
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<style type="text/css">



</style>
<% String contextPath=request.getContextPath();%>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 

<script type="text/javascript">

$(document).ready(function () {
	
	 $("#indate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	 $("#intime").jqxDateTimeInput({  width: '20%', height: '17px', formatString: 'HH:mm', showCalendarButton: false ,value: new Date()});
 	 $("#jqxDateOut").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#jqxTimeOut").jqxDateTimeInput({  width: '20%', height: '17px', formatString: 'HH:mm', showCalendarButton: false });
	 
	 
	 $("#exdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection: true});
	 $("#extime").jqxDateTimeInput({  width: '20%', height: '17px', formatString: 'HH:mm', showCalendarButton: false ,value: new Date()});
	 $('#collectionwindow').jqxWindow({ width: '60%', height: '54%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Driver Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	  $('#collectionwindow').jqxWindow('close');
	    $('#vehinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Fleet Search' , position: { x: 200, y: 120 }, keyboardCloseKey: 27});
		 $('#vehinfowindow').jqxWindow('close');
		 
		$('#outdriver').dblclick(function(){
		    $('#collectionwindow').jqxWindow('open');
		$('#collectionwindow').jqxWindow('focus');
		 collectionSearchContent('driverSearchGrid.jsp', $('#collectionwindow'));
		});
		 	
		
		   $('#outfleet').dblclick(function(){
		  	    $('#vehinfowindow').jqxWindow('open');
	             $('#vehinfowindow').jqxWindow('focus');
	            vehinfoSearchContent('vehinfo.jsp?groupid='+$('#group').val()+'&branchids='+$('#branchids').val()); 
	            });
		   
		   
		   $('#indate').on('change', function (event) {	   
				if(document.getElementById("eorc").value=="1" || document.getElementById("eorc").value=="2")
				{    
				   var dateout1=new Date($('#indate').jqxDateTimeInput('getDate'));
			  	 
			  		var dateouthidden1=new Date($('#jqxDateOut').jqxDateTimeInput('getDate'));
			
			  		
			  	  		dateout1.setHours(0,0,0,0);
			  		dateouthidden1.setHours(0,0,0,0);
			  		
			  		
			  		if(dateout1<dateouthidden1){
			 
			  			 $.messager.alert('Message',' In Date Cannot be Less than RA Out Date ','warning');    
			  			//document.getElementById("errormsg").innerText="In Date Cannot be Less than RA Out Date";
			  			$('#indate').jqxDateTimeInput('focus'); 
			  	  			return 0;	
			  			
			  		}
				}
			  		
				 });
	$('#intime').on('change', function (event) {	   
		if(document.getElementById("eorc").value=="1" || document.getElementById("eorc").value=="2")
		{    
		   var dateout1=new Date($('#indate').jqxDateTimeInput('getDate'));
	  	 	var timeout1=$('#intime').jqxDateTimeInput('getDate');
	  		var dateouthidden1=new Date($('#jqxDateOut').jqxDateTimeInput('getDate'));
	  		var timeouthidden1=$('#jqxTimeOut').jqxDateTimeInput('getDate');
	  		
	  	  		dateout1.setHours(0,0,0,0);
	  		dateouthidden1.setHours(0,0,0,0);
	  		
	  		
	  		if(dateout1<dateouthidden1){
	 
	  			 $.messager.alert('Message',' In Date Cannot be Less than RA Out Date ','warning');    
	  			//document.getElementById("errormsg").innerText="In Date Cannot be Less than RA Out Date";
	  			$('#indate').jqxDateTimeInput('focus'); 
	  	  			return 0;	
	  			
	  		}
	  		if(dateout1-dateouthidden1==0){
					
		  			if(timeout1.getHours() < timeouthidden1.getHours()){
		  				 $.messager.alert('Message',' In Time Cannot be Less than RA Out Time ','warning');   
		  			//	document.getElementById("errormsg").innerText="In Time Cannot be Less than RA Out Time";
		  				$('#intime').jqxDateTimeInput('focus'); 
		  				return 0;
		  			}
		  			if(timeout1.getHours() == timeouthidden1.getHours()){
		  			if(timeout1.getMinutes() < timeouthidden1.getMinutes()){
		  				 $.messager.alert('Message',' In Time Cannot be Less than RA Out Time ','warning');  
		  				//document.getElementById("errormsg").innerText="In Time Cannot be Less than RA Out Time";
		  				$('#intime').jqxDateTimeInput('focus');
		  				return 0;
		  			}
		  			}
		  			
		  			else{
		  				//document.getElementById("errormsg").innerText="";
		  			}
		  		}
		}
	  
	}); 
	$('#exdate').on('change', function (event) {	   
		if(document.getElementById("eorc").value=="1")
		{    
		   var dateout1=new Date($('#exdate').jqxDateTimeInput('getDate'));
	  	 
	  		var dateouthidden1=new Date($('#indate').jqxDateTimeInput('getDate'));
	  		
	  		
	  	  		dateout1.setHours(0,0,0,0);
	  		dateouthidden1.setHours(0,0,0,0);
	  		
	  		
	  		if(dateout1<dateouthidden1){
	 
	  			 $.messager.alert('Message','Out Date Cannot be Less than In  Date ','warning');  
	  			//document.getElementById("errormsg").innerText="Out Date Cannot be Less than In  Date";
	  			$('#exdate').jqxDateTimeInput('focus'); 
	  	  			return 0;	
	  			
	  		}
		}
	  
	}); 
	$('#extime').on('change', function (event) {	   
		if(document.getElementById("eorc").value=="1")
		{    
		   var dateout1=new Date($('#exdate').jqxDateTimeInput('getDate'));
	  	 	var timeout1=$('#extime').jqxDateTimeInput('getDate');
	  		var dateouthidden1=new Date($('#indate').jqxDateTimeInput('getDate'));
	  		var timeouthidden1=$('#intime').jqxDateTimeInput('getDate');
	  		
	  	  		dateout1.setHours(0,0,0,0);
	  		dateouthidden1.setHours(0,0,0,0);
	  		
	  		
	  		if(dateout1<dateouthidden1){
	 
	  			 $.messager.alert('Message','Out Date Cannot be Less than In  Date','warning');  
	  			//document.getElementById("errormsg").innerText="Out Date Cannot be Less than In  Date";
	  			$('#exdate').jqxDateTimeInput('focus'); 
	  	  			return 0;	
	  			
	  		}
	  		if(dateout1-dateouthidden1==0){
					
		  			if(timeout1.getHours() < timeouthidden1.getHours()){
		  				$.messager.alert('Message','Out Time Cannot be Less than In Time','warning');  
		  			//	document.getElementById("errormsg").innerText="Out Time Cannot be Less than In Time";
		  				$('#extime').jqxDateTimeInput('focus'); 
		  				return 0;
		  			}
		  			if(timeout1.getHours() == timeouthidden1.getHours()){
		  			if(timeout1.getMinutes() < timeouthidden1.getMinutes()){
		  				$.messager.alert('Message','Out Time Cannot be Less than In Time','warning'); 
		  				//document.getElementById("errormsg").innerText="Out Time Cannot be Less than In Time";
		  				$('#extime').jqxDateTimeInput('focus');
		  				return 0;
		  			}
		  			}
		  			
		  			else{
		  				//document.getElementById("errormsg").innerText="";
		  			}
		  		}
		}
	  
	}); 
});
function getvehinfo(event){
  	 var x= event.keyCode;
  	 if(x==114){
  	  $('#vehinfowindow').jqxWindow('open');
  
     
     vehinfoSearchContent('vehinfo.jsp?groupid='+$('#group').val()+'&branchids='+$('#branchids').val());   }
  	 else{
  		 }
  	 }

   function vehinfoSearchContent(url) {
 
  		 $.get(url).done(function (data) {
  		
  		$('#vehinfowindow').jqxWindow('setContent', data);
  
  	}); 
  	}
   
function collectionSearchContent(url) {
    $.get(url).done(function (data) {
  $('#collectionwindow').jqxWindow('setContent', data);
}); 
}
function getDriver(event){
	 var x= event.keyCode;
   if(x==114){
  	 $('#collectionwindow').jqxWindow('open');
  		$('#collectionwindow').jqxWindow('focus');
  		collectionSearchContent('driverSearchGrid.jsp',  $('#collectionwindow'));
   }
   else{
    } 
}


function funAttachBtn(){
	if ($("#rentaldoc").val()!="") {
		  $("#windowattach").jqxWindow('setTitle',"RAG - "+document.getElementById("rentaldoc").value);
		changeAttachContent("<%=contextPath%>/com/dashboard/Attach.jsp?formCode=RAG&docno="+document.getElementById("rentaldoc").value+"&barchvals="+document.getElementById("branchids").value);		
	} else {
		$.messager.alert('Message','Select a Document....!','warning');
		return;
	}
}
function changeAttachContent(url) {
	$.get(url).done(function (data) {
		    $('#windowattach').jqxWindow('open');
			$('#windowattach').jqxWindow('setContent',data);
			 $('#windowattach').jqxWindow('bringToFront');
}); 
}

function funreload(event)
{
	disitems();
	 var barchval = document.getElementById("cmbbranch").value;
	
 
	  $("#delupdiv").load("delupdateGrid.jsp?barchval="+barchval);
	
	
	}

function funupdate()
{// eorc inkm, infuel
	
	
	 if(document.getElementById("eorc").value=="")
	 {
 
				 
		  $.messager.alert('Message',' Select Type ','warning'); 
		 return 0;
	 }
	 
		if(document.getElementById("eorc").value=="1")
		{ 
			 
			
			 if(document.getElementById("inkm").value=="")
			 {
		 
						 
				  $.messager.alert('Message',' Enter In KM ','warning'); 
				 return 0;
			 }
			
			 if($('#infuel').val()=="")
			 {
				 $.messager.alert('Message',' Select In Fuel','warning'); 
				
				 return 0;
			 }
			 
			 
			
			// outfleet outdriver outkm outfuel		 
					
					 if(document.getElementById("outfleet").value=="")
					 {
				 
								 
						  $.messager.alert('Message','Search Fleet','warning'); 
						 return 0;
					 }
					
					 if($('#outdriver').val()=="")
					 {
						 $.messager.alert('Message','Search Out Driver','warning'); 
						
						 return 0;
					 }
					 var dateout1=new Date($('#indate').jqxDateTimeInput('getDate'));
				  	 	var timeout1=$('#intime').jqxDateTimeInput('getDate');
				  		var dateouthidden1=new Date($('#jqxDateOut').jqxDateTimeInput('getDate'));
				  		var timeouthidden1=$('#jqxTimeOut').jqxDateTimeInput('getDate');
				  		
				  	  		dateout1.setHours(0,0,0,0);
				  		dateouthidden1.setHours(0,0,0,0);
				  		
				  		
				  		if(dateout1<dateouthidden1){
				 
				  			$.messager.alert('Message','In Date Cannot be Less than RA Out Date','warning'); 
				  			//document.getElementById("errormsg").innerText="In Date Cannot be Less than RA Out Date";
				  			$('#indate').jqxDateTimeInput('focus'); 
				  	  			return 0;	
				  			
				  		}
				  		if(dateout1-dateouthidden1==0){
								
					  			if(timeout1.getHours() < timeouthidden1.getHours()){
					  				$.messager.alert('Message','In Time Cannot be Less than RA Out Time','warning'); 
					  				//document.getElementById("errormsg").innerText="In Time Cannot be Less than RA Out Time";
					  				$('#intime').jqxDateTimeInput('focus'); 
					  				return 0;
					  			}
					  			if(timeout1.getHours() == timeouthidden1.getHours()){
					  			if(timeout1.getMinutes() < timeouthidden1.getMinutes()){
					  				$.messager.alert('Message','In Time Cannot be Less than RA Out Time','warning'); 
					  				//document.getElementById("errormsg").innerText="In Time Cannot be Less than RA Out Time";
					  				$('#intime').jqxDateTimeInput('focus');
					  				return 0;
					  			}
					  			}
					  			
					  			else{
					  				//document.getElementById("errormsg").innerText="";
					  			}
					  		}
				  		
				  		
				  		
								
				  		
				  		 var exdate1=new Date($('#exdate').jqxDateTimeInput('getDate'));
					  	 	var extime1=$('#extime').jqxDateTimeInput('getDate');
					  		var indate1=new Date($('#indate').jqxDateTimeInput('getDate'));
					  		var intime1=$('#intime').jqxDateTimeInput('getDate');
					  		
					  		exdate1.setHours(0,0,0,0);
					  		indate1.setHours(0,0,0,0);
					  		
					  		
					  		if(exdate1<indate1){
					 
					  			$.messager.alert('Message','Out Date Cannot be Less than In  Date','warning'); 
					  			//document.getElementById("errormsg").innerText="Out Date Cannot be Less than In  Date";
					  			$('#exdate').jqxDateTimeInput('focus'); 
					  	  			return 0;	
					  			
					  		}
					  		if(exdate1-indate1==0){
									
						  			if(extime1.getHours() < intime1.getHours()){
						  				$.messager.alert('Message','Out Time Cannot be Less than In Time','warning'); 
						  				//document.getElementById("errormsg").innerText="Out Time Cannot be Less than In Time";
						  				$('#extime').jqxDateTimeInput('focus'); 
						  				return 0;
						  			}
						  			if(extime1.getHours() == intime1.getHours()){
						  			if(extime1.getMinutes() < intime1.getMinutes()){
						  				$.messager.alert('Message','Out Time Cannot be Less than In Time','warning'); 
						  				//document.getElementById("errormsg").innerText="Out Time Cannot be Less than In Time";
						  				$('#extime').jqxDateTimeInput('focus');
						  				return 0;
						  			}
						  			}
						  			
						  			else{
						  				//document.getElementById("errormsg").innerText="";
						  			}
						  		}
				  		
				  		
					
				
		}
		
		else if(document.getElementById("eorc").value=="2")
		{ 
			 
			
			 if(document.getElementById("inkm").value=="")
			 {
		 
						 
				  $.messager.alert('Message',' Enter In KM ','warning'); 
				 return 0;
			 }
			
			 if($('#infuel').val()=="")
			 {
				 $.messager.alert('Message',' Select In Fuel','warning'); 
				
				 return 0;
			 }
			 var dateout1=new Date($('#indate').jqxDateTimeInput('getDate'));
		  	 	var timeout1=$('#intime').jqxDateTimeInput('getDate');
		  		var dateouthidden1=new Date($('#jqxDateOut').jqxDateTimeInput('getDate'));
		  		var timeouthidden1=$('#jqxTimeOut').jqxDateTimeInput('getDate');
		  		
		  	  		dateout1.setHours(0,0,0,0);
		  		dateouthidden1.setHours(0,0,0,0);
		  		
		  		
		  		if(dateout1<dateouthidden1){
		 
		  			$.messager.alert('Message','In Date Cannot be Less than RA Out Date','warning'); 
		  			//document.getElementById("errormsg").innerText="In Date Cannot be Less than RA Out Date";
		  			$('#indate').jqxDateTimeInput('focus'); 
		  	  			return 0;	
		  			
		  		}
		  		if(dateout1-dateouthidden1==0){
						
			  			if(timeout1.getHours() < timeouthidden1.getHours()){
			  				$.messager.alert('Message','In Time Cannot be Less than RA Out Time','warning'); 
			  				//document.getElementById("errormsg").innerText="In Time Cannot be Less than RA Out Time";
			  				$('#intime').jqxDateTimeInput('focus'); 
			  				return 0;
			  			}
			  			if(timeout1.getHours() == timeouthidden1.getHours()){
			  			if(timeout1.getMinutes() < timeouthidden1.getMinutes()){
			  				$.messager.alert('Message',' In Time Cannot be Less than RA Out Time','warning'); 
			  				//document.getElementById("errormsg").innerText="In Time Cannot be Less than RA Out Time";
			  				$('#intime').jqxDateTimeInput('focus');
			  				return 0;
			  			}
			  			}
			  			
			  			else{
			  				//document.getElementById("errormsg").innerText="";
			  			}
			  		}
			 
		}
	
	 var outkm=document.getElementById("out_km").value;
		//alert("out"+outkm);
	 	var delkm=document.getElementById("inkm").value;
	   if((parseFloat(delkm)<parseFloat(outkm)))
		   
	 	
	 	{
		   
		   $.messager.alert('Message',' In KM Less Than Retal Out KM','warning'); 
		
		 
		   return 0; 
	 	}
	 
	
	
	
	var rentaldoc=document.getElementById("rentaldoc").value;
	
	var fleetno=document.getElementById("fleetno").value;

	var inkm=document.getElementById("inkm").value;
	var infuel=document.getElementById("infuel").value;
	var indate= $('#indate').val();
	var intime= $('#intime').val();
	 var group=document.getElementById("group").value;
	var vlocation=document.getElementById("vehloca").value;
	
	var branchval=document.getElementById("branchids").value;
	var cldocno=document.getElementById("cldocno").value;
	//down
	//outfleet outdriverid outkm outfuel exdate extime
	var eorc=document.getElementById("eorc").value;
	
	var outfleet=document.getElementById("outfleet").value;
	var outdrvid=document.getElementById("outdriverid").value;
	var outkm=document.getElementById("outkm").value;
	var outfuel=document.getElementById("outfuelval").value; 
	var outloc=document.getElementById("outloc").value; 
	var remarksss=document.getElementById("remarkss").value; 
		var remarkss = remarksss.replace(/ /g, "%20");
	var exdate= $('#exdate').val();
	var extime= $('#extime').val();
    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
   	  
	       
     	if(r==false)
     	  {
     		return false; 
     	  }
     	else{
     		delsave(rentaldoc,fleetno,inkm,infuel,indate,intime,group,vlocation,branchval,cldocno,eorc,outfleet,outdrvid,outkm,outfuel,exdate,extime,outloc,remarkss);
     	}
	     });
	
	
}
	function delsave(rentaldoc,fleetno,inkm,infuel,indate,intime,group,vlocation,branchval,cldocno,eorc,outfleet,outdrvid,outkm,outfuel,exdate,extime,outloc,remarkss)
         {
		
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
		
			 	var items= x.responseText.trim();
			 	//alert(items);
		if(parseInt(items)==11)
			{
				disitems();
				funreload(event);
			 	$.messager.alert('Message', '  Record successfully Updated ', function(r){
					     
				     });     
			 	
			}
		
		
		else if(parseInt(items)==12)
			{
			$.messager.alert('Message', '  Not Updated ', function(r){
			     
		     }); 
			}
		else
			{
			
			}
			 	// eorc,outfleet,outdrvid,outkm,outfuel,exdate,extime
	    }
		}
	     x.open("GET","saveexdata.jsp?rentaldoc="+rentaldoc+"&fleetno="+fleetno+"&inkm="+inkm+"&infuel="+infuel+"&indate="+indate+"&intime="+intime+"&group="+group+"&vlocation="+vlocation+"&branchval="+branchval+"&cldocno="+cldocno+"&eorc="+eorc+"&outfleet="+outfleet+"&outdrvid="+outdrvid+"&outkm="+outkm+"&outfuel="+outfuel+"&exdate="+exdate+"&extime="+extime+'&outloc='+outloc+'&remarkss='+remarkss,true);
	     x.send();
		
		}
	
	function disitems()
	{
		
		
		   $("#remarkss").prop("readonly", true);
		
		   $("#outfuel").prop("disabled", true);
 		       $("#eorc").prop("disabled", true);
 		   //indate intime   exdate extime
 		    $("#indetailss input").prop("disabled", true);
		    $("#indetailss select").prop("disabled", true);
		   $('#indate').jqxDateTimeInput({ disabled: true});
		   $('#intime').jqxDateTimeInput({ disabled: true});
		   
	 		$("#outdetailss input").prop("disabled", true);
   		    $("#outdetailss select").prop("disabled", true);
   		   $('#exdate').jqxDateTimeInput({ disabled: true});
   		   $('#extime').jqxDateTimeInput({ disabled: true});
		
   		document.getElementById("eorc").value="";
	    document.getElementById("indriver").value="";
		document.getElementById("inkm").value="";
		document.getElementById("infuel").value="";
		document.getElementById("remarkss").value="";
	
		document.getElementById("outfleet").value="";
		document.getElementById("outdriver").value="";
	    document.getElementById("outkm").value="";
		document.getElementById("outfuel").value="";
		document.getElementById("outfuelval").value="";
	    document.getElementById("outloc").value="";
		document.getElementById("outdriverid").value="";
		
		document.getElementById("cldocno").value="";
		document.getElementById("vehloca").value="";
	    document.getElementById("group").value="";
		document.getElementById("rentaldoc").value="";
		document.getElementById("fleetno").value="";
	    document.getElementById("out_km").value="";
		document.getElementById("branchids").value="";
		
   		 
   		$('#exdate').val(new Date());
   		$('#extime').val(new Date());
   			
   		$('#jqxDateOut').val(new Date());
	      $('#jqxTimeOut').val(new Date());
	 	
	$('#indate').val(new Date());
	$('#intime').val(new Date());
		
		

	 $('#driverUpdate').attr("disabled",true);
		
	 $('#attachbtns').attr("disabled",true);
		
	}
    function isNumber(evt) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
        	{
        	
        
        	 $.messager.alert('Message',' Enter Numbers Only ','warning');    
        	
        	 
            return false;
        	}
        
        return true;
    }	
