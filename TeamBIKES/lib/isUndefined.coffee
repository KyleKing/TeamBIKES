# Source: http://www.quora.com/What-is-the-best-way-to-check-if-a-property-or-variable-is-undefined
@isUndefined = (value) ->
  typeof value is 'undefined'