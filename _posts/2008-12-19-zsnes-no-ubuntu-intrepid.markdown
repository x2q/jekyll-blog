---
layout: post
title: "Zsnes no Ubuntu Intrepid"
date: 2008-12-19 09:21
comments: true
categories: [desktop, game, linux, ubuntu, zsnes]
---

Quem usa o Zsnes no Ubuntu sabe que no Ubuntu Intrepid ele não abre:

    % zsnes
    ZSNES v1.51, (c) 1997-2007, ZSNES Team
    Be sure to check http://www.zsnes.com/ for the latest version.
    
    ZSNES is written by the ZSNES Team (See AUTHORS.TXT)
    ZSNES comes with ABSOLUTELY NO WARRANTY.  This is free software,
    and you are welcome to redistribute it under certain conditions;
    please read 'LICENSE.TXT' thoroughly before doing so.
    
    Use ZSNES -? for command line definitions.
    
    Starting Mouse detection.
    Unable to poll /dev/input/event6. Make sure you have read permissions to it.
    Unable to poll /dev/input/event5. Make sure you have read permissions to it.
    Unable to poll /dev/input/event4. Make sure you have read permissions to it.
    Unable to poll /dev/input/event2. Make sure you have read permissions to it.
    Unable to poll /dev/input/event3. Make sure you have read permissions to it.
    Unable to poll /dev/input/event1. Make sure you have read permissions to it.
    Unable to poll /dev/input/event0. Make sure you have read permissions to it.
    ManyMouse: 0 mice detected.
    *** buffer overflow detected ***: zsnes terminated
    ======= Backtrace: =========
    /lib/tls/i686/cmov/libc.so.6(__fortify_fail+0x48)[0xb7d4b558]
    /lib/tls/i686/cmov/libc.so.6[0xb7d49680]
    zsnes[0x8056c1b]
    ======= Memory map: ========
    08048000-08303000 r-xp 00000000 08:01 3598443    /usr/bin/zsnes
    08303000-08304000 r--p 002ba000 08:01 3598443    /usr/bin/zsnes
    08304000-08343000 rw-p 002bb000 08:01 3598443    /usr/bin/zsnes
    08343000-088f7000 rw-p 08343000 00:00 0 
    09a8a000-09ad5000 rw-p 09a8a000 00:00 0          [heap]
    b5e7b000-b69aa000 rw-p b5e7b000 00:00 0 
    b69aa000-b69cc000 r-xp 00000000 08:01 3600638    /usr/lib/libaudiofile.so.0.0.2
    b69cc000-b69cf000 rw-p 00021000 08:01 3600638    /usr/lib/libaudiofile.so.0.0.2
    b69e5000-b6a33000 r-xp 00000000 08:01 3599318    /usr/lib/libpulse.so.0.4.1
    b6a33000-b6a34000 r--p 0004d000 08:01 3599318    /usr/lib/libpulse.so.0.4.1
    b6a34000-b6a35000 rw-p 0004e000 08:01 3599318    /usr/lib/libpulse.so.0.4.1
    b6a35000-b6a41000 r-xp 00000000 08:01 3599319    /usr/lib/libpulse-simple.so.0.0.1
    b6a41000-b6a42000 r--p 0000b000 08:01 3599319    /usr/lib/libpulse-simple.so.0.0.1
    b6a42000-b6a43000 rw-p 0000c000 08:01 3599319    /usr/lib/libpulse-simple.so.0.0.1
    b6a43000-b6a58000 r-xp 00000000 08:01 3599887    /usr/lib/libICE.so.6.3.0
    b6a58000-b6a59000 rw-p 00014000 08:01 3599887    /usr/lib/libICE.so.6.3.0
    b6a59000-b6a5b000 rw-p b6a59000 00:00 0 
    b6a5b000-b6aa8000 r-xp 00000000 08:01 3599891    /usr/lib/libXt.so.6.0.0
    b6aa8000-b6aac000 rw-p 0004c000 08:01 3599891    /usr/lib/libXt.so.6.0.0
    b6aac000-b6ac2000 r-xp 00000000 08:01 3600873    /usr/lib/libaudio.so.2.4
    b6ac2000-b6ac3000 r--p 00015000 08:01 3600873    /usr/lib/libaudio.so.2.4
    b6ac3000-b6ac4000 rw-p 00016000 08:01 3600873    /usr/lib/libaudio.so.2.4
    b6aca000-b6ad3000 r-xp 00000000 08:01 3598478    /usr/lib/libesd.so.0.2.39
    b6ad3000-b6ad4000 r--p 00008000 08:01 3598478    /usr/lib/libesd.so.0.2.39
    b6ad4000-b6ad5000 rw-p 00009000 08:01 3598478    /usr/lib/libesd.so.0.2.39
    b6ad5000-b6ad8000 r-xp 00000000 08:01 3817990    /usr/lib/ao/plugins-2/libalsa09.so
    b6ad8000-b6ada000 rw-p 00002000 08:01 3817990    /usr/lib/ao/plugins-2/libalsa09.so
    b6ada000-b6b02000 r-xp 00000000 08:01 4350135    /lib/libpcre.so.3.12.1
    b6b02000-b6b03000 r--p 00027000 08:01 4350135    /lib/libpcre.so.3.12.1
    b6b03000-b6b04000 rw-p 00028000 08:01 4350135    /lib/libpcre.so.3.12.1
    b6b04000-b6bb9000 r-xp 00000000 08:01 3601560    /usr/lib/libglib-2.0.so.0.1800.2
    b6bb9000-b6bba000 r--p 000b4000 08:01 3601560    /usr/lib/libglib-2.0.so.0.1800.2
    b6bba000-b6bbb000 rw-p 000b5000 08:01 3601560    /usr/lib/libglib-2.0.so.0.1800.2
    b6bbb000-b6bbf000 r-xp 00000000 08:01 3601563    /usr/lib/libgthread-2.0.so.0.1800.2
    b6bbf000-b6bc0000 r--p 00003000 08:01 3601563    /usr/lib/libgthread-2.0.so.0.1800.2
    b6bc0000-b6bc1000 rw-p 00004000 08:01 3601563    /usr/lib/libgthread-2.0.so.0.1800.2
    b6bc2000-b6bc3000 rw-p b6bc2000 00:00 0 
    b6bc3000-b6bc6000 r-xp 00000000 08:01 4350187    /lib/libcap.so.1.10
    b6bc6000-b6bc7000 rw-p 00002000 08:01 4350187    /lib/libcap.so.1.10
    b6bc7000-b6bc9000 r-xp 00000000 08:01 3818136    /usr/lib/ao/plugins-2/libpulse.so
    b6bc9000-b6bcb000 rw-p 00001000 08:01 3818136    /usr/lib/ao/plugins-2/libpulse.so
    b6bcb000-b6bd2000 r-xp 00000000 08:01 3598853    /usr/lib/libSM.so.6.0.0
    b6bd2000-b6bd3000 r--p 00006000 08:01 3598853    /usr/lib/libSM.so.6.0.0
    b6bd3000-b6bd4000 rw-p 00007000 08:01 3598853    /usr/lib/libSM.so.6.0.0
    b6bd4000-b6bd5000 r-xp 00000000 08:01 3817993    /usr/lib/ao/plugins-2/libnas.so
    b6bd5000-b6bd7000 rw-p 00000000 08:01 3817993    /usr/lib/ao/plugins-2/libnas.so
    b6bd7000-b6be1000 r-xp 00000000 08:01 4350179    /lib/tls/i686/cmov/libnss_files-2.8.90.so
    b6be1000-b6be2000 r--p 00009000 08:01 4350179    /lib/tls/i686/cmov/libnss_files-2.8.90.so
    b6be2000-b6be3000 rw-p 0000a000 08:01 4350179    /lib/tls/i686/cmov/libnss_files-2.8.90.so
    b6be3000-b6bf8000 r-xp 00000000 08:01 4350176    /lib/tls/i686/cmov/libnsl-2.8.90.so
    b6bf8000-b6bf9000 r--p 00014000 08:01 4350176    /lib/tls/i686/cmov/libnsl-2.8.90.so
    b6bf9000-b6bfa000 rw-p 00015000 08:01 4350176    /lib/tls/i686/cmov/libnsl-2.8.90.so
    b6bfa000-b6bfc000 rw-p b6bfa000 00:00 0 
    b6bfc000-b6bfd000 r-xp 00000000 08:01 3817992    /usr/lib/ao/plugins-2/libesd.so
    b6bfd000-b6bff000 rw-p 00000000 08:01 3817992    /usr/lib/ao/plugins-2/libesd.so
    b6bff000-b6c02000 r-xp 00000000 08:01 3601561    /usr/lib/libgmodule-2.0.so.0.1800.2
    b6c02000-b6c03000 r--p 00002000 08:01 3601561    /usr/lib/libgmodule-2.0.so.0.1800.2
    b6c03000-b6c04000 rw-p 00003000 08:01 3601561    /usr/lib/libgmodule-2.0.so.0.1800.2
    b6c04000-b6c09000 r-xp 00000000 08:01 2834529    /usr/lib/libartsc.so.0.0.0
    b6c09000-b6c0a000 r--p 00004000 08:01 2834529    /usr/lib/libartsc.so.0.0.0
    b6c0a000-b6c0b000 rw-p 00005000 08:01 2834529    /usr/lib/libartsc.so.0.0.0
    b6c0b000-b6c0c000 r-xp 00000000 08:01 3817991    /usr/lib/ao/plugins-2/libarts.so
    b6c0c000-b6c0e000 rw-p 00000000 08:01 3817991    /usr/lib/ao/plugins-2/libarts.so
    b6c0e000-b6c10000 r-xp 00000000 08:01 3817994    /usr/lib/ao/plugins-2/liboss.so
    b6c10000-b6c12000 rw-p 00001000 08:01 3817994    /usr/lib/ao/plugins-2/liboss.so
    b6c12000-b6c79000 rw-p b6c12000 00:00 0 
    b6c79000-b6c7d000 r-xp 00000000 08:01 3596805    /usr/lib/libXdmcp.so.6.0.0
    b6c7d000-b6c7e000 rw-p 00003000 08:01 3596805    /usr/lib/libXdmcp.so.6.0.0
    b6c7e000-b6c95000 r-xp 00000000 08:01 3596810    /usr/lib/libxcb.so.1.0.0
    b6c95000-b6c96000 r--p 00016000 08:01 3596810    /usr/lib/libxcb.so.1.0.0
    b6c96000-b6c97000 rw-p 00017000 08:01 3596810    /usr/lib/libxcb.so.1.0.0
    b6c97000-b6c98000 r-xp 00000000 08:01 3600616    /usr/lib/libxcb-xlib.so.0.0.0
    b6c98000-b6c99000 r--p 00000000 08:01 3600616    /usr/lib/libxcb-xlib.so.0.0.0
    b6c99000-b6c9a000 rw-p 00001000 08:01 3600616    /usr/lib/libxcb-xlib.so.0.0.0
    b6c9a000-b6c9c000 r-xp 00000000 08:01 3596801    /usr/lib/libXau.so.6.0.0
    b6c9c000-b6c9d000 rw-p 00001000 08:01 3596801    /usr/lib/libXau.so.6.0.0
    b6c9d000-b6ca4000 r-xp 00000000 08:01 4351511    /lib/tls/i686/cmov/librt-2.8.90.so
    b6ca4000-b6ca5000 r--p 00007000 08:01 4351511    /lib/tls/i686/cmov/librt-2.8.90.so
    b6ca5000-b6ca6000 rw-p 00008000 08:01 4351511    /lib/tls/i686/cmov/librt-2.8.90.so
    b6ca6000-b6ca7000 rw-p b6ca6000 00:00 0 
    b6ca7000-b6d92000 r-xp 00000000 08:01 1802305    /usr/lib/libX11.so.6.2.0
    b6d92000-b6d93000 r--p 000ea000 08:01 1802305    /usr/lib/libX11.so.6.2.0
    b6d93000-b6d95000 rw-p 000eb000 08:01 1802305    /usr/lib/libX11.so.6.2.0
    b6d95000-b6d96000 rw-p b6d95000 00:00 0 
    b6d96000-b6da3000 r-xp 00000000 08:01 3599910    /usr/lib/libXext.so.6.4.0
    b6da3000-b6da5000 rw-p 0000c000 08:01 3599910    /usr/lib/libXext.so.6.4.0
    b6da5000-b6da6000 r-xp 00000000 08:01 622611     /usr/lib/tls/libnvidia-tls.so.173.14.12
    b6da6000-b6da7000 rw-p 00000000 08:01 622611     /usr/lib/tls/libnvidia-tls.so.173.14.12
    b6da7000-b7955000 r-xp 00000000 08:01 3598914    /usr/lib/libGLcore.so.173.14.12
    b7955000-b7ae2000 rwxp 00bad000 08:01 3598914    /usr/lib/libGLcore.so.173.14.12
    b7ae2000-b7ae7000 rwxp b7ae2000 00:00 0 
    b7ae7000-b7afa000 r-xp 00000000 08:01 3598928    /usr/lib/libdirect-1.0.so.0.1.0
    b7afa000-b7afb000 r--p 00012000 08:01 3598928    /usr/lib/libdirect-1.0.so.0.1.0
    b7afb000-b7afc000 rw-p 00013000 08:01 3598928    /usr/lib/libdirect-1.0.so.0.1.0
    b7afc000-b7b03000 r-xp 00000000 08:01 3599096    /usr/lib/libfusion-1.0.so.0.1.0
    b7b03000-b7b04000 r--p 00006000 08:01 3599096    /usr/lib/libfusion-1.0.so.0.1.0
    b7b04000-b7b05000 rw-p 00007000 08:01 3599096    /usr/lib/libfusion-1.0.so.0.1.0
    b7b05000-b7b06000 rw-p b7b05000 00:00 0 
    b7b06000-b7b6a000 r-xp 00000000 08:01 3599095    /usr/lib/libdirectfb-1.0.so.0.1.0
    b7b6a000-b7b6b000 r--p 00063000 08:01 3599095    /usr/lib/libdirectfb-1.0.so.0.1.0
    b7b6b000-b7b6c000 rw-p 00064000 08:01 3599095    /usr/lib/libdirectfb-1.0.so.0.1.0
    b7b6c000-b7b6e000 r-xp 00000000 08:01 4350173    /lib/tls/i686/cmov/libdl-2.8.90.so
    b7b6e000-b7b6f000 r--p 00001000 08:01 4350173    /lib/tls/i686/cmov/libdl-2.8.90.so
    b7b6f000-b7b70000 rw-p 00002000 08:01 4350173    /lib/tls/i686/cmov/libdl-2.8.90.so
    b7b70000-b7c33000 r-xp 00000000 08:01 3600511    /usr/lib/libasound.so.2.0.0
    b7c33000-b7c35000 r--p 000c2000 08:01 3600511    /usr/lib/libasound.so.2.0.0
    b7c35000-b7c38000 rw-p 000c4000 08:01 3600511    /usr/lib/libasound.so.2.0.0
    b7c38000-b7c4d000 r-xp 00000000 08:01 4351509    /lib/tls/i686/cmov/libpthread-2.8.90.so
    b7czsh: abort      zsnes

Minha solução para isso enquanto ainda não corrigirem é usar a versão para o Hardy.

É possível obter a versão antiga do pacote no site [http://packages.ubuntu.com/](http://packages.ubuntu.com/) clicando no nome Hardy (ou outra versão) ou seguir o link para escolher o mirror da versão para o Hardy: [http://packages.ubuntu.com/hardy/i386/zsnes/download](http://packages.ubuntu.com/hardy/i386/zsnes/download).

Para instalar sem usar linha de comando: desinstale o Zsnes usando o Synaptic e abra o arquivo com o Gdebi (clike duplo) e, apesar de o Gdebi lembrar que existe uma versão mais nova, instalar.

Você pode ainda no Synaptic prender a versão atual do pacote em _Pacote_ -> _Travar versão_.

Atualizado em 22 de Dezembro de 2008.
