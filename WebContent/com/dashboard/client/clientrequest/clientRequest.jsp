<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
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
		 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 $('#cmbprocess').attr('disabled', true);$('#txtclientname').attr('readonly', true);$('#txtamount').attr('readonly', true);
		 $('#txtremarks').attr('readonly', true);$('#btnupdate').attr("disabled",true);
		 
	});
	
	function funreload(event){
		 $('#cmbprocess').attr('disabled', true); $('#date').val(new Date());$('#btnupdate').attr("disabled",true);
		 $('#cmbprocess').val('');$('#txtdocno').val('');$('#txtbrhid').val('');$('#txtcldocno').val('');$('#txtagreement').val('');
		 $('#txtremarks').val('');$('#txtamount').val('');$('#txtagreementno').val('');$('#txtrtype').val('');$('#txttypeid').val('');$('#txtclientname').val(''); 
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var uptodate = $('#uptodate').val();
		 $("#overlay, #PleaseWait").show();
		 
		 $("#clientRequestDiv").load("clientRequestGrid.jsp?branchval="+branchval+'&uptodate='+uptodate+'&check=1');
		}
	
	function getProcess() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
			//alert(items);
				items = items.split('####');
				
				var srno  = items[0].split(",");
				var process = items[1].split(",");
				var optionsbranch = '<option value="" selected>-- Select -- </option>';
				for (var i = 0; i < process.length; i++) {
					optionsbranch += '<option value="' + srno[i].trim() + '">'
							+ process[i] + '</option>';
				}
				$("select#cmbprocess").html(optionsbranch);
				
			} else {}
		}
		x.open("GET","getProcess.jsp", true);
		x.send();
	}
	
	function funUpdate(event){
		var process = $('#cmbprocess').val();
		var docno = $('#txtdocno').val();
		var date =  $('#date').val();
		var branchid = $('#txtbrhid').val();
		var cldocno = $('#txtcldocno').val();
		var agreement = $('#txtagreement').val();
		var remarks = $('#txtremarks').val();
		var amount = $('#txtamount').val();
		var rdocno = $('#txtagreementno').val();
		var rtype = $('#txtrtype').val();
		var typeid = $('#txttypeid').val();
		
		if(process==''){
			 $.messager.alert('Message','Choose a Process.','warning');
			 return 0;
		 }
		
		if(docno==''){
			 $.messager.alert('Message','Doc No is Mandatory.','warning');
			 return 0;
		 }
		
		if(cldocno==''){
			 $.messager.alert('Message','Client is Mandatory.','warning');
			 return 0;
		 }
		
		if(amount==''){
			 $.messager.alert('Message','Amount is Mandatory.','warning');
			 return 0;
		 }
		
		 if(remarks==''){
			 $.messager.alert('Message','Please Enter Remarks.','warning');
			 return 0;
		 }
		
		    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		 saveGridData(docno,date,branchid,cldocno,agreement,remarks,amount,process,rdocno,rtype,typeid);	
		     	}
		 });
	}
	
	function saveGridData(docno,date,branchid,cldocno,agreement,remarks,amount,process,rdocno,rtype,typeid){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;

				var process = $('#cmbprocess').val('');
				var docno = $('#txtdocno').val('');
				$('#date').val(new Date());
				var branchid = $('#txtbrhid').val('');
				var cldocno = $('#txtcldocno').val('');
				var agreement = $('#txtagreement').val('');
				var remarks = $('#txtremarks').val('');
				var amount = $('#txtamount').val('');
				var rdocno = $('#txtagreementno').val('');
				var rtype = $('#txtrtype').val('');
				var clientname = $('#txtclientname').val(''); 
				var typeid = $('#txttypeid').val('');
				
				$.messager.alert('Message', '  Record Successfully Updated ', function(r){
			  });
		      funreload(event); 
		  }
		}
			
	x.open("GET","saveData.jsp?docno="+docno+"&date="+date+"&branchid="+branchid+"&cldocno="+cldocno+"&agreement="+agreement+"&remarks="+remarks+"&amount="+amount+"&process="+process+"&rdocno="+rdocno+"&rtype="+rtype+"&typeid="+typeid,true);
	x.send();
	}
	
	function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
		  	JSONToCSVCon(data1, 'ClientRequest', true);
		 } else {
			 $("#clientRequest").jqxGrid('exportdata', 'xls', 'ClientRequest');
		 }
	}
	
</script>
</head>
<body onload="getBranch();getProcess();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td align="right"><label class="branch">Up To</label></td>
     <td align="left"><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td align="right"><label class="branch">Process</label></td>
	<td align="left"><select name="cmbprocess" id="cmbprocess" style="width:40%;" name="cmbprocess"  value='<s:property value="cmbprocess"/>'></select></td></tr>
	<tr><td align="right"><label class="branch">Doc No</label></td>
	<td align="left"><input type="text" id="txtdocno" name="txtdocno" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txtdocno"/>'/></td></tr>
    <tr><td align="right"><label class="branch">Date</label></td>
    <td align="left"><div id="date" name="date" value='<s:property value="date"/>'></div></td></tr> 
    <tr><td align="right"><label class="branch">Client</label></td>
	<td align="left"><input type="text" id="txtclientname" name="txtclientname" style="width:100%;height:20px;" readonly="readonly" value='<s:property value="txtclientname"/>'/>
    <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/></td></tr> 
	<tr><td align="right"><label class="branch">Amount</label></td>
	<td align="left"><input type="text" id="txtamount" name="txtamount" style="width:70%;height:20px;text-align: right;" onblur="funRoundAmt(this.value,this.id);" value='<s:property value="txtamount"/>'/></td></tr> 
	<tr><td align="right"><label class="branch">Remarks</label></td>
	<td align="left"><input type="text" id="txtremarks" name="txtremarks" style="width:100%;height:20px;" value='<s:property value="txtremarks"/>'/></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2" align="center"><button class="myButton" type="button" id="btnupdate" name="btnupdate" onclick="funUpdate(event);">Update</button></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2"><input type="hidden" name="txtbrhid" id="txtbrhid" style="height:20px;width:70%;" value='<s:property value="txtbrhid"/>'>
	<input type="hidden" name="txtrtype" id="txtrtype" style="height:20px;width:70%;" value='<s:property value="txtrtype"/>'>
	<input type="hidden" name="txttypeid" id="txttypeid" style="height:20px;width:70%;" value='<s:property value="txttypeid"/>'>
	<input type="hidden" name="txtagreement" id="txtagreement" style="height:20px;width:70%;" value='<s:property value="txtagreement"/>'>
	<input type="hidden" name="txtagreementno" id="txtagreementno" style="height:20px;width:70%;" value='<s:property value="txtagreementno"/>'></td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="clientRequestDiv"><jsp:include page="clientRequestGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>

</div> 
</body>
</html>