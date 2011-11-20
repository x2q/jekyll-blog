---
layout: post
title: "Dividir Arquivos"
date: 2006-09-01 04:47
comments: true
categories: [split, terminal, tools, unix]
---

As vezes é necessário que manipulemos arquivos grandes, mas o destino deles pode não comportar: em disquetes, em CD-ROM ou em outro destino. Desta forma existe o comando **split** para dividir os arquivos e para recuperá-los um simples **cat**.

# Dividir

Uso:

    % split [ OPCAO ] [ ARQUIVO [ PREFIXO ] ]

As principais opções são:

* `-b` serve para indicar o tamanho de arquivo(s) de saída;
* `--verbose` imprime um diagnóstico para a saída de erro padrão antes que cada arquivo de saída seja aberto;
* `--help` mostra a ajuda;
* `--version` mostra a versão.

## Exemplo Prático:

Temos o seguinte arquivo:

    % ls -lh
    total 1.7G
    -rw-r--r-- 1 root root 1.7G Sep 1 21:38 backup.tar.gz

Para dividir em formatos de 680 MBytes:

    % split -b 680m backup.tar.gz

Pronto o arquivo já está dividido:

    % ls -lh
    total 3.3G
    -rw-r--r-- 1 root root 1.7G Sep 1 21:38 backup.tar.gz
    -rw-r--r-- 1 root root 680M Sep 2 10:02 xaa
    -rw-r--r-- 1 root root 680M Sep 2 10:03 xab
    -rw-r--r-- 1 root root 301M Sep 2 10:04 xac

Quando o **split** separa um arquivo ele o coloca em arquivos com o padrão de nome: `x` seguido de outras letras e números de forma a ficar em ordem, como visto no **ls** acima, isto ajuda quando for recompor o arquivo.

# Recompor

O conhecido **cat** é útil para vermos arquivos de texto, mas ele também abre arquivos binários, e para unir arquivos separados pelo comando **split**.

É preciso redirecionar o conteúdo do **cat**, caso contrário o conteúdo será mostrado na tela.

    % cat x* > arquivo

## Exemplo

Seguindo o exemplo anteriormente mencionado, já com o transporte feito:

    % cat x* > backup.tar.gz

### Nota

Além disso o comando **cat** permite unir vários arquivos de textos: por exemplo você tem alguns arquivos com o conteúdo de um trabalho para ser impresso, é fácil uní-los usando **cat *.txt**, claro que somente com arquivos de texto puro, afinal arquivos, mesmo documentos de texto, mas em formato binário podem - e acredite darão - problemas e a ordem de união deve ser avaliada pelo comando por isso aconselho colocar algo para dar segurança à união: algo como _01_introducao.txt_, _02_caracteristicas_gerais.txt_, _03_aprofundamento.txt_ e _04_finalizando.txt_.
