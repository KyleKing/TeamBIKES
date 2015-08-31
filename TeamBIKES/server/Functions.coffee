@RemoveReservation = (ID) ->
  # Init vars
  [today, now] = CurrentDay()
  # Count number of reserved bikes under this user
  count = DailyBikeData.find({Tag: ID, Day: today}).count()
  # Make all reserved bikes available
  DailyBikeData.update { Tag: ID}, {$set: Tag: 'Available' }, multi: true
  # Remove associated cron/backup task from queue to reduce server function
  ClearTaskBackups ID
  # Alert test environment of progress
  console.log 'Updated: ' + count + ' bike tags'
  count