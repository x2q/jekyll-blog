---
layout: post
title: "Reinstalar VirtualBox Guest Additions Usando Vagrant"
date: 2012-05-20 22:53
comments: true
categories: [vb, vagrant, ruby]
---

Usando uma máquina virtual ubuntu percebi que ao fazer uma atualização
completa do sistema e reiniciar a máquina o seguinte erro passa a surgir
na tela:

    test-vm% vagrant up
    [default] VM already created. Booting if it's not already running...
    [default] Clearing any previously set forwarded ports...
    [default] Forwarding ports...
    [default] -- 22 => 2222 (adapter 1)
    [default] Creating shared folders metadata...
    [default] Clearing any previously set network interfaces...
    [default] Preparing network interfaces based on configuration...
    [default] Booting VM...
    [default] Waiting for VM to boot. This can take a few minutes.
    [default] VM booted and ready for use!
    [default] Configuring and enabling network interfaces...
    [default] Mounting shared folders...
    [default] -- v-root: /vagrant
    The following SSH command responded with a non-zero exit status.
    Vagrant assumes that this means the command failed!

    mount -t vboxsf -o uid=`id -u vagrant`,gid=`id -g vagrant` v-root /vagrant

Para corrigir isso basta reinstalar VirtualBox Additions. O jeito mais fácil,
como o [@esmerinocosta](http://twitter.com/esmerinocosta) comentou é entrar na
máquina virtual e executar:

    vagrant@precise64:~$ sudo /etc/init.d/vboxadd setup

Mais se tiver atualizado o VirtualBox ou tiver pego uma box antiga a gem
*vagrant-vbguest* automatizar total ou parcialmente o processo.

# Usando vagrant-vbguest:

Caso você tenha uma conexão ruim ou queira baixar a iso do VBoxGuestAdditions
apenas uma vez:

Primeiro adicione essa linha no `Vagrantfile`:

    Vagrant::Config.run do |config|
      config.vbguest.auto_update = false
    end

Isso vai impedir que o *tudo* seja feito de forma automatizada.

Baixe a `iso`, no meu caso eu baixei assim:

    test-vm% wget -c http://download.virtualbox.org/virtualbox/4.1.14/VBoxGuestAdditions_4.1.14.iso

Instalar a gem *vagrant-vbguest*:

    test-vm% gem install vagrant-vbguest

Com a ISO baixada e a gem instalada basta rodar este commando:

    test-vm% vagrant vbguest -f --iso ./VBoxGuestAdditions_4.1.14.iso
    [default] Detected Virtualbox Guest Additions 4.1.14 --- OK.
    [default] Forcing installation of Virtualbox Guest Additions 4.1.14 - guest's version is 4.1.14
    [default] Copy iso file ./VBoxGuestAdditions_4.1.14.iso into the box /tmp/VBoxGuestAdditions.iso
    [default] Copy installer file setup_debian.sh into the box /tmp/install_vbguest.sh
    stdin: is not a tty
    Reading package lists...
    Building dependency tree...
    Reading state information...
    linux-headers-3.2.0-24-generic is already the newest version.
    linux-headers-3.2.0-24-generic set to manually installed.
    The following extra packages will be installed:
      fakeroot make patch
    Suggested packages:
      make-doc diffutils-doc
    The following NEW packages will be installed:
      dkms fakeroot make patch
    dpkg-preconfigure: unable to re-open stdin: No such file or directory
    0 upgraded, 4 newly installed, 0 to remove and 0 not upgraded.
    Need to get 0 B/359 kB of archives.
    After this operation, 1,219 kB of additional disk space will be used.
    Selecting previously unselected package make.
    (Reading database ... 55209 files and directories currently installed.)
    Unpacking make (from .../make_3.81-8.1ubuntu1_amd64.deb) ...
    Selecting previously unselected package patch.
    Unpacking patch (from .../patch_2.6.1-3_amd64.deb) ...
    Selecting previously unselected package dkms.
    Unpacking dkms (from .../dkms_2.2.0.3-1ubuntu3_all.deb) ...
    Selecting previously unselected package fakeroot.
    Unpacking fakeroot (from .../fakeroot_1.18.2-1_amd64.deb) ...
    Processing triggers for man-db ...
    Setting up make (3.81-8.1ubuntu1) ...
    Setting up patch (2.6.1-3) ...
    Setting up dkms (2.2.0.3-1ubuntu3) ...
    Setting up fakeroot (1.18.2-1) ...
    update-alternatives: using /usr/bin/fakeroot-sysv to provide /usr/bin/fakeroot (fakeroot) in auto mode.
    mount: warning: /mnt seems to be mounted read-only.
    Verifying archive integrity... All good.
    Uncompressing VirtualBox 4.1.14 Guest Additions for Linux.........
    VirtualBox Guest Additions installer
    Removing installed version 4.1.14 of VirtualBox Guest Additions...
    Removing existing VirtualBox DKMS kernel modules ...done.
    Removing existing VirtualBox non-DKMS kernel modules ...done.
    Building the VirtualBox Guest Additions kernel modules ...done.
    Doing non-kernel setup of the Guest Additions ...done.
    Starting the VirtualBox Guest Additions ...done.
    Installing the Window System drivers ...fail!
    (Could not find the X.Org or XFree86 Window System.)

E quando a máquina for iniciar novamente:

    test-vm% vagrant up
    [default] VM already created. Booting if it's not already running...
    [default] Clearing any previously set forwarded ports...
    [default] Forwarding ports...
    [default] -- 22 => 2222 (adapter 1)
    [default] Creating shared folders metadata...
    [default] Clearing any previously set network interfaces...
    [default] Preparing network interfaces based on configuration...
    [default] Booting VM...
    [default] Waiting for VM to boot. This can take a few minutes.
    [default] VM booted and ready for use!
    [default] Detected Virtualbox Guest Additions 4.1.14 --- OK.
    [default] Configuring and enabling network interfaces...
    [default] Mounting shared folders...
    [default] -- v-root: /vagrant

O erro não surge mais e ele monta o diretório em `/vagrant`.

A saída abaixo foi capturada usando a forma *totalmente* automatizada (sem o
`config.vbguest.auto_update = false` no `Vagrantfile`):

    % vagrant up
    [default] Importing base box 'precise64'...
    [default] The guest additions on this VM do not match the install version of
    VirtualBox! This may cause things such as forwarded ports, shared
    folders, and more to not work properly. If any of those things fail on
    this machine, please update the guest additions and repackage the
    box.

    Guest Additions Version: 4.1.14
    VirtualBox Version: 4.2.4
    [default] Matching MAC address for NAT networking...
    [default] Clearing any previously set forwarded ports...
    [default] Forwarding ports...
    [default] -- 22 => 2222 (adapter 1)
    [default] Creating shared folders metadata...
    [default] Clearing any previously set network interfaces...
    [default] Preparing network interfaces based on configuration...
    [default] Booting VM...
    [default] Waiting for VM to boot. This can take a few minutes.
    [default] VM booted and ready for use!
    [default] Installing Virtualbox Guest Additions 4.2.4 - guest's version is 4.1.14
    [default] Copy iso file /usr/share/virtualbox/VBoxGuestAdditions.iso into the box /tmp/VBoxGuestAdditions.iso
    [default] Copy installer file setup_debian.sh into the box /tmp/install_vbguest.sh
    stdin: is not a tty
    stdin: is not a tty
    Reading package lists...
    Building dependency tree...
    Reading state information...
    The following extra packages will be installed:
      fakeroot linux-headers-3.2.0-23 make patch
    Suggested packages:
      make-doc diffutils-doc
    The following NEW packages will be installed:
      dkms fakeroot linux-headers-3.2.0-23 linux-headers-3.2.0-23-generic make
      patch
    0 upgraded, 6 newly installed, 0 to remove and 10 not upgraded.
    Need to get 12.7 MB of archives.
    After this operation, 68.5 MB of additional disk space will be used.
    Get:1 http://us.archive.ubuntu.com/ubuntu/ precise/main make amd64 3.81-8.1ubuntu1 [118 kB]
    Get:2 http://us.archive.ubuntu.com/ubuntu/ precise/main patch amd64 2.6.1-3 [80.2 kB]
    Get:3 http://us.archive.ubuntu.com/ubuntu/ precise/main dkms all 2.2.0.3-1ubuntu3 [73.1 kB]
    Get:4 http://us.archive.ubuntu.com/ubuntu/ precise/main fakeroot amd64 1.18.2-1 [87.2 kB]
    Get:5 http://us.archive.ubuntu.com/ubuntu/ precise/main linux-headers-3.2.0-23 all 3.2.0-23.36 [11.4 MB]
    Get:6 http://us.archive.ubuntu.com/ubuntu/ precise/main linux-headers-3.2.0-23-generic amd64 3.2.0-23.36 [947 kB]
    dpkg-preconfigure: unable to re-open stdin: No such file or directory
    Fetched 12.7 MB in 2min 58s (71.3 kB/s)
    Selecting previously unselected package make.
    (Reading database ... 51083 files and directories currently installed.)
    Unpacking make (from .../make_3.81-8.1ubuntu1_amd64.deb) ...
    Selecting previously unselected package patch.
    Unpacking patch (from .../patch_2.6.1-3_amd64.deb) ...
    Selecting previously unselected package dkms.
    Unpacking dkms (from .../dkms_2.2.0.3-1ubuntu3_all.deb) ...
    Selecting previously unselected package fakeroot.
    Unpacking fakeroot (from .../fakeroot_1.18.2-1_amd64.deb) ...
    Selecting previously unselected package linux-headers-3.2.0-23.
    Unpacking linux-headers-3.2.0-23 (from .../linux-headers-3.2.0-23_3.2.0-23.36_all.deb) ...
    Selecting previously unselected package linux-headers-3.2.0-23-generic.
    Unpacking linux-headers-3.2.0-23-generic (from .../linux-headers-3.2.0-23-generic_3.2.0-23.36_amd64.deb) ...
    Processing triggers for man-db ...
    Setting up make (3.81-8.1ubuntu1) ...
    Setting up patch (2.6.1-3) ...
    Setting up dkms (2.2.0.3-1ubuntu3) ...
    Setting up fakeroot (1.18.2-1) ...
    update-alternatives: using /usr/bin/fakeroot-sysv to provide /usr/bin/fakeroot (fakeroot) in auto mode.
    Setting up linux-headers-3.2.0-23 (3.2.0-23.36) ...
    Setting up linux-headers-3.2.0-23-generic (3.2.0-23.36) ...
    Examining /etc/kernel/header_postinst.d.
    run-parts: executing /etc/kernel/header_postinst.d/dkms 3.2.0-23-generic /boot/vmlinuz-3.2.0-23-generic
    mount: warning: /mnt seems to be mounted read-only.
    Verifying archive integrity... All good.
    Uncompressing VirtualBox 4.2.4 Guest Additions for Linux..........
    VirtualBox Guest Additions installer
    Removing installed version 4.1.14 of VirtualBox Guest Additions...
    Removing existing VirtualBox DKMS kernel modules ...done.
    Removing existing VirtualBox non-DKMS kernel modules ...done.
    Building the VirtualBox Guest Additions kernel modules ...done.
    Doing non-kernel setup of the Guest Additions ...done.
    You should restart your guest to make sure the new modules are actually used

    Installing the Window System drivers ...fail!
    (Could not find the X.Org or XFree86 Window System.)
    [default] Restarting VM to apply changes...
    [default] Attempting graceful shutdown of VM...
    [default] Clearing any previously set forwarded ports...
    [default] Forwarding ports...
    [default] -- 22 => 2222 (adapter 1)
    [default] Creating shared folders metadata...
    [default] Clearing any previously set network interfaces...
    [default] Preparing network interfaces based on configuration...
    [default] Booting VM...
    [default] Waiting for VM to boot. This can take a few minutes.
    [default] VM booted and ready for use!
    [default] Detected Virtualbox Guest Additions 4.2.4 --- OK.
    [default] Configuring and enabling network interfaces...
    [default] Mounting shared folders...
    [default] -- v-root: /vagrant
    [default] Configuring and enabling network interfaces...
    [default] Mounting shared folders...
    [default] -- v-root: /vagrant

