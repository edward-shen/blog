---
title: "Magic Mirror: Module interlude"
date: 2017-06-14 17:56:00 -0400
---

I took a break from physically developing my magic mirror (not because the parts aren't here yet or anything) to work on creating some module that I wanted but didn't exist. Take, for example, an module that would allow you to view information about a single station in Boston, and what modes of transportation would arrive there at what (predicted time). Seems pretty cool, right? Turns out, I couldn't find one. So I instead of just being ok with not having one, I made one instead.

I present to you, MMM-MBTA.

There's a lot more information on the github page, so I'll just leave my repo card below.

{% ghcards MMM-MBTA %}

The total time from production to (effecitvely) completed was about one day and 6.5 hrs, including sleep, eating, etc. I was surprised at how quickly I was able to finish this. MBTA's API rules are pretty nice though---they give a public dev api key for anyone to use. Unfortunately, they also limit each type of polling request to 1 per every 10 seconds.

But that wasn't all. I also wanted to have a paging feature, where you could basically have app pages like you do on most modern smart phones.

Considering the implementation constraints of the MagicMirror platform, I realized I needed two modules, one that does the page switching, and one that displays what page you're on.

As of writing this post, I got the display helper module done. I'm currently taking a break to write up this post, but I'll edit this when I have it done.

But for now, have another card:

{% ghcards MMM-page-indicator %}
