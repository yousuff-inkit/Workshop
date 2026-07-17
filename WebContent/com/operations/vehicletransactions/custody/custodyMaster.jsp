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
</head>
<script type="text/javascript">
$(document).ready(function () { 

//date definition 
$("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
$("#refdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null}); 
$("#dateout").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});

$("#hidevmovedate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null}); 
$("#hidevmovetime").jqxDateTimeInput({ width: '40%', height: '15px', formatString: 'HH:mm', showCalendarButton: false,value:null });
 

$("#colleteddate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null,enableBrowserBoundsDetection: true});
$("#indate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null,enableBrowserBoundsDetection: true});
$("#outdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null,enableBrowserBoundsDetection: true});
$("#deldate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null,enableBrowserBoundsDetection: true});
//time definition
 $("#timeout").jqxDateTimeInput({ width: '40%', height: '15px', formatString: 'HH:mm', showCalendarButton: false,value:null });

$("#deltime").jqxDateTimeInput({ width: '40%', height: '15px', formatString: 'HH:mm', showCalendarButton: false,value:null });
$("#collectedtime").jqxDateTimeInput({ width: '40%', height: '15px', formatString: 'HH:mm', showCalendarButton: false,value:null });
$("#intime").jqxDateTimeInput({ width: '40%', height: '15px', formatString: 'HH:mm', showCalendarButton: false,value:null });
$("#outtime").jqxDateTimeInput({ width: '40%', height: '15px', formatString: 'HH:mm', showCalendarButton: false,value:null });
 $('#collectionwindow').jqxWindow({ width: '60%', height: '54%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Driver Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
  $('#collectionwindow').jqxWindow('close');
  $('#agmtnowindow').jqxWindow({ width: '60%', height: '56%',  maxHeight: '75%' ,maxWidth: '80%' , title: 'Agreement Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#agmtnowindow').jqxWindow('close');
 
	$('#collectiondriver').dblclick(function(){
	    $('#collectionwindow').jqxWindow('open');
	$('#collectionwindow').jqxWindow('focus');
	 collectionSearchContent('driverSearchGrid.jsp?id=1', $('#collectionwindow'));
	});
	 	
	
 $('#deldriver').dblclick(function(){
   $('#collectionwindow').jqxWindow('open');
	$('#collectionwindow').jqxWindow('focus');
	collectionSearchContent('driverSearchGrid.jsp?id=2',  $('#collectionwindow'));
}); 
 
 
 $('#refno').dblclick(function(){
	 if(document.getElementById("mode").value=="view"){
		 return false;
	 }
	 
	 
	 if(document.getElementById("searchbranch").value==''){
		 document.getElementById("errormsg").innerText="Branch Is Mandatory";
		document.getElementById("searchbranch").focus();
		 return false;  
	 }
	 if(document.getElementById("cmbrentaltype").value==''){
		 document.getElementById("errormsg").innerText="Rental Type Is Mandatory";
		document.getElementById("cmbrentaltype").focus();
		 return false;  
	 }
	document.getElementById("errormsg").innerText="";
    $('#agmtnowindow').jqxWindow('open');
 agmtnoSearchContent('agmtnoSearch.jsp?rentalbranch='+document.getElementById("searchbranch").value, $('#agmtnowindow'));
});
 $('#date').on('change', function (event) {
	  
     var maindate = $('#date').jqxDateTimeInput('getDate');
   	 if ($("#mode").val() == "A") {   
     funDateInPeriod(maindate);
   	 }
    });
 getTestLocation();

 
 $("#btnEdit").attr('disabled', true );
 $("#btnDelete").attr('disabled', true );

 
});

function getAgmtno(event){
	 if(document.getElementById("mode").value=="view"){
		 return false;
	 }
	 if(document.getElementById("searchbranch").value==''){
		 document.getElementById("errormsg").innerText="Branch Is Mandatory";
		document.getElementById("searchbranch").focus();
		 return false;  
	 }
	 
	 if(document.getElementById("cmbrentaltype").value==''){
		 document.getElementById("errormsg").innerText="Rental Type Is Mandatory";
		document.getElementById("cmbrentaltype").focus();
		 return false;  
	 }
	document.getElementById("errormsg").innerText="";
  
		 
	  var x= event.keyCode;
    if(x==114){
   	 $('#agmtnowindow').jqxWindow('open');
   	 agmtnoSearchContent('agmtnoSearch.jsp?rentalbranch='+document.getElementById("searchbranch").value, $('#agmtnowindow'));
    }
    else{
     }
}

function collectionSearchContent(url) {
    $.get(url).done(function (data) {
  $('#collectionwindow').jqxWindow('setContent', data);
}); 
}
function agmtnoSearchContent(url) {

	$.get(url).done(function (data) {
  $('#agmtnowindow').jqxWindow('setContent', data);
}); 
	
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

function funReadOnly(){


	
	    $('#custody input').attr('readonly', true );
		$('#custody select').attr('disabled', true);
		$('#date').jqxDateTimeInput({ disabled: true});
		$('#refdate').jqxDateTimeInput({ disabled: true});
		$('#dateout').jqxDateTimeInput({ disabled: true});
		$('#timeout').jqxDateTimeInput({ disabled: true});
		
		
		$('#colleteddate').jqxDateTimeInput({ disabled: true});
		 $("#collection input").attr("disabled", true);
		 $("#collection select").attr("disabled", true);
		 
		 
			$('#deldate').jqxDateTimeInput({ disabled: true});
		 $("#delivery input").prop("disabled", true);
		 $("#delivery select").prop("disabled", true);
		 
			$('#colleteddate').jqxDateTimeInput({ disabled: true});
			$('#indate').jqxDateTimeInput({ disabled: true});
			$('#outdate').jqxDateTimeInput({ disabled: true});
			$('#deldate').jqxDateTimeInput({ disabled: true});
			
			$('#deltime').jqxDateTimeInput({ disabled: true});
			$('#collectedtime').jqxDateTimeInput({ disabled: true});
			$('#intime').jqxDateTimeInput({ disabled: true});
			$('#outtime').jqxDateTimeInput({ disabled: true});
		
			 
			$('#chkcollection').attr('disabled', true);
			
			
			 $("#branchout input").attr("readonly", true);
			 $("#branchout select").attr("disabled", true);
		
}

function funRemoveReadOnly(){
	
	
	 $("#branchout input").attr("disabled", true);
	 $("#branchout select").attr("disabled", true);
	 
	$('#chkcollection').attr('disabled', false);
	$('#chkdelivery').attr('disabled', true);

		$('#date').jqxDateTimeInput({ disabled: false});
		$('#refdate').jqxDateTimeInput({ disabled: true});
		$('#dateout').jqxDateTimeInput({ disabled: true});
		$('#timeout').jqxDateTimeInput({ disabled: true});
	
		
		        
		
	
		$('#indate').jqxDateTimeInput({ disabled: false});
		$('#intime').jqxDateTimeInput({ disabled: false});

		
		  $('#custody input').attr('readonly', false );
		$('#custody select').attr('disabled', false);
			
		$('#colleteddate').jqxDateTimeInput({ disabled: true});
		 $("#collection input").prop("disabled", true);
		 $("#collection select").prop("disabled", true);
		 
		 $('#deldate').jqxDateTimeInput({ disabled: true});
		 $("#delivery input").prop("disabled", true);
		 $("#delivery select").prop("disabled", true);
	
		if(document.getElementById("mode").value=="A"){
			
			$('#date').val(new Date());
				
		$('#docno').prop('readonly',true);
		$('#txtfleetno').prop('readonly',true);
		$('#txtfleetname').prop('readonly',true);
		$('#refname').prop('readonly',true);
		$('#refno').prop('readonly',true);
		$('#outkm').prop('readonly',true);
		$('#reason').prop('readonly',true);
	
 		$('#refdate').jqxDateTimeInput('setDate', null);
 		$('#dateout').jqxDateTimeInput('setDate', null);
 		$('#timeout').jqxDateTimeInput('setDate', null);
 	
 		
 		$('#colleteddate').jqxDateTimeInput('setDate', null);
 		$('#indate').jqxDateTimeInput('setDate', null);
 		$('#outdate').jqxDateTimeInput('setDate', null);
 		$('#deldate').jqxDateTimeInput('setDate', null);
 		
 		
 	
 		$('#collectedtime').jqxDateTimeInput('setDate', null);
 		$('#intime').jqxDateTimeInput('setDate', null);
 		$('#outtime').jqxDateTimeInput('setDate', null);
 		$('#deltime').jqxDateTimeInput('setDate', null);
 		 $("#branchout input").attr("disabled", true);
 		 $("#branchout select").attr("disabled", true);
		
 		$('#txtbranch').attr('readonly', true);
		$('#txtlocation').attr('readonly', true);
 		document.getElementById("reason").value="Custody";
	}
	
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
			$("select#inbranch").html(optionsbranch);
			
			if ($('#hidebranch').val() != null) {
				$('#inbranch').val($('#hidebranch').val());
			}
			
		
		} else {
		}
	}
	x.open("GET", "getBranch.jsp", true);
	x.send();
}


function getBranch1() {
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
			$("select#searchbranch").html(optionsbranch);
			
			if ($('#searchbranchval').val() != null) {
				$('#searchbranch').val($('#searchbranchval').val());
			}
			
		
		} else {
		}
	}
	x.open("GET", "getBranch.jsp", true);
	x.send();
}



function chkstatus() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			
			
			var items = x.responseText.trim();
			//alert(items);	
			if(items=="OUT")
				{
				$.messager.alert('Message','Fleet Is Not Available','warning');
				return 0;
				
				}
			else
				{
				
			items = items.split(',');
			var datein = items[0];
			var timein = items[1];
			var kmin = items[2];
			
		     $('#hidevmovedate').val(datein);
		     $('#hidevmovetime').val(timein);
		     $('#hidevmovekm').val(kmin);
			
			document.getElementById("outbranch").value="Update";
			$("#branchout input").prop("disabled", false);
			$("#branchout input").prop("readonly", false);
			 $("#branchout select").prop("disabled", false);
			 $('#outdate').jqxDateTimeInput({ disabled: false});
			  $('#outtime').jqxDateTimeInput({ disabled: false});
			  
			  return 0;
			
		
		} 
	}
	}
	x.open("GET", "validateDetails.jsp?fleetno="+document.getElementById("txtfleetno").value, true);
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
			$("select#inlocation").html(optionslocation);
			
			if ($('#hidelocation').val() != null) {
				$('#inlocation').val($('#hidelocation').val());
			}
			
		
		} else {
		}
	}
	x.open("GET", "getLoc.jsp?id="+value, true);
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
				
				$("select#inlocation").html(optionsloc);
		
				//alert("here");
				if ($('#hidelocation').val() != null) {
				$('#inlocation').val($('#hidelocation').val());
			}
				
			} else {
			}
		}
		x.open("GET", "getTestLocation.jsp", true);
		x.send();
  }  
