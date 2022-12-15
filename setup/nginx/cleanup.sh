#!/bin/bash

WLOSIARA_PL_CONFIG_FILENAME="wlosiara.pl.conf"

echo "Trying to remove symlink to /etc/nginx/sites-available/$WLOSIARA_PL_CONFIG_FILENAME ..."
rm /etc/nginx/sites-enabled/$WLOSIARA_PL_CONFIG_FILENAME
if [ $? -ne 0 ]; then
	echo "Symlink does not exist"
else
	echo "Symlink removed"
fi

echo "Trying to remove configuration file ..."
rm /etc/nginx/sites-available/$WLOSIARA_PL_CONFIG_FILENAME
if [ $? -ne 0 ]; then
	echo "Configuration file does not exist"
else
	echo "Configuration file removed"
fi

echo "Testing nginx configuration ..."
nginx -t
if [ $? -ne 0 ]; then
	echo "Nginx configuration test failed"
	echo "Exiting ..."
	exit 1
fi
echo "Testing done"

echo "Reloading nginx ..."
nginx -s reload
if [ $? -ne 0 ]; then
	echo "Reloading failed"
	echo "Exiting ..."
	exit 1
fi
echo "Reloading done"
