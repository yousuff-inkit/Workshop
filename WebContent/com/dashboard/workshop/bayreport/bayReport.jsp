<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include> 
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="https://fonts.googleapis.com/css?family=Oswald" rel="stylesheet">
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");    
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	 var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	 $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	 getData();
});

function funreload(event)
{
	$('.asd').html('');
	getData();
}
function getData(){
	$("#overlay, #PleaseWait").show(); 
	var fromdate=$('#fromdate').jqxDateTimeInput('val');
	var todate=$('#todate').jqxDateTimeInput('val');
	var branch=$('#cmbbranch').val();
 	var x = new XMLHttpRequest();
 	x.onreadystatechange = function() {
 		if (x.readyState == 4 && x.status == 200) {
 			var items = x.responseText.trim();
 			if(items==""){
 				getInitData();
 			}
 			else{
 				var htmldata='';
 	 			var oldbay='';
 	 			htmldata+='<tr>';
 	 			for(var i=0;i<items.split(",").length;i++){
 	 				var temp=items.split(",")[i].split("::");
 	 				if(oldbay!=temp[0]){
 				 		if(i>0){
 				 			htmldata+='</td>';
 				 		}
 				 		htmldata+='<td style="vertical-align:top" >';
 				 		htmldata+='<div class="bay-heading"><b>'+temp[0]+'</b></div>';
 				 		if(temp[6]=='1'){
 				 			htmldata+='<div class="bay-data delay-class"><ul><li><b>Fleet No&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b>&nbsp;&nbsp;'+temp[1]+'</li><li><b>Reg No&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b>&nbsp;&nbsp;'+temp[8]+'</li><li><b>Fleet Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b>&nbsp;&nbsp;'+temp[7]+'</li><li><b>In Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b>&nbsp;&nbsp;'+temp[2]+'</li><li><b>In Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b>&nbsp;&nbsp;'+temp[3]+'</li><li><b>Est Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b>&nbsp;&nbsp;'+temp[9]+'</li><li><b>Est Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b>&nbsp;&nbsp;'+temp[4]+'</li><li><b>Used Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b>&nbsp;&nbsp;'+temp[5]+'</li></ul></div>';
 				 		}
 				 		else{
 				 			htmldata+='<div class="bay-data"><ul><li><b>Fleet No&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b>&nbsp;&nbsp;'+temp[1]+'</li><li><b>Reg No&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b>&nbsp;&nbsp;'+temp[8]+'</li><li><b>Fleet Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b>&nbsp;&nbsp;'+temp[7]+'</li><li><b>In Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b>&nbsp;&nbsp;'+temp[2]+'</li><li><b>In Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b>&nbsp;&nbsp;'+temp[3]+'</li><li><b>Est Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b>&nbsp;&nbsp;'+temp[9]+'</li><li><b>Est Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b>&nbsp;&nbsp;'+temp[4]+'</li><li><b>Used Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b>&nbsp;&nbsp;'+temp[5]+'</li></ul></div>';
 				 		}
 				 		
 				 	}
 				 	else{
 				 		if(temp[6]=='1'){
 				 			htmldata+='<div class="bay-data delay-class"><ul><li><b>Fleet No&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b>&nbsp;&nbsp;'+temp[1]+'</li><li><b>Reg No&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b>&nbsp;&nbsp;'+temp[8]+'</li><li><b>Fleet Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b>&nbsp;&nbsp;'+temp[7]+'</li><li><b>In Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b>&nbsp;&nbsp;'+temp[2]+'</li><li><b>In Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b>&nbsp;&nbsp;'+temp[3]+'</li><li><b>Est Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b>&nbsp;&nbsp;'+temp[9]+'</li><li><b>Est Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b>&nbsp;&nbsp;'+temp[4]+'</li><li><b>Used Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b>&nbsp;&nbsp;'+temp[5]+'</li></ul></div>';	
 				 		}
 				 		else{
 				 			htmldata+='<div class="bay-data"><ul><li><b>Fleet No&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b>&nbsp;&nbsp;'+temp[1]+'</li><li><b>Reg No&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b>&nbsp;&nbsp;'+temp[8]+'</li><li><b>Fleet Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b>&nbsp;&nbsp;'+temp[7]+'</li><li><b>In Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b>&nbsp;&nbsp;'+temp[2]+'</li><li><b>In Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b>&nbsp;&nbsp;'+temp[3]+'</li><li><b>Est Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b>&nbsp;&nbsp;'+temp[9]+'</li><li><b>Est Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b>&nbsp;&nbsp;'+temp[4]+'</li><li><b>Used Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b>&nbsp;&nbsp;'+temp[5]+'</li></ul></div>';
 				 		}
 				 	}
 				 	oldbay=temp[0];
 	 			}
 	 			htmldata+='</tr>';
 	 		
 	 			$('.asd').append(htmldata);		
 			}
 		
 			$("#overlay, #PleaseWait").hide(); 
 			clearInterval(interval);
 			//clearInterval(interval2);
 			timer=60;
 			$('.timer').text(timer);
 			interval = setInterval(function() {funreload()},60000);
 		} else {
 			}
 		}
 		x.open("GET", "getBayData.jsp?fromdate="+fromdate+"&todate="+todate+"&branch="+branch, true);
 		x.send();
  }
