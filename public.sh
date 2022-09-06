#!/bin/bash

echo "What do you want the subdomain to be?"
read subdomain

lt -s $subdomain -p 80
