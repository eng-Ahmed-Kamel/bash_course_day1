```markdown
# Bash Scripting Lab – Scripts Overview

## Author
**Ahmed Kamel**

---

## Lab Directory Structure

```

Lab2/
├── lab2.1       # Greeting script: asks user name and sends greeting
├── lab2.2s1     # Script s1: contains variable x=5 and calls lab2.2s2
├── lab2.2s2     # Script s2: prints value of x using environment variable or argument
├── lab2.3       # Custom copy script: copy single file or multiple files to a directory
├── lab2.4       # Custom change directory script: go to home or specified directory
├── lab2.5       # Custom list directory script: list current or specified directory
├── lab2.6       # Enhanced list directory script: supports options -l, -a, -d, -i, -R

````

---

## 1. Greeting Script (`lab2.1`)

**Description:**  
A simple script that asks for the user's name and prints a personalized greeting.

**Usage:**  
```bash
./lab2.1
````

**Example Output:**

```bash
Enter your name:
Ahmed
Hello, Ahmed! Nice to meet you.
```

---

## 2. Script Calling Another Script (`lab2.2s1` and `lab2.2s2`)

**Description:**

* `lab2.2s1` contains a variable `x=5` and calls `lab2.2s2`.
* `lab2.2s2` prints the value of `x` in two ways:

  1. Using an **exported environment variable**
  2. Using **command-line argument**

**Usage:**

```bash
./lab2.2s1
```

---

## 3. Custom Copy Script (`lab2.3`)

**Description:**

* Copies a single file to another file.
* Copies multiple files to a directory.

**Usage:**

```bash
# Copy a single file
./lab2.3 file1.txt file2.txt

# Copy multiple files to a directory
./lab2.3 file1.txt file2.txt file3.txt myfolder/
```

---

## 4. Custom Change Directory Script (`lab2.4`)

**Description:**

* Changes directory to **home** if called without arguments.
* Otherwise, changes directory to the specified path.

**Usage:**

```bash
# Go to home directory
source ./lab2.4

# Go to a specific directory
source ./lab2.4 /path/to/directory
```

**Note:** Use `source` to change the **current shell directory**.

---

## 5. Custom List Directory Script (`lab2.5`)

**Description:**

* Lists current directory if called without arguments.
* Otherwise, lists the specified directory.

**Usage:**

```bash
# List current directory
./lab2.5

# List a specific directory
./lab2.5 /etc
```

---

## 6. Enhanced List Directory Script (`lab2.6`)

**Description:**
Supports individual options for listing directory contents:

| Option | Description                                    |
| ------ | ---------------------------------------------- |
| `-l`   | List in long format                            |
| `-a`   | List all entries including hidden files        |
| `-d`   | If argument is a directory, list only its name |
| `-i`   | Print inode number                             |
| `-R`   | Recursively list subdirectories                |

**Usage:**

```bash
./lab2.6             # List current directory
./lab2.6 /etc        # List /etc
./lab2.6 -l          # Long format
./lab2.6 -a          # Show hidden files
./lab2.6 -d /etc     # Show only directory name
./lab2.6 -i          # Show inode numbers
./lab2.6 -R /etc     # Recursive listing
./lab2.6 -laR /etc   # Combine options
```

---

### Notes

* All scripts are written in **Bash**.
* Make scripts executable before use:

```bash
chmod +x scriptname
```

* Use `source` for scripts that need to change the **current shell environment**, like `lab2.4`.

```