function funchkkm()
	{
		    var outkm=document.getElementById("out_km").value;
			//alert("out"+outkm);
		 	var inkm=document.getElementById("inkm").value;
		   if((parseFloat(inkm)<parseFloat(outkm)))
			   
		 	
		 	{
			   
			   $.messager.alert('Message',' In KM Less Than RA Out KM','warning'); 
			
			 
			   return 0;
		 	}
	 
		
	}
function change()
{
	if(document.getElementById("eorc").value=="1")
		{
		
		 $("#indetailss input").prop("disabled", false);
		    $("#indetailss select").prop("disabled", false);
		   $('#indate').jqxDateTimeInput({ disabled: false});
		   $('#intime').jqxDateTimeInput({ disabled: false});
		   
			 $("#remarkss").prop("readonly", false);
			 
		   
			$("#outdetailss input").prop("disabled", false);
			    $("#outdetailss select").prop("disabled", false);
			   $('#exdate').jqxDateTimeInput({ disabled: false});
			   $('#extime').jqxDateTimeInput({ disabled: false});
		
		}
	else if(document.getElementById("eorc").value=="2")
		{
		 $("#remarkss").prop("readonly", false);
	    $("#indetailss input").prop("disabled", false);
	    $("#indetailss select").prop("disabled", false);
	   $('#indate').jqxDateTimeInput({ disabled: false});
	   $('#intime').jqxDateTimeInput({ disabled: false});
	   
		$("#outdetailss input").prop("disabled", true);
		    $("#outdetailss select").prop("disabled", true);
		   $('#exdate').jqxDateTimeInput({ disabled: true});
		   $('#extime').jqxDateTimeInput({ disabled: true});
		}
	else {
		 $("#remarkss").prop("readonly", true);
    $("#indetailss input").prop("disabled", true);
    $("#indetailss select").prop("disabled", true);
   $('#indate').jqxDateTimeInput({ disabled: true});
   $('#intime').jqxDateTimeInput({ disabled: true});
   
     	$("#outdetailss input").prop("disabled", true);
	    $("#outdetailss select").prop("disabled", true);
	   $('#exdate').jqxDateTimeInput({ disabled: true});
	   $('#extime').jqxDateTimeInput({ disabled: true});
	}
	
	}

	
	function funExportBtn(){
		  // $("#delupdategrid").jqxGrid('exportdata', 'xls', 'RAG-Exchange Or Cancel');
		   
		   
		   if(parseInt(window.parent.chkexportdata.value)=="1")
		    {
		    JSONToCSVCon(datasssss, 'RAG-Exchange Or Cancel', true);
		    }
		   else
		    {
		    $("#delupdategrid").jqxGrid('exportdata', 'xls', 'RAG-Exchange Or Cancel');
		    }
		   
		   
		   
		   
		   
		   
		 }	
	
