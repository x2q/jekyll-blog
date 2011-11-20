---
layout: post
title: "Orientação a Objetos com Ruby"
date: 2011-09-22 20:10
comments: true
categories: [ruby, oo]
published: true
---
Como você leu no primeiro post fazendo uma [Introdução a Ruby](/ruby/),
Ruby é uma linguagem *orientada a objetos*, significa?

Significa que usando Ruby pode-se "mapear" os objetos do mundo real para os
seus programas.

# Classes e Objetos

As classes constroem objetos com o método `new`:

    % irb
    ruby-1.8.7-p352 :001 > String.new("teste")
    => "teste" 

O método `new` é mapeado para o método `initialize` da classe:

    class Animal
      def initialize(nome)
        @nome = nome
      end
    end

Para chamar usando o `irb`:

    % irb -r ./animal.rb
    ruby-1.8.7-p352 :001 > animal = Animal.new('nome')
    => #<Animal:0x7f679fa1e0d8 @nome="nome">
    ruby-1.8.7-p352 :002 >


Aproveitando vamos fazer perguntas ao objeto:

    ruby-1.8.7-p352 :002 > animal.class
    => Animal
    ruby-1.8.7-p352 :003 > animal.instance_variables
    => ["@nome"]

## Variáveis

Ao contrário de linguagens estáticas, em Ruby não há relação entre a classe
e as variáveis do objeto. As variáveis de instância só existem quando lhes
é dado um valor, baseado nisso você pode ter 2 objetos de mesma classe
com variáveis de instância diferentes.

Observe o código abaixo:

    class Animal
      def initialize(nome)
        @nome = nome
        @um_gato = 'sim' if nome == 'gato'
      end
    end

E

    % irb -r ./animal.rb
    ruby-1.8.7-p352 :001 > gato = Animal.new('gato')
    => #<Animal:0x7f1d386e87d0 @um_gato="sim", @nome="gato">
    ruby-1.8.7-p352 :002 > gato.instance_variables
    => ["@um_gato", "@nome"]
    ruby-1.8.7-p352 :003 > macaco = Animal.new('macaco')
    => #<Animal:0x7f1d386d79f8 @nome="macaco">
    ruby-1.8.7-p352 :004 > macaco.instance_variables
    => ["@nome"]

## Métodos

Assim como as classes tem seus métodos os objetos também tem, para ver a
lista de métodos de um objeto:

    ruby-1.8.7-p352 :006 > gato.methods
    => ["inspect", "tap", "clone", "public_methods", "__send__", "object_id", "instance_variable_defined?", "equal?", "freeze", "extend", "send", "methods", "hash", "dup", "to_enum", "instance_variables", "eql?", "instance_eval", "id", "singleton_methods", "taint", "enum_for", "frozen?", "instance_variable_get", "instance_of?", "display", "to_a", "method", "type", "instance_exec", "protected_methods", "==", "===", "instance_variable_set", "kind_of?", "respond_to?", "to_s", "class", "__id__", "tainted?", "=~", "private_methods", "untaint", "nil?", "is_a?"]

E para filtrar:

    ruby-1.8.7-p352 :002 > gato.methods.grep /ins/
    => ["inspect", "instance_variable_defined?", "instance_variables", "instance_eval", "instance_variable_get", "instance_of?", "instance_exec", "instance_variable_set"] 

Se você abrir o interpretador Ruby, verá que o Ruby armazena as variáveis
de instância no objeto e um "link" para a classe, ou seja, **as variáveis
de instância no objeto e os métodos na classe**.

    class Animal
      def initialize(nome)
        @nome = nome
        @um_gato = 'sim' if nome == 'gato'
      end

      def qual_o_nome
        @nome
      end
    end

Como você viu o método `qual_o_nome` é de instância, ou seja, só existe
quando um objeto é criado, para exemplificar vamos filtrar os métodos
de instância dos de classe:

    ruby-1.8.7-p352 :007 > gato.methods.grep /qual/
    => ["equal?", "qual_o_nome"]
    ruby-1.8.7-p352 :008 > Animal.methods.grep /qual/
    => ["equal?"]

Para criar o método de classe usa-se o `self` na definição do método:

    class Animal
      def initialize(nome)
        @nome = nome
      end

      def qual_o_nome
        @ja_foi_mostrado_o_nome = 'sim'
        @nome
      end

      def self.qual_o_nome
        "Eu sou uma classe e ainda nao tenho nome"
      end
    end

Verificando os métodos:

    % irb -r ./animal
    ruby-1.8.7-p352 :001 > Animal.qual_o_nome
    => "Eu sou uma classe e ainda nao tenho nome"
    ruby-1.8.7-p352 :002 >

## Um pouco sobre herança

Quando um método é chamado na instância de um objeto, o interpretador
procura pelo método na sua classe e "sobe" na hierarquia até encontrar o
método.

Por exemplo, agora temos estas 3 classes:

    class Animal
      def initialize(nome)
        @nome = nome
        @tipo = 'animal'
      end

      def meu_tipo
        @tipo
      end
    end

    class Macaco < Animal
      def initialize(nome)
        @nome = nome
        @tipo = 'macaco'
      end
    end

    class Gato < Animal
      def initialize(nome)
        @nome = nome
        @tipo = 'gato'
      end
    end

Testando:

    % irb -r ./animal.rb
    ruby-1.8.7-p352 :001 > animal = Animal.new('tipo generico de animal')
    => #<Animal:0x7f11ce5d93a0 @tipo="animal", @nome="tipo generico de animal"> 
    ruby-1.8.7-p352 :002 > animal.meu_tipo
    => "animal"
    ruby-1.8.7-p352 :003 > macaco = Macaco.new('nome do macaco')
    => #<Macaco:0x7f11ce5c7768 @tipo="macaco", @nome="nome do macaco">
    ruby-1.8.7-p352 :004 > macaco.meu_tipo
    => "macaco"
    ruby-1.8.7-p352 :005 > gato = Gato.new('um gato')
    => #<Gato:0x7f11ce5b6d00 @tipo="gato", @nome="um gato">
    ruby-1.8.7-p352 :004 > gato.meu_tipo
    => "gato"

Ao inicializar uma instância de cada um dos tipos você verá que cada um
vai responder pelo método `meu_tipo`, porém somente a classe `Animal`
define o método `meu_tipo` as outras duas classes herdam este método.

