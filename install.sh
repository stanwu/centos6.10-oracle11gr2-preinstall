#!/bin/bash

if [ $UID -gt 0 ]; then
   echo "required root permission"
   echo "you need login as root"
   exit 1
fi

if [ ! -f /root/install_files.tgz ]; then
   echo "/root/install_files.tgz not found!"
   exit 1
fi


if uname -m | grep 64; then
   mcpu="64"
   rpm -ivh pdksh-5.2.14-37.el5_8.1.x86_64.rpm
else
   mcpu="32"
   rpm -ivh pdksh-5.2.14-2.i386.rpm
fi

echo "install pre-install files"
cd /etc/yum.repos.d
wget https://public-yum.oracle.com/public-yum-ol6.repo
wget https://public-yum.oracle.com/RPM-GPG-KEY-oracle-ol6 -O /etc/pki/rpm-gpg/RPM-GPG-KEY-oracle

echo "install requirment packages"
yum -y install gcc-c++ gcc glibc libgcc libstdc++ compat-libstdc++  elfutils-libelf-dev libaio-devel
yum -y install binutils compat-libstdc++ elfutils-libelf elfutils-libelf-devel gcc gcc-c++ glibc glibc-common glibc-devel glibc-headers libaio libaio-devel libgcc libstdc++ libstdc++-devel make sysstat numactl libXp unixODBC unixODBC-devel

echo "preinstall"
yum -y install oracle-rdbms-server-11gR2-preinstall

clear
echo "Add oinstall group"
groupadd oinstall

if [ ! -d /home/oracle ]; then
   echo "Add and detup password for oracle user :"
   adduser oracle
   passwd oracle
fi

echo "config oracle setup files"
mkdir -p /u01/app/oracle/product/11.2.0/dbhome_1
chown -R oracle:oinstall /u01
chmod -R 775 /u01

if ! grep oracle.local /etc/hosts; then
   mip=`ifconfig eth0 | grep "inet addr" | awk '{print $2}' | awk -F: '{print $2}'`
   echo "$mip  oracle.local  oracle" >> /etc/hosts
fi

echo "config network"
cur_dir=`pwd`
cd /
tar xvzf /root/install_files.tgz

clear
echo "You may use below command to install pdksh again"
echo ""
if uname -m | grep 64; then
   echo "rpm -ivh pdksh-5.2.14-37.el5_8.1.x86_64.rpm"
else
   echo "rpm -ivh pdksh-5.2.14-2.i386.rpm"
fi
echo ""
echo "Pre-install done! ${mcpu}bit"
echo "You need reboot before install Oracle"


