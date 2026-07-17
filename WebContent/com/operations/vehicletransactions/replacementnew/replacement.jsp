<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="../../../../css/body.css"> 
 <style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style> 
<script type="text/javascript">
$(document).ready(function () { 
	document.getElementById("btnEdit").disabled=true;
	 $('#btnDelete').attr('disabled',true);
	document.getElementById("btnUpdate").style.display="none";
	document.getElementById("btnUpdateSave").style.display="none";
//date definition 
$("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection: true});
$("#refdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null,enableBrowserBoundsDetection: true});
$("#dateout").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null,enableBrowserBoundsDetection: true});
$("#dateouthidden").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection: true});
$("#atbranchdatein").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null,enableBrowserBoundsDetection: true});
$("#atbranchoutdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null,enableBrowserBoundsDetection: true});
$("#coloutdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null,enableBrowserBoundsDetection: true});
$("#colcollectdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null,enableBrowserBoundsDetection: true});
$("#coldeldate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null,enableBrowserBoundsDetection: true});
$("#colindate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null,enableBrowserBoundsDetection: true});
//time definition
 $("#timeout").jqxDateTimeInput({ width: '40%', height: '15px', formatString: 'HH:mm', showCalendarButton: false,value:null });
$("#timeouthidden").jqxDateTimeInput({ width: '40%', height: '15px', formatString: 'HH:mm', showCalendarButton: false,value:new Date()});
$("#atbranchtimein").jqxDateTimeInput({ width: '80%', height: '15px', formatString: 'HH:mm', showCalendarButton: false,value:null });
$("#atbranchouttime").jqxDateTimeInput({ width: '40%', height: '15px', formatString: 'HH:mm', showCalendarButton: false,value:null });
$("#colouttime").jqxDateTimeInput({ width: '40%', height: '15px', formatString: 'HH:mm', showCalendarButton: false,value:null });
$("#colcollecttime").jqxDateTimeInput({ width: '40%', height: '15px', formatString: 'HH:mm', showCalendarButton: false,value:null });
$("#coldeltime").jqxDateTimeInput({ width: '40%', height: '15px', formatString: 'HH:mm', showCalendarButton: false,value:null });
$("#colintime").jqxDateTimeInput({ width: '40%', height: '15px', formatString: 'HH:mm', showCalendarButton: false,value:null });
changeAtbranch();
getBranch();
getReason();
getTestLocation();
//Window Definition

 $('#agmtnowindow').jqxWindow({ width: '60%', height: '54%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Agreement Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
   	   $('#agmtnowindow').jqxWindow('close');
   	 $('#collectionwindow').jqxWindow({ width: '60%', height: '54%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Driver Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
 	   $('#collectionwindow').jqxWindow('close');
 	  $('#vehiclewindow').jqxWindow({ width: '60%', height: '54%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Vehicle Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#vehiclewindow').jqxWindow('close');

/* 
('#dateout').on('change', function (event) 
		{  
checkfuturedate();
		   });  */
		   
		   
$('#refvocno').dblclick(function(){
		 if(document.getElementById("mode").value=="view"){
			 return false;
		 }
		 if(document.getElementById("cmbrentaltype").value==''){
			 document.getElementById("errormsg").innerText="Agreement Type is Mandatory";
			document.getElementById("cmbrentaltype").focus();
			 return false;  
		 }
		 if(document.getElementById("cmbagmtbranch").value==''){
			 document.getElementById("errormsg").innerText="";
			 document.getElementById("errormsg").innerText="Agreement Branch is Mandatory";
			 return false;
			 
		 }
		
		document.getElementById("errormsg").innerText="";
	    $('#agmtnowindow').jqxWindow('open');
	 agmtnoSearchContent('agmtnoSearch.jsp?', $('#agmtnowindow'));
	});
	
	
	
	
	$('#colcollectdriver').dblclick(function(){
	    $('#collectionwindow').jqxWindow('open');
	$('#collectionwindow').jqxWindow('focus');
	 collectionSearchContent('driverSearchGrid.jsp?id=1', $('#collectionwindow'));
	});
	
	
	
$('#coldeldriver').dblclick(function(){
   $('#collectionwindow').jqxWindow('open');
	$('#collectionwindow').jqxWindow('focus');
	collectionSearchContent('driverSearchGrid.jsp?id=2',  $('#collectionwindow'));
});



	 $('#atbranchoutfleetno').dblclick(function(){
		 //alert(document.getElementById("mode").value);
		if(document.getElementById("mode").value=="view"){
		 return false;
	 }
		$('#vehiclewindow').jqxWindow('open');
	$('#vehiclewindow').jqxWindow('focus');
	 vehicleSearchContent('masterFleetSearch.jsp?id=1', $('#vehiclewindow'));
	});
	 
	 
	 
	 $('#coloutfleetno').dblclick(function(){
			if(document.getElementById("mode").value=="view"){
			 return false;
		 }
			
		    $('#vehiclewindow').jqxWindow('open');
		$('#vehiclewindow').jqxWindow('focus');
		 vehicleSearchContent('masterFleetSearch.jsp?id=2', $('#vehiclewindow'));
		});
	 
	 
	 
});

function getAgmtno(event){
	 if(document.getElementById("mode").value=="view"){
		 return false;
	 }
	 if(document.getElementById("cmbrentaltype").value==''){
		 document.getElementById("errormsg").innerText="Agreement Type is Mandatory";
		document.getElementById("cmbrentaltype").focus();
		 return false;  
	 }
	document.getElementById("errormsg").innerText="";
   
		 
	  var x= event.keyCode;
     if(x==114){
    	 $('#agmtnowindow').jqxWindow('open');
    	 agmtnoSearchContent('agmtnoSearch.jsp?', $('#agmtnowindow'));
     }
     else{
      }
}
function getAtbranchOutFleet(event){
	 if(document.getElementById("mode").value=="view"){
		 return false;
	 }
	  var x= event.keyCode;
	     if(x==114){
	    	 $('#vehiclewindow').jqxWindow('open');
	    	 $('#vehiclewindow').jqxWindow('focus');
	    	 vehicleSearchContent('masterFleetSearch.jsp?id=1', $('#vehiclewindow'));
	     }
	     else{
	      }
	 
}
function getColOutFleet(event){
	 if(document.getElementById("mode").value=="view"){
		 return false;
	 }
	  var x= event.keyCode;
	     if(x==114){
	    	 $('#vehiclewindow').jqxWindow('open');
	    	 $('#vehiclewindow').jqxWindow('focus');
	    	 vehicleSearchContent('masterFleetSearch.jsp?id=2', $('#vehiclewindow'));
	     }
	     else{
	      }
}

function getDriver(event,id){
	 var x= event.keyCode;
     if(x==114){
    	 $('#collectionwindow').jqxWindow('open');
    		$('#collectionwindow').jqxWindow('focus');
    		collectionSearchContent('driverSearchGrid.jsp?id='+id,  $('#collectionwindow'));
     }
     else{
      }
}
function agmtnoSearchContent(url) {

	$.get(url).done(function (data) {
  $('#agmtnowindow').jqxWindow('setContent', data);
}); 
	
}
function vehicleSearchContent(url) {

	$.get(url).done(function (data) {
  $('#vehiclewindow').jqxWindow('setContent', data);
}); 
	
}

function collectionSearchContent(url) {
    $.get(url).done(function (data) {
  $('#collectionwindow').jqxWindow('setContent', data);
}); 
}




function checkfuturedate(){
		var date1=new Date($('#dateout').jqxDateTimeInput('getDate')); 
		var futuredate=new Date();
		date1.setHours(0,0,0,0);
		futuredate.setHours(0,0,0,0);

		if(date1>futuredate){
				   document.getElementById("errormsg").innerText="";
				   document.getElementById("errormsg").innerText="Future Date Cannot be applied";
				   $('#dateout').jqxDateTimeInput('focus'); 
				   return false;
			   }
	
			 
			   document.getElementById("errormsg").innerText="";
			 //  $('#timeout').jqxDateTimeInput('focus'); 
			   return true;
			  
	}

function getBranch() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			items = items.split('***');
			var branchItems = items[0].split(",");
			var branchIdItems = items[1].split(",");
			var optionsbranch = '<option value="">--Select--</option>';
			for (var i = 0; i < branchItems.length; i++) {
				optionsbranch += '<option value="' + branchIdItems[i] + '">'
						+ branchItems[i] + '</option>';
			}
			$("select#cmbinbranch").html(optionsbranch);
			$("select#cmbcolinbranch").html(optionsbranch);
			$("select#cmbagmtbranch").html(optionsbranch);
			if ($('#hidcmbinbranch').val() != null) {
				$('#cmbinbranch').val($('#hidcmbinbranch').val());
			}
			if ($('#hidcmbcolinbranch').val() != null) {
				$('#cmbcolinbranch').val($('#hidcmbcolinbranch').val());
			}
			if ($('#hidcmbagmtbranch').val() != null) {
				$('#cmbagmtbranch').val($('#hidcmbagmtbranch').val());
			}
		
		} else {
		}
	}
	x.open("GET", "getBranch.jsp", true);
	x.send();
}
	function getLoc(value) {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			items = items.split('***');
			var locationItems = items[0].split(",");
			var locationIdItems = items[1].split(",");
			var optionslocation = '<option value="">--Select--</option>';
			for (var i = 0; i < locationItems.length; i++) {
				optionslocation += '<option value="' + locationIdItems[i] + '">'
						+ locationItems[i] + '</option>';
			}
			$("select#cmbinlocation").html(optionslocation);
			$("select#cmbcolinlocation").html(optionslocation);
			if ($('#hidcmbinlocation').val() != null) {
				$('#cmbinlocation').val($('#hidcmbinlocation').val());
			}
			if ($('#hidcmbcolinlocation').val() != null) {
				$('#cmbcolinlocation').val($('#hidcmbcolinlocation').val());
			}
		
		} else {
		}
	}
	x.open("GET", "getLoc.jsp?id="+value, true);
	x.send();
}
	
	
	function getReason() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('***');
				var statusItems = items[0].split(",");
				var statusIdItems = items[1].split(",");
				var optionsstatus = '<option value="">--Select--</option>';
				for (var i = 0; i < statusItems.length; i++) {
					optionsstatus += '<option value="' + statusIdItems[i] + '">'
							+ statusItems[i] + '</option>';
				}
				$("select#cmbtrreason").html(optionsstatus);
				//$("select#cmbcloselocation").html(optionsloc);
				if ($('#hidcmbtrreason').val() != null) {
					$('#cmbtrreason').val($('#hidcmbtrreason').val());
				}
			
			} else {
			}
		}
		x.open("GET", "getReason.jsp", true);
		x.send();
	}
 	function getTestLocation(){
 		
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('***');
				var locItems = items[0].split(",");
				var locIdItems = items[1].split(",");
				var optionsloc = '<option value="">--Select--</option>';
				for (var i = 0; i < locItems.length; i++) {
					optionsloc += '<option value="' + locIdItems[i] + '">'
							+ locItems[i] + '</option>';
				}
				
				$("select#cmbcolinlocation").html(optionsloc);
				$("select#cmbinlocation").html(optionsloc);
				//alert("here");
				if ($('#hidcmbinlocation').val() != null) {
				$('#cmbinlocation').val($('#hidcmbinlocation').val());
			}
				if ($('#hidcmbcolinlocation').val() != null) {
					//alert($('#hidcmbcolinlocation').val());
						$('#cmbcolinlocation').val($('#hidcmbcolinlocation').val());
					}
			} else {
			}
		}
		x.open("GET", "getTestLocation.jsp", true);
		x.send();
  }  
