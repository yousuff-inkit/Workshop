<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<jsp:include page="../../../includes.jsp"></jsp:include>
<link href="../../../../vendors/select2/css/select2.min.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../../../../vendors/select2/js/select2.min.js"></script>
<%-- <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" >
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script> --%>
<style>
.hidden-scrollbar {
  /* // overflow: auto; */
  height: 530px;
    overflow-x: hidden;
    
} 
.headClass
{
    background-color: #FFEBC2;
}
.redClass
{
    background-color: #FFEBEB;
}
.violetClass
{
    background-color: #EBD6FF;
}
.yellowClass
{
    background-color: #FFFFD1;
}
.whiteClass
{
   background-color: #FFF;
}
.greenClass
{
   background-color: #CEFFCE;
}
        
</style>
<script type="text/javascript">
var rawconfig={};
$(document).ready(function() {

$("#date").jqxDateTimeInput({  width:'125px',height : '15px', formatString : "dd.MM.yyyy" });
//$("#policedate").jqxDateTimeInput({  width:'125px',height : '15px', formatString : "dd.MM.yyyy" });
//$("#intime").jqxDateTimeInput({  width:'55px',height : '15px', formatString : "HH:mm",showCalendarButton:false,value:new Date() });
$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;margin-left:50%;margin-right:50%;margin-top:15%;top:200;right:600;'><img src='../../../icons/31load.gif'/></div>");    
//$('#intime').jqxDateTimeInput('setDate', new Date());
$('#searchwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Gate In Pass Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#searchwindow').jqxWindow('close');
$('#partssearchwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Product Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#partssearchwindow').jqxWindow('close');
$('#laboursearchwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Service Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#laboursearchwindow').jqxWindow('close');
$('#printWindow').jqxWindow({width: '51%', height: '28%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
$('#printWindow').jqxWindow('close'); 
$('#emailWindow').jqxWindow({width: '51%', height: '28%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Email',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
$('#emailWindow').jqxWindow('close');   
/*$('#cmbserviceadvisor').select2({
	placeholder:"Select Service Advisor",
	allowClear:true
});*/
//setLumSum();
//document.getElementById("chklumsum").disabled=false;
$( "#jobcardvocno" ).dblclick(function() {
	if(document.getElementById("mode").value=="view"){
		return false;
	}
	$('#searchwindow').jqxWindow('open');
	$('#searchwindow').jqxWindow('focus');
	SearchContent('gateInPassSearch.jsp','searchwindow');
});
$('#btnEdit').mousedown(function(){
	var editstatus=$('#editstatus').val();
	if(editstatus==0){
		$.messager.alert('Warning','Job Card Issued!!Cannot Edit');
		return false;
	}
});
/* $( "#sparepartstotal,#labourtotal,#discount" ).change(function() {
	  var parts=parseFloat($('#sparepartstotal').val());
	  var labour=parseFloat($('#labourtotal').val());
	  var discount=parseFloat($('#discount').val());
	  var total=(parts+labour)-discount;
	  $('#esttotal').val(total);
}); */
$( "#servicestotal,#servicesdiscount" ).change(function() {
	  var services=parseFloat($('#servicestotal').val());
	  var discount=parseFloat($('#servicesdiscount').val());
	  var total=services-discount;
	  $('#netservices').val(total);
});
$( "#sparetotal,#sparediscount" ).change(function() {
	
	var spare=parseFloat($('#sparetotal').val()==""?"0.0":$('#sparetotal').val());
	var discount=parseFloat($('#sparediscount').val()==""?"0.0":$('#sparediscount').val());
	var total=spare-discount;
	$('#netspare').val(total.toFixed(2));	
	
});
$('#btnCalculate').click(function(){
	$('#sparePartsAmountGrid').jqxGrid('clear');
	var servicetotal=$('#netservices').val();
	var approvedtotal=$('#netspare').val();
	//$('#approvedtotal').val();
	var date=$('#date').jqxDateTimeInput('val');
	var docno=$('#docno').val();
	var gatedocno=$('#gatedocno').val();
	var lumsumamount=$('#lumsumamount').val();
	var chklumsum=0;
	var addition=$('#addition').val();
	var servicelumsumamt=$('#servicelumsumamt').val();
	var randomlumsumamt=$('#randomlumsumamt').val();
	if(document.getElementById("chklumsum").checked==true){
		chklumsum=1;
	}
	else{
		chklumsum=0;
	}
	var chkservicelumsum=0;
	var chkrandomlumsum=0;
	if(document.getElementById("chkservicelumsum").checked==true){
		chkservicelumsum=1;
	}
	else{
		chkservicelumsum=0;
	}
	if(document.getElementById("chkrandomlumsum").checked==true){
		chkrandomlumsum=1;
	}
	else{
		chkrandomlumsum=0;
	}
	
	//alert(chklumsum+"//"+lumsumamount);
	insertSparePartsAmount(servicetotal,approvedtotal,date,docno,gatedocno,lumsumamount,chklumsum,addition,$('#mode').val(),chkservicelumsum,servicelumsumamt,chkrandomlumsum,randomlumsumamt);
});
});

function insertSparePartsAmount(servicetotal,approvedtotal,date,docno,gatedocno,lumsumamount,chklumsum,addition,mode,chkservicelumsum,servicelumsumamt,chkrandomlumsum,randomlumsumamt){
	console.log("insertSparePartsAmount.jsp?servicetotal="+servicetotal+"&approvedtotal="+approvedtotal+"&date="+date+"&docno="+docno+"&gatedocno="+gatedocno+"&lumsumamount="+lumsumamount+"&chklumsum="+chklumsum+"&addition="+addition+"&mode="+mode+"&chkservicelumsum="+chkservicelumsum+"&servicelumsumamt="+servicelumsumamt+"&chkrandomlumsum="+chkrandomlumsum+"&randomlumsumamt="+randomlumsumamt);
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();
			if($('#mode').val()=='A'){
				$('#sparepartsamountdiv').load('sparePartsAmountGrid.jsp?gatedocno='+items+'&id=1&addition='+(parseInt(addition)+1));				
			}
			else{
				$('#sparepartsamountdiv').load('sparePartsAmountGrid.jsp?gatedocno='+items+'&id=1&addition='+(parseInt(addition)));

			}
		}
	}
	x.open("GET", "insertSparePartsAmount.jsp?servicetotal="+servicetotal+"&approvedtotal="+approvedtotal+"&date="+date+"&docno="+docno+"&gatedocno="+gatedocno+"&lumsumamount="+lumsumamount+"&chklumsum="+chklumsum+"&addition="+addition+"&mode="+mode+"&chkservicelumsum="+chkservicelumsum+"&servicelumsumamt="+servicelumsumamt+"&chkrandomlumsum="+chkrandomlumsum+"&randomlumsumamt="+randomlumsumamt, true);
	x.send();
}
function getGateInPass(event){
	if(document.getElementById("mode").value=="view"){
		return false;
	}
	var x= event.keyCode;
    if(x==114){
    	$('#searchwindow').jqxWindow('open');
    	$('#searchwindow').jqxWindow('focus');
    	SearchContent('gateInPassSearch.jsp');
      }
}

function SearchContent(url,id) {
    $.get(url).done(function (data) {
  $('#'+id).jqxWindow('setContent', data);
}); 
}

function funSearchLoad(){
	changeContent('masterSearch.jsp', $('#window'));
 }
function funReadOnly() {
	$('#frmWSEstimationAdditionPal input').attr('readonly',true);
}
function funRemoveReadOnly() {
	//$('#frmWSEstimationAdditionPal input').attr('readonly',false);
	//$('#docno').attr('readonly',true);
	$("#frmWSEstimationAdditionPal input:not(.readonly)").attr('readonly',false);
	if($('#mode').val()=='A'){
		$('#sparePartsNewGrid,#labourcostGrid,#sparePartsAmountGrid,#complaintGrid').jqxGrid('clear');
		$('#sparePartsNewGrid,#labourcostGrid,#sparePartsAmountGrid').jqxGrid({disabled:false});
		$("#sparePartsNewGrid,#labourcostGrid").jqxGrid("addrow", null, {});
		/* if($('#discount').val()==""){
			$('#discount').val(0);
		}
		if($('#sparepartstotal').val()==""){
			$('#sparepartstotal').val(0);
		}
		if($('#labourtotal').val()==""){
			$('#labourtotal').val(0);
		}
		$('#esttotal').val(0); */
		$('#servicestotal,#servicesdiscount,#netservices').val(0);
		$('#sparetotal,#sparediscount,#netspare').val(0);
		if(rawconfig.serviceConsumables.method=="1"){
			$("#sparePartsNewGrid").jqxGrid("setcellvalue",0,"description","Consumables");
			$("#sparePartsNewGrid").jqxGrid("addrow", null, {});
		}
	}
	else if($('#mode').val()=='E' || $('#mode').val()=='D'){
		$('#sparePartsNewGrid,#labourcostGrid').jqxGrid({disabled:false});
		$("#sparePartsNewGrid,#labourcostGrid").jqxGrid("addrow", null, {});
	}
	if($('#mode').val()=='E'){
		$('#sparePartsAmountGrid').jqxGrid('clear');
	}
}
function setValues() {
	getEstPrintConfig();
	// document.getElementById("formdetail").value="Gate In-Pass";
    //  document.getElementById("formdetailcode").value="GIP";
	
	 if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
	 }
	var a=$('#gatedocno').val();
	var b=$('#docno').val();
	var addition=$('#addition').val();
	
	if($('#docno').val()!=''){
		var b=$('#docno').val();
		$('#complaintdiv').load('../../../com/workshop/estimationadditionpal/complaintGrid.jsp?docno='+$('#gatedocno').val()+'&branch='+$('#brchName').val()+'&id=1');	
		$('#jobtypeinputdiv').load('jobtypeinput.jsp?id=1');
		CheckEditStatus($('#docno').val());
	
	}
	if($('#docno').val()!=''){
		$('#sparepartsdiv').load('../../../com/workshop/estimationadditionpal/sparePartsNewGrid.jsp?docno='+$('#docno').val()+'&id=1&addition='+addition);
	}
	if($('#docno').val()!=''){
		$('#labourcostdiv').load('../../../com/workshop/estimationadditionpal/labourcostGrid.jsp?docno='+$('#docno').val()+'&id=1&addition='+addition);		
	}
	if($('#gatedocno').val()!=''){
		$('#sparepartsamountdiv').load('../../../com/workshop/estimationadditionpal/sparePartsAmountGrid.jsp?gatedocno='+$('#gatedocno').val()+'&id=1&addition='+addition);		
	}
	//alert(document.getElementById("hidchklumsum").value);
	if(document.getElementById("hidchklumsum").value=='1'){
		document.getElementById("chklumsum").checked=true;
	}
	else{
		document.getElementById("chklumsum").checked=false;
	}
	
	if(document.getElementById("hidchkservicelumsum").value=='1'){
		document.getElementById("chkservicelumsum").checked=true;
	}
	else{
		document.getElementById("chkservicelumsum").checked=false;
	}
	if(document.getElementById("hidchkrandomlumsum").value=='1'){
		document.getElementById("chkrandomlumsum").checked=true;
	}
	else{
		document.getElementById("chkrandomlumsum").checked=false;
	}
	setLumSum();
	setServiceLumSum();
	setRandomLumSum();
	if($('#brhid').val()!='' && $('#brhid').val()!='undefined' && $('#brhid').val()!=null && typeof($('#brhid').val())!='undefined'){
		$('#brchName').val($('#brhid').val());	
	}
	
	document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	funSetlabel();
}

 function funFocus()
    {
    	document.getElementById("gatevocno").focus(); 
    }
    
     
 function funNotify(){
	if($('#gatedocno').val()==""){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Gate In Pass is Mandatory";
		return 0;
	} 
	var amountrows=$("#sparePartsAmountGrid").jqxGrid('getrows');
	if(amountrows.length==0){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Please Calculate Amount";
		return 0;
	}
	var labourrows = $("#labourcostGrid").jqxGrid('getrows');
	var labourgridlength=0;
	for(var i=0;i<labourrows.length;i++){
		if(labourrows[i].jobid!="" && labourrows[i].jobid!=null && labourrows[i].jobid!="undefined" && typeof(labourrows[i].jobid)!="undefined"){
			var j=labourgridlength;
			newTextBox = $(document.createElement("input"))
			.attr("type", "dil")
			.attr("id", "labourcostarray"+j)
			.attr("name", "labourcostarray"+j)
			.attr("hidden",true);
				
			newTextBox.val(labourrows[j].jobid+" :: "+labourrows[j].hrs+" :: "+labourrows[j].rate+" :: "+labourrows[j].markuppercent+" :: "+labourrows[j].total+" :: "+labourrows[j].remarks+" :: "+labourrows[j].jobtype+" :: "+labourrows[j].jobdesc+" :: "+labourrows[j].seqno);
			
			newTextBox.appendTo('form');
			labourgridlength++;
		}
	}
	$('#labourcostgridlength').val(labourgridlength);
	
	var partrows = $("#sparePartsNewGrid").jqxGrid('getrows');
	var partgridlength=0;
	for(var i=0;i<partrows.length;i++){
		if(partrows[i].description!="" && partrows[i].description!=null && partrows[i].description!="undefined" && typeof(partrows[i].description)!="undefined"){
			partgridlength++;
			newTextBox = $(document.createElement("input"))
			.attr("type", "dil")
			.attr("id", "sparepartsarray"+i)
			.attr("name", "sparepartsarray"+i)
			.attr("hidden",true);
			newTextBox.val(partrows[i].description+" :: "+partrows[i].qty+" :: "+partrows[i].sprate+" :: "+partrows[i].approvedvalue);
			newTextBox.appendTo('form');
			
		}
	}
	$('#sparePartsNewGridlength').val(partgridlength);
	if(document.getElementById("chklumsum").checked==true){
 		document.getElementById("hidchklumsum").value="1";
	}
	else{
		document.getElementById("hidchklumsum").value="0";
	}
	
	//Checking for User Clicked Calculate
	
	var gridsum=($("#sparePartsAmountGrid").jqxGrid("getcellvalue",2, "approvedtotal"))+"";
	gridsum=gridsum.replace(/,/g, '');
	var netsum=0.0;
	
	var sparesum=0.0,servicesum=0.0;
	if(document.getElementById("chkrandomlumsum").checked==true){
		netsum=$('#randomlumsumamt').val();
	}
	else{
		if(document.getElementById("chkservicelumsum").checked==true){
			servicesum=$('#servicelumsumamt').val();
		}
		else{
			servicesum=$('#netservices').val();
		}
		if(document.getElementById("chklumsum").checked==true){
			sparesum=$('#lumsumamount').val();
		}
		else{
			/*var sparesumdata=$("#sparePartsNewGrid").jqxGrid("getcolumnaggregateddata", "approvedvalue", ["sum"]);
			sparesum=(sparesumdata.sum)+"";
			sparesum=sparesum.replace(/,/g, '');*/
			sparesum=$('#netspare').val();
		}
		netsum=(parseFloat(servicesum)+parseFloat(sparesum)).toFixed(2);
	}
	
	if(parseFloat(netsum)!=parseFloat(gridsum)){
		$.messager.alert('Warning','Please Calculate');
		return 0;
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
 
 function CheckEditStatus(docno){
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			$('#editstatus').val(items.trim());
			} else {
			}
		}
	x.open("GET", "checkEditStatus.jsp?docno="+docno, true);
	x.send();
 }
 
 function setLumSum(){
	 
 	if(document.getElementById("chklumsum").checked==true){
 		document.getElementById("lumsumamount").disabled=false;
 		document.getElementById("hidchklumsum").value="1";
	}
	else{
		document.getElementById("lumsumamount").disabled=true;
		document.getElementById("hidchklumsum").value="0";
	}
 }
  
 function setServiceLumSum(){
	 
 	if(document.getElementById("chkservicelumsum").checked==true){
 		document.getElementById("servicelumsumamt").disabled=false;
 		document.getElementById("hidchkservicelumsum").value="1";
	}
	else{
		document.getElementById("servicelumsumamt").disabled=true;
		document.getElementById("hidchkservicelumsum").value="0";
	}
 }
 
 function setRandomLumSum(){
	 
 	if(document.getElementById("chkrandomlumsum").checked==true){
 		document.getElementById("randomlumsumamt").disabled=false;
 		document.getElementById("hidchkrandomlumsum").value="1";
	}
	else{
		document.getElementById("randomlumsumamt").disabled=true;
		document.getElementById("hidchkrandomlumsum").value="0";
	}
 }
 function funPrintBtn(){
	 console.log($('#estprintconfig').val());
	 if($('#estprintconfig').val()=='1'){           
		 estimationPrintContent('printVoucherWindow.jsp');    
	 }else{          
		/*  if($('#docno').val()!='' && $('#docno').val()!='0'){          
				var url=document.URL;
				var reurl=url.split("com");
				var docno=$('#docno').val();   
				var gatedoc=$('#gatedocno').val();         
				var path= "com/workshop/wsestimationpal/printEstimation1.action?estDocno="+$('#vocno').val()+"&docno="+docno+"&gatedocno="+gatedoc+"&branch="+$('#brchName').val()+"&addition="+$('#addition').val()+"&withvat="+0;        
				var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=700,Height=600,location=no,scrollbars=yes,toolbar=yes");	          	
				win.focus();	   	
			 } */
			 
		 if($('#docno').val()!='' && $('#docno').val()!='0'){
				var url=document.URL;
				var reurl=url.split("com");
				var docno=$('#docno').val();
				var gatedoc=$('#gatedocno').val();
				var path= "com/dashboard/workshop/quotationapproval/printQuotationAproval.action?estDocno="+$('#vocno').val()+"&docno="+docno+"&gatedocno="+gatedoc;
				var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=700,Height=600,location=no,scrollbars=yes,toolbar=yes");		
				win.focus();		
			 }
	 }
	 
	
 }
 
 function estimationPrintContent(url) {
		$('#printWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#printWindow').jqxWindow('setContent', data);
		$('#printWindow').jqxWindow('bringToFront');
	}); 
}
 
 function getEstPrintConfig(){       
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText.trim();
				items=JSON.parse(items);
				rawconfig=items;
				if(rawconfig.estSpareDiscount.method=="1"){
					$('.spare-row').show();
				}
				else{
					$('.spare-row').hide();
				}
				if(rawconfig.estLumSum.method=="1"){
					$('.lumsum-row').show();
				}
				else{
					$('.lumsum-row').hide();
				}
				$("#estprintconfig").val(items.estprintconfig);
				var htmldata='<option value="">--Select--</option>';
				$.each(items.serviceadvisordata,function(index,value){
					htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
				});
				$('#cmbserviceadvisor').html($.parseHTML(htmldata));
				/*$('#cmbserviceadvisor').select2({
					placeholder:'Select Service Advisor',
					allowClear:true
				});*/
				if($('#hidcmbserviceadvisor').val()!=''){
					$('#cmbserviceadvisor').val($('#hidcmbserviceadvisor').val()).trigger('change');
				}
			} else {
			}
		}
		x.open("GET", "getEstPrintConfig.jsp", true);       
		x.send();
	}
	
	function funSendmail(){
	 getEstPrintConfig();   
	 //console.log($('#estprintconfig').val());
	 if($('#estprintconfig').val()=='1'){           
		 estimationPrintContent('emailVoucherWindow.jsp');    
	 }else{
	 }  
 }
  function estimationPrintContent(url) {
		$('#printWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#printWindow').jqxWindow('setContent', data);
		$('#printWindow').jqxWindow('bringToFront');
	}); 
}
</script>
<style>
	
