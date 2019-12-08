prepare-eksctl:
	brew tap weaveworks/tap
	brew install weaveworks/tap/eksctl
setup-cluster:
	eksctl create cluster ${CLUSTER_NAME} --fargate
delete-cluster:
	eksctl delete cluster ${CLUSTER_NAME}
prepare-alb-for-env:
	./scripts/prepare-alb-for-env.sh
prepare-alb:
	./scripts/prepare-alb.sh
deploy-alb-for-env:
	./scripts/deploy-alb-for-env.sh
deploy-alb:
	./scripts/deploy-alb.sh
undeploy-alb:
	kubectl delete -f ./deployments/aws/rbac-role.yaml
	kubectl delete -f ./deployments/aws/alb-ingress-controller.yaml
deploy-app:
	kubectl apply -f ./deployments/app.yaml
undeploy-app:
	kubectl delete -f ./deployments/app.yaml
cleanup:
	$(MAKE) undeploy-app undeploy-alb delete-cluster
	./scripts/cleanup.sh
