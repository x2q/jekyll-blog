---
layout: post
title: "Criar Pacotes Debian"
date: 2009-02-13 05:23
comments: true
categories: [deb, debian, software]
---

A distribuição Debian criou o formato de pacote pré-compilado deb.

Neste post tento mostrar como criar um pacote debian.

# Estrutura de Diretórios

O diretório de pacotes usa a seguinte estrutura, segundo o comando **tree**:

    machine% tree -F debianpkg
    debianpkg/
    `-- DEBIAN/
        `-- control

O que estiver dentro do diretório DEBIAN serve apenas para controle de informações, tarefas a serem executadas antes/após a instalação, md5sum, entre outros.

O que estiver abaixo do diretório do pacote, no exemplo debianpkg, será adicionado na raiz do sistema que instalará este pacote. Por exemplo: se existir arquivo teste dentro do diretório do pacote, quando este pacote for instalado o arquivo teste do pacote será colocado em /teste.

# O Arquivo control

O arquivo control define as propriedades do pacote, como, por exemplo: nome, versão, autor, dependência e descrição. Estas informações além de auxiliar na base de dados de pacotes instalados no computador, também é usado para construir o repositório.

Veja adiante um exemplo do arquivo control:

    Package: du2sort
    Version: 4.0.2release2
    Architecture: all
    Maintainer: Dmitry <dmitry@mailer.com>
    Depends: coreutils
    Section: utils
    Description: To sort `du -sh' output
     du2sort use du to sort sizes and print size in human readable format.

As informações postas no exemplo são as mais básicas pra ter num pacote. Veja a descrição:

* Package: nome do pacote;
* Version: versão do pacote;
* Architecture: arquitetura que o pacote pode ser instalado, ``all`` indica qualquer uma, muito usada por scripts em shell, ruby, python, dentre outros;
* Maintainer: o mantenedor (não necessariamente o dono-criador do pacote/software);
* Depends: a dependência do pacote, o pacote pode ser dependente de uma versão específica de um pacote;
* Section: A seção que o pacote se enquadra, este é apenas para ser usado na construção do repositório e na visualização com aptitude ou synaptic, outros exemplos: games, network, utils, x11, multimedia, tools...
* Description: Informa uma descrição sobre o pacote. Tem a utilização no mesmo local que _Section_.

# Construindo o Pacote

Use o comando dpkg-deb da seguinte forma para construir pacotes debian:

    machine% dpkg-deb -b debianpkg
    dpkg-deb: construindo pacote 'du2sort' em 'debianpkg.deb'.

Veja que foi criado um pacote debian com o nome de nomedodiretorio.deb. Eu costumo usar o build-deb*, um shell script criado por mim, que obtêm a partir do arquivo control o nome do pacote, a versão e a arquitetura para criar o pacote neste formato: nomedopacote_versão_arquitetura.deb, além de adicionar um arquivo md5sums que contém os md5sums do pacote.

Veja mais em [repositório deste site](/repositorio-do-site/).
