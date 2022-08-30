#!/bin/env bash

exclude=('triproutes.json')
source .env
cd 1824db2
for collection in *.json; do
    if [[ "${exclude[@]}" =~ "$collection" ]]; then
        echo "to $collection tha paralifthei..."
        continue;
    fi
    mongo5="mongoimport --uri $MONGO_URI -d $DB --jsonArray $collection"
    mongo6="mongoimport --uri $MONGO_URI6 -d $DB --jsonArray $collection"
    echo $mongo5
    echo $mongo6
    eval $mongo5
    eval $mongo6
done
echo -e "\n################################################################\n
                            OLA ETOIMA          
         \n################################################################"