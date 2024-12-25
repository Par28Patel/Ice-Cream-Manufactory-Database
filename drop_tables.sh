#!/bin/bash

# Global variables for database connection
DB_USER="p16patel"
DB_PASS="05287286"
DB_SID="(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle12c.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl12c)))"
SQLPLUS_CMD="sqlplus64 -s $DB_USER/$DB_PASS@$DB_SID"

# Function to drop tables if they exist
drop_tables() {
    $SQLPLUS_CMD <<EOF
    SET SERVEROUTPUT ON
    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE CustomerOrder CASCADE CONSTRAINTS';
        EXECUTE IMMEDIATE 'DROP TABLE Customer CASCADE CONSTRAINTS';
        EXECUTE IMMEDIATE 'DROP TABLE ingredientShipmentInfo CASCADE CONSTRAINTS';
        EXECUTE IMMEDIATE 'DROP TABLE ingredientShipmentLogistics CASCADE CONSTRAINTS';
        EXECUTE IMMEDIATE 'DROP TABLE Supplier CASCADE CONSTRAINTS';
        EXECUTE IMMEDIATE 'DROP TABLE Product CASCADE CONSTRAINTS';
        EXECUTE IMMEDIATE 'DROP TABLE Ingredients CASCADE CONSTRAINTS';
        EXECUTE IMMEDIATE 'DROP TABLE Recipe CASCADE CONSTRAINTS';
        EXECUTE IMMEDIATE 'DROP TABLE Employee CASCADE CONSTRAINTS';
        EXECUTE IMMEDIATE 'DROP TABLE Manufactory CASCADE CONSTRAINTS';
        EXECUTE IMMEDIATE 'DROP TABLE Finances CASCADE CONSTRAINTS';
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE != -942 THEN
                RAISE;
            END IF;
    END;
    /
    COMMIT;
    EXIT;
EOF
    echo "All tables dropped successfully."
}

# Run the drop_tables function
drop_tables
