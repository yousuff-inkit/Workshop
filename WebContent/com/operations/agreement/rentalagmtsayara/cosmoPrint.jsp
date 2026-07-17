 <%@ page pageEncoding="utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style>
table {
    border-collapse: collapse;
}
td{
 border: 1px solid black;
 border-radius:20px;
 cell-spacing:0;
 cell-padding:0;
}
</style>
</head>
<body>
<div style="width:100%;height:130px;border:1px solid #000;"></div>
<table width="100%">
  <tr>
    <td width="10%">ﻟﻤﻮﻗﻊ<br>
    Location</td>
    <td width="18%">&nbsp;</td>
    <td width="15%">&nbsp;</td>
    <td width="16%">&nbsp;</td>
    <td width="18%">رﻗﻢ اﺗﻔﺎﻗﻴﺔ إﻳﺠﺎر اﻟﻤﺮﻛﺒﺔ <br>Vehicle Hire Agreement No</td>
    <td width="23%">&nbsp;</td>
  </tr>
  <tr>
    <td>HA / Date</td>
    <td>&nbsp;</td>
    <td>رﻗﻢ ﺗﻠﻔﻮن اﻟﺤﺎﺳﺐ<br>Counter Telephone No</td>
    <td>&nbsp;</td>
    <td>ﺗﺎرﻳﺦ اﻻﺳﺘﺤﻘﺎق <br>Due Date</td>
    <td>&nbsp;</td>
  </tr>
