---
layout: post
title: "Git Básico"
date: 2011-06-01 17:14
comments: true
categories: [git]
---

# Iniciando um Projeto

Dentro da pasta que você quer começar a usar git execute o `git init`,
pode já ter conteúdo ou não:

    teste % git init
    Initialized empty Git repository in /Users/dmitry/teste/.git/
    teste %

Se você tem um projeto no github (fork ou algo semelhante)

Basta executar um `git clone`

    dmitry % git clone git@github.com:dmitrynix/teste.git

# O que eu mudei?

Se você já fez as mudanças dentro do seu projeto veja os arquivos que foram modificados com o comando `git status`

    teste % git status
    # On branch master
    #
    # Initial commit
    #
    # Untracked files:
    #   (use "git add <file>..." to include in what will be committed)
    #
    #	novo_arquivo
    nothing added to commit but untracked files present (use "git add" to track)

# Adicionando arquivos

Se um arquivo nunca existiu no git o `git add` vai adicionar um novo
arquivo, mas caso o arquivo já exista no git o `git add` só vai adicionar
as mudanças feitas.

     teste % git add novo_arquivo

Após adicionar com o `git add` tudo que você pretende por no git, use o
comando `git commit` para escrever uma mensagem das mudação.

     teste % git commit -m 'Iniciando monitoramento ou adicionando modificacoes'
     [master (root-commit) 46b0893] Iniciando monitoramento ou adicionando modificacoes
      0 files changed, 0 insertions(+), 0 deletions(-)
      create mode 100644 novo_arquivo

Pronto seus arquivos já estão no git.

# Enviando e Recebendo Arquivos do Servidor

_Crie uma conta no [github.com](http://github.com) e experimente os
comandos abaixo_

Antes de enviar os arquivos você precisa configurar qual é o endereço do
servidor, no meu caso vou usar: *git@github.com:dmitrynix/teste.git*.

Enviando arquivos:

    teste % git push
    Counting objects: 3, done.
    Delta compression using up to 4 threads.
    Compressing objects: 100% (2/2), done.
    Writing objects: 100% (2/2), 244 bytes, done.
    Total 2 (delta 0), reused 0 (delta 0)
    To git@github.com:dmitrynix/teste.git
       46b0893..266ad1b  master -> master
    teste %

Pegando arquivos:

    teste % git pull
    remote: Counting objects: 5, done.
    remote: Compressing objects: 100% (2/2), done.
    remote: Total 3 (delta 0), reused 0 (delta 0)
    Unpacking objects: 100% (3/3), done.
    From github.com:dmitrynix/teste
       266ad1b..7e0527e  master     -> origin/master
    Updating 266ad1b..7e0527e
    Fast-forward
     novo_arquivo |    1 +
     1 files changed, 1 insertions(+), 0 deletions(-)
    teste %

* [http://www.slideshare.net/slide_user/magia-git](http://www.slideshare.net/slide_user/magia-git);
* [http://git-scm.com/](http://git-scm.com/).
