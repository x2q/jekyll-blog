---
layout: post
title: "As tags do erb"
date: 2009-02-23 04:22
comments: true
categories: [erb, rails, ruby]
---

O ERB é um arquivo que contém tags que podem ser intepretadas pelo interpretador Ruby.

Neste post mostro as tags que podem ser usadas.

# Exibindo Saída

    <%=  %>

Este tipo de tag informa que algo será executado e que a saída deve ser exibida.

O fato interessante desta tag é que não é preciso usar comandos de saída para
exibir resultados. Por exemplo:

    <%= "Olá Mundo!!!" %>

Mesmo não tendo o comando ``puts`` ou o ``print``, será exibido o texto na página. E caso, use o ``puts`` ou o ``print`` não será exibido nada!

# Somente Execução

    <% %>

Esta tag é executada, mas nada é mostrado, independente de gerar ou não saída.

Exemplo:

    <% unless mensagem.blank? %>
      <%= '<div class="mensagem">' %>
        <%= mensagem %>
      <%= '</div>' %>
    <% end %>

Veja que neste exemplo, que se a variável ``mensagem`` for vazia nem
mesmo o ``div``, que usa a tag ``<%=`` será exibido.

# Comentário


    <%#  %>

Comentário, i. e., nada é executado, nada é mostrado. Isso é bastante útil, por exemplo, para apenas deixar de executar algo, porém sem apagar o código.
