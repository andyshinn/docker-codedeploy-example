#!/usr/bin/env bash

set -e

docker run -d --name middleman -p 8000:8000 middleman
