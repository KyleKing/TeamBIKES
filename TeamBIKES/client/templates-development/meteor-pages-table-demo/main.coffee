# getRoute = (d) ->
#   if !d
#     d = 0
#   pageNumber = Pages.sess('currentPage') + d
#   if _.isNaN(pageNumber)
#     pageNumber = 1
#   '/items_' + pageNumber

# Template.items.helpers
#   prevLink: _.partial(getRoute, -1)
#   nextLink: _.partial(getRoute, 1)