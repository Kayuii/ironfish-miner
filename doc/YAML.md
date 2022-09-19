## default config.yaml for miner

```yaml
# miner名称，不填使用电脑名
# miner name, use the computer name without filling in
minerName: ""
# 在 https://www.hpool.in/center/configuration 找ApiKey
# Find ApiKey at https://www.hpool.in/center/configuration
apiKey: ""
# 日志配置
# Log configuration
log:
  lv: info
  path: ./log/
  name: miner.log
# x-proxy配置
# x-proxy configuration
url:
  # 一个局域网内，代理只需要开一台就可以了，如代理所在的机器Ip是192.168.1.88，端口9190
  # 下面配置改为
  # proxy: "http://192.168.1.88:9190"
  # In a local area network, only one proxy is required. For example, the IP of the machine where the proxy is located is 192.168.1.88 and the port is 9190
  # The following configuration is changed to
  # proxy: "http://192.168.1.88:9190"
  proxy: ""
# socket 或者是http代理配置
# socket5 or http proxy
proxy:
    # E.g http://127.0.0.1:8888 socks5://127.0.0.1:8888
    url: ""
    username: ""
    password: ""
# 语言选择
# language selection
language: cn
# 线路
# line
line: cn

# 参数配置
# Parameter configuration
extraParams:
  # 计算线程，0不使用CPU
  # Compute thread, 0 does not use CPU
  threadNum: "0"
  # 是否开启GPU,0 关闭，1 开启
  # Whether to enable GPU, 0 is off, 1 is on
  enableGPU: 1
  # GPU设备编号
  # GPU device number
  gpuDevice: 0
  # 一次计算个数, 默认 10240000
  # Calculate the number at a time, the default is 10240000
  gpuBatchCount: 10240000
  # 循环次数，默认1
  # Number of cycles, default 1
  gpuLoop: 1

```

## default config.yaml for xproxy
```yml
# Service configuration
server:
    host: 0.0.0.0
    # 服务端口
    # Service port
    port: 9190
# db filename
dbFile: "proxy.db"
chains:
    -
        chain: ironfish
        # Configure the apikey of ironfish, configure it before generating the db file, and it will be automatically written to the db
        # 配置ironfish的apikey，在未生成db文件前配置好，会自动写入到db中
        # address https://www.hpool.in/center/configuration
        apiKey: ""

# socket5 or http proxy
proxy:
    # E.g http://127.0.0.1:8888 socks5://127.0.0.1:8888
    url: ""
    username: ""
    password: ""

```
