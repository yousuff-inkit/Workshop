<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<jsp:include page="../../../includes.jsp"></jsp:include>
<%-- <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" >
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script> --%>
<script type="text/javascript">
$(document).ready(function() {

$("#date").jqxDateTimeInput({  width:'125px',height : '15px', formatString : "dd.MM.yyyy" });
$("#indate").jqxDateTimeInput({  width:'125px',height : '15px', formatString : "dd.MM.yyyy" });
$("#intime").jqxDateTimeInput({  width:'55px',height : '15px', formatString : "HH:mm",showCalendarButton:false,value:new Date() });
$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;margin-left:50%;margin-right:50%;margin-top:15%;top:200;right:600;'><img src='../../../icons/31load.gif'/></div>");    
$('#intime').jqxDateTimeInput('setDate', new Date());
$('#fleetwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Fleet Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#fleetwindow').jqxWindow('close');
$('#driverwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Driver Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#driverwindow').jqxWindow('close');
$('#clientwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#clientwindow').jqxWindow('close');
$('#complaintwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Complaint Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#complaintwindow').jqxWindow('close');
$( "#fleetno" ).dblclick(function() {
	if(document.getElementById("mode").value=="view"){
		return false;
	}
	$('#fleetwindow').jqxWindow('open');
	$('#fleetwindow').jqxWindow('focus');
	SearchContent('fleetMasterSearch.jsp','fleetwindow');
});

$( "#cldocno" ).dblclick(function() {
	if(document.getElementById("mode").value=="view"){
		return false;
	}
	$('#clientwindow').jqxWindow('open');
	$('#clientwindow').jqxWindow('focus');
	SearchContent('clientMasterSearch.jsp','clientwindow');
});

$( "#driver" ).dblclick(function() {
	if(document.getElementById("mode").value=="view"){
		return false;
	}
	if($('#cldocno').val()==''){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Please Select Client";
		return false;
	}
	$('#driverwindow').jqxWindow('open');
	$('#driverwindow').jqxWindow('focus');
	SearchContent('driverMasterSearch.jsp?agmtexist='+$('#agmtexist').val()+'&cldocno='+$('#cldocno').val()+'&agmtno='+$('#agmtno').val(),'driverwindow');
});

setDriverType();
});


function getFleet(event){
	if(document.getElementById("mode").value=="view"){
		return false;
	}
	var x= event.keyCode;
    if(x==114){
    	$('#fleetwindow').jqxWindow('open');
    	$('#fleetwindow').jqxWindow('focus');
    	SearchContent('fleetMasterSearch.jsp','fleetwindow');
      }
}
function getClient(event){
	if(document.getElementById("mode").value=="view"){
		return false;
	}
	var x= event.keyCode;
    if(x==114){
    	$('#clientwindow').jqxWindow('open');
    	$('#clientwindow').jqxWindow('focus');
    	SearchContent('clientMasterSearch.jsp','clientwindow');
      }
}

function getDriver(event){
	if(document.getElementById("mode").value=="view"){
		return false;
	}
	if($('#cldocno').val()==''){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Please Select Client";
		return false;
	}
	var x= event.keyCode;
    if(x==114){
    	$('#driverwindow').jqxWindow('open');
    	$('#driverwindow').jqxWindow('focus');
    	SearchContent('driverMasterSearch.jsp?agmtexist='+$('#agmtexist').val()+'&cldocno='+$('#cldocno').val()+'&agmtno='+$('#agmtno').val(),'driverwindow');
      }
}
function SearchContent(url,id) {
    $.get(url).done(function (data) {
  $('#'+id).jqxWindow('setContent', data);
}); 
}

function funSearchLoad(){
	changeContent('searchGrid.jsp?id=1', $('#window'));
 }
