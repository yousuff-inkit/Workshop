<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<% String contextPath=request.getContextPath();%>
<html>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
/* =========================================================
SCOPED UI: Modern Layout (Matches Client Master)
========================================================= */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 5px 15px;
    box-sizing: border-box;
    width: 100%;
}

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"],
.modern-ui select { 
    height: 24px !important; 
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus { 
    border-color: #007bff; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled,
.modern-ui select:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

/* Layout Utilities */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: wrap;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Middle Section Panels */
.modern-ui .middle-panel {
    border: 1px solid #c5d3e0; 
    padding: 20px 10px 10px 10px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 15px;
    margin-top: 12px;
}

.modern-ui .middle-panel-title { 
    position: absolute; 
    top: -12px;
    left: 10px; 
    background: #ffffff; 
    padding: 0 8px; 
    color: #0056b3;
    font-weight: bold; 
    font-size: 14px; 
    border-left: 3px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
}

/* Custom UI Buttons matching 24px height */
.modern-ui .myButton {
    height: 24px !important;
    line-height: 22px !important;
    padding: 0 12px;
    font-family: Arial, sans-serif;
    font-size: 11px;
    font-weight: bold;
    border-radius: 3px;
    cursor: pointer;
    text-shadow: none;
    transition: all 0.2s;
    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    border: none;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    white-space: nowrap;
}
.modern-ui .myButton:hover { background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); }

/* Search Icon Wrapper */
.modern-ui .input-search-container {
    position: relative;
    display: flex;
}
.modern-ui .input-search-container input {
    padding-right: 25px !important;
}
.modern-ui .magnifier-icon {
    position: absolute;
    right: 6px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #64748b; 
    z-index: 10;
}
.modern-ui .magnifier-icon:hover { color: #2563eb; }

/* Grid Wrappers */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 120px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

form label.error { color:red; font-weight:bold; }
#errormsg { color:red; font-weight:bold; text-align:center; margin-bottom: 10px; }
.ff { display: none; }
</style>

<script type="text/javascript">
$(document).ready(function () { 
	$('#btnvaluechange').hide();
	
	/* Formatted jqxDateTimeInput heights to match modern UI 24px */
    $("#masterdate").jqxDateTimeInput({  width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    $("#deliverydate").jqxDateTimeInput({  width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    
    /* force internal alignment AFTER render */
    setTimeout(function () {
        $("#masterdate, #deliverydate").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#masterdate, #deliverydate").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);
    
    $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27, theme: 'energyblue'});
	$('#accountSearchwindow').jqxWindow('close');
	$('#searchwndow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Product Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27, theme: 'energyblue'});
	$('#searchwndow').jqxWindow('close');  
	      
	$('#expencewindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Search ' , position : {x : 420, y : 87}, keyboardCloseKey: 27, theme: 'energyblue'});
	$('#expencewindow').jqxWindow('close');
	     
	$('#sidesearchwndow').jqxWindow({ width: '55%', height: '92%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Product Search ' , position: { x: 600, y: 0 }, keyboardCloseKey: 27, theme: 'energyblue'});
	$('#sidesearchwndow').jqxWindow('close');   
	     
	$('#refnosearchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27, theme: 'energyblue'});
	$('#refnosearchwindow').jqxWindow('close'); 
	 
	$('#locationwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Location Search' ,position: { x: 200, y: 70 }, keyboardCloseKey: 27, theme: 'energyblue'});
	$('#locationwindow').jqxWindow('close');  
		   
	$('#importwindow').jqxWindow({ width: '30%', height: '24.4%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Import Options' , position: { x: 500, y: 200 }, theme: 'energyblue', showCloseButton: false});
	$('#importwindow').jqxWindow('close');   
		     
	if($('#reftypeval').val()=="PIV") {
		$("#btnDelete").attr('disabled', true );
	} else {
		$("#btnDelete").attr('disabled', false );
	}
			   
	$('#rrefno').dblclick(function(){
		if($("#mode").val() == "A") {
			if(document.getElementById("puraccid").value=="") {
				document.getElementById("errormsg").innerText="Search Vendor";  
				document.getElementById("puraccid").focus();
				return 0;
			}
			$('#refnosearchwindow').jqxWindow('open');
			refsearchContent('refnosearch.jsp?'); 
		}
	}); 
	
	$('#txtlocation').dblclick(function(){
		if($("#mode").val() == "A" || $("#mode").val() == "E") {
			$('#locationwindow').jqxWindow('open');
			locationsearchContent('searchlocation.jsp?'); 
		}
	}); 
		   
    $('#puraccid').dblclick(function(){
    	if($('#mode').val()!= "view") {
	  	    $('#accountSearchwindow').jqxWindow('open');
	  	  	accountSearchContent('accountsDetailsSearch.jsp?');
    	}
	});   
});

function funcheckaccinvendor() {
	if(document.getElementById("puraccid").value=="") {
		document.getElementById("errormsg").innerText="Search Vendor";  
		document.getElementById("puraccid").focus();
	    return 0;
	}
}

function expenceSearchContent(url) {
	$('#expencewindow').jqxWindow('open');
    $.get(url).done(function (data) {
    	$('#expencewindow').jqxWindow('setContent', data);
    	$('#expencewindow').jqxWindow('bringToFront');
	}); 
} 

function getloc(event){
	var x= event.keyCode;
	if(x==114){
		$('#locationwindow').jqxWindow('open');
	  	locationsearchContent('searchlocation.jsp?');   
	}
}  

function getrefno(event) {
	var x= event.keyCode;
	if(x==114){
		$('#refnosearchwindow').jqxWindow('open');
	  	refsearchContent('refnosearch.jsp?');  
	}
}  
	 
function refsearchContent(url) {
	$.get(url).done(function (data) {
       $('#refnosearchwindow').jqxWindow('setContent', data);
	}); 
}

function importsearchcontent(url) {
	$('#importwindow').jqxWindow('open');
	$.get(url).done(function (data) {
	    $('#importwindow').jqxWindow('setContent', data);
	}); 
}

function locationsearchContent(url) {
	$.get(url).done(function (data) {
		$('#locationwindow').jqxWindow('setContent', data);
	}); 
}

function calculationsearchContent(url) {
	$.get(url).done(function (data) {
		$('#calculationwindow').jqxWindow('setContent', data);
	}); 
}

function getaccountdetails(event){
 	var x= event.keyCode;
 	if($('#mode').val()!="view") {
 	 	if(x==114){
 	  		$('#accountSearchwindow').jqxWindow('open');
 	 		accountSearchContent('accountsDetailsSearch.jsp?');    
 	 	}
 	}
}  
	  
function accountSearchContent(url) {
	$.get(url).done(function (data) {
    	$('#accountSearchwindow').jqxWindow('setContent', data);
	}); 
}
	  
function reqproductSearchContent(url) {
	$.get(url).done(function (data) {
		$('#sidesearchwndow').jqxWindow('open');
	    $('#sidesearchwndow').jqxWindow('setContent', data);
	}); 
} 

function productSearchContent(url) {
	$.get(url).done(function (data) {
		$('#sidesearchwndow').jqxWindow('open');
     	$('#sidesearchwndow').jqxWindow('setContent', data);
	}); 
} 

function funReset(){
	//$('#purchaseInv')[0].reset(); 
}

function funReadOnly(){
	$('#purchaseInv input').attr('readonly', true );
	$('#purchaseInv select').attr('disabled', true );
	$('#masterdate').jqxDateTimeInput({ disabled: true});
	$('#deliverydate').jqxDateTimeInput({ disabled: true});
	$('#process1').attr('disabled', true);
	$('#rrefno').attr('disabled', true);
	$('#producttype').val(0);	 
	$('#cmbcurr').attr('disabled', true);		
	$('#btnvaluechange').hide();
	$('#acctype').attr('disabled', true);
	chkfoc(); 
}

function funRemoveReadOnly(){
	chkproductconfig();
	document.getElementById("editdata").value="";
	chkmultiqty();
	$('#purchaseInv input').attr('readonly', false );
	$('#serviecGrid').jqxGrid('setcolumnproperty', 'discount',  "editable", true);
	$('#serviecGrid').jqxGrid('setcolumnproperty', 'discper',  "editable", true);
	$('#purchaseInv select').attr('disabled', false );
    $('#currate').attr('readonly', true);
	$('#puraccid').attr('readonly', true);
	$('#puraccname').attr('readonly', true);
	$('#rrefno').attr('disabled', false);
	$('#rrefno').attr('readonly', false);
	$('#btnvaluechange').hide();
	$('#txtlocation').attr('readonly', true);
	gettaxaccount(1);	
	$('#st').attr('readonly', true );
	$('#taxontax1').attr('readonly', true );
	$('#taxontax2').attr('readonly', true );
	$('#taxontax3').attr('readonly', true );
	$('#taxtotal').attr('readonly', true );
	$('#process1').attr('disabled', false);
	$('#producttype').val(0);	 
	$('#masterdate').jqxDateTimeInput({ disabled: false});
	$('#deliverydate').jqxDateTimeInput({ disabled: false});
	$('#cmbcurr').attr('disabled', false);
	$('#acctype').attr('disabled', false);
	$('#docno').attr('readonly', true);
	$("#serviecGrid").jqxGrid({ disabled: false});
	$('#descPercentage').attr('disabled', true);
	$('#descountVal').attr('disabled', true);
	$('#docno').attr('readonly', true);
	$('#orderValue').attr('readonly', true);
	$('#productTotal').attr('readonly', true);
	$('#netTotaldown').attr('readonly', true);
	 
	if ($("#mode").val() == "A") {
		$('#masterdate').val(new Date());
		$('#deliverydate').val(new Date());
		$("#serviecGrid").jqxGrid('clear');
		$("#serviecGrid").jqxGrid('addrow', null, {});
		chkfoc(); 
	}
	
  	if ($("#mode").val() == "E") {
		$('#btnvaluechange').show();
		$("#serviecGrid").jqxGrid({ disabled: true});
	}  
  
  	$('#serviecGrid').jqxGrid('hidecolumn', 'cost_price');  
	getCurrencyIds();
}

function funFocus(){
   	$('#masterdate').jqxDateTimeInput('focus'); 	    		
}

function funDateInPeriodchk(value){
    var styear = new Date(window.parent.txtaccountperiodfrom.value);
    var edyear = new Date(window.parent.txtaccountperiodto.value);
    var mclose = new Date(window.parent.monthclosed.value);
    mclose.setHours(0,0,0,0);
    edyear.setHours(0,0,0,0);
    styear.setHours(0,0,0,0);
    var currentDate = new Date(new Date());
 
    if(value>currentDate){
    	document.getElementById("errormsg").innerText="Future Date, Transaction Restricted. ";
    	return 0;
    } 
    document.getElementById("errormsg").innerText="";
    return 1;
}

function funNotify(){
	var maindate = $('#masterdate').jqxDateTimeInput('getDate');
	var validdate=funDateInPeriodchk(maindate);
	if(validdate==0){
	   return 0; 
	}
	if($('#txtlocation').val()== ""){
		document.getElementById("errormsg").innerText="select location";
		document.getElementById("txtlocation").focus();
		return 0;
	}	  	
	if($('#cmbreftype').val()=="DIR"){
		save();
	} else {
		chkstock();
	}
}

function chkstock() {
	var rows = $("#serviecGrid").jqxGrid('getrows');
	var list = new Array();
	for(var i=0 ; i < rows.length; i++){
		if(parseInt(rows[i].prodoc)>0)  { 
		   list.push(rows[i].psrno+"::"+rows[i].specid+"::"+rows[i].qty+"::"+rows[i].oldqty+"::"+0);
		}
	}
	ajaxcallchk(list);
}
	   
function ajaxcallchk(list){
	var branch=document.getElementById("brchName").value;
	var location=document.getElementById("txtlocationid").value;
	var mode=$('#mode').val();
		
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200) {
			var items= x.responseText.trim();
		    if(items!="nodata" && items!="0") {
		 		document.getElementById("errormsg").innerText=""+items;  
		 		return 0;
			} else  if(items=="nodata") {
		 		document.getElementById("errormsg").innerText=" error!!";  
		 		return 0;
		 	} else {
			    save();
			}
		}
	}
	x.open("GET","validateqty.jsp?list="+list+"&branch="+branch+"&mode="+mode+"&location="+location,true);
	x.send();
}

function save(){	
	var purid= document.getElementById("puraccid").value;
	if(purid=="") {
		document.getElementById("errormsg").innerText=" Select An Account";
		document.getElementById("puraccid").focus();
		return 0;
	} else {
		document.getElementById("errormsg").innerText="";
	}
		   
	if(document.getElementById("txtlocation").value=="") {
		document.getElementById("errormsg").innerText="Search Location";  
		document.getElementById("txtlocation").focus();
	    return 0;
	} else {
		document.getElementById("errormsg").innerText="";
	}
		   
	if(document.getElementById('reftype').value=="DIR") {
	} else {
		if(document.getElementById("rrefno").value=="") {
			document.getElementById("errormsg").innerText=" Search Purchase Invoice ";  
			document.getElementById("rrefno").focus();
		    return 0;
		}
	}  
	   
	var refval= document.getElementById("nettotal").value;
	if(refval=="") {
		document.getElementById("nettotal").value=0;
	} else {
	   document.getElementById("errormsg").innerText="";
	}

	var rows = $("#serviecGrid").jqxGrid('getrows');
   	$('#serviecGridlength').val(rows.length);
  	for(var i=0 ; i < rows.length ; i++){
		newTextBox = $(document.createElement("input")) 
			.attr("type", "dil")
			.attr("id", "sertest"+i)
			.attr("name", "sertest"+i) 
			.attr("hidden", "true");           
				  
		newTextBox.val(rows[i].psrno+"::"+rows[i].prodoc+" :: "+rows[i].unitdocno+" :: "+rows[i].qty+" :: "
				+rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "+rows[i].qty
				+" :: "+rows[i].checktype+" :: "+rows[i].specid+" :: "+rows[i].discper+" :: "+rows[i].stockid+" :: "+rows[i].oldqty+" :: "+rows[i].foc+" :: "+rows[i].oldfoc
				+"::"+rows[i].taxper+"::"+rows[i].taxperamt+"::"+rows[i].taxamount+"::"); 
		newTextBox.appendTo('form');  
  	}   
	   
	if ($("#mode").val() == "E") {
		if($('#reftypeval').val()=="PIV") {
			$('#rrefno').attr('disabled', false);
		    $('#rrefno').attr('readonly', true);
		}
		
		$('#chkdiscount').attr('disabled', false);
		if(document.getElementById("chkdiscountval").value==1) {
			document.getElementById("chkdiscount").value = 1;
		 	$('#descPercentage').attr('disabled', false);
		 	$('#btnCalculate').attr('disabled', false);
		 	$('#descountVal').attr('disabled', false);
		}
		$('#rrefno').attr('disabled', false);
		$('#rrefno').attr('readonly', true);
	    $("#serviecGrid").jqxGrid({ disabled: false});
	} 
	document.getElementById("purchaseInv").submit();
} 

function funwarningopen(){
	$.messager.confirm('Confirm', 'Transaction Will Affect Already Inserted Values.', function(r){
		if (r){
			document.getElementById("editdata").value="Editvalue";
			if(document.getElementById('reftype').value=="DIR") {
				$('#rrefno').attr('disabled', true);
				$('#rrefno').attr('readonly', true);
			} else {
				$('#rrefno').attr('disabled', false);
				$('#rrefno').attr('readonly', true);
			}
	    	$("#serviecGrid").jqxGrid({ disabled: false});
	    	$("#serviecGrid").jqxGrid('addrow', null, {});
		}
	});
}

function funChkButton() {}

function funSearchLoad(){
	changeContent('mainsearch.jsp'); 
}

function getCurrencyIds(){
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200) {
			items= x.responseText;
	      	items=items.split('####');
			var curidItems=items[0];
			var curcodeItems=items[1];
			var currateItems=items[2];
			var multiItems=items[3];
			var optionscurr = '';
			if(curcodeItems.indexOf(",")>=0){
	            curidItems.split(",");
	            curcodeItems.split(",");
	            currateItems.split(",");
	            for ( var i = 0; i < curcodeItems.length; i++) {
	           		optionscurr += '<option value="' + curidItems[i] + '">' + curcodeItems[i] + '</option>';
	           	}
	            $("select#cmbcurr").html(optionscurr);
	        } else {
				optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
				$("select#cmbcurr").html(optionscurr);
				funRoundRate(currateItems,"currate");
				$('#currate').attr('readonly', true);
	      	}
	    }
	}
	x.open("GET","getCurrencyId.jsp",true);
	x.send();
}
	   
function getRatevalue(angel) {
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200) {
			var items= x.responseText;
	        funRoundRate(items,"currate"); 
	    } else { }
	}
	x.open("GET","getRateTo.jsp?curr="+a,true);
	x.send();
}
	   
