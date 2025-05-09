#!/bin/sh
clear
docker rm -f tf_workspace
mkdir -p ~/SOURCE/tf-app
docker run -dt \
           -p 6006:6006 \
           -v ~/SOURCE/tf-app:/app \
           --name=tf_workspace \
           --memory=4g \
           tf_workspace:latest \
           /usr/bin/bash
