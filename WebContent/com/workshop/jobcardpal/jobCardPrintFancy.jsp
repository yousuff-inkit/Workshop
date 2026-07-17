
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
 <link rel="stylesheet" type="text/css" href="../../../css/body.css">
   <jsp:include page="../../../includes.jsp"></jsp:include>  
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
<body bgcolor="white" style="background-color:#fff !important;font-size:12px;">
<form>
 <div style="background-color:#fff !important;">
 <jsp:include page="../../common/printHeader1.jsp"></jsp:include>
 <br><br><br><br><br><br><br><br>
<table width="100%" border="0">
  <tr>
    <td width="7%">Date</td>
    <td width="20%" align=""><label name="lbldate"><s:property value="lbldate"/>
      </label></td>
    <td width="12%">Ref Type</td>
    <td width="14%"><label name="lblreftype"><s:property value="lblreftype"/>
      </label></td>
    <td width="10%">Ref No</td>
    <td width="14%"><label name="lblrefvocno"><s:property value="lblrefvocno"/>
      </label></td>
    <td width="11%">Job Card No</td>
    <td width="12%"><label name="lblvocno"><s:property value="lblvocno"/></label></td>
  </tr>
  <tr>
    <td colspan="9">
    	<table width="100%">
        	<tr>
            	<td width="50%"><fieldset><legend>Client Details</legend>
    		
          <table width="100%" border="0">
            <tr>
              <td width="20%">Client No</td>
              <td width="15%"><label name="lblcldocno"><s:property value="lblcldocno"/></label></td>
              <td>Name</td>
              <td colspan="2"><label name="lblclientname"><s:property value="lblclientname"/></label></td>
            </tr>
            <tr>
              <td>Address</td>
              <td colspan="4"><label name="lblclientaddress"><s:property value="lblclientaddress"/></label></td>
            </tr>
            <tr>
              <td>Mobile</td>
              <td colspan="2"><label name="lblclientmobile"><s:property value="lblclientmobile"/></label></td>
              <td width="13%">Email</td>
              <td width="37%"><label name="lblclientemail"><s:property value="lblclientemail"/></label></td>
            </tr>
            <tr>
            	<td>Service Advisor</td>
            	<td colspan="2"><label name="lblserviceadvisor"><s:property value="lblserviceadvisor"/></label></td>
            </tr>
            <tr>
            	<br>
            </tr>
          </table>
    	</fieldset></td>
    	    <td colspan="9">
            	<td width="50%"><fieldset><legend>Vehicle Details</legend>
        	<table width="100%" border="0">
  <tr>
    <td width="21%">Reg No</td>
    <td width="30%"><label name="lblplatecode"><s:property value="lblplatecode"/></label>-<label name="lblregno"><s:property value="lblregno"/></label></td>
    <td width="21%">Mileage</td>
    <td width="28%"><label name="lblmileage"><s:property value="lblmileage"/></label></td>
  </tr>
  <tr>
    <td>Brand</td>
    <td><label name="lblbrand"><s:property value="lblbrand"/></label></td>
    <td>Model</td>
    <td><label name="lblmodel"><s:property value="lblmodel"/></label></td>
  </tr>
  <tr>
    <td>Chassis No</td>
    <td><label name="lblchassis"><s:property value="lblchassis"/></label></td>
    <td>Yom</td>
    <td><label name="lblyom"><s:property value="lblyom"/></label></td>
  </tr>
    <tr>
    <td>Color</td>
    <td><label name="lblcolor"><s:property value="lblcolor"/></label></td>
    <td>GIP Date</td>
    <td><label name="gipdate"><s:property value="gipdate"/></label></td>
  </tr>
  <tr>
    <td>Promise Date</td>
    <td><label name="promdate"><s:property value="promdate"/></label></td>
	<td>GIP No</td>
    <td><label name="lblgipno"><s:property value="lblgipno"/></label></td>
    </tr>
