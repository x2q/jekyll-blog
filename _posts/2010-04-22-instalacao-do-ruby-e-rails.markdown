---
layout: post
title: "Instalação do Ruby e Rails"
date: 2010-04-22 16:37
comments: true
categories: [linux, rails, ruby, ubuntu]
---

Alguns amigos pediram que eu fizesse um tutorial de como instalar o ruby/rails, então lá vai:

Para este exemplo foi usado Ubuntu 10.04.

# Instalar o Ruby

No Ubuntu:

    sudo aptitude install ruby irb rdoc ri libopenssl-ruby ruby-dev build-essential

Estes dois últimos pacotes iram instalar ferramentas para compilar alguma gem que seja em C. Os outros são: o pacote do ruby, do rdoc (para gerar documentação), e o irb um shell ruby.

# Instalar o RubyGems:

O Synaptic tem o RubyGems, mas como eu já tive muitos problemas com o rubygems provido pelo próprio Ubuntu eu prefiro instalar baixando o pacote tgz do site [rubyforge.org](http://rubyforge.org), na página do projeto rubygems: [http://rubyforge.org/frs/?group_id=126](http://rubyforge.org/frs/?group_id=126).

Após baixar o tgz do rubygems, execute estes passos:

    cd ~/Downloads
    tar xfz rubygems-1.3.7.tgz
    cd rubygems-1.3.7
    sudo ruby setup.rb
    sudo ln -s /usr/bin/gem1.8 /usr/bin/gem

Respectivamente:

* Entrar no diretório que foi baixado o pacote;
* Extrair o pacote tgz;
* Entrar no diretório descompactado;
* Executar o instalador: ``setup.rb``.

Para verificar se está tudo ok:

    % gem list

    *** LOCAL GEMS ***

# Instalar o Rails

Para instalar o Rails:

    sudo gem install rails

Se quiser instalar uma versão expecífica do Rails:

    sudo gem install rails -v=2.2.3

# Instalar o Mongrel

O mongrel é um servidor web, gosto de usá-lo apenas para o desenvolvimento, para instalar use:

    sudo gem install mongrel

Ele (ou alguma dependência dele) é compilado, para isso deve-se ter os pacotes debian: ``build-essential`` e ``ruby-dev``.

# Instalar suporte ao Sqlite3

O Sqlite é um banco de dados que fica salvo em arquivo, ele é muito útil para desenvolver, uma vez que não é extremamente necessário uma super estrutura de banco de dados.

    sudo apt-get install libsqlite3-dev

Continue com o rails em outro post: [Scaffold Exemplo e a Estrutura no Rails](/scaffold-exemplo-e-a-estrutura-no-rails)
