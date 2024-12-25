#!/bin/bash

# Global variables for database connection
DB_USER="p16patel"
DB_PASS="05287286"
DB_SID="(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle12c.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl12c)))"
SQLPLUS_CMD="sqlplus64 -s $DB_USER/$DB_PASS@$DB_SID"

# Function to create Ingredients table
create_ingredients_table() {
    $SQLPLUS_CMD <<EOF
    SET SERVEROUTPUT ON
    CREATE TABLE Ingredients (
        ingredientID NUMERIC(10) PRIMARY KEY,
        ingredientName VARCHAR2(100),
        Quantity NUMERIC(10) DEFAULT 0,
        storageLocation VARCHAR2(100),
        expiryDate DATE
    );
    COMMIT;
    EXIT;
EOF
    echo "Ingredients table created successfully."
}

# Function to create Product table
create_product_table() {
    $SQLPLUS_CMD <<EOF
    SET SERVEROUTPUT ON
    CREATE TABLE Product (
        productID NUMERIC(10) PRIMARY KEY,
        productName VARCHAR2(100),
        Flavour VARCHAR2(100),
        Quantity NUMERIC(10) DEFAULT 0,
        storageLocation VARCHAR2(100),
        expiryDate DATE
    );
    COMMIT;
    EXIT;
EOF
    echo "Product table created successfully."
}

# Function to create Supplier table
create_supplier_table() {
    $SQLPLUS_CMD <<EOF
    SET SERVEROUTPUT ON
    CREATE TABLE Supplier (
        supplierID NUMERIC(10) PRIMARY KEY,
        Name VARCHAR2(100),
        phoneNumber VARCHAR2(15),
        Address VARCHAR2(200)
    );
    COMMIT;
    EXIT;
EOF
    echo "Supplier table created successfully."
}

# Function to create Customer table
create_customer_table() {
    $SQLPLUS_CMD <<EOF
    SET SERVEROUTPUT ON
    CREATE TABLE Customer (
        customerID NUMERIC(10) PRIMARY KEY,
        Name VARCHAR2(100),
        phoneNumber VARCHAR2(15),
        Address VARCHAR2(200)
    );
    COMMIT;
    EXIT;
EOF
    echo "Customer table created successfully."
}

# Function to create CustomerOrder table
create_customer_order_table() {
    $SQLPLUS_CMD <<EOF
    SET SERVEROUTPUT ON
    CREATE TABLE CustomerOrder (
        orderID NUMERIC(10) PRIMARY KEY,
        customerID NUMERIC(10),
        productID NUMERIC(10),
        orderDate DATE,
        Quantity NUMERIC(10),
        deliveryStatus VARCHAR2(50),
        Revenue NUMERIC(10,2),
        FOREIGN KEY (customerID) REFERENCES Customer(customerID),
        FOREIGN KEY (productID) REFERENCES Product(productID)
    );
    COMMIT;
    EXIT;
EOF
    echo "CustomerOrder table created successfully."
}

# Function to create Recipe table
create_recipe_table() {
    $SQLPLUS_CMD <<EOF
    SET SERVEROUTPUT ON
    CREATE TABLE Recipe (
        recipeID NUMERIC(10) PRIMARY KEY,
        productID NUMERIC(10),
        ingredientsList VARCHAR2(500),
        Proportion VARCHAR2(100),
        Instructions CLOB,
        FOREIGN KEY (productID) REFERENCES Product(productID)
    );
    COMMIT;
    EXIT;
EOF
    echo "Recipe table created successfully."
}

# Function to create Employee table
create_employee_table() {
    $SQLPLUS_CMD <<EOF
    SET SERVEROUTPUT ON
    CREATE TABLE Employee (
        employeeID NUMERIC(10) PRIMARY KEY,
        Name VARCHAR2(100),
        Role VARCHAR2(100),
        phoneNumber VARCHAR2(15),
        Shift VARCHAR2(50),
        Salary NUMBER(10,2),
        Department VARCHAR2(100)
    );
    COMMIT;
    EXIT;
EOF
    echo "Employee table created successfully."
}

