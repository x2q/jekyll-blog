---
layout: post
title: "VMware Server"
date: 2008-10-19 11:04
comments: true
categories: [daemon, desktop, linux, server]
---

A muito tempo procuro um programa gratuito para criar e gerenciar máquinas virtuais de forma fácil e organizada semelhante ao [Wmware Workstation](http://www.vmware.com/products/ws/). E recentemente descobri que entre os produtos gratuitos da Vmware está o Vmware Server.

Esta aplicação serve para justamente ser um servidor de máquinas virtuais. Ao invés de eu ter um computador desktop (com interface gráfica e acesso, local ou remoto, via interface gráfica) tenho apenas um servidor com acesso a https.

As máquinas são armazenadas no servidor e utilizam deste para o uso de recursos (armazenamento e processamento). Ficando assim um servidor dedicado a máquinas virtuais, que por sua vez podem ser dedicadas a cada serviço específico, inclusive testes na rede.

Claro que é necessário instalar a máquina, e por isso existe um plugin (testado no [Firefox](http://www.mozilla.com/firefox/)) para ver a máquina graficamente, além de ter como criar contas de usuários e ceder permissões diferenciadas.

# Ambiente(s)

A instalação num [Ubuntu Hardy](http://www.ubuntu.com/) aconteceu de forma satisfatória, porém o console que teoricamente daria maior velocidade de comunicação foi instalado, mas não conecta com o servidor, nem mesmo localmente, o jeito é usar somente no navegador.

Até o momento inicializei e instalei: [Ubuntu Hardy](http://www.ubuntu.com/), Windows XP Professional SP2, [OpenBSD 4.3](http://www.openbsd.org/) e [Solaris 10](http://br.sun.com/solaris) (por alguma razão fica empancado quando uso o modo gráfico de instalação). Futuramente testarei OpenSolaris e Fedora.

É uma excelente opção ao [Vmware Player](http://www.vmware.com/products/player/), também gratuito, que apenas abre máquinas previamente criadas. E ao meu ver roda as máquinas virtuais mais rapidamente que o Player. Ademais, como servidor você pode fechar todas as janelas que o sistema operacional continuará sendo executado pelo server.

# Dicas rápidas de uso

* Se não consegue acessar com o navegador o endereço [http://localhost:8333/](http://localhost:8333/) tente [https://localhost:8333/](https://localhost:8333/) e adicione uma exceção.
* Primeiramente somente o root pode acessar, mas por segurança crie uma conta de usuário, através dos usuários existentes no sistema servidor, inclusive a mesma senha.
* Todos os arquivos, inclusive imagens iso, somente podem ser acessados abaixo de _/var/lib/vmware/Virtual Machines_, porém existe um recurso bastante útil: "Add Datastore", com ele é possível adicionar espaço para o servidor sem precisar configurar o próprio servidor ou reiniciá-lo, tudo via web.
