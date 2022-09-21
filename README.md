# [kayuii/ironfish-miner](https://github.com/Kayuii/ironfish-miner)
An [ironfish-miner](https://github.com/hpool-dev/ironfish-miner) docker image.

## docker hub:
[kayuii/ironfish-miner](https://hub.docker.com/r/kayuii/ironfish-miner)

## Requirements

* NVIDIA driver for your GPUs
* Docker
* [nvidia-docker](https://github.com/NVIDIA/nvidia-docker) (NVIDIA Container Toolkit) to be installed ([CUDA container requirements](https://github.com/NVIDIA/nvidia-docker/wiki/CUDA))
* A [supported Linux distribution](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#linux-distributions) for the Nvidia Container Runtime.

Note: I had to disable secure boot on Ubuntu 20.04 so that nvidia-docker can see the GPU(s) properly, but your mileage may vary.

## Tags

ironfish-miner

- `v1.0.3` ([Dockerfile](https://github.com/Kayuii/ironfish-miner/blob/main/gpu/Dockerfile))

x-proxy

- `v1.0.3` ([Dockerfile](https://github.com/Kayuii/ironfish-miner/blob/main/gpu/xproxy/Dockerfile))

### for ironfish-miner

`docker-compose` example :

```yml
version: "3"

services:
  miner:
    image: kayuii/ironfish-miner:v1.0.3
    restart: always
    runtime: nvidia
    environment:
        # 'all' uses all available GPUs. Specific GPU(s) can be selected with comma separated numbers, like '1,2' or '0,1,4'.
      - NVIDIA_VISIBLE_DEVICES=all
    volumes:
      - ./config.yaml:/opt/config.yaml
    environment:
    command:
      - hpool-miner
```
or
```yml
version: "3"

services:
  miner:
    image: kayuii/ironfish-miner:v1.0.3
    restart: always
    runtime: nvidia
    environment:
        # 'all' uses all available GPUs. Specific GPU(s) can be selected with comma separated numbers, like '1,2' or '0,1,4'.
      - NVIDIA_VISIBLE_DEVICES=all
      - APIKEY=ironfish-b486-cbdc-1370-704770a25172
      - HOSTNAME=miner
      - PROXY=http://192.168.1.88:9190
      - ENABLEGPU=1
      - DEVICE=0
    command:
      - hpool-miner
```

command-line example:

```sh
docker run -itd --rm --gpus=all --name miner \
    -v "./config.yaml:/opt/config.yaml" \
    kayuii/ironfish-miner:v1.0.3 hpool-miner
```
or
```sh
docker run -itd --rm --gpus=all --name miner \
    -e "APIKEY=ironfish-b486-cbdc-1370-704770a25172" \
    -e 'HOSTNAME=miner' \
    -e 'PROXY=http://192.168.1.88:9190' \
    -e 'ENABLEGPU=1' \
    -e 'DEVICE=0' \
    kayuii/ironfish-miner:v1.0.3 hpool-miner
```
# Multi-GPU setup and GPU selection
The image can run on a multi-gpu setup. The exact GPUs can be selected using the `NVIDIA_VISIBLE_DEVICES`. Value `all` will make the image use all available GPUs. Number values can be used to select a specific GPU. Multiple specific GPUs can be selected with comma separated numbers, like `1,2` or `0,1,4`.

GPU information (IDs, models, etc.) can be get from NVIDIA-SMI. The image comes with NVIDIA-SMI, so if you don't have it installed on your machine, you can run it with:

```
docker run --runtime=nvidia -e NVIDIA_VISIBLE_DEVICES=all --rm  kayuii/ironfish-miner nvidia-smi
```
or
```
docker run --gpus=all --rm  kayuii/ironfish-miner nvidia-smi
```

## about config.yaml

- ([config.yaml](https://github.com/Kayuii/ironfish-miner/blob/main/doc/YAML.md))

## Performance:

| GPU  | Hashrate | Power |
| --- | --- | --- |
| RTX 3070   | 2.5 GH/s  | 220 W |
| RTX 3070   | 2.29 GH/s  | 153 W |
| RTX 3080 Ti  | 4 GH/s  | 243 W |
| RTX 1660 super  | 1.17 GH/s  | 125 W |
| RTX 1660 super  | 960 MH/s  | 75 W |
| 6800XT  | 3.6 GH/s |  |


| CPU  | Hashrate | Thread |
| --- | --- | --- |
| AMD Ryzen Threadripper 3990X  | 3.8 MH/s  | 1 |
| AMD Ryzen Threadripper 3990X  | 110 MH/s  | 32 |
| AMD Ryzen Threadripper 3990X  | 200 MH/s  | 64 |
| AMD Ryzen Threadripper 3990X  | 310 MH/s  | 128 |
