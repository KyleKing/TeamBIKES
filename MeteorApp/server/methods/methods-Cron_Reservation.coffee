# Cron scheduling for reservation system
# Based on demo from: http://richsilv.github.io/meteor/scheduling-events-in-the-future-with-meteor/

StartReservationCountdown = (UserID, Bike) ->
  # Create Task object for queue and create Cron Task
  timeout = 5
  # now = moment().tz('America/New_York').add(timeout, 'minutes').format('h:mm:ss a z')
  future = moment().add(timeout, 'minutes').format()
  CreateTask(UserID, Bike, timeout, future)


CreateTask = (UserID, Bike, timeout, future) ->
  FT = new FutureTask()
  FT.set({
    date: new Date(future) # reformat for cron
    timeout: timeout
    ID: UserID
    Bike: Bike
  })
  FT.save()
  addTask(FT.get('_id'), FT)


addTask = (ID, Task) ->
  SyncedCron.add
    name: 'Destruct Reservation for ' + ID
    schedule: (parser) ->
      # parser.text 'at ' + Task.date
      parser.recur().on(Task.date).fullDate()
    job: ->
      # Remove specified reservation
      RemoveReservation(Task.ID, Task)
      console.log 'Running Cron Job on what should be: ' + Task.date


RemoveReservation = (UserID, Task) ->
  # Make all bikes reserved by this user available
  [today, now] = CurrentDay()
  count = DailyBikeData.find({ Tag: UserID }).count()
  # console.log 'Pre count: ' + count
  DailyBikeData.update { Tag: UserID}, {$set: Tag: 'Available' }, multi: true
  # console.log 'Post count: ' + DailyBikeData.find({ Tag: UserID }).count()
  ClearTaskBackups(UserID, Task)
  # Alert test environment of progress
  console.log 'Removed Reservation for: ' + count + ' bike tags'


ClearTaskBackups = (UserID, Task) ->
  # Remove both queued task and cron task, this allows the task to be run once
  FT = FutureTasks.findOne({ ID: UserID })
  if FT
    try
      FT.remove()
    catch err
      console.warn 'No FutureTask Found' + err
    SyncedCron.remove 'Destruct Reservation for ' + UserID
    console.log 'Cleared: ' + UserID
  # else
  #   console.log 'No FutureTask Found'


Meteor.startup ->
  # Find any tasks stored in database and quickly run triage
  FutureTasks.find().forEach (Task) ->
    console.log '\n~~~ Checking Current list of tasks: ~~~'.lightMagenta
    console.log Task

    # If in the past, make action right away
    if Task.date <= new Date moment().add(Task.timeout, 'minutes')
      if Task.Type is 'Destruct Reservation'
        RemoveReservation(Task.ID)
      else
        ClearTaskBackups(Task.ID)
    # Otherwise reschedule that event
    else
      addTask Task._id, Task

  # Update database every night to make sure
  SyncedCron.add
    name: 'Update DB'
    schedule: (parser) ->
      # parser is a later.parse object
      # At UTC, so subtract 5 hours for my time
      parser.text 'at 06:30'
    job: ->
      [today, now] = CurrentDay()
      info = 'Running CreateDailyBikeData'
      # Check to add a new day's worth of bike data
      Meteor.call 'CreateDailyBikeData', 65, 1
      # Alert Kyle
      previously = DailyBikeData.find({Day: today}).count()
      info = 'CreateDailyBikeData finished. Currently ' +
        DailyBikeData.find({Day: today}).count() + ' were found. Previously ' +
        previously + ' bikes were found.'
  SyncedCron.start()


# Make methods accessible throughout application
Meteor.methods(
  'StartReservationCountdown': StartReservationCountdown
  # 'addTask': addTask
  'CreateTask': CreateTask
  'RemoveReservation': RemoveReservation
  # 'ClearTaskBackups': ClearTaskBackups
)