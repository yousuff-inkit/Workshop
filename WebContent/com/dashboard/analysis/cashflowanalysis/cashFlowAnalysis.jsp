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
<style type="text/css">
.myButtons {
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
}

.myButtons1 {
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
.myButtons1:hover {
	  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons1:active {
  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons1:focus {
  color: #fff;
  background-color: grey;
}
</style>

<script type="text/javascript">

	$(document).ready(function () {
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		   
		 $('#cashAccountSearchWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#cashAccountSearchWindow').jqxWindow('close');
		 
		 $('#bankAccountSearchWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#bankAccountSearchWindow').jqxWindow('close');
		
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	   
	     document.getElementById("rdsummary").checked=true;
	});
	
	function cashAccountSearchContent(url) {
	    $('#cashAccountSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#cashAccountSearchWindow').jqxWindow('setContent', data);
		$('#cashAccountSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function bankAccountSearchContent(url) {
	    $('#bankAccountSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#bankAccountSearchWindow').jqxWindow('setContent', data);
		$('#bankAccountSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getGridColumnCalculation(fromdate,todate){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				 items = items.split('***');
		          var difference=items[0];
		          var columns=items[1];
		          
		          if(parseInt(columns)==1) {
						$.messager.alert('Message','Period is too Long,Limit Reached.','warning');
						return;
		          }else {
		        	  
		        	  var branchval = document.getElementById("cmbbranch").value;
		        	  var summarytype = $('#cmbsummarytype').val();
		        	  var cash=document.getElementById("hidtxtcash").value;
		        	  var bank=document.getElementById("hidtxtbank").value;
		        	  
		     		  var check=1;
		        	  $("#overlay, #PleaseWait").show();
		     		 
		        	  if(document.getElementById("rdsummary").checked==true){
		        	  		$("#analysisDiv").load("cashFlowAnalysisGrid.jsp?rptType=1&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&summarytype='+summarytype+"&cash="+cash+"&bank="+bank+'&check='+check);
		        	  }else if(document.getElementById("rddetailed").checked==true){
		        	  		$("#analysisDiv").load("cashFlowAnalysisGrid.jsp?rptType=2&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&summarytype='+summarytype+"&cash="+cash+"&bank="+bank+'&check='+check);
		        	  }
		          }
    		}
		}
		x.open("GET", "getGridColumnCalculation.jsp?fromdate="+fromdate+"&todate="+todate, true);
		x.send();
   }
	
	function funExportBtn(){
	    JSONToCSVCon(dataExcelExport, 'CashFlowAnalysis', true);
	} 
	
	function funClearData(){
		$('#cmbbranch').val('a');
   	    $('#fromdate').val(new Date());
   	    var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	    var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	    var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	    $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		$('#todate').val(new Date());
		
		document.getElementById("rdsummary").checked=true;$('#cmbsummarytype').val('');	
		document.getElementById("searchdetails").value="";document.getElementById("searchby").value="";
		document.getElementById("txtcash").value="";document.getElementById("txtbank").value="";
		document.getElementById("hidtxtcash").value="";document.getElementById("hidtxtbank").value="";
		summaryDisable();
	}
	
	function summaryDisable(){
		if(document.getElementById("rddetailed").checked==true){
			$('#cmbsummarytype').attr('disabled', true);$('#cmbsummarytype').val('');
		}else if(document.getElementById("rdsummary").checked==true){
			$('#cmbsummarytype').attr('disabled', false); $('#cmbsummarytype').val('');
		}
	}
	
	function getCashAccountDetailsSearch(){
	 	 cashAccountSearchContent('cashAccountSearch.jsp');
	}

	function getBankAccountDetailsSearch(){
		bankAccountSearchContent('bankAccountSearch.jsp');
	}
	
	function setSearch(){
		
		var value=$('#searchby').val().trim();
		
		if(value=="cash"){
			getCashAccountDetailsSearch();
		} else if(value=="bank"){
			getBankAccountDetailsSearch();
		} else{}
	}
	
	function setRemove(){
		
		var value=$('#searchby').val().trim();
		
		if(value=="cash"){
			document.getElementById("searchdetails").value="";
			document.getElementById("txtcash").value="";
			document.getElementById("hidtxtcash").value="";
			if(document.getElementById("txtbank").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("txtbank").value; 
			} 
		} else if(value=="bank"){
			document.getElementById("searchdetails").value="";
			document.getElementById("txtbank").value="";
			document.getElementById("hidtxtbank").value="";
			if(document.getElementById("txtcash").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("txtcash").value; 
			} 
		} 
	}
	
	function funreload(event){
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 
		 if(fromdate==todate) {
				$.messager.alert('Message','Not a Valid Period,From Date & To Date are Same.','warning');
				return;
         }
		 
		 if(document.getElementById("rdsummary").checked==true){
		 	if($('#cmbsummarytype').val()=='') {
				$.messager.alert('Message','Please Choose a Summary Type.','warning');
				return;
		 	}
         }
		 
		 getGridColumnCalculation(fromdate,todate);
	}
	
</script>
</head>
<body onload="getBranch();summaryDisable();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr>
	 <td align="right"><label class="branch">Period</label></td>
     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr>
	<td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr>  
	<tr><td colspan="2">
	  <fieldset><legend><b><label class="branch">Report Type</label></b></legend>
	  <table width="100%">
      <tr>
      <td align="left"><input type="radio" id="rdsummary" name="rdo" onclick="summaryDisable();" value="rdsummary"><label for="rdsummary" class="branch">Summary</label></td>
      <td>      
      <select id="cmbsummarytype" name="cmbsummarytype" style="width:80%;" onchange="clearAccountInfo();" value='<s:property value="cmbsummarytype"/>'>
      <option value="">--Select--</option><option value="All">All</option><option value="604">Cash</option><option value="305">Bank</option></select>
      </td>
      </tr>
      <tr>
      <td width="40%" align="left"><input type="radio" id="rddetailed" name="rdo" onclick="summaryDisable();" value="rddetailed"><label for="rddetailed" class="branch">Detailed</label></td>
      <td width="60%">&nbsp;</td>
      </tr>
      </table></fieldset>
	</td></tr>  
	<tr><td colspan="2">
	<table width="100%">
  <tr>
    <td align="right"><label class="branch">Search By</label></td>
    <td align="left"><select name="searchby" id="searchby"><option value="">--Select--</option>
	<option value="cash">Cash</option><option value="bank">Bank</option></select></td>
    <td><button type="button" name="btnadditem" id="additem" class="myButtons1" onClick="setSearch();">+</button></td>
    <td><button type="button" name="btnremoveitem" id="btnremoveitem" class="myButtons1" onclick="setRemove();">-</button></td>
  </tr>
  <tr>
    <td colspan="4" align="center"><textarea id="searchdetails" style="height:140px;width:230px;font: 10px Tahoma;resize:none" name="searchdetails" readonly="readonly"><s:property value="searchdetails"></s:property></textarea>
    </td>
  </tr>
</table></td></tr>
	<tr><td colspan="2"><center><input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();"></center></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2"><input type="hidden" name="txtcash" id="txtcash"><input type="hidden" name="hidtxtcash" id="hidtxtcash">
			  <input type="hidden" name="txtbank" id="txtbank"><input type="hidden" name="hidtxtbank" id="hidtxtbank"></td></tr>  
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="analysisDiv"><jsp:include page="cashFlowAnalysisGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>

<div id="cashAccountSearchWindow">
	<div></div>
</div>
<div id="bankAccountSearchWindow">
	<div></div>
</div>

</div>
</body>
</html>