---
layout: post
title: "Dividir arquivos de mp3"
date: 2009-06-19 06:13
comments: true
categories: [audio, media, split, terminal, tools]
---

Recentemente (e bote recente nisso) com a obtenção (por meios legais) de um novo celular e de banda larga eu estou me adentrando na mídia podcast com ouvinte, claro.

Mas, como sempre tem que ter um `mas', meu celular, assim como muitos celulares e mp3 players, não permite que você passe para um determinado ponto do áudio, com isso para ouvir somente aquela parte é necessário ouvir tudo novamente.

Mas há programas que fazem uma divisão de arquivos, uns permitem fazer manualmente outros de forma automatizada.

Visando isso encontrei o programa mp3splt, que "splita" os arquivos de mp3, além, é claro, que o programa Audacity também faz isso. O problema é que no Audacity tem que ser feita a divisão toda na "mão" e no mp3splt pode-se apenas setar um tempo e ele divide em quantos arquivos forem necessários.

A instalação em Ubuntu é fácil, apenas marcar o pacote mp3splt para instalação, que tem apenas 172 KB:

    cpd102[pts/4]% aptitude install mp3splt

Para dividir use a opção ``-t 20.0``, do qual 20.0 significa o tempo em minutos:

    cpd102[pts/3]% mp3splt -t 20.0 ../Codigo_Livre_Podcast_72.mp3
    Mp3Splt 2.1 (2004/Sep/28) by Matteo Trotta <matteo.trotta@lib.unimib.it>
    THIS SOFTWARE COMES WITH ABSOLUTELY NO WARRANTY! USE AT YOUR OWN RISK!
    MPEG 1 Layer 3 - 44100 Hz - Stereo - 96 Kb/s - Total time: 273m.04s
    Splitting Codigo_Livre_Podcast_72_000.00_020.00.mp3... OK
    Splitting Codigo_Livre_Podcast_72_020.00_040.00.mp3... OK
    Splitting Codigo_Livre_Podcast_72_040.00_060.00.mp3... OK
    Splitting Codigo_Livre_Podcast_72_060.00_080.00.mp3... OK
    Splitting Codigo_Livre_Podcast_72_080.00_100.00.mp3... OK
    Splitting Codigo_Livre_Podcast_72_100.00_120.00.mp3... OK
    Splitting Codigo_Livre_Podcast_72_120.00_140.00.mp3... OK
    Splitting Codigo_Livre_Podcast_72_140.00_160.00.mp3... OK
    Splitting Codigo_Livre_Podcast_72_160.00_180.00.mp3... OK
    Splitting Codigo_Livre_Podcast_72_180.00_200.00.mp3... OK
    Splitting Codigo_Livre_Podcast_72_200.00_220.00.mp3... OK
    Splitting Codigo_Livre_Podcast_72_220.00_240.00.mp3... OK
    Splitting Codigo_Livre_Podcast_72_240.00_260.00.mp3... OK
    Splitting Codigo_Livre_Podcast_72_260.00_280.00.mp3... OK (WARNING)
    Warning: mp3 might be VBR. You should use -f option.

Pronto! Agora você tem um mercadinho de arquivos mp3 de 20 minutos (eu uso de 10 minutos).

Futuramente eu posso fazer uma interface gráfica para auxiliar isso.
