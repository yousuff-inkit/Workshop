<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();
String outdate=request.getParameter("printdate");
String outtime=request.getParameter("printtime");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style type="text/css">
 body,label {
    font-size: 0.88em;
} 
.header{
	width:100%;
	height:120px;
	display:block;
}
table tr td,table{
	border-collapse:collapse;
	cell-spacing:0;
	cell-padding:0;
	/* border:1px solid #000;  */ 
}

</style>
</head>
<body>
<form id="frmInvoicePrint" action="printrental" autocomplete="off" target="_blank">
<div class="header"></div>
<table width="100%" border="0">
  <tr>
    <td width="23%" height="25" align="center"><label><s:property value="barnchval"/></label></td>
    <td width="58%" align="center">&nbsp;</td>
    <td width="19%" align="center"><label><s:property value="rentaldoc"/></label></td>
  </tr>
</table>
<table width="100%" border="0">
  <tr>
    <td width="67%"><table width="100%" border="0">
      <tr>
        <td width="22%" height="50">&nbsp;</td>
        <td colspan="3"><label><s:property value="clname"/></label></td>
        <td width="21%">&nbsp;</td>
      </tr>
      <tr>
        <td height="50">&nbsp;</td>
        <td colspan="3"><label><s:property value="radrname"/></label></td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td colspan="2">&nbsp;</td>
        <td colspan="2"><label><s:property value="claddress"/></label></td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td colspan="2"><label><s:property value="clmobno"/></label></td>
        <td width="21%">&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td colspan="2">&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td height="30" colspan="2"><label style="padding-left:20px;padding-top:10px;"><s:property value="radlno"/></label></td>
        <td width="17%"><label style="padding-top:10px;"><s:property value="lblissby"/></label></td>
        <td width="21%"><label style="padding-top:10px;"><s:property value="lblissfromdate"/></label></td>
        <td><label style="padding-top:10px;"><s:property value="licexpdate"/></label></td>
      </tr>
      <tr>
        <td height="30" colspan="2"><label style="padding-left:20px;padding-top:10px;"><s:property value="passno"/></label></td>
        <td>&nbsp;</td>
        <td><label><s:property value="passexpdate"/></label></td>
        <td><label><s:property value="dobdate"/></label></td>
      </tr>
      <tr>
        <td height="30" colspan="3"><label style="padding-left:50px;padding-top:10px;"><s:property value="lblnation"/></label></td>
        <td colspan="2">&nbsp;</td>
        </tr>
      <tr>
        <td height="30">&nbsp;</td>
        <td colspan="3"><label><s:property value="adddrname1"/></label></td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td height="30" colspan="2"><label><s:property value="addlicno1"/></label></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td><label><s:property value="expdate1"/></label></td>
      </tr>
    </table>
      <table width="100%" border="0">
        <tr>
          <td height="656">&nbsp;</td>
        </tr>
    </table></td>
    <td width="33%"><table width="100%" border="0">
      <tr>
        <td width="62%" height="50" valign="bottom"><label  style="padding-top:25px;margin-left:-30px;"><s:property value="ravehname"/></label></td>
        <td width="38%" valign="bottom"><label><s:property value="ravehregno"/></label></td>
      </tr>
      <tr>
        <td height="30"><label><s:property value="racolor"/></label></td>
        <td><label><s:property value="rayom"/></label></td>
      </tr>
      <tr>
        <td height="30"><label><s:property value="raklmout"/></label></td>
        <td><label><%=outdate%>&nbsp;<%=outtime%></label></td>
      </tr>
      <tr>
        <td height="30">&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td height="30">&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
    </table>
      <table width="100%" border="0">
        <tr>
          <td width="70%" height="25">&nbsp;</td>
          <td width="30%">
		  	<% if(request.getAttribute("rarenttypes").toString().equalsIgnoreCase("daily")){ %>
				<label><s:property value="tariff"/></label>
				
 			<%} %>
 			
 		</td>
        </tr>
        <tr>
          <td height="25">&nbsp;</td>
          <td><% if(request.getAttribute("rarenttypes").toString().equalsIgnoreCase("weekly")){ %>
				<label><s:property value="tariff"/></label>
 			<%} %>
 			
          </td>
        </tr>
        <tr>
          <td height="25">&nbsp;</td>
          <td>
          <% if(request.getAttribute("rarenttypes").toString().equalsIgnoreCase("monthly")){ %>
				<label><s:property value="tariff"/></label>
 			<%} %>
 			
          </td>
        </tr>
        <tr>
          <td height="20">&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="20">&nbsp;</td>
          <td><label><s:property value="laldelcharge"/></label></td>
        </tr>
        <tr>
          <td height="20">&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="20">&nbsp;</td>
          <td><label><s:property value="racdwscdw"/></label></td>
        </tr>
        <tr>
          <td height="20">&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="20">&nbsp;</td>
          <td><label><s:property value="raexxtakmchg"/></label></td>
        </tr>
        <tr>
          <td height="20">&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="20">&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="20">&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="20">&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="20">&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="20">&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="20">&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="199">&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="59">&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
    </table></td>
  </tr>
</table>
</form>
</body>
</html>