---
layout: post
title: "Permissões"
date: 2008-12-05 08:10
comments: true
categories: [linux, permissions, terminal, unix]
---

Nesta categoria estão os comandos que modificam as permissões dos arquivo e diretórios, somente o root pode modificar permissões sem qualquer impedimento, os outros usuários tem algumas restrições.

# chown

Altera o dono do arquivo, sintaxe:

    % chown novo_dono arquivo

Parâmetros:

* ``-R``: muda as permissões do diretório e de todos os outros abaixo dele (nesta sintaxe prefira colocar depois do nome do comando).

O chown também permite alterar o grupo do arquivo:

    % chown root:src /usr/src

root o usuário e src o grupo.

# chgrp

Da mesma forma que **chown** é para usuário **chgrp** é para grupo.

    % chgrp novo_grupo arquivo

# chmod

Modifica as permissões de acesso ao arquivo para o usuário (dono), grupo e outros usuários do sistema.

As permissões dadas/modificadas devem ser informada através de números (em octeto) e seguir a ordem: ``DonoGrupoOutros``, por exemplo: ``750``.

A permissão de leitura equivale a 4; escrita a 2 e execução (para programas ou scripts) a 1. Desta forma para dar permissão de leitura para todos e escrita somente para o dono:

    % chmod 644 arquivo

Veja: para o usuário 6 (leitura e escrita), a soma de 4 (leitura) e 2 (escrita); para os usuários do mesmo grupo e para todos outros 4 (leitura).

Há também a possibilidade de informar as permissões de arquivos de uma forma mais "humana":

* u indica que deve ser aplicado ao dono (ou usuário), g aplicado ao grupo, o indica os outros e a indica para todos (o mesmo que usar os três ao mesmo tempo).
* + adiciona, - retira e = torna igual;
* r estabelece leitura, w escrita e x execução.

Tendo esta sintaxe, ao invés de ``644`` do exemplo anterior basta substituir por ``u=rw,go=r``, ficando desta forma:

    % chmod u=rw,go=r arquivo

É importantíssimo frisar que as permissões diferem quando tratadas para diretórios:

Para diretórios o r permite listar o conteúdo do diretório, w criar e apagar arquivos no diretório e x para ler e escrever nos arquivos dentro do diretório.

# Permissões para Links

É cediço que existe dois tipos de links: simbólicos (synbolic) e rígidos (hard), pois bem veja adiante como se comportam as permissões para estes dois tipos de links:

## Hard Links

Somente existem na mesma partição e os arquivos tem o mesmo i-node.

Para os hard links o número do i-node do arquivo é o mesmo, isto quer dizer que qualquer alteração (editando o arquivo ou mudando permissão) no "original" é gravada no "link" e vice versa...

Veja o exemplo adiante:

    % touch arquivo1
    % ln arquivo1 arquivo2
    % ls -lhiFA
    total 0
    4892835 -rw-r--r-- 2 dmitry it 0 2008-12-06 17:30 arquivo1
    4892835 -rw-r--r-- 2 dmitry it 0 2008-12-06 17:30 arquivo2
    % chmod 700 arquivo1
    % ls -lhiFA
    total 0
    4892835 -rwx------ 2 dmitry it 0 2008-12-06 17:30 arquivo1*
    4892835 -rwx------ 2 dmitry it 0 2008-12-06 17:30 arquivo2*

Observe que a alteração de permissão do arquivo arquivo1 também foi gravada em arquivo2.

## Links Simbólicos

Os links simbólicos sempre usam a permissão 777, mas na realidade a permissão é a mesma do arquivo "alvo":

    % touch arquivo1
    % ln -s arquivo1 arquivo2
    % ls -lhiFA
    total 0
    4892835 -rw-r--r-- 1 dmitry it 0 2008-12-06 17:33 arquivo1
    4892859 lrwxrwxrwx 1 dmitry it 8 2008-12-06 17:33 arquivo2 -> arquivo1
    % chmod 000 *
    % ls -lhiFA
    total 0
    4892835 ---------- 1 dmitry it 0 2008-12-06 17:33 arquivo1
    4892859 lrwxrwxrwx 1 dmitry it 8 2008-12-06 17:33 arquivo2 -> arquivo1
    % ps axu > arquivo1
    zsh: permissão negada: arquivo1
    % ps axu > arquivo2
    zsh: permissão negada: arquivo2


Pois ele apenas aponta para o arquivo.

# Atributos dos Arquivos

Os atributos dos arquivos são definições peculiares para os arquivos e diretórios do sistema de arquivo ext2 (e por conseguinte ext3).

Segue os atributos:

* A, quando este atributo está presente a adição dos outros atributos não modifica a hora de modificação dos arquivos ou diretórios;
* a, "Append-Only". Restringe a gravação para modo incremental no final do arquivos, i. e., os arquivos com este atributo não podem ser modificados (renomeados, removidos ou com conteúdo alterado) apenas podem ser adicionado conteúdo no final do arquivo. Não permite a criação de novos links para este arquivo. Somente o root pode especificar este atributo;
* c, "Compressão". Permite compactação de forma transparente ao usuário, i. e., quando lido o kernel mostra o conteúdo descompactado e quando gravado o kernel compacta o conteúdo antes de gravar;
* d, marca o arquivo para que não seja copiado ao utilizar o comando **dump**, usado para backup;
* D, para diretórios. Quando mudanças são feitas no diretório elas são gravadas imediatamente no disco. Equivale a usar o 'dircync' na opção de montagem do sistema de arquivos;
* i, "Imutável". Torna o arquivo imutável: não pode ser modificado, não podem ser removidos ou renomeados até mesmo para o usuário root e links não podem ser criados para ele. Nos diretórios não permite criar arquivos ou apagar. Somente pode ser usado pelo root.
* s, "Apagamento Seguro". Quando um arquivo com este atributo é apagado seus blocos zerados e gravados novamente no disco para que não possam ser recuperados.
* S faz a sincronia de gravação do arquivo no disco. É semelhante a especificar o 'sync' para o sistema de arquivos. Não tem efeito em diretório.
* u Marcado como recuperável, para que quando apagado seu conteúdo fica salvo para futura recuperação.

Para adicionar alguma opção use o comando **chattr** e para ver use o **lsattr**.

O comando chattr permite o uso de +, para adicionar; -, para remover, e =, para tornar igual.

Veja abaixo alguns exemplos:

    % ps axu > arquivo{1,2}
    % sudo chattr +a arquivo1
    [sudo] password for dmitry:
    % lsattr
    -----a------------- ./arquivo1
    ------------------- ./arquivo2
    % ps axu > arquivo{1,2}
    zsh: operação não permitida: arquivo1
    % ps axu >> arquivo{1,2}

