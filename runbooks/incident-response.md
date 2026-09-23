# Production Incident Response Runbook

## 1. Detect and acknowledge

Confirm the alert, capture the start time, affected service/environment and current customer impact.

## 2. Triage

Check:
- Argo CD sync/health
- Kubernetes deployment, pods and recent events
- Prometheus/Grafana error, latency and saturation signals
- application logs and trace samples
- recent CI/CD or infrastructure changes
- DNS, load balancer, network policy, security group and secret dependencies

## 3. Mitigate

Prefer the lowest-risk recovery action:
- roll back the last deployment
- pause automated sync if Git is pushing a bad state
- scale a constrained workload
- fail over/restart only when evidence supports it

Record every action and timestamp.

## 4. Recover and validate

Confirm health checks, error rate and latency have returned to normal. Validate both technical recovery and user-facing behavior.

## 5. Follow up

Create a blameless incident review with:
- timeline
- root cause and contributing factors
- detection gaps
- corrective actions
- automation opportunities that reduce operational toil
