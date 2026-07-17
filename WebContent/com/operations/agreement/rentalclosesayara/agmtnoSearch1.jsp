<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<link href="../../../../css/body.css" rel="stylesheet" type="text/css"> 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%--  <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<style>

.hidden-scrollbar {
    overflow: auto;
    height: 600px;
}
</style>
	<script type="text/javascript">
	$(document).ready(function () {
	$("#searchdate2").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	});

 	function loadRentalSearch() {
	
		
		
		var docnosearch1=document.getElementById("docnosearch2").value;
		var fleetsearch=document.getElementById("fleetsearch2").value;
		var regnosearch=document.getElementById("regnosearch2").value;
		var clientsearch=document.getElementById("clientsearch2").value;
	 	var searchdate=$('#searchdate2').jqxDateTimeInput('val');
	 
		var mobilesearch=document.getElementById("mobilesearch2").value;
 
		getdata(docnosearch1,fleetsearch,regnosearch,clientsearch,searchdate,mobilesearch);
	}
	function getdata(docnosearch1,fleetsearch,regnosearch,clientsearch,searchdate,mobilesearch){
		//alert(searchdate);
				$("#loadRentalAgmtSearchDiv").load("gridRaSearch.jsp?docno="+docnosearch1+"&fleet="+fleetsearch+"&regno="+regnosearch+"&client="+clientsearch+"&date="+searchdate+"&mobile="+mobilesearch+"&temp=1");

	}

	</script>
	
<body>
<div id=search>
<table width="100%" >
  <tr>
    <td align="right">Doc No</td>
    <td align="left"><input type="text" name="docnosearch2" id="docnosearch2" value='<s:property value="docnosearch2"/>'></td>
    <td align="right">Fleet</td>
    <td align="left"><input type="text" name="fleetsearch2" id="fleetsearch2" value='<s:property value="fleetsearch2"/>'></td>
    <td align="right">Reg No</td>
    <td align="left"><input type="text" name="regnosearch2" id="regnosearch2" value='<s:property value="regnosearch2"/>'></td>
   <%--  <td align="right">License No</td>
    <td align="left"><input type="text" name="licensesearch" id="licensesearch" value='<s:property value="licensesearch"/>'></td> --%>
  </tr>
  <tr>
    <td align="right">Client</td>
    <td align="left"><input type="text" name="clientsearch2" id="clientsearch2" value='<s:property value="clientsearch2"/>'></td>
    <td align="right">Date</td>
    <td align="left"><div id="searchdate2" name="searchdate2" value='<s:property value="searchdate2"/>'></div>
</td><input type="hidden" name="hidsearchdate2" id="hidsearchdate2" value='<s:property value="hidsearchdate2"/>'>
    <td align="right">Mobile</td>
    <td align="left"><input type="text" name="mobilesearch2" id="mobilesearch2" value='<s:property value="mobilesearch2"/>'></td>
    <td colspan="2" align="center"><input type="button" name="btnrentalsearch" id="btnrentalsearch" class="myButton" value="Search"  onclick="loadRentalSearch();"></td>
  </tr>
  <tr>
    <td colspan="8" align="right"><div id="loadRentalAgmtSearchDiv"><jsp:include page="gridRaSearch.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>