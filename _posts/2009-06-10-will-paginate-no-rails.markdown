---
layout: post
title: "Will Paginate no Rails"
date: 2009-06-10 11:13
comments: true
categories: [framework, paginate, rails, ruby]
---

O Will Paginate é um plugin para paginar a exibição dos itens no Rails, uma vez que o Rails exibe todos os items quando é solicitado no 'index' de cada controller.

# Instalação

Pode ser instalado via git [http://github.com/mislav/will_paginate](http://github.com/mislav/will_paginate) ou usando a gem _will_paginate_.

    % ./script/plugin install http://github.com/mislav/will_paginate.git

ou

    # gem install will_paginate

A solução desta página deve ser implementada em cada controller para que ele possa ser paginado!

# Uso

Agora modifique a seguinte linha do controller:

    def index
      # @tickets = Ticket.all
      @tickets = Ticket.paginate :page => params[:page], :per_page => 3

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @tickets }
      end
    end

Veja que eu comentei a linha 2 e adicionei a linha 3, para ficar bem claro a mudança.

Basicamente a linha 3 indica que:

* Será paginada (``Ticket.paginate``);
* O paginador receberá como parâmetro o ``page`` da url (``:page => params[:page]``);
* Terá no máximo 3 itens por página (``:per_page => 3``), o máximo padrão é 30.

E na view index usar o código abaixo (última linha, a 20):

    <h1>Listing tickets</h1>

    <%= link_to 'New ticket', new_ticket_path %><br />

    <table>
      <tr>
        <th>Description</th>
        <th>Customer</th>
      </tr>

    <% @tickets.each do |ticket| %>
      <tr>
        <td><%=h ticket.description %></td>
        <td><%=h ticket.customer %></td>
        <td><%= link_to 'Show', ticket %></td>
        <td><%= link_to 'Edit', edit_ticket_path(ticket) %></td>
        <td><%= link_to 'Destroy', ticket, :confirm => 'Are you sure?', :method => :delete %></td>
      </tr>
    <% end %>
    </table>

    <%= will_paginate @tickets %>

É possível ainda usar temas pré-definidos do will paginate (copiando os devidos css) ou criar seu próprio tema.

# Exemplo

Está disponível no meu Github.com ([http://github.com/dmitrynix](http://github.com/dmitrynix)) o código fonte de uma aplicação com will paginate. Para o controller 'tickets' eu usei conforme descrito neste simples artigo, e no controller 'notes' está um exemplo usando um helper, que eu particularmente creio ser mais produtivo para quem usa temas no will paginate.

[http://github.com/dmitrynix/Paginate_example](http://github.com/dmitrynix/Paginate_example).

