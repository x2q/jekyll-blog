---
layout: post
title: "Software du2sort"
date: 2008-05-01 04:50
comments: true
categories: [labs, terminal, tools]
---

Programa para ordenar a saída do comando du.

# A necessidade

O programa *du* exibe a estimativa de uso do disco de determinado arquivo ou diretório (com o uso do parâmetro ``s``), mas sua saída não é ordenada:

    % du -sh ~/programming/*
    2,4M	/home/dmitry/programming/asm
    160K	/home/dmitry/programming/awk
    11M	/home/dmitry/programming/cpp
    123M	/home/dmitry/programming/java
    7,8M	/home/dmitry/programming/Linux_Programming.pdf
    792K	/home/dmitry/programming/lua
    200K	/home/dmitry/programming/make
    43M	/home/dmitry/programming/netbeans
    5,3M	/home/dmitry/programming/perl
    77M	/home/dmitry/programming/php
    4,1M	/home/dmitry/programming/python
    42M	/home/dmitry/programming/ruby
    4,8M	/home/dmitry/programming/sed
    2,1M	/home/dmitry/programming/shell

Isso é resolvido facilmente pelo *sort*:

    % du -s ~/programming/* | sort -nr
    125656	/home/dmitry/programming/java
    78284	/home/dmitry/programming/php
    43540	/home/dmitry/programming/netbeans
    42604	/home/dmitry/programming/ruby
    11152	/home/dmitry/programming/cpp
    7916	/home/dmitry/programming/Linux_Programming.pdf
    5352	/home/dmitry/programming/perl
    4896	/home/dmitry/programming/sed
    4168	/home/dmitry/programming/python
    2440	/home/dmitry/programming/asm
    2096	/home/dmitry/programming/shell
    792	/home/dmitry/programming/lua
    200	/home/dmitry/programming/make
    160	/home/dmitry/programming/awk

Mas o parâmetro ``h`` não usado faz com que seja necessário novamente rodar ``du -sh`` para voltar a visão humana.

A necessidade surgiu da repetição.

# Descrição

Como visto anteriormente o *du2sort* ordena a estimativa de uso do disco:

    % du2sort ~/programming/
    123M	java
    77M	php
    43M	netbeans
    42M	ruby
    11M	cpp
    7,8M	Linux_Programming.pdf
    5,3M	perl
    4,8M	sed
    4,1M	python
    2,4M	asm
    2,1M	shell
    792K	lua
    200K	make
    160K	awk

Para ver somente diretórios:

    % du2sort -d ~/programming/
    123M	java/
    77M	php/
    43M	netbeans/
    42M	ruby/
    11M	cpp/
    5,3M	perl/
    4,8M	sed/
    4,1M	python/
    2,4M	asm/
    2,1M	shell/
    792K	lua/
    200K	make/
    160K	awk/

Para ver somente arquivos específicos:

    % du2sort ~/programming/{asm,ruby}
    42M	/home/dmitry/programming/ruby
    2,1M	/home/dmitry/programming/shell

Veja na saída de ajuda do du2sort, quando eu aprender a fazer páginas de manual eu faço uma:

    % du2sort -h
    Usage:
      du2sort                       to sort all files of working directory
      du2sort -d                    to sort only directories of working directory
      du2sort -d <directory>        to sort only directories of selected directory
      du2sort <directory>           to sort all files of selected directory
      du2sort <file> <file> ...     to sort selected files

# Bugs

Este script é derivado do du, por isso, mostra a estimativa de uso do disco. Isso significa que, por exemplo: a instalação padrão Debian usa blocos de 4K por isso diretórios e arquivos terão no mínimo 4k, veja o exemplo a seguir de quatro diretórios vazios:

    % mkdir ola{1,2,3,4} >> du2sort ola*
    4,0K	ola4
    4,0K	ola3
    4,0K	ola2
    4,0K	ola1

Ainda não é reconhecido espaços em nomes de arquivos:

    % ls ~/.wine/drive_c
    Arquivos de programas
    windows

    % du2sort ~/.wine/drive_c
    2,9M	windows
    du: impossí­vel acessar `Arquivos': Arquivo ou diretório não encontrado

# Download

Páginas e arquivos principais:

* Filtre os [marcador de laboratório](#);
* O pacote debian: [du2sort_4.0.2release1_all.deb](#);
* O shell script puro, sem página de manual: [du2sort](#);
* Ou você pode adicionar o [Repositório do Site](/repositorio-do-site/).

