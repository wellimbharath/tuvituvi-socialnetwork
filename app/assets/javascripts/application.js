//= require jquery
//= require jquery_ujs
//= require semantic-ui
//= require jquery.Jcrop
//= require_tree .

$(document).ready(function() {
    setTimeout(function() {
        $("#flash").fadeOut("fast", function() {
            $(this).remove();
        })
    }, 1000 );
});
