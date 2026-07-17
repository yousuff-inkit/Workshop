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

p{
font-size: 8.5px;
font-family: Tahoma;
align: justify;
}
.boldclass{
font-size: 8px;
font-family: Tahoma;
align: justify;
}

ul{
font-size: 10px;
font-family: Tahoma;
}

.tableborder {
    border: 1px solid black;
    border-collapse: collapse;
}
 fieldSet
    {
        
    
        border-width: 1px; border-color: rgb(250,235,215);
       
        margin:0;
    }

    legend
    {

        border-style:none;
        background-color:#FFF;
        padding-left:1px;

    }
</style> 
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
    .biketable2 tr.border_bottom td {
  border-bottom:1px solid black;
  border-left:1px solid black;
}
.biketable2 tr.border_top td {
  border-top:1px solid black;
}
.border-right{
border-right:1px solid black;
}
.biketable{
border-collapse: collapse;
} 
.img-responsive{
 display: block;
  max-width: 100%;
  height: auto;
}
/* p{
	font-size: 8px;
	font-family: Times new roman;
	align: justify;
}
 */
</style> 
<script>
 
 
function gridload(){
	   var indexvals = document.getElementById("docnoval").value;
  
       $("#calcdiv").load("calculationGrid.jsp?rentaldoc="+indexvals);
       
     }  


</script>

</head>
<body onload="gridload();" bgcolor="white" style="font-size:10px;" >
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmAgreemrntPrint" action="saveAgreementPrint" method="post" autocomplete="off">

<div style="background-color:white;">
<table width="100%" >
  <tr>
    <td width="18%" rowspan="6"><img src="<%=contextPath%>/icons/epic.jpg" width="100" height="91"  alt=""/></td> 
    <td width="46%" rowspan="2">&nbsp;</td>
    <td width="36%"><b><label id="companyname" name="companyname"><s:property value="companyname"/></label></b></td>
  </tr>
  <tr>
    <td><b><label id="address" name="address"><s:property value="address"/></label></b></td>
  </tr>
  <tr>
    <td rowspan="2"  align="center"><b><font size="4">Rental Agreement</font></b></td>
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
<table width="100%">
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
By putting your initial in box provided , You agree to pay the accident amount in full issued to you whilst the vehicle is rented in your name.
<%-- <label id="excessinsu" name="excessinsu"><s:property value="excessinsu"/></label> --%>
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
<!--  <fieldset width="100%">
<legend><b>Salik (Road tolls)</b></legend>
 By putting your initial in the box provided below you agree to pay salik charges of 4  for each crossing and 1  admin fee.
Total 5  per crossing.These charges will be added to the end of the rental, or as and when we are notified by the RTA.
<table width="100%" >
<tr><td  width="50%"></td><td width="50%" height="25px" > <fieldset style="height:100%;"></fieldset></td>
</tr>
</table>
</fieldset>  -->
<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>
 </td></tr>
 </table>
 <br>&nbsp;
 <table width="100%">
 <tr>
 <td width="100%" align="center">
<b >Vehicle Insured For Republic Of India Only</b>
</td>
</tr>
<tr>
<td>

<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br> 


</td>
</tr>


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
      <td align="left">Reg NO&nbsp;<label id="drivravehregno" name="drivravehregno"><s:property value="drivravehregno"/></label></td>
 
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
  <jsp:include page="calculationGridPrint.jsp"></jsp:include></div>
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
      below the page. And if you are paying by Credit card, your signature is authorization 
       for Automatic  billing. Your signature also allows us to deduct any additional 
       charges pertaining to this  contract after the rental agreement has been closed.</td>
    </tr>
    <tr>
    <td align="left" ><hr noshade size=1>Customer Signature
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Date</td></tr>
  <!--   <tr> <td align="left" ><hr noshade size=1>Date</td></tr> -->
     <tr> <td align="left" ><hr noshade size=1>Rental Agent
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Date</td></tr>
     <!--  <tr> <td align="left" ><hr noshade size=1>Date</td></tr> -->
      <tr>
      <tr> <td align="left" ><hr noshade size=1>Checkout   
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;Date</td></tr>
     <!--  <tr> <td align="left" ><hr noshade size=1>Date</td></tr> -->
      <tr>
<!--       <td align="left">
    <fieldset>
    You are responsible for any damage to the vehicle by striking overhanging objects.
      </fieldset>
      </td> -->
      </tr>
     </table>
 </fieldset> 
  </td>
</tr>
  </table>
  
<br><br><br><br>&nbsp;<br>&nbsp;<br>&nbsp;<br> &nbsp;<br> 


<table width="100%">
  <tr>
    <td width="26%"><img src="<%=contextPath%>/icons/epic.jpg" width="80" height="70"  alt=""/></td>
    <td width="74%"><b><font size="4PX">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Master Agreement</font></b></td>
  </tr>
</table>

<table width="100%">
<tr>
<td width="2%">&nbsp;</td> 
<td width="45%">

