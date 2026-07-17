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

.branchs{
background-color:#E0ECF8 !important;
}
</style>

	<script type="text/javascript">
	$(document).ready(function () {
	
	}); 

 	function mainloadSearch() {
 		
 		var sclname=document.getElementById("SCl_name").value;
 		var smob=document.getElementById("Sl_mob").value;
 		var rno=document.getElementById("rno").value;
 		var flno=document.getElementById("flno").value;
 		var sregno=document.getElementById("sregno").value;
 		var smra=document.getElementById("smra").value;
		var agmttype='<%=request.getParameter("agmttype")==null?"":request.getParameter("agmttype")%>';
		var branch='<%=request.getParameter("branch")==null?"":request.getParameter("branch")%>';
		if(agmttype==''){
			$.messager.alert('Message','Please Select Agreement Type');
			
			return false;
		}
		getdata(sclname,smob,rno,flno,sregno,smra,agmttype,branch);
 

	}
	 function getdata(sclname,smob,rno,flno,sregno,smra,agmttype,branch){
		
		// $("#tariffDivId").load('rateDescription.jsp?txtrentaldocno='+indexVal1+'&revehGroup='+revehGroup);
		
		 $("#srefreshdiv").load('submainSearch.jsp?sclname='+sclname+'&smob='+smob+'&rno='+rno+'&flno='+flno+'&sregno='+sregno+'&smra='+smra+'&agmttype='+agmttype+'&branch='+branch);
		 

		  
/* x.open("GET", "dissearch.jsp?sclname="+sclname+"&smob="+smob+"&rno="+rno+"&flno="+flno+"&sregno="+sregno+"&smra="+smra, true);
		x.send(); */
		}
 
	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr >
   <td>
   <table >
   <tr>
    <td align="right" width=""><label class="branch branchs">Name</label></td>
    <td align="left" width="53%"><input type="text" name="SCl_name" id="SCl_name"  style="width:96.5%;" value='<s:property value="SCl_name"/>' style="height:17px;"></td>
    <td align="right"><label class="branch branchs">MOB</label></td>
    <td align="left"><input type="text" name="Sl_mob" id="Sl_mob" value='<s:property value="Sl_mob"/>' style="height:17px;"></td>
      <td align="right"><label class="branch branchs">MRA</label></td>
    <td align="left"><input type="text" id="smra" name="smra" value='<s:property value="smra"/>' style="height:17px;"> </td>
    <tr>
    </table>
    </td>
  </tr>
 
		
  <table >
  <tr>
 
     <td align="left" width=""><label class="branch branchs">Doc NO</label></td>
    <td align="left" width=><input type="text" name="rno" id="rno" value='<s:property value="rno"/>' style="height:17px;">
    <td width="4%"></td>
    <td align="right"><label class="branch branchs">Fleet NO</label></td>
    
    <td align="left" width="20%"><input type="text" name="flno" id="flno" style="width:96.5%;" value='<s:property value="flno"/>' style="height:17px;"></td>
    <td align="right"><label class="branch branchs">Reg NO</label></td>
    <td align="left"><input type="text" id="sregno" name="sregno" value='<s:property value="sregno"/>' style="height:17px;"></td>
    
    <td colspan="2" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="mbtnrasearch" id="mbtnrasearch" class="myButton" value="Search"  onclick="mainloadSearch();"></td>
  </tr>
  </table>
  </td>

  <tr>
    <td colspan="8" align="right">
    
    <div id="srefreshdiv">
      
   <jsp:include  page="submainSearch.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>