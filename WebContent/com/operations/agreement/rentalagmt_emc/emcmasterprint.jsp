<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<%@ page pageEncoding="utf-8" %>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<% String contextPath=request.getContextPath();%>
<title>GatewayERP(i)</title>
<!-- <link rel="stylesheet" type="text/css" href="../../../../css/body.css">  -->
  <jsp:include page="../../../../includes.jsp"></jsp:include>  
<style>
table tr td{
	cell-spacing:0;
	cell-padding:0;
	 border-spacing: 0px 0px 0px 0px;
}
#tablebrdr {
    border: 1px solid #CCC;
    border-collapse: collapse;
}

#tdbrdr {
    border: none;
}
#cell_space{
cellspacing:0;
cellpadding:0;
 border-spacing: 0px 0px;
}
 .hidden-scrollbar {
  overflow: auto;
/*  height: 900px;  */
} 

label {
    font: normal 10px ;
}

#terms{
font-size: 7px;
}
  /* fieldSet
    {
        
    
        border-width: 1px; border-color: rgb(225,224,223);
       
        margin:0;
    } */
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
	.bordertop{
		border-top:1px solid #000;
	}
	.borderbottom{
		border-bottom:1px solid #000;
	}
	.borderleft{
		border-left:1px solid #000;
	}
	.borderright{
		border-right:1px solid #000;
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
<form id="frmPrintlease" action="printleaseone" autocomplete="off" target="_blank">
 <div style="background-color:white;">

<!-- <hr noshade size=1 > -->
 <table width="100%">
     <tr>
      <td width="100%"><img src="<%=contextPath%>/icons/emcheadder.png" width="100%" height="75%"  alt=""/></td>
     </tr>
    <tr>
    <td  align="center" width="100%"><b>Contract No: &nbsp; </b><b><label id="rentaldoc" name="rentaldoc" ><s:property value="rentaldoc"/></label>&nbsp;:رقم العقد </b></td>
    </tr></table>
<table width="100%">
  <tr>
  <td width="50%">
  
  <fieldset>
  <table width="100%"> 
  <tr>
      <td width="20%" align="left" >Name :&nbsp; </td><td></td>
    <td width="60%"  align="center"><label id="clname" name="clname"><s:property value="clname"/></label></td><td width="20%"  align="right">&nbsp; :الاسم </td>
    </tr>
      <tr>
    <td  align="left"> Address :</td><td></td>
    <td height="40px" width="60%"  align="center"><label id="claddress" name="claddress"><s:property value="claddress"/></label></td><td width="20%"  align="right">&nbsp;:العنوان </td>
    </tr>
    <tr></tr>
   </table>
  <table width="100%" >
      <tr>
    <td width="23%" align="left">MOB :</td>
    <td width="40%" align="center"><label id="clmobno" name="clmobno"><s:property value="clmobno"/></label></td><td width="37%"  align="right">&nbsp; :هاتف متحرك </td>
 </tr>
 <tr>
    <td  align="left" width="23%"> Email :  </td>
    <td width="40%" align="center"><label id="clemail" name="clemail"><s:property value="clemail"/></label></td><td width="37%"  align="right">&nbsp; :البريد الإلكتروني </td>
    </tr>
    
    <tr>
    <td  align="left" width="23%">Job Card No :   </td>
        <td width="40%" align="center" ><label id="job_cardno" name="job_cardno"><s:property value="job_cardno"/></label></td><td width="37%"  align="right">&nbsp; :مرجع العمل </td>
    </tr>
    <tr>
    <td  align="left" width="25%">Registration no : </td>
    <td width="38%" align="center"><label id="reg_no" name="reg_no"><s:property value="reg_no"/></label></td><td width="37%"  align="right">&nbsp; :رقم اللوحة </td>
    </tr>
    </table>
</fieldset>
<fieldset><legend><b>Driver Details&nbsp;&nbsp;&nbsp; بيانات السائق</b></legend>
    <table  width="100%" >	
   <tr>
      <td width="20%" align="left">Name : </td>
    <td width="60%" colspan="3" align="center">&nbsp;&nbsp;&nbsp;<label id="radrname" name="radrname"><s:property value="radrname"/></label></td>
    <td align="right"><span style="font-size:11px;">&nbsp;: الاسم </span></td>
     
    </tr>
    </table>
        <table  width="100%" >
    <tr>
        <td  width="23%" align="left">D\L NO :&nbsp; </b></td>
    <td width="40%"  align="center"><label id="radlno" name="radlno"><s:property value="radlno"/></label></td>
    <td id="terms" width="37%" align="right"><span style="font-size:11px;">&nbsp;:رقم رخصة القيادة </span></td>
    </tr>
    <tr>
   <td width="23%" align="left">Exp Date : &nbsp;&nbsp; </td>
    <td width="40%" align="center"><label id="lblaccount" name="licexpdate" ><s:property value="licexpdate"/></label></td>
    <td id="terms" width="37%" align="right"><span style="font-size:11px;">:تاريخ الانتهاء	</span></td>
    </tr>
<%--     <tr>
     <td align="left" width="23%">Passport NO : &nbsp; </td>
    <td  width="40%" align="center"> <label name="passno" id="passno" ><s:property value="passno"/></label></td>
    <td id="terms" width="37%" align="right">&nbsp;:رقم جواز السفر</td>
    </tr>
 --%>
  <tr>

    <td width="23%" align="left">Emirates ID Or Passport no :&nbsp; </td>
    <td width="35%" align="center"><label name="emiratesid" id="emiratesid" ><s:property value="emiratesid"/></label></td>
    <td id="terms" width="37%" align="right"><span style="font-size:11px;">:رقم الهوية او جواز السفر </span></td>
    </tr>
     <tr>
    <td width="23%" align="left">Exp Date :&nbsp;</td>
    <td width="40%" align="center"><label name="passexpdate" id="passexpdate" ><s:property value="passexpdate"/></label></td>
    <td id="terms" width="37%" align="right"><span style="font-size:11px;">&nbsp;:تاريخ الانتهاء  </span></td>
   </tr> 
   <tr>

    <td width="23%" align="left">DOB :&nbsp;&nbsp;</td>
    <td width="40%" align="center"><label name="dobdate" id="dobdate" ><s:property value="dobdate"/></label></td>
    <td id="terms" width="37%" align="right"><span style="font-size:11px;">&nbsp;:تاريخ الميلاد  </span></td>
    </tr>
   
    </table>
</fieldset>
  <fieldset>
  <legend><b> Vehicle&nbsp;&nbsp;&nbsp;&nbsp;   نوع المركبة</b></legend>
   <%-- <table width="100%">  
  <tr>
    
    <td  colspan="3" width="50%"  ><label id="ravehname" name="ravehname"><s:property value="ravehname"/></label></td>
    <td width="15%" align="left">YOM :&nbsp;</td><td width="14%" align="center"> <label id="rayom" name="rayom"><s:property value="rayom"/></label></td><td id="terms" width="19%" align="right">&nbsp;: سنةالصنع  </td>
   
    </tr>
   
   <!--  </table>
      <table width="100%">  -->
      <tr>
      <td width="17%" align="left" >Reg NO :&nbsp;</td><td  width="16%" align="center"><label id="ravehregno" name="ravehregno"><s:property value="ravehregno"/></label></td><td id="terms" width="15%" align="right">&nbsp; :رقماللوحة</td>
      <td width="15%" align="left">Group :&nbsp;</td><td  width="18%" align="center"><label id="ravehgroup" name="ravehgroup"><s:property value="ravehgroup"/></label></td> <td width="15%" align="right"></td>
    </tr>
    <tr>
     <td width="20%" align="left">Chassis No:</td><td  width="15%" align="center"> <label id="vehdet_chasisno" name="vehdet_chasisno"><s:property value="vehdet_chasisno"/></label></td><td id="terms" width="15%" align="right">&nbsp; :الرقمالتعريفي</td>
       <td width="13%" align="left">Color :&nbsp;</td><td  width="18%" align="center"><label id="racolor" name="racolor"><s:property value="racolor"/></label></td><td width="15%" align="right">&nbsp; :اللون</td>
     </tr>
     <tr>
   
    <td width="15%" align="left">KM :</td><td width="18%" align="center"> <label id="raklmout" name="raklmout"><s:property value="raklmout"/></label></td><td id="terms" width="15%" align="right">&nbsp; :عددالكيلوميترات</td>
      
        <td  width="15%" align="left">Fuel :&nbsp;</td><td width="18%" align="center"> <label id="rafuelout" name="rafuelout"><s:property value="rafuelout"/></label></td><td width="15%" align="right">&nbsp; :الوقود </td>
    </tr>  
    </table> --%>
    <table width="100%">
    	<tr>
    		<td width="30%">Name</td>
    		<td width="30%" ><label id="ravehname" name="ravehname"><s:property value="ravehname"/></label></td>
    		<td width="30%" align="right">الاسم</td>
    	</tr>
    	<tr>
    		<td width="30%">YOM</td>
    		<td width="30%"><label id="rayom" name="rayom"><s:property value="rayom"/></label></td>
    		<td width="30%" align="right">سنة الصنع</td>
    	</tr>
    	<tr>
    		<td width="30%">Reg NO</td>
    		<td width="30%"><label id="ravehregno" name="ravehregno"><s:property value="ravehregno"/></label></td>
    		<td width="30%" align="right"> رقم اللوحة</td>
    	</tr>
    	
    	<tr>
    		<td width="30%">Category</td>
    		<td width="30%"><label id="branch" name="branch"><s:property value="Barnchval"/></label><%-- <label id="ravehgroup" name="ravehgroup"><s:property value="ravehgroup"/></label> --%></td>
    		<td width="30%" align="right"><!-- الصنف -->ال صنف</td>
    	</tr>
    	
    	<tr>
    		<td width="30%">KM</td>
    		<td width="30%"><label id="raklmout" name="raklmout"><s:property value="raklmout"/></label></td>
    		<td width="30%" align="right">عدد الكيلو ميترات</td>
    	</tr>
    	
    	<tr>
    		<td width="30%">Fuel</td>
    		<td width="30%"><label id="rafuelout" name="rafuelout"><s:property value="rafuelout"/></label></td>
    		<td width="30%" align="right">الوقود</td>
    	</tr>
    	
    	<tr>
    		<td width="30%">Chassis No</td>
    		<td width="30%"><label id="vehdet_chasisno" name="vehdet_chasisno"><s:property value="vehdet_chasisno"/></label></td>
    		<td width="30%" align="right">الرقم التعريفي </td>
    	</tr>
    	
    	<tr>
    		<td width="30%">Color</td>
    		<td width="30%"><label id="racolor" name="racolor"><s:property value="racolor"/></label></td>
    		<td width="30%" align="right">اللون</td>
    	</tr>
    </table>
    </fieldset>
    <div style="width:100%;height:54px;"></div>
  <%--      <fieldset>
    <legend><b> Release Vehicle Details &nbsp;&nbsp; بياناتتسليمالسيارة</b></legend>
    <table width="100%" >
    <tr>
    <td width="10%" align="left">Date :</td>
    <td width="18%"><label id="radateout" name="radateout"><s:property value="radateout"/></label>:تاريخ.</td>
    <td width="12%" align="right">Time :&nbsp;&nbsp;</td>
     <td width="15%"><label id="ratimeout" name="ratimeout"><s:property value="ratimeout"/>&nbsp; : الوقت</label></td>
    </tr>
    <tr>
   
    <td width="10%" align="left">KM :</td><td width="25%">
      <label id="raklmout" name="raklmout"><s:property value="raklmout"/></label>&nbsp; :عددالكيلوميترات</td>
      
        <td width="10%" align="right">Fuel :&nbsp;&nbsp;</td><td width="30%">
      <label id="rafuelout" name="rafuelout"><s:property value="rafuelout"/></label>&nbsp; :الوقود </td>
    </tr>
    <tr>
    <td width="10%" align="left">Due Date :</td><td width="25%">
      <label id="outdet_duedate" name="outdet_duedate"><s:property value="outdet_duedate"/></label>:تاريخالاعادة</td>
      
       
    </tr>
    </table>
    </fieldset> --%>

<!-- <table><tr><td></td></tr></table> adjust space
 <table><tr><td></td></tr></table>
 <table><tr><td></td></tr></table> adjust space
 
 <table><tr><td></td></tr></table>
<br>
<br> -->
<!-- <br>
<br> -->
<br>

  </td>
  <td width="50%">
 
  <table width="100%" >

<tr>
<td width="100%">
 <fieldset >

<!-- <table width="100%" >
<tr><td  width="40%"></td><td width="50%" height="15px" > <fieldset style="height:100%;"></fieldset></td>
</tr>
</table> -->
<b>Terms And Conditions</b>
<p id="terms" >In order to comply with local laws we are required to obtain a valid UAE driving license copy before allowing one of our vehicles to be driven. Your co-operation is highly appreciated.
I undertake to use the vehicle provided by EMC for normal transportation in the city and not for racing or any other illegal activity. I agree to bear all cost related to non-compliance of my above undertaking. I agree to inform EMC and get their approval before another person will drive the vehicle. In any case, a valid driving drivinglicense must be presented.
All our cars are non-smoking cars. Nobody under the age 21 is permitted to drive the car or if the user is not added as additional driver.</br>
1) Driving License: I confirm that I am owner of the mentioned driving license and that I am legally allowed to drive the vehicle being provided by EMC.</br>
2) Salik/ Fuel: I agree that all cost related to Salik during the period of usage will be charged to me upon returning the vehicle to EMC.
I agree to return the vehicle with the same level of fuel when received. In case of non-compliance the amount involved will be paid by me upon returning the vehicle to EMC.</br>
3) Traffic Violations: I undertake to drive the vehicle provided by EMC in the accordance with all existing traffic regulations. In case of traffic fines combined with black points, I agree that EMC will forward all relevant details to the authorities in order to transfer the black points to my driving license.
I agree to reimburse EMC all traffic fines or other cost as a result of non-observance of traffic regulations. I authorize EMC to debit all related cost administrations fee to my credit card listed below. I authorize EMC to block a guarantee amount of AED 3,000 from my credit card listed below.</br>
4) Accident: In case of accident, I will supply the related police valid report to EMC. In the event that I will be held responsible for the accident according to the police report, I authorize EMC to debit the insurance excess of between AED 750 up to AED 1,500 to below mentioned credit card if I did not pay in cash.  
For persons under 25 years of age, there is an excess of 20% of the repairs or the current value of the car in case of a total lost.</br>
5) Delayed return: I agree to return the vehicle to EMC within 24 hours after being notified that my vehicle is ready for collection. In the event that the vehicle is not returned within 24 hours, I accept to pay the charge of AED 900/- per day.
All above mentioned clause apply also for all other drivers using the mentioned vehicle while it is under my possession.</p>

