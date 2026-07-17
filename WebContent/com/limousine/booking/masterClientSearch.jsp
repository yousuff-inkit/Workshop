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
$("#clientdob").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy",value:null });
});
function funClientSearch(){
var clientdocno=document.getElementById("clientdoc").value;
var clientname=document.getElementById("clientname").value;
var clientmobile=document.getElementById("clientmobile").value;
var clientlicense=document.getElementById("clientlicense").value;
var clientdob=$('#clientdob').jqxDateTimeInput('val');
$('#clientsearchdiv').load('clientSearchGrid.jsp?clientdocno='+clientdocno+'&clientname='+clientname+'&clientmobile='+clientmobile+'&clientlicense='+clientlicense+'&clientdob='+clientdob+'&id=1');
}

</script>
</head>

<body >
<div style="background-color:#E0ECF8;">
<table width="100%">
  <tr>
    <td width="19%" align="right">Doc No</td>
    <td width="14%"><input type="text" name="clientdoc" id="clientdoc" ></td>
    <td width="10%" align="right">Name</td>
    <td colspan="4"><input type="text" name="clientname" id="clientname" style="width:96%;"></td>
  </tr>
  <tr>
    <td align="right">Mobile</td>
    <td><input type="text" name="clientmobile" id="clientmobile"></td>
    <td align="right">License No</td>
    <td width="12%"><input type="text" name="clientlicense" id="clientlicense"></td>
    <td width="14%" align="right">DOB</td>
    <td width="16%"><div id="clientdob"></div></td>
    <td width="15%" align="center"><input type="button" name="btnclientsearch" id="btnclientsearch" value="Search" onClick="funClientSearch();" class="myButton"></td>
  </tr>
  <tr>
    <td colspan="7"><div id="clientsearchdiv"><jsp:include page="clientSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>

</html>