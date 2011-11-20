---
layout: post
title: "Software fduplicate"
date: 2008-11-19 05:40
comments: true
categories: [labs, software]
---

O **fduplicate** procura por arquivos duplicados em determinado diretório.

# A necessidade

Muitas vezes podemos ter vários arquivos armazenados, mas desnecessariamente, por isso surgiu o **fduplicate**, um front-end para o **md5sum** e o **sort**.

    ubuntu% touch arquivo{1,2,3,4}
    ubuntu% ps aux > arquivo{1,3}
    ubuntu% md5sum * | sort
    b194d980bafdf036c6c44bc9a8cb6cdb  arquivo1
    b194d980bafdf036c6c44bc9a8cb6cdb  arquivo3
    d41d8cd98f00b204e9800998ecf8427e  arquivo2
    d41d8cd98f00b204e9800998ecf8427e  arquivo4

Olhando dá para saber, pelo md5sum dos arquivos, que o arquivo1 e arquivo3 são idênticos, assim como os arquivos arquivo2 e arquivo4, mas para facilitar a vida:

    ubuntu% fduplicate
    # ./arquivo1 ./arquivo3
    # ./arquivo4 ./arquivo2

ou informando o diretório:

    ubuntu% fduplicate /tmp/teste
    # /tmp/teste/arquivo1 /tmp/teste/arquivo3
    # /tmp/teste/arquivo4 /tmp/teste/arquivo2

*O download foi temporariamente desabilitado*.

Lançado em 21 de Novembro de 2008 a versão 2.1.2;
