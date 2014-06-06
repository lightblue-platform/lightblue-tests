#!/bin/sh

# requires resttest (https://github.com/lightblue-platform/pyresttest) and argparse module

LOGGING_LEVEL="debug"

# BIG HACK, expect metadata.sh to be run first and for it NOT to unset env variables..
export ENTITY_VERSION="${ENTITY_VERSION_2}"

if [ "x$1" == "x" ]; then
    echo "Must specify base URL as first command line argument."
    exit 1
fi

if [ "x$2" != "x" ]; then
    LOGGING_LEVEL=$2
fi

echo "Running tests for entity: $ENTITY_NAME"

python -c "import resttest; resttest.main('$1', 'crud.yaml', '$LOGGING_LEVEL')" 2>&1 | tee crud.log

#unset ENTITY_NAME
#unset ENTITY_VERSION
