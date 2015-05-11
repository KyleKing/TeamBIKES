Team BIKES
=======

Team BIKES is a MeteorJS web application that manages a customized station less bike share for university campuses. The code has been entirely open sourced and this page describes how to get started using it quickly.

 * User accounts
 * Maps
 * Cool bike icons
 * Gorgeous theme (and it's responsive)
 * Just ride with no handlebars and deploy!

Outline
-------

Everything included in this guide. Click any link to quickly go to the right section or read the getting started section for general information.


Getting started
---------------

# Download and install the necessary tools
> This guide is written for *nix systems, Windows guide coming soon

## Run the general application
> Skip if you already use Meteor and are comfortable in terminal

1. Install Meteor ([Guide ](http://docs.meteor.com))

  ```
  curl https://install.meteor.com | /bin/sh
  ```

2. Change to the working directory

  ```
  cd testProject/
  ```

3. Run Meteor

  ```
  meteor
  ```

4. Point your browser to [Localhost:3000](http://localhost:3000)

## Connect with hardware
> Note: designed for and Arduino or comparable device

1. Install NodeJS
2. While inside the project folder, run: ``` npm install ```
	This fetches necessary Node packages that the Node server depends on
3. In a separate terminal window, run ``` node node-client.js ```
	This starts the node server to listen to serial port communication from connected hardware
4. If you have a comparable device, try downloading the Arduino code from the [Default theme template >][template] folder

How it works
------------

Flatdoc is a hosted `.js` file (along with a theme and its assets) that you can
add into any page hosted anywhere.

#### The mysteries of MeteorJS
> Or why Meteor is the fastest way to develop

...

Customizing
===========

Basic
-----

### Theme options

For the default theme (*theme-white*), You can set theme options by adding
classes to the `<body>` element. The available options are:

#### big-h3
Makes 3rd-level headings bigger.

``` html
<body class='big-h3'>
```

#### no-literate
Disables "literate" mode, where code appears on the right and content text
appear on the left.

``` html
<body class='no-literate'>
```

#### large-brief
Makes the opening paragraph large.

``` html
<body class='large-brief'>
```

### Adding more markup

You have full control over the HTML file, just add markup wherever you see fit.
As long as you leave `role='flatdoc-content'` and `role='flatdoc-menu'` empty as
they are, you'll be fine.

Here are some ideas to get you started.

 * Add a CSS file to make your own CSS adjustments.
 * Add a 'Tweet' button on top.
 * Add Google Analytics.
 * Use CSS to style the IDs in menus (`#acknowledgements + p`).

### JavaScript hooks

Flatdoc emits the events `flatdoc:loading` and `flatdoc:ready` to help you make
custom behavior when the document loads.

``` js
$(document).on('flatdoc:ready', function() {
  // I don't like this section to appear
  $("#acknowledgements").remove();
});
```

Full customization
------------------

You don't have to be restricted to the given theme. Flatdoc is just really one
`.js` file that expects 2 HTML elements (for *menu* and *content*). Start with
the blank template and customize as you see fit.

[Get blank template >][template]

Misc
====

Inspirations
------------

The following projects have inspired Flatdoc.

 * [Backbone.js] - Jeremy's projects have always adopted this "one page
 documentation" approach which I really love.

 * [Docco] - Jeremy's Docco introduced me to the world of literate programming,
 and side-by-side documentation in general.

 * [Stripe] - Flatdoc took inspiration on the look of their API documentation.

 * [DocumentUp] - This service has the same idea but does a hosted readme
 parsing approach.

Attributions
------------

[Photo](http://www.flickr.com/photos/doug88888/2953428679/) taken from Flickr,
licensed under Creative Commons.

Acknowledgements
----------------

© 2013, 2014, Rico Sta. Cruz. Released under the [MIT
License](http://www.opensource.org/licenses/mit-license.php).

**Flatdoc** is authored and maintained by [Rico Sta. Cruz][rsc] with help from its
[contributors][c].

 * [My website](http://ricostacruz.com) (ricostacruz.com)
 * [Github](http://github.com/rstacruz) (@rstacruz)
 * [Twitter](http://twitter.com/rstacruz) (@rstacruz)

[rsc]: http://ricostacruz.com
[c]:   http://github.com/rstacruz/flatdoc/contributors

[GitHub API]: http://github.com/api
[marked]: https://github.com/chjj/marked
[Backbone.js]: http://backbonejs.org
[dox]: https://github.com/visionmedia/dox
[Stripe]: https://stripe.com/docs/api
[Docco]: http://jashkenas.github.com/docco
[GitHub pages]: https://pages.github.com
[fences]:https://help.github.com/articles/github-flavored-markdown#syntax-highlighting
[DocumentUp]: http://documentup.com

[project]: https://github.com/rstacruz/flatdoc
[template]: https://github.com/rstacruz/flatdoc/raw/gh-pages/templates/template.html
[blank]: https://github.com/rstacruz/flatdoc/raw/gh-pages/templates/blank.html
[dist]: https://github.com/rstacruz/flatdoc/tree/gh-pages/v/0.9.0
