# CLI-Test-based-system
![WhatsApp Image 2024-10-21 at 18 33 47](https://github.com/user-attachments/assets/843a6170-3738-4597-91e4-1b95539a8760)
## Overview

This project is a Bash-based Test System designed to manage user registration, login, and testing functionality. It focuses on efficient user interaction through CLI, handling file creation (for user credentials and test answers), logging, and enforcing timeouts to ensure smooth operation. through the command-line interface. 
### Key Features

**Sign-Up and Sign-In System**:

-Users can create an account with a username and password.
Existing users can sign in by entering their credentials, which are validated against a CSV file (.user_credentials.csv).

**Test Taking Interface**:

-A basic test-taking interface allows users to answer a question within a set timeout.
Answers are logged and stored in a CSV file (answers.csv).
If the time runs out while answering a question, the user is automatically logged out.

**Viewing Test Results**:

-Users can view their previous test answers, including unanswered questions.
A log file (test_system.log) records all activities such as login attempts, test completions, and answer submissions.

**Logging**:

-Every major action (e.g., signing in, signing up, answering questions) is logged with a timestamp for future reference and debugging.

## Methodology

1. **User Authentication:**
   - The system provides a sign-up and sign-in functionality, using a `.csv` file to store and verify user credentials securely.
  
2. **File and Directory Setup:**
   - Key directories such as `.TestData` (for user credentials and answer files) and `./logs` (for logging system activity) are created dynamically.
   
3. **Logging Mechanism:**
   - All user interactions, such as logging in, answering test questions, or viewing test results, are recorded in a log file with timestamps for accountability.
  
4. **Test Interface:**
   - The user is presented with multiple-choice questions. They can answer these questions within a specified time limit, or the test will automatically timeout.
  
5. **Answer Logging and Backup:**
   - Each user’s test answers are stored in an answer CSV file. If an answer file already exists, a backup is created with a timestamp.
  
## Prerequisites
- **Bash Shell**: Make sure you have Bash installed on your system (typically available on most Unix-like OS)

## How to Run
1. Clone this repository or download the files.
   ```bash
   git clone https://github.com/yourusername/cli-test-system.git
   cd cli-test-system

## Conclusion
This CLI-based test system showcases the power of Bash scripting for developing simple yet effective user interaction systems. Through a series of features like user authentication, activity logging, and timed tests, it offers a basic framework for educational tools or small quiz systems. 

