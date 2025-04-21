#!/bin/sh
set -e
set -u

echo "**CONTAINER INIT**"

while read package; do
    echo "Installing $package"
    tlmgr install "$package" || echo "Failed to install $package" >&2
done < /package-list
echo "Done"

# Continue with the container's normal execution
echo "**CONTAINER START**"
/sbin/my_init
echo "Exit"
