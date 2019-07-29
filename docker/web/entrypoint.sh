#!/bin/sh

bundle_install() {
  bundle check || bundle install --jobs 20 --retry 5
  bundle clean # remove any old binaries
}

is_ruby () {
  case $1 in
    ruby|rake|bundle|rails|rspec|cucumber) return 0;;
    *) return 1;;
  esac
}

if is_ruby "$1"; then
  echo "Alright. I am ensuring I am on the latest and stuffs. Yo!"
  bundle_install
elif [ "$2" = '/docker/command.sh' ]; then
  echo "Running the command. Yo!"
  bundle_install

  # ensure pid is removed
  rm tmp/pids/server.pid 2>/dev/null
fi

exec "$@"
