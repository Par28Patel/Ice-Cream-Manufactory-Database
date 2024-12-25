#!/bin/bash

# Global variables for database connection
DB_USER="p16patel"
DB_PASS="05287286"
DB_SID="(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle12c.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl12c)))"
SQLPLUS_CMD="sqlplus64 -s $DB_USER/$DB_PASS@$DB_SID"

# Function to insert an ingredient
insert_ingredient() {
    read -p "Enter Ingredient ID: " ingredient_id
    read -p "Enter Ingredient Name: " ingredient_name
    read -p "Enter Ingredient Quantity: " ingredient_quantity
    read -p "Enter Ingredient Storage Location: " ingredient_SL
    read -p "Enter Ingredient Expiry Date (formate YYYY-MM-DD): " ingredient_expiry_date


    $SQLPLUS_CMD <<EOF
    SET SERVEROUTPUT ON
    INSERT INTO Ingredients (ingredientID, ingredientName, Quantity, storageLocation, expiryDate)
    VALUES ($ingredient_id, '$ingredient_name', $ingredient_quantity, '$ingredient_SL', TO_DATE('$ingredient_expiry_date', 'YYYY-MM-DD'));
    COMMIT;
    EXIT;
EOF
    echo "Ingredient $ingredient_name inserted successfully."
}

# Function to insert a product
insert_product() {
    read -p "Enter Product ID: " product_id
    read -p "Enter Product Name: " product_name
    read -p "Enter Product Flavour: " product_flavour
    read -p "Enter Product Quantity: " product_quantity
    read -p "Enter Product Storage Location: " product_storage_location
    read -p "Enter Product Expiry Date (format YYYY-MM-DD): " product_expiry_date

    $SQLPLUS_CMD <<EOF
    SET SERVEROUTPUT ON
    INSERT INTO Product (productID, productName, Flavour, Quantity, storageLocation, expiryDate)
    VALUES ($product_id, '$product_name', '$product_flavour', $product_quantity, '$product_storage_location', TO_DATE('$product_expiry_date', 'YYYY-MM-DD'));
    COMMIT;
    EXIT;
EOF
    echo "Product $product_name inserted successfully."
}

# Function to insert a supplier
insert_supplier() {
    read -p "Enter Supplier ID: " supplier_id
    read -p "Enter Supplier Name: " supplier_name
    read -p "Enter Supplier Phone Number: " supplier_phone
    read -p "Enter Supplier Address: " supplier_address

    $SQLPLUS_CMD <<EOF
    SET SERVEROUTPUT ON
    INSERT INTO Supplier (supplierID, Name, phoneNumber, Address)
    VALUES ($supplier_id, '$supplier_name', '$supplier_phone', '$supplier_address');
    COMMIT;
    EXIT;
EOF
    echo "Supplier $supplier_name inserted successfully."
}


# Function to insert a customer
insert_customer() {
    read -p "Enter Customer ID: " customer_id
    read -p "Enter Customer Name: " customer_name
    read -p "Enter Customer Phone Number: " customer_phone
    read -p "Enter Customer Address: " customer_address

    $SQLPLUS_CMD <<EOF
    SET SERVEROUTPUT ON
    INSERT INTO Customer (customerID, Name, phoneNumber, Address)
    VALUES ($customer_id, '$customer_name', '$customer_phone', '$customer_address');
    COMMIT;
    EXIT;
EOF
    echo "Customer $customer_name inserted successfully."
}


# Function to insert a customer order
insert_customer_order() {
    read -p "Enter Order ID: " order_id
    read -p "Enter Customer ID: " customer_id
    read -p "Enter Product ID: " product_id
    read -p "Enter Order Date (format YYYY-MM-DD): " order_date
    read -p "Enter Quantity: " order_quantity
    read -p "Enter Delivery Status: " delivery_status
    read -p "Enter Revenue: " revenue

    $SQLPLUS_CMD <<EOF
    SET SERVEROUTPUT ON
    INSERT INTO CustomerOrder (orderID, customerID, productID, orderDate, Quantity, deliveryStatus, Revenue)
    VALUES ($order_id, $customer_id, $product_id, TO_DATE('$order_date', 'YYYY-MM-DD'), $order_quantity, '$delivery_status', $revenue);
    COMMIT;
    EXIT;
EOF
    echo "Customer order $order_id inserted successfully."
}

