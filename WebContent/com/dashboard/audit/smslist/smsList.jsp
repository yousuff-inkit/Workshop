<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

<script type="text/javascript">

$(document).ready(function () {
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
    var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
    var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
    $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
});

	function funreload(event){
		
		
		var fromdate=$('#fromdate').jqxDateTimeInput('val');
		var todate=$('#todate').jqxDateTimeInput('val');
		$("#overlay, #PleaseWait").show();
		$('#smslistdiv').load('smsListGrid.jsp?fromdate='+fromdate+'&todate='+todate+'&id=1');	
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
	<table width="100%"  >
	
		
	<tr><td colspan="2"><jsp:include page="../../heading.jsp"></jsp:include></td></tr>
    <tr><td width="35%" align="right"><label class="branch">From Date</label></td>
	<td width="65%" align="left"><div id="fromdate" name="fromdate"></div></td></tr> 
	<tr>
	  <td align="right"><label class="branch">To Date</label></td>
	  <td><div id="todate" name="todate"></div></td>
	</tr>
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
			 <td><div id="smslistdiv"><jsp:include page="smsListGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>


</div> 
</body>
</html>