# author :
## Ahmed Kamel Mohamed 
## System Admin ITI 46
## bash coursh

---
# 👤 User & Group Manager

A terminal-based user and group management tool for Linux, built entirely in **Bash** with a **whiptail** TUI (Text User Interface). Designed to replicate a clean menu-driven admin panel — no GUI required.

---

## 📸 Preview

```
┌─────────────────── Main Menu ───────────────────┐
│                                                  │
│   Add User          Add a user to the system.   │
│   Modify User       Modify an existing user.    │
│   Delete User       Delete an existing user.    │
│   List Users        List all users on system.   │
│   Add Group         Add a user group to system. │
│   Modify Group      Modify a group and members. │
│   Delete Group      Delete an existing group.   │
│   List Groups       List all groups on system.  │
│   Disable User      Lock the user account.      │
│   Enable User       Unlock the user account.    │
│   Change Password   Change Password of a user.  │
│   About             Information about program.  │
│                                                  │
│         <Select>               <Exit>            │
└──────────────────────────────────────────────────┘
```

---

## 📋 Requirements

| Requirement | Details |
|---|---|
| OS | Linux (Debian, Ubuntu, RHEL, CentOS, Fedora, etc.) |
| Shell | Bash 4.0+ |
| TUI library | `whiptail` (usually pre-installed) |
| Privileges | `sudo` required for most operations |

### Install whiptail (if not already installed)

```bash
# Debian / Ubuntu
sudo apt install whiptail

# RHEL / CentOS / Fedora
sudo yum install newt

# Arch Linux
sudo pacman -S libnewt
```

> **Note:** `whiptail` comes pre-installed on most Debian/Ubuntu systems as part of the base install.

---

## 🚀 Installation & Usage

```bash
# 1. Clone or download the script
git clone https://github.com/eng-Ahmed-Kamel/bash_course_ITI.git
cd user-manager

# 2. Make the script executable
chmod +x user_manager.sh

# 3. Run it with sudo
sudo ./user_manager.sh
```

> `sudo` is required because operations like `useradd`, `userdel`, `groupadd`, and `passwd` need root privileges.

---

## 🗂️ Features

### User Management

| Menu Option | Description | Command Used |
|---|---|---|
| **Add User** | Create a new user, optionally with a home directory | `useradd [-m]` |
| **Modify User** | Change username, home directory, or login shell | `usermod` |
| **Delete User** | Remove a user, optionally with their home directory | `userdel [-r]` |
| **List Users** | Display all regular users (UID 1000–65533) with UID and shell | reads `/etc/passwd` |
| **Disable User** | Lock a user account (prevents login) | `usermod -L` |
| **Enable User** | Unlock a previously locked account | `usermod -U` |
| **Change Password** | Set a new password for any user | `passwd` |

### Group Management

| Menu Option | Description | Command Used |
|---|---|---|
| **Add Group** | Create a new system group | `groupadd` |
| **Modify Group** | Add or remove a user from a group | `usermod -aG` / `gpasswd -d` |
| **Delete Group** | Remove an existing group | `groupdel` |
| **List Groups** | Display all groups with GID and members | reads `/etc/group` |

---

## 🧭 Navigation

| Key | Action |
|---|---|
| `↑` / `↓` | Move between menu items |
| `Enter` | Select highlighted option |
| `Tab` | Switch between buttons (Select / Exit) |
| `Esc` or `Cancel` | Go back / Exit |
| `↑` / `↓` / `PgUp` / `PgDn` | Scroll in List views |
| `q` or `Enter` | Exit List Users / List Groups view |

---

## 🔧 How It Works

The script uses **whiptail** widgets for all UI interactions:

- `--menu` — the main navigation menu and sub-menus
- `--inputbox` — prompts for usernames, paths, shells, etc.
- `--yesno` — confirmation dialogs before destructive actions
- `--msgbox` — success and error notifications
- `--textbox` — scrollable viewer for listing users and groups (writes to a temp file via `mktemp`, cleaned up automatically)

The standard `3>&1 1>&2 2>&3` file descriptor swap is used throughout to capture `whiptail` output (which goes to stderr) into variables.

---

## 📁 Project Structure

```
user-manager/
├── user_manager.sh   # Main script
└── README.md         # This file
```

---

## ⚠️ Important Notes

- **Destructive operations** (Delete User, Delete Group) prompt for confirmation before executing.
- **Delete User** gives you the option to also remove the home directory and mail spool (`userdel -r`).
- **List Users** only shows regular users (UID 1000–65533), not system accounts.
- **Change Password** drops to the terminal temporarily (whiptail cannot mask password input), then returns to the menu on Enter.
- Locking a user (`Disable User`) adds a `!` prefix to their password hash in `/etc/shadow` — it does **not** delete the account.

---

## 🛠️ Troubleshooting

| Problem | Solution |
|---|---|
| `whiptail: command not found` | Install with `sudo apt install whiptail` |
| `Permission denied` | Run the script with `sudo` |
| Menu appears garbled | Resize your terminal window to at least 80×24 |
| List view won't scroll | Use arrow keys or Page Up/Down; press `q` or Enter to exit |

---

## 📄 License

Feel free to use, modify, and distribute.