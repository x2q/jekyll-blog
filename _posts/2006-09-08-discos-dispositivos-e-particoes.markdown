---
layout: post
title: "Discos, Dispositivos e Partições"
date: 2006-09-08 07:54
comments: true
categories: [file-system, linux, unix]
---

Unix-like é um sistema com grande ênfase a arquivos: CD-ROM, disquete, teclado, monitor, entre outros são considerados arquivos, desta forma basta que determinado programa leia ou escreva em um arquivo para poder acessar um dispositivo.

Nesses sistemas o uso dos periféricos como HD, CD-ROM, disquete, pen drive e outros se faz com a montagem, necessitando então pontos de montagem, isso significa que o diretório de seu dispositivo não ficará solto como se não pertencesse ao sistema; pelo contrário os dispositivos são adicionados a estrutura do sistema _raiz_.

Com o que foi colocado acima estes dispositivos poderiam ser acessados de qualquer parte do sistema, mas comumente estes diretórios de montagem ficam em _/mnt/_ ou _/media/_.

# Tipos de Sistemas de Arquivos

Este tópico somente salienta as características básicas dos tipos existentes mais comuns.

## ext

_Extended filesystem_: é o sistema de arquivo de disco mais utilizado no GNU/Linux. Existe _ext2_ e _ext3_, sendo este o mais difundido atualmente.

* _ext2_: Arquitetado por Rémy Card para substituir o _ext_; não suporta journaling (os dados são gravados diretamente, oferecendo melhor desempenho em termos de velocidade e uso da CPU).
* _ext3_: Com suporte a journaling (guarda de informações sobre escrita, resultando numa recuperação rápida e confiável caso ocorra uma interrupção).

## reiserfs

Criado por Hans Reiser é um dos sistemas com suporte a journaling mais rápidos atualmente. Sua única desvantagem é o consumo elevado de CPU.

## FFS: Fast File System

Sistema nativo para muitos BSDs (FreeBSD, NetBSD, OpenBSD, Sun Solaris, ...). É derivado de UFS (Unix File System) Sistema de arquivos para Unix.

## Swap: memória virtual

É usado adicional à memória RAM. Como é usado no disco fica a deriva da velocidade do HD, não é necessário montar e sim adicionar. Não é indicado para ser usado em pen drives pelo fato de que reduz sua vida útil, então em uma instalação de GNU/Linux em pen drive não coloque partição _swap_.

## nfs

Sistema de arquivo para ser usado em rede: um computador monta e desta forma independente do formato do sistema de arquivos do outro computador ele pode ser acessado fazendo com que o servidor de NFS mande informações para o cliente.

## iso9660 ou cd9660

Para ser usado em CDs. Inicialmente os CDs somente suportavam músicas, logo viu-se a alternativa de usá-los para armazenar arquivos. Muitos sistemas operacionais tem sua própria  derivação do iso9660, exemplos bem comuns são: GNU/Linux com _Rock Ridge_ e _Windows com Joliet_.

## vfat

Sistema de arquivos do Windows: _fat16_ ou _fat32_. Também é amplamente (creio que totalmente) usado em disquetes.

## ntfs

Usado em versões mais novas do Windows, ao contrário de todos os outros citados acima não tem muito suporte (a escrita) em GNU/Linux e outros Unix-like.

# Partições

Particionamento é o meio pelo qual o disco pode ser dividido para que uma parte possa ser formatada em um tipo de sistemas de arquivos e também para que o disco seja facilmente recuperado em caso de necessidade de formatação, tornando fácil a recuperação do disco e do sistema operacional. Por exemplo: se está separados os dados do sistema dos dados do usuário, então torna-se fácil recompor o sistema sem alterar de forma alguma os dados de usuários.

Em discos rígidos, por uma limitação, o dispositivo somente pode suportar quatro partições, mas com as partições estendidas o número aumenta consideravelmente - de fato partições em uma partição estendida são reconhecidas como somente uma partição - depois disso pode-se concluir que um disco pode suportar quatro partições, entre primária e estendida, e que partições estendidas podem, por sua vez suportar mais partições.

Para fazer particionamento do disco há **cfdisk** e **fdisk** muito comuns em distribuições Linux, para formatar (criar o sistema de arquivos que será usado no dispositivo) **fdformat**.

# Montagem e Desmontagem

É preciso montar antes de usar qualquer dispositivo, mesmo que seja CD-ROM ou disquete, e para esta operação existe, por padronização, o diretório _/mnt/_ ou _/media/_, mas o **root** pode montar em qualquer ponto da árvore do sistema.

Este ponto de montagem deve ser um diretório vazio. Acessado para montar pelo comando **mount** e desmontado por **umount**.

A sintaxe do mount é:

    # mount -t sistemadearquivos dispositivo ponto

No qual o dispositivo indica qual arquivo de bloco o sistema deve acessar para poder monta em ponto. A incremento deste comando pode ser necessário informar qual o tipo de arquivo com a adcição do parâmetro **-t** com seu respectivo tipo; note que somente estes tipos: _ext2/3_, _reiserfs_, _nfs_, _iso9660_, _vfat_ e _ntfs_, são montados sem problemas em GNU/Linux com a restrição de _ntfs_ montado para somente leitura.

A sintaxe do **umount** é ainda mais simples:

    # umount device

ou

    # umount ponto

Veja que **umount** aceita tanto o ponto quanto o device (dispositivo) como parâmetros para desmontar, não sendo obrigatório os dois.

Arquivo de Configuração de Montagem

O arquivo _/etc/fstab_ contém os arquivos que devem ser montados no boot (exceto os indicados como ``noauto``) e também os arquivos que podem ser montados pelos outros usuários, no caso de GNU/Linux, como grande parte dos arquivos de configuração as tabulações e espaços em branco são desconsiderados e comentários com ``#``.

    # /etc/fstab
    # fs      mount point   type        options                    dump    pass
    proc      /proc         proc        defaults                   0       0
    /dev/hda6 /             ext3        defaults,errors=remount-ro 0       1
    /dev/hda7 none          swap        sw                         0       0
    /dev/hdc  /media/cdrom0 udf,iso9660 user,noauto                0       0
    /dev/hda5 /usr/         ext3        defaults                   0       0

Neste arquivo o CD-ROM não é montado no boot mas pode ser montado pelos usuários; quando um dispositivo estiver no _/etc/fstab_ apenas com o comando **mount /device** ou **mount ponto** monta o dispositivo.
