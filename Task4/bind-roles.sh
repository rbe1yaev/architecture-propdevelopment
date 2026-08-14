#!/usr/bin/env bash
#
# Связывание пользователей (ServiceAccounts) с ролями для RBAC PropDevelopment
#

set -e

# ----------------------------------------------------------------------
# ClusterRoleBinding: cluster-admin-propdevelopment → security-admin
# ----------------------------------------------------------------------
kubectl apply -f - <<'EOF'
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: cluster-admin-binding
subjects:
- kind: ServiceAccount
  name: security-admin
  namespace: kube-system
roleRef:
  kind: ClusterRole
  name: cluster-admin-propdevelopment
  apiGroup: rbac.authorization.k8s.io
EOF

# ----------------------------------------------------------------------
# ClusterRoleBinding: devops-engineer → devops-engineer
# ----------------------------------------------------------------------
kubectl apply -f - <<'EOF'
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: devops-engineer-binding
subjects:
- kind: ServiceAccount
  name: devops-engineer
  namespace: kube-system
roleRef:
  kind: ClusterRole
  name: devops-engineer
  apiGroup: rbac.authorization.k8s.io
EOF

# ----------------------------------------------------------------------
# ClusterRoleBinding: developer-readonly → developer
# ----------------------------------------------------------------------
kubectl apply -f - <<'EOF'
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: developer-readonly-binding
subjects:
- kind: ServiceAccount
  name: developer
  namespace: kube-system
roleRef:
  kind: ClusterRole
  name: developer-readonly
  apiGroup: rbac.authorization.k8s.io
EOF

# ----------------------------------------------------------------------
# RoleBinding: domain-sales-admin → sales-admin (ns: sales)
# ----------------------------------------------------------------------
kubectl apply -f - <<'EOF'
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: domain-sales-admin-binding
  namespace: sales
subjects:
- kind: ServiceAccount
  name: sales-admin
  namespace: sales
roleRef:
  kind: Role
  name: domain-sales-admin
  apiGroup: rbac.authorization.k8s.io
EOF

# ----------------------------------------------------------------------
# RoleBinding: domain-zhku-admin → zhku-admin (ns: zhku)
# ----------------------------------------------------------------------
kubectl apply -f - <<'EOF'
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: domain-zhku-admin-binding
  namespace: zhku
subjects:
- kind: ServiceAccount
  name: zhku-admin
  namespace: zhku
roleRef:
  kind: Role
  name: domain-zhku-admin
  apiGroup: rbac.authorization.k8s.io
EOF

echo "Созданы привязки: cluster-admin-binding, devops-engineer-binding, developer-readonly-binding, domain-sales-admin-binding, domain-zhku-admin-binding"
