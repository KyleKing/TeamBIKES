# Template.agency.rendered = ->
#   $ ->
#     $('.typed-element').typed
#       strings: [
#         ' faster'
#         ' smarter'
#         ' cheaper'
#         ' better'
#       ]
#       typeSpeed: 150
#       startDelay: 300
#       backDelay: 500
#     return

#   ###!
#   # Start Bootstrap - Agency Bootstrap Theme (http://startbootstrap.com)
#   # Code licensed under the Apache License v2.0.
#   # For details, see http://www.apache.org/licenses/LICENSE-2.0.
#   ###

#   # jQuery for page scrolling feature - requires jQuery Easing plugin
#   $ ->
#     $('a.page-scroll').bind 'click', (event) ->
#       $anchor = $(this)
#       $('html, body').stop().animate { scrollTop: $($anchor.attr('href')).offset().top }, 1500, 'easeInOutExpo'
#       event.preventDefault()
#       return
#     return
#   # Highlight the top nav as scrolling occurs
#   $('body').scrollspy target: '.navbar-fixed-top'
#   # Closes the Responsive Menu on Menu Item Click
#   $('.navbar-collapse ul li a').click ->
#     $('.navbar-toggle:visible').click()
#     return
#   return

# # ---
# # generated by js2coffee 2.0.4