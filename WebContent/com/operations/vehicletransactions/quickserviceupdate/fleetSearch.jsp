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
	$("#searchdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	});

 	function loadSearch() {
	
		
		
		var docnosearch1=document.getElementById("docnosearch").value;
		var fleetsearch=document.getElementById("fleetsearch").value;
		var regnosearch=document.getElementById("regnosearch").value;
	 	var searchdate=$('#searchdate').jqxDateTimeInput('val');
			getdata(docnosearch1,fleetsearch,regnosearch,searchdate);
		//$("#loadRaSearch").load("gridRaSearch.jsp?item="+items);
	}
	function getdata(docnosearch,fleetsearch,regnosearch,clientsearch,searchdate,mobilesearch){
		//alert(searchdate);
				$("#loadFleetSearch").load("gridFleetSearch.jsp?docno="+docnosearch+"&fleet="+fleetsearch+"&regno="+regnosearch+"&date="+searchdate);
		}

	</script>
	
<body>
<div id=search>
<table width="100%" >
  <tr>
    <td align="right">Doc No</td>
    <td align="left"><input type="text" name="docnosearch" id="docnosearch" value='<s:property value="docnosearch"/>'></td>
    <td align="right">Fleet</td>
    <td align="left"><input type="text" name="fleetsearch" id="fleetsearch" value='<s:property value="fleetsearch"/>'></td>
    <td align="right">Reg No</td>
    <td align="left"><input type="text" name="regnosearch" id="regnosearch" value='<s:property value="regnosearch"/>'></td>
  <td align="right">Date</td>
    <td align="left"><div id="searchdate" name="searchdate" value='<s:property value="searchdate"/>'></div></td>
  </tr>
  <tr>
    <td colspan="8" align="right"><%-- <input type="text" name="clientsearch" id="clientsearch" value='<s:property value="clientsearch"/>'> --%>      <%-- <input type="text" name="mobilesearch" id="mobilesearch" value='<s:property value="mobilesearch"/>'> --%>
    <center><input type="button" name="btnrasearch" id="btnrasearch" class="myButton" value="Search"  onclick="loadSearch();"></center></td>
    <input type="hidden" name="hidsearchdate" id="hidsearchdate" value='<s:property value="hidsearchdate"/>'>
    </tr>
  <tr>
    <td colspan="8" align="right"><div id="loadFleetSearch"><jsp:include page="gridFleetSearch.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>