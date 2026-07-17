<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<%-- <style type="text/css">
  .firstcol {
    border-right: 1px solid #000;
  }
  .lastcol {
    border-left: 1px solid #000;
  }
   .table {
    border: 1px solid black;
}
  
  th {
    border: 1px solid black;
}
.tablereceipt {

    border: 1px solid #ffebcd;
    border-collapse: collapse;
}
 
</style> --%>

<script type="text/javascript">
/* window.onload= function fun1()
{

window.open("quotprint.pdf", "_self");
 
} */
function hidedata()
{
	
	var first=document.getElementById("firstarray").value;
	var sec=document.getElementById("secarray").value;

	if(parseInt(first)==1)
		{
		   $("#firstdiv").prop("hidden", false);
		}
	else
		{
		$("#firstdiv").prop("hidden", true);
		}
	
	/* if(parseInt(sec)==2)
	{
		  $("#secdiv").prop("hidden", false);
	}
	else
		{
		 $("#secdiv").prop("hidden", true);
		} 
	
	
	
 */
 
 }
</script>
</head>
<body bgcolor="white" style="font-size:10px;" onload="hidedata();">
<!-- <div id="mainBG" class="homeContent" data-type="background"> -->
<form id="frmqotPrint" action="prqotInvoice" autocomplete="off" target="_blank">
<%-- <jsp:include page="../../../../../header.jsp"></jsp:include> --%> <br/> 

 <div style="background-color:white;">
<table width="100%" class="normaltable">
  <tr>
    <td width="20%" rowspan="6"><img src="<%=contextPath%>/icons/epic.jpg" width="120" height="91"  alt=""/></td> 
    <td width="44%" rowspan="2">&nbsp;</td>
    <td width="36%" style="font:10px;font-weight:bold;font-family:sans-serif;"><label id="lblcompname" name="lblcompname" ><s:property value="lblcompname"/></label></td>
  </tr>
  <tr>
    <td style="font:10px;font-weight:bold;font-family:sans-serif;"><label id="lblcompaddress" name="lblcompaddress"><s:property value="lblcompaddress"/></label></td>
  </tr>
  <tr>
    <td rowspan="2"  align="center" style="font:20px;font-weight:bold;"><label id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label></td>
    <td align="left"><label style="font:10px;font-weight:bold;font-family:sans-serif;">Tel :&nbsp;</label><label id="lblcomptel" name="lblcomptel"><s:property value="lblcomptel"/></label></td>
  </tr>
  <tr>
    <td align="left"><label style="font:10px;font-weight:bold;font-family:sans-serif;">Fax :</label>&nbsp;<label name="lblcompfax" id="lblcompfax" ><s:property value="lblcompfax"/></label></td>
  </tr>
  <tr>
    <td rowspan="2">&nbsp;</td>
    <td align="left"><label style="font:10px;font-weight:bold;font-family:sans-serif;">Branch :</label>&nbsp;<label id="lblbranch" name="lblbranch" ><s:property value="lblbranch"/></label></td>
  </tr>
  <tr>
    <td align="left"><label style="font:10px;font-weight:bold;font-family:sans-serif;">Location :</label>&nbsp;<label id="lbllocation" name="lbllocation" ><s:property value="lbllocation"/></label></td>
  </tr>
  <tr>
    <td colspan="3"><hr noshade size=1 width="100%"></td>
  </tr>
   <tr>
    <td colspan="3"></td></tr></table>
<fieldset>

<table width="100%" > 
  <tr>
    <td width="15%" align="left">Customer Name </td>
    <td width="61%">: <label id="lblclient" name="lblclient"><s:property value="lblclient"/></label></td>
    <td width="8%" align="left">Doc No</td>
    <td  width="16%">: <label id="docvals" name="docvals"><s:property value="docvals"/></label></td>
    </tr>
    <tr>
    <td align="left">Address </td>
    <td >: <label name="lblclientaddress" id="lblclientaddress" ><s:property value="lblclientaddress"/></label></td>
    <td align="left">Date </td>
    <td >: <label name="lbldate" id="lbldate" ><s:property value="lbldate"/></label></td>
  </tr>
  <tr>
   
    <td align="left">MOB </td>
    <td>: <label name="lblmob" id="lblmob" ><s:property value="lblmob"/></label></td>
 <%--        <td align="left">Type</td>
    <td>: <label name="lbltypep" id="lbltypep" ><s:property value="lbltypep"/></label></td> --%>
    
     <td align="left">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>

    <td align="left">Email</td>
    <td>: <label name="lblemail" id="lblemail" ><s:property value="lblemail"/></label></td>
      <td align="left">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
 
   </table>
</fieldset>
<br>

  <div id="firstdiv" hidden="true" >
