#!/bin/bash

# ============================================================
#  User & Group Manager - Bash Script with whiptail TUI
# ============================================================

# Check if whiptail is installed
if ! command -v whiptail &>/dev/null; then
    echo "The 'whiptail' package is required. Install it with:"
    echo "  sudo apt install whiptail    (Debian/Ubuntu)"
    echo "  sudo yum install newt        (RHEL/CentOS)"
    exit 1
fi

TITLE="Main Menu"

# ─────────────────────────────────────────────
# Helper: show a message box
# ─────────────────────────────────────────────
msg() {
    whiptail --title "$TITLE" --msgbox "$1" 10 55
}

# ─────────────────────────────────────────────
# 1. ADD USER
# ─────────────────────────────────────────────
add_user() {
    username=$(whiptail --title "Add User" \
        --inputbox "Enter new username:" 8 40 \
        3>&1 1>&2 2>&3) || return

    [[ -z "$username" ]] && msg "Username cannot be empty." && return

    if id "$username" &>/dev/null; then
        msg "User '$username' already exists."
        return
    fi

    if whiptail --title "Add User" \
        --yesno "Create home directory for '$username'?" 8 45; then
        sudo useradd -m "$username" \
            && msg "User '$username' created with home directory." \
            || msg "Failed to create user."
    else
        sudo useradd "$username" \
            && msg "User '$username' created (no home directory)." \
            || msg "Failed to create user."
    fi
}

# ─────────────────────────────────────────────
# 2. MODIFY USER
# ─────────────────────────────────────────────
modify_user() {
    username=$(whiptail --title "Modify User" \
        --inputbox "Enter username to modify:" 8 40 \
        3>&1 1>&2 2>&3) || return

    [[ -z "$username" ]] && return

    if ! id "$username" &>/dev/null; then
        msg "User '$username' does not exist."
        return
    fi

    choice=$(whiptail --title "Modify User: $username" \
        --menu "What would you like to change?" 14 55 3 \
        "1" "Change username (login)" \
        "2" "Change home directory" \
        "3" "Change shell" \
        3>&1 1>&2 2>&3) || return

    case $choice in
        1)
            newname=$(whiptail --title "Modify User" \
                --inputbox "Enter new username for '$username':" 8 40 \
                3>&1 1>&2 2>&3) || return
            sudo usermod -l "$newname" "$username" \
                && msg "Username changed to '$newname'." \
                || msg "Failed to change username."
            ;;
        2)
            newdir=$(whiptail --title "Modify User" \
                --inputbox "Enter new home directory path:" 8 40 "/home/$username" \
                3>&1 1>&2 2>&3) || return
            sudo usermod -d "$newdir" -m "$username" \
                && msg "Home directory changed to '$newdir'." \
                || msg "Failed to change home directory."
            ;;
        3)
            newshell=$(whiptail --title "Modify User" \
                --inputbox "Enter new shell (e.g. /bin/bash):" 8 40 "/bin/bash" \
                3>&1 1>&2 2>&3) || return
            sudo usermod -s "$newshell" "$username" \
                && msg "Shell changed to '$newshell'." \
                || msg "Failed to change shell."
            ;;
    esac
}

# ─────────────────────────────────────────────
# 3. DELETE USER
# ─────────────────────────────────────────────
delete_user() {
    username=$(whiptail --title "Delete User" \
        --inputbox "Enter username to delete:" 8 40 \
        3>&1 1>&2 2>&3) || return

    [[ -z "$username" ]] && return

    if ! id "$username" &>/dev/null; then
        msg "User '$username' does not exist."
        return
    fi

    whiptail --title "Delete User" \
        --yesno "Are you sure you want to delete user '$username'?\n\nThis cannot be undone!" \
        9 50 || return

    if whiptail --title "Delete User" \
        --yesno "Also remove home directory and mail spool?" 8 50; then
        sudo userdel -r "$username" \
            && msg "User '$username' and their files have been deleted." \
            || msg "Failed to delete user."
    else
        sudo userdel "$username" \
            && msg "User '$username' deleted (home directory kept)." \
            || msg "Failed to delete user."
    fi
}

