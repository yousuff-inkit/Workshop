<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../includes.jsp"></jsp:include>
</head>
<body>
<div id="mainBG" class="homeContent" data-type="background">
<%@include file="../../../header.jsp" %><br/>
<fieldset><legend>Maintenance Update Info</legend>
<table width="100%">
  <tr>
    <td width="10%"><div align="right">Date</div></td>
    <td colspan="2"><div align="left"><sj:datepicker value="today" id="date1" name="date1" displayFormat="dd.mm.yy" label="Today" /></div></td>
    <td width="12%"><div align="right"></div></td>
    <td><div align="right">Entry Type</div></td>
    <td><div align="left">
      <select name="cmbentrytype" required="required">
        <option value="-1">--Select--</option>
      </select>
    </div></td>
    <td><div align="right">Doc No</div></td>
    <td width="9%"><input type="text" name="docno"></td>
    <td width="14%">&nbsp;</td>
  </tr>
  <tr>
    <td><div align="right">Fleet No</div></td>
    <td width="7%"><select name="cmbfleetno" required="required">
      <option value="-1">--Select--</option>
    </select></td>
    <td colspan="2"><input type="text" name="fleetname" required="required" style="width:99%;"></td>
    <td width="12%"><div align="right">Job No</div></td>
    <td width="14%"><input type="text" name="jobno" required="required"></td>
    <td width="9%"><div align="right">JV No</div></td>
    <td><input type="text" name="jvno"></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><div align="right">Remarks</div></td>
    <td colspan="7"><textarea name="remarks" style="width:99%;"></textarea></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td><div align="right">Net Total</div></td>
    <td><input type="text" name="total"></td>
    <td>&nbsp;</td>
  </tr>
</table>
</fieldset>
</div>
</body>
</html>