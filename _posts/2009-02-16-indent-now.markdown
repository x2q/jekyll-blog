---
layout: post
title: "Indent Now"
date: 2009-02-16 11:00
comments: true
categories: [vim]
---

No [vim](/vim) quando é colocado no modo de 'indent' o código em C, Ruby ou qualquer outra linguagem fica automaticamente formatado, i. e., quando você vai digitando o próprio vim adiciona as tabs ou espaços necessários:

    #!/usr/bin/ruby
    def hello
      puts "Hello Word!!"
    end
    hello

No exemplo acima a tabulação da linha 3 foi feita automaticamente.

Ok! O vim 'tabula' o texto, mas e se eu tiver um arquivo de texto já colocado, mas não formatado?

Basta usar, no modo comando, ``gg=G`` (sem o ``:``).

# Exemplo

O arquivo está assim:

    #!/usr/bin/ruby
    
    def hello
      puts "Hello Word!!"
                 end
    
            hello

Após usa o ``gg=G``:

    #!/usr/bin/ruby
    
    def hello
      puts "Hello Word!!"
    end
    
    hello

Referência:

Anthony Ettinger. Fix Indentation and Tabs in VIM. Disponível em [http://www.chovy.com/web-development/fix-indentation-and-tabs-in-vim/](http://www.chovy.com/web-development/fix-indentation-and-tabs-in-vim/). Acessado em 16 de Fevereiro de 2009.
