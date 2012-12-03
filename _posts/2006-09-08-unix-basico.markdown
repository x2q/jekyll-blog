---
layout: post
title: "Unix Básico"
date: 2006-09-08 04:56
comments: true
categories: [basic, terminal, unix]
---

Básico sobre sistemas operacionais Unix-like.

# Contas de Usuários

Sistemas Unix-like são muito conhecidos por serem multitarefa e
multi-usuários, uma vez que o sistema surgiu para ser trabalhado em rede.

Como um sistema para ser tratado em rede valem-se as contas de usuários: a
forma pela qual identifica-se um usuário no sistema; e da qual restringi
usuários a somente seus dados e configurações.

Para ter acesso e por conseguinte usar o sistema é preciso (e em grande parte
obrigatório, a grande exceção são os Live CDs) estar cadastrado no sistema,
i. e., é preciso um nome de usuário e uma senha. O cadastro dos usuários
recaem sobre o administrador do sistema chamado de `root`.

O usuário `root` (**administrador do sistema** ou **super usuário**) tem uma
grande gama de permissões de acesso ao sistema e à arquivos. É de suma
importância que este usuário não seja usado de forma indiscriminada e
aleatória, por exemplo navegar pela internet, editar imagens, dentre outros.
Este usuário somente deve ser usado para fazer ajustes/manutenção ao sistema.

# Terminais

Certamente todo o poder de um sistema Unix está no console (terminal ou modo
texto), partindo de um console pode-se executar diversas tarefas e também
automatizar e otimizar tarefas.

Se seu sistema não estiver configurado para iniciar automaticamente partindo
de uma interface gráfica o que deve aparecer é, nas últimas linhas algo
semelhante à:

Exemplo FreeBSD:

    FreeBSD/i386 (host0) (ttyv0)
    login:

Exemplo Debian:

    Debian GNU/Linux 3.1 pc1 tty1
    pc1 login:

Nos dois exemplos a primeira linha mostra detalhes da máquina: Sistema
Operacional/Distribuição, nome do computador, identificação do terminal; a
segunda linha pede o nome de login.

Quando digitado e confirmado com `<ENTER>` o nome de usuário é pedido uma
senha, _password_, note que não é mostrado qualquer símbolo quando é
digitado, isso é por uma questão de segurança, alguém pode supor sua senha
a partir de seu tamanho, exemplo: se alguém ver que sua senha tem seis ou 8
caracteres e toda vez que você digita utiliza o teclado alfanumérico, pode-se
supor que seja uma data.

Se digitada a senha correta você se loga no sistema e após isso é mostrado o
`MOTD` (mensagem do dia, conteúdo do arquivo `/etc/motd`) na seqüência é
mostrado o terminal de comando simbolizado pelo caractere **#**, para conta de
`root`, **$** ou **%** para outros usuários do sistema.

Após logar no sistema é mostrado um **shell** (que é um interpretador de
comandos), para iniciar a utilização do sistema. A partir do seu shell é
possível iniciar todos os comandos, programas e scripts disponíveis.

Em tratando-se de sistema multi-usuário/multitarefa o sistema pode executar
uma grande quantidade de programas de uma vez. É, certamente, um desperdício
usar apenas um terminal e/ou apenas um programa por vez.

Os consoles virtuais existem exatamente para logar no sistema e executar
várias tarefas. O sistema encarrega-se de redirecionar a saída (tela) e a
entrada (teclado) de um terminal somente para o mesmo, uma alusão a ter
vários monitores e vários teclados no mesmo computador.

Uma combinação `<ALT>+<F1>` até `<ALT>+<F12>` é usada para movimentar-se
entre os terminais virtuais. Essas combinações somente diferem de duas formas:

A primeira é se estiver em terminal virtual basta `<ALT>+<F_n_>`, a segunda
é quando está na interface gráfica é necessário teclar também o `<CONTROL>`
ficando `<CONTROL>+<ALT>+<F_n_>`.

