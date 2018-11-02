#!/bin/bash
set -m

mongodb_cmd="mongod --storageEngine $STORAGE_ENGINE"
cmd="$mongodb_cmd --httpinterface --rest"
if [ "$DB_PATH" != "" ]; then
   cmd="$cmd --dbpath $DB_PATH"
fi

if [ "$BIND_IP" != "" ]; then
   cmd="$cmd --bind_ip $BIND_IP"
fi

if [ "$DB_PORT" != "" ]; then
   cmd="$cmd --port $DB_PORT"
fi

if [ "$AUTH" == "yes" ]; then
    cmd="$cmd --auth"
fi

if [ "$AUTH" == "no" ]; then
    cmd="$cmd --noauth"
fi

if [ "$REPL_SET" != "" ]; then
    cmd="$cmd --replSet $REPL_SET"
fi

if [ "$JOURNALING" == "no" ]; then
    cmd="$cmd --nojournal"
fi

if [ "$OPLOG_SIZE" != "" ]; then
    cmd="$cmd --oplogSize $OPLOG_SIZE"
fi

$cmd &

if [ ! -f $DB_PATH/.mongodb_password_set ] && [ "$AUTH" != "no" ]; then
    $DB_CONF/set_mongodb_password.sh
fi

fg
