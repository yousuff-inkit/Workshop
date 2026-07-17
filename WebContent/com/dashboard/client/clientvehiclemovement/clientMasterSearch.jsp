 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<script type="text/javascript">
$(document).ready(function () {
	$("#searchdob").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
}); 

function loadSearch() {
 		
	var clientname=document.getElementById("searchclient").value;
	var mobile=document.getElementById("searchmobile").value;
	var license=document.getElementById("searchlicense").value;
	var passport=document.getElementById("searchpassport").value;
	var nation=document.getElementById("searchnationality").value;
	var dob=$('#searchdob').jqxDateTimeInput('val');
	var client = clientname.replace(/ /g, "%20");
	getdata(client,mobile,license,passport,nation,dob);
}
function getdata(client,mobile,license,passport,nation,dob){
		
	$('#clientsearchdiv').load('clientSearchGrid.jsp?client='+client+'&mobile='+mobile+'&license='+license+'&passport='+passport+'&nation='+nation+'&dob='+dob+'&id=1');
	
}

	</script>
	</head>
<body style="background-color:#E0ECF8;">
		<table style="width:100%;">
			<tr>
	    		<td width="8%" align="right"><label class="branch" style="background-color:transparent;">Name</label></td>
			    <td colspan="5"><input type="text" id="searchclient" name="searchclient" style="height:18px;width:100%;"></td>
			    <td width="8%" align="right"><label class="branch" style="background-color:transparent;">Mobile</label></td>
			    <td width="15%"><input type="text" id="searchmobile" name="searchmobile" style="height:18px;"></td>
			    <td width="7%" rowspan="2" align="center"><button type="button" name="btnclientsearch" class="myButton" id="btnclientsearch" onclick="loadSearch();">Search</button></td>
	  		</tr>
	  		<tr>
	    		<td align="right"><label class="branch" style="background-color:transparent;">License</label></td>
			    <td width="13%"><input type="text" name="searchlicense" id="searchlicense" style="height:18px;"></td>
			    <td width="9%" align="right"><label class="branch" style="background-color:transparent;">Passport</label></td>
			    <td width="16%"><input type="text" name="searchpassport" id="searchpassport" style="height:18px;"></td>
			    <td width="10%" align="right"><label class="branch" style="background-color:transparent;">Nationality</label></td>
			    <td width="14%"><input type="text" name="searchnationality" id="searchnationality" style="height:18px;"></td>
			    <td align="right"><label class="branch" style="background-color:transparent;">DOB</label></td>
			    <td><div id="searchdob" name="searchdob"></div></td>
	    	</tr>
	  		<tr>
	    		<td colspan="9" align="center"><div id="clientsearchdiv"><jsp:include page="clientSearchGrid.jsp"></jsp:include></div></td>
	    	</tr>
		</table>
	</div>
</body>
</html>