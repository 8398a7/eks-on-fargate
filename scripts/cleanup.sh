#!/bin/bash -xeu

userId=$(aws sts get-caller-identity | jq -r .UserId)
aws iam delete-policy --policy-arn arn:aws:iam::${userId}:policy/ALBIngressControllerIAMPolicy
