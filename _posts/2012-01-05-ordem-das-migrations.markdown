---
layout: post
title: "Ordem das Migrations?"
date: 2012-01-22 14:03
comments: true
categories: [git, rails, activerecord, ruby]
---

Nota: este post está sobre a tag [git](/categories/git/), pois estou simulando um "conflito"
usando git e rails

    % rails g model teams name:string
    % rails g model tasks name:string
    % rails g model user name:string

Para ficar melhor para ver mudei as migrations para:

    check_migration_order % ls -1 db/migrate
    20100105101918_create_tasks.rb
    20110105101832_create_teams.rb
    20120105102143_create_users.rb

O processo normal seria roda uma migration aqui, porém eu "apaguei" a **2011** e rodei as migrations:

    check_migration_order % rake db:migrate
    == CreateTasks: migrating ====================================================
    -- create_table(:tasks)
    -> 0.0016s
    == CreateTasks: migrated (0.0017s) ===========================================

    == CreateUsers: migrating ====================================================
    -- create_table(:users)
    -> 0.0015s
    == CreateUsers: migrated (0.0016s) ===========================================

Agora eu adicionei a migration **2011** justamente para simular, por
exemplo, como se alguém tivesse mandado a migration posteriormente via
git.

Rodando o `rake db:migrate`:

    check_migration_order % rake db:migrate
    == CreateTeams: migrating ====================================================
    -- create_table(:teams)
    -> 0.0016s
    == CreateTeams: migrated (0.0018s) ===========================================

Ou seja, o _ActiveRecord_ não faz as migrations em ordem e descarta as
que já passou (como muitos pensam E como era até certas versões), ele
verifica as que não foram feitas e, claro, dando preferência para a ordem
no nome.
