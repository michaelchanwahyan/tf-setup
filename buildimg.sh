#!/bin/sh
docker build -t tf_workspace:latest ./
docker rmi   -f $(docker images -f "dangling=true" -q)
