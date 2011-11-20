---
layout: post
title: "Mac e os BSDs"
date: 2009-08-20 12:25
comments: true
categories: [bsd, freebsd, mac os x, terminal, tools]
---

Você percebe que o Mac é BSD nos pequenos detalhes do terminal:

# Comando cp

O comando cp tem a mesma peculiaridade dos BSD. Se você usar:

    % cp /Users/usuario/Desktop/ /Users/usuario

Ele vai copiar os arquivos dentro de /Users/usuario/Desktop/ e não o diretório como no Linux.

# Comando find

O find é outro que tem uma pequena diferença quando rodado no Linux ou quando é rodado num BSD.

Se quiser obter uma lista de arquivos e diretórios a partir do diretório corrente com o find deve-se usar:

    find .

# Comando chmod

O chmod e a maioria dos comandos requer parâmetros na hora certa, por exemplo:

    # chmod -R 777 arquivo

ao invés de

    chmod 777 -R arquivo

São pequenos detalhes que provam que o Mac é realmente um Unix e derivado dos BSDs.
