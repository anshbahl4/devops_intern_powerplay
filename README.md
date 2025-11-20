Made By: Ansh Bahl

This project is my submission for the DevOps Intern Assignment.
The goal was to set up an EC2 instance, configure Linux users, host a simple web page, create a monitoring script, schedule it with cron, and then upload logs to CloudWatch.

Part 1 – EC2 & User Setup

Launched an Ubuntu t2.micro EC2 instance (free tier).

Connected to it using SSH.

Created a new user:

sudo adduser devops_intern


Gave the user sudo access without a password by editing the sudoers file:

sudo visudo


Added:

devops_intern ALL=(ALL) NOPASSWD:ALL


Changed the hostname to:

ansh-devops

Deliverable:

Screenshot showing hostname, /etc/passwd, and sudo whoami.

Part 2 – Simple Web Service

Installed Nginx:

sudo apt update
sudo apt install nginx -y


Fetched the instance ID using IMDSv2.

Created an index.html containing:

My name

Instance ID

Server uptime

File location:

/var/www/html/index.html

Deliverable:

Screenshot of the webpage accessed from the EC2 public IP.

Part 3 – Monitoring Script & Cron Job

Created the monitoring script:

/usr/local/bin/system_report.sh


The script prints:

Date & time

Uptime

CPU usage

Memory usage

Disk usage

Top 3 processes by CPU

Made it executable:

sudo chmod +x /usr/local/bin/system_report.sh


Created a cron job:

sudo crontab -e


Added:

*/5 * * * * /usr/local/bin/system_report.sh >> /var/log/system_report.log


After waiting around 10 minutes, multiple log entries were generated.

Deliverables:

Cron configuration

Screenshot of /var/log/system_report.log showing multiple entries

Part 4 – CloudWatch Integration

Created a CloudWatch Log Group:

/devops/intern-metrics


Created a log stream:

system-report-stream


Converted the system log file into a JSON format using jq.

Uploaded the logs using AWS CLI.

AWS CLI Commands Used
aws logs create-log-group --log-group-name /devops/intern-metrics

aws logs create-log-stream \
    --log-group-name /devops/intern-metrics \
    --log-stream-name system-report-stream

aws logs put-log-events \
    --region us-east-1 \
    --log-group-name /devops/intern-metrics \
    --log-stream-name system-report-stream \
    --log-events file://log_events.json

Deliverable:

Screenshot of CloudWatch showing the uploaded log events.