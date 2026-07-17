 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<style>
.formfont {
	font: 10px Tahoma;
	color: #404040;
	background: #E0ECF8;
	overflow:hidden;
}
</style>
<%--   <jsp:include page="../../../../includes.jsp"></jsp:include>   --%> 
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

	<script type="text/javascript">
	$(document).ready(function () {
	 $("#dr_DOB").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {
 		
 		var clname=document.getElementById("Cl_name").value;
 		var mob=document.getElementById("Cl_mob").value;
 		var lcno=document.getElementById("dr_Licence").value;
 		var passno=document.getElementById("dr_Passport").value;
 		var nation=document.getElementById("dr_Nation").value;
 		var dob=$('#dr_DOB').jqxDateTimeInput('val');

		getdata(clname,mob,lcno,passno,nation,dob);

	}
	function getdata(clname,mob,lcno,passno,nation,dob){
		
		 $("#refreshdiv").load('clientinfo.jsp?clname='+clname+'&mob='+mob+'&lcno='+lcno+'&passno='+passno+'&nation='+nation+'&dob='+dob+'&mode=1');
	
		}

	</script>
<body bgcolor="#E0ECF8">
<div id="search">
<table width="100%" >
  <tr >
   <td>
   <table>
   <tr>
    <td align="right"><label class="formfont">Name</label></td>
    <td align="left" width="73.7%"><input type="text" name="Cl_name" id="Cl_name"  style="width:99%;height:18px;" value='<s:property value="Cl_name"/>'></td>
    <td align="left"><label class="formfont">MOB</label></td>
    <td align="left"><input type="text" name="Cl_mob" id="Cl_mob" value='<s:property value="Cl_mob"/>'></td>
    <tr>
    </table>
    </td>
  </tr>
  
  <table>
  <tr>
   <td align="right"><label class="formfont">Licence#</label></td>
    <td align="left"><input type="text" name="dr_Licence" id="dr_Licence" value='<s:property value="dr_Licence"/>' style="height:18px;">
    <td align="right"><label class="formfont">Passport#</label></td>
    <td align="left"><input type="text" name="dr_Passport" id="dr_Passport" value='<s:property value="dr_Passport"/>' style="height:18px;"></td>
    <td align="right"><label class="formfont">Nationality</label></td>
    <td align="left"><input type="text" id="dr_Nation" name="dr_Nation" value='<s:property value="dr_Nation"/>' style="height:18px;"></td>
    
    <td align="right"><label class="formfont">DOB</label></td>
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