#!/bin/bash

TF_DIR="/home/revanth/src/dineMaster/aws-free-tier-ec2"
KEY_FILE="$HOME/.ssh/my_tf_key"
USER="ec2-user"

IP=$(terraform -chdir="$TF_DIR" output -raw instance_public_ip)

echo "Connecting to $IP ..."
ssh -i "$KEY_FILE" -o StrictHostKeyChecking=no $USER@$IP
