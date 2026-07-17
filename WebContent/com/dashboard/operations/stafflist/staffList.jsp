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
	});

	function funreload(event){
			 var branchval = document.getElementById("cmbbranch").value;
			 var type = document.getElementById("cmbtype").value;
			 var check=1;
			 $("#overlay, #PleaseWait").show();
			 
			 $("#staffListDiv").load("staffListGrid.jsp?branchval="+branchval+'&type='+type+'&check='+check);
	}
	
	function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
		  	JSONToCSVCon(data1, 'StaffList', true);
		 } else {
			 $("#staffList").jqxGrid('exportdata', 'xls', 'StaffList');
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
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
    <tr><td colspan="2">&nbsp;</td></tr>
	<tr><td align="right"><label class="branch">Type</label></td>
	<td align="left"><select id="cmbtype" name="cmbtype" style="width:70%;" value='<s:property value="cmbtype"/>'>
    <option value="">--Select--</option><option value="SLM">Sales Man</option><option value="SLA">Sales Agent</option><option value="RLA">Rental Agent</option>
    <option value="DRV">Driver</option><option value="CHK">Check In</option><option value="STF">Staff</option></select></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td style="background-color: #FFEBEB;"></td>
	<td align="left"><label class="branch">Sales Man</label></td></tr>
	<tr><td style="background-color: #FFFFD1;"></td>
	<td align="left"><label class="branch">Sales Agent</label></td></tr>
	<tr><td style="background-color: #FFFAFA;"></td>
	<td align="left"><label class="branch">Rental Agent</label></td></tr> 
	<tr><td style="background-color: #F0FFFF;"></td>
	<td align="left"><label class="branch">Driver</label></td></tr>
	<tr><td style="background-color: #F8E0F7;"></td>
	<td align="left"><label class="branch">Staff</label></td></tr>
	<tr><td style="background-color: #F7F2E0;"></td>
	<td align="left"><label class="branch">Check In</label></td></tr>
    <tr><td colspan="2">&nbsp;</td></tr> 
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="staffListDiv"><jsp:include page="staffListGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>


</div> 
</body>
</html>