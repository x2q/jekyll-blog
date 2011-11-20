---
layout: post
title: "NetBeans e Ruby no Ubuntu"
date: 2008-11-13 09:35
comments: true
categories: [linux, netbeans, ruby, software, ubuntu]
---

Existe uma versão para linux do NetBeans já com Ruby (ou outras linguagens) mais recente que a versão dos repositórios oficiais do Ubuntu (ainda no Ubuntu Hardy).

Para usar instale alguns pacotes do java, comumente: sun-java*. Não sei ao certo qual o pacote para rodar o NetBeans.

Baixe o NetBeans na página de download do site do projeto: http://www.netbeans.org/downloads/index.html, de acordo com qual será a linguagem apresentada. E não esqueça de configurar o idioma e a plataforma, caso esteja baixando de outro computador.

Após fazer o download do shell script execute-o como root:

    ubuntu% sudo sh /onde/esta/o/arquivo/netbeans-6.1-ml-ruby-linux.sh
    [sudo] password for dmitry:

Para mais informações veja a página do próprio NetBeans: [Instruções de Instalação do IDE NetBeans 6.1](http://www.netbeans.org/community/releases/61/install_pt_BR.html).

E pronto basta usar. Creio que melhorou até o desempenho ao abrir.

