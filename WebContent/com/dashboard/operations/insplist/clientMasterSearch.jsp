<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head> 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<style>
.formfont {
	font: 10px Tahoma;
	color: #404040;
	background: transparent;
	overflow:hidden;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
	
	$("#clientdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	//$('body').css('background-color','#E0ECF8');
});

function loadClients(){
	var name=document.getElementById("clients").value;
	var cldocno=document.getElementById("cldocno").value;
	var telephone=document.getElementById("telephone").value;
	var clientdate=$('#clientdate').jqxDateTimeInput('val');
	var mobile=document.getElementById("mobile").value;
	$("#overlay, #PleaseWait").show();
	$('#clientdiv').load('clientSearch.jsp?name='+name+'&cldocno='+cldocno+'&telephone='+telephone+'&clientdate='+clientdate+'&mobile='+mobile+'&id=1');
}


</script>
</head>
<body >
<div style="background-color:#E0ECF8;">
<table width="100%">
  <tr>
    <td width="10%" align="right"><label class="formfont">Name</label></td>
    <td colspan="3" align="left"><input type="text" name="clients" id="clients" style="width:99%;height:18px;"></td>
    <td width="10%" align="right"><label class="formfont">Telephone</label></td>
    <td width="16%" align="left"><input type="text" name="telephone" id="telephone" style="height:18px;"></td>
    
    <td width="13%">&nbsp;</td>
  </tr>
  <tr>
    <td align="right"><label class="formfont">Doc No</label></td>
    <td width="13%" align="left"><input type="text" name="cldocno" id="cldocno" style="height:18px;"></td>
    <td width="25%" align="right"><label class="formfont">Date</label></td>
    <td width="13%" align="left"><div id="clientdate"></div></td>
    <td align="right"><label class="formfont">Mobile</label></td>
    <td align="left"><input type="text" name="mobile" id="mobile" style="height:18px;"></td>
    
    <td align="center"><button type="button" name="btnclientsearch" id="btnclientsearch" class="myButtons" onclick="loadClients();">Search</button></td>
  </tr>
  <tr>
    <td colspan="9"><div id="clientdiv"><jsp:include page="clientSearch.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>