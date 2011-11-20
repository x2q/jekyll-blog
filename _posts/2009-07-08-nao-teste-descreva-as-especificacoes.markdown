---
layout: post
title: "Não Teste! Descreva as Especificações!"
date: 2009-07-08 13:22
comments: true
categories: [rails, spec, test]
---

O Rspec é uma ferramenta que ajuda o desenvolvedor quando estiver criando sua aplicação web, funciona como um teste, mas não é um teste (segundo o desenvolvedor), infelizmente não sei informar a sutil diferença entre ambos.

Continue a ler vou apresentar o Rspec e o Remarkable do Carlos Brando.

Primeiro instale as gems ``rspec`` e ``rspec-rails``:

    cpd102[pts/3]% sudo gem install rspec rspec-rails
    [sudo] password for dmitry: 
    **************************************************

      Thank you for installing rspec-1.2.7
    
      Please be sure to read History.rdoc and Upgrade.rdoc
      for useful information about this release.

    **************************************************
    Successfully installed rspec-1.2.7
    **************************************************
    
      Thank you for installing rspec-rails-1.2.7.1
    
      If you are upgrading, do this in each of your rails apps
      that you want to upgrade:
    
        $ ruby script/generate rspec
    
      Please be sure to read History.rdoc and Upgrade.rdoc
      for useful information about this release.
    
    **************************************************
    Successfully installed rspec-rails-1.2.7.1
    2 gems installed
    Installing ri documentation for rspec-1.2.7...
    Installing ri documentation for rspec-rails-1.2.7.1...
    Installing RDoc documentation for rspec-1.2.7...
    Installing RDoc documentation for rspec-rails-1.2.7.1...

Veja a saída do rpec-rails: ``ruby script/generate rspec``, e é exatamente este a linha de comando que deve ser usada para adicionar o suporte a Rspec no rails:

Após criar nossa aplicação vamos adicionar o suporte a Rspec:

    cpd102[pts/4]% rails Rspec_example
          create  
          create  app/controllers
          create  app/helpers
          create  app/models
          create  app/views/layouts
          [ . . . ]
    dmicpd102[pts/4]% cd Rspec_example
    dmicpd102[pts/4]% ./script/generate rspec
          exists  lib/tasks
          create  lib/tasks/rspec.rake
          create  script/autospec
          create  script/spec
          create  script/spec_server
          create  spec
          create  spec/rcov.opts
          create  spec/spec.opts
          create  spec/spec_helper.rb

Adicionado o suporte a Rspec vamos criar nosso primeiro teste, digo, nossa primeira especificação:

Crie o arquivo spec/models/post_spec.rb (sim, novamente sobre blog), se necessário crie o diretório model. O conteúdo dele deve ser algo parecido com isso:

    require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

    describe Post do
      before(:each) do
        @valid_attributes = {
          :title => "value for name",
          :body => "value for body"
        }
      end
    
      it "should create a new instance given valid attributes" do
        Post.create!(@valid_attributes)
      end
    end

Vamos criar nosso model e também a migração:

    cpd102[pts/4]% ./script/generate model Post title:string body:text
          exists  app/models/
          exists  test/unit/
          exists  test/fixtures/
          create  app/models/post.rb
          create  test/unit/post_test.rb
          create  test/fixtures/posts.yml
          create  db/migrate
          create  db/migrate/20090708181546_create_posts.rb

Fazer a migração:

    cpd102[pts/4]% rake db:migrate
    (in /home/dmitry/Projects/Rspec_example)
    ==  CreatePosts: migrating ====================================================
    -- create_table(:posts)
       -> 0.0013s
    ==  CreatePosts: migrated (0.0014s) ===========================================

Vamos executar nosso teste:

    cpd102[pts/4]% rake spec:models
    (in /home/dmitry/Projects/Rspec_example)
    .
    
    Finished in 0.027251 seconds

    1 example, 0 failures

Passou! Era realmente para passar, não criamos nenhuma especificação (dá uma vontade de dizer que é teste)!

Agora vamos descrever a especificação para o título, que é "não deve ser válido sem título".

    require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

    describe Post do
      before(:each) do
        @valid_attributes = {
          :title => "value for name",
          :body => "value for body"
        }
      end

      it "should create a new instance given valid attributes" do
        Post.create!(@valid_attributes)
      end
    
      it "should not be valid without title" do
        post = Post.new(@valid_attributes.except(:title))
        post.should_not be_valid
        post.should have(1).error_on(:title)
      end
    end

E no terminal nossa falha:

    cpd102[pts/4]% rake spec:models
    (in /home/dmitry/Projects/Rspec_example)
    .F

    1)
    'Post should not be valid without title' FAILED
    expected valid? to return false, got true
    ./spec/models/post_spec.rb:17:

    Finished in 0.069284 seconds

    2 examples, 1 failure
    rake aborted!
    Command /usr/bin/ruby1.8 -I"/usr/lib/ruby/gems/1.8/gems/rspec-1.2.7/lib"  "/usr/lib/ruby/gems/1.8/gems/rspec-1.2.7/bin/spec" "spec/models/post_spec.rb" --options "/home/dmitry/Projects/Rspec_example/spec/spec.opts" failed

    (See full trace by running task with --trace)

Se corrigirmos no model:

    class Post < ActiveRecord::Base
      validates_presence_of :title
    end

