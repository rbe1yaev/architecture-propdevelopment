#!/usr/bin/env bash
#
# Создание ролей (Roles и ClusterRoles) для ролевой модели RBAC PropDevelopment
#

set -e

# ----------------------------------------------------------------------
# ClusterRole: cluster-admin (привилегированная — полный доступ к secrets)
# ----------------------------------------------------------------------
kubectl apply -f - <<'EOF'
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: cluster-admin-propdevelopment
rules:
- apiGroups: ["*"]
  resources: ["*"]
  verbs: ["*"]
EOF

# ----------------------------------------------------------------------
# ClusterRole: devops-engineer (настройка кластера без secrets)
# ----------------------------------------------------------------------
kubectl apply -f - <<'EOF'
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: devops-engineer
rules:
- apiGroups: [""]
  resources: ["pods", "pods/log", "pods/exec", "services", "endpoints", "configmaps", "persistentvolumeclaims"]
  verbs: ["create", "update", "patch", "delete", "get", "list", "watch"]
- apiGroups: ["apps"]
  resources: ["deployments", "replicasets", "daemonsets", "statefulsets"]
  verbs: ["create", "update", "patch", "delete", "get", "list", "watch"]
- apiGroups: ["networking.k8s.io"]
  resources: ["ingresses"]
  verbs: ["create", "update", "patch", "delete", "get", "list", "watch"]
- apiGroups: ["batch"]
  resources: ["jobs", "cronjobs"]
  verbs: ["create", "update", "patch", "delete", "get", "list", "watch"]
- apiGroups: [""]
  resources: ["events"]
  verbs: ["get", "list", "watch"]
- apiGroups: [""]
  resources: ["namespaces"]
  verbs: ["get", "list", "watch"]
EOF

# ----------------------------------------------------------------------
# ClusterRole: developer-readonly (только чтение)
# ----------------------------------------------------------------------
kubectl apply -f - <<'EOF'
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: developer-readonly
rules:
- apiGroups: [""]
  resources: ["pods", "pods/log", "services", "endpoints", "configmaps", "persistentvolumeclaims"]
  verbs: ["get", "list", "watch"]
- apiGroups: ["apps"]
  resources: ["deployments", "replicasets", "daemonsets", "statefulsets"]
  verbs: ["get", "list", "watch"]
- apiGroups: ["networking.k8s.io"]
  resources: ["ingresses"]
  verbs: ["get", "list", "watch"]
- apiGroups: ["batch"]
  resources: ["jobs", "cronjobs"]
  verbs: ["get", "list", "watch"]
- apiGroups: [""]
  resources: ["events", "namespaces"]
  verbs: ["get", "list", "watch"]
EOF

# ----------------------------------------------------------------------
# Role: domain-sales-admin (управление в ns sales)
# ----------------------------------------------------------------------
kubectl apply -f - <<'EOF'
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: domain-sales-admin
  namespace: sales
rules:
- apiGroups: [""]
  resources: ["pods", "pods/log", "pods/exec", "services", "endpoints", "configmaps", "secrets", "persistentvolumeclaims"]
  verbs: ["*"]
- apiGroups: ["apps"]
  resources: ["deployments", "replicasets", "daemonsets", "statefulsets"]
  verbs: ["*"]
- apiGroups: ["networking.k8s.io"]
  resources: ["ingresses"]
  verbs: ["*"]
- apiGroups: ["batch"]
  resources: ["jobs", "cronjobs"]
  verbs: ["*"]
- apiGroups: [""]
  resources: ["events"]
  verbs: ["get", "list", "watch"]
EOF

# ----------------------------------------------------------------------
# Role: domain-zhku-admin (управление в ns zhku)
# ----------------------------------------------------------------------
kubectl apply -f - <<'EOF'
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: domain-zhku-admin
  namespace: zhku
rules:
- apiGroups: [""]
  resources: ["pods", "pods/log", "pods/exec", "services", "endpoints", "configmaps", "secrets", "persistentvolumeclaims"]
  verbs: ["*"]
- apiGroups: ["apps"]
  resources: ["deployments", "replicasets", "daemonsets", "statefulsets"]
  verbs: ["*"]
- apiGroups: ["networking.k8s.io"]
  resources: ["ingresses"]
  verbs: ["*"]
- apiGroups: ["batch"]
  resources: ["jobs", "cronjobs"]
  verbs: ["*"]
- apiGroups: [""]
  resources: ["events"]
  verbs: ["get", "list", "watch"]
EOF

echo "Созданы роли: cluster-admin-propdevelopment, devops-engineer, developer-readonly, domain-sales-admin, domain-zhku-admin"
