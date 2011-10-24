// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

//setTimeout(function() {;$$(".popup").each(function(value, index) {value.hide();});}, 3000);

jQuery(function(){$.datepicker.regional['zh-CN']={clearText:'清除',clearStatus:'清除已选日期',closeText:'关闭',closeStatus:'不改变当前选择',prevText:'<上月',prevStatus:'显示上月',prevBigText:'<<',prevBigStatus:'显示上一年',nextText:'下月>',nextStatus:'显示下月',nextBigText:'>>',nextBigStatus:'显示下一年',currentText:'今天',currentStatus:'显示本月',monthNames:['一月','二月','三月','四月','五月','六月','七月','八月','九月','十月','十一月','十二月'],monthNamesShort:['一','二','三','四','五','六','七','八','九','十','十一','十二'],monthStatus:'选择月份',yearStatus:'选择年份',weekHeader:'周',weekStatus:'年内周次',dayNames:['星期日','星期一','星期二','星期三','星期四','星期五','星期六'],dayNamesShort:['周日','周一','周二','周三','周四','周五','周六'],dayNamesMin:['日','一','二','三','四','五','六'],dayStatus:'设置 DD 为一周起始',dateStatus:'选择 m月 d日, DD',dateFormat:'yy-mm-dd',firstDay:1,initStatus:'请选择日期',isRTL:false};$.datepicker.setDefaults($.datepicker.regional['zh-CN']);});
jQuery.ajaxSetup({ 'beforeSend': function(xhr){xhr.setRequestHeader("Accept", "text/javascript")}})
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
})

function insertText(obj,str) {
	obj.focus();
	if (document.selection) {
		var sel = document.selection.createRange();
		sel.text = str;
	} else if (typeof obj.selectionStart == 'number' && typeof obj.selectionEnd == 'number') {
		var startPos = obj.selectionStart,
			endPos = obj.selectionEnd,
			cursorPos = startPos,
			tmpStr = obj.value;
		obj.value = tmpStr.substring(0, startPos) + str + tmpStr.substring(endPos, tmpStr.length);
		cursorPos += str.length;
		obj.selectionStart = obj.selectionEnd = cursorPos;
	} else {
		obj.value += str;
	}
}

function moveEnd(obj){
	obj.focus();
	var len = obj.value.length;
	if (document.selection) {
		var sel = obj.createTextRange();
		sel.moveStart('character',len);
		sel.collapse();
		sel.select();
	} else if (typeof obj.selectionStart == 'number' && typeof obj.selectionEnd == 'number') {
		obj.selectionStart = obj.selectionEnd = len;
	}
}


function dosomething(e) { alert("dosomething"); return false; }
function popupCenter(url, width, height, name) {
	var left = (screen.width/2)-(width/2);
	var top = (screen.height/2)-(height/2);
	window.open(url, name, "menubar=no,toolbar=no,status=no,width="+width+",height="+height+",toolbar=no,left="+left+",top="+top);
}

// popup menu
function popup_menu(){
	$("li.menu").click(function() {
		$("ul.submenu").toggle();
	});
	
	$("ul.submenu").mouseup(function() {
		return false
	});
	$(document).mouseup(function(e) {
		if($(e.target).parent("li.menu").length==0) {
			$("ul.submenu").hide();
		}
	});
}

jQuery(document).ready(function(){
    //jQuery("div#flash_message").fadeOut(5000);
	jQuery(".popup").click(function(){
		popupCenter(jQuery(this).attr("href"), jQuery(this).attr("data-width"), jQuery(this).attr("data-height"));
		return false;
	});
	popup_menu(); // init popup menu
	jQuery("#activity_start_time").datetimepicker();
	jQuery("#activity_end_time").datetimepicker();
	
	jQuery(".tinyman").mouseover(function(){
		$(this).css("background", "#ddd");
	}).mouseout(function(){
		$(this).css("background", "#fff");
	});
  
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

});


