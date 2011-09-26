KindEditor.ready(function(K) {
	K.create('#kindeditor_id', {
	width: "600px",
	allowFileManager: false,
	allowImageUpload: false,
	allowFlashUpload: false,
	langType: "zh_CN",
    items: ['bold', 'italic', 'forecolor', 'hilitecolor', 'plainpaste', 'wordpaste', 'justifyleft', 'justifycenter', 'justifyright', 'link', 'unlink', 'removeformat', 'image', 'map', 'flash', 'emoticons', 'preview']
	});
});
