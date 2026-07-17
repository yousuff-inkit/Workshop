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
 
select{
    height:15px;
}
</style>

<script type="text/javascript">

$(document).ready(function () {
   $("#btnExcel").click(function() {
		//JSONToCSVCon(repexceldata, 'Replacement List', true);
		//$("#vehiclelist").jqxGrid('exportdata', 'xls', 'vehiclelist');
	});
  	document.getElementById("recievediv").style.display="none";
  	document.getElementById("refunddiv").style.display="none";
  	document.getElementById("curramtdiv").style.display="none";
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 99999; display: none;"></div>');
	$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 99999;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	$("#uptodate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy"});
	$("#agmtfromdate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	$("#agmttodate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	$('#clientsearchwindow').jqxWindow({ width: '65%', height: '66%',  maxHeight: '66%' ,maxWidth: '65%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#clientsearchwindow').jqxWindow('close');
	$('#agmtnowindow').jqxWindow({ width: '65%', height: '66%',  maxHeight: '66%' ,maxWidth: '65%' , title: 'Agreement Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#agmtnowindow').jqxWindow('close');
	$('#categorywindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Client Category Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#categorywindow').jqxWindow('close');
	funChkRecieve();
	funChkRefund();
	funChkCurrAmt();

});

function clientSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#clientsearchwindow').jqxWindow('setContent', data);

}); 
}
function agmtSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#agmtnowindow').jqxWindow('setContent', data);

}); 
}
function categorySearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#categorywindow').jqxWindow('setContent', data);

}); 
}

function getClient(){
 	  $('#clientsearchwindow').jqxWindow('open');
		$('#clientsearchwindow').jqxWindow('focus');
		 clientSearchContent('masterClientSearch.jsp', $('#clientsearchwindow'));
}
function getAgmtno(){
	var branch=document.getElementById("cmbbranch").value;
	var agmtstatus=document.getElementById("cmbagmtstatus").value;
	var agmttype=document.getElementById("cmbagmttype").value;
	var agmtfromdate=$('#agmtfromdate').jqxDateTimeInput('val');
	var agmttodate=$('#agmttodate').jqxDateTimeInput('val');
	if(document.getElementById("cmbagmttype").value==""){
		$.messager.alert('warning','Agreement Type is Mandatory');
		return false;
	}
	else{
		$('#agmtnowindow').jqxWindow('open');
		$('#agmtnowindow').jqxWindow('focus');
		agmtSearchContent('masterAgmtSearch.jsp?branch='+branch+'&agmtstatus='+agmtstatus+'&agmttype='+agmttype+'&agmtfromdate='+agmtfromdate+'&agmttodate='+agmttodate, $('#agmtnowindow'));		
	}

}
function getCategory(){
	$('#categorywindow').jqxWindow('open');
	$('#categorywindow').jqxWindow('focus');
	 categorySearchContent('clientCatSearch.jsp?id=1', $('#categorywindow'));
}