A nossa especificação passa:

    cpd102[pts/4]% rake spec:models
    (in /home/dmitry/Projects/Rspec_example)
    ..
    
    Finished in 0.033128 seconds
    
    2 examples, 0 failures

Explicando: a linha 16 contém esse conteúdo:

    post = Post.new(@valid_attributes.except(:title))

Ela informa para passar todos os parâmetros padrão exceto (``.except(:title)``) o parâmetro `title'.

Deixo para vocês os outros testes, agora quero mostrar algo mais interessante, para isso instale as gems remarkable_rails e carlosbrando-remarkable (esta última no github):

    cpd102[pts/2]% sudo gem install remarkable_rails carlosbrando-remarkable
    Successfully installed remarkable-3.1.7
    Successfully installed remarkable_activerecord-3.1.7
    Successfully installed remarkable_rails-3.1.7
    PostInstall.txt
    Successfully installed carlosbrando-remarkable-2.3.1
    4 gems installed
    Installing ri documentation for remarkable-3.1.7...
    Installing ri documentation for remarkable_activerecord-3.1.7...
    Installing ri documentation for remarkable_rails-3.1.7...
    Installing ri documentation for carlosbrando-remarkable-2.3.1...
    Installing RDoc documentation for remarkable-3.1.7...
    Installing RDoc documentation for remarkable_activerecord-3.1.7...
    Installing RDoc documentation for remarkable_rails-3.1.7...
    Installing RDoc documentation for carlosbrando-remarkable-2.3.1...

Note que na verdade foram instaladas 4 gems por causa de dependência.

Para que o remarkable seja carregado no momento do rake devemos editar dois arquivos, o primeiro é config/environments/test.rb:

    # Settings specified here will take precedence over those in config/environment.rb
    
    # The test environment is used exclusively to run your application's
    # test suite.  You never need to work with it otherwise.  Remember that
    # your test database is "scratch space" for the test suite and is wiped
    # and recreated between test runs.  Don't rely on the data there!
    config.cache_classes = true
    
    # Log error messages when you accidentally call methods on nil.
    config.whiny_nils = true
    
    # Show full error reports and disable caching
    config.action_controller.consider_all_requests_local = true
    config.action_controller.perform_caching             = false
    config.action_view.cache_template_loading            = true
    
    # Disable request forgery protection in test environment
    config.action_controller.allow_forgery_protection    = false
    
    # Tell Action Mailer not to deliver emails to the real world.
    # The :test delivery method accumulates sent emails in the
    # ActionMailer::Base.deliveries array.
    config.action_mailer.delivery_method = :test
    
    # Use SQL instead of Active Record's schema dumper when creating the test database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    # config.active_record.schema_format = :sql

    config.gem "rspec", :lib => false
    config.gem "rspec-rails", :lib => false
    config.gem "remarkable_rails", :lib => false

Apenas as três últimas linhas foram adicionadas.

Adicione também a linha 7 ao arquivo spec/spec_helper.rb:

    # This file is copied to ~/spec when you run 'ruby script/generate rspec'
    # from the project root directory.
    ENV["RAILS_ENV"] ||= 'test'
    require File.dirname(__FILE__) + "/../config/environment" unless defined?(RAILS_ROOT)
    require 'spec/autorun'
    require 'spec/rails'
    require 'remarkable_rails'
    
    # Requires supporting files with custom matchers and macros, etc,
    # in ./support/ and its subdirectories.
    Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
    
    Spec::Runner.configure do |config|
      # If you're not using ActiveRecord you should remove these
      # lines, delete config/database.yml and disable :active_record
      # in your config/boot.rb
      config.use_transactional_fixtures = true
      config.use_instantiated_fixtures  = false
      config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
    
      # == Fixtures
      #
      # You can declare fixtures for each example_group like this:
      #   describe "...." do
      #     fixtures :table_a, :table_b
      #
      # Alternatively, if you prefer to declare them only once, you can
      # do so right here. Just uncomment the next line and replace the fixture
      # names with your fixtures.
      #
      # config.global_fixtures = :table_a, :table_b
      #
      # If you declare global fixtures, be aware that they will be declared
      # for all of your examples, even those that don't use them.
      #
      # You can also declare which fixtures to use (for example fixtures for test/fixtures):
      #
      # config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
      #
      # == Mock Framework
      #
      # RSpec uses it's own mocking framework by default. If you prefer to
      # use mocha, flexmock or RR, uncomment the appropriate line:
      #
      # config.mock_with :mocha
      # config.mock_with :flexmock
      # config.mock_with :rr
      #
      # == Notes
      #
      # For more information take a look at Spec::Runner::Configuration and Spec::Runner
    end

A linha 7 deve ficar abaixo de ``require 'spec/rails'``.

Preparado nosso ambiente: modifique o arquivo spec/models/post_spec.rb para que fique semelhante a isso (apenas a linha 21 foi adiciona) :

    require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

    describe Post do
      before(:each) do
        @valid_attributes = {
          :title => "value for name",
          :body => "value for body"
        }
      end
    
      it "should create a new instance given valid attributes" do
        Post.create!(@valid_attributes)
      end
    
      it "should not be valid without title" do
        post = Post.new(@valid_attributes.except(:title))
        post.should_not be_valid
        post.should have(1).error_on(:title)
      end

      it { should validate_uniqueness_of :registration }
    end

Com apenas uma linha o Remarkable faz o que comumente é feito com 5 ou 6 linhas.
