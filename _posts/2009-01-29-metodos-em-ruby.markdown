---
layout: post
title: "Métodos em Ruby"
date: 2009-01-29 07:41
comments: true
categories: [ruby, oo]
---

Vamos criar uma classe para usar seus métodos:

    class Greeting
      def hi(name)
        puts "Hi #{name.capitalize}"
      end
    end

    greeting = Greeting.new
    greeting.hi("dmitry")

E sua saída:

    % ruby MyDef.rb
    Hi Dmitry

Note que estou instanciando um objeto da classe ``Greeting`` para só
então usá-la.

# ``initialize``

Quando for instanciar um objeto também é possível passa para ele
atributos, neste próximo exemplo vamos passar o nome para o
``initialize`` e usá-lo em outros métodos:

    class Greeting
      def initialize name
        @name = name
      end

      def hi
        puts "Hi #{@name.capitalize}"
      end

      def bye
        puts "Bye #{@name.capitalize}"
      end
    end

    greeting = Greeting.new 'dmitry'
    greeting.hi
    greeting.bye

# Métodos com ``?`` e ``!``

Não é obrigatório, mas em Ruby costumamos a usar o ``?`` no final do
método para métodos que retornam ``true`` ou ``false``.

Exemplo, vamos deixar o ``name`` como parâmetro opcional:

    class Greeting
      def initialize name = ''
        @name = name
      end

      def hi
        puts "Hi #{@name.capitalize}"
      end

      def bye
        puts "Bye #{@name.capitalize}"
      end

      def name
        @name
      end

      def name?
        @name != ''
      end
    end

    greeting = Greeting.new 'dmitry'
    puts greeting.name
    puts greeting.name?

    greeting = Greeting.new
    puts greeting.name
    puts greeting.name?

Vamos testar:

    % ruby my.rb
    dmitry
    true

    false

Quanto ao ``!`` é comum que ele modifique o próprio objeto, vamos a um
exemplo prático:

    class Greeting
      def initialize name = ''
        @name = name
      end

      def hi
        puts "Hi #{@name.capitalize}"
      end

      def bye
        puts "Bye #{@name.capitalize}"
      end

      def name
        @name
      end

      def name?
        @name != ''
      end

      def upcase
        @name.upcase
      end

      def upcase!
        @name = upcase
      end
    end

    greeting = Greeting.new 'dmitry'
    puts greeting.upcase
    puts greeting.name
    puts greeting.upcase!
    puts greeting.name

E na saída:

    % ruby my.rb
    DMITRY
    dmitry
    DMITRY
    DMITRY

Primeiro o ``name`` foi apenas exibido com ``upcase``, mas na chamada
de ``upcase!`` ele foi modificado e passou a ser assim dentro do objeto.

O que é uma boa prática também é ter o mesmo método sem o ``!``, ou como
eu prefiro fazer: primeiro o método que apenas retorna o comportamento
que quero e depois um método com ``!`` que modifica o objeto.
