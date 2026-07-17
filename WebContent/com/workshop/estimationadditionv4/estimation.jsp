<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<jsp:include page="../../../includeso.jsp"></jsp:include>
<link href="../../../../vendors/select2/css/select2.min.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../../../../vendors/select2/js/select2.min.js"></script>
<%-- <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" >
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script> --%>
<style>
.list-group {
    padding-left: 0;
    margin-bottom: 20px;
}
.list-group-item {
    position: relative;
    display: block;
    padding: 10px 15px;
    margin-bottom: -1px;
    background-color: #fff;
    border: 1px solid #ddd;
}
.list-group-item:first-child {
    border-top-left-radius: 4px;
    border-top-right-radius: 4px;
}
.list-group-item:last-child {
    margin-bottom: 0;
    border-bottom-right-radius: 4px;
    border-bottom-left-radius: 4px;
}
a.list-group-item,
button.list-group-item {
    color: #555;
}
a.list-group-item .list-group-item-heading,
button.list-group-item .list-group-item-heading {
    color: #333;
}
a.list-group-item:focus,
a.list-group-item:hover,
button.list-group-item:focus,
button.list-group-item:hover {
    color: #555;
    text-decoration: none;
    background-color: #f5f5f5;
}
button.list-group-item {
    width: 100%;
    text-align: left;
}
.list-group-item.disabled,
.list-group-item.disabled:focus,
.list-group-item.disabled:hover {
    color: #777;
    cursor: not-allowed;
    background-color: #eee;
}
.list-group-item.disabled .list-group-item-heading,
.list-group-item.disabled:focus .list-group-item-heading,
.list-group-item.disabled:hover .list-group-item-heading {
    color: inherit;
}
.list-group-item.disabled .list-group-item-text,
.list-group-item.disabled:focus .list-group-item-text,
.list-group-item.disabled:hover .list-group-item-text {
    color: #777;
}
.list-group-item.active,
.list-group-item.active:focus,
.list-group-item.active:hover {
    z-index: 2;
    color: #fff;
    background-color: #337ab7;
    border-color: #337ab7;
}
.list-group-item.active .list-group-item-heading,
.list-group-item.active .list-group-item-heading > .small,
.list-group-item.active .list-group-item-heading > small,
.list-group-item.active:focus .list-group-item-heading,
.list-group-item.active:focus .list-group-item-heading > .small,
.list-group-item.active:focus .list-group-item-heading > small,
.list-group-item.active:hover .list-group-item-heading,
.list-group-item.active:hover .list-group-item-heading > .small,
.list-group-item.active:hover .list-group-item-heading > small {
    color: inherit;
}
.list-group-item.active .list-group-item-text,
.list-group-item.active:focus .list-group-item-text,
.list-group-item.active:hover .list-group-item-text {
    color: #c7ddef;
}
.list-group-item-success {
    color: #3c763d;
    background-color: #dff0d8;
}
a.list-group-item-success,
button.list-group-item-success {
    color: #3c763d;
}
a.list-group-item-success .list-group-item-heading,
button.list-group-item-success .list-group-item-heading {
    color: inherit;
}
a.list-group-item-success:focus,
a.list-group-item-success:hover,
button.list-group-item-success:focus,
button.list-group-item-success:hover {
    color: #3c763d;
    background-color: #d0e9c6;
}
a.list-group-item-success.active,
a.list-group-item-success.active:focus,
a.list-group-item-success.active:hover,
button.list-group-item-success.active,
button.list-group-item-success.active:focus,
button.list-group-item-success.active:hover {
    color: #fff;
    background-color: #3c763d;
    border-color: #3c763d;
}
.list-group-item-info {
    color: #31708f;
    background-color: #d9edf7;
}
a.list-group-item-info,
button.list-group-item-info {
    color: #31708f;
}
a.list-group-item-info .list-group-item-heading,
button.list-group-item-info .list-group-item-heading {
    color: inherit;
}
a.list-group-item-info:focus,
a.list-group-item-info:hover,
button.list-group-item-info:focus,
button.list-group-item-info:hover {
    color: #31708f;
    background-color: #c4e3f3;
}
a.list-group-item-info.active,
a.list-group-item-info.active:focus,
a.list-group-item-info.active:hover,
button.list-group-item-info.active,
button.list-group-item-info.active:focus,
button.list-group-item-info.active:hover {
    color: #fff;
    background-color: #31708f;
    border-color: #31708f;
}
.list-group-item-warning {
    color: #8a6d3b;
    background-color: #fcf8e3;
}
a.list-group-item-warning,
button.list-group-item-warning {
    color: #8a6d3b;
}
a.list-group-item-warning .list-group-item-heading,
button.list-group-item-warning .list-group-item-heading {
    color: inherit;
}
a.list-group-item-warning:focus,
a.list-group-item-warning:hover,
button.list-group-item-warning:focus,
button.list-group-item-warning:hover {
    color: #8a6d3b;
    background-color: #faf2cc;
}
a.list-group-item-warning.active,
a.list-group-item-warning.active:focus,
a.list-group-item-warning.active:hover,
button.list-group-item-warning.active,
button.list-group-item-warning.active:focus,
button.list-group-item-warning.active:hover {
    color: #fff;
    background-color: #8a6d3b;
    border-color: #8a6d3b;
}
.list-group-item-danger {
    color: #a94442;
    background-color: #f2dede;
}
a.list-group-item-danger,
button.list-group-item-danger {
    color: #a94442;
}
a.list-group-item-danger .list-group-item-heading,
button.list-group-item-danger .list-group-item-heading {
    color: inherit;
}
a.list-group-item-danger:focus,
a.list-group-item-danger:hover,
button.list-group-item-danger:focus,
button.list-group-item-danger:hover {
    color: #a94442;
    background-color: #ebcccc;
}
a.list-group-item-danger.active,
a.list-group-item-danger.active:focus,
a.list-group-item-danger.active:hover,
button.list-group-item-danger.active,
button.list-group-item-danger.active:focus,
button.list-group-item-danger.active:hover {
    color: #fff;
    background-color: #a94442;
    border-color: #a94442;
}
.list-group-item-heading {
    margin-top: 0;
    margin-bottom: 5px;
}
.list-group-item-text {
    margin-bottom: 0;
    line-height: 1.3;
}
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
/*$('#cmbserviceadvisor').select2({
	placeholder:"Select Service Advisor",
	allowClear:true
});*/
getProductAjax();
//setLumSum();
//document.getElementById("chklumsum").disabled=false;
$('#netestsparetotal,#netestservicetotal,#servicelumsumamt,#lumsumamount,#randomlumsumamt').change(function(){
		var netestsparetotal=$('#netestsparetotal').val();
		var netestservicetotal=$('#netestservicetotal').val();
		var servicelumsumamt=$('#servicelumsumamt').val();
		var lumsumamount=$('#lumsumamount').val();
		var randomlumsumamt=$('#randomlumsumamt').val();
		var netesttotal=0.0;
		if(netestsparetotal!=""){
			netesttotal+=parseFloat(netestsparetotal);
		}
		if(netestservicetotal!=""){
			netesttotal+=parseFloat(netestservicetotal);
		}
		if(servicelumsumamt!="" && servicelumsumamt!=null && servicelumsumamt!="undefined" && typeof(servicelumsumamt)!="undefined"){
			netesttotal+=parseFloat(servicelumsumamt);
		}
		if(lumsumamount!="" && lumsumamount!=null && lumsumamount!="undefined" && typeof(lumsumamount)!="undefined"){
			netesttotal+=parseFloat(lumsumamount);
		}
		if(randomlumsumamt!="" && randomlumsumamt!=null && randomlumsumamt!="undefined" && typeof(randomlumsumamt)!="undefined" && parseFloat(randomlumsumamt)>0.0){
			netesttotal=parseFloat(randomlumsumamt);
		}
		funRoundAmt(netesttotal,"netesttotal");
	});
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
	
	var spare=parseFloat($('#sparetotal').val());
	var discount=parseFloat($('#sparediscount').val());
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
$('#searchproductqty,#searchproductrate,#searchproductamount,#searchproductdiscount,#searchproductvatpercent,#searchproductvatamount').change(function(){
	var searchproductqty=$('#searchproductqty').val();
	var searchproductrate=$('#searchproductrate').val();
	if(searchproductqty!="" && searchproductqty!="undefined" && searchproductqty!=null && searchproductrate!="" && searchproductrate!="undefined" && searchproductrate!=null){
		var searchproductamount=parseFloat(searchproductqty)*parseFloat(searchproductrate);
		$('#searchproductamount').val(searchproductamount.toFixed(2));
	}
	var searchproductamount=($('#searchproductamount').val()=="" || $('#searchproductamount').val()==null || $('#searchproductamount').val()=="undefined"?0.0:parseFloat($('#searchproductamount').val()));
	var searchproductdiscount=($('#searchproductdiscount').val()=="" || $('#searchproductdiscount').val()==null || $('#searchproductdiscount').val()=="undefined"?0.0:parseFloat($('#searchproductdiscount').val()));
	var searchproductvatpercent=($('#searchproductvatpercent').val()=="" || $('#searchproductvatpercent').val()==null || $('#searchproductvatpercent').val()=="undefined"?0.0:parseFloat($('#searchproductvatpercent').val()));
	var searchproductvatamount=(parseFloat(searchproductamount)-parseFloat(searchproductdiscount))*(parseFloat(searchproductvatpercent)/100);
	searchproductvatamount=searchproductvatamount.toFixed(2);
	$('#searchproductvatamount').val(searchproductvatamount);
	var searchproductnetamount=(parseFloat(searchproductamount)-parseFloat(searchproductdiscount))+parseFloat(searchproductvatamount);
	searchproductnetamount=searchproductnetamount.toFixed(2);
	$('#searchproductnetamount').val(searchproductnetamount);
});
$('#jobqty,#jobrate,#jobamount,#jobdiscount,#jobvatpercent,#jobvatamount').change(function(){
	var jobqty=$('#jobqty').val();
	var jobrate=$('#jobrate').val();
	var jobhrs=$('#jobhrs').val();
	if(jobqty!="" && jobqty!="undefined" && jobqty!=null && jobrate!="" && jobrate!="undefined" && jobrate!=null){
		var jobamount=parseFloat(jobqty)*parseFloat(jobrate);
		$('#jobamount').val(jobamount.toFixed(2));
	}
	var jobamount=($('#jobamount').val()=="" || $('#jobamount').val()==null || $('#jobamount').val()=="undefined"?0.0:parseFloat($('#jobamount').val()));
	var jobdiscount=($('#jobdiscount').val()=="" || $('#jobdiscount').val()==null || $('#jobdiscount').val()=="undefined"?0.0:parseFloat($('#jobdiscount').val()));
	var jobvatpercent=($('#jobvatpercent').val()=="" || $('#jobvatpercent').val()==null || $('#jobvatpercent').val()=="undefined"?0.0:parseFloat($('#jobvatpercent').val()));
	var jobvatamount=(parseFloat(jobamount)-parseFloat(jobdiscount))*(parseFloat(jobvatpercent)/100);
	jobvatamount=jobvatamount.toFixed(2);
	$('#jobvatamount').val(jobvatamount);
	var jobnetamount=(parseFloat(jobamount)-parseFloat(jobdiscount))+parseFloat(jobvatamount);
	jobnetamount=jobnetamount.toFixed(2);
	$('#jobnetamount').val(jobnetamount);
});
});
function getProductAjax(){
	$.get('getProductAjax.jsp',function(data){
		data=JSON.parse(data);
		var htmldata1='',htmldata2='';
		$.each(data.productdata,function(index,value){
			htmldata1+='<li class="list-group-item"><a href="#" data-rate="'+value.rate+'" data-partno="'+value.partno+'" data-productname="'+value.productname+'" data-psrno="'+value.psrno+'">'+value.partno+'</a></li>';
			htmldata2+='<li class="list-group-item"><a href="#" data-rate="'+value.rate+'" data-partno="'+value.partno+'" data-productname="'+value.productname+'" data-psrno="'+value.psrno+'">'+value.productname+'</a></li>';
		});
		$('#searchproductid').closest('td').find('ul[data-type="product"]').html($.parseHTML(htmldata1));
		$('#searchproductname').closest('td').find('ul[data-type="product"]').html($.parseHTML(htmldata2));
		$('ul[data-type="product"] li a').dblclick(function(){
			$('#searchproductid').val($(this).attr('data-partno'));
			$('#searchproductname').val($(this).attr('data-productname'));
			$('#searchproductrate').val($(this).attr('data-rate'));
			$('#searchproductpsrno').val($(this).attr('data-psrno'));
			$('ul[data-type="product"]').css('display','none');
			return false;
		});
		$('#searchproductid,#searchproductname').dblclick(function(){
			//$('ul[data-type="product"]').css('display','none');
			//$(this).closest('td').find('ul[data-type="product"]').css('display','block');
			$('#partssearchwindow').jqxWindow('open');
			$('#partssearchwindow').jqxWindow('focus');
			SearchContent('prodectnamesearch.jsp?partindex=0&mode=3', 'partssearchwindow');
		});
	});
}
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
	$('#frmEstimationAdditionV4 input').attr('readonly',true);
}
function funRemoveReadOnly() {
	//$('#frmEstimationAdditionV4 input').attr('readonly',false);
	//$('#docno').attr('readonly',true);
	$("#frmEstimationAdditionV4 input:not(.readonly)").attr('readonly',false);
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
		$('#date').jqxDateTimeInput('setDate',new Date());
		$('#servicestotal,#servicesdiscount,#netservices').val(0);
		$('#sparetotal,#sparediscount,#netspare').val(0);
		if(rawconfig.serviceConsumables.method=="1"){
			$("#sparePartsNewGrid").jqxGrid("setcellvalue",0,"description","Consumables");
			$("#sparePartsNewGrid").jqxGrid("addrow", null, {});
		}
		$('#jobdiscount,#searchproductdiscount').val(0);
	}
	else if($('#mode').val()=='E' || $('#mode').val()=='D'){
		$('#sparePartsNewGrid,#labourcostGrid').jqxGrid({disabled:false});
		$("#sparePartsNewGrid,#labourcostGrid").jqxGrid("addrow", null, {});
	}
	if($('#mode').val()=='E'){
		$('#sparePartsAmountGrid').jqxGrid('clear');
		funChangeEntity();
		$('#jobdiscount,#searchproductdiscount').val(0);
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
		$('#complaintdiv').load('../../../com/workshop/estimationadditionv4/complaintGrid.jsp?docno='+$('#gatedocno').val()+'&branch='+$('#brchName').val()+'&id=1');	
		$('#jobtypeinputdiv').load('jobtypeinput.jsp?id=1');
		CheckEditStatus($('#docno').val());
	
	}
	if($('#docno').val()!=''){
		$('#sparepartsdiv').load('../../../com/workshop/estimationadditionv4/sparePartsNewGrid.jsp?docno='+$('#docno').val()+'&id=1&addition='+addition);
	}
	if($('#docno').val()!=''){
		$('#labourcostdiv').load('../../../com/workshop/estimationadditionv4/labourcostGrid.jsp?docno='+$('#docno').val()+'&id=1&addition='+addition);		
	}
	if($('#gatedocno').val()!=''){
		$('#sparepartsamountdiv').load('../../../com/workshop/estimationadditionv4/sparePartsAmountGrid.jsp?gatedocno='+$('#gatedocno').val()+'&id=1&addition='+addition);		
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
	
	funDtype();
	getapprcount();
	apprCheck(); 
	
	setLumSum();
	setServiceLumSum();
	setRandomLumSum();
	
	if($('#brhid').val()!='' && $('#brhid').val()!='undefined' && $('#brhid').val()!=null && typeof($('#brhid').val())!='undefined'){
		$('#brchName').val($('#brhid').val());	
	}
	
	document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	funSetlabel();
	if($('#hidcmbentitytype').val()!=''){
		$('#cmbentitytype').val($('#hidcmbentitytype').val());
	}
	
	var netestsparetotal=$('#netestsparetotal').val();
	var netestservicetotal=$('#netestservicetotal').val();
	var servicelumsumamt=$('#servicelumsumamt').val();
	var lumsumamount=$('#lumsumamount').val();
	var randomlumsumamt=$('#randomlumsumamt').val();
	var netesttotal=0.0;
	if(netestsparetotal!=""){
		netesttotal+=parseFloat(netestsparetotal);
	}
	if(netestservicetotal!=""){
		netesttotal+=parseFloat(netestservicetotal);
	}
	if(servicelumsumamt!="" && servicelumsumamt!=null && servicelumsumamt!="undefined" && typeof(servicelumsumamt)!="undefined"){
		netesttotal+=parseFloat(servicelumsumamt);
	}
	if(lumsumamount!="" && lumsumamount!=null && lumsumamount!="undefined" && typeof(lumsumamount)!="undefined"){
		netesttotal+=parseFloat(lumsumamount);
	}
	if(randomlumsumamt!="" && randomlumsumamt!=null && randomlumsumamt!="undefined" && typeof(randomlumsumamt)!="undefined" && parseFloat(randomlumsumamt)>0.0){
		netesttotal=parseFloat(randomlumsumamt);
	}
	funRoundAmt(netesttotal,"netesttotal");
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
	/*var amountrows=$("#sparePartsAmountGrid").jqxGrid('getrows');
	if(amountrows.length==0){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Please Calculate Amount";
		return 0;
	}*/
	var entitytype=$('#cmbentitytype').val();
	if(entitytype=="1"){
		var vaterror=0;
		var labourrows = $("#labourcostGrid").jqxGrid('getrows');
		for(var i=0;i<labourrows.length;i++){
			if(labourrows[i].jobid!="" && labourrows[i].jobid!=null && labourrows[i].jobid!="undefined" && typeof(labourrows[i].jobid)!="undefined"){
				var vatpercent=$("#labourcostGrid").jqxGrid('getcellvalue',i,'jobvatamount');
				var taxable=$("#labourcostGrid").jqxGrid('getcellvalue',i,'taxable');
				var rate=$("#labourcostGrid").jqxGrid('getcellvalue',i,'rate');
				rate=rate=="" || rate==null || rate=="undefined" || typeof(rate)=="undefined"?0.0:parseFloat(rate);
				if((vatpercent=="" || vatpercent==null || vatpercent=="undefined" || typeof(vatpercent)=="undefined" || parseFloat(vatpercent)==0.0) && taxable=="1" && rate>0.0){
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="Taxable Entity,VAT Amount must be provided";
					vaterror=1;
					break;
				}
			}
		}
		var partrows = $("#sparePartsNewGrid").jqxGrid('getrows');
		for(var i=0;i<partrows.length;i++){
			if(partrows[i].description!="" && partrows[i].description!=null && partrows[i].description!="undefined" && typeof(partrows[i].description)!="undefined"){
				var vatpercent=$("#sparePartsNewGrid").jqxGrid('getcellvalue',i,'spvatamount');
				var rate=$("#sparePartsNewGrid").jqxGrid('getcellvalue',i,'rate');
				rate=rate=="" || rate==null || rate=="undefined" || typeof(rate)=="undefined"?0.0:parseFloat(rate);
				if((vatpercent=="" || vatpercent==null || vatpercent=="undefined" || typeof(vatpercent)=="undefined" || parseFloat(vatpercent)==0.0) && rate>0.0){
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="Taxable Entity,VAT Amount must be provided";
					vaterror=1;
					break;
				}
			}
		}
		if(vaterror==1){
			return 0;
		}
	}
	if($('#chkservicelumsum').is(":checked") || $('#chkrandomlumsum').is(":checked")){
		var servicerows = $("#labourcostGrid").jqxGrid('getrows');
		for(let i=0;i<servicerows.length;i++){
			if(servicerows[i].jobid!="" && servicerows[i].jobid!=null && servicerows[i].jobid!="undefined" && typeof(servicerows[i].jobid)!="undefined"){
				$('#labourcostGrid').jqxGrid('setcellvalue',i,'rate',0.0);
				$('#labourcostGrid').jqxGrid('setcellvalue',i,'jobdiscount',0.0);
				$('#labourcostGrid').jqxGrid('setcellvalue',i,'distservicediscount',0.0);
				
			}
		}	
	}
	if($('#chklumsum').is(":checked") || $('#chkrandomlumsum').is(":checked")){
		var partrows = $("#sparePartsNewGrid").jqxGrid('getrows');
		for(let i=0;i<partrows.length;i++){
			if(partrows[i].description!="" && partrows[i].description!=null && partrows[i].description!="undefined" && typeof(partrows[i].description)!="undefined"){
				$('#sparePartsNewGrid').jqxGrid('setcellvalue',i,'sprate',0.0);
				$('#sparePartsNewGrid').jqxGrid('setcellvalue',i,'spdiscount',0.0);
				$('#sparePartsNewGrid').jqxGrid('setcellvalue',i,'distsparediscount',0.0);
			}
		}	
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
				
			newTextBox.val(labourrows[j].jobid+" :: "+labourrows[j].hrs+" :: "+labourrows[j].rate+" :: "+labourrows[j].markuppercent+" :: "+labourrows[j].total+" :: "+labourrows[j].remarks+" :: "+labourrows[j].jobtype+" :: "+labourrows[j].jobdesc+" :: "+labourrows[j].seqno+" :: "+labourrows[j].jobqty+" :: "+labourrows[j].jobdiscount+" :: "+labourrows[j].jobvatpercent+" :: "+labourrows[j].jobvatamount+" :: "+labourrows[j].jobnetamount+" :: "+labourrows[j].distservicediscount);
			
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
			newTextBox.val(partrows[i].description+" :: "+partrows[i].qty+" :: "+partrows[i].sprate+" :: "+partrows[i].approvedvalue+" :: "+partrows[i].spdiscount+" :: "+partrows[i].sptotal+" :: "+partrows[i].spvatpercent+" :: "+partrows[i].spvatamount+" :: "+partrows[i].spnetamount+" :: "+partrows[i].psrno+" :: "+partrows[i].distsparediscount);
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
	
	/*if(parseFloat(netsum)!=parseFloat(gridsum)){
		$.messager.alert('Warning','Please Calculate');
		return 0;
	}*/
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
	var addition=$('#addition').val();
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			$('#editstatus').val(items.trim());
			} else {
			}
		}
	x.open("GET", "checkEditStatus.jsp?docno="+docno+"&addition="+addition, true);
	x.send();
 }
  function setLumSum(){
	 
 	if(document.getElementById("chklumsum").checked==true){
 		if($('#mode').val()=='A' || $('#mode').val()=='E'){
 			var partrows=$('#sparePartsNewGrid').jqxGrid('getrows');
 			var sparelength=0;
 			for(let i=0;i<partrows.length;i++){
 				if(partrows[i].description!="" && partrows[i].description!=null && partrows[i].description!="undefined" && typeof(partrows[i].description)!="undefined"){
 					sparelength++;
 				}
 			}
 			if(sparelength>0){
 				$.messager.confirm('Confirm', 'Line item rates will be set to zero,Do you want to continue?', function(r){
					if (r){
						for(let i=0;i<partrows.length;i++){
			 				if(partrows[i].description!="" && partrows[i].description!=null && partrows[i].description!="undefined" && typeof(partrows[i].description)!="undefined"){
			 					$('#sparePartsNewGrid').jqxGrid('setcellvalue',i,'sprate',0.0);
			 					$('#sparePartsNewGrid').jqxGrid('setcellvalue',i,'spdiscount',0.0);
								$('#sparePartsNewGrid').jqxGrid('setcellvalue',i,'distsparediscount',0.0);
			 				}
			 			}
						document.getElementById("lumsumamount").disabled=false;
		 				document.getElementById("hidchklumsum").value="1";
					}
					else{
						document.getElementById("chklumsum").checked=false;
						document.getElementById("lumsumamount").disabled=true;
						document.getElementById("lumsumamount").value="0.0";
						document.getElementById("hidchklumsum").value="0";
						$('#lumsumamount').trigger('change');
					}
				});
 			}
 			else{
 				document.getElementById("lumsumamount").disabled=false;
		 		document.getElementById("hidchklumsum").value="1";
 			}
 		}
 		else{
 			document.getElementById("lumsumamount").disabled=false;
		 	document.getElementById("hidchklumsum").value="1";
 		}
	}
	else{
		$('#sparePartsNewGrid').jqxGrid({disabled:false});
		document.getElementById("lumsumamount").value="0.0";
		document.getElementById("lumsumamount").disabled=true;
		document.getElementById("hidchklumsum").value="0";
		$('#lumsumamount').trigger('change');
	}
 }
 
 function setServiceLumSum(){
	 
 	if(document.getElementById("chkservicelumsum").checked==true){
 		if($('#mode').val()=='A' || $('#mode').val()=='E'){
 			var partrows=$('#labourcostGrid').jqxGrid('getrows');
 			var sparelength=0;
 			for(let i=0;i<partrows.length;i++){
 				if(partrows[i].jobid!="" && partrows[i].jobid!=null && partrows[i].jobid!="undefined" && typeof(partrows[i].jobid)!="undefined"){
 					sparelength++;
 				}
 			}
 			if(sparelength>0){
 				$.messager.confirm('Confirm', 'Line item rates will be set to zero,Do you want to continue?', function(r){
					if (r){
						for(let i=0;i<partrows.length;i++){
			 				if(partrows[i].jobid!="" && partrows[i].jobid!=null && partrows[i].jobid!="undefined" && typeof(partrows[i].jobid)!="undefined"){
			 					$('#labourcostGrid').jqxGrid('setcellvalue',i,'rate',0.0);
			 					$('#labourcostGrid').jqxGrid('setcellvalue',i,'jobdiscount',0.0);
								$('#labourcostGrid').jqxGrid('setcellvalue',i,'distservicediscount',0.0);
			 					
			 				}
			 			}
						document.getElementById("servicelumsumamt").disabled=false;
		 				document.getElementById("hidchkservicelumsum").value="1";
					}
					else{
						document.getElementById("chkservicelumsum").checked=false;
						document.getElementById("servicelumsumamt").disabled=true;
						document.getElementById("hidchkservicelumsum").value="0";
						document.getElementById("servicelumsumamt").value="0.0";
						$('#servicelumsumamt').trigger('change');
					}
					
				});
 			}
 			else{
 				document.getElementById("servicelumsumamt").disabled=false;
		 		document.getElementById("hidchkservicelumsum").value="1";
 			}
 		}
 		else{
 			document.getElementById("lumsumamount").disabled=false;
		 	document.getElementById("hidchklumsum").value="1";
 		}
 		
 		
	}
	else{
		$('#labourcostGrid').jqxGrid({disabled:false});
		document.getElementById("servicelumsumamt").disabled=true;
		document.getElementById("hidchkservicelumsum").value="0";
		document.getElementById("servicelumsumamt").value="0.0";
		$('#servicelumsumamt').trigger('change');
	}
 }
 
 function setRandomLumSum(){
	
 	if(document.getElementById("chkrandomlumsum").checked==true){
 		if($('#mode').val()=='A' || $('#mode').val()=='E'){
 			$('#chklumsum').prop('checked',false);
 			$('#chkservicelumsum').prop('checked',false);
 			setLumSum();
 			setServiceLumSum();
 			$('#chklumsum').attr('disabled',true);
 			$('#chkservicelumsum').attr('disabled',true);
 			var servicerows=$('#labourcostGrid').jqxGrid('getrows');
 			var servicelength=0;
 			var partrows=$('#sparePartsNewGrid').jqxGrid('getrows');
 			var sparelength=0;
 			for(let i=0;i<servicerows.length;i++){
 				if(servicerows[i].jobid!="" && servicerows[i].jobid!=null && servicerows[i].jobid!="undefined" && typeof(servicerows[i].jobid)!="undefined"){
 					servicelength++;
 				}
 			}
 			for(let i=0;i<partrows.length;i++){
 				if(partrows[i].description!="" && partrows[i].description!=null && partrows[i].description!="undefined" && typeof(partrows[i].description)!="undefined"){
 					sparelength++;
 				}
 			}
 			if(sparelength>0 || servicelength>0){
 				$.messager.confirm('Confirm', 'Line item rates will be set to zero,Do you want to continue?', function(r){
					if (r){
						for(let i=0;i<servicerows.length;i++){
			 				if(servicerows[i].jobid!="" && servicerows[i].jobid!=null && servicerows[i].jobid!="undefined" && typeof(servicerows[i].jobid)!="undefined"){
			 					$('#labourcostGrid').jqxGrid('setcellvalue',i,'rate',0.0);
			 					$('#labourcostGrid').jqxGrid('setcellvalue',i,'jobdiscount',0.0);
								$('#labourcostGrid').jqxGrid('setcellvalue',i,'distservicediscount',0.0);
			 				}
			 			}
			 			for(let i=0;i<partrows.length;i++){
			 				if(partrows[i].description!="" && partrows[i].description!=null && partrows[i].description!="undefined" && typeof(partrows[i].description)!="undefined"){
			 					$('#sparePartsNewGrid').jqxGrid('setcellvalue',i,'sprate',0.0);
			 					$('#sparePartsNewGrid').jqxGrid('setcellvalue',i,'spdiscount',0.0);
								$('#sparePartsNewGrid').jqxGrid('setcellvalue',i,'distsparediscount',0.0);
			 				}
			 			}
						document.getElementById("randomlumsumamt").disabled=false;
		 				document.getElementById("hidchkrandomlumsum").value="1";
					}
					else{
						document.getElementById("chkrandomlumsum").checked=false;
						document.getElementById("randomlumsumamt").disabled=true;
						document.getElementById("hidchkrandomlumsum").value="0";
						document.getElementById("randomlumsumamt").value="0.0";
						$('#randomlumsumamt').trigger('change');
					}
				});
 			}
 			else{
 				document.getElementById("randomlumsumamt").disabled=false;
		 		document.getElementById("hidchkrandomlumsum").value="1";
 			}
 		}
 		else{
 			document.getElementById("randomlumsumamt").disabled=false;
		 	document.getElementById("hidchkrandomlumsum").value="1";
 		}
	}
	else{
		document.getElementById("randomlumsumamt").disabled=true;
		document.getElementById("hidchkrandomlumsum").value="0";
		document.getElementById("randomlumsumamt").value="0.0";
		$('#randomlumsumamt').trigger('change');
		$('#chklumsum').attr('disabled',false);
 		$('#chkservicelumsum').attr('disabled',false);
	}
 }
  function funPrintBtn(){
  	getEstPrintConfig();
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
		/*var x = new XMLHttpRequest();
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
				});
				if($('#hidcmbserviceadvisor').val()!=''){
					$('#cmbserviceadvisor').val($('#hidcmbserviceadvisor').val()).trigger('change');
				}
			} else {
			}
		}
		x.open("GET", "getEstPrintConfig.jsp", true);       
		x.send();*/
		$.ajax({
    		url: "getEstPrintConfig.jsp",
    		async:false,
    		type: 'GET',
		    success : function(data){
		    	var items = JSON.parse(data);
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
		    } 
		});
	}
	
	function funFilterList(el){
		var input=$(el).val();
		input = input.toUpperCase();
		var li=$(el).closest('td').find('ul[data-type="product"] li');
		for (i = 0; i < li.length; i++) {
   			var a = li[i].getElementsByTagName("a")[0];
   			var txtValue = a.textContent || a.innerText;
   			if (txtValue.toUpperCase().indexOf(input) > -1) {
     				li[i].style.display = "";
   			} else {
     				li[i].style.display = "none";
   			}
 		}
	}
	
	function funAddSpare(){
		if($('#mode').val()=='A' || $('#mode').val()=='E'){
			if($('#searchproductid').val()!=''){
				var labourrows=$('#sparePartsNewGrid').jqxGrid('getrows');
				var labourindex=0;
				if(labourrows.length==0){
					$("#sparePartsNewGrid").jqxGrid("addrow", null, {});
					labourrows=$('#sparePartsNewGrid').jqxGrid('getrows');
				}
				labourindex=labourrows.length-1;
		        $('#sparePartsNewGrid').jqxGrid('setcellvalue',labourindex,'description',$('#searchproductname').val());
		        $('#sparePartsNewGrid').jqxGrid('setcellvalue',labourindex,'psrno',$('#searchproductpsrno').val());
		        $('#sparePartsNewGrid').jqxGrid('setcellvalue',labourindex,'qty',$('#searchproductqty').val());
		        $('#sparePartsNewGrid').jqxGrid('setcellvalue',labourindex,'sprate',$('#searchproductrate').val());
		        var qty=parseFloat($('#sparePartsNewGrid').jqxGrid('getcellvalue',labourindex,'qty'));
		        var rate=parseFloat($('#sparePartsNewGrid').jqxGrid('getcellvalue',labourindex,'sprate'));
		        
		        
		        $('#sparePartsNewGrid').jqxGrid('setcellvalue',labourindex,'spdiscount',$('#searchproductdiscount').val());
		        var discount=$('#sparePartsNewGrid').jqxGrid('getcellvalue',labourindex,'spdiscount');
		        discount=(discount=="" || discount=="undefined" || typeof(discount)=="undefined" || discount==null?0.0:parseFloat(discount));
		        $('#sparePartsNewGrid').jqxGrid('setcellvalue',labourindex,'approvedvalue',(qty*rate)-discount);
		        $('#sparePartsNewGrid').jqxGrid('setcellvalue',labourindex,'sptotal',(qty*rate)-discount);
		        $('#sparePartsNewGrid').jqxGrid('setcellvalue',labourindex,'spvatpercent',$('#searchproductvatpercent').val());
		        $('#sparePartsNewGrid').jqxGrid('setcellvalue',labourindex,'spvatamount',$('#searchproductvatamount').val());
		        $('#sparePartsNewGrid').jqxGrid('setcellvalue',labourindex,'spnetamount',$('#searchproductnetamount').val());
		        $("#sparePartsNewGrid").jqxGrid("addrow", null, {});
		        
				$('#searchproductid,#searchproductname,#searchproductrate,#searchproductqty,#searchproductamount,#searchproductdiscount,#searchproductvatamount,#searchproductnetamount').val('');
				$('#searchproductdiscount').val(0);
				$('#searchproductid').focus();
				funSetDistSpareDiscount();
			}
		}
	}
	function funChangeEntity(){
		if($('#jobcardvocno').val()==''){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Please Select Job Card";
			return false;
		}
		else{
			document.getElementById("errormsg").innerText="";
		}
		var jobdocno=$('#jobcarddocno').val();
		$.get('getVatPercent.jsp',{'jobdocno':jobdocno},function(data){
			data=JSON.parse(data);
			console.log(data);
			var value=$('#cmbentitytype').val();
			if(value=="1"){
				$('#labourcostGrid').jqxGrid('setcolumnproperty', 'jobvatpercent', 'editable',false);
				$('#sparePartsNewGrid').jqxGrid('setcolumnproperty', 'spvatpercent', 'editable',false);
				$('#labourcostGrid').jqxGrid('setcolumnproperty', 'jobvatamount', 'editable',false);
				$('#sparePartsNewGrid').jqxGrid('setcolumnproperty', 'spvatamount', 'editable',false);
				$('#labourcostGrid').jqxGrid('setcolumnproperty', 'total', 'editable',false);
				$('#sparePartsNewGrid').jqxGrid('setcolumnproperty', 'approvedvalue', 'editable',false);
				$('#labourcostGrid').jqxGrid('setcolumnproperty', 'jobnetamount', 'editable',false);
				$('#sparePartsNewGrid').jqxGrid('setcolumnproperty', 'spnetamount', 'editable',false);
				
				//Updating grids when taxable
				var labourrows=$('#labourcostGrid').jqxGrid('getrows');
				var sparerows=$('#sparePartsNewGrid').jqxGrid('getrows');
				for(var i=0;i<labourrows.length;i++){
					var firstfield=$('#labourcostGrid').jqxGrid('getcellvalue',i,'jobtype');
					if(firstfield!="" && firstfield!="undefined" && firstfield!=null && typeof(firstfield)!="undefined"){
						$('#labourcostGrid').jqxGrid('setcellvalue',i,'jobvatpercent',data.vatpercent);
					}
				}
				for(var i=0;i<sparerows.length;i++){
					var firstfield=$('#sparePartsNewGrid').jqxGrid('getcellvalue',i,'description');
					if(firstfield!="" && firstfield!="undefined" && firstfield!=null && typeof(firstfield)!="undefined"){
						$('#sparePartsNewGrid').jqxGrid('setcellvalue',i,'spvatpercent',data.vatpercent);
					}
				}
			}
			else{
				$('#labourcostGrid').jqxGrid('setcolumnproperty', 'jobvatpercent', 'editable',true);
				//$('#sparePartsNewGrid').jqxGrid('setcolumnproperty', 'spvatpercent', 'editable',true);
				$('#labourcostGrid').jqxGrid('setcolumnproperty', 'jobvatamount', 'editable',true);
				//$('#sparePartsNewGrid').jqxGrid('setcolumnproperty', 'spvatamount', 'editable',true);
			}
			if(parseInt(data.insurcldocno)>0 ){
				if(value=="0"){
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="Taxable Only,Insur.Company Exists";
					$('#cmbentitytype').val(1);
					return false;
				}
			}
			$('#jobvatpercent,#searchproductvatpercent').val(data.vatpercent);
			if($('#cmbentitytype').val()=='1'){
				$('#jobvatpercent,#searchproductvatpercent,#jobvatamount,#searchproductvatamount').attr('readonly',true);
			}
			else{
				$('#jobvatpercent,#searchproductvatpercent').attr('readonly',false);
			}
		});
		
	}
	
	function funSetDistJobDiscount(){
		if($('#mode').val()=='A' || $('#mode').val()=='E'){
			var distdiscount=$('#distservicediscount').val();
        	distdiscount=(distdiscount=="" || distdiscount==null || distdiscount=="undefined" || typeof(distdiscount)=="undefined"?0.0:parseFloat(distdiscount));
        	var labourrows=$('#labourcostGrid').jqxGrid('getrows');
        	var totalamount=0.0;
        	for(var i=0;i<labourrows.length;i++){
        		var jobid=$('#labourcostGrid').jqxGrid('getcellvalue',i,'jobid');
        		if(jobid!="" && jobid!=null && jobid!="undefined" && typeof(jobid)!="undefined"){
        			var rate=parseFloat($('#labourcostGrid').jqxGrid('getcellvalue',i,'rate'));
            		var hrs=parseFloat($('#labourcostGrid').jqxGrid('getcellvalue',i,'hrs'));
            		if(parseInt($('#labourcostGrid').jqxGrid('getcellvalue',i,'taxable'))==1 && rate>0.0 && hrs>0.0){
            			totalamount+=(hrs*rate);
            		}
            		
        		}	
        	}
        	var lastindex=0;
        	for(var i=0;i<labourrows.length;i++){
        		var jobid=$('#labourcostGrid').jqxGrid('getcellvalue',i,'jobid');
        		if(jobid!="" && jobid!=null && jobid!="undefined" && typeof(jobid)!="undefined"){
        			var rate=parseFloat($('#labourcostGrid').jqxGrid('getcellvalue',i,'rate'));
            		var hrs=parseFloat($('#labourcostGrid').jqxGrid('getcellvalue',i,'hrs'));
            		var amount=rate*hrs;
            		
            		var currentdistdiscount=0.0;
            		if(parseFloat(amount)>0.0){
            			currentdistdiscount=(amount/totalamount)*distdiscount;
            			lastindex=i;
            		}
            		
            		currentdistdiscount=parseFloat(currentdistdiscount).toFixed(2);
            		currentdistdiscount=Math.round(currentdistdiscount * 100) / 100;
            		
            		var jobdiscount=$('#labourcostGrid').jqxGrid('getcellvalue',i,'jobdiscount');
            		jobdiscount=(jobdiscount=="" || jobdiscount==null || jobdiscount=="undefined" || typeof(jobdiscount)=="undefined"?0.0:parseFloat(jobdiscount));
            		
            		var jobvatpercent=$('#labourcostGrid').jqxGrid('getcellvalue',i,'jobvatpercent');
            		jobvatpercent=(jobvatpercent=="" || jobvatpercent==null || jobvatpercent=="undefined" || typeof(jobvatpercent)=="undefined"?0.0:parseFloat(jobvatpercent));
            		var subtotal=0.0;
            		var taxable=$('#labourcostGrid').jqxGrid('getcellvalue',i,'taxable');
            		taxable=(taxable=="" || taxable==null || taxable=="undefined" || typeof(taxable)=="undefined"?0:parseInt(taxable));
            		if(parseInt(taxable)==1){
            			subtotal=(parseFloat(amount)-parseFloat(jobdiscount))-parseFloat(currentdistdiscount);
            			$('#labourcostGrid').jqxGrid('setcellvalue',i,'distservicediscount',currentdistdiscount);
            		
            		}
            		else{
            			subtotal=(parseFloat(amount)-parseFloat(jobdiscount));
            		}
            		
            		subtotal=subtotal.toFixed(2);
            		var vatamount=parseFloat(subtotal)*(parseFloat(jobvatpercent)/100);
            		vatamount=vatamount.toFixed(2);
            		var netamount=parseFloat(subtotal)+parseFloat(vatamount);
            		netamount=netamount.toFixed(2);
            		$('#labourcostGrid').jqxGrid('setcellvalue',i,'total',subtotal);
            		$('#labourcostGrid').jqxGrid('setcellvalue',i,'jobtotal',subtotal);
            		$('#labourcostGrid').jqxGrid('setcellvalue',i,'jobdiscount',jobdiscount);
            		$('#labourcostGrid').jqxGrid('setcellvalue',i,'jobvatpercent',jobvatpercent);
            		$('#labourcostGrid').jqxGrid('setcellvalue',i,'jobvatamount',vatamount);
            		$('#labourcostGrid').jqxGrid('setcellvalue',i,'jobnetamount',netamount);
        		}	
        	}
        	
        	var griddist=$("#labourcostGrid").jqxGrid("getcolumnaggregateddata", "distservicediscount", ["sum"]);
        	griddist=(griddist.sum)+"";
			griddist=griddist.replace(/,/g, '');
			griddist=(griddist=="" || griddist==null || griddist=="undefined" || typeof(griddist)=="undefined"?0.0:parseFloat(griddist));
			if(parseFloat(griddist)>0.0){
				var remaining=parseFloat(griddist)-parseFloat(distdiscount);
				remaining=parseFloat(remaining).toFixed(2);
				if(parseFloat(remaining)>0.0){					
					var currvalue=$('#labourcostGrid').jqxGrid('getcellvalue',lastindex,'distservicediscount');
					$('#labourcostGrid').jqxGrid('setcellvalue',lastindex,'distservicediscount',currvalue-remaining);
				}
			}
		}
        	
	}
        
	function funSetDistSpareDiscount(){
		if($('#mode').val()=='A' || $('#mode').val()=='E'){
			var distdiscount=$('#distsparediscount').val();
        	distdiscount=(distdiscount=="" || distdiscount==null || distdiscount=="undefined" || typeof(distdiscount)=="undefined"?0.0:parseFloat(distdiscount));
        	var labourrows=$('#sparePartsNewGrid').jqxGrid('getrows');
        	var totalamount=0.0;
        	for(var i=0;i<labourrows.length;i++){
        		var description=$('#sparePartsNewGrid').jqxGrid('getcellvalue',i,'description');
        		if(description!="" && description!=null && description!="undefined" && typeof(description)!="undefined"){
        			var rate=parseFloat($('#sparePartsNewGrid').jqxGrid('getcellvalue',i,'sprate'));
            		var hrs=parseFloat($('#sparePartsNewGrid').jqxGrid('getcellvalue',i,'qty'));
            		//if(parseInt($('#sparePartsNewGrid').jqxGrid('getcellvalue',i,'taxable'))==1){
            		if(rate>0.0 && hrs>0.0){
            			totalamount+=(hrs*rate);
            		}
            			
            		//}
            		
        		}	
        	}
        	var lastindex=0;
        	for(var i=0;i<labourrows.length;i++){
        		var description=$('#sparePartsNewGrid').jqxGrid('getcellvalue',i,'description');
        		if(description!="" && description!=null && description!="undefined" && typeof(description)!="undefined"){
        			var rate=parseFloat($('#sparePartsNewGrid').jqxGrid('getcellvalue',i,'sprate'));
            		var hrs=parseFloat($('#sparePartsNewGrid').jqxGrid('getcellvalue',i,'qty'));
            		var amount=rate*hrs;
            		console.log(amount+"::"+totalamount+"::"+distdiscount);
            		var currentdistdiscount=0.0;
            		if(amount>0.0){
            			currentdistdiscount=(amount/totalamount)*distdiscount;
            			lastindex=i;
            		}
            		currentdistdiscount=currentdistdiscount.toFixed(2);
            		currentdistdiscount=Math.round(currentdistdiscount * 100) / 100;
            		$('#sparePartsNewGrid').jqxGrid('setcellvalue',i,'distsparediscount',currentdistdiscount);
            		
            		var jobdiscount=$('#sparePartsNewGrid').jqxGrid('getcellvalue',i,'spdiscount');
            		jobdiscount=(jobdiscount=="" || jobdiscount==null || jobdiscount=="undefined" || typeof(jobdiscount)=="undefined"?0.0:parseFloat(jobdiscount));
            		
            		var jobvatpercent=$('#sparePartsNewGrid').jqxGrid('getcellvalue',i,'spvatpercent');
            		jobvatpercent=(jobvatpercent=="" || jobvatpercent==null || jobvatpercent=="undefined" || typeof(jobvatpercent)=="undefined"?0.0:parseFloat(jobvatpercent));
            		var subtotal=0.0;
            		subtotal=(parseFloat(amount)-parseFloat(jobdiscount))-parseFloat(currentdistdiscount);
            		/*var taxable=$('#sparePartsNewGrid').jqxGrid('getcellvalue',i,'taxable');
            		taxable=(taxable=="" || taxable==null || taxable=="undefined" || typeof(taxable)=="undefined"?0:parseInt(taxable));
            		if(taxable==1){
            			subtotal=(parseFloat(amount)-parseFloat(jobdiscount))-parseFloat(currentdistdiscount);
            		}
            		else{
            			subtotal=(parseFloat(amount)-parseFloat(jobdiscount));
            		}*/
            		
            		subtotal=subtotal.toFixed(2);
            		var vatamount=parseFloat(subtotal)*(parseFloat(jobvatpercent)/100);
            		vatamount=vatamount.toFixed(2);
            		var netamount=parseFloat(subtotal)+parseFloat(vatamount);
            		netamount=netamount.toFixed(2);
            		$('#sparePartsNewGrid').jqxGrid('setcellvalue',i,'approvedvalue',subtotal);
            		$('#sparePartsNewGrid').jqxGrid('setcellvalue',i,'sptotal',subtotal);
            		$('#sparePartsNewGrid').jqxGrid('setcellvalue',i,'spdiscount',jobdiscount);
            		$('#sparePartsNewGrid').jqxGrid('setcellvalue',i,'spvatpercent',jobvatpercent);
            		$('#sparePartsNewGrid').jqxGrid('setcellvalue',i,'spvatamount',vatamount);
            		$('#sparePartsNewGrid').jqxGrid('setcellvalue',i,'spnetamount',netamount);
        		}	
        	}
        	
        	var griddist=$("#sparePartsNewGrid").jqxGrid("getcolumnaggregateddata", "distsparediscount", ["sum"]);
        	griddist=(griddist.sum)+"";
			griddist=griddist.replace(/,/g, '');
			griddist=(griddist=="" || griddist==null || griddist=="undefined" || typeof(griddist)=="undefined"?0.0:parseFloat(griddist));
			if(parseFloat(griddist)>0.0){
				var remaining=parseFloat(griddist)-parseFloat(distdiscount);
				remaining=parseFloat(remaining).toFixed(2);
				if(parseFloat(remaining)>0.0){					
					var currvalue=$('#sparePartsNewGrid').jqxGrid('getcellvalue',lastindex,'distsparediscount');
					$('#sparePartsNewGrid').jqxGrid('setcellvalue',lastindex,'distsparediscount',currvalue-remaining);
				}
			}
		}
        	
	}
