#!/bin/bash

echo "-------------------------------------------"
echo "System Report - $(date)"
echo "-------------------------------------------"

echo "Uptime:"
uptime

echo
echo "CPU Usage (%):"
top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}'

echo
echo "Memory Usage (%):"
free | grep Mem | awk '{print ($3/$2)*100}'

echo
echo "Disk Usage (%):"
df -h / | awk 'NR==2 {print $5}'

echo
echo "Top 3 Processes by CPU Usage:"
ps -eo pid,ppid,cmd,%cpu,%mem --sort=-%cpu | head -n 4

echo