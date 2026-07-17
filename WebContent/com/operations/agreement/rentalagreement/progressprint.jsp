<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
 <%@ page pageEncoding="utf-8" %>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<% String contextPath=request.getContextPath();%>
<!--  <title>GatewayERP(i)</title> --> 
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
.tablereceipt {
    border: 1px solid black;
    border-collapse: collapse;
}

#para1{
	font-size: 8.5px;
	font-family: Times New Roman;
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
      <table width="100%"  >
  <tr>
    <td width="22" rowspan="6" ><img src="<%=contextPath%>/icons/epic.jpg" width="200" height="70"  alt=""/></td> 
    <td width="52%" rowspan="2">&nbsp;</td>
    <td width="26%"><b><label id="companyname" name="companyname"><s:property value="companyname"/></label></b></td>
  </tr>
  <tr>
    <td><b><label id="address" name="address"><s:property value="address"/></label></b></td>
  </tr>
  <tr>
    <td rowspan="2"  align="center"><b><font size="4"> &nbsp;&nbsp; &nbsp;&nbsp;Rental Agreement</font></b></td>
    <td align="left"><b>Tel :</b>&nbsp;<label id="mobileno" name="mobileno"><s:property value="mobileno"/></label></td>
  </tr>
  <tr>
    <td align="left"><b>Fax :</b>&nbsp;<label id="fax" name="fax"><s:property value="fax"/></label></td>
  </tr>
  <tr>
    <td rowspan="2"  align="center"><b>&nbsp;&nbsp;RANO :</b><b><label id="rentaldoc" name="rentaldoc" ><s:property value="rentaldoc"/></label></b>
    &nbsp;&nbsp; <b>MRA NO# :<label id="mrano" name="mrano"><s:property value="mrano"/></label></b>&nbsp;&nbsp; 
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
By initialing, I understand that in case of accident, even though availed CDW, must be accompanied by a valid police report. If without CDW, I will be liable to pay excess deductible amount of  AED .<label   id="excessinsu" name="excessinsu"><s:property value="excessinsu"/></label>

<table width="100%"  >
<tr><td  width="50%"></td><td width="50%" height="25px" > <fieldset style="height:100%;"></fieldset></td>
<%-- <label style="text-align: right;display: block;" id="excessinsu" name="excessinsu"><s:property value="excessinsu"/></label> --%>
</tr>
</table>
</fieldset>
</td>
</tr>
<tr>
<td width="100%">
 <fieldset >
<legend><b>Traffic/Parking Fines/Salik (Toll)</b></legend>
By initialing, I agree to pay all traffic/parking/other fines plus AED.<!-- .25/- --><label   id="trafficcharge"><s:property value="trafficcharge"/></label>/-per fine and plus AED <label id="salikcharge"><s:property value="salikcharge"/></label> /- per Salik crossing  as surcharge, occurring during the agreement period. 
  <table width="100%" >
<tr><td  width="50%"></td><td width="50%" height="25px" > <fieldset style="height:100%;"><%-- <label style="text-align: right;display: block;" id="trafficcharge"><s:property value="trafficcharge"/> </label> --%></fieldset></td>
</tr>
</table>
</fieldset>

 </td>
 </tr>
<tr>
 <td>
<%--  <fieldset width="100%">
<legend><b>Salik (Road tolls)</b></legend> 
 By putting your initial in the box provided below you agree to pay salik charges of 4 Dhs for each crossing and  <label id="salikcharge"><s:property value="salikcharge"/></label> Dhs admin fee.
