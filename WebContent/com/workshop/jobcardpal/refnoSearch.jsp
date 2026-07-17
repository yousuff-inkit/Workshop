<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<%String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String reftype=request.getParameter("reftype")==null?"":request.getParameter("reftype"); 
%>
<script type="text/javascript">
	$(document).ready(function(e) {
		var branch='<%=branch%>';
		var reftype='<%=reftype%>';
		$("#refsearchdate").jqxDateTimeInput({  width:'125px',height : '15px', formatString : "dd.MM.yyyy",value:null });
        $('#btnrefnosearch').click(function(e) {
            var refgatevocno=$('#refsearchgatevocno').val();
			var refestvocno=$('#refsearchestvocno').val();
			var clientname=$('#refsearchclientname').val();
			var regno=$('#refsearchregno').val();
			var refdate=$('#refsearchdate').jqxDateTimeInput('val');
			$('#refnosearchdiv').load('refnoSearchGrid.jsp?refgatevocno='+refgatevocno+'&refestvocno='+refestvocno+'&clientname='+clientname.replace(' ', '%20')+'&regno='+regno+'&refdate='+refdate+'&id=1&branch='+branch+'&reftype='+reftype);
        });
    });
</script>
</head>
<body>
<%--<table width="100%" border="0">
  <tr>
    <td width="14%">Ref No</td>
    <td width="26%"><input type="text" name="searchrefno" id="searchrefno"></td>
    <td width="13%">Ref Date</td>
    <td width="21%"><div id="searchrefdate"></div></td>
    <td width="26%" align="center"><input type="button" name="btnrefnosearch" id="btnrefnosearch" value="Search"></td>
  </tr>
  <tr>
    <td colspan="5"><div id="refnosearchdiv"><jsp:include page="refnoSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>--%>
<table width="100%" border="0">
  <tr>
    <td width="16%" align="right">Gate In Pass No</td>
    <td width="18%"><input type="text" name="refsearchgatevocno" id="refsearchgatevocno"></td>
    <td width="16%" align="right">Estimation No</td>
    <td width="21%"><input type="text" name="refsearchestvocno" id="refsearchestvocno"></td>
    <td width="14%" align="right">Date</td>
    <td width="15%"><div id="refsearchdate"></div></td>
  </tr>
  <tr>
    <td align="right">Reg No</td>
    <td><input type="text" name="refsearchregno" id="refsearchregno"></td>
    <td align="right">Client Name</td>
    <td colspan="2"><input type="text" name="refsearchclientname" id="refsearchclientname"></td>
    <td align="center"><button type="button" name="btnrefnosearch" id="btnrefnosearch" class="myButton">Search</button></td>
  </tr>
  <tr>
    <td colspan="6"><div id="refnosearchdiv"><jsp:include page="refnoSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>

</body>
</html>