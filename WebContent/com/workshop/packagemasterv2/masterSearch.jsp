<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<script>
	$(document).ready(function(e) {
		$.get('getInitData.jsp',function(data){
			data=JSON.parse(data);
			var htmldata='<option value="">--Select--</option>';
			$.each(data.enginedata,function(index,value){
				htmldata+='<option value="'+value.docno+'">'+value.enginesize+'</option>';
			});
			$('#msearchenginesize').html($.parseHTML(htmldata));
		});
		$("#msearchdate").jqxDateTimeInput({  width:'125px',height : '15px', formatString : "dd.MM.yyyy",value:null });
        $('#btnmastersearch').click(function(e) {
            var branch=$('#brchName').val();
			var docno=$('#msearchdocno').val();
			var date=$('#msearchdate').jqxDateTimeInput('val');
			var brand=$('#msearchbrand').val();
			var model=$('#msearchmodel').val();
			var packagename=$('#msearchpackage').val();
			var brhid=$('#brchName').val();
			var enginesize=$('#msearchenginesize').val();
			$('#mastersearchdiv').load('masterSearchGrid.jsp?enginesize='+enginesize+'&branch='+branch+'&docno='+docno+'&date='+date+'&brand='+brand+'&model='+model+'&packagename='+packagename+'&id=1&brhid='+brhid);
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
    <td align="right">Engine Size</td>
    <td colspan="3"><select name="msearchenginesize" id="msearchenginesize" style="width:99%;"><option value="">--Select--</option></select></td>
    <!-- <td align="right">Model</td>
    <td ><select name="msearchmodel" id="msearchmodel"><option value="">--Select--</option></select></td>
     -->
  </tr>
  <tr>
    <td align="right">Package Name</td>
    <td colspan="6"><input type="text" name="msearchpackage" id="msearchpackage" style="width:99%;"></td>
    <td align="center"><button type="button" name="btnmastersearch" id="btnmastersearch" class="myButton">Search</button></td>
    
  </tr>
  <tr>
    <td colspan="8"><div id="mastersearchdiv"><jsp:include page="masterSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>

</body>
</html>