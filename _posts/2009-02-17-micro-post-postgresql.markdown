---
layout: post
title: "micro-post PostgreSQL"
date: 2009-02-17 14:14
comments: true
categories: [db, postgresql]
---

O [PostgreSQL](http://www.postgresql.org/) é um banco de dados Open Source
sobre licença BSD-like.

Apresento adiante alguns comandos de gerenciamento do PostgreSQL.

# Instalação

Em ambientes Debian e derivados, como o Ubuntu, basta marcar o pacote
[postgreslq](http://packages.ubuntu.com/postgresql) para instalação ou em
linha de comando:

    # aptitude install postgresql

Ou use sudo: `sudo aptitude install postgresql`.

# Usuário Administrador

O PostgreSQL não usa o *root* para gerenciamento de banco de dados e de
usuários, ao invés disso é o usuário *postgres*, então antes de executar
qualquer configuração entre como usuário administrador.

    % su - postgres

# Criar Usuário e Banco de Dados

Criar usuário:

    % createuser user_name -DRSP

    % createdb -O user_name database

# Apagar Usuário e Banco de Dados

Apagar banco de dados:

    % dropdb database

Usuário:

    % dropuser user

# PHP Pg Admin

O PHP Pg Admin é um gerenciador de banco de dados semelhante ao Php My Admin
(para mysql), i. e., interface web. No debian/ubuntu o pacote é
[phppgadmin](http://packages.ubuntu.com/phppgadmin).
