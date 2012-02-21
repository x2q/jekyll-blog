---
layout: post
title: "Hello Sinatra ;)"
date: 2011-08-09 08:59
comments: true
categories: [ruby, sinatra]
---

Depois de recomendações do [@hakagura](http://twitter.com/hakagura)
sobre o framework sinatra (o mesmo que me recomendou o Rails ;) resolvi
voltar a testá-lo. Neste post vou mostrar como criar uma aplicação
usando sinatra e rspec.

# Preparando ambiente com Bundler

Crie um arquivo de ``Gemfile`` seguindo este exemplo:

    source 'http://rubygems.org'

    gem 'sinatra'

Agora um ``bundle install`` para instalar as dependêcias e criar o
``Gemfile.lock``.

Agora vamos criar o ``config.ru`` e o ``demo_app.rb`` para carregar as
dependências usando o Bundler:

``config.ru``:

    require 'rubygems'
    require 'bundler'

    Bundler.require :default

    require File.dirname(__FILE__)+'/demo_app'

    run DemoApp::Application

``demo_app.rb``:

    module DemoApp
      class Application < Sinatra::Base
      end
    end

Nossa aplicação já está pronta e ela é considerada do "tipo modular"
quando se usa sinatra.

# Iniciando o ambiente de testes com RSpec

Primeiro adicionar o rspec e o rack-test para o Gemfile:

    group :development, :test do
      gem 'rspec'
      gem 'rack-test', :require => 'rack/test'
    end

Agora vamos criar um arquivo ``spec_helper.rb`` dentro do diretório ``spec``:

    require 'rubygems'
    require 'bundler'

    Bundler.require :default, :test

    ENV['RACK_ENV'] = 'test'

    require File.dirname(__FILE__)+'/../demo_app'

    RSpec.configure do |config|
      include Rack::Test::Methods

      def app
        DemoApp::Application
      end
    end

Nosso ambiente de teste também já está pronto.

# Primeira spec

Ainda dentro do diretório ``spec`` vamos criar o arquivo ``demo_app_spec.rb``:

    require 'spec_helper'

    describe DemoApp::Application do
      context 'Get /' do
        it 'should be ok' do
          get '/'
          last_response.status.should be(200)
        end
      end
    end

Nosso primeiro spec irá, obviamente, falhar:

    sinatra-demo-app % rspec spec/demo_app_spec.rb
    F

    Failures:

      1) DemoApp::Application Get / should be ok
         Failure/Error: last_response.status.should be(200)

           expected #<Fixnum:401> => 200
                got #<Fixnum:809> => 404

           Compared using equal?, which compares object identity,
           but expected and actual are not the same object. Use
           'actual.should == expected' if you don't care about
           object identity in this example.
         # ./spec/demo_app_spec.rb:7:in `block (3 levels) in <top (required)>'

    Finished in 0.02014 seconds
    1 example, 1 failure

    Failed examples:

    rspec ./spec/demo_app_spec.rb:5 # DemoApp::Application Get / should be ok


Se você tentar inicializar o servidor para testar no navegador também
verá uma mensagem de erro:

    sinatra-demo-app % rackup config.ru -p 4000
    [2011-08-09 08:43:37] INFO  WEBrick 1.3.1
    [2011-08-09 08:43:37] INFO  ruby 1.9.3 (2011-07-31) [x86_64-darwin11.0.0]
    [2011-08-09 08:43:37] INFO  WEBrick::HTTPServer#start: pid=61772 port=4000
    127.0.0.1 - - [09/Aug/2011 08:43:40] "GET / HTTP/1.1" 404 429 0.0085

Escrevendo nosso código:

    module DemoApp
      class Application < Sinatra::Base
        get '/' do
          ""
        end
      end
    end

Executando o rspec novamente:

    sinatra-demo-app % rspec spec/demo_app_spec.rb
    .

    Finished in 0.02425 seconds
    1 example, 0 failures

# Mais um exemplo de spec

Agora vamos testar o texto que retorna da requisição:

    require 'spec_helper'

    describe DemoApp::Application do
      context 'Get /' do
        it 'should be ok' do
          get '/'
          last_response.status.should be(200)
        end

        it 'should have the correct text' do
          get '/'
          last_response.body.should == 'DemoApp::Application request'
        end
      end
    end

Quando executado este teste irá obviamente falhar, mas ao escrever
corretamente a aplicação:

    module DemoApp
      class Application < Sinatra::Base
        get '/' do
          "DemoApp::Application request"
        end
      end
    end

Ele irá passar.

# Links recomendados

* Este projeto no github:
[https://github.com/dmitrynix/sinatra-demo-app-post](https://github.com/dmitrynix/sinatra-demo-app-post);
* [http://sinatrarb.com](http://sinatrarb.com);
* [http://sinatra-book-contrib.com/](http://sinatra-book-contrib.com/);
