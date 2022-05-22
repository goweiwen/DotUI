#!/bin/bash

cd ./third-party/picoarch

echo "$(git rev-parse --short HEAD) $(basename $PWD)" # $(git config --get remote.origin.url)

shopt -s dotglob

update() {
    for d in "$@"; do
        test -d "$d" -a \! -L "$d" || continue
        cd "$d"
        if [ -d ".git" ]; then
            echo "$(git rev-parse --short HEAD) $(basename $PWD)" # $(git config --get remote.origin.url)
        else
            update *
        fi
        cd ..
    done
}

update *

echo "-------"
echo "generated by $0"