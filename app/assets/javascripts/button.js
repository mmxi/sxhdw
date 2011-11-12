$(document).ready(function(){
  var buttons = ["blue-button", "green-button", "red-button"];
  $.each(buttons, function(i, v){
    var button_cssname = 'button.' + v;
    var button_hover = v + '-hover';
    var button_active = v + '-active';
    var element = $(button_cssname);
    $(button_cssname).hover(function(){$(this).addClass(button_hover);},function(){$(this).removeClass(button_hover);});
    $(button_cssname).focus(function(){$(this).addClass(button_active); $(this).blur();});
    $(button_cssname).mousedown(function(){$(this).addClass(button_active); $(this).blur;});
    $(button_cssname).mouseup(function(){$(this).removeClass(button_active); $(this).blur();});
    $('a.' + v).mouseup(function(){$(this).removeClass(button_active); $(this).blur();});
  });
});