function funReset(){
	//	$('#frmQuote')[0].reset(); 
	}
	
function funNotify(){	
	

		
		
		var maindate = $('#date').jqxDateTimeInput('getDate');
		   var validdate=funDateInPeriod(maindate);
		   if(validdate==0){
			   $('#date').jqxDateTimeInput('focus');
		   return 0; 
		   }
	    
		   if(document.getElementById("chkcollection").checked==true)
			{
		    	      
			var maindate1 = $('#colleteddate').jqxDateTimeInput('getDate');
			   var validdate1=funDateInPeriod(maindate1);
			   if(validdate1==0){
				   
				   $('#colleteddate').jqxDateTimeInput('focus');
				   
			   return 0; 
			   }
		    
			}  
				var maindate2 = $('#indate').jqxDateTimeInput('getDate');
				   var validdate2=funDateInPeriod(maindate2);
				   if(validdate2==0){
					   
					   $('#indate').jqxDateTimeInput('focus');
					   
				   return 0; 
				   }
			    
	 
		   
	    if(document.getElementById("cmbrentaltype").value==""){
			 document.getElementById("errormsg").innerText="Select Rental Type";
			document.getElementById("cmbrentaltype").focus();
			 return 0;  
		 }
	    else
	    	{
	    	 document.getElementById("errormsg").innerText="";
	    	}
	    if(document.getElementById("refno").value==""){
			 document.getElementById("errormsg").innerText="Select Ref No";
			document.getElementById("refno").focus();
			 return 0;  
		 }
	    else
	    	{
	    	 document.getElementById("errormsg").innerText="";
	    	}
	    if(document.getElementById("chkcollection").checked==true)
		{
	    	
		
	    if(document.getElementById("collectiondriver").value==""){
			 document.getElementById("errormsg").innerText="Select Driver";
			document.getElementById("collectiondriver").focus();
			 return 0;  
		 }
	    else
	    	{
	    	 document.getElementById("errormsg").innerText="";
	    	}
	    
	     var colleteddate=$('#colleteddate').jqxDateTimeInput('getDate');
		 var collectedtime=$('#collectedtime').jqxDateTimeInput('getDate');
		 if(colleteddate==null){
			 document.getElementById("errormsg").innerText="";
			 document.getElementById("errormsg").innerText="Collection Date Is Mandatory";
			 $('#colleteddate').jqxDateTimeInput('focus');
			 return 0;
		 }
		 if(collectedtime==null){
			 document.getElementById("errormsg").innerText="";
			 document.getElementById("errormsg").innerText="Collection Time Is Mandatory";
			 $('#collectedtime').jqxDateTimeInput('focus');
			 return 0;
		 }
		    if(document.getElementById("colletedkm").value==""){
				 document.getElementById("errormsg").innerText="Enter Collection KM ";
				document.getElementById("colletedkm").focus();
				 return 0;  
			 }
		    else
		    	{
		    	 document.getElementById("errormsg").innerText="";
		    	}
		    if(document.getElementById("collectedfuel").value==""){
				 document.getElementById("errormsg").innerText="Select Collection Fuel";
				document.getElementById("collectedfuel").focus();
				 return 0;  
			 }
		    else
		    	{
		    	 document.getElementById("errormsg").innerText="";
		    	}
		}
	   // colleteddate,collectedtime,colletedkm,collectedfuel
	    
	    if(document.getElementById("inbranch").value==""){
			 document.getElementById("errormsg").innerText="Select Branch";
			document.getElementById("inbranch").focus();
			 return 0;  
		 }
	    else
	    	{
	    	 document.getElementById("errormsg").innerText="";
	    	}
	    if(document.getElementById("inlocation").value==""){
			 document.getElementById("errormsg").innerText="Select Location";
			document.getElementById("inlocation").focus();
			 return 0;  
		 }
	    else
	    	{
	    	 document.getElementById("errormsg").innerText="";
	    	}
	    var indate=$('#indate').jqxDateTimeInput('getDate');
		 var intime=$('#intime').jqxDateTimeInput('getDate');
		 if(indate==null){
			 document.getElementById("errormsg").innerText="";
			 document.getElementById("errormsg").innerText="In Date Is Mandatory";
			 $('#indate').jqxDateTimeInput('focus');
			 return 0;
		 }
		 if(intime==null){
			 document.getElementById("errormsg").innerText="";
			 document.getElementById("errormsg").innerText="In Time Is Mandatory";
			 $('#intime').jqxDateTimeInput('focus');
			 return 0;
		 }
		    if(document.getElementById("binkm").value==""){
				 document.getElementById("errormsg").innerText="Enter In KM ";
				document.getElementById("binkm").focus();
				 return 0;  
			 }
		    else
		    	{
		    	 document.getElementById("errormsg").innerText="";
		    	}
		    if(document.getElementById("binfuel").value==""){
				 document.getElementById("errormsg").innerText="Select In Fuel";
				document.getElementById("binfuel").focus();
				 return 0;  
			 }
		    else
		    	{
		    	 document.getElementById("errormsg").innerText="";
		    	}
		    if(document.getElementById("chkcollection").checked==true)
					{ 
		    /* 	dateout timeout-=colleteddate,collectedtime */ 
		    	
					
							  if ($("#mode").val() == "A") 
							     {  var dateout1=new Date($('#colleteddate').jqxDateTimeInput('getDate'));
							  	 	var timeout1=$('#collectedtime').jqxDateTimeInput('getDate');
							  		var dateouthidden1=new Date($('#dateout').jqxDateTimeInput('getDate'));
							  		var timeouthidden1=$('#timeout').jqxDateTimeInput('getDate');
							  		
							  	  		dateout1.setHours(0,0,0,0);
							  		dateouthidden1.setHours(0,0,0,0);
							  		
							  		
							  		if(dateout1<dateouthidden1){
							 
							  			document.getElementById("errormsg").innerText="";
							  			document.getElementById("errormsg").innerText="Collection Date Cannot be Less than Out Date";
							  			$('#colleteddate').jqxDateTimeInput('focus'); 
							  	  			return 0;	
							  			
							  		}
							  		if(dateout1-dateouthidden1==0){
											
								  			if(timeout1.getHours() < timeouthidden1.getHours()){
								  				document.getElementById("errormsg").innerText="";
								  				document.getElementById("errormsg").innerText="Collection Time Cannot be Less than Out Time";
								  				$('#collectedtime').jqxDateTimeInput('focus'); 
								  				return 0;
								  			}
								  			if(timeout1.getHours() == timeouthidden1.getHours()){
								  			if(timeout1.getMinutes() < timeouthidden1.getMinutes()){
								  				document.getElementById("errormsg").innerText="";
								  				document.getElementById("errormsg").innerText="Collection Time Cannot be Less than Out Time";
								  				$('#collectedtime').jqxDateTimeInput('focus');
								  				return 0;
								  			}
								  			}
								  			
								  			else{
								  				document.getElementById("errormsg").innerText="";
								  			}
								  		}
							  
							  		
							  		
							  		
								  	var outkm=document.getElementById("outkm").value;
					        	 	var colkm=document.getElementById("colletedkm").value;
					        	 	
					        	    if((parseFloat(colkm)<parseFloat(outkm)))
					        		   
					        	 	
					        	 	{
					        		  
					        		   document.getElementById("errormsg").innerText="Collection KM Less Than Out KM";  
					        		   document.getElementById("colletedkm").focus();
					        		   return 0;
					        	 	}		
							  	 
											   
					        }
					}
		 	   else
		    		{
		    	
							    	 if ($("#mode").val() == "A") 
								     {    
							    		 
							    		 
							    		 
							    		 
							    		 
							    		 var dateout1=new Date($('#indate').jqxDateTimeInput('getDate'));
									  	 	var timeout1=$('#intime').jqxDateTimeInput('getDate');
									  		var dateouthidden1=new Date($('#dateout').jqxDateTimeInput('getDate'));
									  		var timeouthidden1=$('#timeout').jqxDateTimeInput('getDate');
									  		
									  	  		dateout1.setHours(0,0,0,0);
									  		dateouthidden1.setHours(0,0,0,0);
									  		
									  		
									  		if(dateout1<dateouthidden1){
									 
									  			document.getElementById("errormsg").innerText="";
									  			document.getElementById("errormsg").innerText="In Date Cannot be Less than Out Date";
									  			$('#indate').jqxDateTimeInput('focus'); 
									  	  			return 0;	
									  			
									  		}
									  		if(dateout1-dateouthidden1==0){
													
										  			if(timeout1.getHours() < timeouthidden1.getHours()){
										  				document.getElementById("errormsg").innerText="";
										  				document.getElementById("errormsg").innerText="In Time Cannot be Less than Out Time";
										  				$('#intime').jqxDateTimeInput('focus'); 
										  				return 0;
										  			}
										  			if(timeout1.getHours() == timeouthidden1.getHours()){
										  			if(timeout1.getMinutes() < timeouthidden1.getMinutes()){
										  				document.getElementById("errormsg").innerText="";
										  				document.getElementById("errormsg").innerText="In Time Cannot be Less than Out Time";
										  				$('#intime').jqxDateTimeInput('focus');
										  				return 0;
										  			}
										  			}
										  			
										  			else{
										  				document.getElementById("errormsg").innerText="";
										  			}
							    		 
												
								  
					                           }
				    	
										  	var outkm=document.getElementById("outkm").value;
							        	 	var inkm=document.getElementById("binkm").value;
							        	 	
							        	    if((parseFloat(inkm)<parseFloat(outkm)))
							        		   
							        	 	
							        	 	{
							        		  
							        		   document.getElementById("errormsg").innerText="In KM Less Than Out KM";  
							        		   document.getElementById("binkm").focus();
							        		   return 0;
							        	 	}
		    	
								     }
							 }
		    
		    
		    
		    
		    if(document.getElementById("chkcollection").checked==true)
			{ 
    /* 	dateout timeout-=colleteddate,collectedtime */ 
    	
			
					  if ($("#mode").val() == "A") 
					     {      var dateout1=new Date($('#indate').jqxDateTimeInput('getDate'));
					  	 	    var timeout1=$('#intime').jqxDateTimeInput('getDate');
					  		    var dateouthidden1=new Date($('#colleteddate').jqxDateTimeInput('getDate'));
					  		   var timeouthidden1=$('#collectedtime').jqxDateTimeInput('getDate');
					  		
					  	  		dateout1.setHours(0,0,0,0);
					  		dateouthidden1.setHours(0,0,0,0);
					  		
					  		
					  		if(dateout1<dateouthidden1){
					 
					  			document.getElementById("errormsg").innerText="";
					  			document.getElementById("errormsg").innerText="In Date Cannot be Less than Collection Date";
					  			$('#indate').jqxDateTimeInput('focus'); 
					  	  			return 0;	
					  			
					  		}
					  		if(dateout1-dateouthidden1==0){
									
						  			if(timeout1.getHours() < timeouthidden1.getHours()){
						  				document.getElementById("errormsg").innerText="";
						  				document.getElementById("errormsg").innerText="In Time Cannot be Less than Collection Time";
						  				$('#intime').jqxDateTimeInput('focus'); 
						  				return 0;
						  			}
						  			if(timeout1.getHours() == timeouthidden1.getHours()){
						  			if(timeout1.getMinutes() < timeouthidden1.getMinutes()){
						  				document.getElementById("errormsg").innerText="";
						  				document.getElementById("errormsg").innerText="In Time Cannot be Less than Collection Time";
						  				$('#intime').jqxDateTimeInput('focus');
						  				return 0;
						  			}
						  			}
						  			
						  			else{
						  				document.getElementById("errormsg").innerText="";
						  			}
						  		}
					  		
					  		var colkm=document.getElementById("colletedkm").value;
			        	 	var inkm=document.getElementById("binkm").value;
			        	 	
			        	    if((parseFloat(inkm)<parseFloat(colkm)))
			        		   
			        	 	
			        	 	{
			        		  
			        		   document.getElementById("errormsg").innerText="In KM Less Than Collection KM";  
			        		   document.getElementById("binkm").focus();
			        		   return 0;
			        	 	}
									   
			     }
			}
		    
		    $('#date').jqxDateTimeInput({ disabled: false});
			$('#refdate').jqxDateTimeInput({ disabled: false});
			$('#dateout').jqxDateTimeInput({ disabled: false});
			$('#timeout').jqxDateTimeInput({ disabled: false});
		    $('#cmbfuel').prop('disabled',false);
	return 1;
	
}