function funreload(event)
{
	var branch=document.getElementById("cmbbranch").value;
	var uptodate=$('#uptodate').jqxDateTimeInput('val');
	var agmttype=document.getElementById("cmbagmttype").value;
	var agmtstatus=document.getElementById("cmbagmtstatus").value;
	var agmtno=document.getElementById("hidagmtno").value;
	var clientcat=document.getElementById("hidclientcat").value;
	var client=document.getElementById("hidclient").value;
	var agmtfromdate=$('#agmtfromdate').jqxDateTimeInput('val');
	var agmttodate=$('#agmttodate').jqxDateTimeInput('val');
	var chkrecieve=0,chkrefund=0,chkcurramt=0;
	if(document.getElementById("chkrecievable").checked==true){
		chkrecieve=1;
	}
	else{
		chkrecieve=0;
	}
	if(document.getElementById("chkrefund").checked==true){
		chkrefund=1;
	}
	else{
		chkrefund=0;
	}
   if(document.getElementById("chkcurramt").checked==true){
	   chkcurramt=1;
   }
   else{
	   chkcurramt=0;
   }
   var rcvfromamt=document.getElementById("rcvfromamt").value;
   var rcvtoamt=document.getElementById("rcvtoamt").value;
   var refundfromamt=document.getElementById("refundfromamt").value;
   var refundtoamt=document.getElementById("refundtoamt").value;
   var currfromamt=document.getElementById("currfromamt").value;
   var currtoamt=document.getElementById("currtoamt").value;
    $("#overlay, #PleaseWait").show(); 
   	$("#balancediv").load('rawiseBalanceGrid.jsp?branch='+branch+'&uptodate='+uptodate+'&agmttype='+agmttype+'&agmtstatus='+agmtstatus+'&agmtno='+agmtno+'&clientcat='+clientcat+'&client='+client+'&agmtfromdate='+agmtfromdate+'&agmttodate='+agmttodate+'&chkrecieve='+chkrecieve+'&chkrefund='+chkrefund+'&chkcurramt='+chkcurramt+'&rcvfromamt='+rcvfromamt+'&rcvtoamt='+rcvtoamt+'&refundfromamt='+refundfromamt+'&refundtoamt='+refundtoamt+'&currfromamt='+currfromamt+'&currtoamt='+currtoamt+'&id=1');
   	
}
	
	

	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
	
	}
	function funExportBtn(){

	}
	
		
	
	function funClearData(){
		$('input[type=text],[type=hidden]').val('');
		$('select').find('option').prop("selected", false);
/* 		$('#fromdate').jqxDateTimeInput('setDate',new Date());
		$('#todate').jqxDateTimeInput('setDate',new Date());
		var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);  */
	
	}

	
	function funChkRecieve(){
		if(document.getElementById("chkrecievable").checked==true){
			document.getElementById("recievediv").style.display="block";
			$('#div1').hide();
		}
		else{
			document.getElementById("recievediv").style.display="none";
			$('#div1').show();
		}
	}
	function funChkRefund(){
		if(document.getElementById("chkrefund").checked==true){
			document.getElementById("refunddiv").style.display="block";
			$('#div2').hide();
		}
		else{
			document.getElementById("refunddiv").style.display="none";
			$('#div2').show();
		}
	}
	function funChkCurrAmt(){
		if(document.getElementById("chkcurramt").checked==true){
			document.getElementById("curramtdiv").style.display="block";
			$('#div3').hide();
	    	$('#rawiseBalanceGrid').jqxGrid('showcolumn', 'curramt');
		}
		else{
			document.getElementById("curramtdiv").style.display="none";
			$('#div3').show();
	    	$('#rawiseBalanceGrid').jqxGrid('hidecolumn', 'curramt');
		}
	}
	
	
	function setSearch(){
		var searchby=document.getElementById("cmbsearchby").value;
		if(searchby=="category"){
			getCategory();
		}
		else if(searchby=="client"){
			getClient();
		}
		else if(searchby=="agmt"){
			getAgmtno();
		}
		else{
			
		}
	}
	
	</script>
	
