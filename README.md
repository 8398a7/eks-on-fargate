# EKS on Fargate PoC

refs: https://839.hateblo.jp/

## Requirements

- aws-cli
- eksctl
- kubectl
- jq
- envsubst

## Try

```bash
cp .envrc.tmpl .envrc
```

Set `AWS_PROFILE` of .envrc.

```bash
# - Creating an EKS Cluster
# - Preparing to pass IAM permissions to the alb-ingress-controller pod
# - Deploy alb-ingress-controller
# - Deploy nginx app
make setup-cluster prepare-alb deploy-alb deploy-app
# wait until alb-ingress-controller pod is running
watch kubectl get po -n kube-system
# wait until ALB is made
kubectl logs -n kube-system $(kubectl get po -n kube-system -o name | grep alb | cut -d/ -f2) -f
# wait until the target group is healthy in the aws console
open http://$(kubectl get ing -o jsonpath='{.items[].status.loadBalancer.ingress[].hostname}')
```

## Cleanup

```bash
# - Deleting ALB resources
# - Deleting nginx app resources
# - Deleting EKS Cluster
# - Deleting ALB Policy
make cleanup
```