<p id="terms" align="right"><b>الشروط  والاحكام</b> <br><br>
تلبية للقوانين المحلية فإنه مطلوب منا الحصول على صورة من رخصة القيادة وبطاقة الإئتمان لمستخدمي سياراتنا قبل السماح لهم بقيادتها، نشكر لكم تعاونكم. 
أوافق على أن السيارة التي استلمتها من شركة الإمارات للسيارات هي لغرض المواصلات العادية، و لن يتم قيادة السيارة بهدف التسابق أو لأية غايات غير قانونية. وأوافق على تحمل كافة المسؤوليات المترتبة على عدم الإلتزام بهذا التعهد. وأوافق على الحصول على الموافقة المسبقة من شركة الإمارات للسيارات قبل السماح لأي شخص آخر بقيادة السيارة. في أي حال، يجب تقديم رخصة قيادة سارية المفعول
جميع السيارات لدينا مخصصة لغير المدخنين. ولا نسمح لمن دون 21 بقيادة السيارة أو اذا لم يكن المستخدم قد أضيف كسائق اضافي.<br>
رخصة القيادة<br>
أوكد بأني مالك رخصة القيادة المذكورة أدناه، ومسموح لي قانونيا بأن أقود السيارة التي تم تقديمها لي من قبل شركة الإمارات للسيارات.
<br>
سالك / الوقود
أوافق على كل التكاليف التابعة لسالك اثناء فترة إستخدامي للسيارة وسوف أقوم بسداد المبلغ عند إسترجاع السيارة لدى شركة الامارات للسيارات. وأتعهد بإرجاع السيارة بنفس كمية الوقود الموجودة لدى إستلامي للسيارة
<br>
الـمخالفات المرورية
أتعهد بقيادة السيارة التابعة لشركة الامارات للسيارات بموجب التعليمات ولوائح الشرطة، وفي حالة حصول مخالفات المرورية وكذلك النقاط السوداء، أوافق على أن تقوم شركة الامارات للسيارات بتحويل النقاط السوداء إلى رخصة قيادتي.
وأوافق أن أسدد إلى شركة الإمارات للسيارات كل المخالفات المرورية أو أي تكاليف أخرى كنتيجة لعدم مراعاة أحكام ولوائح المرور. وأفوض شركة الإمارات للسيارات لإستقطاع كافة رسوم المخالفات المرورية من بطاقتي الإئتمانية المدونة أدناه. كما أفوض شركة الإمارات للسيارات حق حجز مبلغ 3000 درهم كضمان من بطاقتي الإئتمانية المدونة أدناه
<br>
الحوادث
في حال وقوع حادث أتعهد بتزويد شركة الامارات للسيارات بتقرير الشرطة ساري المفعول. في نفس مكان الحادث وفي حال كوني متسبباً بالحادث طبقاً لتقرير الشرطة، فإني أفوض شركة الإمارات للسيارات لتحويل مبلغ زيادة التأمين (والذي لا يقل عن 750 درهم و لايزيد عن 1500 درهم)، إذا لم يتم الدفع نقداً الى بطاقة الإئتمان المذكوره أدناه.
الأشخاص الأقل من 25 عام، يفرض تحمل 20% من قيمة الاصلاح أو المركبة في حالة شطب المركبة
<br>
التأخر في التسليم
أوافق على إرجاع السيارة إلى شركة الإمارات للسيارات خلال 24 ساعة من لحظة إعلامي بجهوزية سيارتي وإللا سوف يتم استقطاع مبلغ و قدره 900 درهم عن كل يوم تأخير.
كل البنود المذكوره أعلاه تطبق أيضاً على كل السائقين والمستخدمين للسيارة المذكورة عندما تكون تحت ملكيتي.

