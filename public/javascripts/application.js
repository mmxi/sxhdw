// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

//setTimeout(function() {;$$(".popup").each(function(value, index) {value.hide();});}, 3000);

jQuery(function(){$.datepicker.regional['zh-CN']={clearText:'清除',clearStatus:'清除已选日期',closeText:'关闭',closeStatus:'不改变当前选择',prevText:'<上月',prevStatus:'显示上月',prevBigText:'<<',prevBigStatus:'显示上一年',nextText:'下月>',nextStatus:'显示下月',nextBigText:'>>',nextBigStatus:'显示下一年',currentText:'今天',currentStatus:'显示本月',monthNames:['一月','二月','三月','四月','五月','六月','七月','八月','九月','十月','十一月','十二月'],monthNamesShort:['一','二','三','四','五','六','七','八','九','十','十一','十二'],monthStatus:'选择月份',yearStatus:'选择年份',weekHeader:'周',weekStatus:'年内周次',dayNames:['星期日','星期一','星期二','星期三','星期四','星期五','星期六'],dayNamesShort:['周日','周一','周二','周三','周四','周五','周六'],dayNamesMin:['日','一','二','三','四','五','六'],dayStatus:'设置 DD 为一周起始',dateStatus:'选择 m月 d日, DD',dateFormat:'yy-mm-dd',firstDay:1,initStatus:'请选择日期',isRTL:false};$.datepicker.setDefaults($.datepicker.regional['zh-CN']);});

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
});