Total <label id="totalsalikandtraffic"><s:property value="totalsalikandtraffic"/></label> Dhs per crossing.These charges will be added to the end of the rental, or as and when we are notified by the RTA.
<table width="100%" >
<tr><td  width="50%"></td><td width="50%" height="25px" > <fieldset style="height:100%;"></fieldset></td>
</tr>
</table>
</fieldset> --%>
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
<td>&nbsp;
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
<%--      <fieldset><legend><b>Rental Rates</b></legend>  
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
    </fieldset> --%>
    
    
        <fieldset><legend><b>Rental Rates</b></legend>  
      <table  width="100%"  >
   
        <tr> <td width="40%">Rent Type</td><td  width="20%" align="right"><label id="rarenttypes" name="rarenttypes"><s:property value="rarenttypes"/></label></td><td  width="30%" >&nbsp; </td></tr>
        
       <tr> <td width="40%">Tariff</td><td  width="20%" align="right"><label id="tariff" name="tariff"><s:property value="tariff"/></label></td><td  width="30%" >&nbsp; </td></tr>
                
      <tr> <td width="40%">CDW</td><td  width="20%" align="right"><label id="racdwscdw" name="racdwscdw"><s:property value="racdwscdw"/></label></td><td  width="30%" >&nbsp; </td></tr>
                        
      <tr> <td width="40%">PAI</td><td  width="20%" align="right"><label id="lblpai" name="lblpai"><s:property value="lblpai"/></label></td><td  width="30%" >&nbsp; </td></tr>
      
      
       <tr> <td width="40%">Accessories</td><td  width="20%" align="right"><label id="raaccessory" name="raaccessory"><s:property value="raaccessory"/></label></td><td  width="30%" >&nbsp; </td></tr>
       
              <tr> <td width="40%">Delivery Chrges</td><td  width="20%" align="right"><label id="laldelcharge" name="laldelcharge"><s:property value="laldelcharge"/></label></td><td  width="30%" >&nbsp; </td></tr>
      
                    <tr> <td width="40%">Add Driver Charge</td><td  width="20%" align="right"><label id="raadditionalcge" name="raadditionalcge"><s:property value="raadditionalcge"/></label></td><td  width="30%" >&nbsp; </td></tr>
                    
                <tr> <td width="40%">Chaufer Charge</td><td  width="20%" align="right"><label id="lblchafcharge" name="lblchafcharge"><s:property value="lblchafcharge"/></label></td><td  width="30%" >&nbsp; </td></tr>      
                    
              <tr> <td width="40%">Restrict KMS</td><td  width="20%" align="right"><label id="raextrakm" name="raextrakm"><s:property value="raextrakm"/></label></td><td  width="30%" >&nbsp; </td></tr>  
              
              
                <tr> <td width="40%">Excess KM Rate</td><td  width="20%" align="right"><label id="raexxtakmchg" name="raexxtakmchg"><s:property value="raexxtakmchg"/></label></td><td  width="30%" >&nbsp; </td></tr>
                   
                    
<%--       <tr>
      <td width="12%"><label id="rarenttypes" name="rarenttypes"><s:property value="rarenttypes"/></label>&nbsp;Tariff</td>   <td align="center" ><label id="tariff" name="tariff"><s:property value="tariff"/></label></td>
       <td width="18%" align="right">CDW&nbsp;&nbsp;</td>   <td align="left" ><label id="racdwscdw" name="racdwscdw"><s:property value="racdwscdw"/></label></td>
    </tr>
    </table>
     
    <table  width="100%"  >
       <tr><td width="15%">Accessories</td><td width="25%"><label id="raaccessory" name="raaccessory"><s:property value="raaccessory"/></label></td>
       <td width="35%">Add Driver Charges </td><td width="25%"><label id="raadditionalcge" name="raadditionalcge"><s:property value="raadditionalcge"/></label></td></tr>
        <tr><td width="15%">Extra KM</td><td width="25%"><label id="raextrakm" name="raextrakm"><s:property value="raextrakm"/></label></td>
       <td width="35%">Extra KM Charge</td><td width="25%"><label id="raexxtakmchg" name="raexxtakmchg"><s:property value="raexxtakmchg"/></label></td></tr> --%>
  </table>
    </fieldset>
    
    
    
    
    
    
    
    
    
    
    
    
    
<%--     
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
  </fieldset>      --%>
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
<%--  <div id="calcdiv">
  <jsp:include page="calculationGrid.jsp"></jsp:include></div> --%>
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
    <td><!-- It is important that you have read and understood the terms
     and conditions that  will apply  to this contract before singing.
      Only sign this agreement if you wish to be bound by the terms and conditions 
      over the page. (Arabic translation overleaf is available on the rental 
       wallet) and if you are paying by Credit card, your signature is authorization 
       for Automatic  billing. Your signature also allows us to deduct any additional 
       charges pertaining to this  contract after the rental agreement has been closed. -->
       I have read and understood the terms & conditions above and overleaf and agree with my signature to the same and acknowledge that 
       a) Disclaimer b) Credit Card Authorization  c) Vehicle Checklist (for original and replacement vehicles) are part of this agreement.</td>
    </tr>
    <tr>
    <td align="left" ><hr noshade size=1>Customer Signature
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Date
    <br><br><br><br><br>
    
    </td></tr>
  <!--   <tr> <td align="left" ><hr noshade size=1>Date</td></tr> -->
     <tr> <td align="left" ><hr noshade size=1>Rental Agent
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Date    <br><br><br><br><br></td></tr>
     <!--  <tr> <td align="left" ><hr noshade size=1>Date</td></tr> -->
     <!-- <tr>
      <td align="left">&nbsp;
      </td>
      </tr>-->
     </table>
 </fieldset> 
  </td>
    </tr>
  </table>
 <!-- <br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp; <br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp; <br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp; 
  <br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp; -->
 <!-- Page 2 -->
  	<div style="page-break-after:always;"></div>				
