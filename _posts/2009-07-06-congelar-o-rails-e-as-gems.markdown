---
layout: post
title: "Congelar o Rails e as Gems"
date: 2009-07-06 13:24
comments: true
categories: [gems, rails]
---

O framework Ruby on Rails está em constante evolução, e ninguém acha isso ruim, pois a cada "evolução" o framework ganha novos recursos (e vez por outra uma mudança radical, que não agrada).

Desta forma para usar sempre a versão que foi usada na criação do projeto basta congelar o Rails e as gems dentro do diretório do próprio projeto seguindo os passos adiante:

# Congelando as Gems

É preciso informar as gems que são necessárias para seu projeto editando o arquivo <span class="path">config/environment.rb</span> (linhas 22 e 23):

    # Be sure to restart your server when you modify this file
    
    # Specifies gem version of Rails to use when vendor/rails is not present
    RAILS_GEM_VERSION = '2.3.2' unless defined? RAILS_GEM_VERSION
    
    # Bootstrap the Rails environment, frameworks, and default configuration
    require File.join(File.dirname(__FILE__), 'boot')
    
    Rails::Initializer.run do |config|
      # Settings in config/environments/* take precedence over those specified here.
      # Application configuration should go into files in config/initializers
      # -- all .rb files in that directory are automatically loaded.
    
      # Add additional load paths for your own custom dirs
      # config.load_paths += %W( #{RAILS_ROOT}/extras )
    
      # Specify gems that this application depends on and have them installed with rake gems:install
      # config.gem "bj"
      # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
      # config.gem "sqlite3-ruby", :lib => "sqlite3"
      # config.gem "aws-s3", :lib => "aws/s3"
      config.gem "authlogic"
      config.gem "will_paginate"
    
      # Only load the plugins named here, in the order given (default is alphabetical).
      # :all can be used as a placeholder for all plugins not explicitly named
      # config.plugins = [ :exception_notification, :ssl_requirement, :all ]
    
      # Skip frameworks you're not going to use. To use Rails without a database,
      # you must remove the Active Record framework.
      # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]
    
      # Activate observers that should always be running
      # config.active_record.observers = :cacher, :garbage_collector, :forum_observer
    
      # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
      # Run "rake -D time" for a list of tasks for finding time zone names.
      config.time_zone = 'UTC'
    
      # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
      # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
      # config.i18n.default_locale = :de
      config.i18n.default_locale = :pt_br
    end

Estamos informando a versão da gem, é aconselhavel informar, pois o objetivo é justamente congelar a versão que sabemos que funciona perfeitamente.

Depois de informado quais gems e qual versão usar, basta:

    % rake gems:unpack
    in /home/dmitry/Projects/FRails_example)
    Unpacked gem: '/home/dmitry/Projects/FrozenApp/vendor/gems/authlogic-2.0.5'
    Unpacked gem: '/home/dmitry/Projects/FrozenApp/vendor/gems/will_paginate-2.2.2'

Será criado no diretório vendor/gems um subdiretório para cada gem, no meu caso existe:

    ubuntu% ls vendor/gems
    authlogic-2.0.5  will_paginate-2.2.2

Feito isso é necessário, para gems que são compiladas, compilar uma "versão" nativa para o computador atual:

    ubuntu% rake gems:build

O passo acima é necessário para cada computador que usa a o projeto.

Até agora as gems que uso não são compiladas.

# Congelando o Rails

*Nunca* deve-se comentar a seguinte linha do arquivo config/environment.rb:

    RAILS_GEM_VERSION = '2.3.2' unless defined? RAILS_GEM_VERSION

Seja qual for a versão do Rails usada.

Feito isso na raiz da aplicação use o comando ``rake rails:freeze:gems``:

    ubuntu% rake rails:freeze:gems
    (in /home/dmitry/apps/FRails_example)
    Freezing to the gems for Rails 2.3.2
    rm -rf vendor/rails
    mkdir -p vendor/rails
    cd vendor/rails
    Unpacked gem: '/home/groups/develop/Rails/Apps/browsermedia/vendor/rails/activesupport-2.3.2'
    mv activesupport-2.3.2 activesupport
    Unpacked gem: '/home/groups/develop/Rails/Apps/browsermedia/vendor/rails/activerecord-2.3.2'
    mv activerecord-2.3.2 activerecord
    Unpacked gem: '/home/groups/develop/Rails/Apps/browsermedia/vendor/rails/actionpack-2.3.2'
    mv actionpack-2.3.2 actionpack
    Unpacked gem: '/home/groups/develop/Rails/Apps/browsermedia/vendor/rails/actionmailer-2.3.2'
    mv actionmailer-2.3.2 actionmailer
    Unpacked gem: '/home/groups/develop/Rails/Apps/browsermedia/vendor/rails/activeresource-2.3.2'
    mv activeresource-2.3.2 activeresource
    Unpacked gem: '/home/groups/develop/Rails/Apps/browsermedia/vendor/rails/rails-2.3.2'
    cd -

Pronto. Tudo congelado leve sua aplicação para qualquer lugar.
