---
layout: post
title: "Estrutura básica de HTML"
date: 2009-04-27 05:05
comments: true
categories: [basic, html]
---

O HTML é uma linguagem de "marcação". Vindo a ser uma linguagem existem regras que são seguidas para usá-la.

Atualmente o HTML está sendo "transformado" em xml, uma linguagem que basicamente separa conteúdo de formatação.

# O DocType

Não sei bem se é o W3C ou o XML que define isso, mas é necessário por uma informação semelhante a essa no HTML:

    <DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

# Início do HTML

É necessário informa após o _DocType_ a estrutura abaixo:

    <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt" lang="pt">

# O cabeçalho

O cabeçalho é compreendido entre ``<head>`` e ``</head>``.

No cabeçalho ficam informações sobre a página, a maioria destas informações não são vistas diretamente pelo usuário, elas servem apenas para informar ao navegador como estruturar a página.

No cabeçalho ficam estruturas como:

* codificação (segundo o W3C é obrigatório);
* título;
* autor;
* descrição;
* palavras-chave;
* localização dos arquivos de feed;
* localização de arquivos de css ou de scripts;
* o código css ou código de javascripts;

Abaixo tem um exemplo de um cabeçalho:

    <head>
      <meta http-equiv="content-type" content="text/html;charset=UTF-8" />
      <title>App :: Login</title>
      <meta name="description" content="Esta página mostra a estutura básica de um arquivo html">
      <meta name="keywords" content="HTML, linguagem, ">
      <link href="css.css" media="screen" rel="stylesheet" type="text/css" />
      <script src="jscript.js" type="text/javascript"></script>
    </head>

# O Corpo

O corpo (body) de um html é tudo que pode ser mostrado no navegador.

Ele fica entre ``<body>`` e ``</body>``:

   <body>
    <h1>Este é o primeiro título do corpo do html</h1>
    <p>Este é o primeiro parágrafo do corpo do html</p>
   </body>

E por fim o fechamento da tag html:

    </html>

# Resumo

    <DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

    <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt" lang="pt">
    <head>
      <meta http-equiv="content-type" content="text/html;charset=UTF-8" />
      <title>Estrutura Básica</title>
      <meta name="description" content="Esta página mostra a estutura básica de um arquivo html">
      <meta name="keywords" content="HTML, linguagem, ">
      <link href="css.css" media="screen" rel="stylesheet" type="text/css" />
      <script src="jscript.js" type="text/javascript"></script>
    </head>
    <body>
      <h1>Este é o primeiro título do corpo do html</h1>
      <p>Este é o primeiro parágrafo do corpo do html</p>
    </body>
    </html>

Lembre-se cada tag aberta deve ser fechada.
