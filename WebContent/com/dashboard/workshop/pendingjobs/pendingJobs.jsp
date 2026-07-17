
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
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<style>
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

</style>

<script type="text/javascript">

$(document).ready(function () {
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	 /* var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	 var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	 $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); */
	 $('#gipwindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Gate In Pass Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#gipwindow').jqxWindow('close');
	 
	 $('#gipno').dblclick(function(){
		 gateSearchContent("gateInPassSearch.jsp");
	 });
	 
});
function getGIP(event){
	var x= event.keyCode;
    if(x==114){
  	 	gateSearchContent("gateInPassSearch.jsp");
    }
    else{
    }
}

function gateSearchContent(url) {
 	$('#gipwindow').jqxWindow('open');
	$.get(url).done(function (data) {
		$('#gipwindow').jqxWindow('setContent', data);
	}); 
}
function funreload(event)
{
	//var fromdate= $("#fromdate").jqxDateTimeInput('val');
	var todate= $("#todate").jqxDateTimeInput('val'); 
	var gipno=$('#gipno').val();
	var branch=$('#cmbbranch').val();
	$("#overlay, #PleaseWait").show(); 
	$("#pendingdiv").load("pendingJobsGrid.jsp?todate="+todate+"&gipno="+gipno+"&branch="+branch+"&id=1");
}
	

function  funClearData()
{
	$('#frmPendingJobs input,textarea').val('');
	$('#pendingJobsGrid').jqxGrid('clear');
	/* var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	$('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate) */;
	$('#todate').jqxDateTimeInput('setDate', new Date())
   		
}

function funCheckJobCard(){
	if(document.getElementById("hidgipno").value==""){
		$.messager.alert('Warning','Please Select Valid Document','Warning');
		return false;
	}
	else{
		funCreateJobCardAJAX();
	}
}
function funCreateJobCardAJAX(){
	var gipno=$('#hidgipno').val();
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();
			if(items=="0"){
				funCreateJobCard();
			}
			else{
				$.messager.alert('Message','Job Card already exists','warning');
				return false;
			}
			
		}
		else{
			}
		}
	
	x.open("GET", "createJobCardAJAX.jsp?gipno="+gipno, true);
	x.send();
}

function funCreateJobCard(){
	var estdocno=$('#hidestno').val();
	var gatedocno=$('#hidgipno').val();
	window.parent.formName.value="Job Card";
	window.parent.formCode.value="JBC";
	var detName= "Job Card";
	var url=document.URL;
	var reurl=url.split("com/");
	var path= "com/workshop/jobcard_fancy/jobCard.jsp?mode=view&estdocno="+estdocno+"&gatedocno="+gatedocno+"&id=3";
	top.addTab( detName,reurl[0]+""+path);
	funClearData();
}
function funExportBtn(){
	JSONToCSVCon(pendingexceldata, 'Pending Invoices', true);
}
 </script>
</head>
<body onload="getBranch();">
	<div id="mainBG" class="homeContent" data-type="background"> 
		<form id="frmPendingJobs" method="POST">
			<div class='hidden-scrollbar'>
				<table width="100%">
					<tr>
						<td width="20%" >
						    <fieldset style="background: #ECF8E0;">
								<table  width="100%"  >
									<jsp:include page="../../heading.jsp"></jsp:include>
								  	<%-- <tr width="100%">
								  		<td align="right" width="40%" ><label class="branch">From Date</label></td>
								  		<td align="left" width="40%"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div></td>
								  	</tr>  --%> 
								  	<tr width="100%">
								  		<td align="right" width="40%" ><label class="branch">Up To Date</label></td>
								  		<td align="left" width="40%"><div id='todate' name='todate' value='<s:property value="todate"/>'></div></td>
								  	</tr>
								  	<tr width="100%">
								  		<td align="right" width="40%" ><label class="branch">Gate In Pass</label></td>
								  		<td align="left" width="40%"><input type="text" name="gipno" id="gipno" value='<s:property value="gipno"/>' readonly placeholder="Press F3 to Search" onkeydown="getGIP(event);" style="height:18px;"></td>
								  	</tr>
								  	
								  	<tr><td colspan="2"><hr></td></tr>
								  	<tr><td colspan="2" align="center"><button type="button" class="myButtons" id="btnupdate" onclick="funCheckJobCard();">Create Job Card</button>&nbsp;&nbsp;<button type="button" class="myButtons" id="btnclear" onclick="funClearData();">Clear</button></td></tr>
									<tr><td colspan="2">&nbsp;</td></tr>
									<tr><td colspan="2"><br><br><br><br><br><br><br><br><br><br><br><br><br><br></td></tr>
								</table>
							</fieldset>
						</td>
						<td width="80%">
							<table width="100%">
								<tr><td><div id="pendingdiv"><jsp:include page="pendingJobsGrid.jsp"></jsp:include></div></td></tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
			<input type="hidden" name="hidgipno" id="hidgipno">
			<input type="hidden" name="hidestno" id="hidestno">
		<div id="gipwindow">
			<div></div>
		</div>
		</form>
	</div>

</body>
</html>
