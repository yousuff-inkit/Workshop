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
<style>
 .hidden-scrollbar {
  overflow: auto;
  height: 800px;
} 
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

#ita {
     font-style: "italic";
    color:#6495ed;
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


p{
	font-size: 12px;
	font-family: Times new roman;
	align: justify;
}
  H2 {page-break-before: always}

</style> 
  <%-- <style type="text/css">
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
 </style>  --%>
 
 
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
<body style="font-size:12px;"  bgcolor="white" onload="hidedata()">
<div id="mainBG" class="homeContent" data-type="background">
<form id="fmnq" action="priInvoices" autocomplete="off" target="_blank">
<%-- <jsp:include page="../../../../../header.jsp"></jsp:include> --%> <br/> 

 <div style="background-color:white;">
<table width="100%">
  <tr>

  <td><jsp:include page="../../../common/printHeader.jsp"></jsp:include></td>
    
 </tr></table>
 <table width="100%" border="0">
  <tr>
    <td width="35%">Dear Mr.<label id="lblclient" name="lblclient"><s:property value="lblclient"/></label></td>
    <td width="43%">&nbsp;</td>
    <td width="22%">Date.<label name="lbldate" id="lbldate" ><s:property value="lbldate"/></label></td>
  </tr>
  <tr>
    <td colspan="3"><p>Please find detailed below the requested quotation with a summary of coverage and key information.</p></td>
    </tr>
</table>

 <div id="firstdiv" >
<!-- <fieldset> -->
<table style="border-collapse: collapse;" width="100%" class="table"> 

 <tr  style="background-color: #ffebcd;border-collapse: collapse;" >
   <th align="left" class="firstcol" style="border-collapse: collapse;"><b>Sl No</b></th>
   <th align="left" class="firstcol" style="border-collapse: collapse;"><b>Lease From</b> </th>
     <th align="left" class="firstcol" style="border-collapse: collapse;"><b>Brand</b> </th>
     <th align="left" class="firstcol" style="border-collapse: collapse;"><b>Model</b></th>
    <th align="left" class="firstcol"style="border-collapse: collapse;"><b>Specification</b></th>
     
     <th align="left" class="firstcol"style="border-collapse: collapse;"><b>Color</b></th>
     <th align="left" class="firstcol"style="border-collapse: collapse;"><b>Lease in Months</b></th>
     
     <th align="left"  class="firstcol"style="border-collapse: collapse;"><b>KM use</b></th>
     
     <th align="left" class="firstcol" style="border-collapse: collapse;"><b>Group</b></th>
     <th align="left" class="firstcol" style="border-collapse: collapse;"><b>Total</b></th>
 
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
<%-- <% for(int i=0;i<3;i++) 
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
        <!--<td align="left" class="firstcol">&nbsp;</td> -->
  </tr>
  <%} %>

 --%></table>
<br>
<!-- <table width="100%" style="font-size: 10px;font-family: Times new roman">
<tr>
<td width="1%">&nbsp;</td><td colspan="2" width="99%"><u><b><label name="terms1" id="terms1"><s:property value="terms1"/></label></b></u> </td> 

</tr>
<tr>
<td width="1%"></td><td width="99%"><label name="generalterms" id="generalterms" ><s:property value="generalterms"/></label> </td>

</tr>
</table>
<br>
<table width="100%" style="font-size: 10px;font-family: Times new roman">
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
-->

<!-- </fieldset> -->
</div>
  <table style="border-collapse: collapse;" width="100%" border="1" >
  <tr height="50" style="background-color: #D8D8D8;border-collapse: collapse;">
<td align="center" width="33%" style="border-collapse: collapse;"><b>Included In Monthly Payment</b></td>
<td align="center" width="67%" style="border-collapse: collapse;"><b>Coverage</b></td>
 </tr>
  <tr style="border-collapse: collapse;">
