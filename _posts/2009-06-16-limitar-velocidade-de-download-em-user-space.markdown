---
layout: post
title: "Limitar velocidade de download em user-space"
date: 2009-06-16 04:49
comments: true
categories: [download, limit, software, userspace]
---

Alguns usuários são conscientes do consumo de banda de seus downloads, mas nem sempre a ferramenta de download permite que seja feito alguma forma de limite, i. e., limite em "espaço de usuário".

O wget e o gPodder permitem o controle da taxa de download e este último também da quantidade de downloads simultaneos, porém alguns programas não permitem esse limite, como o debmirror.

Para a solução deste problema existe o projeto Trickle.

Para instalar em ambiente debian ou Ubuntu basta usar o aptitude:

    cpd102[pts/1]% sudo aptitude install trickle

Exemplos de uso:

    cpd102[pts/1]% trickle -d 50 wget http://download.blender.org/apricot/yofrankie_bge.zip

    cpd102[pts/1]% trickle -d 50 \
    debmirror -p --debug --ignore-missing-release --ignore-release-gpg --postcleanup \
    --nosource --proxy=http://192.168.1.254:3128/ --arch=i386 -e http \
    --host=br.archive.ubuntu.com --root=ubuntu --dist=jaunty,jaunty-updates,jaunty-security \
    --section=main,main/debian-installer,multiverse,restricted,universe /home/mirror/ubuntu

