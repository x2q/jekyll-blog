---
layout: post
title: "Will Paginate no Rails"
date: 2009-06-10 11:13
comments: true
categories: [framework, paginate, rails, ruby]
---

O [Will Paginate](http://github.com/mislav/will_paginate) é uma gem para
paginar a exibição dos itens no Rails, uma vez que o Rails exibe todos
os items quando é solicitado no 'index' de cada controller.

# Instalação

Adicione ao `Gemfile`:

    gem 'will_paginate'

# Uso

Scaffold:

    rails g scaffold users name:string phone:string

Agora modifique a seguinte linha do controller:

    def index
      @users = User.paginate :page => params[:page], :per_page => 3
    end

Basicamente a linha 3 indica que:

* Será paginada (`User.paginate`);
* O paginador receberá como parâmetro o `page` da url (`:page => params[:page]`);
* Terá no máximo 3 itens por página (`:per_page => 3`), o máximo padrão é 30.

E na view index basta adicionar `will_paginate @users`:

    <%= will_paginate @users %>

# Código em

Como de costume o código está em:
[https://github.com/dmitrynix/will-paginate-post](https://github.com/dmitrynix/will-paginate-post)

Para fazer um teste rápido basta rodar a tarefa *populate:users*.

    % rake populate:users

E abrir [http://localhost:3000/](http://localhost:3000/).
