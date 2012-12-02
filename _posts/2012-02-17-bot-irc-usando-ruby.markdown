---
layout: post
title: "Bot IRC usando Ruby"
date: 2012-02-17 19:31
comments: true
categories: [ruby, irc, bot]
---

Voltei a usar IRC depois de um tempo e como antes eu já ouvi falar muito
de bots em irc resolvi testar por mim mesmo.

Após pesquisar um pouco achei o [cinch](https://github.com/cinchrb/cinch):

> The IRC Bot Building Framework

Ou seja: "Um framework de criação de bot IRC".

# Mãos a obra

Primeiro instale a gem 'cinch' ou como eu prefiro cria um arquivo
`Gemfile`:

```ruby
source 'http://rubygems.org'

gem 'cinch'
```

No nosso primeiro exemplo, vamo fazer o bot responder bom dia para todos
que derem bom dia:

```ruby
require 'rubygems'
require 'bundler/setup'

bot = Cinch::Bot.new do
  configure do |c|
    c.server = 'irc.freenode.net'
    c.channels = ['#gurupi']
  end

  on :message, /bom dia/i do |m|
    m.reply "Bom dia, #{m.user.nick}"
  end
end

bot.start
```

Pronto nosso bot já está ativo, basta usar.

Note que estou usando expressão regular, ou seja, *bom dia*, *Bom dia* e
*Bom dia!*, vão funcionar sem problemas ;).

Estou tendo mais ideias para posts sobre IRC, fiquem ligados ;)

E por falar em ligados entrem na irc.freenode.net na sala *##gurupi* (com
dois ``#``).