</script>
<style>
	
</style>
</head>	
<body onLoad="setValues();">
	<div id="mainBG" class="homeContent" data-type="background"> 
		<form id="frmEstimationAdditionV4" action="saveEstimationAdditionV4" method="post" autocomplete="off" class="form-inline">
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
    <td width="50%"><input type="text" name="gateuserdetails" id="gateuserdetails" readonly value='<s:property value="gateuserdetails"/>' style="width:99%;" class="readonly"></td>
  	<td align="right" hidden="true">Entity Type</td>
  	<td hidden="true"><input type="hidden" name="hidcmbentitytype" id="hidcmbentitytype" value='<s:property value="hidcmbentitytype"/>'/>
  	<select style="width:99%;" name="cmbentitytype" id="cmbentitytype" onchange="funChangeEntity();"><option value="1">Taxable</option><option value="0">Non-Taxable</option></select></td>
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
    <td colspan="11"><fieldset class="greenClass"><legend>Complaints</legend>
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
    	<td align="right">Qty/Hrs</td>
    	<td><input type="text" name="jobqty" id="jobqty" onKeyPress="javascript:return isNumber (event,id)"></td>
    	<td align="right">Rate</td>
    	<td><input type="text" name="jobrate" id="jobrate" style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
    	<td align="right">Amount</td>
    	<td><input type="text" name="jobamount" id="jobamount" style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
    </tr>
    <tr>	
    	<td align="right">Discount</td>
    	<td><input type="text" name="jobdiscount" id="jobdiscount" style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
    	<td align="right">VAT %</td>
    	<td><input type="text" name="jobvatpercent" id="jobvatpercent" style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
    	<td align="right">VAT Amount</td>
    	<td><input type="text" name="jobvatamount" id="jobvatamount" style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
    	<td align="right">Net Amount</td>
    	<td><input type="text" name="jobnetamount" id="jobnetamount" style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
    	<td align="right" hidden="true">Remarks</td>
    	<td width="20%" hidden="true"><input type="text" name="jobremarks" id="jobremarks" style="width:90%;"></td>
	    <td><input type="button" id="btnaddjob" name="btnaddjob" value="Add" onclick="funAddJob();"></td>
    </tr>
    <tr>
    <td colspan="11"><fieldset class="yellowClass"><legend>Services</legend>
    	<div id="labourcostdiv"><jsp:include page="labourcostGrid.jsp"></jsp:include></div>
        </fieldset></td>
    </tr>
    <tr hidden="true">
    	<td align="right">Total</td>
    	<td><input type="text" name="servicestotal" id="servicestotal"  value='<s:property value="servicestotal"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
    	<td align="right">Discount</td>
    	<td><input type="text" name="servicesdiscount" id="servicesdiscount"  value='<s:property value="servicesdiscount"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
    	<td align="right">Net Services Total</td>
    	<td><input type="text" name="netservices" id="netservices"  value='<s:property value="netservices"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
    </tr>
  	<tr>
    	<td>Distributed Discount</td>
    	<td><input type="text" name="distservicediscount" id="distservicediscount"  value='<s:property value="distservicediscount"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);" onchange="funSetDistJobDiscount();"></td>
    	<td>&nbsp;</td>
    	<td align="left" colspan="5">
    		<input type="checkbox" name="chkservicelumsum" id="chkservicelumsum" onchange="setServiceLumSum();">&nbsp;&nbsp;Service Lumpsum
    		<input type="hidden" name="hidchkservicelumsum" id="hidchkservicelumsum" value='<s:property value="hidchkservicelumsum"/>'>
    		<input type="text" name="servicelumsumamt" id="servicelumsumamt" value='<s:property value="servicelumsumamt"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);">
    	</td>
    	
    </tr>
    <tr><td colspan="10"><hr></td></tr>
    <tr>
    	<td align="right">Product Id</td>
    	<td><input type="text" name="searchproductid" id="searchproductid" onkeyup="funFilterList(this);"/>
    		<ul class="list-group" data-type="product" style="display:none;max-height:250px;overflow-y:auto;"></ul>
    	</td>
    	<td align="right">Product Name</td>
    	<td><input type="text" name="searchproductname" id="searchproductname" onkeyup="funFilterList(this);"/>
    		<ul class="list-group"  data-type="product" style="display:none;max-height:250px;overflow-y:auto;"></ul>
    	</td>
    	<td align="right">Qty</td>
    	<td><input type="text" name="searchproductqty" id="searchproductqty"/>
    	</td>
    	<td align="right">Rate</td>
    	<td><input type="text" name="searchproductrate" id="searchproductrate" style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"/>
    	<input type="hidden" name="searchproductpsrno" id="searchproductpsrno">
    	</td>
    	<td align="right">Amount</td>
    	<td><input type="text" name="searchproductamount" id="searchproductamount" style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
    </tr>
    <tr>	
    	<td align="right">Discount</td>
    	<td><input type="text" name="searchproductdiscount" id="searchproductdiscount" style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
    	<td align="right">VAT %</td>
    	<td><input type="text" name="searchproductvatpercent" id="searchproductvatpercent" style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
    	<td align="right">VAT Amount</td>
    	<td><input type="text" name="searchproductvatamount" id="searchproductvatamount" style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
    	<td align="right">Net Amount</td>
    	<td><input type="text" name="searchproductnetamount" id="searchproductnetamount" style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
    	<td><input type="button" id="btnaddspare" name="btnaddspare" value="Add" onclick="funAddSpare();"></td>	
    </tr>
    
  <tr>
    <td colspan="11"><fieldset class="redClass"><legend>Spare Parts</legend>
    	<div id="sparepartsdiv"><jsp:include page="sparePartsNewGrid.jsp"></jsp:include></div>
        </fieldset></td>
    </tr>
    <tr hidden="true">
    	<td align="right">Total</td>
    	<td><input type="text" name="sparetotal" id="sparetotal"  value='<s:property value="sparetotal"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
    	<td align="right">Discount</td>
    	<td><input type="text" name="sparediscount" id="sparediscount"  value='<s:property value="sparediscount"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
    	<td align="right" width="10%">Net Spare Total</td>
    	<td><input type="text" name="netspare" id="netspare"  value='<s:property value="netspare"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
    </tr>
  <tr>
  <td>Distributed Discount</td>
    <td><input type="text" name="distsparediscount" id="distsparediscount"  value='<s:property value="distsparediscount"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);" onchange="funSetDistSpareDiscount();"></td>
  <td colspan="2" align="center"><input type="checkbox" id="chklumsum" name="chklumsum" onChange="setLumSum();">&nbsp;Spare Lumpsum &nbsp;&nbsp;<input type="text" id="lumsumamount" name="lumsumamount" value='<s:property value="lumsumamount"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
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
  	<td colspan="8"></td>
  	<td colspan="2">Net Total<input type="text" name="netesttotal" id="netesttotal"  value='<s:property value="netesttotal"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
  </tr>
  <tr hidden="true">
  	<td colspan="9" align="center"><button type="button" class="myButton" id="btnCalculate">Calculate Amount</button></td>
  </tr>
  
  <tr hidden="true">
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
      	<input value="0" type="hidden" name="netestsparetotal" id="netestsparetotal" value='<s:property value="netestsparetotal"/>'/>
      	<input value="0" type="hidden" name="netestservicetotal" id="netestservicetotal" value='<s:property value="netestservicetotal"/>'/>    
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
</body>
</html>