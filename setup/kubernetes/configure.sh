#!/bin/bash

SCRIPT_DIR=$( dirname -- "$0"; )
kubectl apply -f $SCRIPT_DIR/github-actions-runner/
