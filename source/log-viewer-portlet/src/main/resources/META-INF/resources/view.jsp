<%@ include file="init.jsp" %>
<style>
<!--
.search-text i.fa{
    position: relative;
    left: -45px;
    font-size: 24px;
}
.fa{
cursor:pointer;
}
.control-label{
 -webkit-touch-callout: none; /* iOS Safari */
    -webkit-user-select: none; /* Safari */
     -khtml-user-select: none; /* Konqueror HTML */
       -moz-user-select: none; /* Firefox */
        -ms-user-select: none; /* Internet Explorer/Edge */
            user-select: none; /* Non-prefixed version, currently
                                  supported by Chrome and Opera */
}

#log-container{
 clear:both;
 height:400px;
 background: #000000;
 margin-top: 15px;
}
.default-Btn{
	border-radius: 3px;
    padding: 10px 20px;
    margin-left: 10px;
	border-color: #fff;
}

.startBtn:disabled{
 background-color:#88C44A;
}

.startBtn {
	background-color: #88C44A;
    color: #fff;
}

button:disabled{
 opacity:0.3;
}
.stopBtn:disabled{
	background-color: #F44E40;
}

.stopBtn {
	background-color: #F44E40;
    color: #fff;
}

.clearBtn {
	background-color: #A0A7AF;
    color: #fff;
}

.allow{
	overflow-y: scroll; 
}

.lockScroll{
  overflow-y:none;
}

.logContainer div{
    display: block;
    word-wrap: break-word;
    color: #158517;
    font-weight:600;
}

.logContainer .button{
display:inline-block;
}

.logContainer .form-group.input-select-wrapper{
	    width: 300px;
    display: inline-block;
    margin-right: 20px;

}
.search-text {
	display: inline-block;
	margin-right: 30px;	
}
.search-text > div {
	display: inline-block;
	width: 250px;
} 
.download-link {
	cursor:pointer;
	display: block;
    color: #099DD9 !important;
    text-decoration: underline !important;
    margin:0px 40px 20px 0px;
}

.header {
	background-color: #f0f1f2;
	bordre-bottom:1px solid #ccc;
}
-->
</style>

<%@ page import="com.ka.logviewer.websocket.LogViewerWebSocket" %>
<div class="logContainer" style="padding:10px 0px 0px 10px">
<div class="header">
<aui:select name="logLevelDropDown" onChange="getAppropriateLoggers()" value="logLevelDropDown">
	 <aui:option value="FATAL">FATAL</aui:option>
	 <aui:option value="ERROR">ERROR</aui:option>
	 <aui:option value="WARN">WARN</aui:option>
	 <aui:option value="INFO">INFO</aui:option>
	 <aui:option value="DEBUG">DEBUG</aui:option>
	 <aui:option value="TRACE">TRACE</aui:option>
	 <aui:option value="ALL">ALL</aui:option>
</aui:select>


	<div class="button">
		<aui:button name="start" cssClass="default-Btn startBtn" value="start" onClick="connect()" />
		<aui:button name="stop" cssClass="default-Btn stopBtn"  value="stop" onClick="disconnect()" />
		<aui:button name="clear" cssClass="default-Btn clearBtn" value="Clear" onClick="clearLogs()" />
		<aui:button name="scrollUnscroll" cssClass="default-Btn" value="Lock ScrollBar"/>
	</div>
	
<!-- 	regex:parth -->

<div class="pull-right search-text">

<aui:input name="searchText" type="text" label="Search Text" placeholder="Search Here"/>
<i class="fa icon-angle-up"></i>
<i class="fa icon-angle-down"></i>
<aui:button name="searchBtn" value="Find"/>
</div>
</div>
<!-- regex:parth -->

<!-- download log file -->
<div>
	<a class="pull-right download-link" id="<portlet:namespace/>genLogFile" download="logfile.log">Download Log File</a>
	<div id="log-container" class="allow"></div>
