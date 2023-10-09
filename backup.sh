#!/bin/bash

# Backup important files to telegram
# credit @xtaodada

dir_list=$(echo $BACKUP_DIR | tr ";" "\n")
db_list=$(echo $BACKUP_DB | tr ";" "\n")
postgres_list=$(echo $BACKUP_POSTGRES_DB | tr ";" "\n")
date=$(date +"%Y%m%d")
bot_api="${BOT_API:-https://api.telegram.org}"

backup_dir() {
    backup_path=$1
    dirname=`echo ${backup_path##*/}`
    filename=/tmp/$dirname-$date.tar.gz
    parent=`echo ${backup_path}|sed 's/'${dirname}'//g'`
    tar zcf $filename -C ${parent} $backup_path
    upload $filename
}

backup_db() {
    filename=/tmp/mysql-db-$1-$date.sql
    mysqldump -u$MYSQL_USERNAME -p$MYSQL_PASSWORD -P $MYSQL_PORT -h $MYSQL_HOST $1 > $filename
    upload $filename
}

backup_postgres() {
    filename=/tmp/postgres-db-$1-$date.sql
    pg_dump "$POSTGRES_CONNECTION_URI/$1" > $filename
    upload $filename
}

upload() {
    curl -F chat_id=$CHAT_ID -F document=@"$1" $bot_api/bot$BOT_TOKEN/sendDocument  > /dev/null
    rm -f $1
}

for dd in ${dir_list[@]};do
    backup_dir ${dd}
done

for dd in ${db_list[@]};do
    backup_db ${dd}
done

for dd in ${postgres_list[@]};do
    backup_postgres ${dd}
done

exit 0
