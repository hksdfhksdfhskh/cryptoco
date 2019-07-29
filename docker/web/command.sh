#!/bin/sh

echo "Running the server..."
exec bundle exec rails server -b 0.0.0.0