</div>

<script type="text/javascript">
var allowScrolling=true;
var index=0;
var matchedElements=[];

//download as txtfile logic 
var textFile = null,
	makeTextFile = function (text) {
	    var data = new Blob([text], {type: 'text/plain'});

	    // If we are replacing a previously generated file we need to
	    // manually revoke the object URL to avoid memory leaks.
	    if (textFile !== null) {
	      window.URL.revokeObjectURL(textFile);
	    }
	    textFile = window.URL.createObjectURL(data);

	    return textFile;
	  };

 $("#<portlet:namespace/>genLogFile").on('click',function(){
		 logTxt=$("#log-container").html().replace(/<[^>]*>/g,'');
		 $("#<portlet:namespace/>genLogFile").attr('href',makeTextFile(logTxt));
		 //window.open(makeTextFile(logTxt),'_blank');  
	 });
	   
//highlight logic
	$("#<portlet:namespace/>searchBtn").on('click',function(){
		var myHilitor = new Hilitor("log-container");
		myHilitor.apply($("#<portlet:namespace/>searchText").val());
		//highlight1stinstance & Change its color.
		matchedElements=$("div em");
		$("div em:first").css('background-color','#FF9632');
		$('#log-container').scrollTo($("div em:first"));
		index=0;
	});
	
	
//up down logic
$(".fa.icon-angle-up").on('click',function(e){
	index--;
	if(index<0){
		index=0;
	}
	$("div em").css('background','#FFFF00');
	$('#log-container').scrollTo(matchedElements[index]);
	$(matchedElements[index]).css('background-color','#FF9632');
});


$(".fa.icon-angle-down").on('click',function(e){
	index++;
	if(index>matchedElements.length){
		index=matchedElements.length;
	}
	$("div em").css('background','#FFFF00');
	$('#log-container').scrollTo(matchedElements[index]);
	$(matchedElements[index]).css('background-color','#FF9632');
});


//socket logic 
     var wsocket;      
     function connect() {
   	  	
    	var socketProtocol = "ws://";
    	if(window.location.protocol === "https:") {
    		socketProtocol = "wss://"
    	}
		wsocket = new WebSocket(socketProtocol+window.location.host+"/o/ka");
		wsocket.onopen = onOpen;
       	wsocket.onmessage = onMessage;
       	
       	// Disable start
       	$("#<portlet:namespace/>start").attr('disabled',true);
     }
     function onMessage(evt) {
    	 debugger
        $("#log-container").append("<div>"+evt.data+"</div>");
        if(allowScrolling){
        	$("#log-container").animate({scrollTop: $('#log-container').prop("scrollHeight")}, 500);
        }	
     }
     function onOpen(evt) {
    	 
    	 var logLevel= $("#<portlet:namespace/>logLevelDropDown").val();
    	 if(logLevel == null || logLevel == "") {
    		 logLevel = "INFO";
    	 }
    	 wsocket.send(logLevel);
       	 console.log("CONNECTED");
     }
	function disconnect(){
		if (wsocket) {
          wsocket.close();
		}
		// Enable start
       	$("#<portlet:namespace/>start").attr('disabled',false);
     }
	function getAppropriateLoggers(){
	     disconnect();
	     connect();
	}
	function clearLogs() {
		$("#log-container").html('');
	}
	
	window.onbeforeunload = function(event){
        return confirm("Refreshing the page will terminate the session, Are you sure ?");
    };
    
 // Scroll Lock Unlock Logic
    $("#<portlet:namespace/>scrollUnscroll").on('click',function(){
    	 if(this.textContent.trim()=="Lock ScrollBar"){
    	   this.textContent="Unlock ScrollBar";
    	   allowScrolling=false;
    	  }else{
    	   this.textContent="Lock ScrollBar";
    	   allowScrolling=true;
    	  }
    });	
   
</script>
</div>