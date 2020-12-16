# Docker Container Live Migration On Local Machine

## Steps

### Step 1: Downloading and Installing Docker & CRIU on local machine

```
# Installing Docker-ce 17.03 through package
# Make sure kernel version is compatible with docker-runc
# older kernel version: 3.x used in this tutorial. Newer kernel version: 5.x need patched criu to work at this point of writing

$ wget https://download.docker.com/linux/ubuntu/dists/xenial/pool/stable/amd64/docker-ce_17.03.0~ce-0~ubuntu-xenial_amd64.deb
$ sudo dpkg -i docker-ce_17.03.0~ce-0~ubuntu-xenial_amd64.deb

# docker checkpoint is an experimental feature, so you should enable docker experimental feature
$ sudo nano /etc/docker/daemon.json

# Add the following code as content:
{
  "experimental":true
}

or

sudo dockerd --experimental
```

```sh
# Then check whether experimental feature has been enabled:
$ docker version
# You will see the value of "experimental" has been true

```
# Install CRIU 3.7

```sh
$ sudo apt-get update && sudo apt-get install -y libnl-route-3-dev libnfnetlink-dev protobuf-c-compiler libprotobuf-c0-dev protobuf-compiler libprotobuf-dev:amd64 gcc build-essential bsdmainutils python git-core asciidoc make htop git curl supervisor cgroup-lite libapparmor-dev libseccomp-dev libprotobuf-dev libprotobuf-c0-dev protobuf-c-compiler protobuf-compiler python-protobuf libnl-3-dev libcap-dev libaio-dev apparmor libnet-dev

$ git clone https://github.com/xemul/criu criu
$ cd criu
$ sudo make clean
$ sudo make 
$ sudo make install

# Then check if your criu works well
$ sudo criu check
$ sudo criu check --all
# You will see 'looks good'
```

### Step 2: Test your live migration

1. On original host(first directory if on local single machine)

```sh
$ docker run -d --name looper2 --security-opt seccomp:unconfined busybox \
         /bin/sh -c 'i=0; while true; do echo $i; i=$(expr $i + 1); sleep 1; done'

# wait a few seconds to give the container an opportunity to print a few lines, then
$ docker checkpoint create --checkpoint-dir=~/Container-Checkpoints/ looper2 checkpoint2

# check your container & print log file
$ docker ps
$ docker logs looper2
```

2. On new host(second directory or nfs or scp file directory)

```sh
$ docker create --name looper-clone --security-opt seccomp:unconfined busybox \
         /bin/sh -c 'i=0; while true; do echo $i; i=$(expr $i + 1); sleep 1; done'

$ docker start --checkpoint-dir=~/Container-Checkpoints/ --checkpoint=checkpoint2 looper-clone

# check your container
$ docekr ps
$ docker logs looper-clone
```
