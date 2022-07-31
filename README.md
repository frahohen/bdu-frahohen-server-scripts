# bdu-frahohen-server-scripts

A basic automated server environment setup for MX Linux

Currently included:

* OpenSSH
* X2Go
* Virtualbox
* PHPVirtualbox
* Syncthing
* FileBrowser
* Webmin
* Glances
* Dashy

# How to install

## Option 1: Install server-frahohen environment

* Install gitg and clone the repository
* Open a terminal and assuming the repository is cloned to the home folder of your user, execute the following commands:

```
cd bdu-frahohen-server-scripts
su root ./server-frahohen.setup.sh
```

## Option 2: Install home-frahohen environment

* Install gitg and clone the repository
* Open a terminal and assuming the repository is cloned to the home folder of your user, execute the following commands:

```
cd bdu-frahohen-server-scripts
su root ./home-frahohen.setup.sh
```

# Enable autostart for VMs
The script _enable_vbox_vm_autostart.sh_  can configure a VM to shut down and restart automatically after the host machine was restarted. The delay before the VM restarts is set to 120 seconds. This can be changed within this script to the required delay time. To apply the autostart configuration to a VM, execute the following command:

```
su vbox ./enable_vbox_vm_autostart.sh
```

# Requirements

* MX-21.1_ahs_x64.iso
* OS language set to German

# Note 

This setup is created for a specific modification of the initial system and was not tested with the stock OS. This setup should only be used on servers that are in a separate local network. 

# Hint for the modified OS

* Press F4 and enter:
```
minstall
```

* Do not install Samba
