Team BIKES
=======

Team BIKES is a MeteorJS web application that manages a customized station less bike share for university campuses. The code has been entirely open sourced and this page describes how to get started using it quickly.

 * User accounts
 * Maps
 * Cool bike icons
 * Gorgeous theme (and it's responsive)
 * Just ride with no handlebars and deploy!

Outline
=======

Everything included in this guide. Click any link to quickly go to the right section or read the getting started section for general information.


Getting started
===============
Note: This guide is written for *nix systems, Windows guide coming soon

### Running the Meteor App

#### Install Meteor
For more information, visit the ([Guide ](http://docs.meteor.com))
```bash
curl https://install.meteor.com | /bin/sh
```
Change to the working directory

```bash
cd testProject/
```
Run Meteor

```bash
meteor
```
Point your browser to [Localhost:3000](http://localhost:3000)

### Connecting with hardware
Note: designed for and Arduino or comparable device

Install NodeJS
Fetch the necessary Node packages. While inside the project folder, run this command:
```bash
npm install
```
While the Meteor app is running, open a new terminal window to run the node application in parallel.
```bash
node node-client.js
```
If you have a comparable device, try downloading the Arduino code from the __ADD FILE LINK HERE__ folder with a demo LED circuit to show functionality. See additional wiring schematics and complete code to replicate the system.
<!--[Default theme template >][template] -->


How it works
------------

Text on Meteor, the app file structure, preprocessors, and packages. Anything else?

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

Misc
====

Attributions
------------

#### Example:
[Photo](http://www.flickr.com/photos/doug88888/2953428679/) taken from Flickr,
licensed under Creative Commons.

Acknowledgements
----------------

#### Example:
© 2013, 2014, Rico Sta. Cruz. Released under the [MIT
License](http://www.opensource.org/licenses/mit-license.php).

**Team BIKES** is authored and maintained by [Kyle King][KK] with help from [Eric Huang][c].

 * [My website](http://kyleking.github.io) (kyleking.github.io)
 * [Github](http://github.com/KyleKing) (@KyleKing)
 * [Twitter](http://twitter.com/Kyle4Miles) (@Kyle4Miles)
 * [Linkedin](https://www.linkedin.com/pub/kyle-king/57/4/8b7) (Kyle King)

<!-- Links stored as variables -->

[KK]: http://ricostacruz.com
[c]:   http://github.com/kyleking/teambikes/contributors

[template]: https://github.com/rstacruz/flatdoc/raw/gh-pages/templates/template.html