</p>
</fieldset>

 </td>
 </tr>

 </table>
 
  </td>
    </tr>
  </table>
	<table width="100%" >
		<tr>
			<td width="50%" class="bordertop borderright borderleft borderbottom">
				<table width="100%">
					<tr>
						<td width="50%" class="borderbottom"><b>Release Vehicle details</b></td>
						<td width="50%" align="right" colspan="2"  class="borderbottom"> بيانات تسليم السيارة </td>
					</tr>
					<tr>
						<td width="25%" align="left"  class="borderbottom">Date &amp; Time Out</td>
						<td width="25%"  align="left"  class="borderbottom"><label id="outdateprint" name="outdateprint"><s:property value="outdateprint"/></label>&nbsp;<label id="outtime" name="outtime"><s:property value="outtime"/></label></td>
						<td width="50%"  align="right"  class="borderbottom"> تاريخ ووقت الخروج </td>
					</tr>
					<tr>
						<td width="20%" align="left">Mileage Out</td>
						<td width="20%"  align="left"><label id="raklmout" name="raklmout"><s:property value="raklmout"/></label></td>
						<td width="60%"  align="right">  عدد الكيلوميترات </td>
					</tr>
					<tr>
						
					</tr>
				</table>
			</td>
			<td width="50%" class="bordertop borderright borderbottom">
				<table width="100%">
					<tr>
						<td width="50%" class="borderbottom"><b>Closing Details </b></td>
						<td width="50%" align="right" colspan="2" class="borderbottom"> بيانات اعادة السيارة  </td>
					</tr>
					<tr>
						<td width="25%" align="left" class="borderbottom">Date &amp; Time In</td>
						<td width="25%"  align="left" class="borderbottom"><label id="indateprint" name="indateprint"><s:property value="indateprint"/></label>&nbsp;<label id="intime" name="intime"><s:property value="intime"/></label></td>
						<td width="50%"  align="right" class="borderbottom">تاريخ ووقت الاعادة </td>
					</tr>
					<tr>
						<td width="20%" align="left">Mileage In</td>
						<td width="20%"  align="left"><label id="inmileageprint" name="inmileageprint"><s:property value="inmileageprint"/></label></td>
						<td width="60%"  align="right">  عدد الكيلوميترات عند اعادة السيارة</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<table  id="cell_space" width="100%">
				  <tr>
				  <td width="10%" style="border-top:1px solid #000;border-left:1px solid #000;">VEHICLE OUT<span style="border:1px solid #000;padding-top:25px;padding-bottom:25px;display:block;margin-top:3px;text-align:center;">Fuel for <label id="rafuelout" name="rafuelout"><s:property value="rafuelout"/></label><%-- <label id="outfueldet" name="outfueldet"><s:property value="outfueldet"/></label> --%></span></td>
				  <td  width="40%" style="border-top:1px solid #000;border-right:1px solid #000;"><img src="<%=contextPath%>/icons/carinoutimg.png" width="100%" height="140px"  alt=""/></td>
				  <td width="10%" style="border-left:1px solid #000;border-top:1px solid #000;">VEHICLE IN<span style="border:1px solid #000;padding-top:25px;padding-bottom:25px;display:block;margin-top:3px;text-align:center;">Fuel for <%-- <label id="rafuelin" name="rafuelin"><s:property value="infuel"/></label> --%> <label id="infueldet" name="infueldet"><s:property value="infueldet"/></label> </span></td>
				  <td width="40%" style=" border-right:1px solid #000;border-top:1px solid #000;"><img src="<%=contextPath%>/icons/carinoutimg.png" width="100%" height="140px"  alt=""/></td>
				  <!-- <td width="2%" >&nbsp;</td> -->
				  </tr>
				  <tr >
				  <td colspan="2" height="30px" style="vertical-align:bottom;border-left:1px solid #000;">Customer's Signature ---------------------------------------------------  توقيع العميل</td>
				  <td colspan="2"  height="30px" style="vertical-align:bottom ;border-right:1px solid #000;border-left:1px solid #000;">Customer's Signature -------------------------------------------------- توقيع العميل</td>
				  </tr>
				  <tr>
				  <td colspan="2" height="30px" style="vertical-align:bottom;border-left:1px solid #000;border-bottom:1px solid #000;">Employee's Signature --------------------------------------------------  توقيع الموظف</td>
				  <td colspan="2" height="30px" style="vertical-align:bottom;border-right:1px solid #000;border-left:1px solid #000;border-bottom:1px solid #000;">Employee's Signature --------------------------------------------------  توقيع الموظف</td>
				  </tr>
				  
				  </table>
			</td>
		</tr>
	</table>
   <%-- <table  width="98%" id="tablebrdr" border="1"> 
   <tr>
   <th align="left" style="border-right:1px solid #000;border-top:1px solid #000;border-left:1px solid #000;"><b>Release Vehicle details &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="text-align:right;"> بيانات تسليم السيارة </span>  </b></th>
   <th align="left" style="border-right:1px solid #000;border-top:1px solid #000;border-left:1px solid #000;"><b>Closing Details &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; بيانات اعادة السيارة  </b></th>
   </tr>
   <tr>
  <td width="50%" style="border-right:1px solid #000;border-top:1px solid #000;border-left:1px solid #000;">Date Out &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label id="outdateprint" name="outdateprint"><s:property value="outdateprint"/></label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;تاريخ الخروج </td>
  <td  style="border-right:1px solid #000;border-top:1px solid #000;border-left:1px solid #000;">Date In &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label id="indateprint" name="indateprint"><s:property value="indateprint"/></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;تاريخ في</td>
  </tr> 
  <!-- <tr>
  <td id="tdbrdr" style="border-right:1px solid #000;">&nbsp;&nbsp;&nbsp;Date Out &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;تاريخ الخروج   </td>
  </tr>
  <tr>
  <td id="tdbrdr">&nbsp;&nbsp;&nbsp;Date In &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;تاريخ في</td>
  </tr>
 -->  
 <tr>
  <td  width="49%" style="border-bottom:1px solid #000;border-right:1px solid #000;border-top:1px solid #000;border-left:1px solid #000;">Mileage Out &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label id="raklmout" name="raklmout"><s:property value="raklmout"/></label> <label id="outmileageprint" name="outmileageprint"><s:property value="outmileageprint"/></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  عدد الكيلوميترات  </td>
  <td  style="border-bottom:1px solid #000;border-right:1px solid #000;border-top:1px solid #000;border-left:1px solid #000;">Mileage In &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <label id="inmileageprint" name="inmileageprint"><s:property value="inmileageprint"/></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  عدد الكيلوميترات عند اعادة السيارة</td>
   </table>
  
  
  <table  id="cell_space" >
  <tr>
  <td width="9%" style="border-top:1px solid #000;border-left:1px solid #000;">VEHICLE OUT<span style="border:1px solid #000;padding-top:25px;padding-bottom:25px;display:block;margin-top:3px;text-align:center;">Fuel for <label id="rafuelout" name="rafuelout"><s:property value="rafuelout"/></label><label id="outfueldet" name="outfueldet"><s:property value="outfueldet"/></label></span></td>
  <td  width="40%" style="border-top:1px solid #000;"><img src="<%=contextPath%>/icons/carinoutimg.png" width="100%" height="150px"  alt=""/></td>
  <td width="9%" style="border-left:1px solid #000;border-top:1px solid #000;">VEHICLE IN<span style="border:1px solid #000;padding-top:25px;padding-bottom:25px;display:block;margin-top:3px;text-align:center;">Fuel for <label id="rafuelin" name="rafuelin"><s:property value="infuel"/></label> <label id="infueldet" name="infueldet"><s:property value="infueldet"/></label> </span></td>
  <td width="40%" style=" border-right:1px solid #000;border-top:1px solid #000;"><img src="<%=contextPath%>/icons/carinoutimg.png" width="100%" height="150px"  alt=""/></td>
  <td width="2%" ></td>
  </tr>
  <tr >
  <td colspan="2" height="30px" style="vertical-align:bottom;border-left:1px solid #000;">Customer's Signature ---------------------------------------------------  توقيع العميل</td>
  <td colspan="2"  height="30px" style="vertical-align:bottom ;border-right:1px solid #000;border-left:1px solid #000;">Customer's Signature -------------------------------------------------- توقيع العميل</td>
  </tr>
  <tr>
  <td colspan="2" height="30px" style="vertical-align:bottom;border-bottom:1px solid #000;border-left:1px solid #000;">Employee's Signature --------------------------------------------------  توقيع الموظف</td>
  <td colspan="2" height="30px" style="vertical-align:bottom;border-bottom:1px solid #000;border-right:1px solid #000;border-left:1px solid #000;">Employee's Signature --------------------------------------------------  توقيع الموظف</td>
  </tr>
  
  </table> --%>
  <!-- <div style="page-break-after:always;"></div> -->
  
  
  <table width="100%">
     <tr>
      <td width="100%"><img src="<%=contextPath%>/icons/emcsecondheadder.png" width="100%" height="80%"  alt=""/></td>
     </tr>
  </table>
  <table width="100%" >
  <tr><th width="100%" align="center"><b><font size="4">Credit Card Authorization Form</font></b> </th></tr>
  <tr><td width="100%" align="center"> <b><font size="4"> نموذج تفويض بطاقة الائتمان </font></b></td></tr>
  </table>
  <br>
  <br>
  <table width="100%">
  <tr>
  <td>
  <p>By signing this form I authorize EMC to charge my credit card listed below for any and all recurring charges and invoices on my account as agreed below and strictly forthe implementation of any outstanding liabilities under the loan Agreement speciﬁed herein.</p>
  <p>I understand and agree, all charges checked will be billed to  the credit card listed below.</p>
  

  
  </td>
  <td>
  <p align="right">
