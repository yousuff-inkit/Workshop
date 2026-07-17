<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
 <%@ page pageEncoding="utf-8" %>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<% String contextPath=request.getContextPath();%>
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
  
<style>
 .hidden-scrollbar {
  overflow: auto;
} 

label {
    font: normal 10px ;
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

ul.a {
	font-size: 10px;
	font-family: Times New Roman;
	align: justify;
}
    
p{
	font-size: 10px;
	font-family: Tahoma;
	align: justify;
}
#para1{
	font-size: 10px;
	font-family: Times New Roman;
	align: justify;
}
.tablereceipt {
    border: 1px solid black;
    border-collapse: collapse;
}

.tableclass {
     border: 1px solid black; 
    border-collapse: collapse;
    height:20px; 
}
.tableclass1 {
     border: 1px solid black; 
    border-collapse: collapse;
    height:40px; 
}
</style> 

</head>
<body bgcolor="white" style="font: 10px Tahoma " >
<div id="mainBG" class="homeContent" data-type="background">
<div class='hidden-scrollbar'>
<form id="frmPrintlease" action="printleaseone" autocomplete="off" target="_blank">
<div style="background-color:white;">

																		<!-- Page 1 -->
																		
<p align="justify"><b><u><center>MASTER HIRE AGREEMENT</center></u></b></p>

<p align="justify">PROGRESS rent a car "PROGRESS", hereafter called “Lessor” rents the vehicle(s) that is/are mentioned in the “Rental/LeaseAgreement,
 Vehicle Check Out Report” to _______________________________, hereafter called the  “Lessee” and is subject to the terms and conditions mentioned below:</p>

<p id="para1" align="justify"><b><u>1)Hire Period</u></b></p>
<p id="para1" align="justify">The period of the hire will be monthly:_____ 1___2___3 ___years.</p>

<p id="para1" align="justify"><b><u>2)Tariff Card, LPO and Delivery</u></b></p>
<p id="para1" align="justify">The Tariff Card attached with the Contract will be valid for all the vehicles 
to be delivered for the period from -to.The Lessee will issue LPO as per the terms mentioned in the contract and based on which the Lessor will deliver 
the vehicle as per the “Rental/Lease Agreement, Vehicle Check Out Report”.</p>

<p id="para1" align="justify"><b><u>3)Lease/Rental, Invoicing & Payment Terms</u></b></p>
<p id="para1" align="justify">Lessor will be invoicing in the beginning of each period (monthly, quarterly, half yearly, yearly,etc. as agreed).<br/>
Rental charges shall be payable in advance at the beginning of each period (or as agreed in writing) by the Lessor at the time of signing the Agreement. In case of 
delay beyond 10 days, Lessee will be liable to pay a late payment fee of 1.5% p/m on the total outstanding.Lessee shall ensure that an official receipt is obtained 
from Lessor for any payment.<br/>
Rental charges are subject to change for reasons beyond the control of the Lessor.</p>

<p id="para1" align="justify"><b><u>4)Payment Terms </u></b></p>
<p id="para1" align="justify">Advance/30 days from invoice date (only for rental/lease invoices).<br/>
<b>Invoices for Fine, Fuel recharge, Insurance Excess, Cleaning charges,Salik, others are to be paid immediately on presentation of the invoice.</b></p>
 
<p id="para1" align="justify"><u>Lessee will transfer monthly dues to Lessor’s bank account with following details:</u></p>
 
 <table width="100%">
  <tr>
    <td width="20%">&nbsp;&nbsp;Bank Name</td>
    <td width="1%">:</td>
    <td width="79%">&nbsp;&nbsp;&nbsp;&nbsp;National Bank of Abu Dhabi</td>
  </tr>
  <tr>
    <td>&nbsp;&nbsp;Address</td>
    <td>:</td>
    <td>&nbsp;&nbsp;&nbsp;&nbsp;PO Box 4, Abu Dhabi, United Arab Emirates</td>
  </tr>
   <tr>
    <td>&nbsp;&nbsp;Branch</td>
    <td>:</td>
    <td>&nbsp;&nbsp;&nbsp;&nbsp;Khalidiya Branch </td>
  </tr>
   <tr>
    <td>&nbsp;&nbsp;Tel</td>
    <td>:</td>
    <td>&nbsp;&nbsp;&nbsp;&nbsp;+ 971 2 611 1111</td>
  </tr>
   <tr>
    <td>&nbsp;&nbsp;Account Name</td>
    <td>:</td>
    <td>&nbsp;&nbsp;&nbsp;&nbsp;PROGRESS RENT A CAR</td>
  </tr>
   <tr>
    <td>&nbsp;&nbsp;Account Number</td>
    <td>:</td>
    <td>&nbsp;&nbsp;&nbsp;&nbsp;6201704264</td>
  </tr>
   <tr>
    <td>&nbsp;&nbsp;Currency</td>
    <td>:</td>
    <td>&nbsp;&nbsp;&nbsp;&nbsp;AED (accepts all currencies)</td>
  </tr>
   <tr>
    <td>&nbsp;&nbsp;Swift Code</td>
    <td>:</td>
    <td>&nbsp;&nbsp;&nbsp;&nbsp;NBADAEAAKHF</td>
  </tr>
