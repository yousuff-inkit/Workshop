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
	  $("#searchdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null}); 
	}); 

 	function loadSearch1() {

 		var seardate=$("#searchdate").val();
 	  var seartype=document.getElementById("enqtype").value;
 		var seardoc=document.getElementById("msdocno").value; 

 	
	getdata1(seardate,seartype,seardoc);
 

	}
	function getdata1(seardate,seartype,seardoc){
		

		
		 $("#refreshdivmas").load('subMastersearch.jsp?seardate='+seardate+'&seartype='+seartype+'&seardoc='+seardoc);
		
		}

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr>
   <td>                         
   <table>
   <tr>
   <td align="right">Docno</td>
    <td align="left" width="2%"><input type="text" name="msdocno" id="msdocno"  value='<s:property value="msdocno"/>'></td>
    <td align="right" >Date</td>
    <td align="left" width="20%" ><div id="searchdate" name="searchdate"  value='<s:property value="searchdate"/>'></div></td>
    <td align="right" >Type</td>
      <td align="left" width="20%"><select  name="enqtype" id="enqtype" style="width:70%;"  value='<s:property value="enqtype"/>' >
    <option value="traffic">Traffic</option>
       <option value="salik">Salik</option>
   </select>
   </td>
   <td>
    <input type="button" name="mainsearchbtn" id="mainsearchbtn" class="myButton" value="Search"  onclick="loadSearch1()">
   </td>
      </tr>
       
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