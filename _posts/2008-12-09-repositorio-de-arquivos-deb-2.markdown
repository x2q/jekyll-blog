---
layout: post
title: "Repositório de Arquivos deb 2"
date: 2008-12-09 14:23
comments: true
categories: [deb, debian]
---

Esta é outra forma e a mais correta de criar um repositório Debian ou suas distribuições derivadas como o Ubuntu.

# O Local Exato

O local exato deve seguir esta hierarquia: root/dists/stable/main/binary-i386/:

    .
    |-- dists/
    |   `-- stable/
    |       |-- Release
    |       |-- Release.gpg
    |       `-- main/
    |           `-- binary-i386
    |               |-- Packages.gz
    |               `-- Release
    `-- pool/

No qual dists e binary-i386 são nomes imutáveis. Escolha substituir root por qualquer nome (ubuntu, debian, labs, ...) ou nem colocar e stable e main conforme a sua necessidade, poderia ser por exemplo: hardy e main ou intrepid e universe.

# Procurar os pacotes

Coloque todos os pacotes em pool, independente da hierarquia (pode ter os diretórios e subdiretórios que quiser).

Agora entre em root e, conforme a hierarquia, execute:

    % dpkg-scanpackages pool /dev/null | gzip > dists/stable/main/binary-i386/Packages.gz

Pacotes duplicados serão desconsiderados e somente uma versão será usada.

# O Arquivo Release

Para finalizar crie um arquivos _Release_ e coloque um diretório acima de binary-i386, no meu exemplo seria em main, semelhante a esse:

    Archive: stable
    Component: main
    Origin: Ubuntu
    Lable: dmitryetibr
    Architecture: all

E mais o md5sum com o tamanho em bytes dos arquivos _Packages.gz_:

    % for file in $( find . -type f -name Packages.gz );
    for> do
    for> MD5=$(md5sum $file|cut -d ' ' -f1) \
    for> DU=$(du -sb $file | cut -f1 ) \
    for> echo "$MD5 $DU $file"
    for> done >> Release

# O Arquivo Release.gpg

Com sua chave de criptografia assine o arquivos Release. Entre na pasta que está o arquivo Release e:

    % gpg --output Release.gpg -ba Release

Referência:

* Wel. R. Braga. Criando repositório local de pacotes Debian e Ubuntu. Disponível em: [http://blog.welrbraga.eti.br/?p=156](http://blog.welrbraga.eti.br/?p=156). Acessado em 9 de Dezembro de 2008;
* Howto create a Debian repository. Disponível em [http://www.rigacci.org/wiki/doku.php/doc/appunti/linux/sa/debian_repository](http://www.rigacci.org/wiki/doku.php/doc/appunti/linux/sa/debian_repository). Acessado em 9 de Dezembro de 2008.

Atualizado em: 12 de Dezembro de 2008.
