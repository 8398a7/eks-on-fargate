#!/bin/bash -xeu

curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/v1.1.4/docs/examples/iam-policy.json
policyArn=$(aws iam create-policy \
  --policy-name ALBIngressControllerIAMPolicy \
  --policy-document file://iam-policy.json | jq -r .Policy.Arn)
rm iam-policy.json

aws iam create-user --user-name pocUser
aws iam attach-user-policy --user-name pocUser --policy-arn ${policyArn}
aws iam create-access-key --user-name pocUser
