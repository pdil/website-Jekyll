---
layout: post
title: Automated 
category: meta
author: Paolo Di Lorenzo
date: 2017-06-20 20:00 -0500
---

My website/blog that you are currently reading is built using the [Jekyll framework](https://jekyllrb.com) and hosted on [Github Pages](https://pages.github.com). Jekyll allows one to define webpage layouts, insert plugins, and automate much of the blog generating process. For example, on my website I have used a [plugin]() that automatically generates all of the [category]({{site.url}}/blog/categories) from the written posts. Similarly blog posts have a predefined layout that is used which allows me to focus on writing the content of each post and not worry about making sure each detail of the site (sidebar, CSS, etc.) is consistent throughout. Jekyll has the added benefit of generating a static HTML webpage from your layouts, stylesheets, plugins, and pages which tend to render much faster since there is no dynamic content.
<br><br>
With this power and flexibility comes a cost: in order to generate the webpages from the various files that are used, I need to run the `jekyll build` command from the root directory. This compiles the files into a static webpage located in the `/_site` folder. The contents of the `/_site` folder are pushed to my dedicated [repository](https://github.com/pdil/_site) on Github which then hosts the website on Github pages. The files used to generate the website are located in the [website-generator](https://github.com/pdil/website-generator) repository.
<br><br>
So how do I build my website if I don't have access to my laptop with the cloned repo and a terminal to use? This might occur when I'm away from home and need to fix a quick typo. Or perhaps I'm traveling and want to submit a post about my experiences. Enter my workflow, which allows me to update my website from any computer with an internet connection, even my iPhone or iPad.

## Automation with Travis CI
[Travis CI](https://travis-ci.org) is a continuous integration platform that is free for open source projects. When it is hooked up to a Github repository, it automatically builds the contents of the repo and runs any custom scripts or tests on the code within. The ability to customize settings and run shell scripts makes Travis CI very powerful in automating tasks.

Here are the steps