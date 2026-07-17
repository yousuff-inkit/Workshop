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
		document.getElementById("branchlabel").style.display="none";
		document.getElementById("branchdiv").style.display="none";
		  /*  $("#btnExcel").click(function() {
				JSONToCSVCon(repexceldata, 'Replacement List', true);
				//$("#vehiclelist").jqxGrid('exportdata', 'xls', 'vehiclelist');
			}); */
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	     $('#agmtnowindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Agreement Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#agmtnowindow').jqxWindow('close');
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	 funGetAgmtBranch();
	 funGetReplaceReason();
	
	 $('#agmtno').dblclick(function(){
		 if(document.getElementById("cmbagmttype").value==""){
			 $.messager.alert('warning','Please Select Agreement Type');
				document.getElementById("cmbagmttype").focus();
			 return false;
		 }
		 if(document.getElementById("cmbagmtbranch").value==""){
			 $.messager.alert('warning','Please Select Agreement Branch');
			 document.getElementById("cmbagmtbranch").focus();
			 return false;
		 }
		 $('#agmtnowindow').jqxWindow('open');
			$('#agmtnowindow').jqxWindow('focus');
			 agmtSearchContent('agmtSearch.jsp?agmttype='+document.getElementById("cmbagmttype").value+'&branch='+document.getElementById("cmbagmtbranch").value, $('#agmtnowindow'));
		}); 

});


function getAgmtno(event){
	var x= event.keyCode;
	if(x==114){
		if(document.getElementById("cmbagmttype").value==""){
			 $.messager.alert('warning','Please Select Agreement Type');
				document.getElementById("cmbagmttype").focus();
			 return false;
		 }
		 if(document.getElementById("cmbagmtbranch").value==""){
			 $.messager.alert('warning','Please Select Agreement Branch');
			 document.getElementById("cmbagmtbranch").focus();
			 return false;
		 }
		 $('#agmtnowindow').jqxWindow('open');
			$('#agmtnowindow').jqxWindow('focus');
			 agmtSearchContent('agmtSearch.jsp?agmttype='+document.getElementById("cmbagmttype").value+'&branch='+document.getElementById("cmbagmtbranch").value, $('#agmtnowindow'));
			 
	}
 	 

}

function agmtSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#agmtnowindow').jqxWindow('setContent', data);

}); 
}



function funGetAgmtBranch(){
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();
			items = items.split('###');
			var branchIdItems  = items[0].split(",");
			var branchItems = items[1].split(",");
			var optionsbranch = '<option value="">--Select--</option>';
			for (var i = 0; i < branchItems.length; i++) {
				optionsbranch += '<option value="' + branchIdItems[i].trim() + '">'
						+ branchItems[i] + '</option>';
			}
			$("select#cmbagmtbranch").html(optionsbranch);

		} else {

		}
	}
	x.open("GET","getAgmtBranch.jsp", true);
	x.send();
}



function funGetReplaceReason(){
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();
			items = items.split('###');
			
			var replaceIdItems  = items[0].split(",");
			var replaceItems = items[1].split(",");
			var optionsbranch = '<option value="">--Select--</option>';
			for (var i = 0; i < replaceItems.length;i++){
				optionsbranch += '<option value="' + replaceIdItems[i].trim() + '">'
						+ replaceItems[i] + '</option>';
			}
			$("select#cmbreplacereason").html(optionsbranch);

		} else {

		}
	}
	x.open("GET","getReplaceReason.jsp", true);
	x.send();
}