</script>
</head>
<body onload="getBranch();disitems();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
		<jsp:include page="../../heading.jsp"></jsp:include>
<!-- 		 <tr><td colspan="2"></td></tr> -->
	 <tr><td colspan="2">
	 <table width="100%">
	 <tr > <td  align="right"><label class="branch">Type</label></td><td align="left">
 <select name="eorc" id="eorc" style="width:70%;" name="eorc"  value='<s:property value="eorc"/>' onchange="change()"> 
       <option value="" selected>-Select-</option>  
      <option value="1">Exchange</option>
                   <option value="2">Cancel</option> 


</select></td></tr>
</table>
</td></tr>
	<tr>
	<td colspan="2"><div id='paychaaaaa' style="width: 100% ; align:right; height: 150px;"><fieldset><legend ><b>In Details</b></legend> 
	<table width="100%" id="indetailss">
<tr><td align="right"><label class="branch">Driver</label></td><td  align="left" ><input type="text" name="indriver" id="indriver" style="height:20px;width:100%;" value='<s:property value="indriver"/>' readonly="readonly">
 
<tr> <td  align="right"><label class="branch">KM</label></td> <td align="left"><input type="text" name="inkm" id="inkm"  style="height:20px;width:80%;" value='<s:property value="inkm"/>' onblur="funchkkm()"   onkeypress="javascript:return isNumber (event)"></td></tr>
 
