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
		 
			var techName=document.getElementById("techname").value;
			var check = 1;
			
		getdata(techName,check);
	}
	function getdata(techName,check){
		 $("#technicianSearchGridDiv").load('technicianSearchGrid.jsp?technicianName='+techName.replace(/ /g, "%20")+'&check='+check);
	} 

</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td align="right" style="font-size:9px;">Name</td>
    <td colspan="2"><input type="text" name="techname" id="techname" style="width:100%;height:20px;" value='<s:property value="techname"/>'></td>
    <td width="49%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadDataSearch()"></td>
  </tr>
  <tr>
     <td colspan="5"><div id="technicianSearchGridDiv"><jsp:include page="technicianSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>