<table width="100%">
<tr>
	<td width="20%">&nbsp;</td><td width="60%"><img src="<%=contextPath%>/icons/epic.jpg" width="400" height="40"  alt=""/></td><td width="20%">&nbsp;</td>
</tr>
</table>

<p align="justify"><b><u><center>STANDARD TERMS AND CONDITIONS OF RENTAL</center></u></b></p>

<p align="justify">The Lessor mentioned overleaf, in the following called PROGRESS rent a car (PRAC), hereby rents the vehicle identified overleaf and replacements there to, to Customer/Driver 
subject to all Terms and Conditions on the front page and this page and Customer/Driver on consideration thereof agrees to them as the essence of the Agreement.</p>

<p id="para1" align="justify"><b>1. <u>Delivery and Return:</u></b> The vehicle is delivered to the Customer/Driver  in good overall condition and without apparent defects and 
complaints as to its condition must be made known to the Lessor &nbsp;&nbsp;immediately on delivery. The Customer/Driver  agrees to return it with all documents and accessories 
and in the same condition to the Lessor at the location and on the date designated in this &nbsp;&nbsp;Agreement. The Lessor reserves the right to repossess the vehicle at any 
time without demand at Renter's expense  if vehicle is used in violation of this Agreement.<br/>

<b>2. <u>Age and Driving License:</u></b>  Minimum age of Driver to be 25 years. Driving license to be one year old. UAE residents can drive with UAE driving license only. Visit/tourist visa holders can drive with International License that are valid in UAE, if their home country license is more than one year old.<br/>

<b>3. <u>Damage, Accident,  Loss, Theft, etc:</u></b> .:  In the event of damage to or loss or theft of the vehicle or parts of it, including fire and breakage of glass,
 the Customer/Driver shall, irrespective of his/her or the driver's fault, pay to the Lessor the amount of all resulting loss and expenses of the Lessor
 (including but not limited to replacement or recovery costs, repair costs, compensation for decline in value and loss of the Rental fee), if the Customer/Driver
  or the driver violated these Standard Terms and Conditions of Rental Agreement, any legal provisions (also customs regulations) or insurance regulations. As loss of revenue,
   the Lessor may charge a compensation corresponding to the Rental charge, until the day the vehicle or a replacement vehicle will again be available to the Lessor. In case of an accident,
    natural calamity (with or without damage to the vehicle) and in case of any personal injuries, the police must be called to the scene of the eventand Customer/Driver must insist on obtaining
     a Police Report. In case of theft of the vehicle or Parts of it, Customer/Driver must report this to the police and obtain a Police Report and forward the said Police Report to the Lessor within 24 hours of the event.
      Upon request of the Lessor, an accident report must be completed. Customer/Driver must secure all data of all other parties as well as of any witnesses to complete said accident report. Under no circumstances, 
      claims by third parties must be accepted by the Customer/Driver. The Customer/Driver is obliged to assist the Lessor and/or its insurance companies in all claims or legal affairs about an accident or any damage.
      These responsibilities of the Customer/Driver shall apply accordingly in case of theft. No repairs are to be carried out on the vehicle without the prior approval of the Lessor. If the Customer/Driver violates any of these regulations, 
      especially if no Police Report can be presented to the Lessor within 24 hours, even an accepted and paid CDW may not release Customer/Driver from indemnities.<br/>

<b>4. <u>Replacement vehicle:</u></b> Lessor will provide a replacement vehicle for the duration of maintenance, servicing and damage repairs of the original vehicle, 
subject to clearing all due payments. The type of vehicle will be the closest available group from the daily rental fleet. A replacement vehicle for any damaged vehicle will only be supplied, 
following the submission of a Police Report and clearing all due payments. Replacement vehicle may not be available if the Rental vehicle is returned to the Lessor for normal general service just before public holidays or weekends.
 Customer/Driver undertakes to monitor and bring the vehicle to Lessor for periodic maintenance/repairs and registration on demand from Lessor or with prior appointment.
  Customer/Driver is responsible for collecting the vehicle within a maximum of 24 hours after being informed of the completion of repairs, failing which Lessee is liable to pay daily tariff rental rate, 
  as additional charge for delaying the return of replacement vehicle, until such time the replacement vehicle has been returned to the Lessor.  In the event of the leased vehicle being rendered totally unfit for use, 
  Lessor shall at its own discretion either provide the Customer/Driver with a replacement vehicle or issue a credit note if applicable or otherwise release the Customer/Driver from its payment obligations under this Agreement.
   Fuel used for Rental replacement/original vehicle/s + fuel used for original/replacement vehicle/s transfer to and from garage for service/maintenance/repair, will be paid by the Renter / Lessee. For frequent accidents,
    the number of total replacement days per annum is limited to 21 days.<br/>

