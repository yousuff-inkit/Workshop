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
		/* document.getElementById("branchlabel").style.display="none";
		document.getElementById("branchdiv").style.display="none"; */
   	$("#btnExcel").click(function() {
		/* JSONToCSVCon(repexceldata, 'Replacement List', true); */
		$("#inspListGrid").jqxGrid('exportdata', 'xls', 'sold Vehicles List');
	});
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	 $('#docwindow').jqxWindow({ width: '70%', height: '60%',  maxHeight: '70%' ,maxWidth: '60%' , title: 'Document Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
 	 $('#docwindow').jqxWindow('close');
 	$('#clientwindow').jqxWindow({ width: '70%', height: '60%',  maxHeight: '70%' ,maxWidth: '60%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	 $('#clientwindow').jqxWindow('close');
	$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	$('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	
	
	$('#refvocno').dblclick(function(){
  	  	var reftype=document.getElementById("cmbreftype").value;
 		if(document.getElementById("cmbreftype").value==''){
			 $.messager.alert('warning','Ref Doc Type is Mandatory');
			 return false;
		 }
 		if(document.getElementById("cmbreftype").value=="RAG" || document.getElementById("cmbreftype").value=="LAG"){
 			if(document.getElementById("cmbagmtbranch").value==""){
 				$.messager.alert('warning','Agreement Branch is Mandatory');
 				return false;
 			}
 		}
		    $('#docwindow').jqxWindow('open');
			 docSearchContent('detailDocSearch.jsp?reftype='+reftype+'&branch='+$('#cmbagmtbranch').val(), $('#docwindow'));
		});

	$('#client').dblclick(function(){
  	  	
		$('#clientwindow').jqxWindow('open');
		clientSearchContent('clientMasterSearch.jsp');
		});

	
	getAgmtBranch();
});

function docSearchContent(url) {
	$.get(url).done(function (data) {
  $('#docwindow').jqxWindow('setContent', data);
}); 
}
function clientSearchContent(url) {
	$.get(url).done(function (data) {
  $('#clientwindow').jqxWindow('setContent', data);
}); 
}
function funreload(event)
{
	var branch=document.getElementById("cmbbranch").value;
	//var fleet=document.getElementById("fleetno").value;
	var client=document.getElementById("hidclient").value;
	var fromdate=$('#fromdate').jqxDateTimeInput('val');
	var reftype=$('#cmbreftype').val();
	var agmtbranch=$('#cmbagmtbranch').val();
	var refdocno=$('#refdocno').val();
	var type=$('#cmbtype').val();
	var invoicetype=$('#cmbinvtype').val();
	var todate=$('#todate').jqxDateTimeInput('val');
    $("#overlay, #PleaseWait").show();
   	$("#inspdiv").load("inspListGrid.jsp?branch="+branch+"&client="+client+"&fromdate="+fromdate+"&todate="+todate+"&reftype="+reftype+"&agmtbranch="+agmtbranch+"&refdocno="+refdocno+"&type="+type+"&invoicetype="+invoicetype+"&id=1");
   	
}
	
function getAgmtBranch(){
	   var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('***');
				var locItems = items[0].split(",");
				var locIdItems = items[1].split(",");
				var optionsloc = '<option value="">--Select--</option>';
				for (var i = 0; i < locItems.length; i++) {
					optionsloc += '<option value="' + locIdItems[i] + '">'
							+ locItems[i] + '</option>';
				}
				$("select#cmbagmtbranch").html(optionsloc);
				
			} else {
			}
		}
		x.open("GET", "getBranch.jsp", true);
		x.send();
}

	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
	
	}
	function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
		     JSONToCSVCon(insplistdata, 'Inspection List', true);
		   } else {
		    //$("#jqxRefund").jqxGrid('exportdata', 'xls', 'SecurityRefund');
		   }
	}
	
		
	
	function funClearData(){
		$('input[type=text],[type=hidden]').val('');
		$('#fromdate').jqxDateTimeInput('setDate',new Date());
		$('#todate').jqxDateTimeInput('setDate',new Date());
		var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
	
	}
	function getDoc(event){
   		var reftype=document.getElementById("cmbreftype").value;
 		if(document.getElementById("cmbreftype").value==''){
			 $.messager.alert('warning','Ref Doc Type is Mandatory');
			 return false;
		 }
		if(document.getElementById("cmbreftype").value=="RAG" || document.getElementById("cmbreftype").value=="LAG"){
			if(document.getElementById("cmbagmtbranch").value==""){
				$.messager.alert('warning','Agreement Branch is Mandatory');
				return false;
			}
		}
    	var x= event.keyCode;
          if(x==114){
       	  		$('#docwindow').jqxWindow('open');
       	   		docSearchContent('detailDocSearch.jsp?reftype='+reftype+'&branch='+$('#cmbagmtbranch').val(), $('#docwindow'));
          }
          else{
           
          }
     }
	function getDoc(event){
    	var x= event.keyCode;
          if(x==114){
       	  		$('#clientwindow').jqxWindow('open');
       	   		clientSearchContent('clientMasterSearch.jsp');
          }
          else{
           
          }
     }
	</script>
	
