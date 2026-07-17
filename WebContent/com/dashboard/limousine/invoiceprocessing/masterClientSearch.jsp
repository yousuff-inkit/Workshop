
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<script>
$(document).ready(function(e) {
    $('#btnclientsearch').click(function(e) {
        var clientdocno=$('#clientsearchdocno').val();
		var clientname=$('#clientsearchname').val();
		$('#clientsearchdiv').load('clientSearchGrid.jsp?clientdocno='+clientdocno+'&clientname='+clientname+'&id=1');
    });
});
</script>

</head>
<body >
<table width="100%" >
  <tr>
    <td width="12%" align="right"><label class="branch" style="background-color:transparent;">Doc No</label></td>
    <td width="16%"><input type="text" name="clientsearchdocno" id="clientsearchdocno" style="height:18px;"></td>
    <td width="10%" align="right"><label class="branch" style="background-color:transparent;">Name</label></td>
    <td colspan="2"><input type="text" name="clientsearchname" id="clientsearchname" style="width:99%;height:18px;"></td>
    <td width="15%" align="center"><button type="button" name="btnclientsearch" id="btnclientsearch" class="myButton">Search</button></td>
  </tr>
  <tr>
    <td colspan="6"><div id="clientsearchdiv"><jsp:include page="clientSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>

</body>
</html>