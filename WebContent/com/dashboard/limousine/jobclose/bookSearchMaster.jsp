
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<style>
span{
background-color:transparent !important;
}

</style>
<script>
$(document).ready(function(){
	$("#searchdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	$('#btnbooksearch').click(function(){
		var branch='<%=request.getParameter("branch")%>';
		var fromdate='<%=request.getParameter("fromdate")%>';
		var todate='<%=request.getParameter("todate")%>';
		var searchdate=$('#searchdate').jqxDateTimeInput('val');
		var searchdocno=$('#searchdocno').val();
		var searchclient=$('#searchclient').val();
		var searchguest=$('#searchguest').val();
		$('#booksearchdiv').load('bookSearchGrid.jsp?branch='+branch+'&searchdate='+searchdate+'&searchdocno='+searchdocno+'&searchclient='+searchclient+'&searchguest='+searchguest+'&id=1');
	});
	
	$('#btnbookok').click(function(){
		var bookings=$('#bookdocno').val();
    	var selectedrows=$('#bookSearchGrid').jqxGrid('selectedrowindexes');
    	for(var i=0;i<selectedrows.length;i++){
    		if(bookings==""){
    			bookings+=$('#bookSearchGrid').jqxGrid('getcellvalue',selectedrows[i],'bookdocno');	
    			document.getElementById("bookdocnodetails").value="Bookings\n";
    			document.getElementById("bookdocnodetails").value+=$('#bookSearchGrid').jqxGrid('getcellvalue',selectedrows[i],'bookdocno')+"\n";
    		}
    		else{
    			bookings+=","+$('#bookSearchGrid').jqxGrid('getcellvalue',selectedrows[i],'bookdocno');
    			document.getElementById("bookdocnodetails").value+=$('#bookSearchGrid').jqxGrid('getcellvalue',selectedrows[i],'bookdocno')+"\n";
    		}
    		
    	}
    	$('#bookdocno').val(bookings);
    	$('#bookSearchWindow').jqxWindow('close');
	});
	
	$('#btnbookcancel').click(function(){
    	$('#bookSearchWindow').jqxWindow('close');
	});
});
</script>
</head>
<body>
<table width="100%">
  <tr>
    <td width="10%" align="right"><span class="branch">Doc No</span></td>
    <td width="14%"><input type="text" name="searchdocno" id="searchdocno"></td>
    <td width="10%" align="right"><span class="branch">Client</span></td>
    <td width="26%"><input type="text" name="searchclient" id="searchclient" style="width:99%;"></td>
    <td width="25%">&nbsp;</td>
    <td width="15%">&nbsp;</td>
  </tr>
  <tr>
    <td align="right"><span class="branch">Date</span></td>
    <td><div id="searchdate" name="searchdate"></div></td>
    <td align="right"><span class="branch">Guest</span></td>
    <td><input type="text" name="searchguest" id="searchguest" style="width:99%;"></td>
    <td colspan="2" align="center"><button type="button" name="btnbooksearch" id="btnbooksearch" class="myButtons" >Search</button>&nbsp;&nbsp;<button type="button" name="btnbookok" id="btnbookok" class="myButtons" >OK</button>&nbsp;&nbsp;<button type="button" name="btnbookcancel" id="btnbookcancel" class="myButtons" >Cancel</button></td>
  </tr>
  <tr>
    <td colspan="6"><div id="booksearchdiv"><jsp:include page="bookSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>

</body>
</html>