
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%
String agmtexist=request.getParameter("agmtexist")==null?"0":request.getParameter("agmtexist");
String agmtno=request.getParameter("agmtno")==null?"0":request.getParameter("agmtno");
String cldocno=request.getParameter("cldocno")==null?"0":request.getParameter("cldocno");
%>
<script type="text/javascript">
$(document).ready(function() {
$("#searchdrvlicensedate").jqxDateTimeInput({  width:'125px',height : '15px', formatString : "dd.MM.yyyy",value:null});
$('#btnsearchdriver').click(function(){

	var driverdocno=$('#searchdrvdocno').val();
	var driverlicense=$('#searchdrvlicense').val();
	var driverlicensedate=$('#searchdrvlicensedate').jqxDateTimeInput('val');
	var drivername=$('#searchdrvname').val();
	var drivermobile=$('#searchdrvmobile').val();
	var agmtexist='<%=agmtexist%>';
	var agmtno='<%=agmtno%>';
	var cldocno='<%=cldocno%>';
	$('#searchdriverdiv').load('driverSearchGrid.jsp?driverdocno='+driverdocno+'&driverlicense='+driverlicense+'&driverlicensedate='+driverlicensedate+'&drivername='+drivername+'&drivermobile='+drivermobile+'&id=1&agmtexist='+agmtexist+'&cldocno='+cldocno+'&agmtno='+agmtno);
});
});


</script>
</head>	
<body>
	<table width="100%" border="0">
  		<tr>
            <td width="14%" align="right">Doc No</td>
            <td width="14%"><input type="text" name="searchdrvdocno" id="searchdrvdocno"></td>
            <td width="20%" align="right">Driver Name</td>
            <td colspan="4"><input type="text" name="searchdrvname" id="searchdrvname" style="width:99%;"></td>
        </tr>
  		<tr>
            <td align="right">License No</td>
            <td><input type="text" name="searchdrvlicense" id="searchdrvlicense"></td>
            <td align="right">License Expiry</td>
            <td width="15%"><div id="searchdrvlicensedate" name="searchdrvlicensedate"></div></td>
            <td width="11%" align="right">Mobile</td>
            <td width="16%"><input type="text" name="searchdrvmobile" id="searchdrvmobile"></td>
            <td width="10%" align="center"><button type="button" name="btnsearchdriver" id="btnsearchdriver" class="myButton">Search</button></td>
  		</tr>
  		<tr>
    		<td colspan="7"><div id="searchdriverdiv"><jsp:include page="driverSearchGrid.jsp"></jsp:include></div></td>
    	</tr>
  		
	</table>
</body>
</html>