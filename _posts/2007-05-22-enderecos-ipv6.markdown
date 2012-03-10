---
layout: post
title: "Endereços IPv6"
date: 2007-05-22 12:04
comments: true
categories: [internet, ip, ip-address]
---

Com o crescente uso dos endereços ip viu-se a necessidade de "aumentar" a sua capacidade, este aumento está sendo feito pela versão 6 do ip.

# Formato

São 128 bits, sendo que são 8 grupos de números em hexadecimal de ``0`` até ``FFFF`` (em decimal ``65.535``) separados entre si por ``:``, por exemplo: **3ffe:6a88:85a3:08d3:1319:8a2e:0370:7344**.

Caso um conjunto for ``0000`` pode ser substituído, exemplo: **3ffe:6a88:85a3:0000:0000:0000:0000:7344** equivale a **3ffe:6a88:85a3::7344**.

Os endereços IPv6 também são divididos entre a parte que informa a rede e a parte do endereço de host dentro da rede: a primeira metade (i. e. os 4 primeiros) destina-se a identificar a rede e a outra metade os hosts.

# Endereços Reservados

Existem endereços e faixas reservadas:

Endereços com o início com _2001_ são reservados para provedores de acesso e carriers e inclusive podem ser registrados.

Em contra partida o endereços com início _fec_, _fed_, _fee_ e_fef_ eram reservados para redes privadas (redes locais que não se conectariam com a internet) assim como os endereço de rede **10.x.x.x** do IPv4, mas isso foi posto abaixo com o RFC3879.

Além destes o endereço de loopback feito para indicar a si próprio que no IPv4 é [127.0.0.1](http://127.0.0.1/) no IPv6 é [::1](http://[::1]/).

# Compatibilidade

Para manter a compatibilidade com a v4 pode-se usar o endereço **::ffff:** juntamente com o endereço IP versão 4, exemplo: **::ffff:10.0.1.1**.

Não há necessidade de servidor DHCP: o formato do endereço IP pode ser uma mescla do endereço da rede com o MAC da placa de rede.

Não existem classes de endereços.

# Na Prática

Na prática alguns programas já tem suporte a nova geração do endereçamento IP:

* nmap: para usar basta adicionar o parâmetro ``-6``;
* no ifconfig colocar ``add`` após o nome da interface;
* no firefox é necessário usar o endereço entre colchetes como em [http://[::1]/](http://[::1]/);
* o ssh aceita normalmente.

Outros porém tiveram novas versões, por exemplo o ping que foi colocado como ping6 e o traceroute para traceroute6.
