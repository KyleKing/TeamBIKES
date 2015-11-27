FlowRouter.notFound = action: ->
  BlazeLayout.render 'NotFound'

FlowRouter.route '/',
    name: 'About',
    action: ->
      BlazeLayout.render 'Layout', {
        Full: 'About'
      }

Templates = [
  'FAQ'
  'Technology'
  'Company'
  'Map'
]
_.each Templates, (Template) ->
  route = '/' + Template
  FlowRouter.route route,
      name: Template,
      action: ->
        BlazeLayout.render 'Layout', {
          Full: Template
        }


# FlowRouter.route '/pumpyouup',
#   name: 'Eric',
#   action: ->
#     BlazeLayout.render 'layout', {
#       Body: 'Eric'
#       Slide_In_Panel_Title: 'Eric_title'
#       Slide_In_Panel_Content: 'Eric'
#     }

# IDs = [
#   'microfluidics'
#   'bikeshare'
#   'side-project'
#   'Canon'
#   'extensions'
#   '3D_printing'
#   'alumni_cup'
#   'class_projects'
#   'microduino'
#   'NEXT'
# ]

# _.each IDs, (ID) ->
#   route = '/' + ID
#   FlowRouter.route route,
#     name: ID,
#     action: ->
#       BlazeLayout.render 'layout', {
#         Body: 'about'
#         Slide_In_Panel_Title: ID + '_title'
#         Slide_In_Panel_Content: ID
#       }

# %%%%%%%%%%%%%%%%%%%%%%%%%%
ScrollToTop = ->
  # Gotta love a mature programming language: http://stackoverflow.com/questions/9316415/the-same-old-issue-scrolltop0-not-working-in-chrome-safari
  $(window).scrollTop 0

FlowRouter.triggers.enter ScrollToTop
