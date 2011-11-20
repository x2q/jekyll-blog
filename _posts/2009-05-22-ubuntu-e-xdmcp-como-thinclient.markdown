---
layout: post
title: "Ubuntu e XDMCP como thinclient"
date: 2009-05-22 12:17
comments: true
categories: [linux, thinclient, ubuntu, xdmcp]
---

O _XDMCP_ é uma forma de acessar remotamente um computador com Linux via interface gráfica, assim como o ssh é para terminal.

Partindo deste princípio basta ter uma máquina com todos os programas necessários instalados e ativar o XDMCP que todos os clientes poderão ter acesso a máquina como se estivessem nela, compartilhando programas, arquivos, dispositivos (impressora, pendrive, dentre outros).

Mas o usuário ainda tem que selecionar no GDM que quer fazer login remoto e selecionar o servidor, com isso pode ficar um pouco prolixo executar esta tarefa a cada login. Felizmente uma boa pesquisa na internet me deu um shell script que pode ser colocado na inicialização do sistema para que seja aberto a janela de login com o servidor já selecionado.

Siga os passo a seguir para configurar o cliente.

# Instalação

A instalação do sistema operacional se deu como uma instalação padrão do Ubuntu 9.04 Desktop, é necessário apenas ativar o servidor XDMCP.

Como o servidor irá precisar ter o GDM instalado e todos os outros programas de desktop eu mostrarei a instalação usando o ambiente gráfico:

# Servidor

Selecione o menu _Sistema_ > _Administração_ > _Janela de início de sessão_:

<a href="http://picasaweb.google.com/lh/photo/AtZ-COX0MqomW6AdDiG3CQ?feat=embedwebsite"><img src="http://lh3.ggpht.com/_5r9AMhQKuQY/ShbvVQI3cII/AAAAAAAAImw/ZX8rhho7PeY/s400/Captura_de_tela-1.png" /></a>

Após autenticar, na aba _Remoto_ deixe o estilo: _O mesmo que local_:

<a href="http://picasaweb.google.com/lh/photo/2niuukhL6D4a6Jxpg8V8kQ?feat=embedwebsite"><img src="http://lh5.ggpht.com/_5r9AMhQKuQY/Shbv8f8puQI/AAAAAAAAIm0/H5le_OxIqdg/s400/Captura_de_tela-Prefer%C3%AAncias%20da%20janela%20de%20in%C3%ADcio%20de%20sess%C3%A3o.png" /></a>

# Cliente

A configuração do cliente é estritamente no terminal, portando pode ser feito via ssh.

Primeiro é necessário desativar o script do GDM, para isso pode-se simplesmente mover o arquivo /etc/init.d/gdm para, por exemplo: /etc/init.d/gdm.OLD:

    ubuntu-client# mv /etc/init.d/gdm /etc/init.d/gdm.OLD

Por fim salve o script abaixo em /etc/init.d/xdmcp:

    #!/bin/sh
    # Launchs XDMCP
    
    set -e
    
    PATH=/sbin:/bin:/usr/sbin:/usr/bin
    PIDFILE=/var/run/xdmcp.pid
    XDMCPSERVER=server

    . /lib/lsb/init-functions
    
    case "$1" in
      start)
           if pidof usplash > /dev/null; then
                    /etc/init.d/usplash start
            fi
            log_begin_msg "Starting XDMCP..."
            start-stop-daemon --start --quiet --pidfile $PIDFILE --name xdmcp --exec /usr/bin/X -- -query $XDMCPSERVER > /dev/null || log_end_msg 1
            log_end_msg 0
      ;;
      stop)
            log_begin_msg "Stopping XDMCP..."
            start-stop-daemon --stop  --quiet --pidfile $PIDFILE --name xdmcp /usr/bin/X -- query $XDMCPSERVER --retry 30
            log_end_msg 0
      ;;
      restart)
            $0 stop || true
            $0 start
      ;;
      *)
            log_success_msg "Usage: /etc/init.d/xdmcp {start|stop|restart}"
            exit 1
      ;;
    esac

    exit 0

Substitua o nome server da linha ``XDMCPSERVER=server`` pelo nome do servidor ou endereço IP.

E execute o seguinte comando:

    ubuntu-client# update-rc.d xdmcp defaults 99
    update-rc.d: warning: /etc/init.d/xdmcp missing LSB information
    update-rc.d: see <http://wiki.debian.org/LSBInitScripts>
     Adding system startup for /etc/init.d/xdmcp ...
       /etc/rc0.d/K99xdmcp -> ../init.d/xdmcp
       /etc/rc1.d/K99xdmcp -> ../init.d/xdmcp
       /etc/rc6.d/K99xdmcp -> ../init.d/xdmcp
       /etc/rc2.d/S99xdmcp -> ../init.d/xdmcp
       /etc/rc3.d/S99xdmcp -> ../init.d/xdmcp
       /etc/rc4.d/S99xdmcp -> ../init.d/xdmcp
       /etc/rc5.d/S99xdmcp -> ../init.d/xdmcp</pre>

# Problemas

O XDMCP acessa o computador remoto como se o usuário estivesse em frente ao computador, por isso caso seja colocado algum pen-drive, cd-rom ou outro dispositivo no computador local ou remoto ele não estará disponível tão facilmente para ambos (ou para todos).