function combochange() {
	if($('#cmbcurrval').val()!="") {
		$('#cmbcurr').val($('#cmbcurrval').val());   
	}
	if($('#hidcmbbilltype').val()!="") {
		$('#cmbbilltype').val($('#hidcmbbilltype').val());   
	}
	if($('#reftypeval').val()!="") {
		$('#reftype').val($('#reftypeval').val());
	}
	if($('#reftypeval').val()=="PIV") {
		$('#rrefno').attr('disabled', false);
		$('#rrefno').attr('readonly', true);
	}
}

function setValues() {
	if($('#hidmasterdate').val()){
		$("#masterdate").jqxDateTimeInput('val', $('#hidmasterdate').val());
	}
	if($('#hiddeliverydate').val()){
		$("#deliverydate").jqxDateTimeInput('val', $('#hiddeliverydate').val());
	}
	
	$("#btnEdit").attr('disabled', true );
	$("#btnDelete").attr('disabled', true ); 
	 
	var dis=document.getElementById("masterdoc_no").value;
	if(dis>0) {     
		var indexval1 = document.getElementById("masterdoc_no").value;   
		var reftypeval = document.getElementById("reftypeval").value;  
		var reqmasterdocno = document.getElementById("reqmasterdocno").value;  
		$("#sevdesc").load("serviecgrid.jsp?purdoc="+indexval1+"&reftype="+reftypeval+"&reqmasterdocno="+reqmasterdocno);
	} 

	if($('#msg').val()!=""){
		$.messager.alert('Message',$('#msg').val());
	} 
	
    combochange();
    gettaxaccount(1);
    document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
} 

