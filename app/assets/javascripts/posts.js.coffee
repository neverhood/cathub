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

        container = $('div#posts')

        currentSection = ->
            matches = window.location.search.match(/section=(.*)/)
            if matches? then matches[1] else null
        currentSort = ->
            matches = window.location.search.match(/sort=(.*)/)
            if matches? then matches[1] else null

        lastPage = ->
            container.attr('data-last-page') == 'true'

        currentPage = ->
            parseInt( container.attr('data-page') )

        nextPageUrl = ->
            url = "/posts?page=#{currentPage() + 1}"
            if currentSection()? then url += "&section=#{ currentSection() }"
            if currentSort()? then url += "&sort=#{ currentSort() }"
            url

        $('div#posts div.post img.gif-image, div#posts div.post img.gif-animation').click ->
            $(this).parent().find('img.gif-image, img.gif-animation, div.gif-info-overlay').toggleClass 'hidden'

        $('div#posts div.post img.regular-image').click ->
            $this = $(this)
            post  = $this.parent()
            largeImage = post.find('img.image-large-version').clone()

            imageModal.find('div#image-container').html(largeImage.removeClass('hidden'))
            imageModal.find('div#author-name').text $this.data('author')
            imageModal.find('div#post-description').text $this.data('description')
            imageModal.modal 'show'

        $('button#close-image-modal, a#close-image-modal').bind 'click', (event) ->
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
            if $.api.action == 'index'
                if currentSection()?
                    $.cookie 'show-new-post-form', 'true', expires: 7, path: '/'
                else
                    event.stopPropagation()
                    event.preventDefault()

                    formContainer.slideDown 'fast'
            else
                $.cookie 'show-new-post-form', 'true', expires: 7, path: '/'

        if $.cookie('show-new-post-form')? and $.cookie('show-new-post-form') == 'true'
            $.removeCookie 'show-new-post-form', path: '/'
            formContainer.slideDown 'fast'

        if $.api.action == 'index'
            $(document).bind('scroll.posts', ->
                if $.api.loading or lastPage() or not nearBottomOfPage()
                    return false

                $.api.loading = true

                $.getJSON nextPageUrl(), (data) ->
                    $.api.loading = false

                    posts = container
                    posts.append data.entries
                    posts.attr('data-page', currentPage() + 1)
                    posts.attr('data-last-page', data.last)
            ).bind('page:change', ->
                $(this).unbind 'scroll.posts'
            )

