
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

<style type="text/css">

 fieldSet {
  -webkit-border-radius: 8px;
  -moz-border-radius: 8px;
  border-radius: 8px;
  border: 1px solid rgb(32,178,170);

 }
 
</style>

<script type="text/javascript">

$(document).ready(function () {
	
	 $("#jqxDateOut").jqxDateTimeInput({ width: '110px', height: '15px', formatString:"dd.MM.yyyy"});

      $("#jqxTimeOut").jqxDateTimeInput({ width: '80%', height: '17px', formatString: 'HH:mm', showCalendarButton: false });
      $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
 
	
    $('#vehinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Fleet Search' , position: { x: 200, y: 120 }, keyboardCloseKey: 27});
	 $('#vehinfowindow').jqxWindow('close');
	  $('#Rentalagentinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Rental Agent Search' ,position: { x: 200, y: 120 }, keyboardCloseKey: 27});
	 $('#Rentalagentinfowindow').jqxWindow('close');
		 
	 $('#Checkoutinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Checkout Search' ,position: { x: 200, y: 120 }, keyboardCloseKey: 27});
	 $('#Checkoutinfowindow').jqxWindow('close');
	   $('#chauffeurinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Driver Search' ,position: { x: 200, y: 70 }, keyboardCloseKey: 27});
	     $('#chauffeurinfowindow').jqxWindow('close');
     $('#driverinfowindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '62%' ,maxWidth: '50%' , title: 'Driver Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
     $('#driverinfowindow').jqxWindow('close'); 	 	
	
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	    
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	 $('#todate').on('change', function (event) {
			
		   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  }   
	 });
	 
	   $('#ratariff_checkout').dblclick(function(){
	  	    $('#Checkoutinfowindow').jqxWindow('open');
	       $('#Checkoutinfowindow').jqxWindow('focus');
	       checkoutSearchContent('searchCheckout.jsp?', $('#Checkoutinfowindow')); 
     });


	   $('#rarenral_Agent').dblclick(function(){
	  	    $('#Rentalagentinfowindow').jqxWindow('open');
	       $('#Rentalagentinfowindow').jqxWindow('focus');
	      rentalagentSearchContent('SearchRentalAgent.jsp?', $('#Rentalagentinfowindow')); 
     });
	   $('#txtfleetno').dblclick(function(){
	  	    $('#vehinfowindow').jqxWindow('open');
             $('#vehinfowindow').jqxWindow('focus');
            vehinfoSearchContent('vehinfo.jsp?groupid='+$('#grpid').val()+'&branchids='+$('#branchids').val()); 
            });
	     $('#radriverlist').dblclick(function(){
		  	    $('#chauffeurinfowindow').jqxWindow('open');
	  
	  chauffeurSearchContent('SearchChauffeur.jsp?', $('#chauffeurinfowindow')); 
		 });
	     
	     $('#clientdrv').dblclick(function(){
		  	    $('#driverinfowindow').jqxWindow('open');
	  
		  	  driverinfoSearchContent('clientDriverSearch.jsp?clientval='+$('#clientid').val()); 
		 });
	     
	      
	          
});

function getcldrv(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#driverinfowindow').jqxWindow('open');

	  driverinfoSearchContent('clientDriverSearch.jsp?clientval='+$('#clientid').val());  }
	 else{
		 }
	 }
function driverinfoSearchContent(url) {
     	 //alert(url);
     		 $.get(url).done(function (data) {
     			 
     			 $('#driverinfowindow').jqxWindow('open');
     		$('#driverinfowindow').jqxWindow('setContent', data);
     
     	}); 
     	} 
