 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath(); %>
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
	$(document).ready(function () {}); 

 	function loadSearch() {

 		var clientsname=document.getElementById("txtclientsname").value;
 		var contactNo=document.getElementById("txtcontactno").value;
 		
		getdata(clientsname,contactNo);
	}
 	
	function getdata(clientsname,contactNo){
		 $("#refreshdiv").load('clientDetailsSearchGrid.jsp?clientname='+clientsname.replace(/ /g, "%20")+'&contactNo='+contactNo+'&check=1');
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="6%" align="right" style="font-size:9px;">Name</td>
    <td width="45%"><input type="text" name="txtclientsname" id="txtclientsname" style="width:100%;height:20px;" value='<s:property value="txtclientsname"/>'></td>
    <td width="17%" align="right" style="font-size:9px;">Contact No.</td>
    <td width="23%"><input type="text" name="txtcontactno" id="txtcontactno" style="width:90%;height:20px;" value='<s:property value="txtcontactno"/>'></td>
    <td width="9%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td colspan="5"><div id="refreshdiv"><jsp:include page="clientDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>