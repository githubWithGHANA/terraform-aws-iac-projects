#!/bin/bash
# ---------------------------------------------
# User Data Script for Terraform Project - Server 2
# OS      : Amazon Linux 2023
# Purpose : Display EC2 metadata using IMDSv2
# Author  : Ghanashyam
# ---------------------------------------------

set -e

# Update system packages
dnf update -y

# Install Apache
dnf install -y httpd

# Enable and start Apache
systemctl enable httpd
systemctl start httpd

# ---------------- IMDSv2 TOKEN ----------------
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

# Fetch EC2 metadata securely
INSTANCE_ID=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" \
  -s http://169.254.169.254/latest/meta-data/instance-id)

AZ=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" \
  -s http://169.254.169.254/latest/meta-data/placement/availability-zone)

PRIVATE_IP=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" \
  -s http://169.254.169.254/latest/meta-data/local-ipv4)

# ---------------- HTML PAGE ----------------
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Terraform Server 2</title>

  <style>
    body {
      font-family: Arial, sans-serif;
      background: #0f172a;
      color: #e5e7eb;
      text-align: center;
      padding-top: 60px;
    }

    /* Faster color animation */
    @keyframes colorChange {
      0%   { color: #ef4444; }
      25%  { color: #22c55e; }
      50%  { color: #3b82f6; }
      75%  { color: #f59e0b; }
      100% { color: #ef4444; }
    }

    h1 {
      animation: colorChange 1s infinite; /* FAST */
      margin-bottom: 10px;
    }

    .card {
      background: #020617;
      padding: 30px;
      border-radius: 12px;
      width: 450px;
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
    <h1>Terraform Project Server-2</h1>
    <p>Welcome to <strong>Ghanashyam’s Terraform Project</strong></p>

    <div class="info">Instance ID: <span class="badge">$INSTANCE_ID</span></div>
    <div class="info">Availability Zone: <span class="badge">$AZ</span></div>
    <div class="info">Private IP: <span class="badge">$PRIVATE_IP</span></div>

    <p style="margin-top:20px; font-size:14px;">
      Secure metadata access using IMDSv2 🚀
    </p>
  </div>
</body>
</html>
EOF

# Restart Apache
systemctl restart httpd
