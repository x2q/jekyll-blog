---
layout: post
title: "Métodos em Ruby"
date: 2009-01-29 07:41
comments: true
categories: [ruby]
---

Funções ou métodos.

Exemplo:

    def bye(name)
      puts "Good Bye #{name.capitalize}"
    end

    bye("dmitry")

E sua saída:

    dmicpd102% ruby MyDef.rb
    Good Bye Dmitry

Assim como shell script e outras linguagens a função deve estar antes do código que a chama, i. e., primeiro cria-se a função e depois a usa.

Pode-se ainda chamar a função sem usar o parenteses:

    bye "dmitry"

Veja um exemplo com dois parâmetros:

    def bye(nome, sobre)
      puts "Good Bye #{nome.capitalize} #{sobre.capitalize}"
    end

    bye("dmitry","rocha")
