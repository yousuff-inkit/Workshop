<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%@page import="com.dashboard.operations.vehicleinsurposting.*"%>
<%ClsVehicleInsurPostingDAO postdao=new ClsVehicleInsurPostingDAO();%>
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
input[type=text]{
	height:18px;
}
</style>
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<script type="text/javascript">
$(document).ready(function () {
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	$("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$('#expensewindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Expense Account Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#expensewindow').jqxWindow('close');
	$('#expenseaccount,#btnpost').attr('disabled',true);
	$('#expenseaccount').dblclick(function(){
		$('#expensewindow').jqxWindow('open');
		$('#expensewindow').jqxWindow('focus');
		SearchContent('expenseAcnoSearchGrid.jsp?id=1','expensewindow');
	});
	getLastDay();

	
	$('#uptodate').on('change', function (event) 
			{  
			$('#expenseacno,#expenseaccount').val('');
			$('#postingCountGrid,#detailsGrid,#postingCalcGrid').jqxGrid('clear');
			    var jsDate = event.args.date; 
			    var type = event.args.type; // keyboard, mouse or null depending on how the date was selected.
			 	var date=$('#uptodate').jqxDateTimeInput('val');
				var x = new XMLHttpRequest();
				x.onreadystatechange = function() {
					if (x.readyState == 4 && x.status == 200) {
						var items = x.responseText.trim();
						if(items=="0"){
							$.messager.alert('message','Date should be month end');
							return false;
						}
						else{
							return true;
						}
					} else {

					}
				}
				x.open("GET","checkMonthEnd.jsp?date="+date, true);
				x.send();

			}); 
	
	$('#branchlabel,#branchdiv').hide();
});

function getLastDay(){
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();
			$('#uptodate').jqxDateTimeInput('val',items);
			
		} else {

		}
	}
	x.open("GET","getLastDay.jsp?date="+$('#uptodate').jqxDateTimeInput('val'), true);
	x.send();
}
function getExpenseAccount(event){
	var x= event.keyCode;
    if(x==114){
		$('#expensewindow').jqxWindow('open');
		$('#expensewindow').jqxWindow('focus');
		SearchContent('expenseAcnoSearchGrid.jsp?id=1','expensewindow');
    }
    else{
    	
    }
}
function SearchContent(url,windowid) {
	$.get(url).done(function (data) {
		$('#'+windowid).jqxWindow('setContent', data);
	}); 
}

function funreload(event)
{
	/* funClearData();
	$('#vehicleInsurGrid').jqxGrid('clear');
	$('#insurHistoryGrid').jqxGrid('clear');
    $('#vehicleInsurGrid').jqxGrid({height:500}); */
    var date=$('#uptodate').jqxDateTimeInput('val');
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();
			if(items=="0"){
				$.messager.alert('message','Date should be month end');
				return false;
			}
			else{
				$("#overlay, #PleaseWait").show();
			    var uptodate=$('#uptodate').jqxDateTimeInput('val');
			    var branch=$('#cmbbranch').val();
			    $('#postingcountdiv').load('postingCountGrid.jsp?uptodate='+uptodate+'&id=1&branch='+branch);		
			}
		} else {

		}
	}
	x.open("GET","checkMonthEnd.jsp?date="+date, true);
	x.send();

		
    /* $('#invoicediv').load('invoiceGrid.jsp?uptodate='+uptodate+'&id=1&branch='+branch); */