function funPrintBtn(){
	if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
		var url=document.URL;
	    var reurl=url.split("saveActionpurInvret");
	    $("#docno").prop("disabled", false);                
		var win= window.open(reurl[0]+"printpurchaseReturn?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
		win.focus();
	} else {
		$.messager.alert('Message','Select a Document....!','warning');
		return false;
	}
}

$(function(){
	$('#purchaseInv').validate({
		rules: { 
			delterms:{maxlength:200},
			purdesc:{maxlength:200},
			payterms:{maxlength:200},
			puraccid:{required:true}
		},
		messages: {
			delterms: {maxlength:"  Max 200 chars"},
			purdesc: {maxlength:"  Max 200 chars"},
			payterms: {maxlength:"  Max 200 chars"},
			puraccid: {required:" *"}
		}
	});
});

function isNumber(evt) {
	var iKeyCode = (evt.which) ? evt.which : evt.keyCode
	if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
		document.getElementById("errormsg").innerText=" Enter Numbers Only";  
		return false;
	}
	document.getElementById("errormsg").innerText="";  
	return true;
}

function funrefdisslno() {
	if(document.getElementById('reftype').value=="DIR") {
		$('#rrefno').attr('disabled', true);
		$('#rrefno').attr('readonly', true);
		document.getElementById("errormsg").innerText="";
		document.getElementById("rrefno").value="";
		document.getElementById("reqmasterdocno").value="";
		$("#serviecGrid").jqxGrid('clear');
		$("#serviecGrid").jqxGrid('addrow', null, {});
		chkfoc();
	} else {
		$('#rrefno').attr('disabled', false);
		$('#rrefno').attr('readonly', true);
		document.getElementById("rrefno").value="";
		document.getElementById("reqmasterdocno").value="";
		$("#serviecGrid").jqxGrid('clear');
		$("#serviecGrid").jqxGrid('addrow', null, {});
		chkfoc();
	}
}
 