function getcheckout(event){
    	 var x= event.keyCode;
    	 if(x==114){
    	  $('#Checkoutinfowindow').jqxWindow('open');
    
     checkoutSearchContent('searchCheckout.jsp?', $('#Checkoutinfowindow'));   }
    	 else{
    		 }
    	 }
	       function checkoutSearchContent(url) {
                 
	                 $.get(url).done(function (data) {
           
		           $('#Checkoutinfowindow').jqxWindow('setContent', data);

          	}); 
	           	}
	       
	       
	       function getrentalAgent(event){
    	       	 var x= event.keyCode;
    	       	 if(x==114){
    	       	  $('#Rentalagentinfowindow').jqxWindow('open');
    	       
    	          
    	       	rentalagentSearchContent('SearchRentalAgent.jsp?', $('#Rentalagentinfowindow'));  }
    	       	 else{
    	       		 }
    	       	 }

      function rentalagentSearchContent(url) {
             //alert(url);
               $.get(url).done(function (data) {
      //alert(data);
	           $('#Rentalagentinfowindow').jqxWindow('setContent', data);

     	}); 
         	}
      
      function getvehinfo(event){
	       	 var x= event.keyCode;
	       	 if(x==114){
	       	  $('#vehinfowindow').jqxWindow('open');
	       
	          
	          vehinfoSearchContent('vehinfo.jsp?groupid='+$('#grpid').val()+'&branchids='+$('#branchids').val());   }
	       	 else{
	       		 }
	       	 }
        
	        function vehinfoSearchContent(url) {
	      
	       		 $.get(url).done(function (data) {
	       		
	       		$('#vehinfowindow').jqxWindow('setContent', data);
	       
	       	}); 
	       	}
	        
	        function getchauffeur(event){
     	       	 var x= event.keyCode;
     	       	 if(x==114){
     	       	  $('#chauffeurinfowindow').jqxWindow('open');
     	       
     	          
     	        chauffeurSearchContent('SearchChauffeur.jsp?', $('#chauffeurinfowindow'));  	 }
     	       	 else{
     	       		 }
     	       	 }

            function chauffeurSearchContent(url) {
  	           
  		    $.get(url).done(function (data) {
  			
  		     $('#chauffeurinfowindow').jqxWindow('setContent', data);
   
          	   }); 
    	      }       
function funreload(event)
{
	var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));

	// out date
		 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 
	 if(fromdates>todates){
		   
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		 
	 return false;
	} 
	 else
		   {
	 var barchval = document.getElementById("cmbbranch").value;
     var fromdate= $("#fromdate").val();
	 var todate= $("#todate").val();
	  $("#overlay, #PleaseWait").show();
		 $("#duedetailsgrid").jqxGrid('clear');
	 $("#bookfollowdiv").load("bookingfollowGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate);

		   }
	
	}
	
function getinfo() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
		//alert(items);
			items = items.split('####');
			
			var srno  = items[0].split(",");
			var process = items[1].split(",");
			var optionsbranch = '<option value="" selected>-- Select -- </option>';
			for (var i = 0; i < process.length; i++) {
				optionsbranch += '<option value="' + srno[i].trim() + '">'
						+ process[i] + '</option>';
			}
			$("select#cmbinfo").html(optionsbranch);
			
		} else {
			//alert("Error");
		}
	}
	x.open("GET","getinfo.jsp", true);
	x.send();
}
function funupdate()
{
	
	
	 if(document.getElementById("cmbinfo").value=="")
	 {
		 $.messager.alert('Message','Select Process ','warning');   
					 
		 return 0;
	 }
	
	 if($('#remarks').val()=="")
	 {
		 $.messager.alert('Message','Enter Remarks ','warning');   
		 return 0;
	 }
	
	 var remarkss = document.getElementById("remarks").value;
	 var nmax = remarkss.length;
		
		
      if(nmax>99)
   	   {
   	  $.messager.alert('Message',' Remarks cannot contain more than 100 characters ','warning');   
   	
			return false; 
   	   
   	 
   	 
   	   } 
      
     var rdocno = document.getElementById("rdocno").value;
 	 var branchids = document.getElementById("branchids").value;
 	 var remarks = document.getElementById("remarks").value;
 	 var cmbinfo = document.getElementById("cmbinfo").value;
 	 var clname=document.getElementById("clname").value;
 	 var reftype=document.getElementById("reftype").value;
 	 var folldate =  $('#date').val();

	    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
	     	  
		        
	     	if(r==false)
	     	  {
	     		return false; 
	     	  }
	     	else{
	     		 savegriddata(rdocno,branchids,remarks,cmbinfo,folldate,clname,reftype);	
	     	}
		     });
	
	
	
}
function savegriddata(rdocno,branchids,remarks,cmbinfo,folldate,clname,reftype)
{
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		
     			
			var items=x.responseText;
			 
			 document.getElementById("rdocno").value="";
			 document.getElementById("branchids").value="";
			 document.getElementById("remarks").value="";
			 document.getElementById("cmbinfo").value="";
			 document.getElementById("clname").value="";
			 document.getElementById("reftype").value=""; 
			 
			  $('#date').val(new Date());
			  
			  $.messager.alert('Message', '  Record Successfully Updated ', function(r){
		 		 
		 		 
			     
		     });
			 funreload(event); 
			 $("#duedetailsgrid").jqxGrid('clear');
			disitems();
			 
			
			}
	}
		
