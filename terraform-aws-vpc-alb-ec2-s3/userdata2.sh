#!/bin/bash
set -e

# Update system and install Apache (httpd)
dnf update -y
dnf install -y httpd

# Enable and start Apache
systemctl enable httpd
systemctl start httpd

# Fetch EC2 metadata
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
AZ=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)
PRIVATE_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)

# Create HTML page
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Amazon Linux 2023 | Terraform Project</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background: #0f172a;
      color: #e5e7eb;
      text-align: center;
      padding-top: 60px;
    }
    @keyframes colorChange {
      0% { color: #ef4444; }
      50% { color: #22c55e; }
      100% { color: #3b82f6; }
    }
    h1 {
      animation: colorChange 2s infinite;
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
      Deployed automatically using Terraform & EC2 user-data 🚀
    </p>
  </div>
</body>
</html>
EOF

# Restart Apache to ensure content loads
systemctl restart httpd