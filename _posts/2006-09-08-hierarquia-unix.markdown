---
layout: post
title: "Hierarquia Unix"
date: 2006-09-08 07:00
comments: true
categories: [file system, linux, unix]
---

Tento mostrar a hierarquia mais comum aos sistemas operacionais baseados nos Unix's.

# Hierarquia do Sistema de Arquivos

O sistema de arquivos é parecido com uma árvore invertida: partindo da _raiz_ (_root_ ou _/_) no qual logo abaixo estão todos os outros diretórios, inclusive o local de acesso do CD-ROM, disquete e outros periféricos de armazenamento externo como pen drive, HD externo entre outros e é possível incluir nesta hierarquia diretórios existentes em outros locais, como computadores conectados via rede.

Para os arquivos: o nome de arquivos (e também de diretórios) são case-sensitive (sensíveis a caixa), isso significa que _leiame.txt_ e _LEIAME.TXT_ são arquivos diferentes; a extensão de nome de arquivos não define se um arquivo é formato texto puro, texto processado, programa ou outro executável ou qualquer outro tipo de arquivo, apesar que a interface gráfica informar que tipo é rapidamente.

Arquivos e diretórios são separados uns dos outros pela barra _/_.

Abaixo os principais diretórios:

_/bin_, armazena executáveis essenciais;

_/boot_, arquivos estáticos para a carga do sistema (boot);

_/dev_, arquivos de dispositivos;

_/etc_, contém arquivos de configuração do sistema;

_/home_, arquivos que são pessoais para cada usuário assim como suas configurações;

_/lib_, bibliotecas compartilhadas e módulos do kernel;

_/mnt_, é o ponto de montagem para sistemas de arquivos, o administrador do sistema pode a sua necessidade montar um sistema de arquivos onde quiser na hierarquia;

_/proc_, o pseudo-sistema de arquivos proc fornece informações sobre processos rodando e o kernel;

_/root_, o diretórios pessoal do usuário **root** não fica em _/home_ e sim diretamente na _raiz_;

_/sbin_, da mesma forma que _/bin_, comumente somente o **root** tem acesso a este diretório;

_/tmp_, arquivos temporários do sistema que podem ser apagados sem prévio aviso (sugiro que não faça), normalmente são apagados durante o boot do sistema;

_/usr_, forma uma segunda hierarquia: com a maioria dos utilitários e aplicações dos usuários, tem também a documentação;

_/var_, dados variáveis, arquivos de log de múltiplos propósitos, arquivos temporários de transição dentre outros.