function gettaxaccount(val) {
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200) {
			var items= x.responseText.trim();
			var item = items.split('::');
			var method=item[0];
			var aa=item[1];
		      
			if(parseInt(method)>0) {
				if(parseInt(aa)==1) {
					document.getElementById("tax1per").value=item[3];
					document.getElementById("labeltax1").innerText=item[2];
					document.getElementById("typeoftaken").value=item[6];
					$('#taxontax2').hide();
					$('#taxontax3').hide();
				}
				if(parseInt(aa)==2) {
					document.getElementById("tax1per").value=item[3];
					document.getElementById("labeltax1").innerText=item[2];
					document.getElementById("tax2per").value=item[5];
					document.getElementById("labeltax2").innerText=item[4];
					document.getElementById("typeoftaken").value=item[6];
					$('#taxontax3').hide();
				}
				if(parseInt(aa)==3) {
					document.getElementById("tax1per").value=item[3];
					document.getElementById("labeltax1").innerText=item[2];
					document.getElementById("tax2per").value=item[5];
					document.getElementById("labeltax2").innerText=item[4];
					document.getElementById("typeoftaken").value=item[6];
					document.getElementById("tax3per").value=item[8];
					document.getElementById("labeltax3").innerText=item[7];
				}
			}
		}
	}
	x.open("GET","gettaxaccount.jsp?date="+document.getElementById("masterdate").value+"&cmbbilltype="+document.getElementById("cmbbilltype").value,true);
	x.send();
} 
		
