#!/bin/bash

minikube start --disk-size='5000mb' --cpus=2 --memory='3096mb'
minikube ip
minikube addons enable ingress
kubectl get pods -n ingress-nginx
