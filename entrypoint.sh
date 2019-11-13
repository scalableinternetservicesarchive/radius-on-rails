#!/bin/bash
set -e

# Remove any pre-existing server.pid for Rails.
rm -f /radius-on-rails/tmp/pids/server.pid

yarn install

# Then exec the container
exec "$@"