# Observability use case

This folder documents the production signals expected for the Kubernetes workload.

## Metrics

Use Prometheus to collect:
- request rate
- HTTP error rate
- request latency (p50/p95/p99)
- pod CPU and memory
- restart count
- Kubernetes deployment availability

## Dashboards

Grafana dashboards should show the four golden signals:
1. latency
2. traffic
3. errors
4. saturation

## Logs

Ship structured container logs with Fluent Bit or an equivalent collector to Loki/OpenSearch. Include fields such as timestamp, service, environment, request_id and severity.

## Traces

Instrument services with OpenTelemetry and export traces to a compatible backend such as Tempo or Jaeger. Propagate trace IDs into logs for correlation.

## Alerting examples

Alert on symptoms first:
- sustained 5xx error rate
- p95 latency above SLO
- unavailable replicas
- CrashLoopBackOff / repeated restarts
- node or filesystem pressure

Route alerts to the incident channel/on-call system and attach a runbook link.
