 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
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
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:50%;left:50%;'><img src='../../../../icons/31load.gif'/></div>");    

	 $("#printfromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
    $("#printtodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
    //$('#printGrid').jqxGrid({'disabled',true});
    
    
});
function isNumber(evt,id) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
     {
    	 $.messager.alert('Warning','Enter Numbers Only');
       $("#"+id+"").focus();
        return false;
        
     }
    
    return true;
}
 function changeRdo(){
 
 if(document.getElementById("rdosingle").checked==true){
 	document.getElementById("tono").disabled=true;
 	document.getElementById("printgriddiv").style.display="none";
 	$('.multiprint').attr('hidden',true);
 	document.getElementById("btnPrintSearch").style.display="none";
 	 	
 }
if(document.getElementById("rdomultiple").checked==true){
 	document.getElementById("tono").disabled=false;
 	 document.getElementById("printgriddiv").style.display="block";
 	$('.multiprint').attr('hidden',false);
 	document.getElementById("btnPrintSearch").style.display="block";
 }
  var voc='<%=request.getParameter("voc")%>';
 if(voc!=""){
	 document.getElementById("fromno").value=voc;
 }
 
 }
 
function funGetPrint(){
	document.getElementById("printdocno").value="";
	var header=0;
	if(document.getElementById("chkheader").checked==true){
		header=1;
	}
	else{
		header=0;
	}
	if(parseFloat(document.getElementById("fromno").value)==0){
		$.messager.alert('Message',"Please Enter valid Inv No");
			document.getElementById("fromno").focus();
			return false;
	} 
	if(parseFloat(document.getElementById("tono").value)==0){
		$.messager.alert('Message',"Please Enter valid Inv No");
			document.getElementById("tono").focus();
			return false;
	}
	if(document.getElementById("rdosingle").checked==true){
 		if(document.getElementById("fromno").value==""){
 			$.messager.alert('Message',"Please Enter Inv No");
 			document.getElementById("fromno").focus();
 			return false;
 		}
	document.getElementById("tono").disabled=false;
 	
	document.getElementById("tono").value=document.getElementById("fromno").value;
 }
	else if(document.getElementById("rdomultiple").checked==true){
	
		var rows=$('#printGrid').jqxGrid('selectedrowindexes');
		for(var i=0;i<rows.length;i++){
			if(i==0){
				document.getElementById("printdocno").value+=$('#printGrid').jqxGrid('getcellvalue',rows[i],'voucherno');
			}
			else{
				document.getElementById("printdocno").value+=","+$('#printGrid').jqxGrid('getcellvalue',rows[i],'voucherno');
			}
		}
		
		if(document.getElementById("fromno").value=="" && document.getElementById("tono").value=="" && document.getElementById("printdocno").value==""){
 			$.messager.alert('Message',"Please Enter Both Inv Nos");
 			document.getElementById("fromno").focus();
 			return false;
 		}
		if(document.getElementById("fromno").value=="" && document.getElementById("printdocno").value==""){
 			$.messager.alert('Message',"Please Enter Inv No");
 			document.getElementById("fromno").focus();
 			return false;
 		}
		if(document.getElementById("tono").value=="" && document.getElementById("printdocno").value==""){
 			$.messager.alert('Message',"Please Enter Inv No");
 			document.getElementById("tono").focus();
 			return false;
 		}
		
		
	}

	var url=document.URL;
	 var reurl=url.split("printVoucherWindow.jsp");
	 var branch='<%=request.getParameter("branch")%>'; 
    var win= window.open(reurl[0]+"printManualInvoice?fromno="+document.getElementById("fromno").value+"&tono="+document.getElementById("tono").value+"&branch="+branch+"&printdocno="+document.getElementById("printdocno").value+"&hidheader="+header,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
    win.focus();
    win_voucher.close();
}
function funPrintGridLoad(){
	
	var agmtno=document.getElementById("printagmtno").value;
	var agmttype=document.getElementById("cmbprintagmttype").value;
	var client=document.getElementById("printclient").value;
	 var fromno=document.getElementById("fromno").value;
	 var  tono=document.getElementById("tono").value;
var branch='<%=request.getParameter("branch")%>';
if(agmttype=="" && agmtno!=""){
	$.messager.alert('Warning','Please Select Agmt Type');
	return false;
}
	//	$("#invoiceDiv").load("invoiceGrid.jsp?docno="+docno1+"&branch="+document.getElementById("brchName").value);
$("#overlay, #PleaseWait").show();
	$("#printgriddiv").load("printGrid.jsp?fromdate="+$("#printfromdate").jqxDateTimeInput("getText")+"&todate="+$('#printtodate').jqxDateTimeInput('getText')+"&agmtno="+agmtno+"&agmttype="+agmttype+"&client="+client+"&branch="+branch+"&fromno="+fromno+"&tono="+tono+"&mode=1");
}
</script>

<body onload="changeRdo();">
<div id=search >
<table width="690" height="105">
  <tr>
    <td height="22" align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td align="left"><input type="radio" name="rdoprint" id="rdosingle" checked onChange="changeRdo();">
<label for="rdosingle">Single</label></td>
    <td colspan="2" rowspan="2" align="center"><input type="checkbox" name="chkheader" id="chkheader"><label for="chkheader"> Header</label></td>
    <td align="center">&nbsp;</td>
    </tr>
    <tr>
    <td height="22" align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td align="left"><input type="radio" name="rdoprint" id="rdomultiple"  onChange="changeRdo();">
      <label for="rdomultiple">Multiple</label></td>
    <td align="center">&nbsp;</td>
    </tr>
  <tr>
    <td width="16%" height="21" align="right"><label class="branch">Doc No From</label></td>
    <td width="25%" align="left"><input type="text" name="fromno" id="fromno" onkeypress="javascript:return isNumber (event,id)"></td>
    <td width="15%" align="right"><label class="branch">Doc No To</label></td>
    <td colspan="2" align="left"><input type="text" name="tono" id="tono" onkeypress="javascript:return isNumber (event,id)"></td>
    <td width="21%" align="left"><button type="button" name="btnGetPrint" id="btnGetPrint" class="myButton" onclick="funGetPrint()">Print</button></td>
  </tr>
  
  <tr>
    <td align="right"><label class="multiprint">From Date</label></td>
    <td align="left"><div id="printfromdate" class="multiprint"></div></td>
    <td align="right"><label class="multiprint">To Date</label></td>
    <td width="14%" align="left"><div id="printtodate" class="multiprint"></div></td>
    <td width="9%" align="right"><label class="multiprint">Agmt Type</label></td>
    <td align="left"><select name="cmbprintagmttype" id="cmbprintagmttype" class="multiprint">
      <option value="">--Select--</option>
      <option value="RAG">Rental</option>
      <option value="LAG">Lease</option>
    </select></td>
  </tr>
  <tr>
    <td align="right"><label class="multiprint">Client</label></td>
    <td align="left"><input type="text" name="printclient" id="printclient" class="multiprint"></td>
    <td align="right"><label class="multiprint">Agmt No</label></td>
    <td align="left"><input type="text" name="printagmtno" id="printagmtno" class="multiprint"></td>
    <td align="left">&nbsp;</td>
    <td align="left"><button type="button" name="btnPrintSearch" id="btnPrintSearch" class="myButton" onclick="funPrintGridLoad();">Search</button></td>
  </tr>
  <tr>
  <td colspan="6"><div id="printgriddiv"><jsp:include page="printGrid.jsp"/></div></td>
  </tr>
</table>
<input type="hidden" name="printdocno" id="printdocno">
</div>
</body>
</html>