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
.tablereceipt {
    border: 1px solid rgb(139,136,120);
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

</style>
 <style type="text/css">
    @media screen {
        div.divFooter {
            display: none;
        }
    }
    @media print {
        div.divFooter {
            position: fixed;
            bottom: 0;
        }
    }
 </style> 
<script>
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
<body bgcolor="white" style="font-size:10px;" onload="hidedata();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmqotPrint" action="prqotInvoice" autocomplete="off" target="_blank">
<%-- <jsp:include page="../../../../../header.jsp"></jsp:include> --%> <br/> 

 <div style="background-color:white;">
<table width="100%">
  <tr>

   <td><jsp:include page="..\..\..\common\printHeader.jsp"></jsp:include></td> 
    
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

    <td align="left">Sales Agent</td>
    <td>: <label name="lblsaagnt" id="lblsaagnt" ><s:property value="lblsaagnt"/></label></td>
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


</table>
 --%>
 <table width="100%" > 
  <tr>
    <td width="14%" align="left">Customer Name </td>
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
<%--         <td align="left">Type</td>
    <td>: <label name="lbltypep" id="lbltypep" ><s:property value="lbltypep"/></label></td> --%>
        <td align="left">Fleet</td>
    <td>: <label name="lblfleet" id="lblfleet" ><s:property value="lblfleet"/></label></td>
            
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
<fieldset>
<table width="100%">
<tr>
<td width="70%">

<table width="100%" > 
  <tr>
    <td width="20%" align="left">Brand </td>
    <td colspan="2">: <label id="lblbrand" name="lblbrand"><s:property value="lblbrand"/></label></td> 
    </tr>
    <tr>
    <td align="left">Model </td>
    <td >: <label name="lblmodel" id="lblmodel" ><s:property value="lblmodel"/></label></td>
  </tr>
  <tr>
   
    <td align="left">Color</td>
    <td>: <label name="lblcolor" id="lblcolor" ><s:property value="lblcolor"/></label></td>
  </tr>
  <tr>

    <td align="left">Group</td>
    <td>: <label name="lblgroup" id="lblgroup" ><s:property value="lblgroup"/></label></td>
  </tr>
 
       <tr>
  <td align="left">Del.Location</td>
    <td > : <label name="lbldellocation" id="lbldellocation" ><s:property value="lbldellocation"/></label></td>
 
  </tr>
 
</table>
</td>

<td width="30%">
<table width="100%" >
  <tr>
    <td width="30%" align="left">From Date</td>
    <td width="40%">: <label id="lblfromdate" name="lblfromdate"><s:property value="lblfromdate"/></label> </td> <td>&nbsp;Time&nbsp;:<label id="lblfromtim" name="lblfromtim"><s:property value="lblfromtim"/></label> </td>
    </tr>
   <tr>
    <td width="20%" align="left">To Date</td>
    <td>: <label id="lbltodate" name="lbltodate"><s:property value="lbltodate"/></label></td> <td>&nbsp;Time&nbsp;:<label id="lbltotim" name="lbltotim"><s:property value="lbltotim"/></label> </td>
    </tr>
  <tr>

    <td align="left">Delivery</td>
    <td colspan="2">: <label name="lbldelivery" id="lbldelivery" ><s:property value="lbldelivery"/></label></td>
  </tr>
  <tr>

    <td align="left">Chauffeur</td>
    <td colspan="2"> : <label name="lblchauffeur" id="lblchauffeur" ><s:property value="lblchauffeur"/></label></td>
  </tr>
   <tr>

   <td align="left">&nbsp;</td>
    <td> <label hidden="true" name="lblrenttype" id="lblrenttype" ><s:property value="lblrenttype"/></label></td>
  </tr>
  
</table>


</td>
</tr>


</table>

</fieldset>


<br>
  <div id="firstdiv" hidden="true" >

<!-- <table width="100%"  >
group1, rentaltype, rate, cdw, pai, cdw1, pai1, gps, babyseater, cooler, kmrest, exkmrte, oinschg, exhrchg
 <tr height="20">
    <td align="left" ><b>SI No</b></td>
    <td align="left" ><b>Group</b></td>
    <td align="left" ><b>Rantal Type</b></td>
    <td align="right" ><b>Taiff</b></td>
    <td align="right"><b>CDW</b></td>
    <td align="right" ><b>Super CDW</b></td>
    <td align="right"><b>Child Seat</b></td>
    <td align="right" ><b>Booster</b></td>
    <td align="right"><b>KM Restrict</b></td>
        <td align="right"><b>Excess KM Rate</b></td>
           <td align="right"><b>Ins Charge</b></td>
  <td align="right"><b>Extra Hr Charge</b></td>
     
   
  </tr> -->
<!--   <fieldset>
  <legend>Tariff</legend> -->
  <table style="border-collapse: collapse;" width="100%" border="" >
<!-- group1, rentaltype, rate, cdw, pai, cdw1, pai1, gps, babyseater, cooler, kmrest, exkmrte, oinschg, exhrchg -->
 <tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
    
   
    <td align="left"  style="border-collapse: collapse;"><b>Rental Type</b></td>
    <td align="right" style="border-collapse: collapse;"><b>Taiff&nbsp;</b></td>
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
    if(j>1){%>
    
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

</table>
<!-- </fieldset> -->
</div>
<br>
<div id="secdiv" hidden="true" > 
<!--   <fieldset>
  <legend>Payment</legend> -->
 <table style="border-collapse: collapse;" width="100%" border="" >

 <tr height="20">
    <td align="left" style="border-collapse: collapse;"><b>Payment</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Mode</b></td>
    <td align="right" style="border-collapse: collapse;"><b>Amount</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Auth No</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Card Type</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Card NO</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Exp:Date</b></td>
    <td align="left"  style="border-collapse: collapse;"><b>Reciept NO</b></td>
    
 
  </tr>

<s:iterator var="stat" value='#request.details' >
<tr>   
<%int i=0; %>
    <s:iterator status="arr" value="#stat.split('::')" var="des">   
    <%
    if(i==2){%>
    
  <td  align="right" >
  <s:property value="#des"/>
  </td>
   <%} else{ %>
    
  <td  align="left" >
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
<jsp:include page="../../../common/printFooter.jsp"></jsp:include>


</div>
<input type="hidden" id="firstarray" name="firstarray" value='<s:property value="firstarray"/>'>  
<input type="hidden" id="secarray" name="secarray" value='<s:property value="secarray"/>'>
</form>
</div>
</body>
</html>
