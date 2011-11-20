---
layout: post
title: "Atualização do Gentoo - Pacote bloqueado"
date: 2009-05-29 12:34
comments: true
categories: [bug, emerge, gentoo, portage]
---

A seguinte linha apareceu quando finalmente resolvi testar o Gentoo como distribuição desktop (no trabalho) e fui atualizar totalmente (_world_), pois a versão que tinha era muita antiga:

    [blocks B     ] <sys-apps/man-pages-3 ("<sys-apps/man-pages-3" is blocking sys-apps/man-pages-posix-2003a)

Para resolvê-la basta usar o seguinte comando:

    host# emerge --nodeps man-pages

Pronto agora o Gentoo pode ser atualizado:

    host# emerge --update --deep -newuse world

Referência:

Gentoo Linux Documentation -- Gentoo Linux x86 Handbook. Disponível em [http://www.gentoo.org/doc/en/handbook/handbook-x86.xml?full=1#blocked](http://www.gentoo.org/doc/en/handbook/handbook-x86.xml?full=1#blocked). Acessado em 29 de Maio de 2009.

PC-Erfahrung.de: Gentoo - Error sys-apps/man-pages-3 is blocking sys-apps/man-pages-posix-2003a - Man-Pages lässt sich nicht updaten. Disponível em [http://www.pc-erfahrung.de/linux/gentoo/gentoo-error-sys-appsman-pages-3-is-blocking-sys-appsman-pages-posix-2003a.html](http://www.pc-erfahrung.de/linux/gentoo/gentoo-error-sys-appsman-pages-3-is-blocking-sys-appsman-pages-posix-2003a.html). Acessado em 29 de Maio de 2009.
