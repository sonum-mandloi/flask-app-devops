#!/bin/bash

set -e

# Variables
CLUSTER_NAME="flask-eks-cluster"
REGION="ap-southeast-2"
NODEGROUP_NAME="worker-nodes"
NODE_TYPE="t3.medium"
NODE_COUNT=2

echo "Checking if EKS cluster '$CLUSTER_NAME' exists..."

if aws eks describe-cluster \
    --name "$CLUSTER_NAME" \
    --region "$REGION" >/dev/null 2>&1; then

    echo "========================================"
    echo "EKS Cluster '$CLUSTER_NAME' already exists."
    echo "Skipping cluster creation."
    echo "========================================"

else

    echo "========================================"
    echo "EKS Cluster not found."
    echo "Creating cluster..."
    echo "========================================"

    eksctl create cluster \
      --name "$CLUSTER_NAME" \
      --region "$REGION" \
      --nodegroup-name "$NODEGROUP_NAME" \
      --node-type "$NODE_TYPE" \
      --nodes "$NODE_COUNT" \
      --nodes-min 2 \
      --nodes-max 3 \
      --managed

    echo "========================================"
    echo "Cluster created successfully."
    echo "========================================"

fi

# Update kubeconfig
aws eks update-kubeconfig \
  --name "$CLUSTER_NAME" \
  --region "$REGION"

# # Verify cluster
# kubectl get nodes