.بالتوقيع على هذه الإتفاقيه أنا أفوض شركة الإمارات للسيارات بالخصم من بطاقة   الإئتمان  المبين تفاصيلها أدناه عن أى أو كل الرسوم أو الفواتير الموجوده بحسابي حسب ما هو متفق عليه آدناه ، و تحديداً لتنفيذ أى إلتزامات قائمه تحت إتفاقية الإعاره المحدده هاهنا
</p>
<p align="right">أقر و أوافق على أن كل الرسوم المقيده سوف تخصم من بطاقة الإئتمان المبين تفاصيلها أدناه
  </p></td>
  </tr>
  </table>
  <table width="100%" >
  <tr>
  <td width="30%" align="right">سالك</td>
  <td width="30%" align="right">مخالفات مروريه
</td>
  <td width="40%" align="right"> أخرى </td>
    </tr>
  
  <tr>
  <td width="30%" align="right"><input type="checkbox" id="salik" />Salik</td>
  <td width="30%" align="right"><input type="checkbox" id="tarif" />Traffic fine</td>
  <td width="40%" align="right"><input type="checkbox" id="otr" />Others</td>
  </tr>
  </table>
  
  <table width="100%">
  <tr>
  <td width="33%">Agreement :&nbsp;<b> <label id="rentaldoc" name="rentaldoc" ><s:property value="rentaldoc"/></label></b>&nbsp;:إتفاقيهًرقم </td>
  <td width="33%"> Start: &nbsp;<b><label id="outdateprint" name="outdateprint"><s:property value="outdateprint"/></label></b>&nbsp; :بدايه </td>
  <td width="33%"> End:&nbsp;<b><label id="indateprint" name="indateprint"><s:property value="indateprint"/></label></b>&nbsp;:نهاية</td>
  </tr>
  </table>
  </br>
  </br>
  <table width="100%"   >
  <th align="center" colspan="3">CREDIT CARD DETAILS &nbsp; تفاصيل بطاقة الإئتمان</th>
  <tr></tr>
  <tr></tr>
  <tr> 
  <td width="14%" >Customer Name:</td><td style="border-bottom:1px solid #000;" align="center"><label   id="customername" name="customername"><s:property value="customername"/></label></td> <td width="10%" align="right">:إسم العميل </td>
  </tr>
  <tr>
  <td >Billing Address :</td><td style="border-bottom:1px solid #000;" align="center"><label  id="cusaddress" name="cusaddress"><s:property value="cusaddress"/></label></td><td align="right"> :عنوان الفواتير 
