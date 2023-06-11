#!/bin/bash

if [ -z "$KUBERNETES_CLUSTER_API_BASE_URL" ]; then
	echo "KUBERNETES_CLUSTER_API_BASE_URL is not set"
	exit 1
fi
SCRIPT_DIR=$( dirname -- "$0"; )
echo "Applying Kubernetes configuration ..."
kubectl apply -f $SCRIPT_DIR/github-actions-runner/
echo "Applying done"


GITHUB_ACTIONS_RUNNER_TOKEN=$( kubectl get secret/github-actions-runner -o jsonpath={.data.token} )
KUBECONFIG=$(cat $SCRIPT_DIR/templates/kubeconfig.yaml | sed 's~$KUBERNETES_CLUSTER_API_BASE_URL~'$KUBERNETES_CLUSTER_API_BASE_URL'~g' | sed 's~$GITHUB_ACTIONS_RUNNER_TOKEN~'$GITHUB_ACTIONS_RUNNER_TOKEN'~g')
if [ $? -ne 0 ]; then
	echo "Creating kubeconfig failed"
	echo "Running cleanup ..."
	bash $SCRIPT_DIR/cleanup.sh
	exit 1
fi
echo "Here's your KUBECONFIG for GitHub Actions Runner:"
echo "$KUBECONFIG"