/*    	$("#replacediv").load("replaceGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&repstatus="+repstatus+"&repreason="+repreason+"&reptype="+reptype+"&agmttype="+agmttype+"&agmtbranch="+agmtbranch+"&agmtno="+agmtno+"&rentaltype="+rentaltype+"&agmtstatus="+agmtstatus+"&id=1");
 */   	
}
	
	

	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
	getBranch();
	}
	
	function funExportBtn(){
	/* 	JSONToCSVCon(repexceldata, 'Replacement List', true); */
		if(parseInt(window.parent.chkexportdata.value)=="1")
		{
			JSONToCSVCon(detailexceldata, 'Vehicle Insurance Posting', true);
		}
		else
		{
			$("#detailsGrid").jqxGrid('exportdata', 'xls', 'Vehicle Insurance Posting');
		}	
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
	 
	function funCalculate(){
		if($('#expenseacno').val()==''){
			$.messager.alert('warning','Expense Account is Mandatory');
			return false;
		}
		
		var selectedrows=$('#detailsGrid').jqxGrid('selectedrowindexes');
		if(selectedrows.length==0){
			$.messager.alert('warning','Please select documents');
			return false;
		}
		var insurarray=new Array();
		for(var i=0;i<selectedrows.length;i++){
			insurarray.push($('#detailsGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no')+"::"+$('#detailsGrid').jqxGrid('getcellvalue',selectedrows[i],'insurdocno'));
		}
		$("#overlay, #PleaseWait").show();
	    var expenseacno=$('#expenseacno').val();
	    var uptodate=$('#uptodate').jqxDateTimeInput('val');
	    var branch=$('#cmbbranch').val();
	    $('#calcdiv').load('postingCalcGrid.jsp?expenseacno='+expenseacno+'&insurarray='+insurarray+'&uptodate='+uptodate+'&branch='+branch+'&id=1&desc='+$('#desc').val().replace(/ /g, "%20"));
	    
		
	}
	function funPost(){
		if($('#expenseacno').val()==''){
			$.messager.alert('warning','Expense Account is Mandatory');
			return false;
		}
		if($('#uptodate').jqxDateTimeInput('getDate')==null){
			$.messager.alert('warning','Upto date is Mandatory');
			return false;
		}
		var rows=$('#postingCalcGrid').jqxGrid('getrows');
		if(rows.length==0){
			$.messager.alert('warning','Please Calculate');
			return false;
		}
		var selectedrows=$('#detailsGrid').jqxGrid('selectedrowindexes');
		
		if(selectedrows.length==0){
			$.messager.alert('Warning','Select a document');
			return false;
		}
		$.messager.confirm('Confirm', 'Do you want to Post Insurance?', function(r){
 			if (r){
 				$('#invgridlength').val(selectedrows.length);	
 				for(var i=0,z=0;i<selectedrows.length;i++,z++){
 					newTextBox = $(document.createElement("input"))
				    .attr("type", "dil")
				    .attr("id", "testinsurance"+z)
				    .attr("name", "testinsurance"+z)
				    .attr("hidden","true");
					
				newTextBox.val($('#detailsGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no')+"::"+$('#detailsGrid').jqxGrid('getcellvalue',selectedrows[i],'insurdocno'));
				
				newTextBox.appendTo('form');
 				}
 				document.getElementById("mode").value="A";
 				$("#overlay, #PleaseWait").show();
 				document.getElementById("frmVehicleInsurancePosting").submit();
 				
 			}
		});
		
	} 
	
	function funClearData(){
		$('#uptodate').jqxDateTimeInput('setDate',new Date());
		getLastDay();
		$('#expenseacno,#expenseaccount').val('');
		$('#postingCountGrid,#detailsGrid,#postingCalcGrid').jqxGrid('clear');
	}
	function postAJAX(){
		/* var agmtno=$('#hidagmtno').val();
		var vendor=$('#hidvendor').val();
		var invno=$('#invno').val();
		var invamount=$('#invamount').val();
		var invdate=$('#invdate').jqxDateTimeInput('val');
		var insurfromdate=$('#insurfromdate').jqxDateTimeInput('val');
		var insurtodate=$('#insurtodate').jqxDateTimeInput('val');
		var vendoracno=$('#vendoracno').val();
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
				if(items=="0"){
					$.messager.alert('message','Successfully Saved');
					$('#invoiceGrid').jqxGrid('clear');
					$('#vehicleInsurGrid').jqxGrid('clear');
				}
				else{
					$.messager.alert('message','Not Saved');
				}
			} else {

			}
		}
		x.open("GET","postAJAX.jsp?agmtno="+agmtno+"&vendor="+vendor+"&invno="+invno+"&invamount="+invamount+"&invdate="+invdate+"&insurfromdate="+insurfromdate+"&insurtodate="+insurtodate+"&vendoracno="+vendoracno, true);
		x.send(); */
	}
	</script>
	
</head>
<body onload="setValues();">
<form id="frmVehicleInsurancePosting" method="post" action="saveVehicleInsurancePosting">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%" align="center">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

 <tr>
   <td width="37%" align="right"><label class="branch">Upto Date</label></td><td width="63%"><div id="uptodate" name="uptodate"></div></td></tr>
 <tr>
 	<td colspan="2" align="center"><div id="postingcountdiv"><jsp:include page="postingCountGrid.jsp"></jsp:include></div></td>
 </tr>
 <tr>
   <td colspan="2">
   <table width="100%" border="0">
  <tr>
    <td width="43%" align="right"><label class="branch">Expense Account</label></td>
    <td width="57%"><input type="text" name="expenseaccount" id="expenseaccount"  style="height:18px;" onkeydown="getExpenseAccount(event);" readonly placeholder="Press F3 to Search"></td>
    
  </tr>
</table>
   </td>
   </tr>
 <tr>
   <td colspan="2" >&nbsp;</td>
 </tr>
 <tr >
	<td colspan="2" style="border-top:2px solid #DCDDDE;">
	<div style="text-align:center;">
	<input type="button" name="btnclear" id="btnclear" value="Clear" class="myButton" onclick="funClearData();">&nbsp;&nbsp;
	<button type="button" name="btnpost" id="btnpost" class="myButton" onclick="funPost();">Post</button>
	</div>
    </td>
	</tr>
<tr ><td colspan="2"><br><br><br><br><br><br><br><br><br><!-- <textarea id="agmtdetails" name="agmtdetails" readonly style="resize:none;" rows="10" cols="35"></textarea> -->
</td></tr>

<tr colspan="2"><td>&nbsp;</td></tr>
	
		
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="detailsdiv"><jsp:include page="detailsGrid.jsp"></jsp:include></div>
			 	<div id="calcdiv"><jsp:include page="postingCalcGrid.jsp"></jsp:include></div>
			 </td>
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  <input type="hidden" name="expenseacno" id="expenseacno" value='<s:property value="expenseacno"/>'>
		<input type="hidden" name="invgridlength" id="invgridlength" value='<s:property value="invgridlength"/>'>
		</tr>
	</table>
</tr>
</table>
</div>
</div>
<div id="expensewindow">
<div></div>
</div>
</form>
</body>
</html>