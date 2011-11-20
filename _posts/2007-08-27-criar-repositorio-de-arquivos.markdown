---
layout: post
title: "Criar Repositório de Arquivos"
date: 2007-08-27 11:01
comments: true
categories: [deb, linux]
---

Como não tenho banda larga e precisei atualizar meu GNU/Linux Debian recentemente de pacotes que obtive da Internet de outro computador.

Quando fui colocar os pacotes do Debian para atualizar não tive problemas pois o índice já estava atualizado com o servidor e os arquivos eram já de cache de um outro computador então somente precisei colocar os pacotes Debian em /var/cache/apt/archives/ e rodar:

    # aptitude upgrade

Mas quando fui colocar os pacotes atualizados em uma instalação Debian sem qualquer acesso a Internet obtive uma série de erros (provenientes a maioria de dependências). Desta forma encontrei em [http://debian-br.sourceforge.net/docs/sgml/apt-howto-pt_BR/apt-howto-pt_BR.txt](http://debian-br.sourceforge.net/docs/sgml/apt-howto-pt_BR/apt-howto-pt_BR.txt), o necessário para colocar as atualizações.

Veja abaixo como criar um repositório Debian de pacotes binários.

# O Local

Este tópico somente é abordagem aqui pelo motivo de que você pode colocar tanto via internet, colocar um servidor local de intranet ou como um diretório do seu computador.

Neste exemplo usarei o local /var/www/deb/ para criar o repositório, como meu serviço http está ativo irá funcionar de duas formas local ou via rede, crie por exemplo:

    # mkdir /var/www/deb/

# Criando o Repositório

Após colocar os arquivos deb no diretório /var/www/deb/, deve-se, segundo o apt-how-to, criar um arquivo de "override" que pode estar vazio, para nós escolhi criar o arquivo vazio em <span class="path">/var/www/deb/over</span>:

    # touch /var/www/deb/over

Sem mais configurações crie o índice com o comando:

    # cd /var/www/
    # dpkg-scanpackages deb deb/over | gzip &gt; deb/Packages.gz

Como o nosso diretório do repositório foi criado em /var/www/deb/ você pode usar para local ou para http ou ftp. Se usar para diretório local veja a configuração no arquivo /etc/apt/source.list:

    deb file:/root deb/

Se usar para http ou ftp:

    deb http://localhost deb/

Para maiores informações veja o link para o apt-how-to no início teste texto.
