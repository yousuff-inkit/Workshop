
  <jsp:include page="../../../../includes.jsp"></jsp:include>  
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 

<script type="text/javascript">

$(document).ready(function () {
	 $("#fleetdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value: null});
	 $("#fleettime").jqxDateTimeInput({ width: '25%', height: '17px', formatString: 'HH:mm', showCalendarButton: false,value: null});
	 $("#movdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value: null});
	 $("#movtime").jqxDateTimeInput({ width: '25%', height: '17px', formatString: 'HH:mm', showCalendarButton: false,value: null});
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");    
	 document.getElementById("cmbfuel").value="";
	 document.getElementById("cmbfuel").disabled=true;
	 document.getElementById("btnUpdate").disabled=true;
		   $('#searchwindow').jqxWindow({ width: '70%', height: '58%',  maxHeight: '62%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#searchwindow').jqxWindow('close');
	   
	   $('#driver').dblclick(function(){
		    $('#searchwindow').jqxWindow('open');
		  $('#searchwindow').jqxWindow('focus');
		 SearchContent('DriverSearch.jsp', $('#searchwindow'));
		 });  
	 
});
function getproject(event){
	
	 var x= event.keyCode;
	 if(x==114){
	  $('#searchwindow').jqxWindow('open');

// $('#accountWindow').jqxWindow('focus');
	  SearchContent('DriverSearch.jsp'); 	 }
	 else{
		 }
	 }
	 

function SearchContent(url) {
  //alert(url);
$.get(url).done(function (data) {
	 //alert(data);
$('#searchwindow').jqxWindow('setContent', data);

	   }); 
}

function updateStatus(){
	var fleet_no=document.getElementById("fleetno").value;
	var driverdocno=document.getElementById("docno").value;
	var fleetdate=$('#fleetdate').jqxDateTimeInput('getDate');
	var fleettime=$('#fleettime').jqxDateTimeInput('getDate');
	var km= document.getElementById("km").value; 
	var fuel=document.getElementById("cmbfuel").value;
	var branch=$('#cmbbranch').val();
	if(branch=="" || branch=="a"){
		$.messager.alert('Message',"Please select a specific branch");
		return false;
	}
	if(document.getElementById("fleetno").value==""){
		 $.messager.alert('Message',"Please select fleet");
		 return false;
	}
	 if(document.getElementById("driver").value==""){
		 $.messager.alert('Message',"Please select Driver");
		 return false;
	}
	 if(fleetdate==null || fleetdate=="undefined" || fleetdate=="" || typeof(fleetdate)=="undefined") {
		 $.messager.alert('Message',"Please select date");
		  return false;
		}
	 
	 if(fleettime==null || fleettime=="undefined" || fleettime=="" || typeof(fleettime)=="undefined"){
		 $.messager.alert('Message',"Please enter time");
		 return false;
	}
	 
	 var fleetdatecalc=new Date($('#fleetdate').jqxDateTimeInput('getDate'));
	 var movdate=new Date($('#movdate').jqxDateTimeInput('getDate'));
	 var fleettimecalc=new Date($('#fleettime').jqxDateTimeInput('getDate'));
	 var movtime=new Date($('#movtime').jqxDateTimeInput('getDate'));
	 fleetdatecalc.setHours(0,0,0,0);
	 movdate.setHours(0,0,0,0);
	 if(fleetdatecalc<movdate){
		 $.messager.alert('warning','Date cannot be less than last In Date');
		 return false;
	 }
	 if(fleetdatecalc-movdate==0){
		 if(fleettimecalc.getHours()<movtime.getHours()){
			 $.messager.alert('warning','Time cannot be less than last In Time');
			 return false;
		 }
		 if(fleettimecalc.getHours()==movtime.getHours()){
			 if(fleettimecalc.getMinutes()<movtime.getMinutes()){
				 $.messager.alert('warning','Time cannot be less than last In Time');
				 return false;
			 }
		 }
	 }
	 if(document.getElementById("km").value==""){
		 $.messager.alert('Message',"Please enter KM");
		 return false;
	}
	 var fleetkm=parseFloat(document.getElementById("km").value);
	 var movkm=parseFloat(document.getElementById("movkm").value);
	 if(fleetkm<movkm){
		 $.messager.alert('Message',"KM cannot be less than last In Km");
		 return false;
	 }
	 if(document.getElementById("cmbfuel").value==""){
		 $.messager.alert('Message',"Please select fuel");
		 return false; 
	}   
	$('#overlay,#PleaseWait').show();
 	var x = new XMLHttpRequest();
 	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			
			if(items.trim()=="1"){
					   $.messager.alert('Message',"Successfully Saved");
						
					   funreload(this);
					   $('#overlay,#PleaseWait').hide();
			}
				else{
					$.messager.alert('Message',"Not Saved");
					funreload(this);
					$('#overlay,#PleaseWait').hide();
				}

		} else {
		}
	}
	x.open("GET", "updateStatus.jsp?fleetno="+fleet_no+"&fleetdate="+$('#fleetdate').jqxDateTimeInput('val')+"&fleettime="+$('#fleettime').jqxDateTimeInput('val')+"&km="+km+"&fuel="+fuel+"&driverdocno="+driverdocno+"&branch="+branch, true);
	x.send();
 }
function funreload(event)
{
	 document.getElementById("btnUpdate").disabled=true;
	 document.getElementById("fleetdetails").value="";
	 document.getElementById("cmbfuel").value="";
	
 	$('input[type=text],[type=hidden]').val('');
   $('#fleetdate').jqxDateTimeInput('setDate', null);
	  $('#fleettime').jqxDateTimeInput('setDate', null);
  	var barchval = document.getElementById("cmbbranch").value;
     
	  $("#fleetdiv").load("vehassignmentGrid.jsp?branchval="+barchval);
	  
	  
	
	}
	
	
function funExportBtn()
{
	
	 


  if(parseInt(window.parent.chkexportdata.value)=="1")
	    {
	    JSONToCSVCon(ssss, 'Unrentable', true);
	    }
	   else
	    {
		   $("#vehassignmentGrid").jqxGrid('exportdata', 'xls', 'Unrentable');
	    }
	}

</script>
</head>
<body onload="getBranch();">
<form autocomplete="off">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
	
	<!--  <tr><td colspan="2">&nbsp;</td></tr> -->
		 <tr>
	<td colspan="2" ><table width="100%">
	  
	  <tr>
	    <td width="25%" align="right"><label class="branch">Fleet No.</label></td>
	    <td colspan="2"><input type="text" name="fleetno" id="fleetno" readonly style="height:18px;"></td>
	    </tr>
	  <tr>
	    <td align="right"><label class="branch">Fleet Details</label></td>
	    <td colspan="2">
	    
	    <textarea id="fleetdetails" style="height:50px;width:125px;font: 10px Tahoma;resize:none" name="fleetdetails"  readonly="readonly"  ></textarea>
	    
	    </td>
	    </tr>
	   <tr>
	    <td align="right"><label class="branch">Driver</label></td>
	    <td colspan="2"><input type="text" id="driver" name="driver" readonly placeholder="Press F3 To Search" value='<s:property value="driver"/>' onKeyDown="getproject(event);" ondoubleclick="getproject(event);" style="height:18px;"/></td></td>
	    </tr>
	  <tr>
	    <td align="right"><label class="branch">Date</label></td>
	    <td colspan="2"><div id="fleetdate" name="fleetdate"></div></td>
	    </tr>
	  <tr>
	    <td align="right"><label class="branch">Time</label></td>
	    <td colspan="2"><div id="fleettime" name="fleettime"></div></td>
	    </tr>
	    <tr>
	    <td width="17%" align="right"><label class="branch">KM.</label></td>
	    <td colspan="2"><input type="text" name="km" id="km" style="height:18px;"></td>
	    </tr>
	  <tr>
	    <td align="right"><label class="branch">Fuel</label></td>
	    <td colspan="2"><select name="cmbfuel" id="cmbfuel" style="width:68%;"><option value="">--Select--</option>
	    <option value=0.000 selected>Level 0/8</option>
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
	    <td colspan="2" align="center">
	  
	   <input type="button" name="btnUpdate" id="btnUpdate" value="Update" class="myButton" onClick="updateStatus();"></td>
	    
	    </td>
	      </tr>
	  <!-- <tr>
	    <td colspan="3"><center><div id="hiddate" name="hiddate" hidden="true"></div><div id="hidtime" name="hidtime" hidden="true"></div></center></td>
	    </tr> -->
	  </table>
	<br><br><br><br><br><br><br><br><br><br><br><br>
	
	
	<%-- <div id="Readygrid"   ><jsp:include page="vehDetailsgrid.jsp"></jsp:include>
	</div> --%></td>
	</tr> 
	<tr>

 
 


	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="fleetdiv"><jsp:include page="vehassignmentGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>

<input type="hidden" name="docno" id="docno">
<div id="movdate"></div>
<div id="movtime"></div>
<input type="hidden" name="movkm" id="movkm">
<div id="searchwindow">
   <div ></div>
</div>


</div>
</div>

</form>
</body>
</html>