function funReadOnly(){
	 $('#frmReplacementNew input').attr('readonly', true );
		$('#frmReplacementNew select').attr('disabled', true);
		$('#date').jqxDateTimeInput({ disabled: true});
		$('#refdate').jqxDateTimeInput({ disabled: true});
		$('#dateout').jqxDateTimeInput({ disabled: true});
		$('#timeout').jqxDateTimeInput({ disabled: true});
		$('#atbranchdatein').jqxDateTimeInput({ disabled: true});
		$('#atbranchtimein').jqxDateTimeInput({ disabled: true});
		$('#atbranchoutdate').jqxDateTimeInput({ disabled: true});
		$('#atbranchouttime').jqxDateTimeInput({ disabled: true});
		$('#coloutdate').jqxDateTimeInput({ disabled: true});
		$('#colouttime').jqxDateTimeInput({ disabled: true});
		$('#colcollectdate').jqxDateTimeInput({ disabled: true});
		$('#colcollecttime').jqxDateTimeInput({ disabled: true});
		$('#coldeldate').jqxDateTimeInput({ disabled: true});
		$('#coldeltime').jqxDateTimeInput({ disabled: true});
		$('#colindate').jqxDateTimeInput({ disabled: true});
		$('#colintime').jqxDateTimeInput({ disabled: true});
}
function funRemoveReadOnly(){
	$('#frmReplacementNew input').attr('readonly', false );
	$('#frmReplacementNew select').attr('disabled', false);
	$('#date').jqxDateTimeInput({ disabled: false});
	$('#refdate').jqxDateTimeInput({ disabled: false});
	$('#dateout').jqxDateTimeInput({ disabled: false});
	$('#timeout').jqxDateTimeInput({ disabled: false});
	$('#atbranchdatein').jqxDateTimeInput({ disabled: false});
	$('#atbranchtimein').jqxDateTimeInput({ disabled: false});
	$('#atbranchoutdate').jqxDateTimeInput({ disabled: false});
	$('#atbranchouttime').jqxDateTimeInput({ disabled: false});
	$('#coloutdate').jqxDateTimeInput({ disabled: false});
	$('#colouttime').jqxDateTimeInput({ disabled: false});
	$('#colcollectdate').jqxDateTimeInput({ disabled: false});
	$('#colcollecttime').jqxDateTimeInput({ disabled: false});
	$('#coldeldate').jqxDateTimeInput({ disabled: false});
	$('#coldeltime').jqxDateTimeInput({ disabled: false});
	$('#colindate').jqxDateTimeInput({ disabled: false});
	$('#colintime').jqxDateTimeInput({ disabled: false});
	if(document.getElementById("mode").value=="A"){
		$('#atbranchfield').prop('disabled',true);
		$('#collectionfield').prop('disabled',true);
		$('#date').jqxDateTimeInput('setDate',new Date());
		$('#refdate').jqxDateTimeInput('setDate',null);
		$('#dateout').jqxDateTimeInput('setDate',null);
		$('#timeout').jqxDateTimeInput('setDate',null);
		$('#atbranchdatein').jqxDateTimeInput('setDate',null);
		$('#atbranchtimein').jqxDateTimeInput('setDate',null);
		$('#atbranchoutdate').jqxDateTimeInput('setDate',null);
		$('#atbranchouttime').jqxDateTimeInput('setDate',null);
		$('#coloutdate').jqxDateTimeInput('setDate',null);
		$('#colouttime').jqxDateTimeInput('setDate',null);
		$('#colcollectdate').jqxDateTimeInput('setDate',null);
		$('#colcollecttime').jqxDateTimeInput('setDate',null);
		$('#coldeldate').jqxDateTimeInput('setDate',null);
		$('#coldeltime').jqxDateTimeInput('setDate',null);
		$('#colindate').jqxDateTimeInput('setDate',null);
		$('#colintime').jqxDateTimeInput('setDate',null);
	}
	$('#inuser').prop('readonly',true);
	$('#atbranchoutfleetno').prop('readonly',true);
	$('#atbranchoutfleetname').prop('readonly',true);
	$('#atbranchoutbranch').prop('readonly',true);
	$('#atbranchoutlocation').prop('readonly',true);
	$('#atbranchoutuser').prop('readonly',true);
	$('#coloutfleetno').prop('readonly',true);
	$('#coloutfleetname').prop('readonly',true);
	$('#coloutbranch').prop('readonly',true);
	$('#coloutlocation').prop('readonly',true);
	$('#coloutuser').prop('readonly',true);
}
function setValues(){
	funSetlabel();
	/* if(document.getElementById("docno").value!=""){
		getTestLocation();
	} */
	document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
	
	
	//Time Setting
		if($('#hidtimeout').val()){
		$("#timeout").jqxDateTimeInput('val', $('#hidtimeout').val());
	}
		
	
		if($('#hidatbranchtimein').val()){
		$("#atbranchtimein").jqxDateTimeInput('val', $('#hidatbranchtimein').val());
	}
		if($('#hidatbranchouttime').val()){
		$("#atbranchouttime").jqxDateTimeInput('val', $('#hidatbranchouttime').val());
	}
		if($('#hidcolouttime').val()){
		$("#colouttime").jqxDateTimeInput('val', $('#hidcolouttime').val());
	}
		
		if($('#hidcolcollecttime').val()){
		$("#colcollecttime").jqxDateTimeInput('val', $('#hidcolcollecttime').val());
	}
		if($('#hidcoldeltime').val()){
			$("#coldeltime").jqxDateTimeInput('val', $('#hidcoldeltime').val());
		}
		if($('#hidcolintime').val()){
			$("#colintime").jqxDateTimeInput('val', $('#hidcolintime').val());
		}
		//Combo box setting
		
			if ($('#hidcmbrentaltype').val() != null) {
	$('#cmbrentaltype').val($('#hidcmbrentaltype').val());
}
			if ($('#hidcmbtrreason').val() != null) {
				$('#cmbtrreason').val($('#hidcmbtrreason').val());
			}
			if ($('#hidcmbreplacetype').val() != null) {
				$('#cmbreplacetype').val($('#hidcmbreplacetype').val());
			}
			if ($('#hidcmbfuel').val() != null) {
				$('#cmbfuel').val($('#hidcmbfuel').val());
			}
			if ($('#hidcmbinbranch').val() != null) {
				$('#cmbinbranch').val($('#hidcmbinbranch').val());
				
				
			}
			/* getTestLocation(); */
			
			if ($('#hidcmbatbranchinfuel').val() != null) {
				$('#cmbatbranchinfuel').val($('#hidcmbatbranchinfuel').val());
			}
			if ($('#hidcmbatbranchoutfuel').val() != null) {
				$('#cmbatbranchoutfuel').val($('#hidcmbatbranchoutfuel').val());
			}
			
			if ($('#hidcmbcoloutfuel').val() != null) {
				$('#cmbcoloutfuel').val($('#hidcmbcoloutfuel').val());
			}
			if ($('#hidcmbcolcollectfuel').val() != null) {
				$('#cmbcolcollectfuel').val($('#hidcmbcolcollectfuel').val());
			}
			if ($('#hidcmbcoldelfuel').val() != null) {
				$('#cmbcoldelfuel').val($('#hidcmbcoldelfuel').val());
			}
			if ($('#hidcmbcolinfuel').val() != null) {
				$('#cmbcolinfuel').val($('#hidcmbcolinfuel').val());
			}
			if ($('#hidcmbcolinbranch').val() != null) {
				$('#cmbcolinbranch').val($('#hidcmbcolinbranch').val());
				
				//getLoc($('#cmbcolinbranch').val());
			}
		
			
	
	if(document.getElementById("cmbreplacetype").value=="atbranch"){
		document.getElementById("chkatbranch").checked=true;
		document.getElementById("chkcollection").checked=false;
	}
	else if(document.getElementById("cmbreplacetype").value=="collection"){
		document.getElementById("chkatbranch").checked=false;
		document.getElementById("chkcollection").checked=true;
	}
	else{
		
	}
	if(document.getElementById("chkcollection").checked==true){
		if(document.getElementById("hidchkcollect").value=="1"){
			document.getElementById("chkcollect").checked=true;
		}
		else{
			document.getElementById("chkcollect").checked=false;
		}
		if(document.getElementById("hidchkdelivery").value=="1"){
			document.getElementById("chkdelivery").checked=true;
		}
		else{
			document.getElementById("chkdelivery").checked=false;
		}
	}
	
	if(document.getElementById("docno").value!="" && document.getElementById("chkcollection").checked==true){
		document.getElementById("btnUpdate").style.display="block";
	}
	if(document.getElementById("colinkm").value!="" && parseFloat(document.getElementById("colinkm").value)>0){
		document.getElementById("btnUpdate").style.display="none";
	}
	
	
	
	if(document.getElementById("docno").value!=""){
			getCancelStatus(document.getElementById("docno").value);
		}
}


