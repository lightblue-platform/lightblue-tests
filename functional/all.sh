#!/bin/sh

pushd metadata > /dev/null
. ./metadata.sh $@
popd > /dev/null
pushd crud > /dev/null
./crud.sh $@
popd > /dev/null

