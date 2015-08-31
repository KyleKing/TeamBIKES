# Cron scheduling experimentation
# Based on demo from: http://richsilv.github.io/meteor/scheduling-events-in-the-future-with-meteor/

@StartReservationCountdown = (ID, Bike) ->
  # [today, now] = CurrentDay()
  now = new Date()
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
      parser.text 'at 2:01 am'
      # parser.recur().on(Task.date)
    job: ->
      RemoveReservation Task.ID
      console.log Task.date
      # ClearTaskBackups(ID)

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