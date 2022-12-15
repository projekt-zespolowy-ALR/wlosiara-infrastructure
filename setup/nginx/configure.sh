#!/bin/bash

WLOSIARA_PL_CONFIG_FILENAME="wlosiara.pl.conf"
SCRIPT_DIR=$( dirname -- "$0"; )
if [ -z "$WLOSIARA_PL_MINIKUBE_CLUSTER_IP" ]; then
	echo "WLOSIARA_PL_MINIKUBE_CLUSTER_IP is not set"
	exit 1
fi
if ! [[ $WLOSIARA_PL_MINIKUBE_CLUSTER_IP =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
	echo "WLOSIARA_PL_MINIKUBE_CLUSTER_IP is not valid IP address"
	exit 1
fi


echo "Copying $WLOSIARA_PL_CONFIG_FILENAME to /etc/nginx/sites-available/$WLOSIARA_PL_CONFIG_FILENAME ..."
cat $SCRIPT_DIR/configs/$WLOSIARA_PL_CONFIG_FILENAME | sed 's/$WLOSIARA_PL_MINIKUBE_CLUSTER_IP/'$WLOSIARA_PL_MINIKUBE_CLUSTER_IP'/g' > /etc/nginx/sites-available/$WLOSIARA_PL_CONFIG_FILENAME
if [ $? -ne 0 ]; then
	echo "Copying failed"
	echo "Running cleanup ..."
	bash $SCRIPT_DIR/cleanup.sh
	exit 1
fi
echo "Copying done"
echo "Creating symlink to /etc/nginx/sites-available/$WLOSIARA_PL_CONFIG_FILENAME ..."
ln --target-directory=/etc/nginx/sites-enabled /etc/nginx/sites-available/$WLOSIARA_PL_CONFIG_FILENAME
if [ $? -ne 0 ]; then
	echo "Creating symlink failed"
	echo "Running cleanup ..."
	bash $SCRIPT_DIR/cleanup.sh
	exit 1
fi
echo "Symlink created"

echo "Testing nginx configuration ..."
nginx -t
if [ $? -ne 0 ]; then
	echo "Nginx configuration test failed"
	echo "Running cleanup ..."
	bash $SCRIPT_DIR/cleanup.sh
	exit 1
fi
echo "Testing done"

echo "Reloading nginx ..."
nginx -s reload
if [ $? -ne 0 ]; then
	echo "Reloading failed"
	echo "Running cleanup ..."
	bash $SCRIPT_DIR/cleanup.sh
	exit 1
fi
echo "Reloading done"
