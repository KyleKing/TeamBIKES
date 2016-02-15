@RackNames = new Mongo.Collection 'racknames'
@OuterLimit = new Mongo.Collection 'outerlimit'

@XbeeData = new Mongo.Collection 'XbeeData'

# Cron scheduling
@FutureTasks = new Meteor.Collection 'future_tasks'

# @FutureTask = Astro.Class(
#   name: 'FutureTask'
#   collection: FutureTasks
#   fields:
#     Bike:
#       type: 'number'
#       validator: Validators.and [
#         Validators.number()
#         Validators.gt(0)
#         Validators.lte(100)
#       ]
# )
