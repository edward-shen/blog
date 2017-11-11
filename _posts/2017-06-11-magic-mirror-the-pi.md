---
title:  "Magic Mirror: The pi"
date:   2017-06-11 15:11:00 -0400
categories: jekyll update
---

*This is part two of the Magic Mirror Project. For part 1, please click
[here][previous post]*.

Parts used:
* [A Class 10 32GB MicroSD card][sd card]
* [Raspberry Pi Model 3 B][pi]
* [Micro USB power adapter][power adapter]
* A random monitor, to test.

## Installing an OS

It's finally arrived! Let me plug everything in and... nothing.

Oops, forgot to install an operating system. Lets install Raspbian... and sync error.

Uh, lets try NOOBS? Cool we booted up!

Ok, everything is set for Britian. Lets change everything real quick to the US.

**EDIT: I would *highly* recommend you to delete the `pi` user before moving on and creating your own. It's simply a vunerability, especially
if you plan on going to a public (read: university) network. Check the "Preliminary Security" section for more info.**

At this point, you may have attempted to install the Magic Mirror² platform, like I did. Don't. Go update your packages first:

```bash
sudo apt update && sudo apt upgrade
sudo apt dist-upgrade && sudo apt-get autoremove
```

The second line is really optional, but it's a fresh system, so a full upgrade couldn't hurt.

Now for the [MagicMirror² platform](https://magicmirror.builders)!

## MagicMirror²
The command on their front page worked for the most part, as it threw an error for the optional install of pm2.
It looks like there was a typo---an extra newline typed. It's an easy fix, just installing pm2 and running the line found in the installer,
but I'll post it here for visibility:
```bash
sudo npm install -g pm2
sudo su -c "env path=$PATH:/usr/bin pm2 startup systemd -u pi --hp /home/pi"
pm2 start ~/MagicMirror/installers/pm2_MagicMirror.json
pm2 save
```

Note that if you changed the default user from `pi`, you'll need to change the `-u` flag and the home directory in the second line. At this point, our basic magic mirror worked. The monitor displayed the platform perfectly.

You'll also need to edit the `pm2_MagicMirror.json` file. Unfortunately, the author hardcoded in the `home` directory to be `pi`. Fortunately, it's a two line fix. Change that to your own user directory.

A quick reboot to check if everything went smoothly, and now I have a Mirror in portrait mode... except I now have no way to control it.

\<panic>

Oh wait, I can just press `alt` and go to Window > minimize. (`ctrl + M` works too)

\</panic>

You could call setting up the RPi (Raspberry Pi) done, but there's a few tweaks that you can do to make it a little better.

-----------

## Tweaks

### Hiding the mouse cursor after a short period
I noticed that the mouse would still show up after reboot. There's also a quick fix for that:
```bash
sudo apt install unclutter
```
Then add the line `@unclutter -idle 1 -root` to /etc/xdg/lxsession/LXDE/autostart. You can change the idle timeout parameter
if you so desire (e.g. `-idle 0` instantly hides, while `-idle 2.5` hides after 2.5 seconds).

I personally left it at 1 second, because it's long enough where I can develop stuff on the magic mirror (and not wonder why my mouse disappears if I stop moving it), and short enough that it won't be noticed by normal usage. Well, you shouldn't have a mouse or keyboard attached to it anyways, so...

### Changing the orientation
You can change the orientation to a portrait mode if you wish by editing `/boot/config.txt`]
and writing `display_rotate=1` or `display_rotate=3`, depending which way you need to rotate it. I would highly recommend doing this when
testing any new modules.

### Preliminary Security
Well, every RPi comes with the user `pi` by default. This is a major security flaw. Lets fix this.

#### Adding a new user and deleting the `pi` user
I followed [this](http://raspi.tv/2012/how-to-create-a-new-user-on-raspberry-pi) guide. It's a little verbose, but it's a great introductionary
guide.

However, I had trouble deleting `pi`. I was able to solve this by following [this SO][SO deleting pi] post. Due to it's length, I've
reposted the commands below: 
```bash
sudo systemctl stop autologin@tty1

# Make sure that no process is being run by the user pi.
ps -fu pi

sudo deluser -remove-home pi
```

Then, set to auto-boot to the new user by adding `autologin-user=YOUR_USER` in `/etc/lightdm/lightdm.conf`. Reboot, and you're all set!

#### Requiring sudo password prompt
You may have noticed that there's no password prompt for `sudo` commands. If that scares you (it should since your pi auto-logins), there's
an easy way to fix it.

First, run `sudo visudo`. then comment out the following:
```bash
%sudo ALL=(ALL:ALL) ALL
```
By commenting it out (with a `#`), every non-root user will be prompted to enter their password.


[previous post]: {{ site.baseurl }}{% post_url 2017-06-11-magic-mirror-intro-and-design %}

[sd card]: https://www.amazon.com/gp/product/B010Q57T02/ref=oh_aui_detailpage_o01_s00?ie=UTF8&psc=1
[pi]: https://www.amazon.com/gp/product/B01CD5VC92/ref=oh_aui_detailpage_o01_s01?ie=UTF8&psc=1
[power adapter]: https://www.amazon.com/gp/product/B01L8DVOFM/ref=oh_aui_detailpage_o01_s00?ie=UTF8&psc=1
[SO deleting pi]: https://unix.stackexchange.com/questions/287620/why-failing-to-delete-user-in-raspbian
