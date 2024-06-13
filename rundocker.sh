#!/bin/sh
clear
docker rm -f tf_workspace
docker run -dt \
           --name=tf_workspace \
           --memory=4g \
           tf_workspace:latest \
           /usr/bin/bash
