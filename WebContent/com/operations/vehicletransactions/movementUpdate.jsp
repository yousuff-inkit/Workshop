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

<fieldset><legend>Movement Update</legend>
<table width="100%" >
  <tr>
    <td width="10%"><div align="right">From Date</div></td>
    <td width="16%"><sj:datepicker value="today" id="frmdate" name="frmdate" displayFormat="dd.mm.yy" label="Today" /></td>
    <td width="11%"><div align="right">To Date</div></td>
    <td colspan="2"><sj:datepicker value="today" id="todate" name="todate" displayFormat="dd.mm.yy" label="Today" /></td>
  </tr>
  <tr>
    <td><div align="right">Fleet No</div></td>
    <td colspan="2"><div align="left"><span class="homeContent">
      <select name="cmbfleetno">
        <option value="-1">--Select--</option>
      </select>
      </span><span class="homeContent">
        <input type="text" name="fleetname" style="width:70%;">
      </span></div></td>
    <td width="8%"><span class="homeContent">
      <input type="button" name="btshow" value="Show" class="myButton">
    </span></td>
    <td width="55%"><span class="homeContent">
      <input type="button" name="btnupdate" value="Update" class="myButton">
    </span></td>
  </tr>
</table>
</fieldset>
</div>
</body>
</html>
