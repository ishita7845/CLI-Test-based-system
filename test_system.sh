#!/bin/bash

# The file names
USER_CREDENTIALS_FILE=".user_credentials.csv"
ANSWER_FILE="answers.csv"
LOG_FILE="test_system.log"

# The file paths
TEST_DATA_DIR=".TestData"
LOG_DIR="./logs"

# The globals
TIMEOUT_PERIOD=60  # Example of a general timeout period in seconds

# Time out periods
LOGIN_TIMEOUT=30   # Timeout for entering login details
TEST_TIMEOUT=120   # Timeout for completing the test

# Function to log activities with a timestamp
function log() {
    local activity="$1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $activity" >> "$LOG_DIR/$LOG_FILE"
}

# Function to create the answer CSV file and back it up if it already exists
function answer_file_creation() {
    if [ -f "$TEST_DATA_DIR/$ANSWER_FILE" ]; then
        mv "$TEST_DATA_DIR/$ANSWER_FILE" "$TEST_DATA_DIR/$(date '+%Y%m%d_%H%M%S')_$ANSWER_FILE.bak"
    fi
    touch "$TEST_DATA_DIR/$ANSWER_FILE"
    log "Answer file created."
}

# Function to print a welcome menu header
function menu_header() {
    echo "*******************************"
    echo "       Welcome to the Test      "
    echo "*******************************"
}

# Array holding multiple questions
questions=(
    "What is the capital of France?"
    "What is the largest planet in the Solar System?"
    "What element does 'O' represent on the periodic table?"
    "What is bash ?"
    "What is the hardest natural substance on Earth?"
)

# Array holding the correct answers (for reference or future scoring)
answers=("Paris" "Jupiter" "Oxygen" "Bourne again shell" "Diamond")

# Function to view the test screen and show answers from the CSV file
function view_test_screen() {
    if [ -f "$TEST_DATA_DIR/$ANSWER_FILE" ]; then
        echo "Test answers:"
        while IFS=',' read -r question answer; do
            if [ -z "$answer" ]; then
                echo "$question - Not answered"
            else
                echo "$question - Answer: $answer"
            fi
        done < "$TEST_DATA_DIR/$ANSWER_FILE"
    else
        echo "No test data available."
    fi
    log "Viewed test answers."
}

# Function to present the test screen, handle questions and answers, and implement timeout
function test_screen() {
    local start_time=$(date +%s)
    local current_time
    local random_question
    local answer
    local num_questions=${#questions[@]}  # Number of questions

    for ((i=0; i<num_questions; i++)); do
        current_time=$(date +%s)
        elapsed=$((current_time - start_time))
        if [ $elapsed -ge $TEST_TIMEOUT ]; then
            echo "Time's up! You could not complete the test."
            log "Test timed out."
            break
        fi

        # Pick and display the i-th question from the question array
        random_question=${questions[i]}
        echo "$random_question"
        read -t $((TEST_TIMEOUT - elapsed)) -p "Answer: " answer

        if [ $? -ne 0 ]; then
            echo "You ran out of time."
            log "User ran out of time."
            break
        fi

        echo "$random_question,$answer" >> "$TEST_DATA_DIR/$ANSWER_FILE"
        log "Answered question: $random_question"
    done
}

# Function to display the test menu, allowing users to take or view tests
function test_menu() {
    menu_header
    echo "1. Take a test"
    echo "2. View previous test"
    echo "3. Exit"
    read -p "Choose an option: " choice

    case $choice in
        1) test_screen ;;
        2) view_test_screen ;;
        3) exit 0 ;;
        *) echo "Invalid option." ;;
    esac
}

# Function for user sign-in
function sign_in() {
    read -p "Username: " username
    read -s -t $LOGIN_TIMEOUT -p "Password: " password
    echo ""

    if grep -q "^$username,$password$" "$TEST_DATA_DIR/$USER_CREDENTIALS_FILE"; then
        log "$username signed in successfully."
        echo "Login successful!"
        return 0  # Successful login
    else
        log "$username failed to sign in."
        echo "Invalid username or password."
        return 1  # Failed login
    fi
}

# Function for user sign-up
function sign_up() {
    read -p "Enter username: " username
    if grep -q "^$username," "$TEST_DATA_DIR/$USER_CREDENTIALS_FILE"; then
        echo "Username already exists."
        return
    fi

    read -s -t $LOGIN_TIMEOUT -p "Enter password (min 6 chars): " password
    echo ""

    if [[ ${#password} -lt 6 ]]; then
        echo "Password must be at least 6 characters."
        return
    fi

    echo "$username,$password" >> "$TEST_DATA_DIR/$USER_CREDENTIALS_FILE"
    log "New user signed up: $username"
    echo "Registration successful!"
}

# Main script to create necessary directories and files
mkdir -p "$TEST_DATA_DIR" "$LOG_DIR"
touch "$TEST_DATA_DIR/$USER_CREDENTIALS_FILE"
answer_file_creation  # Create the answer file at the start

# Main loop for the application
while true; do
    echo "1. Sign Up"
    echo "2. Sign In"
    echo "3. Exit"
    read -p "Choose an option: " option

    case $option in
        1) sign_up ;;
        2)
            if sign_in; then
                test_menu  # Access test menu only if sign-in is successful
            else
                echo "Please sign in again."
            fi
            ;;
        3) exit 0 ;;
        *) echo "Invalid option." ;;
    esac
done

