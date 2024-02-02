#!/bin/bash


package_name="php"


if dpkg -s "$package_name" &> /dev/null; then
    echo "Installed"
else
    echo "Installing $package_name"
    sudo apt update
    sudo apt-get install -y "$package_name"
    if [ $? -eq 0 ]; then
        echo "Installation of $package_name successful."
    else
        echo "Failed to install $package_name. Please check your internet co>
        exit 1
    fi
fi


sudo php -S 0.0.0.0:80
