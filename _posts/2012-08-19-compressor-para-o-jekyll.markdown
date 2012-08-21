---
layout: post
title: "Compressor para o Jekyll"
date: 2012-08-19 12:52
comments: true
categories: [tip, jekyll]
meta-description: "Como deixar o HTML gerado pelo Jekyll mais limpo"
---

A um bom tempo estou usando [Jekyll](https://github.com/mojombo/jekyll) como
"engine" deste blog. Tenho certeza que esta é a melhor engine de blog que já
usei, mas o html gerado me incomodava um pouco.

O html gerado continha muitas linhas em branco, algumas vezes são linhas de
checagem (`if`, `else`, `case`) usados pelos arquivos em `_layouts` ou
`_include`, semelhante ao que já vi em código gerado pelo erb.

E como vez por outra gosto de "rever meus conceitos" olhando novamente a lista
de plugins do jekyll eis que encontro um "compressor".

Para usá-lo é bastante simples: salvar o arquivo deste gist
[https://gist.github.com/2758691](https://gist.github.com/2758691) para
`_plugins/compressor.rb`:

    % wget --no-check-certificate -O _plugins/compressor.rb https://gist.github.com/raw/2758691/5f49511b09887878103d827660ae3d7fce3d1773/compressor.rb

Agora apenas executar o comando para gerar novamente o blog.

# Observações

No meu caso precisei desativar o uso do **pack**, pois não tenho interesse em
comprimir os javascripts.

E uma "boa prática" quanto ao conteúdo do `_layouts`/`_include`.

Ao invés de fazer algo como:

    {% for category in post.categories %}
      <a href="{{ root_url }}/categories/{{ category }}/">{{ category }}</a>
    {% endfor %}

Tive que mudar para:

    {{ post.categories | category_links }}

Na primeira forma as tags `a` geradas eram uma por linha, porém o compressor
unia na mesma linha, o que por sua vez fazia com que o navegador exibisse todos
os links juntos.
