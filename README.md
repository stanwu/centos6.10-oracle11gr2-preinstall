# CentOS 6.10 + Oracle 11gR2 pre-installer

This preinstall will help you to install all of requirment files before you start install Oracle 11gR2

## Requirement

### CentOS 6.10

- 32bit : CentOS-6.10-i386-LiveDVD.iso

- 64bit : CentOS-6.10-x86_64-LiveDVD.iso

### Oracle 11gR2 

You need download below files before you start pre-install:

- 32bit 

    * linux_11gR2_database_1of2.zip
    * linux_11gR2_database_2of2.zip

- 64bit

    * linux.x64_11gR2_database_1of2.zip
    * linux.x64_11gR2_database_2of2.zip

## Steps

1. Please copy all files to /root

```bash
cp install* /root
cp pdk* /root
```

2. Change install.sh to executable

```bash
cd /root
chmod 755 install.sh
```

3. Start auto install

```bash
./install.sh
```

You need reboot your system before install Oracle 11gR2

## Start install Oracle 11gR2

1. put Oracle 11gR2 zip files into /home/oracle
2. Unzip zip files
3. Change to root to enable X windows access

```bash
su -
xhost +
exit
```

4. Start setup

```bash
cd database
./runInstaller
```