</head>
<body onload="setValues();getBranch();">
<form id="frmSoldList" method="post">
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
   <td align="right"><label class="branch">Ref Type</label></td>
   <td><select name="cmbreftype" id="cmbreftype" style="width:125px;">
   			<option value="">--Select--</option>
   			<option value="RAG">Rental</option>
   			<option value="LAG">Lease</option>
   			<option value="RPL">Replacement</option>
   			<option value="NRM">Non Revenue Movement</option>
   	   </select>
   	</td>
 </tr>
 <tr>
   <td align="right"><label class="branch">Agmt Branch</label></td>
   <td><select name="cmbagmtbranch" id="cmbagmtbranch" style="width:125px;"><option value="">--Select--</option></select>
   	</td>
 </tr>
 <tr>
   <td align="right"><label class="branch">Ref Doc</label></td>
   <td><input type="text" name="refvocno" id="refvocno" placeholder="Press F3 to Search" readonly style="height:18px;" onKeyDown="getDoc(event);">
   	</td>
 <input type="hidden" name="refdocno" id="refdocno" placeholder="Press F3 to Search" readonly style="height:18px;">  	
 </tr>
 
 <tr>
   <td align="right"><label class="branch">Client</label></td>
   <td><input type="text" name="client" id="client" placeholder="Press F3 to Search" readonly style="height:18px;"></td>
   <input type="hidden" name="hidclient" id="hidclient">
 </tr>
 <tr>
   <td align="right"><label class="branch">Type</label></td>
   <td><select name="cmbtype" id="cmbtype" style="width:125px;">
   			<option value="">--Select--</option>
   			<option value="DMG">Damage</option>
   			<option value="ACC">Accident</option>
   		</select>
   	</td>
 </tr>
 <tr>
   <td align="right"><label class="branch">Invoice Type</label></td>
   <td><select name="cmbinvtype" id="cmbinvtype" style="width:125px;">
   			<option value="">--Select--</option>
   			<option value="1">Invoiced</option>
   			<option value="0">Not Invoiced</option>
   		</select>
   	</td>
 </tr>
 <tr >
	<td colspan="2" style="border-top:2px solid #DCDDDE;">
	<div style="text-align:center;">
	<input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();">
	</div>
    </td>
	</tr>
<tr ><td colspan="2"><!-- <textarea id="agmtdetails" name="agmtdetails" readonly style="resize:none;" rows="10" cols="35"></textarea> -->
	<br><br><br><br><br><br><br><br><br>

</td></tr>

<tr colspan="2"><td>&nbsp;</td></tr>
	
		
	</table>
	</fieldset>
</td>
<td width="77%">
	<table width="100%">
		<tr>
			 <td><div id="inspdiv"><jsp:include page="inspListGrid.jsp"></jsp:include></div></td>
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
		
		</tr>
	</table>
</tr>
</table>
</div>
<div id="clientwindow">
<div></div>
</div>
<div id="docwindow">
   <div ></div>
</div>
</div>
</form>
</body>
</html>