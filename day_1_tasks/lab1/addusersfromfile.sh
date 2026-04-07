#!/bin/bash
echo "This script made by:"
echo "Ahmed Kamel -- Lab 1.1"
# Usage:
# ./addusersfromfile.sh data.csv outfile.txt
# CSV format: fname,lname,email,no
input_file=$1
outfile=$2
# Validate arguments
if [ $# -ne 2 ]; then
    echo "Usage: $0 data.csv outfile.txt"
    exit 1
fi
# Check if input file exists
if [ ! -f "$input_file" ]; then
    echo "Error: Input file $input_file not found!"
    exit 1
fi
touch "$outfile"  # create output file if it does not exist
# Read CSV line by line
sed '1 d' "$input_file" | while read -r line
do
    fname=$(echo "$line" | cut -d ',' -f 1)  # Extract name field
    lname=$(echo "$line" | cut -d ',' -f 2)  # Extract password field
    email=$(echo "$line" | cut -d ',' -f 3)  # Extract email field
    number=$(echo "$line" | cut -d ',' -f 4)  # Extract number field
    username=$fname  # Use first name as username
    password=$(openssl rand -base64 3)          # Generate random password
    echo "Processing user: $username (email: $email)"
    # Check if user already exists
    id "$username" &>/dev/null
    while [ $? -eq 0 ]; do
        echo "User $username already exists. Generating a new username."
        username="${username}${RANDOM:0:3}"
        id "$username" &>/dev/null
    done
    # Create user
    useradd -m -c "$fname" "$username"
    echo "${username}:${password}" | chpasswd   # Set password
    chage -d 0 "$username"                      # Force password change at first login
    # Save credentials to output file
    echo "$username $password $email $number" >> "$outfile"
    echo "Created user: $username (email: $email)"
done
echo "All users processed. Credentials saved to $outfile."
echo "Temporary credentials saved to $outfile."
echo "All users must change their password at first login."
