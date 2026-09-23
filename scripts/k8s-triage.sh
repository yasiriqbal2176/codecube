#!/usr/bin/env bash
set -euo pipefail

NAMESPACE="${1:-default}"

echo "== Context =="
kubectl config current-context

echo "== Workloads =="
kubectl get deploy,sts,ds,pods -n "$NAMESPACE" -o wide

echo "== Recent events =="
kubectl get events -n "$NAMESPACE" --sort-by=.lastTimestamp | tail -n 30

echo "== Non-ready pods =="
kubectl get pods -n "$NAMESPACE" --no-headers | awk '$2 !~ /^[0-9]+\/\1$/ || $3 != "Running" {print}'

echo "== Resource usage (metrics-server required) =="
kubectl top pods -n "$NAMESPACE" 2>/dev/null || true
