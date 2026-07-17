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
	  $("#bookdates").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null}); 
	}); 

 	function bookloadSearch() {
 		
 		var qutdocno1=document.getElementById("qutdocno").value;
 		 var clientnamess=document.getElementById("clientnames").value;
 		var clmob1=document.getElementById("clmob").value;
 		var qutdate1=document.getElementById("bookdates").value;
 		var quttype1=document.getElementById("quttype").value; 
 		
 	//	alert("clientname"+clientnames);
 	
 	var regno=document.getElementById("regno").value; 
 		
			var clientnames = clientnamess.replace(' ', '%20');
	
	getdata1(qutdocno1,clientnames,clmob1,qutdate1,quttype1,regno);
 

	}
	function getdata1(qutdocno1,clientnames,clmob1,qutdate1,quttype1,regno){
		

		
		 $("#qutrediv").load('bookingsubsearch.jsp?qutdocno='+qutdocno1+'&clientname='+clientnames+'&clmob='+clmob1+'&qutdate='+qutdate1+'&quttype='+quttype1+'&regno='+regno);
		
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
    <td align="right" width="7%">Name</td>
    <td align="left" width="70%" ><input type="text" name="clientnames" id="clientnames"  style="width:96.5%;" value='<s:property value="clientnames"/>'></td>
    <td align="right" >MOB</td>
      <td align="left" width="28%"><input type="text" name="clmob" id="clmob" value='<s:property value="clmob"/>'></td>
      </tr>
      </table>
      <table  >
        <tr> 
        <td width="4%">Date </td>
    <td align="left" width="2%" ><div id="bookdates" name="bookdates"  value='<s:property value="bookdates"/>'></div></td>
    <td width="6%" align="right" >RefType</td><td ><select  name="quttype" id="quttype" style="width:30%;"  value='<s:property value="quttype"/>' >
  <option value="">--select--</option>
   <option value="DIR">Direct</option>
    <option value="QOT">Quotation</option>
    <option value="ONL">Online</option>
   </select> &nbsp;&nbsp;Reg NO&nbsp;
     <input type="text" name="regno" id="regno" style="width:24%;" value='<s:property value="regno"/>'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   <input type="button" name="qutbtnrasearch" id="qutbtnrasearch" class="myButton" value="Search"  onclick="bookloadSearch()"></td>
    <tr>
    </table>
    </td>
</tr>

  <tr>
    <td colspan="8" align="right">
    
    <div id="qutrediv">
      
   <jsp:include  page="bookingsubsearch.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>