function getCancelStatus(value) {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();
			if(items=="1"){
				document.getElementById("lblcancelstatus").innerText="CANCELLED";
			}
			else{
				document.getElementById("lblcancelstatus").innerText="";
			}
		} else {
		
		}
	}
	x.open("GET", "../replacement/getCancelStatus.jsp?id="+value, true);
	x.send();
}



function funNotify(){
	var docdateval=funDateInPeriod($('#date').jqxDateTimeInput('getDate'));
		if(docdateval==0){
			$('#date').jqxDateTimeInput('focus');
			return false;
		}
		else{
			document.getElementById("errormsg").innerText="";
		}
		/* var refdateval=funDateInPeriod($('#refdate').jqxDateTimeInput('getDate'));
		if(refdateval==0){
			$('#refdate').jqxDateTimeInput('focus');
			return false;
		}
		else{
			document.getElementById("errormsg").innerText="";
		} */
	var x=checkfuturedate();
	 	if(x==false){
	 		return 0;
	 	}
	 	
	 	if(document.getElementById("refno").value==''){
  	 		document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Ref No Should Not be Empty";
			document.getElementById("refno").focus();
			return 0;
  	 	}
	 	if(document.getElementById("chkatbranch").checked==false && document.getElementById("chkcollection").checked==false){
	 		document.getElementById("errormsg").innerText="";
	 		document.getElementById("errormsg").innerText="Please Select At Branch or Collection";
	 		document.getElementById("chkatbranch").focus();
	 		return 0;
	 	}
	 	if(document.getElementById("cmbtrreason").value==""){
	 		document.getElementById("errormsg").innerText="";
	 		document.getElementById("errormsg").innerText="Please Select Replacement Reason";
	 		document.getElementById("cmbtrreason").focus();
	 		return 0;
	 	}
	 	//alert($('#dateout').jqxDateTimeInput('val')+"::"+$('#timeout').jqxDateTimeInput('val')+"::"+$('#cmbfuel').val()+"::"+$('#cmbtrreason').val()+$('#atbranchoutkm').val()+"::"+$('#cmbatbranchoutfuel').val());
	$('#dateout').jqxDateTimeInput({ disabled: false});
	$('#timeout').jqxDateTimeInput({ disabled: false});
	 	var dateout=$('#dateout').jqxDateTimeInput('getDate');
	 var timeout=$('#timeout').jqxDateTimeInput('getDate');
	 var kmout=parseFloat(document.getElementById("outkm").value);
	 $('#dateout').jqxDateTimeInput({ disabled: true});
		$('#timeout').jqxDateTimeInput({ disabled: true});
	 dateout.setHours(0,0,0,0);
	 	if(document.getElementById("chkatbranch").checked==true){
		 var atbranchindate=$('#atbranchdatein').jqxDateTimeInput('getDate');
		 var atbranchintime=$('#atbranchtimein').jqxDateTimeInput('getDate');
		 var atbranchoutdate=$('#atbranchoutdate').jqxDateTimeInput('getDate');
		 var atbranchouttime=$('#atbranchouttime').jqxDateTimeInput('getDate');
		 var atbranchoutkm=parseFloat(document.getElementById("atbranchoutkm").value);
		 var atbranchinkm=parseFloat(document.getElementById("atbranchkmin").value);
		 
		 if(document.getElementById("cmbinbranch").value==""){
			 document.getElementById("errormsg").innerText="";
			 document.getElementById("errormsg").innerText="In Branch is Mandatory";
			 document.getElementById("cmbinbranch").focus();
			 return 0;
		 }
		 if(document.getElementById("cmbinlocation").value==""){
			 document.getElementById("errormsg").innerText="";
			 document.getElementById("errormsg").innerText="In Location is Mandatory";
			 document.getElementById("cmbinlocation").focus();
			 return 0;
		 }
		 if(atbranchindate==null){
			 document.getElementById("errormsg").innerText="";
			 document.getElementById("errormsg").innerText="In Date is Mandatory";
			 $('#atbranchdatein').jqxDateTimeInput('focus');
			 return 0;
		 }
		 var atbranchindateval=funDateInPeriod($('#atbranchdatein').jqxDateTimeInput('getDate'));
			if(atbranchindateval==0){
				$('#atbranchdatein').jqxDateTimeInput('focus');
				return false;
			}
			else{
				document.getElementById("errormsg").innerText="";
			}
		 if(atbranchintime==null){
			 document.getElementById("errormsg").innerText="";
			 document.getElementById("errormsg").innerText="In Time is Mandatory";
			 $('#atbranchtimein').jqxDateTimeInput('focus');
			 return 0;
		 }
		 atbranchindate.setHours(0,0,0,0);
		 if(atbranchindate<dateout){
			 document.getElementById("errormsg").innerText="";
			 document.getElementById("errormsg").innerText="In Date Cannot be less than Agreement Date";
			 $('#atbranchdatein').jqxDateTimeInput('focus');
			 return 0;
		 }
		 if(atbranchindate-dateout==0){
			 if(atbranchintime.getHours()<timeout.getHours()){
				 document.getElementById("errormsg").innerText="";
				 document.getElementById("errormsg").innerText="In Time Cannot be less than Agreement Time";
				 $('#atbranchtimein').jqxDateTimeInput('focus');
				 return 0;
			 }
			 else if(atbranchintime.getHours()==timeout.getHours()){
				 if(atbranchintime.getMinutes()<timeout.getMinutes()){
					 document.getElementById("errormsg").innerText="";
					 document.getElementById("errormsg").innerText="In Time Cannot be less than Agreement Time";
					 $('#atbranchtimein').jqxDateTimeInput('focus');
					 return 0;	 
				 }
			 }
		 }
		 
		 
			 if(atbranchoutdate==null){
				 document.getElementById("errormsg").innerText="";
				 document.getElementById("errormsg").innerText="Out Date is Mandatory";
				 $('#atbranchoutdate').jqxDateTimeInput('focus');
				 return 0;
			 }
				var atbranchoutdateval=funDateInPeriod($('#atbranchoutdate').jqxDateTimeInput('getDate'));
				if(atbranchoutdateval==0){
					$('#atbranchoutdate').jqxDateTimeInput('focus');
					return false;
				}
				else{
					document.getElementById("errormsg").innerText="";
				}
			 if(atbranchouttime==null){
				 document.getElementById("errormsg").innerText="";
				 document.getElementById("errormsg").innerText="Out Time is Mandatory";
				 document.getElementById("atbranchouttime").focus();
				 return 0;
			 }
			 atbranchoutdate.setHours(0,0,0,0);
		 if(atbranchinkm<outkm){
			 document.getElementById("errormsg").innerText="";
			 document.getElementById("errormsg").innerText="In Km cannot be less than Agreement km";
			 document.getElementById("atbranchkmin").focus();
			 return 0;
		 }
		 if(document.getElementById("cmbatbranchinfuel").value==""){
			 document.getElementById("errormsg").innerText="";
			 document.getElementById("errormsg").innerText="Please Select In Fuel";
			 document.getElementById("cmbatbranchinfuel").focus();
			 return 0;
		 }
		
		 
		 if(document.getElementById("atbranchoutfleetno").value==""){
			 document.getElementById("errormsg").innerText="";
			 document.getElementById("errormsg").innerText="Out Fleet is Mandatory";
			 document.getElementById("cmbatbranchinfuel").focus();
			 return 0;
		 }
		 
		 
		if(atbranchoutdate<atbranchindate){
			document.getElementById("errormsg").innerText="";
			 document.getElementById("errormsg").innerText="New Vehicle Out Date Cannot be less than Vehicle In Date";
			 $('#atbranchoutdate').jqxDateTimeInput('focus');
			 return 0;
		} 
		if(atbranchoutdate-atbranchindate==0){
			if(atbranchouttime.getHours()<atbranchintime.getHours()){
				document.getElementById("errormsg").innerText="";
				 document.getElementById("errormsg").innerText="New Vehicle Out Time Cannot be less than Vehicle In Time";
				 $('#atbranchouttime').jqxDateTimeInput('focus');
				 return 0;
			}
			else if(atbranchouttime.getHours()==atbranchintime.getHours()){
				if(atbranchouttime.getMinutes()<atbranchintime.getMinutes()){
					document.getElementById("errormsg").innerText="";
					 document.getElementById("errormsg").innerText="New Vehicle Out Time Cannot be less than Vehicle In Time";
					 $('#atbranchouttime').jqxDateTimeInput('focus');
					 return 0;
				}
			}
		}
		
	}
	 	else if(document.getElementById("chkcollection").checked==true){
	 		if(document.getElementById("coloutfleetno").value==""){
	 			document.getElementById("errormsg").innerText="";
	 			document.getElementById("errormsg").innerText="Out Fleet is Mandatory";
	 			document.getElementById("coloutfleetno").focus();
	 			return 0;
	 		}
	 		var coloutdate=$('#coloutdate').jqxDateTimeInput('getDate');
	 		var colouttime=$('#colouttime').jqxDateTimeInput('getDate');
	 		var coloutkm=parseFloat(document.getElementById("coloutkm").value);
	 		if(coloutdate==null){
	 			document.getElementById("errormsg").innerText="";
				 document.getElementById("errormsg").innerText="Vehicle Out Date is Mandatory";
				 $('#coloutdate').jqxDateTimeInput('focus');
				 return 0;
	 		}
	 		
	 		var coloutdateval=funDateInPeriod($('#coloutdate').jqxDateTimeInput('getDate'));
			if(coloutdateval==0){
				$('#coloutdate').jqxDateTimeInput('focus');
				return false;
			}
			else{
				document.getElementById("errormsg").innerText="";
			}
	 		coloutdate.setHours(0,0,0,0);
	 		if(colouttime==null){
	 			document.getElementById("errormsg").innerText="";
				 document.getElementById("errormsg").innerText="Vehicle Out Time is Mandatory";
				 $('#colouttime').jqxDateTimeInput('focus');
				 return 0;
	 		}
	 		if(coloutdate<dateout){
	 			document.getElementById("errormsg").innerText="";
				 document.getElementById("errormsg").innerText="Vehicle Out Date cannot be less than Agreement Date";
				 $('#coloutdate').jqxDateTimeInput('focus');
				 return 0;
	 		}
	 		if(coloutdate-dateout==0){
	 			if(colouttime.getHours()<timeout.getHours()){
	 				document.getElementById("errormsg").innerText="";
					 document.getElementById("errormsg").innerText="Vehicle Out Time cannot be less than Agreement Time";
					 $('#colouttime').jqxDateTimeInput('focus');
					 return 0;
	 			}
	 			else if(colouttime.getHours()==timeout.getHours()){
	 				if(colouttime.getMinutes()<timeout.getMinutes()){
	 					document.getElementById("errormsg").innerText="";
						 document.getElementById("errormsg").innerText="Vehicle Out Time cannot be less than Agreement Time";
						 $('#colouttime').jqxDateTimeInput('focus');
						 return 0;
	 				}
	 			}
	 			
	 		}
	 		
	 	}
	
	if(document.getElementById("chkatbranch").checked==true){
		$('#cmbreplacetype').val('atbranch');
		
	}
	else if(document.getElementById("chkcollection").checked==true){
		$('#cmbreplacetype').val('collection');
	}

	
	$('#dateout').jqxDateTimeInput({ disabled: false});
	$('#timeout').jqxDateTimeInput({ disabled: false});
	$('#cmbfuel').prop('disabled',false);
	if(document.getElementById("chkatbranch").checked==true){
		$('#atbranchoutkm').prop('disabled',false);
		$('#cmbatbranchoutfuel').prop('disabled',false);	
	}
	if(document.getElementById("chkcollection").checked==true){
		document.getElementById("coloutkm").disabled=false;
		$('#cmbcoloutfuel').prop('disabled',false);	
	}
	//alert("55555");
	 	return 1;
	 	
}
function funFocus(){
	$('#date').jqxDateTimeInput('focus'); 
}
function funChkButton(){
	
}
function changeAtbranch(){
	if(document.getElementById("chkatbranch").checked==true){
		/* $('#collectionfield').children().prop('disabled',true);  */
		$('#collectionfield').prop('disabled',true);
		if($('#atbranchfield').prop('disabled')==true){
			$('#atbranchfield').prop('disabled',false);
		}
		if(document.getElementById("chkcollection").checked==true){
			document.getElementById("chkcollection").checked=false;
		}
		
	}
	if(document.getElementById("chkatbranch").checked==false){
		$('#collectionfield').prop('disabled',false);
	}
	
}
function changeCollection(){
	if(document.getElementById("chkcollection").checked==true){
		/* $('#collectionfield').children().prop('disabled',true);  */
		$('#atbranchfield').prop('disabled',true);
		if($('#collectionfield').prop('disabled')==true){
			$('#collectionfield').prop('disabled',false);
		}
		if(document.getElementById("chkatbranch").checked==true){
			document.getElementById("chkatbranch").checked=false;
		}
		checkCollect();
		checkDelivery();
		if(document.getElementById("mode").value=="A"){
			document.getElementById("chkcollect").disabled=true;
			document.getElementById("chkdelivery").disabled=true;
			document.getElementById("cmbcolinbranch").disabled=true;
			document.getElementById("cmbcolinlocation").disabled=true;
			document.getElementById("colinkm").disabled=true;
			document.getElementById("cmbcolinfuel").disabled=true;
			$('#colindate').jqxDateTimeInput({ disabled: true});
			$('#colintime').jqxDateTimeInput({ disabled: true});
		}
		
	}
	if(document.getElementById("chkcollection").checked==false){
		$('#atbranchfield').prop('disabled',false);
	}
}

