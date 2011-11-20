---
layout: post
title: "Conexões Remotas"
date: 2006-12-27 11:38
comments: true
categories: [connection, linux, remote, server, ssh, unix]
---

O **ssh** (_Secure Shell_) é capaz de abrir terminais - ou mesmo interfaces gráficas - entre máquinas através de uma conexão criptografada, dificultando, desta forma, a  captura de dados através de sniffers.

O programa servidor é o **sshd** (_Secure Shell Daemon_) que trabalha na porta 22. Vale ressaltar que há dois protocolos SSH1 e SSH2, muitas aplicações usam somente um e outras os dois.

Atualmente existem várias implementações para o shell de segurança, exemplo: _ssh_, _openssh_, _sftp_ (_Secure FTP_) e outras. Em uma grande quantidade de sistemas operacionais, de interface gráfica ou em texto.

# O Lado do Servidor: O Daemon sshd

Quem receberá a conexão, e permitirá ou não (através do arquivo de configuração: _/etc/sshd_config_ ou de verificação de senha), deve estar executando o daemon **sshd**. Neste caso ele se chamará servidor, mesmo que esteja sendo cliente em outra aplicação.

Para executar o daemon basta, no terminal, chamar **sshd** que ele começa a rodar e de logo vai para segundo plano.

# O Lado do Cliente: ssh e scp

Este é o comando que permite conexões, tanto de terminais como gráficas, e execução de comando. Veja estes exemplos:

## ssh

Logando:

    % ssh -l usuario servidor

ou

    % ssh usuario@servidor

Neste exemplo substitua o nome ``usuario`` pelo login na máquina remota, já o nome do servidor é o mesmo definido pelo arquivo _/etc/hosts_ ou pelo DNS e pode até ser indicado o endereço IP.

Caso o seu nome de usuário sejam o mesmo na máquina local e no servidor utilize a linha abaixo, lembrando a já observação para o nome do servidor, que valerá para todas os outros exemplos do **ssh** e do **scp**.

    % ssh servidor

Executando comando sem permanecer logado:

    % ssh servidor comando

Backup Remoto:

    machine% tar cf - home | ssh username@server dd of=/Backup/home.tgz

## scp

O **scp** (_Secure Copy_) também se faz da necessidade de haver no servidor a execução do daemon **sshd**.

Este comando é semelhante ao **cp**, a única diferença é que ele usa conexões semelhantes a ssh para copiar os arquivos e, por isso, deve ser fornecido no endereço do arquivo de origem e/ou no endereço do arquivo de destino o nome do servidor, veja estes exemplos:

    % scp servidor:/home/usuario/arquivo_exemplo /home/usuario/

Esta outra forma informa qual usuário será usado para logar:

    % scp username@servidor:/home/usuario/arquivo_exemplo /home/usuario/

Observe o trecho ``servidor:/diretorio/arquivo`` ele indica a localização do servidor e do arquivo na máquina remota, pode ser colocado como segunda opção de linha de comando que, no caso, estaria copiando para o servidor.

Também é possível copiar diretórios para isso acrescente a opção ``-r``.

# ssh com login automático

Quando é necessário trabalhar numa rede que precisa de muitas conexões **ssh** feitas num curto intervalo de tempo torna-se prolixo a repetição da mesma senha de 13 caracteres ou mais.

Para não haver necessidade de repetição da senha armazena-se no servidor uma chave de autenticação.

Para automatizar procure no arquivo de configuração do servidor a linha que contenha ``PubkeyAuthentication no`` e deixe-a não comentada (sem o ``#`` no início da linha) e marcada como ``yes``, após isso reinicie o servidor (não o servidor inteiro apenas o **sshd**).

No cliente utilize o comando abaixo com o login de usuário (de preferência não _root_) para criar a chave que fará a autenticação:

    % ssh-keygen -t rsa

Agora coloque o arquivo _~/.ssh/id_rsa.pub_ para seu _home_ no servidor:

    % ssh-copy-id -i ~/.ssh/id_rsa.pub usuario@servidor

Nesta configuração apenas foi feita uma automatização do processo de login. Somente vale ressaltar para que ninguém tenha acesso ao diretório _~/.ssh_.

Atualizado em 23 de Março de 2009.
