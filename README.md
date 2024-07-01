
---

# Automated User and Group Management Script

## Introduction

Managing users and groups in a Linux environment can be a tedious task, especially when dealing with a large number of users. To streamline this process, we've created a bash script named `create_users.sh` that automates user and group creation, assigns users to specified groups, sets up home directories, generates random passwords, and logs all actions.

## Features

- **Automated User and Group Creation**: Creates users and personal groups.
- **Group Assignment**: Assigns users to multiple groups as specified.
- **Random Password Generation**: Generates secure random passwords for each user.
- **Logging**: Logs all actions to `/var/log/user_management.log`.
- **Secure Password Storage**: Stores passwords securely in `/var/secure/user_passwords.csv`.

## Prerequisites

- Ubuntu (or a similar Linux distribution)
- Root or sudo access

## Script Breakdown

- **Logging**: The script logs all actions with timestamps to `/var/log/user_management.log` using the `log_action` function.
- **User and Group Creation**: 
  - The script reads the input file line by line.
  - Each line is split into a username and groups.
  - Personal groups (with the same name as the username) are created if they don't already exist.
  - Users are created if they don't already exist and are added to their respective groups.
- **Password Generation and Storage**:
  - The script generates a random password for each user using `openssl rand`.
  - Passwords are set for each user and stored securely in `/var/secure/user_passwords.csv` with appropriate permissions.

## Conclusion

This script simplifies the process of managing users and groups on a Linux system, making it efficient and error-free. It is particularly useful for large environments where user and group management is a frequent task.

For more information about the HNG Internship and opportunities it offers, please visit the [HNG Internship page](https://hng.tech/internship) and learn about the [premium services](https://hng.tech/premium) provided.

Dev.to Link: [BLOG Link](https://dev.to/stephennwac007/linux-user-creation-bash-script-3hki)


### THANK YOU HNG FOR THE OPPORTUNITY!!!

---

