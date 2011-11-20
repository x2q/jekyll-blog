---
layout: post
title: "Laboratório"
date: 2008-11-20 13:01
comments: true
categories: [labs, me]
---

Estão listados no site alguns projetos, até o momento shell script, que divulgo sobre uma licença BSD-like.

Todos os projetos estão sobre a tag _lab_:

# du2sort

O **du2sort** é um front-end para o **du** e o **sort**, i. e., obtém o tamanho e ordena os diretórios e arquivos do maior para o menor usando a unidade (KB, MB, GB, ...) mais próxima.

Veja um exemplo:

    ubuntu% du2sort ~/Programming/
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

# fduplicate

Este script procura no diretório atual quais são os arquivos duplicados, através do md5sum, veja um exemplo:

    ubuntu% fduplicate
    # ./arquivo1 ./arquivo3
    # ./arquivo4 ./arquivo2

Os arquivos que não estão duplicados não são listados e os duplicados são listados um por linha.