</head>
<body onload="setValues();getBranch();">
<form id="frmRawiseBalance" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="23%" align="center">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>
 <tr>
   <td width="28%" align="right"><label class="branch">Upto</label></td><td width="72%"><div id="uptodate"></div></td></tr>
 <tr>
   <td align="right"><label class="branch">Agmt Type</label></td>
   <td><select name="cmbagmttype" id="cmbagmttype" style="width:56%;">
   <option value="">--Select--</option>
   <option value="RAG">Rental</option>
   <option value="LAG">Lease</option>
   </select></td>
 </tr>
 <tr>
   <td align="right"><label class="branch">Agmt Status</label></td>
   <td><select name="cmbagmtstatus" id="cmbagmtstatus" style="width:56%;">
   <option value="">--Select--</option>
   <option value="0">Open</option>
   <option value="1">Closed</option>
   </select></td>
 </tr>
 <tr>
   <td align="right"><span class="branch">Search By</span></td>
   <td><select name="cmbsearchby" id="cmbsearchby" style="width:56%;">
   		<option value="">--Select--</option>
   		<option value="category">Category</option>
   		<option value="client">Client</option>
   		<option value="agmt">Agreement</option></select>
        
        <button type="button" name="btnsearchadd" id="btnsearchadd" class="myButtons" onclick="setSearch();">+</button>
        &nbsp;
        <button type="button" name="btnsearchremove" id="btnsearchremove" class="myButtons" onclick="removeSearch();">-</button>
   </td>
 </tr>
 

 <tr>
   <td align="right"><label class="branch">Agmt From</label></td>
   <td><div id="agmtfromdate"></div></td>
 </tr>
 <tr>
   <td align="right"><label class="branch">Agmt To</label></td>
   <td><div id="agmttodate"></div></td>
 </tr> 
   <tr>
   <td  colspan="2">
   <div style="width:28%;text-align:right;display:inline-block;"><input type="checkbox" id="chkrecievable" name="chkrecievable" onchange="funChkRecieve();">
   </div>
   <div style="display:inline-block;"><label class="branch" for="chkrecievable">Recievable</label></div>
   <div id="recievediv">
   <table width="100%">
   		<tr>
   			<td width="27%" align="right" ><label class="branch">From</label></td>
   			<td width="73%"><input type="text" name="rcvfromamt" id="rcvfromamt"></td>
   		</tr>
   		<tr>
   			<td align="right" ><label class="branch">To</label></td>
   			<td><input type="text" name="rcvtoamt" id="rcvtoamt"></td>
   		</tr>
   </table>
   </div></td>
 </tr>
   <tr>
   <td  colspan="2">
   <div style="width:28%;text-align:right;display:inline-block;"><input type="checkbox" id="chkrefund" name="chkrefund" onchange="funChkRefund();">
   </div>
   <div style="display:inline-block;"><label class="branch" for="chkrefund">Refunded</label></div>
   <div id="refunddiv">
   <table width="100%">
   		 <tr>
   			<td width="26%" align="right"><label class="branch">From</label></td>
   			<td width="74%"><input type="text" name="refundfromamt" id="refundfromamt"></td>
 		</tr>
 		<tr>
  			<td align="right"><label class="branch">To</label></td>
   			<td><input type="text" name="refundtoamt" id="refundtoamt"></td>
 		</tr>
   </table>
   </div></td>
 </tr>
 <tr>
   <td  colspan="2">
   <div style="width:28%;text-align:right;display:inline-block;"><input type="checkbox" id="chkcurramt" name="chkcurramt" onchange="funChkCurrAmt();">
   </div>
   <div style="display:inline-block;"><label class="branch" for="chkcurramt">Current Amount</label></div>
   <div id="curramtdiv">
   <table width="100%">
   		 <tr>
   			<td width="26%" align="right"><label class="branch">From</label></td>
   			<td width="74%"><input type="text" name="currfromamt" id="currfromamt"></td>
 		</tr>
 		<tr>
   			<td width="26%" align="right"><label class="branch">To</label></td>
   			<td width="74%"><input type="text" name="currtoamt" id="currtoamt"></td>
 		</tr>
   </table>
   </div></td>
 </tr>
<tr ><td colspan="2"><textarea id="searchdetails" name="searchdetails" readonly style="resize:none;" rows="10" cols="35"></textarea> 
	<div id="div1"></div>
	<div id="div2"></div>
	<div id="div3"></div>
</td></tr>
<tr >
	<td colspan="2" style="border-top:2px solid #DCDDDE;">
	<div style="text-align:center;">
	<input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();">
	</div>
    </td>
	</tr>
	</table>
	</fieldset>
</td>
<td width="77%">
	<table width="100%">
		<tr>
			 <td><div id="balancediv"><jsp:include page="rawiseBalanceGrid.jsp"></jsp:include></div></td>
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  <input type="hidden" name="clientcat" id="clientcat" value='<s:property value="clientcat"/>'>
			  <input type="hidden" name="hidclientcat" id="hidclientcat" value='<s:property value="hidclientcat"/>'>
			<input type="hidden" name="client" id="client" value='<s:property value="client"/>'>
			  <input type="hidden" name="hidclient" id="hidclient" value='<s:property value="hidclient"/>'>
			<input type="hidden" name="agmtno" id="agmtno" value='<s:property value="agmtno"/>'>
			  <input type="hidden" name="hidagmtno" id="hidagmtno" value='<s:property value="hidagmtno"/>'>
		</tr>
	</table>
</tr>
</table>
</div>
<div id="clientsearchwindow">
<div></div>
</div>
<div id="categorywindow">
<div></div>
</div>
<div id="agmtnowindow">
<div></div>
</div>
</div>
</form>
</body>
</html>