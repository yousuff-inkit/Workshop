
<%@page import="javax.servlet.http.HttpSession.*"%>
<%@page import="javax.servlet.http.HttpServletRequest.*"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <link rel="stylesheet" type="text/css" href="../../../../css/body.css">
 <jsp:include page="../../../../includes.jsp"></jsp:include>  
<style media="print">
 .hidden-scrollbar {
  overflow: auto;
  height: 800px;
} 
 fieldSet {
  -webkit-border-radius: 8px;
  -moz-border-radius: 8px;
  border-radius: 8px;
  border: 1px solid rgb(139,136,120);

 }
 .saliktable{
 border:1px solid;
 border-collapse:collapse;

 }
 
 table:last-of-type {
    page-break-after: auto
}



#pageFooter {
    display: table-footer-group;
}

#pageFooter:after {
      counter-increment: page;
      counter-reset: pages 1;
      content: "Page " counter(page) " / " counter(pages);
}
       
  /* /* tr.saliktable:nth-child(even) {background: #fff } 
tr.saliktable:nth-child(odd) {background: #fdf5e6} */ */
/* #salikdiv{
break-before: always;
}  */
/* div.salikdiv
      {
        page-break-after: always;
        page-break-inside: avoid;
      } */
</style> 

</head>
<body onload="" bgcolor="white"  style="font-size:12px;background:#fff;">
<div id="mainBG" class="homeContent" data-type="background">
 <div style="background-color:white !important;">
 <jsp:include page="../../../common/printHeaderCarfareWorkshop.jsp"></jsp:include> 
<fieldset>
<table width="100%">
  <tr>
    <td width="16%" align="left">Customer  </td>
    <td colspan="3">: <label id="lblclient" name="lblclient"><s:property value="lblclient"/></label></td>
    <td width="18%" align="left">Job Card No </td>
    <td width="20%"> : <label name="lblinvno" id="lblinvno" ><s:property value="lblinvno"/></label></td>
  </tr>
  <tr>
    <td align="left">Address</td>
    <td colspan="3">: <label id="lbladdress" name="lbladdress" ><s:property value="lbladdress"/></label></td>
    <td align="left">Date </td>
    <td>: <label name="lbldate" id="lbldate" ><s:property value="lbldate"/></label></td>
  </tr>
  <tr>
    <td align="left">Mobile</td>
    <td width="19%">: <label name="lblmobile" id="lblmobile" ><s:property value="lblmobile"/></label></td>
    <td width="6%">Email</td>
    <td width="21%">: <label name="lblemail" id="lblemail" ><s:property value="lblemail"/></label></td>
    <td align="left">Ref No </td>
    <td>: <label name="lblrefno" id="lblrefno" ><s:property value="lblrefno"/></label></td>
  </tr>
  <tr>
    <td align="left">TRN</td>
    <td colspan="3">: <label name="lblclienttrn" id="lblclienttrn" ><s:property value="lblclienttrn"/></label></td>
    <td align="left">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="left">Vehicle</td>
    <td colspan="5">: <label name="lblvehicle" id="lblvehicle" ><s:property value="lblvehicle"/></label></td>
    </tr>
  <tr>
    <td align="left">Chassis No</td>
    <td colspan="3">: <label name="lblchassis" id="lblchassis" ><s:property value="lblchassis"/></label></td>
    <td align="left">&nbsp;</td>
    <td></td>
  </tr> 
</table>
</fieldset>
<br>
<hr>

<table width="100%">
<tr>
    <td align="left">SI No</td>
    <td align="left">Job Type</td>
    <td align="left">Job Description</td>
    <td align="right">Amount</td>
  </tr>
 <s:set name="counter" value="0"></s:set>
 <s:iterator var="stat1" status="arr" value="%{#request.LABOURPRINT}" >
 	<s:iterator status="arr" value="#stat1" var="stat">
		<tr>   
	    	<s:iterator status="arr" value="#stat.split('::')" var="des">
	    		<s:if test="#arr.index>2">
	    			<td  align="right">
						<s:property value="#des"/>
					</td>
	    		</s:if>
  				<s:else>
  					<s:if test="#counter==#request.LABOURPRINT.size-1 && #arr.index==2">
  						<td  align="right">
		  					<s:property value="#des"/>
		  				</td>	
  					</s:if>
  					<s:else>
  						<td  align="left">
		  					<s:property value="#des"/>
		  				</td>
  					</s:else>
  					
  				</s:else>
			</s:iterator>
		</tr>
	</s:iterator>
	<s:set name="counter" value="%{#counter+1}" />
