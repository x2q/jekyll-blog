---
layout: post
title: "Bot IRC para Salvar Mensagens"
date: 2012-02-21 09:15
comments: true
categories: [activerecord, ruby, irc]
---

Usando dos dois últimos posts nós vamos fazer agora com que nosso bot de
irc armazene as mensagens.

Primeiro um ``Gemfile``:

    source 'http://rubygems.org'

    gem 'cinch'
    gem 'sqlite3'
    gem 'activerecord', :require => 'active_record'

Seguindo o post sobre [ActiveRecord sem Rails](/activerecord-sem-rails) nos
vamos criar os models, as migrations e o nosso arquivo ``boot.rb``.

``boot.rb``:

    require 'rubygems'
    require 'bundler'

    Bundler.require :default

    ActiveRecord::Base.establish_connection(
      :adapter => 'sqlite3',
      :database => 'development.sqlite3'
    )

    ActiveRecord::Migrator.migrate('./migrations')
    require './quote'

``quote.rb``

    class Quote < ActiveRecord::Base
    end

``migrations/01_create_quotes.rb``

    class CreateQuote < ActiveRecord::Migration
      def change
        create_table :quotes do |t|
          t.string :added_nick
          t.string :quote
          t.timestamps
        end
      end
    end

Agora seguindo o post sobre [Bot IRC usando Ruby](/bot-irc-usando-ruby)
vamos criar o ``bot.rb``:

    require './boot'
    require 'cinch'

    DEFAULT_CHANNEL = '#gurupi'

    bot = Cinch::Bot.new do
      configure do |c|
        c.server = 'irc.freenode.net'
        c.channels = [DEFAULT_CHANNEL]
      end

      on :message, /^!add (.+)/ do |m, msg|
        Quote.create :added_nick => m.user.nick, :quote => msg
        m.reply 'Quote adicionado com sucesso.'
      end

      on :message, /^!quote (.+)/ do |m, nick|
        ch = Channel DEFAULT_CHANNEL
        quotes = Quote.where('quote like ?', "%#{nick}%").to_a
        ch.send quotes[rand(quotes.count)].quote
      end

      on :message, '!count' do |m|
        m.reply "Quote: #{Quote.count}"
      end
    end

    bot.start

Agora é só iniciar o ``bot.rb`` para que ele entre no canal.

Como de costume o código do post está em
[https://github.com/dmitrynix/bot-irc-and-active-record](https://github.com/dmitrynix/bot-irc-and-active-record).
