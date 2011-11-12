//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require rails.validations
//= reauire rails.validations.custom
//= require mdlgbox
function init_dropdown_menu(){
  $("li.dropdown_menu").hover(function(){
    $(this).addClass("hover");
    $('a.menu_t', this).addClass("menu_hover");
    $('dl:first',this).css('display', 'block');
    $('ul:first',this).css('display', 'block');
  }, function(){
    $(this).removeClass("hover");
    $('a.menu_t', this).removeClass("menu_hover");
    $('dl:first',this).css('display', 'none');
    $('ul:first',this).css('display', 'none');
  });
}

function ajaxbind(){
  $(document).bind('ajaxSend', function(e, request, options) {
    if ('POST' == options.type) {
      $('.floading').show();
    } else {
      $('.loading').show();
    }
  });

  $(document).bind('ajaxComplete', function(e, request, options) {
    $('.loading').hide();
    $('.floading').hide();
  });
}

jQuery(document).ready(function(){
  ajaxbind();
  init_dropdown_menu();
});