<b>5. <u>Charges:</u></b> Customer/Driver shall pay any charges shown on the front page or mentioned in the current tariffs including Rental, cost of fuel, Mawaqif, 
Salik (AED 5 p/crossing. Subject to change if Salik charge increased by local authorities), RTA, Traffic Fines, SAAED, 
Municipality and respective service charge fees (AED 25 p/fine). If required by the Lessor, Customer/Driver undertakes to clear black points/fines 
directly with the authority immediately, without any delay and inform Lessor accordingly. 
Cleaning charges from AED 50-500 is applicable in case the vehicle is returned stained/ dirty.<br/>

<b>6. <u>Payment Terms:</u></b> Daily/weekly/monthly rental: advance for entire rental duration. All the above categories will also require a pre-authorization of a minimum 
of AED 1,000 to cover Salik, RTA, Mawaqif, Traffic fines, SAAED, etc.Corporate customers must release the payment as per 
the terms which is mutually agreed by both parties.  Lessor has the right to terminate the contract and take possession of the vehicle at the expense 
of the Customer/Driver in case charges (rental, fines, Salik) are not cleared within 7 (seven) days of due date. 
For delayed payment: Late payment fee will be charged at 1.5% per month of total outstanding.<br/>

<b>7. <u>Invoice Submission:</u></b> Invoice will be submitted to the customer / client by beginning of every month as per the agreed invoice rules.<br/>

<b>8. <u>Indemnity: </u></b>The Lessor is only responsible for loss or damage suffered by Customer/Driver or Third Parties - limited
 to PRAC Insurance Policy, about the renting or the rented vehicle, where such loss or damage was caused intentionally or through gross negligence on its part.
  In all cases, the Lessor cannot accept any such liability and Customer/Driver shall hold the Lessor harmless against such claims. The Customer/Driver shall indemnify and hold harmless the Lessor, 
  its employees and agents from and against any loss, liability and expense arising directly in or directly from: a) any breach of terms of this Agreement by Customer/Driver; b) loss of or damage to the vehicle; 
  c) death or injury to any person arising out of the operation or usage of the vehicle; d) loss of or damage to any property suffered by Customer/Driver or by third parties arising out of the operation or usage of the vehicle 
  or for loss of or damage to Renters/Lessees property left in the vehicle or for loss or inconvenience resulting from delivery delays, breakdown or any cause beyond Lessor's control.<br/>

<b>9. <u>Conditions of use:</u></b> The Customer/Driver is expected to look after the vehicle carefully and in particular not allow it to be used: a) to carry persons or property for hire, 
except in the case of trucks; b) to propel or tow any vehicle, trailer or other object; c) in any race, test or contest, 
or  off-road/through water driving; d) while Customer/Driveror any other driver of vehicle is under the influence of 
alcohol, hallucinatory drugs, narcotics, barbiturates or any other substance impairing his/her consciousness or ability 
to react; e) in contravention of any customs, traffic, insurance policy or other regulations; f) by any person other than 
Customer/Driver unless such person has been previously designated by the Lessor in the space provided on the front page of 
this Agreement; g) outside the country of rental unless otherwise pre-authorized by written permission of the Lessor, 
h) in geographical areas which have been defined by the Lessor as restricted ones, 
i) the Customer/Driver undertakes to make sure of the car condition by periodically checking of the oil, water, 
tire pressure and inform the Lessor of any mechanical, electrical or tire problem. The Customer/Driver needs to report 
to the Lessor any signal that appears on the car screen for warning of any type of maintenance. The Customer/Driver 
shall bear any damages because of driver misuse, including an administration fee (Minimum AED. 2,000/-  up to 25% of the 
total repair cost) from not reporting this fault and continuing to drive the vehicle. 
Tire replacement due to Renter's/Lessee's negligence and punctures will be at the Customer/Driver and expense 
in this case' replacement vehicle shall not be provided. J) Customer/Driver is aware of the obligation to follow 
Road Traffic Rules, in case of any traffic offence occurs, Customer/Driver agrees to pay the company the compensation 
amount for vehicle if impounded by the police + the respective fines and black points for each such occurrence during 
the time of rental period + agrees to accept any transferrable fines/black points. 
K) Customer/Driver agrees to if necessary and without delay, to visit the respective traffic department to clear any 
fines/black points. Tinting of rented/leased vehicle is strictly prohibited by UAE authorities. Fines are responsibility 
of Customer/Driver. L) Customer/Driver agrees to provide color copies of all documents like Passport with valid visa page, 
Emirates id, Credit card, valid Driving license, and to provide renewed documents on expiry of any.<br/>

