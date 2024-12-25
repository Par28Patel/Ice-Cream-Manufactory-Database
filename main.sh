#!/bin/bash

# Pause function to hold the screen until a key press
Pause() {
    read -p "Press [Enter] key to continue..."
}

# Main Menu Function
MainMenu() {
    while [ "$CHOICE" != "START" ]
    do
        clear
        echo "================================================================="
        echo "| Oracle All Inclusive Tool                                      |"
        echo "| Main Menu - Select Desired Operation(s):                       |"
        echo "| <CTRL-Z Anytime to Enter Interactive CMD Prompt>               |"
        echo "-----------------------------------------------------------------"
        echo " $IS_SELECTEDM M) View Manual"
        echo " "
        echo " $IS_SELECTED1 1) Drop Tables"
        echo " $IS_SELECTED2 2) Create Tables"
        echo " $IS_SELECTED3 3) Populate Tables"
        echo " $IS_SELECTED4 4) Query Tables"
        echo " "
        echo " $IS_SELECTEDX X) Force/Stop/Kill Oracle DB"
        echo " "
        echo " $IS_SELECTEDE E) End/Exit"
        echo "Choose: "
        read CHOICE

        case $CHOICE in
            "M" | "m")
                echo "Displaying manual..."
                Pause
                ;;
            "1")
                echo "Dropping tables..."
                ./drop_tables.sh
                Pause
                ;;
            "2")
                echo "Creating tables..."
                 ./insert_tables.sh
                Pause
                ;;
            "3")
                echo "Populating tables..."
                ./populate_table.sh  # Ensure insert.sh is executable
                if [ $? -eq 0 ]; then
                    echo "Tables populated successfully."
                else
                    echo "Error occurred during table population."
                fi
                Pause
                ;;
            "4")
                echo "Querying tables..."
                ./queries.sh
                Pause
                ;;
            "X" | "x")
                echo "Forcing/Stooping/Killing Oracle DB..."
                sudo service oracle stop
                Pause
                ;;
            "E" | "e")
                echo "Exiting..."
                exit 0
                ;;
            *)
                echo "Invalid choice, please try again."
                Pause
                ;;
        esac
    done
}


# Run Main Program
MainMenu
