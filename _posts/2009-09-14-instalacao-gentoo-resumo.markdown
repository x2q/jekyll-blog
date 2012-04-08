---
layout: post
title: "Instalação Gentoo - Resumo"
date: 2009-09-14 10:14
comments: true
categories: [gentoo, install]
---

O Gentoo é uma distribuição linux de total personalização.

Neste tutorial vou informar quais são os passos para a instalação e
configuração do Gentoo. E como é mais um lembrete do que é necessário do
que um guia passo-a-passo não vou me ater a configurações minuciosas,
desta forma não recomendo para iniciantes.

É necessário o download da iso e no momento da instalação também será
requerido arquivos para download, como o kernel linux e outros
utilitários:

* [install-x86-minimal-20090901.iso](http://www.las.ic.unicamp.br/pub/gentoo/releases/x86/current-iso/install-x86-minimal-20090901.iso) 104M;
* [stage3-i686-20090901.tar.bz2](http://www.las.ic.unicamp.br/pub/gentoo/releases/x86/current-iso/stage3-i686-20090901.tar.bz2) 119,1M;
* [portage-20090913.tar.bz2](http://www.las.ic.unicamp.br/pub/gentoo/snapshots/portage-20090913.tar.bz2) 34,9M;
* e cerca de 70M que será baixado para o kernel linux e outros
  utilitários durante a instalação.

Nota: Você pode ter qualquer Linux Live CD, qualquer linux tem as
ferramentas necessárias antes de entrar no gentoo para instalar o

# Particionar e Formatar Discos

A tabela de partição do disco pode ser formatada com o fdisk ou cfdisk.

Após a formatação use um destes comandos para criar o sistema de
arquivos na partição: `mkfs.ext2`, `mkfs.ext3`, `mkfs.ext4` e/ou
`mkfs.reiserfs`.

Após este particionamento e formatação monte o novo sistema de arquivos
como se a raiz fosse em `/mnt/gentoo`.

# Stage3

Baixe o stage3 previamente ou no momente da instalação usando o wget ou
links.

Após ter o stage3 descompacte-o dentro da nova raiz:

    livecd gentoo # tar xvjpf stage3-i686-20090901.tar.bz2 -C /mnt/gentoo

# Portage

Obtenha também o arquivo do portage e decompacte-o dentro de `/usr` dentro
da nova raiz

    livecd gentoo # tar xvjf portage-0090901.tar.bz2 -C /mnt/gentoo/usr

# Executando chroot

Se estiver instalando usando uma conexão de internet copie o arquivo
`/etc/resolv.conf`:

    livecd gentoo # cp -L /etc/resolv.conf /mnt/gentoo/etc

Monte o sistema de arquivo `/proc` e faça um bind (mais ou menos como um
mirror) de `/dev`:

    livecd gentoo # mount -t proc none /mnt/gentoo/proc
    livecd gentoo # mount -o bind /dev /mnt/gentoo/dev

Execute agora o chroot:

    livecd gentoo # chroot /mnt/gentoo /bin/bash
    livecd gentoo # env-update
    >>> Regenerating /etc/ld.so.cache...
    livecd gentoo # source /etc/profile

Por fim edite o arquivo `/etc/fstab`:

    # /etc/fstab: static file system information.
    #
    # noatime turns off atimes for increased performance (atimes normally aren't 
    # needed; notail increases performance of ReiserFS (at the expense of storage 
    # efficiency).  It's safe to drop the noatime options if you want and to 
    # switch between notail / tail freely.
    #
    # The root filesystem should have a pass number of either 0 or 1.
    # All other filesystems should have a pass number of 0 or greater than 1.
    #
    # See the manpage fstab(5) for more information.
    #

    # <fs>			<mountpoint>	<type>		<opts>		<dump/pass>

    # NOTE: If your BOOT partition is ReiserFS, add the notail option to opts.
    /dev/hda1		/boot		ext2		noauto,noatime	1 2
    /dev/hda2		/		ext3		noatime		0 1
    /dev/hda3		none		swap		sw		0 0
    /dev/cdrom		/mnt/cdrom	auto		noauto,ro	0 0
    #/dev/fd0		/mnt/floppy	auto		noauto		0 0

    # glibc 2.2 and above expects tmpfs to be mounted at /dev/shm for 
    # POSIX shared memory (shm_open, shm_unlink).
    # (tmpfs is a dynamically expandable/shrinkable ramdisk, and will
    #  use almost no memory if not populated with files)
    shm			/dev/shm	tmpfs		nodev,nosuid,noexec	0 0

# Instalando o kernel e gerenciador de boot

Neste tutorial vamos obter o fonte e um pacote para automatizar o
compilamento do kernel.

Obtendo o código-fonte do kernel:

    livecd gentoo # emerge gentoo-sources

Compilando o kernel de forma automatizada com genkernel:

    livecd gentoo # emerge genkernel
    livecd gentoo # genkernel all

Opcionalmente pode-se usar o parâmetro ``--menuconfig`` para que seja
mostrado o menu de configuração do kernel.

Pode-se usar tanto o lilo como o grub como gerenciador de boot, mas aqui
mostro a forma de instalar e configurar o grub:

Obtendo o grub:

    livecd gentoo # emerge grub

Configure em `/boot/grub/menu.lst`:

    # This is a sample grub.conf for use with Genkernel, per the Gentoo handbook
    # http://www.gentoo.org/doc/en/handbook/handbook-x86.xml?part=1&chap=10#doc_chap2
    # If you are not using Genkernel and you need help creating this file, you
    # should consult the handbook. Alternatively, consult the grub.conf.sample that
    # is included with the Grub documentation.

    default 0
    timeout 3
    #splashimage=(hd0,0)/boot/grub/splash.xpm.gz

    title=Gentoo Linux GenKernel
    root (hd0,0)
    kernel /boot/kernel-genkernel-x86-2.6.30-gentoo-r5 root=/dev/hda1
    initrd /boot/initramfs-genkernel-x86-2.6.30-gentoo-r5

E para colocar o grub na MBR

    livecd gentoo # grep -v rootfs /proc/mounts > /etc/mtab
    livecd gentoo # grub-install --no-floppy /dev/hda

# Instalação de programas extras

Syslog:

    livecd gentoo # emerge syslog-ng
    livecd gentoo # rc-update add syslog-ng default

Cron:

    livecd gentoo # emerge vixie-cron
    livecd gentoo # rc-update add vixie-cron default

Instale a(s) ferramenta(s) necessária(s) para o sistema de arquivo
instalado xfsprogs, reiserfsprogs e/ou jfsutils.

Instale as ferramentas de rede como dhcpcd ou rp-pppoe.

Configure a rede em: `/etc/conf.d/hostname`, `/etc/hosts` e
`/etc/conf.d/net`, para este último existe um exemplo em
`/etc/conf.d/net.example`.

# Usuários

Modifique a senha de root:

    livecd gentoo # passwd root

E adicione novos usuários:

    livecd gentoo # useradd -m -G users,wheel,audio -s /bin/zsh john

# Esqueça o bash e instale o zsh

    emerge zsh
