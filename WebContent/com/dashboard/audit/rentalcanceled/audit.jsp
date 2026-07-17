<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

<script type="text/javascript">

$(document).ready(function () {
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
});

	function funreload(event){
		     $('#txtdocno').val('');
			 var branchval = document.getElementById("cmbbranch").value;
			 $("#overlay, #PleaseWait").show();
			 
			 $("#auditDiv").load("auditGrid.jsp?branchval="+branchval+"&check=1");
		}
	
	function funAudit(event){
		var docno = $('#txtdocno').val();
		var branchid = $('#txtbranchid').val();
		
		if(docno==''){
			 $.messager.alert('Message','Choose an Agreement.','warning');
			 return 0;
		 }
			
		    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		 saveGridData(branchid,docno);	
		     	}
		 });
	}
	
	function saveGridData(branchid,docno,srno){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;

				var branchid = $('#txtbranchid').val('');
				var docno = $('#txtdocno').val('');
				var vocno = $('#txtvocno').val('');
				
				$.messager.alert('Message', '  Record Successfully Updated ', function(r){
			  });
		      funreload(event); 
		  }
		}
			
	x.open("GET","saveData.jsp?branchid="+branchid+"&docno="+docno,true);
	x.send();
	}
	
	function getRentalAgreement(){
		var docno = $('#txtdocno').val();
		
		if(docno==''){
			 $.messager.alert('Message','Choose an Agreement.','warning');
			 return 0;
		 }
		
		var url=document.URL;
		var reurl=url.split("com/");
		
		window.parent.formName.value="Rental Agreement Create";
		window.parent.formCode.value="RAG";
		
		var detName= "Rental Agreement Create";
		var path= "com/operations/agreement/rentalagreement/rentalAgrementDetails.action?mode=view&masterdoc_no="+docno;
		top.addTab( detName,reurl[0]+""+path);
	}	
	
	function funExportBtn(){
		 JSONToCSVCon(data1, 'Rental Agreement Cancelled List', true);
	 }
	
</script>

</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	<tr><td colspan="2">&nbsp;</td></tr>
    <tr><td align="right"><label class="branch">Agreement</label></td>
	<td align="left"><input type="text" id="txtvocno" name="txtvocno" style="width:75%;height:20px;" readonly="readonly" value='<s:property value="txtvocno"/>'/>
	<input type="hidden" id="txtdocno" name="txtdocno" style="width:75%;height:20px;" value='<s:property value="txtdocno"/>'/></td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2"><button class="myButton" type="button" id="btnRAG" name="btnRAG" onclick="getRentalAgreement(event);">Rental Agreement</button>&nbsp;<button class="myButton" type="button" id="btnaudit" name="btnaudit" onclick="funAudit(event);">Audit</button></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
    <tr><td colspan="2">&nbsp;</td></tr> 
    <tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="auditDiv"><jsp:include page="auditGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>

<input type="hidden" name="txtbranchid" id="txtbranchid" style="height:20px;width:70%;" value='<s:property value="txtbranchid"/>'>

</div> 
</body>
</html>