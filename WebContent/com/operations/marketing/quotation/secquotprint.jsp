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


<script type="text/javascript">

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
	
	if(parseInt(sec)==2)
	{
		  $("#secdiv").prop("hidden", false);
	}
	else
		{
		 $("#secdiv").prop("hidden", true);
		} 
	
	
	}

</script>
</head>
<body bgcolor="white" style="font-size:10px;" onload="hidedata(); ">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmqotPrint" action="prqotInvoice" autocomplete="off" target="_blank">

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
<fieldset >

<table width="100%" > 
  <tr >
    <td width="15%" align="left" ><label style="font:10px;font-weight:bold;font-family:sans-serif;">Customer Name </label></td>
    <td width="61%"><label style="font:10px;font-weight:bold;font-family:sans-serif;">:</label> <label id="lblclient" name="lblclient"><s:property value="lblclient"/></label></td>
    <td width="8%" align="left" ><label style="font:10px;font-weight:bold;font-family:sans-serif;">Doc No</label></td>
    <td  width="16%"><label style="font:10px;font-weight:bold;font-family:sans-serif;">:</label> <label id="docvals" name="docvals"><s:property value="docvals"/></label></td>
    </tr>
    <tr>
    <td align="left" ><label style="font:10px;font-weight:bold;font-family:sans-serif;">Address</label> </td>
    <td ><label style="font:10px;font-weight:bold;font-family:sans-serif;">:</label> <label name="lblclientaddress" id="lblclientaddress" ><s:property value="lblclientaddress"/></label></td>
    <td align="left" ><label style="font:10px;font-weight:bold;font-family:sans-serif;">Date</label> </td>
    <td ><label style="font:10px;font-weight:bold;font-family:sans-serif;">:</label> <label name="lbldate" id="lbldate" ><s:property value="lbldate"/></label></td>
  </tr>
  <tr>
   
    <td align="left" ><label style="font:10px;font-weight:bold;font-family:sans-serif;">Mobile</label> </td>
    <td><label style="font:10px;font-weight:bold;font-family:sans-serif;">:</label> <label name="lblmob" id="lblmob" ><s:property value="lblmob"/></label></td>
        <td align="left" ><label style="font:10px;font-weight:bold;font-family:sans-serif;">Type</label></td>
    <td><label style="font:10px;font-weight:bold;font-family:sans-serif;">:</label> <label name="lbltypep" id="lbltypep" ><s:property value="lbltypep"/></label></td>
  </tr>
  <tr>

    <td align="left" ><label style="font:10px;font-weight:bold;font-family:sans-serif;">Email</label></td>
    <td><label style="font:10px;font-weight:bold;font-family:sans-serif;">:</label> <label name="lblemail" id="lblemail" ><s:property value="lblemail"/></label></td>
      <td align="left">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
 
   </table>
</fieldset>
<br>

  <div id="firstdiv" hidden="true" >
<!-- <fieldset> -->
<table style="border-collapse: collapse;border: 1px solid #8b8682;" width="100%"  > 

 <tr height="25" style="background-color: #F0F0F0 ;border-collapse: collapse;border: 1px solid #8b8682;">
    <td align="left" style="border-collapse: collapse;border: 1px solid #8b8682;" >Sl Nos</td>
    <td align="left" style="border-collapse: collapse;border: 1px solid #8b8682;">Brand</td>
    <td align="left" style="border-collapse: collapse;border: 1px solid #8b8682;">Model</td>
    <td align="left" style="border-collapse: collapse;border: 1px solid #8b8682;">Specification</td>
    <td align="left" style="border-collapse: collapse;border: 1px solid #8b8682;">Color</td>
    <td align="left"  style="border-collapse: collapse;border: 1px solid #8b8682;">Rent Type</td>
    <td align="left" style="border-collapse: collapse;border: 1px solid #8b8682;">From Date</td>
    <td align="left"  style="border-collapse: collapse;border: 1px solid #8b8682;">To Date</td>
    <td align="left" style="border-collapse: collapse;border: 1px solid #8b8682;">Unit</td>
        <td align="left" style="border-collapse: collapse;border: 1px solid #8b8682;">Group</td>
 
  </tr>
 
