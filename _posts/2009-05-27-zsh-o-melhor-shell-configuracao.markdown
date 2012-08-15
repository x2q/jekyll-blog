---
layout: post
title: "Zsh o melhor shell - Configuração"
date: 2009-05-27 13:11
comments: true
categories: [shell, zsh]
---

Um fato de eu gostar do zsh ao invés do bash é que o complemento de linha
de comando daquele é o melhor que já testei. O zsh também preza pela
simplicidade.

# Instalação

Debian/Ubuntu:

    # aptitude install zsh

Gentoo:

    # emerge zsh

# Primeira execução

A primeira execução do zsh ele apresenta uma tela de configuração através
de menus, exceto para usuário root:

    This is the Z Shell configuration function for new users,
    zsh-newuser-install.
    You are seeing this message because you have no zsh startup files
    (the files .zshenv, .zprofile, .zshrc, .zlogin in the directory
    ~).  This function can help you with a few settings that should
    make your use of the shell easier.

    You can:

    (q)  Quit and do nothing.  The function will be run again next time.

    (0)  Exit, creating the file ~/.zshrc containing just a comment.
         That will prevent this function being run again.

    (1)  Continue to the main menu.

    --- Type one of the keys in parentheses ---

Eu particularmente não gosto deste modo de configuração, pois fico perdido
nos menus, assim sendo eu comentarei somente as duas primeiras opções:

* `q`, sair e fazer nada. na próxima vez que o zsh for aberto será aberto o
mesmo menu;
* `0`, sair e adicionar um comentário ao arquivo de configuração, desta
forma este menu não será aberto da próxima vez (é a que uso).

# Usando oh-my-zsh

O [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh/) é:

> A community-driven framework for managing your zsh configuration.

Que já vem com alguns temas e plugins que auxiliam ainda mais o uso do
terminal.

Vou fazer usando git, mas caso não tenha instalado basta baixar o zip/tar do
github.

    % git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

Renomear seu `.zshrc` antigo (caso tenha):

    % mv ~/.zshrc ~/.zshrc.pre-oh-my-zsh

E copiar o padrão do oh-my-zsh:

    % cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

# Escolha dos temas

Em (https://github.com/robbyrussell/oh-my-zsh/wiki/themes)[https://github.com/robbyrussell/oh-my-zsh/wiki/themes]
escolha o tema que queira e modifique a linha:

    ZSH_THEME="robbyrussell"

Com o nome do tema que gostou.

# Tips

## Entrar em diretório sem o cd

O oh-my-zsh já vem com essa opção habilitada.

Quando for digitado o caminho de um diretório ele nunca será executado (pelo
fato de ser um diretório), por isso há uma opção de `autocd`, i. e., entrar
automaticamente num diretório apenas informando o caminho:

Exemplo:

    % pwd
    /home/user
    % /tmp
    % pwd
    /tmp

## "autoexpand"

Algo que uso bastante é o que chamo de "autoexpand".

Ao invés de ter que usar o tab para selecionar um por um, pq não selecionar
todos exceto o que não quer?

Vamos supor que tenha estes aquivos:

     % file .*zsh*
    .oh-my-zsh:   directory
    .zsh-update:  ASCII text
    .zsh_history: data
    .zshrc:       ASCII text

E queira-se editar todos exceto o `.zsh_history`, digite `vim .*zsh*` e no
final da linha um `Tab` daí basta remover o `.zsh_history`.

## Busca "inteligente"

Vamos supor que foi digitado os seguintes comandos:

    % vim /etc/hosts
    % /usr/local
    % /tmp

Se quiser voltar imediatamente para editar o `/etc/hosts` basta digitar `vim` e
seta para cima que ele vai mostrar `vim /etc/hosts` sem passar pelos outros
dois comandos.
