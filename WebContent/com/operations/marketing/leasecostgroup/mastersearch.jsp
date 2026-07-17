
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
	 
 	function loaddata() {
 		
 	 
 		 var docno=document.getElementById("msdocno").value;
 		var gpname=document.getElementById("gpnames").value;
 		var gpnames = gpname.replace(/ /g, "%20");
	
	getdata1(gpnames,docno);
 

	}
	function getdata1(gpnames,docno){
		

		
		 $("#refreshdivmas").load('submastersearch.jsp?gpnames='+gpnames+'&docno='+docno);
		
		}

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr>
   <td>                         
   <table>
   <tr>
   <td align="right" width="10%">Doc No</td>
    <td align="left" width="10%"><input type="text" name="msdocno" id="msdocno"  value='<s:property value="msdocno"/>'></td>
    <td align="right" width="10%">Group Name</td>
    <td align="left" width="70%" ><input type="text" name="gpnames" id="gpnames"  style="width:96.5%;" value='<s:property value="gpnames"/>'></td>
     <td>
   <input type="button" name="loaddata" id="loaddata" class="myButton" value="Search"  onclick="loaddata()"></td>
    <tr>
    </table>
    </td>
</tr>

  <tr>
    <td colspan="8" align="right">
    
    <div id="refreshdivmas">
      
   <jsp:include  page="submastersearch.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>