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
 <link rel="stylesheet" type="text/css" href="../../../../css/body.css">
<style type="text/css">
.tablereceipt {
    border: 1px solid black;
    border-collapse: collapse;
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
    
    
    #pageFooter {
    display: table-footer-group;
}

#pageFooter:after {
      counter-increment: page;
      counter-reset: pages 1;
      content: "Page " counter(page) " / " counter(pages);
}

</style>
<script type="text/javascript">
$(document).ready(function ()
		 {
/* document.getElementById("collectionfield").style.display="none";
document.getElementById("deliveryfield").style.display="none";
if(document.getElementById("lbldelivery").innerText=="1"){
	document.getElementById("deliveryfield").style.display="block";	
}
if(document.getElementById("lblcollection").innerText=="1"){
	document.getElementById("collectionfield").style.display="block";	
} */
		 }); 
		 </script>
</head>
<body bgcolor="white" style="font-size:12px" >
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmprintrep" action="printrep" method="post" autocomplete="off" target="_blank">

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
    <td rowspan="2"  align="center"><b><font size="5">Vehicle PickUp</font></b></td>
    <td align="left"><b>Tel :</b>&nbsp;<label id="mobileno" name="mobileno"><s:property value="mobileno"/></label></td>
  </tr>
  <tr>
    <td align="left"><b>Fax :</b>&nbsp;<label id="fax" name="fax"><s:property value="fax"/></label></td>
  </tr>
  <tr>
    <td rowspan="2"  align="center">&nbsp;</td>
    <td align="left"><b>Branch :</b>&nbsp;<label id="barnchval" name="barnchval"><s:property value="barnchval"/></label></td>
  </tr>
  <tr>
    <td align="left"><b>Location :</b>&nbsp;<label id="location" name="location"><s:property value="location"/></label></td>
  </tr>
  <tr>
    <td colspan="3"><hr noshade size=1 width="100%"></td>
  </tr>
</table>

<fieldset>
<legend><b>Agreement Opening Details</b></legend>

<table width="100%" >
<tr>
<td width="100%">
<table width="100%"  >
<tr>
<td align="left" width="11%">Branch</td >
<td>:&nbsp;<label id="lblagmtbranch" name="lblagmtbranch"> <s:property value="lblagmtbranch"/></label></td>
<td width="12%" align="left">&nbsp;</td>
<td width="19%" align="left">&nbsp;</td>
<td align="left">Doc NO </td>
<td align="left">:&nbsp;<label id="lbldocno" name="lbldocno"> <s:property value="lbldocno"/></label></td>
</tr>
<tr>
  <td align="left">Location</td >
  <td align="left">:&nbsp;
    <label id="lblagmtloc" name="lblagmtloc" >
      <s:property value="lblagmtloc"/>
    </label></td>
  <td align="left">&nbsp;</td>
  <td align="left">&nbsp;</td>
  <td align="left">Date</td>
  <td align="left">:&nbsp;
    <label id="lbldate" name="lbldate">
      <s:property value="lbldate"/>
    </label></td>
</tr>
<tr>
<td align="left" width="11%">Agreement</td><td align="left" width="20%">:&nbsp;<label id="lblagmttype" name="lblagmttype"> <s:property value="lblagmttype"/>
  &nbsp; -      <s:property value="lblvrano"/>
 
</label></td>
<td align="left">&nbsp;</td>
<td align="left">&nbsp;</td>
<td align="left">Fleet</td>
<td align="left" width="29%">:&nbsp;
  <label id="lblfleet_no" name="lblfleet_no">
    <s:property value="lblfleet_no"/>
  </label>
&nbsp;&nbsp;
<label id="lblflname" name="lblflname">
  <s:property value="lblflname"/>
</label></td>

</tr>
<tr>
  <td align="left">VRA Date</td>
  <td align="left">:&nbsp;
    <label id="lblvradate" name="lblvradate">
      <s:property value="lblvradate"/>
    </label></td>
  <td align="left">&nbsp;</td>
  <td align="left">&nbsp;</td>
  <td align="left">Reg NO</td>
  <td align="left">:&nbsp;
    <label id="lblregno" name="lblregno">
      <s:property value="lblregno"/>
    </label></td>
</tr>
<tr>
  <td align="left">Client</td>
  <td colspan="3" align="left">:&nbsp;
    <label id="lblclientacno" name="lblclientacno">
      <s:property value="lblclientacno"/>
    </label>
  &nbsp;
  <label id="lblrefname" name="lblrefname">
    <s:property value="lblrefname"/>
</label></td>
  <td align="left">Date Out </td>
  <td align="left">:&nbsp;
    <label id="lblstartdate" name="lblstartdate"> 
      <s:property value="lblstartdate"/> &nbsp; <s:property value="lblstarttime"/>
    </label></td>
</tr>
<tr>
  <td align="left">Driven By</td>
  <td colspan="3" align="left">:&nbsp;
    <label id="lbldrivenby" name="lbldrivenby">
      <s:property value="lbldrivenby"/>
      </label></td>
  <td align="left">KM Out</td>
  <td align="left">:&nbsp;
    <label id="lblstartkm" name="lblstartkm">
      <s:property value="lblstartkm"/>
      </label></td>