<b>10. <u>Insurance:</u></b> The Lessor provides insurance coverage for the authorized persons using the vehicle with its 
permission (and not otherwise) in accordance with an automobile liability insurance policy, which is available for 
inspection upon written request, and this will form part of this Agreement. Collision Damage Waiver (CDW): 
By placing his/her initials in the space "Accept" on the front page, the Customer/Driver assumes the obligation to 
periodic payment of a supplementary fee in accordance with valid price list. Otherwise in case of damages to or 
loss or theft of the vehicle or parts of it, Customer/Driver shall be liable to pay an insurance excess as per 
valid price list, unless otherwise specified, in accordance with Clause 2 of these Standard Terms and Conditions of 
Rental Agreement. The Collision Damage Waiver does not exempt from liability in case of negligence or contravention 
of the Rental conditions, legal regulations or insurance conditions. Personal Accident Insurance (PAI): By placing his/her 
initials in the space Accept on the front page, the Customer/Driver agrees to pay an additional fee as per valid price 
list. Driver's age 23-25 years or driving license less than one year damage at fault or without 3rd party 25% of 
total repair cost with a minimum of AED 2,000 is the Renter's /Lessee'sresponsibility.<br/>

<b>11. <u>Identification marks:</u></b> The Customer/Driver is not authorized to place any identification marks on the rented vehicle. 
Customer /Driver will be responsible for any violation of this including the penalties/legal action.<br/>

<b>12. <u>Mileage:</u></b> Unless otherwise specified, the following applies, the mileage is agreed to be unlimited up to a maximum of: a) 5,000 km per month (MONTHLY)b) 1,500 km per week (WEEKLY), c) 300 km per day (DAILY).
 Any mileage that is more than above will be subject to an excess mileage charge at ratesspecified, this charge will be applied periodically as per the contract duration where relevant. 
<br/>

<b>13. <u>Documents:</u></b>Credit card authorization letter, Disclaimer form and Vehicle check in/out forms and any other documents issued will form integral part of this rental agreement.<br/>

<b>14. <u>Personal Data:</u></b> The Customer/Driver acknowledges that the personal data on the Rental Agreement will be kept as part of the Lessor's database. 
The Customer/Driver agrees expressly that the data can be communicated to third parties, especially for credit protection purposes. 
The Customer/Driver commits to immediately inform the Lessor of any change to contact/personal data details.<br/>


<b>15. <u>Governing Law & Jurisdiction:</u></b> This agreement in all respects be governed by and be construed and 
interpreted and take effect in accordance with the law of the United Arab Emirates, applicable to the Emirate where 
it is executed and the parties hereto irrevocably submit to the non exclusive jurisdiction of the courts of such Emirate.<br/>

<b>16. <u>Language:</u></b> The language acceptable for this contract is English only unless the court of law demands legal Arabic translation.</p>
					
<b><center><font color="#a52a2a">SAFETY FIRST! SAFETY FIRST! SAFETY FIRST! SAFETY FIRST! SAFETY FIRST!&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></center></b>

<table width="100%">
<tr>
<td width="40%">

<p id="para1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&diams;&nbsp;&nbsp; Always fasten your seat belt.<br/>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&diams;&nbsp;&nbsp; Drive with stipulated speed limits.<br/>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&diams;&nbsp;&nbsp; Cross traffic junction only when green.<br/>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&diams;&nbsp;&nbsp; Do not seat young children in the front.<br/>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&diams;&nbsp;&nbsp; Do not enter the left yellow line (hard shoulder).
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br/>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&diams;&nbsp;&nbsp; Overtake only from left and always use indicator.
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </p>

</td>

<td width="2%">&nbsp;</td>

<td width="58%">

<p id="para1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&diams;&nbsp;&nbsp; Obey traffic instructions & be watchful of road signs.<br/>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&diams;&nbsp;&nbsp; Never drive after consuming any narcotic substances.<br/>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&diams;&nbsp;&nbsp; Do not carry inflammable, hazardous materials in your vehicle.<br/>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&diams;&nbsp;&nbsp; Avoid using mobile phone while driving. If you must, always use hands-free.<br/>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&diams;&nbsp;&nbsp; Ensure tires, brakes, head & brake lights + side indicators are in good working 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; condition.<br/>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&diams;&nbsp;&nbsp; Think ahead and do not make impulsive deviations. Change lanes only after 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; indicating your move.</p>

