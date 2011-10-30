jQuery.ajaxSetup({ 'beforeSend': function(xhr){xhr.setRequestHeader("Accept", "text/javascript")}});

jQuery.fn.topLink = function(settings) {
  settings = jQuery.extend({
    min: 1,
    fadeSpeed: 200
  }, settings);
  return this.each(function() {
    var el = $(this);
    el.hide(); //in case the user forgot
    $(window).scroll(function() {
      if($(window).scrollTop() >= settings.min)
      {
        el.fadeIn(settings.fadeSpeed);
      }
      else
      {
        el.fadeOut(settings.fadeSpeed);
      }
    });
  });
};

jQuery.fn.extend({
  insertAtCaret: function(myValue){
  var obj;
  if( typeof this[0].name !='undefined' ) obj = this[0];
  else obj = this;

  if ($.browser.msie) {
    obj.focus();
    sel = document.selection.createRange();
    sel.text = myValue;
    obj.focus();
    }
  else if ($.browser.mozilla || $.browser.webkit) {
    var startPos = obj.selectionStart;
    var endPos = obj.selectionEnd;
    var scrollTop = obj.scrollTop;
    obj.value = obj.value.substring(0, startPos)+myValue+obj.value.substring(endPos,obj.value.length);
    obj.focus();
    obj.selectionStart = startPos + myValue.length;
    obj.selectionEnd = startPos + myValue.length;
    obj.scrollTop = scrollTop;
  } else {
    obj.value += myValue;
    obj.focus();
   }
 }
});

function init_dropdownmenu(){
  $("ul.dropdown li").hover(function(){
    $(this).addClass("hover");
    $('dl:first',this).css('visibility', 'visible');
    $('ul:first',this).css('visibility', 'visible');
  }, function(){
    $(this).removeClass("hover");
    $('dl:first',this).css('visibility', 'hidden');
    $('ul:first',this).css('visibility', 'hidden');
  });
}

function forumhover() {
  $('.forumnav').hover(function(){
    $(this).addClass('hover');
  }, function(){
    $(this).removeClass('hover');
  });
}

function topichhover() {
  $('.topic').hover(function(){
    $(this).addClass('hover');
  }, function(){
    $(this).removeClass('hover');
  });
}

function popupCenter(url, width, height, name) {
	var left = (screen.width/2)-(width/2);
	var top = (screen.height/2)-(height/2);
	window.open(url, name, "menubar=no,toolbar=no,status=no,width="+width+",height="+height+",toolbar=no,left="+left+",top="+top);
}

function ajaxbind(){
  $(document).bind('ajaxSend', function(e, request, options) {
    if ('POST' == options.type) {
      $('.floading').show();
    } else {
      $('#loading').show();
    }
  });

  $(document).bind('ajaxComplete', function(e, request, options) {
    $('#loading').hide();
    $('.floading').hide();
  });
}

jQuery(document).ready(function(){
  ajaxbind();
  forumhover();
  topichhover();
  init_dropdownmenu();



  $('#top-link').topLink({min: 400, fadeSpeed: 500});
  $('#top-link').click(function(e) {e.preventDefault(); $(document).scrollTop(0);});

	jQuery(".popup").click(function(){
		popupCenter(jQuery(this).attr("href"), jQuery(this).attr("data-width"), jQuery(this).attr("data-height"));
		return false;
	});
});


