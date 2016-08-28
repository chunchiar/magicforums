postsChannelFunctions = () ->

  checkMe = (comment_id, username) ->
    unless $('meta[name=admin]').length > 0 || $("meta[user=#{username}]").length > 0
      $("#comment-#{comment_id} .control-panel").remove()
    #//$("#main-comment-#{comment_id}").removeClass("hidden")

  if $('.comments.index').length > 0
    App.posts_channel = App.cable.subscriptions.create {
      channel: "PostsChannel"
    },
    connected: () ->
      console.log("user logged in");

    disconnected: () ->
      console.log("user logged out");

    received: (data) ->

      console.log(data)

      switch data.type
        when "create" then createComment(data)
        when "update" then updateComment(data)
        when "destroy" then destroyComment(data)

    createComment = (data) ->
      if $('.comments.index').data().id == data.post.id
        $('#comments').prepend(data.partial)
        checkMe(data.comment.id, data.username)

    updateComment = (data) ->
      $("#comment-#{data.comment.id}").after(data.partial).remove();
      checkMe(data.comment.id, data.username)

    destroyComment = (data) ->
      $("#comment-#{data.comment.id}").remove();
      checkMe(data.comment.id, data.username)



$(document).on 'turbolinks:load', postsChannelFunctions
