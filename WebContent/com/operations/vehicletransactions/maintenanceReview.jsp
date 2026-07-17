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

<fieldset><legend>Maintenance Review Info</legend>
<table width="100%">
  <tr>
    <td width="8%">&nbsp;</td>
    <td colspan="4">&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td><div align="right">Reg No</div></td>
    <td colspan="2"><span class="homeContent">
      <input type="text" name="regno">
    </span></td>
  </tr>
  <tr>
    <td><div align="right">Fleet No</div></td>
    <td><span class="homeContent">
      <select name="cmbfleetno" required="required">
        <option value="-1">--Select--</option>
      </select>
    </span></td>
    <td><span class="homeContent">
      <input type="text" name="fleetname" style="width:99%;">
    </span></td>
    <td><div align="right">Brand</div></td>
    <td><span class="homeContent">
      <input type="text" name="brand">
    </span></td>
    <td><div align="right">Model</div></td>
    <td><span class="homeContent">
      <input type="text" name="model">
    </span></td>
    <td><div align="right">YoM</div></td>
    <td colspan="2"><span class="homeContent">
      <input type="text" name="yom">
    </span></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td width="8%">&nbsp;</td>
    <td width="18%">&nbsp;</td>
    <td width="4%">&nbsp;</td>
    <td width="11%">&nbsp;</td>
    <td width="5%">&nbsp;</td>
    <td width="11%">&nbsp;</td>
    <td width="5%">&nbsp;</td>
    <td width="17%"><div align="right">Net Total</div></td>
    <td width="13%"><span class="homeContent">
      <input type="text" name="nettotal">
    </span></td>
  </tr>
</table>
</fieldset>
</div>
</body>
</html>