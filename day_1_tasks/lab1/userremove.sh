#!/bin/bash
echo "This script made by:"
echo "Ahmed Kamel -- Remove users by suffix (with dry run option)"
# Usage: ./userremove.sh suffix [--dry-run]
suffix=$1
dry_run=$2
# Validate arguments
if [ $# -lt 1 ] || [ $# -gt 2 ]; then
    echo "Usage: $0 suffix [--dry-run]"
    exit 1
fi
# Get all users starting with the suffix using grep and cut
users=$(getent passwd | grep "^$suffix" | cut -d: -f1)
# Check if any users were found
if [ -z "$users" ]; then
    echo "No users found with suffix '$suffix'."
    exit 0
fi
# Dry run: just show users that would be deleted
if [ "$dry_run" == "--dry-run" ]; then
    echo "Dry run mode: The following users would be removed:"
    for user in $users; do
        echo "  $user"
    done
    exit 0
fi
# Loop and remove users
for user in $users; do
    echo "Removing user: $user"
    userdel -r "$user"
done
echo "All users with suffix '$suffix' have been removed."