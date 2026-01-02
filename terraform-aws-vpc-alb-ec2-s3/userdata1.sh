#!/bin/bash
set -e

# Update and install Apache (httpd on Amazon Linux)
dnf update -y
dnf install -y httpd

# Enable and start Apache
systemctl enable httpd
systemctl start httpd

# Fetch EC2 metadata
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
HOSTNAME=$(hostname)

# Create simple static page
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Server 1 | Terraform Project</title>

  <style>
    body {
      font-family: Arial, sans-serif;
      background: #020617;
      color: #e5e7eb;
      text-align: center;
      padding-top: 70px;
    }

    h1 {
      color: #22c55e;
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
      color: #3b82f6;
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
      Auto-deployed using Terraform & EC2 user-data
    </p>
  </div>
</body>
</html>
EOF

# Restart Apache to ensure latest content is served
systemctl restart httpd