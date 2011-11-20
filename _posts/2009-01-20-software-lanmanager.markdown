---
layout: post
title: "Software LanManager"
date: 2009-01-20 14:57
comments: true
categories: [labs, software]
---

O LanManager é um shell script em linha de comando para gerenciar Lan Houses. Sendo shell script pode-se contruir várias outras interfaces para usá-lo.

# Características

Atualmente conta com uma interface em Zenity (Gnome), mas é cediço que será criado uma interface Web.

Usa o mesmo cliente para [Zeiberbude](http://sourceforge.net/projects/zeiberbude/), o zbdesk.

Para ter várias computadores gerenciando os usuários, basta exportar um diretório em nfs.

# Bugs

Procurando gerenciar usuários logados foi posto para buscar os usuários do sistema (arquivo /etc/passwd), por isso não funciona sobre NIS e o gerenciador deve rodar na máquina que tem os clientes cadastrados.

# TODO

Será posto configuração de usuários (clientes) usando o próprio LanManager.

# Downloads

* Shell script principal: [lanmanager_1.7.4release3_all.deb](#);
* Interface Zenity, depende do script principal: [lanmanager-zenity_1.7.3_all.deb](#).
* Cliente para Linux: [zbdeskBR_3.0rebuild3_i386.deb](#).

Obs.: Os pacotes foram testados em ambiente Gnu/Linux Ubuntu, mas pode-se adaptá-los a qualquer sistema. Há ainda a versão do zbdesk para Windows, mas como o foco principal do projeto é Linux será posto posteriormente.

Atualizado em 21 de Janeiro de 2008.
