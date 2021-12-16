#!/bin/bash

# Backup important files to telegram
# 2019/6/5
# credit @xtaodada

dir_list=$(echo $BACKUP_DIR | tr ";" "\n")
db_list=$(echo $BACKUP_DB | tr ";" "\n")
date=$(date +"%Y%m%d")

backup_dir() {
    backup_path=$1
    dirname=`echo ${backup_path##*/}`
    filename=/tmp/$dirname-$date.tar.gz
    parent=`echo ${backup_path}|sed 's/'${dirname}'//g'`
    tar zcf $filename -C ${parent} $backup_path
    upload $filename
}

backup_db() {
    filename=/tmp/db-$1-$date.sql
    mysqldump -u$MYSQL_USERNAME -p$MYSQL_PASSWORD -P $MYSQL_PORT -h $MYSQL_HOST $1 > $filename
    upload $filename
}

upload() {
    curl -F chat_id=$CHAT_ID -F document=@"$1" https://api.telegram.org/$BOT_TOKEN/sendDocument  > /dev/null
    rm -f $1
}

for dd in ${dir_list[@]};do
    backup_dir ${dd}
done

for dd in ${db_list[@]};do
    backup_db ${dd}
done

exit 0