function gettaxaccounts() {
	gettaxaccount(1);
}
		
function funcalutax() {
	var tax1=document.getElementById("tax1per").value;
	var tax2=document.getElementById("tax2per").value;
	var tax3=document.getElementById("tax3per").value;
	var typeoftaken=document.getElementById("typeoftaken").value;
	var st=document.getElementById("st").value;
	var producttotal=document.getElementById("netTotaldown").value;
	var tax1val=0;
	var tax2val=0;
	var tax3val=0;
	var finaltax=0;
			
	if(parseInt(typeoftaken)==-1) {
		if(parseFloat(tax1)>0) {
			tax1val=parseFloat(producttotal)*(parseFloat(tax1)/100);
			if(parseFloat(tax2)>0) {
				tax2val=parseFloat(tax1val)*(parseFloat(tax2)/100);
			} else {
				tax2val=0;
			}
			if(parseFloat(tax3)>0) {
				tax3val=parseFloat(tax2val)*(parseFloat(tax3)/100);
			} else {
				tax3val=0;
			}
		}
	} else {
		if(parseFloat(tax1)>0) {
			tax1val=parseFloat(st)*(parseFloat(tax1)/100);
			if(parseFloat(tax2)>0) {
				tax2val=parseFloat(tax1val)*(parseFloat(tax2)/100);
			} else {
				tax2val=0;
			}
			if(parseFloat(tax3)>0) {
				tax3val=parseFloat(tax2val)*(parseFloat(tax3)/100);
			} else {
				tax3val=0;
			}
		}
	}
			
	funRoundAmt4(tax1val,"taxontax1"); 
	funRoundAmt4(tax2val,"taxontax2");
	funRoundAmt4(tax3val,"taxontax3");
	
	finaltax=parseFloat(st)+parseFloat(tax1val)+parseFloat(tax2val)+parseFloat(tax3val);
	funRoundAmt4(finaltax,"taxtotal");
}
		
