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

    <td><jsp:include page="../../../common/printHeader.jsp"></jsp:include></td>
    
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
<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- The delivery is subject to the availability .<br>

</td>
</tr>


</table>
<p align="justify"><b>Quoted Rate Includes:</b></p>


<table width="100%"  style="font-size: 10px;font-family: Times new roman">
<tr><td>&nbsp;1.</td><td>Routine Service & Maintenance</td></tr>
<tr><td>&nbsp;2.</td><td>Free Replacement Vehicle</td></tr>
<tr><td>&nbsp;3.</td><td>Registration & Renewal </td></tr>
<tr><td>&nbsp;4.</td><td>Full Comprehensive Insurance(Subject to Police Report /Payment of Insurance excess or CDW )</td></tr>
<!-- <tr><td>&nbsp;5.</td><td>Free Delivery & collection in City Limits between 08:00 to 19:00 on working days.</td></tr> -->
<tr><td>&nbsp;5.</td><td>Free Delivery and collections on 30 days contract.</td></tr>
<tr><td>&nbsp;6.</td><td>24 Hours Breakdown Service.</td></tr>
<tr><td>&nbsp;7.</td><td>Door to door Service for long term contracts.</td></tr>

</table>

<p align="justify">We trust the above offer is to your satisfaction and we are looking forward to receiving your order confirmation.</br>
<tr><br></tr>
 <tr>Should you require any further clarifications, please do not hesitate to contact us.</p></tr>
 <table width="100%" style="font-size: 10px;font-family: Times new roman">
 <TR>
 <td>
The Calder Car Rental Team is looking forward to be at your service ...<label  id="ita">with a difference!</label></td>

</tr></table>
<hr noshade size=1 width="100%">

<table width="100%" style="font-size: 10px;font-family: Times new roman">
<tr><td>Name</td><td>T: +971 55 558 7276 / +971</td></tr> <!-- 4169e1 -->
<tr><td>558 7176</td></tr>
<tr></tr>
<tr><td>Sales Executive</td><td><u><font color="blue">sales@caldercarrentals.com</font></u></td></tr>
<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
 
<!-- <tr><td colspan="2">* Subject to Police report/Payment of Insurance excess or CDW</td></tr>
 -->
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

<table width="100%" style="font-size: 10px;font-family: Times new roman">
<tr><td>
<b>&nbsp;&nbsp;<u>TERMS AND CONDITION :</u></b></br>
</br>
</td></tr>
<tr>
<td>
&nbsp;&nbsp;CALDER RENT A CAR LLC HEREINAFTER REFERRED TO AS “LESSOR” BEING THE LAWFUL OWNER OF THE CAR DESCRIBED OVERLEAF,<br>
 &nbsp;&nbsp;HEREBY RENTS TO THE CUSTOMER, HEREINAFTER REFERRED TO AS “HIRER” WHO SIGNED OVERLEAF SUBJECT TO ALL TERMS & CONDITIONS </br>
 &nbsp;&nbsp;HEREIN ON THIS RENTAL AGREEMENT IN CONSIDERATION WHEREOF THE HIRER ACKNOWLEDGES AND AGREES THAT:<br>
 </td></tr>
</table>



