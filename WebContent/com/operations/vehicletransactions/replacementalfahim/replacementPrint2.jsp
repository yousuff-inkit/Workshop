<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<script type="text/javascript" src="<%=contextPath%>/js/jquery-1.11.1.min.js"></script>
<!--<jsp:include page="../../../../includes.jsp"></jsp:include>-->
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
 /* @media print
   {
      label{
      	font-size:14px !important;
      }
      body{
      	font-size:14px !important;
      }
   }
  @media screen
   {
      label{
      	font-size:12px !important;
      }
      body{
      	font-size:12px !important;
      }
   } 
   
*/

@media screen {
/*         #footerstyle { */
/*             display: none; */
/*         } */
    }
    @media print,screen
   {
      label{
      	font-size:12px !important;
      }
      body{
      	font-size:12px !important;
      }
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
}
*/

	var d = new Date,
    dformat = [''+' on '+d.getDate(),
               d.getMonth()+1,
               d.getFullYear()].join('-')+' at '+
              [d.getHours(),
               d.getMinutes(),
               d.getSeconds()].join(':');

	 document.getElementById("lblfooter").innerText=""+dformat;


		 }); 
		 </script>
</head>
<body bgcolor="white">
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
    <td rowspan="2"  align="center"><b><font size="5">Vehicle Replacement</font></b></td>
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
<td>:&nbsp;<label id="brwithcompany" name="brwithcompany"><s:property value="brwithcompany"/></label></td>
<td align="left">&nbsp;</td>
<td align="left">&nbsp;</td>
<td align="left">Doc NO </td>
<td align="left">:&nbsp;<label id="pdocno" name="pdocno"><s:property value="pdocno"/></label></td>
</tr>
<tr>
  <td align="left">Location</td >
  <td align="left">:&nbsp;
    <label id="lblrlocation" name="lblrlocation" >
      <s:property value="lblrlocation"/>
    </label></td>
  <td align="left">&nbsp;</td>
  <td align="left">&nbsp;</td>
  <td align="left">Date</td>
  <td align="left">:&nbsp;
    <label id="pdate" name="pdate">
      <s:property value="pdate"/>
    </label></td>
</tr>
<tr>
<td align="left" width="11%">Agreement</td><td align="left" width="20%">:&nbsp;<label id="agmt" name="agmt"><s:property value="agmt"/>
  &nbsp; -      <s:property value="vrano"/>
 
</label></td>
<td align="left">&nbsp;</td>
<td align="left">&nbsp;</td>
<td align="left">Fleet</td>
<td align="left" width="29%">:&nbsp;
  <label id="pfleetno" name="pfleetno">
    <s:property value="pfleetno"/>
  </label>
&nbsp;&nbsp;
<label id="lblinfleetname" name="lblinfleetname">
  <s:property value="lblinfleetname"/>
</label></td>

</tr>
<tr>
  <td align="left">VRA Date</td>
  <td align="left">:&nbsp;
    <label id="vradate" name="vradate">
      <s:property value="vradate"/>
    </label></td>
  <td align="left">&nbsp;</td>
  <td align="left">&nbsp;</td>
  <td align="left">Reg NO</td>
  <td align="left">:&nbsp;
    <label id="pregno" name="pregno">
      <s:property value="pregno"/>
    </label></td>
</tr>
<tr>
  <td align="left">Client</td>
  <td colspan="3" align="left">:&nbsp;
    <label id="clientacno" name="clientacno">
      <s:property value="clientacno"/>
    </label>
  &nbsp;
  <label id="pclient" name="pclient">
    <s:property value="pclient"/>
</label></td>
  <td align="left">Date Out </td>
  <td align="left">:&nbsp;
    <label id="poutdate" name="poutdate"> 
      <s:property value="poutdate"/> &nbsp; <s:property value="mtime"/>
    </label></td>
</tr>
<tr>


<!--Delivery<label id="pdelivery" name="pdelivery">
      <s:property value="pdelivery"/>
    </label>-->
</tr>
<tr>
  <td align="left">Opened</td>
  <td colspan="3" align="left">:&nbsp;
    <label id="popened" name="popened">
      <s:property value="popened"/>
    </label></td>
  <td align="left">KM Out</td>
  <td align="left">:&nbsp;
    <label id="pkm" name="pkm">
      <s:property value="pkm"/>
    </label></td>
</tr>
<tr>
<td align="left">Rep Type</td><td align="left">:&nbsp;
  <label id="reptype" name="reptype">
    <s:property value="reptype"/>
  </label></td>