<td align="center" width="33%" style="border-collapse: collapse;" >Vehicle Insurance</td>
<td align="center" width="67%" style="border-collapse: collapse;" >The vehicle will have comprehensive Insurance <br>Covering accidental damage, Fire and Theft.</td>
 </tr>
  <tr style="border-collapse: collapse;">
<td align="center" width="33%" style="border-collapse: collapse;">Vehicle Servicing</td>
<td align="center" width="67%" style="border-collapse: collapse;">All Servicing is included as per the routine intervals<br>of the manufacturers guidelines.</td>
 </tr>
 <tr style="border-collapse: collapse;">
<td align="center" width="33%" style="border-collapse: collapse;" >Maintenance</td>
<td align="center" width="67%" style="border-collapse: collapse;" >Standard Maintenance is included in the Lease<br> Covering most mechanical faults and failure.</td>
 </tr>
 <tr style="border-collapse: collapse;">
<td align="center" width="33%" style="border-collapse: collapse;" >Replacement Vehicle</td>
<td align="center" width="67%" style="border-collapse: collapse;" >A Replacement vehicle is provided for all routine<br>service work and in the event of mechanical<br> failure or break down.</td>
 </tr>
 <tr style="border-collapse: collapse;">
<td align="center" width="33%" style="border-collapse: collapse;" >Registration Fee</td>
<td align="center" width="67%" style="border-collapse: collapse;" >All Registration Fees are covered within the lease.</td>
 </tr>
 <tr style="border-collapse: collapse;">
<td align="center" width="33%" style="border-collapse: collapse;" >Roadside Assistance</td>
<td align="center" width="67%" style="border-collapse: collapse;" >Your vehicle will have 24 Roadside assistance in <br> the event of a break down.</td>
 </tr>  
  </table>
  <br>
  <table style="border-collapse: collapse;" width="100%" border="1">
  <tr height="40" style="background-color: #D8D8D8;border-collapse: collapse;">
<td align="center" width="25%" style="border-collapse: collapse;" ><b>Peace of Mind Packages</b></td>
<td style="border-collapse: collapse;" width="25%" ></td>
<td style="border-collapse: collapse;" width="25%" ></td>
<td style="border-collapse: collapse;"width="25%" ></td>
 </tr>
  <tr height="40" style="background-color: #D8D8D8;border-collapse: collapse;">
<td align="center" width="25%" style="border-collapse: collapse;"><b>Basic</b></td>
<td align="center" width="25%" style="border-collapse: collapse;"><b>Silver</b></td>
<td align="center" width="25%" style="border-collapse: collapse;"><b>Gold</b></td>
<td align="center" width="25%" style="border-collapse: collapse;"><b>Platinum</b></td>
 </tr>
  <tr style="border-collapse: collapse;">
<td width="25%" style="border-collapse: collapse;"></td>
<td align="center" width="25%" style="border-collapse: collapse;">250 AED</td>
<td align="center" width="25%" style="border-collapse: collapse;">250 AED</td>
<td align="center" width="25%" style="border-collapse: collapse;">350 AED</td>
 </tr>
   <tr style="border-collapse: collapse;">
<td align="center" width="25%" style="border-collapse: collapse;">Insurance Excess - 3500</td>
<td align="center" width="25%" style="border-collapse: collapse;">Insurance Excess - 2500</td>
<td align="center" width="25%" style="border-collapse: collapse;">Insurance Excess - NIL</td>
<td align="center" width="25%" style="border-collapse: collapse;">Insurance Excess - NIL</td>
 </tr>
  <tr style="border-collapse: collapse;">
<td align="center" width="25%" style="border-collapse: collapse;">Replacement for Accident</td>
<td align="center" width="25%" style="border-collapse: collapse;">Replacement for Accident</td>
<td align="center" width="25%" style="border-collapse: collapse;">Replacement for Accident</td>
<td align="center" width="25%" style="border-collapse: collapse;">Replacement for Accident</td>
 </tr> 
  </table>
  <br>  
  <p style="line-height:20px;">
  <b><u>Terms and Conditions</u></b>
  <br>
  <b>Payment Terms :</b>
  <br>
  3 months in advance plus monthly Post Dated Cheques.
  <br>
  <b>Security :</b>
  <br>
  Credit Card pre authority for 1500 each month to cover fines and salik
  <br>
  <b>Credit Facility :</b>
  <br>
