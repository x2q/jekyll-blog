---
layout: post
title: "Manipulando Arquivos e Diretórios - Linha de Comando"
date: 2006-09-08 05:30
updated: 2012-12-13 21:02
comments: true
categories: [linux, terminal, tools, unix]
---

Uma pequena amostra poder dos terminais em ambiente Unix no gerenciamento de
arquivos.

# Navegação

## pwd

Exibe o diretório corrente, equivalente ao site atual no navegador.

Parâmetros:

* `-P`: informa o diretório real, caso esteja em um diretório que é um link.

## cd

É usado para navegar entre diretórios.

Parâmetros:

* `-`: usado para voltar para o último diretório visitado pelo `cd`;
* `-P dir` ou `-p dir`: caso o diretório destino informado seja um link o
`cd` segue o link até chegar ao diretório real; o uso maiúsculo é para
GNU/Linux e o uso minúsculo é para FreeBSD;

Endereços Especiais:

Muitos destes endereços são quase universais em relação ao terminal e
interface gráfica.

* `/dir`: pode ser informado o caminho completo iniciando pela raiz ou de onde
está, exemplo: o diretório atual é `/var/` e quer ir para `/var/www/`, usa-se
`cd /var/www/` ou `cd www`;

* `..`: indica para subir um nível, exemplo: o diretório atual é `/var/www/` e
quer ir para `/var/`, usa-se `cd ..`; e neste exemplo para ir dois níveis
acima: `cd ../../`;
* `~`: é usado para informar que é o diretório home do usuário, exemplo:
`cd ~/textos`, vai para `/home/dmitry/textos`.

## ls

Mostra o que tem no diretório corrente ou em outro, e até mesmo somente para
ver as permissões de um arquivo.

Parâmetros:

`-l`: informa permissões, dono, grupo, tamanho, data de modificação, exemplo
abaixo:

    % ls -l
    total 12
    -rw-r--r-- 1 dmitry dmitry 9500 2007-03-09 19:30 psaux

`-d`: trata o diretório como um arquivo exibindo suas permissões e não as
permissões de seu conteúdo. Veja abaixo:

    % ls -l /home/dmitry/textos/
    total 10
    -rw-r--r--  1 dmitry  dmitry  6355 May 11 14:23 ps_aux
    drwxr-xr-x  2 dmitry  dmitry   512 May 11 14:23 tutoriais
    -rw-r--r--  1 dmitry  dmitry     0 May 11 14:25 vim

    % ls -ld /home/dmitry/textos
    drwxr-xr-x  3 dmitry  dmitry  512 May 11 14:26 /home/dmitry/textos

`-a` ou `-A`: ambos mostram os arquivos ocultos (com o primeiro caractere *.*,
ponto), a diferença existe em que o minúsculo mostra `..`, diretório superior,
e *.*, diretório atual, enquanto o maiúsculo não os mostra.

## stat

