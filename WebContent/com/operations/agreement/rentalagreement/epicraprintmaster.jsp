<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<% String contextPath=request.getContextPath();%>
<title>GatewayERP(i)</title>
<!-- <link rel="stylesheet" type="text/css" href="../../../../css/body.css">  -->
  <jsp:include page="../../../../includes.jsp"></jsp:include>  
<style>
 .hidden-scrollbar {
  overflow: auto;
/*  height: 900px;  */
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
    
p{
	font-size: 8px;
	font-family: Times new roman;
	align: justify;
}

</style> 
<script>
 
 
function gridload(){
	   var indexvals = document.getElementById("docnoval").value;
  
       $("#calcdiv").load("calculationGrid.jsp?rentaldoc="+indexvals);
       
     }  


</script>

</head>
<body onload="gridload();" bgcolor="white" style="font: 10px Tahoma " >
<div id="mainBG" class="homeContent" data-type="background">
<div class='hidden-scrollbar'>
<form id="frmInvoicePrint" action="printrental" autocomplete="off" target="_blank">
 <div style="background-color:white;">
      <table width="100%" >
  <tr>
    <td width="18%" rowspan="6"><img src="<%=contextPath%>/icons/epic.jpg" width="100" height="91"  alt=""/></td> 
    <td width="57%" rowspan="2">&nbsp;</td>
    <td width="25%"><font size="3"><label id="companyname" name="companyname"><s:property value="companyname"/></label></font></td>
  </tr>
  <tr>
    <td><b><label id="address" name="address"><s:property value="address"/></label></b></td>
  </tr>
  <tr>
    <td rowspan="2"  align="center"><b><font size="5">Rental Agreement</font></b></td>
    <td align="left"><b>Tel :</b>&nbsp;<label id="mobileno" name="mobileno"><s:property value="mobileno"/></label></td>
  </tr>
  <tr>
    <td align="left"><b>Fax :</b>&nbsp;<label id="fax" name="fax"><s:property value="fax"/></label></td>
  </tr>
  <tr>
    <td rowspan="2"  align="center"><b>RANO :</b><b><label id="rentaldoc" name="rentaldoc" ><s:property value="rentaldoc"/></label></b>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>MRA NO# :<label id="mrano" name="mrano"><s:property value="mrano"/></label></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <b>RA :</b><b><label  id="rastatus" name="rastatus"><s:property value="rastatus"/></label></b>
     </td>
    <td align="left"><b>Branch :</b>&nbsp;<label id="barnchval" name="barnchval"><s:property value="barnchval"/></label></td>
  </tr>
  <tr>
    <td align="left"><b>Location :</b>&nbsp;<label id="location" name="location"><s:property value="location"/></label></td>
  </tr>
  <tr>
    <td colspan="3"><hr noshade size=1 width="100%"></td>
  </tr>
</table>
<table width="100%" >
  <tr>
  <td width="50%">
  <fieldset>
  <table width="100%"> 
  <tr>
      <td width="18%" align="left" >Name &nbsp;  </td>
    <td width="82%" ><label id="clname" name="clname"><s:property value="clname"/></label></td>
    </tr>
      <tr>
    <td  align="left">Address </td>
    <td height="40px" ><label id="claddress" name="claddress"><s:property value="claddress"/></label></td>
    </tr>
   </table>
  <table width="100%" >
      <tr>
    <td width="18%" align="left">MOB</td>
    <td width="82%"><label id="clmobno" name="clmobno"><s:property value="clmobno"/></label></td>
 </tr>
 <tr>
    <td  align="left">Email  </td>
    <td ><label id="clemail" name="clemail"><s:property value="clemail"/></label></td>
    </tr>
    </table>
</fieldset>
   <fieldset><legend><b>Driver Details</b></legend>
    <table  width="100%" >
   <tr>
      <td width="20%" align="left">Name</td>
    <td width="82%" colspan="3">&nbsp;&nbsp;&nbsp;<label id="radrname" name="radrname"><s:property value="radrname"/></label></td>
      
    </tr>
    </table>
        <table  width="100%" >
    <tr>
        <td  width="23%" align="left">D\L NO</td>
    <td width="77%" colspan="3"><label id="radlno" name="radlno"><s:property value="radlno"/></label></td>
    </tr>
    <tr>
   <td width="22%" align="left">Exp Date</td>
    <td width="20%" colspan="3"><label id="lblaccount" name="licexpdate" ><s:property value="licexpdate"/></label></td>
    </tr>
    <tr>
     <td align="left">Passport NO</td>
    <td colspan="3"> <label name="passno" id="passno" ><s:property value="passno"/></label></td>
    </tr>
    <tr>
    <td width="20%" align="left">Exp Date</td>
    <td width="30%"><label name="passexpdate" id="passexpdate" ><s:property value="passexpdate"/></label></td>
   

    <td width="15%" align="right">DOB&nbsp;&nbsp;</td>
    <td width="30%"><label name="dobdate" id="dobdate" ><s:property value="dobdate"/></label></td>
    </tr>
    </table>
</fieldset>
  <fieldset><legend><b>Additional Driver Details</b></legend>
    <table  width="100%"  >
   <tr>
      <td width="20%" align="left"></td>
          <td width="40%" align="left">Additional Driver One</td>
    
     <td width="40%" align="left">Additional Driver Two</td>
   
    </tr>
     <tr> 
      <td width="" align="left">Name</td>  
        <td width="" ><label id="adddrname1" name="adddrname1"><s:property value="adddrname1"/></label></td>
   
      <td width="" ><label id="adddrname2" name="adddrname2"><s:property value="adddrname2"/></label></td>
   
    </tr>
      <tr>
      <td width="" align="left">D\L NO</td>
        <td width="" ><label id="addlicno1" name="addlicno1"><s:property value="addlicno1"/></label></td>
   
      <td width="" ><label id="addlicno2" name="addlicno2"><s:property value="addlicno2"/></label></td>
   
    </tr>
    <tr>
      <td width="" align="left">Exp Date</td>
        <td width="" ><label id="expdate1" name="expdate1"><s:property value="expdate1"/></label></td>
   
      <td width="" ><label id="expdate2" name="expdate2"><s:property value="expdate2"/></label></td>
   
    </tr>
     <tr>
      <td width="" align="left">DOB</td>
        <td width="" ><label id="adddob1" name="adddob1"><s:property value="adddob1"/></label></td>
   
      <td width="" ><label id="adddob2" name="adddob2"><s:property value="adddob2"/></label></td>
   
    </tr>
    </table>

</fieldset>
<table width="100%"  >
 <tr>
 <td   width="100%">
 <fieldset>

<legend><b>Accidents</b></legend>
By Initialing, you understand any accident, even if you have availed CDW, must be accompanied by a valid police report.
Failure to provide one will result in additional charges. Customer who opt out of CDW will be liable to pay the excess deductible amount of  
<label id="excessinsu" name="excessinsu"><s:property value="excessinsu"/></label>
<table width="100%"  >
<tr><td  width="50%"></td><td width="50%" height="25px" > <fieldset style="height:100%;"></fieldset></td>
</tr>
</table>
</fieldset>
</td>
</tr>
<tr>
<td width="100%">
 <fieldset >
<legend><b>Traffic Fines</b></legend>
By putting your initial in box provided,
 You agree to pay all traffic and parking 
 fines issued to you whilst the vehicle is
  rented in your name, you also agree to pay 
  a 10% admin charge in addition to the fine.
  <table width="100%" >
<tr><td  width="50%"></td><td width="50%" height="25px" > <fieldset style="height:100%;"></fieldset></td>
</tr>
</table>
</fieldset>

 </td>
 </tr>
<tr>
 <td>
 <fieldset width="100%">
<legend><b>Salik (Road tolls)</b></legend>
 By putting your initial in the box provided below you agree to pay salik charges of 4 Dhs for each crossing and 1 Dhs admin fee.
Total 5 Dhs per crossing.These charges will be added to the end of the rental, or as and when we are notified by the RTA.
<table width="100%" >
<tr><td  width="50%"></td><td width="50%" height="25px" > <fieldset style="height:100%;"></fieldset></td>
</tr>
</table>
</fieldset>
 </td></tr>
 </table>
 <br>&nbsp;
 <table width="100%">
 <tr>
 <td>
<b>VEHICLE INSURED FOR UAE TERRITORY ONLY</b>
</td>
</tr>
<tr>
<td>
<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;
</td>
</TR>
</table>

  </td>
  <td width="50%">
  <fieldset>
  <legend><b> Vehicle</b></legend>
     <table width="100%" >  
  <tr>
    
    <td width="52%" ><label id="ravehname" name="ravehname"><s:property value="ravehname"/></label></td>
    <td width="18%" >YOM&nbsp;<label id="rayom" name="rayom"><s:property value="rayom"/></label></td>
    <td width="30%">Color&nbsp;<label id="racolor" name="racolor"><s:property value="racolor"/></label></td>
    </tr>
      <tr>
      <td align="left">Reg NO&nbsp;<label id="ravehregno" name="ravehregno"><s:property value="ravehregno"/></label></td>
 
     <td align="left" colspan="2">Group&nbsp;<label id="ravehgroup" name="ravehgroup"><s:property value="ravehgroup"/></label></td> 
    </tr>
    </table>
    </fieldset>
         <fieldset>
    <legend><b>Out Details</b></legend>  
       <table>
  <tr>
    <th align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
    <th width="25%" align="left">Date</th>
       <th width="10%" align="left">Time</th>
          <th width="22%" align="left">Km</th>
             <th width="19%" align="left">Fuel</th>
             <th width="19%" align="center">Signature</th>
  </tr>
  <tr>
  <td><b><label id="outdetails" name="outdetails"><s:property value="outdetails"/></label></b></td> 
<td><label id="radateout" name="radateout"><s:property value="radateout"/></label></td>
<td><label id="ratimeout" name="ratimeout"><s:property value="ratimeout"/></label></td>
<td><label id="raklmout" name="raklmout"><s:property value="raklmout"/></label></td>
<td><label id="rafuelout" name="rafuelout"><s:property value="rafuelout"/></label></td>
  </tr>
   <tr>
  <td><b><label id="deldetailss" name="deldetailss"><s:property value="deldetailss"/></label></b></td>
<td><label id="deldates" name="deldates"><s:property value="deldates"/></label></td>
<td><label id="deltimes" name="deltimes"><s:property value="deltimes"/></label></td>
<td><label id="delkmins" name="delkmins"><s:property value="delkmins"/></label></td>
<td><label id="delfuels" name="delfuels"><s:property value="delfuels"/></label></td>
  </tr>
 </table>
  </fieldset>     
        
  <%--   <fieldset>
    <legend><b>Out Details</b></legend>
    <table width="100%" >
    <tr>
    <td width="10%" align="left">Date</td>
    <td width="18%"><label id="radateout" name="radateout"><s:property value="radateout"/></label></td>
    <td width="12%" align="right">Time&nbsp;&nbsp;</td>
     <td width="15%"><label id="ratimeout" name="ratimeout"><s:property value="ratimeout"/></label></td>
    </tr>
    <tr>
   
    <td width="10%" align="left">KM</td><td width="25%">
      <label id="raklmout" name="raklmout"><s:property value="raklmout"/></label></td>
      
        <td width="10%" align="right">Fuel&nbsp;&nbsp;</td><td width="30%">
      <label id="rafuelout" name="rafuelout"><s:property value="rafuelout"/></label></td>
    </tr>
    </table>
    </fieldset> --%>
     <fieldset><legend><b>Rental Rates</b></legend>  
      <table  width="100%" >
      <tr>
      <td width="12%"><label id="rarenttypes" name="rarenttypes"><s:property value="rarenttypes"/></label>&nbsp;Tariff</td>   <td align="center" ><label id="tariff" name="tariff"><s:property value="tariff"/></label></td>
       <td width="18%" align="right">CDW&nbsp;&nbsp;</td>   <td align="left" ><label id="racdwscdw" name="racdwscdw"><s:property value="racdwscdw"/></label></td>
    </tr>
    </table>
     
    <table  width="100%"  >
       <tr><td width="15%">Accessories</td><td width="25%"><label id="raaccessory" name="raaccessory"><s:property value="raaccessory"/></label></td>
       <td width="35%">Add Driver Charges </td><td width="25%"><label id="raadditionalcge" name="raadditionalcge"><s:property value="raadditionalcge"/></label></td></tr>
        <tr><td width="15%">Extra KM</td><td width="25%"><label id="raextrakm" name="raextrakm"><s:property value="raextrakm"/></label></td>
       <td width="35%">Extra KM Charge</td><td width="25%"><label id="raexxtakmchg" name="raexxtakmchg"><s:property value="raexxtakmchg"/></label></td></tr>
  </table>
    </fieldset>
     <fieldset>
    <legend><b>In Details</b></legend>  
       <table>
  <tr>
    <th align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
    <th width="25%" align="left">Date</th>
       <th width="10%" align="left">Time</th>
          <th width="22%" align="left">Km</th>
             <th width="19%" align="left">Fuel</th>
             <th width="19%" align="center">Signature</th>
  </tr>
  <tr>
  <td><b><label id="indetails" name="indetails"><s:property value="indetails"/></label></b></td>
<td><label id="indate" name="indate"><s:property value="indate"/></label></td>
<td><label id="intime" name="intime"><s:property value="intime"/></label></td>
<td><label id="inkm" name="inkm"><s:property value="inkm"/></label></td>
<td><label id="infuel" name="infuel"><s:property value="infuel"/></label></td>
  </tr>
   <tr>
  <td><b><label id="coldetails" name="coldetails"><s:property value="coldetails"/></label></b></td>
<td><label id="coldates" name="coldates"><s:property value="coldates"/></label></td>
<td><label id="coltimes" name="coltimes"><s:property value="coltimes"/></label></td>
<td><label id="colkmins" name="colkmins"><s:property value="colkmins"/></label></td>
<td><label id="colfuels" name="colfuels"><s:property value="colfuels"/></label></td>
  </tr>
 </table>
  </fieldset>     
  <%--  <fieldset><legend><b> Closing Details</b></legend> 
     <table width="100%" > 
           <tr>
    <td width="18%" align="left">In KM </td>
    <td width="36%"><label id="inkm" name="inkm"><s:property value="inkm"/></label></td>
 
    <td width="20%" align="left">In Fuel </td>
    <td width="26%"><label id="infuel" name="infuel"><s:property value="infuel"/></label></td>
    </tr>
       <tr>
    <td align="left">In Date </td>
    <td ><label id="indate" name="indate"><s:property value="indate"/></label></td>
 
    <td  align="left">In Time</td>
    <td><label id="intime" name="intime"><s:property value="intime"/></label></td>
    </tr>
     </table>
     </fieldset> --%>
        <table width="100%">
    <tr>
    <td width="100%">
 <div id="calcdiv">
  <jsp:include page="calculationGrid.jsp"></jsp:include></div>
  </td>
  </tr>
  </table> 
  <fieldset width="100%">
    <legend>
     <b>Closing Balance Amount</b></legend>
     <table  width="100%">
      <tr>
     
         
    <td width="25%" align="left">Total Receipt</td>
    <td width="75%">&nbsp;&nbsp;<label id="totalpaids" name="totalpaids"><s:property value="totalpaids"/></label></td>
 </tr>
 <tr>
    <td width="25%" align="left">Invoice Amount </td>
    <td width="75%">&nbsp;&nbsp;<label id="invamount" name="invamount"><s:property value="invamount"/></label></td>
 </tr>
 <tr>
    <td align="left">Balance</td>
    <td >&nbsp;&nbsp;<label id="balance" name="balance"><s:property value="balance"/></label></td>
    </tr>
    
     </table>
    <hr noshade size=1>
     <table  width="100%"   >
           <tr>
    <td>It is important that you have read and understood the terms
     and conditions that  will apply  to this contract before singing.
      Only sign this agreement if you wish to be bound by the terms and conditions 
      over the page. (Arabic translation overleaf is available on the rental 
       wallet) and if you are paying by Credit card, your signature is authorization 
       for Automatic  billing. Your signature also allows us to deduct any additional 
       charges pertaining to this  contract after the rental agreement has been closed.</td>
    </tr>
    <tr>
    <td align="left" ><hr noshade size=1>Customer Signature
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Date</td></tr>
  <!--   <tr> <td align="left" ><hr noshade size=1>Date</td></tr> -->
     <tr> <td align="left" ><hr noshade size=1>Rental Agent
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Date</td></tr>
     <!--  <tr> <td align="left" ><hr noshade size=1>Date</td></tr> -->
      <tr>
      <td align="left">
    <fieldset>
    You are responsible for any damage to the vehicle by striking overhanging objects.
      </fieldset>
      </td>
      </tr>
     </table>
 </fieldset> 
  </td>
    </tr>
  </table>
  
  <!-- Page 2 -->
  
<table width="100%">
<tr>
<td width="32%">

<p align="justify"><b><u>Terms and Conditions.</u></b></p>

<p align="justify"><b>EPIC</b> Rent a Car (referred to as <b>"EPIC"</b>, "we", "us" or "our") rents the vehicle (including any replacement vehicle) to you subject to this Rental Agreement, which incorporates these terms and conditions and the information and conditions contained on the Rental Record that you have signed and on the Rental Wallet. In making this rental you accept the terms of the Rental Agreement and confirm that you will strictly comply with them.</p>

<p align="justify"><b>1.&nbsp;&nbsp;NATURE OF THIS AGREEMENT</b><br/>
1.1- The rights and obligations contained in this Rental Agreement govern your use of our vehicle and are not transferable by you. You acknowledge that the vehicle is owned by us and that any attempted transfer or sub rent of the vehicle by anyone other than us is void. We permit you to use the vehicle on the terms and conditions of this Rental Agreement only</p>

<p align="justify"><b>2.&nbsp;&nbsp;WHO MAY DRIVE THE VEHICLE</b><br/>
2.1 - The vehicle must only be driven by you or any other person who has first been authorised by us and added to the Rental Record and you agree that you will not allow anyone to drive the vehicle, including yourself:<br/>
2.1.1 - who does not fulfil our minimum requirements regarding age and possession of a valid driving licence as indicated for the relevant rate or otherwise notified by us; or<br/>
2.1.2 - who is over-tired or under the influence of alcohol, drugs, medication or any other legal or illegal substance impairing their consciousness or ability to react.</p>

<p align="justify"><b>3.&nbsp;&nbsp;PICK-UP, DELIVERY AND RETURN</b><br/>
3.1 - We will supply the vehicle to you in good overall and operating condition, complete with all necessary documents, parts and accessories.<br/>
3.2 - You agree to return the vehicle to us in the same condition as you rented it, subject to fair wear and tear, with the same documents, parts and accessories, at the location and on the date and time designated in this Rental Agreement.<br/>
3.3 - You and we will check the condition of the vehicle at the start of the rental and on return of the vehicle. An EPIC representative will provide a record showing any agreed defects. You acknowledge that you will be responsible for any loss or damage to the vehicle, its documents, parts or accessories arising during the rental.<br/>
3.4 - The vehicle must be returned to the agreed EPIC location within the normal business hours of the location concerned. If you return the vehicle outside of these hours you must comply with the out of hours return instructions for that location, in which case you will remain fully responsible for the vehicle until the location re-opens for business. If you fail to comply with these instructions, you will remain responsible for the vehicle until we are able to access it.<br/>
3.5 - If at any time we have agreed that you may return the vehicle to a place other than an EPIC rental location, or if we have agreed to collect it, you will remain fully responsible for the vehicle until it is collected by us.<br/>
3.6 - Our rental charges are calculated on the basis of 24 hour periods from commencement of the rental. If you fail to return the vehicle to the agreed return or collection point at or before the vehicle return time stated on the Rental Record, you will be charged an extra day's rental at the relevant daily rate, including charges for any options taken, for every day or part of a day that the car is overdue. This charge is subject to any additional time (or 'grace period') allowed for return by prior agreement with us or in accordance with our current policy (please ask at the rental location for details).<br/>
3.7 - You agree that we are entitled to charge you a reasonable additional cost if the vehicle requires more than our standard cleaning on its return to restore it to its pre-rental condition allowing for fair wear and tear.<br/>
3.8 In the cases of a lease vehicle, you agree to return any replacement vehicle within 24 hours of notification of readiness of leased vehicle, and default thereof to accept charges applicable to such replacement vehicle, in addition to the lease rate.</p>

<p align="justify"><b>4.&nbsp;&nbsp;YOUR RESPONSIBILITY FOR LOSS OR DAMAGE</b><br/>
4.1 - Subject only to any deductions arising from your acceptance of any of the options specified at paragraph 4.2 you will be liable to us for all reasonable losses and costs incurred by us in the event of loss, damage to or theft of the vehicle, its parts or accessories while on rental. Your liability may include the cost of repairs, loss in value of the vehicle, loss of rental income, towing and storage charges and an administration charge, which recovers our costs for handling any claim arising from damage caused to the vehicle unless responsibility for the damage lies with us or has been determined by a third party or their insurers to lie with the third party. If, in our judgement, any damage makes the vehicle unfit for rental, we will endeavour to repair the vehicle as soon as possible. You will not be liable to us for any charge or excess if the loss or damage is directly due to our negligence or breach of this Rental Agreement.
4.2 - Provided you comply with all the terms of this Rental Agreement and provided the loss, damage or theft is not caused intentionally, or by the gross negligence of you or an authorised driver, or by any unauthorised driver, your liability may be limited as follows:<br/>
4.2.1 - if you accept the optional Theft Protection (TP) by paying the daily charge specified, your liability for loss of or damage to the vehicle, its parts or accessories as a result of theft, attempted theft or vandalism is limited to the non-waivable excess stated on the Rental Record;</p>
 
</td>
<td width="2%">&nbsp;</td>
<td width="32%">
<p align="justify">4.2.2 - if you accept the optional Collision Damage Waiver (CDW) by paying the daily charge specified,your liability for loss of or damage to the vehicle, its parts or accessories other than caused by theft, attempted theft or vandalism is limited, for each such incidence of loss or damage arising from a separate event, to the amount of the <b>excess stated on the</b> Rental record; and<br/>
4.3 - You are fully responsible for damage caused by failure to assess the height of the vehicle and striking overhead or overhanging objects. This responsibility is not excluded by any waiver.<br/>
4.4 - To accept charges for tire damage due to negligence (e.g. impact side wall damage) or mechanical damage due to misuse, or any other repairs not attributable to fair wear and tear commensurate with the vehicle’s age and mileage and not recoverable via insurance claim.</p>
<p align="justify"><b>5.&nbsp;&nbsp;PROHIBITED USE OF THE VEHICLE</b><br/>
5.1 – You are authorised to drive the vehicle on the conditions contained in this paragraph 5 and paragraph 2 above including, at all times, to use the vehicle in a responsible manner. If you do not comply with these conditions, you will be liable to us for any liability or reasonable loss incurred by us or any damages or reasonable expenses we suffer or incur as a result of your breach. You may additionally lose the benefit of any waivers or insurance selected by you. We reserve the right to take back the vehicle at any time, and at your expense, if you are in breach of this Rental Agreement.<br/>
5.2 – You must look after the vehicle, make sure it is locked, secure and parked in a safe place when not in use and set and use any security device provided. You must remove and keep in a safe place any removable radio and/ or radio faceplate when the vehicle is unoccupied. You must use seat belts, child seats and other child restraints as appropriate.<br/>
5.3 – You must use the correct fuel and check the oil and other fluid gauges beyond 600 miles, refilling as necessary. If you experience any problem due to accident or mechanical failure, you must contact us on the number indicated on the Rental Wallet. No one may service or repair the vehicle without our prior express permission.<br/>
5.4 – You must not use the vehicle or allow it to be used:<br/>
5.4.1 – to carry passengers for remuneration;<br/>
5.4.2 - to carry cargo for remuneration (except in the case of trucks and vans);<br/>
5.4.3 to tow or push any vehicle, trailer or other object (without our express permission);<br/>
5.4.4 off road for recreational purposes, sand dunes and wadi driving  or on roads unsuitable for the vehicle; <br/>
5.4.5 when it is overloaded or when loads are not properly secured; <br/>
5.4.6 for carrying any object or any substance which, because of its condition or smell may harm the vehicle and/ or delay our ability to rent the vehicle again;<br/>
5.4.7 to take part in any race, rally, test or other contest;<br/>
5.4.8 in contravention of any traffic or other regulations;<br/>
5.4.9 for any illegal purpose;<br/>
5.4.10 for sub-renting;<br/>
5.4.11 to drive or be driven in restricted areas including, but not limited to, airport runways, airport service roads and associated areas;<br/>
5.4.12 for driver training activity; or<br/>
5.4.13 in contravention of any of the driver requirements contained in paragraph 2 above.<br/>
5.5 – Unless you have obtained our prior written consent, the vehicle may not be taken outside the United Arab Emirates,</p> 
<p align="justify"><b>6.&nbsp;&nbsp;PAYMENT OF CHARGES</b><br/>
If you do not pay any of the charges owing to us under this Rental Agreement within the time indicated on your statement of account, we reserve the right to charge you interest in addition to the outstanding charges, at a rate of 3% above the one month inter-bank base lending rate. We also reserve the right to charge your credit card for any unpaid traffic or toll fees arriving after the contract is closed.</p>
<p align="justify"><b>7.&nbsp;&nbsp;CHARGES</b><br/>
7.1- The charges stated on the Rental Record reflect your use of the vehicle as agreed between us at the start of your rental and include the basic rental charges; charges for any optional or ancillary services chosen by you; and any applicable taxes at the prevailing rate.<br/>
7.2 - The basic rental charge is made for a minimum of one rental day (the 24 hour period starting from the time the rental begins) and, unless otherwise agreed, includes a charge for compulsory third party insurance and, if applicable, a Vehicle Licence Fee (which passes on your share of any compulsory charges we incur for keeping the vehicle on the road). A Location Service Charge may be made to reflect the higher cost of renting from certain locations. A Young Driver Surcharge may apply if you or any additional driver is under 25 years old.<br/>
7.3 - Additional charges may arise from your use of the vehicle during the rental, and may include loss of or damage to the vehicle, a refuelling service charge, late return charge, non-smoking charge, additional driver charge, extra cleaning charge and any road tolls or fines or charges arising from traffic or parking offences during the rental.<br/>
7.4 - All charges are calculated in accordance with our current rates and subject to final calculation after the rental.<br/>
7.5 - An excess kilometers charge of 0.35 Fils, which we will charge for each kilometer over the standard kilometer limit of 60,000 per year or 5000 per month. We will use the vehicle’s odometer to calculate the number of excess Kilometers.</p>

</td>
<td width="2%">&nbsp;</td>
<td width="32%">

<p align="justify"><b>8.&nbsp;&nbsp;REFUELLING SERVICE CHARGE</b><br/>
8.1 - The rental vehicle will be supplied to you with a full tank of fuel. If you return the vehicle with less than a full tank of fuel,a refuelling<br/>
service charge will be payable by you for fuel and the service of refuelling at the applicable rate specified on the Rental Agreement.</p>

<p align="justify"><b>9.&nbsp;&nbsp;RESPONSIBILITY FOR PROPERTY</b><br/>
9.1 - We are not liable to you or any authorised driver or passenger for loss of or damage to property left in the vehicle either during or after the period of rental unless the loss or damage results from our negligence or breach of this Rental Agreement. Such property is entirely at your own risk, unless covered by Personal Insurance.</p> 

<p align="justify"><b>10.&nbsp;&nbsp;THIRD PARTY LIABILITY INSURANCE</b><br/>
10.1. To keep the vehicle insured for loss; damage, including personal accident cover for driver (only) and unlimited Third Party Liability in respect of death and bodily injury as may be awarded by the Court in U.A. E. and for property damage up to a maximum of Dhs. 500,000.00. The cover is in accordance with the Lessor current insurance policy which is available on request and which the Lessee is presumed to have accepted by signing this lease agreement.<br/>
10.2 - Our automobile liability insurance policy meets all legal requirements and protects us, you and any authorised driver against legal claims from any other person for death or personal injury or damage to any other person's property caused by use of the vehicle.<br/>
10.3 - In the event that any third party suffers death, personal injury or damage to property caused by use of the vehicle which involves a breach by you or any authorised driver of any of the terms and conditions of this Rental Agreement, you agree to reimburse us if we are obliged to compensate (i) the insurers for any payment they make to a third party on your behalf and/ or (ii) any third party.</p>

<p align="justify"><b>11.&nbsp;&nbsp;ACCIDENTS, THEFT AND VANDALISM</b><br/>
11.1 - You must, where possible, report any traffic accident, loss, damage or theft involving the vehicle to the police immediately and to us within 24 hours of the incident or discovery of the incident. A valid Police report must be accompanied on return. Failure to supply a valid Police report could result in additional rental charges until such time one is provided.<br/>
11.2 - EPIC accident or theft report form must always be completed and submitted to us when you return the vehicle. In the event of theft, you must return the keys and any remote control anti-theft device to us. If you do not comply with the requirements of this paragraph 12, any optional coverage you take to reduce or eliminate your liability, such as CDW or TP (in case of theft) will be void.<br/>
11.3- You agree to co-operate with us and our insurers in any investigation or subsequent legal proceedings arising out of any loss of or damage to the vehicle.</p>

<p align="justify"><b>12.&nbsp;&nbsp;LIMITS ON LIABILITY</b><br/>
12.1, we shall not be liable to you or any third party for any loss or damage arising from the rental other than as a result of our negligence or wilful misconduct or any other breach by us of this Rental Agreement. We shall not be liable for any indirect or unforeseeable loss or damages, including loss of profits or loss of opportunity.</p>

<p align="justify"><b>13.&nbsp;&nbsp;ROAD TOLLS, PARKING FINES AND TRAFFIC VIOLATIONS</b><br/>
13.1 - You are fully responsible for all road tolls Salik charges or associated costs, you agree that we may charge you with the amount of any fine plus a reasonable administration charge of 1 Dhs per crossing for dealing with these matters. Max charge per crossing is 5 Dhs<br/>
13.2 – We are required to pay such road tolls, fines, charges or associated costs on your behalf, you agree that we may charge you with the amount of any fine plus a reasonable administration charge of 10% for dealing with these matters.<br/>
13.3 - We shall, upon request, supply you with a copy of any traffic violation notice which we receive.</p> 

<p align="justify"><b>14.&nbsp;&nbsp;PERSONAL DATA</b><br/>
14.1 - By entering this Rental Agreement you consent to the computer storage and processing of your personal information by us in connection with this Rental Agreement for the purposes of our legitimate interests, including statistical analysis, credit control and protection of our assets. Accordingly, if you breach this Rental Agreement your personal data may be disclosed or passed to third parties to the extent necessary to assist recovery procedures or prevent damage to our assets.</p>

<p align="justify"><b>15.&nbsp;&nbsp;INTERPRETATION</b><br/>
15.1 -	If any provision of this Rental Agreement shall be held to be invalid, illegal or unenforceable (in whole or in part) under applicable law such provision or part shall to that extent be deemed not to form part of this Rental Agreement but the remainder of this Rental Agreement shall continue in full force and effect.</p>

<p align="justify"><b>16.&nbsp;&nbsp;APPLICABLE LAW</b><br/>
We aim to resolve all disputes amicably. If this is not possible, the law of the United Arab Emirates will apply.</p> 
<br/><br/><br/>

</td>
</tr></table>
 </div>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="docnoval" id="docnoval" value='<s:property value="docnoval"/>'  />
</form>
</div>
</div>
</body>
</html>
    