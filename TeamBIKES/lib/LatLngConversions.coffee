# Source: http://www.johndcook.com/blog/2009/04/27/converting-miles-to-degrees-longitude-or-latitude/

# Distances are measured in miles.
# Longitudes and latitudes are measured in degrees.
# Earth is assumed to be perfectly spherical.

earth_radius = 3960.0
earth_radius_meters = 6371*1000
degrees_to_radians = Math.PI / 180.0
radians_to_degrees = 180.0 / Math.PI

@convert_meters_to_miles = (meters) ->
  factor = 1609.344
  meters / factor
@convert_meters_to_meters = (meters) ->
  meters

@change_in_latitude = (miles) ->
  # "Given a distance north, return the change in latitude."
  (miles / earth_radius) * radians_to_degrees
@change_in_longitude = (latitude, miles) ->
  # "Given a latitude and a distance west, return the change in longitude."
  # Find the radius of a circle around the earth at given latitude.
  # r = earth_radius * Math.cos latitude * degrees_to_radians
  # (miles / r) * radians_to_degrees
  # If both x/y coordinates are from equator...
  (miles / earth_radius) * radians_to_degrees

@change_in_latitude_meters = (meters) ->
  # "Given a distance north, return the change in latitude."
  (meters / earth_radius_meters) * radians_to_degrees
@change_in_longitude_meters = (latitude, meters) ->
  # "Given a latitude and a distance west, return the change in longitude."
  # If both x/y coordinates are from equator...
  (meters / earth_radius_meters) * radians_to_degrees