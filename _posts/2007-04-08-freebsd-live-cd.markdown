---
layout: post
title: "FreeBSD Live CD"
date: 2007-04-08 04:52
comments: true
categories: [cd, freebsd, live cd]
---

Como tornar o FreeBSD um Live CD.

# Obtendo o FreeBSD

Não será preciso fazer download de arquivos _iso_ além do seu sistema FreeBSD para qualquer instalação padrão. Obtendo seus CDs faça uma instalação normal e conforme fizer em seu HD será no live CD,  afinal faremos o live CD como uma cópia do que estiver no HD, inclusive arquivos de configurações e até arquivos pessoais se você não der uma última olhada e apagar o que for desnecessário.

# Copiando os Arquivos para a Raiz do Live CD

Crie o diretório _/livecd_ e copie todos os arquivos da raiz para este diretório:

    # mkdir /livecd
    # cp -fr / /livecd

Caso não dê certo sugiro que compacte o diretório raiz e depois descompacte em _/livecd_, isso dará certo pelo fato de que o **tar** ao compactar ignora socktes, dispositivos e outras inapropriações e conserva as permissões:

    # tar cfzp /livecd_compacted.tar.gz /
    tar: Removing leading '/' from member names
    tar: /livecd_compacted.tar.gz: Can't add archive to itself
    tar: /var/run/devd.pipe: tar format cannot archive socket: Inappropriate file
    type or format
    tar: /var/run/log: tar format cannot archive socket: Inappropriate file type
    or format
    tar: /var/run/logpriv: tar format cannot archive socket: Inappropriate file
    type or format

    # tar xfzp /livecd_compacted.tar.gz -C /livecd

Fiz compactado pois pode querer usar o arquivo novamente.

# Áreas de Escrita

Dentro de _/mnt_ crie o diretório _mdfs_.

O sistema precisará de áreas de gravação, além de arquivos de log, creio que você vai querer fazer alterações para testar o CD, para estas área que precisem de gravação usaremos o recurso Memory Disks.

Após a linha ``. /etc/rc.subr`` em _/livecd/etc/rc_ adicione ``sh /etc/rc.d/rc.diskless``, ou seja, deve ficar desta forma:

    . /etc/rc.subr
    sh /etc/rc.d/rc.diskless

Crie e edite o arquivo _/livecd/etc/rc.d/rc.diskless_:

    #!/bin/sh
    # /livecd/etc/rc.d/rc.diskless

    # swap
    mdconfig -a -t malloc -o compress -s 30m -u 0
    swapon /dev/md0

    # /etc
    mdconfig -a -t malloc -o compress -s 4m -u 1
    newfs -U -O 2 md1 > /dev/null 2>&1

    # /usr/local/etc
    mdconfig -a -t malloc -o compress -s 1m -u 2
    newfs -U -O 2 md2 > /dev/null 2>&1

    # /var
    mdconfig -a -t malloc -o compress -s 20m -u 3
    newfs -U -O 2 md3 > /dev/null 2>&1

    # /root
    mdconfig -a -t malloc -o compress -s 3m -u 4
    newfs -U -O 2 md4 > /dev/null 2>&1

    # montando todos os MDfs's
    mount -a

    # descompactando os arquivos dos MDfs's
    tar xfjp /mnt/mdfs/var.tar.bz2 -C /
    tar xfjp /mnt/mdfs/etc.tar.bz2 -C /
    tar xfjp /mnt/mdfs/usr_local_etc.tar.bz2 -C /
    tar xfjp /mnt/mdfs/root.tar.bz2 -C /

Este script monta na memória as áreas de escrita e se encarregará também de descompactar o conteúdo dos diretórios que compactaremos, mas antes edite o arquivo _/livecd/etc/fstab_ para que os diretórios sejam montados no boot e tenham permissão de escrita.

    /dev/acd0   /               cd9660    ro   0   0
    proc        /proc           procfs    rw   0   0
    /dev/md1    /etc            ufs       rw   0   0
    /dev/md2    /usr/local/etc  ufs       rw   0   0
    /dev/md3    /var            ufs       rw   0   0
    /dev/md4    /root           ufs       rw   0   0
    
Feito as alterações em _/etc/</span> agora compactaremos os diretórios: _/livecd/etc_, _/livecd/usr/local/etc_, _/livecd/var/_ e _/livecd/root_; não esqueça de fazer isso dentro de _/livecd_, pois se compactados usando seu endereço completo quando for descompactar descompactará usando seu endereço completo também, por exemplo: se compactado com **tar cfjp /livecd/mnt/var.tar.gz /livecd/var**, será descompactado para _/livecd/var/_ quando o que realmente queremos é o diretório _/var_ descompactado na raiz do live cd.

    # cd /livecd/
    # tar cfjp /livecd/mnt/mdfs/var.tar.bz2 var
    # tar cfjp /livecd/mnt/mdfs/etc.tar.bz2 etc
    # tar cfjp /livecd/mnt/mdfs/usr_local_etc.tar.bz2 usr/local/etc
    # tar cfjp /livecd/mnt/mdfs/root.tar.bz2 root

# Recompilando o Kernel

Não precisei recompilar meu kernel, tentei fazer o boot sem recompilar o kernel dando certo não busquei informações sobre como recompilá-lo.

Mas caso precise recompilar o kernel e o diretório **/livecd/** já esteja com todo sistema copiado e devidamente configurado, copie o kernel recompilado e os módulos de _/boot/kernel_ para a raiz do live CD, como no comando abaixo:

    # cp -fr /boot/kernel/* /livecd/boot/kernel/

# Criando a Imagem iso e Queimando o CD

Para poder carregar o sistema a partir do CD é necessário o arquivo _cdboot_ se não tiver na instalação do HD copie do CD-ROM ambos estão no diretório _boot_ a partir da _raiz_.

A imagem _iso_ se faz com o comando:

    # cd /
    # mkisofs -b boot/cdboot -no-emul-boot -c boot/boot.catalog -V "livebsd" -o /live.iso livecd

Para fazer a gravação do CD:

    # burncd -e -f /dev/acd0 data live.iso fixate

# Informações Finais

Seguindo tudo isso, para mim funciona, basta instalar pacotes extras como para gravação de CDs e os necessários para seus testes e remover os arquivos extras como o ports em _/usr/ports_ com 239 Megabytes, além do ports não creio que o código fonte em _/usr/src_ com 99 Megabytes precise estar no live.

Tomei como base este artigo no Viva o Linux: [http://www.vivaolinux.com.br/artigos/verArtigo.php?codigo=4414](http://www.vivaolinux.com.br/artigos/verArtigo.php?codigo=4414); veja este também de como reduzir o tamanho de uma instalação do FreeBSD: [http://neon1.net/misc/minibsd.html](http://neon1.net/misc/minibsd.html).

Atualizado em 22 de abril de 2007.
