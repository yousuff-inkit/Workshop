<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />
<script>
$(document).ready(function(){
    $("#btnticketsearch").click(function(){
    	var branch='<%=request.getParameter("branch")%>';
    	var fromdate='<%=request.getParameter("fromdate")%>';
    	var todate='<%=request.getParameter("todate")%>';
    	var type='<%=request.getParameter("type")%>';
    	var acno='<%=request.getParameter("acno")%>';
    	var searchticketno=$('#searchticketno').val();
    	var searchregno=$('#searchregno').val();
    	$("#overlay, #PleaseWait").show();
    	$('#multisearchdiv').load('multiTicketSearch.jsp?branch='+branch+'&fromdate='+fromdate+'&todate='+todate+'&type='+type+'&acno='+acno+'&id=1&ticketno='+searchticketno+'&regno='+searchregno);
    });
    $('#btnticketok').click(function(){
    	var ticketno=$('#hidticketno').val();
    	var selectedrows=$('#multiTicketSearch').jqxGrid('selectedrowindexes');
    	for(var i=0;i<selectedrows.length;i++){
    		if(ticketno==""){
    			ticketno+=$('#multiTicketSearch').jqxGrid('getcellvalue',selectedrows[i],'ticket_no');	
    			document.getElementById("ticketdetails").value="Tickets\n";
    			document.getElementById("ticketdetails").value+=$('#multiTicketSearch').jqxGrid('getcellvalue',selectedrows[i],'ticket_no')+"\n";
    		}
    		else{
    			ticketno+=","+$('#multiTicketSearch').jqxGrid('getcellvalue',selectedrows[i],'ticket_no');
    			document.getElementById("ticketdetails").value+=$('#multiTicketSearch').jqxGrid('getcellvalue',selectedrows[i],'ticket_no')+"\n";
    		}
    		
    	}
    	$('#hidticketno').val(ticketno);
    	$('#multiSearchWindow').jqxWindow('close');
    });
    $('#btnticketcancel').click(function(){
    	$('#multiSearchWindow').jqxWindow('close');
    });
});
</script>
</head>
<body>
<table width="100%">
  <tr>
    <td width="13%" align="right"><label class="branch" style="background-color:transparent;">Ticket No</label></td>
    <td width="14%" align="left"><input type="text" name="searchticketno" id="searchticketno" style="height:18px;"></td>
    <td width="17%" align="right"><label class="branch" style="background-color:transparent;">Reg No</label></td>
    <td width="23%" align="left"><input type="text" name="searchregno" id="searchregno" style="height:18px;"></td>
    <td width="11%" align="center"><button type="button" name="btnticketsearch" id="btnticketsearch" class="myButtons">Search</button></td>
    <td width="7%" align="center"><button type="button" name="btnticketok" id="btnticketok" class="myButtons">OK</button></td>
    <td width="15%" align="center"><button type="button" name="btnticketcancel" id="btnticketcancel" class="myButtons">Cancel</button></td>
  </tr>
  <tr>
    <td colspan="7"><div id="multisearchdiv"><jsp:include page="multiTicketSearch.jsp"></jsp:include></div></td>
  </tr>
</table>
</body>
</html>