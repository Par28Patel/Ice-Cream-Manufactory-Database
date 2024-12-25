#!/bin/bash

# Database connection details
DB_USER="p16patel"  # Database username
DB_PASS="05287286"  # Database password
DB_SID="(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle12c.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl12c)))"  # Database connection string
SQLPLUS_CMD="sqlplus64 -s $DB_USER/$DB_PASS@$DB_SID"  # SQL*Plus command for executing queries silently

# Function to execute a SQL query
run_query() {
    local query=$1  # The SQL query to execute
    $SQLPLUS_CMD <<EOF
    SET SERVEROUTPUT ON
    $query
    COMMIT;
    EXIT;
EOF
}

# Function for searching specific records
search_records() {
    echo "Choose search criteria:"
    echo "1. Search for ingredients by storage location"
    echo "2. Search for products by flavour"
    echo "3. Search for supplier info based on supplier name"
    echo "4. Search for customer info based on customer name"
    echo "5. Search for a customer order based on delivery status"
    echo "6. Search for ingredients list, proportion and recipe instructions based on recipeID"
    echo "7. Search for employee information based on employee role"
    echo "8. Search for a manufactory address and hours based on manufactory name"
    echo "9. Search for net income, expenses, revenue, and maintenance costs based on finance ID"
    read -p "Enter your choice (1-9): " search_choice

    # Queries for specific search records
    case $search_choice in
        1)
            read -p "Enter storage location: " storage_location
            query="SELECT * FROM Ingredients WHERE storageLocation = '$storage_location';"
            ;;
        2)
            read -p "Enter flavour: " flavour
            query="SELECT * FROM Product WHERE Flavour = '$flavour';"
            ;;
        3)
           read -p "Enter supplier name: " supplier_name
           query="SELECT * FROM Supplier WHERE Name = '$supplier_name';"
            ;;
        4)
            read -p "Enter customer name: " customer_name
            query="SELECT * FROM Customer WHERE Name = '$customer_name';"
            ;;
        5)
            read -p "Enter delivery status: " delivery_status
            query="SELECT * FROM CustomerOrder WHERE deliveryStatus = '$delivery_status';"
            ;;
        6)
           read -p "Enter recipe ID: " recipe_id
           query="SELECT ingredientsList, Proportion, Instructions FROM Recipe WHERE recipeID = $recipe_id;"
            ;;
        7)
            read -p "Enter employee role: " role
            query="SELECT * FROM Employee WHERE Role = '$role';"
            ;;
        8)
            read -p "Enter manufactory name: " manufactory_name
            query="SELECT Address, operatingHours FROM Manufactory WHERE Name = '$manufactory_name';"
            ;;
        9)
            read -p "Enter finance ID: " finance_id
            query="SELECT netIncome, Expenses, Revenue, maintenanceCost FROM Finances WHERE financeID = $finance_id;"
            ;;
        *)
            echo "Invalid option. Please try again."
            return
            ;;
    esac

    run_query "$query"
}

# Main loop for menu-driven query execution
while true; do
    # Display the menu options
    echo "Oracle Database Query Execution Menu"
    echo "1. This query provides a complete view of orders, the associated customers, and the ordered products."
    echo "2. This query helps identify employees earning above the average salary in their department, useful for looking at salary distribution."
    echo "3. This query provides a list of products that have generated significant sales revenue, helping identify top-performing products."
    echo "4. This query checks for products that have not been ordered, useful for displaying underperforming products."
    echo "5. Display total revenue from customers and total expenses from ingredient shipments to get an overall financial perspective on cost to buy and revenue from sales."
    echo "6. Search for a specific record"
    echo "0. Exit"

    # Read user choice
    read -p "Enter your choice: " choice

    # Handle the user's choice using a case statement
    case $choice in
        1)
            # Query 1: Fetches detailed information about orders, customers, and products
            run_query "
                SELECT c.Name AS ClientName, c.phoneNumber AS ClientPhone, o.orderID, p.productName, p.Flavour, o.Quantity, o.Revenue
                FROM CustomerOrder o
                JOIN Customer c ON o.customerID = c.customerID
                JOIN Product p ON o.productID = p.productID
                ORDER BY o.orderID; "
            echo "Query 1 executed successfully."
            ;;
        2)
            # Query 2: Lists employees earning above the average salary within their department
            run_query "
                SELECT e.Department, e.Name, e.Salary
                FROM Employee e
                GROUP BY e.Department, e.Name, e.Salary
                HAVING e.Salary > (SELECT AVG(e2.Salary) FROM Employee e2 WHERE e2.Department = e.Department);"
            echo "Query 2 executed successfully."
            ;;
        3)
            # Query 3: Displays top-performing products based on total revenue
            run_query "
                SELECT p.productName, p.Flavour, SUM(o.Revenue) AS TotalRevenue
                FROM Product p
                JOIN CustomerOrder o ON p.productID = o.productID
                GROUP BY p.productName, p.Flavour
                HAVING SUM(o.Revenue) > 10
                ORDER BY TotalRevenue DESC;"
            echo "Query 3 executed successfully."
            ;;
        4)
            # Query 4: Finds products that have not been ordered (underperforming products)
            run_query "
                SELECT p.productID, p.productName, p.Flavour, p.Quantity
                FROM Product p
                WHERE NOT EXISTS (
                    SELECT 1
                    FROM CustomerOrder o
                    WHERE o.productID = p.productID
                );"
            echo "Query 4 executed successfully."
            ;;
        5)
            # Query 5: Summarizes total revenue and total expenses for financial analysis
            run_query "
                (SELECT 'Revenue' AS Type, SUM(o.Revenue) AS TotalAmount
                FROM CustomerOrder o
                GROUP BY o.Revenue)
                UNION
                (SELECT 'Expenses_total' AS Type, SUM(s.Expenses_total) AS TotalAmount
                FROM ingredientShipmentLogistics s
                GROUP BY s.Expenses_total);"
            echo "Query 5 executed successfully."
            ;;
        6)
            search_records
            ;;
        0)
            # Exit option
            echo "Exiting..."
            break
            ;;
        *)
            # Handle invalid input
            echo "Invalid choice! Please enter a valid option."
            ;;
    esac

    # Pause before showing the menu again
    read -p "Press Enter to continue..."
done
