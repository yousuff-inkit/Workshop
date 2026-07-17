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
            var docno=$('#msearchdocno').val();
			var date=$('#msearchdate').jqxDateTimeInput('val');
			var jobcardno=$('#msearchjobcardno').val();
			var regno=$('#msearchregno').val();
			var cldocno=$('#msearchcldocno').val();
			var clientname=$('#msearchclientname').val();
			var brhid=$('#brchName').val();
			$('#mastersearchdiv').load('masterSearchGrid.jsp?docno='+docno+'&date='+date+'&jobcardno='+jobcardno+'&regno='+regno+'&cldocno='+cldocno+'&clientname='+clientname+'&id=1&brhid='+brhid);
        });
    });
</script>
</head>
<body>
<table width="100%" border="0" >
  <tr>
    <td width="8%" align="right"><label class="branch">Doc No</label></td>
    <td width="14%"><input type="text" name="msearchdocno" id="msearchdocno"></td>
    <td width="6%" align="right"><label class="branch">Date</label></td>
    <td width="11%"><div id="msearchdate"></div></td>
    <td width="10%" align="right"><label class="branch">Job Card No</label></td>
    <td width="12%"><input type="text" name="msearchjobcardno" id="msearchjobcardno"></td>
    <td width="12%" align="right"><label class="branch">Vehicle Reg No</label></td>
    <td width="17%"><input type="text" name="msearchregno" id="msearchregno"></td>
  </tr>
  <tr>
    <td align="right"><label class="branch">Client No</label></td>
    <td><input type="text" name="msearchcldocno" id="msearchcldocno"></td>
    <td align="right"><label class="branch">Client</label></td>
    <td colspan="4"><input type="text" name="msearchclientname" id="msearchclientname" style="width:95%;"></td>
    <td align="center"><input type="button" name="btnmastersearch" id="btnmastersearch" value="Search" class="myButton"></td>
  </tr>
  <tr>
    <td colspan="8"><div id="mastersearchdiv"><jsp:include page="masterSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>

</body>
</html>