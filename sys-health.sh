#!/bin/bash

# ─────────────────────────────────────────────
# Linux System Health Checker (v1.1)
# Author: Praneeth Varma K
# Date: 29/07/2025
# Description: System info and resource usage report with enhanced formatting
# ─────────────────────────────────────────────

# ========== CONFIGURATION ==========
LOG_MODE=false
ALL_MODE=false
LOG_FILE="system_health_$(date +%Y%m%d_%H%M%S).log"

# ========== COLOR CODES ==========
RED='\033[0;31m'
ORANGE='\033[38;5;214m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

# ========== USAGE FUNCTION ==========
usage() {
    echo -e "${BLUE}System Health Checker${NC}"
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -a     Show all system stats (default)"
    echo "  -l     Log output to a file"
    echo "  -h     Show help"
}

# ========== PARSE OPTIONS ==========
while getopts "alh" opt; do
    case $opt in
        a) ALL_MODE=true ;;
        l) LOG_MODE=true ;;
        h) usage; exit 0 ;;
        *) usage; exit 1 ;;
    esac
done

# ========== OUTPUT FUNCTION ==========
print() {
    if [ "$LOG_MODE" = true ]; then
        echo -e "$1" | tee -a "$LOG_FILE"
    else
        echo -e "$1"
    fi
}

# ========== SYSTEM HEADER ==========
print "${BLUE}===== System Health Checker =====${NC}"
print "Host: $(hostname)  |  User: $(whoami)  |  Date: $(date +"%Y-%m-%d %I:%M %p")"
print "--------------------------------------------"

# ========== SYSTEM OVERVIEW (Neofetch-style) ==========
print "${BLUE}--- System Overview ---${NC}"
print "OS: $(lsb_release -ds 2>/dev/null || grep '^PRETTY_NAME' /etc/os-release | cut -d= -f2 | tr -d '"')"
print "Kernel: $(uname -r)"
print "Shell: $SHELL"
print "Terminal: $TERM"
print "CPU: $(lscpu | grep 'Model name' | cut -d: -f2 | xargs)"
print "GPU: $(lspci | grep -i 'vga\|3d\|2d' | cut -d: -f3 | xargs)"
print "Desktop Env/WM: ${XDG_CURRENT_DESKTOP:-Unknown}"

# ========== UPTIME ==========
print "${GREEN}--- Uptime ---${NC}"
print "$(uptime -p)"

# ========== MEMORY USAGE ==========
print "${GREEN}--- Memory Usage ---${NC}"
used_mem=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')
mem_status="${GREEN}$used_mem% used${NC}"
[ "$used_mem" -gt 80 ] && mem_status="${RED}$used_mem% used${NC}"
[ "$used_mem" -gt 70 ] && mem_status="${ORANGE}$used_mem% used${NC}"
[ "$used_mem" -gt 60 ] && mem_status="${YELLOW}$used_mem% used${NC}"
print "RAM Usage: $mem_status"
print "$(free -h)"

# ========== DISK USAGE ==========
print "${GREEN}--- Disk Usage (/ Partition) ---${NC}"
disk_usage=$(df / | awk 'NR==2 {print $5}' | tr -d '%')
disk_status="${GREEN}$disk_usage% used${NC}"
[ "$disk_usage" -gt 80 ] && disk_status="${RED}$disk_usage% used${NC}"
[ "$disk_usage" -gt 70 ] && disk_status="${ORANGE}$disk_usage% used${NC}"
[ "$disk_usage" -gt 60 ] && disk_status="${YELLOW}$disk_usage% used${NC}"
print "Disk Usage: $disk_status"
print "$(df -h /)"

# ========== CPU LOAD ==========
print "${GREEN}--- CPU Load (1 min average) ---${NC}"
cpu_load=$(uptime | awk -F'load average:' '{ print $2 }' | cut -d',' -f1 | xargs)
load_int=${cpu_load%.*}
cpu_status="${GREEN}${cpu_load}${NC}"
[ "$load_int" -ge 3 ] && cpu_status="${RED}${cpu_load}${NC}"
[ "$load_int" -eq 2 ] && cpu_status="${YELLOW}${cpu_load}${NC}"
print "Load Average: $cpu_status"

# ========== TOP 5 MEMORY-CONSUMING PROCESSES ==========
print "${GREEN}--- Top 5 Memory-Consuming Processes ---${NC}"
ps -eo pid,comm,%mem,rss --sort=-%mem | head -n 6 | \
awk 'NR==1 {printf "%-8s %-20s %-10s %-10s\n", "PID", "COMMAND", "%MEM", "RAM(MB)"} 
     NR>1 {printf "%-8s %-20s %-10s %-10.2f\n", $1, $2, $3, $4/1024}'

# ========== OPTIONAL: ALL STATS ==========
if [ "$ALL_MODE" = true ]; then
    print "${GREEN}--- Process Summary ---${NC}"
    print "$(ps -e --no-headers | wc -l) running processes"
fi

# ========== END ==========
print "${BLUE}===== End of Report =====${NC}"

