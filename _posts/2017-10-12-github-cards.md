---
title: "Jekyll Plugin: Github Cards"
date: 2017-10-12 21:54:00 -0400
---

I need to make a confession: I finished the magic mirror back in mid-August. I'll be posting the final update to my mirror whenever I have time (as you can see I am *terrible* with this concept of blogging), but for now I want to write a post-mortem, to say, of the Jekyll plugin I just made:

{% ghcards github-cards %}

If you're wondering what it does, congratulations, you just saw what it does! It's an easy-to-style github card liquid tag! I can easily call a bunch of cards, or a single card, depending on what params I put in.

For example, the one you just saw was the following on my end:
```liquid
{% raw %}{% ghcards github-cards %}{% endraw %}
```

I can also call up to 30 (but seriously, who needs more than 30?) repos at a time just by saying the following:
```liquid
{% raw %}{% ghcards 30 %}{% endraw %}
```
Or, if I don't want to use my own repos, just pass in the author:
```liquid
{% raw %}{% ghcards jekyll 3 %}{% endraw %}
```

It uses Github's new APIv4 that utilizes GraphQL, a relatively novel API format by Facebook. I personally think it's a strong contender to replace API calls for many larger organizations, since, when specified correctly, lightens the load for both the server and the client.

On the user side (that is, the people who view this blog), they'll have a small JS that will pull and cache the latest stars and forks from Github, so they'll see the latest data, even when the last time the website was regenerated was 20 years ago.

I personally will be using this in the future, and I hope many come to adopt it as well.

## What went right

### 1. GraphQL

