#!/bin/bash
# ---------------------------------------------
# User Data Script for Terraform Project - Server 1
# OS      : Amazon Linux 2023
# Purpose : Install Apache and display instance details
# Author  : Ghanashyam
# ---------------------------------------------

set -e

# Update system packages
dnf update -y

# Install Apache (httpd)
dnf install -y httpd

# Enable and start Apache
systemctl enable httpd
systemctl start httpd

# ---------------- IMDSv2 TOKEN ----------------
# Fetch IMDSv2 token (more secure than IMDSv1)
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

# Fetch EC2 metadata using IMDSv2
INSTANCE_ID=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" \
  -s http://169.254.169.254/latest/meta-data/instance-id)

HOSTNAME=$(hostname)

# ---------------- HTML PAGE ----------------
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Terraform Server 1</title>

  <style>
    body {
      font-family: Arial, sans-serif;
      background: #020617;
      color: #e5e7eb;
      text-align: center;
      padding-top: 70px;
    }

    /* Faster color animation */
    @keyframes colorChange {
      0%   { color: #ef4444; }
      25%  { color: #22c55e; }
      50%  { color: #3b82f6; }
      75%  { color: #a855f7; }
      100% { color: #ef4444; }
    }

    h1 {
      animation: colorChange 1s infinite; /* FAST animation */
      margin-bottom: 10px;
    }

    .card {
      background: #0f172a;
      padding: 30px;
      border-radius: 12px;
      width: 420px;
      margin: auto;
      box-shadow: 0 10px 25px rgba(0,0,0,0.4);
    }

    .info {
      margin-top: 15px;
      font-size: 18px;
    }

    .badge {
      color: #22c55e;
      font-weight: bold;
    }
  </style>
</head>

<body>
  <div class="card">
    <h1>Terraform Project Server-1</h1>
    <p>Welcome to <strong>Ghanashyam’s Terraform Project</strong></p>

    <div class="info">Instance ID: <span class="badge">$INSTANCE_ID</span></div>
    <div class="info">Hostname: <span class="badge">$HOSTNAME</span></div>

    <p style="margin-top:20px; font-size:14px;">
      Deployed automatically using Terraform & EC2 User-Data
    </p>
  </div>
</body>
</html>
EOF

# Restart Apache to ensure latest content is served
systemctl restart httpd
