---
layout: post
title: Developing FoodEase
category: ios
author: Paolo Di Lorenzo
date: 2017-11-12 18:30 -0500
---

Just over five weeks ago, I released my first iPhone app, [FoodEase](https://foodease.xyz) to the App Store. I haven’t written any formal blog posts since then so I thought it might be a good idea to lay out my thoughts and vision for FoodEase, as well as what led to its creation.

## Born in Charleston, SC
Right after Christmas 2016, my girlfriend and I took a road trip down to South Carolina to get away from the harsh northern weather and experience a new place. Charleston was a beautiful little city with countless things to do and places to see. One thing that struck me was the abundance of highly rated eateries in such a concentrated downtown area. Answering the timeless travel question “where should we eat next?” became a constant bottleneck in deciding how we spent our day. Much time was wasted perusing the available dining options in Google Maps or Yelp before we decided on a place to eat. 

<table class=“centered”>
  <tr>
    <td><a href="{{site.url}}/images/google_maps_example.png"><img src="{{site.url}}/images/google_maps_example.png" width="200" alt="Google Maps Example"></a></td>
    <td><a href="{{site.url}}/images/yelp_example.png"><img src="{{site.url}}/images/yelp_example.png" width="200" alt="Yelp Example"></a></td>
  </tr>
</table>

One of the great difficulties in deciding where to eat was due to having *too many* options. Should we have burgers, tacos, Italian, or Chinese food? Something fancy or something more casual? Should we walk there or pick something further and use ride sharing?

Weighing all of these factors at once while staring at a list of unknown places **while** at the same trying to ensure it has good reviews can be overwhelming. This is when the gears began turning which eventually led me to start working on FoodEase: what if there was a way to open an app, and within *seconds* know where we should eat next? No scrolling through countless locations, no juggling a dozen variables; just open an app, see the place, and go. 

## Solving “Where should we eat?”
This issue seems pretty straightforward at first, but once you begin to map out how this should be implemented, it becomes much more involved. 

The following aspects must be considered at a minimum:
* Where is the user, and what’s nearby?
* What time is it during the day?
* What is the user’s budget?
* Does the user have any dietary restrictions?
* What kind of food does the user like?

Obtaining the first four bullet points is pretty straightforward with modern smartphones:
* Request the user’s GPS location and use a public places API (examples include [Google Places](https://developers.google.com/places/), [Yelp](https://api.yelp.com), and [Foursquare](https://developer.foursquare.com)). 
* Get the current time from the user’s device. 
* Have settings in-app for various elements such as budget and dietary restrictions. 

The fifth point is the most challenging to solve, but also the most important. People’s eating preferences vary greatly and the selection that exists in types of restaurants is enormous (Yelp’s [category list](https://www.yelp.com/developers/documentation/v2/category_list) contains over 200 types of food and restaurant places alone!). The blending of user settings, environment, and eating preferences to quickly produce a result is at the core of the FoodEase user experience. This is possible with the implementation of the FoodEase Recommendation Engine.

## The FoodEase Recommendation Engine
The FoodEase Recommendation Engine is the set of algorithms that provide the user with a list of places. The main drivers of place suggestions are the [categories](https://www.yelp.com/developers/documentation/v2/category_list)  assigned to places on Yelp. These categories provide the most granular, unique representation of a place while still being broad enough for general categorization. Using the categories (as opposed to say, the actual place itself) is useful because of the idea that if a user likes a place with certain categories, there is a chance that they would like a completely different place that had the same exact categories. This of course, is not always true but using a long-term average, one can assume that this would be the case.

Therefore, with each action the user takes (Thumbs Up to select, Thumbs Down to reject, and Arriving at the selected place), the categories of the place in question are given a positive or negative score. If the categories already exist in the database, the category’s score is increased or decreased. Whenever a new Yelp API query is performed, the categories of the results are matched against the category scores in the user’s database. These scores are then adjusted, normalized, and probabilistically sorted. I decided to use a probabilisitic sorting method rather than a purely hierarchical sorting method. The reason is that if the user were to keep using the app in the same location and selecting the suggestion that came up first each time, the first suggestion’s category scores would eventually become so high that the user would never see a different place first. This way, there is always a chance that the user sees a new place, even if it’s not their absolute favorite type of place.

The category scores do not come into play until the [Yelp API’s](https://api.yelp.com) results are returned however. Initially, the recommendation engine must build the query that is submitted to the Yelp API. The API call is largely generated from the user’s settings and location (i.e. time of day, coordinates, price range settings, dietary restrictions, etc.). Once the results are returned, we move forward with the category score sorting.

This is the basic idea behind how the recommendation engine works. I will not divulge the exact implementation details behind the algorithms here but perhaps I will explore them further in future blog posts.

## Smooth, reachable design
The “brain” behind the recommendations would be useless without a visually appealing user interface to display results. The focus for developing the interface of FoodEase relied on creating a relatively fresh design that can easily be used with one hand, regardless of screen size. All main actions within FoodEase can be performed by constraining any touches to the bottom half of the screen. This is especially helpful in the context that this app would mainly be used: while navigating a busy street to reach a destination.

<table class=“centered”>
  <tr>
    <td><a href="{{site.url}}/images/foodease_main.png"><img src="{{site.url}}/images/foodease_main.png" width="200" alt="Main Screen"></a></td>
    <td><a href="{{site.url}}/images/foodease_map.png"><img src="{{site.url}}/images/foodease_map.png" width="200" alt="Map Screen"></a></td>
    <td><a href="{{site.url}}/images/foodease_settings.png"><img src="{{site.url}}/images/foodease_settings.png" width="200" alt="Settings Screen"></a></td>
  </tr>
</table>

### Designed for reachability
I was especially pleased with my initial decision to pursue a reachable design (circa February 2017) when [iPhone X was announced](https://www.apple.com/newsroom/2017/09/the-future-is-here-iphone-x/) in Fall 2017. The new phone boasts a much taller screen than users are used to (at least non-Plus users). The reaction buttons fall in the perfect zone to reach in a one-handed fashion—not too high up but not too low either. The toolbar icons would be the next most used buttons, and they fall along the bottom edge of the screen (no pesky hamburger menus in the upper corners). The map button, which would be the most used toolbar button, can actually be replaced by swiping down anywhere on the *entire* main screen. This is very convenient for one-handedness. Once on the map screen, the user can return to the main screen by swiping up from the bottom panel (or tapping it) and all of the map manipulation buttons are easily accessible at the bottom left. Inside the slide-up views from the main screen (e.g. Settings or Details) I have implemented a simple, subtle feature which goes a long way to improving one-handed accessibility: the “Done” button is located at the *bottom* of the screen, not the top where it’s usually found. Moreover, this dismissive “Done” button is available on any of these modal screens, no matter how deep in the navigation hierarchy the user is. This makes it very easy for the user to return to the main screen (which can sometimes be a point of confusion inside modal views).

## The road ahead
### Short Term
I have already begun collecting feedback from users since the app launched. The main near-term focus is adding some more basic features while improving the intuitiveness of the UI. I’m considering adding an on-boarding flow displaying how to interact with the Thumbs Up/Down buttons and explaining the basic elements of the app.  I’ve heard complaints that it is not clear that the Thumbs Up/Down buttons need to be held for a duration of time rather than simply tapped. User experience flaws such as these are difficult to predict in the development phase, as I am constantly iterating and using the design myself. Improving the discoverability of features is definitely something I intend to continue as I receive more user feedback.
### Long Term
The ultimate goal for this app is to provide the user with the perfect suggestion 100% of the time, and then providing an elegant experience to navigate to such a place. Of course, with any machine learning based solution, it is almost certainly impossible to achieve such accuracy. However, there are definitely ways to try to get as close to 100%, and it is definitely possible to provide an immersive navigation experience once the user has selected a place. These define my long term goals, and the way we get there is to increase the number of settings, include as many variables as possible (without intruding on user privacy) to determine what places are presented, allow the engine to update based on user actions, and maximize algorithm performance so the user can be on their way quickly. Once the perfect place has been suggested, the user should be able to request a ride or navigate to said place, easily and without leaving the app. That would be the ultimate FoodEase experience.

## Conclusion
If you made it this far through the blog post, I give you my thanks for choosing to experience a slice of this journey with me. This was my first time publishing a major piece of software online and I hope this post shed some light on my thoughts and ideas as it happened. I invite you to send me *your* thoughts about this story or the app on [Twitter](https://twitter.com/dilorenzopl) or by [email](mailto:paolo@dilorenzo.pl).

If FoodEase sounds like something you would enjoy using, please [download it on the App Store](https://foodease.xyz/download), leave a rating & review, and tell a friend!

