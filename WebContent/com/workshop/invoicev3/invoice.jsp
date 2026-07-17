<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<% String contextPath=request.getContextPath();%>
<jsp:include page="../../../includes.jsp"></jsp:include>

<style>

.greenClass
{
   background-color: #ECF8E0;
}

.hidden-scrollbar {
overflow: auto;
height: 530px;
}
</style>

<script>

$(document).ready(function() {
	getWorkshopInvoiceConfig();
	$("#date").jqxDateTimeInput({  width:'125px',height : '15px', formatString : "dd.MM.yyyy" });
	$('#searchWindow').jqxWindow({width: '60%', height: '58%',  maxHeight: '70%' ,maxWidth: '60%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	$('#searchWindow').jqxWindow('close');
	$('#printWindow').jqxWindow({width: '51%', height: '28%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	$('#printWindow').jqxWindow('close'); 
	$('#workshopprintWindow').jqxWindow({width: '51%', height: '28%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	$('#workshopprintWindow').jqxWindow('close'); 
	$('#mailWindow').jqxWindow({width: '51%', height: '28%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Send Mail',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	$('#mailWindow').jqxWindow('close'); 
	$("#refno").dblclick(function(){
		var reftype = $("#cmbreftype").val();
		if(reftype=="JC"){
			 searchContent("jobCardSearch.jsp?reftype="+reftype);
		}
	});
	$("#excessamountaccount").dblclick(function(){
		searchContent("accountSearchGrid.jsp?id=1");
	});
	
	$( "#total,#excessamount,#discount,#taxpercent,#roundamt" ).on('change blur',function() {
		if($('#mode').val()=='A'){
			var total=parseFloat($('#total').val());
			var excess=parseFloat($('#excessamount').val());
			var discount=parseFloat($('#discount').val());
			var nettotal=(total)-discount;
			$('#nettotal').val(nettotal);
			var taxpercent=parseFloat($('#taxpercent').val());
			var taxvalue=taxpercent/100;
			var taxamount=nettotal*taxvalue;
			taxamount=funCustomRound(taxamount);
			$('#taxamount').val(taxamount);
			var taxtotal=parseFloat(taxamount)+parseFloat(nettotal);
			taxtotal=funCustomRound(taxtotal);
			$('#taxtotal').val(taxtotal);
		}
		var targetid=$(this).attr('id');
		var discountconfig=$('#discountconfig').val();
		if((targetid=='discount' || targetid=='roundamt') && $('#mode').val()=='E' && discountconfig=='1'){
			var total=parseFloat($('#total').val());
			var excess=parseFloat($('#excessamount').val());
			var discount=$('#discount').val();
			if(discount=='' || discount==null || discount=='undefined' || typeof(discount)=='undefined'){
				discount='0';
			}
			discount=parseFloat(discount);
			var nettotal=(total)-discount;
			//nettotal=funCustomRound(nettotal);
			$('#nettotal').val(nettotal);
			var taxpercent=parseFloat($('#taxpercent').val());
			var taxvalue=taxpercent/100;
			var taxamount=nettotal*taxvalue;
			taxamount=funCustomRound(taxamount);
			$('#taxamount').val(taxamount);
			var taxtotal=parseFloat(taxamount)+parseFloat(nettotal);
			taxtotal=funCustomRound(taxtotal);
			/*let roundamt=$('#roundamt').val();
			if(roundamt=='' || roundamt==null || roundamt=='undefined' || typeof(roundamt)=='undefined'){
				roundamt='0';
			}
			roundamt=parseFloat(roundamt);
			roundamt=funCustomRound(roundamt);
			taxtotal=taxtotal-roundamt;
			taxtotal=funCustomRound(taxtotal);*/
			$('#taxtotal').val(taxtotal);
			
			if(discount>0.0){
				let detrows=$("#invoiceDetailNewGrid").jqxGrid('getrows');
				let basediscountlength=0;
				let baseamttotal=0.0;
				for(let i=0;i<detrows.length;i++){
					let rate=$("#invoiceDetailNewGrid").jqxGrid('getcellvalue',i,'rate');
					rate=rate=='' || rate=='undefined' || rate==null || typeof(rate)=='undefined'?0.00:parseFloat(rate);
					let qty=$("#invoiceDetailNewGrid").jqxGrid('getcellvalue',i,'qty');
					qty=qty=='' || qty=='undefined' || qty==null || typeof(qty)=='undefined'?0.00:parseFloat(qty);
					
					let baseamt=rate*qty;
					baseamt=funCustomRound(baseamt);
					if(baseamt>0.0){
						baseamttotal+=parseFloat(baseamt);
						basediscountlength++;
					}
				}
				let basediscount=discount/(basediscountlength);
				basediscount=funCustomRound(basediscount);
				let lastindex=-1;
				for(let i=0;i<detrows.length;i++){
					let rate=$("#invoiceDetailNewGrid").jqxGrid('getcellvalue',i,'rate');
					rate=rate=='' || rate=='undefined' || rate==null || typeof(rate)=='undefined'?0.00:parseFloat(rate);
					let qty=$("#invoiceDetailNewGrid").jqxGrid('getcellvalue',i,'qty');
					qty=qty=='' || qty=='undefined' || qty==null || typeof(qty)=='undefined'?0.00:parseFloat(qty);
					
					let baseamt=rate*qty;
					var currentdiscount=0.0;
					console.log("Base:"+discount+"::"+baseamttotal);
					if(baseamt>0.0){
						currentdiscount=(parseFloat(discount)/parseFloat(baseamttotal))*100;
						console.log("First:"+currentdiscount);
            			currentdiscount=parseFloat(baseamt)*(parseFloat(currentdiscount)/100);
            			console.log("Second:"+currentdiscount);
						$("#invoiceDetailNewGrid").jqxGrid('setcellvalue',i,'discount',currentdiscount);	
						lastindex++;
					}				
				}
				let discountSumData = $("#invoiceDetailNewGrid").jqxGrid('getcolumnaggregateddata', 'discount', ['sum']);
				let discountsum=parseFloat(discountSumData.sum);
				let discountremain=discount-discountsum;
				discountremain=funCustomRound(discountremain);
				let lastdiscount=$("#invoiceDetailNewGrid").jqxGrid('getcellvalue',lastindex,'discount');
				lastdiscount=parseFloat(lastdiscount)+parseFloat(discountremain);
				lastdiscount=funCustomRound(lastdiscount);
				$("#invoiceDetailNewGrid").jqxGrid('setcellvalue',lastindex,'discount',lastdiscount);
				
				let vatSumData=$("#invoiceDetailNewGrid").jqxGrid('getcolumnaggregateddata', 'vatamount', ['sum']);
				let vatsum=parseFloat(vatSumData.sum);
				let vatremain=taxamount-vatsum;
				vatremain=funCustomRound(vatremain);

				let lastvat=$("#invoiceDetailNewGrid").jqxGrid('getcellvalue',lastindex,'vatamount');
				lastvat=parseFloat(lastvat)+parseFloat(vatremain);
				lastvat=funCustomRound(lastvat);
				$("#invoiceDetailNewGrid").jqxGrid('setcellvalue',lastindex,'vatamount',lastvat);				
				let lastamt=$("#invoiceDetailNewGrid").jqxGrid('getcellvalue',lastindex,'amount');
				let nettotal=parseFloat(lastvat)+parseFloat(lastamt);
				nettotal=funCustomRound(nettotal);
				$("#invoiceDetailNewGrid").jqxGrid('setcellvalue',lastindex,'netamount',nettotal);				
				
			}
		}
		
	});
	setSaperateInvoice();
	getDocDateConfig();
	if($('#discount').val()=="" || isNaN($('#discount').val())){
			$('#discount').val(0);
		}
		if($('#total').val()=="" || isNaN($('#total').val())){
			$('#total').val(0);
		}
		if($('#excessamount').val()=="" || isNaN($('#excessamount').val())){
			$('#excessamount').val(0);
		}
		if($('#nettotal').val()=="" || isNaN($('#nettotal').val())){
			$('#nettotal').val(0);
		}
		if($('#taxpercent').val()=="" || isNaN($('#taxpercent').val())){
			$('#taxpercent').val(0);
		}
		if($('#taxamount').val()=="" || isNaN($('#taxamount').val())){
			$('#taxamount').val(0);
		}
		if($('#taxtotal').val()=="" || isNaN($('#taxtotal').val())){
			$('#taxtotal').val(0);
		}
		if($('#roundamt').val()=="" || isNaN($('#roundamt').val())){
			$('#roundamt').val(0);
		}
});

function searchContent(url) {
 	$('#searchWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#searchWindow').jqxWindow('setContent', data);
	$('#searchWindow').jqxWindow('bringToFront');
}); 
}

function funrefno(){
	if((document.getElementById('cmbreftype').value=="")||(document.getElementById('cmbreftype').value=="DIR"))
	 {
		$("#refno").attr('disabled',true);
		$("#refno").attr('readonly',true);
	 }
	else{
		$("#refno").attr('disabled',false);
		$("#refno").attr('readonly',true);
	}
	
}
function invoicePrintContent(url) {
	$('#printWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#printWindow').jqxWindow('setContent', data);
	$('#printWindow').jqxWindow('bringToFront');
}); 
}
function workshopinvoicePrintContent(url) {
	$('#workshopprintWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#workshopprintWindow').jqxWindow('setContent', data);
	$('#workshopprintWindow').jqxWindow('bringToFront');
}); 
}

function invoiceMailContent(url) {
	$('#mailWindow').jqxWindow('open');
	$.get(url).done(function (data) {
		$('#mailWindow').jqxWindow('setContent', data);
		$('#mailWindow').jqxWindow('bringToFront');
	}); 
}
function getRefno(event){
	var x= event.keyCode;
	var reftype = $("#cmbreftype").val();
	if(x==114){
		if(reftype=="JC"){
			searchContent("jobCardSearch.jsp?reftype="+reftype);
		}
	}
}
function getAccount(event){
	var x= event.keyCode;
	if(x==114){
		searchContent("accountSearchGrid.jsp?id=1");
	}
}


function funSearchLoad(){
	changeContent('masterSearch.jsp', $('#window'));
}

function funReadOnly(){
	$('#frmInvoiceV3 input').attr('readonly', true);
	$('#frmInvoiceV3 select').attr('disabled', true);
	$('#refno').attr('disabled',true);
	
}

function funRemoveReadOnly(){
	$('#frmInvoiceV3 input').attr('readonly', false);
	$('#frmInvoiceV3 select').attr('disabled', false);
	$('#vocno').attr('readonly',true);
	$('#refno').attr('disabled',true);
	if($('#mode').val()=="A"){
		$('#invoiceGrid,#invoiceDetailNewGrid').jqxGrid('clear');
		$('#date').jqxDateTimeInput('setDate',new Date());
		setSaperateInvoice();
		getDocDateConfig();
	}
	if($('#mode').val()=="A" || $('#mode').val()=="E"){
		$('#invoiceGrid').jqxGrid('addrow',null,{});
		if($('#discount').val()=="" || isNaN($('#discount').val())){
			$('#discount').val(0);
		}
		if($('#total').val()=="" || isNaN($('#total').val())){
			$('#total').val(0);
		}
		if($('#excessamount').val()=="" || isNaN($('#excessamount').val())){
			$('#excessamount').val(0);
		}
		if($('#nettotal').val()=="" || isNaN($('#nettotal').val())){
			$('#nettotal').val(0);
		}
		if($('#taxpercent').val()=="" || isNaN($('#taxpercent').val())){
			$('#taxpercent').val(0);
		}
		if($('#taxamount').val()=="" || isNaN($('#taxamount').val())){
			$('#taxamount').val(0);
		}
		if($('#taxtotal').val()=="" || isNaN($('#taxtotal').val())){
			$('#taxtotal').val(0);
		}
		if($('#roundamt').val()=="" || isNaN($('#roundamt').val())){
			$('#roundamt').val(0);
		}
	}
	if($('#mode').val()=='E'){
		$('#excessamount').attr('disabled',true);
		$('#invdetailrow').show();
		$('#invoiceDetailNewGrid').jqxGrid('selectallrows');
	}
	getDocDateConfig();
}

function setValues(){
	if($('#msg').val()!=''){
		$.messager.alert('Message',$('#msg').val());
	}
	document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	funSetlabel();
	if($('#docno').val()!=''){
		//alert($('#docno').val());
		$('#invoicediv').load('invoiceGrid.jsp?docno='+$('#docno').val()+'&id=1');
		$('#detaildiv').load('detailNewGrid.jsp?jobcarddocno='+$('#hidrefno').val()+'&id=1&docno='+$('#docno').val());
		if(document.getElementById("hidchksaperateinvoice").value=="1"){
			document.getElementById("chksaperateinvoice").checked=true;
		}
		else{
			document.getElementById("chksaperateinvoice").checked=false;
		}
		var docno=$('#docno').val();
		$.get('getLogDetails.jsp',{'docno':docno},function(data){
			data=JSON.parse(data);
			document.getElementById("errormsg").innerText=data.msg;
		});
	}
	if($('#hidcmbreftype').val()!=''){
		$('#cmbreftype').val($('#hidcmbreftype').val());
	}
}

function funFocus()
{
	document.getElementById("cmbreftype").focus();
}

function funNotify(){
	var docdateval=funDateInPeriod($('#date').jqxDateTimeInput('getDate'));
	if(docdateval==0){
		$('#date').jqxDateTimeInput('focus');
		return 0;
	}
	var docdateconfig=$('#docdateconfig').val();
	if(docdateconfig=="1"){
		var currentdate=new Date();
		currentdate.setHours(0,0,0,0);
		var docdate=new Date($('#date').jqxDateTimeInput('getDate'));
		docdate.setHours(0,0,0,0);
		if(currentdate.getTime()!=docdate.getTime() && $('#mode').val()=='A'){
			$.messager.alert('Warning','Document Date should be Current Date');
			$('#date').jqxDateTimeInput('focus');
			return 0;
		}
		else{
			
		}
	}
	if(document.getElementById("cmbreftype").value==""){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Ref Type is Mandatory";
		 return 0;
	}
	 if(document.getElementById("refno").value==""){
		 document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Ref No is Mandatory";
		return 0;
	}
	if($('#mode').val()=='E'){
		var taxtotal=$('#taxtotal').val();
		if(taxtotal=="" || taxtotal==null || taxtotal=="undefined" || typeof(taxtotal)=="undefined"){
			taxtotal="0.0";
		}
		var summaryData = $("#invoiceDetailNewGrid").jqxGrid('getcolumnaggregateddata', 'netamount', ['sum']);
		console.log(parseFloat(taxtotal)+"::"+parseFloat(summaryData.sum));
		if(parseFloat(taxtotal).toFixed(2)!=parseFloat(summaryData.sum).toFixed(2)){
			$.messager.alert('Warning','Estimated Total and Total (Tax.Incl) not tallied');
			return 0;
		}
	}
	/*  if(document.getElementById("excessamountaccount").value==""){
		 document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Excess Account is Mandatory";
		return 0;
	} 
	if(parseFloat($('#total').val())<parseFloat($('#esttotal').val()) && $('#esttotal').val()!=""){
			$.messager.alert('Warning','Cannot be less than estimated total');
			return 0;
		}
		*/
	var rows = $("#invoiceGrid").jqxGrid('getrows');
	var gridlength=0;
	for(var i=0;i<rows.length;i++){
		if(rows[i].amount!="" && rows[i].amount!=null && rows[i].amount!="undefined" && typeof(rows[i].amount)!="undefined"){
			gridlength++;
			newTextBox = $(document.createElement("input"))
			.attr("type", "dil")
			.attr("id", "invoicearray"+i)
			.attr("name", "invoicearray"+i)
			.attr("hidden",true);
				
			newTextBox.val(rows[i].desc1+"::"+rows[i].amount);
			
			newTextBox.appendTo('form');
			
		}
	}
	$('#gridlength').val(gridlength);
	
	var detrows = $("#invoiceDetailNewGrid").jqxGrid('getselectedrowindexes');
	var detbaserows=$("#invoiceDetailNewGrid").jqxGrid('getrows');
	if(detrows.length==0 && detbaserows.length>0){
		$.messager.alert('Warning','Please select details to be updated');
		return 0;
	}
	var detgridlength=0;
	for(var i=0;i<detrows.length;i++){
		var rowno=$("#invoiceDetailNewGrid").jqxGrid('getcellvalue',detrows[i],'rowno');
		var type=$("#invoiceDetailNewGrid").jqxGrid('getcellvalue',detrows[i],'type');
		var description=$("#invoiceDetailNewGrid").jqxGrid('getcellvalue',detrows[i],'description');
		var qty=$("#invoiceDetailNewGrid").jqxGrid('getcellvalue',detrows[i],'qty');
		var rate=$("#invoiceDetailNewGrid").jqxGrid('getcellvalue',detrows[i],'rate');
		var discount=$("#invoiceDetailNewGrid").jqxGrid('getcellvalue',detrows[i],'discount');
		var amount=$("#invoiceDetailNewGrid").jqxGrid('getcellvalue',detrows[i],'amount');
		var vatpercent=$("#invoiceDetailNewGrid").jqxGrid('getcellvalue',detrows[i],'vatpercent');
		var vatamount=$("#invoiceDetailNewGrid").jqxGrid('getcellvalue',detrows[i],'vatamount');
		var netamount=$("#invoiceDetailNewGrid").jqxGrid('getcellvalue',detrows[i],'netamount');
		var serialno=$("#invoiceDetailNewGrid").jqxGrid('getcellvalue',detrows[i],'serialno');
		var estdocno=$("#invoiceDetailNewGrid").jqxGrid('getcellvalue',detrows[i],'estdocno');
		var addition=$("#invoiceDetailNewGrid").jqxGrid('getcellvalue',detrows[i],'addition');
		var jobdocno=$("#invoiceDetailNewGrid").jqxGrid('getcellvalue',detrows[i],'jobdocno');
		var invno=$("#invoiceDetailNewGrid").jqxGrid('getcellvalue',detrows[i],'invno');
		if(String(netamount).length>0 && netamount!=null && netamount!="undefined" && typeof(netamount)!="undefined"){
			var newTextBox = $(document.createElement("input"))
			.attr("type", "dil")
			.attr("id", "invoicedetarray"+detgridlength)
			.attr("name", "invoicedetarray"+detgridlength)
			.attr("hidden",true);
			newTextBox.val(rowno+" :: "+type+" :: "+description+" :: "+qty+" :: "+rate+" :: "+discount+" :: "+amount+" :: "+vatpercent+" :: "+vatamount+" :: "+netamount+" :: "+serialno+" :: "+estdocno+" :: "+addition+" :: "+jobdocno+" :: "+invno);			
			newTextBox.appendTo('form');
			detgridlength++;
		}
	}
	$('#detgridlength').val(detgridlength);
	
	if($('#mode').val()=='E'){
		$('#refno,#excessamount').attr('disabled',false);
	}
	return 1;
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
function getTax(cldocno,date,hidrefno){
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			items = x.responseText.trim();
			$('#taxpercent').val(items);
			$('#taxpercent,#taxamount').attr('readonly',true);
		} else {
		}
	}
	x.open("GET", "getTax.jsp?cldocno="+cldocno+"&date="+date+"&hidrefno="+hidrefno, true);
	x.send();
}

function funPrintBtn(){
	 if($('#docno').val()!='' && $('#docno').val()!='0'){  
		 			var partsconfig=$('#partsconfig').val();
		 			 //alert(partsconfig); 
		 			
		 if($('#partsconfig').val().trim()==1){
			 workshopinvoicePrintContent('printVoucherWindowIroman.jsp');
		 }
		 else if($('#partsconfig').val().trim()==2){
			 var url=document.URL;
		var reurl=url.split("com/");
		var path= "invoicePrintActionV3.action?docno="+$('#docno').val()+"&header="+1+"&branch="+$('#brchName').val()+"&jobcarddocno="+$('#hidrefno').val()+"&type="+1;            
		var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");		
		win.focus();
		 }
		 else
			 {
			 getBulkConfig();    
			 invoicePrintContent('printVoucherWindow.jsp');  
			 }		 
	 }  
}
function funSendmail(){
	if($('#docno').val()!='' && $('#docno').val()!='0'){  
		 getBulkConfig();    
		 invoiceMailContent('mailVoucherWindow.jsp');    		
	 }
}
function funCustomRound(value){
	var res=parseFloat(value).toFixed(window.parent.amtdec.value);
	var res1=(res=='NaN'?"0":res);
	return res1;  
}

function setSaperateInvoice(){
	if(document.getElementById("chksaperateinvoice").checked==true){
		document.getElementById("hidchksaperateinvoice").value="1";
	}
	else{
		document.getElementById("hidchksaperateinvoice").value="0";
	}
}


function getDocDateConfig(){
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			items = x.responseText.trim();
			$('#docdateconfig').val(items.split("::")[0]);
			$('#discountconfig').val(items.split("::")[1]);
		} else {
		}
	}
	x.open("GET", "getDocDateConfig.jsp", true);
	x.send();
}