</style>
</head>	
<body onLoad="setValues();">
	<div id="mainBG" class="homeContent" data-type="background"> 
		<form id="frmWSEstimationAdditionPal" action="saveEstimationAdditionPal" method="post" autocomplete="off" class="form-inline">
			<jsp:include page="../../../header.jsp" />
            <br>
            <div class='hidden-scrollbar'>
   			<table width="100%" border="0">
   			  <tr>
   			    <td width="9%" align="right">Date</td>
   			    <td width="31%"><div id="date" name="date" value='<s:property value="date"/>'></div></td>
   			    <td width="20%">&nbsp;</td>
   			    <td width="20%" align="right">Doc No</td>
   			    <td ><input type="text" name="vocno" id="vocno" readonly="readonly" tabindex="-1" value='<s:property value="vocno"/>' class="readonly"></td>
                <input type="hidden" name="docno" id="docno" readonly tabindex="-1" value='<s:property value="docno"/>' class="readonly">
		      	<td><input type="text" name="addition" id="addition" readonly tabindex="-1" value='<s:property value="addition"/>' class="readonly"></td>
		      </tr>
		  </table>
          <fieldset class="headClass"><legend>Job Card Details</legend>
          <table width="100%" border="0">
  <tr>
    <td width="12%" align="right">Job Card Doc No</td>
    <td width="12%"><input type="text" name="jobcardvocno" id="jobcardvocno" readonly placeholder="Press F3 to Search" value='<s:property value="jobcardvocno"/>'class="readonly" onkeydown="getGateInPass(event);"></td>
    <td width="10%"  align="right">User Details</td>
    <td width="66%"><input type="text" name="gateuserdetails" id="gateuserdetails" readonly value='<s:property value="gateuserdetails"/>' style="width:99%;" class="readonly"></td>
  </tr>
  <input type="hidden" name="gatevocno" id="gatevocno" class="readonly" readonly placeholder="Press F3 to Search" value='<s:property value="gatevocno"/>' onkeydown="getGateInPass(event);">
  <input type="hidden" name="gatedocno" id="gatedocno" readonly class="readonly" tabindex="-1" value='<s:property value="gatedocno"/>'>
  <input type="hidden" name="jobcarddocno" id="jobcarddocno" readonly class="readonly" tabindex="-1" value='<s:property value="jobcarddocno"/>'>
  <input type="hidden" name="estdocno" id="estdocno" readonly class="readonly" tabindex="-1" value='<s:property value="estdocno"/>'>
  <tr>
    <td align="right">Insurance Company</td>
    <td><input type="text" name="gipinsurcomp" id="gipinsurcomp" readonly class="readonly" value='<s:property value="gipinsurcomp"/>' ></td>
    <td  align="right">Vehicle Details</td>
    <td><input type="text" name="gatevehicledetails" id="gatevehicledetails" readonly class="readonly" value='<s:property value="gatevehicledetails"/>' style="width:99%;"></td>
  </tr>
  <tr>
    <td align="right">Claim No</td>
    <td><input type="text" name="gipclaimno" id="gipclaimno" value='<s:property value="gipclaimno"/>' ></td>
    <td  align="right">Header</td>
    <td><input type="text" name="header" id="header" value='<s:property value="header"/>' style="width:99%;"></td>
  </tr>
  <tr>
    <td align="right">GIP Date Time</td>
    <td><input type="text" name="gipdatetime" id="gipdatetime" value='<s:property value="gipdatetime"/>'></td>
    <td  align="right">Notes</td>
    <td><input type="text" name="notes" id="notes"  value='<s:property value="notes"/>' style="width:99%;"></td>
  </tr>
  <tr>
    <td align="right">Estimate Days</td>
    <td><input type="text" name="estimatedays" id="estimatedays" value='<s:property value="estimatedays"/>'></td>
    <td  align="right">Internal Remarks</td>
    <td><input type="text" name="internalremarks" id="internalremarks"  value='<s:property value="internalremarks"/>' style="width:99%;"></td>
  </tr>
  <tr>
    <td align="right">Service Advisor</td>
    <td>
    	<select name="cmbserviceadvisor" id="cmbserviceadvisor" style="width:100%;">
    		<option value="">--Select--</option>
    	</select>
    	<input type="hidden" name="hidcmbserviceadvisor" id="hidcmbserviceadvisor" value='<s:property value="hidcmbserviceadvisor"/>'/>
    </td>
  </tr>
