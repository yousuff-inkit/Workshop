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
		$("#datess").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy", value:null}); 
	}); 

 	function loadSearch() {
 		var Cl_names=document.getElementById("Cl_names").value;
 		var dates=$("#datess").jqxDateTimeInput('val');
 		var msdocno=document.getElementById("msdocno").value; 
 		var mobile=document.getElementById("mobile").value;
 		var regno=document.getElementById("regno").value;
 		var Cl_namess = Cl_names.replace(' ','%20'); 
 		var refno=document.getElementById("searchrefno").value;
 		refno = refno.replace(' ','%20'); 
 		
	    getdata1(Cl_namess,msdocno,dates,mobile,regno,refno);
			}
 	
	  function getdata1(Cl_namess,msdocno,dates,mobile,regno,refno){
		  
		  var id=1;
		var brhid=$('#brchName').val();
		 $("#refreshdivmas").load('subMastersearch.jsp?Cl_namess='+Cl_namess+'&msdocno='+msdocno+'&dates='+dates+'&mobile='+mobile+'&regno='+regno+'&id='+id+'&refno='+refno+'&brhid='+brhid);
		
		}

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%"  >
  <tr>
   <td>                         
   <table>
   <tr width="100%">
   <td align="right" width="10%">Doc No</td>
    <td align="left" width="20%"><input type="text" name="msdocno" id="msdocno"  value='<s:property value="msdocno"/>'></td>
    <td align="right" width="10%">Name</td>
    <td align="left" width="20%" ><input type="text" name="Cl_names" id="Cl_names"  style="width:85%;" value='<s:property value="Cl_names"/>'></td>
    <td align="right" width="10%">Mobile</td>
    <td align="left" width="20%" ><input type="text" name="mobile" id="mobile"  style="width:85%;" value='<s:property value="mobile"/>'></td>
   
   </tr>
        <tr>
    <td align="right" width="10%" >Date</td>
      <td align="left" width="20%"><div id="datess" name="datess" value='<s:property value="datess"/>'></td>
      <td align="right" width="10%" >Ref No</td>
      <td align="left" width="20%"><input type="text" name="searchrefno" id="searchrefno"  style="width:85%;" value='<s:property value="searchrefno"/>'></td>
       <td align="right" width="10%">REG No.</td>
    <td align="left" width="20%" ><input type="text" name="regno" id="regno"  style="width:85%;" value='<s:property value="regno"/>'></td>
   
  <td width="10%">&nbsp;</td>
  
   <td align="left" width="35"><input type="button" name="btnrasearch" id="btnrasearch" class="myButton" value="Search"  onclick="loadSearch()"></td>
    
    <tr>
    </table>
    </td>
</tr>

  <tr>
    <td colspan="8" align="right">
    
    <div id="refreshdivmas">
      
   <jsp:include  page="subMastersearch.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>