---
layout: post
title: "Scaffold Exemplo e a Estrutura no Rails"
date: 2009-06-12 11:58
comments: true
categories: [framework, rails, ruby, scaffold]
---
O [Rails](http://rubyonrails.org/) é um framework que utiliza a linguagem
[Ruby](http://ruby-lang.org) para produzir aplicações web.

Para a utilização do Rails basta um simples terminal e um editor de texto.

Neste post vou mostrar superficialmente a estrutura de diretórios.

# Criando o Projeto e a Estrutura de Diretórios

    % rails new ScaffoldApp
          create
          create  README.rdoc
          create  Rakefile
          create  config.ru
          create  .gitignore
          create  Gemfile
          create  app
          create  app/assets/images/rails.png
          create  app/assets/javascripts/application.js
          create  app/assets/stylesheets/application.css
          create  app/controllers/application_controller.rb
          create  app/helpers/application_helper.rb
          create  app/mailers
          create  app/models
          create  app/views/layouts/application.html.erb
          create  app/mailers/.gitkeep
          create  app/models/.gitkeep
          create  config
          create  config/routes.rb
          create  config/application.rb
          create  config/environment.rb
          create  config/environments
          create  config/environments/development.rb
          create  config/environments/production.rb
          create  config/environments/test.rb
          create  config/initializers
          create  config/initializers/backtrace_silencers.rb
          create  config/initializers/inflections.rb
          create  config/initializers/mime_types.rb
          create  config/initializers/secret_token.rb
          create  config/initializers/session_store.rb
          create  config/initializers/wrap_parameters.rb
          create  config/locales
          create  config/locales/en.yml
          create  config/boot.rb
          create  config/database.yml
          create  db
          create  db/seeds.rb
          create  doc
          create  doc/README_FOR_APP
          create  lib
          create  lib/tasks
          create  lib/tasks/.gitkeep
          create  lib/assets
          create  lib/assets/.gitkeep
          create  log
          create  log/.gitkeep
          create  public
          create  public/404.html
          create  public/422.html
          create  public/500.html
          create  public/favicon.ico
          create  public/index.html
          create  public/robots.txt
          create  script
          create  script/rails
          create  test/fixtures
          create  test/fixtures/.gitkeep
          create  test/functional
          create  test/functional/.gitkeep
          create  test/integration
          create  test/integration/.gitkeep
          create  test/unit
          create  test/unit/.gitkeep
          create  test/performance/browsing_test.rb
          create  test/test_helper.rb
          create  tmp/cache
          create  tmp/cache/assets
          create  vendor/assets/javascripts
          create  vendor/assets/javascripts/.gitkeep
          create  vendor/assets/stylesheets
          create  vendor/assets/stylesheets/.gitkeep
          create  vendor/plugins
          create  vendor/plugins/.gitkeep
             run  bundle install
    Fetching gem metadata from https://rubygems.org/.........
    Using rake (0.9.2.2) 
    Using i18n (0.6.0) 
    Using multi_json (1.3.6) 
    Using activesupport (3.2.7) 
    Using builder (3.0.0) 
    Using activemodel (3.2.7) 
    Using erubis (2.7.0) 
    Using journey (1.0.4) 
    Using rack (1.4.1) 
    Using rack-cache (1.2) 
    Using rack-test (0.6.1) 
    Using hike (1.2.1) 
    Using tilt (1.3.3) 
    Using sprockets (2.1.3) 
    Using actionpack (3.2.7) 
    Using mime-types (1.19) 
    Using polyglot (0.3.3) 
    Using treetop (1.4.10) 
    Using mail (2.4.4) 
    Using actionmailer (3.2.7) 
    Using arel (3.0.2) 
    Using tzinfo (0.3.33) 
    Using activerecord (3.2.7) 
    Using activeresource (3.2.7) 
    Using bundler (1.1.5) 
    Using coffee-script-source (1.3.3) 
    Using execjs (1.4.0) 
    Using coffee-script (2.2.0) 
    Using rack-ssl (1.3.2) 
    Using json (1.7.4) 
    Using rdoc (3.12) 
    Using thor (0.15.4) 
    Using railties (3.2.7) 
    Using coffee-rails (3.2.2) 
    Using jquery-rails (2.0.2) 
    Using rails (3.2.7) 
    Using sass (3.1.20) 
    Using sass-rails (3.2.5) 
    Using sqlite3 (1.3.6) 
    Installing uglifier (1.2.7) 
    Your bundle is complete! Use `bundle show [gemname]` to see where a bundled gem is installed.
    % cd ScaffoldApp

Os principais diretórios são:

## `app`

Diretório que contém a aplicação propriamente dita, os controllers, models
e views e recentemente também os "assets" que são os javascripts e css da
aplicação.

Nesse diretório nas últimas atualizações do rails pode-se também por outras
"convenções", por exemplo se você usa "enumerates" coloque todos em
`app/enumerations`, se usa workers em `app/workers`, e assim por diantes.

# `config`

Usado para configurar, apesar de dizermos que usamos convensão ao invés de
configuração, vez por outra é necessário uma configuração, por exemplo
configurar as rotas (`config/routes.rb`, forma de acesso ao banco de dados
(`config/database.yml` ou `config/mongoid.yml`), arquivos de tradução (todos
em `config/locales`) dentre outros.

# `lib`

Contém pequenas bibliotecas que vocês mesmo cria e que podem ser reutilizadas
entre projetos.

Por exemplo: num site tipo "portal" é comum existirem vários models, mas se
alguns models tem algo em comum (um "slug") seria interessante criar uma "lib"
para tornar string para slug ao invés de copiar e colar código.

# `db`

Contém as *migrações* do banco de dados o schema (`db/schema.rb`) e caso use
o SQLite também o banco de dados.

# `log`

Arquivos de log.

# `test`

São os arquivos de teste do seu projeto, também podem ficar em `spec` caso
use [rspec](https://github.com/rspec/rspec/) ao invés de test::unit.

# `vendor`

Diretório que fica o "conteúdo" de terceiros.

Basicamente algo que você está reaproveitando de alguém que fez e compartilhou
algo, um bom exemplo é o [twitter bootstrap](http://twitter.github.com/bootstrap/).

# Primeiro Scaffold

O Rails usa o padrão MVC (*model, controller and view*) para gerir o fluxo
dos dados e de interação com os clientes. Mas mais uma vez o Rails facilita a
criação desses models, pois ao invés de criar cada um separadamente (o que é
perfeitamente possível) pode-se usar um scaffold para criar todos estes.

Por exemplo, ao invés de fazer isso:

    % rails generate model post title:string body:text
          invoke  active_record
          create    db/migrate/20120803223743_create_posts.rb
          create    app/models/post.rb
          invoke    test_unit
          create      test/unit/post_test.rb
          create      test/fixtures/posts.yml

E:

    % rails generate controller posts index show new create edit update destroy
          create  app/controllers/posts_controller.rb
           route  get "posts/destroy"
           route  get "posts/update"
           route  get "posts/edit"
           route  get "posts/create"
           route  get "posts/new"
           route  get "posts/show"
           route  get "posts/index"
          invoke  erb
          create    app/views/posts
          create    app/views/posts/index.html.erb
          create    app/views/posts/show.html.erb
          create    app/views/posts/new.html.erb
          create    app/views/posts/create.html.erb
          create    app/views/posts/edit.html.erb
          create    app/views/posts/update.html.erb
          create    app/views/posts/destroy.html.erb
          invoke  test_unit
          create    test/functional/posts_controller_test.rb
          invoke  helper
          create    app/helpers/posts_helper.rb
          invoke    test_unit
          create      test/unit/helpers/posts_helper_test.rb
          invoke  assets
          invoke    coffee
          create      app/assets/javascripts/posts.js.coffee
          invoke    scss
          create      app/assets/stylesheets/posts.css.scss

E ainda ter que editar o controller para conter as devidas actions corretamente
e criar as views, pode-se simplesmente:

    % rails generate scaffold post title:string body:text 
          invoke  active_record
          create    db/migrate/20120803224002_create_posts.rb
          create    app/models/post.rb
          invoke    test_unit
          create      test/unit/post_test.rb
          create      test/fixtures/posts.yml
          invoke  resource_route
           route    resources :posts
          invoke  scaffold_controller
          create    app/controllers/posts_controller.rb
          invoke    erb
          create      app/views/posts
          create      app/views/posts/index.html.erb
          create      app/views/posts/edit.html.erb
          create      app/views/posts/show.html.erb
          create      app/views/posts/new.html.erb
          create      app/views/posts/_form.html.erb
          invoke    test_unit
          create      test/functional/posts_controller_test.rb
          invoke    helper
          create      app/helpers/posts_helper.rb
          invoke      test_unit
          create        test/unit/helpers/posts_helper_test.rb
          invoke  assets
          invoke    coffee
          create      app/assets/javascripts/posts.js.coffee
          invoke    scss
          create      app/assets/stylesheets/posts.css.scss
          invoke  scss
          create    app/assets/stylesheets/scaffolds.css.scss


Para criar o model, o controller (com as actions: *index*, *show*, *new*,
*create*, *edit*, *update* e *destroy*) e as views para as actions criadas.

# Migrations (Migrações)

Até o momento não editaremos a migration, pois o foco deste post é apresentar
a estrutura de diretórios, e mesmo assim a maioria das migrations criada com o
scaffold não precisam ser editadas. E elas ainda são compatíveis com: MySQL,
PostgreSQL e SQLite.

A correspondente migration é `db/migrate/20120803224002_create_posts.rb`:

    class CreatePosts < ActiveRecord::Migration
      def change
        create_table :posts do |t|
          t.string :title
          t.text :body

          t.timestamps
        end
      end
    end

Mudou um pouco a forma como se faz migrations, atualmente apenas o *change* é
necessário, poi se for necessário "voltar" o ActiveRecord tenta identificar
automaticamente a reversão.

Sabendo seu conteúdo é necessário fazer apenas o envio de dados para o
servidor de banco de dados, neste caso utilizamos o sqlite3 que é baseado em
arquivo e não precisa de nenhuma outra configuração:

    % rake db:migrate
    ==  CreatePosts: migrating ====================================================
    -- create_table(:posts)
       -> 0.0013s
    ==  CreatePosts: migrated (0.0014s) ===========================================

# Ativando o servidor de desenvolvimento

Ao contrário de outras ferramentas que é necessário um servidor como o
apache para "ver" sua app o rails gem com o webrick que serve muito bem ao
ambiente de desenvolvimento:

    % rails server
    => Booting WEBrick
    => Rails 3.2.7 application starting in development on http://0.0.0.0:3000
    => Call with -d to detach
    => Ctrl-C to shutdown server
    [2012-08-03 19:45:51] INFO  WEBrick 1.3.1
    [2012-08-03 19:45:51] INFO  ruby 1.9.3 (2012-04-20) [x86_64-linux]
    [2012-08-03 19:45:51] INFO  WEBrick::HTTPServer#start: pid=15075 port=3000

Agora abra o navegador e coloque a seguinte url:
[http://localhost:3000/posts](http://localhost:3000/posts):

![Index](http://lh6.ggpht.com/_5r9AMhQKuQY/SjKW-IM_erI/AAAAAAAAIoA/fuCPE4sSl2U/s800/Captura_de_tela-1.png)

Você já tem um "blog" feito!

Como de praxe no meu github tem este exemplo:
[http://github.com/dmitrynix/Scaffolds_example/](http://github.com/dmitrynix/Scaffolds_example/).
