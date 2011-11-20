---
layout: post
title: "Google no Computador"
date: 2008-12-11 14:29
comments: true
categories: [desktop, google]
---

Eu tentei muito usar o [Beagle](http://packages.ubuntu.com/beagle) e o [Tracker](http://packages.ubuntu.com/tracker), mas não consegui pelo simples motivo de já ter usado o [Google Desktop](http://desktop.google.com) (no Linux, claro).

Assim como os outros dois citados anexa arquivos de texto (TXT, HTML, PDF, OpenDocument, dentre outros), imagens (JPEG, GIF, PNG, ...) e arquivos de áudio com o diferencial de catalogar e-mails (local e do Gmail).

# Instalação

## Baixando o Pacote

Para instalar basta ir na página de download: [http://desktop.google.com/pt/BR/linux/download.html](http://desktop.google.com/pt/BR/linux/download.html), escolher a plataforma (deb/rpm e 32/64 bits), aceitar, baixar o pacote deb/rpm e instalar usando o Gdebi.

## Adicionando os Repositórios

É bem mais rápido usar a linha de comando para instalar, basta usar estes comandos:

### Adicionar as chaves de assinatura

Como root:

    # wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
    # apt-get update

### Adicionar o Repositório do Google no Sources.list

Colocar no arquivo /etc/apt/souces.list a seguinte linha:

    deb http://dl.google.com/linux/deb/ stable non-free</span>

Pode ser editado com o [Vim](/vim/) ou a linha:

    # echo "deb http://dl.google.com/linux/deb/ stable non-free" >> /etc/apt/sources.list

Após adicionar atualize a base de dados do apt:

    # aptitude update

### Instalar

    # aptitude install google-desktop

Links de ajuda do Google:

* [APT](http://www.google.com/linuxrepositories/apt.html), para adicionar em linha de comando;
* [Ubuntu 7.04](http://www.google.com/linuxrepositories/ubuntu704.html), para adicionar usando o Synaptic, apesar de usar a versão 7.04 como exemplo Ubuntu ainda é válido para versões posteriores e para o Debian.
