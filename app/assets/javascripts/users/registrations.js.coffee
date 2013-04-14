$.api.usersRegistrations =
    init: ->
        passwordsToggler = $('a#passwords-container-toggler')
        passwordsContainer = $('div#passwords-container')

        passwordsToggler.bind 'click', (event) ->
            event.preventDefault()
            event.stopPropagation()

            passwordsContainer.slideToggle 'fast'


        if $('div#passwords-container span.help-inline').length > 0
            passwordsContainer.toggle()

        $('input#user_password').val ''
