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
</style>

<script type="text/javascript">

$(document).ready(function () {
	  // setType(null);
	  
	   $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	$('#vehdetaildiv').hide();
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	
	  $('#brandwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Brand Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#brandwindow').jqxWindow('close');
	   $('#modelwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Model Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#modelwindow').jqxWindow('close');
	   $('#groupwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Group Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#groupwindow').jqxWindow('close');
	   $('#yomwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'YOM Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#yomwindow').jqxWindow('close');
	   $('#fleetwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Fleet Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#fleetwindow').jqxWindow('close');
	   $('#accountwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#accountwindow').jqxWindow('close');
	   var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
       var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
       $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
      
});

function getBrand(){
	 $('#brandwindow').jqxWindow('open');
		$('#brandwindow').jqxWindow('focus');
		 brandSearchContent('brandSearch.jsp?id=1', $('#brandwindow'));

}


function getModel(){
	
	 $('#modelwindow').jqxWindow('open');
		$('#modelwindow').jqxWindow('focus');
		 modelSearchContent('modelSearch.jsp?id=1', $('#brandwindow'));

}

function getGroup(event){

	$('#groupwindow').jqxWindow('open');
	$('#groupwindow').jqxWindow('focus');
	 groupSearchContent('groupSearch.jsp?id=1', $('#groupwindow'));

}
function getYom(event){

	 $('#yomwindow').jqxWindow('open');
		$('#yomwindow').jqxWindow('focus');
		 yomSearchContent('yomSearch.jsp?id=1', $('#yomwindow'));
}
function getFleet(event){

	 $('#fleetwindow').jqxWindow('open');
		$('#fleetwindow').jqxWindow('focus');
		 fleetSearchContent('fleetSearch.jsp?id=1', $('#fleetwindow'));
}

function getAccount(value){

	$('#accountwindow').jqxWindow('open');
	$('#accountwindow').jqxWindow('focus');
	accountSearchContent('accountSearch.jsp?id=1&accounttype='+value, $('#accountwindow'));
}

function accountSearchContent(url) {
	$.get(url).done(function (data) {
    	$('#accountwindow').jqxWindow('setContent', data);
	}); 
}
function brandSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#brandwindow').jqxWindow('setContent', data);

}); 
}

function modelSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#modelwindow').jqxWindow('setContent', data);

}); 
}

function groupSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#groupwindow').jqxWindow('setContent', data);

}); 
}

function yomSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#yomwindow').jqxWindow('setContent', data);

}); 
}

function fleetSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#fleetwindow').jqxWindow('setContent', data);

}); 
}
function setSearch(){
	var value=$('#cmbaccounttype').val().trim();
	
	if(value=="brand"){
		getBrand();
	}
	else if(value=="model"){
		getModel();
	}
	else if(value=="group"){
		getGroup();
	}
	else if(value=="yom"){
		getYom();
	}
	else if(value=="fleet"){
		getFleet();
	}
	else if(value=="income" || value=="expense"){
		getAccount(value);
	}
	else{
		
	}
}

function setRemove(){
	var value=$('#cmbaccounttype').val().trim();
	

	 if(value=="brand"){
		document.getElementById("searchdetails").value="";
		document.getElementById("brand").value="";
		document.getElementById("hidbrand").value="";
		
		if(document.getElementById("model").value!=""){
			document.getElementById("searchdetails").value+=document.getElementById("model").value;	
		}
		if(document.getElementById("group").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
		}
		if(document.getElementById("yom").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
		}
		if(document.getElementById("fleet").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("fleet").value;	
		}
	}
	else if(value=="model"){
		document.getElementById("searchdetails").value="";
		document.getElementById("model").value="";
		document.getElementById("hidmodel").value="";
		
		if(document.getElementById("brand").value!=""){
			document.getElementById("searchdetails").value+=document.getElementById("brand").value;	
		}
		if(document.getElementById("group").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
		}
		if(document.getElementById("yom").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
		}
		if(document.getElementById("fleet").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("fleet").value;	
		}
	}
	else if(value=="group"){
		document.getElementById("searchdetails").value="";
		document.getElementById("group").value="";
		document.getElementById("hidgroup").value="";
		
		if(document.getElementById("brand").value!=""){
			document.getElementById("searchdetails").value+=document.getElementById("brand").value;	
		}
		if(document.getElementById("model").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("model").value;	
		}
		if(document.getElementById("yom").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
		}
		if(document.getElementById("fleet").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("fleet").value;	
		}
	}
	else if(value=="yom"){
		document.getElementById("searchdetails").value="";
		document.getElementById("yom").value="";
		document.getElementById("hidyom").value="";
		
		if(document.getElementById("brand").value!=""){
			document.getElementById("searchdetails").value+=document.getElementById("brand").value;	
		}
		if(document.getElementById("model").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("model").value;	
		}
		if(document.getElementById("group").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
		}
		if(document.getElementById("fleet").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("fleet").value;	
		}
	}
	else if(value=="fleet"){
		document.getElementById("searchdetails").value="";
		document.getElementById("yom").value="";
		document.getElementById("hidyom").value="";
		
		if(document.getElementById("brand").value!=""){
			document.getElementById("searchdetails").value+=document.getElementById("brand").value;	
		}
		if(document.getElementById("model").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("model").value;	
		}
		if(document.getElementById("group").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
		}
		if(document.getElementById("yom").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
		}
	}
	else if(value=="income"){
		document.getElementById("searchdetails").value="";
		document.getElementById("incomeaccounts").value="";
		document.getElementById("hidincomeaccounts").value="";
		
		if(document.getElementById("expenseaccounts").value!=""){
			document.getElementById("searchdetails").value+=document.getElementById("expenseaccounts").value;	
		}
		
	}
	else if(value=="expense"){
		document.getElementById("searchdetails").value="";
		document.getElementById("expenseaccounts").value="";
		document.getElementById("hidexpenseaccounts").value="";
		
		if(document.getElementById("incomeaccounts").value!=""){
			document.getElementById("searchdetails").value+=document.getElementById("incomeaccounts").value;	
		}
		
	}
	 
}


