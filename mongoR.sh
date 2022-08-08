#!/bin/bash

#dimiourgise script edw me heredocs (cat<<EOF>executable.sh) kai kalesta me bash *.sh
#oti mporeis kanto async me &

cd_here(){
    cd "$(dirname "$(readlink -f "$0")")"
    source .env
}
check_id_Rsa(){
    if ! test -f "$ID_RSA"; then
        echo "To $ID_RSA den yparxei,kali synexeia..."
        exit 1
    fi
}
check(){
    pwd
    whoami
    date >> date.txt
    wall "done"
}
diagrafi_paliwn_arxeiwn(){
    rm *.gz
    rm -rf ./backup/1824db2
    date > date.txt
}
katevase_backup(){
    scp -i $ID_RSA -o StrictHostKeyChecking=no $BACKUPFILE .
}
extract_files(){
    tar -xzvf $FILE -C ./backup/
}
delete_db_from_mongo(){
    docker exec -ti $(docker ps -q -f name=$MONGO_SERVICE) bash -c "mongo -u $MONGO_USER -p $MONGO_PASS --eval \"db=db.getSiblingDB('$DB_TO_DELETE');db.dropDatabase();\""
}
cron_delete_db_from_mongo(){
    docker exec $(docker ps -q -f name=$MONGO_SERVICE) bash -c "mongo -u $MONGO_USER -p $MONGO_PASS --eval \"db=db.getSiblingDB('$DB_TO_DELETE');db.dropDatabase();\""
}
sikwse_mongo_Zarta(){
    docker stack deploy -c $dockerfile $STACK
}
insert_backup_to_mongo(){
    docker exec -ti $(docker ps -q -f name=$MONGO_HELP_SERVICE) bash zart.sh
}
cron_insert_backup_to_mongo(){
    docker exec $(docker ps -q -f name=$MONGO_HELP_SERVICE) bash zart.sh
}

cd_here
check_id_Rsa
diagrafi_paliwn_arxeiwn
katevase_backup
extract_files
sikwse_mongo_Zarta
cron_delete_db_from_mongo
cron_insert_backup_to_mongo
check
