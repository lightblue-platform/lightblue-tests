#!/bin/sh

pushd metadata > /dev/null
. ./metadata.sh $@ || exit $?
popd > /dev/null
pushd crud > /dev/null
./crud.sh $@ || exit $?
popd > /dev/null

