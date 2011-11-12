(function($){     
  function popup(obj) {
    var maskHeight = $(document).height();  
    var maskWidth = $(window).width();
    var scrollTop = $(document).scrollTop();
    if(typeof(obj) == 'object') {
      var dialogTop =  scrollTop + 100;
      var dialogLeft = (maskWidth/2) - (obj.width()/2);
      $('#dialog-overlay').css({height:maskHeight, width:maskWidth}).show();
      obj.css({top:dialogTop, left:dialogLeft}).show();
    } else if (typeof(obj) == 'string') {
      $('#dialog-message-box .dialog-message').html(obj);
      var dialogTop =  scrollTop + 100;
      var dialogLeft = (maskWidth/2) - ($('#dialog-message-box').width()/2);
      $('#dialog-overlay').css({height:maskHeight, width:maskWidth}).show();
      $('#dialog-message-box').css({top:dialogTop, left:dialogLeft}).show();
    }

    $('a.dialog-close-button, #dialog-overlay').bind('click', function () {		
      $('#dialog-overlay, .dialog-box').hide();		
      $(this).unbind('click');
      return false;
    });
  }

  jQuery.mdlg_box = function(message){
    popup(message);
  };

  jQuery.fn.mdlg_box = function(){
    if ($(this).length == 0) return;
    function clickHandler() {
      href = this.href;
      var url    = window.location.href.split('#')[0];
      var target = href.replace(url,'');
      popup($(target));
      return false;
    }
    return this.bind('click.mdlg_box', clickHandler);
  };

  jQuery.fn.mdlgresize = function(){
    var maskHeight = $(document).height();  
    var maskWidth = $(window).width();
    var scrollTop = $(document).scrollTop();
    var dialogTop =  scrollTop + 100;
    var dialogLeft = (maskWidth/2) - ($('.dialog-box').width()/2); 
    $('#dialog-overlay').css({height:maskHeight, width:maskWidth}).show();
    $(this).css({top:dialogTop, left:dialogLeft}).show();
  };

	$(window).resize(function () {
    $('.dialog-box').each(function(){
      if(!$(this).is(':hidden')) $(this).mdlgresize();
    });
	});	

	$('a.dialog-close-button, #dialog-overlay').click(function () {		
		$('#dialog-overlay, .dialog-box').hide();		
		return false;
	});
})(jQuery); 