<td width="12%" align="left">&nbsp;</td>
<td width="19%" align="left">&nbsp;</td>
<td width="9%" align="left">Fuel Out </td>
<td align="left">:&nbsp;
  <label id="pfuel" name="pfuel">
    <s:property value="pfuel"/>
  </label></td>
<!--Time<label id="dtimes" name="dtimes">
      <s:property value="dtimes"/>
    </label>
--></tr>
<tr>
  <td align="left">Driven By</td>
  <td colspan="3" align="left">:&nbsp;
    <label id="lbldrivenby" name="lbldrivenby">
      <s:property value="lbldrivenby"/>
    </label></td>
  <td align="left">Replaced</td>
  <td align="left">:&nbsp;
    <label id="replaced" name="replaced">
      <s:property value="replaced"/>
    </label></td>
</tr>
<tr>
<td align="left">Description</td><td colspan="3" align="left">:&nbsp;
  <label id="lbldescription" name="lbldescription">
    <s:property value="lbldescription"/>
  </label></td>
<td align="left">Reason</td>
<td align="left">:&nbsp;
  <label id="invehreason" name="invehreason">
    <s:property value="invehreason"/>
  </label></td>
</tr>

</table>
</td>
</tr>
</table>
</fieldset>
<br>
<fieldset><legend><b>Vehicle In Details</b></legend>
<table width="100%">
  <tr>
    <td width="8%">Branch</td>
    <td width="16%">:&nbsp;
            <label id="inbrwithcompany" name="inbrwithcompany">
              <s:property value="inbrwithcompany"/>
            </label></td>
    <td width="4%">Location</td>
    <td width="19%">:&nbsp;
      <label id="lblinlocation" name="lblinlocation">
        <s:property value="lblinlocation"/>
      </label></td>
    <td width="53%" rowspan="5"><img src="<%=contextPath%>/icons/replacevehicle.jpg" width="100%" height="33%" alt=""/></td>
    </tr>
  <tr>
    <td>Fleet No</td>
    <td colspan="3">:&nbsp;
      <label id="colfleet" name="colfleet">
        <s:property value="colfleet"/>
        </label>
      &nbsp;&nbsp;
      <label id="lblcolfleetname" name="lblcolfleetname">
        <s:property value="lblcolfleetname"/>
</label></td>
    </tr>
  <tr>
    <td>Reg No</td>
    <td >:&nbsp;
      <label id="colregno" name="colregno">
        <s:property value="colregno"/>
      </label></td>
    <td>Driver</td>
    <td>:&nbsp;
      <label id="lblcoldriver" name="lblcoldriver">
        <s:property value="lblcoldriver"/>
      </label></td>
    </tr>
  <tr>
    <td height="123" colspan="2"><fieldset>
      <legend>Collected - Client</legend>
      <table width="99%">
        <tr>
          <td width="25%">Date</td>
          <td width="75%">:&nbsp;
            <label id="coldate" name="coldate">
              <s:property value="coldate"/>
              </label></td>
        </tr>
        <tr>
          <td>Time</td>
          <td>:&nbsp;
            <label id="coltime" name="coltime">
              <s:property value="coltime"/>
            </label></td>
        </tr>
        <tr>
          <td>KM</td>
          <td>:&nbsp;
            <label id="colkm" name="colkm">
              <s:property value="colkm"/>
            </label></td>
        </tr>
        <tr>
          <td>Fuel</td>
          <td>:&nbsp;
            <label id="colfuel" name="colfuel">
              <s:property value="colfuel"/>
            </label></td>
        </tr>
      </table>
    </fieldset></td>
    <td colspan="2"><fieldset>
      <legend>Recieved-Branch</legend>
      <table width="100%">
        <tr>
          <td width="20%">Date</td>
          <td width="80%">:&nbsp;
            <label id="invehdate" name="invehdate">
              <s:property value="invehdate"/>
              </label></td>
        </tr>
        <tr>
          <td>Time</td>
          <td>:&nbsp;
            <label id="invehtime" name="invehtime">
              <s:property value="invehtime"/>
              </label></td>
          </tr>
        <tr>
          <td>KM</td>
          <td>:&nbsp;
            <label id="invehkm" name="invehkm">
              <s:property value="invehkm"/>
              </label></td>
          </tr>
        <tr>
          <td>Fuel</td>
          <td>:&nbsp;
            <label id="invehfuel" name="invehfuel">
              <s:property value="invehfuel"/>
              </label></td>
          </tr>
        </table>
    </fieldset></td>
    </tr>