<!--  &nbsp;&nbsp;&nbsp; <b><u>Terms & Conditions </u></b>  -->
<p id="para1" align="justify"><b>&nbsp;&nbsp;&nbsp;1. </b>INCASE OF CONFISCATION OF THE VEHICLE HIRER SHALL BE RESPONSIBLE TO BEAR ALL THE FEES/FINES AND VALUE OF THE VEHICLE AND<br/> 
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;THE DUE RENT. <br/>
 <b>&nbsp;&nbsp;&nbsp;2. </b>HIRER HEREBY ACKNOWLEDGES THAT HE/SHE HAS FULLY INSPECTED THE CAR, CHECKED ITS SERVICEABILITY AND ACCEPTED THE CAR AS <br/>  
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ITS PRESENT CONDITION AND WILL RETURN IN SAME CONDITION AT THE END OF THE RENTAL AGREEMENT.<br/>
 <b>&nbsp;&nbsp;&nbsp;3. </b>THE VEHICLE WAS DELIVERED TO HIRER IN GOOD CONDITION AS PER CHECK-OUT INSPECTION AND HIRER UNDERTAKES TO KEEP <br/>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;SUFFICIENT LEVEL OF FUEL, WATER & OIL IN VEHICLE.<br>
 <b>&nbsp;&nbsp;&nbsp;4. </b>THE HIRER IS NOT ALLOWED TO TAKE CAR OUT OF UNITED ARAB EMIRATES & NO RENTAL REFUND WILL BE MADE IN CASE HIRER<br> 
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TERMINATES RENTAL CONTRACT BEFORE EXPIRY DATE. A REFUND CAN BE DONE IN SOME CASES BASED ON MANAGEMENT<br>
         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;SOLE DISCRETION. <br>
 <b>&nbsp;&nbsp;&nbsp;5. </b>THE HIRER IS FORBIDDEN TO TRANSFER AND CARRY ANY ITEMS THAT ARE NOT ALLOWED IN THE LAW OF U.A.E,<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SUCH AS ALCOHOL DRINKS AND OTHER FORBIDDEN ITEMS.<br>
 <b>&nbsp;&nbsp;&nbsp;6. </b> A DEPOSIT OF AED 1500 SHALL BE RETAINED FOR 3 WEEKS FROM THE DATE OF RETURN OF CAR & WILL BE RETURNED THEREAFTER, <br> 
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;IF NO DUES.IN THE EVENT OF ACCIDENT WHERE HIRER AT FAULT OR HIT & RUN CASE INSURANCE EXCESS CHARGES / DEDUCTIBLE AED <br>
 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1500 IS PAYABLE.<br>
 <b>&nbsp;&nbsp;&nbsp;7. </b>IN CASE OF AN ACCIDENT RESULTING FROM THE DRIVER/HIRER BEING UNDER THE INFLUENCE OF ALCOHOL OR ANY OTHER SUBSTITUTE <br/>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;HAVING THE SAME EFFECT THEN THE HIRER HAS TO PAY COMPLETE COMPENSATION FOR THE DAMAGES OCCURRED TO THE VEHICLE & <br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ANY LEGAL COSTS INVOLVED TO RELEASE THE CAR.<br>
 <b>&nbsp;&nbsp;&nbsp;8. </b>THE HIRER AGREES TO PAY FOR ALL TRAFFIC FINES AND PARKING TICKETS DURING THE RENTAL PERIOD, WITH ADDITIONAL<br>
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ADMINISTRATION FEES OF AED 35/- PER FINE. THE COMPANY RESERVES THE RIGHTS WITHIN ONE YEAR OF THE END OF SUCH  RENTAL<br>
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CONTRACT, TO CLAIM ANY SUCH UNPAID AMOUNTS FROM THE HIRER.<br>
<b>&nbsp;&nbsp;&nbsp;9. </b>IT IS HEREBY AGREED UPON BETWEEN THE HIRER AND THE LESSOR THAT IN CASE OF TOTAL LOSS / CANCELLATION OF VEHICLE BY UAE<br>
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;POLICE / RTA DEPT. (VEHICLE BEYOND ECONOMICAL REPAIRS) THE HIRER AGREES TO PAY THE COMPANY TOTAL AMOUNT OF AED 5500/-(NOT<br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;APPLICABLE IF THE HIRER NOT AT FAULT).<br>
<b>&nbsp;10. </b>HIRER NOT ALLOWED TO TAKE VEHICLE FOR REPAIRS, SHOULD INFORM LESSOR FOR ANY SERVICE REQUIRED (ALL REPAIRS SHOULD BE<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DONE AT AGENCY WORKSHOPS ONLY).<br>
<b>&nbsp;11. </b>HIRER SHOULD INFORM ANY ABNORMALITY/MALFUNCTIONING IN THE VEHICLE WITH-IN 1 HOUR OF START OF CONTRACT, ANY<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ABNORMALITY/MALFUNCTIONING DETECTED LATER WILL BE REPAIRED/REPLACED AT HIRER’S COST.<br>
<b>&nbsp;12. </b>HIRER IS NOT ALLOWED TO HAND OVER /GIVE UP POSSESSION OF THE VEHICLE TO ANY OTHER PERSON.<br>
<b>&nbsp;13. </b>NO PERMISSION TO USE THE VEHICLE OUTSIDE U.A.E, INSURANCE POLICY VALID INSIDE U.A.E ONLY.<br>
<b>&nbsp;14. </b>LESSOR PERMISSION IS REQUIRED TO EXTEND THE RENT PERIOD, ANY HIRER DRIVING WITH EXPIRED CONTRACT REMAINS TOTALLY LIABLE<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;FOR DAMAGES OUT OF ANY ACCIDENT DURING SUCH PERIOD.<br>
<b>&nbsp;15. </b>HIRER HAS TO VISIT LESSOR OFFICE FOR EXTENSION OF CONTRACT / COLLECTION / DELIVERY / SERVICE, ETC.<br>
<b>&nbsp;16. </b>THE HIRER WHO BEARS A UAE LICENSE THAT HASN’T PASSED A YEAR ON IT FROM THE DATE OF ISSUE OR IF THE HIRER IS LESS THAN 23<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;YEARS OLD WILL BE RESPONSIBLE FOR ALL THE DAMAGE OCCURRED OF ANY ACCIDENT / AN EXCESS OF DHS 1500 + 10% OF CLAIM/LOSS<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;AMOUNT.<br>
<b>&nbsp;17. </b>THE LESSOR IS NOT RESPONSIBLE FOR ANY CASH OR VALUABLES BELONGING TO THE HIRER THAT MAY BE LOST WHILST THE VEHICLE IS IN<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;HIRER’S POSSESSION OR AFTER THE ENTIRE PERIOD OF THE HIRE WHEN CAR IS RETURNED BACK TO LESSOR.<br>
<b>&nbsp;18. </b>THE HIRER MUST ENSURE THAT THE VEHICLE IS PARKED IN A SAFE AND SECURE PLACE WHEN IT IS NOT IN USE. ANY DAMAGE CAUSED TO<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;THE VEHICLE INCLUDING DAMAGE DUE TO ACTS OF GOD WILL BE THE SOLE RESPONSIBILITY OF THE HIRER AS THESE DAMAGES CANNOT<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;BE CLAIMED FROM THE INSURANCE.<br>
<b>&nbsp;19. </b>THE RENTER IS ALLOWED TO DRIVE- 250 KM/DAY ON DAILY RENTALS, 1500KMS/WEEK ON WEEKLY RENTALS & 5000 KMS/MONTH ON<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MONTHLY RENTALS, ABOVE THAT, WILL BE CHARGE 35 FILS PER ADDITIONAL KM.<br>
<b>&nbsp;20. </b>THE HIRER AGREES TO RETURN THE VEHICLE WITH SAME QUANTITY OF FUEL OR PAY FOR THE SAME AT THE END OF THE RENT PERIOD AS<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DELIVERED AT START OF RENTAL CONTRACT.<br>
<b>&nbsp;21. </b>THE HIRER AGREES THAT IN CASE OF ANY BREACH OF CONTRACT, LESSOR RESERVES RIGHTS TO REPOSSESS THE CAR BACK AND CHARGE<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;HIRER ANY LOSS OF INCOME THAT MAY BE INCURRED DUE TO HIRER’S BREACH OF CONTRACT.<br>
<b>&nbsp;22. </b>NO ARTICLES WHICH MIGHT CAUSE DAMAGE TO THE VEHICLE OR ITS UPHOLSTERY SHALL BE TRANSPORTED IN THE VEHICLE, ANY DAMAGE<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TO INTERIORS / EXTERIORS / TIRES /UPHOLSTERY / ELECTRONIC GADGETS/ ANY PART OF VEHICLE WILL BE CHARGED TO HIRER AT AGENCY<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;PRICES.<br>
<b>&nbsp;23. </b>HIRER IS NOT ALLOWED TO SMOKE/DRINK/EAT INSIDE VEHICLE, ELSE ANY DAMAGE/FOUL SMELL ARISING WILL BE CHARGES TO HIRER.<br>
<b>&nbsp;24. </b>THE HIRER AGREES TO USE THE VEHICLE FOR THE PURPOSE FOR WHICH IT HAS BEEN LICENSED. THE RENTED VEHICLE SHALL NOT BE USED<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;FOR MOTOR SPORT EVENTS, RACING, RALLYING AND SPEED TESTING TOWING OF THE VEHICLE AND TRANSPORT<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;OF GOODS IN VIOLATION OF U.A.E RULES.<br>
<b>&nbsp;25. </b>IN CASE OF HIRER ABSCONDING / NOT RESPONDING FOR CONSECUTIVE 2 DAYS, COMPANY RESERVES RIGHTS TO REPOSSESS THE CAR AND<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CLAIM FROM HIRER ANY LOSS THAT COMPANY INCURS DUE TO HIRER, AT THE SAME TIME HIRER CANNOT CLAIM ANY DAMAGES FROM<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;LESSOR.<br>
<b>&nbsp;26. </b>WINDOW TINTING IS NOT ALLOWED, ANY HIRER APPLYING WINDOW TINT FILM WILL BE RESPONSIBLE FOR FINES AND LESSOR CAN CHARGE<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ANY DAMAGE/REMOVAL CHARGES THAT MAY ARISE DUE TO APPLICATION OF TINT FILM ON THE RENTED CAR.<br>
<b>&nbsp;27. </b>HIRER IS NOT ALLOWED TO LET ANY PERSON, WHICH IS NOT SPECIFIED ON THE CONTRACT, DRIVE THE VEHICLE. DRIVING THE CAR<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;WITHOUT PRIOR PERMISSION FROM LESSOR WILL RESULT IN A 5000 AED PENALTY CHARGE AND POSSIBILITY OF LEGAL ACTION BEING<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TAKEN AGAINST THE HIRER.<br>
<b>&nbsp;28. </b>THE HIRER AGREES TO BEAR ALL LEGAL COSTS INCURRED IN RECOVERING ANY OUTSTANDING AMOUNT OWED BY THE HIRER.<br>