function getBulkConfig(){ 
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			items = x.responseText.trim();
			$('#bulkconfig').val(items);  
			//alert("items===="+items);
			//alert("items===="+('#bulkconfig').val(items));
		} else {
		}
	}
	x.open("GET", "getPrintBulkConfig.jsp", true);
	x.send();
}


function getWorkshopInvoiceConfig(){ 
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			items = x.responseText.trim();
			$('#partsconfig').val(items); 
		} else {
		}
	}
	x.open("GET", "getWorkshopInvoiceConfig.jsp", true);
	x.send();
}



function funLoadInvDetail(){
	$('#detaildiv').load('detailNewGrid.jsp?jobcarddocno='+$('#hidrefno').val()+'&id=2&docno='+$('#docno').val());
}
</script>
</head>

<body onload="funReadOnly();setValues();getBulkConfig();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmInvoiceV3" action="saveInvoiceV3" autocomplete="off">
<jsp:include page="../../../header.jsp" />
<br/> 
<div class='hidden-scrollbar'>

<fieldset>
<table width="100%" border="0">
  <tr>
    <td width="2%" height="32" align="right" scope="col">&nbsp;</td>
    <td width="10%" align="right" scope="col">Date</td>
    <td align="left" scope="col"><div id="date" name="date" value='<s:property value="date"/>'></div></td>
    <td colspan="3" scope="col">&nbsp;</td>
    <td width="6%" scope="col" align="right">Doc No</td>
    <td width="14%" scope="col" align="left"><input type="text" name="vocno" id="vocno" value='<s:property value="vocno"/>' readonly tabindex="-1"></td>
  </tr>
  
  <tr>
    <td colspan="2" align="right">Ref Type</td>
    <td width="1%"><select name="cmbreftype" id="cmbreftype" onchange="funrefno();" value='<s:property value="cmbreftype"/>'>
        <option value="">--Select--</option>
        <option value="DIR">DIR</option>
        <option value="JC">Job Card</option>
    </select></td>
    <td width="10%" align="right">Ref No</td>
    <td width="33%" align="left"><input name="refno" type="text"  id="refno" placeholder="Press F3 to search" onkeydown="getRefno(event);"  value='<s:property value="refno"/>'></td>
    <td colspan="3" hidden="true"><input type="checkbox" name="chksaperateinvoice" id="chksaperateinvoice" onChange="setSaperateInvoice();">&nbsp;&nbsp;Saperate Invoice</td>
  </tr>
  <input name="hidchksaperateinvoice" type="hidden"  id="hidchksaperateinvoice"  value='<s:property value="hidchksaperateinvoice"/>'>
  <input name="hidrefno" type="hidden"  id="hidrefno"  value='<s:property value="hidrefno"/>'>
  <tr>
    <td height="29" colspan="2" align="right">Vehicle</td>
    <td align="left"><input type="text" name="regno" id="regno" value='<s:property value="regno"/>'></td>
    <td align="right">Details</td>
    <td colspan="4" align="left"><input name="vehicledetails" type="text" id="vehicledetails" style="width:93.5%" value='<s:property value="vehicledetails"/>'></td>
  </tr>
  <tr>
    <td colspan="2" align="right">Client</td>
    <td align="left"><input type="text" name="cldocno" id="cldocno"  value='<s:property value="cldocno"/>'></td>
    <td align="right">Details</td>
    <td colspan="4" align="left"><input name="userdetails" type="text" id="userdetails" style="width:93.5%"  value='<s:property value="userdetails"/>'></td>
  </tr>
  <tr>
    <td colspan="2" align="right">Invoice to Account</td>
    <td align="left"><input type="text" name="tempinvoicetoaccount" id="tempinvoicetoaccount"  value='<s:property value="tempinvoicetoaccount"/>' readonly></td>
    <td align="right">Account Name</td>
    <td colspan="4" align="left"><input type="text" name="tempinvoicetoacname" id="tempinvoicetoacname" style="width:93.5%" value='<s:property value="tempinvoicetoacname"/>' readonly></td>
  </tr>
  <input type="text" name="tempinvoicetoacno" id="tempinvoicetoacno"  value='<s:property value="tempinvoicetoacno"/>' readonly  hidden="true">
  <input type="text" name="invoicetoaccount" id="invoicetoaccount"  value='<s:property value="invoicetoaccount"/>' readonly hidden="true">
  <input type="text" name="invoicetoacname" id="invoicetoacname" style="width:93.5%" value='<s:property value="invoicetoacname"/>' readonly hidden="true">

  <%-- <tr>
    <td colspan="2" align="right">Invoice to Account</td>
    <td align="left"><input type="text" name="invoicetoaccount" id="invoicetoaccount"  value='<s:property value="invoicetoaccount"/>' readonly></td>
    <td align="right">Account Name</td>
    <td colspan="4" align="left"><input type="text" name="invoicetoacname" id="invoicetoacname" style="width:93.5%" value='<s:property value="invoicetoacname"/>' readonly></td>
  </tr> --%>