</table>
</fieldset>
<table width="100%" border="0">
  <tr>
    <td colspan="9"><fieldset class="greenClass"><legend>Complaints</legend>
    	<div id="complaintdiv"><jsp:include page="complaintGrid.jsp"></jsp:include></div>
        </fieldset>
    </td>
    </tr>
    <tr>
    	<td align="right">Job Type</td>
    	<td><div id="jobtypeinputdiv"><jsp:include page="jobtypeinput.jsp"></jsp:include></div></td>
    	<td align="right">Description</td>
    	<td width="20%"><input type="text" name="jobdescription" id="jobdescription" style="width:90%;">
    	<input type="hidden" name="jobhrs" id="jobhrs">
    	</td>
    	<!-- <td align="right">Hrs</td>
    	<td><input type="text" name="jobhrs" id="jobhrs"></td> -->
    	<td align="right">Rate</td>
    	<td><input type="text" name="jobrate" id="jobrate" style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
    	<td align="right">Remarks</td>
    	<td width="20%"><input type="text" name="jobremarks" id="jobremarks" style="width:90%;"></td>
	    <td><input type="button" id="btnaddjob" name="btnaddjob" value="Add" onclick="funAddJob();"></td>
    </tr>
    <tr>
    <td colspan="9"><fieldset class="yellowClass"><legend>Services</legend>
    	<div id="labourcostdiv"><jsp:include page="labourcostGrid.jsp"></jsp:include></div>
        </fieldset></td>
    </tr>
    <tr>
    	<td align="right">Total</td>
    	<td><input type="text" name="servicestotal" id="servicestotal"  value='<s:property value="servicestotal"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
    	<td align="right">Discount</td>
    	<td><input type="text" name="servicesdiscount" id="servicesdiscount"  value='<s:property value="servicesdiscount"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
    	<td align="right">Net Services Total</td>
    	<td><input type="text" name="netservices" id="netservices"  value='<s:property value="netservices"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
    </tr>
  	<tr class="lumsum-row">
    	<td align="right">
    		<input type="checkbox" name="chkservicelumsum" id="chkservicelumsum" onchange="setServiceLumSum();">&nbsp;&nbsp;Service Lumpsum
    		<input type="hidden" name="hidchkservicelumsum" id="hidchkservicelumsum" value='<s:property value="hidchkservicelumsum"/>'>
    		<input type="text" name="servicelumsumamt" id="servicelumsumamt" value='<s:property value="servicelumsumamt"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);">
    	</td>
    </tr>  
  <tr>
    <td colspan="9"><fieldset class="redClass"><legend>Spare Parts</legend>
    	<div id="sparepartsdiv"><jsp:include page="sparePartsNewGrid.jsp"></jsp:include></div>
        </fieldset></td>
    </tr>
    <tr class="spare-row">
    	<td align="right">Total</td>
    	<td><input type="text" name="sparetotal" id="sparetotal"  value='<s:property value="sparetotal"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
    	<td align="right">Discount</td>
    	<td><input type="text" name="sparediscount" id="sparediscount"  value='<s:property value="sparediscount"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
    	<td align="right" width="10%">Net Spare Total</td>
    	<td><input type="text" name="netspare" id="netspare"  value='<s:property value="netspare"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
    </tr>
  <tr class="lumsum-row"><td colspan="2" align="center"><input type="checkbox" id="chklumsum" name="chklumsum" onChange="setLumSum();">&nbsp;&nbsp; Spare Lumpsum &nbsp;&nbsp;<input type="text" id="lumsumamount" name="lumsumamount" value='<s:property value="lumsumamount"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
  <input type="hidden" name="hidchklumsum" id="hidchklumsum" value='<s:property value="hidchklumsum"/>'>
    
    <td align="center">&nbsp;</td>
    <td ><input type="checkbox" id="chkrandomlumsum" name="chkrandomlumsum" onchange="setRandomLumSum();">&nbsp;&nbsp;Lumpsum
    	<input type="hidden" id="hidchkrandomlumsum" name="hidchkrandomlumsum" value='<s:property value="hidchkrandomlumsum"/>'>
    	<input type="text" id="randomlumsumamt" name="randomlumsumamt" value='<s:property value="randomlumsumamt"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"/>
    </td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
  </tr>
  <tr>
  	<td colspan="9" align="center"><button type="button" class="myButton" id="btnCalculate">Calculate Amount</button></td>
  </tr>
  
  <tr>
    <td colspan="9">
    	<fieldset class=""><legend>Spare Parts Amount</legend>
    		<div id="sparepartsamountdiv"><jsp:include page="sparePartsAmountGrid.jsp"></jsp:include></div>
        </fieldset>
    </td>
 </tr>
