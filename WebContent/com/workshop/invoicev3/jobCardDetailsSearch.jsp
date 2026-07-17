<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>
<% String contextPath=request.getContextPath();%>

<style>
 <link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
</style>
<script type="text/javascript">

$(document).ready(function() {
	
	$("#sdate").jqxDateTimeInput({  width:'125px',height : '15px', formatString : "dd.MM.yyyy" });
});

function loadSearch() {
		
		var sdocno=document.getElementById("sdocno").value;
		var rtype='<%=request.getParameter("rtype")%>'
		var sdate=document.getElementById("sdate").value;
		 
		var scldocno=document.getElementById("sdate").value;
		
		var sclientname=document.getElementById("sclientname").value;
		var brhid=$('#brchName').val();
				
		getdatas(sdocno,sdate,scldocno,sclientname,rtype,brhids);


}

function getdatas(sdocno,sdate,scldocno,sclientname,rtype,brhid){
	$('#jobCardSearchGrid').load('jobCardDetailsSearchGrid.jsp?doccno='+sdocno+'&date='+sdate+'&cldocno='+scldocno+'&clientname='+sclientname+'&rtype='+rtype+'&id=1&brhid='+brhid);
}
</script>


</head>
<body>

<div id="search">
<table width="100%" border="0">
		<tr>
			<td width="13%" align="right">Date</td> <td width="14%" align="left"><div id="sdate"></div></td>
			<td width="15%" align="right">Doc No </td>
			<td width="14%"><input type="text" name="sdocno" id="sdocno"></td>
			<td width="44%" align="center" style="float: right;"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
		</tr>
		<tr>
			<td width="13%" align="right">Client Doc. No:</td> <td><input type="text" name="scldocno" id="scldocno"></td>
			<td align="right">Client Name</td>
			<td colspan="2"><input type="text" name="sclientname" id="sclientname" style="width:96%"></td>
		</tr>
	</table>
</div>

<div id="jobCardSearchGrid"> <jsp:include page="jobCardDetailsSearchGrid.jsp"></jsp:include> </div>

</body>
</html>