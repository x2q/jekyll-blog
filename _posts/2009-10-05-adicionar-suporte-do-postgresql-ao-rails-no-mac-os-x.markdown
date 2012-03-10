---
layout: post
title: "Adicionar suporte do PostgreSQL ao rails no Mac OS X"
date: 2009-10-05 07:08
comments: true
categories: [db, mac-os-x, postgresql, rails]
---

Primeiro instale o pacote do PostGreSQL (o servidor em si), após isso pode-se instalar a gem.

Antes de instalar a gem certifique-se que tem em seu PATH o comando psql, ou seja, certifique-se que tenha o terminal do postgres.

    ~ dmitry% which psql
    psql not found

Caso não tenha (como na saída acima) execute o comando abaixo:

    8.3 dmitry% export PATH=${PATH}:/Library/PostgreSQL/8.3/bin

Agora certifique-se que tenha o caminho para o terminal do postgres:

    8.3 dmitry% which psql
    /Library/PostgreSQL/8.3/bin/psql

Com isso execute o seguinte comando:

    8.3 dmitry% sudo gem install postgres -- --with-pgsql-dir=/Library/PostgreSQL/8.3
    Building native extensions.  This could take a while...Successfully installed postgres-0.7.9.2008.01.28
    1 gem installed
    Installing ri documentation for postgres-0.7.9.2008.01.28...
    Installing RDoc documentation for postgres-0.7.9.2008.01.28...

# Atualização

Recentemente adquiri uma atualização do _Snow Leopard_, desta forma a gem teve que ser recompilada, mas caso não consiga instale a gem postgres-pr e remova a postgres.