# ─────────────────────────────────────────────
# 4. LIST USERS
# ─────────────────────────────────────────────
list_users() {
    local tmpfile
    tmpfile=$(mktemp /tmp/userlist.XXXXXX)

    echo "Regular system users:" > "$tmpfile"
    echo "------------------------------------------------------" >> "$tmpfile"
    awk -F: '$3 >= 1000 && $3 < 65534 {
        printf "%-20s UID: %-6s Shell: %s\n", $1, $3, $7
    }' /etc/passwd >> "$tmpfile"

    [[ $(wc -l < "$tmpfile") -le 2 ]] && echo "No regular users found." >> "$tmpfile"

    whiptail --title "List Users" --textbox "$tmpfile" 22 65
    rm -f "$tmpfile"
}

# ─────────────────────────────────────────────
# 5. ADD GROUP
# ─────────────────────────────────────────────
add_group() {
    groupname=$(whiptail --title "Add Group" \
        --inputbox "Enter new group name:" 8 40 \
        3>&1 1>&2 2>&3) || return

    [[ -z "$groupname" ]] && msg "Group name cannot be empty." && return

    if getent group "$groupname" &>/dev/null; then
        msg "Group '$groupname' already exists."
        return
    fi

    sudo groupadd "$groupname" \
        && msg "Group '$groupname' created." \
        || msg "Failed to create group."
}

# ─────────────────────────────────────────────
# 6. MODIFY GROUP
# ─────────────────────────────────────────────
modify_group() {
    groupname=$(whiptail --title "Modify Group" \
        --inputbox "Enter group name to modify:" 8 40 \
        3>&1 1>&2 2>&3) || return

    [[ -z "$groupname" ]] && return

    if ! getent group "$groupname" &>/dev/null; then
        msg "Group '$groupname' does not exist."
        return
    fi

    choice=$(whiptail --title "Modify Group: $groupname" \
        --menu "What would you like to do?" 12 50 2 \
        "1" "Add a user to this group" \
        "2" "Remove a user from this group" \
        3>&1 1>&2 2>&3) || return

    case $choice in
        1)
            username=$(whiptail --title "Add User to Group" \
                --inputbox "Enter username to add to '$groupname':" 8 40 \
                3>&1 1>&2 2>&3) || return
            sudo usermod -aG "$groupname" "$username" \
                && msg "User '$username' added to group '$groupname'." \
                || msg "Failed to add user to group."
            ;;
        2)
            username=$(whiptail --title "Remove User from Group" \
                --inputbox "Enter username to remove from '$groupname':" 8 40 \
                3>&1 1>&2 2>&3) || return
            sudo gpasswd -d "$username" "$groupname" \
                && msg "User '$username' removed from group '$groupname'." \
                || msg "Failed to remove user from group."
            ;;
    esac
}

# ─────────────────────────────────────────────
# 7. DELETE GROUP
# ─────────────────────────────────────────────
delete_group() {
    groupname=$(whiptail --title "Delete Group" \
        --inputbox "Enter group name to delete:" 8 40 \
        3>&1 1>&2 2>&3) || return

    [[ -z "$groupname" ]] && return

    if ! getent group "$groupname" &>/dev/null; then
        msg "Group '$groupname' does not exist."
        return
    fi

    whiptail --title "Delete Group" \
        --yesno "Are you sure you want to delete group '$groupname'?" 8 50 || return

    sudo groupdel "$groupname" \
        && msg "Group '$groupname' deleted." \
        || msg "Failed to delete group."
}

# ─────────────────────────────────────────────
# 8. LIST GROUPS
# ─────────────────────────────────────────────
list_groups() {
    local tmpfile
    tmpfile=$(mktemp /tmp/grouplist.XXXXXX)

    echo "System groups:" > "$tmpfile"
    echo "------------------------------------------------------" >> "$tmpfile"
    awk -F: '{
        printf "%-20s GID: %-6s Members: %s\n", $1, $3, $4
    }' /etc/group >> "$tmpfile"

    whiptail --title "List Groups" --textbox "$tmpfile" 22 70
    rm -f "$tmpfile"
}

