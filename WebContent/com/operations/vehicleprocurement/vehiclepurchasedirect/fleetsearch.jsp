 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

<script type="text/javascript">
//flnames flno regnos
	
	function loadtSearch() {
		var flnames=document.getElementById("flnames").value;
		

			var flno=document.getElementById("flno").value;
		
			var regnos=document.getElementById("regnos").value;
		
			var check = "load";
	
			getFleetDetails(flnames,flno,regnos,check);
	}
		
	function getFleetDetails(flnames,flno,regnos,check){ 

		 $("#fleetdiv").load("subfleetsearch.jsp?flno="+flno+'&flnames='+flnames.replace(/ /g, "%20")+'&regnos='+regnos+'&check='+check);
	}

</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="10%" align="right">Fleet No</td>
    <td width="30%"><input type="text" name="flno" id="flno" style="width:85%;" value='<s:property value="flno"/>'></td>
    <td width="10%" align="right">Reg No</td>
    <td width="27%"><input type="text" name="regnos" id="regnos" style="width:50%;" value='<s:property value="regnos"/>'>
   
    <td width="23%" rowspan="2" align="center"><input type="button" name="btnfleetSearch" id="btnfleetSearch" class="myButton" value="Search"  onclick="loadtSearch();"></td>
  </tr>
  <tr>
    <td align="right">Fleet Name</td>
    <td colspan="3"><input type="text" name="flnames" id="flnames" style="width:80%;" value='<s:property value="flnames"/>'></td>
  </tr>
  <tr>
    <td colspan="5"><div id="fleetdiv"><jsp:include page="subfleetsearch.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>