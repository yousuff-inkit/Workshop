 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();
 String masterdocno=request.getParameter("docno");
 %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<title>GatewayERP(i)</title>
<link rel="stylesheet" href="../../../../css/body.css">
<script type="text/javascript">
$(document).ready(function(){
	/*  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:50%;left:50%;'><img src='../../../../icons/31load.gif'/></div>");    
 */
	 $("#printdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
    $("#printtime").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"HH:mm", showCalendarButton: false,value:null});
    //$('#printGrid').jqxGrid({'disabled',true});
    
    
});
 
function funGetPrint(){
	document.getElementById("printdocno").value="";
	
	if($("#printdate").val() == "") {
		 $.messager.alert('Message',"Please Select Date");
		  return false;
		}
	 if($("#printtime").val() == ""){
		 $.messager.alert('Message',"Please Select Time");
		 return false;
	}
		
	
	var url=document.URL;
	 var reurl=url.split("printVoucherWindow.jsp");
	 var win= window.open(reurl[0]+"printRASayara?docno="+<%=masterdocno%>+"&formdetailcode=RAG"+"&printdate="+document.getElementById("printdate").value+"&printtime="+document.getElementById("printtime").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	 
	 win.focus();
	 win_voucher.close();
}

</script>

<body ">
<div id=search >
<table width="450" height="105" align="center">
  
    
  <tr>
    <td align="right"><label class="multiprint"><b>Date</b></label></td>
    <td align="left"><div id="printdate" name="printdate"></div></td>
    <td align="right"><label class="multiprint"><b>Time</b></label></td>
    <td width="14%" align="left"><div id="printtime" name="printtime"></div></td>
    <td width="21%" align="center"><button type="button" name="btnGetPrint" id="btnGetPrint" class="myButton" onclick="funGetPrint()">Print</button></td>
  </tr>
  
</table>
<input type="hidden" name="printdocno" id="printdocno">
</div>
</body>
</html>