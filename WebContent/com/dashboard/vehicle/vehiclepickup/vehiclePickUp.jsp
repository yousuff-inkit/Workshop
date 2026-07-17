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
<style>
textarea{
font-family:Tahoma;
font-size:12px;

}
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
  background-color: #31b0d5;
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
	
	
	
	document.getElementById("btnpickupsave").style.display="none";
	$("#overlay, #PleaseWait").hide();
	 /* $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");     */
	    $('#agmtnowindow').jqxWindow({ width: '60%', height: '68%',  maxHeight: '68%' ,maxWidth: '60%' , title: 'Agreement Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#agmtnowindow').jqxWindow('close');
	    $("#periodupto").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#indate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	 $("#intime").jqxDateTimeInput({ width: '80%', height: '17px', formatString: 'HH:mm', showCalendarButton: false ,value:null});
	funDisable();
	 $('#agmtvocno').dblclick(function(){
		 
				if(document.getElementById("cmbbranch").value==""){
					
					$.messager.alert('Message','Branch is Mandatory','warning');
					return false;
				}
				if(document.getElementById("cmbtype").value==""){
					$.messager.alert('Message','Agreement Type is Mandatory','warning');
					return false;
				}
	    $('#agmtnowindow').jqxWindow('open');
	$('#agmtnowindow').jqxWindow('focus');

	 agmtnoSearchContent('agmtnoSearch.jsp?', $('#agmtnowindow'));
		 
		 });
	 
	 funClearData();
});

function getAgmt(event){
	
	  /*  $('#gridRaSearch').jqxGrid('clear');
	 $("#gridRaSearch").jqxGrid("addrow", null, {}); */
	if(document.getElementById("cmbbranch").value==""){
		
		$.messager.alert('Message','Branch is Mandatory','warning');
		return false;
	}
	if(document.getElementById("cmbtype").value==""){
		$.messager.alert('Message','Agreement Type is Mandatory','warning');
		return false;
	}
	 var x= event.keyCode;
   if(x==114){
  	 
	    $('#agmtnowindow').jqxWindow('open');
		$('#agmtnowindow').jqxWindow('focus');
		 agmtnoSearchContent('agmtnoSearch.jsp?', $('#agmtnowindow'));
   }
   else{
    }
	
}
function agmtnoSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#agmtnowindow').jqxWindow('setContent', data);

}); 
}
function funDisable(){
	/* $('input[type=text],[type=email],[type=hidden],[type=password], textarea').val('');
	$('select').find('option').prop("selected", false); */
	$('#pickupfield').prop('disabled',true);
	$('#indate').jqxDateTimeInput('disabled',true);
}
function funpickupadd(){
	$('#pickupfield').prop('disabled',false);
	$('#indate').jqxDateTimeInput('disabled',false);
	document.getElementById("btnpickupadd").style.display="none";
	document.getElementById("btnpickupsave").style.display="block";
}
function funpickupsave(){
	if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=='a'){
		$.messager.alert('Message','Please Select a Branch','warning');
		return false;
	}
	if(document.getElementById("agmtvocno").value==""){
		$.messager.alert('Message','Agreement is Mandatory','warning');
		return false;
	}
	if($('#indate').jqxDateTimeInput('getDate')==null){
		$.messager.alert('Message','Pick Up Date is Mandatory','warning');
		return false;
	}
	if($('#intime').jqxDateTimeInput('getDate')==null){
		$.messager.alert('Message','Pick Up Time is Mandatory','warning');
		return false;
	}
	document.getElementById("mode").value="A";
	 $("#overlay, #PleaseWait").show();
	document.getElementById("frmVehiclePickup").submit();

}

