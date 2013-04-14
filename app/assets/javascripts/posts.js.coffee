# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$.api.posts =
    init: ->
        $.api.likes.init()


        formToggler   = $('a#new-post-form-toggler')
        formContainer = $('div#new-post-form-container')
        imageModal    = $('div#image-modal')

        formToggler.bind 'click', (event) ->
            event.preventDefault()
            event.stopPropagation()

            formContainer.slideToggle 'fast'

        currentSection = ->
            matches = window.location.search.match(/section=(.*)/)
            if matches? then matches[1] else null

        $('div#posts div.post img.gif-image, div#posts div.post img.gif-animation').click ->
            $(this).parent().find('img.gif-image, img.gif-animation, div.gif-info-overlay').toggleClass 'hidden'

        $('div#posts div.post img.regular-image').click ->
            $this = $(this)
            container = $this.parent()
            largeImage = container.find('img.image-large-version').clone()

            imageModal.find('div#image-container').html(largeImage.removeClass('hidden'))
            imageModal.find('div#author-name').text $this.data('author')
            imageModal.find('div#post-description').text $this.data('description')
            imageModal.modal 'show'

        $('button#close-image-modal, a#close-image-modal').click (event), ->
            event.preventDefault()
            event.stopPropagation()

            imageModal.modal 'hide'

        $('div#media-switch i').click ->
            $this = $(this)
            return if $this.hasClass 'active'

            $this.parent().find('i').toggleClass 'active'
            $('div#video-uploader-container, div#image-uploader-container').toggle()

        $('div#posts a.destroy-post').bind 'ajax:beforeSend', ->
            $(this).parents('div.post').remove()

        $('a#new-post').bind 'click', (event) ->
            if currentSection()?
                $.cookie 'show-new-post-form', 'true', expires: 7, path: '/'
            else
                event.stopPropagation()
                event.preventDefault()

                formContainer.slideDown 'fast'

        if $.cookie('show-new-post-form')? and $.cookie('show-new-post-form') == 'true'
            $.removeCookie 'show-new-post-form', path: '/'
            formContainer.slideDown 'fast'
