votesChannelFunctions = () ->

  if $('.comments.index').length > 0
    App.votes_channel = App.cable.subscriptions.create {
      channel: "VotesChannel"
    },
    connected: () ->
    disconnected: () ->
    received: (data) ->
      console.log(data)
      $("#comment-#{data.comment_id} .voting-score").html(data.value)

$(document).on 'turbolinks:load', votesChannelFunctions