</td>
  </tr>
  <tr>
  <td >Phone:</td><td style="border-bottom:1px solid #000;" align="center"><label id="customerphno" name="customerphno"><s:property value="customerphno"/></label></td><td align="right"> :هاتف</td></tr>
  <tr><td> Email:</td><td style="border-bottom:1px solid #000;" align="center"><label id="customeremail" name="customeremail"><s:property value="customeremail"/></label></td><td align="right"> :بريد إلكترونى
 </td>
  </tr>
  </table>
  <br>
  <br>
  <table width="100%" >
  <tr>
   <td width="15%" align="left">&nbsp;&nbsp;نوع البطاقة</td>
  <td width="20%" align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;تأشيرة</td>
  <td width="25%" align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ماسترًكارد </td>
  <td width="25%" align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; أمريكان إكسبريس
 </td>
    </tr>
  
  <tr>
  <td width="20%" align="left">Card Type:</td>
  <td width="20%" align="left"><input type="checkbox" />VISA</td>
  <td width="25%" align="left"><input type="checkbox"/>MASTERCARD</td>
  <td width="25%" align="left"><input type="checkbox" />AMERICAN EXPRESS
</td>
  </tr>
  </table>
  <br>
  <br>
  <table width="100%" >
  <tr></tr>
  <tr>
  <td width="14%" >Card Holder Name:</td><td style="border-bottom:1px solid #000;" align="center"><label   id="customername" name="customername"><s:property value="customername"/></label></td> <td width="15%" align="right"> :إسم حامل البطاقه
