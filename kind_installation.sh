#!/bin/bash
# Remove any existing kind binary
sudo rm -f /usr/local/bin/kind

# Download kind for Linux x86_64 (AMD64)
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.33.0/kind-linux-amd64

# Make it executable
chmod +x ./kind

# Install system-wide
sudo mv ./kind /usr/local/bin/kind

# Verify installation
kind version

# K8s Cluster creation
kind create cluster --name k8s-cluster 

# set current context to kind-k8s-cluster
kubectl cluster-info --context kind-k8s-cluster 