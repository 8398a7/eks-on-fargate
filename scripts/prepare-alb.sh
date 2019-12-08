#!/bin/bash -xeu

curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/v1.1.4/docs/examples/iam-policy.json
policyArn=$(aws iam create-policy \
  --policy-name ALBIngressControllerIAMPolicy \
  --policy-document file://iam-policy.json | jq -r .Policy.Arn)
rm iam-policy.json

eksctl utils associate-iam-oidc-provider --region=${AWS_REGION} --cluster=${CLUSTER_NAME} --approve
eksctl create iamserviceaccount --name alb-ingress-controller \
  --namespace kube-system \
  --cluster ${CLUSTER_NAME} \
  --attach-policy-arn ${policyArn} \
  --approve --override-existing-serviceaccounts
