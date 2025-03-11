#!/bin/bash

# Define the todo file path
TODO_FILE=~/.todo.txt
VERSION="0.0.1 (dev) (2025-03-10)"

# Ensure the file exists
if [ ! -f "$TODO_FILE" ]; then
    touch "$TODO_FILE"
    echo "Created new todo file: $TODO_FILE"
fi

# ANSI color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# ASCII art logo for TODO
print_logo() {
    echo "               _____         _       "
    echo "              |_   _|__   __| | ___  "
    echo "                | |/ _ \ / _\` |/ _ \ "
    echo "                | | (_) | (_| | (_) |"
    echo "                |_|\___/ \__,_|\___/ "
    echo " "
    echo "    Todo Version ${VERSION}"
    echo " Developer: Zihan YAN (yanzihan@westlake.edu.cn)"
    echo " "
}

# Add a new task
add_task() {
    local message="$1"
    local timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    echo "$timestamp | [ ] | $message" >> "$TODO_FILE"
    echo -e "Added task: ${YELLOW}$message${NC}"
}

# List all tasks with full timestamp, sorting pending tasks first
list_tasks() {
    if [ ! -s "$TODO_FILE" ]; then
        print_logo
        echo -e "${YELLOW}No tasks currently${NC}"
        return
    fi
    print_logo
    echo "================= Current Tasks =================="
#    echo "--------------------------------------------------"
    # Separate pending ([ ]) and completed ([X]) tasks, then combine and number them
    #(grep -v "\[X\]" "$TODO_FILE"; grep "\[X\]" "$TODO_FILE") |
    nl -w2 -s". " "$TODO_FILE" | while IFS= read -r line; do
        num=$(echo "$line" | awk '{print $1}')
        task=$(echo "$line" | cut -d' ' -f3-)
        timestamp=$(echo "$task" | cut -d'|' -f1 | xargs)
        status=$(echo "$task" | cut -d'|' -f2 | xargs)
        message=$(echo "$task" | cut -d'|' -f3- | xargs)

        # Colorize status
        if [ "$status" = "[X]" ]; then
            status_color="${GREEN}[X]${NC}"
        else
            status_color="${RED}[ ]${NC}"
        fi

        # Print task with full timestamp
        echo -e "$num $timestamp | $status_color | $message"
    done
    echo "--------------------------------------------------"
}

# Delete a task by number
delete_task() {
    local task_number="$1"
    if ! [[ "$task_number" =~ ^[0-9]+$ ]]; then
        echo "Error: Please provide a valid task number"
        return
    fi
    local total_lines=$(wc -l < "$TODO_FILE")
    if [ "$task_number" -lt 1 ] || [ "$task_number" -gt "$total_lines" ]; then
        echo "Error: Task number $task_number out of range (1-$total_lines)"
        return
    fi
    sed -i "${task_number}d" "$TODO_FILE"
    echo "Deleted task number $task_number"
}

# Mark a task as done
done_task() {
    local task_number="$1"
    if ! [[ "$task_number" =~ ^[0-9]+$ ]]; then
        echo "Error: Please provide a valid task number"
        return
    fi
    local total_lines=$(wc -l < "$TODO_FILE")
    if [ "$task_number" -lt 1 ] || [ "$task_number" -gt "$total_lines" ]; then
        echo "Error: Task number $task_number out of range (1-$total_lines)"
        return
    fi
    sed -i "${task_number}s/\[ \]/[X]/" "$TODO_FILE"
    echo -e "Marked task $task_number as ${GREEN}done${NC}"
}

# Search tasks by keyword with full timestamp
search_tasks() {
    local keyword="$1"
    if [ -z "$keyword" ]; then
        echo "Error: Please provide a search keyword"
        return
    fi
    print_logo
    echo -e "${YELLOW}Tasks matching '$keyword':${NC}"
    echo "--------------------------------------------------"
    grep -i "$keyword" "$TODO_FILE" | nl -w2 -s". " | while IFS= read -r line; do
        num=$(echo "$line" | awk '{print $1}')
        task=$(echo "$line" | cut -d' ' -f3-)
        timestamp=$(echo "$task" | cut -d'|' -f1 | xargs)
        status=$(echo "$task" | cut -d'|' -f2 | xargs)
        message=$(echo "$task" | cut -d'|' -f3- | xargs)

        if [ "$status" = "[X]" ]; then
            status_color="${GREEN}[X]${NC}"
        else
            status_color="${RED}[ ]${NC}"
        fi
        echo -e "$num $timestamp $status_color $message"
    done
    echo "--------------------------------------------------"
}

# Show task statistics
show_stats() {
    local total=$(wc -l < "$TODO_FILE")
    local done=$(grep -c "\[X\]" "$TODO_FILE")
    local pending=$((total - done))
    print_logo
    echo "================ Task Statistics ================="
    #echo "--------------------------------------------------"
    echo -e "Total tasks: $total"
    echo -e "Completed:   ${GREEN}$done${NC}"
    echo -e "Pending:     ${RED}$pending${NC}"
    echo "--------------------------------------------------"
}

# Main logic
case "$1" in
    "add")
        if [ -z "$2" ]; then
            echo "Error: Please provide a task message, e.g., todo.sh add 'Buy milk'"
        else
            add_task "$2"
        fi
        ;;
    "del")
        if [ -z "$2" ]; then
            echo "Error: Please provide a task number, e.g., todo.sh del 1"
        else
            delete_task "$2"
        fi
        ;;
    "done")
        if [ -z "$2" ]; then
            echo "Error: Please provide a task number, e.g., todo.sh done 1"
        else
            done_task "$2"
        fi
        ;;
    "search")
        if [ -z "$2" ]; then
            echo "Error: Please provide a keyword, e.g., todo.sh search milk"
        else
            search_tasks "$2"
        fi
        ;;
    "stats"|"status")
        show_stats
        ;;
    "")
        list_tasks
        ;;
    *)
        print_logo
        echo "Usage:"
        echo "  todo.sh add 'message'         - Add a new task"
        echo "  todo.sh del number            - Delete a task"
        echo "  todo.sh done number           - Mark a task as done"
        echo "  todo.sh search keyword        - Search tasks by keyword"
        echo "  todo.sh status                - Show task statistics"
        echo "  todo.sh                       - List all tasks"
        ;;
esac