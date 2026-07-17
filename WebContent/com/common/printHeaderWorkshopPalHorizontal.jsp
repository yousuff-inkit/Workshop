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
$(document).ready(function () {
	var path=$("#lblprintpath").val();
	$('#headerimg').attr('src', "<%=contextPath%>"+path); 
});
</script>
</head>
<body onload="" bgcolor="white">
<div id="mainBG" class="homeContent" data-type="background">
<%-- <jsp:include page="../../../../../header.jsp"></jsp:include> --%> <br/> 
<form>
 <div style="background-color:white;">
<table width="100%" class="normaltable">
  <tr>
    <td width="30%" rowspan="5"><img id="headerimg" src="" width="100%"  alt=""/></td>       
    <td width="35%" >&nbsp;<input type="hidden" id="lblprintpath" name="lblprintpath" value='<s:property value="lblprintpath"/>'> </td>     
    <td width="35%"><font size="3"><label id="lblcompname" name="lblcompname" ><s:property value="lblcompname"/></label></font></td>
  </tr>  
  <tr>
    <td width="35%" >&nbsp;</td> 
    <td><b><label id="lblcompaddress" name="lblcompaddress"><s:property value="lblcompaddress"/></label></b></td>
  </tr>  
  <tr>
    <td align="center" ><b><font size="3"><label id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label></font></b></td>
    <td align="left"><b>Tel :</b>&nbsp;<label id="lblcomptel" name="lblcomptel"><s:property value="lblcomptel"/></label></td>
  </tr>  
 <tr>
    <td width="35%" >&nbsp;</td>
    <td align="left"><b>Branch :</b>&nbsp;<label name="lblbranch" id="lblbranch" ><s:property value="lblbranch"/></label></td> 
  </tr> 
  <tr>
     <td width="35%" >&nbsp;</td>  
     <td align="left"><b>TRN :</b>&nbsp;<label id="lblcomptrn" name="lblcomptrn" >100240072700003</label></td>
  </tr> 
  <%-- <tr>
    <td rowspan="2" align="center"><b><font size="2"><label id="lblprintname1" name="lblprintname1"><s:property value="lblprintname1"/></label></font></b></td>
    <td align="left"></td>  
  </tr> --%>  
<tr>
<td align="left"></td> 
  </tr> 
 <!--  <tr>
  	<td>&nbsp;</td>
  	<td>&nbsp;</td>
    <td align="left"><b>TRN :</b>&nbsp;<label id="lblcomptrn" name="lblcomptrn" >100317648200003</label></td>
  </tr> -->
  <tr>
    <td colspan="3"><hr noshade size=1 width="100%"></td>
  </tr>
   <tr>
    <td colspan="3"></td></tr></table></div>

</form>
</div>

</body>
</html>
