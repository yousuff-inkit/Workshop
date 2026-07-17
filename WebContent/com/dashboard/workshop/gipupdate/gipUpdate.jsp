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
		  
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	    $('#clientwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search'  , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
		$('#clientwindow').jqxWindow('close');
	    
	    $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	    $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	    $("#estdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	    $("#esttime").jqxDateTimeInput({ width: '80px', height: '15px',formatString:"HH:mm",showCalendarButton:false,value:new Date()});
	    var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1)); 
	    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	    $('#clientname').dblclick(function(){
	  	    
		   $('#clientwindow').jqxWindow('open');
		       		clientSearchContent('clientsearch.jsp', $('#clientwindow')); 
	       });
});


	function funreload(event)
	{
		var load=$('#txttype').val();
		var clnt=$('#cldocno').val();
	    var fromdate=$('#fromdate').jqxDateTimeInput('val');
	    var todate=$('#todate').jqxDateTimeInput('val');
	    $("#overlay, #PleaseWait").show();
	    $("#gateinpassdiv").load("gipUpdateGrid.jsp?froms="+fromdate+"&tdt="+todate+"&ldtype="+load+"&cldocno="+clnt+"&check=1");
	   	
	}
	
	

	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
	
	}
	
	function funExportBtn(){
		JSONToCSVCon(repexceldata, 'Replacement List', true);
		 }
	
	function getclinfo(event){
		 var x= event.keyCode;
		if(x==114){
	 		$('#clientwindow').jqxWindow('open');
			clientSearchContent('clientsearch.jsp', $('#clientwindow'));    }
		else{}
	} 

	function clientSearchContent(url) {
		 	$.get(url).done(function (data) {
			$('#clientwindow').jqxWindow('open');
			$('#clientwindow').jqxWindow('setContent', data);
	}); 
	} 
		
	
	function funClearData(){
		$('#fromdate,#estdate,#esttime').jqxDateTimeInput('setDate',new Date());
		$('#todate').jqxDateTimeInput('setDate',new Date());
		var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
	 	document.getElementById("txttype").value="";
		document.getElementById("clientname").value="";
		document.getElementById("cldocno").value="";
		$('#jqxFleetGrid').jqxGrid('clear');
		$('#lblgip').text('');
		$('#gipdocno,#gipvocno,#estkm').val('');
	
	}
	
	function funLoadData(){
	
	  	document.getElementById("txttype").value="";
		document.getElementById("clientname").value="";
	}
	
	function funSaveData(){
		if($('#gipdocno').val()==''){
			$.messager.alert('Warning','Please select a valid document');
			return false;
		}
		if($('#estdate').jqxDateTimeInput('getDate')==null){
			$.messager.alert('Warning','Please select a valid date');
			return false;
		}
		if($('#esttime').jqxDateTimeInput('getDate')==null){
			$.messager.alert('Warning','Please select a valid time');
			return false;
		}
		if($('#estkm').val()==''){
			$.messager.alert('Warning','Km is Mandatory');
			return false;
		}
		var gipdocno=$('#gipdocno').val();
		var estdate=$('#estdate').jqxDateTimeInput('val');
		var esttime=$('#esttime').jqxDateTimeInput('val');
		var estkm=$('#estkm').val();
		funUpdateData(gipdocno,estdate,esttime,estkm);
	}
	
	function funUpdateData(gipdocno,estdate,esttime,estkm){
		$("#overlay, #PleaseWait").show(); 
 		var x = new XMLHttpRequest();
 		x.onreadystatechange = function() {
 			if (x.readyState == 4 && x.status == 200) {
 				var items = x.responseText.trim();
 				if(items=="0"){
 					$.messager.alert('Message','Successfully Updated');
 					funClearData();
 					funreload("");
 				}
 				else{	
 					$.messager.alert('Warning','Not Updated');
 				}
 		
 				$("#overlay, #PleaseWait").hide(); 
 			
 			}
 			else {
 			}
 		}
 		x.open("GET", "updateData.jsp?gipdocno="+gipdocno+"&estdate="+estdate+"&esttime="+esttime+"&estkm="+estkm, true);
 		x.send();
  	}
	function isNumber(evt) {
	    evt = (evt) ? evt : window.event;
	    var charCode = (evt.which) ? evt.which : evt.keyCode;
	    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
	        return false;
	    }
	    return true;
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
 <tr><td align="right"><label class="branch">Client</label></td><td align="left"><input type="text" name="clientname" id="clientname" placeholder="Press F3 To Search" readonly="readonly" onKeyDown="getclinfo(event);" onclick="this.placeholder='' "  style="height:20px;width:90%;" value='<s:property value="clientname"/>'></td>
  <td><input type="hidden" name="cldocno" id="cldocno" style="height:20px;width:70%;" value='<s:property value="cldocno"/>' ></td>
 </tr>
<tr>
	
   <td width="37%" align="right"><label class="branch">Type</label></td>            
         <td ><select id="txttype" name="txttype" style="width:75%;height:20px;" value='<s:property value="txttype"/>'>   
      <option value="">--select--</option><option value="open">open</option><option value="close">close</option></select>
  </tr>
  <tr><td colspan="2" align="center"><label id="lblgip" style="color:blue;"></label></td></tr>
 <tr><td colspan="2"><hr></td></tr>
  <tr>
  	<td align="right"><label class="branch">Est.Date</label></td>
  	<td><div id="estdate"></div></td>
  	</tr>
  	<tr>
  	<td align="right"><label class="branch">Est.Time</label></td>
  	<td><div id="esttime"></div></td>
  	</tr>
  	<tr>
  	<td align="right"><label class="branch">Km</label></td>
  	<td><input type="text" name="estkm" id="estkm" onkeypress="return isNumber(event);" style="height:20px;width:90%;"></td>
  	</tr>
  <tr><td colspan="2"><hr></td></tr>
 <tr>
	<td colspan="2">
	<div style="text-align:center;">
	<input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();">&nbsp;&nbsp;
	<input type="button" name="btnsave" id="btnsave" value="Update" class="myButtons" onclick="funSaveData();">
	</div>
    </td>
	</tr>
<tr ><td colspan="2"><!-- <textarea id="agmtdetails" name="agmtdetails" readonly style="resize:none;" rows="10" cols="35"></textarea> -->
	<br><br><br><br><br><br><br><br>
    <br>
    </td></tr>

<tr colspan="2"><td>&nbsp;</td></tr>
	
		
	</table>
	</fieldset>
</td>
<td width="77%">
	<table width="100%">
		<tr>
			 <td><div id="gateinpassdiv"><jsp:include page="gipUpdateGrid.jsp"></jsp:include></div></td>
			 <input type="hidden" name="gipdocno" id="gipdocno" value='<s:property value="gipdocno"/>'>
			 <input type="hidden" name="gipvocno" id="gipvocno" value='<s:property value="gipvocno"/>'>
			 <%--  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			 <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			 <input type="hidden" name="printdocno" id="printdocno" value='<s:property value="printdocno"/>'> --%>
		     
		</tr>
	</table>
</tr>
</table>
</div>
<div id="clientwindow">
   <div></div>
</div>
<div id="agmtnowindow">
<div></div>
</div>
</div>
</form>
</body>
</html>