---
layout: post
title: "Branch Remoto - Git"
date: 2010-03-04 13:00
comments: true
categories: [git]
---

Mostro como criar um _branch_ remoto no git desde o início.

# Criar um branch remoto desde o início

Criar o novo branch:

      % git push origin origin:refs/heads/novobranch
      Total 0 (delta 0), reused 0 (delta 0)
      From /var/spool/gitosis/repositories/brancher
       * [new branch]      unstable   -> origin/unstable
      To git@server.localdomain:brancher.git
       * [new branch]      origin/HEAD -> unstable

Então você pode ver que o branch foi criado.

      % git branch -a
        master
      * novobranch
        remotes/origin/HEAD -> origin/master
        remotes/origin/master
        remotes/origin/novobranch

Agora siga o novo branch

      % git checkout -t -b novobranch origin/novobranch
      Branch novobranch set up to track remote branch novobranch from origin.
      Switched to a new branch 'novobranch'

# Apagar um Branch Remoto

      % git branch -d -r origin/novobranch
      Deleted remote branch origin/novobranch (was 01e5ee4).

