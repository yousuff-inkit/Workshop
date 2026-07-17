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
.account {
	color: black;
	background-color: #E0ECF8;
	width: 100%;
	height: 28px;
	font-family: Myriad Pro;
	font-weight: bold;
}
.accname {
	color: black;
	background-color: #E0ECF8;
	width: 100%;
	font-family: comic sans ms;
}
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
</style>
<script type="text/javascript">

	$(document).ready(function () {
		 
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $('#vehicleDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Vehicle Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#vehicleDetailsWindow').jqxWindow('close');
		 
		 $('#inspectionWindow').jqxWindow({ autoOpen: false,width: '78%', height: '85%',  maxHeight: '85%' ,maxWidth: '78%' , title: 'Inspection Details' , theme: 'energyblue', position: { x: 280, y: 10 }, keyboardCloseKey: 27, showCloseButton: true,closeButtonAction:'hide'});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		
	     var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	     $('#txtvehicle').dblclick(function(){
			  vehicleSearchContent('vehicleDetailsGrid.jsp');
			});
	});
	
	function vehicleSearchContent(url) {
	    $('#vehicleDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#vehicleDetailsWindow').jqxWindow('setContent', data);
		$('#vehicleDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function inspectionSearchContent(url) {
		 $('#inspectionWindow').jqxWindow('focus'); 
		 $.get(url).done(function (data) {
		 $('#inspectionWindow').jqxWindow('setContent', data);
		}); 
		}
	
	function getVehicle(event){
        var x= event.keyCode;
        if(x==114){
        	vehicleSearchContent('vehicleDetailsGrid.jsp');
        }
        else{
         }
        }
	
	function funreload(event){
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var type = $('#cmbtype').val();
		 var fleetno = $('#txtfleetno').val();
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 
		 if(type==''){
			 $.messager.alert('Message','Please Choose a Review Type.','warning');
			 return 0;
		 }

		 $("#overlay, #PleaseWait").show();
		 
		 if(type==1){
			 $("#serviceHistoryDiv").prop("hidden", true);
	       	 $("#accidentHistoryDiv").prop("hidden", false);
		     $("#accidentHistoryDiv").load("accidentHistoryGrid.jsp?branchval="+branchval+'&type='+type+'&fromdate='+fromdate+'&todate='+todate+'&fleetno='+fleetno+'&id=1');
		 }
		 else{
			 $("#accidentHistoryDiv").prop("hidden", true); 
	       	 $("#serviceHistoryDiv").prop("hidden", false);
		     $("#serviceHistoryDiv").load("serviceHistoryGrid.jsp?branchval="+branchval+'&type='+type+'&fromdate='+fromdate+'&todate='+todate+'&fleetno='+fleetno+'&id=1');
		 }
		}
	
	function funClearInfo(){

  	     $('#cmbbranch').val('a');
  	     $('#fromdate').val(new Date());
  	 	 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		 $('#todate').val(new Date());
		 $("#cmbtype").val('');$("#txtvehicle").val('');$("#txtfleetno").val('');$("#txtvehdocno").val('');
		 
		 $("#accidentHistory").jqxGrid('clear');$("#serviceHistory").jqxGrid('clear');		
		 
		 if (document.getElementById("txtvehicle").value == "") {
		        $('#txtvehicle').attr('placeholder', 'Press F3 to Search'); 
		  }
		}
	
	function funMaintenancePrint(){
		var fleetno = $('#txtfleetno').val();
		 
		if(fleetno==''){
			 $.messager.alert('Message','Please Choose a Fleet.','warning');
			 return 0;
		 }
		
 	    if ($("#txtfleetno").val()!="") {
	        var url=document.URL;
	        var reurl=url.split("maintenanceReview.jsp");
	        
	        $("#txtfleetno").prop("disabled", false);
	        var win= window.open(reurl[0]+"printMaintenanceReview?&fleetno="+document.getElementById("txtfleetno").value+'&branch='+document.getElementById("cmbbranch").value+'&fromdate='+$("#fromdate").val()+'&todate='+$("#todate").val(),"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        win.focus();
	     }
	    else {
			$.messager.alert('Message','Fleet is Mandatory.','warning');
			return;
		}
	   }
	   
	   function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
		 if(temp1=='1'){
		  	JSONToCSVCon(data2, 'AccidentHistory', true);
		 }
		 
		 if(temp1=='2'){
		    JSONToCSVCon(data1, 'ServiceHistory', true);
		 }
			
		 } else {
			 if(temp1=='1'){
	    			$("#accidentHistory").jqxGrid('exportdata', 'xls', 'AccidentHistory');
        	}
			if(temp1=='2'){
	    			$("#serviceHistory").jqxGrid('exportdata', 'xls', 'ServiceHistory');
        	}
		 }
	 }
	
</script>
</head>
<body onload="getBranch();">
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
	<tr><td align="right"><label class="branch">Review</label></td>
	<td align="left"><select id="cmbtype" name="cmbtype" style="width:70%;" value='<s:property value="cmbtype"/>'>
    <option value="">--Select--</option><option value="1">Accident History</option><option value="2">Service History</option></select></td></tr> 
	 <tr>
	 <td align="right"><label class="branch">Vehicle</label></td>
     <td align="left"><input type="text" id="txtvehicle" name="txtvehicle" style="width:80%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtvehicle"/>' ondblclick="funSearchdblclick();" onkeydown="getVehicle(event);"/>
     <input type="hidden" id="txtfleetno" name="txtfleetno" style="width:80%;height:20px;" value='<s:property value="txtfleetno"/>'></td></tr> 
    <tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2" align="center"><textarea id="vehinfo" style="height:195px;width:200px;font: 10px Tahoma;resize:none" name="vehinfo"  readonly="readonly"  ><s:property value="vehinfo" ></s:property></textarea></td></tr> 
	<tr><td colspan="2"><input type="hidden" id="txtvehdocno" name="txtvehdocno" style="width:80%;height:20px;" value='<s:property value="txtvehdocno"/>'/></td></tr>
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();">
	<button class="myButton" type="button" id="btnMaintenancePrint" name="btnMaintenancePrint" onclick="funMaintenancePrint();">Print</button></td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="accidentHistoryDiv"><jsp:include page="accidentHistoryGrid.jsp"></jsp:include></div>
			 <div id="serviceHistoryDiv" hidden="true"><jsp:include page="serviceHistoryGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>

<div id="vehicleDetailsWindow">
	<div></div><div></div>
</div>
<div id="inspectionWindow">
<div></div>
</div>
</div> 
</body>
</html>