curl --request GET -sL \
     --url 'http://mirrors.tuna.tsinghua.edu.cn/apache/rocketmq/${ROCKETMQ_VERSION}/rocketmq-all-${ROCKETMQ_VERSION}-bin-release.zip'\
     --output './path/to/file'
mkdir -p  /home/httech/app/docker/rocketmq/logs/nameserver-a
mkdir -p  /home/httech/app/docker/rocketmq/logs/nameserver-b
mkdir -p /home/httech/app/docker/rocketmq/store/nameserver-a
mkdir -p /home/httech/app/docker/rocketmq/store/nameserver-b
mkdir -p /home/httech/app/docker/rocketmq/logs/broker-a
mkdir -p /home/httech/app/docker/rocketmq/logs/broker-b
mkdir -p /home/httech/app/docker/rocketmq/store/broker-a
mkdir -p /home/httech/app/docker/rocketmq/store/broker-b
mkdir -p/home/httech/app/docker/rocketmq/broker-a/
mkdir -p /home/httech/app/docker/rocketmq/broker-b/

docker-compose -f docker-compose.yml up -d

docker-compose logs --tail="all"  rmqbroker-a
docker container stop $(docker container ls -aq)
docker container rm $(docker container ls -aq)
mqadmin clusterList -n localhost:9876
# 注意点
# centos 7.6 默认开启 SELinux 容器不能访问主机挂载的目录
# broker.conf 需要配置 broker ip
# 由于容器内定义了一个 rocketmq 用户，必须保证该用户拥有各个数据卷的读写权限，否则会闪退