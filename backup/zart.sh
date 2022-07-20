#!/bin/env bash

source .env
cd $FOLDER
for collection in *.json; do
    cmd="mongoimport --uri $MONGO_URI -d $DB --jsonArray $collection"
    echo $cmd
    eval $cmd
done
echo -e "\n################################################################\n
                            OLA ETOIMA          
         \n################################################################"