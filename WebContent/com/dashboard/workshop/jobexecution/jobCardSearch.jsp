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
		 
		 $("#searchjcdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
		
	}); 
	
	 function loadDataSearch() {
		 
			 var date=$('#searchjcdate').jqxDateTimeInput('val');
			 var reftype=document.getElementById("reftype").value;
			 var name=document.getElementById("clname").value;
			var check = 1;
		
			getdata(date,check,reftype,name);
	}
	function getdata(date,check,reftype,name){
		 $("#jobcardSearchGridDiv").load('jobCardSearchGrid.jsp?date='+date+'&check='+check+'&reftype='+reftype+'&clname='+name);
	} 

</script>
<body>
<div id=search>
<table width="100%" border="0">
  <tr>
    <td width="9%" align="right" style="font-size:9px;">Date</td>
    <td width="26%"><div id="searchjcdate" name="searchjcdate"></div></td>
    <td width="11%" align="right" style="font-size:9px;">Ref Type</td>
    <td width="36%"><input type="text" style="height: 18px;" name="reftype" id="reftype"  value='<s:property value="reftype"/>'></td>
    <td width="18%" rowspan="2" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadDataSearch()"></td>
  </tr>
  <tr>
    <td align="right" style="font-size:9px;">Client</td>
    <td colspan="3"><input type="text" style="height: 18px; width: 77%;" name="clname" id="clname"  value='<s:property value="clname"/>'></td>
  </tr>
</table>

<table width="100%">
  <tr>
     <td ><div id="jobcardSearchGridDiv"><jsp:include page="jobCardSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>