function funSearchLoad(){
	 changeContent('mainSearch.jsp'); 
}

	
function funFocus(){
	
	document.getElementById("searchbranch").focus();
	
   		
}
function setValues() {
	funSetlabel();
	document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	
	
	if($('#hidedate').val()){
		$("#date").jqxDateTimeInput('val', $('#hidedate').val());
	}
		if($('#hiderefdate').val()){
		$("#refdate").jqxDateTimeInput('val', $('#hiderefdate').val());
	}
		if($('#hideroutdate').val()){
		$("#dateout").jqxDateTimeInput('val', $('#hideroutdate').val());
	}
		
		if($('#hidertimeout').val()){
		$("#timeout").jqxDateTimeInput('val', $('#hidertimeout').val());
	}
		
	
		if ($('#renttypeval').val() != null) {
            $('#cmbrentaltype').val($('#renttypeval').val());
       }
		if ($('#rfuelval').val() != null) {
			$('#cmbfuel').val($('#rfuelval').val());
		}
		
		if($('#hidcollectedTime').val()){
			$("#collectedtime").jqxDateTimeInput('val', $('#hidcollectedTime').val());
		}
			
			if($('#hideIntime').val()){
			$("#intime").jqxDateTimeInput('val', $('#hideIntime').val());
		}
			
			
			if ($('#hidcollectedFuelval').val() != null) {
	            $('#collectedfuel').val($('#hidcollectedFuelval').val());
	       }
			if ($('#inFuelval').val() != null) {
				$('#binfuel').val($('#inFuelval').val());
			}	
			
			if($('#hidcollecteddate').val()){
				$("#colleteddate").jqxDateTimeInput('val', $('#hidcollecteddate').val());
			}
				
				if($('#hideIndate').val()){
				$("#indate").jqxDateTimeInput('val', $('#hideIndate').val());
			}
				
				if($('#hidouttime').val()){
					$("#outtime").jqxDateTimeInput('val', $('#hidouttime').val());
				}
					
					if($('#hidoutdate').val()){
					$("#outdate").jqxDateTimeInput('val', $('#hidoutdate').val());
				}
					if ($('#outfuelval').val() != null) {
						$('#boutfuel').val($('#outfuelval').val());
					}	
				   
			
					if($('#hiddeltime').val()){
						$("#deltime").jqxDateTimeInput('val', $('#hiddeltime').val());
					}
						
						if($('#hiddeldate').val()){
						$("#deldate").jqxDateTimeInput('val', $('#hiddeldate').val());
					}
						if ($('#hiddelfuelval').val() != null) {
							$('#delfuel').val($('#hiddelfuelval').val());
						}	
				
						if ($('#delyornval').val() != null) {
							$('#delyesorno').val($('#delyornval').val());
						}		
	
						
						
					   
					
					
		
	        if(parseInt(document.getElementById("collectintickval").value)>0)
	        	{
	        	
	        	document.getElementById("chkcollection").checked=true;
	    
	        	if(document.getElementById("mode").value=="A")
	        		
	        		{
	        		
	        		$("#collection input").prop("disabled", false);
	       		    $("#collection select").prop("disabled", false);
	       		   $('#colleteddate').jqxDateTimeInput({ disabled: false});
	       		   $('#collectedtime').jqxDateTimeInput({ disabled: false});
	       	
	        		
	        		}
	        	
	        	}
		
	        
        	
        	 if(document.getElementById("mode").value=="view")
        		
    		{
        		 if(parseInt(document.getElementById("delyornval").value)>0)
             	{
        				$('#chkdelivery').attr('disabled', false);	 
        	}
        		 else
        			 {
        				$('#chkdelivery').attr('disabled', true);
        			 }
        		 if(parseInt(document.getElementById("branchoutval").value)>0)
              	{
         				$('#outbranch').attr('disabled', true);	 
             	}
         		 else
         			 {
         				$('#outbranch').attr('disabled', false);
         			 }
         		  
        		 
        		 
        	}

	        if(parseInt(document.getElementById("delchkval").value)>0)
        	{
        	
        	document.getElementById("chkdelivery").checked=true;
        	if(document.getElementById("mode").value=="view")
        		
    		{
        	$('#chkdelivery').attr('disabled', true);
        	}
        	} 
		
		
		if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		
		
	
}

