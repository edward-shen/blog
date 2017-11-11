---
title:  "Magic Mirror: Intro and design considerations"
date:   2017-06-11 15:11:00 -0400
categories: jekyll update
---

Summer has arrived. High school just finished, and I need something to do to 
fill the time.

Why not build a magic mirror? It's should be relatively cheap, fun, and I get 
to learn the raspberry pi at the same time. Plus, it shouldn't take too long to 
complete (Soon&trade;).

## Design considerations

Weight, size, and functionality all take a critical part when the physical part 
of the mirror. Since I'm heading to college, I'd love to find a way to mount 
the mirror safely and securely without damaging the walls lest face the wraith 
of a $900 repair bill.

If everything goes to plan, I should have a large full touch screen mirror.

In regards to electronics hardware, there's an entire platform for magic
mirrors under the raspberry pi. I could alternatively write my own, but there 
seems no need to. Plus, I'll likely be contributing to the modules.

Weight is a very tricky concern. From previous builds on the internet, it appears that the 
frame and mirror are the heaviest components, as the frame needs to hold the heavy glass. At
the same time, however, I do want it to be large--greater than 25" diagonally.

At this point, I started to do some searching. Amazon was no good, since at best
I would like to purchase a used monitor, and the used market there as good. Craigslist didn't
even have monitors near me, so that was out. I eventually turned to eBay, and despite my
reservations from buying there, I eventually looked at some of their 27" monitors.

### The monitor

You could buy a new 27" thin monitor for around $150 there. At first, that sounded like a great
deal. But a major concern was the orientation of the I/O. They were facing perpendicular to the
screen! Unless you want to buy right angle connecters for everything, you'd best be find another
monitor. That being said, however, I did manage to find a 27" monitor with I/O parallel to the
screen, but they were bulky---around 2 inches thick. That was no go, either.

So I turned to parts. If I got the parts indiviually, I would be able to not only cut down on
plastic thickness, but weight as well. I was able to find a [27" 1080p LCD Panel][lcd panel]
and a [controller kit][kit] that worked with the panel. Note that if you're buying a different
panel, you'll need to contact the controller seller to make sure that they're compatible! I
contaced the controller seller and they said that that panel was ok. Alright, so add both to
cart, and boom, the controller kit will take more than two weeks to arrive.

Wait, what?

Well, one guy reviewed the product and said "Fast delivery". So hopefully we'll get it soon.

### The glass

There are two primary materials that are considered for this: Acrylic and glass. With wieght in
mind, my first idea was to go to acrylic, but after some research, I soon found out that acryllic
can warp if it's thin and large enough. Plus, it would scratch and dent, and considering how I'm
going into a rugged environment, I think it would be better to just leave it to glass.

I was able to find a relatively nice deal from [Two Way Mirrors][mirror]. They not only sold 70%
reflective and 30% transparent glass (which was the best ratio according to the internet), they
also had a pretty nice deal: $169.95 for a 20"x24" sheet. Considering how the price was originally
$250, I don't think I could find a better deal. It's also a little bigger than the screen I bought,
which means that I have some space for adjusting and adding additional sensors.




[lcd panel]: http://www.ebay.com/itm/222412534424
[kit]: http://www.ebay.com/itm/121059321784
[mirror]: https://www.twowaymirrors.com/smart-mirror/#34131241324312
