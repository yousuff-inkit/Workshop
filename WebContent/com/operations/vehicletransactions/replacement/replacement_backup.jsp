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
     /*	Words Used for representing different types of vehicle movement
	  Collect Details => oncollect
	  In Details => incollect
	  Delivery Details => deliveryout
	  Out Details => ondelivery*/
      $(document).ready(function () { 
    	  $('#btnEdit').attr('disabled',true);
		   $('#btnDelete').attr('disabled',true);
    	  /* Date */
    	  $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
    	  $("#refdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
    	  $("#dateout").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
    	  $("#dateouthidden").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
    	  $("#oncollectdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
    	  $("#incollectdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
    	  $("#deliveryoutdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
    	  $("#ondeliverydate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
          $("#timeout").jqxDateTimeInput({ width: '40%', height: '15px', formatString: 'HH:mm', showCalendarButton: false,value:null });
          $("#timeouthidden").jqxDateTimeInput({ width: '40%', height: '15px', formatString: 'HH:mm', showCalendarButton: false,value:new Date() });
          $("#oncollecttime").jqxDateTimeInput({ width: '95%', height: '15px', formatString: 'HH:mm', showCalendarButton: false,value:null });
          $("#incollecttime").jqxDateTimeInput({ width: '95%', height: '15px', formatString: 'HH:mm', showCalendarButton: false,value:null });
          $("#deliveryouttime").jqxDateTimeInput({ width: '95%', height: '15px', formatString: 'HH:mm', showCalendarButton: false,value:null });
          $("#ondeliverytime").jqxDateTimeInput({ width: '95%', height: '15px', formatString: 'HH:mm', showCalendarButton: false,value:null });
          $('#agmtnowindow').jqxWindow({ width: '60%', height: '54%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
   	   $('#agmtnowindow').jqxWindow('close');
   	 $('#collectionwindow').jqxWindow({ width: '60%', height: '54%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Driver Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
 	   $('#collectionwindow').jqxWindow('close');
 	/*  	 $('#deliverywindow').jqxWindow({ width: '60%', height: '54%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Delivery Driver Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
 	 	   $('#deliverywindow').jqxWindow('close'); */
		  document.getElementById("btnsave").style.display="none";
		  $('#dateout').on('change', function (event) 
	    			{  
	    	checkfuturedate();
	    			   }); 
   	 $('#refvocno').dblclick(function(){
  		 if(document.getElementById("mode").value=="view"){
  			 return false;
  		 }
   		 if(document.getElementById("cmbrentaltype").value==''){
  			 document.getElementById("errormsg").innerText="Agreement Type is Mandatory";
  			document.getElementById("cmbrentaltype").focus();
  			 return false;
  		 }
   		 if(document.getElementById("cmbagmtbranch").value==""){
   			 document.getElementById("errormsg").innerText="";
   			 document.getElementById("errormsg").innerText="Agreement Branch is Mandatory";
   			 return false;
   			 
   		 }
  		document.getElementById("errormsg").innerText="";
		    $('#agmtnowindow').jqxWindow('open');
		 agmtnoSearchContent('agmtnoSearch.jsp?', $('#agmtnowindow'));
		});
   	$('#collectdriver').dblclick(function(){
		    $('#collectionwindow').jqxWindow('open');
		$('#collectionwindow').jqxWindow('focus');
		 collectionSearchContent('driverSearchGrid.jsp?id=1', $('#collectionwindow'));
		});
 	$('#deliverydriver').dblclick(function(){
 	   $('#collectionwindow').jqxWindow('open');
		$('#collectionwindow').jqxWindow('focus');
		collectionSearchContent('driverSearchGrid.jsp?id=2',  $('#collectionwindow'));
	});
   	 $('#txtoutfleetno').dblclick(function(){
   		if(document.getElementById("mode").value=="view"){
 			 return false;
 		 }
   		//$('#gridAgmtSearch').jqxGrid('clear');
		    $('#agmtnowindow').jqxWindow('open');
		$('#agmtnowindow').jqxWindow('focus');
		 agmtnoSearchContent('masterFleetSearch.jsp?', $('#agmtnowindow'));
		});
 	//getLocation();
 	
	getReason();
	check();
	checkDelivery();
	checkCollection();
	getBranch();
	check();
	getTestLocation();
	
	if((document.getElementById("docno").value=='')||(document.getElementById("cmbreplacetype").value=="atbranch")||(document.getElementById("cmbreplacetype").value=="0")){
		document.getElementById("btnupdate").style.display="none";
	}
	else{
		if(!(document.getElementById("cmbreplacetype").value=="atbranch")){
		document.getElementById("btnupdate").style.display="block";
		}
		
	}

//	$('#ondeliverykm').prop('disabled',false);
      });
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
    				$("select#cmbinlocation").html(optionsloc);
    				//$("select#cmbcloselocation").html(optionsloc);
    				if ($('#hidcmbinlocation').val() != null) {
    					$('#cmbinlocation').val($('#hidcmbinlocation').val());
    				}
    				/* if ($('#hidcmbcloselocation').val() != null) {
    					$('#cmbcloselocation').val($('#hidcmbcloselocation').val());
    				} */
    			} else {
    			}
    		}
    		x.open("GET", "getTestLocation.jsp", true);
    		x.send();
      }
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
   			$('#agmtnowindow').jqxWindow('focus');
   			 agmtnoSearchContent('agmtnoSearch.jsp?', $('#agmtnowindow'));
           }
           else{
            }
      }
      function getOutfleet(event){
    	  if(document.getElementById("mode").value=="view"){
   			 return false;
   		 }
    	  var x= event.keyCode;
           if(x==114){
         	  $('#agmtnowindow').jqxWindow('open');
   			$('#agmtnowindow').jqxWindow('focus');
   			 agmtnoSearchContent('masterFleetSearch.jsp?', $('#agmtnowindow'));
           }
           else{
            }
      }
      function getDeliveryDriver(event){
    	  var x= event.keyCode;
          if(x==114){
        	  $('#collectionwindow').jqxWindow('open');
    			$('#collectionwindow').jqxWindow('focus');
    			collectionSearchContent('driverSearchGrid.jsp?id=2', $('#collectionwindow'));
          }
          else{
           }
      }
      function getCollectDriver(event){
    	  var x= event.keyCode;
          if(x==114){
        	  $('#collectionwindow').jqxWindow('open');
  			$('#collectionwindow').jqxWindow('focus');
  			 collectionSearchContent('driverSearchGrid.jsp?id=1', $('#collectionwindow'));
          }
          else{
           }
      }
      function agmtnoSearchContent(url) {
	      $.get(url).done(function (data) {
	    $('#agmtnowindow').jqxWindow('setContent', data);
	}); 
	}
      function collectionSearchContent(url) {
	      $.get(url).done(function (data) {
	    $('#collectionwindow').jqxWindow('setContent', data);
	}); 
	}
     /*  function deliverySearchContent(url) {
	      $.get(url).done(function (data) {
	    $('#deliverywindow').jqxWindow('setContent', data);
	});  
	}*/
        function funReset(){
    		//$('#frmReplacement')[0].reset(); 
    	}
    	function funReadOnly(){
    		 $('#frmReplacement input').attr('readonly', true );
    		$('#frmReplacement select').attr('disabled', true);
    		$('#date').jqxDateTimeInput({ disabled: true});
    		$('#refdate').jqxDateTimeInput({ disabled: true});
    		$('#dateout').jqxDateTimeInput({ disabled: true});
    		$('#timeout').jqxDateTimeInput({ disabled: true});
    		$('#incollectdate').jqxDateTimeInput({ disabled: true});
    		$('#incollecttime').jqxDateTimeInput({ disabled: true});
    		$('#oncollectdate').jqxDateTimeInput({ disabled: true});
    		$('#oncollecttime').jqxDateTimeInput({ disabled: true});
    		$('#deliveryoutdate').jqxDateTimeInput({ disabled: true});
    		$('#deliveryouttime').jqxDateTimeInput({ disabled: true});
    		$('#ondeliverydate').jqxDateTimeInput({ disabled: true});
    		$('#ondeliverytime').jqxDateTimeInput({ disabled: true});
    	}
    	function funRemoveReadOnly(){
    		 $('#frmReplacement input').attr('readonly', false );
     		$('#frmReplacement select').attr('disabled', false);
     		$('#date').jqxDateTimeInput({ disabled: false});
     		$('#refdate').jqxDateTimeInput({ disabled: false});
     		$('#dateout').jqxDateTimeInput({ disabled:false});
     		$('#timeout').jqxDateTimeInput({ disabled: false});
     		$('#incollectdate').jqxDateTimeInput({ disabled:false});
     		$('#incollecttime').jqxDateTimeInput({ disabled: false});
     		$('#oncollectdate').jqxDateTimeInput({ disabled: false});
     		$('#oncollecttime').jqxDateTimeInput({ disabled: false});
     		$('#deliveryoutdate').jqxDateTimeInput({ disabled: false});
     		$('#deliveryouttime').jqxDateTimeInput({ disabled: false});
     		$('#ondeliverydate').jqxDateTimeInput({ disabled: false});
     		$('#ondeliverytime').jqxDateTimeInput({ disabled: false});
   			$('#refno').prop('readonly', true);
   			$('#refname').prop('readonly', true);
   			$('#txtfleetno').prop('readonly', true);
   			$('#txtfleetname').prop('readonly', true);
   			$('#outkm').prop('readonly', true);
   			$('#txtbranch').prop('readonly', true);
   			$('#txtlocation').prop('readonly', true);
   			$('#user').prop('readonly', true);
   			$('#outbranch').prop('readonly', true);
   			$('#outlocation').prop('readonly', true);
   			$('#txtoutfleetno').prop('readonly', true);
   			$('#txtoutfleetname').prop('readonly', true);
   			$('#outuser').prop('readonly', true);
   			$('#dateout').val(new Date());
   			$('#collectdriver').prop('readonly',true);
   			$('#deliverydriver').prop('readonly',true);
   			
   			getReason();
			check();
			checkDelivery();
			checkCollection();
			getBranch();
			check();
			if(document.getElementById("mode").value=='A' && document.getElementById("chkstatus")!="1"){
				$('input:checkbox').removeAttr('checked');
				funResetValues();
			}		
    	}
    	function funResetValues(){
    		$('#refdate').jqxDateTimeInput('setDate', null);
     		$('#dateout').jqxDateTimeInput('setDate', null);
     		$('#timeout').jqxDateTimeInput('setDate', null);
     		$('#incollectdate').jqxDateTimeInput('setDate', null);
     		$('#incollecttime').jqxDateTimeInput('setDate', null);
     		$('#oncollectdate').jqxDateTimeInput('setDate', null);
     		$('#oncollecttime').jqxDateTimeInput('setDate', null);
     		$('#deliveryoutdate').jqxDateTimeInput('setDate', null);
     		$('#deliveryouttime').jqxDateTimeInput('setDate', null);
     		$('#ondeliverydate').jqxDateTimeInput('setDate', null);
     		$('#ondeliverytime').jqxDateTimeInput('setDate', null);
     		$('#refno').val('');
   			$('#refname').val('');
   			$('#txtfleetno').val('');
   			$('#txtfleetname').val('');
   			$('#outkm').val('');
   			$('#txtbranch').val('');
   			$('#txtlocation').val('');
   			$('#user').val('');
   			$('#outbranch').val('');
   			$('#outlocation').val('');
   			$('#txtoutfleetno').val('');
   			$('#txtoutfleetname').val('');
   			$('#outuser').val('');
   			$('#collectdriver').val('');
   			$('#deliverydriver').val('');
   			$('#incollectkm').val('');
   			$('#cmbincollectfuel').val('');
   			$('#cmbinbranch').val('');
   			$('#cmbinlocation').val('');
   			$('#ondeliverykm').val('');
   			$('#cmbondeliveryfuel').val('');
    		//$("#jqxWidget").jqxDateTimeInput('setDate', null);
    	}
    	function check(){
    		
    			if(document.getElementById("hidchkdelivery").value==1){
        			document.getElementById("chkdelivery").checked=true;
        			checkDelivery();
        		}
        		if(document.getElementById("hidchkdelivery").value==0){
        			document.getElementById("chkdelivery").checked=false;
        			checkDelivery();
        		}
        		if(document.getElementById("hidchkcollection").value==1){
        			document.getElementById("chkcollection").checked=true;
        			checkCollection();
        		}
        		if(document.getElementById("hidchkcollection").value==0){
        			document.getElementById("chkcollection").checked=false;
        			checkCollection();
        		}	
    		
    		//document.getElementById("cmbreplacetype").disabled=true;
    	}
    	function funSearchLoad(){
   		 changeContent('mainSearch.jsp'); 
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
    		var reptype=document.getElementById("cmbreplacetype").value;
    		var outkm=parseFloat(document.getElementById("outkm").value);
    		var dateout1=new Date($('#dateout').jqxDateTimeInput('getDate'));
      	 	var timeout1=new Date($('#timeout').jqxDateTimeInput('getDate'));
      	 	dateout1.setHours(0,0,0,0);
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
    		if(reptype=='atbranch'){
    			if($('#incollectdate').jqxDateTimeInput('getDate')==null){
    				document.getElementById("errormsg").innerText="";
    				document.getElementById("errormsg").innerText="In Date is Mandatory";
    				$('#incollectdate').jqxDateTimeInput('focus'); 
    				return 0;	
    			}
    			var atbranchindateval=funDateInPeriod($('#incollectdate').jqxDateTimeInput('getDate'));
     			if(atbranchindateval==0){
     				$('#incollectdate').jqxDateTimeInput('focus');
     				return 0;
     			}
     			else{
     				document.getElementById("errormsg").innerText="";
     			}
    			if($('#incollecttime').jqxDateTimeInput('getDate')==null){
    				document.getElementById("errormsg").innerText="";
    				document.getElementById("errormsg").innerText="In Time is Mandatory";
    				$('#incollecttime').jqxDateTimeInput('focus'); 
    				return 0;	
    			}
    			var incollectdate1=new Date($('#incollectdate').jqxDateTimeInput('getDate'));
          	 	incollectdate1.setHours(0,0,0,0);
    			var incollecttime1=new Date($('#incollecttime').jqxDateTimeInput('getDate'));
				document.getElementById("errormsg").innerText="";
				
    			if(incollectdate1<dateout1){
    				document.getElementById("errormsg").innerText="";
    				document.getElementById("errormsg").innerText="In Date Should Not be less than Fleet Date";
    				$('#incollectdate').jqxDateTimeInput('focus'); 
					return 0;
    			}
    			if(incollectdate1-dateout1==0){
    			
    		 	if(incollecttime1.getHours()<timeout1.getHours()){
        				document.getElementById("errormsg").innerText="";
        				document.getElementById("errormsg").innerText="In Time Should Not be less than Fleet Time";
        				$('#incollecttime').jqxDateTimeInput('focus'); 
        				return 0;
    				}
    		 	
    		 	else if(incollecttime1.getHours()==timeout1.getHours()){
    		 		if(incollecttime1.getMinutes()<timeout1.getMinutes()){
    		 			document.getElementById("errormsg").innerText="";
    		 			document.getElementById("errormsg").innerText="In Time Should Not be less than Fleet Time";
    		 			$('#incollecttime').jqxDateTimeInput('focus'); 
        				return 0;	
    		 		}
    		 		else{
    		 			document.getElementById("errormsg").innerText="";
    		 		}
    		 	}
    		 	else{
    		 		document.getElementById("errormsg").innerText="";
    		 	}

    			}
    			if(document.getElementById("incollectkm").value=='' || parseFloat(document.getElementById("incollectkm").value)==0.0){
    				document.getElementById("errormsg").innerText="";
    				document.getElementById("errormsg").innerText="In KM cannot be Empty";
    				document.getElementById("incollectkm").focus();
    				return 0;
    			}
    			if(parseFloat(document.getElementById("incollectkm").value)<outkm){
    				document.getElementById("errormsg").innerText="";
    				document.getElementById("errormsg").innerText="In KM Should Not be less than Out Km";
    				document.getElementById("incollectkm").focus();
    				return 0;
    			}
    			if(document.getElementById("cmbincollectfuel").value==''){
    				document.getElementById("errormsg").innerText="";
    				document.getElementById("errormsg").innerText="Please select In Fuel";
    				document.getElementById("cmbincollectfuel").focus();
    				return 0;
    			}
    			if(document.getElementById("cmbinbranch").value==''){
    				document.getElementById("errormsg").innerText="";
    				document.getElementById("errormsg").innerText="In Branch Cannot be Empty";
    				document.getElementById("cmbinbranch").focus();
    				return 0;
    			}
    			if(document.getElementById("cmbinlocation").value==''){
    				document.getElementById("errormsg").innerText="";
    				document.getElementById("errormsg").innerText="In Location Cannot be Empty";
    				document.getElementById("cmbinlocation").focus();
    				return 0;
    			}
    			
    		}
    		
    		if(document.getElementById("txtoutfleetno").value==''){
    			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="Out Fleet Cannot be Empty";
    			document.getElementById("txtoutfleetno").focus();
    			return 0;
    		}
    		if($('#ondeliverydate').jqxDateTimeInput('getDate')==null){
    			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="Out Date is Mandatory";
    			$('#ondeliverydate').jqxDateTimeInput('focus'); 
    			return 0;
    		}
    		var outdateval=funDateInPeriod($('#ondeliverydate').jqxDateTimeInput('getDate'));
 			if(outdateval==0){
 				$('#ondeliverydate').jqxDateTimeInput('focus');
 				return 0;
 			}
 			else{
 				document.getElementById("errormsg").innerText="";
 			}
 			
    		if($('#ondeliverytime').jqxDateTimeInput('getDate')==null){
    			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="Out Time is Mandatory";
    			$('#ondeliverytime').jqxDateTimeInput('focus'); 
    			return 0;
    		}
    		var ondeliverydate=new Date($('#ondeliverydate').jqxDateTimeInput('getDate'));
    		ondeliverydate.setHours(0,0,0,0);    		
    		var ondeliverytime=new Date($('#ondeliverytime').jqxDateTimeInput('getDate'));
    		if(ondeliverydate<dateout1){
    			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="Out Date cannot be less than Agreement Date";
    			$('#ondeliverydate').jqxDateTimeInput('focus');
    			return 0;
    			
    		}
    		if(ondeliverydate-dateout1==0){
    			if(ondeliverytime.getHours()<timeout1.getHours()){
    				document.getElementById("errormsg").innerText="";
        			document.getElementById("errormsg").innerText="Out Time cannot be less than Agreement Time";
        			$('#ondeliverytime').jqxDateTimeInput('focus');
        			return 0;	
    			}
    			if(ondeliverytime.getHours()==timeout1.getHours()){
    				if(ondeliverytime.getMinutes()<timeout1.getMinutes()){
    					document.getElementById("errormsg").innerText="";
            			document.getElementById("errormsg").innerText="Out Time cannot be less than Agreement Time";
            			$('#ondeliverytime').jqxDateTimeInput('focus');
            			return 0;	
    				}
    			}
    		}
    		document.getElementById("errormsg").innerText="";
    		dateenable();
    		$('#frmReplacement input').attr('disabled',false);
    		$('#frmReplacement select').attr('disabled',false);
    		
    		return 1;
     	} 

     	function funChkButton() {
    		/* funReset(); */
    	}

     	function funFocus(){
    	   	$('#date').jqxDateTimeInput('focus'); 	    		
     	}
     	function chkCollection(){
     	
     	}
function dateenable(){
	$('#date').jqxDateTimeInput({ disabled: false});
		$('#refdate').jqxDateTimeInput({ disabled: false});
		$('#dateout').jqxDateTimeInput({ disabled:false});
		$('#timeout').jqxDateTimeInput({ disabled: false});
		$('#incollectdate').jqxDateTimeInput({ disabled:false});
		$('#incollecttime').jqxDateTimeInput({ disabled: false});
		$('#oncollectdate').jqxDateTimeInput({ disabled: false});
		$('#oncollecttime').jqxDateTimeInput({ disabled: false});
		$('#deliveryoutdate').jqxDateTimeInput({ disabled: false});
		$('#deliveryouttime').jqxDateTimeInput({ disabled: false});
		$('#ondeliverydate').jqxDateTimeInput({ disabled: false});
		$('#ondeliverytime').jqxDateTimeInput({ disabled: false});
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
    				$("select#cmbagmtbranch").html(optionsbranch);
    				if ($('#hidcmbagmtbranch').val() != null) {
    					$('#cmbagmtbranch').val($('#hidcmbagmtbranch').val());
    				}
    				if ($('#hidcmbinbranch').val() != null) {
    					$('#cmbinbranch').val($('#hidcmbinbranch').val());
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
    				//$("select#cmbcloselocation").html(optionsloc);
    				if ($('#hidcmbinlocation').val() != null) {
    					$('#cmbinlocation').val($('#hidcmbinlocation').val());
    				}
    			
    			} else {
    			}
    		}
    		x.open("GET", "getLoc.jsp?id="+value, true);
    		x.send();
    	}
     	function checkCollection(){
     		if(document.getElementById("chkcollection").checked==false){
     			document.getElementById("hidchkcollection").value="0";
     			$('#collectdriver').prop('disabled',true);
     			$('#oncollectdate').jqxDateTimeInput({ disabled: true});
     			$('#oncollecttime').jqxDateTimeInput({ disabled: true});
     			$('#oncollectkm').prop('disabled',true);
     			$('#cmboncollectfuel').prop('disabled',true);
     			
     		}
     		if(document.getElementById("chkcollection").checked==true){
     			document.getElementById("hidchkcollection").value="1";
     			$('#collectdriver').prop('disabled',false);
     			$('#oncollectdate').jqxDateTimeInput({ disabled: false});
     			$('#oncollecttime').jqxDateTimeInput({ disabled: false});
     			$('#oncollectkm').prop('disabled',false);
     			$('#oncollectkm').prop('readonly',false);
				
     			$('#cmboncollectfuel').prop('disabled',false);
     		}
     		
     	}
     	function checkDelivery(){
     		if(document.getElementById("chkdelivery").checked==false){
     			
     			document.getElementById("hidchkdelivery").value="0";
     			$('#deliverydriver').prop('disabled',true);
     			$('#deliveryoutdate').jqxDateTimeInput({ disabled: true});
     			$('#deliveryouttime').jqxDateTimeInput({ disabled: true});
     			//$('#deliveryoutkm').prop('disabled',true);
     			$('#deliveryto').prop('disabled',true);
     			$('#cmbdeliveryoutfuel').prop('disabled',true);
     			$('#deliveryoutkm').prop('disabled',false);
     			
     		}
     		if(document.getElementById("chkdelivery").checked==true){
     			document.getElementById("hidchkdelivery").value="1";
     			$('#deliverydriver').prop('disabled',false);
     			$('#deliveryoutdate').jqxDateTimeInput({ disabled: false});
     			$('#deliveryouttime').jqxDateTimeInput({ disabled: false});
     			//$('#deliveryoutkm').prop('disabled',false);
     			$('#deliveryoutkm').prop('readonly',false);
     			$('#cmbdeliveryoutfuel').prop('disabled',false);
     			$('#ondeliverykm').prop('disabled',false);
     			$('#cmbondeliveryfuel').prop('disabled',false);
     			$('#deliveryto').prop('disabled',false);
     			$('#deliveryto').prop('readonly',false);
     			/* $('#ondeliverykm').val('');
     			$('#cmbondeliveryfuel').val(''); */
     		}
     	}
     	function setValues(){
     		funSetlabel();
     		//date and time setting
     		
     		
     		if($('#hidoncollecttime').val()){
    			$("#oncollecttime").jqxDateTimeInput('val', $('#hidoncollecttime').val());
    		}
     	
     		if($('#hiddeliveryouttime').val()){
    			$("#deliveryouttime").jqxDateTimeInput('val', $('#hiddeliveryouttime').val());
    		}
     		if($('#hidtimeout').val()){
    			$("#timeout").jqxDateTimeInput('val', $('#hidtimeout').val());
    		}
     		if($('#hidincollecttime').val()){
    			$("#incollecttime").jqxDateTimeInput('val', $('#hidincollecttime').val());
    		}
     		if($('#hidondeliverytime').val()){
    			$("#ondeliverytime").jqxDateTimeInput('val', $('#hidondeliverytime').val());
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
     			if ($('#hidcmboncollectfuel').val() != null) {
     				$('#cmboncollectfuel').val($('#hidcmboncollectfuel').val());
     			}
     			if ($('#hidcmbincollectfuel').val() != null) {
     				$('#cmbincollectfuel').val($('#hidcmbincollectfuel').val());
     			}
     			if ($('#hidcmbinbranch').val() != null) {
     				$('#cmbinbranch').val($('#hidcmbinbranch').val());
     			}
     			if ($('#hidcmbinlocation').val() != null) {
     				$('#cmbinlocation').val($('#hidcmbinlocation').val());
     			}
     			if ($('#hidcmbdeliveryoutfuel').val() != null) {
     				$('#cmbdeliveryoutfuel').val($('#hidcmbdeliveryoutfuel').val());
     			}
     			if ($('#hidcmbondeliveryfuel').val() != null) {
     				$('#cmbondeliveryfuel').val($('#hidcmbondeliveryfuel').val());
     			}
     			//Pop Up setting
     			
     			if($('#msg').val()!=""){
     			   $.messager.alert('Message',$('#msg').val());
     			  }
     			document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
     			if(document.getElementById("cmbreplacetype").value=="atbranch"){
     				document.getElementById("btnupdate").disabled=true;
     			}
     			else if(document.getElementById("cmbreplacetype").value=="collection"){
     				document.getElementById("btnupdate").disabled=false;
     			}
     			else{
     				
     			}
     			if(document.getElementById("incollectkm").value!='' && parseFloat(document.getElementById("incollectkm").value)>0){
     				document.getElementById("btnupdate").disabled=true;
     			}
         		//if(document.getElementById("mode").value!="A" && document.getElementById("cmbreplacetype").value=="atbranch"){
         			document.getElementById("chkcollection").disabled=true;
         			document.getElementById("chkdelivery").disabled=true;
         	//	}
     	}
  	  function isNumber(evt,id) {
	        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
	        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
	         {
	        	 $.messager.alert('Warning','Enter Numbers Only');
	           $("#"+id+"").focus();
	            return false;
	            
	         }
	        
	        return true;
	    }
     	function checkReplace(){
     		var temp=document.getElementById("cmbreplacetype").value;
     		//alert(temp);
     		if(temp=='atbranch'){
     			document.getElementById("hidchkdelivery").value=0;
     			$('#deliverydriver').prop('disabled',true);
     			$('#deliveryoutdate').jqxDateTimeInput({ disabled: true});
     			$('#deliveryouttime').jqxDateTimeInput({ disabled: true});
     			$('#deliveryoutkm').prop('disabled',true);
     			$('#cmbdeliveryoutfuel').prop('disabled',true);
     			$('#deliveryto').prop('disabled',true);
     			document.getElementById("hidchkcollection").value=0;
     			$('#collectdriver').prop('disabled',true);
     			$('#oncollectdate').jqxDateTimeInput({ disabled: true});
     			$('#oncollecttime').jqxDateTimeInput({ disabled: true});
     			$('#oncollectkm').prop('disabled',true);
     			$('#cmboncollectfuel').prop('disabled',true);
     			document.getElementById("btnupdate").style.display="none";
     			$('#chkdelivery').prop('disabled',true);
     			$('#chkcollection').prop('disabled',true);
     			$('#incollectdate').jqxDateTimeInput({ disabled: false});
     			$('#incollecttime').jqxDateTimeInput({ disabled: false});
     			$('#incollectkm').prop('disabled',false);
     			$('#incollectkm').prop('readonly',false);
     			$('#cmbincollectfuel').prop('disabled',false);
     			$('#cmbinbranch').prop('disabled',false);
     			$('#cmbinlocation').prop('disabled',false);
     			$('#incollectdate').jqxDateTimeInput('focus');
     		}
     		if(temp=='collection'){
     			
     			//alert(document.getElementById("mode").value);
     	if(document.getElementById("mode").value=='A'){
     		$('#oncollectdate').jqxDateTimeInput({ disabled: true});
 			$('#oncollecttime').jqxDateTimeInput({ disabled: true});
 			$('#oncollectkm').prop('disabled',true);
 			$('#oncollectkm').prop('readonly',true);
 			$('#cmboncollectfuel').prop('disabled',true);
     		$('#incollectdate').jqxDateTimeInput({ disabled: true});
 			$('#incollecttime').jqxDateTimeInput({ disabled: true});
 			$('#incollectkm').prop('disabled',true);
 			$('#incollectkm').prop('readonly',true);
 			$('#cmbincollectfuel').prop('disabled',true);
 			$('#cmbinbranch').prop('disabled',true);
 			$('#cmbinlocation').prop('disabled',true);
 			document.getElementById("txtoutfleetno").focus();
 			$('#chkdelivery').prop('disabled',true);
 			$('#chkcollection').prop('disabled',true);
 			checkDelivery();
 			checkCollection();
     	}
     			if(document.getElementById("docno").value>0){
     			document.getElementById("btnupdate").style.display="block";
     			}
     		}
     		
     		else{
     			
     		}
     	}
     	function funupdate(){
    		document.getElementById("chkcollection").disabled=false;
 			document.getElementById("chkdelivery").disabled=false;
     		$('#incollectdate').jqxDateTimeInput({ disabled: false});
 			$('#incollecttime').jqxDateTimeInput({ disabled: false});
 			$('#incollectkm').prop('disabled',false);
 			$('#incollectkm').prop('readonly',false);
 			$('#cmbincollectfuel').prop('disabled',false);
 			$('#cmbinbranch').prop('disabled',false);
 			$('#cmbinlocation').prop('disabled',false);
 			$('#ondeliverydate').jqxDateTimeInput({ disabled: false});
 			$('#ondeliverytime').jqxDateTimeInput({ disabled: false});
 			$('#ondeliverykm').prop('disabled',false);
 			$('#ondeliverykm').prop('readonly',false);
 			$('#cmbondeliveryfuel').prop('disabled',false);
			document.getElementById("btnupdate").style.display="none";
			document.getElementById("btnsave").style.display="block";
			$('#cmbtrreason').prop('disabled',false);
			
     	}
     	
     	function funsave(){
 			$('#dateout').jqxDateTimeInput({ disabled: false});
 			$('#timeout').jqxDateTimeInput({ disabled: false});
    		var oncollectdate1=new Date($('#oncollectdate').jqxDateTimeInput('getDate'));
    		oncollectdate1.setHours(0,0,0,0);
			var oncollecttime1=new Date($('#oncollecttime').jqxDateTimeInput('getDate'));
			var outkm=document.getElementById("outkm").value;
			var dateout1=new Date($('#dateout').jqxDateTimeInput('getDate'));
			dateout1.setHours(0,0,0,0);
			var timeout1=new Date($('#oncollecttime').jqxDateTimeInput('getDate'));
			var deliveryoutdate1=new Date($('#deliveryoutdate').jqxDateTimeInput('getDate'));
			var deliveryouttime1=new Date($('#deliveryouttime').jqxDateTimeInput('getDate'));
			var ondeliverydate1=new Date($('#ondeliverydate').jqxDateTimeInput('getDate'));
			ondeliverydate1.setHours(0,0,0,0);
			deliveryoutdate1.setHours(0,0,0,0);
			var ondeliverytime1=new Date($('#ondeliverytime').jqxDateTimeInput('getDate'));
			$('#dateout').jqxDateTimeInput({ disabled: true});
 			$('#timeout').jqxDateTimeInput({ disabled: true});
 			var incollectdate1=new Date($('#incollectdate').jqxDateTimeInput('getDate'));
 			var incollecttime1=new Date($('#incollecttime').jqxDateTimeInput('getDate'));
 			incollectdate1.setHours(0,0,0,0);
/*  			alert("On Delivery Date:"+$('#ondeliverydate').jqxDateTimeInput('getDate'));
 			alert("Delivery Out Date:"+$('#deliveryoutdate').jqxDateTimeInput('getDate') );*/
 			if(document.getElementById("chkcollection").checked==false && document.getElementById("chkdelivery").checked==false){
     			document.getElementById("errormsg").innerText="";
     			document.getElementById("errormsg").innerText="Collection/Delivery is Mandatory";
     			return false;
     		}
     		if(document.getElementById("chkcollection").checked==true){
     			if(document.getElementById("collectdriver").value==''){
     				document.getElementById("errormsg").innerText="";
     				document.getElementById("errormsg").innerText="Please Select Collection Driver";
     				document.getElementById("collectdriver").focus();
     				return false;
     			}
     			if($('#oncollectdate').jqxDateTimeInput('getDate')==null){
     				document.getElementById("errormsg").innerText="";
         			document.getElementById("errormsg").innerText="Collection Date is Mandatory";
         			$('#oncollectdate').jqxDateTimeInput('focus'); 
         			return false;
     			}
     			
     			var collectdateval=funDateInPeriod($('#oncollectdate').jqxDateTimeInput('getDate'));
     			if(collectdateval==0){
     				$('#oncollectdate').jqxDateTimeInput('focus');
     				return false;
     			}
     			else{
     				document.getElementById("errormsg").innerText="";
     			}
     			if($('#oncollecttime').jqxDateTimeInput('getDate')==null){
     				document.getElementById("errormsg").innerText="";
         			document.getElementById("errormsg").innerText="Collection Time is Mandatory";
         			$('#oncollecttime').jqxDateTimeInput('focus'); 
         			return false;
     			}
     			if($('#incollectdate').jqxDateTimeInput('getDate')==null){
     				document.getElementById("errormsg").innerText="";
         			document.getElementById("errormsg").innerText="In Date is Mandatory";
         			$('#incollectdate').jqxDateTimeInput('focus'); 
         			return false;
     			}
     			var colindateval=funDateInPeriod($('#incollectdate').jqxDateTimeInput('getDate'));
     			if(colindateval==0){
     				$('#incollectdate').jqxDateTimeInput('focus');
     				return false;
     			}
     			else{
     				document.getElementById("errormsg").innerText="";
     			}
     			if($('#incollecttime').jqxDateTimeInput('getDate')==null){
     				document.getElementById("errormsg").innerText="";
         			document.getElementById("errormsg").innerText="In Time is Mandatory";
         			$('#incollecttime').jqxDateTimeInput('focus'); 
         			return false;
     			}
     			if(oncollectdate1<deliveryoutdate1){
     				document.getElementById("errormsg").innerText="";
     				document.getElementById("errormsg").innerText="Collect Date cannot be less than Vehicle out Date";
     				$('#oncollectdate').jqxDateTimeInput('focus'); 
         			return false;
     			}
     			if(oncollectdate1-deliveryoutdate1==0){
     				if(oncollecttime1.getHours()<deliveryoutdate1.getHours()){
     					document.getElementById("errormsg").innerText="";
             			document.getElementById("errormsg").innerText="Collection Time cannot be less than Vehicle out Time";
             			$('#oncollecttime').jqxDateTimeInput('focus'); 
             			return false;
     				}
     				if(oncollecttime1.getHours()==deliveryoutdate1.getHours()){
     					if(oncollecttime1.getMinutes()<oncollecttime1.getMinutes()){
     						document.getElementById("errormsg").innerText="";
                 			document.getElementById("errormsg").innerText="Collection Time cannot be less than Vehicle out Time";
                 			$('#oncollecttime').jqxDateTimeInput('focus'); 
                 			return false;
     					}
     					else{
     						
     					}
     				}
     			}
     			
     		if(incollectdate1<oncollectdate1){
     			document.getElementById("errormsg").innerText="";
     			document.getElementById("errormsg").innerText="In Date Cannot be less than Collection Date";
     			$('#incollectdate').jqxDateTimeInput('focus');
     			return false;
     		}	
     		if(incollectdate1-oncollectdate1==0){
     			if(incollecttime1.getHours()<oncollecttime1.getHours()){
     				document.getElementById("errormsg").innerText="";
         			document.getElementById("errormsg").innerText="Collection Time Cannot be less than In Time";
         			$('#oncollecttime').jqxDateTimeInput('focus');
         			return false;
     			}
     			if(incollecttime1.getHours()==oncollecttime1.getHours()){
     				if(incollecttime1.getMinutes()<oncollecttime1.getMinutes()){
     					document.getElementById("errormsg").innerText="";
             			document.getElementById("errormsg").innerText="Collection Time Cannot be less than In Time";
             			$('#incollecttime').jqxDateTimeInput('focus');
             			return false;	
     				}
     			}
     		}
     		if(document.getElementById("oncollectkm").value==''){
     			document.getElementById("errormsg").innerText="";
     			document.getElementById("errormsg").innerText="Collection Km cannot be Empty";
     			document.getElementById("oncollectkm").focus();
     			return false;
     		}
     		if(parseFloat(document.getElementById("oncollectkm").value)==0.0){
     			document.getElementById("errormsg").innerText="";
     			document.getElementById("errormsg").innerText="Collection Km cannot be Empty";
     			document.getElementById("oncollectkm").focus();
     			return false;
     		}
     		if(parseFloat(document.getElementById("oncollectkm").value)<parseFloat(outkm)){
     			document.getElementById("errormsg").innerText="";
     			document.getElementById("errormsg").innerText="Collection Km cannot be less than Agreement Km";
     			document.getElementById("oncollectkm").focus();
     			return false;
     		}
     		if(document.getElementById("cmboncollectfuel").value==''){
     			document.getElementById("errormsg").innerText="";
     			document.getElementById("errormsg").innerText="Please select Collect fuel";
     			document.getElementById("cmboncollectfuel").focus();
     			return false;
     		}
     		
     		if(parseFloat(document.getElementById("incollectkm").value)<parseFloat(document.getElementById("oncollectkm").value)){
     			document.getElementById("errormsg").innerText="";
     			document.getElementById("errormsg").innerText="In Km Cannot be less than Collection Km";
     			document.getElementById("incollectkm").focus();
     			return false;
     		}
     		
     		}
     		if(document.getElementById("incollectkm").value==''){
     			document.getElementById("errormsg").innerText="";
     			document.getElementById("errormsg").innerText="In Km cannot be Empty";
     			document.getElementById("incollectkm").focus();
     			return false;
     		}
     		if(parseFloat(document.getElementById("incollectkm").value)==0.0){
     			document.getElementById("errormsg").innerText="";
     			document.getElementById("errormsg").innerText="In Km cannot be Empty";
     			document.getElementById("incollectkm").focus();
     			return false;
     		}
     		if(parseFloat(document.getElementById("incollectkm").value)<parseFloat(outkm)){
     			document.getElementById("errormsg").innerText="";
     			document.getElementById("errormsg").innerText="In Km Cannot be less than Agreement Km";
     			document.getElementById("incollectkm").focus();
     			return false;
     		}
     		if(document.getElementById("cmbincollectfuel").value==''){
     			document.getElementById("errormsg").innerText="";
     			document.getElementById("errormsg").innerText="In Fuel cannot be Empty";
     			document.getElementById("cmbincollectfuel").focus();
     			return false;
     		}
     		if(document.getElementById("cmbinbranch").value==''){
     			document.getElementById("errormsg").innerText="";
     			document.getElementById("errormsg").innerText="Select In Branch";
     			document.getElementById("cmbinbranch").focus();
     			return false;
     		}
     		if(document.getElementById("cmbinlocation").value==''){
     			document.getElementById("errormsg").innerText="";
     			document.getElementById("errormsg").innerText="Select In Location";
     			document.getElementById("cmbinlocation").focus();
     			return false;
     		}
     		if(document.getElementById("chkdelivery").checked==true){
     			if(document.getElementById("deliverydriver").value==''){
     				document.getElementById("errormsg").innerText="";
         			document.getElementById("errormsg").innerText="Please Select Driver";
         			document.getElementById("deliverydriver").focus();
         			return false;
     			}
     			if($('#deliveryoutdate').jqxDateTimeInput('getDate')==null){
     				document.getElementById("errormsg").innerText="";
         			document.getElementById("errormsg").innerText="Delivery Date is Mandatory";
         			$('#deliveryoutdate').jqxDateTimeInput('focus'); 
         			return false;
     			}
     			
     			var deliverydateval=funDateInPeriod($('#deliveryoutdate').jqxDateTimeInput('getDate'));
     			if(deliverydateval==0){
     				$('#deliveryoutdate').jqxDateTimeInput('focus');
     				return false;
     			}
     			else{
     				document.getElementById("errormsg").innerText="";
     			}
     			if($('#deliveryouttime').jqxDateTimeInput('getDate')==null){
     				document.getElementById("errormsg").innerText="";
         			document.getElementById("errormsg").innerText="Delivery Time is Mandatory";
         			$('#deliveryouttime').jqxDateTimeInput('focus'); 
         			return false;
     			}
    		if(deliveryoutdate1<ondeliverydate1){
    			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="Delivery Date cannot be less than Out Date";
    			$('#deliveryoutdate').jqxDateTimeInput('focus'); 
    			return false;
    		}
    		if(deliveryoutdate1-ondeliverydate1==0){
    			if(deliveryouttime1.getHours()<ondeliverytime1.getHours()){
    				document.getElementById("errormsg").innerText="";
        			document.getElementById("errormsg").innerText="Delivery Time cannot be less than Out Time";
        			$('#deliveryouttime').jqxDateTimeInput('focus'); 
        			return false;
    			}
    			if(deliveryouttime1.getHours()==ondeliverytime1.getHours()){
    			if(deliveryouttime1.getMinutes()<ondeliverytime1.getMinutes()){
    				document.getElementById("errormsg").innerText="";
        			document.getElementById("errormsg").innerText="Delivery Time cannot be less than Out Time";
        			$('#deliveryouttime').jqxDateTimeInput('focus'); 
        			return false;
    			}
    			}
    		}
    		if(document.getElementById("chkcollection").checked==true){
    			if(deliveryoutdate1<oncollectdate1){
        			document.getElementById("errormsg").innerText="";
        			document.getElementById("errormsg").innerText="Delivery Date cannot be less than Collection Date";
        			$('#deliveryouttime').jqxDateTimeInput('focus'); 
        			return false;
        		}
        		if(deliveryoutdate1-oncollectdate1==0){
        			if(deliveryouttime1.getHours()<oncollecttime1.getHours()){
        				document.getElementById("errormsg").innerText="";
            			document.getElementById("errormsg").innerText="Delivery Time cannot be less than Collection Time";
            			$('#deliveryouttime').jqxDateTimeInput('focus'); 
            			return false;
        			}
        			if(deliveryouttime1.getHours()==oncollecttime1.getHours()){
        				if(deliveryouttime1.getMinutes()<=oncollecttime1.getMinutes()){
        					document.getElementById("errormsg").innerText="";
                			document.getElementById("errormsg").innerText="Delivery Time must be Greater than Collection Time";
                			$('#deliveryouttime').jqxDateTimeInput('focus'); 
                			return false;
        				}
        			}
        		}
    		}
    		
     		if(document.getElementById("deliveryoutkm").value==''){
     			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="Delivery Km cannot be Empty";
    			document.getElementById("deliveryoutkm").focus();
    			return false;
     		}	
     		if(parseFloat(document.getElementById("deliveryoutkm").value)==0.0){
     			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="Delivery Km cannot be Empty";
    			document.getElementById("deliveryoutkm").focus();
    			return false;
     		}
     		if(parseFloat(document.getElementById("deliveryoutkm").value)<parseFloat(document.getElementById("ondeliverykm").value)){
     			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="Delivery Km Cannot be Less than Out Km";
    			document.getElementById("deliveryoutkm").focus();
    			return false;
     		}
     		if(document.getElementById("cmbdeliveryoutfuel").value==""){
     			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="Please Select Delivery Fuel";
    			document.getElementById("cmbdeliveryoutfuel").focus();
    			return false;
     		}
     		}
     		
     		document.getElementById("errormsg").innerText="";
     		document.getElementById("mode").value="update";
     		dateenable();
     		$('#cmbondeliveryfuel').attr('disabled',false);
     		$('#cmbdeliveryoutfuel').attr('disabled',false);
     		
     		$('#btnSave').mousedown();
     
     	}
     	 $(function(){
 	        $('#frmReplacement').validate({
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
     	
     	 
     	function funPrintBtn(){
     		 /*   if (($("#mode").val() == "view") && $("#docno").val()!="") { */
     		  
     		      
     		   var url=document.URL;

     		 
     	    var reurl=url.split("saveReplacement");

     	 var win= window.open(reurl[0]+"printReplacements?docno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
     	win.focus(); 
     		   /* } 
     		  
     		   else {
     	 	      $.messager.alert('Message','Select a Document....!','warning');
     	 	      return false;
     	 	     } */
     	 	
     		} 
  </script>

 
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmReplacement" action="saveReplacement" autocomplete="off">
	<script>
			window.parent.formName.value="Replacement";
			window.parent.formCode.value="RPL";
	</script>
	<jsp:include page="../../../../header.jsp" />
	<br/>
<div class='hidden-scrollbar'>
    <fieldset>
      <legend>Vehicle Info As In Agreement</legend>
      <table width="100%">
        <tr>
          <td align="right">Date</td>
          <td width="7%"><div id="date" name="date" value='<s:property value="date"/>'></div>
		    </td><input type="hidden" id="hidddate" name="hidddate" value='<s:property value="hidddate"/>'/>
          <td width="6%" align="right">Rental Type</td>
          <td width="7%"><select id="cmbrentaltype" name="cmbrentaltype" value='<s:property value="cmbrentaltype"/>'>
            <option value="">--Select--</option><option value="RAG">Rental</option><option value="LAG">Lease</option>
          </select></td>
          <td width="4%" align="right">Branch</td>
          <td width="8%" align="left"><select name="cmbagmtbranch" id="cmbagmtbranch" value='<s:property value="cmbagmtbranch"/>' style="width:96%;"><option value="">--Select--</option></select></td>
          <input type="hidden" name="hidcmbagmtbranch" id="hidcmbagmtbranch" value='<s:property value="hidcmbagmtbranch"/>' >
          <td align="right">Ref No</td>
          <td colspan="3" align="align"><input type="text" id="refvocno" name="refvocno" value='<s:property value="refvocno"/>' placeholder="Press F3 to Search" readonly onKeyDown="getAgmtno(event);"/>            <input type="text" id="refname" name="refname" style="width:60%;" value='<s:property value="refname"/>' readonly/></td>
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
          <td colspan="5" align="left"><input type="text" id="txtfleetno" name="txtfleetno" value='<s:property value="txtfleetno"/>' readonly/>
            <input type="text" id="txtfleetname" name="txtfleetname" style="width:71%;" value='<s:property value="txtfleetname"/>' readonly/></td>
          <td width="6%" align="right">Date Out</td>
          <td width="12%" align="left"><div id="dateout" name="dateout" value='<s:property value="dateout"/>'></div></td>
          <input type="hidden" name="hiddateout" id="hiddateout" value='<s:property value="hiddateout"/>'/>
          <td width="8%" align="right">Time Out</td>
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
            
          <td align="right">Replace Type</td>
          <td><select name="cmbreplacetype" id="cmbreplacetype" style="width:95%;" onchange="checkReplace();">
            <option value="">--Select--</option>
            <option value="atbranch">At Branch</option>
            <option value="collection">Collection</option>
          </select></td>
          <input type="hidden" id="hidcmbtrreason" name="hidcmbtrreason" value='<s:property value="hidcmbtrreason"/>'/>
          <td align="right">&nbsp;</td>
          <td>&nbsp;</td>
          <input type="hidden" name="hiduser" id="hiduser" value='<s:property value="hiduser"/>'/>
          <input type="hidden" name="hidcmbreplacetype" id="hidcmbreplacetype" value='<s:property value="hidcmbreplacetype"/>' />
          <td align="right">&nbsp;</td>
          <td align="left">&nbsp;</td>
        </tr>
        <tr>
          <td align="right">Description</td>
          <td colspan="7" align="left"><input type="text" name="description" id="description" value='<s:property value="description"/>' style="width:100%;"/></td>
          <td align="right">&nbsp;</td>
          <td>&nbsp;</td>
          <td align="right">&nbsp;</td>
          <td>&nbsp;</td>
          <td align="right">&nbsp;</td>
          <td align="left">&nbsp;</td>
        </tr>
      </table>
    </fieldset>
    
 <table width="100%">
  <tr style="background: #ECF8E0;">
    <td><fieldset><legend>Vehicle In Info</legend><table width="100%">
      <tr>
        <td align="right"><input type="checkbox" id="chkcollection" name="chkcollection" onchange="checkCollection();">
          Collection</td>
        <input type="hidden" name="hidchkcollection" id="hidchkcollection" value='<s:property value="hidchkcollection"/>'/>
        
        <td align="left"><input type="text" name="collectdriver" id="collectdriver" value='<s:property value="collectdriver"/>' onkeydown="getCollectDriver(event);"/></td>
        <input type="hidden" name="hidcollectdriver" id="hidcollectdriver" value='<s:property value="hidcollectdriver"/>'/>
        <td align="right">User</td>
        <td align="left"><input type="text" id="outuser" name="outuser" value='<s:property value="outuser"/>'/></td>
        <td align="right">&nbsp;</td>
        <td align="left"><input type="button" name="btnupdate" id="btnupdate" class="myButton" value="Update" onclick="funupdate();">
        <input type="button" name="btnsave" id="btnsave" class="myButton" value="Save" onclick="funsave();">
        </td>
        <td align="right">&nbsp;</td>
        <td colspan="5" align="left">&nbsp;</td>
        </tr>
      <tr>
        <td width="9%" align="right">Collect Details : Date</td>
        <td width="12%" align="left"><div id="oncollectdate" name="oncollectdate" value='<s:property value="oncollectdate"/>'></div></td>
        <input type="hidden" name="hidoncollectdate" id="hidoncollectdate" value='<s:property value="hidoncollectdate"/>'/>
        <td width="8%" align="right">Time</td>
        <td width="11%" align="left"><div id='oncollecttime' name='oncollecttime' value='<s:property value="oncollecttime"/>'></div></td>
        <input type="hidden" id="hidoncollecttime" name="hidoncollecttime" value='<s:property value="hidoncollecttime"/>'/>
        <td width="10%" align="right">KM</td>
        <td width="15%" align="left"><input type="text" id="oncollectkm" name="oncollectkm" style="width:50%" value='<s:property value="oncollectkm"/>' onkeypress="javascript:return isNumber (event,id)"/></td>
        <td width="8%" align="right">Fuel</td>
        <td colspan="5" align="left"><select id="cmboncollectfuel" name="cmboncollectfuel" value='<s:property value="cmboncollectfuel"/>'>
          <option value="">--Select--</option><option value=0.000>Level 0/8</option><option value=0.125>Level 1/8</option><option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option><option value=0.500>Level 4/8</option>
    <option value=0.625>Level 5/8</option><option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
          </select></td>
        <input type="hidden" id="hidcmboncollectfuel" name="hidcmboncollectfuel" value='<s:property value="hidcmboncollectfuel"/>'/>
        </tr>
      <tr>
        <td align="right">In Details : Date</td>
        <td align="left"><div id="incollectdate" name="incollectdate" value='<s:property value="incollectdate"/>'></div></td>
        <input type="hidden" name="hidincollectdate" id="hidincollectdate"  value='<s:property value="hidincollectdate"/>'>
        <td align="right">Time</td>
        <td align="left"><div id='incollecttime' name='incollecttime' value='<s:property value="incollecttime"/>'></div></td>
        <input type="hidden" id="hidincollecttime" name="hidincollecttime" value='<s:property value="hidincollecttime"/>'/>
        <td align="right">KM</td>
        <td align="left"><input type="text" id="incollectkm" name="incollectkm" style="width:50%" value='<s:property value="incollectkm"/>' onkeypress="javascript:return isNumber (event,id)"/></td>
        <td align="right">Fuel</td>
        <td width="6%" align="left"><select id="cmbincollectfuel" name="cmbincollectfuel" value='<s:property value="cmbincollectfuel"/>'>
          <option value="">--Select--</option><option value=0.000>Level 0/8</option><option value=0.125>Level 1/8</option><option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option><option value=0.500>Level 4/8</option>
    <option value=0.625>Level 5/8</option><option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
          </select></td>
        <td width="4%" align="right">Branch</td>
        <td width="6%" align="left"><select name="cmbinbranch" id="cmbinbranch" onchange="getLoc(this.value);"><option value="">--Select--</option></select></td>
        <td width="4%" align="right">Location</td>
        <td width="7%" align="left"><select name="cmbinlocation" id="cmbinlocation" ><option value="">--Select--</option></select></td>
        <input type="hidden" id="hidcmbincollectfuel" name="hidcmbincollectfuel" value='<s:property value="hidcmbincollectfuel"/>'/>
                <input type="hidden" id="hidcmbinbranch" name="hidcmbinbranch" value='<s:property value="hidcmbinbranch"/>'/>
<input type="hidden" id="hidcmbinlocation" name="hidcmbinlocation" value='<s:property value="hidcmbinlocation"/>'/>
        </tr>
      </table></fieldset>
  <tr style="background: #F7F2E0;">
   <td>
     <fieldset>
       <legend>New Vehicle Out Info</legend>
       <table width="100%">
         <tr>
           <td width="9%" align="right">Fleet</td>
           <td colspan="3" align="left"><input type="text" id="txtoutfleetno" name="txtoutfleetno" value='<s:property value="txtoutfleetno"/>' placeholder="Press F3 to Search" onKeyDown="getOutfleet(event);"/>
             <input type="text" id="txtoutfleetname" name="txtoutfleetname" style="width:65%;" value='<s:property value="txtoutfleetname"/>'/></td>
           <input type="hidden" name="hidoutbranch" id="hidoutbranch" value='<s:property value="hidoutbranch"/>'/>
           <input type="hidden" name="hidoutlocation" id="hidoutlocation" value='<s:property value="hidoutlocation"/>'/>
           <td align="right">Branch</td>
           <td align="left"><input type="text" name="outbranch" id="outbranch" value='<s:property value="outbranch"/>'/></td>
           <td align="right">Location</td>
           <td align="left"><input type="text" name="outlocation" id="outlocation" value='<s:property value="outlocation"/>'/></td>
           <td align="right">Delivery To</td>   

           <td align="left"><input type="text" name="deliveryto" id="deliveryto" value='<s:property value="deliveryto"/>'/></td>
           
           </tr>
         <tr>
           <td align="right"><input type="checkbox" name="chkdelivery" id="chkdelivery" onchange="checkDelivery();">
             Delivery</td>
           <input type="hidden" name="hidchkdelivery" id="hidchkdelivery" value='<s:property value="hidchkdelivery"/>'>
           <td width="12%" align="left"><input type="text" name="deliverydriver" id="deliverydriver" value='<s:property value="deliverydriver"/>' onkeydown="getDeliveryDriver(event)";/></td>
                 <input type="hidden" id="hiddeliverydriver" name="hiddeliverydriver" value='<s:property value="hiddeliverydriver"/>'/>

           <td width="8%" align="right">Del Details : Date</td>
           <td width="11%" align="left"><div id="deliveryoutdate" name="deliveryoutdate"  value='<s:property value="deliveryoutdate"/>'></div></td>
                 <input type="hidden" id="hiddeliveryoutdate" name="hiddeliveryoutdate" value='<s:property value="hiddeliveryoutdate"/>'/>

           <td width="10%" align="right">Time</td>
           <td width="8%" align="left"><div id="deliveryouttime" name="deliveryouttime" value='<s:property value="deliveryouttime"/>'></div></td>
                 <input type="hidden" id="hiddeliveryouttime" name="hiddeliveryouttime" value='<s:property value="hiddeliveryouttime"/>'/>

           <td width="10%" align="right">KM</td>
           <td width="11%" align="left"><input type="text" id="deliveryoutkm" name="deliveryoutkm" style="width:50%" value='<s:property value="deliveryoutkm"/>' onkeypress="javascript:return isNumber (event,id)"/></td>
           <td width="10%" align="right">Fuel</td>
           <td width="11%" align="left"><select id="cmbdeliveryoutfuel" name="cmbdeliveryoutfuel" value='<s:property value="cmbdeliveryoutfuel"/>'>
             <option value="">--Select--</option><option value=0.000>Level 0/8</option><option value=0.125>Level 1/8</option><option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option><option value=0.500>Level 4/8</option>
    <option value=0.625>Level 5/8</option><option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
           </select></td>
                 <input type="hidden" id="hidcmbdeliveryoutfuel" name="hidcmbdeliveryoutfuel" value='<s:property value="hidcmbdeliveryoutfuel"/>'/>
           </tr>
         <tr>
           <td align="right">User</td>
           <td align="left"><input type="text" id="user" name="user" value='<s:property value="user"/>' readonly/></td>
           <input type="hidden" name="hidoutuser" id="hidoutuser" value='<s:property value="hidoutuser"/>'/>
           <td align="right"> Out Details : Date</td>
           <td align="left"><div id="ondeliverydate" name="ondeliverydate" value='<s:property value="ondeliverydate"/>'></div></td>
                 <input type="hidden" id="hidondeliverydate" name="hidondeliverydate" value='<s:property value="hidondeliverydate"/>'/>

           <td align="right">Time</td>
           <td align="left"><div id="ondeliverytime" name="ondeliverytime" value='<s:property value="ondeliverytime"/>'></div></td>
                 <input type="hidden" id="hidondeliverytime" name="hidondeliverytime" value='<s:property value="hidondeliverytime"/>'/>

           <td align="right">KM</td>
           <td align="left"><input type="text" id="ondeliverykm" name="ondeliverykm" style="width:50%" value='<s:property value="ondeliverykm"/>' onkeypress="javascript:return isNumber (event,id)"/></td>
           <td align="right">Fuel</td>
           <td align="left"><select id="cmbondeliveryfuel" name="cmbondeliveryfuel" value='<s:property value="cmbondeliveryfuel"/>'>
             <option value="">--Select--</option><option value=0.000>Level 0/8</option><option value=0.125>Level 1/8</option><option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option><option value=0.500>Level 4/8</option>
    <option value=0.625>Level 5/8</option><option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
           </select></td>
                 <input type="hidden" id="hidcmbondeliveryfuel" name="hidcmbondeliveryfuel" value='<s:property value="hidcmbondeliveryfuel"/>'/>
           </tr>
         </table>
       </fieldset>
   </td>
   </tr>
 </table>

<input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'  />
<input type="hidden" name="dtype" id="dtype" value='<s:property value="dtype"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<div id="dateouthidden" name="dateouthidden" hidden="true"></div>
<div id="timeouthidden" name="timeouthidden" hidden="true"></div>
<input type="hidden" id="infleettrancode" name="infleettrancode"  value='<s:property value="infleettrancode"/>'/>
<input type="hidden" id="refno" name="refno" value='<s:property value="refno"/>' placeholder="Press F3 to Search" readonly onkeydown="getAgmtno(event);"/>

</div>
<%-- <div id='reftime' name='reftime' value='<s:property value="reftime"/>'></div> --%>
</form>
<div id="agmtnowindow">
   <div ></div>
</div>
<div id="collectionwindow">
   <div ></div>
</div>
<!-- <div id="deliverywindow">
   <div ></div>
</div> -->
</div>
</body>
</html>