---
layout: post
title: "Baixando Arquivos no Terminal com Wget"
date: 2007-03-17 11:46
comments: true
categories: [terminal, tools, wget]
---

Para baixar arquivos existe o programa **wget**, o mais difundido e vários outros programas somente são um front-end para o **wget**, como por exemplo o **gwget**.

# Iniciar e Continuar um Download

A forma mais simples de baixar um arquivo é: **wget URL**, como neste exemplo:

    % wget http://dmitry.eti.br/pub/curriculo-dmitry-nix.pdf

Lembrando que tanto pode ser um ftp como um http.

O parâmetro ``-c`` permite continuar um download, caso interrompido por um **<control>+c** ou se o sistema for desligado automaticamente (o que é comum para deixar automático o desligamento se a conexão for dial-up):

    % wget -c http://dmitry.eti.br/pub/curriculo-dmitry-nix.pdf

# Download em Segundo Plano

Como é cediço o caractere ``&`` é usado para indicar um programa para segundo plano, mas usado com o **wget** o programa ainda continua enviando informações para a tela a solução segundo o próprio **wget** é adicionar o parâmetro ``-b``.

    % wget -b -c http://www.host.com/arquivo.txt.bz2

Com isso pode-se até mesmo sair do terminal ou fazer logoff. Ademais é criado um arquivo de log neste formato _wget-log_, _wget-log.1_ e assim sucessivamente se a opção **-q** não for informada.

# Redirecionamento de Saída

O redirecionamento de saída para o **wget** com **>** não funciona perfeitamente, restando ao próprio programa fazer o redirecionamento que também funciona como um registro de log.

Basta indicar o parâmetro ``-o`` com o nome do arquivo ao qual a saída será redirecionado: ``wget -o output URL``, exemplo:

    % wget -o log http://dmitry.eti.br/pub/curriculo-dmitry-nix.pdf

O ``-o`` apaga o arquivo antes de gravar a saída; ``-a`` serve para adicionar a saída a um arquivo, útil para baixar em várias etapas.

# Aceitar/Recusar Arquivos

Selecionar arquivos para o qual deseja baixar ou recusar arquivos.

O parâmetro ``-A`` aceita e ``-R`` recusa os arquivos conforme a sintaxe de nome de arquivo, o que pode perfeitamente ser usado para baixar um tipo de arquivo:

Exemplo para baixar tipo _gif_:

    % wget -r -A "*.gif" dmitry.eti.br

O parâmetro recursivo (``-r``) deve ser informado, isso serve para fazer com que procure em todas as página encontradas.

O **wget** é, como a maioria dos comandos, sensível a caixa, então para baixar tudo de _gif_:

    % wget -r -A "*.[Gg][Ii][Ff]" dmitry.eti.br

Para recusar a sintaxe é a mesma basta mudar ``-A`` para **-R**.

# Lista de Arquivos

Há a possibilidade de criar uma lista com os arquivos que se deseja baixar e somente então começar a baixar; o arquivo que contém a lista deve ter o endereço completo dos arquivos, como neste exemplo:

    http://dmitry.eti.br/pub/curriculo-dmitry-nix.pdf
    http://dmitry.eti.br/pub/digitacao.pdf
    http://dmitry.eti.br/pub/mm.pdf

Com a lista pronta e salva:

    % wget -i lista_de_arquivos

# FTP com Senha

Após a definição do protocolo e antes do nome do ftp separados por dois pontos o nome de usuário e a senha, exemplo:

    % wget ftp://login:senha@www.host.com/arquivo.txt.bz2

# Proxy

O **wget** e alguns outros programas em linha de comando usam a variável ``http_proxy``, para obter informações sobre o proxy:

    % export http_proxy=http://usuario:senha@10.1.1.1:3128

Para proxy sem senha:

    % export http_proxy=http://10.1.1.1:3128

Depois disso basta usar o **wget** normalmente.

# Baixar Site ou FTP Completo

O **wget** usa o modo recursivo (acrescentando o parâmetro ``-r``) para baixar o site, isso é semelhante ao que o Google faz: na home page procura todos os links e conforme encontra os links baixa o arquivo:

    % wget -r dmitry.eti.br

# Erros Comuns

Os erros mais comuns são:

* Quando um site usa php ou outra tecnologia para controlar seus downloads e constantemente usa em sua url o caractere _?_ que é interpretado diferente do desejado pelo usuário, a melhor solução é colocar a url entre aspas;
* Ou quando se deseja baixar um arquivo que lhe foi enviado por e-mail com isso o servidor precisa saber que você é o verdadeiro dono do endereço de e-mail desta forma a maneira mais comum de verificar isso é através de login e de coockies que o **wget** não utiliza;
* Outro problema é quando for continuar um download esquecer da opção ``-c`` e começar o download do início e não da posição na qual se parou.

Atualizado em 01 de Maio de 2008
