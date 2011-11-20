---
layout: post
title: "Capistrano"
date: 2010-08-24 12:10
comments: true
categories: [deploy, capistrano, rails, ruby, develop]
---

O Capistrano é uma ferramenta de "deploy" de programas, feito inicialmente para rails, mas qualquer outro framework/linguagem pode se aproveitar dele. Neste post vou mostrar a configuração.

# Capify a Aplicação

Instale a gem capistrano.

Para fazer deploy com capistrano você precisa do arquivo config/deploy.rb para isso o capistrano coloca um arquivo exemplo para você com o seguinte comando ``capify``, entre no diretório da aplicação e:

    dmitry@dmitrys-mac rails-app% capify .
    [add] writing './Capfile'
    [add] writing './config/deploy.rb'
    [done] capified!

# Configurando a Aplicação e o Repositório:

Tendo nosso arquivo config/deploy.rb, vamos configurar nossa aplicação para usar o git, a primeira parte do arquivo é algo semelhante a isso:

    set :application, "rails-app" # nome da aplicação
    set :keep_releases, 5 # a quantidade de versões da aplicação que manter-se-a no servidor

    # git
    set :scm, :git # o tipo de servidor de código
    set :repository,  "git@github.com:dmitrynix/rails-app.git" # repositório que será copiado o código da aplicação
    set :branch, 'master' # o braço da aplicação
    set :git_enable_submodules, 1 # para habilitar submodules do git, no meu caso eu uso, mas a maioria da aplicações não precisa
    set :deploy_via, :remote_cache # mantém um cache do código, isso faz com que não seja feito um git clone "total" toda vez que for fazer um deploy

# Credenciais e Servidores

Bom no meu caso eu só utilizo um servidor que é o mesmo para aplicação e para base de dados, veja como ficou meu arquivo:

    # credentials
    set :user, 'urea' # usuário que fará ssh no servidor
    set :deploy_to, "/home/urea/#{application}" # local que será colocado a aplicação, incluindo arquivos temporários, log, e o git clone
    set :use_sudo, false # desabilita o sudo, por padrão o capistrano usa o sudo para a maioria das tarefas

    # servers
    set :servers, 'servidor-da.aplicacao.com' # esse endereço será usado para fazer o ssh

    role :app, servers
    role :db, servers, :primary => true

    default_run_options[:pty] = true

# Como iniciar, parar e reiniciar o servidor

Para o meu exemplo uso o passenger, a configuração do nginx/apache do servidor é feita manualmente da mesma forma que a inicialização.

    namespace :deploy do
      task :start do ; end # não necessário
      task :stop do ; end # não necessário
      task :restart, :roles => :app, :except => { :no_release => true } do
        run "touch #{current_path}/tmp/restart.txt"
      end
    end

# Enviar o arquivo config/database.yml para o servidor

Bom, o servidor tem seu próprio arquivo database.yml, do mesmo jeito o meu arquivo database.yml e o arquivo config/deploy.rb não está versionado no github.

    namespace :init do
      desc "Create production-only database.yml"
      task :database_yml do
        database_configuration =<<-EOF
    production:
      adapter: postgresql
      encoding: utf8
      database: urea
      username: urea
      password: urea
      host: localhost
    EOF
        put database_configuration, "#{shared_path}/database.yml"
      end
    end

    after "deploy:setup", "init:database_yml"

# Usando o mesmo arquivo de configuração da base de dados para cada versão

O database.yml obviamente é o mesmo arquivo para todas as versões.

Para usar o mesmo arquivo da base de dados nas "releases" vamos adicionar a tarefa symlink_database ao "namespace" deploy:

      task :symlink_database do
        run "ln -nfs #{deploy_to}/#{shared_dir}/database.yml #{release_path}/config/database.yml"
      end

E por fim adicionar o symlink_database para executar depois de deploy:update_code, no final do arquivo:

    after "deploy:update_code", "deploy:symlink_database"

# Arquivo exemplo:

Antes de rodar o comando para iniciar e fazer deploy da aplicação vamos conferir o arquivo

    set :application, "rails-app" # nome da aplicação
    set :keep_releases, 5 # a quantidade de versões da aplicação que manter-se-a no servidor

    # git
    set :scm, :git # o tipo de servidor de código
    set :repository,  "git@github.com:dmitrynix/rails-app.git" # repositório que será copiado o código da aplicação
    set :branch, 'master' # o braço da aplicação
    set :git_enable_submodules, 1 # para habilitar submodules do git, no meu caso eu uso, mas a maioria da aplicações não precisa
    set :deploy_via, :remote_cache # mantém um cache do código, isso faz com que não seja feito um git clone "total" toda vez que for fazer um deploy

    # credentials
    set :user, 'urea'
    set :deploy_to, "/home/urea/#{application}"
    set :use_sudo, false

    # credentials
    set :user, 'urea' # usuário que fará ssh no servidor
    set :deploy_to, "/home/urea/#{application}" # local que será colocado a aplicação, incluindo arquivos temporários, log, e o git clone
    set :use_sudo, false # desabilita o sudo, por padrão o capistrano usa o sudo para a maioria das tarefas

    # servers
    set :servers, 'servidor-da.aplicacao.com' # esse endereço será usado para fazer o ssh

    role :app, servers
    role :db, servers, :primary => true

    default_run_options[:pty] = true

    namespace :deploy do
      task :start do ; end # não necessário
      task :stop do ; end # não necessário
      task :restart, :roles => :app, :except => { :no_release => true } do
        run "touch #{current_path}/tmp/restart.txt"
      end

      task :symlink_database do
        run "ln -nfs #{deploy_to}/#{shared_dir}/database.yml #{release_path}/config/database.yml"
      end
    end

    namespace :init do
      desc "Create production-only database.yml"
      task :database_yml do
        database_configuration =<<-EOF
    production:
      adapter: postgresql
      encoding: utf8
      database: urea
      username: urea
      password: urea
      host: localhost
    EOF
        put database_configuration, "#{shared_path}/database.yml"
      end
    end

    after "deploy:setup", "init:database_yml"
    after "deploy:update_code", "deploy:symlink_database"


# Fazendo o deploy

Fazer o deploy com capistrano da sua aplicação não cobre a instalação de gems e nem configuração do nginx/apache/mongrel (pelo menos não neste exemplo), partindo disso:

* Instale as gems no servidor;
* configure seu nginx/apache/mongrel, com a raiz apontando para /home/urea/rails-app/current/public/

E rode o comando ``cap deploy:setup`` para iniciar o deploy e o comando ``cap deploy:cold`` para colocar o código da aplicação no servidor, depois desses comandos basta rodar ``cap deploy`` e pronto.

Caso precise rodas as migration use o comando ``cap deploy:migrations``.

Para voltar ao estado anterior use o ``cap deploy:rollback``.

Para outras tarefas do capistrano: ``cap -T``