</td>
</tr>
</table>
<b><center><font color="#191970">The PRAC Team wishes you safe driving!</font></center></b>


<!-- ------------------------------page 3-------------------------------- -->
<div style="page-break-after:always;"></div>
<table width="100%">
<tr>
<td width="20%">&nbsp;</td><td width="60%"><img src="<%=contextPath%>/icons/epic.jpg" width="400" height="70"  alt=""/></td><td width="20%">&nbsp;</td>
 
</tr></table>
<br><br><br><br>
<table width="100%">

<tr  >  <td width="100%"> From: <u><label id="clname" name="clname"><s:property value="clname"/></label></u></td> </tr>

<tr  >  <td width="100%"> &nbsp;<br><br></td> </tr>
<tr  >  <td width="100%"> &nbsp;<br><br></td> </tr>
<tr> <td width="100%">To: PROGRESS  rent  a  car</td></tr>
</table>

<table  width="100%">

<tr  > <td width="100%" align="center"><font size="4"><u>Authorization Letter</u></font></td> </tr>


<tr  > <td width="100%" align="center">&nbsp;<br><br></td></tr>
<tr  > <td width="100%" align="left">I hereby authorize PROGRESS rent a car to charge my credit card no:&nbsp;<label id="lbcardno" name="lbcardno"><s:property value="lbcardno"/></label></td></tr> 

</table>
<br>
<table  width="100%" border="" class="tablereceipt">

 <tr>
 <td width="100%"  height="100"></td>
 </tr>
</table><br><br>
<table  width="100%"  >

<tr  > <td width="40%" align="left">Expiry Date:  <label id="lbexpcarddate" name="lbexpcarddate"><s:property value="lbexpcarddate"/></label> </td><td  width="60%"> (Visa, Master, American Express)</td></tr> 
<tr  > <td colspan="2" align="left">&nbsp;</td></tr> 

<tr  > <td   colspan="2" align="left">Being rental, Traffic Fine, Salik, Damage, Insurance Excess, Fuel, other charges  against vehicle hired by me or replacements provided with Rental Agreement no:</td></tr>
 
 <tr  > <td   colspan="2" align="left">&nbsp;</td></tr> 
 <tr  > <td   colspan="2" align="left">&nbsp;</td></tr> 
 <tr  > <td   colspan="2" align="left">&nbsp;</td></tr> 
 
 
 <tr  >  <td   colspan="2"> ______________________________________________________________________________________________________________________________</td> </tr>
 
 </table>
<br><br><br><br>

<table width="100%"  >

<tr><td width="1%"><b>Name</b></td><td width="1%"><b>:</b></td><td width="98%"> <u><label id="clname" name="clname"><s:property value="clname"/></label></u></td> </tr>


<tr  >  <td  colspan="3"> &nbsp;<br><br><br></td> </tr>
<tr  >  <td width="1%"><b>Id</b></td><td width="1%"><b>:</b></td><td width="98%">_____________________________________________________________________________________________________________</td> </tr>


<tr  >  <td  colspan="3"> &nbsp;<br><br><br></td> </tr>
<tr  >  <td width="1%"><b>Signature</b></td><td width="1%"><b>:</b></td><td width="98%">_____________________________________________________________________________________________________________</td> </tr>


<tr  >  <td   colspan="3"> &nbsp;<br><br><br></td> </tr>


<tr>   <td width="1%"><b>Date</b></td><td width="1%"><b>:</b></td><td width="98%">_____________________________________________________________________________________________________________</td> </tr>
<tr> <td width="100%" colspan="3"> <b><i>* Attach copies of: passport, visa page, EID, CRC of card holder</i></b></td></tr> 

<tr  >  <td width="100%" colspan="3"> &nbsp;<br><br></td> </tr>


<tr  >  <td width="100%" colspan="3" > &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</td> </tr>

</table>


<!-- 
-------------------------------------page 3-------------------------------------------------------- -->
<div style="page-break-after:always;"></div>
<table width="100%">
<tr>
<td width="20%">&nbsp;</td><td width="60%"><img src="<%=contextPath%>/icons/epic.jpg" width="400" height="70"  alt=""/></td><td width="20%">&nbsp;</td>
 
</tr></table>
<br><br> 
  <table width="100%"  >
<tr>	<td width="100%" colspan="3">&nbsp;&nbsp;&nbsp;</td></tr>

