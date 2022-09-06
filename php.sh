!#/bin/bash

sudo apt install php

echo "Which port would you like to host on?"
read port

sudo php -S 0.0.0.0:$port
