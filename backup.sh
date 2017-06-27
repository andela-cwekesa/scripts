#!/bin/bash

# PG_USER=collins
# DATABASE=edms
# SERVER=127.0.0.1
# DIR="$HOME/pg_bak"
# DATE=$(date +"%m_%d_%y")
# FILE="$DATABASE_$DATE"

# echo "Ready to dump to $FILE" >> "$HOME/pg_status" 
# PG_BAK_NOW () {
#   pg_dump -h $SERVER -U $PG_USER $DATABASE > $FILE.sql 
# }

# cd $DIR
# if [ -f "$FILE" ];
# then
#   echo "Removing old"
#   rm $FILE
#   PG_BAK_NOW 
# else
#   PG_BAK_NOW
# fi

export PG_BIN=/usr/local/bin 
export OUT_DIR="$HOME/pg_bak"
export TODAY=$(date "+%Y/%m/%d") 
export BACKUP_DBS=`/usr/local/bin/psql template1 -t -c "SELECT 
datname FROM pg_database WHERE datname NOT LIKE 'template_' ORDER BY 
datname"` 

mkdir -p $OUT_DIR/$TODAY 

echo "DataBase backup for $(date)"; 

for i in $BACKUP_DBS 
do 
         echo -n "Backing up $i...." 
         $PG_BIN/pg_dump -o -C $i > $OUT_DIR/$TODAY/$i 
         echo -n "Compressing...." 
         bzip2 -9 -f $OUT_DIR/$TODAY/$i 
         echo "Done" 
done 
         echo -n "Backing up globals...." 
         $PG_BIN/pg_dumpall -g > $OUT_DIR/$TODAY/global.sql 
         echo "Done" 

echo "Backup done successfully!"; 