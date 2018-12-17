#!/usr/bin/env bash

LATEST_TAG=`git describe --abbrev=0`
echo "Pushing latest tag $LATEST_TAG"
git push origin $LATEST_TAG:$LATEST_TAG

git push
