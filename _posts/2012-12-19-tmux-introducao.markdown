---
layout: post
title: "tmux - Introdução"
date: 2012-12-18 12:01
comments: true
meta-description: "Introdução ao uso do tmux: Instalação, janelas e sessões"
categories: [terminal, tools, tmux]
---

O Tmux é um "multiplexador de terminal", um software que nos permite de um
ambiente único iniciar vários outros terminais, cada um rodando seu próprio
processo.

Além de abrir programas simultaneamente o tmux também permite que a janela seja
dividida na horizontal ou vertical, i. e., pode rodar dois programas
simultamente na mesma janela, lado a lado.

Mas se você já faz isso no iTerm2, por exemplo, por que fazer usando tmux?

A resposta, para mim, seria: padronização. Imagine-se configurando um servidor
remoto, e no "meio" disso você tenta fazer o "split" usando o que já está
acostumado? Certamente *funcionaria*, mas teria que ser feito outra conexão
ssh.

E uma terceira característica do tmux é a capacidade de anexar ou sair de uma
sessão sem que ela seja fechada.

Este post é introdutório, então vamos ver o básico de criar "janelas" e
sessões.

# Instalando

Certifique-se de que tem o tmux instalado:

    % tmux -V
    tmux 1.6

Caso não tenha use no ubuntu o `apt-get` para instalar:

    % sudo apt-get install tmux

E no mac, o homebrew:

    % brew install tmux

Para começar vamos abrir o tmux:

    % tmux

Caso queira sair basta apenas encerrar o terminal, i. e., usando o comando
`exit` do terminal.

# Janelas

Com o tmux aberto execute algum comando e crie uma nova janela com as
combinações `control + b, c`, ou seja, tecle simultameamente `control` e
`b`, solte-os e tecle `c`.

Com a nova janela aberta é possível mudar de uma para outra com o
`control + b, n` ou `control + b, p`.

Para sair nesse caso é preciso sair de todas as janelas ou "matar" o tmux.

# Sessões

Cada vez que se executa o comando `tmux` ele abre uma nova sessão.

Para ver as sessões abertas use o `tmux ls`:

    % tmux ls
    0: 3 windows (created Wed Dec 19 08:53:28 2012) [97x28]
    1: 1 windows (created Wed Dec 19 11:15:37 2012) [80x22] (attached)

Para entrar numa sessão basta usar o comando `attach` e opcionalmente o
parâmetro `-t` para escolher qual sessão deseja "se anexar" (nesse caso temos
a sessão **0** e **1**:

    % tmux attach

## Exemplo prático:

Abra uma nova seção no tmux e abra o vim (ou execute qualquer outro comando):

    % vim ~/editando-no-tmux.txt

Insira algum conteúdo ou simplesmente deixe-o aberto, agora vamos sair do tmux
e deixar tudo aberto usando `control + b, d`, se quiser pode até fechar o
terminal e/ou fazer logout.

Usando o `tmux ls` você verá que tem uma sessão aberta, vamos entrar nela
novamente e constatar que o conteúdo é o mesmo que deixamos.

Agora para entender melhor isso abra outro terminal deixando lado a lado com o
primeiro, e digite novamente o `tmux attach`, começe a fazer mudanças em
qualquer um para ver o outro "se atualizando".