function checkCollection()
{
	if(document.getElementById("chkcollection").checked==true)
		{
		$('#collectiondriver').attr('readonly', true );
		$("#collection input").prop("disabled", false);
		 $("#collection select").prop("disabled", false);
		$('#colleteddate').jqxDateTimeInput({ disabled: false});
		  $('#collectedtime').jqxDateTimeInput({ disabled: false});
		document.getElementById("collectintickval").value=1;	
			
			
		}
	else
		{
		
		$("#collection input").prop("disabled", true);
		 $("#collection select").prop("disabled", true);
		 $('#colleteddate').jqxDateTimeInput({ disabled: true});
		  $('#collectedtime').jqxDateTimeInput({ disabled: true});
		 document.getElementById("collectintickval").value=0;	
		}
	
	}
	
function checkDelivery()
{
	if(document.getElementById("chkdelivery").checked==true)
		{
		
		$("#delivery input").prop("disabled", false);
		$("#delivery select").prop("disabled", false);
		$("#delivery input").prop("readonly", false);
		$("#deldriver").prop("readonly", true);
		
		$('#deldate').jqxDateTimeInput({ disabled: false});
		  $('#deltime').jqxDateTimeInput({ disabled: false});
		  
		  document.getElementById("delchkval").value=1;	  
		  document.getElementById("delupdate").value="Update";
		  
		}
	else
		{
		
		$("#delivery input").prop("disabled", true);
		$("#delivery select").prop("disabled", true);
		$('#deldate').jqxDateTimeInput({ disabled: true});
		  $('#deltime').jqxDateTimeInput({ disabled: true});
		  document.getElementById("delchkval").value=0;	 
		  document.getElementById("delupdate").value="Edit";
		}
	
	}
