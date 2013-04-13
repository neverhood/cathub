# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#

$.api.likes =
    init: ->
        $('div#posts div.post div.like-bar').show()
        $('div#posts div.post div.like-bar-js-required').hide()

        $('div#posts a.like, div#posts a.unlike').bind 'ajax:beforeSend', ->
            $this = $(this)
            container = $(this).parent()
            currentLikesDom = container.find('span.current-likes-count')
            currentLikesCount = parseInt(currentLikesDom.text())

            container.find('a.like, a.unlike').toggleClass 'hidden'

            newLikesCount = if $this.hasClass('like') then currentLikesCount + 1 else currentLikesCount - 1
            currentLikesDom.text newLikesCount
