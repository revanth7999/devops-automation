# 🛠️ AWS EC2 Provisioning & Deployment with Terraform + Ansible

This project automates the creation of an AWS EC2 instance using **Terraform** and then configures the instance using **Ansible** to install Docker and deploy the backend + MySQL containers.

---

## 📌 Project Structure

ansible-deployment

│── inventory/ # Dynamic inventory generated after Terraform apply

│── playbook.yml # Main Ansible playbook (installs Docker, runs containers)

│── roles/ # Future Ansible roles (optional)

│── scripts/

│ └── run.sh # Automation script (Terraform apply → Ansible run)

│── README.md # Project documentation


## 🚀 Workflow Overview

1. ✅ Terraform creates EC2 instance  
2. ✅ Terraform outputs public IP  
3. ✅ Ansible reads IP and connects via SSH  
4. ✅ Installs Docker & (optional) Docker Compose  
5. ✅ Pulls backend + MySQL Docker images  
6. ✅ Starts containers

---

## ⚙️ Requirements

| Tool | Version |
|-------|---------|
| Terraform | ≥ 1.3 |
| Ansible   | ≥ 2.14 |
| AWS CLI   | Configured with credentials |
| SSH key   | Same key used in Terraform |

---

## 🔧 How to Run

### 1️⃣ Navigate to Terraform directory and apply infra

```bash
cd /home/revanth/aws-free-tier-ec2
terraform init
terraform apply -auto-approve
```

#### This will output:
```bash
instance_public_ip = "X.X.X.X"
```

### 2️⃣ Back to Ansible project
```bash 
cd /path/to/ansible-deployment
```

### 3️⃣ Run the automation script
```bash
bash scripts/run.sh
```

- ✔ Reads Terraform output
- ✔ Updates Ansible inventory
- ✔ SSH into EC2 and runs playbook

## 🐳 What Ansible Installs

- ✅ Docker
- ✅ Adds ec2-user to docker group
- ✅ Pulls images:
    - Backend: your-dockerhub-backend-image
    - MySQL: mysql:8.0 (optional)

- ✅ Runs containers
- ✅ Exposes backend on port 8080

## 🔐 SSH Key Requirement
Make sure the same SSH key used in Terraform is available locally:

```bash
~/.ssh/my_tf_key   (private key)
~/.ssh/my_tf_key.pub (public key)
```

SSH login example:
```bash
ssh -i ~/.ssh/my_tf_key ec2-user@<public-ip>
```

## 🧹 Destroy Everything
To delete the EC2 instance:
```bash
cd /home/revanth/aws-free-tier-ec2
terraform destroy -auto-approve
```

## 📌 Notes to me

- I must stay inside AWS Free Tier limits (750 hours/month, 30GB EBS, etc.)
- Backend image already contains Java — no JDK install is needed on EC2
- If you want Docker Compose instead of single container deployment, update playbook.yml
