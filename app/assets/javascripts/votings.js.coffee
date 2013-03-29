$(document).ready ->
  $('a.vote-link[data-remote]').on 'ajax:beforeSend', (evt, data, status, xhr) ->
    $this = $(this)
    $this.children(".btn").hide()
    $this.children(".btn-pending").show()

  $('a.vote-link[data-remote]').on 'ajax:success', (evt, data, status, xhr) ->
    $this = $(this)
    count = $(this).next(".votings-count")
    $this.children(".btn-pending").hide()

    if ($this.hasClass('action-vote'))
      $this.data("method", "delete")
      $this.removeClass('action-vote')
      $this.addClass('action-unvote')
      $this.children('.btn-unvote, .btn-unvote-hover').removeAttr("style")
      count.html(parseInt(count.html()) + 1)
    else
      if ($this.hasClass('action-unvote'))
        $this.data("method", "post")
        $this.removeClass('action-unvote')
        $this.addClass('action-vote')
        $this.children('.btn-vote, .btn-vote-hover').removeAttr("style")
        count.html(parseInt(count.html()) - 1)
