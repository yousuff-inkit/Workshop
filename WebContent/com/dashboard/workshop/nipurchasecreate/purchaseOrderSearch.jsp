<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>
<style type="text/css">
#search {
    background-color: #E0ECF8;
}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$("#date").jqxDateTimeInput({width:'125px', height: '15px', formatString:'dd.MM.yyyy'});
		$("#date").jqxDateTimeInput('setDate',null);
	});
	function loadSearch() {

 		var docno=document.getElementById("txtdocno").value;
 		var date=$('#date').jqxDateTimeInput('val');
 		var chk = 1;
 		
		getdata(docno,date,chk);
	}
	function getdata(docno,date,chk){
		 $("#posearchdiv").load('purchaseOrderSearchGrid.jsp?docno='+docno+'&date='+date+'&chk='+chk);
		}
</script>
</head>
<body>
	<div id="search">
		<table width="100%" border="0">
		  <tr>
		    <td width="20%" align="right" style="font-size: 12px;">Date</td>
		    <td width="20%" ><div id="date"></div></td>
		    <td width="20%" align="right" style="font-size: 12px;">Doc No</td>
		    <td width="20%"><input type="number" id="txtdocno" name="txtdocno" style="height: 18px;"></td>
		    <td width="20%" align="center"><input type="button" id="btnSearch" name="btnSearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
		  </tr>
		  <tr>
		  	<td colspan="5"><div id="posearchdiv"><jsp:include page="purchaseOrderSearchGrid.jsp"></jsp:include></div></td>
		  </tr>
		</table>
	</div>
</body>
</html>