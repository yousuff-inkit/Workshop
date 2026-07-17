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
.textdetail {
	color: black;
	background-color: #E0ECF8;
	width: 100%;
	font-family: Tahoma;
	font-size: 10px;
}
</style>

	<script type="text/javascript">
	$(document).ready(function () {
		$("#empdate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
		$("#led").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
		
		document.getElementById("txttype").value=document.getElementById("emptype").value;
	}); 

 	function mainloadSearch() {
 		
 		var salesman=document.getElementById("txtsalname").value;
 		var smob=document.getElementById("txtmob").value;
 		var salescode=document.getElementById("txtcode").value;
 		var docno=document.getElementById("txtdocno").value;
 		var date=document.getElementById("empdate").value;
 		var led=document.getElementById("led").value;
	    var type=document.getElementById("txttype").value;
	    
		getdata(salesman,smob,salescode,docno,date,led,type);

	}
	 function getdata(salesman,smob,salescode,docno,date,led,type){
		 $("#refreshdiv").load('employeeDetailsSearchGrid.jsp?salesman='+salesman+'&smob='+smob+'&salescode='+salescode+'&docno='+docno+'&date='+date+'&led='+led+'&type='+type);
		}
 
	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr>
    <td align="right" width="6%"><label class="textdetail">Name</label></td>
    <td align="left" width="40%"><input type="text" name="txtsalname" id="txtsalname"  style="width:96.5%;height:20px;" value='<s:property value="txtsalname"/>'>
    <input type="hidden" name="txttype" id="txttype"  style="height:20px;" value='<s:property value="txttype"/>'></td>
    <td width="4%" align="right"><label class="textdetail">Code</label></td>
    <td align="left"><input type="text" id="txtcode" name="txtcode" style="height:20px;" value='<s:property value="txtcode"/>'> </td>
    <td width="7%" align="right"><label class="textdetail">Mob</label></td>
    <td colspan="2" align="left"><input type="text" name="txtmob" id="txtmob" style="height:20px;" value='<s:property value="txtmob"/>'></td>
    </tr>
  <tr>
    <td align="right" width="6%"><label class="textdetail">Doc No</label></td>
    <td align="left" width=40%><input type="text" name="txtdocno" id="txtdocno" style="height:20px;" value='<s:property value="txtdocno"/>'>
    <td align="right"><label class="textdetail">Date</label></td>
    <td align="left" width="16%"><div id="empdate" name="empdate"  value='<s:property value="empdate"/>'></div>
    <input type="hidden" name="hidempdate" id="hidempdate" value='<s:property value="hidempdate"/>'></td>
    <td align="right"><label class="textdetail">L/C Exp.</label></td>
    <td width="14%" align="left"><div id="led" name="led"  value='<s:property value="led"/>'></div>
    <input type="hidden" name="hidled" id="hidled" value='<s:property value="hidled"/>'></td>
    <td width="13%" colspan="2" align="center"><input type="button" name="mbtnrasearch" id="mbtnrasearch" class="myButton" value="Search"  onclick="mainloadSearch();"></td>
  </tr>
  <tr>
    <td colspan="8" align="right">
    <div id="refreshdiv"><jsp:include  page="employeeDetailsSearchGrid.jsp"></jsp:include></div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>