</table>
 
 
 <p id="para1" align="justify"><b><u>5)Lessor’s Undertaking</u></b></p>

<ul class="a">
  <li>Provide vehicles as mentioned in the “Individual Agreement/Vehicle Check Out Report” in good condition with clean interior and full tank fuel.</li>
  <li>Provide insurance cover for persons using the vehicle with its permission as per the fleet policy. CDW/PAI provided at extra cost. Insurance will not 
      cover Sabotage/Terrorism/Force Majeure.</li>
  <li>Keep the registration of the vehicle valid.</li>
  <li>Perform maintenance and repair of the vehicle due to normal wear and tear.</li>
  <li>Replace the vehicle during maintenance, repairs and accident. In case of more than three accidents during any given period of 12 months, the replacement 
      period will be limited to 15 days and the extra days will be chargeable as extras. Replacement for accidents will be given only on submission of Police Report.</li>
</ul>
  
<p id="para1" align="justify"><b><u>6)Lessee’s Undertaking</u></b></p>
<ul class="a">
  <li>Provide details of the driver, i.e. the person(s) who will be driving the vehicle, details to be provided are colour copies of the Driving License, Passport and visa page, ID card, Labour Card and to ensure that during the tenure of the contract these documents remain valid.</li>
  <li>Any change in the driver to be intimated to Lessor to comply with the legal requirement and documents mentioned above to be provided.Not to sub-let and give possession to third party and use the vehicle for any illegal purposes.</li>
  <li>To check all fluid levels, tire pressure and accept liabilities for all damages for using the vehicle below the specified limit and to bring the vehicle for periodic maintenance/repairs and registration with prior appointment and as per requirement.</li>
  <li>Pay for any repair of any damage to the vehicle not due to normal wear and tear.</li>
  <li>Inform the Lessor in case of an accident and obtain a Police Report to process an insurance claim and pay insurance excess amount of AED 600 - 2,000 (according to vehicle group, as per tariff/quote) per claim if at fault or “Hit & Run” where third party is not identified. If CDW is purchased and police report is obtained and operating of vehicle is as per/according to/within the UAE law, excess insurance is not applicable.</li>
  <li>Pay all repair and related cost in case Police Report is not obtained due to any reason.</li>
  <li>Accept all liabilities and pay fines and other related expenses incurred due to violation of traffic, municipality and local laws; in addition Lessor will apply service charge of AED 25 per traffic fine and AED 1 perSalik crossing and reserves the right to charge these to the Lessees’ credit card with no preset time limit. On corporate account, invoice to be paid upon receipt. Credit facility does not apply.</li>
  <li>Lessee agrees to transfer any black points on traffic fine to the driver who is driving the vehicle.</li>
  <li>If for any traffic violation the vehicle has to be kept in the Police custody, then the Lessee has to pay the related amount for release of the vehicle or to pay the extra rent for the number of days the vehicle is in police custody.</li>
  <li>Not to repair the vehicle by any unauthorized person and pay AED 50 for exterior cleaning, AED 100 for internal cleaning and AED 300 for shampooing in case the vehicle is returned dirty.</li>
  <li>Return the vehicle on the date as per the agreement, in overall good condition, without apparent defects/damages and with all documents and accessories to the Lessor’s location.</li>
  <li>Return the vehicle with full tank of fuel and if not pay for the fuel as per current PROGRESS fuel tariff (approx. 1.25 x of the actual cost), based on the fuel levels as mentioned in Vehicle Check Out- &In Report.</li>
  <li>The monthly mileage limit will be <font color="#FF0000">5,000</font> kilometers and to inform the Lessor about the mileage every month and to pay for the extra Kilometers at AED<font color="#FF0000">. 0.25</font> per kilometer, unless otherwise agreed in writing.</li>
</ul>
   
<p id="para1" align="justify"><b><u>7)Driver Requirement</u></b></p>
<ul class="a">
  <li>Minimum age of the driver is 25 years.</li>
  <li>Driver on resident visa status must have a valid driving license acceptable to the UAE authorities that is min. 1 year old.</li>
  <li>Driver on visit/tourist status must have an International Driving License and the National Driving License that is min. 1 year old.</li>
 </ul>
 
