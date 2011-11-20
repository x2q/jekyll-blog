---
layout: post
title: "Eu vou tentar"
date: 2009-11-17 09:57
comments: true
categories: [framework, method, rails, ruby]
---

É muito comum ter parâmetros num objeto que não são obrigatórios, mas mesmo assim deseja-se executar alguma ação.

Para exemplificar: se você tivesse que usar o método ``downcase`` para um campo ``observacao``:

    <%= departamento.observacao ? departamento.observacao.downcase : " " %>

Mas ao invés disso simplesmente use:

    <%= departamento.observacao.try(:downcase) %>

Mais um exemplo, este usando parâmetros para o método:

    @search.created_at_gte.try(:strftime,"%d/%m/%Y")

    <% form_for @search do |f| %>
      <p><%= label_tag 'Data' %>
      <%= f.text_field :created_at_gte, :value => @search.created_at_gte.try(:strftime,"%d/%m/%Y"), :size => 10 %>
    <% end %>

Esse método faz parte do Rails e não do Ruby
