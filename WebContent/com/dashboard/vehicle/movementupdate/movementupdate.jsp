
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
<script type="text/javascript">
 
$(document).ready(function () {
	 
	 $("#dateout").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	 $("#timeout").jqxDateTimeInput({  width: '30%', height: '17px', formatString: 'HH:mm', showCalendarButton: false ,value: new Date()});
	 $("#datein").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#timein").jqxDateTimeInput({  width: '30%', height: '17px', formatString: 'HH:mm', showCalendarButton: false,value: new Date() });
	
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	 $('#fleetwindow').jqxWindow({ width: '30%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Fleet Search' , position: { x: 200, y: 60 }, keyboardCloseKey: 27});
	 $('#fleetwindow').jqxWindow('close');
	     
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
     
	     
	 $('#fleetno').dblclick(function(){
	  	    $('#fleetwindow').jqxWindow('open');
	   
	       fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow')); 
    });
	 
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	    
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	 
	 
	 $('#todate').on('change', function (event) {
			
		   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  }   
	 });
	 
	 
	 
	 

	 
	 $('#dateout').on('change', function (event) {
		 if($("#status").val()=="IN")
			{ 
		   var outdate=new Date($('#dateout').jqxDateTimeInput('getDate'));
		 
		 
		 	 var indate=new Date($('#datein').jqxDateTimeInput('getDate'));  
		 	outdate.setHours(0,0,0,0); 
		 	indate.setHours(0,0,0,0); 
		   if(outdate>indate){
			   $.messager.alert('Message',' Out Date Cannot Be More Than In Date','warning');   
		
		   return false;
		  }   
		
		 
		
		   var indate1=new Date($('#dateout').jqxDateTimeInput('getDate'));     
		  var agmtdate1=new Date($('#datein').jqxDateTimeInput('getDate'));  
		 
		   var intime1=new Date($('#timeout').jqxDateTimeInput('getDate'));   
			  var agmttime1=new Date($('#timein').jqxDateTimeInput('getDate'));  

			  indate1.setHours(0,0,0,0); 
			  agmtdate1.setHours(0,0,0,0); 
			   if(indate1.valueOf()==agmtdate1.valueOf()){
			 
			  var out=intime1.getHours();
			  var del=agmttime1.getHours();
			
			  if(out > del){
				  $.messager.alert('Message',' Out Time Cannot be More than In Time ','warning');   
				  
			  // alert("Delivery Time Cannot be Less than Out Time");
			    return false;
			   }
			   if(out==del){
			    if(intime1.getMinutes()>agmttime1.getMinutes()){
			    	  $.messager.alert('Message',' Out Time Cannot be More than In Time ','warning');   
			    	
			   
			     return false;
			    }
			   }
			  }
			  
			} 
	
	       });
	 
	 
	  $('#timeout').on('change', function (event) { 	
		
			 if($("#status").val()=="IN")
				{ 
		   var indate1=new Date($('#dateout').jqxDateTimeInput('getDate'));     
		  var agmtdate1=new Date($('#datein').jqxDateTimeInput('getDate'));  
		 
		  var intime1=new Date($('#timeout').jqxDateTimeInput('getDate'));   
		  var agmttime1=new Date($('#timein').jqxDateTimeInput('getDate'));  

		  indate1.setHours(0,0,0,0); 
		  agmtdate1.setHours(0,0,0,0); 
		   if(indate1>agmtdate1){
			   $.messager.alert('Message',' Out Date Cannot Be More Than In Date','warning');   
			 
		 
		   return false;
		  }   
		
		   if(indate1.valueOf()==agmtdate1.valueOf()){
		 
		  var out=intime1.getHours();
		  var del=agmttime1.getHours();
		
		  if(out > del){
			  $.messager.alert('Message',' Out Time Cannot Be More Than In Time ','warning');   
			  
		  
		    return false;
		   }
		   if(out==del){
		    if(intime1.getMinutes()>agmttime1.getMinutes()){
		    	  $.messager.alert('Message',' Out Time Cannot Be More Than In Time ','warning');   
		    	
		   
		     return false;
		    }
		   }
		  }
		  
		 	} 
		  
		  
	
	       });
	 
	 
	  $('#datein').on('change', function (event) {
		  if($("#status").val()=="IN")
			{
			   var outdate=new Date($('#dateout').jqxDateTimeInput('getDate'));
			 
			 
			 	 var indate=new Date($('#datein').jqxDateTimeInput('getDate'));  
			 	outdate.setHours(0,0,0,0); 
			 	indate.setHours(0,0,0,0); 
			   if(outdate>indate){
				   $.messager.alert('Message',' In Date Cannot Be Less Than Out Date','warning');   
				
			   return false;
			  }   
			
		 
			var indate1=new Date($('#dateout').jqxDateTimeInput('getDate'));     
			  var agmtdate1=new Date($('#datein').jqxDateTimeInput('getDate'));  
			 
			  var intime1=new Date($('#timeout').jqxDateTimeInput('getDate'));  
			  var agmttime1=new Date($('#timein').jqxDateTimeInput('getDate')); 

			  indate1.setHours(0,0,0,0); 
			  agmtdate1.setHours(0,0,0,0); 
			   if(indate1.valueOf()==agmtdate1.valueOf()){
			 
			  var out=intime1.getHours();
			  var del=agmttime1.getHours();
			
			  if(out > del){
				  $.messager.alert('Message',' In Time Cannot Be Less Than Out Time ','warning');   
				  
			  
			    return false;
			   }
			   if(out==del){
			    if(intime1.getMinutes()>agmttime1.getMinutes()){
			    	  $.messager.alert('Message',' IN Time Cannot Be Less Than Out Time ','warning');   
			    	
			   
			     return false;
			    }
			   }
			  }
			}
		
		       });
		 
		 
		  $('#timein').on('change', function (event) { 	
			
			  if($("#status").val()=="IN")
				{
			   var indate1=new Date($('#dateout').jqxDateTimeInput('getDate'));      
			  var agmtdate1=new Date($('#datein').jqxDateTimeInput('getDate'));  
			 
			  var intime1=new Date($('#timeout').jqxDateTimeInput('getDate'));  
			  var agmttime1=new Date($('#timein').jqxDateTimeInput('getDate'));  
			  indate1.setHours(0,0,0,0); 
			  agmtdate1.setHours(0,0,0,0); 
			  
			   if(indate1>agmtdate1){
				   $.messager.alert('Message',' In Date Cannot Be Less Than Out Date','warning');   
				 
		          return false;
			  }   
			
			   if(indate1.valueOf()==agmtdate1.valueOf()){
			 
			  var out=intime1.getHours();
			  var del=agmttime1.getHours();
			
			  if(out > del){
				  $.messager.alert('Message',' In Time Cannot Be Less Than Out Time ','warning');   
				  
			 
			    return false;
			   }
			   if(out==del){
			    if(intime1.getMinutes()>agmttime1.getMinutes()){
			    	  $.messager.alert('Message',' IN Time Cannot Be Less Than Out Time ','warning');   
			    	
			   
			     return false;
			    }
			   }
			  }
			  
				} 
			  
			  
		
		       });
		 
	 
	 
	 
	 
	 
	 
	 
	 
	 
    
});
function outchkkm()

