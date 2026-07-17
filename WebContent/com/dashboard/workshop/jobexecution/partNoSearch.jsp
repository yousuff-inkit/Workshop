 <%@ taglib prefix="s" uri="/struts-tags" %>
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <% String contextPath=request.getContextPath(); 
 %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<style type="text/css">
#search {
    background-color: #E0ECF8;
}
</style>

<script type="text/javascript">

	 $(document).ready(function () {
		 
		
		
	}); 
	
	 function loadDataSearch() {
		 
			var partName=document.getElementById("partnames").value;
			var partNo=document.getElementById("partnos").value;
			var check = 1;
			
		getdata(techName,check);
	}
	function getdata(techName,check){
		 $("#partSearchGridDiv").load('partNoSearchGrid.jsp?partName='+partName.replace(/ /g, "%20")+'&check='+check+'&partNo='+partNo);
	} 

</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td align="right" style="font-size:9px;">Name</td>
    <td><input type="text" name="partname" id="partnames" style="width:100%;height:20px;" value='<s:property value="partname"/>'></td>
    <td align="right" style="font-size:9px;">Part No</td>
    <td><input type="text" name="partno" id="partnos" style="width:100%;height:20px;" value='<s:property value="partno"/>'></td>
    <td width="49%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadDataSearch()"></td>
  </tr>
  <tr>
     <td colspan="5"><div id="partSearchGridDiv"><jsp:include page="partNoSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>