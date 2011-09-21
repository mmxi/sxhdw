// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

//setTimeout(function() {;$$(".popup").each(function(value, index) {value.hide();});}, 3000);


function popupCenter(url, width, height, name) {
  var left = (screen.width/2)-(width/2);
  var top = (screen.height/2)-(height/2);
  return window.open(url, name, "menubar=no,toolbar=no,status=no,width="+width+",height="+height+",toolbar=no,left="+left+",top="+top);
}
/*
$("a.popup").click(function(e) {
  popupCenter($(this).attr("href"), $(this).attr("data-width"), $(this).attr("data-height"), "authPopup");
  e.stopPropagation(); return false;
});
*/
function dosomething(e) {
    //do something
    Event.stop(e);
}
document.observe("dom:loaded", function() {
  // initially hide all containers for tab content
	setTimeout(function() {;$$(".msg").each(function(value, index) {value.hide();});}, 3000);
	$$(".popup").each(function(element, index) {
		element.observe('click', function(e){
			popupCenter(element.readAttribute("href"), element.readAttribute("data-width"), element.readAttribute("data-height"), "authPopup");
			e.stop();
		});
	});	
});



