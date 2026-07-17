 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%--   <jsp:include page="../../../../includes.jsp"></jsp:include>   --%> 
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<style>
.textdetail {
	color: black;
	background-color: #E0ECF8;
	width: 100%;
	font-family: Tahoma;
	font-size: 10px;
}
</style>

	<script type="text/javascript">
	$(document).ready(function () {
	
	}); 

 	function mainloadSearch() {
 		
 		var sclname=document.getElementById("SCl_name").value;
 		
 		var docno=document.getElementById("docno").value;
 		
 		
 		  var branchval = document.getElementById("cmbbranch").value; 
	
		getdata(sclname,docno,branchval);

	}
	 function getdata(sclname,docno,branchval){
		 $("#srefreshdiv").load('agreementDetailsSearchGrid.jsp?sclname='+sclname+'&docno='+docno+'&branchval='+branchval);
		}
 
	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr >
   <td>
   <table >
   <tr>
    <td align="left" width="6.5%"><label class="textdetail">Name</label></td>
    <td align="left" width="54%"><input type="text" name="SCl_name" id="SCl_name"  style="width:96.5%;height:20px;" value='<s:property value="SCl_name"/>'></td>
     <td align="left" width="7%"><label class="textdetail">Doc No</label></td>
    <td align="left" width="54%"><input type="text" name="docno" id="docno" style="height:20px;" value='<s:property value="docno"/>'>
    <td  align="left">&nbsp;&nbsp;<input type="button" name="mbtnrasearch" id="mbtnrasearch" class="myButton" value="Search"  onclick="mainloadSearch();"></td>
 
    <tr>
    </table>
    </td>
  </tr>
 
 
  <tr>
    <td colspan="8" align="right">
    
    <div id="srefreshdiv">
      
   <jsp:include  page="agreementDetailsSearchGrid.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>