</table>

</fieldset>
<br>
<fieldset><legend>Vehicle Out Details</legend>
<table width="100%">
  <tr>
    <td width="8%">Branch</td>
    <td width="16%">:&nbsp;
                  <label id="delbrwithcompany" name="delbrwithcompany">
                    <s:property value="delbrwithcompany"/>
            </label></td>
    <td width="5%">Location</td>
    <td width="18%">:&nbsp;
      <label id="lbloutlocation" name="lbloutlocation">
        <s:property value="lbloutlocation"/>
      </label></td>
    <td width="53%" rowspan="5"><img src="<%=contextPath%>/icons/replacevehicle.jpg" width="100%" height="33%"  alt=""/></td>
    </tr>
  <tr>
    <td>Fleet No</td>
    <td colspan="3">:&nbsp;
      <label id="delfleet" name="delfleet">
        <s:property value="delfleet"/>
        </label>
      &nbsp;&nbsp;
      <label id="lbldelfleetname" name="lbldelfleetname">
        <s:property value="lbldelfleetname"/>
</label></td>
    </tr>
  <tr>
    <td>Reg No</td>
    <td>:&nbsp;
      <label id="delregno" name="delregno">
        <s:property value="delregno"/>
      </label></td>
    <td>Driver</td>
    <td>:&nbsp;
      <label id="lbldeldriver" name="lbldeldriver">
        <s:property value="lbldeldriver"/>
      </label></td>
    </tr>
  <tr>
    <td height="121" colspan="2"><fieldset>
        <legend>Delivery -Branch</legend><table width="118%">
      <tr>
        <td width="29%">Date</td>
        <td width="71%">:&nbsp;
          <label id="newvehoutdate" name="newvehoutdate">
            <s:property value="newvehoutdate"/>
            </label></td>
      </tr>
      <tr>
        <td>Time</td>
        <td>:&nbsp;
          <label id="newvehouttime" name="newvehouttime">
            <s:property value="newvehouttime"/>
          </label></td>
      </tr>
      <tr>
        <td>KM</td>
        <td>:&nbsp;
          <label id="newvehkm" name="newvehkm">
            <s:property value="newvehkm"/>
          </label></td>
      </tr>
      <tr>
        <td>Fuel</td>
        <td>:&nbsp;
          <label id="newvehfuel" name="newvehfuel">
            <s:property value="newvehfuel"/>
          </label></td>
      </tr>
    </table></fieldset></td>
    <td colspan="2"><fieldset>
      <legend>Delivered - Client</legend>
      <table width="100%">
        <tr>
          <td width="21%">Date</td>
          <td width="79%">:&nbsp;
            <label id="deldate" name="deldate">
              <s:property value="deldate"/>
              </label></td>
        </tr>
        <tr>
          <td>Time</td>
          <td>:&nbsp;
            <label id="deltime" name="deltime">
              <s:property value="deltime"/>
              </label></td>
          </tr>
        <tr>
          <td>KM</td>
          <td>:&nbsp;
            <label id="delkm" name="delkm">
              <s:property value="delkm"/>
              </label></td>
          </tr>
        <tr>
          <td>Fuel</td>
          <td>:&nbsp;
            <label id="delfuel" name="delfuel">
              <s:property value="delfuel"/>
              </label></td>
          </tr>
        </table>
    </fieldset></td>
    </tr>
</table>
</fieldset>

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
 <div id="footerstyle" style="width:135%;bottom: 0;font-size: 8px;">
<table>
 <tr>
     <td colspan="3" align="center"><fieldset><font style="color: #D8D8D8;font-size: 11px;">System Generated Document Signature & Stamp Not Required.</font></fieldset></td>
  </tr>
  <tr>
  <td width="47%" style="color: #D8D8D8;" align="left"><i>Printed by <%=session.getAttribute("USERNAME")%> 
  <label id="lblfooter"></label></i></td>
  
  <td width="43%" style="color: #FAFAFA;" align="left">Powered by GATEWAY ERP</td>
  
 <td width="10%" style="color: #D8D8D8;">
    <div id="content"> 
  <div id="pageFooter"></div>
   </div>  
  </td>
  </tr>
</table>
</div>
</div>
<!--<table style="width:100vw;"><tr><td><jsp:include page="../../../common/printFooter.jsp"></jsp:include></td></tr></table>-->

 </body>
</html>
