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
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
</style>
	<script type="text/javascript">
	$(document).ready(function () {
	}); 

 	function loadVendorSearch() {
 		
 		var docno=document.getElementById("vndsearchdocno").value;
 		var clientname=document.getElementById("vndsearchname").value;
 		var mobile=document.getElementById("vndsearchmobile").value;
 		var email=document.getElementById("vndsearchemail").value;
	
		
	
		getdata(docno,clientname,mobile,email);
 

	}
	function getdata(docno,clientname,mobile,email){
		
		 $("#refreshdiv").load("vendorSearchGrid.jsp?docno="+docno+"&clientname="+clientname+"&mobile="+mobile+"&email="+email+"&id=1");
	
		}

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%">
  <tr>
    
    <td width="17%" align="right" style="font-size:9px;">Doc No.</td>
    <td width="23%"><input type="text" name="vndsearchdocno" id="vndsearchdocno" style="width:90%;height:18px;" value='<s:property value="vndsearchdocno"/>'></td>
    <td width="6%" align="right" style="font-size:9px;">Name</td>
    <td width="45%"><input type="text" name="vndsearchname" id="vndsearchname" style="width:100%;height:18px;" value='<s:property value="vndsearchname"/>'></td>
   </tr>
   <tr>
    <td width="17%" align="right" style="font-size:9px;">Mobile No.</td>
    <td width="23%"><input type="text" name="vndsearchmobile" id="vndsearchmobile" style="width:90%;height:18px;" value='<s:property value="vndsearchmobile"/>'></td>
    <td width="6%" align="right" style="font-size:9px;">Email</td>
    <td width="45%"><input type="text" name="vndsearchemail" id="vndsearchemail" style="width:100%;height:18px;" value='<s:property value="vndsearchemail"/>'></td>
   
  <td width="9%" align="center"><input type="button" name="btnvndsearch" id="btnvndsearch" class="myButton" value="Search"  onclick="loadVendorSearch();"></td>
  </tr>
  <tr>
    <td colspan="5"><div id="refreshdiv"><jsp:include  page="vendorSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>

  </div>
</body>
</html>