x.open("GET","booksavedata.jsp?rdocno="+rdocno+"&branchids="+branchids+"&remarks="+remarks+"&cmbinfo="+cmbinfo+"&folldate="+folldate+"&clname="+clname+"&reftype="+reftype,true);

x.send();
		
}

function disitems()
{
	
	 $('#date').jqxDateTimeInput({ disabled: true});
	 $('#jqxDateOut').jqxDateTimeInput({ disabled: true});
	 $('#jqxTimeOut').jqxDateTimeInput({ disabled: true});
	 
	 
	  $("#delcharge").prop("disabled", true);
	
	 $('#cmbinfo').attr("disabled",true);
	 $('#remarks').attr("readonly",true);
	 $('#driverUpdate').attr("disabled",true);
	
	 $('#txtfleetno').attr("disabled",true);
	 $('#delivery_chk').attr("disabled",true);
	 $('#radrivercheck').attr("disabled",true);
	 $('#radriverlist').attr("disabled",true);
	 $('#clientdrv').attr("disabled",true);
	 $('#rarenral_Agent').attr("disabled",true);
	 $('#ratariff_checkout').attr("disabled",true);
	 $('#rentalcreate').attr("disabled",true);
	 
	 
	
	 

	
}


function funchangeinfo()
{
	
	 $('#date').jqxDateTimeInput( 'focus');
		
	
	}
	
function funExportBtn(){
	   $("#qutfollowgrid").jqxGrid('exportdata', 'xls', 'Booking Follow Up');
	 }	
	
	
function fundriverdisable(){
	 
	   if (document.getElementById('delivery_chk').checked) {
		   
		   document.getElementById("radriverlist").value="";
		   $("#radriverlist").prop("disabled", false);
		  
		   document.getElementById("radrivercheck").checked = false;
		   $("#radrivercheck").prop("disabled", true);
		   document.getElementById("del_chaufferid").value="";
	       document.getElementById("delivery").value=1; 
	       $("#delcharge").prop("disabled", false);
		   
		  
	   }	else
		   
		   {   
		   $("#radriverlist").prop("disabled", true);
		   $("#delcharge").prop("disabled", true);
		   $("#radrivercheck").prop("disabled", false);
		
		   document.getElementById('radriverlist').value="";
		
		   document.getElementById("del_chaufferid").value="";
		   document.getElementById("delcharge").value="";

	       document.getElementById("delivery").value=0;
			   
		   
		   } 
         }


function funShaffurdisable(){
	  
	    if (document.getElementById('radrivercheck').checked) {
	    	document.getElementById("radriverlist").value="";
	    	
	    	
		   $("#radriverlist").prop("disabled", false);
		   document.getElementById("delivery_chk").checked = false;
		   $("#delivery_chk").prop("disabled", true);
		   
		 //  $("#delivery_chk").prop("clientdrv", true);
		 document.getElementById("clientdrvid").value="";
		 document.getElementById("clientdrv").value="";
		 document.getElementById("del_chaufferid").value="";
		  $("#clientdrv").prop("disabled", true);
		  
		  $("#delcharge").prop("disabled", true);
		     document.getElementById("chuef").value=1;
		     document.getElementById("delcharge").value="";
		  
		
	   }
	   else
		   {
		   $("#radriverlist").prop("disabled", true);
            $("#delivery_chk").prop("disabled", false);
		   document.getElementById('radriverlist').value="";
		   document.getElementById('delcharge').value="";
		   $("#delcharge").prop("disabled", true);

		   document.getElementById("del_chaufferid").value="";
		   $("#delivery_chk").prop("clientdrv", false);
			 document.getElementById("clientdrvid").value="";
			 document.getElementById("clientdrv").value="";
			 document.getElementById("del_chaufferid").value="";
			 
			 
			  $("#clientdrv").prop("disabled", false);
			 
			     document.getElementById("chuef").value=0; 
		   }
}

