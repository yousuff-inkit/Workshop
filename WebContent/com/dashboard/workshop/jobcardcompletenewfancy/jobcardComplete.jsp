<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<% String contextPath=request.getContextPath();%>
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<style type="text/css">
.myButtons {
	display: inline-block;
	margin-right:4px;
	margin-left:4px; 
  margin-bottom: 0;
  font-weight: normal;
  line-height: 1.3;
  text-align: center;
  white-space: nowrap;
  vertical-align: middle;
  -ms-touch-action: manipulation;
      touch-action: manipulation;
  cursor: pointer;
  -webkit-user-select: none;
     -moz-user-select: none;
      -ms-user-select: none;
          user-select: none;
  background-image: none;
  border: 1px solid transparent;
  border-radius: 4px;
  color: #fff;
  background-color: grey;
}
.myButtons:hover {
	  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons:active {
  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons:focus {
  color: #fff;
  background-color: grey;
}
 
select{
    height:15px;
}

.hidden-scrollbar {
    overflow: auto;
    height: 600px;
}
</style>

<script type="text/javascript">

$(document).ready(function () {
		
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	    
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	 var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	 $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	 $('#clientSearchWindow').jqxWindow({width: '50%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#clientSearchWindow').jqxWindow('close');
	 
	 
	 $("#clientname").dblclick(function(){
			
		 clientSearchContent(<%=contextPath+"/"%>+"com/dashboard/workshop/jobcardcomplete/clientSearch.jsp");

		});
	 if($('#nettotal').val()==''){
		 $('#nettotal').val('0.0');
	 }
	 $('#labourtotal,#sparetotal,#extratotal').val('0.0');
});

function searchClient(){
	var x= event.keyCode;
	if(x==114){
			clientSearchContent(<%=contextPath+"/"%>+"com/dashboard/workshop/jobcardcomplete/clientSearch.jsp");
	
	
	}
}


function clientSearchContent(url) {
 	$('#clientSearchWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#clientSearchWindow').jqxWindow('setContent', data);
	$('#clientSearchWindow').jqxWindow('bringToFront');
}); 
}


function funreload(event)
{
	
    var fromdate=$('#fromdate').jqxDateTimeInput('val');
    var todate=$('#todate').jqxDateTimeInput('val');
    var clientname=$('#clientname').val();
    $('#labourcostGrid,#sparePartsNewGrid').jqxGrid('clear');
    $("#overlay, #PleaseWait").show();
    $('#labourtotal,#sparetotal,#extratotal').val('0.0');
    var brhid=$('#cmbbranch').val();
   	$("#jobcardcompletediv").load("jobcardCompleteGrid.jsp?id=1&fromdate="+fromdate+"&todate="+todate+"&clientname="+clientname.replace(/ /g, "%20")+"&brhid="+brhid);
   	
}
	
	

	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
	
	}
	
	function funExportBtn(){
		//JSONToCSVCon(repexceldata, 'Replacement List', true);
		 }
	
		
	
	function funClearData(){
		$('input[type=text],[type=hidden]').val('');
		$('select').find('option').prop("selected", false);
		$('#fromdate').jqxDateTimeInput('setDate',new Date());
		$('#todate').jqxDateTimeInput('setDate',new Date());
		var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
		$('#nettotal,#labourtotal,#sparetotal,#extratotal').val('0.0');
	}
	
	function funComplete(){
		var docno=$('#docno').val();
		var brhid=$('#brhid').val();
		
		if(docno==''){
			 $.messager.alert('Message','Choose a document','warning');
			 return 0;
		}
		if($('#materialreqpending').val()=="1"){
			$.messager.alert('Warning','Material Requests Pending');
			return 0;
		}
		checkAdditionsPending(document.getElementById("docno").value);
		if($('#pendingconfirm').val()!="0" && $('#pendingapproval').val()!="0"){
			$.messager.alert('Warning','Confirm Estimation(s) & Quotation Approval(s) are pending','info');
			return 0;
		}
		else{
			if($('#pendingconfirm').val()!="0"){
				$.messager.alert('Warning','Confirm Estimation(s) are pending','info');
				return 0;
			}
			if($('#pendingapproval').val()!="0"){
				$.messager.alert('Warning','Quotation Approval(s) are pending','info');
				return 0;
			}
		}
		
		var skipinvoice=0;
		$.messager.confirm('Confirm', 'Do you want to Complete Job Card?', function(r){
			if (r){
				var nettotal=parseFloat($('#nettotal').val());
				if(nettotal==0.0){
					$.messager.confirm("Confirm", "Total Invoice Value is zero, Job card wouldn't come for invoicing?", function(r){
						if (r){
							var x = new XMLHttpRequest();
							x.onreadystatechange = function() {
								if (x.readyState == 4 && x.status == 200) {
									var items = x.responseText;
									if(items==0){
										$.messager.alert('Message','Job Card Completed Succesfully','info');
										funreload(1);
										$('#labourcostGrid,#sparePartsNewGrid').jqxGrid('clear');
									}
									else if(items==1){
										$.messager.alert('Message','Job Card Completion Failed','warning');
									}
								}
								else{
								}
							}
							x.open("GET", "completeJobcard.jsp?docno="+docno+"&brhid="+brhid+"&skipinvoice=1", true);
							x.send();	
						}
						else{
							
						}
					});
				}
				else{
					var x = new XMLHttpRequest();
					x.onreadystatechange = function() {
						if (x.readyState == 4 && x.status == 200) {
							var items = x.responseText;
							if(items==0){
								$.messager.alert('Message','Job Card Completed Succesfully','info');
								funreload(1);
								$('#labourcostGrid,#sparePartsNewGrid').jqxGrid('clear');
							}
							else if(items==1){
								$.messager.alert('Message','Job Card Completion Failed','warning');
							}
							else if(items==2){
								$.messager.alert('Message','Please Save Job Card','warning');
							}
						}
						else{
						}
					}
					x.open("GET", "completeJobcard.jsp?docno="+docno+"&brhid="+brhid+"&skipinvoice=0", true);
					x.send();	
				}	
			}
	 	});	
	 	
	}
	function funRefreshData(){
		var docno=$('#docno').val();
		if(docno==''){
			 $.messager.alert('Message','Choose a document','warning');
			 return 0;
		}

		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
				if(parseInt(items)>0){
					$.messager.alert('Message','Job Card Refreshed Succesfully','info');
					funreload(1);
					$('#labourcostGrid,#sparePartsNewGrid').jqxGrid('clear');
				}
				else if(items==1){
					$.messager.alert('Message','Job Card Refreshing Failed','warning');
				}
				
			}
			else{
				}
			}
		
		x.open("GET", "refreshData.jsp?jobcarddocno="+docno, true);
		x.send();
	}
	function checkMaterialReqPending(docno){
		if(docno==''){
			 $.messager.alert('Message','Choose a document','warning');
			 return 0;
		}

		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
				if(items!=""){
					$('#materialreqpending').val("1");
					$.messager.alert('Warning','Material Requests '+items+' are pending','info');
					
				}
				else{
					$('#materialreqpending').val("0");
				}
			}
			else{
				}
			}
		
		x.open("GET", "checkMaterialReqPending.jsp?jobcarddocno="+docno, true);
		x.send();
	}
	
	function checkAdditionsPending(docno){
		if(docno==''){
			 $.messager.alert('Message','Choose a document','warning');
			 return 0;
		}

		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
				$('#pendingconfirm').val(items.split("::")[0]);
				$('#pendingapproval').val(items.split("::")[1]);
				if($('#pendingconfirm').val()!="0" && $('#pendingapproval').val()!="0"){
					$.messager.alert('Warning','Confirm Estimation(s) & Quotation Approval(s) are pending','info');
					return 0;
				}
				else{
					if($('#pendingconfirm').val()!="0"){
						$.messager.alert('Warning','Confirm Estimation(s) are pending','info');
						return 0;
					}
					if($('#pendingapproval').val()!="0"){
						$.messager.alert('Warning','Quotation Approval(s) are pending','info');
						return 0;
					}
				}
			}
			else{
				}
			}
		
		x.open("GET", "checkAdditionsPending.jsp?jobcarddocno="+docno, true);
		x.send();
	}
	function funNotify(){
		var docno=$('#docno').val();
		if(docno==''){
			 $.messager.alert('Message','Choose a document','warning');
			 return false;
		}
		var partrowstemp=$('#sparePartsNewGrid').jqxGrid('getrows');
		for(var z=0;z<partrowstemp.length;z++){
			if(partrowstemp[z].addition=="" || partrowstemp[z].addition==null || partrowstemp[z].addition=="undefined"){
				$.messager.alert('Message','Please fill Est.Addition for Spares','warning');
			 	return false;
			}
		}
		if($('#materialreqpending').val()=="0"){
			$.messager.confirm('Confirm', 'Do you want to Complete Job Card?', function(r){
	 			if (r){
	 				var labourarray=new Array();
	 				var partsarray=new Array();
	 				var extraarray=new Array();
					var rows=$('#labourcostGrid').jqxGrid('getrows');
					var partrows=$('#sparePartsNewGrid').jqxGrid('getrows');
					var extrarows=$('#extraDetailGrid').jqxGrid('getrows');
					for(var i=0;i<rows.length;i++){
						labourarray.push(rows[i].rowno+" :: "+rows[i].invoiceamt);
					}
					for(var i=0;i<partrows.length;i++){
						partsarray.push(partrows[i].description+" :: "+partrows[i].psrno+" :: "+partrows[i].qty+" :: "+partrows[i].esttotal+" :: "+partrows[i].costtotal+" :: "+partrows[i].catprofitpercent+" :: "+partrows[i].invoiceamt+" :: "+partrows[i].customeramt+" :: "+partrows[i].addition);
					}
					for(var i=0;i<extrarows.length;i++){
						if(extrarows[i].amount!="" && extrarows[i].amount!=null && extrarows[i].amount!="undefined" && typeof(extrarows[i].amount)!="undefined"){
							extraarray.push(extrarows[i].description+" :: "+extrarows[i].amount);	
						}
						
					}
					//alert(labourarray);
					//alert(partsarray);
					$('#strlabourarray').val(labourarray);
					$('#strpartsarray').val(partsarray);
					$('#strextraarray').val(extraarray);
					document.getElementById("mode").value='A';
					$("#overlay, #PleaseWait").show();
					document.getElementById("frmWSJobCardCompleteNewFancy").submit();
	 			}
			 });
		}
		else{
			$.messager.alert('Warning','Material Requests Pending');
			return false;
			}
	}
	
	function funPrintBtn(){
		 if($('#docno').val()!='' && $('#docno').val()!='0'){
			 
			var url=document.URL;
			var reurl=url.split("com");
			var save=$('#savestatus').val();
			//alert(save);
			if(save=='0'){
				$.messager.alert('message','please save the form','warning');
			}
			else
				{
			/* var path= "com/dashboard/workshop/quotationapproval/printQuotationAproval.action?estDocno="+estdocno; */
			var path= "com/dashboard/workshop/jobcardcompletenewfancy/printWSJobCardCompleteNewFancy.action?docno="+$('#docno').val();
			var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");		
			win.focus();		
				}	
	     }
			
	}
	function funExportBtn(){
		//JSONToCSVCon(gateexceldata, 'Job Card Complete List', true);
		$("#jqxJobcardCompleteGrid").excelexportjs({
			containerid: "jqxJobcardCompleteGrid",
			datatype: 'json',
			dataset: null,
			gridId: "jqxJobcardCompleteGrid",
			columns: getColumns("jqxJobcardCompleteGrid"),
			worksheetName: "Job Card Complete List"
		});
				
	}
	function isNumber(evt,id) {
		//Function to restrict characters and enter number only
	  	var iKeyCode = (evt.which) ? evt.which : evt.keyCode
	    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
	    {
	    	$.messager.alert('Warning','Enter Numbers Only');
	       	$("#"+id+"").focus();
	        return false;
	    }
	    return true;
	}
	</script>
	
