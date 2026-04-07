#!/bin/bash
echo "This script made by:"
echo "Ahmed Kamel -- Lab 1.1"
# This script to do write addusers script   ./useradd_count.sh   suffix   count  outfile.txt
#example usage:
# ./useradd_count.sh dev 10 users.txt
suffix=$1
count=$2
outfile=$3
# Validate arguments
if [ $# -ne 3 ]; then
    echo "Usage: $0 suffix count outfile.txt"
    exit 1
fi
touch "$outfile"   # create file if not exists
# Loop through the requested number of users
for i in $(seq 1 $count); do
######check if user exist or not##########
    # if id "${suffix}${i}" &>/dev/null; then
        # echo "User ${suffix}${i} already exists. Skipping."
        # continue
    # fi
    username="${suffix}${i}"
    id "$username" &>/dev/null
    while [ $? -eq 0 ]; do
        echo "User $username already exists. Generating a new username."
        username="${suffix}${RANDOM:0:3}"
        id "$username" &>/dev/null
    done
    password=$(openssl rand -base64 3)          # Generate random password
    useradd -m "$username"                       # Create user with home directory
    echo "${username}:${password}" | chpasswd    # Set password
    chage -d 0 "$username"                       # Force password change at first login
    echo "$username $password" >> "$outfile"     # Save credentials to file
done
# Final summary
echo "Created users with suffix '$suffix' from $start to $end."
echo "Temporary credentials saved to $outfile."
echo "All users must change their password at first login." 