</table>
<!-- <table width="100%">
  <tr>
    <td colspan="2">Hirer Information</td>
    <td colspan="4"><span dir="RTL">&#65267;&#1600;&#1600;&#65184;&#65166;&#1585;</span>N<span dir="RTL">&#1575;</span><span dir="LTR"> </span><span dir="LTR"> </span> <span dir="RTL">&#65251;&#65228;&#65248;&#65262;&#65251;&#65166;&#1578;</span></td>
    <td colspan="3">Vehicle Information</td>
    <td colspan="3"><span dir="RTL"><span dir="RTL">&#1575;&#65247;&#65252;&#65198;&#65243;&#65170;&#65172;</span><span dir="LTR"> </span><span dir="LTR"> </span> &#65251;&#65228;&#65248;&#65262;&#65251;&#65166;&#1578;</span></td>
  </tr>
  <tr>
    <td width="12%"><p align="right" dir="RTL"><span dir="LTR">&#1575;N&#65203;&#65250;</span><br>Name</p></td>
    <td colspan="5">&nbsp;</td>
    <td width="20%"><p align="right" dir="RTL"><span dir="LTR">&#1585;&#65239;&#65250; &#1575;&#65247;&#65252;&#65184;&#65252;&#65262;&#65227;&#65172;</span><br>Fleet No</p></td>
    <td colspan="2" width="10%">&nbsp;</td>
    <td colspan="2" width="10%">&nbsp;</td>
    <td >&nbsp;</td>
  </tr>
  <tr>
    <td><p align="right" dir="RTL"><span dir="LTR">&#1585;&#65239;&#65250;</span><span dir="LTR"> </span><span dir="LTR">&#1585;&#65191;&#65212;&#65172;</span><span dir="LTR"> </span><span dir="LTR">&#1575;&#65247;&#65240;&#65268;&#65166;&#1583;&#1577;</span><br>
    Driving License No.
    </p></td>
    <td colspan="2">&nbsp;</td>
    <td colspan="2" width="8%"><p align="right" dir="RTL"><span dir="LTR">&#65255;&#65262;&#1593;  &#1575;&#65247;&#65200;&#65169;&#65262;&#1606;</span><br>
      Customer Type
    </p></td>
    <td width="14%">&nbsp;</td>
    <td><p align="right" dir="RTL"><span dir="LTR">&#65255;&#65262;&#1593;  &#1575;&#65247;&#65252;&#65198;&#65243;&#65170;&#65172;</span><br>
    Vehicle Type
    </p></td>
    <td colspan="2">&nbsp;</td>
    <td colspan="2"><p align="right" dir="RTL"><span dir="LTR">&#1585;&#65239;&#65250;  &#1575;&#65247;&#65176;&#65204;&#65184;&#65268;&#65246;</span><br>Reg No.</p></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><p align="right" dir="RTL"><span dir="LTR">&#65211;&#65166;&#65247;&#65188;&#65172;  &#65247;&#65176;&#65166;&#1585;&#65267;&#65190;</span><br>
    Valid Upto</p></td>
    <td colspan="2">&nbsp;</td>
    <td colspan="2"><p align="right" dir="RTL"><span dir="LTR">&#65175;&#65166;&#1585;&#65267;&#65190; &#1575;N&#65211;&#65194;&#1575;&#1585;</span><br>
      Issued At
    </p></td>
    <td>&nbsp;</td>
    <td><p align="right" dir="RTL"><span dir="LTR">&#65227;&#65256;&#65194;  &#1575;&#65247;&#65252;&#65232;&#65166;&#1583;&#1585;&#1577;</span><br>
    Check Out
    </p></td>
    <td colspan="2">&nbsp;</td>
    <td colspan="2"><p align="right" dir="RTL"><span dir="LTR">&#65227;&#65256;&#65194;  &#1575;&#65247;&#65176;&#65204;&#65248;&#65268;&#65250;</span><br>
    Check In
    </p></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><p align="right" dir="RTL"><span dir="LTR">&#1585;&#65239;&#65250;</span><span dir="LTR"> </span><span dir="LTR">&#65183;&#65262;&#1575;&#1586;</span><span dir="LTR"> </span><span dir="LTR">&#1575;&#65247;&#65204;&#65236;&#65198;</span><br>Passport No </p></td>
    <td colspan="2">&nbsp;</td>
    <td colspan="2"><p align="right" dir="RTL"><span dir="LTR">&#1575;&#65247;&#65184;&#65256;&#65204;&#65268;&#65172;</span><br>Nationality</p></td>
    <td>&nbsp;</td>
    <td><p align="right" dir="RTL"><span dir="LTR">&#65239;&#65198;&#1575;&#1569;&#1577;  &#1575;&#65247;&#65228;&#65194;&#1575;&#1583;</span><br>
    KM Reading (Out)
    </p></td>
    <td colspan="2">&nbsp;</td>
    <td colspan="2"><p align="right" dir="RTL"><span dir="LTR">&#65239;&#65198;&#1575;&#1569;&#1577;  &#1575;&#65247;&#65228;&#65194;&#1575;&#1583;</span><br>
      KM Reading (In)
    </p></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><p align="right" dir="RTL"><span dir="LTR">&#1575;&#65247;&#65170;&#65198;&#65267;&#65194; &#1575;N&#65247;&#65244;&#65176;&#65198;&#1608;&#65255;&#65266;</span><br>
    Email
    </p></td>
    <td colspan="2">&nbsp;</td>
    <td colspan="2"><p align="right" dir="RTL"><span dir="LTR">&#1585;&#65239;&#65250; &#1575;&#65247;&#65252;&#65262;&#65169;&#65166;&#65267;&#65246;</span><br>
      Tel/Mobile
    </p></td>
    <td>&nbsp;</td>
    <td><p align="right" dir="RTL"><span dir="LTR">&#65251;&#65204;&#65176;&#65262;&#1609;  &#1575;&#65247;&#65262;&#65239;&#65262;&#1583;</span><br>
    Fuel Level (Out)
    </p></td>
    <td colspan="2">&nbsp;</td>
    <td colspan="2"><p align="right" dir="RTL"><span dir="LTR">&#65251;&#65204;&#65176;&#65262;&#1609;  &#1575;&#65247;&#65262;&#65239;&#65262;&#1583;</span><br>
      Fuel Level (In)
    </p></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td height="68"><p align="right" dir="RTL"><span dir="LTR">&#1575;&#65247;&#65228;&#65256;&#65262;&#1575;&#1606; &#65235;&#65266;</span><span dir="LTR"> </span><span dir="LTR">&#1575;N&#65251;&#65166;&#1585;&#1575;&#1578;</span><br>
    Address in UAE
    </p></td>
    <td colspan="5">&nbsp;</td>
    <td colspan="6">Rate Information&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span dir="RTL">&#1575;&#65275;&#65203;&#65228;&#65166;&#1585;</span><span dir="LTR"> </span><span dir="LTR"> </span> <span dir="RTL">&#65251;&#65228;&#65248;&#65262;&#65251;&#65166;&#1578;</span></td>
  </tr>
  <tr>
    <td height="72"><p align="right" dir="RTL"><span dir="LTR">&#1575;&#65247;&#65228;&#65256;&#65262;&#1575;&#1606; &#1575;&#65247;&#65194;&#1575;&#65163;&#65250;</span><br>
    Permanent Address
    </p></td>
    <td colspan="5">&nbsp;</td>
    <td colspan="6" rowspan="9"><table width="100%" border="0">
      <tr>
        <td align="left"><p align="center" dir="RTL"><span dir="LTR">&#65255;&#65262;&#1593;  &#1575;N&#65267;&#65184;&#65166;&#1585;</span><br>
        Type of Hire
        </p></td>
        <td align="right"><p align="center" dir="RTL"><span dir="LTR">&#1575;&#65247;&#65204;&#65228;&#65198;</span><br>
        Rate
        </p></td>
        <td><p align="center" dir="RTL"><span dir="LTR">&#1575;&#65247;&#65236;&#65166;&#65163;&#65214; &#65267;&#65256;&#65220;&#65170;&#65238;</span><br>
        Excess Applicable
        </p></td>
      </tr>
      <tr>
        <td colspan="2" align="center">Non Rental Type<div style="right:0;"><span dir="RTL">&#65251;&#65158;&#65183;&#65198;</span><span dir="LTR"> </span><span dir="LTR"> </span>&nbsp;<span dir="RTL">&#1575;&#65247;&#65232;&#65268;&#65198;</span><span dir="LTR"> </span><span dir="LTR"> </span>&nbsp;<span dir="RTL">&#1575;&#65247;&#65208;&#65268;&#65162;</span><span dir="LTR"> </span><span dir="LTR"> </span>&nbsp;<span dir="RTL">&#65255;&#65262;&#1593;</span></div></td>
        <td><p><span dir="RTL">&#1575;&#65247;&#65244;&#65252;&#65268;&#65172;</span><br>
        Amount</p></td>
      </tr>
     
      <tr>
        <td width="38%" align="left">SCDW</td>
        <td width="36%" align="right">SCDW</td>
        <td width="26%">&nbsp;</td>
      </tr>
      <tr>
        <td>CDW</td>
        <td align="right">CDW</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>PAI</td>
        <td align="right">PAI</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>VRF-Vehicle Reg Fee</td>
        <td align="right"><span dir="RTL">&#1575;&#65247;&#65252;&#65198;&#65243;&#65170;&#65166;&#1578;</span><span dir="LTR"> </span><span dir="LTR"> </span><span dir="LTR"> </span><span dir="LTR"> </span> <span dir="RTL">&#65175;&#65204;&#65184;&#65268;&#65246;</span><span dir="LTR"> </span><span dir="LTR"> </span><span dir="LTR"> </span><span dir="LTR"> </span> <span dir="RTL">&#1585;&#65203;&#65262;&#1605;</span>-VRF</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>Baby Seat</td>
        <td align="right"><span dir="RTL">&#1571;&#65219;&#65236;&#65166;&#1604;</span><span dir="LTR"> </span><span dir="LTR"> </span> <span dir="RTL">&#65251;&#65240;&#65228;&#65194;</span></td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>GPS/Navigation</td>
        <td align="right"><span dir="RTL">&#65251;&#65276;&#65187;&#65172;</span><span dir="LTR"> </span><span dir="LTR"> </span> <span dir="RTL">&#65255;&#65220;&#65166;&#1605;</span><span dir="LTR"> </span><span dir="LTR"> </span> / GPS</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>Delivery Charges</td>
        <td align="right"><span dir="RTL">&#1575;&#65247;&#65176;&#65262;&#65211;&#65268;&#65246;</span><span dir="LTR"> </span><span dir="LTR"> </span> &nbsp;<span dir="RTL">&#1585;&#65203;&#65262;&#1605;</span></td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>Collection Charges</td>
        <td align="right"><span dir="RTL">&#1575;&#65275;&#65203;&#65176;&#65276;&#1605;</span><span dir="LTR"> </span><span dir="LTR"> </span>&nbsp; &nbsp;<span dir="RTL">&#1585;&#65203;&#65262;&#1605;</span></td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>Repairs &amp; Damages</td>
        <td align="right"><span dir="RTL">&#1575;&#65247;&#65176;&#65212;&#65248;&#65268;&#65188;&#65166;&#1578;</span><span dir="LTR"> </span><span dir="LTR"> </span>&nbsp; <span dir="RTL">&#1608;</span><span dir="LTR"> </span><span dir="LTR"> </span> &nbsp;<span dir="RTL">&#65227;&#65220;&#65166;&#1604;</span>N<span dir="RTL">&#1575;</span></td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>Fuel Charges</td>
        <td align="right"><span dir="RTL">&#1575;&#65247;&#65262;&#65239;&#65262;&#1583;</span><span dir="LTR"> </span><span dir="LTR"> </span> &nbsp;<span dir="RTL">&#1585;&#65203;&#65262;&#1605;</span></td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>Others</td>
        <td align="right"><span dir="RTL">&#1571;&#65191;&#65198;&#1609;</span></td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>Total Charges</td>
        <td align="right"><span dir="RTL">&#1575;&#65247;&#65244;&#65248;&#65268;&#65172;</span><span dir="LTR"> </span><span dir="LTR"> </span> <span dir="RTL">&#1575;&#65247;&#65176;&#65244;&#65248;&#65236;&#65172;</span></td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td align="left">&nbsp;</td>
        <td align="right">&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <!--  <tr>
        <td align="left">&nbsp;</td>
        <td align="right">&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td colspan="6">Payment Mode Information &nbsp;&nbsp;&nbsp;<span dir="RTL">&#1575;&#65247;&#65194;&#65235;&#65226;</span><span dir="LTR"> </span><span dir="LTR"> </span>&nbsp;<span dir="RTL">&#65219;&#65198;&#65267;&#65240;&#65172;</span><span dir="LTR"> </span><span dir="LTR"> </span> <span dir="RTL">&#65227;&#65254;</span><span dir="LTR"> </span><span dir="LTR"> </span><span dir="RTL">&#65251;&#65228;&#65248;&#65262;&#65251;&#65166;&#1578;</span></td>
  </tr>
  <tr>
    <td><p align="right" dir="RTL"><span dir="LTR">&#1585;&#65239;&#65250;  &#65169;&#65220;&#65166;&#65239;&#65172;</span><span dir="LTR"> </span><span dir="LTR">&#1575;N&#65163;&#65176;&#65252;&#65166;&#1606;</span><br>Credit card No
    </p></td>
    <td colspan="3">&nbsp;</td>
    <td width="6%"><p align="right" dir="RTL"><span dir="LTR">&#1585;&#65239;&#65250;  &#1575;&#65247;&#65252;&#65262;&#65169;&#65166;&#65267;&#65246;</span><br>
    Valid Till
    </p></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><p align="right" dir="RTL"><span dir="LTR">&#1575;N&#65251;&#65166;&#1606;</span><br>
    Security
    </p></td>
    <td colspan="5">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">Important Notes for Customer</td>
    <td colspan="4"><span dir="RTL">&#65247;&#65248;&#65200;&#65169;&#1600;&#65262;&#1606;</span><span dir="LTR"> </span><span dir="LTR"> </span>&nbsp; <span dir="RTL">&#65251;&#65260;&#65252;&#65172;</span><span dir="LTR"> </span><span dir="LTR"> </span>&nbsp;<span dir="RTL">&#65251;&#65276;&#65187;&#65224;&#65166;&#1578;</span></td>
  </tr>
  <tr>
    <td colspan="2">1. Hirer is obliged to obtained all extensions to this hire agreement from an authorized Al Sayara, All extensions may be subject to rate increases.</td>
    <td colspan="4" align="right"><p><span dir="RTL">&#1575;<span dir="RTL">&#65259;&#65196;&#1575;</span><span dir="LTR"> </span><span dir="LTR"> </span> <span dir="RTL">&#65251;&#65248;&#65188;&#65240;&#65166;&#1578;</span><span dir="LTR"> </span><span dir="LTR"> </span> <span dir="RTL">&#65183;&#65252;&#65268;&#65226;</span><span dir="LTR"> </span><span dir="LTR"> </span> <span dir="RTL">&#65227;&#65248;&#65264;</span><span dir="LTR"> </span><span dir="LTR"> </span> <span dir="RTL">&#65169;&#65166;&#65247;&#65188;&#65212;&#65262;&#1604;</span><span dir="LTR"> </span><span dir="LTR"> </span> <span dir="RTL">&#1575;&#65247;&#65252;&#65204;&#65176;&#65156;&#65183;&#65198;</span><span dir="LTR"> </span><span dir="LTR"> </span> <span dir="RTL">&#65267;&#65248;&#65176;&#65200;&#1605;</span><span dir="LTR"> </span><span dir="LTR"> </span> .<span dir="RTL"> </span><span dir="RTL"><span dir="RTL"> </span>&#1633;</span></span><br><span dir="RTL">&#1606;</span><span dir="LTR"> </span><span dir="LTR"> </span> <span dir="RTL">&#65203;&#65228;&#65166;&#1585;</span>Z<span dir="RTL">&#65247;</span><span dir="LTR"> </span><span dir="LTR"> </span> <span dir="RTL">&#65267;&#65252;&#65244;&#65254;</span><span dir="LTR"> </span><span dir="LTR"> </span> <span dir="RTL">&#65187;&#65268;&#65178;</span><span dir="LTR"> </span><span dir="LTR"> </span> ,<span dir="RTL">&#1575;&#65247;&#65204;&#65268;&#65166;&#1585;&#1577;</span><span dir="LTR"> </span><span dir="LTR"> </span> <span dir="RTL">&#65207;&#65198;&#65243;&#65172;</span><span dir="LTR"> </span><span dir="LTR"> </span> <span dir="RTL">&#65251;&#65254;</span><span dir="LTR"> </span><span dir="LTR"> </span> <span dir="RTL">&#1575;&#65247;&#65228;&#65240;&#65194;</span><span dir="LTR"> </span>.<span dir="RTL">&#1575;&#65247;&#65236;&#65166;&#65163;&#65194;&#1577;</span><span dir="LTR"> </span><span dir="LTR"> </span> <span dir="RTL">&#65247;&#65252;&#65228;&#65194;&#1604;</span><span dir="LTR"> </span><span dir="LTR"> </span> <span dir="RTL">&#65175;&#65170;&#65228;&#65166;</span><span dir="LTR"> </span><span dir="LTR"> </span> <span dir="RTL">&#65175;&#65200;&#65267;&#65194;</span></p></td>
  </tr>
  <tr>
    <td colspan="2">2. Should be vehicle be returned at any of our Airport locations the following charges will apply.</td>
    <td colspan="4" align="right"><span dir="RTL">&#1575;&#65247;&#65252;&#65220;&#65166;&#1585;</span><span dir="LTR"> </span><span dir="LTR"> </span> <span dir="RTL">&#65235;&#65266;</span><span dir="LTR"> </span><span dir="LTR"> </span> <span dir="RTL">&#65235;&#65198;&#1608;&#65227;&#65256;&#65166;</span><span dir="LTR"> </span><span dir="LTR"> </span> <span dir="RTL">&#65251;&#65254;</span><span dir="LTR"> </span><span dir="LTR"> </span> <span dir="RTL">&#65235;&#65198;&#1593;</span><span dir="LTR"> </span><span dir="LTR"> </span> <span dir="RTL">&#1610;</span>N <span dir="RTL">&#1575;&#65247;&#65252;&#65198;&#65243;&#65170;&#65172;</span><span dir="LTR"> </span><span dir="LTR"> </span> <span dir="RTL">&#1573;&#65227;&#65166;&#1583;&#1577;</span><span dir="LTR"> </span><span dir="LTR"> </span> <span dir="RTL">&#65227;&#65256;&#65194;</span><span dir="LTR"> </span><span dir="LTR"> </span> .<span dir="RTL"> </span><span dir="RTL"><span dir="RTL"> </span>&#1634;.</span><br><span dir="RTL">&#1575;&#65247;&#65176;&#65166;&#65247;&#65268;&#65172;</span><span dir="LTR"> </span><span dir="LTR"> </span>&nbsp; <span dir="RTL">&#1575;&#65247;&#65198;&#65203;&#65262;&#1605;</span><span dir="LTR"> </span><span dir="LTR"> </span>&nbsp;<span dir="RTL">&#1583;&#65235;&#65226;</span><span dir="LTR"> </span><span dir="LTR"> </span>&nbsp;<span dir="RTL">&#65227;&#65248;&#65268;&#65242;</span><span dir="LTR"> </span><span dir="LTR"> </span>&nbsp;<span dir="RTL">&#65203;&#65268;&#65204;&#65176;&#65188;&#65238;</span></td>
  </tr>
  <tr>
    <td colspan="2">3. Sharjah Airport Terminal AED 25.</td>
    <td colspan="4" align="right"><span dir="RTL">&#1583;&#1585;&#65259;&#65250;</span><span dir="LTR"> </span><span dir="LTR"> </span>&nbsp;25 <span dir="RTL">&#1575;&#65247;&#65208;&#65166;&#1585;&#65239;&#65172;</span><span dir="LTR"> </span><span dir="LTR"> </span>&nbsp;<span dir="RTL">&#65251;&#65220;&#65166;&#1585;</span><span dir="LTR"> </span><span dir="LTR"> </span>&nbsp;.3</td>
  </tr>
  <tr>
    <td><p align="center" dir="RTL"><span dir="LTR">&#65175;&#65236;&#65166;&#65211;&#65268;&#65246; &#1575;N&#65251;&#65268;&#65166;&#1604; &#1575;&#65247;&#65200;&#1575;&#65163;&#65194;&#1577;</span><br>
    Excess Mileage Details
    </p></td>
    <td colspan="2"><p align="center" dir="RTL"><span dir="LTR">&#65267;&#65262;&#65251;&#65268;&#65166;</span><br>Daily</p></td>
    <td colspan="2"><p align="center" dir="RTL"><span dir="LTR">&#1571;&#65203;&#65170;&#65262;&#65227;&#65268;&#65166;</span><br>Weekly
    </p></td>
    <td><p align="center" dir="RTL"><span dir="LTR">&#65207;&#65260;&#65198;&#65267;&#65166;</span><br>
      Monthly
    </p></td>
  </tr>
  <tr>
    <td><p align="right" dir="RTL"><span dir="LTR">&#65227;&#65194;&#1583;  &#1575;&#65247;&#65244;&#65268;&#65248;&#65262;&#65251;&#65176;&#65198;&#1575;&#1578; &#65247;&#65244;&#65246; &#1608;&#65187;&#65194;&#1577;</span><br>
    Mileage Per Unit
    </p></td>
    <td colspan="2">&nbsp;</td>
    <td colspan="2">&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="3"><p align="right" dir="RTL"><span dir="LTR">&#1575;&#65247;&#65194;&#65235;&#65228;&#65172; &#1575;&#65247;&#65252;&#65204;&#65176;&#65248;&#65252;&#65172; &#1575;&#65247;&#65262;&#1583;&#65267;&#65228;&#65172;</span><br>Payment Recieved Deposit Advance
      
    </p></td>
    <td colspan="3">&nbsp;</td>
  </tr>
  <tr>
    <td><p align="right" dir="RTL"><span dir="LTR">&#65175;&#65244;&#65248;&#65236;&#65172; &#1575;&#65247;&#65244;&#65268;&#65248;&#65262;&#65251;&#65176;&#65198;&#1575;&#1578; &#1575;&#65247;&#65200;&#1575;&#65163;&#65194;&#1577;</span><br>
    Charges per extra km
    </p></td>
    <td colspan="2">&nbsp;</td>
    <td colspan="2">&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="3">Toll Service Charges in : 25 %<br>Fine Service Charges in :10 %<br>
    Fuel Service Charges in :10 %</td>
    <td colspan="3" align="right"><p>% <span dir="RTL"> </span><span dir="RTL"><span dir="RTL"> </span>&#1637;&#1634;</span><span dir="LTR"> </span><span dir="LTR"> </span>&nbsp;: <span dir="RTL">&#65183;&#65252;&#65166;&#65247;&#65268;&#65172;</span>N<span dir="RTL">&#1575;</span><span dir="LTR"> </span><span dir="LTR"> </span>&nbsp;<span dir="RTL">&#1575;&#65247;&#65192;&#65194;&#65251;&#65172;</span><span dir="LTR"> </span><span dir="LTR"> </span>&nbsp;<span dir="RTL">&#1585;&#65203;&#65262;&#1605;</span> <br>
    <span dir="RTL"> </span><span dir="RTL"><span dir="RTL"> </span>%&#1632;&#1633;</span><span dir="LTR">   </span><span dir="LTR"> </span> <span dir="RTL">&#1575;&#65247;&#65184;&#65268;&#65194;&#1577;</span><span dir="LTR"> </span><span dir="LTR"> </span> <span dir="RTL">&#1575;&#65247;&#65192;&#65194;&#65251;&#65172;</span><span dir="LTR"> </span><span dir="LTR"> </span> <span dir="RTL">&#1585;&#65203;&#65262;&#1605;</span><br>%<span dir="RTL"> </span><span dir="RTL"><span dir="RTL"> </span>&#1632;&#1633;</span><span dir="LTR"> </span><span dir="LTR"> </span> <span dir="RTL">&#1575;&#65247;&#65262;&#65239;&#65262;&#1583;</span><span dir="LTR"> </span><span dir="LTR"> </span> <span dir="RTL">&#65191;&#65194;&#65251;&#65172;</span><span dir="LTR"> </span><span dir="LTR"> </span> <span dir="RTL">&#1585;&#65203;&#65262;&#1605;</span></p></td>
  </tr>