<tr>	<td width="100%" colspan="3" align="justify">&nbsp;&nbsp;&nbsp;<b>DISCLAIMER for RA#:</b>&nbsp;<u><label id="rentaldoc" name="rentaldoc" ><s:property value="rentaldoc"/></label></u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Customer Name:</b>  <u><label id="clname" name="clname"><s:property value="clname"/></label></u></td></tr>
<tr>	<td width="100%" colspan="3">&nbsp;&nbsp;&nbsp;</td></tr>
<tr>	<td width="100%" colspan="3">&nbsp;&nbsp;&nbsp;</td></tr> 

	<tr>	<td width="30%"   align="justify">&nbsp;&nbsp;&nbsp;Mobile no: <u><label id="clmobno" name="clmobno"><s:property value="clmobno"/></label></u></td>
	 <td width="30%" align="justify"> Landline no: <u><label id="ldllandno"><s:property value="ldllandno"/></label></u></td>
	 <td width="40%" align="justify">  Email: <u><label id="clemail" name="clemail"><s:property value="clemail"/></label></u></td></tr>
</table> 
  <table width="100%"  >
<tr>	<td width="100%" colspan="3">&nbsp;&nbsp;&nbsp;</td></tr>
 <tr>	<td width="100%" colspan="3">&nbsp;&nbsp;&nbsp;</td></tr>

<tr><td width="100%" colspan="3" align="justify"><b>Traffic fines, Black Points and impounding charges to be cleared with the respective authority by
 the renter/lessee within two working days from the date of intimation.</b></td></tr>
 <tr>	<td width="100%" colspan="3">&nbsp;&nbsp;&nbsp;</td></tr>
  <tr>	<td width="100%" colspan="3">&nbsp;&nbsp;&nbsp;</td></tr>
  <tr>	 </td><td width="100%" colspan="3" align="justify">	<b>1.<u>Use of mobile phones</u>:</b> Usage of mobile phones without a hands free is against the law.  <br>  </td></tr>

  <tr>	 <td width="100%" colspan="3"  align="justify">	<b>2.<u>Red Light Jumping/black point fines</u>:</b>  Red light jumping/black point fines to be clearedby the Customer immediately on advice and pay the impounding
            charges, if applicable.<br> </td></tr>
 
    <tr>	 <td width="100%" colspan="3"  align="justify">  <b>3.<u>Tinting of windows</u>:</b> Not permitted for rental cars as per UAE law. Fines as per law/black points/vehicle impounding charges will be the renter's responsibility. Insurance coverage will not be available. <br></td></tr>
 
  <tr>	 <td width="100%" colspan="3"  align="justify">	<b>4.<u>Off-road driving is not allowed.</u>  </b>Not covered by insurance.<br></td></tr>
   
   <tr>	 <td width="100%" colspan="3"  align="justify">	<b>5.<u>Periodic maintenance service</u>:</b>   :  It is the responsibility of the Customer to bring the vehicle for service as per the mileage mentioned in the Sticker
      in the wind screen/mentioned in the Checkout report. Amount charged will be depending on the extra KM driven. If any damage happens to the vehicle due to this it will be charged extra. <br></td></tr>
   
    <tr>	 <td width="100%" colspan="3" align="justify"> <b>6.<u>Insurance:</u></b>Police report to be submitted for all accident/damage claim and the excess insurance/damage charges to be paid, for providing replacement vehicle.  </td></tr>
    
     <tr>	 <td width="100%" colspan="2" align="justify">	<b>7.<u>Oman Travel:</b></u> At PRAC management discretion only, request to be submitted by Customer and NOC obtained before two working days of the date of travel.
     Charges to be paid in advance and depends on period of travel. Purchase of Orange card(third party insurance)and responsibility to bring the vehicle to UAE is the responsibility of Lessee/Renter.</td></tr>
     <tr>	 <td width="100%" colspan="3" align="justify">  <b>8.<u>	Vehicles to be parked in proper authorized parking with valid parking document.</u>:</b>   </td></tr>
      <tr>	 <td width="100%" colspan="3" align="justify">	<b>9.<u>Vehicle Cleanliness</u>:</b>  Use proper fuel, to regularly check the oil and water levels, tire pressure and keep the vehicle clean (in-  and exterior).
                &nbsp;&nbsp;&nbsp;Renter/Lessee will be charged for the maintenance and allied costs. </td></tr>
      <tr>	 <td width="100%" colspan="3" align="justify">  <b>10.<u>All our vehicles are smoke free. </u>:</b> Charges apply for cleaning and maintenance.  </td></tr>
       

  
    <tr>	 <td width="100%" colspan="3" align="justify">  <b>11.<u>Fuel cost</u>:</b> Fuel consumed during service/maintenance/repair is at Customer cost. Vehicle original/replacement, to be returned with same 
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fuel as given, fuel charges will apply for lesser level.  </td></tr>
    
      <tr>	 <td width="100%" colspan="3" align="justify">  <b>12.<u>Mileage limits</u>:</b> Monthly 5,000km, Weekly 1500km,daily 250km. Extra KM will be charged as per tariff rate. </td></tr>
     
      <tr>	 <td width="100%" colspan="3" align="justify">  <b>13.<u>Payments </u>:</b> Rental amounts to be paid in advance and other payments on presentation of Invoice.  </td></tr>
      
      <tr>	 <td width="100%" colspan="3" align="justify">  <b>14.<u>Credit Card Payment and Pre-authorization  </u>:</b> PRAC has the right to charge the credit card for all payments related to the Rental agreement.   </td></tr>
        <tr>	 <td width="100%" colspan="3" align="justify">  <b>15.<u>Driver</u>:</b>  Only as authorized driver as per the Rental Agreement. Responsibility to keep and submit all documents valid.For other drivers insurance will not be covered. </td></tr>
        
        
          <tr>	 <td width="100%" colspan="3" align="justify">  <b>16.<u>Driver age</u>:</b> Minimum 25 years with minimum 1 year old driving license.  Drivers 23-25 years with prior approval at PRAC Management 
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;discretion: Excess AED 2,000 + 25% of total repair cost. </td></tr> 
        
          <tr>	 <td width="100%" colspan="3" align="justify"> <b>17.<u>Driving License</u>:</b>  If vehicle rented whilst on visit visa,the Customer/driver is not permitted to drive the vehicle until UAE license,visa, and Emirates ID copies are submitted to PRAC. </td></tr>

