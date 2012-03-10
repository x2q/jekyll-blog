---
layout: post
title: "Endereços IP"
date: 2007-01-03 11:57
comments: true
categories: [internet, ip, ip-address]
---

Em redes TCP/IP cada host, ou interface de rede, tem um endereço IP: 4 grupos de 8 bits, no qual podem ter números entre ``0`` e ``255``, separados por um ponto; exemplo: _192.80.0.3_.

Um conjunto de 1, 2 ou de 3 (sempre um dos primeiros) grupos identificam a rede e os outros identificam os hosts.

# Rápida introdução a conversão binária/decimal

<pre>1      1      1      1      1      1      1      1       binário
2<sup>7</sup>     2<sup>6</sup>     2<sup>5</sup>     2<sup>4</sup>     2<sup>3</sup>     2<sup>2</sup>     2<sup>1</sup>     2<sup>0</sup>       potência
128    64    32     16     8      4      2      1        decimal</pre>

Onde, no octeto, existir o valor 1, procurar a ordem correspondente e soma-se o valor, caso exista o valor 0 o valor simplesmente não entra na soma; exemplo:

<pre>1      0      1      0      1      0      0      0
2<sup>7</sup>     2<sup>6</sup>     2<sup>5</sup>     2<sup>4</sup>     2<sup>3</sup>     2<sup>2</sup>     2<sup>1</sup>     2<sup>0</sup></pre>

No caso acima os únicos que estão "ligados" são as posições 7, 5 e 3, portanto a soma fica: 128 + 32 + 8 = 168.

# Classes

As classes são grupos que diferem na quantidade dos octetos destinada aos hosts e as quantidade destinada à rede:

* Classe A: o primeiro octeto informa a rede e os outros os hosts. O endereço da rede vai de _1.x.x.x_ até _126.x.x.x_; desta forma podem existir 126 redes;
* Classe B: à rede pertencem os dois primeiros octetos. Os endereços vão de _128.0.x.x_ até _191.255.x.x_;
* Classe C: os três primeiros octetos informam rede e os demais hosts; de _192.x.x.x_ até _223.x.x.x_.

# Endereços de Rede e de Broadcast

Há dois valores que não são usados para identificar um host numa rede:

## Endereço de Rede

Com o valor 0; exemplo: _129.10.20.0_, _192.80.3.0_ etc;

## Endereço de Broadcast

Este tipo de endereço é usado em especial para indicar todos os computadores da rede; por exemplo para enviar pacotes para todos de determinada rede.

Valor 255, porém pode variar com o uso de máscaras - visto adiante -; exemplo: _192.80.3.255_, _120.255.255.255_, dentre outros;

# Máscaras de Rede

As classes identificam a quantidade de máquinas numa rede: uma rede para 60 hosts deve usar endereço de classe C, exemplo: _172.168.200.x_ com isso pode-se conseguir 256 hosts, no entanto, para este exemplo, há um desperdício de 196 endereços.

Para resolver o problema acima de desperdício de IPs existem as máscaras de rede.

Para as classes A, B e C as máscaras definidos por padrão são, respectivamente: _255.0.0.0_, _255.255.0.0_ e _255.255.255.0_

Para evitar o desperdício de IPs as máscaras podem ser configuradas para que a rede comporte menos hosts.

O conceito de máscaras de rede, ou de máscaras de sub-rede, fica melhor entendido com exemplo. Segui-se abaixo:

## Exemplo

Rede para 25 hosts, no qual o endereço, segundo a classificação por classes, é _172.16.252.0_. Porém há desperdício de 254 endereços IPs; a solução é usar a máscara _255.255.255.224_.

A máscara faz com que os bits destinados a identificação da rede aumente em 2, e os de hosts diminua para 6 bits, claro que neste exemplo. Como rede fica o endereço _172.16.252.0_ e broadcast _172.16.252.0_.

Analise:

Rede

<table>
<tbody>
<tr>
<td>172 (10101100)</td>
<td>16 (0001000)</td>
<td>252 (11111199)</td>
<td>0 (00000000)</td>
<td>IP</td>
</tr>
<tr>
<td>255 (11111111)</td>
<td>255 (11111111)</td>
<td>255 (11111111)</td>
<td>224 (11100000)</td>
<td>máscara</td>
</tr>
</tbody>
</table>

Broadcast

<table>
<tbody>
<tr>
<td>172 (10101100)</td>
<td>16 (00001000)</td>
<td>252 (11111100)</td>
<td>31 (00011111)</td>
<td>IP</td>
</tr>
<tr>
<td>255 (11111111)</td>
<td>255 (11111111)</td>
<td>255 (11111111)</td>
<td>224 (11100000)</td>
<td>máscara</td>
</tr>
</tbody>
</table>

Hosts

<table>
<tbody>
<tr>
<td>172 (10101100)</td>
<td>16 (00001000)</td>
<td>252 (11111199)</td>
<td>1 (00011111)</td>
<td>IP</td>
</tr>
<tr>
<td>255 (11111111)</td>
<td>255 (11111111)</td>
<td>255 (11111111)</td>
<td>224 (11100000)</td>
<td>máscara</td>
</tr>
</tbody>
</table>

Desta forma se for criada a rede _172.16.254.0/255.255.255.224_ e ela tiver no mesmo meio físico que a rede _172.16.254.0/255.255.255.0_: elas não poderão se comunicar, pois são redes distintas.

# Endereços Reservados para Redes Privadas

Quando for criada uma rede que nunca usará a internet, portanto será privada, pode-se usar qualquer endereço para a rede. Entretanto, foram reservados endereços para este propósito de acordo com RFC1597:

Classe A: _10.0.0.0_ até _10.255.255.255_;
Classe B: _172.16.0.0_ até _172.31.255.255_;
Classe C: _192.168.0.0_ até _192.168.255.255_.

Todos com as máscaras padrão de cada classe.

Existe ainda o endereço de loopback, usado para indicar a si próprio: [127.0.0.1](http://127.0.0.1/ "127.0.0.1") indicado muitas vezes por [localhost](http://localhost/ "Localhost").

Atualizado em 22 de Maio de 2007.
