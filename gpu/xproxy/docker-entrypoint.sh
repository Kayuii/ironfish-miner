#!/bin/sh
set -e

if [ $(echo "$1" | cut -c1) = "-" ]; then
    echo "$0: assuming arguments for x-proxy"
    set -- x-proxy "$@"
fi

if [ ! -f config.yaml ]; then
cat <<-EOF > "/opt/config.yaml"
server:
  host: 0.0.0.0
  port: 9190
log:
  level: "info"
  out: "proxy.log"
dbFile: "proxy.db"
chains:
  -
    chain: ironfish
    apiKey: "ironfish"
# socket5 or http proxy
proxy:
  # E.g http://127.0.0.1:8888 socket5://127.0.0.1:8888
  url: ""
  username: ""
  password: ""
EOF
fi

if [ "$1" = "x-proxy" ] ; then
    mkdir -p /opt/log/ /opt/db/

    if [ -n "$LOGLV" ]; then
        echo "$(sed "s/info/$LOGLV/g" config.yaml)" > config.yaml
    fi
    if [ -n "$LOGPATH" ]; then
        sed -i "s#out: \"proxy.log\"#out: \"$LOGPATH\"#g" config.yaml
    else
        LOGPATH=/opt/log/proxy.log
        sed -i "s#out: \"proxy.log\"#out: \"$LOGPATH\"#g" config.yaml
    fi
    if [ -n "$DBDIR" ]; then
        sed -i "s#dbFile: \"proxy.db\"#dbFile: \"$DBDIR\"#g" config.yaml
    else
        DBDIR=/opt/db/proxy.db
        sed -i "s#dbFile: \"proxy.db\"#dbFile: \"$DBDIR\"#g" config.yaml
    fi

    if [ -n "$APIKEY" ]; then
        sed -i "s/apiKey: \"ironfish\"/apiKey: \"$APIKEY\"/g" config.yaml
    fi

    cat config.yaml
    chown -R miner ./
    chown -h miner:miner ./
    if [ ! -f $LOGPATH ]; then
      touch "$LOGPATH"
      chown -R miner "$LOGPATH"
      chown -h miner:miner "$LOGPATH"
    fi
    echo "run : $@ "
    exec gosu miner "$@"
fi

echo "run some: $@"
exec "$@"
