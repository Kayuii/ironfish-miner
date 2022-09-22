### `docker-compose` example :

```yml

## for cuda
  miner-cuda:
    image: kayuii/ironfish-miner:cuda-v1.0.3
    restart: unless-stopped
    runtime: nvidia
    environment:
      - NVIDIA_VISIBLE_DEVICES=all
      - HOSTNAME=miner
      - PROXY=http://xproxy:9190
      - CPUNUM=0
      - ENABLEGPU=1
      - DEVICE=0
      - GPUBATCHCOUNT=10240000
      - GPULOOP=1
    command:
      - hpool-miner

## for opencl
  miner-opencl:
    image: kayuii/ironfish-miner:opencl-v1.0.3
    restart: unless-stopped
    devices:
      - "/dev/kfd"
      - "/dev/dri"
    group_add:
      - render
    security_opt:
      - seccomp:unconfined
    environment:
      - HOSTNAME=miner
      - PROXY=http://xproxy:9190
      - CPUNUM=0
      - ENABLEGPU=1
      - DEVICE=0
      - GPUBATCHCOUNT=10240000
      - GPULOOP=1
    command:
      - hpool-miner

```
