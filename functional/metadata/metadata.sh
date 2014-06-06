#!/bin/sh

# requires resttest (https://github.com/lightblue-platform/pyresttest) and argparse module

LOGGING_LEVEL="debug"
export ENTITY_NAME="nmalik-$(date +'%Y%m%d%H%M%S')";
export ENTITY_VERSION_1="1.0.0";
export ENTITY_VERSION_2="2.0.0"

if [ "x$1" == "x" ]; then
    echo "Must specify base URL as first command line argument."
    exit 1
fi

if [ "x$2" != "x" ]; then
    LOGGING_LEVEL=$2
fi

echo "Running tests for new entity: $ENTITY_NAME"

python -c "import resttest; resttest.main('$1', 'metadata.yaml', '$LOGGING_LEVEL')" 2>&1

#unset ENTITY_NAME
#unset ENTITY_VERSION_1
#unset ENTITY_VERSION_2
