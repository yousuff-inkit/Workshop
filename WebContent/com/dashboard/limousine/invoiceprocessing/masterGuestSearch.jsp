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
    $('#btnguestsearch').click(function(e) {
        var guestdocno=$('#guestsearchdocno').val();
		var guestname=$('#guestsearchname').val();
		var guestmobile=$('#guestsearchcontactno').val();
		$('#guestsearchdiv').load('guestSearchGrid.jsp?guestdocno='+guestdocno+'&guestname='+guestname+'&guestmobile='+guestmobile+'&id=1');
    });
});
</script>

</head>
<body >
<table width="100%" >
  <tr>
    <td width="8%" align="right"><label class="branch" style="background-color:transparent;">Doc No</label></td>
    <td width="15%"><input type="text" name="guestsearchdocno" id="guestsearchdocno" style="height:18px;"></td>
    <td width="9%" align="right"><label class="branch" style="background-color:transparent;">Name</label></td>
    <td width="30%"><input type="text" name="guestsearchname" id="guestsearchname" style="width:99%;height:18px;"></td>
    <td width="9%" align="right"><label class="branch" style="background-color:transparent;">Contact No</label></td>
    <td width="19%"><input type="text" name="guestsearchcontactno" id="guestsearchcontactno" style="height:18px;"></td>
    <td width="10%" align="center"><button type="button" name="btnguestsearch" id="btnguestsearch" class="myButton">Search</button></td>
  </tr>
  <tr>
    <td colspan="7"><div id="guestsearchdiv"><jsp:include page="guestSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>

</body>
</html>