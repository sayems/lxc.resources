# LXD/LXC Resources

**L**inu**X** **C**ontainers (LXC) is an operating system-level virtualization method for running multiple isolated Linux systems (containers) on a single control host (LXC host).

LXD is the newer, better way to interface with LXC. LXD provides a system-wide daemon, a new LXC command-line client. The daemon exports a REST API, which makes the entire LXD experience very powerful and extremely simple to use.

In this tutorial, I’ll walk through the installation of LXD, ZFS and Bridge-Utils on Ubuntu 18.04 and show you how to provision, deploy, and configure containers remotely.

**Note** This walkthrough assumes you already have a **```Ubuntu 18.04```** up and running on your PC. If you do not, please download and install it now.

&nbsp;

Table of contents
--
- [Installation](https://github.com/sayems/lxc.resources/wiki/Installing-and-configuring-LXD#installation)
- [Configuration](https://github.com/sayems/lxc.resources/wiki/Installing-and-configuring-LXD#configuration)
- [LXD Profile](https://github.com/sayems/lxc.resources/wiki/Installing-and-configuring-LXD#profile)
- [Getting started](https://github.com/sayems/lxc.resources/wiki/Installing-and-configuring-LXD#getting-started)
- [Run Vagrant box on LXD/LXC](https://github.com/sayems/lxc.resources/wiki/LXC-provider-for-Vagrant)
- [Setup k8s on LXD/LXC](https://github.com/sayems/lxc.resources/wiki/Kubernetes-on-Linux-containers)
- [LXD/LXC Cheat Sheet](https://github.com/sayems/lxc.resources/wiki/LXC-and-LXD-Cheat-Sheet)

&nbsp;