</table>
<table width="100%" border="0">
  <tr>
    <td width="51%" rowspan="2" align="right"><p dir="RTL"><span dir="LTR">&bull;</span><span dir="LTR"> </span><span dir="LTR">&#65175;&#65262;&#65239;&#65268;&#65228;&#65266; &#1571;&#1583;&#65255;&#65166;&#1607; &#65267;&#65240;&#65198;</span><span dir="LTR"> </span><span dir="LTR">&#65169;&#65166;&#65227;&#65176;&#65198;&#1575;&#65235;&#65266;</span><span dir="LTR"> </span><span dir="LTR">&#65169;&#65194;&#65235;&#65226; &#1575;&#65247;&#65252;&#65170;&#65248;&#65230;  &#1575;&#65247;&#65252;&#65228;&#65268;&#65254; &#1608;&#65235;&#65240;&#65166; &#65275;&#65175;&#65236;&#65166;&#65239;&#65268;&#65172;</span><span dir="LTR"> </span><span dir="LTR">&#1575;&#65275;&#65267;&#65184;&#65166;&#1585;</span><span dir="LTR"> </span><span dir="LTR">&#65259;&#65196;&#1607;.</span><span dir="LTR"> </span><br>
      <span dir="LTR">&bull;</span><span dir="LTR"> </span><span dir="LTR">&#1608;&#65235;&#65240;&#65166;</span><span dir="LTR"> </span><span dir="LTR">&#65247;&#65184;&#65252;&#65268;&#65226; &#1575;&#65175;&#65236;&#65166;&#65239;&#65268;&#65166;&#1578;</span><span dir="LTR"> </span><span dir="LTR">&#1575;N&#65267;&#65184;&#65166;&#1585;</span><span dir="LTR">,</span><span dir="LTR"> </span><span dir="LTR">&#65203;&#65268;&#65176;&#65250; &#1583;&#65235;&#65226;</span><span dir="LTR"> </span><span dir="LTR">&#1585;&#65203;&#65262;&#1605; &#1586;&#1575;&#65163;&#65194;&#1577;</span><span dir="LTR"> </span><span dir="LTR">&#65235;&#65266;</span><span dir="LTR"> </span><span dir="LTR">&#65187;&#65166;&#65247;&#65172; &#1586;&#65267;&#65166;&#1583;&#1577;  &#65227;&#65194;&#1583; &#1575;&#65247;&#65244;&#65268;&#65248;&#65262;&#65251;&#65176;&#65198;&#1575;&#1578;.</span><span dir="LTR"> </span><br>
      <span dir="LTR">&bull;</span><span dir="LTR"> </span><span dir="LTR">&#65267;&#65184;&#65168;</span><span dir="LTR"> </span><span dir="LTR">&#65239;&#65268;&#65166;&#1583;&#1577;</span><span dir="LTR"> </span><span dir="LTR">&#65203;&#65268;&#65166;&#1585;&#1575;&#1578;</span><span dir="LTR"> </span><span dir="LTR">&#1575;&#65247;&#65194;&#65235;&#65226;</span><span dir="LTR"> </span><span dir="LTR">&#1575;&#65247;&#65198;&#65169;&#65166;&#65227;&#65266;</span><span dir="LTR"> </span><span dir="LTR">&#65235;&#65240;&#65218;</span><span dir="LTR"> </span><span dir="LTR">&#65227;&#65248;&#65264;</span><span dir="LTR"> </span><span dir="LTR">&#1575;&#65247;&#65220;&#65198;&#65267;&#65238;</span><span dir="LTR"> </span><span dir="LTR">&#1575;&#65247;&#65252;&#65228;&#65170;&#65194;&#1577;</span><span dir="LTR"> </span><span dir="LTR">&#1608; &#65275;</span><span dir="LTR"> </span><span dir="LTR">&#65267;&#65204;&#65252;&#65186; &#65169;&#65166;&#65247;&#65240;&#65268;&#65166;&#1583;&#1577;  &#65227;&#65248;&#65264;</span><span dir="LTR"> </span><span dir="LTR">&#1575;&#65247;&#65198;&#65251;&#65166;&#1604;&#1548; &#1608;</span><span dir="LTR"> </span><span dir="LTR">&#65203;&#65268;&#65176;&#65250;</span><span dir="LTR"> </span><span dir="LTR">&#1573;&#65247;&#65200;&#1575;&#1605;</span><span dir="LTR"> </span><span dir="LTR">&#1575;&#65247;&#65200;&#65169;&#65262;&#1606;</span><span dir="LTR"> </span><span dir="LTR">&#65169;&#65194;&#65235;&#65226;</span><span dir="LTR"> </span><span dir="LTR">&#65183;&#65252;&#65268;&#65226; &#1575;&#65247;&#65198;&#65203;&#65262;&#1605;</span><span dir="LTR"> </span><span dir="LTR">&#1608;</span><span dir="LTR"> </span><br>
      <span dir="LTR">&#1575;&#65247;&#65232;&#65198;&#1575;&#65251;&#65166;&#1578;</span><span dir="LTR"> </span><span dir="LTR">&#65235;&#65266;</span><span dir="LTR"> </span><span dir="LTR">&#65187;&#65166;&#1604; &#1573;&#65247;&#65188;&#65166;&#1602;</span><span dir="LTR"> </span><span dir="LTR">&#1575;&#65247;&#65216;&#65198;&#1585;</span><span dir="LTR"> </span><span dir="LTR">&#65169;&#65166;&#65247;&#65252;&#65198;&#65243;&#65170;&#65172;</span><span dir="LTR"> </span><span dir="LTR">&#65235;&#65266;</span><span dir="LTR"> </span><span dir="LTR">&#65187;&#65166;&#65247;&#65172;</span><span dir="LTR"> </span><span dir="LTR">&#65227;&#65194;&#1605;</span><span dir="LTR"> </span><span dir="LTR">&#1575;N&#65247;&#65176;&#65200;&#1575;&#1605;.</span><span dir="LTR"> </span><br>
      <span dir="LTR">&bull;</span><span dir="LTR"> </span><span dir="LTR">&#65235;&#65266;</span><span dir="LTR"> </span><span dir="LTR">&#65187;&#65166;&#65247;&#65172; &#65175;&#65262;&#65239;&#65268;&#65234;  &#1575;&#65247;&#65252;&#65198;&#65243;&#65170;&#65172; &#65251;&#65254;</span><span dir="LTR"> </span><span dir="LTR">&#1571;&#1610;</span><span dir="LTR"> </span><span dir="LTR">&#65183;&#65260;&#65172; &#65187;&#65244;&#65262;&#65251;&#65268;&#65172;&#1548;  &#1571;&#1608;&#1575;&#65235;&#65238; &#65227;&#65248;&#65264; &#1575;&#65203;&#65176;&#65244;&#65252;&#65166;&#1604;  &#1585;&#65203;&#65262;&#1605;</span><span dir="LTR"> </span><span dir="LTR">&#1575;N&#65267;&#65184;&#65166;&#1585;</span><span dir="LTR"> </span><span dir="LTR">&#65247;&#65232;&#65166;&#65267;&#65172; &#1575;&#65255;&#65176;&#65260;&#65166;&#1569;  &#1575;&#65247;&#65252;&#65194;&#1577;</span><span dir="LTR"> </span><span dir="LTR">&#1608;</span><span dir="LTR"> </span><span dir="LTR">&#65175;&#65204;&#65248;&#65268;&#65252;&#65260;&#65166; &#65247;&#65208;&#65198;&#65243;&#65172;</span><span dir="LTR"> </span><span dir="LTR">&#1575;&#65247;&#65204;&#65268;&#65166;&#1585;&#1577;.</span><span dir="LTR"> </span><br>
      <span dir="LTR">&bull;</span><span dir="LTR"> </span><span dir="LTR">&#65175;&#65240;&#65198;&#65267;&#65198;  &#1575;&#65247;&#65208;&#65198;&#65219;&#65172; &#65247;&#65208;&#65198;&#65243;&#65172; &#1575;&#65247;&#65176;&#65156;&#65251;&#65268;&#65254;</span><span dir="LTR"> </span><span dir="LTR">&#65215;&#65198;&#1608;&#1585;&#1610;</span><span dir="LTR"> </span><span dir="LTR">&#65183;&#65194;&#1575;</span><span dir="LTR"> </span><span dir="LTR">&#65235;&#65266;</span><span dir="LTR"> </span><span dir="LTR">&#65187;&#65166;&#65247;&#65172; &#1575;&#65247;&#65188;&#65262;&#1575;&#1583;&#1579;.</span><span dir="LTR"> </span><br>
      <span dir="LTR">&bull;</span><span dir="LTR"> </span><span dir="LTR">&nbsp;&#1575;&#65227;&#65176;&#65198;&#1601;</span><span dir="LTR"> </span><span dir="LTR">&#65169;&#65156;&#65255;&#65266;</span><span dir="LTR"> </span><span dir="LTR">&#65239;&#65194;</span><span dir="LTR"> </span><span dir="LTR">&#65239;&#65198;&#1571;&#1578;</span><span dir="LTR"> </span><span dir="LTR">&#1608;</span><span dir="LTR"> </span><span dir="LTR">&#65235;&#65260;&#65252;&#65174;</span><span dir="LTR"> </span><span dir="LTR">&#1608;</span><span dir="LTR"> </span><span dir="LTR">&#1571;&#65247;&#65176;&#65200;&#1605; &#65169;&#65184;&#65252;&#65268;&#65226; &#1575;&#65247;&#65208;&#65198;&#1608;&#1591;</span><span dir="LTR"> </span><span dir="LTR">&#1608;</span><span dir="LTR"> </span><span dir="LTR">&#1575;N&#65187;&#65244;&#65166;&#1605; &#1575;&#65247;&#65252;&#65244;&#65176;&#65262;&#65169;&#65172;</span><span dir="LTR"> </span><span dir="LTR">&#65235;&#65266; &#65259;&#65196;&#1575;</span><span dir="LTR"> </span><span dir="LTR">&#1575;N&#65175;&#65236;&#65166;&#1602;.</span><span dir="LTR"> </span><br>
    <span dir="LTR">&bull;</span><span dir="LTR"> </span><span dir="LTR">&#65275;&#65267;&#65204;&#65252;&#65186;  &#65169;&#65240;&#65268;&#65166;&#1583;&#1577; &#1575;&#65247;&#65252;&#65198;&#65243;&#65170;&#65172;</span><span dir="LTR"> </span><span dir="LTR">&#65191;&#65166;&#1585;&#1580;</span><span dir="LTR"> </span><span dir="LTR">&#65187;&#65194;&#1608;&#1583; &#1583;&#1608;&#65247;&#65172;</span><span dir="LTR"> </span><span dir="LTR">&#1575;&#65275;&#65251;&#65166;&#1585;&#1575;&#1578;.</span><span dir="LTR"> </span></p></td>
    <td width="49%" height="110" align="left"><p align="left" dir="RTL"><span dir="LTR">&#65175;&#65262;&#65239;&#65268;&#65226; &#1575;&#65247;&#65252;&#65262;&#65223;&#65234;</span><br>Staff's Signature
    </p></td>
  </tr>
  <tr>
    <td height="116" align="left"><p align="left" dir="RTL"><span dir="LTR">&#1575;&#65203;&#65250;</span><span dir="LTR"> </span><span dir="LTR">&#1575;&#65247;&#65252;&#65204;&#65176;&#65156;&#65183;&#65198; &#1575;&#65247;&#65244;&#65166;&#65251;&#65246;</span><br>
    Hirer's Name
    </p></td>
  </tr>
  <tr>
    <td rowspan="2"><ul>
    	<li>My Signature below shall constitute my authority to debit my nominated credit(s) with the amounts due under this rental agreement.</li>
        <li>For all rental agreemets the agreed excess km rate (per km) will be applied.</li>
        <li>4*4 vehicles are for paved road driving only.Desert driving is not permitted.Customers will be charged in full for any damage caused by off-roading.</li>
        <li>If the vehicle is impounded by Govt. authorities for any violation of law.I accept to pay the rental charges till it is returned to Al Sayara.</li>
        <li>Police reports are mandatory in all cases to claim the insurance.</li>
        <li>I/We acknowledge that i/we read the and understood the terms and conditions printed above the overleaf and hereby acknowledge myself/ourselfs to bound therby.</li>
        <li>Vehicle not allowed to drive out of UAE</li>
    </td>
    <td width="49%" height="90">&nbsp;</td>
  </tr>
  <tr>
    <td align="left"><p align="left" dir="RTL"><span dir="LTR">&#65175;&#65262;&#65239;&#65268;&#65226; &#1575;&#65247;&#65252;&#65204;&#65176;&#65156;&#65183;&#65198;</span><br>
    Hire's Signature
    
    </p></td>
  </tr>
</table> -->
<hr style="width:100%;">
<p style="text-align:center;">www.sayararental.com</p>
</body>
</html>