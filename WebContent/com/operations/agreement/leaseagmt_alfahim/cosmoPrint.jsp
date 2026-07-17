 <%@ page pageEncoding="utf-8" %>
 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript" src="../../../../js/jquery-1.11.1.min.js"></script> 
<style>
body{
overflow:hidden;
}
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
font-size:12px !important;
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
<script type="text/javascript">
$(document).ready(function(){
	/* if($('.term').val()=='' || $('.term').text()==''){
		$('#termtable').hide();
	} */
});
</script>
</head>
<body>
<div style="width:100%;height:130px;"></div>
<div class="bordertop borderbottom borderleft borderright" style="border-radius:5px;">
<table width="100%" border="0">
  <tr>
    <td width="16%"><b>Station Operation</b></td>
    <td width="34%">: </td>
    <td width="20%"><b>Agreement Number</b></td>
    <td width="30%"><label name="lblcosmoagmtno">: <s:property value="lblcosmoagmtno"/></label></td>
  </tr>
</table>
</div>
<div class="bordertop borderbottom borderleft borderright" style="border-radius:5px;">
<table width="100%" border="0">
  <tr>
    <td colspan="2" class="borderbottom"><b>This agreement made between the parties here in after started as</b></td>
    <td colspan="2" class="borderbottom">&nbsp;</td>
  </tr>
  <tr>
    <td width="11%" class="borderright"><b>Lessor</b></td>
    <td width="39%" class="borderright">Al Sayara Limousine Passengers Transport</td>
    <td width="12%" class="borderright"><b>Lesse</b></td>
    <td width="38%" class=""><label name="lblcosmoclientname"><s:property value="lblcosmoclientname"/></label></td>
  </tr>
  <tr>
    <td class="borderright">&nbsp;</td>
    <td class="borderright">Sharjah, UAE</td>
    <td class="borderright">&nbsp;</td>
    <td><label name="lblcosmoclientaddress"><s:property value="lblcosmoclientaddress"/></label></td>
  </tr>
  <tr>
    <td class="borderright">&nbsp;</td>
    <td class="borderright">Tel 600 52 2200</td>
    <td class="borderright">&nbsp;</td>
    <td><label name="lblcosmoclientmobile"><s:property value="lblcosmoclientmobile"/></label></td>
  </tr>
  <tr>
    <td class="borderright">&nbsp;</td>
    <td class="borderright">&nbsp;</td>
    <td class="borderright">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
</div>
<div class="bordertop borderbottom borderleft borderright" style="border-radius:5px;">
<table width="100%" border="0">
  <tr>
    <td colspan="6" class="borderbottom"><b>Referring to the motor vehicle as specified here after</b></td>
  </tr>
  <tr>
    <td colspan="2" class="borderbottom">Vehicle Registered under the license :</td>
    <td width="12%" class="borderbottom">&nbsp;</td>
    <td width="20%" class="borderbottom">&nbsp;</td>
    <td width="9%" class="borderbottom">&nbsp;</td>
    <td width="21%" class="borderbottom">&nbsp;</td>
  </tr>
  <tr>
    <td width="13%" class="borderbottom borderright">Fleet No</td>
    <td width="25%" class="borderbottom"><label name="lblcosmofleetno"><s:property value="lblcosmofleetno"/></label></td>
    <td class="borderbottom borderright borderleft">Colour</td>
    <td class="borderbottom"><label name="lblcosmocolor"><s:property value="lblcosmocolor"/></label></td>
    <td class="borderbottom borderright">Engine No</td>
    <td class="borderbottom"><label name="lblcosmoengine"><s:property value="lblcosmoengine"/></label></td>
  </tr>
  <tr>
    <td class="borderbottom borderright">Reg No Year Model</td>
    <td class="borderbottom"><label name="lblcosmoregdetails"><s:property value="lblcosmoregdetails"/></label>
    </td>
    <td class="borderbottom borderright borderleft">Chassis No</td>
    <td class="borderbottom"><label name="lblcosmochassis"><s:property value="lblcosmochassis"/></label></td>
    <td class="borderbottom">&nbsp;</td>
    <td class="borderbottom">&nbsp;</td>
  </tr>
  <tr>
    <td class=" borderright">Vehicle Make </td>
    <td class=""><label name="lblcosmobrand"><s:property value="lblcosmobrand"/></label></td>
    <td class="">&nbsp;</td>
    <td class="">&nbsp;</td>
    <td class="">&nbsp;</td>
    <td class="">&nbsp;</td>
  </tr>
