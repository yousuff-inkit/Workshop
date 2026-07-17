<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<script type="text/javascript">
$(document).ready(function() {
	$("#drvdate").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy",value:null });
	
});
function funDrvLoad(){
	var docno=document.getElementById("drvdocno").value;
	var name=document.getElementById("drvname").value;
	var mobile=document.getElementById("drvmobile").value;
	var license=document.getElementById("drvlicense").value;
	var date=$('#drvdate').jqxDateTimeInput('val');
	
	$('#drvsearchdiv').load('driverSearchGrid.jsp?docno='+docno+'&name='+name+'&mobile='+mobile+'&license='+license+'&date='+date+'&id=1');
}
</script>

<body>
<table width="100%">
  <tr>
    <td width="11%" align="right">Doc No</td>
    <td width="16%"><input type="text" name="drvdocno" id="drvdocno"></td>
    <td width="13%" align="right">Name</td>
    <td colspan="3"><input type="text" name="drvname" id="drvname" style="width:100%;"></td>
    <td width="14%">&nbsp;</td>
  </tr>
  <tr>
    <td align="right">Mobile</td>
    <td><input type="text" name="drvmobile" id="drvmobile"></td>
    <td align="right">License</td>
    <td width="20%"><input type="text" name="drvlicense" id="drvlicense"></td>
    <td width="13%" align="right">Date</td>
    <td width="13%"><div id="drvdate" name="drvdate"></div></td>
    <td align="center"><button type="button" name="btndrvsearch" id="btndrvsearch" class="myButton" onclick="funDrvLoad();">Search</button></td>
  </tr>
  <tr>
    <td colspan="7"><div id="drvsearchdiv"><jsp:include page="driverSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</body>
</html>