{
	
	  if($("#status").val()=="IN")
		{	
	
var outkm=document.getElementById("outkm").value;
var inkm=document.getElementById("inkm").value;
if((parseFloat(inkm)<parseFloat(outkm)))
   
	
	{
   
   $.messager.alert('Message',' Out KM More Than In KM','warning'); 

 
   return 0;
	}
	
		}
	
}



function inchkkm()

{
var outkm=document.getElementById("outkm").value;
var inkm=document.getElementById("inkm").value;
if((parseFloat(inkm)<parseFloat(outkm)))
   
	
	{
   
   $.messager.alert('Message',' In KM Less Than Out KM','warning'); 

 
   return 0;
	}
}
function fundeletedata()
{
	
	

	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		
		if(x.readyState==4 && x.status==200)
			
			{
			
			var temp=x.responseText;
			
			if(parseInt(temp)==1)
				{
				  $.messager.alert('Message',' Only Last Vehicle Status can be Deleted ','warning'); 
	  
				   return 0;
				
				}
			
			else
				{
				
				var vmrdocnos=document.getElementById("vmrdocno").value;
				   $.messager.confirm('Message', 'Do you want to Delete all Entries of Movement Docno '+vmrdocnos, function(r){
				     	  
				       
			        	if(r==false)
			        	  {
			        		return false; 
			        	  }
			        	else{
			        		fundeletedatas();;
			        	   }
		 });
				
				
				}
			
			
			
			}
		
	}
	x.open("GET","chkforupdate.jsp?fleetno="+fleetno+"&vmdocno="+vmdocno+"&status="+status);
			  x.send();
	}

