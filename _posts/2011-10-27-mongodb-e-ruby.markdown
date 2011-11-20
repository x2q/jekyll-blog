---
layout: post
title: "MongoDB e Ruby"
date: 2011-10-27 16:12
comments: true
categories: [db, mongodb, ruby]
---

# ORM no Rails

No Rails eu uso o [Mongoid](http://mongoid.org) como ORM.

Sua configuração é simples:

* Adicionar a gem *mongoid*;
* Rodar `bundle install` e;
* Criar o arquivo de configuração `config/mongoid.yml` ou rodar o comando
`rails g mongoid:config`

Os models ficariam semelhante a isso:

    class Customer
      include Mongoid::Document
      include Mongoid::Timestamps

      field :name, :type => String
      field :active, :type => Boolean, :default => false
      field :priority, :type => Integer, :default => 1
    end

Praticamente não há diferença quando substitui o ActiveRecord.

Uma outra configuração seria tirar o "require all" do arquivo
`config/application.rb` e usar:

    require 'action_controller/railtie'
    require 'action_mailer/railtie'
    require 'active_resource/railtie'
    require 'rails/test_unit/railtie'

E mais em baixo deste arquivo:

    config.generators do |g|
      g.orm :mongoid
    end

Pronto, Rails configurado!

## Rails, Mongoid e Heroku

Quando usando git eu prefiro não colocar o `mongoid.yml` ou `database.yml`
ou qualquer outro de configuração de base de dados, então em um projeto
que eu tenho no heroku eu apenas criei o arquivo
`config/initializers/heroku.rb`:

    if ENV['MONGOHQ_URL']
      Mongoid.configure do |config|
        uri = URI.parse(ENV['MONGOHQ_URL'])
        connection = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])
        db = connection.db(uri.path.gsub(/^\//, ''))
        config.master = db
      end
    end

# Sinatra

No sinatra só precisa colocar em algum ponto da app a linha:

    Mongoid.load!('/path/to/mongoid.yml')

E, claro, fazer o require dos models.

# Carrierwave

O Carrierwave pode usar o mesmo banco do mongoid para armazenas os arquivos.

É necessário antes adicionar a gem `carrierwave-mongoid` para o projeto:

    # Gemfile
    gem 'carrierwave-mongoid', :require => 'carrierwave/mongoid'

E o arquivo de configuração, `config/initializers/carrierwave.rb`:

    CarrierWave.configure do |config|
      config.storage = :grid_fs
      config.grid_fs_connection = Mongoid.database
    end

Mas claro, também dá para usar outro banco:

    CarrierWave.configure do |config|
      config.grid_fs_database = 'my_mongo_database'
      config.grid_fs_host = 'mongo.example.com'
    end

No sinatra é semelhante, configurar `Gemfile` e "executar" o código ruby
antes de carregar a aplicação (ou no config).

## Grid

     mongo_con = Mongo::Connection.new(
       gridfs_conf['host'],
       (gridfs_conf['port'] || 27017)
     ).db(gridfs_conf['database'])

     key = params[:arquivo]

     Mongo::GridFileSystem.new(mongo_con).open(key, 'r') do |file|
       file.read
     end

No exemplo acima as últimas linha iram fazer a "query" no banco de dados
e retornar um objeto arquivo, o `read` vai mostrar o conteúdo do arquivo.
