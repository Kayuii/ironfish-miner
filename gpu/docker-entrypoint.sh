#!/bin/sh
set -e

if [ $(echo "$1" | cut -c1) = "-" ]; then
    echo "$0: assuming arguments for hpool-miner"
    set -- hpool-miner "$@"
fi

if [ ! -f config.yaml ]; then
cat <<-EOF > "/opt/config.yaml"
minerName:
apiKey:
log:
  lv: info
  path: ./log/
  name: miner.log
url:
  proxy: ""
proxy:
    url: ""
    username: ""
    password: ""
language: cn
line: cn
extraParams:
  threadNum: 0
  enableGPU: 1
  gpuDevice: 0
  gpuBatchCount: 10240000
  gpuLoop: 1

EOF
fi

if [ "$1" = "hpool-miner" ]; then
    if [ -n "$APIKEY" ]; then
        echo "$(sed "/apiKey:$/c apiKey: $APIKEY" config.yaml)" > config.yaml
    fi
    if [ -n "$HOSTNAME" ]; then
        echo "$(sed "/minerName:$/c minerName: $HOSTNAME" config.yaml)" > config.yaml
    fi
    if [ -n "$PROXY" ]; then
        echo "$(sed "s!proxy: \"\"!proxy: \"$PROXY\"!g" config.yaml)" > config.yaml
    fi
    if [ -n "$LANG" ]; then
        echo "$(sed "/line: cn/cline: $LANG" config.yaml)" > config.yaml
    fi
    if [ -n "$LOGPATH" ]; then
        echo "$(sed "s:./log/:$LOGPATH:g" config.yaml)" > config.yaml
        mkdir -p "$LOGPATH"
        chown -R miner "$LOGPATH"
        chown -h miner:miner "$LOGPATH"
    else
        mkdir -p ./log/
        chown -R miner ./log/
        chown -h miner:miner ./log/
    fi
    if [ -n "$CPUNUM" ]; then
        echo "$(sed "s/threadNum: 0/threadNum: $CPUNUM/g" config.yaml)" > config.yaml
    fi
    if [ -n "$ENABLEGPU" ] && [ "$ENABLEGPU" -gt 0 ]; then
        echo "$(sed "s/enableGPU: 1/enableGPU: 1/g" config.yaml)" > config.yaml
    else
        echo "$(sed "s/enableGPU: 1/enableGPU: 0/g" config.yaml)" > config.yaml
    fi
    if [ -n "$DEVICE" ]; then
        echo "$(sed "s/gpuDevice: 0/gpuDevice: $DEVICE/g" config.yaml)" > config.yaml
    fi
    if [ -n "$GPUBATCHCOUNT" ]; then
        echo "$(sed "s/gpuBatchCount: 10240000/gpuBatchCount: $GPUBATCHCOUNT/g" config.yaml)" > config.yaml
    fi
    if [ -n "$GPULOOP" ]; then
        echo "$(sed "s/gpuLoop: 1/gpuLoop: $GPULOOP/g" config.yaml)" > config.yaml
    fi

    chown -R miner .
    chown -h miner:miner .
    cat config.yaml

    echo "run : $@ "
    exec gosu miner "$@"
fi

echo "run some: $@"
exec "$@"
