---
layout: post
title: "Configurando o HIRB no .irbrc, terminal"
date: 2009-10-28 06:13
comments: true
categories: [irb, rails, ruby, terminal]
---

Quem acompanha o Railscasts vê frequentemente a saída do ``script/console`` formatada em tabelas, esta formatação é feita usando o HIRB.

Para instalar use: 

    dmitry-macbook:~ root# gem install hirb
    Successfully installed hirb-0.2.7
    1 gem installed
    Installing ri documentation for hirb-0.2.7...
    Installing RDoc documentation for hirb-0.2.7...
    dmitry-macbook:~ root# 

Após isso configure no ~/.irbrc:

    require 'rubygems'
    require 'hirb'
    Hirb.enable :pager => false
    Hirb.enable :formatter => false

Pronto basta abrir o script/console:

    app.git master* dmitry% ./script/console
    Loading development environment (Rails 2.3.3)
    Already enabled.
    >> Departamento.all
    +----+--------------+---------+----------+
    | id | nome         | user_id | posto_id |
    +----+--------------+---------+----------+
    | 1  | INFORMÁTICA  | 2       | 1        |
    | 3  | AUMOXARIFADO | 24      | 1        |
    | 4  | SOROLOGIA    | 22      | 1        |
    +----+--------------+---------+----------+
    3 rows in set
    >>
