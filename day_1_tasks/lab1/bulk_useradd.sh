#!/bin/bash
# to run script ./bulk_useradd.sh or by source <full path> or bash <full path>
echo "This script made by:"
echo "Ahmed Kamel"
# bulk_useradd.sh
# Purpose:
#   This script automates the creation of multiple Linux user accounts.
#   It takes three arguments:
#       1. suffix   → the base name for each user (e.g., "dev" → dev1, dev2, …)
#       2. count    → how many users to create
#       3. outfile  → a text file to record usernames and their temporary passwords
#   For each user:
#       - A random password is generated.
#       - The account is created with a home directory.
#       - The password is set and immediately expired, forcing the user to change it at first login.
#       - The username and temporary password are written to the output file.
#   This is useful for lab environments, training setups, or bulk onboarding where
#   administrators need to quickly provision accounts and enforce password updates.
suffix=$1
count=$2
outfile=$3
# Validate arguments
if [ $# -ne 3 ]; then
    echo "Usage: $0 suffix count outfile.txt"
    exit 1
fi
# Clear or create the output file
> "$outfile"
# Loop through the requested number of users
for i in $(seq 1 $count); do
    username="${suffix}${i}"                     # Construct username
    password=$(openssl rand -base64 3)          # Generate random password
    useradd -m "$username"                       # Create user with home directory
    echo "${username}:${password}" | chpasswd    # Set password
    chage -d 0 "$username"                       # Force password change at first login
    echo "$username $password" >> "$outfile"     # Save credentials to file
done
# Final summary
echo "Created $count users with suffix '$suffix'."
echo "Temporary credentials saved to $outfile."
echo "All users must change their password at first login."
