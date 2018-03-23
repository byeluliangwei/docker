#!/bin/bash

ROOT_PASS=${MONGODB_ROOT_PASS:-$(pwgen -s 12 1)}
_for_root_word=$( [ ${MONGODB_ROOT_PASS} ] && echo "preset" || echo "random" )

WORK_PASS=${MONGODB_WORK_PASS:-$(pwgen -s 12 1)}
_for_work_word=$( [ ${MONGODB_WORK_PASS} ] && echo "preset" || echo "random" )

RET=1
while [[ RET -ne 0 ]]; do
    echo "===================>>>>> Waiting for confirmation of MongoDB service startup"
    sleep 5
    mongo --host $REPL_SET_HOST --port $REPL_SET_PORT admin --eval "help" >/dev/null 2>&1
    RET=$?
done

if [ "$AS_PRIMARY" != "no" ]; then
   RET=1
   while [[ RET -ne 0 ]]; do
      echo "===================>>>>> Waiting for confirmation of MongoDB  Replica Set service startup"
      sleep 5
      mongo --host $REPL_SET_HOST --port $REPL_SET_PORT admin --eval "rs.status();" | grep "stateStr" | grep "PRIMARY" >/dev/null 2>&1
      RET=$?
   done
   echo "===================>>>>> Creating an root user with a ${_for_root_word} password in MongoDB"
   mongo --host $REPL_SET_HOST --port $REPL_SET_PORT admin --eval "db.createUser({user: '$MONGODB_ROOT_NAME', pwd: '$ROOT_PASS', roles:[{role:'root',db:'admin'}]}); db.auth({user: '$MONGODB_ROOT_NAME',pwd: '$ROOT_PASS'});"
   echo "===================>>>>> Creating an work user with a ${_for_root_word} password in MongoDB"
   mongo --host $REPL_SET_HOST --port $REPL_SET_PORT admin -u $MONGODB_ROOT_NAME -p $ROOT_PASS --eval "db.getSiblingDB('$MONGODB_WORK_DB').createUser({user: '$MONGODB_WORK_NAME', pwd: '$WORK_PASS', roles: [{role: 'dbOwner', db: '$MONGODB_WORK_DB'}]}); db.auth({user: '$MONGODB_WORK_NAME',pwd: '$WORK_PASS'});"

   echo "===================>>>>> Done!"
   touch $DB_PATH/.mongodb_password_set

   echo "================================================================================================================================================"
   echo "You can now connect to this MongoDB server using:"
   echo ""
   echo "    mongo <database name> -u <username> -p <password> --host $REPL_SET_HOST --port $REPL_SET_PORT"
   echo ""
   echo "Please remember to change the above password as soon as possible!"
   echo "================================================================================================================================================"
else
   echo "================================================================================================================================================"
   echo "You are not a PRIMARY node, can not create user!"
   echo "================================================================================================================================================"
fi

