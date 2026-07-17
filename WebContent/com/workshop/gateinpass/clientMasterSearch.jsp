<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Client Search</title>
<script>
	$(document).ready(function(e) {
        $('#btnclientsearch').click(function(){
			var clientdocno=$('#searchclientcldocno').val();
			var clientname=$('#searchclientname').val();
			var clientaddress=$('#searchclientaddress').val();
			var clientmobile=$('#searchclientmobile').val();
			var clientmail=$('#searchclientmail').val();
			$('#clientsearchdiv').load('clientSearchGrid.jsp?id=1&clientdocno='+clientdocno+'&clientname='+clientname+'&clientaddress='+clientaddress+'&clientmobile='+clientmobile+'&clientmail='+clientmail);
			
		});
    });
</script>
</head>
<body>
	<table width="100%" border="0">
  <tr>
    <td width="7%" align="right">Doc No</td>
    <td width="20%"><input type="text" name="searchclientcldocno" id="searchclientcldocno"></td>
    <td width="14%" align="right">&nbsp;</td>
    <td align="right">Name</td>
    <td colspan="4"><input type="text" name="searchclientname" id="searchclientname" style="width:97%;"></td>
    </tr>
  <tr>
    <td align="right">Address</td>
    <td colspan="2"><input type="text" name="searchclientaddress" id="searchclientaddress" style="width:97%;"></td>
    <td width="4%" align="right">Mobile</td>
    <td width="26%"><input type="text" name="searchclientmobile" id="searchclientmobile"></td>
    <td width="5%" align="right">Mail</td>
    <td width="16%"><input type="text" name="searchclientmail" id="searchclientmail"></td>
    <td width="8%"><button type="button" name="btnclientsearch" id="btnclientsearch" >Search</button></td>
  </tr>
  <tr>
    <td colspan="8"><div id="clientsearchdiv" ><jsp:include page="clientSearchGrid.jsp"></jsp:include></div></td>
    </tr>
</table>

</body>
</html>