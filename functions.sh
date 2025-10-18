# Check if a Kubernetes resource exists (works for both namespaced and cluster-scoped)
# Usage:
#   k8s_resource_exists <resource_type> <resource_name> [namespace]
# Example:
#   k8s_resource_exists secret deploywizard-in-tls traefik
#   k8s_resource_exists node kind-control-plane
#   k8s_resource_exists namespace my-namespace
k8s_resource_exists() {
  local resource_type="$1"
  local resource_name="$2"
  local namespace="$3"

  # Determine whether to include namespace
  if [[ -n "$namespace" ]]; then
    # Namespaced resource
    kubectl get "$resource_type" "$resource_name" -n "$namespace" >/dev/null 2>&1
  else
    # Cluster-wide resource
    kubectl get "$resource_type" "$resource_name" >/dev/null 2>&1
  fi

  # Check exit status
  if [[ $? -eq 0 ]]; then
    return 0
  else
    return 1
  fi
}
