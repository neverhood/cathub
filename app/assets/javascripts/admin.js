// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//
//= require api
//
//= require bootstrap-alert
//= require bootstrap-modal
//= require bootstrap-transition
//
//= require admin/categories
//

$.ajaxSettings.dataType = 'json';

$(window).on('page:fetch', function(event) {
    $.api.admin   = {};
    $.api.loading = true;

    $.api.utils.toggleSpinner();
});

$(window).on('page:restore', function() {
    // History
    if ( $('div#loader').is(':visible') ) {
        $.api.utils.toggleSpinner();

        $.api.loading = false;
    }
});

$(window).on('page:fetch', function() {
});

$(window).bind('page:load load', function(event) {
    $.api.controller     = document.body.id;
    $.api.action         = document.body.attributes['data-action'].value;

    if ( typeof $.api[ $.camelCase($.api.controller) ] === 'object' ) $.api[ $.camelCase($.api.controller) ].init();

    $.api.loading = false
});
