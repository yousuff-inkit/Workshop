<% String contextPath=request.getContextPath();%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%--  <jsp:include page="../../../../../includes.jsp"></jsp:include> --%>  
<style>
.hidden-scrollbar {
    overflow: auto;
    height: 600px;
}
</style>
<%

String branchsearch=request.getParameter("rentalbranch")==null?"0":request.getParameter("rentalbranch").toString();
%>

	<script type="text/javascript">
	
	
	
	$(document).ready(function () {
	$("#searchdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});

	
	document.getElementById("branchsearch").value='<%=branchsearch%>';
	

	
	});

 	function loadSearch() {
	
 		
 	
 		var branchsearch=document.getElementById("branchsearch").value;
		var docnosearch1=document.getElementById("docnosearch").value;
	
		var fleetsearch=document.getElementById("fleetsearch").value;
		var regnosearch=document.getElementById("regnosearch").value;
		var sclnames=document.getElementById("clientsearch").value;
	 	var searchdate=$('#searchdate').jqxDateTimeInput('val');
	 	
	 	
	 	
	 	//alert("===="+searchdate);
	 	var agmttype=document.getElementById("cmbrentaltype").value;
	
		var mobilesearch=document.getElementById("mobilesearch").value;
		
		var clientsearch = sclnames.replace(/ /g, "%20");
		
/*   if(docnosearch1==null && fleetsearch==null && regnosearch==null && clientsearch==null && agmttype==null && mobilesearch==null && searchdate==null){
 }
 else{  */
		getdata(docnosearch1,fleetsearch,regnosearch,clientsearch,searchdate,mobilesearch,agmttype,branchsearch);
  /* } */ 
	}
 	
	function getdata(docnosearch,fleetsearch,regnosearch,clientsearch,searchdate,mobilesearch,agmttype,branchsearch){
		
				$("#loadAgmtSearch").load("gridAgmtSearch.jsp?agmttype="+agmttype+"&docno="+docnosearch+"&fleet="+fleetsearch+"&regno="+regnosearch+"&client="+clientsearch+"&date="+searchdate+"&mobile="+mobilesearch+"&branchsearch="+branchsearch);
				
		}

	</script>
	<div id="search">
<body>
<table width="100%" >
  <tr>
    <td align="right">Doc No</td>
    <td align="left"><input type="text" name="docnosearch" id="docnosearch" value='<s:property value="docnosearch"/>'></td>
    <td align="right">Fleet</td>
    <td align="left"><input type="text" name="fleetsearch" id="fleetsearch" value='<s:property value="fleetsearch"/>'></td>
    <td align="right">Reg No</td>
    <td align="left"><input type="text" name="regnosearch" id="regnosearch" value='<s:property value="regnosearch"/>'></td>
    <td align="right">License No</td>
    <td align="left"><input type="text" name="licensesearch" id="licensesearch" value='<s:property value="licensesearch"/>'>
    <input type="hidden" name="branchsearch" id="branchsearch" value='<s:property value="branchsearch"/>'>
    </td>
  </tr>
  <tr>
    <td align="right">Client</td>
    <td align="left"><input type="text" name="clientsearch" id="clientsearch" value='<s:property value="clientsearch"/>'></td>
    <td align="right">Date</td>
    <td align="left"><div id="searchdate" name="searchdate" value='<s:property value="searchdate"/>'></div>
</td><input type="hidden" name="hidsearchdate" id="hidsearchdate" value='<s:property value="hidsearchdate"/>'>

    <td align="right">Mobile</td>
    <td align="left"><input type="text" name="mobilesearch" id="mobilesearch" value='<s:property value="mobilesearch"/>'></td>
    <td colspan="2" align="center"><input type="button" name="btnrasearch" id="btnrasearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td colspan="8" align="right"><div id="loadAgmtSearch"><jsp:include page="gridAgmtSearch.jsp"></jsp:include></div></td>
  </tr>
</table>
</body>
</div>
</html>