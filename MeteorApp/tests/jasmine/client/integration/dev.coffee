# describe 'the todo page : page contents', ->
#   it 'should include a page title of \'Todo List\'', ->
#     expect($('title').text()).toEqual 'Todo List'
#     return
#   it 'should include a page heading of \'Todo List\'', ->
#     expect($('h1').text()).toEqual 'Todo List'
#     return
#   it 'should include an unordered list for displaying the tasks', ->
#     expect($('ul').length).toEqual 1

# Edited Sample Code:
# describe 'Player', ->
#   player = undefined
#   song = undefined
#   beforeEach ->
#     player = new Player
#     song = new Song
#   it 'should be able to play a Song', ->
#     player.play song
#     expect(player.currentlyPlayingSong).toEqual song
#     #demonstrates use of custom matcher
#     expect(player).toBePlaying song
#   describe 'when song has been paused', ->
#     beforeEach ->
#       player.play song
#       player.pause()
#     it 'should indicate that the song is currently paused', ->
#       expect(player.isPlaying).toBeFalsy()
#       # demonstrates use of 'not' with a custom matcher
#       expect(player).not.toBePlaying song
#     it 'should be possible to resume', ->
#       player.resume()
#       expect(player.isPlaying).toBeTruthy()
#       expect(player.currentlyPlayingSong).toEqual song
#   # demonstrates use of spies to intercept and test method calls
#   it 'tells the current song if the user has made it a favorite', ->
#     spyOn song, 'persistFavoriteStatus'
#     player.play song
#     player.makeFavorite()
#     expect(song.persistFavoriteStatus).toHaveBeenCalledWith true
