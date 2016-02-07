@RackNames = new Mongo.Collection 'racknames'
@OuterLimit = new Mongo.Collection 'outerlimit'

@XbeeData = new Mongo.Collection 'XbeeData'

# Cron scheduling
@FutureTasks = new Meteor.Collection('future_tasks')
