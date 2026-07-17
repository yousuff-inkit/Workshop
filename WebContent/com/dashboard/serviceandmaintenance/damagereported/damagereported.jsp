
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<% String contextPath=request.getContextPath();%>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
	$('#attachmaintwindow').jqxWindow({ autoOpen: false,width: '55%', height: '50%',  maxHeight: '70%' ,maxWidth: '78%' , title: '' ,position: { x: 280, y: 120 }, keyboardCloseKey: 27, showCloseButton: true,closeButtonAction:'hide'});   
});

function funreload(event)
{
	 var barchval = document.getElementById("cmbbranch").value;

	  $("#damagediv").load("damagereportedgrid.jsp?barchval="+barchval);
	  document.getElementById("fleetno").value="";
		document.getElementById("docno").value="";
		 $('#attachbtn').attr("disabled",true);	
	
	}
	
function funExportBtn(){
	   $("#damageGrid").jqxGrid('exportdata', 'xls', 'Damage Reported');
	 }
	
function funattachss(){
	
	
	  var fleetno=document.getElementById("fleetno").value;
	  var docno=document.getElementById("docno").value;
	  $("#attachmaintwindow").jqxWindow('setTitle',"VIP - "+document.getElementById("docno").value);
	  $('#attachmaintwindow').jqxWindow('setContent', '');
	  $('#attachmaintwindow').jqxWindow('open');  
	  inspSearchContent("newgrid.jsp?fleetno="+fleetno+"&docno="+docno);
	 }

function inspSearchContent(url) {
	 //$('#vehiclewindow').jqxWindow('open'); 
	 $('#attachmaintwindow').jqxWindow('focus'); 
	 $.get(url).done(function (data) {
	$('#attachmaintwindow').jqxWindow('setContent', data);
	}); 
	 
}

function findis()
{
	document.getElementById("fleetno").value="";
	document.getElementById("docno").value="";
	 $('#attachbtn').attr("disabled",true);	
	}


</script>
</head>
<body onload="getBranch();findis()">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	  <tr>
	
           
	</tr> 
	  <tr><td  align="center" colspan="2"><input type="Button" name="attachbtn" id="attachbtn" class="myButton" value="Attach" onclick="funattachss()"></td> </tr>     
 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 

<!--  <tr><td colspan="2">&nbsp;</td></tr -->

	<tr>
	<td colspan="2"><div id='paychaaaaa' style="width: 100% ; align:right; height: 170px;"></div></td>
	</tr>	
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="damagediv"><jsp:include page="damagereportedgrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
 <input type="hidden" id="fleetno" name="fleetno">
 <input type="hidden" id="docno" name="docno">
</div>
<div id="attachmaintwindow">
<div></div>
</div> 
</div>
</body>
</html>