#!/usr/bin/env bash

# echo "Removing unused containers"
# docker rm $(docker ps -a -q)

# echo "Removing unused images"
# docker rmi $(docker images | grep "^<none>" | awk '{print $3}' ORS=' ')
docker system prune -f
