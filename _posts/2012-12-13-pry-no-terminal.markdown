---
layout: post
title: "pry no Terminal"
date: 2012-12-13 21:56
comments: true
meta-description: "Como dividir arquivos no terminal usando split e cat"
categories: [irb, ruby, rails, terminal]
---

![Pry Logo](https://s3.amazonaws.com/dmitrynix.com/posts/pry_logo_350.png)

Primeiro instale a gem:

    % gem install pry

Se você usa o rvm com bundler pode colocar no gemset global.

A wiki do pry tem vários exemplos de como usar com rails, eu particularmente
gostei mais da forma "sem colocar no Gemfile"
([https://github.com/pry/pry/wiki/Setting-up-Rails-or-Heroku-to-use-Pry](https://github.com/pry/pry/wiki/Setting-up-Rails-or-Heroku-to-use-Pry)).

Como a wiki descreve: ele vai iniciar o pry fazendo require do
`config/environment.rb` da sua aplicação, se o arquivo existir, caso contrário
vai iniciar normalmente.

Também é sugerido que instale a gem `pry-rails`

No meu caso eu usei ele um pouco diferente:

    config_environment = File.join Dir.getwd, 'config', 'environment.rb'

    if File.exist?(config_environment) && ENV['SKIP_RAILS'].nil?
      require config_environment

      if Rails.version[0..0] == '3'
        require 'rails/console/app'
        require 'rails/console/helpers'

        extend Rails::ConsoleMethods
      else
        warn "[WARN] cannot load Rails console commands (Not on Rails 3?)"
      end
    end

    require "/home/dmitry/Developer/awesome_print/init"

* Tirei suporte a doc;
* Renomeei a var `rails` para `config_environment` (que, para mim, faz mais
sentido);
* Tirei o suporte a rails 2 (faz muito tempo que não uso, então seria apenas
"deixar teias de aranha" no arquivo :P);
* Para carregar a gem `awesome_print` sem usar o Gemfile tive que fazer um
clone local e fazer require direto no init;

# Links:

* [https://github.com/pry/pry](https://github.com/pry/pry);
* [https://github.com/michaeldv/awesome_print](https://github.com/michaeldv/awesome_print);
