<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<script>
	$(document).ready(function(e) {
		$("#msearchdate").jqxDateTimeInput({  width:'110px',height : '22px', formatString : "dd.MM.yyyy",value:null });
        $('#btnmastersearch').click(function(e) {
            var branch=$('#brchName').val();
			var docno=$('#msearchdocno').val();
			var date=$('#msearchdate').jqxDateTimeInput('val');
			var gatevocno="";
			var regno="";
			var cldet=$('#cldet').val();
			var vehdet=$('#vehdet').val();
			var brhid=$('#brchName').val();
			$('#mastersearchdiv').load('masterSearchGrid.jsp?branch='+branch+'&docno='+docno+'&date='+date+'&gatevocno='+gatevocno+'&cldet='+encodeURIComponent(cldet)+'&vehdet='+encodeURIComponent(vehdet)+'&id=1&brhid='+brhid+'&regno='+regno);
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
     <td align="center"><button type="button" name="btnmastersearch" id="btnmastersearch" class="myButton">Search</button></td>
  </tr>
  <tr>
    <td align="right">Client Details</td>
    <td colspan="2"><input type="text" name="cldet" id="cldet" style="width:99%;"></td>
    <td align="right">Vehicle Details</td>    
    <td colspan="2"><input type="text" name="vehdet" id="vehdet" style="width:99%;"></td>    
  </tr> 
  <tr>
    <td colspan="8"><div id="mastersearchdiv"><jsp:include page="masterSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>

</body>
</html>