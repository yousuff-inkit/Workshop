<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<% String contextPath=request.getContextPath();%>
<!--<link rel="stylesheet" type="text/css" href="../../../css/body.css">-->
<script type="text/javascript">
$(document).ready(function(){
	$("#clientsearchdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null}); 
});
function funSearchClient(){
	var docno=$('#clientsearchdoc').val();
	var name=$('#clientsearchname').val();
	var mobile=$('#clientsearchmobile').val();
	var mail=$('#clientsearchmail').val();
	var date=$('#clientsearchdate').jqxDateTimeInput('val');
	$('#clientsearchdiv').load('clientSearchGrid.jsp?docno='+docno+'&name='+name+'&mobile='+mobile+'&mail='+mail+'&date='+date+'&id=1');
}
</script>
</head>
<body>
<div id="search">
<table width="100%">
  <tr>
    <td width="15%" align="right">Doc No</td>
    <td width="15%"><input type="text" name="clientsearchdoc" id="clientsearchdoc"></td>
    <td width="14%" align="right">Name</td>
    <td colspan="4"><input type="text" name="clientsearchname" id="clientsearchname" style="width:99%;"></td>
  </tr>
  <tr>
    <td align="right">Mobile</td>
    <td><input type="text" name="clientsearchmobile" id="clientsearchmobile"></td>
    <td align="right">Mail</td>
    <td width="16%"><input type="text" name="clientsearchmail" id="clientsearchmail"></td>
    <td width="14%" align="right">Date</td>
    <td width="16%"><div id="clientsearchdate"></div></td>
    <td width="10%" align="center"><button type="button" name="btnclientsearch" id="btnclientsearch" class="myButton" onClick="funSearchClient();">Search</button></td>
  </tr>
  <tr>
    <td colspan="7"><div id="clientsearchdiv"><jsp:include page="clientSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>