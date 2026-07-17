
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
	
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

	
    
	$('#perfleetSearchwindow').jqxWindow({ width: '30%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Fleet Search' ,position: { x: 600, y: 60 }, keyboardCloseKey: 27});
    $('#perfleetSearchwindow').jqxWindow('close');


});
function fleetSearchContent(url) {
 //alert(url);
	 $.get(url).done(function (data) {
		 
		 $('#perfleetSearchwindow').jqxWindow('open');
	$('#perfleetSearchwindow').jqxWindow('setContent', data);

}); 
}  

function funreload(event)
{
	 var barchval = document.getElementById("cmbbranch").value;

	   $("#overlay, #PleaseWait").show();
 
	  $("#tempdiv").load("templistGrid.jsp?barchval="+barchval);
	
	
	}
	
function funExportBtn(){
	  
	   
	   
		 if(parseInt(window.parent.chkexportdata.value)=="1")
		 {
		 JSONToCSVCon(datss, 'LAG-Temperory Vehicle', true);
		 }
	 else
		 {
		 $("#templistupdategrid").jqxGrid('exportdata', 'xls', 'LAG-Temperory Vehicle');
		 }
		
	   
	   
	   
	   
	 }

</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>

	 <tr><td colspan="2">&nbsp;</td></tr>	

	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>	
	 <tr><td colspan="2">&nbsp;</td></tr> 
	 <tr><td colspan="2">&nbsp;</td></tr> 
	 <tr><td colspan="2">&nbsp;</td></tr>	
	 <tr><td colspan="2">&nbsp;</td></tr> 
	 <tr><td colspan="2">&nbsp;</td></tr>  
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>	
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>	
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
  </table>
  
	 
   </fieldset>

</td>
<td width="80%">
	<table width="100%">
		<tr>
			  <td><div id="tempdiv"><jsp:include page="templistGrid.jsp"></jsp:include></div></td> 
		</tr>
	</table>
</tr>
</table>
</div>
 <div id="perfleetSearchwindow">
	   <div></div>
	</div> 
</div>
</body>