<s:iterator var="stat" value='#request.details' >
<tr style="border-collapse: collapse;border: 1px solid #8b8682;">   
<%int i=0; %>
    <s:iterator status="arr" value="#stat.split('::')" var="des">   
    <%
    if(i>1){%>
    
  <td  align="left" style="border-collapse: collapse;border: 1px solid #8b8682;">
  <s:property value="#des"/>
  </td>
   <%} else{ %>
    
  <td  align="left" style="border-collapse: collapse;border: 1px solid #8b8682;" >
  <s:property value="#des"/>
  </td>
  <% } i++;  %>
 </s:iterator>
</tr>
</s:iterator>
</table>
<!-- </fieldset> -->
</div>
<br>
  <div id="secdiv" hidden="true" > 
<!-- <fieldset> -->
<table style="border-collapse: collapse;border: 1px solid #8b8682;" width="100%" >
<!-- group1, rentaltype, rate, cdw, pai, cdw1, pai1, gps, babyseater, cooler, kmrest, exkmrte, oinschg, exhrchg -->
 <tr height="25" style="background-color: #F0F0F0;border-collapse: collapse;border: 1px solid #8b8682;">
    <td align="left" style="border-collapse: collapse;border: 1px solid #8b8682;" >Sl No</td>
    <td align="left"style="border-collapse: collapse;border: 1px solid #8b8682;" >Group</td>
    <td align="left"  style="border-collapse: collapse;border: 1px solid #8b8682;">Rental Type</td>
    <td align="right" style="border-collapse: collapse;border: 1px solid #8b8682;">Taiff</td>
    <td align="right" style="border-collapse: collapse;border: 1px solid #8b8682;">CDW</td>
    <td align="right" style="border-collapse: collapse;border: 1px solid #8b8682;">SCDW</td>
    <td align="right" style="border-collapse: collapse;border: 1px solid #8b8682;">Gps</td>
    <td align="right" style="border-collapse: collapse;border: 1px solid #8b8682;">Child Seat</td>
    <td align="right"  style="border-collapse: collapse;border: 1px solid #8b8682;">Booster</td>
    <td align="right" style="border-collapse: collapse;border: 1px solid #8b8682;">KM Rest</td>
        <td align="right" style="border-collapse: collapse;border: 1px solid #8b8682;">Exc KM Rate</td>
           <td align="right"  style="border-collapse: collapse;border: 1px solid #8b8682;">Ins Charge</td>
  <td align="right"  style="border-collapse: collapse;border: 1px solid #8b8682;">Ex. Hr Charge</td>
     
   
  </tr>

<s:iterator var="stat" value='#request.tariffdetails' >
<tr style="border-collapse: collapse;border: 1px solid #8b8682;">   
<%int j=0; %>
    <s:iterator status="arr" value="#stat.split('::')" var="des">   
    <%
    if(j>2){%>
    
  <td  align="right" style="border-collapse: collapse;border: 1px solid #8b8682;">
  <s:property value="#des"/>
  </td>
   <%} else{ %>
    
  <td  align="left" style="border-collapse: collapse;border: 1px solid #8b8682;">
  <s:property value="#des"/>
  </td>
  <% } j++;  %>
 </s:iterator>
</tr>
</s:iterator>

</table>
<!-- </fieldset> -->
</div>
<br>
<%-- <jsp:include page="../../../common/printFooter.jsp"></jsp:include> --%>


<input type="hidden" id="firstarray" name="firstarray" value='<s:property value="firstarray"/>'>  
<input type="hidden" id="secarray" name="secarray" value='<s:property value="secarray"/>'>

</div>
</form>
</div>
</body>
</html>
