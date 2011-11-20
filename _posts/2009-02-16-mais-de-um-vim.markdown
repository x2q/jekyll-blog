---
layout: post
title: "Mais de um vim"
date: 2009-02-16 11:45
comments: true
categories: [vim]
---

O vim pode parecer um editor bloco-de-notas, mas é muito mais que isso. Atualmente uso como IDE de programação Ruby on Rails.

Neste post apresento formas de visualizar ou editar mais de um arquivo por vez.

# Mais de um Arquivo

Para abrir mais de um arquivo no vim basta informar em linha de comando, separado por espaços, os arquivos:

    machine% vim puts.rb main.rb

Para navegar use ``:next``, para próximo, e ``:previous``, para anterior.

# Dividindo a Janela

Com o comando ``:split`` ou ``:vsplit`` é possível dividir a janela na horizontal e vertical, respectivamente.

Para navegar use _Control+w w_

Para fechar: ``:close`` fecha todas as janelas abertas e ``:only`` deixa somente a atual aberta.

# Modo Diff

Este modo é para comparação de documentos, basta abrir dois arquivos usando o parâmetro ``-d``:

    machine% vim -d main.rb main2.rb

O arquivo é aberto com divisão de janela na vertical e o mais interessante é que quando for navegando para baixo ou para cima o arquivo da direita vai "percorrer junto" a janela.

Referência:

Alceu Rodrigues de Freitas Junior. Disponível em [http://sao-paulo.pm.org/papers/alceu/vim4perl/index.html](http://sao-paulo.pm.org/papers/alceu/vim4perl/index.html). Acessado em 16 de Fevereiro de 2009.
