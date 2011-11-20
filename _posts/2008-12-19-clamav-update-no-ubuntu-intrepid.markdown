---
layout: post
title: "Clamav Update no Ubuntu Intrepid"
date: 2008-12-19 05:07
comments: true
categories: [bug, linux, virus]
---

Sou oficialmente usuário do Ubuntu, usando a versão Intrepid (totalmente atualizada), e olhando o Synaptic a procura de script conversor de áudio do Nautilus, me deparo com a extensão [nautilus-clamscan](http://packages.ubuntu.com/nautilus-clamscan).

Até aí tudo bem, porém o que todo antivírus quer é ser atualizado e lá vou eu a procura disso:

O [freshclam](http://packages.ubuntu.com/freshclam) atualiza a base de dados do [clamv](http://packages.ubuntu.com/clamav), mas ele sempre reportava o erro:

    # freshclam
    WARNING: You must specify at least one database mirror.

Para solucionar este problema encontrei neste link[1] a solução: adicionar a seguinte linha ao arquivo /etc/clamav/clamd.conf:

    DatabaseMirror database.clamav.net

Referência:

Comments about 10.2 Updating Clamav via freshclam mirrors. Disponível em [http://www.techienuggets.com/commentList.jsp?tx=51537&tx=51537&d-49653-p=1](http://www.techienuggets.com/commentList.jsp?tx=51537&tx=51537&d-49653-p=1). Acessado em 19 de Dezembro de 2008.