function chkavailable(valfleet,dateout,timeout)
{
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		
    			
			var items=x.responseText;
	var chkfleet=items.trim();
   
      	 if(chkfleet==1)
				 {
				 $.messager.alert('Message','Fleet Is Not Available ','warning');   
				 return 0;
				 }
			 else
				 {
				    var fleetnos = document.getElementById("txtfleetno").value;
					var rdocno = document.getElementById("rdocno").value;
					 var deldrvss = document.getElementById("del_chaufferid").value;
				 	 var clientdrs = document.getElementById("clientdrvid").value;
				 	 var rantalagt = document.getElementById("tariffrenral_Agentid").value;
				 	 var chkout = document.getElementById("ratariff_checkoutid").value;
				 	 var delivery = document.getElementById("delivery").value;
				 	 var chuef = document.getElementById("chuef").value;
				 	 var delcharge = document.getElementById("delcharge").value;
				 	 var mrano=document.getElementById("mrano").value;
				 	 var branchids = document.getElementById("branchids").value;
				 	 
				 	 
 
				 	 if(delcharge==""|| typeof(delcharge)=="undefined" ||typeof(delcharge)=="NaN")
				 	 {
				 		delcharge=0; 
				 		 
				 	 }
				 	 
				 	
				    $.messager.confirm('Message', 'Do you want to Create A Rental Agreement?', function(r){
				     	  
					        
				     	if(r==false)
				     	  {
				     		return false; 
				     	  }
				     	else{
				     		 creategriddata(rdocno,deldrvss,clientdrs,rantalagt,chkout,delivery,chuef,fleetnos,branchids,dateout,timeout,delcharge,mrano);	
				     	}
					     });
				
				 }
	
			
			}
		
	}
		
x.open("GET","chkavailablefleet.jsp?valfleet="+valfleet+"&dateout="+dateout+"&timeout="+timeout,true);

x.send();
		
}


function funrentalcreate()
{

	var fleetnos = document.getElementById("txtfleetno").value;
	var rdocno = document.getElementById("rdocno").value;
	 var deldrvss = document.getElementById("del_chaufferid").value;
 	 var clientdrs = document.getElementById("clientdrvid").value;
 	 var rantalagt = document.getElementById("tariffrenral_Agentid").value;
 	 var chkout = document.getElementById("ratariff_checkoutid").value;
 	 var delivery = document.getElementById("delivery").value;
 	 var chuef = document.getElementById("chuef").value;
 	 var mrano=document.getElementById("mrano").value;
	 var branchids=document.getElementById("branchids").value;
 	 
 	 if($('#txtfleetno').val()=="")
	 {
		 $.messager.alert('Message','Select Fleet','warning');   
		 return 0;
	 }
 	 
 	
 	 
 	  if ((document.getElementById('delivery_chk').checked)) {
		   
 	  	   var delchrg=document.getElementById("delcharge").value;
 				
 				if(delchrg=="")
 					{
 					 $.messager.alert('Message','Enter Delivery Charge ','warning');   
 		 
 					return 0;
 					}
 				
 		   }
     if ((document.getElementById('delivery_chk').checked)||(document.getElementById('radrivercheck').checked)) {
		   
  	   var drvname=document.getElementById("radriverlist").value;
			
			if(drvname=="")
				{
				 $.messager.alert('Message','Select Driver ','warning');   
	 
				return 0;
				}
			
	   }
 	 
 	if(rantalagt=="")
	 {
		 $.messager.alert('Message','Select Rental Agent ','warning');   
					 
		 return 0;
	 }
	
	 if(chkout=="")
	 {
		 $.messager.alert('Message','Select Checkout','warning');   
		 return 0;
	 }
 	 
	  var valfleetno=document.getElementById("txtfleetno").value;
		var dateout=$('#jqxDateOut').val();
		var timeout=$('#jqxTimeOut').val();
		

		var maindate = $('#jqxDateOut').jqxDateTimeInput('getDate');

		var currentDate = new Date(new Date());
	     
	        if(maindate>currentDate){
	        	 $.messager.alert('Message','Future Date, Transaction Restricted.','warning');   
	        
	        return 0;
	       } 
		
		
		
		chkavailable(valfleetno,dateout,timeout);

}

