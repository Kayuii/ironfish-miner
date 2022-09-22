### `command-line` example:

```sh

## for cuda
docker run -itd --rm --runtime=nvidia -e NVIDIA_VISIBLE_DEVICES=all --name miner \
    -e "APIKEY=ironfish-b486-cbdc-1370-704770a25172" \
    -e 'HOSTNAME=miner' \
    -e 'PROXY=http://192.168.1.88:9190' \
    -e 'ENABLEGPU=1' \
    -e 'DEVICE=0' \
    kayuii/ironfish-miner:cuda-v1.0.3 hpool-miner

## for opencl
docker run -itd --rm --device=/dev/kfd --device=/dev/dri --security-opt seccomp=unconfined --group-add render --name miner \
    -e "APIKEY=ironfish-b486-cbdc-1370-704770a25172" \
    -e 'HOSTNAME=miner' \
    -e 'PROXY=http://192.168.1.88:9190' \
    -e 'ENABLEGPU=1' \
    -e 'DEVICE=0' \
    kayuii/ironfish-miner:opencl-v1.0.3 hpool-miner


```
