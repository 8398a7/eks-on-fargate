#!/bin/bash -xeu

vpcId=$(aws ec2 describe-vpcs --region ${AWS_REGION} --filters "Name=tag:Name,Values=eksctl-${CLUSTER_NAME}-cluster/VPC" | jq -r '.Vpcs[].VpcId')
kubectl apply -f ./deployments/aws/rbac-role.yaml
vpcId=${vpcId} envsubst \
  '$AWS_REGION $ALB_AWS_ACCESS_KEY_ID $ALB_AWS_SECRET_ACCESS_KEY $CLUSTER_NAME $vpcId' < ./deployments/aws/alb-ingress-controller-for-env.yaml \
  | kubectl apply -f -
