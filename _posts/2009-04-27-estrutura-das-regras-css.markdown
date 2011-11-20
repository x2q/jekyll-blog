---
layout: post
title: "Estrutura das Regras CSS"
date: 2009-04-27 05:08
comments: true
categories: [basic, css, html, web]
---

No css usa-se regras para definir a característica do html.

# Estrutura das Regras

A estrutura de uma regra de css é:

    seletor {
      propriedade: valor;
    }

Do qual:

* ``seletor``: é proveniente do html, i. e., é uma tag do html;
* ``propriedade``: é uma propriedade que o seletor pode ser modificado ou que pode ser adiquirida;
* ``valor``: é o valor que a propriedade receberar, modificando assim o seletor.

Por exemplo, para deixar azul a cor do textos dos parágrafos:

    p {
      color:blue;
    }

Com isso será mostrado algo semelhante a isso:

<p style="color:blue">Texto do parágrafo</p>

# Exemplos de Seletores

* h1: define o título, pode ser de 1 a 6;
* p: define um parágrado;
* b: torna o texto negrito;
* em: torna o texto itálico;
* img: indica uma imagem;
* a: indica um link;
* ol ou ul: define o início de uma lista, respectivamente, ordenada e não ordenada (como esta);
* pre: texto pré-definido, i. e., tamanho da linha e largura fixa;

# Exemplos de Propriedades e Valores

* color: a cor do texto;
* background-color: a cor de fundo de um texto;
* text-decoration: decoração do texto, por exemplo: sublinhado underline e linha acima: overline;
