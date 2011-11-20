---
layout: post
title: "Backup+Restore do MySQL"
date: 2011-09-29 19:57
comments: true
categories: [db, mysql]
---
Isto é algo que eu sempre esqueço como se faz (sério).

# Backup

Se for na máquina local:

    % mysqldump -u usuario -p banco_de_dados > nome_do_arquivo.sql
    Enter password:

Se não usar a senha, basta remover a opção `-p`.

E se quiser por a senha na linha de comando:

    % mysqldump -u usuario --password='minha_senha' banco > arquivo.sql

## Backup Remoto

Como você notou o backup é gerado na saída padrão e feito um
redirecionamento para `arquivo.sql`.

    % ssh usuario@site-remoto.com 'mysqldump -u usuario --password="minha_senha" banco' | gzip > arquivo.sql.gz

No exemplo acima nós acessamos o servidor remoto via `ssh` e executamos o
backup _com compactação_ (com o comando `gzip`), mas a "saída padrão" é na
nossa máquina e com ela jogamos no arquivo `arquivo.sql.gz`.

**Mas atenção: se o banco de dados for grande você vai usar muita banda.**

Para bancos pequenos eu faço o comando acima, mas em banco de dados grandes
entro no servidor via ssh, faço o backup compactado e coloco para download
via http ou ftp.

# Restauação (Restore)

O comando para restauração é o mesmo de acesso a "shell" do mysql, com o
`arquivo_de_backup.sql` em mãos:

    % mysql -u usuario --password='senha' banco < arquivo.sql

Se você ver o erro:

    ERROR 1049 (42000): Unknown database 'vclientes_production'

É por que, como a tradução sugere, não existe a base de dados. Neste caso,
é preciso entrar no mysql e executar o comando para criar a base de dados,
com o `create database banco`;

    % mysql -u root
    Welcome to the MySQL monitor.  Commands end with ; or \g.
    Your MySQL connection id is 19
    Server version: 5.1.49-1ubuntu8.1 (Ubuntu)

    Copyright (c) 2000, 2010, Oracle and/or its affiliates. All rights reserved.
    This software comes with ABSOLUTELY NO WARRANTY. This is free software,
    and you are welcome to modify and redistribute it under the GPL v2 license

    Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

    mysql> create database banco;
    Query OK, 1 row affected (0.00 sec)

    mysql>


Ou se preferir, basta executar direto no shell:

    % echo 'create database banco' | mysql -u usuario --password='senha'

Se o arquivo estiver compactado via gzip, basta descompactar e mandar para
o mysql:

    % cat arquivo.sql.gz | gunzip | mysql -u usuario banco

## Restauração Remota para Local Direta

    % ssh usario@host-remoto.com 'mysqldump -u usuario --password="senha" banco | gzip' | gunzip | mysql -u usuario banco

Na linha acima o backup é feito e compactado no servidor remoto, e na nossa
máquina ele é descompactado e usado para restauração.
