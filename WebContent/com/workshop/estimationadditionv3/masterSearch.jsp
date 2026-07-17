<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<script>
	$(document).ready(function(e) {
		$("#msearchdate").jqxDateTimeInput({  width:'125px',height : '15px', formatString : "dd.MM.yyyy",value:null });
        $('#btnmastersearch').click(function(e) {
            var branch=$('#brchName').val();
			var docno=$('#msearchdocno').val();
			var date=$('#msearchdate').jqxDateTimeInput('val');
			var gatevocno=$('#msearchgatevocno').val();
			var cldocno=$('#msearchcldocno').val();
			var clientname=$('#msearchclientname').val();
			var regno=$('#msearchregno').val();
			$('#mastersearchdiv').load('masterSearchGrid.jsp?branch='+branch+'&docno='+docno+'&date='+date+'&gatevocno='+gatevocno+'&cldocno='+cldocno+'&clientname='+clientname+'&id=1&regno='+regno);
        });
    });
</script>
</head>
<body>
<table width="100%" border="0">
  <tr>
    <td  align="right">Doc No</td>
    <td ><input type="text" name="msearchdocno" id="msearchdocno"></td>
    <td align="right">Date</td>
    <td ><div id="msearchdate"></div></td>
    <td align="right">GIP#</td>
    <td ><input type="text" name="msearchgatevocno" id="msearchgatevocno"></td>
    <td align="right">Reg No</td>
    <td ><input type="text" name="msearchregno" id="msearchregno"></td>
    
  </tr>
  <tr>
    <td align="right">Client</td>
    <td><input type="text" name="msearchcldocno" id="msearchcldocno"></td>
    <td colspan="5"><input type="text" name="msearchclientname" id="msearchclientname" style="width:99%;"></td>
    <td align="center"><button type="button" name="btnmastersearch" id="btnmastersearch" class="myButton">Search</button></td>
    
  </tr>
  <tr>
    <td colspan="8"><div id="mastersearchdiv"><jsp:include page="masterSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</body>
</html>