<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
 <%@ page pageEncoding="utf-8" %>
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
	font-size: 10px;
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
    <td   > &nbsp;<br>&nbsp;<br>
  
 
  
    
     </td> 
     </tr>
     </table>
      <table width="100%"  >
  <tr>
    <td width="20" rowspan="6" > &nbsp;
     </td> 
    <td width="56%" rowspan="2">&nbsp;</td>
    <td width="26%"> &nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td rowspan="2"  align="center"><b><font size="4"> &nbsp;&nbsp; &nbsp;&nbsp;Rental Agreement</font></b></td>
    <td align="left">&nbsp;</td>
  </tr>
  <tr>
    <td align="left">&nbsp;</td>
  </tr>
  <tr>
    <td rowspan="2"  align="center"><b>&nbsp;&nbsp;<font size="3">RANO :</font></b><b><font size="3"><label id="rentaldoc" name="rentaldoc" ><s:property value="rentaldoc"/></label></font></b>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>MRA NO# :<label id="mrano" name="mrano"><s:property value="mrano"/></label></b>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
    <td width="30%"><label id="clmobno" name="clmobno"><s:property value="clmobno"/></label></td> 

<td width="15%" align="right">Salesman</td>
   <td width="36%"><label id="salname" name="salname"><s:property value="salname"/></label></td> 


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
    <td width="30%" ><label id="radlno" name="radlno"><s:property value="radlno"/></label></td>
   
   <td width="22%" align="right">Exp Date</td>
    <td width="20%"  ><label id="lblaccount" name="licexpdate" ><s:property value="licexpdate"/></label></td>
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
    <tr>
    
      <td width="15%" align="left">Nationality&nbsp;&nbsp;</td>
    <td width="30%" colspan="3"><label name="lblnation" id="lblnation" ><s:property value="lblnation"/></label></td>
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
By initialing, I understand that in case of accident, even though availed CDW/SUPER CDW, must be accompanied by a valid police report. 
If without CDW/SUPER CDW, I will be liable to pay excess deductible  amount __________ <%-- amount of  AED .<label   id="excessinsu" name="excessinsu"><s:property value="excessinsu"/> --%></label>

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
  <table width="100%"  >
<tr><td  width="50%"></td><td width="50%" height="25px" > <fieldset style="height:100%;"></fieldset></td>
<%-- <label style="text-align: right;display: block;" id="excessinsu" name="excessinsu"><s:property value="excessinsu"/></label> --%>
</tr>
</table>
</fieldset>

 </td>
 </tr>
 
 </table>
 
 <table width="100%">
 <tr>
 <td>
  <fieldset>
  <legend><b>Terms & Conditions</b></legend> 
 <p align="justify">
  &nbsp;&nbsp;&nbsp;&nbsp;I have reviewed and agreed to all the terms and conditions of this agreement and confirm that if payment is to be made by my credit
  card my signature below shall constitute authority to debit my nominated credit card or I will pay to the company the total amount due in cash.
   I further agree to pay all traffic and parking and other violations (charged during the rental period). I undertake not to drive the vehicle outside the
    UAE without prior written approval from the company. Minimum rental period is 24hrs. 4 x 4 vehicles are for paved road driving only.
     Desert driving is not permitted. Customers will be charged in full or any damage caused by off road driving. The hirer is responsible 
     for the excess liability charge of AED 1500 in case of accident. If the hirer is under the age of 25yrs or the national driving license is less
      than one year old then he must pay 20% of the damage charges as the liability as mentioned above. The renter acknowledges that 
      early termination of rental contract will result in higher rate calculation based on applicable rates for either daily, weekly or monthly rates.
       Vehicle you have been upgraded to is for temporary use only. Once the vehicle in your charge group is available Sel will contact you for an exchange. 
       Three (3) attempts for exchange will be made if all three attempts are unsuccessful you will be charged for the upgraded vehicle from the date 
       the vehicle in your charge group was available.
       </p>
       </fieldset>
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
  <tr>
 <td>Due Date </td> <td> <label id="duedate" name="duedate"><s:property value="duedate"/></label></td>
  
 <td> <label id="duetime" name="duetime"><s:property value="duetime"/></label></td>

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
     
     <tr> <td width="40%">SUPER CDW</td><td  width="20%" align="right"><label id="rasupercdw" name="rasupercdw"><s:property value="rasupercdw"/></label></td><td  width="30%" >&nbsp; </td></tr>
     
                 
      <tr> <td width="40%">PAI</td><td  width="20%" align="right"><label id="lblpai" name="lblpai"><s:property value="lblpai"/></label></td><td  width="30%" >&nbsp; </td></tr>
      
        <tr> <td width="40%">VMD</td><td  width="20%" align="right"><label id="ravmd" name="ravmd"><s:property value="ravmd"/></label></td><td  width="30%" >&nbsp; </td></tr>
         
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
    
 
        <table width="100%">
    <tr>
    <td width="100%">
 
  </td>
  </tr>
  </table> 

 
  <table width="100%">
 <tr>
 <td  >
  <fieldset>
  <legend><b> تفاصيل سائق إضافية </b></legend> 
 <p  style="text-align: justify;text-align-last: right;">