function fundeletedatas()
{

	
	var fleetno=document.getElementById("fleetno").value;
	var vmdocno=document.getElementById("vmdocno").value;
	
	var dtype=document.getElementById("dtype").value;
	
	var vmrdocno=document.getElementById("vmrdocno").value;
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		
		if(x.readyState==4 && x.status==200)
			
			{
			
			var temp=x.responseText;
		//	alert(temp);
			if(parseInt(temp)==10)
				{ funreload(event);
				  $.messager.alert('Message',' Record Successfully Deleted ','warning'); 
				 
				   return 0;
				
				}
			
			else
				{
				
				  $.messager.alert('Message','  Not Deleted ','warning'); 
				  
				   return 0;
				
				}
			
			
			
			}
		
	}
	x.open("GET","deletedata.jsp?fleetno="+fleetno+"&vmdocno="+vmdocno+"&dtype="+dtype+"&vmrdocno="+vmrdocno);
			  x.send();
	}


function funupadte()
{
	var fleetno=document.getElementById("fleetno").value;
	var vmdocno=document.getElementById("vmdocno").value;
	var status=document.getElementById("status").value;
	
 updatechk(fleetno,vmdocno,status);
	
	}

function updatechk(fleetno,vmdocno,status)
{
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		
		if(x.readyState==4 && x.status==200)
			
			{
			
			var temp=x.responseText;
			
			if(parseInt(temp)==1)
				{
				  $.messager.alert('Message',' Only Last Vehicle Status can be Updated ','warning'); 
	  
				   return 0;
				
				}
			
			else
				{
				
				updatemovevalidate();
				
				}
			
			
			
			}
		
	}
	x.open("GET","chkforupdate.jsp?fleetno="+fleetno+"&vmdocno="+vmdocno+"&status="+status);
			  x.send();
	}


function updatemovevalidate()
{
	var maindate = $('#dateout').jqxDateTimeInput('getDate');
	var dates = new Date();
	
	   
		  maindate.setHours(0,0,0,0); 
		  dates.setHours(0,0,0,0); 
		  
		   if(maindate>dates){
			   $.messager.alert('Warning',"Future Date, Transaction Restricted. ");
			 
			   return 0; 
		  }   


	  
	
	 if(document.getElementById("outkm").value=="")
	 {
 
				 
		  $.messager.alert('Message',' Enter Out KM ','warning'); 
		 return 0;
	 }
	
	 if($('#outfuel').val()=="")
	 {
		 $.messager.alert('Message',' Select Out Fuel','warning'); 
		
		 return 0;
	 }

	  if($("#status").val()=="IN")
		{
			
	      	 
	   var indate1=new Date($('#dateout').jqxDateTimeInput('getDate'));     
		  var agmtdate1=new Date($('#datein').jqxDateTimeInput('getDate'));  
		 
		  var intime1=new Date($('#timeout').jqxDateTimeInput('getDate'));   
		  var agmttime1=new Date($('#timein').jqxDateTimeInput('getDate'));  
		  indate1.setHours(0,0,0,0); 
		  agmtdate1.setHours(0,0,0,0); 
		  
		   if(indate1>agmtdate1){
			   $.messager.alert('Message',' Out Date Cannot Be More Than In Date','warning');   
			 
		 
		   return false;
		  }   
		
		   if(indate1.valueOf()==agmtdate1.valueOf()){
		 
		  var out=intime1.getHours();
		  var del=agmttime1.getHours();
		
		  if(out > del){
			  $.messager.alert('Message',' Out Time Cannot Be More Than In Time ','warning');   
			  
		  
		    return false;
		   }
		   if(out==del){
		    if(intime1.getMinutes()>agmttime1.getMinutes()){
		    	  $.messager.alert('Message',' Out Time Cannot Be More Than In Time ','warning');   
		    	
		   
		     return false;
		    }
		   }
		  } 
		}
			  if($("#status").val()=="IN")
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
					 var outkm=document.getElementById("outkm").value;
					 var inkm=document.getElementById("inkm").value;
					 if((parseFloat(inkm)<parseFloat(outkm)))
					    
					 	
					 	{
					    
					    $.messager.alert('Message',' In KM Less Than Out KM','warning'); 

					  
					    return 0;
					 	}
			 
			   var indate1=new Date($('#dateout').jqxDateTimeInput('getDate'));      
			  var agmtdate1=new Date($('#datein').jqxDateTimeInput('getDate'));  
			 
			  var intime1=new Date($('#timeout').jqxDateTimeInput('getDate'));  
			  var agmttime1=new Date($('#timein').jqxDateTimeInput('getDate'));  
			  indate1.setHours(0,0,0,0); 
			  agmtdate1.setHours(0,0,0,0); 
			  
			   if(indate1>agmtdate1){
				   $.messager.alert('Message',' In Date Cannot Be Less Than Out Date','warning');   
				 
		          return false;
			  }   
			
			   if(indate1.valueOf()==agmtdate1.valueOf()){
			 
			  var out=intime1.getHours();
			  var del=agmttime1.getHours();
			
			  if(out > del){
				  $.messager.alert('Message',' In Time Cannot Be Less Than Out Time ','warning');   
				  
			 
			    return false;
			   }
			   if(out==del){
			    if(intime1.getMinutes()>agmttime1.getMinutes()){
			    	  $.messager.alert('Message',' IN Time Cannot Be Less Than Out Time ','warning');   
			    	
			   
			     return false;
			    }
			   }
			  }
	 
				}
				 
			    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
			     	  
				       
			     	if(r==false)
			     	  {
			     		return false; 
			     	  }
			     	else{	  
			  
			  updatemovedate();
			     	}
			    });
			    
			  
			  
			}

