---
layout: post
title: "Cron - Daemon de Comandos"
date: 2006-09-14 04:22
comments: true
categories: [cron, daemon, linux, unix]
---

O ``cron`` é um programa que roda em segundo plano - daemon - e executa comandos agendados conforme o arquivo ``/etc/crontab`` ou em crontab de cada usuário. E para ajudar na edição dos arquivos o comando ``crontab``.

# Arquivo de Configuração

Um exemplo do arquivo:

    # /etc/crontab
    #
    # na linha abaixo informa o shell que executara os comandos, caso nao exista
    # usa /bin/sh
    SHELL=/bin/sh
    #
    # Esta linha informa o PATH de comandos, caso omitida o cron não usa path.
    # e deve ser informado o comando completo
    PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
    #
    # m h dom mon dow  user   command
    0 4 * * *          root   /usr/bin/poff
    01-59/20 0-3 * * * root   /usr/bin/pon

Como a maioria dos arquivos de configuração, o caractere ``#``, no início da linha, indica um comentário e é completamente ignorado pelo programa. E se estiver achando a tabulação muito difícil de visualizar pode colocar suas próprias tabulações e espaços extras.

Além deste existe os arquivos ``cron.hourly``, ``cron.daily``, ``cron.weekly`` e `cron.monthly`` que já estão configurados para executar, respectivamente, a cada hora, dia, semana e mês.

Na seqüência é colocado o minuto, a hora, o dia do mês, o mês, o dia da semana, o usuário e o comando. Nota: o usuário é omitido se você está editando o contrab de um determinado usuário.

Em cada campo existe uma configuração:

* Minuto: pode ter valores de ``00`` a ``59``, no qual ``00``;
* Hora: definido conforme relógio de 24 horas;
* Dia do Mês: faixa de ``01`` a ``31``;
* Mês: faixa de ``01`` a ``12``;
* Dia da Semana: segue a faixa de ``00`` a ``07``.

Tanto ``0`` como ``7`` indica domingo e ``6`` sábado;

Também é possível colocar as três primeiras letras do dia da semana (em inglês): ``SUN``, ``MON``, ``TUE``, ``WED``, ``THU``, ``FRI``, ``SAT`.

# Comando

Pode ser tanto o comando sem o path quanto o comando com o path.

Exemplos:

    /bin/pwd
    pwd > ~/cron

# Observações:

* Em qualquer lugar pode-se usar um ``*`` quando não é relevante o uso no campo. Pense no asterisco como: "qualquer tempo".
* Intervalos de tempo pode ser colocados entre hífens, exemplo: ``00-15``;
* É possível usar listas usando uma ``,`` (vírgula), exemplo: ``sun,mon,tue``;
* Também é permitido colocar saltos de tempo: ``00-59/15``; no exemplo se colocado no campo de minutos significa: qualquer tempo a cada 15 minutos.

# O Comando crontab

Este comando é usado para editar os arquivos particulares dos usuários:

Seus parâmetros:

* ``-l`` - lista as tarefas agendadas para o usuário;
* ``-e`` - edita o agendador;
* ``-r`` - apaga o arquivo do usuário;
* ``-u usuario`` - informa o usuário ao qual deve ser aplicado os parâmetros acima (somente o usuário ``root`` pode usar).

# Exemplos Comentados

Nos primeiros cinco dias do mês às **19:25**:

    25 19 01-05 * * /bin/script

De segunda a sexta ao meio-dia e à meia-noite:

    00 00,12 * * 2-5 /bin/script

Script rodar Segunda,Quarta,Sexta às 2 horas:

    0 2 * * mon,wed,fri /bin/script

Script para rodar Terça,Quinta às 3 horas:

    0 3 * * tue,thu /bin/script

Programar todos os dias às 21h:

    0 21 * * * /usr/local/bin/command

A cada 15 minutos e entre as hora 00 e 03:

    00-59/15 0-3 * * * /root/script.backup

Programar para executar segunda, quarta e sexta (qualquer uma das linhas abaixo):

    00 06 * * mon,wed,fri /root/script.backup
    00 06 * * 1,3,5 /root/script.backup
