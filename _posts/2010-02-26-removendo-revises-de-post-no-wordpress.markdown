---
layout: post
title: "Removendo Revisões de Post no WordPress"
date: 2010-02-26 17:38
comments: true
categories: [cms, wordpress]
---

Para desabilitar as revisões dos posts no WordPress, edite o arquivo wp-config.php modificando o seguinte conteúdo:

    define('AUTOSAVE_INTERVAL', 300 ); // seconds
    define('WP_POST_REVISIONS', false );

Para apagá-las na base de dados, execute o seguinte sql:

    DELETE FROM wp_posts WHERE post_type = "revision";
