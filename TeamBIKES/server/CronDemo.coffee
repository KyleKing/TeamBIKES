# Cron scheduling experimentation
# Based on demo from: http://richsilv.github.io/meteor/scheduling-events-in-the-future-with-meteor/

@StartReservationCountdown = (ID, Bike) ->
  # [today, now] = CurrentDay()
  now = moment().tz('America/New_York').add(1, 'minutes').format('h:mm:ss a z')
  # now = new Date.now()
  Task = {
    date: now
    ID: ID
    Bike: Bike
  }
  thisId = FutureTasks.insert Task
  addTask(thisId, Task)

@addTask = (ID, Task) ->
  SyncedCron.add
    name: 'Destruct Reservation for ' + ID
    schedule: (parser) ->
      # parser is a later.parse object
      # parser.text 'at 2:01 am'
      parser.text 'at ' + Task.date
      # parser.recur().on(Task.date).fullDate()
    job: ->
      RemoveReservation Task.ID
      console.log 'Runnning Cron Job on what should be: ' + Task.date
      ClearTaskBackups(Task.ID)

@ClearTaskBackups = (ID) ->
  FutureTasks.remove
    ID: ID
  SyncedCron.remove 'Destruct Reservation for ' + ID
  console.log 'Cleared: ' + ID
  ID


Meteor.startup ->
  FutureTasks.find().forEach (Task) ->
    console.log Task
    # If in the past, send right away
    if Task.date < new Date
      RemoveReservation Task.ID
      ClearTaskBackups(Task.ID)
    # Otherwise schedule that event
    else
      addTask Task._id, Task
    return

  SyncedCron.add
    name: 'Update DB'
    schedule: (parser) ->
      # parser is a later.parse object
      parser.text 'at 2:01 am'
    job: ->
      PopulateDailyBikeData()
  SyncedCron.start()
  return