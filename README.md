# 🖥️ sys-health.sh — Linux System Health Checker

A lightweight and customizable Bash script to monitor essential system health metrics on any Linux machine. It provides a clean, color-coded terminal output for memory, CPU, disk usage, uptime, and more — ideal for developers, system administrators, and power users.

---

## 📌 Features

- 🔍 **Real-time system diagnostics** (CPU, RAM, disk usage, uptime)
- 📊 **Top memory-consuming processes** (with RAM used in MB)
- 📦 **User and hostname info**, timestamped
- 📁 **Optional logging** to timestamped log files
- 🎛️ **Command-line flags** for flexible control
- 🎨 **Color-coded output** (green/yellow/red/blue)
- 💻 **No root required**; works on most Linux distributions

---

## 🚀 Usage

Make the script executable:

```bash
chmod +x sys-health.sh
```

Run the script with desired options:

```bash
./sys-health.sh [OPTIONS]
```

### Options

| Flag | Description                            |
|------|----------------------------------------|
| `-a` | Show all stats (default)               |
| `-l` | Log output to a file                   |
| `-h` | Display help message and usage         |

Example:

```bash
./sys-health.sh -a -l
```

This command shows all system stats and logs the output to a timestamped `.log` file.

---

## 🧪 Output Overview

```
===== System Health Checker =====
Host: my-machine  |  User: john  |  Date: 2025-08-02 11:30 AM
--------------------------------------------
--- Uptime ---
up 2 hours, 15 minutes

--- Memory Usage ---
RAM Usage: 42% used
Total: 8.0Gi | Used: 3.3Gi | Free: 4.4Gi

--- Disk Usage (/ Partition) ---
Disk Usage: 68% used
Size: 100G | Used: 68G | Avail: 32G

--- CPU Load (1 min average) ---
Load Average: 1.23

--- Top 5 Memory-Consuming Processes ---
PID     COMMAND             %MEM       RAM(MB)
1531    firefox             9.2        750.32
1012    code                6.1        580.65
...
===== End of Report =====
```

---

## 🧩 Customization

Want to extend the tool?

- Add swap memory info
- Display IP address or battery status
- Include available system updates
- Add alerting when CPU/memory thresholds are breached

This script is modular and easy to extend.

---

## 📂 Project Structure

```
sys-health/
├── sys-health.sh
├── README.md
├── ss/                  # Screenshots of the script
└── logs/                # (optional) for log outputs
```

---

## Screenshots

## 📝 License

This project is licensed under the MIT License — feel free to use, modify, and distribute it.

---

## 🙌 Acknowledgments

Created by [Praneeth Varma K](https://github.com/pvk-96)  
Inspired by tools like `htop`, `neofetch`, and `vmstat`.

---

## 💡 Contribute

Pull requests are welcome! Feel free to fork this project and enhance it.

If you'd like to:
- Add a new feature
- Improve compatibility
- Refactor for portability

Start an issue or submit a PR.

---

## 🙌 Connect with me:
Github: # pvk-96
E-mail: # praneethvarmakopperla@gmail.com