<tr>	 <td width="100%" colspan="3" align="justify">  <b>18.<u>Return of Vehicle </u>:</b> Customer is responsible to return/extend the vehicle rental as per the agreement due date.  </td></tr>

  <tr>	 <td width="100%" colspan="3" align="justify"><b>19.</b>FURTHER AND DETAILED TERMS & CONDITIONS AS PER RENTAL AGREEMENT/MASTER HIRE AGREEMENT. </td></tr>

 <tr>	<td width="100%" colspan="3">&nbsp;&nbsp;&nbsp;</td></tr>
 <tr>	<td width="100%" colspan="3">&nbsp;&nbsp;&nbsp;</td></tr>
  <tr>	<td width="100%" colspan="3">&nbsp;&nbsp;&nbsp;</td></tr>
   <tr>	<td width="100%" colspan="3">&nbsp;&nbsp;&nbsp;</td></tr>
   
      <tr>	<td width="100%" colspan="3">Above accepted: ________________________________________________________  Date: _____________________</td></tr>
        <tr>	<td width="100%" colspan="3">&nbsp;&nbsp;&nbsp;</td></tr>
   <tr>	<td width="100%" colspan="3">&nbsp;&nbsp;&nbsp;</td></tr>
    <tr>	<td width="100%" colspan="3">&nbsp;&nbsp;&nbsp;</td></tr> <tr>	<td width="100%" colspan="3">&nbsp;&nbsp;&nbsp;</td></tr>
   
      <tr>	<td width="100%" colspan="3">Customer Name &  address: __________________________________________________________________________</td></tr>
</table>
<div style="page-break-after:always;"></div>
<!-- ---------------------------------page 4--------------------------------- -->
<table width="100%">
<tr>
<td width="20%">&nbsp;</td><td width="60%"><img src="<%=contextPath%>/icons/epic.jpg" width="400" height="70"  alt=""/></td><td width="20%">&nbsp;</td>
 
</tr></table>
 
<br><br><br><br><br> <br><br><br><br><br>  

<table width="100%"  >
<tr>
<td width="10%">&nbsp;</td><td width="88%">&nbsp;&nbsp;&nbsp;<img src="<%=contextPath%>/icons/replacevehicle.jpg" width="500" height="250"  alt=""/></td><td width="2%">&nbsp;</td>
 
</tr></table>
<br><br><br><br><br> <br><br><br><br><br> 
<table width="100%">
<tr>
<td width="10%">&nbsp;</td><td width="88%">&nbsp;&nbsp;&nbsp;<img src="<%=contextPath%>/icons/replacevehicle.jpg" width="500" height="250"  alt=""/></td><td width="2%">&nbsp;</td>
 
</tr></table>




 </div>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="docnoval" id="docnoval" value='<s:property value="docnoval"/>'  />
</form>
</div>
</div>
</body>
</html>
    