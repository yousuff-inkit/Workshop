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
	  $("#qutdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null}); 
	}); 

 	function qutloadSearch() {
 		
 		
 		
 		
 		
 		var qutdocno=document.getElementById("qutdocno").value;
 		 var clientnames=document.getElementById("clientname").value;
 		var clmob=document.getElementById("clmob").value;
 		var qutdate=document.getElementById("qutdate").value;
 		var quttype=document.getElementById("quttype").value; 
 		
 		
 		var clientname = clientnames.replace(' ', '%20');
		
	
	getdata1(qutdocno,clientname,clmob,qutdate,quttype);
 
           
	}
	function getdata1(qutdocno,clientname,clmob,qutdate,quttype){
		

		
		 $("#qutrediv").load('qutsubMastersearch.jsp?qutdocno='+qutdocno+'&clientname='+clientname+'&clmob='+clmob+'&qutdate='+qutdate+'&quttype='+quttype);
		
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
    <td align="left" width="2%"><input type="text" name="qutdocno" id="qutdocno"  value='<s:property value="qutdocno"/>'></td>
    <td align="right" >Name</td>
    <td align="left" width="70%" ><input type="text" name="clientname" id="clientname"  style="width:96.5%;" value='<s:property value="clientname"/>'></td>
    <td align="right" >MOB</td>
      <td align="left" width="28%"><input type="text" name="clmob" id="clmob" value='<s:property value="clmob"/>'></td>
      </tr>
      </table>
      <table width="100%">
        <tr> 
        <td align="right" width="4%">Date </td>
    <td align="left" ><div id="qutdate" name="qutdate"  value='<s:property value="qutdate"/>'></div></td>
    <td width="7%" align="right">Type</td><td ><select  name="quttype" id="quttype" style="width:30%;"  value='<s:property value="quttype"/>' >
  <option value="">--select--</option>
  <option value="DIR">Direct</option>
  <option value="CEQ">Enquiry</option>
   </select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   <input type="button" name="qutbtnrasearch" id="qutbtnrasearch" class="myButton" value="Search"  onclick="qutloadSearch()"></td>
    <tr>
    </table>
    </td>
</tr>

  <tr>
    <td colspan="8" align="right">
    
    <div id="qutrediv">
      
   <jsp:include  page="qutsubMastersearch.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>