<tr> <td  align="right"><label class="branch">Fuel</label></td><td align="left">
 <select name="infuel" id="infuel" style="width:80%;"   value='<s:property value="infuel"/>'>
       <option value="" selected>-Select-</option>  
     <option value=0.000 >Level 0/8</option>
     <option value=0.125>Level 1/8</option>
     <option value=0.250>Level 2/8</option>
     <option value=0.375>Level 3/8</option>
     <option value=0.500>Level 4/8</option>
     <option value=0.625>Level 5/8</option>
               <option value=0.750>Level 6/8</option>
                   <option value=0.875>Level 7/8</option> 
                   <option value=1.000>Level 8/8</option>


</select></td></tr>

 <tr><td  align="right" ><label class="branch">Date</label></td><td align="left"><div id='indate' name='indate' value='<s:property value="indate"/>'></div> 
                  </td></tr>
  <tr><td  align="right"><label class="branch">Time</label></td><td align="left" ><div  style="width: 100% ;"  id='intime' name='intime' value='<s:property value="intime"/>'  ></div>
                </td></tr>
                  
    </table>               
      </fieldset> 
              
          </div></td> 
	</tr>
                  
   
<!-- ----------------------------------------------------------------------------------------------  -->            
       <tr> 
	<td colspan="2"><div id='ss' style="width: 100% ; align:right; height: 180px;"><fieldset><legend><b>Out Details</b></legend> 
	<table width="100%" id="outdetailss"> 
	 <tr><td  align="right" ><label class="branch">Date</label></td><td align="left"><div id='exdate' name='exdate' value='<s:property value="exdate"/>'></div> </td></tr>
     <tr><td  align="right"><label class="branch">Time</label></td><td align="left" ><div id='extime' name='extime' value='<s:property value="extime"/>'  ></div> </td></tr>
	 <tr> <td  align="right"><label class="branch">Fleet</label></td> <td align="left"><input type="text" name="outfleet" id="outfleet"   style="height:20px;width:70%;" readonly="readonly" placeholder="Press F3 Search" value='<s:property value="outfleet"/>'  onkeydown="getvehinfo(event)"></td></tr>          
                   <tr><td align="right"><label class="branch">Driver</label></td><td  align="left" ><input type="text" name="outdriver"  placeholder="Press F3 Search"  id="outdriver" style="height:20px;width:100%;" value='<s:property value="outdriver"/>' readonly="readonly" onkeydown="getDriver(event)">
 
