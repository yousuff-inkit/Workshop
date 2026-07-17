 <%@ page pageEncoding="utf-8" %>
 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript" src="../../../../js/jquery-1.11.1.min.js"></script> 
<style>
body{
overflow:hidden;
}
table{
border-collapse:collapse;
/* border:1px solid #000; */
border-radius:20px;
}
td{
cell-padding:0;
cell-spacing:0;
}
body{
background-color:#fff !important;
font-size:12px !important;
}

.bordertop{
	border-top:1px solid #000;
}
.borderbottom{
	border-bottom:1px solid #000;
}
.borderleft{
	border-left:1px solid #000;
}
.borderright{
	border-right:1px solid #000;
}
</style>
<%-- <script type="text/javascript">
$(document).ready(function(){
	 if($('.term').val()=='' || $('.term').text()==''){
		$('#termtable').hide();
	}
});
</script> --%>
</head>
<body>
<div style="width:100%;height:130px;"></div>

<table width="100%" >
  <tr>
    <td width="10%" height="23">&nbsp;</td>
    <td width="21%"><div align="center"></div></td>
    <td width="15%">&nbsp;</td>
    <td width="20%">&nbsp;</td>
    <td width="15%">&nbsp;</td>
    <td width="19%"> <div align="center"><label name="lblcosmoagmtno"><s:property value="lblcosmoagmtno"/></label></div></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2" rowspan="4"><label name="lblcosmoclientname"><s:property value="lblcosmoclientname"/>
    <br>
    <label name="lblcosmoclientaddress"><s:property value="lblcosmoclientaddress"/></label>
    <br>
    <label name="lblcosmoclientmobile"><s:property value="lblcosmoclientmobile"/></label>
    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td height="116">&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td height="62">&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td height="34">&nbsp;</td>
    <td colspan="2"><label name="lblcosmofleetno"><s:property value="lblcosmofleetno"/></label></td>
    <td><label name="lblcosmocolor"><s:property value="lblcosmocolor"/></label></td>
    <td>&nbsp;</td>
    <td><label name="lblcosmoengine"><s:property value="lblcosmoengine"/></label></td>
  </tr>
  <tr>
    <td height="23">&nbsp;</td>
    <td><div align="right"><label name="lblcosmoregdetails"><s:property value="lblcosmoregdetails"/></label></div></td>
    <td>&nbsp;</td>
    <td><label name="lblcosmochassis"><s:property value="lblcosmochassis"/></label></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td height="42">&nbsp;</td>
    <td><label name="lblcosmobrand"><s:property value="lblcosmobrand"/></label></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td height="23">&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td height="43">&nbsp;</td>
    <td><div align="right"><label name="lblcosmoduration" ><s:property value="lblcosmoduration"/></label></div></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2"><label  name="lblcosmostartdate"><s:property value="lblcosmostartdate"/></label></td>
  </tr>
  <tr>
    <td height="21">&nbsp;</td>
    <td><div align="center"><label name="lblcosmoenddate"><s:property value="lblcosmoenddate"/></label></div></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td height="43">&nbsp;</td>
    <td><label name="lblcosmoagreedrate"><s:property value="lblcosmoagreedrate"/></label></td>
    <td>&nbsp;</td>
    <td colspan="3"><label name="lblcosmoagreedratewords"><s:property value="lblcosmoagreedratewords"/></label></td>
  </tr>
  <tr>
    <td height="111">&nbsp;</td>
    <td colspan="2"><div align="center"><label name="lblcosmoexcessamt"><s:property value="lblcosmoexcessamt"/></label></div></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
</body>
</html>