function getInitData(){
 	var x = new XMLHttpRequest();
 	x.onreadystatechange = function() {
 		if (x.readyState == 4 && x.status == 200) {
 			var items = x.responseText.trim();
 			var htmldata='';
 			var oldbay='';
 			htmldata+='<tr>';
 			for(var i=0;i<items.split(",").length;i++){
 				var temp=items.split(",")[i];
		 		if(i>0){
		 			htmldata+='</td>';
		 		}
			 	htmldata+='<td style="vertical-align:top;overflow:auto;" >';
			 	htmldata+='<div class="bay-heading"><b>'+temp+'</b></div>';
			 	if(i==(items.split(",").length-1)){
			 		htmldata+='</td>';
			 	}
 			}
 			htmldata+='</tr>';
 		
 			$('.asd').append(htmldata);
 			
 		} else {
 			}
 		}
 		x.open("GET", "getBayInitData.jsp", true);
 		x.send();
  }
  function setValues(){
	  
  }
  //var timer=60;
  var interval = setInterval(function() {funreload()},60000);
  var timer = 60;

  var interval2 = setInterval(function() {
      timer--;
      $('.timer').text(timer);
      if (timer === 0) timer = 60;
  }, 1000); 
</script>
<style type="text/css">

@keyframes jackInTheBox {
    0% {
        opacity: 0;
        transform: scale(.1) rotate(30deg);
        transform-origin: center bottom
    }
    50% {
        transform: rotate(-10deg)
    }
    70% {
        transform: rotate(3deg)
    }
    100% {
        opacity: 1;
        transform: scale(1)
    }
}

.jackInTheBox {
    animation-name: jackInTheBox
}

	.bay-heading{
        width: 180px;
        height: auto;
        border-radius: 5px;
background: #74ebd5;  /* fallback for old browsers */
background: -webkit-linear-gradient(to right, #ACB6E5, #74ebd5);  /* Chrome 10-25, Safari 5.1-6 */
background: linear-gradient(to right, #ACB6E5, #74ebd5); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */

        text-align: center;
        padding:15px 25px 15px 25px; 
        box-shadow: 0 10px 20px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.23);
       font-size:12px; 
       color:#fff;
    }
    .bay-heading a{
        color: #fff;
        text-transform: capitalize;
        text-align: center;
        text-decoration: none;
        
        
    }
    .bay-data.delay-class{
    	background: #f857a6;  /* fallback for old browsers */
background: -webkit-linear-gradient(to right, #ff5858, #f857a6);  /* Chrome 10-25, Safari 5.1-6 */
background: linear-gradient(to right, #ff5858, #f857a6); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */

    }
    .bay-data.delay-class ul li{
    	color:#fff;
    }
    .bay-data{
        width: 200px;
        padding:15px 25px 15px 5px; 
        border-radius: 5px;
        box-shadow: 0 10px 20px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.23);
        font-size:8.5px; 
    	transition:all 0.5s ease-in;
    	background-color:#fff;
    	margin-bottom:8px;
    	animation-name: jackInTheBox;
    	animation-duration:1s;
    }
    .bay-data:hover{
    	transform:scale(1.5);
    }
    .bay-data ul {
        list-style: none;
        padding-left: 10px;
    }
    .bay-data ul li{
        text-align: left;  		
    }

.hidden-scrollbar {
   overflow: auto; 
  height: 560px;   
} 

.reload-class{
	text-align:center;
	text-transform:uppercase;
	font-family: 'Oswald', sans-serif;
}
.timer{
	font-family: 'Oswald', sans-serif;
	font-weight:bold;
	color:#000;
	animation:number 1s ease-in;
	animation-iteration-count:infinite;
	/* animation-duration:1s; */
}   
@-webkit-keyframes number {
	0%{
		-webkit-transform: scale(0.5); opacity: 0;
	}
	25%{
		-webkit-transform: scale(0.5); opacity: 0;
	}
	50%{
		-webkit-transform: scale(1); opacity: 1;
	}
	75%{
		-webkit-transform: scale(0.5); opacity: 1;
	}
	100%{
		-webkit-transform: scale(0.2); opacity: 0;
	}
}
	/* from {-webkit-transform: scale(0.2); opacity: 0;}
	to {  -webkit-transform: scale(1); opacity: 1;}} */ 
</style>
</head>
<body onload="getBranch();setValues();">
<form id="frmBayReport" action="" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table   >
<tr>
<td width="20%" style="vertical-align:top">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

 <tr><td><label class="branch">From Date</label></td><td><div id="fromdate"></div></td></tr>
 <tr><td><label class="branch">To Date</label></td><td><div id="todate"></div></td></tr>
 <tr><td colspan="2" align="center"> <span class="reload-class"> reloading in</span><div class="timer">60</div><span class="reload-class" style="font-size:10px;">seconds</span></td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr>
 <tr><td colspan="2"><br><br><br><br><br><br><br><br><br><br><br><br><br><br></td></tr>	
	</table>
	</fieldset>
</td>
<td width="80%" style="vertical-align:top">
	<table class="asd">
	</table>
</td>

		
</tr>
</table>
</div>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
</div>
</form>
</body>
</html>