function funreload(event)
{
	
	 if(document.getElementById("cmbrentaltype").value!=""){
		if(document.getElementById("cmbagmttype").value==""){
			$.messager.alert('warning','Please Select Agreement Type');
			return false;
		}
	} 
	 if(document.getElementById("cmbagmtstatus").value!=""){
		 if(document.getElementById("cmbagmttype").value==""){
			 $.messager.alert('warning','Please Select Agreement Type');
				return false;
		 }
	 }
	
	
     var fromdate=$('#fromdate').jqxDateTimeInput('val');
     var todate=$('#todate').jqxDateTimeInput('val');
     var repstatus=document.getElementById("cmbreplacestatus").value;
     var repreason=document.getElementById("cmbreplacereason").value;
     var reptype=document.getElementById("cmbreplacetype").value;
     var agmttype=document.getElementById("cmbagmttype").value;
     var agmtbranch=document.getElementById("cmbagmtbranch").value;
     var agmtno=document.getElementById("agmtno").value;
     var rentaltype=document.getElementById("cmbrentaltype").value;
     var agmtstatus=document.getElementById("cmbagmtstatus").value;
    $("#overlay, #PleaseWait").show();
   	$("#replacediv").load("replaceGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&repstatus="+repstatus+"&repreason="+repreason+"&reptype="+reptype+"&agmttype="+agmttype+"&agmtbranch="+agmtbranch+"&agmtno="+agmtno+"&rentaltype="+rentaltype+"&agmtstatus="+agmtstatus+"&id=1");
   	
}
	
	

	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
	
	}
	
	function funExportBtn(){
		JSONToCSVCon(repexceldata, 'Replacement List', true);
		 }
	
		
	
	function funClearData(){
		$('input[type=text],[type=hidden]').val('');
		$('select').find('option').prop("selected", false);
		$('#fromdate').jqxDateTimeInput('setDate',new Date());
		$('#todate').jqxDateTimeInput('setDate',new Date());
		var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
	
	}
	function funPrintData(){
		var rows=$('#replaceGrid').jqxGrid('getrows');
		if(rows.length==0){
			$.messager.alert('warning','Please Select any valid documents');
			return false;
		}
		else{
			var fromdate=$('#fromdate').jqxDateTimeInput('val');
		     var todate=$('#todate').jqxDateTimeInput('val');
		     var repstatus=document.getElementById("cmbreplacestatus").value;
		     var repreason=document.getElementById("cmbreplacereason").value;
		     var reptype=document.getElementById("cmbreplacetype").value;
		     var agmttype=document.getElementById("cmbagmttype").value;
		     var agmtbranch=document.getElementById("cmbagmtbranch").value;
		     var agmtno=document.getElementById("agmtno").value;
		     var rentaltype=document.getElementById("cmbrentaltype").value;
		     var agmtstatus=document.getElementById("cmbagmtstatus").value;
		     
			var url=document.URL;
			var reurl=url.split("replacelist.jsp");
		    var win= window.open(reurl[0]+"repListPrintAction?fromdate="+fromdate+"&todate="+todate+"&repstatus="+repstatus+"&repreason="+repreason+"&reptype="+reptype+"&agmttype="+agmttype+"&agmtbranch="+agmtbranch+"&agmtno="+agmtno+"&rentaltype="+rentaltype+"&agmtstatus="+agmtstatus,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
		    win.focus();
		
		}
	}
	</script>
	
</head>
<body onload="setValues();">
<form id="frmReplaceList" method="post">
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
   <td align="right"><label class="branch">Replace Status</label></td>
   <td><select id="cmbreplacestatus" name="cmbreplacestatus" style="width:76%;"><option value="">--Select--</option><option value="0">Open</option><option value="1">Closed</option></select></td>
 </tr>
 <tr>
   <td align="right"><label class="branch">Replace Reason</label></td>
   <td><select id="cmbreplacereason" name="cmbreplacereason" style="width:76%;"><option value="">--Select--</option></select></td>
 </tr>
 <tr>
   <td align="right"><label class="branch">Replace Type</label></td>
   <td><select id="cmbreplacetype" name="cmbreplacetype" style="width:76%;"><option value="">--Select--</option><option value="">--Select--</option>
   <option value="atbranch">At Branch</option><option value="collection">Collection</option></select></td>
 </tr>
 <tr>
   <td align="right"><label class="branch">Agmt Type</label></td>
   <td><select name="cmbagmttype" id="cmbagmttype" style="width:76%;" ><option value="">--Select--</option><option value="RAG">Rental</option><option value="LAG">Lease</option></select></td>
 </tr>
 <tr>
   <td align="right"><label class="branch">Agmt Branch</label></td>
   <td><select name="cmbagmtbranch" id="cmbagmtbranch" style="width:76%;"><option value="">--Select--</option></select></td>
 </tr>
  <tr>
   <td align="right"><label class="branch">Agmt No</label></td>
   <td><input type="text" name="agmtno" id="agmtno" placeholder="Press F3 to Search" onkeydown="getAgmtno(event);" readonly style="height:17px;"></td>
 </tr>
  <tr>
   <td align="right"><label class="branch">Rental Type</label></td>
   <td><select name="cmbrentaltype" id="cmbrentaltype" style="width:76%;"><option value="">--Select--</option><option value="daily">Daily</option><option value="weekly">Weekly</option><option value="monthly">Monthly</option></select></td>
 </tr>
 <tr>
   <td align="right"><label class="branch">Agmt Status</label></td>
   <td><select name="cmbagmtstatus" id="cmbagmtstatus" style="width:76%;"><option value="">--Select--</option><option value="0">Open</option><option value="1">Close</option></select></td>
 </tr>
 <tr >
	<td colspan="2" style="border-top:2px solid #DCDDDE;">
	<div style="text-align:center;">
	<input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();">&nbsp;&nbsp;
	<input type="button" name="btnrepprint" id="btnrepprint" value="Print" class="myButtons" onclick="funPrintData();">
	</div>
    </td>
	</tr>
<tr ><td colspan="2"><!-- <textarea id="agmtdetails" name="agmtdetails" readonly style="resize:none;" rows="10" cols="35"></textarea> -->
	<br><br><br><br><br><br><br><br>

</td></tr>

<tr colspan="2"><td>&nbsp;</td></tr>
	
		
	</table>
	</fieldset>
</td>
<td width="77%">
	<table width="100%">
		<tr>
			 <td><div id="replacediv"><jsp:include page="replaceGrid.jsp"></jsp:include></div></td>
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  <input type="hidden" name="printdocno" id="printdocno" value='<s:property value="printdocno"/>'>
		
		</tr>
	</table>
</tr>
</table>
</div>
<div id="clientsearchwindow">
<div></div>
</div>
<div id="agmtnowindow">
<div></div>
</div>
</div>
</form>
</body>
</html>