</td>
  </tr>
  <tr>
  <td >Card Number:</td><td style="border-bottom:1px solid #000;" align="center"><label   id="accountnoprint" name="accountnoprint"><s:property value="accountnoprint"/></label></td> <td width="10%" align="right">: رقم البطاقة

</td>
  </tr>
  </table>
   <table  width="100%">
  <tr>
  <!--<td width="23%" >CVV Number/Security Code :</td><td style="border-bottom:1px solid #000;" align="center" width="18%"><label   id="securitycode" name="securitycode"><s:property value="securitycode"/></label></td> <td width="10%" align="right">:الرقم السرى</td>--><td width="10%">Expiry Date: </td><td style="border-bottom:1px solid #000;" align="center" width="49%"><label   id="expirydate" name="expirydate"><s:property value="expirydate"/></label></td> <td width="10%" align="right">:تاريخ الإنتهاء

 </td>
  </tr>
  </table> 
  
  <br>
  <br>
  <table width="100%">
  <tr>
  <td>I understand that this authorization will remain in effect until the termination of the loan agreement and until the fulfilment of all due obligations and I agree to notify Emirates Motor Company in writing of any changes in my account information. I understand that the payment maybe executed on the next business day. This payment authorization is for the type of bill indicated and for any outstanding dues according to the Loan Agreement provisions. For the avoidance of doubt the payment for traffic offences and salik and any other outstanding amounts will be charged immediately as they arise. I certify that I am the owner of this credit card and that I will not dispute the scheduled payments with my credit card company provided the transactions correspond to the terms indicated in this authorization form and agreement provisions concluded by parties.
  </td>
  <td></td>
  <td>
 <p align="right">  أقر بأن هذا التفويض سوف يظل سارى المفعول حتى تاريخ إنتهاء إتفاقية الإعاره و حتى تمام الوفاء بجميع الإلتزامات و أوافق على إخطار شركة الإمارات ، المستحقه و الواجبه ً للسيارات كتابة فى حال حدوث أى تغيير فى بيانات حسابي. أقر بأن الدفع ربما يتم فى يوم العمل التالى.هذا التفويض يكون سارى لنوع الفواتير الموضحه و لكل مستحقات واجبه ً طبقا لشروط و أحكام إتفاقية الإعاره.لتجنب الشك فإن مدفوعات غرامات المخالفات المروريه و سالك و أى مبالغ أخرى مستحقه سوف يتم خصمها فور إستحقاقها.أقر بأنني مالك بطاقة الائتمان هذه وأني لن أعترض على المدفوعات المجدولة لدى شركة بطاقة الائتمان الخاصة بي بشرط أن تتوافق المعاملات مع الشروط والأحكام المبينة في نموذج التفويض هذا ومع أحكام اعقد الإعاره المبرم بين الطرفين.
 </p>
  </td>
  </tr>
  </table> 
  <br>
  <br>
  <table width="100%">
  <tr>
  <td>Signature:------------------------------------------------------------------------:التوقيع</td>
  <td> Date:------------------------------------------------------------------------------- :التاريخ</td>
  </tr>
  </table>
</div>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="docnoval" id="docnoval" value='<s:property value="docnoval"/>'  />
</form>
</div>
</div>
</body>
</html>
