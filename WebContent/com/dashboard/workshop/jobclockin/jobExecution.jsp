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
		
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	    
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#startdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#closedate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#starttime").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"HH:mm",value:new Date(),showCalendarButton:false});
	 $("#closetime").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"HH:mm",value:new Date(),showCalendarButton:false});
	 var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	 var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	 $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	 
	 $('#technician').dblclick(function(){
		 techSearchContent("technicianSearch.jsp");

		});
	$('#startdate ').jqxDateTimeInput('setMaxDate', new Date()); 
	 
	 $('#technicianToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#technicianToWindow').jqxWindow('close');
	 
	 $('#jobcardvoc').dblclick(function(){
		 jobCardSearchContent("jobCardSearch.jsp?status=2");

		});
	 $('#txtjobcardvoc').dblclick(function(){
		 jobCardSearchContent("jobCardSearch.jsp?status=1");

		});
	 
	 $('#jobCardToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#jobCardToWindow').jqxWindow('close');
	 
	 document.getElementById("strtdjob").checked=true;
	 
});


function funreload(event)
{
	var sjob=0;
    var fromdate=$('#fromdate').jqxDateTimeInput('val');
    var todate=$('#todate').jqxDateTimeInput('val');
	var jcno=document.getElementById("txtjobcard").value;
	if ($('#strtdjob').is(":checked"))
	{
		sjob=1;
	}
    $("#overlay, #PleaseWait").show(); 
   	$("#jobexecutiondiv").load("jobExecutionGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1"+"&jcno="+jcno+"&sjob="+sjob); 
   	
}


function funUpdateClock() {

	var clockDocno=$('#clockDocno').val();
	var jobcard=$('#jobcard').val();
	var techid=$('#techid').val();
	var startdate=$('#startdate').val();
	var starttime=$('#starttime').val();
	
	
	
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var sts = x.responseText;
				if(sts==1){
					$.messager.alert('Message','Not Updated');
				}
				if(sts==0){
					$.messager.alert('Message','Updated Succesfully');
					funreload(event);
					funClearData();
				}
			}
	
			
	}
	x.open("GET", "updateClock.jsp?clockDocno="+clockDocno+"&jobcard="+jobcard+"&techid="+techid+"&startdate="+startdate+"&starttime="+starttime, true);
	x.send();
}


function funCloseClock() {

	var clockDocno=$('#clockDocno').val();
	var closedate=$('#closedate').val();
	var closetime=$('#closetime').val();
	
	
	
	if(clockDocno==""){
		$.messager.alert('Message','Please Select the document');
	}else{
	
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var sts = x.responseText;
				if(sts==1){
					$.messager.alert('Message','Not Updated');
				}
				if(sts==0){
					$.messager.alert('Message','Updated Succesfully');
					funreload(event);
					funClearData();
				}
			}
	}
			
	}
	x.open("GET", "closeClock.jsp?clockDocno="+clockDocno+"&closedate="+closedate+"&closetime="+closetime, true);
	x.send();
}	
	

	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
	
	}
	
	function funExportBtn(){
		//JSONToCSVCon(repexceldata, 'Replacement List', true);
		 }
	
	
	function getTechDetails(event){
	    var x= event.keyCode;
	    if(x==114){
	    	techSearchContent("technicianSearch.jsp");
	    }
	    else{
	     }
	    }
	
	function techSearchContent(url) {
	 	$('#technicianToWindow').jqxWindow('open');
		$.get(url).done(function (data) {
			$('#technicianToWindow').jqxWindow('setContent', data);
		});
	}
	
	function getjobCardDetailsLoad(event){
	    var x= event.keyCode;
	    if(x==114){
	    	jobCardSearchContent("jobCardSearch.jsp?status=1");
	    }
	    else{
	     }
	    }
	function getjobCardDetails(event){
	    var x= event.keyCode;
	    if(x==114){
	    	jobCardSearchContent("jobCardSearch.jsp?status=2");
	    }
	    else{
	     }
	    }
	
	function jobCardSearchContent(url) {
	 	$('#jobCardToWindow').jqxWindow('open');
		$.get(url).done(function (data) {
			$('#jobCardToWindow').jqxWindow('setContent', data);
		});
	}
	
	function funClearData(){
		$('input[type=text],[type=hidden]').val('');
		$('select').find('option').prop("selected", false);
		$('#fromdate').jqxDateTimeInput('setDate',new Date());
		$('#todate').jqxDateTimeInput('setDate',new Date());
		var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	    $('#startdate').jqxDateTimeInput('setDate',new Date());
	    $('#closedate').jqxDateTimeInput('setDate',new Date());
	    $('#starttime').jqxDateTimeInput('setDate',new Date());
	    $('#closetime').jqxDateTimeInput('setDate',new Date());
	
	}
	
	function funExportBtn(){
		//alert("inside Export");
		JSONToCSVConvertor(clockexportdata, 'Job Clock In List', true);
		 }
	
	function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {
		
	    var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
	    
	   // alert("arrData");
	    var CSV = '';    
	    //Set Report title in first row or line
	    
	    CSV += ReportTitle + '\r\n\n';

	    //This condition will generate the Label/Header
	    if (ShowLabel) {
	        var row = "";
	        
	        //This loop will extract the label from 1st index of on array
	        for (var index in arrData[0]) {
	            
	            //Now convert each value to string and comma-seprated
	            row += index + ',';
	        }

	        row = row.slice(0, -1);
	        
	        //append Label row with line break
	        CSV += row + '\r\n';
	    }
	    
	    //1st loop is to extract each row
	    for (var i = 0; i < arrData.length; i++) {
	        var row = "";
	        
	        //2nd loop will extract each column and convert it in string comma-seprated
	        for (var index in arrData[i]) {
	            row += '"' + arrData[i][index] + '",';
	        }

	        row.slice(0, row.length - 1);
	        
	        //add a line break after each row
	        CSV += row + '\r\n';
	    }

	    if (CSV == '') {        
	        alert("Invalid data");
	        return;
	    }   
	    
	    //Generate a file name
	    var fileName = "";
	    //this will remove the blank-spaces from the title and replace it with an underscore
	    fileName += ReportTitle.replace(/ /g,"_");   
	    
	    //Initialize file format you want csv or xls
	    var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
	    
	    // Now the little tricky part.
	    // you can use either>> window.open(uri);
	    // but this will not work in some browsers
	    // or you will not get the correct file extension    
	    
	    //this trick will generate a temp <a /> tag
	    var link = document.createElement("a");    
	    link.href = uri;
	    
	    //set the visibility hidden so it will not effect on your web-layout
	    link.style = "visibility:hidden";
	    link.download = fileName + ".csv";
	    
	    //this part will append the anchor tag and remove it after automatic click
	    document.body.appendChild(link);
	    link.click();
	    document.body.removeChild(link);
	}
	/* setValues(); */
	</script>
	