</table>

        </fieldset></td>
            </tr>
        </table>
    </td></tr>
    	
  <tr>
    <td colspan="8">
    	<fieldset>
        	<legend><b>Services</b></legend>
            <table width="100%">
            	<tr>
            		<td width="10%"><b>Sr No</b></td>
            		<td width="20%"><b>Job Type</b></td>
            		<td width="30%"><b>Job Desc</b></td>
            		<td width="40%"><b>Remarks</b></td>
            	</tr>
        		<s:iterator var="statsalik" status="arr" value='#request.SERVICEPRINT' >
					<s:iterator status="arr" value="#statsalik" var="statsalik2"> 
						<tr class=" ">
 							<s:iterator status="arr" value="#statsalik2.split('::')" var="dessalik"> 
  								<td class=" "><s:property value="#dessalik"/></td>
  							</s:iterator>
  						</tr>	
  					</s:iterator>
  				</s:iterator>
        	</table>
        </fieldset>
    </td>
  </tr>
  <tr>
    <td colspan="8">
    	<fieldset>
        	<legend><b>Spare Parts</b></legend>
            <table width="100%">
            	<tr>
            		<td width="10%"><b>Sr No</b></td>
            		<td width="40%"><b>Description</b></td>
            		<td width="10%"><b>Qty</b></td>
            		<td width="40%"><b>Remarks</b></td>
            	</tr>
        		<s:iterator var="statsalik" status="arr" value='#request.PARTPRINT' >
					<s:iterator status="arr" value="#statsalik" var="statsalik2"> 
						<tr class=" ">
 							<s:iterator status="arr" value="#statsalik2.split('::')" var="dessalik"> 
  								<td class=" "><s:property value="#dessalik"/></td>
  							</s:iterator>
  						</tr>	
  					</s:iterator>
  				</s:iterator>
        	</table>
        </fieldset>
    </td>
  </tr>
  <tr>
    <td colspan="8">
    	<fieldset>
        	<legend><b>Complaints</b></legend>
			<table width="100%">
            	<tr>
            		<td width="10%"><b>Sr No</b></td>
            		<td width="45%"><b>Complaint</b></td>
            		<td width="45%"><b>Description</b></td>
            	</tr>
        		<s:iterator var="statsalik" status="arr" value='#request.COMPLAINTPRINT' >
					<s:iterator status="arr" value="#statsalik" var="statsalik2"> 
						<tr class=" ">
 							<s:iterator status="arr" value="#statsalik2.split('::')" var="dessalik"> 
  								<td class=" "><s:property value="#dessalik"/></td>
  							</s:iterator>
  						</tr>	
  					</s:iterator>
  				</s:iterator>
        	</table>
        </fieldset>
    </td>
  </tr>
  <tr>
    <td colspan="8" >
    	<fieldset>
        	<legend><b>Last Visited</b></legend>
            <table width="100%">
        		<tr><td width="10%"><b>Sr No</b></td><td width="30%"><b>Ref No</b></td><td width="60%"><b>Description</b></td></tr>
        		<s:iterator var="statsalik" status="arr" value='#request.VISITPRINT' >
					<s:iterator status="arr" value="#statsalik" var="statsalik2"> 
						<tr class="">
 							<s:iterator status="arr" value="#statsalik2.split('::')" var="dessalik"> 
  								<td class=" "><s:property value="#dessalik"/></td>
  							</s:iterator>
  						</tr>	
  					</s:iterator>
  				</s:iterator>
        	</table>
        </fieldset>
    </td>
  </tr>
<tr>
<td colspan="8" >
    	<table width="100%">   
    	<br>
    	<br>
        		<tr><td width="10%"><b>Job Card Printed By :</b>
        		<label id="lbluser" name="lbluser"><s:property value="lbluser"/></label></td>
        		</tr>
        		<tr><td width="10%"><b>Print Date :</b>
        		<label id="lbldates" name="lbldates"><s:property value="lbldates"/></label></td>
        		</tr>
</table>
</td>
</tr></table>
</div>
</form>
</body>

</html>