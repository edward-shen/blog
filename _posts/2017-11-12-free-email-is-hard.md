---
title: "Email is hard"
date: 2017-11-12 01:44:00 -0400
---

Correction: *free* email is hard.

You'd think given the availibitily of creating a custom webiste these days that setting up email shouldn't be too difficult either. Just buy a domain, click on "yes I want to have email" and boom, done.

Turns out, it's not that easy. The registrar I registered my domain with, NameCheap, unfortunately don't provide free full email services, like Google domains. They only provide email forwarding, and you can't even send emails from the email address you make.

But ok, fine, I can deal with that. After all, I just needed it for my resumes. Interviewers probably don't mind if they get a mail from a different address so long as there's context, which all mail services provide.

In comes Cloudflare's free service, which lets me use HTTPS with Github pages for custom domains. Yay! No more unsecure website!

**\<aside>**<br />
If you are looking for a way to encrypt your webpage, and you serve it from your own server, perhaps consider [Let's Encrypt][le]. They're a nonprofit whose goal is to provide the internet with SSL/TLS Certs.<br />
**</aside>**

Anyways, back to the topic at hand.

Eventually I wanted to find an actual solution to this issue. After discussion with some friends, I was told that **1)** I could just create my own mail server (but good luck getting it trusted by anyone and not sent to spam) or **2)** I could just shell out 5 dollars a month. It's just $5, after all.

Being the ~~cheap~~ frugal person I am, there's gotta be a better way.

Turns out, you need to jump through some loops before you can get a reliable free mail service that provides sending and recieving through addresses, but it's certainly free[^1].

[Mailgun][mailgun] is a website primarily oriented for developers trying to implemt some form of mailing list-esque features in their clients. While not directly meant for personal use, you can certainly take advantage of their features.

They allow free outbound emails up to 100,000/month, which, for personal email, more than anyone would reasonably ever use. Setting it up was relatively easy (despite some minor setbacks and following [this guide][mailgun-guide]), it was pretty painless. Plus, Cloudflare's DNS propagated *really* quickly, compared to Namecheap's. It took less than a minute for Cloudflare's records to be updated, which was really impressive considering how it can take up to two days for DNS records to be updated.

The only caveate that I have with Mailgun is that it requries your CC info on file. It's reasonable, but at the same time, I'd rather not perfer to do so.

Mailgun also comes with an additional nice feature -- I can see when my recruitors actaully open up my emails.

And this is exactly why you disable images, kids.

[^1]: It just may or may not require an credit card on file.

[mailgun]: https://www.mailgun.com/
[mailgun-guide]: https://www.chrisanthropic.com/blog/2014/mail-forwarding-with-mailgun-and-cloudflare/
[le]: https://letsencrypt.org/

