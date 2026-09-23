# DevOps / SRE Portfolio Lab

A hands-on portfolio demonstrating production-oriented DevOps and SRE practices using Go, Docker, Kubernetes, GitOps, Terraform and AWS.

## Use cases covered

- **DevOps / SRE:** incident-response runbook, operational triage automation and reliability-focused Kubernetes configuration.
- **Kubernetes & Linux:** containerized Go workload with probes, resource controls and a reusable kubectl triage script. The Kubernetes patterns are portable to EKS and on-prem distributions such as SUSE Rancher/RKE2.
- **GitOps & CI/CD:** GitLab CI example, Argo CD application and container-registry workflow. Replace the sample registry with GitLab Registry or Harbor as required.
- **Observability:** Prometheus/Grafana metrics guidance plus structured logging and OpenTelemetry tracing patterns.
- **Infrastructure & Networking:** dynamic AWS VPC/subnet layout with separate public, EKS and database tiers, IAM roles, security groups, EKS and RDS.
- **Automation:** Bash operational automation plus the existing Go application.

## Repository layout

```text
.
├── Bastion-Ec2/                  # Existing Terraform bastion example
├── go-time-api/                  # Existing Go + Docker application
├── terraform/aws-platform/       # VPC + dynamic subnets + EKS + RDS
├── k8s/go-time-api/              # Kubernetes deployment/service
├── gitops/argocd/                # Argo CD application
├── observability/                # Metrics/logs/traces/SLO guidance
├── runbooks/                     # Incident response
├── scripts/                      # Operational automation
└── .gitlab-ci.yml                # CI/CD example
```

## Terraform AWS deployment

The Terraform example creates a VPC with dynamically generated subnet tiers, an EKS cluster/node group and a private PostgreSQL RDS instance.

```bash
cd terraform/aws-platform
terraform init
terraform fmt -check
terraform validate

export TF_VAR_db_password='use-a-secure-secret'
terraform plan
terraform apply
```

For production, use a remote encrypted Terraform backend, locking, private EKS API access where possible, NAT/VPC endpoints for private workloads, least-privilege IAM and AWS Secrets Manager rather than plaintext credentials.

## Kubernetes deployment

```bash
kubectl apply -f k8s/go-time-api/deployment.yaml
kubectl get pods
```

The sample image reference is intentionally generic. Point it to GitLab Container Registry, Harbor, ECR, or another approved registry.

## GitOps with Argo CD

The Argo CD Application watches `k8s/go-time-api` and automatically reconciles drift, prunes deleted resources and self-heals configuration.

```bash
kubectl apply -f gitops/argocd/go-time-api.yaml
argocd app get go-time-api
```

A production setup should use environment-specific Git branches/directories or a dedicated environment repository, protected changes and secret integration such as External Secrets/Vault.

## SRE incident workflow

Remember the operational flow as:

**Detect -> Triage -> Mitigate -> Recover -> Learn**

See `runbooks/incident-response.md` for the full checklist. Run `scripts/k8s-triage.sh <namespace>` to gather first-line Kubernetes evidence during an incident.

## Observability

The recommended stack is:

**Prometheus -> Grafana -> Alerting** for metrics  
**Fluent Bit -> Loki/OpenSearch** for logs  
**OpenTelemetry -> Tempo/Jaeger** for traces

Start with service-level symptoms such as availability, error rate and latency rather than alerting only on infrastructure utilization.

## Security notes

- Never commit Terraform state, secrets, kubeconfigs, private keys or real `.tfvars` files.
- Use IAM roles/workload identity instead of long-lived AWS keys.
- Keep RDS private and restrict security-group ingress.
- Scan container images in CI before deployment.
- Protect the Git branch used by Argo CD.

> Note: an older `Bastion-Ec2/terraform.tfstate` file already exists in repository history. The new `.gitignore` prevents new state files from being added, but sensitive historical state should be reviewed and removed/rotated if it ever contained credentials or secrets.
