<div align="center">
<img src="./todo-logo.png" width="25%" /><br>
<a href="https://github.com/zhyan0603/todo"><img src="https://img.shields.io/badge/version-0.0.1-brightgreen" alt="Version"></a>
<a href="https://github.com/zhyan0603/todo/blob/main/LICENCE"><img src="https://img.shields.io/badge/license-GPL--3.0-blue" alt="License"></a>
<a href="https://github.com/zhyan0603/todo/stargazers"><img src="https://img.shields.io/github/stars/zhyan0603/todo?style=social" alt="Stars"></a>
<img src="https://img.shields.io/github/languages/code-size/zhyan0603/todo" alt="Code Size">
</div>

# Todo

`todo.sh` is a lightweight and ***easy-to-use command-line-based todo management*** script written in Bash. It helps you quickly add, list, complete, delete, and search tasks directly from your terminal.

## Features

- **Add Tasks**: Quickly add new tasks with a timestamp.
- **List Tasks**: View all tasks, with pending tasks sorted before completed ones. 
- **Mark as Done**: Mark tasks as completed with a green `[X]`. 
- **Delete Tasks**: Remove tasks by their number. 
- **Search Tasks**: Find tasks by keyword. 
- **Statistics**: See a summary of total, completed, and pending tasks. 
- **Colorful Output**: Uses ANSI colors for a visually appealing interface. 
- **Simple Storage**: Tasks are saved in a plain text file (`~/.todo.txt`).

## Installation

```bash
# Clone the repository
git clone https://github.com/zhyan0603/todo.git
cd todo.sh

# Make the script executable
chmod +x todo.sh

# move it to a directory in your PATH
mv todo.sh ~/bin/todo.sh
```

## Usage

#### Add tasks

```bash
$ todo.sh add "Buy milk"
Added task: Buy milk
$ todo.sh add "Write code"
Added task: Write code
$ todo.sh add "Read book"
Added task: Read book
```

#### Initial task list

```bash
$ todo.sh
               _____         _       
              |_   _|__   __| | ___  
                | |/ _ \ / _\` |/ _ \ 
                | | (_) | (_| | (_) |
                |_|\___/ \__,_|\___/ 
 
    Todo Version 0.0.1 (dev) (2025-03-10)
    Developer: Zihan YAN (yanzihan@westlake.edu.cn)
 
================= Current Tasks ==================
1. 2025-03-10 14:40:00 | [ ] | Buy milk
2. 2025-03-10 14:40:05 | [ ] | Write code
3. 2025-03-10 14:40:10 | [ ] | Read book
--------------------------------------------------
```

#### Mark some tasks as done

```bash
$ todo.sh done 2
Marked task 2 as done
$ todo.sh
               _____         _       
              |_   _|__   __| | ___  
                | |/ _ \ / _\` |/ _ \ 
                | | (_) | (_| | (_) |
                |_|\___/ \__,_|\___/ 
 
    Todo Version 0.0.1 (dev) (2025-03-10)
 Developer: Zihan YAN (yanzihan@westlake.edu.cn)
 
================= Current Tasks ==================
1. 2025-03-10 14:40:00 | [ ] | Buy milk
2. 2025-03-10 14:40:10 | [ ] | Read book
3. 2025-03-10 14:40:05 | [X] | Write code
--------------------------------------------------
(Note: [ ] is in red, [X] is in green)
```

#### Search for tasks

```bash
$ todo.sh search "milk"
Tasks matching 'milk':
--------------------------------------------------
1. 2025-03-10 14:40:00 | [ ] | Buy milk
--------------------------------------------------
```

#### Show task statistics

```bash
$ todo.sh status
================= Task Statistics ================
Total tasks: 3
Completed:   1
Pending:     2
--------------------------------------------------
```

#### Delete a task

```bash
$ todo.sh del 1
Deleted task number 1
```

## File Structure

Tasks are stored in `~/.todo.txt` in the following format:

```
YYYY-MM-DD HH:MM:SS | [ ] | Task description
YYYY-MM-DD HH:MM:SS | [X] | Completed task description
```

## Join Us 

We’d love your help to improve `todo.sh`! Contribute by:

- Adding scripts via [Pull Requests](https://github.com/zhyan0603/GPUMDkit/pulls).
- Contacting me at [yanzihan@westlake.edu.cn](mailto:yanzihan@westlake.edu.cn).

Let’s build something useful together! If you like it, please ⭐ [star us on GitHub](https://github.com/zhyan0603/GPUMDkit). Thanks for your support!

