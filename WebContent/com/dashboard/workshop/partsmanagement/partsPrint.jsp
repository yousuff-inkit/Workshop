
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
 <link href="../../../../css/css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
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
<body bgcolor="white" style="background-color:#fff !important;font-size:12px;">
 <div style="background-color:#fff !important;">
<table width="100%">
	<tr>
		<td colspan="8"><jsp:include page="../../../../com/common/printHeader.jsp"></jsp:include></td>
	</tr>
	<tr>
	<td><b>Vehicle Details</b></td>
	<td colspan="7"><label name="lblvehdetails"><s:property value="lblvehdetails"/></label></td>
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
  
</table> 
</div>
</body>
</html>