<!-- <fieldset> -->
<table style="border-collapse: collapse;border: 1px solid black;" width="100%"  > 

 <tr height="25" style="background-color: #ffebcd;border-collapse: collapse;font:10px;font-weight:bold;font-family:sans-serif;">
   <th align="left"  style="border-collapse: collapse;border-right: 1px solid #000; border: 1px solid black;">Sl No</th>
     <th align="left"  style="border-collapse: collapse;border-right: 1px solid #000; border: 1px solid black;">Brand </th>
     <th align="left"  style="border-collapse: collapse;border-right: 1px solid #000; border: 1px solid black;">Model</th>
    <th align="left" style="border-collapse: collapse;border-right: 1px solid #000; border: 1px solid black;">Specification</th>
     <th align="left"style="border-collapse: collapse;border-right: 1px solid #000; border: 1px solid black;">YOM</th>
     <th align="left" style="border-collapse: collapse;border-right: 1px solid #000; border: 1px solid black;">Color</th>
     <th align="left"  style="border-collapse: collapse;border-right: 1px solid #000; border: 1px solid black;">Rent Type</th>
     <th align="left" style="border-collapse: collapse;border-right: 1px solid #000; border: 1px solid black;">Tariff</th>
      <th align="left"  style="border-collapse: collapse;border-right: 1px solid #000; border: 1px solid black;">Unit</th>
     <th align="left"  style="border-collapse: collapse;border-right: 1px solid #000; border: 1px solid black;">Days</th>
     <th align="left" style="border-collapse: collapse;border-right: 1px solid #000; border: 1px solid black;">Group</th>
 
  </tr>
 
<s:iterator var="stat" value='#request.details' >
<tr >   
<%int i=0; %>
    <s:iterator status="arr" value="#stat.split('::')" var="des">   
    <%
    if(i>1){%>
    
  <td  align="left"  style="border-right: 1px solid #000;">
  <s:property value="#des"/>
  </td>
   <%} else{ %>
    
  <td  align="left" style="border-right: 1px solid #000;" >
  <s:property value="#des"/>
  </td>
  <% } i++;  %>
 </s:iterator>
</tr>
</s:iterator>
<% for(int i=0;i<3;i++) 
{
	%>

<tr  >
    <td align="left"  style="border-right: 1px solid #000;">&nbsp;</td>
    <td align="left" style="border-right: 1px solid #000;">&nbsp;</td>
    <td align="left" style="border-right: 1px solid #000;">&nbsp;</td>
    <td align="left"style="border-right: 1px solid #000;">&nbsp;</td>
    <td align="left" style="border-right: 1px solid #000;">&nbsp;</td>
    <td align="left" style="border-right: 1px solid #000;">&nbsp;</td>
    <td align="left" style="border-right: 1px solid #000;">&nbsp;</td>
    <td align="left" style="border-right: 1px solid #000;">&nbsp;</td>
<td align="left" style="border-right: 1px solid #000;">&nbsp;</td>
    <td align="left" style="border-right: 1px solid #000;">&nbsp;</td>
        <td align="left" style="border-right: 1px solid #000;">&nbsp;</td> 
  </tr>
  <%} %>


</table>
<br>
<table width="100%" >
<tr>
<td width="1%">&nbsp;</td><td colspan="2" width="99%"><u><label name="terms1" id="terms1" style="font:10px;font-weight:bold;font-family:sans-serif;"><s:property value="terms1"/></label></u> </td> 

</tr>
<tr>
<td width="1%"></td><td width="99%"><label name="generalterms" id="generalterms" ><s:property value="generalterms"/></label> </td>

</tr>
</table>
<br>
<table width="100%" >
<tr>
<td width="1%">&nbsp;</td><td width="99%"><u><label name="terms2" id="terms2" style="font:10px;font-weight:bold;font-family:sans-serif;"><s:property value="terms2"/></label></u> </td>
</tr>
<tr>
<s:iterator var="stat" value='#request.desc' >
<tr >   

<%int i=0; %>
    <s:iterator status="arr" value="#stat.split('::')" var="des">   
    <%
    
    if(i==0){%>
    
  <td  align="left"  >
  <s:property value="#des"/>
  </td>
   <%} else{ %>
    
  <td  align="left" width="99%"  >
  <s:property value="#des"/>
  </td>
  <% } i++;  %>
 </s:iterator>
</tr>
</s:iterator>

</tr>
</table>


<!-- </fieldset> -->
</div>
<br>

<br>
<%-- <jsp:include page="../../../common/printFooter.jsp"></jsp:include> --%>


<input type="hidden" id="firstarray" name="firstarray" value='<s:property value="firstarray"/>'>  
<input type="hidden" id="secarray" name="secarray" value='<s:property value="secarray"/>'>

</div>
</form>
<!-- </div> -->
</body>
</html>