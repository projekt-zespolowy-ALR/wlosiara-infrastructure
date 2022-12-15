#!/bin/bash

minikube start
minikube ip
minikube addons enable ingress
kubectl get pods -n ingress-nginx
