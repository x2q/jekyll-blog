---
layout: post
title: "Tipos de Arquivos"
date: 2008-12-15 09:58
comments: true
categories: [unix, linux]
---

Os tipos de arquivos existentes em Unixes são os seguintes:

* Arquivo regular (representado por - na listagem por ``ls -l``): tipo comum;
  + Arquivo regular de texto: contém informações em forma de texto, entendidos pelos usuários com um simples editor de texto;
  + Arquivo regular binário: compostos por sequências de bits 0 e 1, com código no qual o computador pode executá-lo, e se abertos por um editor simples de texto pode exibir caracteres estranhos;
* Diretórios (representados por d): os diretórios são uma forma organizada de separar e organizar arquivos e até mesmo outros diretórios, chamados estes de subdiretórios;
* Dispositivos: todo componente de hardware usável é chamado de dispositivo: placas de vídeo, som, redes, drives de CD, tudo o que se liga à interface USB, memória RAM;
  + Dispositivos de bloco (representado por b): estes dispositivos utilizam buffer para leitura/gravação o que lhes permite acesso aleatório, geralmente são unidade de disco, como HD's, CD's etc;
  + Dispositivos de caracteres (representados por c): não utilizam o buffer para leitura/gravação tendo somente o acesso (leitura/gravação) seqüencial, grande parte dos dispositivos PCI e outros dispositivos como impressora, mouse etc;
* Links ou Atalhos: São arquivos utilizados para fazer referência a outro arquivo:
  + Links simbólicos (representado por l): fazem referência ao arquivo através de seu endereço de diretórios e subdiretórios, assim basta que o arquivo alvo seja movido para que o link quebre;
  + Hard Links (ou links rígidos; é representado como se fosse o próprio arquivo, já que assim é): fazem referência ao arquivo através do número de i-node*, para este: se o arquivo alvo for movido o arquivo destino ainda apontará para o mesmo arquivo; caso o arquivo alvo seja excluído e o arquivo que aponta existir o arquivo ainda estará no disco, só que com o nome do arquivo que aponta;
* Fifo: canal de comunicação, utilizado para direcionar os dados produzidos por um processo para outro processo.

Use o ls e o stat para ver informações sobre os arquivos:

    % ls -ld * /dev/sda1 /dev/tty0
    -rw-r--r-- 1 dmitry dmitry    0 2008-12-15 13:06 arquivo1
    -rw-r--r-- 1 dmitry dmitry    0 2008-12-15 13:06 arquivo2
    -rw-r--r-- 1 dmitry dmitry    0 2008-12-15 13:06 arquivo3
    brw-rw---- 1 root   disk   8, 1 2008-12-15 07:06 /dev/sda1
    crw-rw---- 1 root   root   4, 0 2008-12-15 07:06 /dev/tty0
    drwxr-xr-x 2 dmitry dmitry 4096 2008-12-15 13:14 diretorio


    % stat index.html
      File: `index.html'
      Size: 2770      	Blocks: 8          IO Block: 4096   arquivo comum
    Device: 305h/773d	Inode: 538032      Links: 1
    Access: (0644/-rw-r--r--)  Uid: ( 1000/  dmitry)   Gid: ( 1000/  dmitry)
    Access: 2007-03-13 11:15:57.000000000 -0300
    Modify: 2007-03-12 08:49:42.000000000 -0300
    Change: 2007-03-12 11:31:10.000000000 -0300</pre>

É possível ver o i-node de arquivo adicionando o parâmetro ``-i`` ao ls:

    % ls -i
    4425900 arquivo1  4425901 arquivo2  4425902 arquivo3
