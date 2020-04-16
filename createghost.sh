#!/bin/bash
if ! [ -n "$BASH_VERSION" ];then
    echo "this is not bash, calling self with bash....";
        SCRIPT=$(readlink -f "$0")
    /bin/bash $SCRIPT
        exit;
fi

# Pull down the ghost image
docker pull ghost:latest

# Set vars
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
DATA_DIR="$HOME/blogs/bobbymac/ghost_volume";
CONTAINER_NAME="ghost_bobbymac"

# Create volume area to store state and create base config there
mkdir -p $DATA_DIR

echo '{
 "url": "http://www.bobbymac.rocks",
   "server": {
       "port": 2368,
    "host": "0.0.0.0"
      },
      "database": {
    "client": "sqlite3",
       "connection": {
      "filename": "/var/lib/ghost/content/data/ghost.db"
          }
    },
     "logging": {
         "transports": [
        "file",
     "stdout"
          ]
    },
      "process": "systemd",
        "paths": {
    "contentPath": "/var/lib/ghost/content"
     }
      }' > $DATA_DIR/config.json