<%--   <tr>
    <td  align="right">Spare Parts Total</td>
    <td><input type="text" name="sparepartstotal" id="sparepartstotal"  value='<s:property value="sparepartstotal"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
    <td align="right">Labour Total</td>
    <td><input type="text" name="labourtotal" id="labourtotal"  value='<s:property value="labourtotal"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
    <td  align="right">Discount </td>
    <td><input type="text" name="discount" id="discount"  value='<s:property value="discount"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
    <td  align="right">Estimation Total</td>
    <td><input type="text" name="esttotal" id="esttotal"  value='<s:property value="esttotal"/>' style="text-align:right;" readonly onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
  </tr> --%>
</table>

    	<input type="hidden" id="brhid" name="brhid" value='<s:property value="brhid"/>'/>
    	<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
		<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
      	<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
      	<input type="hidden" name="sparePartsNewGridlength" id="sparePartsNewGridlength" value='<s:property value="sparePartsNewGridlength"/>'/>
      	<input type="hidden" name="labourcostgridlength" id="labourcostgridlength" value='<s:property value="labourcostgridlength"/>'/>
      	<input type="hidden" name="approvedtotal" id="approvedtotal" value='<s:property value="approvedtotal"/>'/>
      	<input type="hidden" name="estprintconfig" id="estprintconfig" value='<s:property value="estprintconfig"/>'/>  
      	<input type="hidden" name="editstatus" id="editstatus" value='<s:property value="editstatus"/>'/>  
      	
            </div>
      </form>
    </div>
    <div id="searchwindow">
   		<div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
	</div>
	<div id="partssearchwindow">
   		<div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
	</div>
	<div id="laboursearchwindow">
   		<div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
	</div>
	<div id="clientwindow">
   		<div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
	</div>
	<div id="printWindow">
	<div></div><div></div>
	</div>
	<div id="emailWindow">
	<div></div><div></div>
	</div>
</body>
</html>