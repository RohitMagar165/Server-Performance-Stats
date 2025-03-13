#!/bin/bash

# Script Name: server-stats.sh
# Description: Displays server performance stats: CPU, Memory, Disk usage, and Top 5 processes by CPU and Memory.
# Author: ChatGPT

# Function to display CPU usage
function cpu_usage() {
    echo "===== CPU Usage ====="
    mpstat 1 1 | awk '/Average/ { printf("Total CPU Usage: %.2f%%\n", 100 - $NF) }'
    echo
}

# Function to display Memory usage
function memory_usage() {
    echo "===== Memory Usage ====="
    free -m | awk '
    /Mem:/ {
        total=$2; used=$3; free=$4;
        printf("Total Memory: %d MB\nUsed Memory: %d MB\nFree Memory: %d MB\n", total, used, free);
        printf("Memory Usage: %.2f%%\n", used/total*100);
    }'
    echo
}

# Function to display Disk usage
function disk_usage() {
    echo "===== Disk Usage (Root Partition) ====="
    df -h / | awk 'NR==2 { printf("Total: %s\nUsed: %s\nAvailable: %s\nUsage: %s\n", $2, $3, $4, $5) }'
    echo
}

# Function to display Top 5 processes by CPU usage
function top_cpu_processes() {
    echo "===== Top 5 Processes by CPU Usage ====="
    ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
    echo
}

# Function to display Top 5 processes by Memory usage
function top_mem_processes() {
    echo "===== Top 5 Processes by Memory Usage ====="
    ps -eo pid,comm,%mem --sort=-%mem | head -n 6
    echo
}

# Main
echo "===== Server Performance Statistics ====="
echo "Date: $(date)"
echo "Hostname: $(hostname)"
echo "Uptime: $(uptime -p)"
echo

cpu_usage
memory_usage
disk_usage
top_cpu_processes
top_mem_processes