</table>
</div>
<div class="bordertop borderbottom borderleft borderright" style="border-radius:5px;">
<table width="100%" border="0">
  <tr>
  	<td>Lesser hereby leases to lessee and leases from lessor the vehicle specified above for a period of <br>
   <%--  <label name="lblcosmoduration"><s:property value="lblcosmoduration"/></label>
    <div style="height:12px;"></div>
  	____________________________{__________________________________________________________}months commercing on <div style="height:12px;"></div>
  	<label name="lblcosmostartdate"><s:property value="lblcosmostartdate"/></label>
    <label name="lblcosmoenddate"><s:property value="lblcosmoenddate"/></label>
    <label name="lblcosmoagreedrate"><s:property value="lblcosmoagreedarate"/></label>
    <label name="lblcosmoexcessamt"><s:property value="lblcosmoexcessamt"/></label>
    _______________________________and terminating on _______________________________at an agreed rate of UAE Dirhams <div style="height:12px;"></div>
  	__________________________________{UAE Dirhams ______________________________________________________________}<div style="height:12px;"></div>
  	per month,and subject to the conditions below and on the overleaf.</label>
  	<label><div style="height:12px;"></div>Excess amount applicable Dhs.________________________________{Ref.Clause A (4) on the reverse}.</label>
  	<label><div style="height:12px;"></div>The terms and conditions on the reverse have been understood and agreed by the parties______________________________________________.</label>
  	<label><div style="height:12px;"></div>hereto,whose autorized represntatives have signed below in acceptance.</label> --%>
  	<p style="display:inline;line-height:40px;" class="borderbottom"><label name="lblcosmoduration" style="padding-left:70px;padding-right:50px;"><s:property value="lblcosmoduration"/></label></p>
  	months commercing on <p style="display:inline;" class="borderbottom"><label style="padding-left:70px;padding-right:50px;" name="lblcosmostartdate">
  	<s:property value="lblcosmostartdate"/></label> </p> and terminating on <p style="display:inline;line-height:40px;" class="borderbottom">
  	<label style="padding-left:70px;padding-right:50px;" name="lblcosmoenddate"><s:property value="lblcosmoenddate"/></label> </p>
  	at an agreed rate of UAE Dirhams <p style="display:inline;line-height:40px;" class="borderbottom">
  	<label style="padding-left:70px;padding-right:50px;" name="lblcosmoagreedrate"><s:property value="lblcosmoagreedrate"/></label></p>{UAE Dirhams 
  	<p style="display:inline;line-height:40px;" class="borderbottom">
  	<label style="padding-left:70px;padding-right:50px;" name="lblcosmoagreedratewords"><s:property value="lblcosmoagreedratewords"/></label></p>
  	per month,and subject to the conditions below and on the overleaf.<p style="display:block;line-height:30px;width:0px;" class="borderbottom"></p>
  	Excess amount applicable Dhs.<p style="display:inline;line-height:40px;" class="borderbottom"><label name="lblcosmoexcessamt"><s:property value="lblcosmoexcessamt"/></label></p>
  	{Ref.Clause A (4) on the reverse}.<p style="display:block;line-height:40px;"></p><br>
  	The terms and conditions on the reverse have been understood and agreed by the parties<p style="display:block;line-height:40px;width:0px;" class="borderbottom"></p>
  	hereto ,whose authorized representitives have signed below in acceptance.
	</td>
	</tr>
</table>
</div>
<div class="bordertop borderbottom borderleft borderright" style="border-radius:5px;">
<table width="100%" border="0">
  <tr>
    <td colspan="2"><b>Additional Clauses:</b></td>
  </tr>
  <tr>
    <td width="50%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    &nbsp;<table width="100%" border="0" id="termtable" >
      <tr>
      	<th class="borderleft bordertop borderbottom borderright" style="border-radius:10px;">Start Month</tH>
        <th class="bordertop borderbottom borderright">End Month</th>
        <th class="bordertop borderbottom borderright">Amount</th>
      </tr>
      <tr>
        <td class="borderleft borderright" align="center"><label class="term" name="lblcosmoterm1"><s:property value="lblcosmoterm1"/></label></td>
        <td class="borderright"  align="center"><label class="term" name="lblcosmoterm2"><s:property value="lblcosmoterm2"/></label></td>
        <td class="borderright" align="center"><label class="term" name="lblcosmoamt1"><s:property value="lblcosmoamt1"/></label></td>
      </tr>
      <tr>
        <td class="borderleft borderright" align="center"><label class="term" name="lblcosmoterm3"><s:property value="lblcosmoterm3"/></label></td>
        <td class="borderright" align="center"><label class="term" name="lblcosmoterm4"><s:property value="lblcosmoterm4"/></label></td>
        <td class="borderright" align="center"><label class="term" name="lblcosmoamt2"><s:property value="lblcosmoamt2"/></label></td>
      </tr>
      <tr>
        <td class="borderleft borderright" align="center"><label class="term" name="lblcosmoterm5"><s:property value="lblcosmoterm5"/></label></td>
        <td class="borderright" align="center"><label class="term" name="lblcosmoterm6"><s:property value="lblcosmoterm6"/></label></td>
        <td class="borderright" align="center"><label class="term" name="lblcosmoamt3"><s:property value="lblcosmoamt3"/></label></td>
      </tr>
      <tr>
        <td class="borderleft borderright" align="center"><label class="term" name="lblcosmoterm7"><s:property value="lblcosmoterm7"/></label></td>
        <td class="borderright" align="center"><label class="term" name="lblcosmoterm8"><s:property value="lblcosmoterm8"/></label></td>
        <td class="borderright" align="center"><label class="term" name="lblcosmoamt4"><s:property value="lblcosmoamt4"/></label></td>
      </tr>
      <tr>
        <td class="borderleft borderright" align="center"><label class="term" name="lblcosmoterm9"><s:property value="lblcosmoterm9"/></label></td>
        <td class="borderright" align="center"><label class="term" name="lblcosmoterm10"><s:property value="lblcosmoterm10"/></label></td>
        <td class="borderright" align="center"><label class="term" name="lblcosmoamt5"><s:property value="lblcosmoamt5"/></label></td>
      </tr>
    </table></td>
    <td width="50%">&nbsp;</td>
  </tr>
</table>
</div>
<table width="100%" border="0">
  <tr>
    <td width="38%" align="center">Signature and Company stamp</td>
    <td align="center">&nbsp;</td>
    <td align="center">Signature and Company stamp</td>
  </tr>
  <tr>
    <td height="74" class="borderbottom">&nbsp;</td>
    <td width="21%">&nbsp;</td>
    <td width="41%" class="borderbottom">&nbsp;</td>
  </tr>
  <tr>
    <td align="center">Signed for &amp; on behailf of (Lessor)<br>
      Al Sayara Limousine Passengers Transport</td>
    <td align="center">&nbsp;</td>
    <td align="center">Signed for &amp; on behailf of (Lessee)<br>
Company Name</td>
  </tr>
</table>
<hr style="width:100%;">
<p style="text-align:center;">www.sayararental.com</p>
</body>
</html>