<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <link rel="stylesheet" type="text/css" href="<%=contextPath%>/css/body.css">
<script>

</script>
</head>
<body onload="" bgcolor="white">
	<div id="mainBG" class="homeContent" data-type="background">
		<%-- <jsp:include page="../../../../../header.jsp"></jsp:include> --%> <br/> 
		<form>
    		<div style="background-color:white;">
    			<table width="100%" border="0">
				  <tr>
				    <td width="33%"><img src="<%=contextPath%>/icons/carfarehead1.jpg" width="100%" height="149" alt=""/></td>
				    <td width="38%" align="center"><img src="<%=contextPath%>/icons/carfarehead2.png" width="100%" height="140" alt=""/></td>
				    <td width="29%"><img src="<%=contextPath%>/icons/carfarehead3.jpg" width="100%" height="147" alt=""/></td>
				  </tr> 
				  <tr>
				    <td width="33%">&nbsp;</td>
				    <td width="38%" align="center"><font size="3"><b><label id="lblprintname" name="lblprintname" ><s:property value="lblprintname"/></label></b></font></td>
				    <td width="29%">TRN:&nbsp;<label id="lblcomptrn" name="lblcomptrn"><s:property value="lblcomptrn"/></label></td>
				  </tr>
				</table>
            </div>
		</form>
	</div>

</body>
</html>
