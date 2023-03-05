#!/bin/bash

# https://github.com/chartmuseum/charts
# https://artifacthub.io/packages/helm/chartmuseum/chartmuseum

echo "Adding chartmuseum repo"

helm repo add chartmuseum https://chartmuseum.github.io/charts


read -p "Enter basic auth username: " BASIC_AUTH_USER
read -sp "Enter basic auth password: " BASIC_AUTH_PASS

echo "Installing chartmuseum ..."

helm install wlosiara-chartmuseum chartmuseum/chartmuseum --values ./values.yaml --set env.secret.BASIC_AUTH_USER=$BASIC_AUTH_USER --set env.secret.BASIC_AUTH_PASS=$BASIC_AUTH_PASS

echo "Checking rollout status ..."

helm status wlosiara-chartmuseum