Gera informações sobre o arquivo:

    % stat index.html
      File: `index.html'
      Size: 2770      	Blocks: 8          IO Block: 4096   arquivo comum
    Device: 305h/773d	Inode: 538032      Links: 1
    Access: (0644/-rw-r--r--)  Uid: ( 1000/  dmitry)   Gid: ( 1000/  dmitry)
    Access: 2007-03-13 11:15:57.000000000 -0300
    Modify: 2007-03-12 08:49:42.000000000 -0300
    Change: 2007-03-12 11:31:10.000000000 -0300

# Manipulação de Diretórios e Arquivos

## cp

É usado para copiar arquivos, para o mesmo diretório ou outro; os arquivos
devem estar montados no sistema, disco local ou NFS;

Parâmetros:

* `-r`: o comando `cp` não copia diretórios para isso é usado esta opção para
copiar recursivamente;
* `-a`: **arquivar**, mantêm as permissões do arquivo e preserva links.

Nota: sempre é necessário informar o diretório ou o arquivo de destino, se o
diretório de destino for o atual use `.` (ponto) como endereço; Caso queira
copiar arquivos de outro computador veja o comando `scp` (mais em
[Conexões Remotas](/conexoes-remotas)).

## mv

Move e/ou renomeia arquivos e diretórios; a função de renomear para sistema
unix está intrínseca ao ato de mover. Este comando não requer que seja
informado caso mover/renomear diretórios, mas da mesma forma que `cp` necessita
de um destino, mesmo que seja o diretório atual.

## rm

Remove arquivos e/ou diretórios.

Parâmetros:

* `-i`: interage pedindo confirmação para cada item a ser apagado;
* `-f`: não pede confirmação, mesmo se a opção `-i` seja usada;
* `-r`: remove uma árvore de diretórios.

## mkdir

Cria diretórios.

Parâmetros:

* `-p`: faz com que crie diretórios pai, ou superiores, caso eles não existam,
exemplo: quer criar a árvore a partir de onde está tutoriais/unix, mas o
diretório tutoriais não existe, se tentar criar somente com
`mkdir tutoriais/unix` retorna um erro e não cria nada, com a opção `-p` o
`mkdir` não mostra mensagem de erro e cria os diretórios.

## rmdir

Remove diretórios que estão vazios.

    % rmdir dir_vazio

## Trabalhando com Arquivos de Texto

Grande parte dos arquivos de configuração dos programas são armazenados em
formato texto. Além deste tópico sugiro que leia, aqui mesmo,
[Editor de Arquivos vi](/vim), pois na maioria das falhas dos sistema é melhor
configurar para corrigir o erro na linha de comando e um bom editor como `vi` é
a minha indicação.

## cat

Exibe o conteúdo de arquivos como em:

    % cat /etc/shells
    # $FreeBSD: src/etc/shells,v 1.5 2000/04/27 21:58:46 ache Exp $
    #
    # List of acceptable shells for chpass(1).
    # Ftpd will not allow users to connect who are not using
    # one of these shells.

    /bin/sh
    /bin/csh
    /bin/tcsh
    /usr/local/bin/zsh
    /usr/local/bin/rzsh

Para numerar linhas a opção `-n`:

    % cat -n /etc/shells
      1	# $FreeBSD: src/etc/shells,v 1.5 2000/04/27 21:58:46 ache Exp $
      2	#
      3	# List of acceptable shells for chpass(1).
      4	# Ftpd will not allow users to connect who are not using
      5	# one of these shells.
      6
      7	/bin/sh
      8	/bin/csh
      9	/bin/tcsh
     10	/usr/local/bin/zsh
     11	/usr/local/bin/rzsh

## head

A função do `head` é mostrar as primeiras linhas, por padrão mostra as
primeiras 10 linhas, mas pode ser configurado com a opção `-n NUM` para
determinar a quantidade de linhas a serem lidas.

## tail

O `tail` exibe as 10 últimas linhas por padrão, configurado com `-n NUM` da
mesma forma que `head`.

## grep

Filtra o texto procurando uma expressão quando encontra exibe a linha
correspondente, por exemplo:

    % df -h | grep mnt
    /dev/ad0s5      18G     16G    1.6G    91%    /mnt/ad0s5

Para filtrar linha que não quer user `-v`:

    % df -h | grep -v dev
    Filesystem     Size    Used   Avail Capacity  Mounted on

## sort

Faz ordenação, ordena números como um conjunto com a opção `-n` e `-r` faz a
ordenação seja inversa, exemplo:

Texto não ordenado:

    % cat /etc/rc.conf

    # -- sysinstall generated deltas -- # Fri May  4 06:38:28 2007
    # Created: Fri May  4 06:38:28 2007
    # Enable network daemons for user convenience.
    # Please make all changes to this file, not to /etc/defaults/rc.conf.
    # This file now contains just the overrides from /etc/defaults/rc.conf.
    usbd_enable="YES"
    sshd_enable="YES"
    keymap="br275.cp850"
    linux_enable="YES"
    clear_tmp_enable="YES"

Texto ordenado:

    % cat /etc/rc.conf | sort

    # -- sysinstall generated deltas -- # Fri May  4 06:38:28 2007
    # Created: Fri May  4 06:38:28 2007
    # Enable network daemons for user convenience.
    # Please make all changes to this file, not to /etc/defaults/rc.conf.
    # This file now contains just the overrides from /etc/defaults/rc.conf.
    clear_tmp_enable="YES"
    keymap="br275.cp850"
    linux_enable="YES"
    sshd_enable="YES"
    usbd_enable="YES"

# Permissões

Informações atualizadas em [Permissões](/permissoes).

# Links

Como já mencionado acima existem os links simbólicos e os links rígidos
(tradução minha, muitos não traduzem de hard link).

Os links simbólicos são ligações baseadas no caminho, de diretório e
subdiretórios, e os hard links são baseados no número de i-node, que é único
para cada arquivo dentro de uma mesma partição.

Para criar tanto links simbólicos como hard links usa-se o comando `ln`, com a
sintaxe:

    % ln origem destino

A sintaxe acima cria um hard link de origem para destino, para criar links
simbólicos adicione `-s` após o nome o programa.

Nota: Não é possível criar hard links de diretórios e nem de arquivos que
fiquem em partições diferentes.

# Busca

## find

Procura arquivo e/ou diretório. Levando em conta que o `find` pode ser chamado
mesmo sem parâmetros (fazendo com que liste os arquivos que encontrar, isso não
pode ser feito em FreeBSD, o mínimo que pode é `find /dir`, como em `find .`),
abaixo estão listado os principais parâmetros.

`-name`

Procura por o nome após este parâmetro, pode-se usar caracteres coringas para a procura:

    % find /etc/ -name rc.local
    /etc/init.d/rc.local
    /etc/rc.local

    % find /root/ -name "log*"
    ./log
    ./log2

`-exec`

Executa um comando para cada arquivo, esta forma é mais lenta que outras pois a
cada arquivo encontrado é executado o programa, algumas vezes é melhor fazer um
arquivo com a lista dos arquivos encontrados:

Forma com o `find`:

    % find /root/ -name "log*" -exec ls -l {} \;
    [ ... ]

Forma com uma lista de arquivos:

    % find /root/ -name "log*" > lista
    % ls `cat lista`
    [ ... ]

Claro que este exemplo é muito simples, mas use qualquer comando com uma lista,
o conteúdo entre **` `** é substituindo como se informado manualmente, neste
exemplo é como se o `cat` fosse executado primeiro e somente então fornecido o
valor para o `ls`.

`-type`

Com o **find** pode-se procurar por um tipo de arquivo: `-type t`, substituindo
`t` por `f` para procurar arquivos, `d` para procurar diretórios ou por `l`
para procurar links.

Para arquivos e diretórios isto é particularmente útil quando for copiar
arquivos de outros sistemas de arquivos não nativos ou que não tenham suporte
as permissões de unixs, já que o sistema quando monta dá permissão `755` para
todos os arquivos e diretórios:

    % find -type f -exec chmod 644 {} \;
    % find -type d -exec chmod 755 {} \;

Para links é muito fácil procurar links quebrados com a opção `-follow`, esta
opção mostra na saída de erro padrão os nomes dos links quebrados:

    % find -type l -follow
    ./user

    % file user
    user: broken symbolic link do '/user'

`-mtime`

Para procurar por arquivos modificados recentemente (últimas 24 horas).

Veja abaixo os arquivos modificados no dia 18 de maio de 2007 feito com `ls` e
filtragem com o `grep`:

    % ls -l | grep "2007-05-08"
    -rw-r--r-- 1 dmitry dmitry 12110 2007-05-18 08:58 dialog.htm
    -rw-r--r-- 1 dmitry dmitry  4699 2007-05-18 09:11 downloads.html
    -rwxr-xr-x 1 dmitry dmitry  1705 2007-05-18 09:23 du2sort.bz2
    -rw-r--r-- 1 dmitry dmitry  2028 2007-05-18 08:29 index.html
    -rw-r--r-- 1 dmitry dmitry 38619 2007-05-18 09:43 manipulando_arquivos_e_diretorios.htm
    -rw-r--r-- 1 dmitry dmitry  2112 2007-05-18 09:17 servicos.html
    -rw-r--r-- 1 dmitry dmitry  1467 2007-05-18 08:33 sitemap.txt
    -rw-r--r-- 1 dmitry dmitry  3542 2007-05-18 09:35 sobre.html

E abaixo a mesma busca com o find

    % find . -mtime -1
    .
    ./downloads.html
    ./index.html
    ./du2sort.bz2
    ./dialog.htm
    ./sitemap.txt
    ./sobre.html
    ./servicos.html
    ./manipulando_arquivos_e_diretorios.htm

Note o `-1` poderia ser `-2` para as útimas 48 horas e assim por diante.

Nota: o comando `ls` pode listar os arquivos pela data de modificação com a
opção `-t`, neste caso o `ls` lista todo o conteúdo ordenando por data de
modificação e não somente os arquivos alterados.

`-perm`

Procurar por arquivos com as permissões:

    % find -type f -perm 777

ou

    % find -type f -perm /ou=rwx

`-user`

Procura por arquivo com um usuário como dono:

    % find -user \1000

ou

    % find -user dmitry

Depois dessa dissecação, leia a página de manual do find com: `man find`.

## which

Procura pelo caminho do comando.

    % which find
    /usr/bin/find

## whereis

Além de informar o caminho do comando informa também o caminho do manual.

    % whereis find
    find: /usr/bin/find /usr/share/man/man1/find.1.gz /usr/src/usr.bin/find

# Completando no Teminal

Para tornar mais rápida a digitação ou para controlar os erros existe uma forma
de completar o que está digitando: usando a tecla `<tab>` ela completa a partir
da palavra (ou meia palavra atual), exemplo: tente digitar `cd /e<tab>` para
ver completando.

# Concatenação

A saída de um comando pode ser usada para ser a entrada de outro: exemplo:
`ps aux | grep xterm`, aqui é listado os programas que estão atualmente rodando
e é imediatamente filtrado, pela concatenação através de `|` para mostrar
somente os que tem a linha **xterm**.

A saída de um comando pode ser passada para um arquivo, por exemplo:
`ls -l > lista` gera uma lista dos arquivos do diretório corrente e coloca,
"imprime", no arquivo lista.

# Segundo Plano - &

Muitas vezes os comandos demoram para serem executados, com isso o terminal
fica parado até que o comando termine. A resolução deste problema é colocar o
caractere `&` no final da linha.

Mas, muitos programas apesar de colocados para segundo plano ficam ainda
enviando mensagem para a tela do terminal isso facilmente se resolve colocando
ntes do `&` o seguinte trecho: `>/dev/null 2>&1`, que faz o redirecionamento
para um "buraco sem fundo", este é um dispositivo de caractere especial que tem
a função justamente de jogar fora tudo à ele direcionado. Se quiser ter certeza
de que a saída será redirecionada use: `1>/dev/null 2>/dev/null` que tem o
mesmo efeito.

# Comandos em Seqüência

No caso que vários comandos precisem ser executados por vez, em seqüência, o
caractere `;` (ponto e vírgula) separa comandos, por exemplo: compactar o
diretório `/usr/backup` e logo em seguida ver o tamanho do arquivo:

    % tar cfz /usr/backup.tar.gz /usr/backup/ ; du -sh /usr/backup.tar.gz
    [ ... ]

O `;` executa o segundo comando mesmo que o anterior tenha saído com erro, caso
seja necessário executar um comando após o outro somente se o anterior tiver
executado sem problemas use o `&&`:

    % tar cfz /usr/backup.tar.gz /usr/backup/ && du -sh /usr/backup.tar.gz
