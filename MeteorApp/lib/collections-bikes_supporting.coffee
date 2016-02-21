@RackNames = new Mongo.Collection 'racknames'
@OuterLimit = new Mongo.Collection 'outerlimit'

@XbeeData = new Mongo.Collection 'XbeeData'

# Cron scheduling
@FutureTasks = new Meteor.Collection 'future_tasks'


# date: new Date(future) # reformat for cron
# timeout: timeout
# ID: ID
# Bike: Bike

@FutureTask = Astro.Class(
  name: 'FutureTask'
  collection: FutureTasks
  fields:
    date:
      type: 'date'
      validator: Validators.and [
      	Validators.date()
      ]
    timeout:
      type: 'number'
    ID:
      type: 'string'
    Bike:
      type: 'number'
)