قد استعرضت ووافقت على جميع المصطلحات وشروط هذا الاتفاق وتؤكد أنه إذا دفع هو الذي سيدلي به بطاقة الائتمان الخاصة بي توقيعي المبينة أدناه تشكل سلطة الخصم بطاقة الائتمان الخاصة بي رشح أو سوف تدفع للشركة المبلغ الإجمالي المستحق نقدا. كما أوافق على دفع كل حركة المرور ومواقف السيارات وغيرها من ا نتهاكات (اتهم خلال فترة الإيجار). أتعهد بعدم قيادة السيارة خارج الدولة دون الحصول على موافقة خطية مسبقة من الشركة. أتعهد بعدم قيادة السيارة خارج الدولة دون الحصول على موافقة خطية مسبقة من الشركة. فترة الإيجار الحد الأدنى هو 24 ساعة. 4 * 4 السيارات هي لطريق معبد القيادة فقط. لا يسمح القيادة في الصحراء.  وستحمل العملاء بالكامل أو أي ضرر ناتج عن القيادة على الطرق الوعرة. في حال حدوث اي حادث تغريمه مبلغ 1500 في حال اي حادث حصل على المركبة.اذا كان المستأجر اصغر عن سن 25 عاما, أو رخصة قيادة وطنية أقل من سنة واحدة ثم لا بد له من دفع 20٪ من رسوم الضرر المسؤولية على النحو المذكور أعلاه. المستأجر يقر بأن الإنهاء المبكر للعقد الإيجار سوف يؤدي إلى ارتفاع معدل حساب الأسعار المطبقة على أساس إما يوميا،, أسبوعية أو شهرية أسعار الفائدة. السيارة التي تم الترقية إلىها هي فقط للاستخدام المؤقت. مرة واحدة في السيارة مجموعة نفقاتك متاح سوف اتصل بك  لتبادل. وسوف تتاح ثلاثة (3) محاولات للتبديل لو أن كل المحاولات الثلاث غير ناجحة وسيتم محاسبتك على السيارة التي تم الترقية اليها من تاريخ استلام  السيارة في المجموعة نفقاتك كانت متاحة.
       </p>
       </fieldset>
</td>
</tr>
 
</table>
  <fieldset width="100%">
    <legend>
     <b>Signature</b></legend>
      
  
     <table  width="100%"   >
           <tr>
    <td> 
       I have read and understood the terms & conditions above  and agree with my signature to the same and acknowledge that 
       a) Disclaimer b) Credit Card Authorization  c) Vehicle Checklist (for original and replacement vehicles) are part of this agreement.</td>
    </tr>
    <tr><td><hr noshade size=1>  </td></tr>
  
    <tr>
    <td align="left" > Customer Signature
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Date</td></tr>
  <!--   <tr> <td align="left" ><hr noshade size=1>Date</td></tr> -->
   <tr><td>  <br><hr noshade size=1>  <br></td></tr>
     <tr> <td align="left" > Sales Agent	
      &nbsp; <label id="salagent" name="salagent"><s:property value="salagent"/></label></td></tr>
            <tr> <td align="left" >  Date </td></tr>
     <!--  <tr> <td align="left" ><hr noshade size=1>Date</td></tr> -->
        <tr> <td align="left" >  Rental Agent   &nbsp;
      <label id="raagent" name="raagent"><s:property value="raagent"/></label>   </td></tr>
      
      
      <tr> <td align="left" >  Date </td></tr>
     <!--  <tr> <td align="left" ><hr noshade size=1>Date</td></tr> -->
      
     </table>
     
 </fieldset>
 
    
     
  </td>
    </tr>
  </table>
 
 <!-- Page 2 -->
 
 

 </div>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="docnoval" id="docnoval" value='<s:property value="docnoval"/>'  />
</form>
</div>
</div>
</body>
</html>
    