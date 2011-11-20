---
layout: post
title: "Rails e Jquery-ui Datepicker"
date: 2011-09-06 21:20
comments: true
categories: [rails, jquery, jquery-ui]
---

# Instalar o jquery e jquery-ui

Baixar o jquery e o jquery-ui para o diretório ``public``, mas se vc quiser
pode usar a gem *jquery-rails*:

    source 'http://rubygems.org'

    gem 'rails', '3.0.9'
    gem 'jquery-rails'

    gem 'sqlite3'

Instalar:

    % bundle install

E adicionar o jquery:

    % rails g jquery:install --ui
      remove  public/javascripts/prototype.js
      remove  public/javascripts/effects.js
      remove  public/javascripts/dragdrop.js
      remove  public/javascripts/controls.js
     copying  jQuery (1.6.1)
      create  public/javascripts/jquery.js
      create  public/javascripts/jquery.min.js
     copying  jQuery UI (1.8.12)
      create  public/javascripts/jquery-ui.js
      create  public/javascripts/jquery-ui.min.js
     copying  jQuery UJS adapter (0e7426)
      remove  public/javascripts/rails.js
      create  public/javascripts/jquery_ujs.js

# O model

    rails g scaffold Aniversario nome:string dia:date

Nosso projeto já recebe datas, pelo método `date_select`, mas nos queremos que ou o usuário digite a data (separada por `/`) ou selecione no datapicker do jquery-ui uma.

Um fato interessante desta forma de inserir datas é que permite deixar a
data vazia, algo que no *padrão rails* não consegui encontrar.

# Primeiro: Receber a data como string

Vamos primeiro preparar o model e o formulário para inserir a data
manualmente usando o `text_field`.

O primeiro passo é mudar a formulário de `data_select` para `text_field`:

Se você for criar algum registro desta forma a data será reconhecida de
forma errada.

Então vamos preparar o model para receber a data em formato usado no
Brasil.

    class Aniversario < ActiveRecord::Base
      def dia_br
        "#{dia.to_s[8..9]}/#{dia.to_s[5..6]}/#{dia.to_s[0..3]}"
      end

      def dia_br=(dia_en)
        self.dia = "#{dia_en[6..9]}-#{dia_en[3..4]}-#{dia_en[0..1]}"
      end
    end

Como pode-se notar nos não mudamos a *forma padrão*, nos apenas criamos um
método auxiliar.

Continuando no form use, ao invés de `dia`, `dia_br`:

    <div class="field">
      <%= f.label :dia %><br />
      <%= f.text_field :dia_br %>
    </div>

# Implementando o datapicker

Antes de colocar o datapicker vamos primeiro adicionar o *locale* dele,
para isso basta baixar o arquivo
[jquery.ui.datepicker-pt-BR.js](http://jqueryui.com/ui/i18n/jquery.ui.datepicker-pt-BR.js), colocar em `public` e adicionar usando
``javascript_include_tag``:

    <%= javascript_include_tag :defaults, 'jquery.ui.datepicker-pt-BR' %>

Agora só falta usar o jquery-ui datapicker como manda a sua documentação:

    <% javascript_tag do %>
      $(document).ready(function() {
        $('#aniversario_dia_br').datepicker();
      });
    <% end %>

E para ficar mais bonito adicionar um [tema](http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/themes/base/jquery-ui.css).

Como de costume o projeto está no github: [dmitrynix/rails-datepicker](https://github.com/dmitrynix/rails-datepicker).