function funoutupdate()
     {
	if(document.getElementById("docno").value=="")
		
	{
	
	$.messager.alert('Message','Select a Document....!','warning');
	return 0;
	}
	
	
	
	if(document.getElementById("outbranch").value=="Update")
	{
		
		
		$('#colleteddate').jqxDateTimeInput({ disabled: false});
		 $("#collection input").prop("disabled", false);
		 $("#collection select").prop("disabled", false);
		 
		 outdate,outtime,boutkm,boutfuel,delyesorno
		  var outdate=$('#outdate').jqxDateTimeInput('getDate');
			 var outtime=$('#outtime').jqxDateTimeInput('getDate');
			 if(outdate==null){
				 document.getElementById("errormsg").innerText="";
				 document.getElementById("errormsg").innerText="Out Date Is Mandatory";
				 $('#outdate').jqxDateTimeInput('focus');
				 return 0;
			 }
			 if(outtime==null){
				 document.getElementById("errormsg").innerText="";
				 document.getElementById("errormsg").innerText="Out Time Is Mandatory";
				 $('#outtime').jqxDateTimeInput('focus');
				 return 0;
			 }
			 
			    
			 
			    	      
				var maindate1 = $('#outdate').jqxDateTimeInput('getDate');
				   var validdate1=funDateInPeriod(maindate1);
				   if(validdate1==0){
					   $('#outdate').jqxDateTimeInput('focus');
				   return 0; 
				   }
			    
				 
					 
			 
			 
			 
			 
			    if(document.getElementById("boutkm").value==""){
					 document.getElementById("errormsg").innerText="Enter Out KM ";
					document.getElementById("boutkm").focus();
					 return 0;  
				 }
			    else
			    	{
			    	 document.getElementById("errormsg").innerText="";
			    	}
			    if(document.getElementById("boutfuel").value==""){
					 document.getElementById("errormsg").innerText="Select Out Fuel";
					document.getElementById("boutfuel").focus();
					 return 0;  
				 }
			    else
			    	{
			    	 document.getElementById("errormsg").innerText="";
			    	}
			    if(document.getElementById("delyesorno").value==""){
					 document.getElementById("errormsg").innerText="Choose One Option ";
					document.getElementById("delyesorno").focus();
					 return 0;  
				 }
			    else
			    	{
			    	 document.getElementById("errormsg").innerText="";
			    	}
			    
			    
			  //  hidevmovedate hidevmovetime hidevmovekm
			    //-----------------
			  ///  outdate  outtime
				      var dateout1=new Date($('#outdate').jqxDateTimeInput('getDate'));
				  	 	    var timeout1=$('#outtime').jqxDateTimeInput('getDate');
				  		    var dateouthidden1=new Date($('#hidevmovedate').jqxDateTimeInput('getDate'));
				  		   var timeouthidden1=$('#hidevmovetime').jqxDateTimeInput('getDate');
				  		
				  	  		dateout1.setHours(0,0,0,0);
				  		dateouthidden1.setHours(0,0,0,0);
				  		
				  		
				  		if(dateout1<dateouthidden1){
				 
				  			document.getElementById("errormsg").innerText="";
				  			document.getElementById("errormsg").innerText="Out Date Cannot be Less Than  In Date";
				  			$('#outdate').jqxDateTimeInput('focus'); 
				  	  			return 0;	
				  			
				  		}
				  		if(dateout1-dateouthidden1==0){
								
					  			if(timeout1.getHours() < timeouthidden1.getHours()){
					  				document.getElementById("errormsg").innerText="";
					  				document.getElementById("errormsg").innerText="Out Time Cannot be Less Than  In Time";
					  				$('#outtime').jqxDateTimeInput('focus'); 
					  				return 0;
					  			}
					  			if(timeout1.getHours() == timeouthidden1.getHours()){
					  			if(timeout1.getMinutes() < timeouthidden1.getMinutes()){
					  				document.getElementById("errormsg").innerText="";
					  				document.getElementById("errormsg").innerText="Out Time Cannot be Less Than  In Time";
					  				$('#outtime').jqxDateTimeInput('focus');
					  				return 0;
					  			}
					  			}
					  			
					  			else{
					  				document.getElementById("errormsg").innerText="";
					  			}
					  		}
				  		
				  		var colkm=document.getElementById("hidevmovekm").value;
		        	 	var inkm=document.getElementById("boutkm").value;
		        	 	
		        	    if((parseFloat(inkm)<parseFloat(colkm)))
		        		   
		        	 	
		        	 	{
		        		  
		        		   document.getElementById("errormsg").innerText="Out KM Less Than  In KM";  
		        		   document.getElementById("boutkm").focus();
		        		   return 0;
		        	 	}
								   
		        	    $('#searchbranch').attr('disabled',false);
		        		
		  document.getElementById("mode").value="OUT";
		  document.getElementById("custody").submit();
		
	}
	else
		{
		chkstatus();

	
		}
	}
	
	
	function funcleardatas()
	{
		
		
		document.getElementById("masterrefno").value="";
		document.getElementById("refno").value="";
		document.getElementById("txtfleetno").value="";
		document.getElementById("outkm").value="";
		document.getElementById("cmbfuel").value="";
		document.getElementById("txtbranch").value="";
		document.getElementById("txtlocation").value="";

		document.getElementById("refname").value="";
		document.getElementById("txtfleetname").value="";
		// txtfleetno  outkm cmbfuel txtbranch txtlocation    mainbranchid mainlocationid infleettrancode
		//refname txtfleetname
		
		
 		$('#refdate').jqxDateTimeInput('setDate', null);
 		$('#dateout').jqxDateTimeInput('setDate', null);
 		$('#timeout').jqxDateTimeInput('setDate', null);
		
	}
	
	
