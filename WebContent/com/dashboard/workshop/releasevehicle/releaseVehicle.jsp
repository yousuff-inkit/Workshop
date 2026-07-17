
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
	 /*$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});*/
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 /*var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	 var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	 $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);*/
	 document.getElementById("rdonotreleased").checked=true;
});

function funreload(event)
{

	
	
/*var fromdate= $("#fromdate").jqxDateTimeInput('val');*/
var todate= $("#todate").jqxDateTimeInput('val'); 
var branch=$('#cmbbranch').val();
var releasestatus=0;
if(document.getElementById("rdonotreleased").checked==true){
	releasestatus=0;
}
else if(document.getElementById("rdoreleased").checked==true){
	releasestatus=1;
}
$("#releasediv").load("releaseVehicleGrid.jsp?todate="+todate+"&id=1&branch="+branch+"&releasestatus="+releasestatus);

}
	

function  funClearData()
{
	$('#frmReleaseVehicle input').val('');
	$('#releaseVehicleGrid').jqxGrid('clear');
	/*$('#fromdate,#todate').jqxDateTimeInput('setDate',new Date());
	var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	$('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);*/
   		
}

function funUpdate(){
	if(document.getElementById("jobcarddocno").value==""){
		$.messager.alert('Warning','Please Select Valid Document','Warning');
		return false;
	}
	else{
		funUpdateAJAX();
	}
}
function funUpdateAJAX(){
	var gatedocno=$('#gatedocno').val();
	var jobcarddocno=$('#jobcarddocno').val();
	var reltype=$('#reltype').val();
	var releasestatus=0;
	if(document.getElementById("rdonotreleased").checked==true){
		releasestatus=0;
	}
	else if(document.getElementById("rdoreleased").checked==true){
		releasestatus=1;
	}
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();
			if(items=="0"){
				$.messager.alert('Message','Vehicle Released Succesfully','info');
				funClearData();
				funreload(1);
			}
			else if(items==1){
				$.messager.alert('Message','Vehicle Release Failed','warning');
			}
			
		}
		else{
			}
		}
	
	x.open("GET", "releaseVeh.jsp?jobcarddocno="+jobcarddocno+"&gatedocno="+gatedocno+"&releasestatus="+releasestatus+"&reltype="+reltype, true);
	x.send();
}
function funExportBtn(){
	var releasetitle="";
	if(document.getElementById("rdonotreleased").checked==true){
		releasetitle="Vehicle To Be Released";
	}
	else if(document.getElementById("rdoreleased").checked==true){
		releasetitle="Released Vehicles";
	}
	JSONToCSVCon(releaseexceldata, releasetitle, true);
}
function funPrint(){
	if($('#jobcarddocno').val()!='' && $('#jobcarddocno').val()!='0'){
		var url=document.URL;
		var reurl=url.split("com");
		/* var path= "com/dashboard/workshop/quotationapproval/printQuotationAproval.action?estDocno="+estdocno; */
		var path= "com/dashboard/workshop/releasevehicle/printReleaseVehicle.action?jobcarddocno="+$('#jobcarddocno').val();
		var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");		
		win.focus();		
	 }
	else {
		$.messager.alert('Message','Please Select a jobcard.','warning');
		return;
	}
}
 </script>
</head>
<body onload="getBranch();">
	<div id="mainBG" class="homeContent" data-type="background"> 
		<form id="frmReleaseVehicle" method="POST">
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
								  	</tr>   --%>
								  	<tr width="100%">
								  		<td align="right" width="40%" ><label class="branch">Upto Date</label></td>
								  		<td align="left" width="40%"><div id='todate' name='todate' value='<s:property value="todate"/>'></div></td>
								  	</tr> 
								  	
								  	
								  	
								  	
								  	<td align="right" width="5%" class="branch">Remarks</td>
                                    <td align="left" width="10%" ><select name="reltype" id="reltype" style="width:50%;"  value='<s:property value="reltype"/>'>
                                    <option value="1" >LPO</option>
                                    <option value="2" >Parts</option>
                                    <option value="3" >Total Loss</option>
                                    </select></td>
								  	
								  	
								  	
								  	
								  	 
								  	<tr><td colspan="2" align="center"><input type="radio" name="rdorelease" id="rdonotreleased"><label for="rdonotreleased" class="branch">To Be Released</label>&nbsp;&nbsp;<input type="radio" name="rdorelease" id="rdoreleased"><label for="rdoreleased" class="branch">Released</label></td></tr>
								  	<tr><td colspan="2"><hr></td></tr>
								  	<tr><td colspan="2" align="center"><button type="button" class="myButtons" id="btnprint" onclick="funPrint();">Print</button>&nbsp;&nbsp;<button type="button" class="myButtons" id="btnupdate" onclick="funUpdate();">Release</button>&nbsp;&nbsp;<button type="button" class="myButtons" id="btnclear" onclick="funClearData();">Clear</button></td></tr>
									<tr><td colspan="2">&nbsp;</td></tr>
									<tr><td colspan="2"><br><br><br><br><br><br><br><br><br><br><br><br><br></td></tr>
									
													
									
									
								</table>
							</fieldset>
						</td>
						
						
						
						
						
		
						
						
						
						<td width="80%">
							<table width="100%">
								<tr><td><div id="releasediv"><jsp:include page="releaseVehicleGrid.jsp"></jsp:include></div></td></tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
			<input type="hidden" name="jobcarddocno" id="jobcarddocno">
			<input type="hidden" name="gatedocno" id="gatedocno">
		</form>
	</div>

</body>
</html>