function updatemovedate()
{
	var fleetno=document.getElementById("fleetno").value; 
	var vmdocno=document.getElementById("vmdocno").value;
	var status=document.getElementById("status").value;
	
	//out
 	var dateout= $('#dateout').val();
	var timeout= $('#timeout').val();
	var outkm=document.getElementById("outkm").value;
	var outfuel=document.getElementById("outfuel").value;
	
	//in
 	var datein= $('#datein').val();
	var timein= $('#timein').val();
	var inkm=document.getElementById("inkm").value;
	var infuel=document.getElementById("infuel").value;
	

	
	
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		
		if(x.readyState==4 && x.status==200)
			
			{
			
			var temp=x.responseText;
			
			if(parseInt(temp)==1)
				{
				  $.messager.alert('Message','Record successfully Updated','warning'); 
	  
				  disitems();
				  funreload(event);
				}
			
			
			else if(parseInt(temp)==10)
				{
				
				 $.messager.alert('Message','Your Secure Session Has Expired ..','warning'); 
				 return 0;
				 
				}
			
			else
				{
				$.messager.alert('Message','Not Updated','warning'); 
				  
				   return 0;
				 
				
				}
			
			
			
			}
		
	} 
	x.open("GET","savemovementdata.jsp?fleetno="+fleetno+"&vmdocno="+vmdocno+"&status="+status+"&dateout="+dateout+"&timeout="+timeout+"&outkm="+outkm+"&outfuel="+outfuel+"&datein="+datein+"&timein="+timein+"&inkm="+inkm+"&infuel="+infuel);
			  x.send();
	}


function fleetSearchContent(url) {
 
 		 $.get(url).done(function (data) {
 			 
 			 $('#fleetwindow').jqxWindow('open');
 		$('#fleetwindow').jqxWindow('setContent', data);
 
 	}); 
 	} 

function getfleetdata(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#fleetwindow').jqxWindow('open');


	  fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow'));     }
	 else{
		 }
	 }

function funreload(event)
{
	
	disitems();
	
	 var fleetno = document.getElementById("fleetno").value;

	  if(fleetno=="")
		 {
		   $.messager.alert('Message','Search Fleet  ','warning'); 
		   return 0;
		 }
	 else
		 {
		  
		  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			 
		 
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate'));  
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  } 
		   else{
			    
			   
     var fromdate= $("#fromdate").val();
	 var todate= $("#todate").val();
	 $("#overlay, #PleaseWait").show();
	  $("#vehdiv").load("movementupdateGrid.jsp?fleetno="+fleetno+"&fromdate="+fromdate+"&todate="+todate);
		   }
		 }
	
	}
function hiddenbrh(){
	
	$("#branchlabel").attr('hidden',true);
	$("#branchdiv").attr('hidden',true);
 
	
}
function funExportBtn(){
	   $("#vehmovement").jqxGrid('exportdata', 'xls', 'Movement Update');
	 }

function isNumber(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
    	{
    	
    	
  	  $.messager.alert('Message', 'Enter Numbers Only');
    	
 	  
       
        return false;
    	}
  
    return true;
}