# Function to insert finances
insert_finances() {
    read -p "Enter Finance ID: " finance_id
    read -p "Enter Net Income: " net_income
    read -p "Enter Expenses: " expenses
    read -p "Enter Revenue: " revenue
    read -p "Enter Maintenance Cost: " maintenance_cost

    $SQLPLUS_CMD <<EOF
    SET SERVEROUTPUT ON
    INSERT INTO Finances (financeID, netIncome, Expenses, Revenue, maintenanceCost)
    VALUES ($finance_id, $net_income, $expenses, $revenue, $maintenance_cost);
    COMMIT;
    EXIT;
EOF
    echo "Finance record with ID $finance_id inserted successfully."
}


# Function to insert a recipe
insert_recipe() {
    read -p "Enter Recipe ID: " recipe_id
    read -p "Enter Product ID: " product_id
    read -p "Enter Ingredients List (comma-separated): " ingredients_list
    read -p "Enter Proportion: " proportion
    read -p "Enter Instructions: " instructions

    $SQLPLUS_CMD <<EOF
    SET SERVEROUTPUT ON
    INSERT INTO Recipe (recipeID, productID, ingredientsList, Proportion, Instructions)
    VALUES ($recipe_id, $product_id, '$ingredients_list', '$proportion', '$instructions');
    COMMIT;
    EXIT;
EOF
    echo "Recipe with ID $recipe_id inserted successfully."
}


# Function to insert an employee
insert_employee() {
    read -p "Enter Employee ID: " employee_id
    read -p "Enter Employee Name: " employee_name
    read -p "Enter Employee Role: " employee_role
    read -p "Enter Employee Phone Number: " employee_phone
    read -p "Enter Employee Shift: " employee_shift
    read -p "Enter Employee Salary: " employee_salary
    read -p "Enter Employee Department: " employee_department

    $SQLPLUS_CMD <<EOF
    SET SERVEROUTPUT ON
    INSERT INTO Employee (employeeID, Name, Role, phoneNumber, Shift, Salary, Department)
    VALUES ($employee_id, '$employee_name', '$employee_role', '$employee_phone', '$employee_shift', $employee_salary, '$employee_department');
    COMMIT;
    EXIT;
EOF
    echo "Employee $employee_name inserted successfully."
}


# Function to insert a manufactory
insert_manufactory() {
    read -p "Enter Manufactory ID: " manufactory_id
    read -p "Enter Manufactory Name: " manufactory_name
    read -p "Enter Manufactory Address: " manufactory_address
    read -p "Enter Employee Count: " employee_count
    read -p "Enter Operating Hours: " operating_hours

    $SQLPLUS_CMD <<EOF
    SET SERVEROUTPUT ON
    INSERT INTO Manufactory (manufactoryID, Name, Address, employeeCount, operatingHours)
    VALUES ($manufactory_id, '$manufactory_name', '$manufactory_address', $employee_count, '$operating_hours');
    COMMIT;
    EXIT;
EOF
    echo "Manufactory $manufactory_name inserted successfully."
}


# Function to insert ingredient shipment info
insert_ingredient_shipment_info() {
    read -p "Enter Shipment ID: " shipment_id
    read -p "Enter Expiry Date (format YYYY-MM-DD): " expiry_date
    read -p "Enter Storage Location: " storage_location

    $SQLPLUS_CMD <<EOF
    SET SERVEROUTPUT ON
    INSERT INTO ingredientShipmentInfo (shipmentID, expiryDate, storageLocation)
    VALUES ($shipment_id, TO_DATE('$expiry_date', 'YYYY-MM-DD'), '$storage_location');
    COMMIT;
    EXIT;
EOF
    echo "Ingredient shipment info with Shipment ID $shipment_id inserted successfully."
}


