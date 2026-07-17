<link href="../../../../css/body.css" media="screen" rel="stylesheet" type="text/css" />  
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<script type="text/javascript">
	$(document).ready(function(e) {
		$("#searchagmtdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
        $('.branch').css('background-color','transparent');
        $('input[type=text]').css('height','18px');
		$('#btnagmtsearch').click(function(e) {
            var docno=$('#searchagmtno').val();
			var client=$('#searchagmtclient').val();
			var date=$('#searchagmtdate').jqxDateTimeInput('val');
			var fleetno=$('#searchagmtfleetno').val();
			var regno=$('#searchagmtregno').val();
			var mobile=$('#searchagmtmobile').val();
			var branch=$('#cmbbranch').val();
			$('#agmtsearchdiv').load('agmtSearchGrid.jsp?docno='+docno+'&client='+client.replace(/ /g, "%20")+'&date='+date+'&fleetno='+fleetno+'&regno='+regno+'&mobile='+mobile+'&branch='+branch+'&id=1');
        });
    });
</script>
</head>
<body>
<table width="100%" border="0">
  <tr>
    <td width="8%"><label class="branch" >Doc No</label></td>
    <td width="15%"><input type="text" name="searchagmtno" id="searchagmtno"></td>
    <td width="11%"><label class="branch">Date</label></td>
    <td width="21%"><div name="searchagmtdate" id="searchagmtdate"></div></td>
    <td width="10%"><label class="branch">Client</label></td>
    <td colspan="2"><input type="text" name="searchagmtclient" id="searchagmtclient" style="width:99%;"></td>
  </tr>
  <tr>
    <td><label class="branch">Fleet No</label></td>
    <td><input type="text" name="searchagmtfleetno" id="searchagmtfleetno"></td>
    <td><label class="branch">Reg No</label></td>
    <td><input type="text" name="searchagmtregno" id="searchagmtregno"></td>
    <td><label class="branch">Mobile</label></td>
    <td width="17%"><input type="text" name="searchagmtmobile" id="searchagmtmobile"></td>
    <td width="18%" align="center"><button type="button" id="btnagmtsearch" name="btnagmtsearch" class="myButton">Search</button></td>
  </tr>
  <tr>
    <td colspan="7"><div id="agmtsearchdiv"><jsp:include page="agmtSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</body>
</html>