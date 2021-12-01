#!/bin/bash
#Install Two Haproxy High Availibility with KeepAlived
var1=400
var2=401
sshkeys=~/.ssh/id_rsa.pub

pct create $var1 \
    local:vztmpl/centos-8-default_20201210_amd64.tar.xz \
    --cores 2 --cpuunits 1024 \
    --memory 2048 --swap 128 \
    --hostname ha1 \
    --net0 name=eth0,ip=192.168.9.104/16,bridge=vmbr0,gw=192.168.10.254 \
    --searchdomain jwsgroup.fr \
    --nameserver 192.168.10.254 \
    --rootfs local-zfs:20 \
    --ssh-public-keys $sshkeys \
    --onboot 1
pct start $var1 &&\
sleep 10 &&\
pct exec $var1 -- bash -c "yum update -y &> /dev/null &&\
    yum install -y openssh-server nano &> /dev/null &&\
    systemctl start sshd"
sleep 5

pct create $var2 \
    local:vztmpl/centos-8-default_20201210_amd64.tar.xz \
    --cores 2 --cpuunits 1024 \
    --memory 2048 --swap 128 \
    --hostname ha2 \
    --net0 name=eth0,ip=192.168.9.105/16,bridge=vmbr0,gw=192.168.10.254 \
    --searchdomain jwsgroup.fr \
    --nameserver 192.168.10.254 \
    --rootfs local-zfs:20 \
    --ssh-public-keys $sshkeys \
    --onboot 1
pct start $var2 &&\
sleep 10 &&\
pct exec $var2 -- bash -c "yum update -y &> /dev/null &&\
    yum install -y openssh-server nano &> /dev/null &&\
    systemctl start sshd"

echo "The Containers is create & Running"

