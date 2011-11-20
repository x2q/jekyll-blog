---
layout: post
title: "Zsh o melhor shell - Configuração"
date: 2009-05-27 13:11
comments: true
categories: [shell, zsh]
---

Um fato de eu gostar do zsh ao invés do bash é que o complemente de linha de comando daquele é o melhor que já testei. O zsh também preza pela simplicidade.

Adiante existem algumas configurações do zsh encontradas na página de documentação do Gentoo Linux.

# Instalação

Debian/Ubuntu:

    # aptitude install zsh

Gentoo:

    # emerge zsh

# Primeira execução

A primeira execução do zsh ele apresenta uma tela de configuração através de menus, exceto para usuário root:

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

Eu particularmente não gosto deste modo de configuração, pois fico perdido nos menus, assim sendo eu comentarei somente as duas primeiras opções:

* q, sair e fazer nada. na próxima vez que o zsh for aberto será aberto o mesmo menu;
* 0, sair e adicionar um comentário ao arquivo de configuração, desta forma este menu não será aberto da próxima vez.

# Correção de comandos

A correção de comandos permite que seja indicado um comando próximo do comando que se queira, não é um alias, uma vez que o zsh pergunta se quer executar o comando indicado:

    % setopt correctall
    % psd
    zsh: correct 'psd' to 'pwd' [nyae]? y
    /home/remoteuser
    % pdw
    zsh: correct 'pdw' to 'pwd' [nyae]? y
    /home/remoteuser
    % cds
    zsh: correct 'cds' to 'cd' [nyae]? y

# Configuração do Prompt

A variável ``PS1`` em muitos shells armazena a configuração que é exibida na linha que é digitado o comando.

O zsh permite que seja configurada esta variável conforme sua necessidade:

* ``%T`` hora no formato HH:MM;
* ``%*`` hora no formato HH:MM:SS;
* ``%D`` data no formato YY-MM-DD;
* ``%n`` nome de usuário;
* ``%B`` - ``%b`` saída do terminal em negrito;
* ``%U`` - ``%u`` saída do terminal sublinhado;
* ``%d`` diretório atual;
* ``%~`` diretório atual, substitui o diretório home do usuário por _~_;
* ``%M`` ou ``%m`` nome do computador;
* ``%l`` tty atual.

Exemplos:

    host% PS1="%M%% "
    host% PS1="%n@%M %l %% "
    remoteuser@host pts/1 %

# Entrar em diretório sem o cd

O cd é o comando padrão para entrar em qualquer diretório.

Quando for digitado o caminho de um diretório ele nunca será executado (pelo fato de ser um diretório), por isso há uma opção de ``autocd``, i. e., entrar automaticamente num diretório apenas informando o caminho:

Para ativar:

    host% pwd
    /home/user
    host% setopt autocd
    host% /etc
    host% pwd
    /etc

# Salvando as configurações

O arquivo _.zshrc_ no diretório home é carregado a cada início do zsh, para guardar configurações basta digitar uma por linha como se cada uma fosse um comando.

Por exemplo (meu _.zshrc_):

    source ${HOME}/.profile
    PS1="%M[%l]%# " 
    setopt
    autocd

    alias :q="exit"
    alias :e="vim