</p>
<!-- ------------------------------------------------------------------------page---------------------------------------- -->


 

<jsp:include page="../../../common/printFooter.jsp"></jsp:include>


<H2></H2>
    <table width="100%">
<tr>
<td width="20%">&nbsp;</td><td width="60%"><img src="<%=contextPath%>/icons/epic.jpg" width="400" height="70"  alt=""/></td><td width="20%">&nbsp;</td>
 
</tr></table>
<br>
<br>

<table width="100%" style="font-size: 10px;font-family: Times new roman">
<tr><td>
<b>&nbsp;&nbsp;<u> SCHEDULE OF CHARGES / FEES: </u></b></br>
</br>
</td></tr>
<tr>
<td>
&nbsp;&nbsp; CALDER CAR RENTAL FZE / CALDER RENT A CAR LLC IS COMMITTED TO ENHANCE THE QUALITY OF SERVICES PROVIDED TO THE HIRER,<br>
 &nbsp;&nbsp; WILL DO ITS BEST TO PROVIDE THE HIRER WITH CLEAN, WASHED VEHICLES ON THE START OF RENTAL CONTRACT, HIRER IS EXPECTED TO<br>
 &nbsp;&nbsp; RETURN THE VEHICLE IN SAME CONDITION AS PROVIDED ON START OF RENTAL CONTRACT, HOWEVER BELOW MENTIONED CHARGES<br>
 &nbsp;&nbsp; ARE APPLICABLE:</br>
 </td></tr>
