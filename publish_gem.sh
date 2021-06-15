#!/bin/bash

GEM_PATH=$1
gem push --key github --host https://rubygems.pkg.github.com/lonnyantunes $GEM_PATH

# More informations :
# https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-rubygems-registry