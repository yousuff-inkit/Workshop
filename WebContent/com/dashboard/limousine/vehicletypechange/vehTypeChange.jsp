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
<script type="text/javascript">

$(document).ready(function () {
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");    
	 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $('#brandwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '55%' ,maxWidth: '30%' , title: 'Brand Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	 $('#brandwindow').jqxWindow('close');
	 $('#modelwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '55%' ,maxWidth: '30%' , title: 'Model Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	 $('#modelwindow').jqxWindow('close');
	 $('#groupwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '55%' ,maxWidth: '30%' , title: 'Group Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	 $('#groupwindow').jqxWindow('close');
	 $('.filters').css('height', '18px');
	 
	 $( "#brand" ).dblclick(function() {
			SearchContent('brandSearchGrid.jsp?id=1','brandwindow');
		});
	 
	 $( "#model" ).dblclick(function() {
		 if($('#brand').val()==''){
			 $.messager.alert('Warning','Please Choose Brand');
			 return false;
		 }
		 else{
			 SearchContent('modelSearchGrid.jsp?id=1&brandid='+$('#hidbrand').val(),'modelwindow');			 
		 }
		});
	 
	 $( "#group" ).dblclick(function() {
			SearchContent('groupSearchGrid.jsp?id=1','groupwindow');
		});
});
function SearchContent(url,id) {
	id='#'+id;
	$(id).jqxWindow('open');
	$(id).jqxWindow('focus');
	$.get(url).done(function (data) {
		$(id).jqxWindow('setContent', data);
	}); 
}
function getBrand(event){
	var x= event.keyCode;
    if(x==114){
    	SearchContent('brandSearchGrid.jsp?id=1','brandwindow');
      }
}

function getModel(event){
	var x= event.keyCode;
    if(x==114){
    	if($('#brand').val()==''){
			 $.messager.alert('Warning','Please Choose Brand');
			 return false;
		 }
		 else{
			 SearchContent('modelSearchGrid.jsp?id=1&brandid='+$('#hidbrand').val(),'modelwindow');			 
		 }
      }
}

function getGroup(event){
	var x= event.keyCode;
    if(x==114){
    	SearchContent('groupSearchGrid.jsp?id=1','groupwindow');
      }
}
function funreload(event)
{
	var regno=document.getElementById("regno").value;
	var brandid=document.getElementById("hidbrand").value;
	var modelid=document.getElementById("hidmodel").value;
	var groupid=document.getElementById("hidgroup").value;
	var branch=document.getElementById("cmbbranch").value;
	var uptodate=$('#uptodate').jqxDateTimeInput('val');
	$('#overlay,#PleaseWait').show();
	$('#vehtypechangediv').load('vehTypeChangeGrid.jsp?branch='+branch+'&uptodate='+uptodate+'&regno='+regno+'&brandid='+brandid+'&modelid='+modelid+'&groupid='+groupid+'&id=1');
}
function setValues(){

	 if($('#msg').val()!=""){
		 $.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
		  }
	 
}


function funUpdateData(){
	if(document.getElementById("fleetno").value==""){
		$.messager.alert('warning','Please select a valid fleet');
		return false;
	}
	else{
		if(document.getElementById("cmbstatus").value==""){
			$.messager.alert('warning','Please select a valid status');
			return false;
		}
		else{
			var fleet=document.getElementById("fleetno").value;
			updateVehicle(fleet);			
		}
	}
}

function updateVehicle(value){
	var status=document.getElementById("cmbstatus").value;
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			items = x.responseText;
			if(items.trim()=="1"){
				$.messager.alert('warning','Successfully Updated');
				funClearData();
				funreload(event);
				
			}
			else{
				$.messager.alert('warning','Not Updated');
			}
			
		} else {
		}
	}
	x.open("GET", "updateVehicle.jsp?fleetno="+value+"&updatestatus="+status, true);
	x.send();
}
function funClearData(){
	$('.filters').val('');
	$('#uptodate').jqxDateTimeInput('val',new Date());
}
function funExportBtn(){
	JSONToCSVCon(VehicleTypeChangeexcel, 'Vehicle Type Change', true);
	 }
</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmLimoVehicleUpdate" action="saveLimoVehicleUpdate" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%" rowspan="2">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

 <tr>
 <td width="41%" align="right"><label class="branch">Upto Date</label></td>
 <td colspan="2" ><div id="uptodate" name="uptodate"></div></td>
 </tr>
 <tr>
   <td align="right">&nbsp;</td>
   <td>&nbsp;</td>
 </tr>
 
 <tr>
   <td align="right"><label class="branch">Reg No</label></td>
   <td><input type="text" name="regno" id="regno" placeholder="Please Type In" class="filters"></td>
 </tr>
 <tr>
   <td align="right"><label class="branch">Brand</label></td>
   <td><input type="text" name="brand" id="brand" readonly placeholder="Press F3 to Search" class="filters" onkeydown="getBrand(event);"></td>
   <input type="hidden" name="hidbrand" id="hidbrand" readonly placeholder="Press F3 to Search" class="filters">
 </tr>
 <tr>
   <td align="right"><label class="branch">Model</label></td>
   <td><input type="text" name="model" id="model" readonly placeholder="Press F3 to Search" class="filters"  onkeydown="getModel(event);"></td>
 <input type="hidden" name="hidmodel" id="hidmodel" readonly placeholder="Press F3 to Search" class="filters">
 </tr>
 <tr>
   <td align="right"><label class="branch">Group</label></td>
   <td><input type="text" name="group" id="group" readonly placeholder="Press F3 to Search" class="filters"  onkeydown="getGroup(event);"></td>
   <input type="hidden" name="hidgroup" id="hidgroup" readonly placeholder="Press F3 to Search" class="filters">
 </tr>
 <tr>
   <td align="right">&nbsp;</td>
   <td>&nbsp;</td>
 </tr>
 <tr>
   <td align="right"><label class="branch">Fleet</label></td>
   <td><input type="text" name="fleetno" id="fleetno" readonly class="filters"></td>
 </tr>
 <tr>
   <td align="right"><label class="branch">Limousine Status</label></td>
   <td><select name="cmbstatus" id="cmbstatus" style="width:95%;" class="filters">
   <option value="">--Select--</option>
   <option value="0">Vehicle</option>
   <option value="1">Limousine</option>
   </select>
   </td>
 </tr>
 <tr>
   <td colspan="2" align="center"><button type="button" name="btnclear" id="btnclear" class="myButton" onclick="funClearData();">Clear</button>&nbsp;&nbsp;
   <button type="button" name="btnupdate" id="btnupdate" class="myButton" onclick="funUpdateData();">Update</button></td>
   </tr>
    <tr>
   <td colspan="2" align="center">&nbsp;</td>
   </tr>
   <tr>
   <td colspan="2" align="center"><br><br><br><br><br><br><br></td>
   </tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td rowspan="2"><div id="vehtypechangediv"><jsp:include page="vehTypeChangeGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>
<div id="brandwindow">
   <div ><img id="loadingImage" src="../../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:40%;margin-top:30%;" /></div>
</div>
<div id="modelwindow">
   <div ><img id="loadingImage" src="../../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
</div>
<div id="groupwindow">
   <div ><img id="loadingImage" src="../../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
</div>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
</div>
</form>
</body>
</html>