function disitems()
{
	document.getElementById("status").value="";
	document.getElementById("vmrdocno").value="";
	document.getElementById("vmrdocno").value="";

	document.getElementById("inkm").value="";
	document.getElementById("outkm").value="";
	document.getElementById("outfuel").value="";
	document.getElementById("infuel").value="";

 
	
	$('#dateout').val(new Date());
	$('#timeout').val(new Date());

 
	$('#datein').val(new Date());
	$('#timein').val(new Date());
	
	
	 $("#in *").attr("disabled", "disabled");
	 $("#out *").attr("disabled", "disabled");
	 $('#dateout').jqxDateTimeInput({ disabled: true});
	 $('#datein').jqxDateTimeInput({ disabled: true});
	 
	 
	 
	 $("#savedata").attr("disabled", true);
	 $("#deletedata").attr("disabled", true);
	 
	 
	}


</script>
</head>
<body onload="hiddenbrh();disitems();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	 
	 
	 
	  <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div></td></tr>
       	 
       	  <tr><td align="right"><label class="branch">Fleet</label></td>
	 <td align="left"><input type="text" id="fleetno" style="height:20px;width:61%;" name="fleetno" placeholder="Press F3 To Search" onfocus="this.placeholder = ''" readonly="readonly" value='<s:property value="fleetno"/>' onkeydown="getfleetdata(event);" > </td></tr>
	 
       	 
 
   <tr> <td colspan="2">
<!-- 	<fieldset> -->
 
<table width="100%"  >
<tr><td>
	
	
	
	<div id="out" style="width: 100% ; align:left; height: 120px;  "  > 
		<fieldset>
	<legend>Out Details</legend> 
<table width="100%" >
 <tr><td  align="right" ><label class="branch">Date</label></td><td align="left"><div id='dateout' name='dateout' value='<s:property value="dateout"/>'></div>
                 
  <tr><td  align="right"><label class="branch">Time</label></td><td align="left" ><div id='timeout'  style="height:20px;width:100%;" name='timeout' value='<s:property value="timeout"/>'  ></div>
                   
<tr> <td  align="right"><label class="branch">KM</label></td> <td align="left"><input type="text" name="outkm" id="outkm"  style="height:20px;width:70%;" value='<s:property value="outkm"/>' onblur="outchkkm()"  onkeypress="javascript:return isNumber (event)"></td></tr>
 
<tr> <td  align="right"><label class="branch">Fuel</label></td><td align="left">
 <select  id="outfuel" style="width:70%;" name="outfuel"  value='<s:property value="outfuel"/>'>
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

</div>

</td>
 <tr> 




 <tr> 
	<td colspan="2"><div id="in" style="width: 100% ; align:left; height: 120px;">
	<fieldset>
	<legend>In Details</legend> 
<table width="100%" >
 <tr><td  align="right" ><label class="branch">Date</label></td><td align="left"><div id='datein' name='datein' value='<s:property value="datein"/>'></div>
                 
  <tr><td  align="right"><label class="branch">Time</label></td><td align="left" ><div id='timein' name='timein' value='<s:property value="timein"/>'  ></div>
                   
<tr> <td  align="right"><label class="branch">KM</label></td> <td align="left"><input type="text" name="inkm" id="inkm"  style="height:20px;width:70%;" value='<s:property value="inkm"/>' onblur="inchkkm()"  onkeypress="javascript:return isNumber (event)"></td></tr>
 
<tr> <td  align="right"><label class="branch">Fuel</label></td><td align="left">
 <select  id="infuel" style="width:70%;" name="infuel"  value='<s:property value="infuel"/>'> 
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
 </div>

</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>

<tr>
<td colspan="2" align="center"><input type="Button" name="savedata" id="savedata" class="myButton" value="Update" onclick="funupadte();">&nbsp;
<input type="Button" name="deletedata" id="deletedata" class="myButton" value="Delete" onclick="fundeletedata();"></td>
</tr>
</table>


<!-- 	</fieldset> -->

<input type="hidden" name="status" id="status" style="height:20px;width:70%;" value='<s:property value="status"/>' >

<input type="hidden" name="dtype" id="dtype" style="height:20px;width:70%;" value='<s:property value="dtype"/>' >

<input type="hidden" name="vmdocno" id="vmdocno" style="height:20px;width:70%;" value='<s:property value="vmdocno"/>' >
<input type="hidden" name="vmrdocno" id="vmrdocno" style="height:20px;width:70%;" value='<s:property value="vmrdocno"/>' >


</td>
 </tr> 
		
	
	
	
	</table>
	</fieldset>
	

</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="vehdiv"><jsp:include page="movementupdateGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>

</div>
<div id="fleetwindow"><div></div>
</div>
</div>
</body>
</html>