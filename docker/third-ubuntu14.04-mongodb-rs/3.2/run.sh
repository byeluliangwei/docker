#!/bin/bash

# mongod 启动配置
mongodb_cmd="mongod --storageEngine $STORAGE_ENGINE"
cmd="$mongodb_cmd --httpinterface --rest"
no_auth_cmd=$cmd
if [ "$DB_PATH" != "" ]; then
   cmd="$cmd --dbpath $DB_PATH"
   no_auth_cmd=$cmd
   mkdir -p $DB_PATH
fi

if [ "$BIND_IP" != "" ]; then
   cmd="$cmd --bind_ip $BIND_IP"
   no_auth_cmd=$cmd
fi

if [ "$REPL_SET_PORT" != "" ]; then
   cmd="$cmd --port $REPL_SET_PORT"
   no_auth_cmd=$cmd
fi

if [ "$REPL_SET" != "" ]; then
    cmd="$cmd --replSet $REPL_SET"
    no_auth_cmd=$cmd
fi

if [ "$JOURNALING" = "no" ]; then
    cmd="$cmd --nojournal"
    no_auth_cmd=$cmd
fi

if [ "$OPLOG_SIZE" != "" ]; then
    cmd="$cmd --oplogSize $OPLOG_SIZE"
    no_auth_cmd=$cmd
fi

if [ "$AUTH" = "yes" ]; then
    cmd="$cmd --auth"
    if [ "$KEY_FILE" != "" ]; then
        cmd="$cmd --keyFile $KEY_FILE"
    fi
fi

if [ "$AUTH" = "no" ]; then
    cmd="$cmd --noauth"
fi


# mongod 初始化配置
process="mongod"

if [ ! -f $DB_PATH/.mongodb_rs_set ]; then
   if [ "$(ps x | grep $process | grep -v grep | awk '{print $1}')" = "" ]; then
       $no_auth_cmd &
   fi
   echo "===================>>>>> Need init Mongo Replica Set..."
   $DB_CONF/set_mongodb_rs.sh
else
   echo "===================>>>>> Mongo Replica Set Already Inited!"
fi

pid=$(ps x | grep $process | grep -v grep | awk '{print $1}')

if [ ! -f $DB_PATH/.mongodb_password_set ] && [ "$AUTH" != "no" ] && [ "$AS_PRIMARY" != "no" ]; then
    echo "===================>>>>> Executing no_auth mongod command: '$no_auth_cmd'"
    if [ "$pid" = "" ]; then
       $no_auth_cmd &
    fi
    echo "===================>>>>> Mongod daemon running..."
    
    echo "===================>>>>> Init set mongodb password..."
    $DB_CONF/set_mongodb_password.sh
else 
    echo "===================>>>>> Kill existed 'mongod'..."
    if [ "$pid" != "" ]; then
        kill -9 $pid
        sleep 5
    fi
    echo "===================>>>>> Running 'mongod' using command: '$cmd'..."
    $cmd
fi