# Function to create Manufactory table
create_manufactory_table() {
    $SQLPLUS_CMD <<EOF
    SET SERVEROUTPUT ON
    CREATE TABLE Manufactory (
        manufactoryID NUMERIC(10) PRIMARY KEY,
        Name VARCHAR2(100),
        Address VARCHAR2(200),
        employeeCount NUMERIC(10),
        operatingHours VARCHAR2(100)
    );
    COMMIT;
    EXIT;
EOF
    echo "Manufactory table created successfully."
}

# Function to create ingredientShipmentInfo table
create_ingredient_shipment_info_table() {
    $SQLPLUS_CMD <<EOF
    SET SERVEROUTPUT ON
    CREATE TABLE ingredientShipmentInfo (
        shipmentID NUMERIC(10) PRIMARY KEY,
        expiryDate DATE,
        storageLocation VARCHAR2(100)
    );
    COMMIT;
    EXIT;
EOF
    echo "ingredientShipmentInfo table created successfully."
}

# Function to create ingredientShipmentLogistics table
create_ingredient_shipment_logistics_table() {
    $SQLPLUS_CMD <<EOF
    SET SERVEROUTPUT ON
    CREATE TABLE ingredientShipmentLogistics (
        shipmentID NUMERIC(10),
        supplierID NUMERIC(10),
        ingredientID NUMERIC(10),
        Quantity NUMERIC(10),
        Expenses_total NUMERIC(10,2),
        PRIMARY KEY (shipmentID, supplierID),
        FOREIGN KEY (supplierID) REFERENCES Supplier(supplierID),
        FOREIGN KEY (ingredientID) REFERENCES Ingredients(ingredientID)
    );
    COMMIT;
    EXIT;
EOF
    echo "ingredientShipmentLogistics table created successfully."
}

# Function to create Finances table
create_finances_table() {
    $SQLPLUS_CMD <<EOF
    SET SERVEROUTPUT ON
    CREATE TABLE Finances (
        financeID NUMERIC(10) PRIMARY KEY,
        netIncome NUMERIC(10,2),
        Expenses NUMERIC(10,2),
        Revenue NUMERIC(10,2),
        maintenanceCost NUMERIC(10,2)
    );
    COMMIT;
    EXIT;
EOF
    echo "Finances table created successfully."
}

# Main menu loop
while true; do
    clear
    echo "Oracle Database Table Creation Menu"
    echo "1. Create Ingredients Table"
    echo "2. Create Product Table"
    echo "3. Create Supplier Table"
    echo "4. Create Customer Table"
    echo "5. Create CustomerOrder Table"
    echo "6. Create Recipe Table"
    echo "7. Create Employee Table"
    echo "8. Create Manufactory Table"
    echo "9. Create Ingredient Shipment Info Table"
    echo "10. Create Ingredient Shipment Logistics Table"
    echo "11. Create Finances Table"
    echo "12. Create All Tables"
    echo "0. Exit"

    read -p "Enter your choice: " choice

    case $choice in
        1)
            create_ingredients_table
            ;;
        2)
            create_product_table
            ;;
        3)
            create_supplier_table
            ;;
        4)
            create_customer_table
            ;;
        5)
            create_customer_order_table
            ;;
        6)
            create_recipe_table
            ;;
        7)
            create_employee_table
            ;;
        8)
            create_manufactory_table
            ;;
        9)
            create_ingredient_shipment_info_table
            ;;
        10)
            create_ingredient_shipment_logistics_table
            ;;
        11)
            create_finances_table
            ;;
        12)
            create_ingredients_table
            create_product_table
            create_supplier_table
            create_customer_table
            create_customer_order_table
            create_recipe_table
            create_employee_table
            create_manufactory_table
            create_ingredient_shipment_info_table
            create_ingredient_shipment_logistics_table
            create_finances_table
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
