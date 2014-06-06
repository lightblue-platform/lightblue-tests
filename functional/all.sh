#!/bin/sh

pushd metadata
. ./metadata.sh $@
popd
pushd crud
./crud.sh $@
popd