</s:iterator>
</table>
<hr>
<table width="100%">
<tr>
    <td align="left">SI No</td>
    <td align="left">Part Name</td>
    <td align="left">Qty</td>
    <td align="right">Rate</td>
    <td align="right">Total</td>
  </tr>
 <s:iterator var="stat1" status="arr" value="%{#request.PARTSPRINT}" >
 	<s:iterator status="arr" value="#stat1" var="stat">
 		
		<tr>   
	    	<s:iterator status="arr" value="#stat.split('::')" var="des">
	    		<s:if test="#arr.index>2">
	    			<td  align="right">
						<s:property value="#des"/>
					</td>
	    		</s:if>
  				<s:else>
  					<td  align="left">
	  					<s:property value="#des"/>
	  				</td>
  				</s:else>
			</s:iterator>
		</tr>
	</s:iterator>
</s:iterator>
</table>
<hr>
<table width="100%" >
  <tr>
    <td width="197" align="left">Total :</td>
    <td width="752">&nbsp;</td>
    <td width="163">&nbsp;</td>
    <td width="146" align="right"><b><label id="lbltotal" name="lbltotal"><s:property value="lbltotal"/></label></b></td>
  </tr>
  <tr>
    <td width="197" align="left">Tax :</td>
    <td width="752">&nbsp;</td>
    <td width="163">&nbsp;</td>
    <td width="146" align="right"><b><label id="lbltax" name="lbltax"><s:property value="lbltax"/></label></b></td>
  </tr>
  <tr>
    <td width="197" align="left">Round Off :</td>
    <td width="752">&nbsp;</td>
    <td width="163">&nbsp;</td>
    <td width="146" align="right"><b><label id="lblroundoff" name="lblroundoff"><s:property value="lblroundoff"/></label></b></td>
  </tr>
  <tr>
    <td align="left"><b>Net Amount :</b></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td align="right"><b><label id="lblnetamount" name="lblnetamount"><s:property value="lblnetamount"/></label><b></td>
  </tr>
  <tr>
    <td align="left"><b>Amount In Words : </b></td>
    <td colspan="3" align="right"><b><label id="lblamountwords" name="lblamountwords"><s:property value="lblamountwords"/></label></b></td>
    </tr>
</table>
<hr>
<div id="bottompage">
<table width="100%" >
  <tr>
    <td width="13%">Processed By</td>
    <td width="20%"><label id="lblcheckedby" name="lblcheckedby"><s:property value="lblcheckedby"/></label></td>
    <td width="13%">Received By</td>
    <td width="29%"><label id="lblrecievedby" name="lblrecievedby"><s:property value="lblrecievedby"/></label></td>
    <td width="4%">Date</td>
    <td width="21%"><label id="lblfinaldate" name="lblfinaldate"><s:property value="lblfinaldate"/></label></td>
   
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    
    </tr>
</table>
</div>
<br/><br/><br/><br/><br/><br/>
<div class="divFooter">
 
<table width="100%">

 <tr>
     <td colspan="3" align="center"><fieldset><font style="color: #D8D8D8;font-size: 11px;">System Generated Document Signature & Stamp Not Required.</font></fieldset></td>
  </tr>
  <tr>
  <td width="47%" style="color: #D8D8D8;" align="left"><i>Printed by <%=session.getAttribute("USERNAME")%> 
  <label id="lblfooter"></label></i></td>
  
  <td width="43%" style="color: #FAFAFA;" align="left">Powered by GATEWAY ERP</td>
  
 <td width="10%" style="color: #D8D8D8;">   
    <!-- <div id="content"> 
  <div id="pageFooter"></div>
   </div>   -->
  </td>
  </tr>
</table>
</div>
</div>
</body>
</html>
