window.YTb ||= {}
YTb.App = angular.module('YTapp', [])
App = YTb.App

# Loads youtube API lib
tag = document.createElement("script")
tag.src = "https://www.youtube.com/iframe_api"
firstScriptTag = document.getElementsByTagName("script")[0]
firstScriptTag.parentNode.insertBefore tag, firstScriptTag

# 3. This function creates an <iframe> (and YouTube player)
#    after the API code downloads.
window.onYouTubeIframeAPIReady = ->
  YTb.player = new YT.Player("player",
    height: "390"
    width: "640"
    videoId: "DZ0eMIbkwp8"
    playerVars: {controls: 0}
    events:
      onReady: onPlayerReady
      onStateChange: onPlayerStateChange
  )

# 4. The API will call this function when the video player is ready.
onPlayerReady = (event) ->
  event.target.playVideo()
  setInterval YTb.update, 250

# 5. The API calls this function when the player's state changes.
#    The function indicates that when playing a video (state=1),
#    the player should play for six seconds and then stop.
onPlayerStateChange = (event) ->
  if event.data is YT.PlayerState.PLAYING and not done
    setTimeout stopVideo, 6000
    done = true
stopVideo = ->
  player.stopVideo()
player = undefined
done = false

App.controller "MyVideosCtrl", ["$scope", ($scope) ->

  YTb.update = =>
    $scope.$apply ->
      duration = YTb.player.getDuration()
      progress = YTb.player.getCurrentTime()
      $scope.progress = progress / duration * 100

  $scope.seekTo = (event) ->
    click_position = event.offsetX
    width = $("#scrubber-wrapper").width()
    position = click_position / width * 100

    duration = YTb.player.getDuration()
    position_seconds = duration / 100 * position

    YTb.player.seekTo(position_seconds)


  $scope.progress = 0
  $scope.stop = ->
    YTb.player.stopVideo()
  $scope.play = ->
    YTb.player.playVideo()
  $scope.pause = ->
    YTb.player.pauseVideo()

  $scope.load = (id) ->
    YTb.player.loadVideoById(id)
]