Available on request for Companies only.
<br>
<b>Driver Requirement :</b>
<br>
Must hold a valid UAE driving license for at least 12 months and be over 25 years old.
<br>
<b>Termination :</b>
<br>
Customer may terminate the lease in writinggiving 30 days notice. 
<br>
During first year termination fee would be 3 x monthly payment.
<br>
After first year termination fee would be 2 x monthly payment.
<br>
<b>Government Fees :</b>
<br>
Salik is charged at 5 AED per crossing
<br>
Admin fee for all traffic fines would be 150 AED.
<br>
<b>Insurance Coverage :</b>
<br>The Insurance coverage excludes All Off Road areas , any Race or Performance track area and countries outside <br>of the UAE. The customer is fully liable for any damage caused due to excluded coverage.
  </p>
  
  <table style="border-collapse: collapse;" width="100%" border="1">
  <tr height="40" style="background-color: #D8D8D8;border-collapse: collapse;">
<td align="center" width="40%"  style="border-collapse: collapse;"><b>Documents Req. for Lease approval</b></td>
<td align="left" width="20%"  style="border-collapse: collapse;"></td>
<td align="left" width="40%"  style="border-collapse: collapse;"></td>
 </tr>
 <tr height="40" style="background-color: #D8D8D8;border-collapse: collapse;">
<td align="center" width="40%"  style="border-collapse: collapse;"><b>Private Individual</b></td>
<td align="left" width="20%"  style="border-collapse: collapse;"></td>
<td align="center" width="40%"  style="border-collapse: collapse;"><b>Company</b></td>
 </tr>
 <tr style="border-collapse: collapse;">
<td align="center" width="40%" >Passport Copy + Visa Copy +EID</td>
<td width="20%"  style="border-collapse: collapse;"></td>
<td align="center" width="40%"  style="border-collapse: collapse;">Valid Trade License<br> Memorandum of association</td>
 </tr>
 <tr style="border-collapse: collapse;">
<td align="center" width="40%"  style="border-collapse: collapse;">Salary Certificate</td>
<td width="20%"  style="border-collapse: collapse;"></td>
<td align="center" width="40%"  style="border-collapse: collapse;">Power of Attorney</td>
 </tr>
 <tr style="border-collapse: collapse;">
<td align="center" width="40%"  style="border-collapse: collapse;">Driving License</td>
<td align="left" width="20%" style="border-collapse: collapse;" ></td>
<td align="center" width="40%"  style="border-collapse: collapse;">6 Months Bank Statements</td>
 </tr>
 <tr style="border-collapse: collapse;">
<td align="center" width="40%"  style="border-collapse: collapse;">3 Months Bank Statements</td>
<td align="left" width="20%" style="border-collapse: collapse;" ></td>
<td align="center" width="40%"  style="border-collapse: collapse;">Owners Passport Copy</td>
 </tr>
 <tr style="border-collapse: collapse;">
<td align="center" width="40%"  style="border-collapse: collapse;">Work + Home Address</td>
<td align="left" width="20%"  style="border-collapse: collapse;"></td>
<td align="center" width="40%"  style="border-collapse: collapse;">Premises Address <br>Signed Credit Application Form</td>
 </tr>
  </table> 
  <p> 
  Thank you : Quotation is valid for 14 days from Date of Quotation and subject to vehicle availability. This
Quotation is not a Contract and is for information purpose only.
 </p>
 </div>   
<br>
<jsp:include page="../../../common/printFooter.jsp"></jsp:include> 
<input type="hidden" name="firstarray" id="firstarray" value='<s:property value="firstarray"/>'>
<input type="hidden" name="secarray" id="secarray"  value='<s:property value="secarray"/>'>
</div>
</body>
</html>