GraphQL was an absolute breeze to work with. I loved the concept getting everything I wanted and *only* the things I wanted, rather that getting everything and then discarding the unnecessary parts. It's cleaner code, lighter on the network, and best of all, it feels elegant. GraphQL seems like a natural progression from a clunkly API protocol (aka JSON via RESTful calls) to a streamlined and optimized solution. I simply don't want to go back. I've experienced hell when an single api call (read: the only api call) returns literally everything you need to know, everything you don't need to know, and *then* some. Filtering, parsing JSON, debugging, and more all took so much time out of development to just figuring out *What the fuck is this, and how do I properly parse it?* I just wished that it had more adoption. As of right now, you need to rely on an library client (that isn't trivial to minimally reproduce) that, while excellent in itself, is rather large.

Using it is rather simple. You ask the server for the template schema it uses, make a schema of your own that follows that template, and then send the request. It's done in this way so that the client can verify that the schema that you generate is valid against the schema the server has, so you don't need to worry about getting invalid data. If it's wrong, you'll know it won't work before you ship it to production.

### 2. Caching

Implementing a caching function to my small JS code was actually surprisingly easy. Perhaps it was because I was used to JavaScript, or perhaps the documentation was easier to understand. Regardless, I was able to implement a rudamentary form of caching within 10 minutes.

For reference, my plugin actually doesn't add any javascript at all, nor does it require any. That's the beauty of this liquid tag--it only generates HTML. However, a side effect of this is that the numbers (forks and stars) that should be dynamic text, are static. Initially a friend offered a quick, easy (and maybe sarcastic) fix: iframes, but I heavily opposed this idea. It went against one of the prime reason to even use this plugin. Instead, I opted to create a script that pulls data from Github's RESTful API (APIv3). It worked, but with the test page I was using (~27 repos), I quickly reached the rate limit for my IP--3 refreshes, in fact. Caching the data, and only reloading after a certain time, would allow both other repos to be updated and prevent already viewed to waste precious calls.

### 3. Styling

You might expect styling to be easy, but in a sense, it was quite difficult. Actually, I even had to ask my friendo [Aralisza][em-github] to help with styling. I had 4 objectives when creating the style hooks and styling the template design:
1. Design a HTML structure that was easy to modify and style
2. Copy the Github style as much as possible
3. Not make it ugly.
4. Add useful and meaningful links to the repo card

(1.) and (2.) were relatively easy to accomplish, and (3.) naturally came from following (2.), but (4.) was difficult. At times, I didn't know how much would be enough: *Should I make every piece of text interactive? Or should I just keep it to the basics?* I actually had considered linking the language indicator to the trending repos in that language because it seemed like neat idea but decided against it when I realized it wasn't helpful to whomever was looking at that card. I also had the idea of making the stars and forks indicators interactive, but that idea quickly ended when I realized that Github's fork and star buttons weren't simple GET calls. That might be a feature in the future, but for now, it seems a little beyond what was needed.

## What went wrong

### 1. Learning Ruby

Man, oh man, learning Ruby was tougher than expected. The way I generally learn a language is to dive deep into a project, and come back out with some understanding of the syntax and kinks the language has. With Ruby, I had expected it to be easy to learn, like Python, since it boasted the ease of use of its language. But then I saw some interesting quirks:
1. `test` is a normal variable.
2. `@test` is an instance variable. I understood this as a field in other languages.
3. `Test` must be just another variable, right? Nope, it's a constant. I believe this is the correct way to style a constant, and not the normal `UPPERCASE` other languages use. Okay, that's a little new, but nothing to get fussy over about.
4. `@@test` is a... instance instance variable? It's kinda like a pointer to a pointer in C++ right? Nope, class variable. Apparently, it's a variable that all inherited classes can access as well. I guess this would be nice in some cases, but I don't think I'll be using this.
5. `$test` Uh... the only experience I have with variables starting with `$` was back in PHP, and everyone hates PHP so I doubt it'd be just a variable. Turns out, it's a global variable. Why do you need to declare that in a function? Why not just define a variable outside any function or class, and just let that have global scope? What happens if you rely on a `nil` global variable? Why does Ruby even encourage usage of the global namespace‽

### 2. GraphQL and Ruby

Global variables me to my next confusion: GraphQL variables. Remember how GraphQL works? Turns out, you can also define variables in your schema, so that you can use the same schema format for different requests! How intuitive! But guess how those variables are declared in GraphQL? Yup, just like how Ruby declares global variables.

Man, you have no idea how confusing it was to a Ruby newb to see this example code in the `graphql-client` docs:
```rb
HeroNameQuery = SWAPI::Client.parse <<-'GRAPHQL'
  query($id: ID!) {
    hero(id: $id) {
      name
    }
  }
GRAPHQL
```
Now, to those familiar to Ruby, you'd realize that everything's in a String, and that fancy `<<-'GRAPHQL'` and `GRAPHQL` was just syntatic sugar for a multiline string. But to me and my ~~IDE~~ text-editor, it looked like some sort of escaped text. So I had no idea whether it meant we needed to declare some global Ruby variables or it would interpret using `$id` for variables instead.

**\<aside>** What's up with and their `<<-'GRAPHQL'` sugar anyways? How is that even considered synatatic sugar‽**\</aside>**

Once I figured what that meant, the rest was easy to understand. But it took quite a bit of time to figure that out.

### 3. Jekyll, Gems, and Testing
I still don't know how to properly perform unit tests on my code, since when I try to run my code separately from Jekyll, it fails on me (since Jekyll is undefined). Not only that, I still don't quite understand how to make Gems either. That shouldn't be too difficult, it's just I don't have the time (nor mental fortitude at this point) to figure out. I just wish it didn't require all this thinking to begin with, but I guess that's part of my job and not theirs.

## Conclusion

I've come to realize that I don't like Ruby. I will probably never touch this language again (unless the stack I work with uses Ruby on Rails), and I will gladly file this project on *Things I don't want to do again*. But hey, the result was pretty cool, and I'm not going to lie, I'm pretty proud at the end result. This project was overall a fun project, and the problems that occured weren't too bad either. It's just, I don't like the Ruby ecosystem at all. You win some, you lose some.

[em-github]: https://github.com/Aralisza
