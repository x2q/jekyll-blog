---
layout: post
title: "Mudando a Data em Unixs"
date: 2010-03-03 07:45
comments: true
categories: [terminal, tools, unix]
---

Os sistemas operacionais unix seguem um padrão de ferramenta, entre elas o ``date``.

Para modificar a data de qualquer unix-like que seguem este padrão, como por exemplo todos os linuxs:

    date MMDDhhmm[[CC]YY][.ss]]

Do qual:

* ``MM`` indica o mês;
* ``DD`` o dia;
* ``hh`` a hora;
* ``mm`` o minuto;
* ``CC`` para os primeiros dois algarismos do ano;
* ``YY`` os últimos;
* ``.ss`` o segundo.

O últimos três parâmetros são opcionais.

Para mudarmos para o dia _2 de março de 2010 as 12:45_ poderia ser assim:

    root@~ # date 030212452010