</tr>
<tr>
<td align="left">Description</td><td colspan="3" align="left">:&nbsp;
  <label id="lblagmtdesc" name="lblagmtdesc">
    <s:property value="lblagmtdesc"/>
  </label></td>
<td width="9%" align="left">Fuel Out </td>
<td align="left">:&nbsp;
  <label id="lblstartfuel" name="lblstartfuel">
    <s:property value="lblstartfuel"/>
  </label></td>
<!--Time<label id="dtimes" name="dtimes">
      <s:property value="dtimes"/>
    </label>
--></tr>

</table>
</td>
</tr>
</table>
</fieldset>
<br>
<fieldset><legend><b>Pick Up Details</b></legend>
<table width="100%">
  <tr>
    <td width="8%">Branch</td>
    <td width="16%">:&nbsp;
            <label id="lblpickbranch" name="lblpickbranch">
              <s:property value="lblpickbranch"/>
            </label></td>
    <td width="4%">Location</td>
    <td width="19%">:&nbsp;
      <label id="lblpicklocation" name="lblpicklocation">
        <s:property value="lblpicklocation"/>
      </label></td>
    <td width="53%" rowspan="8"><img src="<%=contextPath%>/icons/replacevehicle.jpg" width="100%" height="50%" alt=""/></td>
    </tr>
  <tr>
    <td>Fleet No</td>
    <td colspan="3">:&nbsp;
      <label id="lblfleet_no" name="lblfleet_no">
        <s:property value="lblfleet_no"/>
        </label>
      &nbsp;&nbsp;
      <label id="lblflname" name="lblflname">
        <s:property value="lblflname"/>
</label></td>
    </tr>
  <tr>
    <td>Reg No</td>
    <td >:&nbsp;
      <label id="lblregno" name="lblregno">
        <s:property value="lblregno"/>
      </label></td>
    <td>Driver</td>
    <td>:&nbsp;
    <%--   <label id="lblcoldriver" name="lblcoldriver">
        <s:property value="lblcoldriver"/>
      </label> --%></td>
    </tr>
  <tr>
    <td>Description</td>
    <td colspan="3" rowspan="1" >:&nbsp;
      <label id="lblpickdesc" name="lblpickdesc">
        <s:property value="lblpickdesc"/>
        </label></td>
  </tr>

  <tr>
    <td height="123" colspan="2"><fieldset>
      <legend>Pick Up-Client</legend>
      <table width="100%">
        <tr>
          <td width="20%">Date</td>
          <td width="80%">:&nbsp;
            <label id="lblpdate" name="lblpdate">
              <s:property value="lblpdate"/>
              </label></td>
          </tr>
        <tr>
          <td>Time</td>
          <td>:&nbsp;
            <label id="lblptime" name="lblptime">
              <s:property value="lblptime"/>
              </label></td>
          </tr>
        <tr>
          <td>KM</td>
          <td>:&nbsp;
            <label id="lblpkm" name="lblpkm">
              <s:property value="lblpkm"/>
              </label></td>
          </tr>
        <tr>
          <td>Fuel</td>
          <td>:&nbsp;
            <label id="lblpfuel" name="lblpfuel">
              <s:property value="lblpfuel"/>
              </label></td>
          </tr>
        </table>
      </fieldset></td>
    <td colspan="2"><fieldset>
      <legend>Collected - Client</legend>
      <table width="99%">
        <tr>
          <td width="25%">Date</td>
          <td width="75%">:&nbsp;
            <%-- <label id="coldate" name="coldate">
              <s:property value="coldate"/>
              </label> --%></td>
          </tr>
        <tr>
          <td>Time</td>
          <td>:&nbsp;
            <%-- <label id="coltime" name="coltime">
              <s:property value="coltime"/>
            </label> --%></td>
          </tr>
        <tr>
          <td>KM</td>
          <td>:&nbsp;
            <%-- <label id="colkm" name="colkm">
              <s:property value="colkm"/>
            </label> --%></td>
          </tr>
        <tr>
          <td>Fuel</td>
          <td>:&nbsp;
            <%-- <label id="colfuel" name="colfuel">
              <s:property value="colfuel"/>
            </label> --%></td>
          </tr>
        </table>
      </fieldset></td>
  </tr>
</table>

</fieldset>
<br>

<table width="100%">
  <tr>
    <td width="41%"><fieldset><legend>Customer </legend>
    <table width="100%">
  <tr>
    <td width="29%">Name</td>
    <td width="71%">&nbsp;</td>
  </tr>
  <tr>
    <td>Signature</td>
    <td>&nbsp;</td>
  </tr>
</table>

    </fieldset></td>
    <td width="24%">&nbsp;</td>
    <td width="35%"><fieldset>
        <legend>Checked By</legend><table width="100%">
          <tr>
            <td width="24%">Name</td>
            <td width="76%">&nbsp;</td>
          </tr>
          <tr>
            <td>Signature</td>
            <td>&nbsp;</td>
          </tr>
        </table>
    </fieldset></td>
  </tr>
</table>
</div>
<label id="lbldelivery" name="lbldelivery" hidden="true"><s:property value="lbldelivery"/></label>
<label id="lblcollection" name="lblcollection" hidden="true"><s:property value="lblcollection"/></label>


</form>

</div>
<table style="width:100%;"><tr><td><jsp:include page="../../../common/printFooter.jsp"></jsp:include></td></tr></table>
</body>
</html>
