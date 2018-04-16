---
title: New Website Theme!
author: Daniel Anderson
date: '2018-04-14'
slug: new-website-theme
categories:
  - website
tags:
  - css
  - blogdown
---

This post has needed to be writtend for a little while, but I've been busy with the actual work of redesigning my website (in fact, I have a number of posts that are backlogged). This post will have a little bit of code (all of it CSS, rather than R), but mostly it's just about my journey and things I've learned. 

# Getting started with Blogdown
In Yihui's [introduction to blogdown](https://slides.yihui.name/2018-blogdown-rstudio-conf-Yihui-Xie.html#11) he advocates for simpler themes. Specifically, he states

<blockquote>
My advice on themes (you won't listen anyway):

* you will naturually have strong desire for fancier themes, but I recommend you to try simpler themes in the beginning

* spend more time on creating the content

* you will be bored by your favorite theme someday, no matter how good it looks for now
</blockquote>
This is kind of a funny quote, but also very true - I didn't listen to him, and it caused me a lot of pain. Why? Because prior to this redesign I'd never even dipped a toe into CSS. It reminded me of this O'Rly book [Mara Averick](https://twitter.com/dataandme).

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">It&#39;s Friday- why not make it survivable with another round of <a href="https://twitter.com/ThePracticalDev?ref_src=twsrc%5Etfw">@ThePracticalDev</a> covers? <a href="https://twitter.com/hashtag/nerdhumor?src=hash&amp;ref_src=twsrc%5Etfw">#nerdhumor</a> <a href="https://t.co/7tqL6N9WLz">pic.twitter.com/7tqL6N9WLz</a></p>&mdash; Mara Averick (@dataandme) <a href="https://twitter.com/dataandme/status/764079203499343872?ref_src=twsrc%5Etfw">August 12, 2016</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script> 

(specficialy the "Changing Stuff and Seeing What Happens" book, whichc is a little hard to see in the above)

# Motivation
When I first launched my website, I spent a **long** time looking at themes. I eventually settled on [Beautiful Hugo](https://github.com/halogenica/beautifulhugo), which is a port of [Dean Attali's](https://deanattali.com) [Beautiful Jekyll](https://deanattali.com/beautiful-jekyll/). It's really a great theme. It's beautiful, it's clean, and it's actually relatively simple. This partly explains why it's been so successful, with, at the time of this writing the original Jekyll version having 1,096 stars on GitHub and the Hugo port having 239 stars.

So if I'm such a fan of Beautiful Jekyll/Hugo why did I opt to change? There are three basic reasons:

  1. Code blocks wrapped the code onto the next line when it extended passed the block (I later learned this is called overflow, but changing that parameter didn't seem to help). This was not *that* big of a deal in the grand scheme of things, but was a small annoyance.
  2. The success of the theme. This may sound silly but the theme is so popular that I was constantly running into other websites out there that looked, essentially, exactly like mine. I wanted to be different.
  3. I wanted to learn something new. I like pretty things and making things pretty so I wanted to learn at least the basics of CSS. I knew I wasn't going to be able to start fully from scratch, though, so I decided to start with a theme I liked and then modify it until I got to a point I was satisfied. 
  
# Stuck in indecisive theme hell
Once I decided to adopt and hopefully modify a new theme I spent **hours** exploring themes. The process regularly reminded me of the [paradox of choice](https://en.wikipedia.org/wiki/The_Paradox_of_Choice), where I essentially became paralyzed because there were too many choices! There were always parts of different themes I liked but also parts I didn't like. I even went so far as transfering my entire site to a new theme, then abandoning it -- on more than one occassion. 

Finally, I settled on the [even](https://github.com/olOwOlo/hugo-theme-even) theme. It had a lot of things I liked. I'm a sucker for fancy animations and the *even* theme has a lot. On the home page, you'll see links underline from center on hover, the table of contents on posts (like this one) floats with the page, tags grow marginally, and when there are figures or images you can click to zoom and it will pull out in a nice panel where you can select which image you want to look at. All of this had me like

![](http://68.media.tumblr.com/53346ceedde5b6d29c0558bb1e932858/tumblr_or91vaey0D1rmp6e8o1_540.gif)

Of course, there were things I didn't like too, or at least things that I wished were different. 

# My journey into the land of CSS (sort of)
If you look at my site compared to the [example site](https://themes.gohugo.io/theme/hugo-theme-even/) for *even* you will see that they, obviously, look very different, although there are some strong similarities too. Interestingly (to me anyway), *even* usess a varient of CSS, called [SASS](https://sass-lang.com). This led to some initial confusion for me because I had at least a tiny bit of understanding of CSS, but no idea what SASS even was (I'd never heard of it before). Basically, SASS just allows you to parametrize things a little easier and write more succinct code which eventually gets tranlated to CSS anyway (for a really basic intro, see [here](https://sass-lang.com/guide)).

Some of the changes I made were easy. For example, I just had to change one line to get the background color to be different (which dramatically changed the look and feel of the site). Others were more complicated. For example, I really like [sticky headers](https://www.w3schools.com/howto/howto_css_fixed_menu.asp). Luckily, SASS makes this pretty easy, but it still took me hours to figure out, and then basically just as long to tweak it to how I wanted. The original code for the navigation bar looked like this

```css
.site-navbar {
  float: right;

  .menu {
    display: inline-block;
    position: relative;
    padding-left: 0;
    padding-right: 25px;
    font-family: $global-serif-font-family;

    .menu-item {
      display: inline-block;

      & + .menu-item {
        margin-left: $menu-item-margin-left;;
      }

      @include underline-from-center;
    }

    .menu-item-link {
      font-size: $menu-link-font-size;
    }
  }
}
```

and I changed it to

```css

.site-navbar {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  margin: 0 auto;
  padding: 0;
  background: $white;
  box-shadow: 0px 2px 2px $gray;
  border-bottom: 2px solid $theme-color;
  z-index: 90;
  text-align: right;
  transition: transform 300ms ease;
  z-index: 99;

  .menu {
    display: inline-block;
    position: relative;
    padding-left: 0;
    padding-right: 25px;
    font-family: $global-serif-font-family;

    .menu-item {
      display: inline-block;
      color: $theme-color;

      & + .menu-item {
        margin-left: $menu-item-margin-left;
        z-index: 111;
      }

      @include underline-from-center;
    }

    .menu-item-link {
      font-size: $menu-link-font-size;
    }
  }
}
```

This took **a lot** of trial and error, but eventually I got there. And that's essentially the approach I took throughout. Try some stuff, see what happens, try again, and eventually settle on something.

# Conclusions
I would not recommend the approach I took. I think Yihui's advice is sound, and you should probably listen to him. That said, if you already know some CSS, then all this would probably have been a lot easier for you than it was for me. And, if you are trying to learn CSS, I think redesigning an existing website is a good strategy. It is sort of a trial-by-fire approach that is slow and can be frustrating, but also rewarding because you can (eventually) get everything the way you like it to be. 
