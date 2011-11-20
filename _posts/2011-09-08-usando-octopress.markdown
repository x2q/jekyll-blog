---
layout: post
title: "Usando Octopress"
date: 2011-09-08 21:33
comments: true
categories: cms
---
# Definição

O [Octopress](http://octopress.org/), como o próprio site diz é:

> Um framework de blog para hackers

É um framework feito usando [Jekyll](http://github.com/mojombo/jekyll), que
por sua vez é um gerador de sites estáticos.

Como para alguns pode ser muito trabalhoso usar o Jekyll, pois é preciso
escrever seu próprio template html, css, javascripts e toda a configuração.
Mas usando o Octopress bastante disso já é feito, claro que depois que se
aprende a usar você faz suas próprias customizações.

# Obtendo o Octopress

No meu caso não pensei que iria usar o
[Octopress](http://octopress.org/) então fiz um clone (e não um fork), mas
caso você já tenha decidido usá-lo faça um fork. De qualquer forma obtenha
o Octopress:

    git clone git://github.com/imathis/octopress.git

# Setup

Antes de qualquer ação execute o `bundle install` para instalar as
dependências.

O arquivo de configuração é `_config.yml`. Basicamente só é necessário
mudar _url_, _title_, _subtitle_ e _author_ e caso queira as
*configurações* do github, twitter,
[Google Analytics](https://www.google.com/analytics/) e do
[disqus](http://disqus.com/):

    url: http://blog.dmitrynix.com
    title: Unix and Me
    subtitle: About unix, web programing and me
    author: Dmitry Nix

Agora o `rake install` vai copiar o tema padrão:

    octopress% rake install
    ## Copying classic theme into ./source and ./sass

E para levantar um *preview*:

    octopress% rake preview

E ficará disponível na porta 4000 da sua máquina:
[http://localhost:4000](http://localhost:4000).

# Blogando

Os arquivos das postagens devem ser armazenadas seguindo este padrão:
`YYYY-MM-DD-post-title.markdown`, dentro de `source/_posts`.

O próprio Octopress já tem uma tarefa rake para executar esta ação:

    rake new_post["Título da Postagem"]

No meu caso ela não está funcionando e eu ainda tenho que fazer isso no
"braço".

Abra o seu editor de texto favorito e comece a escrever:

As primeiras linhas são em yaml, para informar *configurações* e
informações da postagem:

```
    ---
    layout: post
    title: "Titulo da Postagem"
    date: 2011-09-08 21:33
    comments: true
    categories: [categoria1, categoria2]
    ---

    Comece a escrever daqui...
```

É importante lembrar que como yaml as categorias precisam ser informadas
seguindo o seu padrão, não apenas separadas por vírgula.

Leia mais em [Blogging Basics](http://octopress.org/docs/blogging/).

# Deploy

Caso queira usar o [heroku](http://heroku.com/) para hospedagem só é
preciso retirar o diretório `public` do `.gitignore`. Só alerto que isso
pode acarretar em mais conteúdo para seu commit, exemplo: caso seja
modificado o _author_ do site, a maioria dos arquivos em `public` serão
afetados.

Já na minha hospedagem [Linode](http://linode.com) eu utilizo o capistrano
para atualizar e tive alguns problemas, tudo foi resolvido com o
`config/deploy.rb` semelhante a este:

    set :keep_releases, 5
    set :scm, :git
    set :scm_verbose, false
    set :repository, 'git@endereco.com:/octopress.git'
    set :deploy_via, :remote_cache
    set :user, 'dmitry'
    set :deploy_to, '/home/dmitry/blog'
    set :use_sudo, false
    role :app, 'blog.dmitrynix.com', :primary => true
    default_run_options[:pty] = true

    namespace :octopress do
      task :generate, :roles => :app do
        run "cd #{release_path} && bundle exec jekyll"
      end
    end

    after 'bundle:install', 'octopress:generate'
    after 'deploy:update_code', 'deploy:cleanup'

E com o nginx apontando para o diretório `public` dentro do "current" do
capistrano.

# Atualização

Após escrever este artigo uma atualização do Octopress (ou do Jekyll)
passou a não ser mais compatível com ruby18 e como ainda não atualizei o
servidor passei a usar o seguinte script para fazer a autalização:

    #!/bin/bash

    # Não use '/' ao final de endereço de pastas
    ssh_user="dmitry@blog.dmitrynix.com"
    remote_tmp_dir="/tmp/.site_update"
    remote_final_dir="/home/dmitry/blog/current/public"

    echo '## Generating Site with Jekyll'
    bundle exec rake generate >/dev/null 2>/dev/null
    echo '## Sending Site with rsync'
    rsync -az --delete public/ ${ssh_user}:${remote_tmp_dir}
    ssh ${ssh_user} "rsync -a --delete ${remote_tmp_dir}/ ${remote_final_dir}"
