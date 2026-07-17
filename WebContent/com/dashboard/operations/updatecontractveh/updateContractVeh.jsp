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
	  // setType(null);
	
	   $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");

	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	   var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
       var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
       $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
       $('#clientsearchwindow').jqxWindow({ width: '49%', height: '65%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#clientsearchwindow').jqxWindow('close');
	   $('#agmtnowindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Agreement Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#agmtnowindow').jqxWindow('close');
	   $('#client').dblclick(function(){
			 $('#clientsearchwindow').jqxWindow('open');
				$('#clientsearchwindow').jqxWindow('focus');
				 clientSearchContent('clientINgridsearch.jsp', $('#clientsearchwindow'));
			});
		 $('#hidagmtno').dblclick(function(){
			 if(document.getElementById("agmttype").value==""){
				 $.messager.alert('warning','Please Select Agreement Type');
				 return false;
			 }
			 $('#agmtnowindow').jqxWindow('open');
				$('#agmtnowindow').jqxWindow('focus');
				 agmtSearchContent('agmtSearch.jsp?agmttype='+document.getElementById("agmttype").value+'&branch='+document.getElementById("cmbbranch").value, $('#agmtnowindow'));
			});
		 
		 
		 
});


function getClient(event){
	var x= event.keyCode;
	if(x==114){
		 $('#clientsearchwindow').jqxWindow('open');
			$('#clientsearchwindow').jqxWindow('focus');
			 clientSearchContent('clientINgridsearch.jsp', $('#clientsearchwindow'));	
	}
 	 

}
function getAgmtno(event){
	var x= event.keyCode;
	if(x==114){
		 if(document.getElementById("agmttype").value==""){
			 $.messager.alert('warning','Please Select Agreement Type');
			 return false;
		 }
		 $('#agmtnowindow').jqxWindow('open');
			$('#agmtnowindow').jqxWindow('focus');
			 agmtSearchContent('agmtSearch.jsp?agmttype='+document.getElementById("agmttype").value+'&branch='+document.getElementById("cmbbranch").value, $('#agmtnowindow'));
			 
	}
 	 

}
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

function funreload(event)
{
	if(document.getElementById("cmbbranch").value==""){
		$.messager.alert('Warning','Please Select Branch');
		return false;
	}
	var dateval=funDateInPeriod($('#todate').jqxDateTimeInput('getDate'));
	//alert(dateval);
	if(dateval==1){

     var branch=document.getElementById("cmbbranch").value;
     var fromdate=$('#fromdate').jqxDateTimeInput('val');
     var todate=$('#todate').jqxDateTimeInput('val');
  	var agmttype=document.getElementById("agmttype").value;
  	var agmtno=document.getElementById("agmtno").value;
  	var cldocno=document.getElementById("hidclient").value;
    
    	 $("#overlay, #PleaseWait").show();
    		 $("#contractdiv").load("UpdateContractGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&agmttype="+agmttype+"&agmtno="+agmtno+"&cldocno="+cldocno+"&id=1");	 
    	 
    	  
     

	}
	}
function funExportBtn(){
	//	 $("#updateContractGrid").jqxGrid('exportdata', 'xls', 'Permanent Vehicle Update');
/* if(parseInt(window.parent.chkexportdata.value.trim())=="1") {
			JSONToCSVCon(updatedata, 'Permanent_Vehicle_Update', true);
		}
		else{
		   // $("#jqxRefund").jqxGrid('exportdata', 'xls', 'Permanent Vehicle Update');
		}
		 */
		 
	if(parseInt(window.parent.chkexportdata.value.trim())=="1") {
		JSONToCSVCon(updatedata, 'Permanent_Vehicle_Update', true);
	}
	else{
	   // $("#jqxRefund").jqxGrid('exportdata', 'xls', 'Permanent Vehicle Update');
	}
	
		 
		 
	}

	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
	
	}

	
		
	
	function funClearData(){
		$('input[type=text],[type=hidden]').val('');
		$('#agmttype').val('');
		$('#agmtdetails').val('');
	}
	function funUpdateData(){
		
		if(document.getElementById("agmtdetails").value==""){
			$.messager.alert('Message','Please Select an Agreement');
		return false;
		}
	
		var reg=document.getElementById("hidfleetreg").value;
		var agmtno=document.getElementById("agmtno").value;
		var agmttype=document.getElementById("agmttype").value;
		var fleet=document.getElementById("hidofleet").value;
		 $.messager.confirm('Confirm', 'Do you want to update Vehicle No: '+fleet+' '+reg+' of Agmt No: '+agmttype+' '+agmtno+' as Permanent Vehicle', function(r){ 
		/* $.messager.confirm('Confirm', 'Do you want to update Vehicle No:'+reg+' as Permanent Vehicle', function(r){ */
			if (r){
				
				
				
				$("#overlay, #PleaseWait").show();
				var x = new XMLHttpRequest();
				x.onreadystatechange = function() {
					if (x.readyState == 4 && x.status == 200) {
						var items = x.responseText;
						$("#overlay, #PleaseWait").hide();
						 $.messager.alert('Message',items); 
						 funClearData();
						 funreload(reg);
					} else {
					}
				}
				x.open("GET", "updateContract.jsp?agmtno="+agmtno+"&agmttype="+agmttype+"&fleet="+fleet, true);
				x.send();
			}
			});
		}

	</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmUpdateContract" method="post">
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
   <td align="right"><label class="branch">Agreement Type</label></td>
   <td><select name="agmttype" id="agmttype" style="width:68%;" ><option value="">--Select--</option><option value="RAG">Rental</option><option value="LAG">Lease</option></select></td>
 </tr>
  <tr>
   <td align="right"><label class="branch">Agreement No</label></td>
   <td><input type="text" name="hidagmtno" id="hidagmtno" placeholder="Press F3 to Search" onkeydown="getAgmtno(event);" readonly style="height:17px;"></td>
 </tr>
  <tr>
   <td align="right"><label class="branch">Client</label></td>
   <td><input type="text" name="client" id="client"  placeholder="Press F3 to Search" onkeydown="getClient(event);" readonly style="height:17px;"></td>
 </tr>
 <input type="hidden" name="hidclient" id="hidclient">
<tr ><td colspan="2"><textarea id="agmtdetails" name="agmtdetails" readonly style="resize:none;" rows="15" cols="35"></textarea></td></tr>
<tr >
	<td colspan="2" style="border-top:2px solid #DCDDDE;">
	<center>
	<input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();">&nbsp;&nbsp;
	<input type="button" name="btnupdate" id="btnupdate" value="Update" class="myButtons" onclick="funUpdateData();">
	</center>
    </td>
	</tr>
<tr colspan="2"><td>&nbsp;</td></tr>
	
		
	</table>
	</fieldset>
</td>
<td width="77%">
	<table width="100%">
		<tr>
			 <td> <div id="contractdiv"><jsp:include page="UpdateContractGrid.jsp"></jsp:include></div>
			 <%-- <div id="distributiondiv"  hidden="true"><jsp:include page="salesMonthwiseGrid.jsp"></jsp:include></div> --%>
			 
			 
			 </td>
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  <input type="hidden" name="hidofleet" id="hidofleet">
			  <input type="hidden" name="hidfleetreg" id="hidfleetreg">
				<input type="hidden" name="agmtno" id="agmtno">
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