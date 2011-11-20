---
layout: post
title: "Inserindo CSS em HTML"
date: 2009-04-27 05:10
comments: true
categories: [basic, css, html]
---

Existem três formas de colocar css num documento html.

# No Cabeçalho (head)

O cabeçalho, como já mencionado anteriormente, contém somente informações sobre a página, não necessariamente nenhuma informação que será mostrada no navegador.

Com isso pode-se colocar como o navegador mostra o corpo do html.

Exemplo:

    <html>
     <head>
      <title>Exemplo CSS</title>
      <style type="text/css">
       p { color:blue; }
      </style>
     </head>
     <body>
      <p>Texto</p>
     </body>
    </html>

# No Seletor (ou Tag)

O seletor (ou a tag) do HTML pode conter as propriedades via css:

    <p style="color:blue;">Texto</p>

# Em Arquivo Externo

O uso de um arquivo é o mais comum para grandes projetos, pois pode-se usar as mesmas regras de css em vários arquivos sem ter que repitir.

Para isso indique no cabeçalho (head) o arquivo:

    <link rel="StyleSheet" title="Default" href="css.css" type="text/css" />

Agora basta criar um arquivo regras.css com todas as regras.
