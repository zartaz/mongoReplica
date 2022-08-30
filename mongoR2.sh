#!/bin/bash

source .env

check_id_Rsa(){
    if ! test -f "$ID_RSA"; then
        echo "To $ID_RSA den yparxei,kali synexeia..."
        exit 1
    fi
}

check(){
    date >> date.txt
    wall "done"
}

cd_here(){
    cd "$(dirname "$(readlink -f "$0")")"
    date > date.txt
}

diagrafi_paliwn_arxeiwn(){
    rm *.gz
    rm -rf .$file
}

katevase_backup(){
    scp -i $ID_RSA -o StrictHostKeyChecking=no $fileserver:$passdb2.tar.gz .
    sleep 3
}

extract_files(){
    tar -xzvf $file -C $backupfolder
}

delete_db_from_mongo(){
    docker exec -ti $(docker ps -q -f name=$service) bash -c "mongo -u $user -p $pass$user --eval \"db=db.getSiblingDB('$db_gia_svisimo');db.dropDatabase();\""
}

cron_delete_db_from_mongo(){
    docker exec $(docker ps -q -f name=$service) /bin/bash -c "mongosh -u $user -p $pass$user --eval \"db=db.getSiblingDB('$db_gia_svisimo');db.dropDatabase();\""
    docker exec $(docker ps -q -f name=dev_mongo6solo) /bin/bash -c "mongosh -u $user -p $pass$user --eval \"db=db.getSiblingDB('$db_gia_svisimo');db.dropDatabase();\""
}

sikwse_mongo_Zarta(){
    docker stack deploy -c $dockerfile dev
}

insert_backup_to_mongo(){
    docker exec -ti $(docker ps -q -f name=$service2) bash zart.sh
}

cron_insert_backup_to_mongo(){
    docker exec $(docker ps -q -f name=$service2) /bin/bash zart.sh
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