<tr> <td  align="right"><label class="branch">KM</label></td> <td align="left"><input type="text" name="outkm" id="outkm"  style="height:20px;width:80%;" readonly="readonly" value='<s:property value="outkm"/>' ></td></tr>
 
<tr> <td  align="right"><label class="branch">Fuel</label></td><td align="left">
 <select name="del_Fuel" id="outfuel" style="width:80%;" name="outfuel"  value='<s:property value="outfuel"/>'>
      <option value="" selected>-Select-</option>  
     <option value=0.000 >Level 0/8</option>
     <option value=0.125>Level 1/8</option>
     <option value=0.250>Level 2/8</option>
     <option value=0.375>Level 3/8</option>
     <option value=0.500>Level 4/8</option>
     <option value=0.625>Level 5/8</option>
     <option value=0.750>Level 6/8</option>
     <option value=0.875>Level 7/8</option>
     <option value=1.000>Level 8/8</option>      
 

</select></td></tr>

           </table>              
      </fieldset>            
          </div></td> 
	</tr>           
               
<tr><td align="right"><label class="branch">Remarks</label></td><td  align="left" ><input type="text" name="remarkss" id="remarkss" style="height:20px;width:100%;" value='<s:property value="remarkss"/>' >                  
            
 <tr><td  align="center" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="Button" name="driverUpdate" id="driverUpdate" class="myButton" value="Update" onclick="funupdate()">
 <input type="Button" name="attachbtns" id="attachbtns" class="myButton" value="Attach" onclick="funAttachBtn()"></td> </tr>
  </table>
   </fieldset>