function fundelUpdate()
{

	 if(document.getElementById("deldriver").value==""){
		 document.getElementById("errormsg").innerText="Select Driver ";
		document.getElementById("deldriver").focus();
		 return 0;  
	 }
    else
    	{
    	 document.getElementById("errormsg").innerText="";
    	}
	
	 if(document.getElementById("deliveryto").value==""){
		 document.getElementById("errormsg").innerText="Enter Deliver To ";
		document.getElementById("deliveryto").focus();
		 return 0;  
	 }
    else
    	{
    	 document.getElementById("errormsg").innerText="";
    	}
	
		
	 var deldate=$('#deldate').jqxDateTimeInput('getDate');
	 var deltime=$('#deltime').jqxDateTimeInput('getDate');
	 if(deldate==null){
		 document.getElementById("errormsg").innerText="";
		 document.getElementById("errormsg").innerText="Delivery Date Is Mandatory";
		 $('#deldate').jqxDateTimeInput('focus');
		 return 0;
	 }
	 if(deltime==null){
		 document.getElementById("errormsg").innerText="";
		 document.getElementById("errormsg").innerText="Delivery Time Is Mandatory";
		 $('#deltime').jqxDateTimeInput('focus');
		 return 0;
	 }
	    if(document.getElementById("delkm").value==""){
			 document.getElementById("errormsg").innerText="Enter Delivery KM ";
			document.getElementById("delkm").focus();
			 return 0;  
		 }
	    else
	    	{
	    	 document.getElementById("errormsg").innerText="";
	    	}
	    if(document.getElementById("delfuel").value==""){
			 document.getElementById("errormsg").innerText="Select Delivery Fuel";
			document.getElementById("delfuel").focus();
			 return 0;  
		 }
	    else
	    	{
	    	 document.getElementById("errormsg").innerText="";
	    	}
	
		var maindate1 = $('#deldate').jqxDateTimeInput('getDate');
		   var validdate1=funDateInPeriod(maindate1);
		   if(validdate1==0){
			   $('#deldate').jqxDateTimeInput('focus');
			   
		   return 0; 
		   }
	    
		 
	    
	    //-------------------------
	  //  deldate,deltime,delkm
	      var dateout1=new Date($('#deldate').jqxDateTimeInput('getDate'));
	 	    var timeout1=$('#deltime').jqxDateTimeInput('getDate');
		    var dateouthidden1=new Date($('#outdate').jqxDateTimeInput('getDate'));
		   var timeouthidden1=$('#outtime').jqxDateTimeInput('getDate');
		
	  		dateout1.setHours(0,0,0,0);
		dateouthidden1.setHours(0,0,0,0);
		
		
		if(dateout1<dateouthidden1){

			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Delivery Date Cannot be Less than Out Date";
			$('#deldate').jqxDateTimeInput('focus'); 
	  			return 0;	
			
		}
		if(dateout1-dateouthidden1==0){
				
	  			if(timeout1.getHours() < timeouthidden1.getHours()){
	  				document.getElementById("errormsg").innerText="";
	  				document.getElementById("errormsg").innerText="Delivery Time Cannot be Less than Out Time";
	  				$('#deltime').jqxDateTimeInput('focus'); 
	  				return 0;
	  			}
	  			if(timeout1.getHours() == timeouthidden1.getHours()){
	  			if(timeout1.getMinutes() < timeouthidden1.getMinutes()){
	  				document.getElementById("errormsg").innerText="";
	  				document.getElementById("errormsg").innerText="Delivery Time Cannot be Less than Out Time";
	  				$('#deltime').jqxDateTimeInput('focus');
	  				return 0;
	  			}
	  			}
	  			
	  			else{
	  				document.getElementById("errormsg").innerText="";
	  			}
	  		}
		
		var outkm=document.getElementById("boutkm").value;
	 	var delkm=document.getElementById("delkm").value;
	 	
	    if((parseFloat(delkm)<parseFloat(outkm)))
		   
	 	
	 	{
		  
		   document.getElementById("errormsg").innerText="Delivery KM Less Than Out KM";  
		   document.getElementById("delkm").focus();
		   return 0;
	 	}
	    
	    
	    
	    
	    
	    
	    
	$('#colleteddate').jqxDateTimeInput({ disabled: false});
	 $("#collection input").prop("disabled", false);
	 $("#collection select").prop("disabled", false);
	 $('#searchbranch').attr('disabled',false);
		  document.getElementById("mode").value="DLY";
		  document.getElementById("custody").submit();
		

	}
function isNumber(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
    	{
 	   document.getElementById("errormsg").innerText=" Enter Numbers Only";  
       
        return false;
    	}
    document.getElementById("errormsg").innerText="";  
    return true;
}


