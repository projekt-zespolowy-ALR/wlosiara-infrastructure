#!/bin/bash

minikube start --disk-size='5000mb' --cpus=3 --memory='3096mb' --driver='virtualbox'
minikube ip
minikube addons enable ingress
kubectl get pods -n ingress-nginx
