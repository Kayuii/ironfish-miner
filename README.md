# [kayuii/ironfish-miner](https://github.com/Kayuii/ironfish-miner)
An [ironfish-miner](https://github.com/hpool-dev/ironfish-miner) docker image.

## docker hub:
[kayuii/ironfish-miner](https://hub.docker.com/r/kayuii/ironfish-miner)

## Requirements

* NVIDIA driver for your NVIDIA GPUs
* AMD/ROCm driver for your AMD GPUs
* Docker
* [nvidia-docker](https://github.com/NVIDIA/nvidia-docker) (NVIDIA Container Toolkit) to be installed ([CUDA container requirements](https://github.com/NVIDIA/nvidia-docker/wiki/CUDA))
* A [supported Linux distribution](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#linux-distributions) for the [Nvidia Container Runtime](https://github.com/NVIDIA/nvidia-container-runtime.git).
* A supported Linux distribution for the [AMD Container Runtime](https://github.com/abuccts/rocm-container-runtime.git).


Note: I had to disable secure boot on Ubuntu 20.04 so that nvidia-docker can see the GPU(s) properly, but your mileage may vary.

## Tags

ironfish-miner

- `v1.0.3` ([Dockerfile](https://github.com/Kayuii/ironfish-miner/blob/main/gpu/Dockerfile))

x-proxy

- `v1.0.3` ([Dockerfile](https://github.com/Kayuii/ironfish-miner/blob/main/gpu/xproxy/Dockerfile))

### for ironfish-miner

* [docker-compose](https://github.com/Kayuii/ironfish-miner/blob/main/doc/docker-compose.md) example

* [command-line](https://github.com/Kayuii/ironfish-miner/blob/main/doc/command-line.md) example

# Multi-GPU setup and NVIDIA GPU selection
The image can run on a multi-gpu setup. The exact GPUs can be selected using the `NVIDIA_VISIBLE_DEVICES`. Value `all` will make the image use all available GPUs. Number values can be used to select a specific GPU. Multiple specific GPUs can be selected with comma separated numbers, like `1,2` or `0,1,4`.

GPU information (IDs, models, etc.) can be get from NVIDIA-SMI. The image comes with NVIDIA-SMI, so if you don't have it installed on your machine, you can run it with:

```
docker run --runtime=nvidia -e NVIDIA_VISIBLE_DEVICES=all --rm  kayuii/ironfish-miner nvidia-smi
```
or
```
docker run --gpus=all --rm  kayuii/ironfish-miner nvidia-smi
```

# AMD GPU selection
The image can run on a multi-gpu setup. The exact GPUs can be selected using the `AMD_VISIBLE_DEVICES`. Value `all` will make the image use all available GPUs. Number values can be used to select a specific GPU. Multiple specific GPUs can be selected with comma separated numbers, like `1,2` or `0,1,4`.

GPU information (IDs, models, etc.) can be get from NVIDIA-SMI. The image comes with ROCM-SMI, so if you don't have it installed on your machine, you can run it with:
```
docker run --runtime=rocm -e AMD_VISIBLE_DEVICES=all --security-opt seccomp=unconfined --rm  kayuii/ironfish-miner rocminfo
```
or
```
docker run --device=/dev/kfd --device=/dev/dri --security-opt seccomp=unconfined --group-add render --rm  kayuii/ironfish-miner rocminfo
```

## about config.yaml

- ([config.yaml](https://github.com/Kayuii/ironfish-miner/blob/main/doc/YAML.md))

## Performance:

| GPU  | Hashrate | Power |
| --- | --- | --- |
| RTX 3070   | 2.5 GH/s  | 220 W |
| RTX 3070   | 2.29 GH/s  | 153 W |
| RTX 3080   | 3.2 GH/s  | 320 W |
| RTX 3080   | 3.02 GH/s  | 220 W |
| RTX 3080 Ti  | 4 GH/s  | 243 W |
| RTX 1660 super  | 1.17 GH/s  | 125 W |
| RTX 1660 super  | 960 MH/s  | 75 W |
| 6800XT  | 3.6 GH/s |  |
| 6600  | 322 MH/s | 130 W  |


| CPU  | Hashrate | Thread |
| --- | --- | --- |
| AMD Ryzen Threadripper 3990X  | 3.8 MH/s  | 1 |
| AMD Ryzen Threadripper 3990X  | 110 MH/s  | 32 |
| AMD Ryzen Threadripper 3990X  | 200 MH/s  | 64 |
| AMD Ryzen Threadripper 3990X  | 310 MH/s  | 128 |