function funPrintBtn(){
	   if (($("#mode").val() == "view") && $("#docno").val()!="") { 
	  
	      
	   var url=document.URL;
  var reurl=url.split("saveCustody");
 var win= window.open(reurl[0]+"printCustody?docno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
win.focus(); 
	    } 
	  
	   else {
 	      $.messager.alert('Message','Select a Document....!','warning');
 	      return false;
 	     } 
 	
	} 

</script>

<body onload="setValues();getBranch();getBranch1();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="custody" action="saveCustody" autocomplete="off">
	<%-- <script>
			window.parent.formName.value="Replacement";
			window.parent.formCode.value="RPL";
	</script> --%>
	<jsp:include page="../../../../header.jsp" />
	<br/>
<div class='hidden-scrollbar'>
<fieldset>
      <legend>Vehicle  Custody</legend>
      <%-- <table width="100%" >
        <tr>
          <td align="right">Date</td> 
          <td width="7%"><div id="date" name="date" value='<s:property value="date"/>'></div>
		    </td>
          <td width="6%" align="right">Rental Type</td>
          <td width="7%"><select id="cmbrentaltype" name="cmbrentaltype"  onchange="funcleardatas()"       value='<s:property value="cmbrentaltype"/>'> 
            <option value="">--Select--</option><option value="RAG">Rental</option><option value="LAG">Lease</option>
          </select></td>
          <td width="5%" align="right">Ref No</td>
          <td width="8%" align="left"><input type="text" id="refno" name="refno" value='<s:property value="refno"/>' placeholder="Press F3 to Search" readonly onkeydown="getAgmtno(event);"/></td>
          <td colspan="2" align="left"><input type="text" id="refname" name="refname" style="width:100%;" value='<s:property value="refname"/>' readonly/></td>
          <td width="7%" align="right">Ref Date</td>
          <td width="10%" align="right"><div id='refdate' name='refdate' value='<s:property value="refdate"/>'></div></td>
                   <td width="5%" align="right"></td>
          <td width="8%" align="left"></td>
       
          <td align="right">Doc No</td>
          <td colspan="2"><input type="text" id="docno" name="docno" tabindex="-1" readonly value='<s:property value="docno"/>'/></td>
        </tr>
        <tr>
          <td width="6%" align="right">Fleet No</td> 
          <td colspan="5" align="left"><input type="text" id="txtfleetno" name="txtfleetno" value='<s:property value="txtfleetno"/>' readonly /> 
            <input type="text" id="txtfleetname" name="txtfleetname" style="width:72.2%;" value='<s:property value="txtfleetname"/>' readonly/></td>
          <td width="7%" align="right">Date Out</td>
          <td width="11%" align="left"><div id="dateout" name="dateout" value='<s:property value="dateout"/>'></div></td>
     
          <td align="right">Time Out</td>
          <td align="left"><div id="timeout" name="timeout" value='<s:property value="timeout"/>'></div></td>
        
          <td align="right">Km Out</td>
          <td align="left"><input type="text" id="outkm" name="outkm" style="width:68%;" value='<s:property value="outkm"/>' readonly onkeypress="javascript:return isNumber (event)"/></td>
         
          <td width="4%" align="right">Fuel</td>
          <td width="9%" align="left"><select id="cmbfuel" name="cmbfuel" value='<s:property value="cmbfuel"/>'> 
            <option value="">--Select--</option><option value=0.000>Level 0/8</option><option value=0.125>Level 1/8</option><option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option><option value=0.500>Level 4/8</option>
    <option value=0.625>Level 5/8</option><option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
          </select></td>
            
        </tr>
        <tr>
          <td align="right">Branch</td>
          <td colspan="3" align="left"><input type="text" name="txtbranch" id="txtbranch" readonly value='<s:property value="txtbranch"/>'/></td>
            
          <td align="right">Location</td>
          <td align="left"><input type="text" name="txtlocation" id="txtlocation" readonly value='<s:property value="txtlocation"/>'/></td>
          
          <td align="right">Tr. Reason</td>
          <td align="left"><input type="text" id="reason" name="reason" style="width:95%;" readonly  value='<s:property value="reason"/>'></td>
          
            
          <td align="right"></td>
          <td></td>
 
          <td align="right">&nbsp;</td>
          <td>&nbsp;</td>
       
          <td align="right">&nbsp;</td>
          <td align="left">&nbsp;</td>
        </tr>
      </table> --%>
        
    <table width="100%" >
        <tr>
          <td align="right">Date</td> 
          <td width="6%"><div id="date" name="date" value='<s:property value="date"/>'></div>
		    </td>
          <td width="4%" align="right">Branch</td>
          <td width="10%" align="right"><select name="searchbranch" id="searchbranch" value='<s:property value="searchbranch"/>' style="width:100%;" ><option value="">--Select--</option></select>
          </td>
          <td width="7%" align="right">Rental Type</td>
          <td width="6%"><select id="cmbrentaltype" name="cmbrentaltype"  onchange="funcleardatas()"   value='<s:property value="cmbrentaltype"/>'> 
            <option value="">--Select--</option><option value="RAG">Rental</option><option value="LAG">Lease</option>
          </select></td>
          <td width="7%" align="right">Ref No</td>
          <td width="7%" align="left"><input type="text" id="refno" name="refno" value='<s:property value="refno"/>' placeholder="Press F3 to Search" readonly onkeydown="getAgmtno(event);"/></td>
          <td colspan="2" align="left"><input type="text" id="refname" name="refname" style="width:100%;" value='<s:property value="refname"/>' readonly/></td>
          <td width="6%" align="right">Ref Date</td>
          <td width="6%" align="right"><div id='refdate' name='refdate' value='<s:property value="refdate"/>'></div></td>
                   <td width="6%" align="right"></td>
          <td align="right">Doc No</td>
          <td colspan="2"><input type="text" id="docno" name="docno" tabindex="-1" readonly value='<s:property value="docno"/>'/></td>
        </tr>
        <tr>
          <td width="6%" align="right">Fleet No</td> 
          <td colspan="7" align="left"><input type="text" id="txtfleetno" name="txtfleetno" value='<s:property value="txtfleetno"/>' readonly /> 
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="text" id="txtfleetname" name="txtfleetname" style="width:70%;" value='<s:property value="txtfleetname"/>' readonly/></td>
          <td width="7%" align="right">Date Out</td>
          <td width="9%" align="left"><div id="dateout" name="dateout" value='<s:property value="dateout"/>'></div></td>
     
          <td align="right">Time Out</td>
          <td align="left"><div id="timeout" name="timeout" value='<s:property value="timeout"/>'></div></td>
        
          <td align="right">&nbsp;</td>
          <td width="6%" align="right">&nbsp;</td>
          <td width="9%" align="left">&nbsp;</td>
            
        </tr>
        <tr>
          <td align="right">Branch</td>
          <td colspan="5" align="left"><input type="text" name="txtbranch" id="txtbranch" readonly value='<s:property value="txtbranch"/>'/>     
             &nbsp;&nbsp;&nbsp;Location 
               <input type="text" name="txtlocation" id="txtlocation" style="width:45%;" readonly value='<s:property value="txtlocation"/>'/></td>
            
          <td align="right">Tr. Reason</td>
          <td align="left"><input type="text" id="reason" name="reason" style="width:95.6%;" readonly  value='<s:property value="reason"/>'></td>
          
          <td align="right">Km Out</td>
          <td align="left"><input type="text" id="outkm" name="outkm" style="width:99%;" value='<s:property value="outkm"/>' readonly onkeypress="javascript:return isNumber (event)"/></td>
          
            
          <td align="right">Fuel</td>
          <td><select id="cmbfuel" name="cmbfuel" value='<s:property value="cmbfuel"/>'>
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
 
          <td align="right">&nbsp;</td>
          <td align="right">&nbsp;</td>
          <td align="left">&nbsp;</td>
        </tr>
		  <tr>
          <td align="right">Description</td>
          <td colspan="11" align="left"><input type="text" name="descnew" id="descnew" value='<s:property value="descnew"/>' style="width:100%;"></td>
          <td align="right">&nbsp;</td>
          <td align="right">&nbsp;</td>
          <td align="left">&nbsp;</td>
        </tr>
      </table>
    </fieldset>
    <br/>
      <fieldset style="background-color:#ffe4e1;"><legend><input type="checkbox" name="chkcollection" id="chkcollection" onchange="checkCollection();"><b>Collection Details</b></legend>
    <table width="100%" id="collection"  >
  <tr>
   <td width="10%" align="right">Driver</td> 
    <td width="18%" align="left"><input type="text" name="collectiondriver" id="collectiondriver" value='<s:property value="collectiondriver"/>' placeholder="Press F3 to Search" readonly onkeydown="getDriver(event,1);"></td>
    
      <td align="right" width="9%">&nbsp;</td>
    <td align="left" width="12%">&nbsp;</td> 
    
    <td align="right" width="10%">&nbsp;</td> 
    <td align="left" width="18%">&nbsp;</td>
   
    <td align="right" width="5%">&nbsp;</td>
    <td align="left" width="10%">&nbsp;</td>
    <td align="left" width="18%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td width="20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
    </tr>
    <tr>
    <td align="right" width="10%">Date</td>
    <td align="left" width="18%"><div id="colleteddate" name="colleteddate" value='<s:property value="colleteddate"/>'></div></td>
    
    <td align="right" width="9%">Time</td>
    <td align="left" width="12%"><div id="collectedtime" name="collectedtime" value='<s:property value="collectedtime"/>'></div></td>
   
    <td align="right" width="10%">KM</td>
    <td align="left" width="18%"><input type="text" name="colletedkm"  style="width:60%;" id="colletedkm" value='<s:property value="colletedkm"/>'onkeypress="javascript:return isNumber (event)"></td>
    <td align="right" width="5%">Fuel</td>
    <td align="left" width="10%"><select name="collectedfuel" id="collectedfuel" value='<s:property value="collectedfuel"/>'>
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

    <td align="left" width="18%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
     <td width="20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
</table>
</fieldset>
    <fieldset style="background-color:#FFFAFA;" id="collectfield"><legend><label><b>Branch In</b></label></legend>
    <table width="100%" >
  <tr>
 
 
<td width="10%" align="right">Branch</td>
    <td width="18%" align="left"><select name="inbranch" id="inbranch" value='<s:property value="inbranch"/>' style="width:60%;" onchange="getLoc(this.value);"><option value="">--Select--</option></select></td>
   
    <td width="9%" align="right">Location</td>
    <td width="12%" align="left"><select name="inlocation" id="inlocation" value='<s:property value="inlocation"/>' style="width:99%;"><option value="">--Select--</option></select></td>

    
    <td align="right" width="10%">&nbsp;</td>
    <td align="left" width="18%">&nbsp;</td>  
   
 <td align="right" width="5%">&nbsp;</td>
    <td align="left" width="10%">&nbsp;</td>
    <td align="left" width="18%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  <td width="20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>  
 </tr>
 <tr>

 
    <td align="right" width="10%">Date</td>
    <td align="left" width="18%"><div id="indate" name="indate" value='<s:property value="indate"/>'></div></td>
   
    <td align="right" width="9%">Time</td>
    <td align="left" width="12%"><div id="intime" name="intime" value='<s:property value="intime"/>' ></div></td>
    
    <td align="right" width="10%">KM</td>
    <td align="left" width="18%"><input type="text" name="binkm" style="width:60%;"  id="binkm" value='<s:property value="binkm"/>' onkeypress="javascript:return isNumber (event)"></td>
    <td align="right" width="5%">Fuel</td>
    <td align="left" width="10%"><select name="binfuel" id="binfuel" value='<s:property value="binfuel"/>'>
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

    <td align="left" width="18%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td width="20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
     </tr>
  </table>
</fieldset>
<fieldset style="background-color:#ECF8E0"><legend><b>Branch Out</b></legend>
    <table width="100%" id="branchout" >
  <tr>


    <td align="right" width="85">Date</td>
    <td align="left" width="118"><div id="outdate" name="outdate" value='<s:property value="outdate"/>'></div></td> 

    <td align="right" width="21">Time</td>
    <td align="left" width="98"><div id="outtime" name="outtime" value='<s:property value="outtime"/>'></div></td> 

    <td align="right" width="88">KM</td>
    <td align="left" width="151"><input type="text" name="boutkm" style="width:61%;"  id="boutkm" value='<s:property value="boutkm"/>' onkeypress="javascript:return isNumber (event)"></td>
    <td align="right" width="46">Fuel</td>
    <td align="left" width="98"><select name="boutfuel" id="boutfuel" value='<s:property value="boutfuel"/>'>
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
   <td width="308" colspan="2">Delivery&nbsp;<select name="delyesorno" id="delyesorno" value='<s:property value="delyesorno"/>'> 
      <option value="">--Select--</option>
           <option value=1>YES</option>
                <option value=0>NO</option>
      </select>&nbsp;&nbsp;&nbsp;&nbsp;
   <input type="button" id="outbranch" class="myButton" name="outbranch" value="Edit" onclick="funoutupdate()"></td>
  
</tr>
  <tr>
    <td align="right">Description</td>
    <td colspan="9" align="left"><input type="text" name="outdesc" id="outdesc" value='<s:property value="outdesc"/>' style="width:95%;"></td>
    </tr>
    </table>
<br/>
</fieldset>
    <fieldset style="background-color:#e6e6fa;" id="deliveryfield"><legend><input type="checkbox" name="chkdelivery" id="chkdelivery" onchange="checkDelivery();"><label for="chkdelivery"><b>Delivery</b></label></legend>
<table width="100%" id="delivery" >
<tr>
  <td align="right" width="11%">Driver</td> 
    <td align="left" width="16%"><input type="text" name="deldriver" id="deldriver" readonly value='<s:property value="deldriver"/>' placeholder="Press F3 to Search" onkeydown="getDriver(event,2);"></td>
 
    <td align="right" width="13%">Deliver To</td>
    <td align="left" width="15%"><input type="text" name="deliveryto" id="deliveryto" value='<s:property value="deliveryto"/>'></td>
   
    
    <td align="right" width="6%">&nbsp;</td>
    <td align="left" width="18%">&nbsp;</td>
   
   <td align="right" width="5%">&nbsp;</td>
    <td align="left" width="10%">&nbsp;</td>
    <td align="left" width="18%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
     <td width="20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
    </tr>
    <tr>
    <td align="right" width="10%">Date</td>
    <td align="left" width="16%"><div id="deldate" name="deldate" value='<s:property value="deldate"/>'></div></td>
    <td align="right" width="11%">Time</td>
    <td align="left" width="15%"><div id="deltime" name="deltime" value='<s:property value="deltime"/>'></div></td>
   
    <td align="right" width="6%">KM</td>
    <td align="left" width="18%"><input type="text" name="delkm" style="width:65%;"  id="delkm" value='<s:property value="delkm"/>' onkeypress="javascript:return isNumber (event)"></td>
    <td align="right" width="7%">Fuel</td>
    <td align="left" width="10%"><select name="delfuel" id="delfuel" value='<s:property value="delfuel"/>'>
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
    </select>
    </td>
     <td align="left" width="18%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
   <td align="left" width="20%">&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" id="delupdate" class="myButton" name="delupdate" value="Edit" onclick="fundelUpdate()"></td>
    
  </tr>
</table>

</fieldset>
</div>

<input type="hidden" name="masterrefno" id="masterrefno" value='<s:property value="masterrefno"/>'>

<input type="hidden" name="searchbranchval" id="searchbranchval" value='<s:property value="searchbranchval"/>'> 



<input type="hidden" name="branchoutval" id="branchoutval" value='<s:property value="branchoutval"/>'> <!-- for branch out burrion disabled val -->
<input type="hidden" name="delyornval" id="delyornval" value='<s:property value="delyornval"/>'> <!-- del s or n val -->
<input type="hidden" name="clientnumbers" id="clientnumbers" value='<s:property value="clientnumbers"/>'>
<!-- 
main set value fields  -->

<input type="hidden" name="hidedate" id="hidedate" value='<s:property value="hidedate"/>'> 
<input type="hidden" name="hiderefdate" id="hiderefdate" value='<s:property value="hiderefdate"/>'>
<input type="hidden" name="hideroutdate" id="hideroutdate" value='<s:property value="hideroutdate"/>'>

<input type="hidden" name="hidertimeout" id="hidertimeout" value='<s:property value="hidertimeout"/>'>

<input type="hidden" name="rfuelval" id="rfuelval" value='<s:property value="rfuelval"/>'>
<input type="hidden" name="renttypeval" id="renttypeval" value='<s:property value="renttypeval"/>'>


<!-- main collection and in  -->


<input type="hidden" name="hidcollecteddate" id="hidcollecteddate" value='<s:property value="hidcollecteddate"/>'> 
<input type="hidden" name="hidcollectedTime" id="hidcollectedTime" value='<s:property value="hidcollectedTime"/>'>
<input type="hidden" name="hidcollectedFuelval" id="hidcollectedFuelval" value='<s:property value="hidcollectedFuelval"/>'>

<input type="hidden" name="hideIndate" id="hideIndate" value='<s:property value="hideIndate"/>'>
<input type="hidden" name=hideIntime id="hideIntime" value='<s:property value="hideIntime"/>'>
<input type="hidden" name="inFuelval" id="inFuelval" value='<s:property value="inFuelval"/>'>



<!-- for branch -->
<input type="hidden" name="mainbranchid" id="mainbranchid" value='<s:property value="mainbranchid"/>'>              
<input type="hidden" name="mainlocationid" id="mainlocationid" value='<s:property value="mainlocationid"/>'>
<input type="hidden" name="infleettrancode" id="infleettrancode" value='<s:property value="infleettrancode"/>'>



<!-- for   branchin-->
<input type="hidden" name="hidebranch" id="hidebranch" value='<s:property value="hidebranch"/>'> 
<input type="hidden" name="hidelocation" id="hidelocation" value='<s:property value="hidelocation"/>'>


<!-- out -->
<input type="hidden" name="hidoutdate" id="hidoutdate" value='<s:property value="hidoutdate"/>'>
<input type="hidden" name=hidouttime id="hidouttime" value='<s:property value="hidouttime"/>'>
<input type="hidden" name="outfuelval" id="outfuelval" value='<s:property value="outfuelval"/>'>


<!-- del --> 
<input type="hidden" name="hiddeldate" id="hiddeldate" value='<s:property value="hiddeldate"/>'> 
<input type="hidden" name="hiddeltime" id="hiddeltime" value='<s:property value="hiddeltime"/>'>
<input type="hidden" name="hiddelfuelval" id="hiddelfuelval" value='<s:property value="hiddelfuelval"/>'>


<!-- driver ids -->

<input type="hidden" name="colldriverid" id="colldriverid" value='<s:property value="colldriverid"/>'> 
<input type="hidden" name="deldriverid" id="deldriverid" value='<s:property value="deldriverid"/>'>


<!-- set collection tickval -->
<input type="hidden" name="collectintickval" id="collectintickval" value='<s:property value="collectintickval"/>'>
<input type="hidden" name="delchkval" id="delchkval" value='<s:property value="delchkval"/>'>


<!-- validate out or in  for brachin-->
<div  hidden="true" id="hidevmovedate" name="hidevmovedate" value='<s:property value="hidevmovedate"/>'></div>

<div hidden="true" id="hidevmovetime" name="hidevmovetime" value='<s:property value="hidevmovetime"/>'></div>
<input type="hidden" name="hidevmovekm" id="hidevmovekm" value='<s:property value="hidevmovekm"/>'>







<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
</form>
<div id="collectionwindow">
   <div ></div>
</div>
.<div id="agmtnowindow">
   <div ></div>
</div>
</div>

</body>
</html>