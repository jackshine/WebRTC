<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<script type="text/javascript" src="../js/initAll.js"></script>
<title>收到视频会议请求</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
<div class='centeralign'>
	是否接受会议请求？
</div>
<div class='rightalign'>
	<input type='button' class="button" value='接受' id='receivevideo' />
	<input type='button' class="greybutton"  id='refusevideo' value='拒绝' />
</div>
<script>
//用户接受请求则调用accept()，用户拒绝则调用refuse()
function GetRequest() {
   var url = location.search; //获取url中"?"符后的字串
   var theRequest = new Object();
   if (url.indexOf("?") != -1) {
      var str = url.substr(1);
      strs = str.split("&");
      for(var i = 0; i < strs.length; i ++) {
         theRequest[strs[i].split("=")[0]]=unescape(strs[i].split("=")[1]);
      }
   }
   return theRequest;
}
var Request = new Object();
Request = GetRequest();
console.log(Request);
var divId = $('#hiddenDivId').val();

var originID=$('#CurrentRemoteUserNameID').val();


var divIdname='chat'+divId;

console.log('divId='+divId);
console.log('originID='+originID);

$('#receivevideo').click(function(){
	var localUserId = $('.pub_banner').attr("userId");
	var remoteMedia = 'video' + divId, localMedia = 'video' + localUserId + '_' + divId;
	com.webrtc.gPeerConnections[originID].gLocalMediaLabel=localMedia;
	com.webrtc.gPeerConnections[originID].gRemoteMediaLabel=remoteMedia;

	var CHAT = $(document.getElementById("Meeting"));
	    CHAT.find("img[id^=bigaudiopicture]").hide();
	$(document).trigger('close.facebox');
	com.webrtc.accept("video",originID);
})
$('#refusevideo').click(function(){
	
	var CHAT = $(document.getElementById("Meeting"));
	
		CHAT.find('.video').removeClass('hidden').attr('src','images/video.png');
		CHAT.find('.audio').removeClass('hidden').attr('src','images/voice.png');
	    CHAT.find('.hang').addClass('hidden');
	    CHAT.find("img[id^=bigaudiopicture]").hide();
	$(document).trigger('close.facebox');
	com.webrtc.refuse(originID);
})
</script>
</body>
</html>
