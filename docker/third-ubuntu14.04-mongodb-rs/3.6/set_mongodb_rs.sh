#!/bin/bash

RET=1
while [[ RET -ne 0 ]]; do
    echo "===================>>>>> Waiting for confirmation of MongoDB service startup"
    sleep 5
    mongo --host $REPL_SET_HOST --port $REPL_SET_PORT admin --eval "help" >/dev/null 2>&1
    RET=$?
done


if [ "$AS_PRIMARY" != "no" ]; then
   echo "===================>>>>> Init Replica Set"
   if [ -f $DB_PATH/.mongodb_password_set ] && [ "$AUTH" != "no" ]; then
      echo "===================>>>>> Need auth init Replica Set"
      mongo --host $REPL_SET_HOST --port $REPL_SET_PORT admin -u $MONGODB_ROOT_NAME -p $MONGODB_ROOT_PASS --eval "rs.initiate({_id:'$REPL_SET',members:[{_id:$REPL_SET_ID,host:'$REPL_SET_HOST:$REPL_SET_PORT',priority :999}]});"
   else
      echo "===================>>>>> No auth init Replica Set"
      mongo --host $REPL_SET_HOST --port $REPL_SET_PORT admin --eval "rs.initiate({_id:'$REPL_SET',members:[{_id:$REPL_SET_ID,host:'$REPL_SET_HOST:$REPL_SET_PORT',priority :999}]});"
   fi
   
   echo "================================================================================================================================================"
   echo "You can now add or remove new SECONDARY nodes to this PRIMARY node:"
   echo ""
   echo "     rs.add('<host>:<port>');"
   echo "     rs.remove('<host>:<port>');"
   echo ""
   echo "================================================================================================================================================"
else
   echo "================================================================================================================================================"
   echo "You can be added as a SECONDARY node from a PRIMARY node!"
   echo "================================================================================================================================================"
fi

echo "===================>>>>> Done!"
touch $DB_PATH/.mongodb_rs_set