# ─────────────────────────────────────────────
# 9. DISABLE USER (lock)
# ─────────────────────────────────────────────
disable_user() {
    username=$(whiptail --title "Disable User" \
        --inputbox "Enter username to lock:" 8 40 \
        3>&1 1>&2 2>&3) || return

    [[ -z "$username" ]] && return

    if ! id "$username" &>/dev/null; then
        msg "User '$username' does not exist."
        return
    fi

    sudo usermod -L "$username" \
        && msg "User '$username' has been locked." \
        || msg "Failed to lock user."
}

# ─────────────────────────────────────────────
# 10. ENABLE USER (unlock)
# ─────────────────────────────────────────────
enable_user() {
    username=$(whiptail --title "Enable User" \
        --inputbox "Enter username to unlock:" 8 40 \
        3>&1 1>&2 2>&3) || return

    [[ -z "$username" ]] && return

    if ! id "$username" &>/dev/null; then
        msg "User '$username' does not exist."
        return
    fi

    sudo usermod -U "$username" \
        && msg "User '$username' has been unlocked." \
        || msg "Failed to unlock user."
}

# ─────────────────────────────────────────────
# 11. CHANGE PASSWORD
# ─────────────────────────────────────────────
change_password() {
    username=$(whiptail --title "Change Password" \
        --inputbox "Enter username to change password for:" 8 40 \
        3>&1 1>&2 2>&3) || return

    [[ -z "$username" ]] && return

    if ! id "$username" &>/dev/null; then
        msg "User '$username' does not exist."
        return
    fi

    clear
    echo "============================================"
    echo "  Changing password for user: $username"
    echo "============================================"
    sudo passwd "$username"
    echo ""
    read -rp "Press Enter to return to menu..."
}

# ─────────────────────────────────────────────
# 12. ABOUT
# ─────────────────────────────────────────────
about() {
    whiptail --title "About" \
        --msgbox "\
User & Group Manager v1.0
Written in Bash using 'whiptail'.

This tool provides a simple TUI for common
Linux user and group administration tasks.

Commands used internally:
  useradd / usermod / userdel
  groupadd / groupmod / groupdel
  passwd / usermod -L / usermod -U

Requires sudo privileges for most operations." \
        18 55
}

# ─────────────────────────────────────────────
# MAIN MENU LOOP
# ─────────────────────────────────────────────
while true; do
    choice=$(whiptail --clear \
        --title "Main Menu" \
        --cancel-button "Exit" \
        --menu "" 22 70 12 \
        "Add User"         "Add a user to the system." \
        "Modify User"      "Modify an existing user." \
        "Delete User"      "Delete an existing user." \
        "List Users"       "List all users on the system." \
        "Add Group"        "Add a user group to the system." \
        "Modify Group"     "Modify a group and its list of members." \
        "Delete Group"     "Delete an existing group." \
        "List Groups"      "List all groups on the system." \
        "Disable User"     "Lock the user account." \
        "Enable User"      "Unlock the user account." \
        "Change Password"  "Change Password of a user." \
        "About"            "Information about this program." \
        3>&1 1>&2 2>&3)

    [[ $? -ne 0 ]] && clear && echo "Goodbye!" && exit 0

    case "$choice" in
        "Add User")        add_user ;;
        "Modify User")     modify_user ;;
        "Delete User")     delete_user ;;
        "List Users")      list_users ;;
        "Add Group")       add_group ;;
        "Modify Group")    modify_group ;;
        "Delete Group")    delete_group ;;
        "List Groups")     list_groups ;;
        "Disable User")    disable_user ;;
        "Enable User")     enable_user ;;
        "Change Password") change_password ;;
        "About")           about ;;
    esac
done