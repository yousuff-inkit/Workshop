<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>
<% String contextPath=request.getContextPath();%>

<style>
 <%-- <link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" /> --%>
</style>
<script type="text/javascript">

$(document).ready(function() {
	
	$("#refsearchdate").jqxDateTimeInput({  width:'125px',height : '15px', formatString : "dd.MM.yyyy",value:null });
});

function loadSearch() {
		
		var refsearchdocno=document.getElementById("refsearchdocno").value;
		var reftype='<%=request.getParameter("reftype")==null?"":request.getParameter("reftype")%>';
		var refsearchdate=$('#refsearchdate').jqxDateTimeInput('val');
		var refsearchcldocno=document.getElementById("refsearchcldocno").value;
		var refsearchclientname=document.getElementById("refsearchclientname").value;
		getdatas(refsearchdocno,refsearchdate,refsearchcldocno,refsearchclientname,reftype);
}

function getdatas(refsearchdocno,refsearchdate,refsearchcldocno,refsearchclientname,reftype){
	var brhid=$('#brchName').val();
	$('#jobcardsearchdiv').load('jobCardSearchGrid.jsp?refsearchdocno='+refsearchdocno+'&refsearchdate='+refsearchdate+'&refsearchcldocno='+refsearchcldocno+'&refsearchclientname='+refsearchclientname+'&reftype='+reftype+'&id=1&brhid='+brhid);
}
</script>


</head>
<body>

<div id="search">
<table width="100%" border="0">
		<tr>
			<td width="13%" align="right">Date</td> <td width="14%" align="left"><div id="refsearchdate"></div></td>
			<td width="15%" align="right">Doc No </td>
			<td width="14%"><input type="text" name="refsearchdocno" id="refsearchdocno"></td>
			<td width="44%" align="center" style="float: right;"><input type="button" name="btnrefsearch" id="btnrefsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
		</tr>
		<tr>
			<td width="13%" align="right">Client Doc. No:</td> <td><input type="text" name="refsearchcldocno" id="refsearchcldocno"></td>
			<td align="right">Client Name</td>
			<td colspan="2"><input type="text" name="refsearchclientname" id="refsearchclientname" style="width:96%"></td>
		</tr>
		<tr><td colspan="5"><div id="jobcardsearchdiv"><jsp:include page="jobCardSearchGrid.jsp"></jsp:include></div></td></tr>
	</table>
</div>



</body>
</html>