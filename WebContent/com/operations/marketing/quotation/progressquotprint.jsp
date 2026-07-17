<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
 <%@ page pageEncoding="utf-8" %>
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
	font-size: 10px;
	font-family: Times new roman;
	align: justify;
}
  H2 {page-break-before: always}
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

    <td><jsp:include page="../../../common/printProgressHeader.jsp"></jsp:include></td>
    
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
<!-- temp=rowcount+"::"+rsdetail.getString("brand")+"::"+rsdetail.getString("model")+"::"+rsdetail.getString("yom")+"::"+rsdetail.getString("color")+"::"+rsdetail.getString("rtype")+"::"+rsdetail.getString("rate")+"::"+rsdetail.getString("unit")+"::"+rsdetail.getString("cdw")+"::"+rsdetail.getString("pai")+"::"+rsdetail.getString("gps")+"::"+rsdetail.getString("babyseater")+"::"+rsdetail.getString("gname")+"::"+rsdetail.getString("total"); -->
 <tr height="25" style="background-color: #ffebcd;border-collapse: collapse;" >
   <th align="left" class="firstcol" style="border-collapse: collapse;"><b>Sl No</b></th>
     <th align="left" class="firstcol" style="border-collapse: collapse;"><b>Brand</b> </th>
     <th align="left" class="firstcol" style="border-collapse: collapse;"><b>Model</b></th>
     <th align="left" class="firstcol"style="border-collapse: collapse;"><b>YOM</b></th>
     <!-- <th align="left" class="firstcol"style="border-collapse: collapse;"><b>Color</b></th> -->
     <th align="left"  class="firstcol"style="border-collapse: collapse;"><b>Rent Type</b></th>
     <th align="left" class="firstcol"style="border-collapse: collapse;"><b>Tariff</b></th>
      <th align="left" class="firstcol" style="border-collapse: collapse;"><b>Unit</b></th>
      <th align="left" class="firstcol"style="border-collapse: collapse;"><b>CDW</b></th>
     <th align="left" class="firstcol"style="border-collapse: collapse;"><b>PAI</b></th>
     <th align="left" class="firstcol"style="border-collapse: collapse;"><b>GPS</b></th>
     <th align="left" class="firstcol"style="border-collapse: collapse;"><b>BABYSEATER</b></th>
     <th align="left" class="firstcol" style="border-collapse: collapse;"><b>Group</b></th>
     <th align="left" class="firstcol"style="border-collapse: collapse;"><b>TOTAL</b></th>
 
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
    <td align="left" class="firstcol">&nbsp;</td>
    <td align="left" class="firstcol">&nbsp;</td>
    <td align="left" class="firstcol">&nbsp;</td> 
  </tr>
  <%} %>


</table>
<br>
<table width="100%" style="font-size: 10px;font-family: Times new roman">
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


<!-- </fieldset> -->
</div>
 <table width="100%" style="font-size: 10px;font-family: Times new roman">
<tr>
<td><b>Note:</b> -  Quotation is valid for 10 days from the date of quotation. </td>
</tr>
<tr>
<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- The delivery is subject to the availability with the dealers. (Temporary replacement ex-fleet can be arranged immediately, subject to<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  availability) 
</td>
</tr>


</table>
<p align="justify"><b>Quoted Rate Includes:</b></p>


<table width="100%"  style="font-size: 10px;font-family: Times new roman">
<tr><td>&nbsp;1.</td><td>Routine Service & Maintenance</td></tr>
<tr><td>&nbsp;2.</td><td>Replacement Vehicle</td></tr>
<tr><td>&nbsp;3.</td><td>Registration & Renewal </td></tr>
<tr><td>&nbsp;4.</td><td>Full Comprehensive Insurance*</td></tr>
<!-- <tr><td>&nbsp;5.</td><td>Free Delivery & collection in City Limits between 08:00 to 19:00 on working days.</td></tr> -->
<tr><td>&nbsp;5.</td><td>Delivery and collections would be charged as per contract.</td></tr>
<tr><td>&nbsp;6.</td><td>24 Hours Breakdown Service.</td></tr>

</table>

