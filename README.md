# Launching EC2 Instance using Terraform 🚀

This project demonstrates how to use **Terraform** to provision an **AWS EC2 instance** with a Security Group, variables, and outputs.

---

## 📌 Prerequisites
- AWS Account with an IAM user having `EC2` permissions
- AWS CLI installed and configured
```bash
aws configure
```
- Terraform installed
```bash
terraform -version
```
- Visual Studio Code (VS Code)
- An existing AWS Key Pair and its .pem file for SSH access

---

## 📂 Project Structure
terraform-ec2-assignment/
 ├── main.tf           &nbsp;   # Main Terraform configuration </br>
 ├── variables.tf   &nbsp;      # Variables definition </br>
 ├── terraform.tfvars     &nbsp;# Variable values</br>
 ├── outputs.tf        &nbsp;   # Outputs after apply</br>
 └── README.md           &nbsp; # Documentation</br>

---

## ⚙️ Steps
### 1. Setup

- Install Terraform and verify:
```bash
terraform -version
```
- Create working directory:
```bash
mkdir terraform-ec2-assignment
cd terraform-ec2-assignment
```


### 2. Launch EC2 Instance

- Define an EC2 instance in main.tf with:
- AMI: Amazon Linux 2
- Instance type: t2.micro
- Key Pair: Existing AWS key pair

Run:
```bash
terraform init
terraform apply -auto-approve
```
Check the AWS Console for your running EC2 instance.


### 3. Use Variables

- variables.tf defines variables (region, ami, instance_type, key_name).
- terraform.tfvars assigns values.

Example terraform.tfvars:
```yaml
region          = "us-east-1"
ami             = "ami-0c02fb55956c7d316"
instance_type   = "t2.micro"
key_name        = "my-aws-keypair"
allowed_ssh_cidr = "YOUR_PUBLIC_IP/32"
allowed_http_cidr = "0.0.0.0/0"
```

- Re-run:
```bash
terraform apply -auto-approve
```


### 4. Security Group with Variables

Security Group allows:

- SSH (22) only from your public IP

- HTTP (80) from anywhere

This is attached to the EC2 instance.


### 5. Outputs

Defined in outputs.tf:
```bash
output "instance_public_ip" {
  value = aws_instance.my_ec2.public_ip
}

output "instance_public_dns" {
  value = aws_instance.my_ec2.public_dns
}
```

After terraform apply, Terraform prints:
```yaml
instance_public_ip = "X.X.X.X"
instance_public_dns = "ec2-xx-xx-xx-xx.compute-1.amazonaws.com"
```

---

## 🔑 SSH into EC2

Use the .pem file for SSH:
```bash
ssh -i "C:\Users\<YourUser>\.ssh\my-aws-keypair.pem" ec2-user@<public-ip>
```

- Replace <YourUser> with your Windows username

- Replace <public-ip> with Terraform output

---

## 🧹 Cleanup

To avoid extra AWS charges, destroy resources:
```bash
terraform destroy -auto-approve
```

