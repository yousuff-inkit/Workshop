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

<style type="text/css">
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
 fieldSet {
  -webkit-border-radius: 8px;
  -moz-border-radius: 8px;
  border-radius: 8px;
  border: 1px solid rgb(139,136,120);

 }
 legend
    {

        border-style:none;
        background-color:#FFF;
        padding-left:1px;

    }
 hr { 
   border-top: 1px solid #e1e2df  ;
   
 
   
    } 
table.ex1 {
   width: auto;
}
</style>

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
<table width="100%">
  <tr>

    <td><jsp:include page="../../../common/printDrivenHeader.jsp"></jsp:include></td>
    
  </tr>
</table>
<fieldset>
<%-- <table width="100%">
<tr>
<td width="60%">



  
<table width="100%" > 
  <tr>
    <td width="25%" align="left">Customer Name </td>
    <td colspan="2">: <label id="lblclient" name="lblclient"><s:property value="lblclient"/></label></td>
    </tr>
    <tr>
    <td align="left">Address </td>
    <td >: <label name="lblclientaddress" id="lblclientaddress" ><s:property value="lblclientaddress"/></label></td>
  </tr>
  <tr>
   
    <td align="left">MOB </td>
    <td>: <label name="lblmob" id="lblmob" ><s:property value="lblmob"/></label></td>
  </tr>
  <tr>

    <td align="left">Email</td>
    <td>: <label name="lblemail" id="lblemail" ><s:property value="lblemail"/></label></td>
  </tr>
 
     
</table>
</td>

<td width="40%">
<table width="100%" >
  <tr>
    <td width="20%" align="left">Doc No</td>
    <td colspan="2">: <label id="docvals" name="docvals"><s:property value="docvals"/></label></td>
    </tr>
    <tr>
    <td align="left">Date </td>
    <td >: <label name="lbldate" id="lbldate" ><s:property value="lbldate"/></label></td>
  </tr>
  <tr>
   
    <td align="left">Type</td>
    <td>: <label name="lbltypep" id="lbltypep" ><s:property value="lbltypep"/></label></td>
  </tr>
  <tr>

    <td align="left">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
   <tr>

    <td align="left">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
    <tr>

    <td align="left">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
     
</table>


</td>
</tr>


</table> --%>
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
<table style="border-collapse: collapse;" width="100%" class="table"> 

 <tr height="25" style="background-color: #ffebcd;border-collapse: collapse;" >
   <th align="left" class="firstcol" style="border-collapse: collapse;"><b>Sl No</b></th>
     <th align="left" class="firstcol" style="border-collapse: collapse;"><b>Brand</b> </th>
     <th align="left" class="firstcol" style="border-collapse: collapse;"><b>Model</b></th>
    <th align="left" class="firstcol"style="border-collapse: collapse;"><b>Specification</b></th>
     <th align="left" class="firstcol"style="border-collapse: collapse;"><b>YOM</b></th>
     <th align="left" class="firstcol"style="border-collapse: collapse;"><b>Color</b></th>
     <th align="left"  class="firstcol"style="border-collapse: collapse;"><b>Rent Type</b></th>
     <th align="left" class="firstcol"style="border-collapse: collapse;"><b>Tariff</b></th>
      <th align="left" class="firstcol" style="border-collapse: collapse;"><b>Unit</b></th>
     <th align="left" class="firstcol" style="border-collapse: collapse;"><b>Days</b></th>
     <th align="left" class="firstcol" style="border-collapse: collapse;"><b>Group</b></th>
 
  </tr>
 
<s:iterator var="stat" value='#request.details' >
<tr >   
<%int i=0; %>
    <s:iterator status="arr" value="#stat.split('::')" var="des">   
    <%
    if(i>1){%>
    
  <td  align="left" class="lastcol">
  <s:property value="#des"/>
  </td>
   <%} else{ %>
    
  <td  align="left" class="firstcol" >
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
    <td align="left"  class="firstcol">&nbsp;</td>
    <td align="left" class="firstcol">&nbsp;</td>
    <td align="left" class="firstcol">&nbsp;</td>
    <td align="left" class="firstcol">&nbsp;</td>
    <td align="left" class="firstcol">&nbsp;</td>
    <td align="left" class="firstcol">&nbsp;</td>
    <td align="left" class="firstcol">&nbsp;</td>
    <td align="left"class="firstcol">&nbsp;</td>
<td align="left" class="firstcol">&nbsp;</td>
    <td align="left" class="firstcol">&nbsp;</td>
        <td align="left" class="firstcol">&nbsp;</td> 
  </tr>
  <%} %>


</table>
<br>
<table width="100%" >
<tr>
<td width="1%">&nbsp;</td><td colspan="2" width="99%"><u><b><label name="terms1" id="terms1"><s:property value="terms1"/></label></b></u> </td> 

</tr>
<tr>
<td width="1%"></td><td width="99%"><label name="generalterms" id="generalterms" ><s:property value="generalterms"/></label> </td>

</tr>
</table>
<br>
<table width="100%" >
<tr>
<td width="1%">&nbsp;</td><td width="99%"><u><b><label name="terms2" id="terms2" ><s:property value="terms2"/></label></b></u> </td>
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
<!--   <div id="secdiv" hidden="true" >  -->
<!-- <fieldset> -->
<%-- <table style="border-collapse: collapse;" width="100%" border="" >
<!-- group1, rentaltype, rate, cdw, pai, cdw1, pai1, gps, babyseater, cooler, kmrest, exkmrte, oinschg, exhrchg -->
 <tr height="25" style="background-color: #ffebcd;border-collapse: collapse;">
    <td align="left" style="border-collapse: collapse;" ><b>Sl No</b></td>
    <td align="left"style="border-collapse: collapse;" ><b>Group</b></td>
    <td align="left"  style="border-collapse: collapse;"><b>Rental Type</b></td>
    <td align="right" style="border-collapse: collapse;"><b>Taiff</b></td>
    <td align="right" style="border-collapse: collapse;"><b>CDW</b></td>
    <td align="right" style="border-collapse: collapse;"><b>SCDW</b></td>
    <td align="right" style="border-collapse: collapse;"><b>Gps</b></td>
    <td align="right" style="border-collapse: collapse;"><b>Child Seat</b></td>
    <td align="right"  style="border-collapse: collapse;"><b>Booster</b></td>
    <td align="right" style="border-collapse: collapse;"><b>KM Rest</b></td>
        <td align="right" style="border-collapse: collapse;"><b>Exc KM Rate</b></td>
           <td align="right"  style="border-collapse: collapse;"><b>Ins Charge</b></td>
  <td align="right"  style="border-collapse: collapse;"><b>Ex. Hr Charge</b></td>
     
   
  </tr>

<s:iterator var="stat" value='#request.tariffdetails' >
<tr>   
<%int j=0; %>
    <s:iterator status="arr" value="#stat.split('::')" var="des">   
    <%
    if(j>2){%>
    
  <td  align="right" >
  <s:property value="#des"/>
  </td>
   <%} else{ %>
    
  <td  align="left" >
  <s:property value="#des"/>
  </td>
  <% } j++;  %>
 </s:iterator>
</tr>
</s:iterator>

</table> --%>
<!-- </fieldset> -->
<!-- </div> -->
<br>
<jsp:include page="../../../common/printFooter.jsp"></jsp:include>


<input type="hidden" id="firstarray" name="firstarray" value='<s:property value="firstarray"/>'>  
<input type="hidden" id="secarray" name="secarray" value='<s:property value="secarray"/>'>

</div>
</form>
<!-- </div> -->
</body>
</html>