#Amazon2023, Redhat,CentOS------>>>>>>><<<<<<<<<<
# Update system packages
sudo dnf update -y

# Install AWS CLI v2 (already available in Amazon Linux 2023 repos)
sudo dnf install -y awscli

# Install Terraform (HashiCorp repo)
sudo dnf install -y yum-utils

# Add HashiCorp repo
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo

# Install Terraform
sudo dnf install -y terraform

# Verify installations
aws --version
terraform -v


#For UBUNTU------------------->>>>>>>>>
#!/bin/bash
set -e

# Update system packages
sudo apt update -y

# Install AWS CLI
sudo apt install awscli -y

# Add HashiCorp GPG key
wget -O- https://apt.releases.hashicorp.com/gpg | \
  sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

# Add HashiCorp repo for Terraform
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

# Update and install Terraform
sudo apt update -y
sudo apt install terraform -y

# Verify installation
terraform -v
aws --version