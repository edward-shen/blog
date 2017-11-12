#!/bin/zsh
git push origin `git subtree split --prefix _site master`:gh-pages --force
