# CLI-Test-based-system
![WhatsApp Image 2024-10-21 at 18 33 47](https://github.com/user-attachments/assets/843a6170-3738-4597-91e4-1b95539a8760)
## Overview

This project is a Bash-based Test System designed to manage user registration, login, and testing functionality. It focuses on efficient user interaction through CLI, handling file creation (for user credentials and test answers), logging, and enforcing timeouts to ensure smooth operation. through the command-line interface. 
### Key Features

**Sign-Up and Sign-In System:**

Users can create an account with a username and password.
Existing users can sign in by entering their credentials, which are validated against a CSV file (.user_credentials.csv).
**Test Taking Interface:**

A basic test-taking interface allows users to answer a question within a set timeout.
Answers are logged and stored in a CSV file (answers.csv).
If the time runs out while answering a question, the user is automatically logged out.
**Viewing Test Results:**

Users can view their previous test answers, including unanswered questions.
A log file (test_system.log) records all activities such as login attempts, test completions, and answer submissions.
**Logging:**

Every major action (e.g., signing in, signing up, answering questions) is logged with a timestamp for future reference and debugging.