<%--   <tr>
    <td colspan="2" align="right">Excess Amount AC</td>
    <td align="left"><input type="text" name="excessamountaccount" id="excessamountaccount" value='<s:property value="excessamountaccount"/>' onkeydown="getAccount(event);"></td>
    <td align="right">Account Name</td>
    <td colspan="4" align="left"><input type="text" name="excessamountacname" id="excessamountacname" style="width:93.5%" value='<s:property value="excessamountacname"/>'></td>
  </tr> --%>
  <tr>
    <td colspan="2" align="right">Remarks</td>
    <td colspan="6" align="left"><input type="text" name="remarks" id="remarks" style="width:95%" value='<s:property value="remarks"/>'></td>
  </tr>
  <tr>
    <td colspan="8">
    	<br/>
   		<fieldset class="greenClass">
			<div id="invoicediv"><jsp:include page="invoiceGrid.jsp"></jsp:include></div>
			<table width="100%" border="0">
			    <tr>
			      <td width="13%" height="24" align="right" style="font-style: normal; font-weight: normal;" scope="col">Total</td>
			      <td width="16%" align="left" scope="col"><input type="text" name="total" id="total" value='<s:property value="total"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
			      <td width="9%" align="right" style="font-style: normal; font-weight: normal;" scope="col" >Discount</td>
			      <td width="13%" align="left" scope="col"><input type="text" name="discount" id="discount" value='<s:property value="discount"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
			      <td width="11%" align="right" style="font-style: normal; font-weight: normal;" scope="col" >Sub Total</td>
			      <td width="11%" align="left" scope="col"><input type="text" name="nettotal" id="nettotal" value='<s:property value="nettotal"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
                  <td width="11%" align="right" style="font-style: normal; font-weight: normal;" scope="col" >Excess Amount</td>
			      <td width="16%" align="left" scope="col"><input type="text" name="excessamount" id="excessamount" value='<s:property value="excessamount"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
			      
				</tr>
			    <tr>
			      <td height="24" align="right" style="font-style: normal; font-weight: normal;" scope="col">Tax Percent</td>
			      <td align="left" scope="col"><input type="text" name="taxpercent" id="taxpercent" value='<s:property value="taxpercent"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" ></td>
			      <td align="right" style="font-style: normal; font-weight: normal;" scope="col" >Tax Amount</td>
			      <td align="left" scope="col"><input type="text" name="taxamount" id="taxamount" value='<s:property value="taxamount"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
			      <td align="right" style="font-style: normal; font-weight: normal;" scope="col" >Total (Incl. Tax)</td>
			      <td align="left" scope="col"><input type="text" name="taxtotal" id="taxtotal" value='<s:property value="taxtotal"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
			      <td align="right" style="font-style: normal; font-weight: normal;" scope="col" >Round Off Amount</td>
			      <td align="left" scope="col"><input type="text" name="roundamt" id="roundamt" value='<s:property value="roundamt"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
			      </tr>
			</table>
		</fieldset>
	</td>
    </tr>
    <tr><td colspan="8" hidden="true" id="invdetailrow" align="center"><button type="button" id="btnloadinvdetail" class="myButton" onclick="funLoadInvDetail();">Load Data</button></td></tr>
  	<tr><td colspan="8"><div id="detaildiv"><jsp:include page="detailNewGrid.jsp"></jsp:include></div></td></tr>
