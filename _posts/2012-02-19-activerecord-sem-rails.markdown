---
layout: post
title: "ActiveRecord sem Rails"
date: 2012-02-19 23:21
comments: true
categories: [ruby, rails, activerecord]
---

Uma boa ferramenta do Rails é o ActiveRecord, sem dúvida ela pode
ajudar e muito, seja para o rails, para sinatra ou apenas para algum
script simples.

Neste post nós vamos tentar usar o ActiveRecord apenas com um script bem
simples de Ruby.

Como de costume um ``Gemfile``:

    source 'http://rubygems.org'

    gem 'sqlite3'
    gem 'activerecord', :require => 'active_record'

Vamos criar nosso model de mensagem no arquivo ``message.rb``:

    class Message < ActiveRecord::Base
    end

Nosso model precisa da base de dados, então vamos escrever uma
migration, para isso coloque o seguinte conteúdo no arquivo
``migrations/01_create_messages.rb``:

    class CreateMessages < ActiveRecord::Migration
      def change
        create_table :messages do |t|
          t.string :text
          t.timestamps
        end
      end
    end

Agora vamos criar um arquivo ``boot.rb`` que vai se encarregar de criar a
conexão com a base de dados, de fazer todas as migrações e também de
carregar todos os models:

    require 'rubygems'
    require 'bundler'

    Bundler.require :default

    ActiveRecord::Base.establish_connection(
      :adapter => 'sqlite3',
      :database => 'development.sqlite3'
    )

    ActiveRecord::Migrator.migrate('./migrations')

    require './message'

Nos podemos testar isso tudo de várias formas, uma delas é usando o irb
como "console":

    % irb -r ./boot.rb
    ==  CreateMessages: migrating
    =================================================
    -- create_table(:messages)
       -> 0.0014s
    ==  CreateMessages: migrated (0.0016s)
    ========================================

    1.9.3p0 :001 > Message.create :text => 'Teste 01'
     => #<Message id: 1, text: "Teste 01", created_at: "2012-02-19
    23:09:33", updated_at: "2012-02-19 23:09:33">
    1.9.3p0 :002 > Message.create :text => 'Outro Teste'
     => #<Message id: 2, text: "Outro Teste", created_at: "2012-02-19
    23:09:41", updated_at: "2012-02-19 23:09:41">
    1.9.3p0 :003 > Message.count
     => 2
    1.9.3p0 :004 > Message.find(1).text
     => "Teste 01"
    1.9.3p0 :005 >

Note acima que logo que o arquivo ``boot.rb`` foi carregado foi feita
uma migração da base de dados, isso é exatamente o que esperamos que
aconteça.

Agora vamos remover alguma coluna para testar novamente as migrations,
crie o arquivo ``migrations/02_remove_messages_updated_at.rb``:

    class RemoveMessagesUpdatedAt < ActiveRecord::Migration
      def change
        remove_column :messages, :updated_at
      end
    end

Mais uma vez no console:

    % irb -r ./boot.rb
    ==  RemoveMessagesUpdatedAt: migrating
    ========================================
    -- remove_column(:messages, :updated_at)
       -> 0.0224s
    ==  RemoveMessagesUpdatedAt: migrated (0.0225s)
    ===============================

    1.9.3p0 :001 > Message.first
     => #<Message id: 1, text: "Teste 01", created_at: "2012-02-19
    23:09:33">
    1.9.3p0 :002 > Message.first.attributes
     => {"id"=>1, "text"=>"Teste 01", "created_at"=>2012-02-19 23:09:33
    -0300}

O código está disponível no github em:
[https://github.com/dmitrynix/ruby-active-record](https://github.com/dmitrynix/ruby-active-record).
