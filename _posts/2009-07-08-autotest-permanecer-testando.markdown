---
layout: post
title: "Autotest: Permanecer Testando"
date: 2009-07-08 06:14
comments: true
categories: [rails, spec, test]
---

O autotest é uma ferramente que a cada modificação de arquivos de teste, de model e de outros que podem ser testados é executado os testes e exibido na tela de forma discreta.

A  página do plugin ([http://github.com/carlosbrando/autotest-notification/tree](http://github.com/carlosbrando/autotest-notification/tree)) é auto explicativa quanto a instalação. Vou seguir neste tutorial usando Ubuntu 9.04.

Instale primeiro o ZenTest e o autotest-rails:

    cpd102[pts/0]% sudo gem install ZenTest autotest-rails
    Successfully installed ZenTest-4.1.3
    Successfully installed autotest-rails-4.1.0
    2 gems installed
    Installing ri documentation for ZenTest-4.1.3...
    Installing ri documentation for autotest-rails-4.1.0...
    Installing RDoc documentation for ZenTest-4.1.3...
    Installing RDoc documentation for autotest-rails-4.1.0...

No Ubuntu marque o pacote libnotify-bin para a instalação ou use a linha abaixo:

    # aptitude install libnotify-bin

Agora vamos instalar o comando do autotest-notification:

    cpd102[pts/0]% sudo gem install carlosbrando-autotest-notification --source=http://gems.github.com

    For more information on autotest_notification, see http://github.com/carlosbrando/autotest-notification/
    
    To turn on the notifier you need to run the following command:
      an-install

    To turn off:
      an-uninstall
    
    Successfully installed carlosbrando-autotest-notification-1.9.1
    1 gem installed
    Installing ri documentation for carlosbrando-autotest-notification-1.9.1...
    Installing RDoc documentation for carlosbrando-autotest-notification-1.9.1...

Após a instalação é necessário apenas configurar:

    cpd102[pts/0]% an-install

    As from now all tests will be notified automatically.

Agora na raiz da aplicação execute o comando:

    cpd102[pts/0]% autotest -rails

Veja o autotest funcionando:

    cpd102[pts/2]% autotest -rails
    loading autotest/rails
    /usr/bin/ruby1.8 -I.:lib:test -rubygems -e "%w[test/unit test/functional/users_controller_test.rb test/unit/problem_test.rb test/unit/kind_test.rb test/functional/reports_controller_test.rb test/functional/comments_controller_test.rb test/unit/ticket_test.rb test/unit/helpers/problems_helper_test.rb test/functional/tickets_controller_test.rb test/functional/home_controller_test.rb test/functional/roles_controller_test.rb test/unit/helpers/kinds_helper_test.rb test/unit/helpers/home_helper_test.rb test/unit/user_test.rb test/unit/helpers/users_helper_test.rb test/functional/problems_controller_test.rb test/unit/helpers/tickets_helper_test.rb test/unit/helpers/user_sessions_helper_test.rb test/unit/helpers/comments_helper_test.rb test/unit/role_test.rb test/unit/comment_test.rb test/functional/kinds_controller_test.rb test/unit/helpers/roles_helper_test.rb test/functional/user_sessions_controller_test.rb test/unit/helpers/reports_helper_test.rb].each { |f| require f }" | unit_diff -u
Loaded suite -e
    Started
    ........................
    Finished in 0.235668 seconds.

    24 tests, 25 assertions, 0 failures, 0 errors
    ================================================================================

Para fechar basta fechar o terminal ou usar control+c duas vezes, pois somente uma ele executa novamente todos os testes.

Veja abaixo quando o autotest-notification executa algum teste, respectivamente um teste falha e outro corrigido:

<a href="http://picasaweb.google.com/lh/photo/nv0wa0AIKZC8MB8aMIAAJg?feat=embedwebsite"><img src="http://lh4.ggpht.com/_5r9AMhQKuQY/SlSKeTqmfKI/AAAAAAAAKTs/--XspkfUuW0/s400/Captura_de_tela-2.png" /></a>

<a href="http://picasaweb.google.com/lh/photo/Gj_IHzG3Mv_xKCV4vPGQ3Q?feat=embedwebsite"><img src="http://lh4.ggpht.com/_5r9AMhQKuQY/SlSKeQWiEdI/AAAAAAAAKTw/1BEDZ7Fjy5g/s400/Captura_de_tela-3.png" /></a>

Esta terceira imagem é de uma janela que é mostrada caso o libnotify-bin não está instalado, a janela fica em primeiro plano "atrapalhando" o usuário:

<a href="http://picasaweb.google.com/lh/photo/VKxwCYI169Gm2wvR8UxKgw?feat=embedwebsite"><img src="http://lh4.ggpht.com/_5r9AMhQKuQY/SlSKel_x3SI/AAAAAAAAKT0/uc5dHzPoArs/s800/Captura_de_tela-1.png" /></a>
