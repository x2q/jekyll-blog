---
layout: post
title: "Informações"
date: 2007-01-09 05:23
comments: true
categories: [info, linux, terminal, tools, unix]
---

Como obter informações em linha de comando nos Unixes.

# Sobre o Sistema

## dmesg

Mostra as mensagem de inicialização do sistema.

## uname

Mostra informações sobre o sistema, o parâmetro que mostra todas as informações possíveis ``-a``:

    % uname -a
    Linux desktop 2.6.15-26-386 #1 PREEMPT Thu Aug 3 02:52:00 UTC 2006 i686
    GNU/Linux

O exemplo acima é para Ubuntu, veja adiante Debian e FreeBSD, respectivamente:

    % uname -a
    Linux debian 2.6.18-4-686 #1 SMP Wed May 9 23:03:12 UTC 2007 i686 GNU/Linux

    % uname -a
    FreeBSD  6.1-RELEASE FreeBSD 6.1-RELEASE #0: Sun May  7 04:32:43 UTC 2006     
    root@opus.cse.buffalo.edu:/usr/obj/usr/src/sys/GENERIC  i386

Quando chamado sem parâmetros imprime somente _Linux_ ou _FreeBSD_.

Além de **uname** é muito comum em GNU/Linux é o arquivo _/etc/issue_ que contém a distribuição, como no exemplo abaixo.

    Ubuntu 6.06.1 LTS n l

# Sobre os Usuários

## last

Mostra uma lista dos últimos usuários logados no sistema.

## who

Os usuários logados atualmente no sistema:

    % who
    root             ttyv0    Apr 11 17:44

## w

Os usuários logados no sistema e qual comando estão executando.

    % w
     5:57PM  up 14 mins, 1 user, load averages: 0.00, 0.02, 0.04
    USER             TTY      FROM              LOGIN@  IDLE WHAT
    root             v0       -                 5:44PM     - w<

# Sobre os Discos

Com o **df** pode-se ter uma estimativa do uso do disco em kilobytes, use **df -h** para mostrar uma forma humana:

    # df -h
    Sist. Arq.            Tam   Usad Disp  Uso% Montado em
    /dev/hda6             2,3G  1,8G  366M  84% /
    varrun                300M   96K  300M   1% /var/run
    varlock               300M  4,0K  300M   1% /var/lock
    udev                  300M  100K  300M   1% /dev
    devshm                300M     0  300M   0% /dev/shm
    lrm                   300M   19M  282M   7% /lib/modules/2.6.15-26-386/volatile
    /dev/hda5              19G   16G  1,6G  91% /usr

Atualizado em 01 de Março de 2008.