function funReadOnly() {
	$('#frmGateInPass input').attr('readonly',true);
}
function funRemoveReadOnly() {
	$('#frmGateInPass input').attr('readonly',false);
	$('#docno').attr('readonly',true);
	$('#fleetno').attr('readonly',true);
	$('#driver,#cldcono').attr('readonly',true);
	if($('#mode').val()=='A'){
		$('#complaintGrid').jqxGrid('clear');
		$('#complaintGrid').jqxGrid({disabled:false});
		$("#complaintGrid").jqxGrid("addrow", null, {});
		$('#agmtexist').val('');
	}
	else if($('#mode').val()=='E'){
		$('#complaintGrid').jqxGrid({disabled:false});
		$("#complaintGrid").jqxGrid("addrow", null, {});
	}
}
function setValues() {
	 document.getElementById("formdetail").value="Gate In-Pass";
     document.getElementById("formdetailcode").value="GIP";
	document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	funSetlabel();
	 if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
	 }
	if($('#hidchkdriver').val()!=""){
		if($('#hidchkdriver').val()=='1'){
			document.getElementById("chkdriver").checked=true;
		}
		else{
			document.getElementById("chkdriver").checked=false;
		}
	}
	if($('#docno').val()!=''){
		$('#complaintdiv').load('complaintGrid.jsp?docno='+$('#docno').val()+'&branch='+$('#brchName').val()+'&id=1');		
	}
	if($('#hidcmbinfuel').val()!=''){
		document.getElementById('cmbinfuel').value=$('#hidcmbinfuel').val();
	}
}

 function funFocus()
    {
    	//document.getElementById("fleetno").focus(); 
    }
    
     
 function funNotify(){
	 if($('#driver').val()==''){
		 document.getElementById("errormsg").innerText="";
		 document.getElementById("errormsg").innerText="Driver is Mandatory";
	 	return 0;
	 }
	 if($('#fleetno').val()==''){
		 document.getElementById("errormsg").innerText="";
		 document.getElementById("errormsg").innerText="Fleet is Mandatory";
	 	return 0;
	 }
	 if($('#indate').jqxDateTimeInput('getDate')==null){
		 document.getElementById("errormsg").innerText="";
		 document.getElementById("errormsg").innerText="In Date is Mandatory";
	 	return 0;
	 }
	 if($('#intime').jqxDateTimeInput('getDate')==null){
		 document.getElementById("errormsg").innerText="";
		 document.getElementById("errormsg").innerText="In Date is Mandatory";
	 	return 0;
	 }
	 if($('#inkm').val()==''){
		 document.getElementById("errormsg").innerText="";
		 document.getElementById("errormsg").innerText="In Km is Mandatory";
	 	return 0;
	 }
	 if($('#cmbinfuel').val()==''){
		 document.getElementById("errormsg").innerText="";
		 document.getElementById("errormsg").innerText="In Fuel is Mandatory";
	 	return 0;
	 }
	 /* if($('#serviceduekm').val()==''){
		 document.getElementById("errormsg").innerText="";
		 document.getElementById("errormsg").innerText="Next Service Due KM is Mandatory";
	 	return 0;
	 }
	 km=parseFloat($('#inkm').val());
	 servicekm=parseFloat($('#serviceduekm').val());
	 if(servicekm<=km){
		 document.getElementById("errormsg").innerText="";
		 document.getElementById("errormsg").innerText="Next Service Due KM must be greater than In Km";
	 	return 0;
	 } */
	if(document.getElementById("chkdriver").checked==true){
		$('#hidchkdriver').val('1');
	}
	else{
		$('#hidchkdriver').val('0');
	}
	var rows = $("#complaintGrid").jqxGrid('getrows');
	var gridlength=0;
	for(var i=0;i<rows.length;i++){
		if(rows[i].complaintdocno!="" && rows[i].complaintdocno!=null && rows[i].complaintdocno!="undefined" && typeof(rows[i].complaintdocno)!="undefined"){
			gridlength++;
			newTextBox = $(document.createElement("input"))
			.attr("type", "dil")
			.attr("id", "test"+i)
			.attr("name", "test"+i)
			.attr("hidden",true);
				
			newTextBox.val(rows[i].complaintdocno+"::"+rows[i].description);
			
			newTextBox.appendTo('form');
			
		}
	}
	$('#gridlength').val(gridlength);
	
	return 1;
 } 
 function setDriverType(){
	 if(document.getElementById("chkdriver").checked==true){
		 $('#driver').attr('readonly',false);
		 $('#driver').attr('placeholder','Please Type In');
		 $('#hidchkdriver').val('1');
	 }
	 else{
		 $('#driver').attr('readonly',true);
		 $('#driver').attr('placeholder','Press F3 to Search');
		 $('#hidchkdriver').val('0');
	 }
	 
	 
	 
 }
 
 function isNumber(evt,id) {
		//Function to restrict characters and enter number only
			  var iKeyCode = (evt.which) ? evt.which : evt.keyCode
		        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
		         {
		        	 $.messager.alert('Warning','Enter Numbers Only');
		           $("#"+id+"").focus();
		            return false;
		            
		         }
		        
		        return true;
		    }
 
 function funCheckKm(value){
	 var srvcdue=$('#hidsrvcdue').val();
	 if(parseFloat(value)>parseFloat(srvcdue)){
		 $.messager.alert('Warning','Service Due Limit Exceeded');
	 }
 }
</script>
<style>
	
