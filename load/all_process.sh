#!/bin/sh

# requires resttest (https://github.com/lightblue-platform/pyresttest) and argparse module

if [ "x$1" == "x" ]; then
    echo "Must specify base URL for data as first command line argument."
    exit 1
fi

if [ "x$2" == "x" ]; then
    echo "Must specify base URL for metadata as second command line argument."
    exit 1
fi

# Global:
INTERACTIVE="False"
LOGGING_LEVEL="debug"
if [ "x$3" != "x" ]; then
    LOGGING_LEVEL=$3
fi
export ENTITY_NAME="nmalik-$(date +'%Y%m%d%H%M%S'){thread}";
export MONGO_DATASOURCE="mongo";

# Metadata:
export ENTITY_VERSION_1="1.0.0";
export ENTITY_VERSION_2="2.0.0"

# CRUD:
export ENTITY_VERSION="${ENTITY_VERSION_2}"

if [ "x$LOAD_PROCESSES" == "x" ]; then
   LOAD_PROCESSES=2
fi
date1=$(date +"%s")
echo "Running tests for new entity: $ENTITY_NAME"

for i in $(seq 1 1 $LOAD_PROCESSES)
do
   python -c "import resttest; args=dict(); args['url']='$2'; args['test']='step1_metadata.yaml'; args['log']='$LOGGING_LEVEL'; args['interactive']=$INTERACTIVE; args['print_bodies']=$INTERACTIVE;args['threads']=1;args['rampup']=0;args['switch_tests_to_benchmark']=True; args['thread_name']='Thread-$i'; resttest.main(args)" 2>&1  &
done
wait

for i in $(seq 1 1 $LOAD_PROCESSES)
do
   python -c "import resttest; args=dict(); args['url']='$1'; args['test']='step2_data.yaml'; args['log']='$LOGGING_LEVEL'; args['interactive']=$INTERACTIVE; args['print_bodies']=$INTERACTIVE;args['threads']=1;args['rampup']=0;args['switch_tests_to_benchmark']=True; args['thread_name']='Thread-$i'; resttest.main(args)" 2>&1  &
done
wait

for i in $(seq 1 1 $LOAD_PROCESSES)
do
   python -c "import resttest; args=dict(); args['url']='$2'; args['test']='step3_metadata_teardown.yaml'; args['log']='$LOGGING_LEVEL'; args['interactive']=$INTERACTIVE; args['print_bodies']=$INTERACTIVE;args['threads']=1;args['rampup']=0;args['switch_tests_to_benchmark']=True; args['thread_name']='Thread-$i'; resttest.main(args)" 2>&1 &
done
wait


#unset ENTITY_NAME
#unset ENTITY_VERSION_1
#unset ENTITY_VERSION_2
date2=$(date +"%s")
diff=$(($date2-$date1))
echo "$(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."

