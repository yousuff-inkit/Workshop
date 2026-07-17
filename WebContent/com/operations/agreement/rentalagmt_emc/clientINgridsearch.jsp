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
	 $("#dr_DOB").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {
 		
 		var clientnamess=document.getElementById("Cl_name").value;
 		var mob=document.getElementById("Cl_mob").value;
 		var lcno=document.getElementById("dr_Licence").value;
 		var passno=document.getElementById("dr_Passport").value;
 		var nation=document.getElementById("dr_Nation").value;
 		var dob=document.getElementById("dr_DOB").value;
 		var idno=document.getElementById("idno").value;
	
		
 		var clname = clientnamess.replace(/ /g, "%20");
		getdata(clname,mob,lcno,passno,nation,dob,idno);
 

	}
	function getdata(clname,mob,lcno,passno,nation,dob,idno){
		 $("#refreshdiv").load('clientinfo.jsp?clname='+clname+'&mob='+mob+'&lcno='+lcno+'&passno='+passno+'&nation='+nation+'&dob='+dob+'&idno='+idno);
	}

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr >
   <td>
   <table>
   <tr>
    <td align="right">Name</td>
    <td align="left" width="73.7%"><input type="text" name="Cl_name" id="Cl_name"  style="width:99%;" value='<s:property value="Cl_name"/>'></td>
    <td align="right">MOB</td>
    <td align="left"><input type="text" name="Cl_mob" id="Cl_mob" value='<s:property value="Cl_mob"/>'></td>
    <td align="right">ID No</td>
    <td align="left"><input type="text" name="idno" id="idno" value='<s:property value="idno"/>'></td>
    <tr>
    </table>
    </td>
  </tr>
  
  <table>
  <tr>
   <td align="right">Licence#</td>
    <td align="left"><input type="text" name="dr_Licence" id="dr_Licence" value='<s:property value="dr_Licence"/>'>
    <td align="right">Passport#</td>
    <td align="left"><input type="text" name="dr_Passport" id="dr_Passport" value='<s:property value="dr_Passport"/>'></td>
    <td align="right">Nationality</td>
    <td align="left"><input type="text" id="dr_Nation" name="dr_Nation" value='<s:property value="dr_Nation"/>'></td>
    
    <td align="right">DOB</td>
    <td align="left"><div id="dr_DOB" name="dr_DOB"  value='<s:property value="dr_DOB"/>'></div>

        <input type="hidden" name="hiddr_DOB" id="hiddr_DOB" value='<s:property value="hiddr_DOB"/>'>
    </td>
    <td colspan="2" align="center"><input type="button" name="btnrasearch" id="btnrasearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  </table>
  </td>

  <tr>
    <td colspan="8" align="right">
    
    <div id="refreshdiv">
      
   <jsp:include  page="clientinfo.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>