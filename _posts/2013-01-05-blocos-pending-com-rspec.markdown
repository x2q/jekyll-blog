---
layout: post
title: "Blocos pending com Rspec"
date: 2013-01-05 07:39
comments: true
meta-description: "Diferentes usos de marcar um bloco como pending usando rspec"
categories: [ruby, test, spec]
---

O Rspec tem diferentes formas de colocar um bloco de código como `pending`,
minhas formas de uso são:

* Como TODO;
* Colocar teste que quebra sem ainda saber o motivo como pendente;
* Marcar o teste que quebra como certo, porém a interface não "preparada";

# Como TODO

Vamos supor que está criando uma lib de criptografia (bem simples), como gosto
de fazer é desenvolver pelo teste, normalmente, eu coloco todos os casos de uso
que lembro, depois implemento cada teste e por fim o código:

```ruby
require './lib/crypt'

describe Crypt do
  it 'encrypt'

  it 'decrypt'
end
```

O seu TODO pode ser visto no próprio rspec:

```
% rspec spec/crypt_spec.rb
**

Pending:
  Crypt encrypt
    # Not yet implemented
    # ./spec/crypt_spec.rb:4
  Crypt decrypt
    # Not yet implemented
    # ./spec/crypt_spec.rb:6

Finished in 0.0004 seconds
2 examples, 0 failures, 2 pending
```

# Quando o teste está quebrando

Há vários motivos para um teste quebrar: pode ter mudado algo na
interface/código, uma gem que você usa está quebrando, …

Mas e se seu teste estiver correto? Uma gem de terceiros pode estar quebrando,
mas sua implementação de uso dela pode estar correta.

Basta colocar um `pending` no começo do teste, opcionalmente com um motivo.

Imagine que temos esse teste:

```ruby
require './lib/crypt'

describe Crypt do
  it 'encrypt' do
    subject = Crypt.new('abc')

    expect(subject.encrypt).to eq 'bcd'
  end

  it 'decrypt'
end
```

Rodar ele vai resultar em:

```
% rspec spec/crypt_spec.rb
F*

Pending:
  Crypt decrypt
    # Not yet implemented
    # ./spec/crypt_spec.rb:10

Failures:

  1) Crypt encrypt
     Failure/Error: expect(subject.encrypt).to eq 'bcd'

       expected: "bcd"
            got: "zzz"

       (compared using ==)
     # ./spec/crypt_spec.rb:7:in `block (2 levels) in <top (required)>'

Finished in 0.00104 seconds
2 examples, 1 failure, 1 pending

Failed examples:

rspec ./spec/crypt_spec.rb:4 # Crypt encrypt
```

Vai falhar, mas e se colocar o `pending` com um bloco (o bloco e o motivo são
opcionais) ele vai ser marcado como pendente:

```ruby
require './lib/crypt'

describe Crypt do
  it 'encrypt' do
    pending "waiting to work right" do
      subject = Crypt.new('abc')

      expect(subject.encrypt).to eq 'bcd'
    end
  end

  it 'decrypt'
end

```

E executando o teste:

```
% rspec spec/crypt_spec.rb
**

Pending:
  Crypt encrypt
    # waiting to work right
    # ./spec/crypt_spec.rb:4
  Crypt decrypt
    # Not yet implemented
    # ./spec/crypt_spec.rb:12

Finished in 0.00107 seconds
2 examples, 0 failures, 2 pending
```

Se não mudarmos nada no teste, mas corrigir o código ele vai exibir a seguinte
saída:

```
% rspec spec/crypt_spec.rb
F*

Pending:
  Crypt decrypt
    # Not yet implemented
    # ./spec/crypt_spec.rb:12

Failures:

  1) Crypt encrypt FIXED
     Expected pending 'waiting to work right' to fail. No Error was raised.
     # ./spec/crypt_spec.rb:5:in `block (2 levels) in <top (required)>'

Finished in 0.00102 seconds
2 examples, 1 failure, 1 pending

Failed examples:

rspec ./spec/crypt_spec.rb:4 # Crypt encrypt
```

Note o `FIXED`.

Basicamente: "Você esperava que esse teste estivesse quebrando, MAS foi
corrigido". Agora pode-se remover o `pending`.

## Usando o xit

Outra forma de desativar o teste é usando o `xit` ao invés de `it`. Ele tem o
mesmo efeito que usar o pending (sem bloco), mas sua saída é um pouco
diferente.

No nosso exemplo:

```ruby
require './lib/crypt'

describe Crypt do
  it 'encrypt' do
    pending
  end

  xit 'decrypt'
end
```

Executando:

```
% rspec spec/crypt_spec.rb
**

Pending:
  Crypt encrypt
    # No reason given
    # ./spec/todo_spec.rb:4
  Crypt decrypt
    # Temporarily disabled with xit
    # ./spec/todo_spec.rb:8

Finished in 0.00049 seconds
2 examples, 0 failures, 2 pending
```

`No reason given` é para o `pending` (sem bloco e sem motivo) e o `Temporarily
disabled with xit` é para o uso do `xit`.

Existem muitas formas de desativar blocos de teste, poderiamos até mesmo
comentar! Mas quando você entrega seu código para outro desenvolvedor é bom
manter o mais claro possível o motivo de um teste estar pendente.