</style>
</head>	
<body onLoad="setValues();">
	<div id="mainBG" class="homeContent" data-type="background"> 
		<form id="frmGateInPass" action="saveGateInPass" method="post" autocomplete="off" class="form-inline">
			<jsp:include page="../../../header.jsp" />
   			<br>
    		<table width="100%" border="0">
  <tr>
    <td width="10%" align="right">Date</td>
    <td width="12%"><div id="date" name="date" value='<s:property value="date"/>'></div></td>
    <td colspan="5">&nbsp;</td>
    <td ><label id="srvcmsg" name="srvcmsg" style="font-weight:bold;color:#000;font-size:12px;"></label></td>
    <td width="13%"  align="right">Doc No</td>
    <td width="13%"><input type="text" name="docno" id="docno" value='<s:property value="docno"/>'></td>
  </tr>
  <tr>
    <td  align="right">Vehicle</td>
    <td><input type="text" name="fleetno" id="fleetno"  value='<s:property value="fleetno"/>' placeholder="Press F3 to Search" onkeydown="getFleet(event);"></td>
    <td colspan="8"><input type="text" name="fleetdetails" id="fleetdetails" value='<s:property value="fleetdetails"/>' style="width:95.5%;" readonly></td>
    </tr>
    <tr>
    <td  align="right">Client</td>
    <td><input type="text" name="cldocno" id="cldocno"  value='<s:property value="cldocno"/>' placeholder="Press F3 to Search" onkeydown="getClient(event);"></td>
    <td colspan="8"><input type="text" name="clientdetails" id="clientdetails" value='<s:property value="clientdetails"/>' style="width:95.5%;" readonly></td>
    </tr>
  <tr>
    <td align="right"><input type="checkbox" name="chkdriver" id="chkdriver" onchange="setDriverType();"><label for="chkdriver">New Driver</label>&nbsp;&nbsp;Driver</td>
    <td><input type="text" name="driver" id="driver" value='<s:property value="driver"/>' placeholder="Press F3 to Search" onkeydown="getDriver(event);"></td>
    <input type="hidden" name="hiddriver" id="hiddriver"  value='<s:property value="hiddriver"/>'>
    <input type="hidden" name="hidchkdriver" id="hidchkdriver"  value='<s:property value="hidchkdriver"/>'>
    <td width="8%"  align="right">In Date</td>
    <td width="10%"><div id="indate" name="indate"  value='<s:property value="indate"/>'></div></td>
    <td width="8%"  align="right">In Time</td>
    <td width="10%"><div id="intime" name="intime"  value='<s:property value="intime"/>'></div></td>
    <td width="9%"  align="right">In Km</td>
    <td width="7%"><input type="text" name="inkm" id="inkm"  value='<s:property value="inkm"/>' onkeypress="javascript:return isNumber (event,id)" onblur="funCheckKm(this.value)"></td>
    <td  align="right">In Fuel</td>
    <td><select name="cmbinfuel" id="cmbinfuel" value='<s:property value="cmbinfuel"/>'>
            <option value="">--Select--</option>
            <option value=0.000>Level 0/8</option>
            <option value=0.125>Level 1/8</option>
            <option value=0.250>Level 2/8</option>
            <option value=0.375>Level 3/8</option>
            <option value=0.500>Level 4/8</option>
            <option value=0.625>Level 5/8</option>
            <option value=0.750>Level 6/8</option>
            <option value=0.875>Level 7/8</option>
            <option value=1.000>Level 8/8</option>
        </select></td>
  </tr>
  <tr>
    <td  align="right">Remarks</td>
    <td colspan="7"><input type="text" name="remarks" id="remarks"  value='<s:property value="remarks"/>' style="width:99.5%;"></td>
    <td  align="right"><span hidden="true">Next Service Due Km</span></td>
    <td><input type="text" name="serviceduekm" id="serviceduekm"  value='<s:property value="serviceduekm"/>' onkeypress="javascript:return isNumber (event,id)" hidden="true"></td>
  </tr>
  <tr>
    <td colspan="10"><div id="complaintdiv"><jsp:include page="complaintGrid.jsp"></jsp:include></div></td>
    </tr>
          </table>

    		<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
		    <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
      		<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
      		<input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'/>
      		<input type="hidden" name="hidcmbinfuel" id="hidcmbinfuel" value='<s:property value="hidcmbinfuel"/>'/>
      		<input type="hidden" name="hidsrvcdue" id="hidsrvcdue" value='<s:property value="hidsrvcdue"/>'/>
      		<input type="hidden" name="srvckm" id="srvckm" value='<s:property value="srvckm"/>'/>
      		<input type="hidden" name="lastsrvckm" id="lastsrvckm" value='<s:property value="lastsrvckm"/>'/>
      		<input type="hidden" name="agmtexist" id="agmtexist" value='<s:property value="agmtexist"/>'>
    <input type="hidden" name="agmtno" id="agmtno" value='<s:property value="agmtno"/>'>
    	</form>
    </div>
    <div id="fleetwindow">
   		<div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
	</div>
	<div id="driverwindow">
   		<div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
	</div>
	<div id="complaintwindow">
   		<div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
	</div>
	<div id="clientwindow">
   		<div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
	</div>
</body>
</html>