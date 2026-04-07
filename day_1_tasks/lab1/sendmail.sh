#!/bin/bash
echo "This script made by:"
echo "Ahmed Kamel -- Lab 1.4"
# Usage: ./sendmail.sh outfile.txt logfile.txt
outfile=$1
logfile=$2
# Validate arguments
if [ $# -ne 2 ]; then
    echo "Usage: $0 outfile.txt logfile.txt"
    exit 1
fi
if [ ! -f "$outfile" ]; then
    echo "Error: Output file $outfile not found!"
    exit 1
fi
# Create logfile if it doesn't exist
touch "$logfile"
# Read each line of the outfile (space-separated)
while IFS=' ' read -r username password email number; do
    # Skip empty lines
    [ -z "$username" ] && continue
    # Email subject and body
    subject="Your Temporary Credentials"
    body="Hello $username,
Your account has been created. Here are your temporary credentials:
Username: $username
Password: $password
Number: $number
Please change your password at first login.
Regards,
Admin Team"
    # Send email via Gmail using msmtp
    echo "$body" | mailx -s "$subject" "$email"
    # Log success/failure
    if [ $? -eq 0 ]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Email sent to $email" >> "$logfile"
        echo "Email sent to $email"
    else
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Failed to send email to $email" >> "$logfile"
        echo "Failed to send email to $email"
    fi
done < "$outfile"
echo "All emails processed. Check $logfile for details."