 <%@ taglib prefix="s" uri="/struts-tags" %>
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <% String contextPath=request.getContextPath(); 
 	String status = request.getParameter("status")==null?"0":request.getParameter("status");
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
			 var status='<%=status%>';
			 var date=$('#searchjcdate').jqxDateTimeInput('val');
			 var jobnos=document.getElementById("jobnos").value;
			 var check = 1;
			
			getdata(date,check,status,jobnos);
	}
	function getdata(date,check,status,jobnos){
		 $("#jobcardSearchGridDiv").load('jobCardSearchGrid.jsp?date='+date+'&check='+check+'&status='+status+'&jobnos='+jobnos);
	} 

</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="7%" align="right" style="font-size:9px;">Date</td>
    <td width="13%"><div id="searchjcdate" name="searchjcdate"></div></td>
    <td width="7%" align="right" style="font-size:9px;">Job No</td>
    <td width="13%"><input type="text" style="height: 18px;" name="jobnos" id="jobnos" value='<s:property value="jobnos"/>'></td>
    <td width="49%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadDataSearch()"></td>
  </tr>
  <tr>
     <td colspan="5"><div id="jobcardSearchGridDiv"><jsp:include page="jobCardSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>