</head>
<body onload="getBranch();">
<form id="frmWorkJobExecution" method="post">
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
	<td style="width:50%;" align="right"><label class="branch">Job Card</label></td>
	<td  style="width:50%;"><input type="text" name="txtjobcardvoc" id="txtjobcardvoc" readonly placeholder="Press F3 to Search" onkeydown="getjobCardDetailsLoad(event)">
		<input type="hidden" name="txtjobcard" id="txtjobcard">
	</td>
</tr>
<tr>
	<td style="width:50%;" align="right"><label class="branch">Started Job</label></td>
	<td  style="width:50%;"><input type="checkbox" name="strtdjob" id="strtdjob" style="height:18px; margine:1px;"></td>
</tr>
<tr><td colspan="2">
	
			<fieldset><legend>Start Details</legend>
				<table style="width:100%;">
					<tr>
						<td style="width:50%;" align="right"><label class="branch">Job Card</label></td>
						<td  style="width:50%;"><input type="text" name="jobcardvoc" id="jobcardvoc" readonly placeholder="Press F3 to Search" onkeydown="getjobCardDetails(event)">
							<input type="hidden" name="jobcard" id="jobcard">
						</td>
					</tr>
					<tr>
						<td  align="right"><label class="branch">Technician</label></td>
						<td><input type="text" name="technician" id="technician" readonly placeholder="Press F3 to Search" onkeydown="getTechDetails(event)" ></td>
					</tr>
					<tr>
						<td  align="right"><label class="branch">Start Date</label></td>
						<td><div id="startdate" name="startdate"></div></td>
					</tr>
					<tr>
						<td  align="right"><label class="branch">Start Time</label></td>
						<td><div id="starttime" name="starttime"></div></td>
					</tr>
				</table>
				<div style="text-align:center;">
				<input type="button" name="btnupdate" id="btnupdate" value="Create" class="myButtons" onclick="funUpdateClock();">
				</div>
		</fieldset>
			<fieldset><legend>Close Details</legend>
				<table style="width:100%;">
					
					<tr>
						<td  align="right" style="width:50%;"><label class="branch">Close Date</label></td>
						<td style="width:50%;"><div id="closedate" name="closedate"></div></td>
					</tr>
					<tr>
						<td  align="right"><label class="branch">Close Time</label></td>
						<td><div id="closetime" name="closetime"></div></td>
					</tr>
				</table>
				<div style="text-align:center;">
				<input type="button" name="btnclose" id="btnclose" value="Close" class="myButtons" onclick="funCloseClock();">
				</div>
		</fieldset>
</td></tr>
 <tr >
	<td colspan="2" style="border-top:2px solid #DCDDDE;">
	<div style="text-align:center;">
	<input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();"><!-- &nbsp;&nbsp;
	<input type="button" name="btnrepprint" id="btnrepprint" value="Print" class="myButtons" onclick="funPrintData();"> -->
	</div>
    </td>
	</tr>
	
	
<tr ><td colspan="2"><!-- <textarea id="agmtdetails" name="agmtdetails" readonly style="resize:none;" rows="10" cols="35"></textarea> -->
	<br><br><br>
</td></tr>

<tr colspan="2"><td>&nbsp;</td></tr>
	
		
	</table>
	</fieldset>
</td>
<td width="77%">
	<table width="100%">
		<tr>
			 <td><div id="jobexecutiondiv"><jsp:include page="jobExecutionGrid.jsp"></jsp:include></div></td>
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  <input type="hidden" name="techid" id="techid" value='<s:property value="techid"/>'>
			  <input type="hidden" name="clockDocno" id="clockDocno" value='<s:property value="clockDocno"/>'>
		
		</tr>
	</table>
</tr>
</table>
</div>

</div>
</form>
<div id="technicianToWindow">
	<div></div>
	</div>
<div id="jobCardToWindow">
	<div></div>
	</div>	
	
</body>
</html>