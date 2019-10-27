# Vagrant for Wazo Platform

Here's a simple Vagrantfile and script to start a Wazo Platform.

## Requirements

- You should know your way around a terminal
- Install [VirtualBox](https://www.virtualbox.org/)
- Install [Vagrant](https://www.vagrantup.com/)
- Install [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

## Get started

In a terminal

```bash
vagrant plugin install vagrant-hostmanager
git clone https://github.com/wazo-platform/vagrant.git
cd vagrant
vagrant up
```

You'll be prompted for password about NFS share and adding the hostname and IP to your `hosts` file.

Head to https://wazo.vagrant

## Next

Connect to the VM to mess with it

```
vagrant ssh
```

Get rid of the VM only to start anew

```bash
vagrant destroy
```

There are many other possibilities like taking snapshot. See `vagrant --help` and doc. Feel free to edit the Vagrantfile and script to your fitting.

You can avoid being prompted everytime for NFS shares and the host name, here's the [official doc for NFS](https://www.vagrantup.com/docs/synced-folders/nfs.html#root-privilege-requirement), and the [hostmanager plugin doc](https://github.com/devopsgroup-io/vagrant-hostmanager#passwordless-sudo).