<p align="justify">This Lease / Rental Agreement (hereinafter referred as 'Agreement / RA') is entered into at Hyderabad, on this  [date]  _ _ / _ _ / _ _ _ _ (DD/MM/YYYY)<br>
By and Between Driven By You Mobility LLP, a Partnership firm having its registered office at 8-2-268/S/91/A-2, Sagar Co-operative Society Ltd. Road No. 2, Banjara Hills, Hyderabad- 500034, hereinafter referred to as "Lessor / Us / We / Driven" where such expression shall, unless repugnant to the context thereof, be deemed to include its respective legal heirs, representatives, administrators, permitted successors and assigns,
And ________________________________________________________________________________________, aged ____________ years, residing at _________________________________________________________________________________________________________________________ __________________________________________________________________ hereinafter referred to as "Lessee / You", where such expression shall, unless repugnant to the context thereof, be deemed to include his / her respective legal heirs, representatives. [Individual] [or]<br/>
________________________________________________________________________, a company incorporated under the Companies Act,  1956, and having its registered office at: <br/>
_____________________________________________________________________________________________________________________________ _____________________________________________________________________________________________________________________________<br/>
hereinafter referred to as "Lessee / You", where such expression shall, unless repugnant to the context thereof, be deemed to include its respective legal heirs, representatives, administrators, permitted successors and assigns.<br>
Lessor and Lessee shall hereinafter be individually referred to as "Party" and collectively as "Parties".
WHEREAS the Lessor is in the business of providing self drive cars and self ride motorcycles on lease, through its brand "Driven... By You"; AND WHEREAS the Lessee is desirous of engaging these movable assets/vehicles of the Lessor on lease as per description and commercial terms in Annexure A. Now it is hereby mutually agreed by and between the parties hereto as follows:<br>
<b class="boldclass">ARTICLE 1:</b><br/>
<b class="boldclass">DEFINITIONS AND INTERPRETATION</b><br>
<b class="boldclass">Definitions</b><br>
In this Agreement, unless repugnant to the context hereof, the following terms, when capitalized, shall have the meanings assigned herein when used in this Agreement.  When not capitalized, such words shall be attributed their ordinary meaning.<br>
1.&nbsp;&nbsp; "Driven" shall mean Driven By You Mobility LLP.<br/> 
2.&nbsp;&nbsp; "Agreement" means this lease agreement for movable assets.<br/>
3.&nbsp;&nbsp; "Effective Date" shall mean the same day as the Effective Date of the Agreement 	which is the day of the signing of this Agreement.<br/>
4.&nbsp;&nbsp; "Vehicles" shall mean the vehicles owned / managed by the Lessor that are leased to the Lessee in pursuance of this Agreement, to be used by the Lessee.<br/>
5.&nbsp;&nbsp; "Hirer" shall mean the person/company/primary user/secondary user named in the RA (Rental Agreement) as the Hirer and any  person/company who provides <br/> 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Credit Card Authorisation to us as consideration for the Lease.<br/>
6.&nbsp;&nbsp;&nbsp;   When any number of days is prescribed in this Agreement, same shall be reckoned exclusively of the first and inclusively of the last day;<br/>
7.&nbsp;&nbsp;&nbsp;    The expiration or termination of this Agreement shall not affect such of the provisions of this Agreement as expressly provide that they will operate after<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; any such expiration or termination or which of necessity must continue to have effect after such expiration or termination, notwithstanding that the<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clauses themselves do not expressly provide for this.<br/>
8.&nbsp;&nbsp;&nbsp;  This Agreement shall be read together with other documents entered into and executed between the parties.<br/>
9.&nbsp;&nbsp;&nbsp;  Further, this Agreement shall be read with the terms available on www.driven.in, as updated from time to time.<br/>
10.&nbsp;&nbsp;"Liability" shall extend to company as specified in Annexure C or Primary and Secondary User as may be stated. In the same annexure<br>
<b class="boldclass">ARTICLE 2:</b><br/>
<b class="boldclass">LEASE OF EQUIPMENT AND TERM</b><br>
1.&nbsp;&nbsp;&nbsp;  For and in consideration of the covenants and agreements hereinafter contained, to be kept and performed by Lessee, Lessor has and does hereby lease to <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Lessee its movable properties, hereafter designated as "Vehicle", to have and to hold the same unto Lessee for the respective periods  as described and <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutually agreed to.<br/> 
2.&nbsp;&nbsp;&nbsp;  The Lessee hereby agrees and accepts to return the vehicle within rental period as agreed upon, failing which, the Lessee shall incur the daily tariff on<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  the vehicle for every additional number of hours, which shall be counted as 24 in a day. In the event the vehicle is returned  prior to the rental period,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  the Lessee shall still be liable for the charges for the entire period of agreement.<br/>
3.&nbsp;&nbsp;&nbsp;  This Rental Agreement shall be applicable for all vehicles leased by the Second Party from the First Party, anywhere in India, during the term, and shall<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  be read in consonance with the other documents entered into between the Lessor and the Lessee regarding the vehicle.<br/>
4.&nbsp;&nbsp;&nbsp;  This Agreement shall be valid for a duration of three years from the date of execution and shall be binding on the lease of all movable  property from the<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Lessor to the Lessee during such duration.<br>
<b class="boldclass">ARTICLE 3:</b><br/>
<b class="boldclass">PAYMENT SCHEDULE</b><br>
1.&nbsp;&nbsp;&nbsp;  The Lessee hereby agrees to pay to the Lessor consideration for the Lease as per terms agreed upon at the time of Lease of the Vehicle.The sum to be paid <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; shall be inclusive of all taxes applicable on the transaction, and the Lessee hereby covenants any and all taxes applicable on the transaction. In the event <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; any further tax liability arises, it shall be the sole responsibility of the Lessee to discharge such liabilities.<br/>
2.&nbsp;&nbsp;&nbsp;  By signing this agreement, you hereby irrevocably and unconditionally authorize us to charge to your credit card and/or to charge to your account. <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  If we charge your credit card for any charges in excess of the amount, we will notify you of the amount so charged and provide details of the reason for  <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  which you have been charged.<br/>
3.&nbsp;&nbsp;&nbsp;  You will be liable for the charges as specified in Annexure A and as follows<br/>
4.&nbsp;&nbsp;&nbsp;  Damage or loss caused by use on construction sites, mines and unsealed roads, including an accident, or by using the vehicle in a dangerous or reckless<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  manner or when vehicle is totally or partially immersed in water. And repatriation for the period towards loss of income when the vehicle<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  is unusable.<br/>
5.&nbsp;&nbsp;&nbsp;  A "zero mileage" tariff as applicable to your rental for the no of days for which the vehicle is confined to for repairs and maintenance arising from <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;such damages<br>
6.&nbsp;&nbsp;&nbsp;  A refueling service charge at prevalent prices if you have not replaced the quantity of fuel that was supplied at the start of the original rental in addition<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to the kilometers run for refueling.  An additional service charge (25% of fuel charge) will also be added for the service.<br/>
7.&nbsp;&nbsp;&nbsp;  You must pay the appropriate authority all government taxes, fines, court costs and intended prosecutions for parking, traffic or other  offences any <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; other fines and costs if and when the authority demands this payment, anytime during the period of the contract or anytime  thereafter, if the same<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  relates to your period of contract/hire. All fines and intended prosecutions incurred will attract reasonable administration charges  which arise<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; when we deal with these matters and repatriation for the period towards loss of income when the  vehicle is unusable.<br/>