function funRoundAmt4(value,id){
	var res=parseFloat(value).toFixed(4);
	var res1=(res=='NaN'?"0":res);
	document.getElementById(id).value=res1;  
}      			
</script>
</head>

<body onLoad="getCurrencyIds();setValues();">

<div id="mainBG" class="homeContent" data-type="background">
<form id="purchaseInv" action="saveActionpurInvret" method="post" autocomplete="off"> 
<jsp:include page="../../../../header.jsp" />    
<jsp:include page="multiqty.jsp"></jsp:include>

<div class="modern-ui hidden-scrollbar">
    <div id="errormsg"></div>

    <!-- Top Details Panel -->
    <div class="middle-panel">
        <span class="middle-panel-title">Purchase Invoice Details</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Date</label>
            <div style="width: 125px;">
                <div id="masterdate" name="masterdate" value='<s:property value="masterdate"/>'></div>
            </div>
            <input type="hidden" name="hidmasterdate" id="hidmasterdate" value='<s:property value="hidmasterdate"/>'>
            
            <label class="lbl-right" style="width:100px; margin-left:auto;">Location</label>
            <div class="input-search-container" style="width:200px;">
                <input type="text" id="txtlocation" name="txtlocation" placeholder="Press F3" value='<s:property value="txtlocation"/>' onkeydown="getloc(event);"/>
                <svg class="magnifier-icon" onclick="$('#txtlocation').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="hidden" id="txtlocationid" name="txtlocationid" value='<s:property value="txtlocationid"/>'/>
            
            <label class="lbl-right" id="billname" style="width:100px; margin-left:auto;">Bill Type</label>
            <select id="cmbbilltype" name="cmbbilltype" onchange="gettaxaccounts()" style="width:125px;" value='<s:property value="cmbbilltype"/>'>
                <option value="1">ST</option>
                <option value="2">CST</option>
            </select>
            <input type="hidden" id="hidcmbbilltype" name="hidcmbbilltype" value='<s:property value="hidcmbbilltype"/>'/>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Ref No</label>
            <input type="text" name="refno" id="refno" style="width:125px;" value='<s:property value="refno"/>'>
            
            <label class="lbl-right" style="width:100px; margin-left:auto;">Doc No</label>
            <input type="text" name="docno" id="docno" style="width:200px;" tabindex="-1" value='<s:property value="docno"/>' readonly>
            
            <label class="lbl-right" style="width:100px; margin-left:auto;">Vendor</label>
            <div class="input-search-container" style="width:125px;">
                <input type="text" name="puraccid" id="puraccid" placeholder="Press F3" value='<s:property value="puraccid"/>' onKeyDown="getaccountdetails(event);">
                <svg class="magnifier-icon" onclick="$('#puraccid').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="text" id="puraccname" name="puraccname" value='<s:property value="puraccname"/>' style="flex:1; max-width:200px;" tabindex="-1" readonly>
        </div>
        
        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Currency</label>
            <select name="cmbcurr" id="cmbcurr" style="width:125px;" value='<s:property value="cmbcurr"/>' onchange="getRatevalue(this.value);">
                <option value="-1">--Select--</option>
            </select>
            
            <label class="lbl-right" style="width:60px;">Rate</label>
            <input type="text" name="currate" id="currate" style="width:80px;" value='<s:property value="currate"/>'>
            
            <label class="lbl-right" style="width:100px; margin-left:auto;">Ref Type</label>
            <select name="reftype" id="reftype" style="width:125px;" value='<s:property value="reftype"/>' onchange="funrefdisslno();">
                <option value="PIV">PIV</option>
            </select>
            
            <div class="input-search-container" style="width:150px; margin-left: 5px;">
                <input type="text" name="rrefno" id="rrefno" placeholder="Press F3" value='<s:property value="rrefno"/>' onfocus="funcheckaccinvendor();" onKeyDown="getrefno(event);">
                <svg class="magnifier-icon" onclick="$('#rrefno').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Delivery Date</label>
            <div style="width: 125px;">
                <div id="deliverydate" name="deliverydate" value='<s:property value="deliverydate"/>'></div>
            </div>
            <input type="hidden" name="hiddeliverydate" id="hiddeliverydate" value='<s:property value="hiddeliverydate"/>'>
            
            <label class="lbl-right" style="width:100px; margin-left:auto;">Delivery Terms</label>
            <input type="text" name="delterms" id="delterms" style="flex:1;" value='<s:property value="delterms"/>'>
        </div>
        
        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Payment Terms</label>
            <input type="text" name="payterms" id="payterms" style="flex:1;" value='<s:property value="payterms"/>'>
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:100px;">Description</label>
            <input type="text" name="purdesc" id="purdesc" style="flex:1;" value='<s:property value="purdesc"/>'>
            <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();" style="margin-left: 10px;">Value Change</button>
        </div>
    </div>
    
    <input type="text" name="gridtext" id="gridtext" style="display:none;" value='<s:property value="gridtext"/>'/>   
    <input type="text" name="gridtext1" id="gridtext1" style="display:none;" value='<s:property value="gridtext1"/>'/>   
    
    <div class="middle-panel">
        <span class="middle-panel-title">Service Details Grid</span>
        <div class="grid-container">
            <div id="sevdesc"><jsp:include page="serviecgrid.jsp"></jsp:include></div>  
        </div>
    </div>

    <!-- Summary and Tax Panel -->
    <div id="tax">
        <div class="middle-panel">
            <span class="middle-panel-title">Summary & Tax Details</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Product Total</label>
                <input type="text" name="productTotal" id="productTotal" style="width:150px; text-align:right;" readonly="readonly" value='<s:property value="productTotal"/>'>
                
                <label class="lbl-right" style="width:100px; margin-left:auto;">Discount</label>
                <input type="text" name="prddiscount" id="prddiscount" style="width:150px; text-align:right;" value='<s:property value="prddiscount"/>' onkeypress="javascript:return isNumber(event);">
                
                <label class="lbl-right" style="width:100px; margin-left:auto;">Net Total</label>
                <input type="text" name="netTotaldown" id="netTotaldown" style="width:150px; text-align:right; font-weight:bold; color:#0b45a2;" readonly="readonly" value='<s:property value="netTotaldown"/>' onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber(event);">
            </div>
            
            <hr style="border: 0; border-top: 1px dashed #c5d3e0; margin: 10px 0;">

            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Total Tax</label>
                <input type="text" id="st" name="st" style="width:150px;" value='<s:property value="st"/>'>
                
                <button type="button" class="myButton" id="process1" title="Process" onclick="funcalutax();" style="margin-left:5px;">Process</button>
                
                <label class="lbl-right" id="labeltax1" style="width:100px; margin-left:auto;"></label>
                <input type="text" id="taxontax1" name="taxontax1" style="width:125px;" value='<s:property value="taxontax1"/>'>
                
                <label class="lbl-right" id="labeltax2" style="width:100px; margin-left:auto;"></label>
                <input type="text" id="taxontax2" name="taxontax2" style="width:125px;" value='<s:property value="taxontax2"/>'>
                
                <label class="lbl-right" id="labeltax3" style="width:100px; margin-left:auto;"></label>
                <input type="text" id="taxontax3" name="taxontax3" style="width:125px;" value='<s:property value="taxontax3"/>'>
            </div>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:100px;">Net Tax Total</label>
                <input type="text" id="taxtotal" name="taxtotal" style="width:150px; text-align:right; font-weight:bold; color:#0b45a2;" value='<s:property value="taxtotal"/>'>
            </div>
        </div>
    </div>

    <!-- Hidden Logic Fields -->
    <div style="display:none;">
        <input type="hidden" id="expencenettotal" name="expencenettotal" value='<s:property value="expencenettotal"/>'/>    
        <input type="hidden" id="nettotal" name="nettotal" value='<s:property value="nettotal"/>'/>   
        <input type="hidden" id="chkdiscountval" name="chkdiscountval" value='<s:property value="chkdiscountval"/>'/>      
        <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'/>  
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>   
        <input type="hidden" id="descgridlenght" name="descgridlenght" value='<s:property value="descgridlenght"/>'/>   
        <input type="hidden" id="serviecGridlength" name="serviecGridlength" value='<s:property value="serviecGridlength"/>'/>    
        <input type="hidden" id="cmbcurrval" name="cmbcurrval" value='<s:property value="cmbcurrval"/>'/>    
        <input type="hidden" id="acctypeval" name="acctypeval" value='<s:property value="acctypeval"/>'/>  
        <input type="hidden" id="accdocno" name="accdocno" value='<s:property value="accdocno"/>'/>    
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="reftypeval" name="reftypeval" value='<s:property value="reftypeval"/>'/>
        <input type="hidden" id="reqmasterdocno" name="reqmasterdocno" value='<s:property value="reqmasterdocno"/>'/>
        <input type="hidden" id="producttype" name="producttype" value='<s:property value="producttype"/>'/>
        <input type="hidden" id="expgridlength" name="expgridlength" value='<s:property value="expgridlength"/>'/>
        <input type="hidden" id="editdata" name="editdata" value='<s:property value="editdata"/>'/>
        <input type="hidden" id="typeoftaken">
        <input type="hidden" id="tax1per">
        <input type="hidden" id="tax2per">
        <input type="hidden" id="tax3per">
        <input type="hidden" id="productchk" name="productchk" value='<s:property value="productchk"/>' />
    </div>

</div> 
</form>
</div> 

<!-- Search Windows -->
<div id="refnosearchwindow"><div></div></div>
<div id="accountSearchwindow"><div></div></div>
<div id="sidesearchwndow"><div></div></div>
<div id="importwindow"><div></div></div>
<div id="searchwndow"><div></div></div>
<div id="expencewindow"><div></div></div>
<div id="locationwindow"><div></div></div>
<div id="calculationwindow"><div></div></div>

</body>
</html>