</table>
</fieldset>
	<input type="hidden" id="insuracno" name="insuracno" value='<s:property value="insuracno"/>'>
	<input type="hidden" id="clientacno" name="clientacno" value='<s:property value="clientacno"/>'>
	<input type="hidden" id="docno" name="docno" value='<s:property value="docno"/>'>
	<input type="hidden" id="invoicetoacno" name="invoicetoacno" value='<s:property value="invoicetoacno"/>' >
	<input type="hidden" id="excessamountacno" name="excessamountacno" value='<s:property value="excessamountacno"/>'>  
	<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
    <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
 	<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
	<input type="hidden" name="esttotal" id="esttotal" value='<s:property value="esttotal"/>'>
	<input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
	<input type="hidden" name="detgridlength" id="detgridlength" value='<s:property value="detgridlength"/>'>
	<input type="hidden" name="hidcmbreftype" id="hidcmbreftype" value='<s:property value="hidcmbreftype"/>'/>
	<input type="hidden" name="docdateconfig" id="docdateconfig" value='<s:property value="docdateconfig"/>'/>
    <input type="hidden" name="bulkconfig" id="bulkconfig" value='<s:property value="bulkconfig"/>'/>
    <input type="hidden" name="partsconfig" id="partsconfig" value='<s:property value="partsconfig"/>'/>
   <input type="hidden" name="discountconfig" id="discountconfig" value='<s:property value="discountconfig"/>'/> 
</div>
</form>

<div id="searchWindow">
<div></div>
</div> 
<div id="printWindow">
	<div></div></div>
</div>
<div id="workshopprintWindow">
	<div></div></div>
</div>
<div id="mailWindow">
	<div></div></div>
</div>

</body>
</html>
