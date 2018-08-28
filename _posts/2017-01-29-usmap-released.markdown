---
layout: post
title: usmap released
category: data
author: Paolo Di Lorenzo
date: 2017-01-29 22:32 -0500
---

I just released my first R package to <a href="http://cran.r-project.org" target="_blank">CRAN</a>. It's called <a href="http://cran.r-project.org/package=usmap" target="_blank">usmap</a> and can help you create nice US maps for visualizing countrywide data. 

Normally, plotting US maps in R is awkward because Alaska and Hawaii are far from the mainland US. So you either make the rest of the US look small, or omit Alaska and Hawaii entirely.

Here's an example: <br>

<center><img src="{{ site.url }}/images/ugly-usmap.png" alt="Default US map"></center>

Absolutely disgusting.

Let's try using `usmap`:

{% highlight r %}
    library(usmap)
    plot_usmap()
{% endhighlight %}

<center><img src="{{ site.url }}/images/nice-usmap.png" alt="Better US map"></center>

Ah, much better. The map is even drawn using a nicer <a href="https://en.wikipedia.org/wiki/Albers_projection" target="_blank">equal-area projection</a>, rather than the default <a href="https://en.wikipedia.org/wiki/Mercator_projection" target="_blank">Mercator</a> that always seems to be used. You can also plot all the counties of the US with this package and select only certain states/counties to be drawn as well. You can see the county map at the landing page I created for this package by <a href="{{ site.url }}/pkgs/usmap">clicking here</a>.

The `plot_usmap` function returns a <a href="https://github.com/tidyverse/ggplot2" target="_blank">`ggplot`</a> object, which means you can very easily change the colors, titles, labels, etc. of the plot. See the <a href="https://cran.r-project.org/web/packages/usmap/vignettes/mapping.html" target="_blank">mapping vignette</a> for more details.

There are some convenience methods for working with <a href="https://en.wikipedia.org/wiki/FIPS_county_code" target="_blank">FIPS codes</a>, which is how the states and counties in the package are identified.

{% highlight r %}
    fips("NJ")
    fips("NJ", county = "Mercer")
{% endhighlight %}

If you want more information, be sure to check out the <a href="http://github.com/pdil/usmap" target="_blank">Github repository</a> or the vignettes.
{% highlight r %}
    vignette(package = "usmap")
    vignette("introduction", package = "usmap")
    vignette("mapping", package = "usmap")
{% endhighlight %}

Feel free to fork the repository and submit pull requests with feature changes and fixes, I'm open to any suggestions. This package was a learning experience for me in creating R packages and starting an open source project. I look forward to maintaining it going forward and implementing great new features.

<hr>

The code that was used to create these maps was based on this blog post: <a href="https://rud.is/b/2014/11/16/moving-the-earth-well-alaska-hawaii-with-r/" target="_blank">https://rud.is/b/2014/11/16/moving-the-earth-well-alaska-hawaii-with-r/</a>.
