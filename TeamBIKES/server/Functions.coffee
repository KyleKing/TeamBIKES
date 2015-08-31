@RemoveReservation = (ID) ->
  [today, now] = CurrentDay()
  count = DailyBikeData.find({Tag: ID, Day: today}).count()
  if count == 1
  	# thisID = DailyBikeData.findOne({Tag: ID, Day: today})._id
  	DailyBikeData.update { Tag: ID}, {$set: Tag: 'Available' }
  	ClearTaskBackups(ID)
  else
	  DailyBikeData.update { Tag: ID}, {$set: Tag: 'Available' }, multi: true
  console.log 'Updated: ' + count + ' bike tags'
  count