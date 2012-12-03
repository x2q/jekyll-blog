---
layout: post
title: "Sinatra e Capybara"
date: 2011-11-13 18:59
comments: true
categories: [ruby, sinatra]
---

Seguindo nosso projeto anterior sobre Sinatra
[Hello Sinatra](/hello-sinatra/) vamos agora usar o
[Capybara](https://github.com/jnicklas/capybara) para fazer os "testes de
aceitação".

# Adicionar a gem

O nosso projeto é baseado no post [Hello Sinatra ;)](/hello-sinatra/),
agora vamos pegar o projeto e adicionar a gem do capybara:

    % git clone git://github.com/dmitrynix/sinatra-demo-app-post.git

Adicionar a gem no `Gemfile`:

```ruby
source 'http://rubygems.org'

gem 'sinatra'

group :development, :test do
  gem 'rspec'
  gem 'rack-test', :require => 'rack/test'
  gem 'capybara'
end
```

E executar o `bundle install`.

## Primeiro teste

Nosso exemplo será de um formulário simples que a pessoa vai escrever uma
mensagem e ela aparecerá após ela enviar para o servidor.

Como já temos um projeto basta adicionar ao `spec_helper.rb` o conteúdo:

```ruby
require 'capybara/rspec'
```

Esse require, claro, deve ser depois do require das rubygems ou depois do
require do bundler.

E dizer ao capybara qual a nossa app rack:

```ruby
Capybara.app = DemoApp::Application
```

Agora vamos ao nosso primeiro spec:

```ruby
require 'spec_helper'

feature 'the message process' do
  it 'expose message' do
    visit '/'

    fill_in 'Message', :with => 'Hi!'

    click_button 'Message!'

    page.should have_content 'Sua mensagem foi "Hi!"'
  end
end
```

Na sequência

* Visite a url `/` da aplicação;
* Preencha o input do label correspondente com o nome *Message*;
* Click no butão *Message!*;
* No final deste processo deve ter a nossa mensagem.

Certamente ele irá falhar:

    % rspec spec/demo_app_spec.rb
    F

    Failures:

      1) the message process expose message
         Failure/Error: within("#message") do
         ArgumentError:
           rack-test requires a rack application, but none was given
         # (eval):2:in `find'
         # ./spec/demo_app_spec.rb:5:in `block (2 levels) in <top (required)>'

    Finished in 0.22032 seconds
    1 example, 1 failure

    Failed examples:

    rspec ./spec/demo_app_spec.rb:4 # the message process expose message

Agora vamos modificar nossa aplicação para o spec:


```ruby
module DemoApp
  class Application < Sinatra::Base
    template :index do
"<form=\"\" action=\"/\" method=\"post\">
  <label for=\"message\">Message</label>
  <input type=\"text\" name=\"message\" id=\"message\">
  <button>Message!</button>
</form>"
    end

    get '/' do
      erb :index
    end

    post '/' do
      "Sua mensagem foi \"#{params[:message]}\""
    end
  end
end
```

E ele irá passar:

    % rspec spec/demo_app_spec.rb
    .

    Finished in 0.36823 seconds
    1 example, 0 failures

Alguns preferem escrever os specs dentro de `spec/integration`, mas eu já
vi também em `spec/acceptance`.

Como de costume o projeto está no github:
[sinatra-and-capybara-demo](https://github.com/dmitrynix/sinatra-and-capybara-demo)