<p id="para1" align="justify"><font color="#d8d8d8">&nbsp;&nbsp;&nbsp;&nbsp;Lessee signature:__________________________&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Date:__________________&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Stamp:</font></p>
 
 																				<!-- page 2 -->
 																				
<ul> 
  <li>Lessee will provide details of all drivers driving the vehicle(s) and provide colouredcopies of Passport with entry stamp/visa and valid Driving License. This is a statutory requirement and has to be provided to the Lessor before the vehicle is driven by the driver.</li>
  <li>No claim shall be entertained and Lessee shall be responsible for all damages to the Vehicle(s), Passenger(s) and Third party damages in case of any violation unless prior written approval is obtained from the Lessor.</li>
</ul>
   
<p id="para1" align="justify"><b><u>8)Early termination/Possession</u></b></p>
<p id="para1" align="justify">Lessor has the right to terminate the contract and take possession of the vehicle(s) at the expense of the Lessee in case the Lessee does not pay the rental, fines and 
Salik within 10 days from the due date or misuses the vehicle or use of vehicle for illegal/criminal activities or violates any of the terms and conditions mention in this 
and/or the individual Agreement.<br/>

For early termination by the Lessee due to any reason, Lessee agrees to compensate the Lessor as listed below:</p>
 
 <table width="95%" class="tablereceipt" align="center">
  <tr height="25" class="tablereceipt" align="center">
    <td class="tablereceipt" width="25%" align="left">&nbsp;&nbsp;Lease Period</td>
    <td class="tablereceipt" width="75%" align="left">&nbsp;&nbsp;Amount payable on Early Termination</td>
  </tr>  
  <tr height="20" class=tablereceipt>   
	    <td class="tablereceipt" align="left">&nbsp;&nbsp;1 Year</td>
    	<td class="tablereceipt" align="left">&nbsp;&nbsp;<font color="#FF0000">30</font> days rental in the first <font color="#FF0000">9</font> months and <font color="#FF0000">15</font> days after 9 months.</td>
  </tr>
  <tr height="20" class=tablereceipt>   
	    <td class="tablereceipt" align="left">&nbsp;&nbsp;2 Years</td>
    	<td class="tablereceipt" align="left">&nbsp;&nbsp;<font color="#FF0000">60</font> days rental in the first year and 30 days rental in the second year.</td>
  </tr>
  <tr height="20" class=tablereceipt>   
	    <td class="tablereceipt" align="left">&nbsp;&nbsp;3 Years</td>
    	<td class="tablereceipt" align="left">&nbsp;&nbsp;<font color="#FF0000">90</font> days rental in the first  year, 60 days rental in the second year and 30 days rental in the third year.</td>
   </tr>
</table>
  														
<p id="para1" align="justify"><b><u>9)Applicable Laws</u></b></p>

<p id="para1" align="justify">This Agreement shall be governed by UAE laws and jurisdiction of Abu Dhabi courts.</p>
 
<table width="99%">
  <tr height="40">
    <td width="20%">&nbsp;&nbsp;For  Lessor</td>
    <td width="1%">:</td>
    <td width="29%">&nbsp;&nbsp;&nbsp;&nbsp;PROGRESS  rent a car</td>
    <td width="9%">&nbsp;&nbsp;For  Lessee</td>
    <td width="1%">:</td>
    <td width="40%">&nbsp;</td>
  </tr>
  <tr height="40">
    <td>&nbsp;&nbsp;Name</td>
    <td>:</td>
    <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td>&nbsp;&nbsp;Name</td>
    <td>:</td>
    <td>&nbsp;</td>
  </tr>
  <tr height="40">
    <td>&nbsp;&nbsp;Signature</td>
    <td>:</td>
    <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td>&nbsp;&nbsp;Signature</td>
    <td>:</td>
    <td>&nbsp;</td>
  </tr>
  <tr height="40">
    <td>&nbsp;&nbsp;Date</td>
    <td>:</td>
    <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td>&nbsp;&nbsp;Date</td>
    <td>:</td>
    <td>&nbsp;</td>
  </tr>
  <tr height="40">
    <td>&nbsp;&nbsp;Stamp</td>
    <td>:</td>
    <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td>&nbsp;&nbsp;Stamp</td>
    <td>:</td>
    <td>&nbsp;</td>
  </tr>
</table><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

<p id="para1" align="justify"><font color="#d8d8d8">&nbsp;&nbsp;&nbsp;&nbsp;Lessee signature:__________________________&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Date:__________________&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Stamp:</font></p>

</div>   
</form>
</div>
</div>
</body>
</html>