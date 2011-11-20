---
layout: post
title: "Grub: does not have any..."
date: 2009-09-17 06:17
comments: true
categories: [bug, emerge, gentoo, grub, linux, portage]
---

Se você instalou o Gentoo usando um CD de outra distro ou usando o HD, talvez lhe apareça este erro:

    livecd gentoo # grub-install /dev/hda
    /dev/hda does not have any corresponding BIOS drive

A solução para este problema é adicionar o parâmetro ``--recheck``:

    # grub-install --recheck /dev/hda
    Probing devices to guess BIOS drives. This may take a long time.
    Installation finished. No error reported.
    This is the contents of the device map /boot/grub/device.map.
    Check if this is correct or not. If any of the lines is incorrect,
    fix it and re-run the script `grub-install'.

    (fd0)	/dev/fd0
    (hd0)	/dev/hda

Veja que na primeira linha ele faz uma verificação. E apesar de ameaçar, não demora tanto assim.
