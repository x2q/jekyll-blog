---
layout: post
title: "Importando Comentários com o disqus.com"
date: 2011-09-15 08:16
updated: 2011-09-15 08:50
comments: true
categories: [cms]
---
Segundo o [disqus.com](http://disqus.com) sobre si mesmo:

> Disqus is all about changing the way people think about discussion on the
> web. We're big believers in the conversations and communities that form
> on blogs and other sites.

ou

> Disqus é como mudar a forma como as pessoas pensam sobre "discussão" na
> internet. Acreditamos em grandes conversas e nas comunidades que se
> formam em blogs e outros sites.

Como parte da mudança entre site estático, wordpress, app própria e por fim
octopress tenho levado comigo além, claro, dos artigos, também todos os
comentários.

Como ferramenta "hacker" o octopress não "permite" comentários, para isso,
como é sugerido temos que usar o [http://disqus.com/](http://disqus.com/).

Primeiro faça seu cadastro em
[http://disqus.com/admin/register/](http://disqus.com/admin/register/).

O disqus permite importar comentárias das ferramentas mais comuns para
blogs como wordpress e blogger.

Como eu usava uma app própria não tive outra saída a não ser criar um xml,
porém não tive êxito ao fazê-lo, pesquisando mais um pouco achei um
projeto para usar a API do disqus,
[https://github.com/norman/disqus](https://github.com/norman/disqus).

Partindo deste projeto e de exemplos cheguei a seguinte tarefa, você só vai
precisar adaptar aos seus models e obter sua `api_key`, neste link
[http://disqus.com/api/get_my_key/](http://disqus.com/api/get_my_key/):

    namespace :import do
      desc 'Import comments into disqus'
      task :comments => :environment do
        Disqus::defaults[:api_key] = '****** MINHA API KEY ******'
        blog_name = 'nome_do_blog_dentro_do_disqus'


        forums = Disqus::Api.get_forum_list
        forum = forums['message'].find do |forum| forum['shortname'] = blog_name end
        forum_key = (Disqus::Api.get_forum_api_key :forum_id => forum["id"])['message']
        Page.all.each do |page|
          thread_url = "http://exemplosite.com/#{page.slug}/"
          thread_id = Disqus::Api.thread_by_identifier(:forum_api_key => forum_key, :title => page.title, :identifier => thread_url)['message']['thread']['id']
          page.comments.each do |comment|
            post = Disqus::Api.create_post :forum_api_key => forum_key,
              :thread_id => thread_id,
              :message => comment.content,
              :author_name => comment.author,
              :author_email => comment.author_email,
              :parent_post => nil,
              :created_at => Time.at(comment.created_at).strftime('%Y-%m-%dT%H:%M'),
              :author_url => comment.author_url,
              :ip_address => comment.user_ip

            if post['succeeded']
              puts "added a post successfully: #{post['message']['id']}"
              comment.imported = true
              comment.save
            else
              puts "false: #{post.inspect}"
            end
          end
        end
      end
    end

Como eu já usava o [akismet](http://akismet.com/), a migração foi muito
fácil e o melhor: até a data que foi feito o comentário foi importado.
