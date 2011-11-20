---
layout: post
title: "Enlightenment no Ubuntu Hardy"
date: 2008-11-04 11:39
comments: true
categories: [desktop, linux, ubuntu]
---

A versão disponível do Enlightenment está um pouco atrasada nos repositórios do Ubuntu (e do Debian).

Vindo disso é possível instalar uma versão nova, para isso adicione ao /etc/apt/sources.list do Ubuntu, versão Hardy:

    deb http://e17.dunnewind.net/ubuntu hardy e17

E marque para instalação o pacote de nome **e17** ou use na linha de comando:

    aptitude install e17
