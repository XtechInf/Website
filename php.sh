#!/bin/bash

package_name="php"

if dpkg -s "$package_name" &> /dev/null; then
    echo "PHP is installed."
else
    echo "Installing $package_name"
    sudo apt update
    sudo apt-get install -y "$package_name"
    if [ $? -eq 0 ]; then
        echo "Installation of $package_name successful."
    else
        echo "Failed to install $package_name. Please check your internet connection."
        exit 1
    fi
fi


sudo php -S 0.0.0.0:80 &
PHP_SERVER_PID=$!
echo "$PHP_SERVER_PID"

sleep 2

if ps -p $PHP_SERVER_PID > /dev/null; then
    echo "PHP server (PID: $PHP_SERVER_PID) started successfully."
else
    echo "Failed to start PHP server. Check for errors."
    exit 1
fi


ssh -R 80:127.0.0.1:80 localhost.run
if [ $? -eq 0 ]; then
    echo "SSH tunnel established successfully."
else
    echo "Failed to establish SSH tunnel. Check for errors."
    exit 1
fi

read -p "Stop the website? (Y/N): " user_response

# Check the user's response
if [ "$user_response" == "Y" ] || [ "$user_response" == "y" ]; then
    echo "Stopping the website..."
    kill -9 $PHP_SERVER_PID
else
    echo "Continuing with the script as the user chose not to stop the website."
fi