function funreload(event)
{
	if(document.getElementById("cmbbranch").value==""){
		$.messager.alert('Warning','Please Select Branch');
		return false;
	}
	if($('#account').val()==''){
		$.messager.alert('Warning','Please Select Accounts');
		return false;
	}
	var dateval=funDateInPeriod($('#todate').jqxDateTimeInput('getDate'));
	//alert(dateval);
	if(dateval==1){
		 var branch=document.getElementById("cmbbranch").value;
	     var fromdate=$('#fromdate').jqxDateTimeInput('val');
	     var todate=$('#todate').jqxDateTimeInput('val');
	     var grpby1=document.getElementById("grpby1").value;
	     var hidbrand=document.getElementById("hidbrand").value;
	     var hidmodel=document.getElementById("hidmodel").value;
	     var hidgroup=document.getElementById("hidgroup").value;
	     var hidyom=document.getElementById("hidyom").value;
	     var gridtype=document.getElementById("gridtype").value;
		var hidfleet=document.getElementById("hidfleet").value;
		var hidincomeaccount=document.getElementById("hidincomeaccount").value;
		var hidexpenseaccount=document.getElementById("hidexpenseaccount").value;
	    	 $("#overlay, #PleaseWait").show();
		if(document.getElementById("gridtype").value=="detail"){
			$("#vehdetaildiv").load("vehDetailGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&grpby1="+grpby1+"&hidbrand="+hidbrand+"&hidmodel="+hidmodel+"&hidgroup="+hidgroup+"&hidyom="+hidyom+"&id=1&gridtype="+gridtype+"&hidfleet="+hidfleet+"&accounts="+hidaccount);
		}
		else{
			 $("#vehprofitdiv").load("vehProfitGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&grpby1="+grpby1+"&hidbrand="+hidbrand+"&hidmodel="+hidmodel+"&hidgroup="+hidgroup+"&hidyom="+hidyom+"&id=1&gridtype="+gridtype+"&hidfleet="+hidfleet+"&incomeaccounts="+hidincomeaccount+"&expenseaccounts="+hidexpenseaccount);
		}	    	 
	
	}
	}
	

	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
		 document.getElementById("rdosummary").checked=true;
		 /* 
		 if(document.getElementById("gridtype").value==""){
			 var value=document.getElementById("rdosummary").value;
			 document.getElementById("rdosummary").checked=true;
			 setType(value);	 
		 } */
		 
	}
	function funExportBtn(){
		 //$("#vehProfitGrid").jqxGrid('exportdata', 'xls', 'Vehicle Profitability');
		 
	/* 	 if(document.getElementById("gridtype").value=="detail") {
		 	JSONToCSVCon(detailExcelExport, 'VehicleProfitability', true);
		 } else {
			JSONToCSVCon(summaryExcelExport, 'VehicleProfitability', true);
		 } */
		JSONToCSVCon(exceldata, 'Vehicle Profitability Account Wise', true);
	}

	
	function funClearData(){
		$('input[type=text],[type=hidden]').val('');
		$('textarea').val('');
		$('#grpby1').val('');
		$('#searchby').val('');
	}

	function setGrid(value){
		if(value=="detail"){
			$('#vehprofitdiv').hide();
			$('#vehdetaildiv').show();
			document.getElementById("gridtype").value="detail";
		}
		else{
			$('#vehprofitdiv').show();
			$('#vehdetaildiv').hide();
			document.getElementById("gridtype").value="summary";
		}
	}
	
