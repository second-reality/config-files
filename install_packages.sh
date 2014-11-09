#!/usr/bin/env bash

#set -euo pipefail

script_dir=$(dirname $(readlink -f $0))
cd $script_dir

sudo apt update
to_ignore=$(cat ./dpkg.list | xargs sudo apt install -y |& grep 'Unable to locate' | sed -e 's/.*Unable to locate package //g')
filter=
for i in $to_ignore; do
  filter="$filter -e $i"
done

if [ "$filter" != "" ]; then
  filter="grep -v $filter"
fi

cat ./dpkg.list | $filter | xargs sudo apt install -y
echo "#####ignored: $filter"