function funreload(event){
	  var branchval = document.getElementById("cmbbranch").value;
	 
	 $("#pickupdiv").load("pickupGrid.jsp?branchval="+branchval);
 
 }
 function setValues(){
	getBranch();
	 if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
	
 }
 function funPickupPrint(){
	 if(document.getElementById("docno").value==""){
		 $.messager.alert('Message','Please Select a Document','warning');
		 return false;
	 }
	 else{
		 
		 var url=document.URL;
		 if(document.getElementById("mode").value==""){
			 var reurl=url.split("vehiclePickUp.jsp");	 
			 var win= window.open(reurl[0]+"vehiclePickUpPrint?docno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
				win.focus(); 
		 }
		 else {
			 var reurl=url.split("saveVehiclePickup");
			 var win= window.open(reurl[0]+"vehiclePickUpPrint?docno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
				win.focus(); 
		 }
     	
	 }
 }
 
 function funPickupDelete(){
	 if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=='a'){
			$.messager.alert('Message','Please Select a Branch','warning');
			return false;
		}
	 if(document.getElementById("docno").value==""){
		 $.messager.alert('Message','Please Select a Document','warning');
		 return false;
	 }
	 else{
		document.getElementById("mode").value="D";
		 $("#overlay, #PleaseWait").show();
		document.getElementById("frmVehiclePickup").submit();
	 }
 }
 
 
 function funClearData(){
	 $('#cmbagmttype').val('');
	 $('#agmtvocno').val('');
	 $('#agmtno').val('');
	 $('#fleet_details').val('');
	 //$('#agmtdetails').val('');
	 $('#fleet_no').val('');
	 $('#indate').jqxDateTimeInput('setDate',null);
	 $('#intime').jqxDateTimeInput('setDate',null);
	 $('#inkm').val('');
	 $('#cmbinfuel').val('');
	 $('#pickdesc').val('');
	 $('#docno').val('');
	// $('#agmtdetails').innerText('');
	//document.getElementById("agmtdetails").innerText="";
 }
 
</script>
</head>
<body onload="setValues();">
<form id="frmVehiclePickup" action="saveVehiclePickup" method="post" autocomplete="off">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

 <tr><td width="25%"><label class="branch">Period Upto</label></td><td width="75%"><div id="periodupto"></div></td></tr>
 <tr>
   <td colspan="2"><center><button type="button" class="myButtons" id="btnpickupadd" onclick="funpickupadd();">Add</button>&nbsp;
   <button type="button" class="myButtons" id="btnpickupsave" hidden="true" onclick="funpickupsave();">Save</button></center>
   </td>
   </tr>
<tr>
  <td colspan="2">
    <fieldset id="pickupfield"><legend>In Details</legend>
      <table width="100%">
        <tr>
          <td width="87" align="right"><label class="branch">Type</label></td>
          <td width="235" align="left"><select name="cmbtype" id="cmbtype" value='<s:property value="cmbtype" />'><option value="">--Select--</option><option value="RAG">Rental</option>
            <option value="LAG">Lease</option></select></td>
          </tr>
        <tr>
          <td align="right"><label class="branch">Agmt</label></td>
          <td align="left"><input type="text" name="agmtvocno" id="agmtvocno" onKeyDown="getAgmt(event);" readonly value='<s:property value="agmtvocno"/>'></td>
<input type="hidden" name="agmtno" id="agmtno" value='<s:property value="agmtno"/>' />
          </tr>
        <tr>
          <td align="right"><label class="branch">Fleet</label></td>
          <td align="left"><input type="text" name="fleetdetails" id="fleetdetails" value='<s:property value="fleetdetails"/>' readonly></td>
          <input type="hidden" name="fleet_no" id="fleet_no" value='<s:property value="fleet_no"/>' readonly>
          </tr>
        <tr>
          <td align="right"><label class="branch">Date</label></td>
          <td align="left"><div id="indate" name="indate" value='<s:property value="indate" />'></div></td>
          </tr>
        <tr>
          <td align="right"><label class="branch">Time</label></td>
          <td align="left"><div id="intime" name="intime" value='<s:property value="intime" />'></div></td>
          </tr>
        <tr>
          <td align="right"><label class="branch">Km</label></td>
          <td align="left"><input type="text" name="inkm" id="inkm" value='<s:property value="inkm" />'></td>
          </tr>
        <tr>
          <td align="right"><label class="branch">Fuel</label></td>
          <td align="left"><select name="cmbinfuel" id="cmbinfuel" value='<s:property value="cmbinfuel" />'><option value="">--Select--</option>
            <option value=0.000>Level 0/8</option>
            <option value=0.125>Level 1/8</option>
            <option value=0.250>Level 2/8</option>
            <option value=0.375>Level 3/8</option>
            <option value=0.500>Level 4/8</option>
            <option value=0.625>Level 5/8</option>
            <option value=0.750>Level 6/8</option>
            <option value=0.875>Level 7/8</option>
            <option value=1.000>Level 8/8</option>
            </select>
            </td>
          </tr>
        <tr>
          <td align="right"><label class="branch">Details</label></td>
          <td align="left"><input type="text" name="pickdesc" id="pickdesc" value='<s:property value="pickdesc" />' style="height:50px;"></td>
        </tr>
        </table>
      </fieldset>
    </td>
</tr>
<tr>
  <td colspan="2" align="left"><center><button type="button" name="btnpickupprint" id="btnpickupprint" class="myButtons" onclick="funPickupPrint();">Print</button>
  &nbsp;&nbsp;&nbsp;
  <button type="button" name="btnpickupdelete" id="btnpickypdelete" class="myButtons" onclick="funPickupDelete();">Delete</button>
  </center></td>
  </tr> 
 
  <tr>
  <td colspan="2" ><textarea id="agmtdetails" name="agmtdetails" style="resize:none;width:100%;" rows="5" readonly></textarea></td>
  </tr> 
		 <tr>
		   <td colspan="2">&nbsp;</td>
		   </tr> 
	<tr>
	<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
	<td colspan="2"></td>
	</tr>	
	</table>
	</fieldset>
</td>
<td width="100%">
	<table width="100%">
		<tr>
			 <td>  <div id="pickupdiv"><jsp:include page="pickupGrid.jsp"></jsp:include></div> </td>
			 <input type="hidden" name="gridlength" id="gridlength" >
			  <input type="hidden" name="invgridlength" id="invgridlength" >
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  <input type="hidden" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>'>
			  <input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>'>
		</tr>
	</table>
</tr>
</table>
</div>
<div id="agmtnowindow">
   <div ></div>
</div>
</div>
</form>
</body>
</html>