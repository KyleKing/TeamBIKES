# Cron scheduling experimentation
# Based on demo from: http://richsilv.github.io/meteor/scheduling-events-in-the-future-with-meteor/

@StartReservationCountdown = (ID, Bike) ->
  timeout = 1
  # now = moment().tz('America/New_York').add(timeout, 'minutes').format('h:mm:ss a z')
  future = moment().add(timeout, 'minutes').format()
  future = new Date(future) # reformat for cron
  # Create Task object for queue
  Task = {
    date: future
    timeout: timeout
    ID: ID
    Bike: Bike
  }
  # Store in database as backup and add task to Cron queue for direct action
  thisId = FutureTasks.insert Task
  addTask(thisId, Task)


@addTask = (ID, Task) ->
  SyncedCron.add
    name: 'Destruct Reservation for ' + ID
    schedule: (parser) ->
      # parser.text 'at ' + Task.date
      parser.recur().on(Task.date).fullDate()
    job: ->
      # Remove specified reservation
      RemoveReservation Task.ID, Task
      console.log 'Running Cron Job on what should be: ' + Task.date
      # Already included in remove reservation:
      # ClearTaskBackups(Task.ID)

@RemoveReservation = (ID, Task) ->
  # Init vars
  [today, now] = CurrentDay()
  # Count number of reserved bikes under this user
  count = DailyBikeData.find({Tag: ID, Day: today}).count()
  # Make all reserved bikes available
  DailyBikeData.update { Tag: ID}, {$set: Tag: 'Available' }, multi: true
  # Remove associated cron/backup task from queue to reduce server function
  ClearTaskBackups ID, Task
  # Alert test environment of progress
  console.log 'Updated: ' + count + ' bike tags'

@ClearTaskBackups = (ID, Task) ->
  # Remove both queued task and cron task, this allows the task to be run once
  FutureTasks.remove
    ID: ID
  SyncedCron.remove 'Destruct Reservation for ' + ID
  console.log 'Cleared: ' + ID

Meteor.startup ->
  FutureTasks.find().forEach (Task) ->
    console.log 'Checking Current list of tasks:'
    console.log Task

    # day = moment(Task.date, 'h:mm:ss a z')
    # console.log day

    # If in the past, make action right away
    if Task.date <= new Date moment().add(Task.timeout, 'minutes')
      if Task.Type is 'Destruct Reservation'
        RemoveReservation Task.ID
      else
        ClearTaskBackups Task.ID
    # Otherwise reschedule that event
    else
      addTask Task._id, Task

  SyncedCron.add
    name: 'Update DB'
    schedule: (parser) ->
      # parser is a later.parse object
      parser.text 'at 12:01 am'
    job: ->
      # Check to add a new day's worth of bike data
      PopulateDailyBikeData()
  SyncedCron.start()