<p align="justify">We trust the above offer is to your satisfaction and we are looking forward to receiving your order confirmation. Should you require any further clarifications, please do not hesitate to contact me at any time.</p>
 <table width="100%" style="font-size: 10px;font-family: Times new roman">
 <TR>
 <td>
The <font color="#6495ed">P</font><font color="red">RAC</font> Team is looking forward to be at your service ...<label  id="ita">with a difference!</label></td>

</tr></table>
<hr noshade size=1 width="100%">

<table width="100%" style="font-size: 10px;font-family: Times new roman" >
<tr><td>Name :<label name="lblsalclient" id="lblsalclient" ><s:property value="lblsalclient"/></label></td><td>ph:  <label name="lblsalmob" id="lblsalmob" ><s:property value="lblsalmob"/></label></td></tr> <!-- 4169e1 -->
<tr><td>Sales Executive</td><td><u><font color="blue">sales@progresscars.com</font></u></td></tr>
<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
 
<tr><td colspan="2">* Subject to Police report/Payment of Insurance excess or CDW</td></tr>

</table>
 

<!-- ------------------------------------------------------------------------page---------------------------------------- -->


 

<jsp:include page="../../../common/printFooter.jsp"></jsp:include>



<H2></H2>
    <table width="100%">
<tr>
<td width="20%">&nbsp;</td><td width="60%"><img src="<%=contextPath%>/icons/epic.jpg" width="400" height="70"  alt=""/></td><td width="20%">&nbsp;</td>
 
</tr></table>
<br>
<br>

 &nbsp;&nbsp;&nbsp; <b><u>Terms & Conditions </u></b> 
<p id="para1" align="justify"><b>&nbsp;&nbsp;&nbsp;1. </b>Documentation: RentalContract, LPO, copies of Trade License,Chamber of Commerce, Power of Attorney, Passport of the signatory. All the documents to be <br/>
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;signed by the authorized signatory. <br/>
 <b>&nbsp;&nbsp;&nbsp;2. </b>Insurance: All our vehicles are comprehensively insured and your liability will be limited to AED 1000/- in case of faulty accidents and hit and run<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cases/natural calamities, based on timely submission of police report. Optional CDW and PAI available on request.<br>
 <b>&nbsp;&nbsp;&nbsp;3. </b>Mileage: Limited 60,000 km P/mnt/weekly/daily, extra mileage 25 Fils/Km <br>
 <b>&nbsp;&nbsp;&nbsp;4. </b>Geographical Boundaries: The lessee is allowed to drive the vehicle within UAE geographical boundaries only. Oman travel, NOC and insurance obtainable at <br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;additional cost subject to Management approval.<br>
 <b>&nbsp;&nbsp;&nbsp;5. </b>Lessee responsibility: The lessee should ensure that the fluid levels are correctly maintained and the tyres are properly inflated at all times. Vehicle is to be<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;driven in proper roads only and not to be driven in flood/saline water/off road. Any damage due to negligence or misuse will be duly charged to the lessee.<br>
 <b>&nbsp;&nbsp;&nbsp;6. </b>Payment terms: PRAC follows an advance invoicing policy and your credit terms are 30 days from invoice generation. Any additional charges to be paid <br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;immediately upon invoice receipt.  <br>
 <b>&nbsp;&nbsp;&nbsp;7. </b>Traffic Fines & Salik: Traffic fines /penalties  & Salik during the contract period to be cleared immediately. Traffic fine @ Actual+AED 25/fine and Salik @<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Actual+ AED1/crossing.<br>
 <b>&nbsp;&nbsp;&nbsp;8. </b>General Policies:<br>
 
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- Fuel will be at customer’s expense (including bringing for replacement/maintenance).<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- NOC for MAWAQIF parking permit will be provided based on request. <br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- Smoking is not allowed in our cars. AED 250/- will be charged in case of smoke smell.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- Tinting of vehicle window is not allowed as per UAE laws.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- Use of mobiles are banned while driving as per UAE laws.<br></p>
     

<input type="hidden" id="firstarray" name="firstarray" value='<s:property value="firstarray"/>'>  
<input type="hidden" id="secarray" name="secarray" value='<s:property value="secarray"/>'>

</div>
</form>
<!-- </div> -->
</body>
</html>