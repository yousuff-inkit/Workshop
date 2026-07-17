<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript">
	$(document).ready(function(e) {
		$("#msearchdate").jqxDateTimeInput({  width:'125px',height : '15px', formatString : "dd.MM.yyyy",value:null });
        $('#btnmastersearch').click(function(e) {
            var refno=$('#msearchrefno').val();
			var reftype=$('#msearchreftype').val();
			var date=$('#msearchdate').jqxDateTimeInput('val');
			var docno=$('#msearchdocno').val();
			var cldocno=$('#msearchcldocno').val();
			var accno=$('#mserchaccnos').val();
			var reg=$('#regss').val();
			var brhid=$('#brchName').val();
			$('#mastersearchdiv').load('masterSearchGrid.jsp?refno='+refno+'&reftype='+reftype+'&date='+date+'&docno='+docno+'&id=1'+'&cldocno='+cldocno+'&accno='+accno+'&regno='+reg+'&brhid='+brhid);
        });
    });
</script>
</head>
<body>
<!-- <table width="100%" border="0">
  <tr>
    <td width="8%">Doc No</td>
    <td width="22%"><input type="text" name="msearchdocno" id="msearchdocno"></td>
    <td width="5%">Date</td>
    <td width="4%"><div id="msearchdate"></div></td>
    <td width="5%">Ref Type</td>
    <td width="17%"><select name="msearchreftype" id="msearchreftype"><option value="">--Select--</option><option value="GIP">Gate In Pass</option><option value="EST">Estimation</option></select></td>
    <td width="7%">Ref No</td>
    <td width="22%"><input type="text" name="msearchrefno" id="msearchrefno"></td>
    <td width="10%" align="center"><input type="button" name="btnmastersearch" id="btnmastersearch" value="Search" class="myButton"></td>
  </tr>
  
</table> -->

<table width="100%" border="0">
  <tr>
    <td width="11%" align="right">Doc No</td>
    <td width="14%"><input type="text" name="msearchdocno" id="msearchdocno"></td>
    <td width="25%" align="right">Date</td>
    <td width="14%"><div id="msearchdate"></div></td>
    <td width="15%" align="right">Ref Type</td>
    <td width="14%"><select name="msearchreftype" id="msearchreftype"><option value="">--Select--</option><option value="GIP">Gate In Pass</option><option value="EST">Estimation</option></select></td>
    <td width="6%"><input type="button" name="btnmastersearch" id="btnmastersearch" value="Search" class="myButton"></td>
  </tr>
  <tr>
    <td align="right">Ref No</td>
    <td><input type="text" name="msearchrefno" id="msearchrefno"></td>
    <td align="right">Client Doc No</td>
    <td><input type="text" name="msearchcldocno" id="msearchcldocno"></td>
    <td align="right">Account No</td>
    <td><input type="text" name="mserchaccnos" id="mserchaccnos"></td>
	<td align="right">Reg No</td>
    <td><input type="text" name="regss" id="regss"></td>
  </tr>
  <tr>
    <td colspan="8"><div id="mastersearchdiv"><jsp:include page="masterSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</body>
</html>