function creategriddata(rdocno,deldrvss,clientdrs,rantalagt,chkout,delivery,chuef,fleetnos,branchids,dateout,timeout,delcharge,mrano)
{
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		
     			
			var items=x.responseText.trim();
		
			if(items=='NO') 
				{
				
				  $.messager.alert('Message', 'Not Create ', function(r){
				 		 
				 		 
					     
				     });
				
			  
				}
			
			
			else
				{
				  document.getElementById("rdocno").value="";
					 document.getElementById("txtfleetno").value="";
					 document.getElementById("rdocno").value="";
					  document.getElementById("del_chaufferid").value="";
				 	  document.getElementById("clientdrvid").value="";
				 	  document.getElementById("tariffrenral_Agentid").value="";
				 	  document.getElementById("ratariff_checkoutid").value="";
				 	  document.getElementById("delivery").value="";
				 	  document.getElementById("chuef").value="";
				 	 document.getElementById("radriverlist").value="";
				 	 document.getElementById("delcharge").value="";
				 	document.getElementById("mrano").value="";
				 	 
						 document.getElementById("clientdrv").value="";
						  document.getElementById("rarenral_Agent").value="";
					 	  document.getElementById("ratariff_checkout").value="";
					 	 document.getElementById("delivery_chk").checked=false; 
					 
					 	 document.getElementById("radrivercheck").checked=false; 
					 	  $('#jqxDateOut').val(new Date());
					 	  $('#jqxTimeOut').val(new Date());
			

				  $.messager.alert('Message', ' Successfully Created '+'RA NO Is '+items);
				 funreload(event); 
		
				disitems();
				
				}
			
			
			}
	}
		
x.open("GET","rentalagmtsavedata.jsp?docno="+rdocno+"&deldrvss="+deldrvss+"&clientdrs="+clientdrs+"&rantalagt="+rantalagt+"&chkout="+chkout+"&delivery="+delivery+"&chuef="+chuef+'&fleetnos='+fleetnos+'&branchids='+branchids+'&dateout='+dateout+'&timeout='+timeout+'&delcharge='+delcharge+"&mrano="+mrano,true);

x.send();
		
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
</script>
</head>
<body onload="getBranch();getinfo();disitems();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
		  <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                    
                    
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>  
	<tr> <td  align="right"><label class="branch">Process</label></td><td align="left">
 <select  id="cmbinfo" style="width:70%;" name="cmbinfo"  value='<s:property value="cmbinfo"/>' onchange="funchangeinfo()" >
       

</select></td></tr>
	<tr><td  align="right" ><label class="branch">Date</label></td><td align="left"><div id='date' name='date' value='<s:property value="date"/>'></div>
                   </td></tr>

	 <tr><td align="right"><label class="branch">Remarks </label></td><td align="left"><input type="text" id="remarks" style="height:20px;width:88%;" name="remarks"  value='<s:property value="remarks"/>'> </td></tr>
	<tr><td  align="center" colspan="2"><input type="Button" name="driverUpdate" id="driverUpdate" class="myButton" value="Update" onclick="funupdate()"></td> </tr>
	<tr>
	<td colspan="2"><div id='cpppp' style="width: 100% ; align:left; height: 230px;">
	<fieldset>
	<legend>Rental Agreement Create</legend>
	<table width="100%" >
	<tr>
		 <td align="right"  width="34%"><label class="branch">Fleet</label> </td> 
          
	 <td  width="66%"><input type="text" id="txtfleetno" name="txtfleetno" readonly placeholder="Press F3 To Search" style="height:20px;width:99%;" value='<s:property value="txtfleetno"/>' onKeyDown="getvehinfo(event);" onfocus="this.placeholder = ''" />
  
        </td>
        </tr>
        
        <tr>
<td colspan="2" align="center"><label class="branch">Delivery</label>

<input type="checkbox" id="delivery_chk"  name="delivery_chk" value="0"  onchange="fundriverdisable()"   onclick="$(this).attr('value', this.checked ? 1 : 0)" >
<label class="branch">Chauffeur</label>

