#!/bin/bash -xeu

vpcId=$(aws ec2 describe-vpcs --region ${AWS_REGION} --filters "Name=tag:Name,Values=eksctl-${CLUSTER_NAME}-cluster/VPC" | jq -r '.Vpcs[].VpcId')
kubectl apply -f ./deployments/aws/rbac-role.yaml
vpcId=${vpcId} envsubst \
  '$AWS_REGION $CLUSTER_NAME $vpcId' < ./deployments/aws/alb-ingress-controller.yaml \
  | kubectl apply -f -