# Function to insert ingredient shipment logistics
insert_ingredient_shipment_logistics() {
    read -p "Enter Shipment ID: " shipment_id
    read -p "Enter Supplier ID: " supplier_id
    read -p "Enter Ingredient ID: " ingredient_id
    read -p "Enter Quantity: " quantity
    read -p "Enter Expenses Total: " expenses_total

    $SQLPLUS_CMD <<EOF
    SET SERVEROUTPUT ON
    INSERT INTO ingredientShipmentLogistics (shipmentID, supplierID, ingredientID, Quantity, Expenses_total)
    VALUES ($shipment_id, $supplier_id, $ingredient_id, $quantity, $expenses_total);
    COMMIT;
    EXIT;
EOF
    echo "Ingredient shipment logistics with Shipment ID $shipment_id and Supplier ID $supplier_id inserted successfully."
}


# Function to insert dummy data
insert_dummy_data() {
    echo "Inserting dummy data..."
    $SQLPLUS_CMD <<EOF
    SET SERVEROUTPUT ON
    -- Insert statements for dummy data
    INSERT INTO Ingredients (ingredientID, ingredientName, Quantity, storageLocation, expiryDate) VALUES (1, 'Heavy Cream', 1000, 'Refrigerator', TO_DATE('2025-01-15', 'YYYY-MM-DD'));
    INSERT INTO Ingredients (ingredientID, ingredientName, Quantity, storageLocation, expiryDate) VALUES (2, 'Whole Milk', 2000, 'Refrigerator', TO_DATE('2025-01-20', 'YYYY-MM-DD'));
    INSERT INTO Ingredients (ingredientID, ingredientName, Quantity, storageLocation, expiryDate) VALUES (3, 'Sugar', 500, 'Pantry', TO_DATE('2026-01-01', 'YYYY-MM-DD'));
    INSERT INTO Ingredients (ingredientID, ingredientName, Quantity, storageLocation, expiryDate) VALUES (4, 'Vanilla Extract', 250, 'Pantry', TO_DATE('2025-06-30', 'YYYY-MM-DD'));

    INSERT INTO Product (productID, productName, Flavour, Quantity, storageLocation, expiryDate) VALUES (1, 'Vanilla Ice Cream', 'Vanilla', 100, 'Freezer', TO_DATE('2025-12-31', 'YYYY-MM-DD'));
    INSERT INTO Product (productID, productName, Flavour, Quantity, storageLocation, expiryDate) VALUES (2, 'Chocolate Ice Cream', 'Chocolate', 120, 'Freezer', TO_DATE('2025-12-31', 'YYYY-MM-DD'));
    INSERT INTO Product (productID, productName, Flavour, Quantity, storageLocation, expiryDate) VALUES (3, 'Strawberry Ice Cream', 'Strawberry', 80, 'Freezer', TO_DATE('2025-12-31', 'YYYY-MM-DD'));
    INSERT INTO Product (productID, productName, Flavour, Quantity, storageLocation, expiryDate) VALUES (4, 'Mint Chocolate Chip Ice Cream', 'Mint', 90, 'Freezer', TO_DATE('2025-12-31', 'YYYY-MM-DD'));
    INSERT INTO Product (ProductID, ProductName, Flavour, Quantity, storageLocation, expiryDate) VALUES (5, 'Oreo Ice Cream', 'Oreo', 60, 'Freezer', TO_DATE('2025-12-28', 'YYYY-MM-DD'));

    INSERT INTO Supplier (supplierID, Name, phoneNumber, Address) VALUES (1, 'Dairy Farms Co.', '+1234567890', '123 Cream St, Toronto, ON');
    INSERT INTO Supplier (supplierID, Name, phoneNumber, Address) VALUES (2, 'Sugar Suppliers Inc.', '+1987654321', '456 Sweet Ave, Toronto, ON');
    INSERT INTO Supplier (supplierID, Name, phoneNumber, Address) VALUES (3, 'Flavor Extracts Ltd.', '+1456789012', '789 Flavor St, Toronto, ON');
    INSERT INTO Supplier (supplierID, Name, phoneNumber, Address) VALUES (4, 'Fresh Fruits Supply', '+1321654980', '321 Berry Blvd, Toronto, ON');

        INSERT INTO ingredientShipmentInfo (shipmentID, expiryDate, storageLocation) VALUES (1, TO_DATE('2025-01-15', 'YYYY-MM-DD'), 'Refrigerator');
    INSERT INTO ingredientShipmentInfo (shipmentID, expiryDate, storageLocation) VALUES (2, TO_DATE('2025-01-20', 'YYYY-MM-DD'), 'Refrigerator');
    INSERT INTO ingredientShipmentInfo (shipmentID, expiryDate, storageLocation) VALUES (3, TO_DATE('2026-01-01', 'YYYY-MM-DD'), 'Pantry');
    INSERT INTO ingredientShipmentInfo (shipmentID, expiryDate, storageLocation) VALUES (4, TO_DATE('2025-06-30', 'YYYY-MM-DD'), 'Pantry');


    INSERT INTO ingredientShipmentLogistics (shipmentID, supplierID, ingredientID, Quantity, Expenses_total) VALUES (1, 1, 1, 1000, 500.00);
    INSERT INTO ingredientShipmentLogistics (shipmentID, supplierID, ingredientID, Quantity, Expenses_total) VALUES (2, 1, 2, 2000, 600.00);
    INSERT INTO ingredientShipmentLogistics (shipmentID, supplierID, ingredientID, Quantity, Expenses_total) VALUES (3, 2, 3, 500, 50.00);
    INSERT INTO ingredientShipmentLogistics (shipmentID, supplierID, ingredientID, Quantity, Expenses_total) VALUES (4, 3, 4, 250, 75.00);


    INSERT INTO Customer (customerID, Name, phoneNumber, Address) VALUES (1, 'John Doe', '+1122334455', '789 Oak St, Toronto, ON');
    INSERT INTO Customer (customerID, Name, phoneNumber, Address) VALUES (2, 'Jane Smith', '+9988776655', '321 Maple Ave, Toronto, ON');
    INSERT INTO Customer (customerID, Name, phoneNumber, Address) VALUES (3, 'Alice Johnson', '+1234561234', '654 Birch St, Toronto, ON');
    INSERT INTO Customer (customerID, Name, phoneNumber, Address) VALUES (4, 'Bob Brown', '+4567894567', '987 Cedar Ave, Toronto, ON');

    INSERT INTO CustomerOrder (orderID, customerID, productID, orderDate, Quantity, deliveryStatus, Revenue) VALUES (1, 1, 1, TO_DATE('2024-09-28', 'YYYY-MM-DD'), 2, 'Delivered', 10.00);
    INSERT INTO CustomerOrder (orderID, customerID, productID, orderDate, Quantity, deliveryStatus, Revenue) VALUES (2, 2, 2, TO_DATE('2024-10-02', 'YYYY-MM-DD'), 3, 'Pending', 30.00);
    INSERT INTO CustomerOrder (orderID, customerID, productID, orderDate, Quantity, deliveryStatus, Revenue) VALUES (3, 3, 3, TO_DATE('2024-09-30', 'YYYY-MM-DD'), 1, 'Shipped', 5.00);
    INSERT INTO CustomerOrder (orderID, customerID, productID, orderDate, Quantity, deliveryStatus, Revenue) VALUES (4, 4, 4, TO_DATE('2024-10-04', 'YYYY-MM-DD'), 5, 'Pending', 45.00);

    INSERT INTO Finances (financeID, netIncome, Expenses, Revenue, maintenanceCost) VALUES (1, 10000.00, 5000.00, 15000.00, 2000.00);
    INSERT INTO Finances (financeID, netIncome, Expenses, Revenue, maintenanceCost) VALUES (2, 12000.00, 6000.00, 18000.00, 2500.00);
    INSERT INTO Finances (financeID, netIncome, Expenses, Revenue, maintenanceCost) VALUES (3, 11000.00, 5500.00, 16500.00, 2200.00);

    INSERT INTO Recipe (recipeID, productID, ingredientsList, Proportion, Instructions) VALUES (1, 1, '500g Heavy Cream, 250g Sugar, 1 tsp Vanilla Extract', '1 batch', 'Mix all ingredients and churn in an ice cream maker.');
    INSERT INTO Recipe (recipeID, productID, ingredientsList, Proportion, Instructions) VALUES (2, 2, '500g Whole Milk, 300g Sugar, 100g Cocoa Powder', '1 batch', 'Combine all ingredients and churn in an ice cream maker.');
    INSERT INTO Recipe (recipeID, productID, ingredientsList, Proportion, Instructions) VALUES (3, 3, '500g Heavy Cream, 250g Sugar, 400g Strawberries', '1 batch', 'Blend strawberries, mix with cream and sugar, then churn.');

    INSERT INTO Employee (employeeID, Name, Role, phoneNumber, Shift, Salary, Department) VALUES (1, 'Alice Martin', 'Ice Cream Maker', '+1567890123', 'Day', 2500.00, 'Production');
    INSERT INTO Employee (employeeID, Name, Role, phoneNumber, Shift, Salary, Department) VALUES (2, 'Bob Dupuis', 'Quality Control', '+1234567890', 'Night', 2000.00, 'Quality Assurance');
    INSERT INTO Employee (employeeID, Name, Role, phoneNumber, Shift, Salary, Department) VALUES (3, 'Claire Bertrand', 'Sales Manager', '+1987654321', 'Day', 3000.00, 'Sales');
    INSERT INTO Employee (employeeID, Name, Role, phoneNumber, Shift, Salary, Department) VALUES (4, 'David Lefevre', 'Cleaner', '+1456789012', 'Night', 1500.00, 'Maintenance');
    INSERT INTO Employee (employeeID, Name, Role, phoneNumber, Shift, Salary, Department) VALUES (5, 'Jaylen Brown', 'Ice Cream Maker', '+1437724010', 'Night', 2750.00, 'Production');
    INSERT INTO Employee (employeeID, Name, Role, phoneNumber, Shift, Salary, Department) VALUES (6, 'Austin James', 'Sales Associate', '+1476478893', 'Day', 2600.00, 'Sales');

    INSERT INTO Manufactory (manufactoryID, Name, Address, employeeCount, operatingHours) VALUES (1, 'Ice Cream Factory Inc.', '789 Elm St, Toronto, ON', 50, '8:00 AM - 6:00 PM');
    INSERT INTO Manufactory (manufactoryID, Name, Address, employeeCount, operatingHours) VALUES (2, 'Frozen Treats Ltd.', '456 Maple St, Toronto, ON', 30, '9:00 AM - 5:00 PM');
    INSERT INTO Manufactory (manufactoryID, Name, Address, employeeCount, operatingHours) VALUES (3, 'Sundae Solutions', '123 Pine St, Toronto, ON', 25, '10:00 AM - 4:00 PM');

    COMMIT;
    EXIT;
EOF
    echo "Dummy data inserted successfully."
}

