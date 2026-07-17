<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<style>
.lblfields,.repheading{
font:13px Tahoma;
	color: #404040;
}
 @media print{
	 @page {
		size: landscape
		}
		} 
		.repheading{
font-weight: bold;
}
tr.border_bottom td {
  border-bottom:1px solid black;
  border-left:1px solid black;
}
tr.border_top td {
  border-top:1px solid black;
}
table{
border-collapse: collapse;
} 



/*  body{
background:#fff;
}
.lblfields,.repheading{
font: 10px Tahoma;
	color: #404040;
}
.repheading{
font-weight: bold;
}
tr.border_bottom td {
  border-bottom:1px solid black;
  border-left:1px solid black;
}
tr.border_top td {
  border-top:1px solid black;
}
table{
border-collapse: collapse;
}  */
/* @media print{
	/* @page {
		size: landscape
		} 
		.lblfields,.repheading{
	font: 12px Tahoma;
	}
	} */
</style>
</head>
<body bgcolor="white">
<form action="repListPrintAction" id="frmRepListPrint"  target="_blank">
<%-- <jsp:include page="../../../common/printHeader.jsp"></jsp:include> --%>
 <table width="100%">
  <tr>  
    <td width="18%" rowspan="6"><img src="<%=contextPath%>/icons/epic.jpg" width="100" height="91"  alt=""/></td>
    <td width="57%" rowspan="2">&nbsp;</td>
    <td width="25%"><font size="3"><label id="lblcompname" name="lblcompname" ><s:property value="lblcompname"/></label></font></td>
  </tr>
  <tr>
    <td><b><label id="lblcompaddress" name="lblcompaddress"><s:property value="lblcompaddress"/></label></b></td>
  </tr>
  <tr>
    <td rowspan="2"  align="center"><b><font size="3"><label id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label></font></b></td>
    <td align="left"><b>Tel :</b>&nbsp;<label id="lblcomptel" name="lblcomptel"><s:property value="lblcomptel"/></label></td>
  </tr>
  <tr>
    <td align="left"><b>Fax :</b>&nbsp;<label name="lblcompfax" id="lblcompfax" ><s:property value="lblcompfax"/></label></td>
  </tr>
  <tr>
    <td rowspan="2">&nbsp;</td>
    <td align="left"><b>Branch :</b>&nbsp;<label id="lblbranch" name="lblbranch" ><s:property value="lblbranch"/></label></td>
  </tr>
  <tr>
    <td align="left"><b>Location :</b>&nbsp;<label id="lbllocation" name="lbllocation" ><s:property value="lbllocation"/></label></td>
  </tr>
  <tr>
    <td colspan="3"><hr noshade size=1 width="100%"></td>
  </tr>
   <tr>
    <td colspan="3"></td></tr></table>
<table width="100%" >
  <tr class="border_bottom border_top">
    <td width="6%" rowspan="2"><label class="repheading">Rep No</label></td>
    <td width="8%" rowspan="2"><label class="repheading">Rep Reason</label></td>
    <td width="7%" rowspan="2"><label class="repheading">Rep Type</label></td>
    <td width="7%" rowspan="2"><label class="repheading">Agmt No</label></td>
    <td width="7%" rowspan="2"><label class="repheading">Agmt Type</label></td>
    <td colspan="6" align="center"><label class="repheading">Out Fleet Details</label></td>
    <td colspan="6" align="center" style="border-right:1px solid black;"><label class="repheading">In Fleet Details</label></td>
  </tr>
  <tr class="border_bottom">
    <td width="6%"><label class="repheading">Fleet</label></td>
    <td width="5%"><label class="repheading">Reg No</label></td>
    <td width="6%"><label class="repheading">Date</label></td>
    <td width="5%"><label class="repheading">Time</label></td>
    <td width="6%"><label class="repheading">KM</label></td>
    <td width="6%"><label class="repheading">Fuel</label></td>
    <td width="5%"><label class="repheading">Fleet</label></td>
    <td width="6%"><label class="repheading">Reg No</label></td>
    <td width="6%"><label class="repheading">Date</label></td>
    <td width="5%"><label class="repheading">Time</label></td>
    <td width="4%"><label class="repheading">KM</label></td>
    <td width="5%" style="border-right:1px solid black;"><label class="repheading">Fuel</label></td>
  </tr>
   <s:iterator var="stat1" status="arr" value="%{#request.REPPRINT}" >
		<s:iterator status="arr" value="#stat1" var="stat">    
			<tr >
				<s:iterator status="arr" value="#stat.split('::')" var="des">
  					<td >
  						<label class="lblfields"><s:property value="#des"/></label>
  					</td>
 				</s:iterator>
			</tr>
		</s:iterator>
	</s:iterator>
</table>
</form>
</body>
</html> 