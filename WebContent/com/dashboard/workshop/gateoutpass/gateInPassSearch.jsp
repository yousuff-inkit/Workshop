 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% 
 String contextPath=request.getContextPath(); 
 String check=request.getParameter("check")==null?"":request.getParameter("check");
 %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<style type="text/css">
#search {
    background-color: #E0ECF8;
}
</style>

	<script type="text/javascript">
$(document).ready(function() {
	var check='<%=check%>';
$("#searchgatedate").jqxDateTimeInput({  width:'125px',height : '15px', formatString : "dd.MM.yyyy",value:null});
$('#btnsearchdoc').click(function(){
	
	var gatedocno=$('#searchgatedocno').val();
	var regno=$('#searchfleetregno').val();
	var date=$('#searchgatedate').jqxDateTimeInput('val');
	var clientname=$('#searchclientname').val();
	$('#gateinpassdiv').load('gateInPassSearchGrid.jsp?gatedocno='+gatedocno+'&regno='+regno+'&date='+date+'&clientname='+clientname+'&id=1'+'&check='+check);
});
});


</script>
</head>	
<body>
<div id="search">
	<table width="100%" border="0">
  		<tr>
            <td width="14%" align="right"style="font-size:9px;">Gate In Pass No</td>
            <td width="20%"><input type="text" name="searchgatedocno" id="searchgatedocno" style="height:18px;"></td>
            <td width="17%" align="right" style="font-size:9px;">Reg No</td>
            <td width="29%"><input type="text" name="searchfleetregno" id="searchfleetregno" style="height:18px;"></td>
            <td width="7%" align="right" style="font-size:9px;">Date</td>
            <td width="13%"><div id="searchgatedate" name="searchgatedate"></div></td>
  		</tr>
  		<tr>
            <td align="right" style="font-size:9px;">Client</td>
            <td colspan="4"><input type="text" name="searchclientname" id="searchclientname" placeholder="Client Name" style="width:100%; height:18px;"></td>
            <td align="center"><button type="button" name="btnsearchdoc" id="btnsearchdoc" class="myButton">Search</button></td>
  		</tr>
  		 <tr>
    		<td colspan="6"><div id="gateinpassdiv"><jsp:include page="gateInPassSearchGrid.jsp"></jsp:include></div></td>
    	</tr>
	</table>
</div>	
</body>
</html>