---
layout: post
title: "Test:unit no Rails"
date: 2009-06-29 04:39
comments: true
categories: [rails, ruby, test]
---

Nota: Este post foi escrito para ser muito didático quanto aos testes

Quem usa Rails como ferramenta de desenvolvimento sabe que um dos assuntos mais falados é testes, não só aqueles programadores mais experientes, mas todos que entram nesse meio.

Visando isso comecei a aprender sobre testes e neste post vou mostrar como usar a biblioteca padrão do Rails para testes para fazer testes nos models.

Primeiro: criar a aplicação.

    ubuntu[pts/0]% rails Test_example
          create  
          create  app/controllers
          create  app/helpers
          create  app/models
          create  app/views/layouts
          [ . . . ]
    ubuntu[pts/0]% cd Test_example

Façamos a migração, apesar de não termos nada:

    ubuntu[pts/0]% rake db:migrate

Para iniciar o teste vamos primeiro verificar se existe o model post:

Adicione o seguinte conteúdo ao novo arquivo test/unit/post_test.rb:

    require 'test_helper'

    class PostTest < ActiveSupport::TestCase
      # Replace this with your real tests.
      test "exist model" do
        post = Post.new :title => "O título do meu primeiro post", :body => "O conteúdo do meu primeiro post"
        assert post.save
      end
    end

Obviamente este teste falha, pois ainda não existe a classe (ou model) Post:

    ubuntu[pts/0]% rake test:units
    (in /home/dmitry/Projects/Test_example)
    /usr/bin/ruby1.8 -I"/home/dmitry/Projects/Test_example/lib" -I"/home/dmitry/Projects/Test_example/test" "/usr/lib/ruby/gems/1.8/gems/rake-0.8.4/lib/rake/rake_test_loader.rb" "test/unit/post_test.rb" 
    Loaded suite /usr/lib/ruby/gems/1.8/gems/rake-0.8.4/lib/rake/rake_test_loader
    Started
    E
    Finished in 0.014721 seconds.
    
      1) Error:
    test_exist_model(PostTest):
    NameError: uninitialized constant PostTest::Post
        /test/unit/post_test.rb:6:in `test_exist_model'
    
    1 tests, 0 assertions, 0 failures, 1 errors
    rake aborted!
    Command failed with status (1): [/usr/bin/ruby1.8 -I"/home/dmitry/Projects/...]
    
    (See full trace by running task with --trace)

Para que o nosso teste passe, ou seja, para que ele realmente crie um post vamos gerar o model (e por conseguinte a migration) do post:

    ubuntu[pts/1]% ./script/generate model Post title:string body:text
          exists  app/models/
          exists  test/unit/
          exists  test/fixtures/
          create  app/models/post.rb
    overwrite test/unit/post_test.rb? (enter "h" for help) [Ynaqdh] n
            skip  test/unit/post_test.rb
          create  test/fixtures/posts.yml
          create  db/migrate
          create  db/migrate/20090628122701_create_posts.rb

Note que o script/generate questionou-me se queria sobrescrever o arquivo de test criado anteriormente por mim e a resposta não.

Agora vamos fazer a migration novamente:

    ubuntu[pts/1]% rake db:migrate
    (in /home/dmitry/Projects/Test_example)
    ==  CreatePosts: migrating ====================================================
    -- create_table(:posts)
       -> 0.0015s
    ==  CreatePosts: migrated (0.0016s) ===========================================

Pronto agora nosso test irá passar!

    ubuntu[pts/1]% rake test:units
    (in /home/dmitry/Projects/Test_example)
    /usr/bin/ruby1.8 -I"/home/dmitry/Projects/Test_example/lib" -I"/home/dmitry/Projects/Test_example/test" "/usr/lib/ruby/gems/1.8/gems/rake-0.8.4/lib/rake/rake_test_loader.rb" "test/unit/post_test.rb" 
    Loaded suite /usr/lib/ruby/gems/1.8/gems/rake-0.8.4/lib/rake/rake_test_loader
    Started
    .
    Finished in 0.061828 seconds.
    
    1 tests, 1 assertions, 0 failures, 0 errors

Ainda faltam dois testes:

* Se o _title_ (ou título) for vazio;
* Se o _body_ (ou o conteúdo do post propriamente dito) for vazio;

Vamos ao primeiro, modificando o arquivo test/unit/post_test.rb:

    require 'test_helper'
    
    class PostTest < ActiveSupport::TestCase
      # Replace this with your real tests.
      test "exist model" do
        post = Post.new :title => "O título do meu primeiro post", :body => "O conteúdo do meu primeiro post"
        assert post.save
      end
    
      test "verifica title" do
        post = Post.new :title => nil, :body => "O conteúdo do meu primeiro post"
        post.save
        assert_not_nil post.errors.on(:title)
      end
    end

E mais uma vez o nosso teste falha: por que queremos que não seja possível a criação de um post sem título, porém ele fez essa criação:

    ubuntu[pts/1]% rake test:units
    (in /home/dmitry/Projects/Test_example)
    /usr/bin/ruby1.8 -I"/home/dmitry/Projects/Test_example/lib" -I"/home/dmitry/Projects/Test_example/test" "/usr/lib/ruby/gems/1.8/gems/rake-0.8.4/lib/rake/rake_test_loader.rb" "test/unit/post_test.rb" 
    Loaded suite /usr/lib/ruby/gems/1.8/gems/rake-0.8.4/lib/rake/rake_test_loader
    Started
    .F
    Finished in 0.062326 seconds.
    
      1) Failure:
    test_verifica(PostTest) [/test/unit/post_test.rb:13]:
    <false> is not true.

    2 tests, 1 assertions, 1 failures, 0 errors
    rake aborted!
    Command failed with status (1): [/usr/bin/ruby1.8 -I"/home/dmitry/Projects/...]

    (See full trace by running task with --trace)

Vamos ao model corrigir isso:

    class Post < ActiveRecord::Base
      validates_presence_of :title
    end

Voltando ao teste:

    ubuntu[pts/1]% rake test:units
    (in /home/dmitry/Projects/Test_example)
    /usr/bin/ruby1.8 -I"/home/dmitry/Projects/Test_example/lib" -I"/home/dmitry/Projects/Test_example/test" "/usr/lib/ruby/gems/1.8/gems/rake-0.8.4/lib/rake/rake_test_loader.rb" "test/unit/post_test.rb" 
    Loaded suite /usr/lib/ruby/gems/1.8/gems/rake-0.8.4/lib/rake/rake_test_loader
    Started
    ..
    Finished in 0.038705 seconds.
    
    2 tests, 2 assertions, 0 failures, 0 errors

Passou novamente!

Antes de proseguir com os testes gostaria de salientar a existencia da contagem de teste:

    2 tests, 2 assertions, 0 failures, 0 errors

A primeira mostra o total de blocos de testes. A segunda a quantidade de testes (assert) que ocorreram conforme o esperado. O terceiro os testes que não passaram, também referentes ao `assert'. A última contagem mostra a quantidade de erros, ou seja, falhas mais grotescas, como por exemplo erro de sintaxe.

Antes de prosseguir novamente gostaria que vocês mesmos escrevessem os próximos testes como tarefa, o que foi feito aqui está em
[http://github.com/dmitrynix/Test_example](http://github.com/dmitrynix/Test_example).

Só uma dica: este post tem como objetivo os testes unitários, mas pode-se sim criar mais rapidamente as views (e o controller) usando o scaffold, basta apenas que você negue que seja sobrescrito os arquivos de teste e o model.
