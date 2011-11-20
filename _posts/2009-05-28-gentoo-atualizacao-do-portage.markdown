---
layout: post
title: "Gentoo - Atualização do portage"
date: 2009-05-28 10:02
comments: true
categories: [emerge, gentoo, portage]
---

Estou testando o Gentoo linux e tendo somente o disco da versão "2008.0" (não sei bem se é uma versão), pois ao procurar um mais novo, talvez 2009, não encontrei.

Ao instalar o Gnome, percebi que a versão no portage que eu usei para instalar não é uma das mais atuais no distfiles dos mirrors, partindo disso tentei atualizar o Gnome (e também uma atualização geral), porém após fazer uma atualização da árvore do portage a maioria das vezes que ia instalar/atualizar algum pacote apresentava o seguinte erro:

    !!! All ebuilds that could satisfy ">=sys-libs/e2fsprogs-libs-1.41" have been masked.
    !!! One of the following masked packages is required to complete your request:
    - sys-libs/e2fsprogs-libs-1.41.4 (masked by: EAPI 2)
    - sys-libs/e2fsprogs-libs-1.41.3-r1 (masked by: EAPI 2)
    
    The current version of portage supports EAPI '1'. You must upgrade to a
    newer version of portage before EAPI masked packages can be installed.
    
    For more information, see MASKED PACKAGES section in the emerge man page or
    refer to the Gentoo Handbook.
    (dependency required by "sys-apps/util-linux-2.14.1" [ebuild])
    
    
    !!! Problem resolving dependencies for sys-apps/util-linux
    !!! Depgraph creation failed.

Após pesquisar no Google achei uma referência a uma simples linha de comando:

    # emerge portage

Decorrente disso pode-se notar que a saída do emerge mostra o que deve ser feito: atualizar o portage, porém um iniciante nesta distribuição Linux pode pensar que é somente para atualizar a árvore do portage e não a ferramenta portage.

Referência:

Linux e eu...: Erro instalação gentoo "emerge -u world". Disponível em: [http://linuxieu.blogspot.com/2009/04/erro-instalacao-gentoo-emerge-u-world.html](http://linuxieu.blogspot.com/2009/04/erro-instalacao-gentoo-emerge-u-world.html). Acessado em 27 de maio de 2009.