function funSearchLoad(){
		 changeContent('mainSearch.jsp'); 
	}
	
	function funUpdate(){
		document.getElementById("btnUpdate").style.display="none";
		document.getElementById("btnUpdateSave").style.display="block";
		funReadOnly();
		//$('#collectfield').prop('disabled',true);
		$('#colcollectdriver').prop('disabled',true);
		$('#colcollectkm').prop('disabled',true);
		$('#cmbcolcollectfuel').prop('disabled',true);
		$('#colcollectdate').jqxDateTimeInput({ disabled: true});
		$('#colcollecttime').jqxDateTimeInput({ disabled: true});
		
		$('#deliveryfield').prop('disabled',true);
		$('#colindate').jqxDateTimeInput({ disabled: false});
		$('#colintime').jqxDateTimeInput({ disabled: false});
		document.getElementById("chkcollect").checked=true;
		document.getElementById("chkdelivery").checked=true;
		checkCollect();
		checkDelivery();
		$('#cmbcolinbranch').prop('disabled',false);
		$('#cmbcolinlocation').prop('disabled',false);
		$('#colinkm').prop('disabled',false);
		$('#cmbcolinfuel').prop('disabled',false);
		$('#colinkm').prop('readonly',false);
		$('#cmbreplacetype').prop('disabled',false);
	
	}
	function funUpdateSave(){
		if(document.getElementById("chkcollect").checked==true){
			document.getElementById("hidchkcollect").value="1";
		}
		else{
			document.getElementById("hidchkcollect").value="0";
		}
		if(document.getElementById("chkdelivery").checked==true){
			document.getElementById("hidchkdelivery").value="1";
		}
		else{
			document.getElementById("hidchkdelivery").value="0";
		}
		var outdate=$('#dateout').jqxDateTimeInput('getDate');
		var outtime=$('#timeout').jqxDateTimeInput('getDate');
		outdate.setHours(0,0,0,0);
		var outkm=parseFloat(document.getElementById("outkm").value);
		var colindate=$('#colindate').jqxDateTimeInput('getDate');
		var colintime=$('#colintime').jqxDateTimeInput('getDate');
		var colinkm=parseFloat(document.getElementById("colinkm").value);
		
		if(colindate==null){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="In Date is Mandatory";
			$('#colindate').jqxDateTimeInput('focus');
			return false;
			
		}
		
		var colindateval=funDateInPeriod($('#colindate').jqxDateTimeInput('getDate'));
		if(colindateval==0){
			$('#colindate').jqxDateTimeInput('focus');
			return false;
		}
		else{
			document.getElementById("errormsg").innerText="";
		}
		if(colintime==null){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="In Date is Mandatory";
			$('#colintime').jqxDateTimeInput('focus');
			return false;
		}
		
		if(colindate<outdate){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="In Date cannot be less than Agreement Date";
			$('#colindate').jqxDateTimeInput('focus');
			return false;
		}
		if(colindate-outdate==0){
			if(colintime.getHours()<outtime.getHours()){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="In Time cannot be less than Agreement Time";
				$('#colintime').jqxDateTimeInput('focus');
				return false;
			}
			else if(colintime.getHours()==outtime.getHours()){
				if(colintime.getMinutes()<outtime.getMinutes()){
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="In Time cannot be less than Agreement Time";
					$('#colintime').jqxDateTimeInput('focus');
					return false;
				}
			}
		}
		if(colinkm==""){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="In Km cannot be Empty";
			document.getElementById("colinkm").focus();
			return false;
		}
		if(colinkm<outkm){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="In Km cannot be less than Agreement Km";
			document.getElementById("colinkm").focus();
			return false;
		}
		if(document.getElementById("cmbcolinfuel").value==""){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Please Select In Fuel";
			document.getElementById("cmbcolinfuel").focus();
			return false;
		}
		
		if(document.getElementById("chkcollect").checked==true){
			if(document.getElementById("colcollectdriver").value==""){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Collection Driver is Mandatory";
				document.getElementById("colcollectdriver").focus();
				return false;
			}
			var colcollectdate=$('#colcollectdate').jqxDateTimeInput('getDate');
			var colcollecttime=$('#colcollecttime').jqxDateTimeInput('getDate');
			var colcollectkm=parseFloat(document.getElementById("colcollectkm").value);
			/* var outkm=parseFloat() */
			if(colcollectdate==null){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Collection Date is Mandatory";
				$('colcollectdate').jqxDateTimeInput('focus');
				return false;
			}
			
			var colcollectdateval=funDateInPeriod($('#colcollectdate').jqxDateTimeInput('getDate'));
			if(colcollectdateval==0){
				$('#colcollectdate').jqxDateTimeInput('focus');
				return false;
			}
			else{
				document.getElementById("errormsg").innerText="";
			}
			if(colcollecttime==null){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Collection Time is Mandatory";
				$('colcollecttime').jqxDateTimeInput('focus');
				return false;
			}
			colcollectdate.setHours(0,0,0,0);
			if(colindate<colcollectdate){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="In Date  cannot be less than Collection Date";
				$('colindate').jqxDateTimeInput('focus');
				return false;
			}
			if(colindate-colcollectdate==0){
				if(colintime.getHours()<colcollecttime.getHours()){
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="In Time  cannot be less than Collection Time";
					$('colintime').jqxDateTimeInput('focus');
					return false;
				}
				if(colintime.getHours()==colcollecttime.getHours()){
					if(colintime.getMinutes()<colcollecttime.getMinutes()){
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="In Time  cannot be less than Collection Time";
					$('colintime').jqxDateTimeInput('focus');
					return false;
					}
					if(colintime.getMinutes()==colcollecttime.getMinutes()){
						document.getElementById("errormsg").innerText="";
						document.getElementById("errormsg").innerText="In Time  cannot be same as Collection Time";
						$('#colintime').jqxDateTimeInput('focus');
						return false;	
					}
				}
			}
			if(colinkm<colcollectkm){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="In Km cannot be less than Collection Km";
				document.getElementById("colinkm").focus();
				return false;
			}
			if(document.getElementById("cmbcolinfuel").value==""){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Please Select Collection Fuel";
				document.getElementById("cmbcolcollectfuel").focus();
				return false;
			}
		}
		if(document.getElementById("chkdelivery").checked==true){
			
			var coldeldate=$('#coldeldate').jqxDateTimeInput('getDate');
			var coldeltime=$('#coldeltime').jqxDateTimeInput('getDate');
			var coloutdate=$('#coloutdate').jqxDateTimeInput('getDate');
			var colouttime=$('#colouttime').jqxDateTimeInput('getDate');
			var coldelkm=parseFloat(document.getElementById("coldelkm").value);
			var coloutkm=parseFloat(document.getElementById("coloutkm").value);
			coloutdate.setHours(0,0,0,0);
			if(document.getElementById("coldeldriver").value==""){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Delivery Driver is Mandatory";
				document.getElementById("coldeldriver").focus();
				return false;
			}
			if(coldeldate==null){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Delivery Date is Mandatory";
				$('#coldeldate').jqxDateTimeInput('focus');
				return false;
			}
			
			var coldeldateval=funDateInPeriod($('#coldeldate').jqxDateTimeInput('getDate'));
			if(coldeldateval==0){
				$('#coldeldate').jqxDateTimeInput('focus');
				return false;
			}
			else{
				document.getElementById("errormsg").innerText="";
			}
			if(coldeltime==null){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Delivery Time is Mandatory";
				$('#coldeltime').jqxDateTimeInput('focus');
				return false;
			}
			coldeldate.setHours(0,0,0,0);
			if(coldeldate<coloutdate){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Delivery Date cannot be less than Vehicle Out Date";
				$('#coldeldate').jqxDateTimeInput('focus');
				return false;
			}
			if(coldeldate-coloutdate==0){
				if(coldeltime.getHours()<colouttime.getHours()){
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="Delivery Time cannot be less than Vehicle Out Time";
					$('#coldeltime').jqxDateTimeInput('focus');
					return false;	
				}
				else if(coldeltime.getHours()==colouttime.getHours()){
					if(coldeltime.getMinutes()<colouttime.getMinutes()){
						document.getElementById("errormsg").innerText="";
						document.getElementById("errormsg").innerText="Delivery Time cannot be less than Vehicle Out Time";
						$('#coldeltime').jqxDateTimeInput('focus');
						return false;	
					}
					if(coldeltime.getMinutes()==colouttime.getMinutes()){
						document.getElementById("errormsg").innerText="";
						document.getElementById("errormsg").innerText="Delivery Time cannot be same as Vehicle Out Time";
						$('#coldeltime').jqxDateTimeInput('focus');
						return false;	
					}
					
				}
				
			}
			if(coldelkm==""){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Delivery Km is Mandatory";
				document.getElementById("coldelkm").focus();
				return false;	
			}
			if(coldelkm<coloutkm){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Delivery Km cannot be less than Vehicle Out Km";
				document.getElementById("coldelkm").focus();
				return false;	
			}
			if(document.getElementById("cmbcoldelfuel").value==""){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Please Select Delivery Fuel";
				document.getElementById("cmbcoldelfuel").focus();
				return false;
			}
			
		}
		/* alert(document.getElementById("status").value);
		alert(document.getElementById("mode").value); */
		/* if(document.getElementById("status").value!="close"){
			/* alert("inside"); 
				
		} */
		
		$('#coloutdate').jqxDateTimeInput({ disabled: false});
		$('#colouttime').jqxDateTimeInput({ disabled: false});
		$('#refdate').jqxDateTimeInput({ disabled: false});
		$('#cmbrentaltype').prop('disabled',false);
		$('#cmbtrreason').prop('disabled',false);
		document.getElementById("mode").value="E";
	$('#btnSave').mousedown(); 
		document.getElementById("btnUpdate").disabled=true;
		//document.getElementById("mode").value="View";
	 /* 	$.messager.confirm('Confirm', 'Do you Want to Save Changes', function(r){
			if (r){
				
				 $('#cmbinlocation').prop('disabled',false);
				$('#cmbcolinbranch').prop('disabled',false); 
				document.getElementById("frmReplacementNew").submit();
				
			}
	 		});  */
	}
	
	
	function checkCollect(){
		if(document.getElementById("chkcollect").checked==true){
			$('#colcollectdriver').prop('disabled',false);
			$('#colcollectkm').prop('disabled',false);
			$('#cmbcolcollectfuel').prop('disabled',false);
			$('#colcollectdate').jqxDateTimeInput({ disabled: false});
			$('#colcollecttime').jqxDateTimeInput({ disabled: false});
			$('#colcollectkm').prop('readonly',false);
			
		}
		else{
			$('#colcollectdriver').prop('disabled',true);
			$('#colcollectkm').prop('disabled',true);
			$('#cmbcolcollectfuel').prop('disabled',true);
			$('#colcollectdate').jqxDateTimeInput({ disabled: true});
			$('#colcollecttime').jqxDateTimeInput({ disabled: true});
		
		}
		
	}
	function checkDelivery(){
		if(document.getElementById("chkdelivery").checked==true){
			$('#deliveryfield').prop('disabled',false);
			$('#cmbcoldelfuel').prop('disabled',false);
			$('#coldeldate').jqxDateTimeInput({ disabled: false});
			$('#coldeltime').jqxDateTimeInput({ disabled: false});
			$('#coldelkm').prop('readonly',false);
			$('#coldeliveryto').prop('readonly',false);
		}
		else{
			$('#deliveryfield').prop('disabled',true);
			$('#coldeldate').jqxDateTimeInput({ disabled: true});
			$('#coldeltime').jqxDateTimeInput({ disabled: true});
		}
	}
	function funResetValues(){
		$('#refdate').jqxDateTimeInput('setDate', null);
 		$('#dateout').jqxDateTimeInput('setDate', null);
 		$('#timeout').jqxDateTimeInput('setDate', null);
 		$('#atbranchdatein').jqxDateTimeInput('setDate', null);
 		$('#atbranchtimein').jqxDateTimeInput('setDate', null);
 		$('#atbranchoutdate').jqxDateTimeInput('setDate', null);
 		$('#atbranchouttime').jqxDateTimeInput('setDate', null);
 		$('#coloutdate').jqxDateTimeInput('setDate', null);
 		$('#colouttime').jqxDateTimeInput('setDate', null);
 		$('#colcollectdate').jqxDateTimeInput('setDate', null);
 		$('#colcollecttime').jqxDateTimeInput('setDate', null);
 		$('#coldeldate').jqxDateTimeInput('setDate', null);
 		$('#coldeltime').jqxDateTimeInput('setDate', null);
 		$('#colindate').jqxDateTimeInput('setDate', null);
 		$('#colintime').jqxDateTimeInput('setDate', null);
 		$('#refno').val('');
 		$('#hidtimeout').val('');
		$('#hiddateout').val('');
		$('#hidatbranchdatein').val('');
		$('#hidatbranchtimein').val('');
		$('#hidatbranchoutdate').val('');
		$('#atbranchouttime').val('');
		$('#hidcoloutdate').val('');
		$('#hidcolouttime').val('');
		$('#hidcolcollectdate').val('');
		$('#hidcolcollecttime').val('');
		$('#hidcoldeldate').val('');
		$('#hidcoldeltime').val('');
		$('#hidcolindate').val('');
		$('#hidcolintime').val('');
	
			$('#refname').val('');
			$('#txtfleetno').val('');
			$('#txtfleetname').val('');
			$('#outkm').val('');
			$('#txtbranch').val('');
			$('#txtlocation').val('');
			$('#user').val('');
			$('#atbranchoutuser').val('');
			$('#cmbinbranch').val('');
			$('#hidcmbinbranch').val('');
			$('#cmbinlocation').val('');
			$('#hidcmbinlocation').val('');
			$('#atbranchinkm').val('');
			$('#cmbatbranchinfuel').val('');
			$('#hidcmbatbranchinfuel').val('');
			$('#atbranchoutfleetno').val('');
			$('#atbranchoutfleetname').val('');
			$('#atbranchoutbranch').val('');
			$('#hidatbranchoutbranch').val('');
			$('#atbranchoutlocation').val('');
			$('#hidatbranchoutlocation').val('');
			$('#atbranchoutkm').val('');
			$('#cmbatbranchoutfuel').val('');
			$('#hidcmbatbranchoutfuel').val('');
			$('#coloutfleetno').val('');
			$('#coloutfleetname').val('');
			$('#coloutbranch').val('');
			$('#coloutlocation').val('');
			$('#coloutuser').val('');
			$('#coloutkm').val('');
		$('#cmbcoloutfuel').val('');
		$('#hidcmbcoloutfuel').val('');
		$('#colcollectdriver').val('');
		$('#colcollectkm').val('');
		$('#cmbcolcollectfuel').val('');
		$('#hidcmbcolcollectfuel').val('');
		$('#coldeldriver').val('');
		$('#coldelkm').val('');
		$('#cmbcoldelfuel').val('');
		$('#hidcmbcoldelfuel').val('');
		$('#cmbcolinbranch').val('');
		$('#hidcmbcolinbranch').val('');
		$('#cmbcolinlocation').val('');
		$('#hidcmbcolinlocation').val('');
		$('#colinkm').val('');
		$('#cmbcolinfuel').val('');
		$('#hidcmbcolinfuel').val('');
		$('#coldeliveryto').val('');
		//$('#cmbinlocation').val('');
	}
	
	
	
	
	
 	function funPrintBtn(){
		 /*   if (($("#mode").val() == "view") && $("#docno").val()!="") { */
		  
		      
		   var url=document.URL;

		 
	    var reurl=url.split("saveReplacementNew");

	 var win= window.open(reurl[0]+"printReplacementNew?docno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	win.focus(); 
		   /* } 
		  
		   else {
	 	      $.messager.alert('Message','Select a Document....!','warning');
	 	      return false;
	 	     } */
	 	
		} 
 	
 	
 	 $(function(){
	        $('#frmReplacementNew').validate({
	                 rules: {
	                cmbtrreason:"required",
	                cmbreplacetype:"required",
	                refno:"required",
	                txtoutfleetno:"required",
	                cmbrentaltype:"required",
	               description:{
	                	 maxlength:250
	                 }
	        		
	                 },
	                 messages: {
	                	 cmbtrreason:" *",
	                	 cmbreplacetype:" *",
	                	 refno:" *",
	                	 txtoutfleetno:" *",
	                	 cmbrentaltype:" *",
	                	description:{
		                	 maxlength:"max 250 chars"
		                 }
	        
	                 }
	        });});
  	
</script>
</head>

<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmReplacementNew" action="saveReplacementNew" autocomplete="off">
	<%-- <script>
			window.parent.formName.value="Replacement";
			window.parent.formCode.value="RPL";
	</script> --%>
	<jsp:include page="../../../../header.jsp" />
	<%-- <div id='reftime' name='reftime' value='<s:property value="reftime"/>'></div> --%>
	<br/>
<div class='hidden-scrollbar'>
<fieldset>
      <legend>Vehicle Info As In Agreement</legend>
      <table width="100%" >
        <tr>
          <td align="right">Date</td>
          <td width="7%"><div id="date" name="date" value='<s:property value="date"/>'></div>
		    </td><input type="hidden" id="hidddate" name="hidddate" value='<s:property value="hidddate"/>'/>
          <td width="6%" align="right">Rental Type</td>
          <td width="7%"><select id="cmbrentaltype" name="cmbrentaltype" value='<s:property value="cmbrentaltype"/>'>
            <option value="">--Select--</option><option value="RAG">Rental</option><option value="LAG">Lease</option>
          </select></td>
          <td width="5%" align="right">Branch</td>
          <td width="8%" align="left"><select name="cmbagmtbranch" id="cmbagmtbranch" value='<s:property value="cmbagmtbranch" />' style="width:98%;"><option value="">--Select--</option></select></td>
          <input type="hidden" name="hidcmbagmtbranch" id="hidcmbagmtbranch" value='<s:property value="hidcmbagmtbranch" />' >
          <td align="right">Ref No</td>
          <td align="left"><input type="text" id="refvocno" name="refvocno" value='<s:property value="refvocno"/>' placeholder="Press F3 to Search" readonly onKeyDown="getAgmtno(event);"/></td>
          <td colspan="2" align="left"><input type="text" id="refname" name="refname" style="width:100%;" value='<s:property value="refname"/>' readonly/></td>
          <input type="hidden" id="hidcmbrentaltype" name="hidcmbrentaltype" value='<s:property value="hidcmbrentaltype"/>'/>
          <input type="hidden" id="hidrefdate" name="hidrefdate" value='<s:property value="hidrefdate"/>'/>
          <td width="5%" align="right">Ref Date</td>
          <td width="8%" align="left"><div id='refdate' name='refdate' value='<s:property value="refdate"/>'></div></td>
          <input type="hidden" id="hidreftime" name="hidreftime" value='<s:property value="hidreftime"/>'/>
          <td align="right">Doc No</td>
          <td colspan="2"><input type="text" id="docno" name="docno" tabindex="-1" readonly value='<s:property value="docno"/>'/></td>
        </tr>
        <tr>
          <td width="6%" align="right">Fleet No</td>
          <td colspan="5" align="left"><input type="text" id="txtfleetno" name="txtfleetno" value='<s:property value="txtfleetno"/>' readonly />
            <input type="text" id="txtfleetname" name="txtfleetname" style="width:71%;" value='<s:property value="txtfleetname"/>' readonly/></td>
          <td width="6%" align="right">Date Out</td>
          <td width="8%" align="left"><div id="dateout" name="dateout" value='<s:property value="dateout"/>'></div></td>
          <input type="hidden" name="hiddateout" id="hiddateout" value='<s:property value="hiddateout"/>'/>
          <td width="11%" align="right">Time Out</td>
          <td width="10%" align="left"><div id="timeout" name="timeout" value='<s:property value="timeout"/>'></div></td>
          <input type="hidden" id="hidtimeout" name="hidtimeout" value='<s:property value="hidtimeout"/>'/>
          <td align="right">Km Out</td>
          <td align="left"><input type="text" id="outkm" name="outkm" style="width:68%;" value='<s:property value="outkm"/>' readonly onkeypress="javascript:return isNumber (event,id)"/></td>
         
          <td width="4%" align="right">Fuel</td>
          <td width="9%" align="left"><select id="cmbfuel" name="cmbfuel" value='<s:property value="cmbfuel"/>'>
            <option value="">--Select--</option><option value=0.000>Level 0/8</option><option value=0.125>Level 1/8</option><option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option><option value=0.500>Level 4/8</option>
    <option value=0.625>Level 5/8</option><option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
          </select></td>
            <input type="hidden" id="hidcmbfuel" name="hidcmbfuel" value='<s:property value="hidcmbfuel"/>'/>
        </tr>
        <tr>
          <td align="right">Branch</td>
          <td colspan="3" align="left"><input type="text" name="txtbranch" id="txtbranch" readonly value='<s:property value="txtbranch"/>'/></td>
             <input type="hidden" id="hidtxtbranch" name="hidtxtbranch" value='<s:property value="hidtxtbranch"/>'/>
          <td align="right">Location</td>
          <td align="left"><input type="text" name="txtlocation" id="txtlocation" readonly value='<s:property value="txtlocation"/>'/></td>
           <input type="hidden" name="hidtxtlocation" id="hidtxtlocation" value='<s:property value="hidtxtlocation"/>'/>
          <td align="right">Tr. Reason</td>
          <td align="left"><select id="cmbtrreason" name="cmbtrreason" style="width:95%;" value='<s:property value="cmbtrreason"/>'>
            <option value="">--Select--</option>
          </select></td>
          <td align="right">Description</td>
          <td colspan="6" align="left"><input type="text" name="description" id="description" value='<s:property value="description"/>' style="width:100%;"/></td>   
          <!-- <td align="right"></td> -->
          <td><!--<select name="cmbreplacetype" id="cmbreplacetype" style="width:95%;" onchange="checkReplace();">
            <option value="">--Select--</option>
            <option value="atbranch">At Branch</option>
            <option value="collection">Collection</option>
          </select>--></td>
          <input type="hidden" id="hidcmbtrreason" name="hidcmbtrreason" value='<s:property value="hidcmbtrreason"/>'/>
         <!--  <td align="right">&nbsp;</td> -->
           <td  align="center"><i><b><label id="lblcancelstatus"  name="lblcancelstatus"   style="font-size: 13px;font-family: Tahoma; color:#6000FC"></label></b></i></td>
          <input type="hidden" name="hiduser" id="hiduser" value='<s:property value="hiduser"/>'/>
          <input type="hidden" name="hidcmbreplacetype" id="hidcmbreplacetype" value='<s:property value="hidcmbreplacetype"/>' />
         
        </tr>
       <!--  <tr>
         
          <td align="right"></td>
          <td>&nbsp;</td>
          <td align="right">&nbsp;</td>
          <td>&nbsp;</td>
          <td align="right">&nbsp;</td>
          <td align="left">&nbsp;</td>
        </tr> -->
      </table>
    </fieldset>
    
    
    <table width="100%">
  <tr>
    <td width="50%"><div id="atbranchdiv">
    <fieldset id="atbranchfield"><legend><input type="checkbox" name="chkatbranch" id="chkatbranch" onchange="changeAtbranch();"><label for="chkatbranch"><b>At Branch</b></label></legend>
    <table width="100%">
  <tr>
    <td>
    <fieldset style="background-color:#ECF8E0;"><legend><b>In Info</b></legend>
    <table width="100%">
  <tr>
    <td width="6%" align="right">Branch</td>
    <td width="12%" align="left"><select name="cmbinbranch" id="cmbinbranch" value='<s:property value="cmbinbranch"/>' style="width:99%;" onchange="getLoc(this.value);"><option value="">--Select--</option></select></td>
    <input type="hidden" name="hidcmbinbranch" id="hidcmbinbranch" value='<s:property value="hidcmbinbranch"/>'>
    <td width="18%" align="right">Location</td>
    <td width="16%" align="left"><select name="cmbinlocation" id="cmbinlocation" value='<s:property value="cmbinlocation"/>'><option value="">--Select--</option></select></td>
    <input type="hidden" name="hidcmbinlocation" id="hidcmbinlocation" value='<s:property value="hidcmbinlocation"/>'>
    <td width="11%" align="right">User</td>
    <td width="16%" align="left"><input type="text" name="inuser" id="inuser" value='<s:property value="inuser"/>' style="text-transform:uppercase;"></td>
    <input type="hidden" name="hidinuser" id="hidinuser" value='<s:property value="hidinuser"/>'>
    <td width="9%">&nbsp;</td>
    <td width="12%">&nbsp;</td>
  </tr>
  <tr>
    <td align="right">Date</td>
    <td align="left"><div id="atbranchdatein" name="atbranchdatein" value='<s:property value="atbranchdatein"/>'></div></td>
    <input type="hidden" name="hidatbranchdatein" id="atbranchdatein" value='<s:property value="hidatbranchdatein"/>'>
    <td align="right">Time</td>
    <input type="hidden" name="hidatbranchtimein" id="hidatbranchtimein" value='<s:property value="hidatbranchtimein"/>'>
    <td align="left"><div id="atbranchtimein" name="atbranchtimein" value='<s:property value="atbranchtimein"/>' ></div></td>
    <td align="right">KM</td>
    <td align="left"><input type="text" name="atbranchkmin" id="atbranchkmin" value='<s:property value="atbranchkmin"/>'></td>
    <td align="right">Fuel</td>
    <td align="left"><select name="cmbatbranchinfuel" id="cmbatbranchinfuel" value='<s:property value="cmbatbranchinfuel"/>'>
    <option value="">--Select--</option>
    <option value=0.000>Level 0/8</option>
    <option value=0.125>Level 1/8</option>
    <option value=0.250>Level 2/8</option>
    <option value=0.375>Level 3/8</option>
    <option value=0.500>Level 4/8</option>
    <option value=0.625>Level 5/8</option>
    <option value=0.750>Level 6/8</option>
    <option value=0.875>Level 7/8</option>
    <option value=1.000>Level 8/8</option></select></td>
    <input type="hidden" name="hidcmbatbranchinfuel" id="hidcmbatbranchinfuel" value='<s:property value="hidcmbatbranchinfuel"/>'>
  </tr>
</table>
</fieldset>
</td>
    </tr>
  <tr>
    <td><fieldset style="background-color:#F7F2E0;"><legend><b>Out Info</b></legend><table width="100%">
  <tr>
    <td width="8%" align="right">Fleet</td>
    <td width="23%" align="left"><input type="text" name="atbranchoutfleetno" id="atbranchoutfleetno" value='<s:property value="atbranchoutfleetno"/>' placeholder="Press F3 to Search" readonly onkeydown="getAtbranchOutFleet(event);"></td>
    
    <td colspan="6" align="left"><input type="text" name="atbranchoutfleetname" id="atbranchoutfleetname" value='<s:property value="atbranchoutfleetname"/>' style="width:95%;" readonly tabindex="-1"></td>
    <input type="hidden" name="hidatbranchoutbranch" id="hidatbranchoutbranch" value='<s:property value="hidatbranchoutbranch"/>'>
    <input type="hidden" name="hidatbranchoutuser" id="hidatbranchoutuser" value='<s:property value="hidatbranchoutuser"/>'>
  </tr>
  <tr>
    <td align="right">Branch</td>
    <td align="left"><input type="text" name="atbranchoutbranch" id="atbranchoutbranch" value='<s:property value="atbranchoutbranch"/>' readonly tabindex="-1"></td>
    <td width="10%" align="right">Location</td>
    <td width="3%" align="left"><input type="text" name="atbranchoutlocation" id="atbranchoutlocation" value='<s:property value="atbranchoutlocation"/>' readonly tabindex="-1"></td>
    <input type="hidden" name="hidatbranchoutlocation" id="hidatbranchoutlocation" value='<s:property value="hidatbranchoutlocation"/>'>
    <td width="3%" align="right">User</td>
    <td width="23%" align="left"><input type="text" name="atbranchoutuser" id="atbranchoutuser" value='<s:property value="atbranchoutuser"/>' style="text-transform:uppercase;" readonly tabindex="-1"></td>
    <td width="6%">&nbsp;</td>
    <td width="24%">&nbsp;</td>
  </tr>
  <tr>
    <td align="right">Date</td>
    <td align="left"><div id="atbranchoutdate" name="atbranchoutdate" value='<s:property value="atbranchoutdate"/>'></div></td>
    <input type="hidden" name="hidatbranchoutdate" id="hidatbranchoutdate" value='<s:property value="hidatbranchoutdate"/>'>
    <td align="right">Time</td>
    <td align="left"><div id="atbranchouttime" name="atbranchouttime" value='<s:property value="atbranchouttime"/>'></div></td>
    <input type="hidden" name="hidatbranchouttime" id="hidatbranchouttime" value='<s:property value="hidatbranchouttime"/>'>
    <td align="right">KM</td>
    <td align="left"><input type="text" name="atbranchoutkm" id="atbranchoutkm" value='<s:property value="atbranchoutkm"/>'></td>
    <td align="right">Fuel</td>
    <td align="left"><select name="cmbatbranchoutfuel" id="cmbatbranchoutfuel" value='<s:property value="cmbatbranchoutfuel"/>'>
    <option value="">--Select--</option>
    <option value=0.000>Level 0/8</option>
    <option value=0.125>Level 1/8</option>
    <option value=0.250>Level 2/8</option>
    <option value=0.375>Level 3/8</option>
    <option value=0.500>Level 4/8</option>
    <option value=0.625>Level 5/8</option>
    <option value=0.750>Level 6/8</option>
    <option value=0.875>Level 7/8</option>
    <option value=1.000>Level 8/8</option></select>
    
    </td>
    <input type="hidden" name="hidcmbatbranchoutfuel" id="hidcmbatbranchoutfuel" value='<s:property value="hidcmbatbranchoutfuel"/>'>
  </tr>
</table>
</fieldset>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br>
</td>
    </tr>

</table>

    </fieldset>
    </div>
    </td>
    <input type="hidden" name="hidchkcollection" id="hidchkcollection" >
    <td width="50%"><div id="collectiondiv">
        
    <fieldset id="collectionfield"><legend><input type="checkbox" name="chkcollection" id="chkcollection" onchange="changeCollection();"><label for="chkcollection"><b>Collection</b></label></legend>
    
    <table width="100%">
  <tr>
    <td>
    <fieldset style="background-color:#F7F2E0;"><legend><b>New Veh. going for Delivery</b></legend>
    <table width="100%">
  <tr>
    <td align="right">Fleet</td>
    <td align="left"><input type="text" name="coloutfleetno" id="coloutfleetno" value='<s:property value="coloutfleetno"/>' placeholder="Press F3 to Search" readonly onkeydown="getColOutFleet(event);"></td>
    
    <td colspan="6" align="left"><input type="text" name="coloutfleetname" id="coloutfleetname" value='<s:property value="coloutfleetname"/>' style="width:97%;" readonly tabindex="-1"></td>
    <input type="hidden" name="hidcoloutbranch" id="hidcoloutbranch" value='<s:property value="hidcoloutbranch"/>'>
    <input type="hidden" name="hidcoloutlocation" id="hidcoloutlocation" value='<s:property value="hidcoloutlocation"/>'>
    <input type="hidden" name="hidcoloutuser" id="hidcoloutuser" value='<s:property value="hidcoloutuser"/>'>
  </tr>
  <tr>
    <td align="right">Branch</td>
    <td align="left"><input type="text" name="coloutbranch" id="coloutbranch" value='<s:property value="coloutbranch"/>' readonly tabindex="-1"></td>
    <td align="right">Location</td>
    <td align="left"><input type="text" name="coloutlocation" id="coloutlocation" value='<s:property value="coloutlocation"/>' readonly tabindex="-1"></td>
    <td align="right">User</td>
    <td align="left"><input type="text" name="coloutuser" id="coloutuser" value='<s:property value="coloutuser"/>' style="text-transform:uppercase;" readonly tabindex="-1"></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="right">Date</td>
    <td align="left"><div id="coloutdate" name="coloutdate" value='<s:property value="coloutdate"/>'></div></td>
    <input type="hidden" name="hidcoloutdate" id="hidcoloutdate" value='<s:property value="hidcoloutdate"/>'>
    <td align="right">Time</td>
    <td align="left"><div id="colouttime" name="colouttime" value='<s:property value="colouttime"/>'></div></td>
    <input type="hidden" name="hidcolouttime" id="hidcolouttime" value='<s:property value="hidcolouttime"/>'>
    <td align="right">KM</td>
    <td align="left"><input type="text" name="coloutkm" id="coloutkm" value='<s:property value="coloutkm"/>'></td>
    <td align="right">Fuel</td>
    <td align="left"><select name="cmbcoloutfuel" id="cmbcoloutfuel" value='<s:property value="cmbcoloutfuel"/>'>
    <option value="">--Select--</option>
    <option value=0.000>Level 0/8</option>
    <option value=0.125>Level 1/8</option>
    <option value=0.250>Level 2/8</option>
    <option value=0.375>Level 3/8</option>
    <option value=0.500>Level 4/8</option>
    <option value=0.625>Level 5/8</option>
    <option value=0.750>Level 6/8</option>
    <option value=0.875>Level 7/8</option>
    <option value=1.000>Level 8/8</option></select>
    </td>
    <input type="hidden" name="hidcmbcoloutfuel" id="hidcmbcoloutfuel" value='<s:property value="hidcmbcoloutfuel"/>'>
  </tr>
</table>
</fieldset>
</td>
  </tr>
  <tr>
    <td>
        
    <fieldset style="background-color:#FFFAFA;" id="collectfield"><legend><input type="checkbox" name="chkcollect" id="chkcollect" onchange="checkCollect();"><label for="chkcollect"><b>Vehicle Recieved from Client</b></label></legend>
    <table width="100%">
  <tr>
  <input type="hidden" name="hidchkcollect" id="hidchkcollect" value='<s:property value="hidchkcollect"/>'>
    <td width="8%" align="right">Driver</td>
    <td width="19%" align="left"><input type="text" name="colcollectdriver" id="colcollectdriver" value='<s:property value="colcollectdriver"/>' placeholder="Press F3 to Search" readonly onkeydown="getDriver(event,1);"></td>
    <input type="hidden" name="hidcolcollectdriver" id="hidcolcollectdriver" value='<s:property value="hidcolcollectdriver"/>'>
    <td width="9%">&nbsp;</td>
    <td width="19%">&nbsp;</td>
    <td width="6%">&nbsp;</td>
    <td width="19%">&nbsp;</td>
    <td width="5%">&nbsp;</td>
    <td width="15%"><input type="button" name="btnUpdate" id="btnUpdate" value="Update" class="myButton" onclick="funUpdate();">
    <input type="button" name="btnUpdateSave" id="btnUpdateSave" value="Save" class="myButton" onclick="funUpdateSave();">
    </td>
  </tr>
  <tr>
    <td align="right">Date</td>
    <td align="left"><div id="colcollectdate" name="colcollectdate" value='<s:property value="colcollectdate"/>'></div></td>
    <input type="hidden" name="hidcolcollectdate" id="hidcolcollectdate" value='<s:property value="hidcolcollectdate"/>'>
    <td align="right">Time</td>
    <td align="left"><div id="colcollecttime" name="colcollecttime" value='<s:property value="colcollecttime"/>'></div></td>
    <input type="hidden" name="hidcolcollecttime" id="hidcolcollecttime" value='<s:property value="hidcolcollecttime"/>'>
    <td align="right">KM</td>
    <td align="left"><input type="text" name="colcollectkm" id="colcollectkm" value='<s:property value="colcollectkm"/>'></td>
    <td align="right">Fuel</td>
    <td align="left"><select name="cmbcolcollectfuel" id="cmbcolcollectfuel" value='<s:property value="cmbcolcollectfuel"/>'>
      <option value="">--Select--</option>
    <option value=0.000>Level 0/8</option>
    <option value=0.125>Level 1/8</option>
    <option value=0.250>Level 2/8</option>
    <option value=0.375>Level 3/8</option>
    <option value=0.500>Level 4/8</option>
    <option value=0.625>Level 5/8</option>
    <option value=0.750>Level 6/8</option>
    <option value=0.875>Level 7/8</option>
    <option value=1.000>Level 8/8</option></select>
    </td>
  </tr>
  <input type="hidden" name="hidcmbcolcollectfuel" id="hidcmbcolcollectfuel" value='<s:property value="hidcmbcolcollectfuel"/>'>
</table>
</fieldset>
</td>
  </tr>
  <tr>
    <td>
    <!-- <br><br><br><br> -->
    <br>
    <fieldset style="background-color:#e6e6fa;" id="deliveryfield"><legend><input type="checkbox" name="chkdelivery" id="chkdelivery" onchange="checkDelivery();"><label for="chkdelivery"><b>New Veh. handed over to Client</b></label></legend>
    <table width="100%">
  <tr>
  <input type="hidden" name="hidchkdelivery" id="hidchkdelivery" value='<s:property value="hidchkdelivery"/>'>
    <td align="right">Driver</td>
    <td align="left"><input type="text" name="coldeldriver" id="coldeldriver" value='<s:property value="coldeldriver"/>' placeholder="Press F3 to Search" onkeydown="getDriver(event,2);"></td>
    <input type="hidden" name="hidcoldeldriver" id="hidcoldeldriver" value='<s:property value="hidcoldeldriver"/>'>
    <td align="right">Deliver To</td>
    <td align="left"><input type="text" name="coldeliveryto" id="coldeliveryto" value='<s:property value="coldeliveryto"/>'></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="right">Date</td>
    <td align="left"><div id="coldeldate" name="coldeldate" value='<s:property value="coldeldate"/>'></div></td>
    <input type="hidden" name="hidcoldeldate" id="hidcoldeldate" value='<s:property value="hidcoldeldate"/>'>
    <td align="right">Time</td>
    <td align="left"><div id="coldeltime" name="coldeltime" value='<s:property value="coldeltime"/>'></div></td>
    <input type="hidden" name="hidcoldeltime" id="hidcoldeltime" value='<s:property value="hidcoldeltime"/>'>
    <td align="right">KM</td>
    <td align="left"><input type="text" name="coldelkm" id="coldelkm" value='<s:property value="coldelkm"/>'></td>
    <td align="right">Fuel</td>
    <td align="left"><select name="cmbcoldelfuel" id="cmbcoldelfuel" value='<s:property value="cmbcoldelfuel"/>'>
    <option value="">--Select--</option>
    <option value=0.000>Level 0/8</option>
    <option value=0.125>Level 1/8</option>
    <option value=0.250>Level 2/8</option>
    <option value=0.375>Level 3/8</option>
    <option value=0.500>Level 4/8</option>
    <option value=0.625>Level 5/8</option>
    <option value=0.750>Level 6/8</option>
    <option value=0.875>Level 7/8</option>
    <option value=1.000>Level 8/8</option></select>
    </td>
    <input type="hidden" name="hidcmbcoldelfuel" id="hidcmbcoldelfuel" value='<s:property value="hidcmbcoldelfuel"/>'>
  </tr>
</table>
</fieldset>
</td>
  </tr>
  <tr>
    <td>

    <fieldset style="background-color:#ECF8E0"><legend><b>Collected Veh. Closing At Branch</b></legend>
    <table width="100%">
  <tr>
    <td width="7%" align="right">Branch</td>
    <td width="19%" align="left"><select name="cmbcolinbranch" id="cmbcolinbranch" value='<s:property value="cmbcolinbranch"/>' style="width:95%;" onchange="getLoc(this.value);"><option value="">--Select--</option></select></td>
    <input type="hidden" name="hidcmbcolinbranch" id="hidcmbcolinbranch" value='<s:property value="hidcmbcolinbranch"/>'>
    <td width="11%" align="right">Location</td>
    <td width="19%" align="left"><select name="cmbcolinlocation" id="cmbcolinlocation" value='<s:property value="cmbcolinlocation"/>' style="width:95%;"><option value="">--Select--</option></select></td>
    <input type="hidden" name="hidcmbcolinlocation" id="hidcmbcolinlocation" value='<s:property value="hidcmbcolinlocation"/>'>
    <td width="4%">&nbsp;</td>
    <td width="20%">&nbsp;</td>
    <td width="5%">&nbsp;</td>
    <td width="15%">&nbsp;</td>
  </tr>
  <tr>
    <td align="right">Date</td>
    <td align="left"><div id="colindate" name="colindate" value='<s:property value="colindate"/>'></td>
	<input type="hidden" name="hidcolindate" id="hidcolindate" value='<s:property value="hidcolindate"/>'>
    <td align="right">Time</td>
    <td align="left"><div id="colintime" name="colintime" value='<s:property value="colintime"/>'></div></td>
    <input type="hidden" name="hidcolintime" id="hidcolintime" value='<s:property value="hidcolintime"/>'>
    <td align="right">KM</td>
    <td align="left"><input type="text" name="colinkm" id="colinkm" value='<s:property value="colinkm"/>'></td>
    <td align="right">Fuel</td>
    <td align="left"><select name="cmbcolinfuel" id="cmbcolinfuel" value='<s:property value="cmbcolinfuel"/>'>
    <option value="">--Select--</option>
    <option value=0.000>Level 0/8</option>
    <option value=0.125>Level 1/8</option>
    <option value=0.250>Level 2/8</option>
    <option value=0.375>Level 3/8</option>
    <option value=0.500>Level 4/8</option>
    <option value=0.625>Level 5/8</option>
    <option value=0.750>Level 6/8</option>
    <option value=0.875>Level 7/8</option>
    <option value=1.000>Level 8/8</option></select>
    </td>
    <input type="hidden" name="hidcmbcolinfuel" id="hidcmbcolinfuel" value='<s:property value="hidcmbcolinfuel"/>'>
  </tr>
</table>
</fieldset>
</td>
  </tr>
</table>
    </fieldset>
    </div>
    </td>
  </tr>
</table>
</div>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
<div id="dateouthidden" name="dateouthidden" hidden="true"></div>
<div id="timeouthidden" name="timeouthidden" hidden="true"></div>
<input type="hidden" id="status" name="status"  value='<s:property value="status"/>'/>
<input type="hidden" id="infleettrancode" name="infleettrancode"  value='<s:property value="infleettrancode"/>'/>
<select name="cmbreplacetype" id="cmbreplacetype" style="width:95%;" onchange="checkReplace();" hidden="true">
            <option value="">--Select--</option>
            <option value="atbranch">At Branch</option>
            <option value="collection">Collection</option>
          </select>
          <input type="hidden" id="refno" name="refno" value='<s:property value="refno"/>' placeholder="Press F3 to Search" readonly onKeyDown="getAgmtno(event);"/>
</form>
<div id="agmtnowindow">
   <div ></div>
</div>
<div id="collectionwindow">
   <div ></div>
</div>
<div id="vehiclewindow">
   <div ></div>
</div>
</div>
</body>
</html>