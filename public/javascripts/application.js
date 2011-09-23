// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

//setTimeout(function() {;$$(".popup").each(function(value, index) {value.hide();});}, 3000);

function dosomething(e) { alert("dosomething"); return false; }
function popupCenter(url, width, height, name) {
	var left = (screen.width/2)-(width/2);
	var top = (screen.height/2)-(height/2);
	window.open(url, name, "menubar=no,toolbar=no,status=no,width="+width+",height="+height+",toolbar=no,left="+left+",top="+top);
}

jQuery(document).ready(function(){
	jQuery(".popup").click(function(){
		popupCenter(jQuery(this).attr("href"), jQuery(this).attr("data-width"), jQuery(this).attr("data-height"));
		return false;
	});
});


