$.api.header =
    init: ->
        signInModal = $('div#sign-in-modal')

        $('a#sign-in').bind 'click', (event) ->
            event.preventDefault()
            event.stopPropagation()

            signInModal.modal 'show'

        $('a#close-sign-in-modal, button#cancel-sign-in-modal').bind 'click', (event) ->
            event.preventDefault()
            event.stopPropagation()

            signInModal.modal 'hide'

        $('a#user-dropdown-toggler').bind 'click', (event) ->
            event.stopPropagation()
            event.preventDefault()

            $('ul#user-dropdown-options').toggle()