<input type="checkbox"  id="radrivercheck"  name="radrivercheck" value="0" onchange="funShaffurdisable()"  onclick="$(this).attr('value', this.checked ? 1 : 0)"></td>
</tr>
        <tr>
   <td align="right"><label class="branch">Del Charge</label></td><td><input type="text" id="delcharge" name="delcharge"    style="text-align: right;height:20px;width:99%;" value='<s:property value="delcharge"/>'  onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber(event);"/></td>

      <tr><td align="right"><label class="branch">Driver</label></td><td><input type="text" readonly  id="radriverlist"  name="radriverlist"  style="height:20px;width:99%;" placeholder="Press F3 To Search" value='<s:property value="radriverlist"/>' onKeyDown="getchauffeur(event);" />
      
          <input type="hidden" id="del_chaufferid" name="del_chaufferid" value='<s:property value="del_chaufferid"/>'/>  
      
      </td>
      </tr>  
       <tr><td align="right"><label class="branch">Client Driver</label></td><td><input type="text" id="clientdrv" readonly  name="clientdrv"  style="height:20px;width:99%;" placeholder="Press F3 To Search" value='<s:property value="clientdrv"/>' onKeyDown="getcldrv(event);" />
               <input type="hidden" id="clientdrvid" name="clientdrvid" value='<s:property value="clientdrvid"/>'/>   
      </td>
      </tr> 
        <tr>
	 <td align="right"  width="34%"><label class="branch">Rental Agent</label> </td>
          
	 <td  width="66%"><input type="text" id="rarenral_Agent" name="rarenral_Agent" readonly  style="height:20px;width:99%;" placeholder="Press F3 To Search"  value='<s:property value="rarenral_Agent"/>' onKeyDown="getrentalAgent(event);" onfocus="this.placeholder = ''"/>
    <input type="hidden" id="tariffrenral_Agentid" name="tariffrenral_Agentid" style="width:95%;" value='<s:property value="tariffrenral_Agentid"/>'/>
        </td>
    </tr> 
      <tr>
   <td align="right" > <label class="branch">Checkout</label> </td>
           
    <td><input type="text" id="ratariff_checkout" placeholder="Press F3 To Search"  readonly="readonly"  name="ratariff_checkout" style="height:20px;width:99%;" value='<s:property value="ratariff_checkout"/>' onKeyDown="getcheckout(event);" onfocus="this.placeholder = ''"/>
    <input type="hidden" id="ratariff_checkoutid" name="ratariff_checkoutid" value='<s:property value="ratariff_checkoutid"/>'/>  
    
    </td>
    </tr>
    <tr>

	   <td align="right" > <label class="branch">DateOut</label> </td>
	   	<td>
	<div id='jqxDateOut' name='jqxDateOut' value='<s:property value="jqxDateOut"/>'></div> 
</td>
    </tr>
    <tr>
 
       <td align="right" > <label class="branch">TimeOut</label> </td>
          <td>
    <div id='jqxTimeOut' name='jqxTimeOut'  value='<s:property value="jqxTimeOut"/>'></div>
    </td>
    <tr>
      <td align="right"><label class="branch">MRA No</label></td>
      <td align="center"><input type="text" id="mrano" name="mrano" style="height:20px;width:99%;" value='<s:property value="mrano"/>'/></td>
    </tr>
    <tr>
<td colspan="2" align="center"><input type="Button" name="rentalcreate" id="rentalcreate" class="myButton" value="Create" onclick="funrentalcreate()"></td>
</tr>
    
    </table>
	</fieldset>
		 
	</div></td>
	</tr>	
	  <tr><td colspan="2">&nbsp;</td></tr>   
		  	  <tr><td colspan="2">&nbsp;</td></tr>  
	</table> 
	
	

                  
<input type="hidden" name="branchids" id="branchids" style="height:20px;width:70%;" value='<s:property value="branchids"/>' >
<input type="hidden" name="rdocno" id="rdocno" style="height:20px;width:70%;" value='<s:property value="rdocno"/>' >
<input type="hidden" name="clname" id="clname" style="height:20px;width:70%;" value='<s:property value="clname"/>' >
<input type="hidden" name="reftype" id="reftype" style="height:20px;width:70%;" value='<s:property value="reftype"/>' >
<input type="hidden" name="clientid" id="clientid" style="height:20px;width:70%;" value='<s:property value="clientid"/>' >

<input type="hidden" name="delivery" id="delivery" style="height:20px;width:70%;" value='<s:property value="delivery"/>' >
<input type="hidden" name="chuef" id="chuef" style="height:20px;width:70%;" value='<s:property value="chuef"/>' >
<input type="hidden" name="grpid" id="grpid" style="height:20px;width:70%;" value='<s:property value="grpid"/>' >


	</fieldset>
	
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="bookfollowdiv"><jsp:include page="bookingfollowGrid.jsp"></jsp:include></div></td>
		</tr>
	
		<tr>
		<td   ><div id="detaildiv"><jsp:include page="detailgrid.jsp"></jsp:include></div></td></tr>

	</table>
</tr>
</table>

</div>
<div id="vehinfowindow">
   <div ></div>
</div> 
<div id="Rentalagentinfowindow">
   <div ></div>
</div>
<div id="Checkoutinfowindow">
   <div ></div>
</div>
<div id="chauffeurinfowindow">
   <div ></div>
</div>
<div id="driverinfowindow">
   <div ></div>
</div>
</div>
</body>
</html>