</table>
 
<table>
<tr><td></td><td></td><td>
<table border=".5"  cellspacing="0" cellpadding="0" width="100%" style="font-size: 10px;font-family: Times new roman">
<tr><td><b>S.NO</b></td>	<td><b>DESCRIPTION OF CHARGES & CONDITIONS</b></td></tr>
<tr><td>1</td>	<td>CLEANING CHARGES (IF VEHICLE RETURNED IN DIRTY CONDITIONS)</td></tr>
<tr><td>2</td>	<td>DELAY IN PAYMENT BEYOND 7 DAYS OF DUE  DATE</td></tr>
<tr><td>3</td>	<td>FINES / TRAFFIC VIOLATIONS (IN ADDITION TO ORIGINAL AMOUNT AS PER AUTHORITIES)</td></tr>
<tr><td>4</td>	<td>DEODORIZING CHARGES (APPLICABLE IN CASE OF SMOKING/DRINKING/EATING IN VEHICLE)	275</td></tr>
<tr><td>5</td>	<td>DELIVERY / COLLECTION CHARGES (ABU DHABI)</td></tr>
<tr><td>6</td>	<td>DELIVERY / COLLECTION CHARGES (DUBAI/SHARJAH)</td></tr>
<tr><td>7</td>	<td>DELIVERY OF ADDITIONAL KEY IN EVENT OF LOSS OF KEY OF VEHICLE (COST OF NEW AS PER AGENCY)	500+COST OF NEW KEY</td></tr>
<tr><td>8</td>	<td>CHEQUE BOUNCE CHARGES</td></tr>
<tr><td>9</td>	<td>MINIMUM LEGAL CHARGE PER CASE OPENING BUT NOT LIMITED TO. ADDITIONAL CHARGES WILL<br>
					<b>apply for lawyers , court fees and other related fees	500/CASE</b>
				</td></tr>
</table>   
 </td> </tr>
 </table>  

<input type="hidden" id="firstarray" name="firstarray" value='<s:property value="firstarray"/>'>  
<input type="hidden" id="secarray" name="secarray" value='<s:property value="secarray"/>'>

</div>
</form>
<!-- </div> -->
</body>
</html>