</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmSalesInvoiceList" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="23%" align="center">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

 <tr>
   <td width="37%" align="right"><label class="branch">From Date</label></td><td width="63%"><div id="fromdate"></div></td></tr>
 <tr>
   <td align="right"><label class="branch">To Date</label></td>
   <td><div id="todate"></div></td>
 </tr>
  <tr>
   <td align="center" colspan="2"><input type="radio" name="rdosummary" id="rdosummary" value="summary" onchange="setGrid(this.value);">
   <label class="branch" for="rdosummary">Summary</label>&nbsp;&nbsp;<!-- <input type="radio" name="rdosummary" id="rdodetail" value="detail" onchange="setGrid(this.value);">
   <label class="branch" for="rdodetail">Detail</label> --></td>
 </tr>
 <tr hidden="true">
   <td align="right"><label class="branch">Grouping 1</label></td>
   <td><select name="grpby1" id="grpby1">
   <option value="">--Select--</option>
   <option value="brand">Brand</option>
   <option value="model">Model</option>
   <option value="group">Group</option>
   <option value="yom">YOM</option></select></td>
 </tr>
<tr hidden="true">
	<td align="right">
	 <label class="branch">Search By</label>
    </td>
    <td>
    <select name="searchby" id="searchby">
    <option value="">--Select--</option>
    <option value="brand">Brand</option>
    <option value="model">Model</option>
    <option value="group">Group</option>
    <option value="yom">YOM</option>
    <option value="fleet">Fleet</option>
    </select>
    &nbsp;&nbsp;
    </td>
	</tr>
	<tr>
	<td align="right">
	 <label class="branch">Account Type</label>
    </td>
    <td>
    <select name="cmbaccounttype" id="cmbaccounttype">
	    <option value="">--Select--</option>
	    <option value="income">Income</option>
	    <option value="expense">Expense</option>
    </select>
    &nbsp;&nbsp;<button type="button" name="btnadditem" id="additem" class="myButtons" onClick="setSearch();">+</button>&nbsp;&nbsp;<button  type="button" name="btnremoveitem" id="btnremoveitem" class="myButtons" onclick="setRemove();">-</button>
    </td>
</tr>
	<tr><td colspan="2"><textarea id="searchdetails" name="searchdetails" style="resize:none;font: 10px Tahoma;" rows="18" cols="50" readonly></textarea></td></tr>
	<tr>
	<td colspan="2" style="border-top:2px solid #DCDDDE;">
	 
	<center><input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();"></center>
   <br><br>
    </td>
	</tr>
		
	</table>
	</fieldset>
</td>
<td width="77%">
	<table width="100%">
		<tr>
			 <td> <div id="vehprofitdiv"><jsp:include page="vehProfitGrid.jsp"></jsp:include></div> 
			  <div id="vehdetaildiv"><jsp:include page="vehDetailGrid.jsp"></jsp:include></div>
			 </td>
			 <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  <input type="hidden" name="hidgroup" id="hidgroup">
			  <input type="hidden" name="hidmodel" id="hidmodel">
			  <input type="hidden" name="hidyom" id="hidyom">
			  <input type="hidden" name="hidbrand" id="hidbrand">
			  <input type="hidden" name="group" id="group">
			  <input type="hidden" name="model" id="model">
			  <input type="hidden" name="yom" id="yom">
			  <input type="hidden" name="brand" id="brand">
			  <input type="hidden" name="gridtype" id="gridtype">
			  <input type="hidden" name="fleet" id="fleet">
			  <input type="hidden" name="hidfleet" id="hidfleet">
			  <input type="hidden" name="incomeaccount" id="incomeaccount">
			  <input type="hidden" name="hidincomeaccount" id="hidincomeaccount">
			  <input type="hidden" name="expenseaccount" id="expenseaccount">
			  <input type="hidden" name="hidexpenseaccount" id="hidexpenseaccount">
			  
		</tr>
	</table>
</tr>
</table>
</div>

</div>
<div id="brandwindow">
<div></div>
</div>
<div id="modelwindow">
<div></div>
</div>
<div id="groupwindow">
<div></div>
</div>
<div id="yomwindow">
<div></div>
</div>
<div id="fleetwindow">
<div></div>
</div>
<div id="accountwindow">
<div></div>
</div>
</form>
</body>
</html>