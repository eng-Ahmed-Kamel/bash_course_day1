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
# Ask for Gmail credentials
sender="ahmed.ozi2001@gmail.com"
read -p "Enter Google App Password: " gapp
# Create logfile if it doesn't exist
touch "$logfile"
# Read each line of outfile
while IFS=' ' read -r username password email number; do
    # Skip empty lines
    [ -z "$username" ] && continue
    receiver="$email"
    sub="Your Temporary Credentials"
    body="Hello $username,
Your account has been created. Here are your temporary credentials:
Username: $username
Password: $password
Number: $number
Please change your password at first login.
Regards,
Admin Team"
    # Send mail using curl SMTP
    curl -s --url 'smtps://smtp.gmail.com:465' --ssl-reqd \
        --mail-from "$sender" \
        --mail-rcpt "$receiver" \
        --user "$sender:$gapp" \
        -T <(echo -e "From: ${sender}
To: ${receiver}
Subject: ${sub}
${body}")
    # Check result
    if [ $? -eq 0 ]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Email sent to $receiver" >> "$logfile"
        echo "Email sent to $receiver"
    else
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Failed to send email to $receiver" >> "$logfile"
        echo "Failed to send email to $receiver"
    fi
done < "$outfile"
echo "All emails processed. Check $logfile for details."