</head>
<body onload="setValues();getBranch();">
<form id="frmWSJobCardCompleteNewFancy" method="post" action="saveWSJobCardCompleteNewFancy">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="23%" align="center">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

<!--  <tr>
   <td width="37%" align="right"><label class="branch">From Date</label></td><td width="63%"><div id="fromdate"></div></td></tr> -->
 <tr>
   <td align="right"><label class="branch">To Date</label></td>
   <td><div id="todate"></div></td>
 </tr>
 
 
  <tr>
    <td width="37%" align="right"><label class="branch">Client Name</label></td>
    <td width="63%" align="left"><input type="text" name="clientname" id="clientname" placeholder="Press F3 to search" style="height: 20px;" onkeydown="searchClient(event);"></td>
  </tr>
  <tr>
    <td width="37%" align="right"><label class="branch">Claim No</label></td>
    <td width="63%" align="left"><input type="text" name="claimno" id="claimno" style="height: 20px;"></td>
  </tr>
  <tr>
    <td width="37%" align="right"><label class="branch">LPO No</label></td>
    <td width="63%" align="left"><input type="text" name="lpono" id="lpono" style="height: 20px;"></td>
  </tr>
  <tr>
    <td width="37%" align="right"><label class="branch">LPO Amount</label></td>
    <td width="63%" align="left"><input type="text" name="lpoamount" id="lpoamount" style="height: 20px;text-align:right;" onblur="funRoundAmt(value,id);"></td>
  </tr>
  
  <tr>
  	<td colspan="2" style="border-top:2px solid #DCDDDE;">
  		<div style="text-align:center;">&nbsp;&nbsp;
  		<label class="branch">Doc. No.</label>
  		<input type="text" name = "docno" id = "docno" readonly="readonly">
  		<input type="hidden" name="brhid" id="brhid">
  		</div>
  	</td>
  </tr>
  <tr>
  	<td colspan="2">
  		<div style="text-align:center;">&nbsp;&nbsp;
  		<label class="branch">Net Total</label>
  		<input type="text" name="nettotal" id="nettotal"  value='<s:property value="nettotal"/>' style="text-align:right;" readonly onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);">
  		</div>
  	</td>
  </tr>