8.&nbsp;&nbsp;&nbsp;  You will be responsible for all charges related to parking, toll tax, permits, during your rental period.<br/>
9.&nbsp;&nbsp;&nbsp;  In the event of returning the rental beyond two hours of grace time of the agreed period, you will be charged one full days zero km rental plan plus <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the additional distance covered during that period.<br>

10.&nbsp;&nbsp; The reasonable cost of repairing any extra damage which was not noted on our vehicle check form at the start of the agreement,whether you were at fault<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;or not.<br>
11.&nbsp;&nbsp; Interest, which we will add every day to any amount you do not pay us on time, at the rate of 18% a year and subject to change from time to time.<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Interest will be payable from the expiry of 14 days from the date on which you were required to pay the money to the date of payment.<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Payments received will be credited firstly against any accrued but unpaid interest.<br/>

12.&nbsp;&nbsp; Any amount that is paid by credit/ debit card and being refunded can attract a bank charge of 2.5% or more, deducted by us from the refund amount.This<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   is applicable only for refunds made against credit card / debit card payments and shall not be deducted for bank transfers / cash payments.<br/>

13.&nbsp;&nbsp; Our costs of recovering or attempting to recover from you outstanding charges, including any mercantile agent's costs, and legal costs on  a full indemnity <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; basis if we are successful in our legal action against you; and<br/>
14.&nbsp;&nbsp; Any charges relating to renting, purchasing or repairing damages on additional equipment or accessory (e.g. Navigation System, Baby Car Seats, Helmets,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Riding Gloves, Jackets, on Board Cameras, Stereo Systems, Bluetooth Systems etc).<br>

