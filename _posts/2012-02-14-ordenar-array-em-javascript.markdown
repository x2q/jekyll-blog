---
layout: post
title: "Ordenar Array em Javascript"
date: 2012-02-14 20:03
comments: true
categories: [javascript]
published: true
---

Recentemente tive um problema ao ordenar array em javascript, na verdade
o array era ordenado, porém não da "forma padrão" desta forma quando eu
rodava no firefox (entenda: teste de integração com capybara) e com o
webkit (entenda: teste de integração usando o capybara-webkit) retornava
valores diferentes.

Vou usar o nodejs como console.

Vamos ao primeiro exemplo:

    > var nomes = ['Bob', 'Jonh', 'Alice'];
    undefined
    > nomes.sort();
    [ 'Alice', 'Bob', 'Jonh' ]

Ordenação normal, mas agora com números:

    > var numeros = [ 20, 2010, 300 ];
    undefined
    > numeros.sort();
    [ 20, 2010, 300 ]

Ops… erro. Tenta ordenar como string ao invés de número.

Para "remediar" podemos passar uma função para a função ```sort```.
Essa função espera um retorno do tipo ```-1```, ```0``` ou ```1```:

* ```-1``` (ou menor que zero) se o **primeiro** argumento for menor que o **segundo**;
* ```0``` se os dois forem iguais;
* ```1``` (ou maior que zero) se o **segundo** argumento for maior que o **primeiro**;

Uma solução bem verbosa é esta:

    > numeros.sort(function(x, y){ return((x > y) ? -1 : ( x > y ? 1 : 0) ) });
    [ 20, 300, 2010 ]

Uma solução "menor" é esta:

    > numeros.sort(function(x, y) { return( x - y); });

Basicamente na subtração nos podemos ter os seguintes valores:

* quando o x é menor que o y retorna um número negativo;
* quando x é igual a y retorna zero;
* e quando x é maior que y retorna um número positivo;

Meu caso era um pouco mais complicado, pois eu queria ordenar um array
semelhante a este:

    > var arr = [[, 'ponto'] , [2, 'ponto e virgua'], [1, 'barra']];

Ou seja: um array de array para ordenar pelo primeiro elemento (podendo
ainda este ser vazio).

A solução:

    > arr.sort(function(x, y){ if(!x[0]) { return(1) } else { return (x[0] - y[0]) } });
    [ [ 1, 'barra' ],
      [ 2, 'ponto e virgua' ],
      [ , 'ponto' ] ]

Sim o "vazio" fica por último, essa é a regra.

Fonte: [Sorting a JavaScript array using array.sort()](view-source:http://www.javascriptkit.com/javatutors/arraysort.shtml)
