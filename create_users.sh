#!/bin/bash

# File paths
LOG_FILE="/var/log/user_management.log"
PASSWORD_FILE="/var/secure/user_passwords.csv"
USER_FILE="$1" # Text file passed as the first argument to the script

# Function to log actions
log_action() {
	echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# Check if user file is provided
if [ -z "$USER_FILE" ]; then
	log_action "No user file provided. Exiting."
	exit 1
fi

# Ensure the secure password directory exists
mkdir -p /var/secure
touch "$PASSWORD_FILE"
chmod 600 "$PASSWORD_FILE"
chown root:root "$PASSWORD_FILE"

# Read the user file line by line
while IFS=';' read -r username groups; do
	# Trim leading/trailing whitespace from username and groups
	username=$(echo "$username" | xargs)
	groups=$(echo "$groups" | xargs)

	# Skip empty lines or lines without a semicolon
	if [ -z "$username" ] || [ -z "$groups" ]; then
		continue
	fi

	# Create the personal group with the same name as the user
	if ! getent group "$username" >/dev/null 2>&1; then
		groupadd "$username"
		log_action "Group $username created."
	else
		log_action "Group $username already exists."
	fi

	# Create the user with the personal group
	if ! id -u "$username" >/dev/null 2>&1; then
		useradd -m -g "$username" -s /bin/bash "$username"
		log_action "User $username created."
	else
		log_action "User $username already exists."
	fi

	# Add the user to the specified groups
	IFS=',' read -ra group_array <<<"$groups"
	for group in "${group_array[@]}"; do
		group=$(echo "$group" | xargs) # Trim whitespace
		if ! getent group "$group" >/dev/null 2>&1; then
			groupadd "$group"
			log_action "Group $group created."
		fi
		usermod -aG "$group" "$username"
		log_action "User $username added to group $group."
	done

	# Generate a random password for the user
	password=$(openssl rand -base64 12)
	echo "$username:$password" | chpasswd
	log_action "Password for user $username set."

	# Store the password securely in CSV format
	echo "$username,$password" >>"$PASSWORD_FILE"
	log_action "Password for user $username stored securely."

done <"$USER_FILE"

log_action "User creation script completed."

exit 0