# Insert into table options
while true; do
    clear
    echo "Ice Cream DBMS Operations Menu"
    echo "1. Insert Ingredient"
    echo "2. Insert Product"
    echo "3. Insert Supplier"
    echo "4. Insert Customer"
    echo "5. Insert Customer Order"
    echo "6. Insert Finances"
    echo "7. Insert Recipe"
    echo "8. Insert Employee"
    echo "9. Insert Manufactory"
    echo "10. Insert Ingredient Shipment Info"
    echo "11. Insert Ingredient Shipment Logistics"
    echo "12. Insert Dummy Data"
    echo "0. Exit"

    read -p "Enter your choice: " choice

    # Function call for each table insertion
    case $choice in
        1)
            insert_ingredient
            ;;
        2)
            insert_product
            ;;
        3)
            insert_supplier
            ;;
        4)
            insert_customer
            ;;
        5)
            insert_customer_order
            ;;
        6)
            insert_finances
            ;;
        7)
            insert_recipe
            ;;
        8)
            insert_employee
            ;;
        9)
            insert_manufactory
            ;;
        10)
            insert_ingredient_shipment_info
            ;;
        11)
            insert_ingredient_shipment_logistics
            ;;
        12)
            insert_dummy_data
            ;;
        0)
            echo "Exiting..."
            break
            ;;
        *)
            echo "Invalid choice! Please enter a valid option."
            ;;
    esac

    read -p "Press Enter to continue..."
done
