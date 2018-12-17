#!/usr/bin/env bash

git rebase -i --exec 'arc diff --allow-untracked --reviewers #plesk_extension -C HEAD HEAD^' $1
