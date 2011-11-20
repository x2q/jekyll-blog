---
layout: post
title: "CDs e Terminal"
date: 2007-03-29 04:10
comments: true
categories: [cd, terminal, tools]
---

No Linux existem ferramentas gráficas para gravar CD como o **k3b**, algumas (se não todas) são somente front-ends para as aplicações em linha de comando. Para entender como estas ferramentas funcionam ou mesmo para automatizar tarefas como backups, veja adiante.

# Extração de CDs

## Extrair CDs de Áudio

O programa **cdparanoia** é usado para extrair áudio de CDs em formato de áudio para arquivos _wav_ no diretório atual.

A opção ``-B`` informa para extrair para vários arquivos, no exemplo abaixo tem-se o **cdparanoia** extraindo o CD inteiro para vários arquivo com o padrão _track01.cdda.wav_ e _track02.cdda.wav_.

    % cdparanoia -B

Para informar a faixa use aspas seguida do número da faixa como em **"6"** e informar intervalos use como no exemplo abaixo:

    % **cdparanoia "3-4" -B**

## Extrair CD de dados

A cópia de arquivos de dados faz-se com o programa **dd**, veja no exemplo abaixo:

    % dd if=/dev/hdc of=imagem.iso

Se o CD for bootável ele permanecerá com essa característica o comando **dd** cria uma cópia exata.

# Criação de arquivos iso

Arquivos _iso_ são cópias de CDs para que possam ser gravados em discos.

Veja o exemplo:

    % mkisofs -r -o imagem.iso diretorio/

Com a opção ``-V "nome"`` o nome do disco (nome do volume ou label) é alterado para o conteúdo entre aspas.

O arquivo _iso_ não contém o nome do diretório _raiz_, por exemplo veja que com o **find** listei os arquivo do diretório _~/arquivos_para_gravar/_:

    % find ~/arquivos_para_gravar
    ~/arquivos_para_gravar/psaux
    ~/arquivos_para_gravar/cpuinfo

E após a criação da _iso_ do diretórios _~/arquivos_para_gravar/_:

    % mkisofs -r -o imagem.iso ~/arquivos_para_gravar/

E gravado o disco os arquivos no disco foram com o **find**:

    % find /media/cdrom/
    /media/cdrom/psaux
    /media/cdrom/cpuinfo

Os CD foram inicialmente feitos para gravar somente áudio, logo viu-se a oportunidade de gravar dados, com isso existem extensões para gravar dados. Para usuários de Windows existe a extensão Joliet. Para adicionar esta extensão para o CD use a opção ``-J`` ao comando **mkisofs**, note que o ``-J`` adiciona, sem ela usuários Windows continuam podendo ler o disco.

# Limpando CD-RW

Antes de gravar em CD-RW é obrigado limpar o CD para uma nova gravação, em caso de não ter gravado em multiseção, o modo que mais uso é o ``fast``:

    % cdrecord dev=/dev/hdc blank=fast

# Montar imagem iso

Antes de gravar o CD o comando **mount** permite visualizar arquivos _iso_ como se realmente estivesse em um CD gravado, veja este exemplo:

    % mount -t iso9660 -o loop imagem.iso /mnt/iso

A única adição ao tradicional **mount** é ``-o loop``.

# Gravando o CD

O **cdrecord** grava os CDs a partir de imagens _iso_ ou arquivos de áudio em _wav_.

As principais opções do **cdrecord** são:

* ``-v`` para usar o modo verbose, uso opcional;
* ``-fs=16M`` usado para limitar a quantidade do buffer da memória RAM em megabytes, também opcional apenas use se tiver pouca memória RAM;
* ``speed=10`` informa a velocidade com a qual será gravada;
* ``dev=/dev/hdc`` indica o dispositivo;
* ``-data imagem.iso`` para informar a gravação de dados em _imagem.iso_ ou ``-audio faixa01.wav faixa02.wav`` para gravar áudio nos arquivos _faixa01.wav_ e _faixa02.wav_.
* ``-eject`` ejeta o CD após a gravação.

Exemplos:

Para dados em uma imagem _iso_:

    % cdrecord speed=8 dev=/dev/hdc -data imagem.iso

Para todos os arquivos _wav_ no diretório atual:

    % cdrecord speed=8 dev=/dev/hdc -audio *.wav

CD misto (dados e áudio):

    % cdrecord speed=8 dev=/dev/hdc -data imagem.iso -audio faixa01.wav faixa02.wav

Gera a imagem _iso_ e passa imediatamente como parâmetro para o **cdrecord**:

    % mkisofs --quiet teste2 | cdrecord dev=/dev/hdc -data -

Atualizado em 15 de Março do 2008.
