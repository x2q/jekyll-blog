---
layout: post
title: "DHCP - Servidor e Cliente"
date: 2007-01-10 12:50
comments: true
categories: [client, daemon, linux, server, tools, unix]
---

É muito custoso para um administrador de uma rede atribuir endereços IPs de forma estática, por isso existem servidores de atribuição automática de endereços, além de abster o usuário de saber detalhes sobre a configuração da rede que sua máquina deve ter.

Com o DHCP (_Dynamic Host Configuration Protocol_) não somente os cálculos de endereços livres são configurados mais rapidamente, como também podem ser fornecidos outros serviços: endereço de broadcast, do roteador, o nome de domínio, endereço de DNS. O controle de quem recebe qual endereço e a faixa de endereço pode ser configurado também.

# Instalação

No GNU/Linux Debian basta usar o aptitude:

    % sudo aptitude install dhcp3-server

Quando instalado pode-se ver em _/etc/dhcp3/dhcpd.conf_ um exemplo de configuração. Faça um backup deste arquivo antes de editar para posterior analise.

# Configuração

## Servidor

    ddns-update-style none;

    default-lease-time 600;
    max-lease-time 7200;

    log-facility local7;

    subnet 192.168.1.0 netmask 255.255.255.0 {
    	option routers 192.168.1.2;
    	option domain-name "intranet.net";
    	option domain-name-servers 192.168.1.3, 192.168.1.4;
    	range 192.168.1.30 192.168.1.224;
    }

Veja no exemplo que o que está dentro de "``subnet``" será a rede fornecida.

Nas linhas abaixo definem um endereço fixo conforme o MAC da placa de rede:

    host host01 {
    	option host-name "host01.intranet.net";
    	hardware ethernet 00:08:54:2C:DD:FD;
    	fixed-address 10.0.0.21;
    }

## Cliente

Em geral basta marcar a rede para ser cliente de DHCP.

No cliente basta deixar configurado a utilização de servidor DHCP: no caso de Unix-like este comando é **dhclient**.

Em GNU/Linux Debian (ou Ubuntu) no arquivo _/etc/network/interfaces_ adicione a seguinte linha:

    iface eth0 inet dhcp

Atualizado em 1 de Junho de 2008.
