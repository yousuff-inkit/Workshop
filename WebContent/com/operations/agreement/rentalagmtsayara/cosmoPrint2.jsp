<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
 <%@ page pageEncoding="utf-8" %>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<% String contextPath=request.getContextPath();%>
<title>GatewayERP(i)</title>
 <link rel="stylesheet" type="text/css" href="../../../../css/body.css"> 
<%--   <jsp:include page="../../../../includes.jsp"></jsp:include>   --%>
<style>
table{
border-collapse:collapse;
/* border:1px solid #000; */
border-radius:20px;
}
td{
cell-padding:0;
cell-spacing:0;
}
body{
background-color:#fff !important;
font-size:10 !important;



}
.location-table{


}
.location-table td{

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
</head>
<body>
<div style="width:100%;height:130px;"></div>

<table width="100%" class="location-table">
  <tr>
    <td width="9%" class="borderbottom borderright bordertop borderleft">اﻟﻤﻮﻗﻊ<br>
    Location</td>
    <td colspan="3" class="borderbottom borderright bordertop"><label id="location" name="location"><s:property value="location"/></label></td>
    <td width="29%" class="borderbottom borderright bordertop">رﻗﻢ اﺗﻔﺎﻗﻴﺔ إﻳﺠﺎر اﻟﻤﺮﻛﺒﺔ<br>Vehicle Hire Agreement No</td>
    <td width="21%" class="borderbottom borderright bordertop"><label id="rentaldoc" name="rentaldoc" ><s:property value="rentaldoc"/></label></td>
  </tr>
  <tr>
    <td class="borderleft borderright borderbottom ">HA/Date</td>
    <td width="11%" class="borderbottom"><label id="radateout" name="radateout"><s:property value="radateout"/></label></td>
    <td width="20%" class="borderleft borderright borderbottom">رﻗﻢ ﺗﻠﻔﻮن اﻟﺤﺎﺳﺐ	اﺗﻔﺎﻗﻴﺔ اNﻳﺠﺎر<br>Counter Telephone No</td>
    <td width="10%" class="borderbottom">&nbsp;</td>
    <td class="borderleft borderright borderbottom">ﺗﺎرﻳﺦ اﻻﺳﺘﺤﻘﺎق<br>Due Date</td>
    <td class="borderbottom borderright"><label id="duedate" name="duedate"><s:property value="duedate"/></label></td>
  </tr>
</table>
<table width="100%" border="0">
  <tr>
    <td width="50%"><table width="100%" border="0">
  <tr>
    <td colspan="3" class="borderbottom borderleft "><b>Hirer Information</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ﻳــﺠﺎرNا ﻣﻌﻠﻮﻣﺎت</td>
   <!--  <td width="25%">&nbsp;</td> -->
    <td width="25%" class="borderright">&nbsp;</td>
  </tr>
  <tr>
    <td width="25%" class="borderbottom borderright borderleft">اNﺳﻢ<br>Name</td>
    <td colspan="3" class="borderbottom borderright"><label id="clname" name="clname"><s:property value="clname"/></label></td>
    </tr>
  <tr>
        <td width="20%" class="borderbottom borderright borderleft">اNﺳﻢ<br>Driver Name</td>
        <td width="40%" class="borderbottom borderright"><label name="radrname" id="radrname"><s:property value="radrname"/></label></td>
      
    <td width="20%" class="borderbottom borderright borderleft">رﻗﻢ رﺧﺼﺔ اﻟﻘﻴﺎدة<br>Driving Lic No</td>
    <td width="20%" class="borderbottom borderright"><label id="radlno" name="radlno"><s:property value="radlno"/></label></td>
    <!-- <td class="borderbottom borderright">ﻧﻮع اﻟﺰﺑﻮن<br>Customer Type</td>
    <td class="borderbottom borderright">&nbsp;</td> -->
  </tr>
  <tr>
    <td class="borderbottom borderright borderleft">ﺻﺎﻟﺤﺔ ﻟﺘﺎرﻳﺦ<br>Valid Up To</td>
    <td class="borderbottom borderright"><label id="lblaccount" name="licexpdate" ><s:property value="licexpdate"/></label></td>
    <td class="borderbottom borderright">ﺗﺎرﻳﺦ اNﺻﺪار<br>Issued At</td>
    <td class="borderbottom borderright"><label id="lblcosmoissuedat" name="lblcosmoissuedat" ><s:property value="lblcosmoissuedat"/></label></td>
  </tr>
  <tr>
    <td class="borderbottom borderright borderleft">رﻗﻢ ﺟﻮاز اﻟﺴﻔﺮ<br>Passport No</td>
    <td class="borderbottom borderright"><label name="passno" id="passno" ><s:property value="passno"/></label></td>
    <td class="borderbottom borderright">اﻟﺠﻨﺴﻴﺔ<br>Nationality</td>
    <td class="borderbottom  borderright"><label name="lblnation" id="lblnation" ><s:property value="lblnation"/></label></td>
  </tr>
  <tr>
    <td class="borderbottom borderright borderleft">اﻟﺒﺮﻳﺪ اNﻟﻜﺘﺮوﻧﻲ<br>Email</td>
    <td class="borderbottom borderright"><label id="clemail" name="clemail"><s:property value="clemail"/></label></td>
    <td class="borderbottom borderright">رﻗﻢ اﻟﻤﻮﺑﺎﻳﻞ<br>Tel/Mobile</td>
    <td class="borderright borderbottom"><label id="clmobno" name="clmobno"><s:property value="clmobno"/></label></td>
  </tr>
</table>
</td>
    <td width="50%"><table width="100%" border="0">
      <tr>
        <td colspan="3" class="borderbottom"><b>Vehicle Information</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;اﻟﻤﺮﻛﺒﺔ ﻣﻌﻠﻮﻣﺎت</td>
        <!-- <td width="28%" class="borderbottom">&nbsp;</td> -->
        <td width="22%" class="borderbottom borderright">&nbsp;</td>
      </tr>
      <tr>
        <td width="28%" class="borderbottom borderright">رﻗﻢ اﻟﻤﺠﻤﻮﻋﺔ<br>Fleet No</td>
        <td width="22%" class="borderbottom borderright" colspan="3"><label name="lblcosmofleetno" id="lblcosmofleetno"><s:property value="lblcosmofleetno"/></label><label id="ravehname" name="ravehname"><s:property value="ravehname"/></label></td>
        <!-- <td class="borderbottom">&nbsp;</td>
        <td class="borderbottom borderright">&nbsp;</td> -->
      </tr>
      <tr>
        <td class="borderbottom borderright">ﻧﻮع اﻟﻤﺮﻛﺒﺔ<br>Vehicle Type</td>
        <td class="borderbottom borderright"><label name="lblcosmofleetbrand" id="lblcosmofleetbrand"><s:property value="lblcosmofleetbrand"/></label></td>
        <td class="borderbottom borderright">رﻗﻢ اﻟﺘﺴﺠﻴﻞ<br>Reg No</td>
        <td class="borderbottom borderright"><label id="ravehregno" name="ravehregno"><s:property value="ravehregno"/></label></td>
      </tr>
      <tr>
        <td class="borderbottom borderright">ﻋﻨﺪ اﻟﻤﻐﺎدرة<br>Check Out</td>
        <td class="borderbottom borderright"><label id="lblcosmocheckout" name="lblcosmocheckout"><s:property value="lblcosmocheckout"/></label></td>
        <td class="borderbottom borderright">ﻋﻨﺪ اﻟﺘﺴﻠﻴﻢ<br>Check In</td>
        <td class="borderbottom borderright"><label id="lblcosmocheckin" name="lblcosmocheckin"><s:property value="lblcosmocheckin"/></label></td>
      </tr>
      <tr>
        <td class="borderbottom borderright">ﻗﺮاءة اﻟﻌﺪاد<br>Km Reading (Out)</td>
        <td class="borderbottom borderright"><label id="raklmout" name="raklmout"><s:property value="raklmout"/></label></td>
        <td class="borderbottom borderright">ﻗﺮاءة اﻟﻌﺪاد<br>Km Reading (In)</td>
        <td class="borderbottom borderright"><label id="lblcosmokmin" name="lblcosmokmin"><s:property value="lblcosmokmin"/></label></td>
      </tr>
      <tr>
        <td class="borderbottom borderright">ﻣﺴﺘﻮى اﻟﻮﻗﻮد<br>Fuel level (Out)</td>
        <td class="borderbottom borderright"><label id="rafuelout" name="rafuelout"><s:property value="rafuelout"/></label></td>
        <td class="borderbottom borderright">ﻣﺴﺘﻮى اﻟﻮﻗﻮد<br>Fuel level (In)</td>
        <td class="borderbottom borderright"><label id="lblcosmofuelin" name="lblcosmofuelin"><s:property value="lblcosmofuelin"/></label></td>
      </tr>
    </table></td>
  </tr>
</table>
<table width="100%" border="0">
  <tr>
    <td width="50%"><table width="100%" border="0">
      <tr>
        <td width="25%" height="31" class="borderbottom borderright borderleft bordertop">اﻟﻌﻨﻮان ﻓﻲ اNﻣﺎرات<br>Address in UAE</td>
        <td colspan="3" class="borderbottom borderright bordertop"><label id="claddress" name="claddress"><s:property value="claddress"/></label></td>
      </tr>
      <tr>
        <td class="borderbottom borderright borderleft">اNﺳﻢ<br>Driver Name</td>
        <td colspan="3" class="borderbottom borderright"><label name="lblcosmodrivername" id="lblcosmodrivername"><s:property value="lblcosmodrivername"/></label></td>
      </tr>
      <tr>
        <td class="borderbottom borderright borderleft">رﻗﻢ رﺧﺼﺔ اﻟﻘﻴﺎدة<br>Driving Lic No</td>
        <td width="25%" class="borderbottom borderright"><label name="lblcosmodriverlicense" id="lblcosmodriverlicense"><s:property value="lblcosmodriverlicense"/></label></td>
        <td width="25%" class="borderbottom borderright">ﺻﺎﻟﺤﺔ ﻟﺘﺎرﻳﺦ<br>Valid Upto</td>
        <td width="25%" class="borderbottom borderright"><label name="lblcosmodrivervalidupto" id="lblcosmodrivervalidupto"><s:property value="lblcosmodrivervalidupto"/></label></td>
      </tr>
      <tr>
        <td class="borderbottom borderright borderleft">رﻗﻢ ﺟﻮاز اﻟﺴﻔﺮ<br>Passport No</td>
        <td class="borderbottom borderright"><label name="lblcosmodriverpassport" id="lblcosmodriverpassport"><s:property value="lblcosmodriverpassport"/></label></td>
        <td class="borderbottom borderright">رﻗﻢ اﻟﻤﻮﺑﺎﻳﻞ<br>Tel/Mobile</td>
        <td class="borderbottom borderright"><label name="lblcosmodrivermobile" id="lblcosmodrivermobile"><s:property value="lblcosmodrivermobile"/></label></td>
      </tr>
    <!--  <tr>
        <td height="36" class="borderbottom borderright borderleft">اﻟﻌﻨﻮان اﻟﺪاﺋﻢ<br>Permanent Address</td>
        <td class="borderbottom borderright"><label id="claddress" name="claddress"><s:property value="claddress"/></label></td>
      </tr>-->
    </table>
      <table width="100%" border="0">
        <tr>
          <td colspan="4" class="borderbottom  borderleft borderright"><b>Payment Mode Information</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;اﻟﺪﻓﻊ ﻃﺮﻳﻘﺔ ﻋﻦ ﻣﻌﻠﻮﻣﺎت</td>
          <!-- <td width="25%">&nbsp;</td> -->
          <!-- <td width="25%" class="borderbottom ">&nbsp;</td> -->
        </tr>
        <tr>
          <td width="25%" class="borderbottom borderright borderleft">رﻗﻢ ﺑﻄﺎﻗﺔ اNﺋﺘﻤﺎن<br>Credit Card No</td>
          <td width="25%" class="borderbottom borderright"><label id="lblcosmocreditcardno" name="lblcosmocreditcardno"><s:property value="lblcosmocreditcardno"/></label></td>
          <td width="26%" class="borderbottom borderright">رﻗﻢ اﻟﻤﻮﺑﺎﻳﻞ<br>Valid Till</td>
          <td width="24%" class="borderbottom borderright"><label id="lblcosmocreditvaliddate" name="lblcosmocreditvaliddate"><s:property value="lblcosmocreditvaliddate"/></label></td>
        </tr>
        <tr>
          <td class="borderright borderleft borderbottom">اNﻣﺎن<br>Security</td>
          <td class="borderbottom borderright" colspan="3"><label id="lblcosmosecurity" name="lblcosmosecurity"><s:property value="lblcosmosecurity"/></label></td>
          <!-- <td>&nbsp;</td>
          <td>&nbsp;</td> -->
        </tr>
    </table>
    <span style="font-size:9px;">
      <table width="100%" border="0">
        <tr>
          <td colspan="2" class="borderbottom borderleft"><b>Important Notes for Customer</b></td>
          <td width="42%" class="borderbottom borderright" align="right">ﻟﻠﺰﺑـﻮن  ﻣﻬﻤﺔ ﻣﻼﺣﻈﺎت</td>
        </tr>
      <!--  <tr>
          <td width="48%" class="borderbottom borderright borderleft">1.Hirer is obliged to obtained all extensions to this hire agreement from an authorized Al Sayara. All extensions may be subject to rate increases.</td>
          <td colspan="2" class="borderbottom borderright">ﻫﺬا ﻣﻠﺤﻘﺎت ﺟﻤﻴﻊ ﻋﻠﻰ ﺑﺎﻟﺤﺼﻮل اﻟﻤﺴﺘﺄﺟﺮ ﻳﻠﺘﺰم .١ ان ﺳﻌﺎرZﻟ ﻳﻤﻜﻦ ﺣﻴﺚ ,اﻟﺴﻴﺎرة ﺷﺮﻛﺔ ﻣﻦ اﻟﻌﻘﺪ .اﻟﻔﺎﺋﺪة ﻟﻤﻌﺪل ﺗﺒﻌﺎ ﺗﺰﻳﺪ</td>
        </tr>
        -->
        <tr>
          <td class="borderbottom borderright borderleft">1.Should be vehicle be returned at any of our Airport locations the following charges will apply.</td>
          <td colspan="2" class="borderbottom borderright">اﻟﻤﻄﺎر ﻓﻲ ﻓﺮوﻋﻨﺎ ﻣﻦ ﻓﺮع ي.اﻟﺘﺎﻟﻴﺔ  اﻟﺮﺳﻮم دﻓﻊ ﻋﻠﻴﻚ ﺳﻴﺴﺘﺤﻖN اﻟﻤﺮﻛﺒﺔ إﻋﺎدة ﻋﻨﺪ .١</td>
        </tr>
        <tr>
          <td class="borderbottom borderright borderleft">2.Sharjah Airport Terminal AED 25.</td>
          <td colspan="2" class="borderbottom borderright">درﻫﻢ 25 اﻟﺸﺎرﻗﺔ ﻣﻄﺎر.2</td>
        </tr>
    </table>
    </span>
    </td>
    <td width="50%"><table width="100%" border="0">
      <tr>
        <td width="34%" colspan="3" class="borderbottom "><b>Rate Information</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;اﻻﺳﻌﺎر ﻣﻌﻠﻮﻣﺎت</td>
        <!-- <td width="37%">&nbsp;</td> -->
       <!--  <td width="29%" class="borderbottom">&nbsp;</td> -->
      </tr>
      <tr>
        <td class="borderbottom borderright">ﻧﻮع اNﻳﺠﺎر<br>Type of Hire<br><label id="rarenttypes" name="rarenttypes"><s:property value="rarenttypes"/></label></td>
        <td class="borderbottom borderright">اﻟﺴﻌﺮ<br>Rate<br><label id="tariff" name="tariff"><s:property value="tariff"/></label></td>
        <td class="borderbottom borderright">اﻟﻔﺎﺋﺾ ﻳﻨﻄﺒﻖ<br>Excess Applicable<br><label id="lblcosmoexcessamt" name="lblcosmoexcessamt"><s:property value="lblcosmoexcessamt"/></label></td>
      </tr>
      <tr>
        <td class="borderbottom borderright"><b>Non Rental Type</b></td>
        <td class="borderbottom borderright">ﻣﺆﺟﺮ اﻟﻐﻴﺮ اﻟﺸﻴﺊ ﻧﻮع</td>
        <td class="borderbottom borderright" align="right"><b>Amount</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;اﻟﻜﻤﻴﺔ</td>
      </tr>
      <tr>
        <td class="borderbottom borderright">SCDW</td>
        <td class="borderbottom borderright" align="right">SCDW</td>
        <td class="borderbottom borderright" align="right"><label id="rasupercdw" name="rasupercdw"><s:property value="rasupercdw"/></label></td>
      </tr>
      <tr>
        <td class="borderbottom borderright">CDW</td>
        <td class="borderbottom borderright" align="right">CDW</td>
        <td class="borderbottom borderright" align="right"><label id="racdwscdw" name="racdwscdw"><s:property value="racdwscdw"/></label></td>
      </tr>
      <tr>
        <td class="borderbottom borderright">PAI</td>
        <td class="borderbottom borderright" align="right">PAI</td>
        <td class="borderbottom borderright" align="right"><label id="lblpai" name="lblpai"><s:property value="lblpai"/></label></td>
      </tr>
      <tr>
        <td class="borderbottom borderright">VRF-Vehicle Reg Fess</td>
        <td class="borderbottom borderright" align="right">VRF- اﻟﻤﺮﻛﺒﺎت ﺗﺴﺠﻴﻞ رﺳﻮم </td>
        <td class="borderbottom borderright" align="right">&nbsp;</td>
      </tr>
      <tr>
        <td class="borderbottom borderright">Baby Seat</td>
        <td class="borderbottom borderright" align="right">أﻃﻔﺎل ﻣﻘﻌﺪ</td>
        <td class="borderbottom borderright" align="right"><label id="lblcosmobabyseater" name="lblcosmobabyseater"><s:property value="lblcosmobabyseater"/></label></td>
      </tr>
      <tr>
        <td class="borderbottom borderright">GPS/Navigation</td>
        <td class="borderbottom borderright" align="right">ﻣﻼﺣﺔ ﻧﻄﺎم /GPS</td>
        <td class="borderbottom borderright" align="right"><label id="lblcosmogps" name="lblcosmogps"><s:property value="lblcosmogps"/></label></td>
      </tr>
      <tr>
        <td class="borderbottom borderright">Delivery Charges</td>
        <td class="borderbottom borderright" align="right">اﻟﺘﻮﺻﻴﻞ  رﺳﻮم</td>
        <td class="borderbottom borderright" align="right"><label id="laldelcharge" name="laldelcharge"><s:property value="laldelcharge"/></label></td>
      </tr>
      <tr>
        <td class="borderbottom borderright">Collection Charges</td>
        <td class="borderbottom borderright" align="right">اﻻﺳﺘﻼم   رﺳﻮم</td>
        <td class="borderbottom borderright" align="right"><label id="lblcosmocollectchg" name="lblcosmocollectchg"><s:property value="lblcosmocollectchg"/></label></td>
      </tr>
      <tr>
        <td class="borderbottom borderright">Repairs &amp; damages</td>
        <td class="borderbottom borderright" align="right">اﻟﺘﺼﻠﻴﺤﺎت  و  ﻋﻄﺎلNا</td>
        <td class="borderbottom borderright" align="right"><label id="lblcosmodamagechg" name="lblcosmodamagechg"><s:property value="lblcosmodamagechg"/></label></td>
      </tr>
      <tr>
        <td class="borderbottom borderright">Fuel Charges</td>
        <td class="borderbottom borderright" align="right">اﻟﻮﻗﻮد  رﺳﻮم</td>
        <td class="borderbottom borderright" align="right"><label id="lblcosmofuelchg" name="lblcosmofuelchg"><s:property value="lblcosmofuelchg"/></label></td>
      </tr>
      <tr>
        <td class="borderbottom borderright">Others</td>
        <td class="borderbottom borderright" align="right">أﺧﺮى</td>
        <td class="borderbottom borderright" align="right">&nbsp;</td>
      </tr>
      <tr>
        <td class="borderbottom borderright">Total Charges</td>
        <td class="borderbottom borderright" align="right">اﻟﻜﻠﻴﺔ اﻟﺘﻜﻠﻔﺔ</td>
        <td class="borderbottom borderright" align="right"><label id="lblcosmototal" name="lblcosmototal"><s:property value="lblcosmototal"/></label></td>
      </tr>
    </table></td>
  </tr>
</table>
<table width="100%" border="0">
  <tr>
    <td width="50%"><table width="100%" border="0">
      <%-- <tr>
        <td width="32%" class="borderbottom borderright borderleft bordertop">ﺗﻔﺎﺻﻴﻞ اNﻣﻴﺎل اﻟﺰاﺋﺪة<br>Excess Mileage Details</td>
        <td width="21%" class="borderbottom borderright bordertop">ﻳﻮﻣﻴﺎ<br>Daily</td>
        <td width="22%" class="borderbottom borderright bordertop">أﺳﺒﻮﻋﻴﺎ<br>Weekly</td>
        <td width="25%" class="borderbottom borderright bordertop">ﺷﻬﺮﻳﺎ<br>Monthly</td>
      </tr>
      <tr>
        <td class="borderbottom borderright borderleft">ﻋﺪد اﻟﻜﻴﻠﻮﻣﺘﺮات ﻟﻜﻞ وﺣﺪة<br>Mileage Per Unit</td>
        <td class="borderbottom borderright"><label id="lblcosmokmrestrictdaily" name="lblcosmokmrestrictdaily"><s:property value="lblcosmokmrestrictdaily"/></label></td>
        <td class="borderbottom borderright"><label id="lblcosmokmrestrictweekly" name="lblcosmokmrestrictweekly"><s:property value="lblcosmokmrestrictweekly"/></label></td>
        <td class="borderbottom borderright"><label id="lblcosmokmrestrictmonthly" name="lblcosmokmrestrictmonthly"><s:property value="lblcosmokmrestrictmonthly"/></label></td>
      </tr>
      <tr>
        <td class="borderbottom borderright borderleft">ﺗﻜﻠﻔﺔ اﻟﻜﻴﻠﻮﻣﺘﺮات اﻟﺰاﺋﺪة<br>Charge per extra km</td>
        <td class="borderbottom borderright"><label id="lblcosmoexkmratedaily" name="lblcosmoexkmratedaily"><s:property value="lblcosmoexkmratedaily"/></label></td>
        <td class="borderbottom borderright"><label id="lblcosmoexkmrateweekly" name="lblcosmoexkmrateweekly"><s:property value="lblcosmoexkmrateweekly"/></label></td>
        <td class="borderbottom borderright"><label id="lblcosmoexkmratemonthly" name="lblcosmoexkmratemonthly"><s:property value="lblcosmoexkmratemonthly"/></label></td>
      </tr> --%>
      <tr>
	        <td width="32%" class="borderbottom borderright borderleft bordertop" >ﺗﻔﺎﺻﻴﻞ اNﻣﻴﺎل اﻟﺰاﺋﺪة<br>Excess Mileage Details</td>
	        <!-- <td width="68%" class="borderbottom borderright bordertop" colspan="3">ﻳﻮﻣﻴﺎ<br>Daily</td> id="rarenttypes" name="rarenttypes"-->
	        <td width="68%" class="borderbottom borderright bordertop" colspan="3"><label ><s:property value="rarenttypes"/></label></td>
	        
	        <!-- <td width="22%" class="borderbottom borderright bordertop">أﺳﺒﻮﻋﻴﺎ<br>Weekly</td>
	        <td width="25%" class="borderbottom borderright bordertop">ﺷﻬﺮﻳﺎ<br>Monthly</td> -->
	      </tr>
	      <tr>
	        <td class="borderbottom borderright borderleft">ﻋﺪد اﻟﻜﻴﻠﻮﻣﺘﺮات ﻟﻜﻞ وﺣﺪة<br>Mileage Per Unit</td>
	        <td class="borderbottom borderright" colspan="3"><label id="lblcosmokmrestrict" name="lblcosmokmrestrict"><s:property value="Raextrakm"/></label></td>
	        <%-- <label id="lblcosmokmrestrictdaily" name="lblcosmokmrestrictdaily"><s:property value="lblcosmokmrestrictdaily"/></label></td>
	        <td class="borderbottom borderright"><label id="lblcosmokmrestrictweekly" name="lblcosmokmrestrictweekly"><s:property value="lblcosmokmrestrictweekly"/></label></td>
	        <td class="borderbottom borderright"><label id="lblcosmokmrestrictmonthly" name="lblcosmokmrestrictmonthly"><s:property value="lblcosmokmrestrictmonthly"/></label></td> --%>
	      </tr>
	      <tr>
	        <td class="borderbottom borderright borderleft">ﺗﻜﻠﻔﺔ اﻟﻜﻴﻠﻮﻣﺘﺮات اﻟﺰاﺋﺪة<br>Charge per extra km</td>
	        <td class="borderbottom borderright" colspan="3"><label id="lblcosmoexkmrate" name="lblcosmoexkmrate"><s:property value="Raexxtakmchg"/></label></td>
	        <%-- <label id="lblcosmoexkmratedaily" name="lblcosmoexkmratedaily"><s:property value="lblcosmoexkmratedaily"/></label></td>
	        <td class="borderbottom borderright"><label id="lblcosmoexkmrateweekly" name="lblcosmoexkmrateweekly"><s:property value="lblcosmoexkmrateweekly"/></label></td>
	        <td class="borderbottom borderright"><label id="lblcosmoexkmratemonthly" name="lblcosmoexkmratemonthly"><s:property value="lblcosmoexkmratemonthly"/></label></td> --%>
	      </tr>
    </table></td>
    <td width="50%"><table width="100%" border="0">
      <tr>
        <td width="66%" class="borderright bordertop borderbottom">اﻟﺪﻓﻌﺔ اﻟﻤﺴﺘﻠﻤﺔ اﻟﻮدﻳﻌﺔ<br>Payment Recieved Deposit-Advance</td>
        <td width="34%" class="borderright bordertop borderbottom"><label id="lblcosmoadvance" name="lblcosmoadvance"><s:property value="lblcosmoadvance"/></label></td>
      </tr>
    </table>
      <table width="100%" border="0">
        <tr>
          <td width="50%" class="borderright">Toll Service Charges in :25%</td>
          <td width="50%" align="right" class="borderright">% ٥٢ : ﺟﻤﺎﻟﻴﺔNا اﻟﺨﺪﻣﺔ رﺳﻮم</td>
        </tr>
        <tr>
          <td class="borderright">Fine Service Charges in :10%</td>
          <td align="right" class="borderright">% ٠١ اﻟﺠﻴﺪة اﻟﺨﺪﻣﺔ رﺳﻮم</td>
        </tr>
        <tr>
          <td class="borderright borderbottom">Fuel Service Charges in :10%</td>
          <td align="right" class="borderbottom borderright">% ٠١ اﻟﻮﻗﻮد ﺧﺪﻣﺔ رﺳﻮم</td>
        </tr>
    </table></td>
  </tr>
</table>
<!-- <DIV style="page-break-after:always"></DIV> -->
<span style="font-size:8px;">
<table width="100%" border="0">
  <tr>
    <td width="50%"><table width="100%" border="0">
      <tr>
        <td class="  borderleft borderright">
        <ul>
        <li> ﺗﻮﻗﻴﻌﻲ أدﻧﺎه ﻳﻘﺮ ﺑﺎﻋﺘﺮاﻓﻲ ﺑﺪﻓﻊ اﻟﻤﺒﻠﻎ اﻟﻤﻌﻴﻦ وﻓﻘﺎ ﻻﺗﻔﺎﻗﻴﺔ اﻻﻳﺠﺎر ﻫﺬه.</li>
        <li> وﻓﻘﺎ ﻟﺠﻤﻴﻊ اﺗﻔﺎﻗﻴﺎت اNﻳﺠﺎر, ﺳﻴﺘﻢ دﻓﻊ رﺳﻮم زاﺋﺪة ﻓﻲ ﺣﺎﻟﺔ زﻳﺎدة ﻋﺪد اﻟﻜﻴﻠﻮﻣﺘﺮات.</li>
        <li> ﻳﺠﺐ ﻗﻴﺎدة ﺳﻴﺎرات اﻟﺪﻓﻊ اﻟﺮﺑﺎﻋﻲ ﻓﻘﻂ ﻋﻠﻰ اﻟﻄﺮﻳﻖ اﻟﻤﻌﺒﺪة و ﻻ ﻳﺴﻤﺢ ﺑﺎﻟﻘﻴﺎدة ﻋﻠﻰ اﻟﺮﻣﺎل، و ﺳﻴﺘﻢ إﻟﺰام اﻟﺰﺑﻮن ﺑﺪﻓﻊ ﺟﻤﻴﻊ اﻟﺮﺳﻮم و
اﻟﻐﺮاﻣﺎت ﻓﻲ ﺣﺎل إﻟﺤﺎق اﻟﻀﺮر ﺑﺎﻟﻤﺮﻛﺒﺔ ﻓﻲ ﺣﺎﻟﺔ ﻋﺪم اNﻟﺘﺰام.</li>
<li> ﻓﻲ ﺣﺎﻟﺔ ﺗﻮﻗﻴﻒ اﻟﻤﺮﻛﺒﺔ ﻣﻦ أي ﺟﻬﺔ ﺣﻜﻮﻣﻴﺔ، أواﻓﻖ ﻋﻠﻰ اﺳﺘﻜﻤﺎل رﺳﻮم اNﻳﺠﺎر ﻟﻐﺎﻳﺔ اﻧﺘﻬﺎء اﻟﻤﺪة و ﺗﺴﻠﻴﻤﻬﺎ ﻟﺸﺮﻛﺔ اﻟﺴﻴﺎرة.</li>
<li> ﺗﻘﺮﻳﺮ اﻟﺸﺮﻃﺔ ﻟﺸﺮﻛﺔ اﻟﺘﺄﻣﻴﻦ ﺿﺮوري ﺟﺪا ﻓﻲ ﺣﺎﻟﺔ اﻟﺤﻮادث.</li>
<li>  اﻋﺘﺮف ﺑﺄﻧﻲ ﻗﺪ ﻗﺮأت و ﻓﻬﻤﺖ و أﻟﺘﺰم ﺑﺠﻤﻴﻊ اﻟﺸﺮوط و اNﺣﻜﺎم اﻟﻤﻜﺘﻮﺑﺔ ﻓﻲ ﻫﺬا اNﺗﻔﺎق.</li>
<li> ﻻﻳﺴﻤﺢ ﺑﻘﻴﺎدة اﻟﻤﺮﻛﺒﺔ ﺧﺎرج ﺣﺪود دوﻟﺔ اﻻﻣﺎرات</li>
        </ul>
 </td>
      </tr>
      <tr>
        <td class="bordertop borderbottom borderleft borderright"><ul>
          <li>My signature below shall constitute my authority to debit my authority to debit my nominated credit(s) with the amount due under this rental agreement.</li>
          <li>For all rental agreements the agreed excess km rate (per km) will be applied.</li>
          <li>4*4 vehicles are paved for road driving only.Desert driving is not permitted.Customers will be charged in full for any damage caused by Off-Roading.</li>
          <li>If the vehicle is impounded by Govt.authorites for any violation of law.I accept to pay the rental charges till it is returned to Al Sayara.</li>
          <li>Police reports are mandatory in all cases to claim the insurance.</li>
          <li>I/We acknowledge that i/we read the and understood the terms and condition printed above the overleaf and here by acknowledge myself/ouerselves to bound thereby.</li>
          <li>Vehicle is not allowed to drive out of UAE.</li>
        </ul></td>
      </tr>
    </table></td>
    <td width="50%"><table width="100%" height="100" border="0" >
      <tr>
        <td style="padding-left:20px;" class="borderbottom">ﺗﻮﻗﻴﻊ اﻟﻤﻮﻇﻒ<br>Staff's Signature<br><br></td>
      </tr>
      <tr>
        <td style="padding-left:20px;" class="borderbottom">اﺳﻢ اﻟﻤﺴﺘﺄﺟﺮ اﻟﻜﺎﻣﻞ<br>Hirer's Name<br><br></td>
      </tr>
      <tr>
        <td style="padding-left:20px;" class="borderbottom">ﺗﻮﻗﻴﻊ اﻟﻤﺴﺘﺄﺟﺮ<br>Hirer's Signature<br><br></td>
      </tr>
    </table></td>
  </tr>
</table>
</span>
</body>
</html>