De acordo que você se movimenta nos consoles virtuais o sistema encarrega-se
de salvar e restaurar o conteúdo da tela correspondente. Esta "ilusão" não
interrompe um processo quando está saindo de um terminal para outro, o programa
continua a ser executado.

# Usuários, Grupos e Permissões

Sendo multi-usuário o sistema pode gerenciar inúmeros usuários, trabalhando
simultaneamente em tarefas iguais ou distintas. Ainda é responsável pelo
gerenciamento e pelo compartilhamento de hardware (por exemplo acesso a
periféricos, memória, …) e de software (arquivos em disco, programas, …)
de forma justa e apropriada entre os usuários.

O sistema por um conjunto de permissões que governam quem pode ler, escrever e
executar recursos forma a base para o gerenciamento de usuários. Sendo
agrupadas as três para usuário dono, para o grupo do usuário e para todos os
outros usuários do sistema.

As permissões são comumente representadas na forma de octetos: três octetos;
um octeto para o usuário, um para o grupo e um para os outros. Veja no quadro
abaixo:

<table>
<tbody>
<tr>
<td>Valor Octal</td>
<td>Permissão</td>
<td>Em caractere</td>
</tr>
<tr>
<td>0 (0+0+0)</td>
<td>Nenhuma</td>
<td>---</td>
</tr>
<tr>
<td>1 (0+0+1)</td>
<td>Executar</td>
<td>--x</td>
</tr>
<tr>
<td>2 (0+2+0)</td>
<td>Escrever</td>
<td>-w-</td>
</tr>
<tr>
<td>3 (0+2+1)</td>
<td>Ler e Executar</td>
<td>r--</td>
</tr>
<tr>
<td>4 (4+0+0)</td>
<td>Ler</td>
<td>r--</td>
</tr>
<tr>
<td>5 (4+0+1)</td>
<td>Ler e Executar</td>
<td>r-x</td>
</tr>
<tr>
<td>6 (4+2+0)</td>
<td>Ler e Escrever</td>
<td>rw-</td>
</tr>
<tr>
<td>7 (4+2+1)</td>
<td>Ler, Escrever e Executar</td>
<td>rwx</td>
</tr>
</tbody></table>

O comando `ls -l` pode ser usado para verificar as permissões para arquivos,
diretórios dentre outros, segue um exemplo:

    # ls -l
    total 10344
    drwxr-xr-x  6 dmitry dmitry    4096 2007-04-07 21:27 BSD
    drwxr-xr-x  3 dmitry dmitry    4096 2007-02-24 18:49 fhs
    drwxr-xr-x 17 dmitry dmitry    4096 2007-03-29 21:23 Linux
    drwxr-xr-x  2 dmitry dmitry    4096 2006-05-11 18:39 POSIX_files
    -rw-r--r--  1 dmitry dmitry   16224 2006-06-13 19:26 POSIX.htm
    drwxr-xr-x  3 dmitry dmitry    4096 2007-02-05 09:55 Single_UNIX_Specification
    -rw-r--r--  1 dmitry dmitry   80221 2007-04-06 08:49 unix_a4.pdf
    -rw-r--r--  1 dmitry dmitry   27179 2006-06-18 15:18 Unix_history-simple.png
    -rw-r--r--  1 dmitry dmitry  667436 2004-01-31 04:25 unix_posterA3.pdf
    [ … ]

No comando `ls -l` a primeira coluna mostra as permissões: `-rw-r--r--`.

O primeiro caractere mostra se é um arquivo normal `-`, um diretório `d`, um
dispositivo especial de bloco `b` ou de caractere `c` ou um link `l`.

Baseado nestas definições o administrador do sistema pode lhe dar permissões
para as mais diversas tarefas, exemplos: para utilizar o drive de disquete
deve-se estar no grupo `floppy`, para usar o CD-ROM no grupo `cdrom`, além é
claro da aplicação ser feita para arquivos e diretórios: pode criar um
diretório para um grupo de trabalho e a partir disso configurar para que
todos do grupo tenha inicialmente os mesmos acessos a arquivos.