<!-- -------------------------------------------------page------------------------------- -->
<b class="boldclass">ARTICLE 4:</b><br/>
<b class="boldclass">DELIVERY AND SETUP</b><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The equipment agreed to be leased will be picked up and dropped off at regular and reasonable working and office hours by the Lessee from the location<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;and commencement and ending dates as specified by the Lessor on the date of this Agreement.<br>
<b class="boldclass">ARTICLE 5:</b><br/>
<b class="boldclass">CONDITION OF VEHICLE</b><br>
1.&nbsp;&nbsp;&nbsp; The Lessee and the Lessor agree that the lease shall be on an 'as is' basis, as set forth in detail at the time of Lease. The Lessee agrees to return the Vehicles<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in the condition in which they are picked up by the Lessee, and the Lessor gives no representation or warranty as to the nature,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; condition, fitness for purpose, merchantability or suitability of the Vehicles.<br/> 
2.&nbsp;&nbsp;&nbsp; The Lessee shall not be entitled to cancel the lease or withhold, defer or reduce any rental or other amount payable by it in terms hereof by reason of  any<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; defect or deficiency in or damage to the Vehicles, except as noted at the time of procuring the Lease Vehicle. Any defect or deficiency in<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; or damage to the Vehicle not observed and set forth in writing at such time shall be deemed to have been caused by the Lessee and shall be<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; paid for by the Lessee.<br/>
3.&nbsp;&nbsp;&nbsp; The Lessee undertakes to take reasonable care of the Vehicle. All wear and tear and regular maintenance issues during the Lease period <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; shall be the responsibility of the Lessor. However, any major/ substantial physical damage shall be the responsibility of the Lessee.<br/>
4.&nbsp;&nbsp;&nbsp; The Lessor reserves the right to declare whether or not the damage is substantial. In the case there is substantial damage to the Vehicle, the Lessee <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  undertakes to compensate the Lessor for these damages to be evaluated at market rate for the parts damaged. The money for compensation<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  will be deducted from the deposit/security amount made by the Lessee.<br/>
5.&nbsp;&nbsp;&nbsp; The Lessee hereby acknowledges receiving the vehicle from us:<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A)&nbsp;In a good and clean condition except as specified in the Vehicle Details and Conditions Report.<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;B)&nbsp;With supplied tools, tyres, accessories and equipment, keys, the mobile global positioning system and accessories (GPS), where <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; applicable and any other items 	specified on the Vehicle Details and Condition Report.<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C)&nbsp;With the seal of the odometer unbroken and odometer reading and fuel reading.<br/>
6.&nbsp;&nbsp;&nbsp; The Lessee shall look after the vehicle, including the keys to the vehicle. You must always lock the vehicle when you are not using it, <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; and use any security device supplied with the vehicle. You must always protect the vehicle against bad weather conditions that could <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cause damage.<br/>
7.&nbsp;&nbsp;&nbsp; The vehicle shall not be used or driven at any point in time, by any individual who has not been named as the hirer, <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; as per this Agreement. In the event any individual not named as hirer shall be found to be operating the vehicle, the Lessee shall be liable <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to additional damages to the Lessor, at such rates as shall be determined by the Lessor.<br/>
8.&nbsp;&nbsp;&nbsp; You are responsible for any damage to the vehicle caused by hitting low-level objects, such as bridges or low branches.<br/>
9.&nbsp;&nbsp;&nbsp; You must follow all traffic rules and regulations at all times.<br/>
10.&nbsp;&nbsp;You must not sell, rent or dispose of the vehicle or any of its parts.<br/>
11.&nbsp;&nbsp;You must not give anyone any legal rights over the vehicle.<br/>
12.&nbsp;&nbsp;You must promptly provide us with any summons, complaint, demand notice in relation to the vehicle.<br/>
13.&nbsp;&nbsp;You agree to maintain tire pressure, fluid and fuel at the proper operating levels and to immediately report to us any defect. You must <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; always make sure that you use the fuel recommended by us. Adulterated fuel shall not be used in the vehicle.<br/>
14.&nbsp;&nbsp;You must not let anyone work on the vehicle without our written permission. If we do give you permission, we will only give you a refund <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if the work doesn't occur as a result of your negligence and you have a bill/invoice for the work performed at an outlet authorised by us.<br/>
15.&nbsp;&nbsp;You must let us know as soon as you become aware of a fault in the vehicle.In the absence of such notification,you will be liable for any <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; charges incurred as a result.<br/>
16.&nbsp;&nbsp;You will remain responsible for the vehicle and its condition as inspected by our maintenance staff and will be liable for any damages as  assessed by them. <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; All efforts will be made by us to complete inspection by end of the following business day.<br/>
17.&nbsp;&nbsp;We must be notified and agree to any extension of the period of hire, in advance of the return date. If you fail to return the vehicle to us by the return time<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  and date, the vehicle will be reported to the authorities as stolen.<br>
<b class="boldclass">ARTICLE 6:</b><br/>
<b class="boldclass">GENERAL CONDITIONS</b><br>
1.&nbsp;&nbsp;&nbsp; At any point during or after the rental, we are not responsible for any personal belongings left in the vehicle.<br/> 
2.&nbsp;&nbsp;&nbsp; You are responsible for any loss or damage to additional equipment hired at the time of rental, including but not limited to satellite navigation equipment,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; baby seats, helmets, jackets, gloves, on board cameras. In the event any of these movable assets are removed from for any reason,<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the Lessee shall be liable to compensate the Lessor for the same.<br/>
3.&nbsp;&nbsp;&nbsp; Any damage found to the unseen mechanicals of the vehicle like engine, gearbox, suspension, etc. even after the return of the vehicle shall be evaluated and<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; assessed and if assessed as being damaged during the rental of the vehicle by you, the same shall be charged to your account and recovered.<br/>
4.&nbsp;&nbsp;&nbsp; In case of any breakdown or repair of the vehicle attributed to routing maintenance and wear and tear, a replacement vehicle of closest category shall be<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; provided only if the vehicle is within the city limits of the city of hire of the vehicle, subject to availability and within the office hours of 0930 to <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1900 hrs on working days.<br/>
5.&nbsp;&nbsp;&nbsp; In case of a pre existing damage to the vehicle, if a damage occurs on the hands of the Lessee on the same part /area, the Lessee will be by the Lessee<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; charged either proportionate cost of repair or will be charged the entire cost of repair depending upon the extent of the damage caused <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; and the extent of the pre-existing damage. The decision on this shall be taken by the Lessor representative and this decision <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; shall be final and shall be accept able to the Lessee, without any dispute whatsoever.<br/>
6.&nbsp;&nbsp;&nbsp; The Lessor will be governed and bound by rule of law to submit any personal information submitted by the lessee as and when reasonably <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; directed to do so by law enforcement authorities.<br>
<b class="boldclass">ARTICLE 7:</b><br/>
<b class="boldclass">SPECIFIC CONDITIONS OF USE</b><br>
1.&nbsp;&nbsp;&nbsp; Only (two) 2 designated drivers/riders can be assigned to the vehicle at any given time and we will be intimated of the same with proper documentation<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  prior to the hire.<br/>
2.&nbsp;&nbsp;&nbsp; Anyone driving / riding the vehicle must have a full valid driving license, should be at least (Twenty One) 21 years of age and have at least <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3 (Three) years of driving/riding experience, as evidenced by the Driving License produced. You will need to provide us with copies of the <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; driver's license and any other relevant documentation prior to hire.<br/>
3.&nbsp;&nbsp;&nbsp; Foreigners must have a valid International driver's license. You will need to provide us with copies of the driver's license, passport, visa and <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; any other relevant documentation prior to hire.<br/>
4.&nbsp;&nbsp;&nbsp; The rental for the period extending to a maximum of 1 (one) month is payable in advance. For rentals beyond 1 month, payment/advance <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; must be made as per the payment schedule as determined by us prior to the hire.<br/>
5.&nbsp;&nbsp;&nbsp; Vehicle must be collected from and dropped off at our office (applicable to Lessee's renting for up to (Six) 6 days); vehicle pick up/drop<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; off charges shall be chargeable each way as determined by us depending on the one way distance from our garage / office to your <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; residence / office, subject to a minimum. of Rs. 300/- (Rupees Three hundred only) each way. You will be responsible for any charges <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; relating to lost key, e.g., cost of key replacement and idling of vehicle caused by lost key and time taken to obtain replacement key, etc.<br/>
6.&nbsp;&nbsp;&nbsp; In the event of an accident, you must:<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A.&nbsp;&nbsp; Obtain the name, address and contact details of all the parties involved, and make the vehicle secure.<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;B.&nbsp;&nbsp; Notify the police immediately if anyone is injured or there is a disagreement over who is responsible.<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C.&nbsp;&nbsp; Notify through phone calls, the office from which you rented the vehicle, as soon as practicable.<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D.&nbsp;&nbsp; Fill in our accident report form and send it to our address shown over the page.<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;E.&nbsp;&nbsp; Provide information and assistance as may be requested by us, including but not 	limited to, being interviewed by an <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; investigator/government official or attending any court hearing;<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F.&nbsp;&nbsp; If necessary, authorize us to bring, defend or settle legal proceedings, as we in our sole discretion determine.<br/>
7.&nbsp;&nbsp;&nbsp; You or any other authorised driver must not:<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A.&nbsp;&nbsp; Use the vehicle for any illegal purpose or activities of terrorism/riots, carry any inflammable, firearms, explosive or corrosive materials, <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; contraband & narcotics & products banned by the Govt.;<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;B.&nbsp;&nbsp; Smoke inside the car. We are proud to offer a smoke-free fleet and violation of this rule will result in a penalty charge plus any cost <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; relating to deodorizing the car and any other clean up that might be required;<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C.&nbsp;&nbsp; Use the documents of the vehicle (e.g.,RC Book,fitness,PUC,Insurance,etc.),provide it to anybody or remove from the vehicle at any given time; <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D.&nbsp;&nbsp; Decorate the vehicle (e.g., flowers, ribbons, bouquets, etc)<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;E.&nbsp;&nbsp; Use the vehicle if damaged or unsafe, for hire or reward, to carry the deceased, carry animals or pets, for towing<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F.&nbsp;&nbsp; Use the vehicle on unsuitable terrain and for motor sports or any such activity that may impair the long term performance and <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; condition of the vehicle (e.g., racing, hill 	climbing, peacemaking and electioneering, testing the vehicle reliability and speed or <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;teaching someone to drive);<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;G.&nbsp;&nbsp; Use the vehicle while under the influence of alcohol or drugs;<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H.&nbsp;&nbsp; Drive/ride the vehicle outside the city of hire, unless we have given you written permission prior to hire. In the event of any travel <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;outside the twin cities of Hyderabad and Secunderabad, a written itinerary (with all the necessary documentation) should be provided <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;and agreed upon in writing prior to the travel;<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I.&nbsp;&nbsp;&nbsp; Load the vehicle beyond the manufacturer maximum weight recommendations on 	passengers and baggage;<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;J.&nbsp;&nbsp; Drive in restricted areas including, but not limited to, airport service roads and associated areas;<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K.&nbsp;&nbsp; Exceed or drive over the speed limits set by the law and in the absence of any such set speed limits, not exceed a speed of (One <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;hundred) 100 km/hr in any circumstance. Exceeding such set speed limits that may be tracked by onboard fitted devices or any other <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;means may make you liable for penalties as determined by the law and separately fines as may be determined by us subject to a <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;minimum fine of Rs.500 (Five Hundred) per incident of exceeding the limit<br>
<b class="boldclass">ARTICLE 8:</b><br/>
<b class="boldclass">LESSOR'S REPRESENTATIONS </b><br>
1.&nbsp;&nbsp; We have maintained the vehicle to the manufacturer recommended standards. We assure you that the vehicle is roadworthy and suitable <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;for renting at the start of the rental period.<br/> 
2.&nbsp;&nbsp; We are not responsible for indirect losses which happen as a side effect of the main loss or damage and which are not foreseeable by you and us <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(such as loss of opportunity).<br>
<b class="boldclass">ARTICLE 9:</b><br/>
<b class="boldclass">INSURANCE OF THE VEHICLE</b><br>
1.&nbsp;&nbsp; Insurance claims for accidents shall be made only in case the claim is greater than Rs. 25,000/- for small cars and sedan cars (Entry Level) <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;and entry level two wheelers (on road value of two wheelers less than INR Two lakhs) and the claim greater than Rs. 50,000/- for Luxury <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sedans and upward category of vehicles and other premium two wheelers (on road value upwards of INR Two lakhs) as per the rental <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;tariff under rent a cab/motorcycle scheme.<br/> 
2.&nbsp;&nbsp; The minimum liability of the Lessee shall be the bill amount or Rs. 25,000/-, whichever is lower for small cars and sedans (Entry Level) <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;and entry level two wheelers (as defined earlier) and Rs. 50,000/- for luxury sedan and upwards & other premium two wheelers.<br/>
3.&nbsp;&nbsp; The rental for the intervening days, when the vehicle is in repair shall be applicable and charged to the Lessee.<br/>
4.&nbsp;&nbsp; While the Lessor shall provide cover for theft, the Lessee shall be responsible for the difference between market value of the vehicle and <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;the amount received from the insurance company. In addition, you will also be responsible to pay for the remaining tenure of the rental <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;agreement/until we get reimbursed by the insurance company.<br>
<b  class="boldclass">ARTICLE 10:</b><br/>
<b class="boldclass">OWNERSHIP</b><br>
1.&nbsp;&nbsp; Ownership of the Vehicles shall at all times remain vested in the Lessor and neither the Lessee nor any person on its behalf shall at any <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;stage before or after the expiry of this lease or the termination of the Agreement become the owner of the Vehicles or be entitled to retain <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;the possession, use or enjoyment of such Vehicles.<br/> 
2.&nbsp;&nbsp; The Lessee shall not in any way deal with the Vehicles, and in particular but without limiting the generality of the foregoing, shall not sell, <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;offer for sale, pledge, sublet, lend or part with possession with the Vehicles.<br/>
3.&nbsp;&nbsp; The Lessee shall keep the Vehicles free from any lien, charge or encumbrance and shall not permit any other person to acquire any right <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;in or to the Vehicles<br>
<b class="boldclass">ARTICLE 11:</b><br/>
<b class="boldclass">REPOSSESSION</b><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If the Lessee defaults in any of the covenants, conditions or provisions of this Lease, it is agreed that Lessor may take possession of<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;the Vehicle from the Lessee's place specified. <br>
<b class="boldclass">ARTICLE 12:</b><br/>
<b class="boldclass">INDEMNITY</b><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The Lessee hereby indemnifies and holds the Lessor harmless against all damage, loss, injury, claims, fines or penalties of whatsoever <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nature and howsoever arising which may be suffered by or instituted against or imposed on the lessor in respect of or in connection with the vehicles or the<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;use, possession or enjoyment thereof by the Lessee.<br>
<b class="boldclass">ARTICLE 13:</b><br/>
<b class="boldclass">CESSATION</b><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The Lessee shall not cede any of its rights nor delegate any of its obligations under this Lease Agreement to any third Party nor shall the Lessee enter into<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;any sublease of the Vehicles without the prior written consent thereto of the Lessor. The Lessor shall not be entitled to cede all or any of the Lessor's rights <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;hereunder including its rights of ownership in the Vehicles or any of them, either absolutely or by way of cession in securitatem debiti.<br>
<b class="boldclass">ARTICLE 14:</b><br/>
<b class="boldclass">SECURITY DEPOSIT</b><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The security deposit shall be liable to forfeiture if the Lessee violates any of the terms of this Agreement.<br>
<b class="boldclass">ARTICLE 15:</b><br/>
<b class="boldclass">NOTICES</b><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Any notice required or permitted to be given hereunder shall be in writing and shall be effectively served (i) if delivered personally, upon receipt by the other<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Party; (ii) if sent by prepaid courier service, airmail or registered mail, within five (5) days of being sent; or (iii) if sent by means of electronic communication,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;immediately. Any notice required or permitted to be given hereunder shall be addressed to the address as given in the title to this Agreement.<br>
<b class="boldclass">ARTICLE 16:</b><br/>
<b class="boldclass">TERMINATION AND DISPUTE RESOLUTION </b><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The rights conferred by the Lessor on the Lessee for the use of the Vehicle ends at the expiration of the time period provided for in this Agreement, unless <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;mutually extended. No oral communication for renewal shall be accepted. The Courts in Hyderabad/ Secunderabad shall have jurisdiction to decide on any <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dispute. Notwithstanding the above, any and all disputes shall be resolved at the first instance through a Sole Arbitrator appointed by the Lessor, in keeping <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;with the Arbitration and Conciliation Act, 1996. The proceedings shall be held at Hyderabad or Secunderabad and conducted in English.<br>
<b class="boldclass">CANCELLATION</b><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;It is possible to cancel your booking with Driven at any time up to 48 hours before the date and time of commencement of booking. Please call our toll free hotline number (7569 374 836) or write us an email through our contact form in the Service section of the website. Customers remain liable to pay the full rental price for cancellations made within 48 hours before the start of the reserved rental period or upon failing to pick up the vehicle (no show). This also includes cases, in which the customer does not comply with the rental conditions. Such sums will be recovered from security deposit amounts. The customer may request for refund/s against the unutilized or 'no show' booking within 24 hours from the hour of departure. No refund will be made for requests made after expiry of 24 hours as mentioned above and all unclaimed amounts for such unutilized or 'no show' booking shall be deemed to have been forfeited.<br>
<b class="boldclass">FORCE MAJEURE</b><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Neither party is not liable for failure to perform the party's obligations as contained in the Rental Agreement if such failure is as a result of Acts of God (including fire, flood, earthquake, storm, hurricane or other natural disaster), war, invasion, act of foreign enemies, hostilities (regardless of whether war is declared), civil war, rebellion, revolution, insurrection, military or usurped power or confiscation, terrorist activities, nationalisation, government sanction, blockage, embargo, labour dispute, strike, lockout or interruption or failure of electricity or telephone service. No party is entitled to terminate this Agreement under in such circumstances. If a party asserts Force Majeure as an excuse for failure to perform the party's obligation, then the nonperforming party must prove that the party took reasonable steps to minimise delay or damages caused by foreseeable events, that the party substantially fulfilled all non-excused obligations, and that the other party was timely notified of the likelihood or actual occurrence of an event described in this Clause. IIn witness whereof the Parties hereto have executed and signed this Agreement the day and year first hereinabove.
This agreement is made for the exclusive use of Driven By You Mobility LLP for the purpose of transacting business with our customers. Neither can this agreement, it's earlier versions nor intended revisions be copied or used by any individual, firm or corporation.</p>

</td>
<td width="2%">&nbsp;</td> 
</tr>
</table>


<table width="95%">
  <tr>
    <td width="8%" rowspan="2"><img src="<%=contextPath%>/icons/epic.jpg" width="100" height="91"  alt=""/></td>
    <td width="92%" align="center"><font size="3"><b>Driven By You Mobility LLP</b></font></td>
  </tr>
  <tr>
    <td align="center"><font size="2"><b><u>CREDIT CARD AUTHORISATION</u></b></font></td>
  </tr>
</table><br/>
					
<p align="justify" ><b>Product:</b> Self drive Car/Motorcycle Rentals</p><br/>

<p align="justify" id="p1"><b>Client Details: NAME:</b> M/s/ Mr./Mrs.</p><br/>				
&nbsp;<label id="lblclname" name="lblclname"><s:property value="lblclname"/></label>
<hr style="border: 0;height: 0;border-top: 1px solid rgba(0, 0, 0, 0.4);border-bottom: 1px solid rgba(255, 255, 255, 0.3);" width="65%" align="left"><br/><br/>					

<p align="justify" id="p1"><b>Address :</b></p><br/>
&nbsp;<label id="lblcladdress" name="lblcladdress"><s:property value="lblcladdress"/></label>
<hr style="border: 0;height: 0;border-top: 1px solid rgba(0, 0, 0, 0.4);border-bottom: 1px solid rgba(255, 255, 255, 0.3);" width="99%"><br/>
<hr style="border: 0;height: 0;border-top: 1px solid rgba(0, 0, 0, 0.4);border-bottom: 1px solid rgba(255, 255, 255, 0.3);" width="99%"><br/>
<hr style="border: 0;height: 0;border-top: 1px solid rgba(0, 0, 0, 0.4);border-bottom: 1px solid rgba(255, 255, 255, 0.3);" width="99%"><br/>
<hr style="border: 0;height: 0;border-top: 1px solid rgba(0, 0, 0, 0.4);border-bottom: 1px solid rgba(255, 255, 255, 0.3);" width="35%" align="left"><br/>

<p align="justify" id="p1"><b>Billing Address :</b></p><br/>
&nbsp;<label id="lblcladdress" name="lblcladdress"><s:property value="lblcladdress"/></label>
<hr style="border: 0;height: 0;border-top: 1px solid rgba(0, 0, 0, 0.4);border-bottom: 1px solid rgba(255, 255, 255, 0.3);" width="99%"><br/>
<hr style="border: 0;height: 0;border-top: 1px solid rgba(0, 0, 0, 0.4);border-bottom: 1px solid rgba(255, 255, 255, 0.3);" width="99%"><br/>
<hr style="border: 0;height: 0;border-top: 1px solid rgba(0, 0, 0, 0.4);border-bottom: 1px solid rgba(255, 255, 255, 0.3);" width="99%"><br/>
<hr style="border: 0;height: 0;border-top: 1px solid rgba(0, 0, 0, 0.4);border-bottom: 1px solid rgba(255, 255, 255, 0.3);" width="35%" align="left"><br/>

<table width="95%">
  <tr>
    <td width="11%"><b>Tel. No</b></td>
    
    <td width="30%">&nbsp;&nbsp;<label id="lblpertel" name="lblpertel"><s:property value="lblpertel"/></label>  
    <hr style="border: 0;height: 0;border-top: 1px solid rgba(0, 0, 0, 0.4);border-bottom: 1px solid rgba(255, 255, 255, 0.3);" width="95%"></td>
    <td width="15%"><b>Fax No.</b></td>
    <td width="44%">&nbsp;&nbsp;<label id="lblfaxno" name="lblfaxno"><s:property value="lblfaxno"/></label>
    <hr style="border: 0;height: 0;border-top: 1px solid rgba(0, 0, 0, 0.4);border-bottom: 1px solid rgba(255, 255, 255, 0.3);" width="95%"></td>
  </tr>
  <tr>
    <td><b>Mobile</b></td>
   
    <td> &nbsp;&nbsp;<label id="lblclmobno" name="lblclmobno"><s:property value="lblclmobno"/></label>
    <hr style="border: 0;height: 0;border-top: 1px solid rgba(0, 0, 0, 0.4);border-bottom: 1px solid rgba(255, 255, 255, 0.3);" width="95%"></td>
    <td><b>E Mail.</b></td>
    <td>&nbsp;&nbsp;<label id="lblclemail" name="lblclemail"><s:property value="lblclemail"/></label>
    <hr style="border: 0;height: 0;border-top: 1px solid rgba(0, 0, 0, 0.4);border-bottom: 1px solid rgba(255, 255, 255, 0.3);" width="95%"></td>
  </tr>
  <tr>
    <td><b>Date of Birth</b></td>
    <td>
    &nbsp;&nbsp;<label name="lbldobdate" id="lbldobdate" ><s:property value="lbldobdate"/></label>
     <hr style="border: 0;height: 0;border-top: 1px solid rgba(0, 0, 0, 0.4);border-bottom: 1px solid rgba(255, 255, 255, 0.3);" width="95%">
    </td>
    <td><b>P.P.No./DLN NO.</b></td>
    <td> 
     &nbsp;&nbsp;<label id="lblradlno" name="lblradlno"><s:property value="lblradlno"/>
    <hr style="border: 0;height: 0;border-top: 1px solid rgba(0, 0, 0, 0.4);border-bottom: 1px solid rgba(255, 255, 255, 0.3);" width="95%"></td>
  </tr>
</table>

<p align="justify" id="p1"><font size="1"><b>Credit Card Details: Credit Card #</b></font></p>

<%-- <table width="95%" height="20" class=tablereceipt align="left">
<!--   <tr> -->
  
  <s:iterator var="stat" value='#request.details' >
<tr>   
<%int j=0; %>
    <s:iterator status="arr" value="#stat.split('::')" var="des">   
    <%
    if(j>=0){%>
    
  <td  align="center"  class=tablereceipt>
  <s:property value="#des"/>
  </td>
   <%} else{ %>
    
  <td  align="left" class=tablereceipt >
  <s:property value="#des"/>
  </td>
  <% } j++;  %>
 </s:iterator>
</tr>
</s:iterator>

</table>
<div id="firstdiv" hidden="true" >
  <table width="95%" height="20" class=tablereceipt align="left">
  <tr> 
     <td class=tablereceipt>&nbsp;</td>
    <td class=tablereceipt>&nbsp;</td>
    <td class=tablereceipt>&nbsp;</td>
    <td class=tablereceipt>&nbsp;</td>
    <td class=tablereceipt>&nbsp;</td>
    <td class=tablereceipt>&nbsp;</td>
    <td class=tablereceipt>&nbsp;</td>
    <td class=tablereceipt>&nbsp;</td>
    <td class=tablereceipt>&nbsp;</td>
    <td class=tablereceipt>&nbsp;</td>
    <td class=tablereceipt>&nbsp;</td>
    <td class=tablereceipt>&nbsp;</td>
    <td class=tablereceipt>&nbsp;</td>
    <td class=tablereceipt>&nbsp;</td>
    <td class=tablereceipt>&nbsp;</td>
    <td class=tablereceipt>&nbsp;</td>
    <td class=tablereceipt>&nbsp;</td>
    <td class=tablereceipt>&nbsp;</td> 
  </tr> 
</table>
</div> --%>
<table width="95%" >
  <tr height="30">
  <td width="11%"><b>Card No.</b></td> 
    <td width="30%">&nbsp;<label id="lbcardno" name="lbcardno"><s:property value="lbcardno"/></label></td> 
    <td width="15%"><b>&nbsp;</b></td>
    <td width="44%"><br>
    &nbsp;</td>
</tr>
<tr>
    <td width="11%"><b>Exp. Date.</b></td>
    <td width="30%">&nbsp;<label id="lbexpcarddate" name="lbexpcarddate"><s:property value="lbexpcarddate"/></label></td>
    <td width="15%"><b>Authorisation No.</b></td>
    <td width="44%"><br>
    <hr style="border: 0;height: 0;border-top: 1px solid rgba(0, 0, 0, 0.4);border-bottom: 1px solid rgba(255, 255, 255, 0.3);" width="95%"></td>
  </tr>
</table><br/>

<p align="justify"><b><u>Declaration :</u></b></p>

<p align="justify" id="p1">I authorise Driven By You Mobility LLP or any of its associates to charge related
car / motorcycle rentals/related expenses on account of the self drive car/motorcycle hire facility to my above
mentioned card(s). These expenses are to be charged to my nominated credit card as mentioned above at the
sole discretion of Driven By You Mobility LLP. This instruction is valid on an ongoing basis. I agree to advise
Driven By You Mobility LLP if my nominated credit card account is cancelled, substituted or not renewed. In such
case, I agree to provide alternative payment instructions as specified by Driven By You Mobility LLP. The charge 
shall reflect in my statement as Driven By You Mobility LLP and I agree to not dispute the same.</p><br/>

<p align="justify"><b>Client Name and Signature :</b></p>
<br><br>
<p align="justify"><b>Date :</b></p><br/>

<br/><br/><br/><br/><br/><br/><br/><br/>

		<!-- Page 10  -->
 						 
<table width="95%">
  <tr>
    <td  width="100" height="91"  rowspan="2"></td>
    <td width="92%">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>

<%-- <table width="100%" align="center">
  <tr>
    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="<%=contextPath%>/icons/cardriven.png" width="90%" height="90%"  alt=""/></td>
  </tr>
  <tr>
    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="<%=contextPath%>/icons/drivenCarPrint2.PNG" width="580" height="250"  alt=""/></td>
  </tr>
  <tr>
    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="<%=contextPath%>/icons/drivenCarPrint3.PNG" width="580" height="250"  alt=""/></td>
  </tr>
  <!-- <br/><br/></br>
  
  <p id="para1" align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Client Name and Signature</p><br/>

<p id="para1" align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CSE Name and Signature</p>
   -->
</table><br/> --%>
  						 
<table width="95%">
  <tr>
    <td  width="100" height="91"  rowspan="2"></td>
    <td width="92%">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
<table width="100%" class="biketable2">
 <tr><td colspan="2" align="center"><strong>VEHICLE INSPECTION SHEET</strong></td></tr>
  <tr><td colspan="2" align="center">&nbsp;</td></tr>
  <tr >
    <td width="47%" ><img src="drivenbikeinsp.jpg" alt="" class="img-responsive"/></td>
    <td width="53%" ><table width="100%" height="534" class="biketable">
      <tr class="border_bottom border_top">
        <td width="48%" align="center" ><strong>Documents Check List</strong></td>
        <td width="27%" align="center" ><strong>OUT</strong></td>
        <td width="25%" align="center" class="border-right"><strong>IN</strong></td>
      </tr>
      <tr class="border_bottom border_top">
        <td> 1. Registration (RC)</td>
        <td>&nbsp;</td>
        <td class="border-right">&nbsp;</td>
      </tr>
      <tr class="border_bottom border_top">
        <td> 2. Insurance</td>
        <td>&nbsp;</td>
        <td class="border-right">&nbsp;</td>
      </tr>
      <tr class="border_bottom border_top">
        <td> 3. All India Permit</td>
        <td>&nbsp;</td>
        <td class="border-right">&nbsp;</td>
      </tr>
      <tr class="border_bottom border_top">
        <td> 4. Authorisation</td>
        <td>&nbsp;</td>
        <td class="border-right">&nbsp;</td>
      </tr>
      <tr class="border_bottom border_top">
        <td> 5. Fitness Certificate</td>
        <td>&nbsp;</td>
        <td class="border-right">&nbsp;</td>
      </tr>
      <tr class="border_bottom border_top">
        <td> 6. Poluution</td>
        <td>&nbsp;</td>
        <td class="border-right">&nbsp;</td>
      </tr>
      <tr class="border_bottom border_top">
        <td> 7. Rent A Cab License</td>
        <td>&nbsp;</td>
        <td class="border-right">&nbsp;</td>
      </tr>
      <tr class="border_bottom border_top">
        <td> 8. Letter</td>
        <td>&nbsp;</td>
        <td class="border-right">&nbsp;</td>
      </tr>
      <tr class="border_bottom border_top">
        <td align="center"><strong>Safety Gear Check List</strong></td>
        <td align="center"><strong>OUT</strong></td>
        <td align="center" class="border-right"><strong>IN</strong></td>
      </tr>
      <tr class="border_bottom border_top">
        <td> 1. Helmet</td>
        <td>&nbsp;</td>
        <td class="border-right">&nbsp;</td>
      </tr>
      <tr class="border_bottom border_top">
        <td> 2. Gloves</td>
        <td>&nbsp;</td>
        <td class="border-right">&nbsp;</td>
      </tr>
      <tr class="border_bottom border_top">
        <td> 3. Shoes</td>
        <td>&nbsp;</td>
        <td class="border-right">&nbsp;</td>
      </tr>
      <tr class="border_bottom border_top">
        <td> 4. Jacket</td>
        <td>&nbsp;</td>
        <td class="border-right">&nbsp;</td>
      </tr>
      <tr class="border_bottom border_top">
        <td> 5. Knee Guards</td>
        <td>&nbsp;</td>
        <td  class="border-right">&nbsp;</td>
      </tr>
      <tr class="border_bottom border_top">
        <td> 6. Elbow Guards</td>
        <td>&nbsp;</td>
        <td  class="border-right">&nbsp;</td>
      </tr>
      <tr class="border_bottom border_top">
        <td align="right">Customer Signature </td>
        <td colspan="2"  class="border-right">&nbsp;</td>
      </tr>
      <tr class="border_bottom border_top">
        <td align="right">CSA Signature </td>
        <td colspan="2"  class="border-right">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
</table>

<DIV style="page-break-after:always"></DIV>

 <table width="100%" align="center">
 <%--  <tr>
    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="<%=contextPath%>/icons/bikes.png" width="90%" height="90%"  alt=""/></td>
  </tr>  --%>
  <tr>
    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="<%=contextPath%>/icons/drivenCarPrint2.PNG" width="580" height="250"  alt=""/></td>
  </tr>
  <tr>
    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="<%=contextPath%>/icons/drivenCarPrint3.PNG" width="580" height="250"  alt=""/></td>
  </tr>
</table> 

<br/>
 
 
<!-- 
<p id="para1" align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Client Name and Signature</p><br/>

<p id="para1" align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CSE Name and Signature</p>

 -->
</div>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="docnoval" id="docnoval" value='<s:property value="docnoval"/>'  />
</form>
</div>
</body>
</html>