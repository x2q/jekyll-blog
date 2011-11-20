---
layout: post
title: "Scaffold Exemplo e a Estrutura no Rails"
date: 2009-06-12 11:58
comments: true
categories: [framework, rails, ruby]
---

O Rails é um framework que utiliza a linguagem Ruby para produzir aplicações web.

Para a utilização do Rails basta um simples terminal (mesmo sendo máquina Windows) e um simples editor de texto.

Neste post vou mostrar superficialmente a estrutura de diretórios.

# Criando o Projeto e a Estrutura de Diretórios

    cpd102[pts/0]% rails Scaffold
          create  
          create  app/controllers
          create  app/helpers
          create  app/models
          create  app/views/layouts
          create  config/environments
          [ . . . ]
    cpd102[pts/0]% cd Scaffold

Os principais diretórios são:

* ``app``, diretório que contém a aplicação propriamente dita (os controllers, os models e as views), os outros diretórios são mais para config, logs, arquivos estáticos (html, css, js);
* ``config``, usado para configurar, apesar de dizermos que usamos convensão ao invés de configuração, vez por outra é necessário uma configuração, por exemplo configurar o controller `root', forma de acesso ao banco de dados, dentre outros;
* ``db``, contém as `migrações' do banco de dados;
* ``log``, arquivos de log;
* ``script``, scripts para automatizar o processo de diversas tarefas do desenvolvimento de publicação;
* ``vendor``, plugins e gems do rails e de terceiros;

# Primeiro Scaffold

O Rails usa o padrão MVC (_model, controller and view_ ou _modelo, controlador e visualizador_) para gerir o fluxo dos dados e de interação com os clientes. Mas mais uma vez o Rails facilita a criação desses models, pois ao invés de criar cada um separadamente (o que é perfeitamente possível) pode-se usar um scaffold para criar todos estes.

Por exemplo, ao invés de fazer isso:

    dmicpd102[pts/1]% ./script/generate model post title:string body:text
          [ . . . ]
    dmicpd102[pts/1]% ./script/generate controller posts index show new create edit update destroy
          [ . . . ]

E ainda ter que editar o controller para conter as devidas actions corretamente e criar as views, pode-se simplesmente:

    dmicpd102[pts/0]% ./script/generate scaffold post title:string body:text
          exists  app/models/
          exists  app/controllers/
          exists  app/helpers/
          create  app/views/posts
          exists  app/views/layouts/
          [ . . . ]

Para criar o model, o controller (com as actions: ``index``, ``show``, ``new``, ``create``, ``edit``, ``update`` e ``destroy``) e as views para as actions criadas.

# Migrations (Migrações)

Até o momento não editaremos a migration, pois o foco deste post é apresentar a estrutura de diretórios, e mesmo assim a maioria das migrations criada com o scaffold não precisam ser editadas.

A correspondente migration é ``db/migrate/20090612172911_create_posts.rb``:


    class CreatePosts < ActiveRecord::Migration
      def self.up
        create_table :posts do |t|
          t.string :title
          t.text :body

          t.timestamps
        end
      end

      def self.down
        drop_table :posts
      end
    end

Sabendo seu conteúdo é necessário fazer apenas o envio de dados para o servidor de banco de dados, neste caso utilizamos o sqlite3 que é baseado em arquivo e não precisa de nenhuma outra configuração:

    dmicpd102[pts/0]% rake db:migrate
    (in /home/dmitry/Projects/Scaffold)
    ==  CreatePosts: migrating ====================================================
    -- create_table(:posts)
       -> 0.0012s
    ==  CreatePosts: migrated (0.0013s) ===========================================

# Ativando o servidor de desenvolvimento

Usando outro script do Rails pode-se ter um servidor para testar (navegando) pela aplicação criada:

    dmicpd102[pts/0]% ./script/server
    => Booting Mongrel
    => Rails 2.3.2 application starting on http://0.0.0.0:3000
    => Call with -d to detach
    => Ctrl-C to shutdown server

Por padrão é ativado o WEBRick, mas eu prefiro usar o Mongrel.

Agora abra o navegador e coloque a seguinte url: [http://localhost:3000/posts](http://localhost:3000/posts):

![Index](http://lh6.ggpht.com/_5r9AMhQKuQY/SjKW-IM_erI/AAAAAAAAIoA/fuCPE4sSl2U/s800/Captura_de_tela-1.png)

Você já tem um "blog" feito!

Como de praxe no meu github tem este exemplo: [http://github.com/dmitrynix/Scaffolds_example/](http://github.com/dmitrynix/Scaffolds_example/).
