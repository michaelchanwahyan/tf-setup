#!/bin/sh
clear
docker rm -f tf_workspace
mkdir -p ~/SOURCE/tf-app
docker rm -f tf_workspace
docker run -dt \
           -v ~/SOURCE/tf-app:/app \
           --name=tf_workspace \
           --memory=4g \
           tf_workspace:latest \
           /usr/bin/bash
