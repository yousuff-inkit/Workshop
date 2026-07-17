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
<% String contextPath=request.getContextPath();%>
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
	 var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	 var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	 $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	 $('#clientSearchWindow').jqxWindow({width: '50%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#clientSearchWindow').jqxWindow('close');
	 
	 
	 $("#clientname").dblclick(function(){
			
		 clientSearchContent(<%=contextPath+"/"%>+"com/dashboard/workshop/jobcardcomplete/clientSearch.jsp");

		});
	 
});

function searchClient(){
	var x= event.keyCode;
	if(x==114){
			clientSearchContent(<%=contextPath+"/"%>+"com/dashboard/workshop/jobcardcomplete/clientSearch.jsp");
	
	
	}
}


function clientSearchContent(url) {
 	$('#clientSearchWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#clientSearchWindow').jqxWindow('setContent', data);
	$('#clientSearchWindow').jqxWindow('bringToFront');
}); 
}


function funreload(event)
{
	
    var fromdate=$('#fromdate').jqxDateTimeInput('val');
    var todate=$('#todate').jqxDateTimeInput('val');
    var clientname=$('#clientname').val();

    $("#overlay, #PleaseWait").show();
   	$("#jobcardcompletediv").load("jobcardCompleteGrid.jsp?id=1&fromdate="+fromdate+"&todate="+todate+"&clientname="+clientname.replace(/ /g, "%20"));
   	
}
	
	

	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
	
	}
	
	function funExportBtn(){
		//JSONToCSVCon(repexceldata, 'Replacement List', true);
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
	
// 	function viewEstimation(event){
// 		var docno = $('#docno').val();
		
// 		if(docno==''){
// 			 $.messager.alert('Message','Choose a document','warning');
// 			 return 0;
// 		 }
		
// 		var url=document.URL;
// 		var reurl=url.split("com/");
		
// 		window.parent.formName.value="Estimation";
// 		window.parent.formCode.value="WE";
		
// 		var detName= "Estimation";
// 		var path= "com/workshop/estimation/estimationView.action?mode=view&docno="+docno;
// 		top.addTab( detName,reurl[0]+""+path);
// 	}
	
	function funComplete(){
		var docno=$('#docno').val();
		var brhid=$('#brhid').val();
		
		if(docno==''){
			 $.messager.alert('Message','Choose a document','warning');
			 return 0;
		 }
		
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
// 				alert(items);
				if(items==0){
					
					$.messager.alert('Message','Job Card Completed Succesfully','info');
					funreload(1);
				}
				else if(items==1){
					$.messager.alert('Message','Job Card Completion Failed','warning');
				}
				
				
			}
			else{
				}
			}
		
		x.open("GET", "completeJobcard.jsp?docno="+docno+"&brhid="+brhid, true);
		x.send();
	}
	
	</script>
	
</head>
<body onload="setValues();getBranch();">
<form id="frmWorkConfirmEstimation" method="post">
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
    <td width="37%" align="right"><label class="branch">Client Name</label></td>
    <td width="63%" align="left"><input type="text" name="clientname" id="clientname" placeholder="Press F3 to search" style="height: 20px;" onkeydown="searchClient(event);"></td>
  </tr>
  
  <tr>
  	<td colspan="2" style="border-top:2px solid #DCDDDE;">
  		<div style="text-align:center;">&nbsp;&nbsp;
  		<label class="branch">Doc. No.</label>
  		<input type="text" name = "docno" id = "docno" readonly="readonly">
  		<input type="hidden" name="brhid" id="brhid">
  		</div>
  	</td>
  </tr>
  

<tr >
	<td colspan="2" style="border-top:2px solid #DCDDDE;">
	<div style="text-align:center;">
		<input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();">&nbsp;
<!-- 		<input type="button" name="btnView" id="btnView" value="View" class="myButtons" onclick="viewEstimation(event);"> -->
		<input type="button" name="btnComplete" id="btnComplete" value="Complete" class="myButtons" onclick="funComplete();">
	</div>
    </td>
</tr>
<br/><br/>	

	
	
	
<tr ><td colspan="2"><!-- <textarea id="agmtdetails" name="agmtdetails" readonly style="resize:none;" rows="10" cols="35"></textarea> -->
	<br><br>
<br><br><br><br><br><br><br><br><br>
</td></tr>

<tr colspan="2"><td>&nbsp;</td></tr>
	
		
	</table>
	</fieldset>
	
	 
	
</td>
<td width="77%">
	<table width="100%">
		<tr>
			 <td><div id="jobcardcompletediv"><jsp:include page="jobcardCompleteGrid.jsp"></jsp:include></div></td>
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
		
		</tr>
	</table>
</tr>
</table>
</div>

</div>


<div id="clientSearchWindow">
	<div></div>
</div>
<input type="hidden" name="cldocno" id="cldocno"/>
<input type="hidden" name="brhid" id="brhid">
</form>



</body>
</html>