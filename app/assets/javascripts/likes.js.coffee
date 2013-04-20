# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#

$.api.likes =
    init: ->
        $('div#posts').on('ajax:beforeSend', 'a.like, a.unlike', ->
            $this = $(this)
            container = $(this).parent()
            currentLikesDom = container.find('span.current-likes-count')
            currentLikesCount = parseInt(currentLikesDom.text())

            container.find('a.like, a.unlike').toggleClass 'hidden'

            newLikesCount = if $this.hasClass('like') then currentLikesCount + 1 else currentLikesCount - 1

            currentLikesDom.slideUp(300, ->
                currentLikesDom.text newLikesCount
                currentLikesDom.slideDown 300
            )

            #currentLikesDom.text newLikesCount
        )
