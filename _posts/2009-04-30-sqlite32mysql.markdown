---
layout: post
title: "Sqlite32Mysql"
date: 2009-04-30 13:06
comments: true
categories: [db, mysql, sqlite3]
---

Eu estava a busca de alguma ferramenta que convertesse do Sqlite3 (baseado exclusivamente em arquivo) para o MySQL e achei este link: [http://stackoverflow.com/questions/18671/quick-easy-way-to-migrate-sqlite3-to-mysql](http://stackoverflow.com/questions/18671/quick-easy-way-to-migrate-sqlite3-to-mysql).

Adiante transcrevo o conteúdo do script perl que faz a conversão:

    #! /usr/bin/perl
    
    # From: http://stackoverflow.com/questions/18671/quick-easy-way-to-migrate-sqlite3-to-mysql
    
    while ($line = <>){
        if (($line !~  /BEGIN TRANSACTION/) && ($line !~ /COMMIT/) && ($line !~ /sqlite_sequence/) && ($line !~ /CREATE UNIQUE INDEX/)){
    
        	if ($line =~ /CREATE TABLE \"([a-z_]*)\"(.*)/){
        		$name = $1;
        		$sub = $2;
        		$sub =~ s/\"//g;
        		$line = "DROP TABLE IF EXISTS $name;\nCREATE TABLE IF NOT EXISTS $name$sub\n";
        	}
        	elsif ($line =~ /INSERT INTO \"([a-z_]*)\"(.*)/){
        		$line = "INSERT INTO $1$2\n";
        		$line =~ s/\"/\\\"/g;
        		$line =~ s/\"/\'/g;
        	}else{
        		$line =~ s/\'\'/\\\'/g;
        	}
        	$line =~ s/([^\\'])\'t\'(.)/$1THIS_IS_TRUE$2/g;
        	$line =~ s/THIS_IS_TRUE/1/g;
        	$line =~ s/([^\\'])\'f\'(.)/$1THIS_IS_FALSE$2/g;
        	$line =~ s/THIS_IS_FALSE/0/g;
        	$line =~ s/AUTOINCREMENT/AUTO_INCREMENT/g;
        	print $line;
        }
    }

Para usar basta indicar o arquivo exportado do Sqlite3 como primeiro argumento e redirecionar a saída padrão para um arquivo, i. e.:

    % sqlite32mysql from_sqlite3.sql > to_mysql.sql

Convertido.
