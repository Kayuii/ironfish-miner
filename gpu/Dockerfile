FROM ubuntu:20.04 as download

ARG TARGETARCH

RUN apt-get -qq update \
  && apt-get -qq install -y --no-install-recommends ca-certificates curl \
  && cd /opt/ \
  && curl -sOL https://github.com/krallin/tini/releases/download/v0.19.0/tini-$TARGETARCH \
  && chmod +x tini* \
  && curl -sOL https://github.com/tianon/gosu/releases/download/1.14/gosu-$TARGETARCH \
  && chmod +x gosu*

COPY / /opt

RUN  find /opt/ -name "hpool-miner*" | xargs -i /bin/mv {} /opt/ \
  && cd /opt/ \
  && ls -al

FROM alpine:3.12 as timezone

Run apk update && apk add tzdata

FROM kayuii/amdgpu:v22.20.3 as opencl

ENV PATH=$PATH:/opt

ENV TZ=Asia/Shanghai
WORKDIR /opt

COPY --from=timezone /usr/share/zoneinfo/$TZ /etc/localtime
COPY --from=download /opt/hpool-miner-ironfish-opencl /opt/hpool-miner
COPY --from=download /opt/tini* /opt/tini
COPY --from=download /opt/gosu* /opt/gosu

RUN apt-get -qq update \
    && apt-get -qq install -y --no-install-recommends ca-certificates curl \
    && groupadd -r miner \
    && useradd -r -m -g miner miner \
    && usermod -a -G render,users,miner miner \
    && echo $TZ > /etc/timezone \
    && ls -al /opt/ \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

COPY docker-entrypoint.sh /opt/entrypoint.sh

ENTRYPOINT ["tini", "--", "entrypoint.sh"]

CMD ["hpool-miner"]

FROM nvidia/cuda:11.7.1-base-ubuntu20.04 as cuda
# FROM nvidia/cuda:11.4.3-base-ubuntu20.04 as cuda
# cuda 11.7 hashrate greater than 11.4

ENV PATH=$PATH:/opt

ENV TZ=Asia/Shanghai
WORKDIR /opt

COPY --from=timezone /usr/share/zoneinfo/$TZ /etc/localtime
COPY --from=download /opt/hpool-miner-ironfish-cuda /opt/hpool-miner
COPY --from=download /opt/tini* /opt/tini
COPY --from=download /opt/gosu* /opt/gosu

RUN apt-get -qq update \
    && apt-get -qq install -y --no-install-recommends ca-certificates curl \
    && groupadd -r miner \
    && useradd -r -m -g miner miner \
    && usermod -a -G users,miner miner \
    && echo $TZ > /etc/timezone \
    && ls -al /opt/ \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

COPY docker-entrypoint.sh /opt/entrypoint.sh

ENTRYPOINT ["tini", "--", "entrypoint.sh"]

CMD ["hpool-miner"]


FROM nvidia/cuda:11.7.1-base-ubuntu20.04 as cuda-rocm

ARG ROCM_VERSION=5.2.3
ARG AMDGPU_VERSION=22.20.3

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends ca-certificates curl libnuma-dev gnupg \
  && curl -sL https://repo.radeon.com/rocm/rocm.gpg.key | apt-key add - \
  && printf "deb [arch=amd64] https://repo.radeon.com/rocm/apt/$ROCM_VERSION/ ubuntu main" | tee /etc/apt/sources.list.d/rocm.list \
  && printf "deb [arch=amd64] https://repo.radeon.com/amdgpu/$AMDGPU_VERSION/ubuntu focal main" | tee /etc/apt/sources.list.d/amdgpu.list \
  && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  rocm-smi \
  rocminfo \
  rocm-opencl-runtime && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*
RUN  groupadd -g 109 render


FROM cuda-rocm as all-in-one

ENV PATH=$PATH:/opt

ENV TZ=Asia/Shanghai
WORKDIR /opt

COPY --from=timezone /usr/share/zoneinfo/$TZ /etc/localtime
COPY --from=download /opt/hpool-miner-ironfish-opencl /opt/hpool-miner-ironfish-opencl
COPY --from=download /opt/hpool-miner-ironfish-cuda /opt/hpool-miner-ironfish-cuda
COPY --from=download /opt/tini* /opt/tini
COPY --from=download /opt/gosu* /opt/gosu

RUN apt-get -qq update \
    && apt-get -qq install -y --no-install-recommends ca-certificates curl \
    && groupadd -r miner \
    && useradd -r -m -g miner miner \
    && usermod -a -G render,users,miner miner \
    && echo $TZ > /etc/timezone \
    && ls -al /opt/ \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

COPY docker-entrypoint-switch.sh /opt/entrypoint.sh

ENTRYPOINT ["tini", "--", "entrypoint.sh"]

CMD ["hpool-miner"]