</td>
<td width="80%">
	<table width="100%">
		<tr>
			  <td><div id="delupdiv"><jsp:include page="delupdateGrid.jsp"></jsp:include></div></td> 
			  </tr>
			  <%-- <tr>
			  <td><div hidden="true">	<jsp:include page="../../../../header.jsp"></jsp:include></div></td>
			  
		</tr> --%>
	</table>
</tr>
</table>
 <input type="hidden" name="rentaldoc" id="rentaldoc" style="height:20px;width:70%;" value='<s:property value="rentaldoc"/>' >

<input type="hidden" name="fleetno" id="fleetno" style="height:20px;width:70%;" value='<s:property value="fleetno"/>' >       

 <input type="hidden" name="out_km" id="out_km" style="height:20px;width:70%;" value='<s:property value="out_km"/>' >
<%-- <input type="hidden" name="out_fuel" id="out_fuel" style="height:20px;width:70%;" value='<s:property value="out_fuel"/>' >  --%>

 <div hidden="true" id='jqxDateOut' name='jqxDateOut' value='<s:property value="jqxDateOut"/>'></div>
<div hidden="true" id='jqxTimeOut' name='jqxTimeOut' value='<s:property value="jqxTimeOut"/>'></div>


<input type="hidden" name="branchids" id="branchids" style="height:20px;width:70%;" value='<s:property value="branchids"/>' > 
<input type="hidden" name="group" id="group" style="height:20px;width:70%;" value='<s:property value="group"/>' >
<input type="hidden" name="vehloca" id="vehloca" style="height:20px;width:70%;" value='<s:property value="vehloca"/>' >
	<input type="hidden" name="cldocno" id="cldocno" style="height:20px;width:70%;" value='<s:property value="cldocno"/>' >  
<!--  -->
	
	<input type="hidden" name="outdriverid" id="outdriverid" style="height:20px;width:70%;" value='<s:property value="outdriverid"/>' > 
		<input type="hidden" name="outloc" id="outloc" style="height:20px;width:70%;" value='<s:property value="outloc"/>' > 
		
		<input type="hidden" name="outfuelval" id="outfuelval" style="height:20px;width:70%;" value='<s:property value="outfuelval"/>' > 
<div id="collectionwindow">
   <div ></div>
</div>
  <div id="vehinfowindow">
   <div ></div>
</div>   
</div>
</div>
</body>

