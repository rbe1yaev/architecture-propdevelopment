#!/usr/bin/env bash
#
# Создание пользователей (ServiceAccounts) для ролевой модели RBAC PropDevelopment
#

set -e

# Неймспейсы доменов
kubectl create namespace sales --dry-run=client -o yaml | kubectl apply -f -
kubectl create namespace zhku --dry-run=client -o yaml | kubectl apply -f -

# Cluster-wide ServiceAccounts
kubectl create serviceaccount security-admin -n kube-system --dry-run=client -o yaml | kubectl apply -f -
kubectl create serviceaccount devops-engineer -n kube-system --dry-run=client -o yaml | kubectl apply -f -
kubectl create serviceaccount developer -n kube-system --dry-run=client -o yaml | kubectl apply -f -

# Domain-scoped ServiceAccounts
kubectl create serviceaccount sales-admin -n sales --dry-run=client -o yaml | kubectl apply -f -
kubectl create serviceaccount zhku-admin -n zhku --dry-run=client -o yaml | kubectl apply -f -

echo "Созданы ServiceAccounts: security-admin, devops-engineer, developer, sales-admin, zhku-admin"