<tr >
	<td colspan="2" style="border-top:2px solid #DCDDDE;">
	<div style="text-align:center;">
		<input type="button" name="btnrefresh" id="btnrefresh" value="Refresh" class="myButtons" onclick="funRefreshData();">
		<input type="button" name="btnPrint" id="btnPrint" value="Print" class="myButtons" onclick="funPrintBtn();">
		<input type="button" name="btnSave" id="btnSave" value="Save" class="myButtons" onclick="funNotify();">
		<input type="button" name="btnComplete" id="btnComplete" value="Complete" class="myButtons" onclick="funComplete();">
	</div>
    </td>
</tr>
<tr >
	<td colspan="2" >
	<div style="text-align:center;">
		<input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();">&nbsp;
	</div>
    </td>
</tr>

<br/><br/>	

	
	
	
<tr ><td colspan="2"><!-- <textarea id="agmtdetails" name="agmtdetails" readonly style="resize:none;" rows="10" cols="35"></textarea> -->
	<br><br>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
</td></tr>

<tr colspan="2"><td>&nbsp;</td></tr>
	
		
	</table>
	</fieldset>
	
	 
	
</td>
<td width="77%">
	<!-- <div class="hidden-scrollbar"> -->
		<table width="100%">
		<tr>
			<td><div id="jobcardcompletediv"><jsp:include page="jobcardCompleteGrid.jsp"></jsp:include></div></td>
			<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			<input type="hidden" name="strlabourarray" id="strlabourarray" value='<s:property value="strlabourarray"/>'>
			<input type="hidden" name="strpartsarray" id="strpartsarray" value='<s:property value="strpartsarray"/>'>
			<input type="hidden" name="strextraarray" id="strextraarray" value='<s:property value="strextraarray"/>'>
			<input type="hidden" name="estdocno" id="estdocno" value='<s:property value="estdocno"/>'>
			<input type="hidden" name="sparetotal" id="sparetotal"  value='<s:property value="sparetotal"/>' style="text-align:right;" readonly onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);">
			<input type="hidden" name="labourtotal" id="labourtotal"  value='<s:property value="labourtotal"/>' style="text-align:right;" readonly onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);">
			<input type="hidden" name="extratotal" id="extratotal"  value='<s:property value="extratotal"/>' style="text-align:right;" readonly onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);">
			<div id="fromdate" hidden="true"></div>
			<input type="hidden" name="materialreqpending" id="materialreqpending" value='<s:property value="materialreqpending"/>'>
			<input type="hidden" name="savestatus" id="savestatus" value='<s:property value="savestatus"/>'>
		</tr>
		<tr><td><div id="labourdiv"><jsp:include page="labourGrid.jsp"></jsp:include></div></td></tr>
		<tr><td><div id="sparediv"><jsp:include page="spareGrid.jsp"></jsp:include></div></td></tr>
		<tr><td><div id="extradiv"><jsp:include page="extraDetailGrid.jsp"></jsp:include></div></td></tr>
	</table>
	<!-- </div> -->
	
</tr>
</table>
</div>

</div>


<div id="clientSearchWindow">
	<div></div>
</div>
<input type="hidden" name="cldocno" id="cldocno"/>
<input type="hidden" name="brhid" id="brhid">
<input type="hidden" name="pendingconfirm" id="pendingconfirm">
<input type="hidden" name="pendingapproval" id="pendingapproval">
</form>



</body>
</html>