
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
	
	 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	   $('#clientwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#clientwindow').jqxWindow('close');
	   $('#fleetwindow').jqxWindow({ width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Fleet Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#fleetwindow').jqxWindow('close');
	  
	   $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

		   
	   $('#clientname').dblclick(function(){
	  	    $('#clientwindow').jqxWindow('open');
	   
	       clientSearchContent('clientsearch.jsp?', $('#clientwindow')); 
      });
	   
	   
	    $('#fleet').dblclick(function(){
	  	    $('#fleetwindow').jqxWindow('open');
	   
	       fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow')); 
       });
	
});



function funExportBtn(){
	
	 JSONToCSVCon(dataildata, 'LA Due Date', true);
	   //$("#detailsgrid").jqxGrid('exportdata', 'xls', 'Lease List');
	 }

 
function getfleet(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#fleetwindow').jqxWindow('open');


	 fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow'));    }
	 else{
		 }
	 } 
function fleetSearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 
			 $('#fleetwindow').jqxWindow('open');
		$('#fleetwindow').jqxWindow('setContent', data);

	}); 
	} 
function getclinfo(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#clientwindow').jqxWindow('open');


	 clientSearchContent('clientsearch.jsp?', $('#clientwindow'));    }
	 else{
		 }
	 } 
function clientSearchContent(url) {
 	 //alert(url);
 		 $.get(url).done(function (data) {
 			 
 			 $('#clientwindow').jqxWindow('open');
 		$('#clientwindow').jqxWindow('setContent', data);
 
 	}); 
 	} 
function funreload(event)
{
	 var barchval = document.getElementById("cmbbranch").value;
	 var uptodate = $('#uptodate').val();
	   $("#overlay, #PleaseWait").show();
	  $("#detlist").load("detailsGrid.jsp?barchval="+barchval+"&uptodate="+uptodate+"&cldocno="+document.getElementById("cldocno").value+"&fleet="+document.getElementById("fleet").value);
	
		  
	}


function  funcleardata()
{
	
	document.getElementById("cldocno").value="";
	document.getElementById("fleet").value="";
	document.getElementById("clientname").value="";
	
	
	
	 if (document.getElementById("clientname").value == "") {
		
		 
	        $('#clientname').attr('placeholder', 'Press F3 TO Search'); 
	    }
	 if (document.getElementById("fleet").value == "") {
			
		 
	        $('#fleet').attr('placeholder', 'Press F3 TO Search'); 
	    }
		  }
		


</script>
<style>
.myButtons {
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
}


</style>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	  <tr>
	<td align="right" width="20%"><label class="branch">Up To</label></td>
            <td align="left"><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td>
	</tr> 
	 <tr><td colspan="2"></td></tr>
 <tr><td align="right"><label class="branch">Client</label></td><td align="left"><input type="text" name="clientname" id="clientname" placeholder="Press F3 TO Search" readonly="readonly" onKeyDown="getclinfo(event);" onclick="this.placeholder='' "  style="height:20px;width:70%;" value='<s:property value="clientname"/>'></td></tr> 
  <tr><td align="right"><label class="branch">Fleet</label></td><td align="left"><input type="text" name="fleet" id="fleet"  placeholder="Press F3 TO Search" readonly="readonly"    onkeydown="getfleet(event)" onclick="this.placeholder='' "  style="height:20px;width:70%;" value='<s:property value="fleet"/>' ></td></tr> 
   
	 <tr><td colspan="2"></td></tr>
	 <tr>
	 <td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funcleardata()"></td></tr>
      
	<tr>
	 <tr><td colspan="2"></td></tr>
	 <tr>
	<td colspan="2"><div id='paychaaaaa' style="width: 100% ; align:right; height: 270px;"></div></td> 
	</tr>	
	</table>
	</fieldset>
	
	
	<input type="hidden" name="cldocno" id="cldocno"  style="height:20px;width:70%;" value='<s:property value="cldocno"/>'>
	
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="detlist"><jsp:include page="detailsGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>

</div>
<div id="clientwindow">
   <div ></div>
</div>
<div id="fleetwindow">
   <div ></div>
</div>

</div>
</div>
</body>
</html>
	 