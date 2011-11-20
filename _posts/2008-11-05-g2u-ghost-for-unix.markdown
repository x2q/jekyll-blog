---
layout: post
title: "g2u - Ghost For Unix"
date: 2008-11-05 13:10
comments: true
categories: [ghost, software, unix]
---

O Ghost para o Unix é uma tarefa bastante trivial, sério apenas use o comando **dd** que existe em todos os Unixes.

O g4u (Ghosting for Unix) é um live cd baseado no [NetBSD](http://www.netbsd.org/) extremamente pequeno e customizado para manipular HDs inteiros ou partições, i. e., copiar um HD para outro na mesma máquina ou para copiar uma imagem de HD para um servidor.

Site: [http://www.feyrer.de/g4u/](http://www.feyrer.de/g4u/).

# Antes de Tudo: Identificar os Discos

Você pode ver os discos e como são identificados no sistema com o comando: **disks** e para ver as partições no disco o comando: ``parts disco``.

Os discos são identificados como ``wd0`` para o primeiro IDE, ``wd1`` para o segundo IDE, ``sd0`` para o primeiro SCSI.

# De Um Disco Para o Outro (No Mesmo Computador)

Antes de entrar na configuração de servidor e cliente vejamos uma simples cópia de um HD para outro, use a seguinte sintaxe:

    g4u> copydisk origem destino

# Usando um Servidor

A parte mais interessante do g4u é a possibilidade de ter um servidor para as imagens de HD, bastando para isso apenas (ou qualquer) servidor de FTP.

## Criando o servidor

O servidor de FTP que usei no Ubuntu Server Hardy foi o Pure FTP.

Marque no Synaptic o pacote [pure-ftp](http://packages.ubuntu.com/pure-ftpd) para instalação ou use a seguinte linha, no terminal:

    servidor# aptitude install pure-ftp

Agora crie um usuário para o FTP, inclusive com senha.

## Cliente

Baixe do site do g4u na parte [3. Requirements & Download](http://www.feyrer.de/g4u/#reqs) uma imagem de disquete ou de CD-ROM.

**Update**: Verifiquei que o UBCD ([http://www.ultimatebootcd.com/](http://www.ultimatebootcd.com)) também tem o g4u.

Confira o md5sum e grave-a em CD ou disquete.

Pronto seu cliente já está preparado.

Inicie o computador pelo disquete ou CD-ROM gravado e use os comandos abaixo:

Copiar HDs (**uploaddisk**) ou partições (**uploadpart**) para o servidor, comando :

    g4u> uploaddisk usuario@servidor nomedaimagem.gz disco

Copiar imagens do servidor:

    g4u> slurpdisk usuario@servidor nomedaimagem.gz disco

No qual:

* _usuario@servidor_ pode ser o endereço ip do servidor ou o nome (desde que no dns), caso não seja informado o nome de usuário ele tentará usar o usuário _install_;
* em _nomedaimagem.gz_ é o nome do arquivo que ficará a imagem;
* e _disco_ é uma parâmetro opcional para usar.

Atualizado em: 20 de Novembro de 2008.
