<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<script>
$(document).ready(function(e) {
	$("#msearchdate").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy",value:null });
});
function funMasterSearch(){
	var docno=$('#msearchdocno').val();
	var client=$('#msearchclient').val();
	var date=$('#msearchdate').jqxDateTimeInput('val');
	var clientmob=$('#msearchclientmob').val();
	var chkallbranch="0";
	var branch='<%=request.getParameter("branch")==null?"":request.getParameter("branch")%>';
	if(document.getElementById("chkallbranch").checked==true){
		chkallbranch="1";
	}
	else{
		chkallbranch="0";
	}
	$('#searchdiv').load('searchGrid.jsp?docno='+docno+'&client='+client+'&date='+date+'&clientmob='+clientmob+'&chkallbranch='+chkallbranch+'&id=1&branch='+branch);
}
</script>
</head>
<body>
<table width="100%">
  <tr>
    <td align="right">Doc No</td>
    <td><input type="text" name="msearchdocno" id="msearchdocno"></td>
    <td align="right">Client</td>
    <td colspan="3"><input type="text" name="msearchclient" id="msearchclient" style="width:95%;"></td>
  </tr>
  <tr>
    <td align="right">Date</td>
    <td><div id="msearchdate"></div></td>
    <td align="right">Client Mob</td>
    <td><input type="text" name="msearchclientmob" id="msearchclientmob"></td>
    <td><input type="checkbox" name="chkallbranch" id="chkallbranch"><label for="chkallbranch">All Branch</label></td>
    <td align="center"><button type="button" name="btnmsearch" id="btnmsearch" class="myButton" onClick="funMasterSearch();">Search</button></td>
  </tr>
  <tr>
    <td colspan="6"><div id="searchdiv"><jsp:include page="searchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</body>
</html>