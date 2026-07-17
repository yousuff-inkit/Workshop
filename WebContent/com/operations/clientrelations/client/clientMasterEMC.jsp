<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>

<jsp:include page="tab.css"/>
<%@ include file="tab.jsp" %> 

<script type="text/javascript">
      $(document).ready(function () {
    	  /* Date */
    	  $("#jqxClientDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    	  $("#jqxContractDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy" , value:null});
    	  $("#dateOfJoining").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy" , value:null});
    	  
    	  /* Searching Window */
    	 $('#nationalityWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Nation Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#nationalityWindow').jqxWindow('close');
 		 
    	 $('#stateWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'State Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#stateWindow').jqxWindow('close');
 		
 		getGroup();getSalesman();getCategory();getNationality();getSalutation();getContractDate();getContract();getIDPDetails();getTax();getNonTaxableEntity();
      }); 
      
      function hidedata(){
  		var contract=$('#txtforcontractdiv').val();
  		
  		if(parseInt(contract)==1){
  			   $("#contractDiv").prop("hidden", false);
  			   $("#sponsorDiv").attr("hidden", true);
  			}
  			else{
  				$("#contractDiv").prop("hidden", true);
  				$("#sponsorDiv").attr("hidden", false);
  			}
  		}
      
      function getContract(){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText;
	  			    $('#txtforcontractdiv').val(items);
	  			    hidedata();
	  		}
	  		}
	  		x.open("GET", "getContract.jsp", true);
	  		x.send();
	 }
	 
	function getIDPDetails(){
    		var x = new XMLHttpRequest();
    		x.onreadystatechange = function() {
    			if (x.readyState == 4 && x.status == 200) {
    				var items = x.responseText;
    			    $('#idpdetailsallowed').val(items);
    		}
    		}
    		x.open("GET", "getIDPDetailsAllowed.jsp", true);
    		x.send();
    }
      
      function getSalutation() {
    		var x = new XMLHttpRequest();
    		x.onreadystatechange = function() {
    			if (x.readyState == 4 && x.status == 200) {
    				var items = x.responseText;
    				items = items.split('####');
    				var salutnItems = items[0].split(",");
    				var salutnIdItems = items[1].split(",");
    				var optionssalutn = '<option value="">--Select--</option>';
    				for (var i = 0; i < salutnItems.length; i++) {
    					optionssalutn += '<option value="' + salutnItems[i] + '">'
    							+ salutnItems[i] + '</option>';
    				}
    				$("select#cmbsalutation").html(optionssalutn);
    				if ($('#hidcmbsalutation').val() != null) {
    					$('#cmbsalutation').val($('#hidcmbsalutation').val());
    				}
    			} else {
    			}
    		}
    		x.open("GET", "getSalutation.jsp", true);
    		x.send();
    	} 
     
      function getGroup() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var groupItems = items[0].split(",");
  				var groupIdItems = items[1].split(",");
  				var optionsgroup = '<option value="">--Select--</option>';
  				for (var i = 0; i < groupItems.length; i++) {
  					optionsgroup += '<option value="' + groupIdItems[i] + '">'
  							+ groupItems[i] + '</option>';
  				}
  				$("select#cmbgroup1").html(optionsgroup);
  				if ($('#hidcmbgroup1').val() != null) {
  					$('#cmbgroup1').val($('#hidcmbgroup1').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "getGroup.jsp", true);
  		x.send();
  	} 
	
	function getCategoryAccountGroup(a) {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText.trim();
  			    $('#hidcmbgroup1').val(items);
  				
  				if ($('#hidcmbgroup1').val() != null || $('#hidcmbgroup1').val() != "") {
  					$('#cmbgroup1').val($('#hidcmbgroup1').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "getCategoryAccountGroup.jsp?category="+a, true);
  		x.send();
  	} 
     
      function getSalesman() {
    		var x = new XMLHttpRequest();
    		x.onreadystatechange = function() {
    			if (x.readyState == 4 && x.status == 200) {
    				var items = x.responseText;
    				items = items.split('####');
    				var salesagentItems = items[0].split(",");
    				var salesagentIdItems = items[1].split(",");
    				var linkItems = items[2].split(",");
    				
    				var optionssalesagent;
    				for (var i = 0; i < salesagentItems.length; i++) {
    					if(parseInt(linkItems[i])==1) {
	    					optionssalesagent += '<option value="' + salesagentIdItems[i] + '">'
	    							+ salesagentItems[i] + '</option>';
    					} else {
    						if(i==0) {
	    						optionssalesagent = '<option value="">--Select--</option>';
	    						optionssalesagent += '<option value="' + salesagentIdItems[i] + '">'
								+ salesagentItems[i] + '</option>';
    						} else {
    							optionssalesagent += '<option value="' + salesagentIdItems[i] + '">'
								+ salesagentItems[i] + '</option>';
    						}
    					}
    				}
    				$("select#cmbsalesman").html(optionssalesagent);
    				if ($('#hidcmbsalesman').val() != null) {
    					$('#cmbsalesman').val($('#hidcmbsalesman').val());
    				}
    			} else {
    			}
    		}
    		x.open("GET", "getSalesagent.jsp", true);
    		x.send();
    	}
      
      function getCategory() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var categoryItems = items[0].split(",");
  				var categoryIdItems = items[1].split(",");
  				var optionscategory = '<option value="">--Select--</option>';
  				for (var i = 0; i < categoryItems.length; i++) {
  					optionscategory += '<option value="' + categoryIdItems[i] + '">'
  							+ categoryItems[i] + '</option>';
  				}
  				$("select#cmbcategory").html(optionscategory);
  				if ($('#hidcmbcategory').val() != null) {
  					$('#cmbcategory').val($('#hidcmbcategory').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "getCategory.jsp", true);
  		x.send();
  	}
      
      function getCurrencyIds(){
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 	items= x.responseText;
				 	items=items.split('####');
			        var curidItems=items[0];
			        var curcodeItems=items[1];
			        var multiItems=items[2];
			        var optionscurr = '';
			        
			     if(curcodeItems.indexOf(",")>=0){
			        	var currencyid=curidItems.split(",");
			        	var currencycode=curcodeItems.split(",");
			        	multiItems.split(",");
			       
			       for ( var i = 0; i < currencycode.length; i++) {
			    	   optionscurr += '<option value="' + currencyid[i] + '">' + currencycode[i] + '</option>';
			        }
			      
			         $("select#cmbcurrency").html(optionscurr);
			         if ($('#hidcmbcurrency').val() != null && $('#hidcmbcurrency').val() != "") {
			       		 $('#cmbcurrency').val($('#hidcmbcurrency').val()) ;
			         } 
					     
				   }
			
			       else{
			    	   optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
			    	   
				    	 $("select#cmbcurrency").html(optionscurr);
				       
				         if ($('#hidcmbcurrency').val() != null && $('#hidcmbcurrency').val() != "") {
				       		 $('#cmbcurrency').val($('#hidcmbcurrency').val()) ;
				         }
				      }
				}
		     }
		      x.open("GET", "getCurrencyId.jsp",true);
		     x.send();
		    
		   }
     
      function getNationality() {
    		var x = new XMLHttpRequest();
    		x.onreadystatechange = function() {
    			if (x.readyState == 4 && x.status == 200) {
    				var items = x.responseText;
    				items = items.split('####');
    				var nationItems = items[0].split(",");
    				var nationIdItems = items[1].split(",");
    				var optionsnation = '<option value="">--Select--</option>';
    				for (var i = 0; i < nationItems.length; i++) {
    					optionsnation += '<option value="' + nationIdItems[i] + '">'
    							+ nationItems[i] + '</option>';
    				}
    				$("select#cmbnationality").html(optionsnation);
    				if ($('#hidcmbnationality').val() != null) {
    					$('#cmbnationality').val($('#hidcmbnationality').val());
    				}
    			} else {
    			}
    		}
    		x.open("GET", "getNationality.jsp", true);
    		x.send();
    	} 
      
      function getClientAlreadyExists(clientname,salutation,docno,mode){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();

					if(parseInt(items)==1){
	  					 document.getElementById("errormsg").innerText="Client Already Exists.";
	  					 return 0;
	  				 } else {
	  					 
	  					 var driverdetails = new Array();
	  					 
	  					 var rowsverify = $("#jqxDriver").jqxGrid('getrows');
	  					 for(var z=0 ; z < rowsverify.length ; z++){
	  						var chkverify=rowsverify[z].name;
	  						if(typeof(chkverify) != "undefined" && typeof(chkverify) != "NaN" && chkverify != ""){
	  							driverdetails.push(rowsverify[z].name+" ::"+rowsverify[z].mobno+" ::"+rowsverify[z].dlno+" ::"+rowsverify[z].dr_id);
	  						}
	  					 }
	  					 
	  				    getDriverDetailsVerification(driverdetails,docno,mode);
	  				 }
	  			   
	  		}
		}
		x.open("GET", "getClientAlreadyExists.jsp?clientname="+clientname+"&salutation="+salutation+"&docno="+docno+"&mode="+mode, true);
		x.send();
   }
    
    
    function getDriverDetailsVerification(driverdetails,docno,mode) {
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();
	  			    items = items.split('####');
	  			
	  				if(parseInt(items[0])==1){
	  					 document.getElementById("errormsg").innerText="Driver Details is Mandatory.";
	  					 return 0;
	  				 } else if(parseInt(items[0])==2){
	  					 document.getElementById("errormsg").innerText=""+items[1]+" (Driver) Mobile Number Required.";
	  					 return 0;
	  				 } else if(parseInt(items[0])==3){
	  					 document.getElementById("errormsg").innerText=""+items[1]+" (Driver) Mobile Number Already Exists.";
	  					 return 0;
	  				 } else if(parseInt(items[0])==4){
	  					 document.getElementById("errormsg").innerText=""+items[1]+" (Driver) Licence Number Required.";
	  					 return 0;
	  				 } else if(parseInt(items[0])==5){
	  					 document.getElementById("errormsg").innerText=""+items[1]+" (Driver) Licence Number Already Exists.";
	  					 return 0;
	  				 } else {
	  					 
	  					var rows = $("#jqxDriver").jqxGrid('getrows');
	  				    var length=0;
	  					 for(var i=0 ; i < rows.length ; i++){
	  						var chk=rows[i].name;
	  						if(typeof(chk) != "undefined"){
	  							length=length+1;
	  							newTextBox = $(document.createElement("input"))
	  						    .attr("type", "dil")
	  						    .attr("id", "test"+i)
	  						    .attr("name", "test"+i)
	  						    .attr("hidden", "true");
	  					
	  					newTextBox.val(rows[i].name+" :: "+rows[i].hiddob+":: "+rows[i].nation1+":: "+rows[i].mobno+":: "+rows[i].passport_no+":: "+rows[i].hidpassexp+":: "+rows[i].dlno+":: "+rows[i].hidissdate+":: "+rows[i].issfrm+":: "+rows[i].hidled+":: "+rows[i].ltype+":: "+rows[i].visano+":: "+rows[i].hidvisaexp+"::"+rows[i].dr_id+":: "+rows[i].hcdlno+":: "+rows[i].hidhcissdate+":: "+rows[i].hidhcled);
	  					newTextBox.appendTo('form');
	  					 }
	  					}
	  		 		 $('#gridlength').val(length);
	  		 		
	  		 		 var rows = $("#jqxReferenceDetails").jqxGrid('getrows');
	  		 		 var referencelength=0;
	  		 		 for(var i=0 ; i < rows.length ; i++){
	  		 				var chkd=rows[i].cperson;
	  						if(typeof(chkd) != "undefined"){
	  						referencelength=referencelength+1;
	  						newTextBox = $(document.createElement("input"))
	  					    .attr("type", "dil")
	  					    .attr("id", "txtreference"+i)
	  					    .attr("name", "txtreference"+i)
	  					    .attr("hidden", "true");
	  				
	  					newTextBox.val(rows[i].cperson+" :: "+rows[i].desig+" :: "+rows[i].mob+" :: "+rows[i].email+" ::");
	  					newTextBox.appendTo('form');
	  					}
	  			      }
	  			      $('#referencelength').val(referencelength);
	  			      
	  			      var rows = $("#jqxCreditCardDetails").jqxGrid('getrows');
	  					 var creditcardlength=0;
	  						 for(var i=0 ; i < rows.length ; i++){
	  							var chkng=rows[i].type;
	  							if(typeof(chkng) != "undefined"){
	  								creditcardlength=creditcardlength+1;
	  								newTextBox = $(document.createElement("input"))
	  							    .attr("type", "dil")
	  							    .attr("id", "txtcard"+i)
	  							    .attr("name", "txtcard"+i)
	  							    .attr("hidden", "true");
	  						
	  						newTextBox.val(rows[i].type+" :: "+rows[i].cardno+" :: "+rows[i].hidexpdate+":: "+rows[i].defaultcard+":: "+rows[i].remarks);
	  						newTextBox.appendTo('form');
	  						 }
	  						}
	  			 		 $('#creditcardlength').val(creditcardlength);
	  			 		 
					    $('#cmbgroup1').attr('disabled', false);
	  					$("#frmClientMaster").submit(); 
	  				 }
	  			   
	  		}
		}
		x.open("GET", "getDriverDetailsVerification.jsp?driverdetails="+driverdetails+"&docno="+docno+"&mode="+mode, true);
		x.send();
     }
	 
	 function getMobileNoAlreadyExists(mobileno,docno,mode){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();

	  				if(parseInt(items)==1){
	  					 $.messager.alert('Message','Personal Mobile No. Already Exists.','warning');
	  					 return 0;
	  				 }
	  		}
		}
		x.open("GET", "getMobileNoAlreadyExists.jsp?mobileno="+mobileno+"&docno="+docno+"&mode="+mode, true);
		x.send();
    }
    
	function getDrivingLicenceNoAlreadyExists(licenceno,docno,mode){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();

	  				if(parseInt(items)==1){
	  					$.messager.alert('Message','Licence# Already Exists.','warning');
	  					 return 0;
	  				 }  			   
	  		}
		}
		x.open("GET", "getDrivingLicenceNoAlreadyExists.jsp?licenceno="+licenceno+"&docno="+docno+"&mode="+mode, true);
		x.send();
    }
	
    function getVisaNoAlreadyExists(visano,docno,mode){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();

	  				if(parseInt(items)==1){
	  					$.messager.alert('Message','ID# Already Exists.','warning');
	  					 return 0;
	  				 }
	  			   
	  		}
		}
		x.open("GET", "getVisaNoAlreadyExists.jsp?visano="+visano+"&docno="+docno+"&mode="+mode, true);
		x.send();
    }
      
    function getPassportNoAlreadyExists(passportno,docno,mode){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();

	  				if(parseInt(items)==1){
	  					$.messager.alert('Message','Passport# Already Exists.','warning');
	  					 return 0;
	  				 }
	  			   
	  		}
		}
		x.open("GET", "getPassportNoAlreadyExists.jsp?passportno="+passportno+"&docno="+docno+"&mode="+mode, true);
		x.send();
    }

      
      function getContractDate(){
		if ($("#mode").val() == "A") {
			var curdate= $('#jqxClientDate').jqxDateTimeInput('getDate');
			var oneyeardate=new Date(new Date(curdate).setMonth(curdate.getMonth()+36));
			var oneyearafterdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
			$('#jqxContractDate ').jqxDateTimeInput('setDate', new Date(oneyearafterdate));
		}
      }
	  
	  function getDefaultService() {
    		var x = new XMLHttpRequest();
    		x.onreadystatechange = function() {
    			if (x.readyState == 4 && x.status == 200) {
    				var items = x.responseText;
    				items = items.split('####');
    				var serviceItems = items[0].split(",");
    				var serviceRateItems = items[1].split(",");
    				$('#txtsalik').val("0");
    				$('#txttraffic').val("0");
    				for (var i = 0; i < serviceItems.length; i++) {
      					if(serviceItems[i]=='saliksrv'){
        					$('#txtsalik').val(serviceRateItems[i]);
        				}else if(serviceItems[i]=='trafficsrv'){
        					$('#txttraffic').val(serviceRateItems[i]);
        				}
      				}
    				
    			} else {
    			}
    		}
    		x.open("GET", "getDefaultServiceCharge.jsp", true);
    		x.send();
    	}
		
	  function getDefaultInvoicingMethod(){
		  		var x = new XMLHttpRequest();
		  		x.onreadystatechange = function() {
		  			if (x.readyState == 4 && x.status == 200) {
		  				var items = x.responseText.trim();
		  			    $('#cmbinvoicing_method').val(items);
		  			    
		  		}
		  		}
		  		x.open("GET", "getDefaultInvoicingMethod.jsp", true);
		  		x.send();
		}
	  
	  function getNonTaxableEntity(){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();
	  			    if(parseInt(items)==1) {
	  			    	document.getElementById("lblnontaxableentity").style.display = 'none';
	  			    	$('#chcknontaxableentity').attr('hidden', false);
	  			    	document.getElementById("lbltrnnoentity").style.display = 'inline-block';
	  			    	$('#txtregisteredtrnno').attr('hidden', false);
	  			    	if($('#mode').val()=='A') {
	  			    		$('#hidchcknontaxableentity').val(1);
							document.getElementById("chcknontaxableentity").checked = true;
	  			    	}
	  			    } else {
	  			    	document.getElementById("lblnontaxableentity").style.display = 'none';
	  			    	$('#chcknontaxableentity').attr('hidden', true);
	  			    	document.getElementById("lbltrnnoentity").style.display = 'none';
	  			    	$('#txtregisteredtrnno').attr('hidden', true);
	  			    	if($('#mode').val()=='A') {
	  			    		$('#hidchcknontaxableentity').val(0);
							document.getElementById("chcknontaxableentity").checked = false;
	  			    	}
	  			    }
	  			    
	  		}
	  		}
	  		x.open("GET", "getNonTaxableEntity.jsp", true);
	  		x.send();
	 }
	  
	  function getTax() {
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText;
	  				items = items.split('####');
	  				var taxItems = items[0].split(",");
	  				var taxIdItems = items[1].split(",");
	  				var optionstax = '<option value="0">--Select--</option>';
	  				for (var i = 0; i < taxItems.length; i++) {
	  					optionstax += '<option value="' + taxIdItems[i] + '">'
	  							+ taxItems[i] + '</option>';
	  				}
	  				$("select#cmbtax").html(optionstax);
	  				if ($('#hidcmbtax').val() != null) {
	  					$('#cmbtax').val($('#hidcmbtax').val());
	  				}
	  			} else {
	  			}
	  		}
	  		x.open("GET", "getTax.jsp", true);
	  		x.send();
	  	}
	  
	  function taxcheck() {
	 		 if($('#cmbtax').val()=='1'){
	 			 document.getElementById("chcknontaxableentity").checked=true;
	 			 document.getElementById("hidchcknontaxableentity").value = 1;
	  		 }
	 		 else if($('#cmbtax').val()=='2'){
	 			 document.getElementById("chcknontaxableentity").checked=false;
	 			 document.getElementById("hidchcknontaxableentity").value = 0;
	  		 }
	  		 else{
	  			 document.getElementById("chcknontaxableentity").checked=false;
	  			 document.getElementById("hidchcknontaxableentity").value = 0;
	  		 }
	 	 }
      
      function nationalitySearchContent(url) {
		 	$('#nationalityWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#nationalityWindow').jqxWindow('setContent', data);
			$('#nationalityWindow').jqxWindow('bringToFront');
		}); 
		}
      
      function stateSearchContent(url) {
		 	$('#stateWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#stateWindow').jqxWindow('setContent', data);
			$('#stateWindow').jqxWindow('bringToFront');
		}); 
		}
      
      $(function(){
	        $('#frmClientMaster').validate({
	                rules: {
	                txtclient_name:"required",
	                cmbcategory:"required",
	                // cmbsalesman:"required",
	                //cmbgroup1:"required",
	                //txtmob: {"required":true,digits:true,maxlength:12,minlength:12},
	                 
	                 },
	                 messages: {
	                 txtclient_name:" *",
	                 cmbcategory:" *",
	                 //cmbsalesman:" *",
	                 //cmbgroup1:" *",
	                 //txtmob: {required:" *",digits:" Invalid Mobile Number",maxlength:" Maximum 12 Digits",minlength:" Please Enter 12 Digits"},
	                 }
	        });});
      
     function defaultcheck(){
 		 if(document.getElementById("chckdefault").checked){
 			 document.getElementById("hidchckdefault").value = 1;
 			 $('#txtsalik').attr('readonly', true );
 			 $('#txttraffic').attr('readonly', true );
			 getDefaultService();
 			 
 		 }
 		 else{
 			 document.getElementById("hidchckdefault").value = 0;
 			 $('#txtsalik').attr('readonly', false );
 			 $('#txtsalik').val("0.0");
 			 $('#txttraffic').attr('readonly', false );
 			 $('#txttraffic').val("0.0");
 		 }
 	 }
     
	 function advancecheck(){
 		 if(document.getElementById("chckadvance").checked){
 			 document.getElementById("hidchckadvance").value = 1;
 		 }
 		 else{
 			 document.getElementById("hidchckadvance").value = 0;
 		 }
 	 }
	 
	 function nontaxableentitycheck() {
		 if(document.getElementById("chcknontaxableentity").checked){
 			 document.getElementById("hidchcknontaxableentity").value = 1;
 		 }
 		 else{
 			 document.getElementById("hidchcknontaxableentity").value = 0;
 		 }
	 }
	 
     function mobileValid(value){
    	   if(value!=""){ 
    	    var phoneno = /^\d{12}$/;  
			if(value.match(phoneno)){
				document.getElementById("errormsg").innerText="";
				$('#txtmobilevalidation').val(0);
				return true;
			}
			else{
				document.getElementById("errormsg").innerText="Invalid Mobile Number";
				$('#txtmobilevalidation').val(1);
				return false;
			}
    	    } 
    	   return true;
     }
 	 
	 function funReadOnly(){
			$('#frmClientMaster input').attr('readonly', true );
			$('#frmClientMaster select').attr('disabled', true);
			$('#jqxClientDate').jqxDateTimeInput({disabled: true});
			$('#jqxContractDate').jqxDateTimeInput({disabled: true});
			$('#dateOfJoining').jqxDateTimeInput({disabled: true});
			$('#chcknontaxableentity').attr('disabled', true);
			//$("#jqxDriver").jqxGrid({ disabled: true});
			$("#jqxReferenceDetails").jqxGrid({ disabled: true});
			$("#jqxCreditCardDetails").jqxGrid({ disabled: true});
	 }
	 
	 function funRemoveReadOnly(){
		    getContract();getIDPDetails();getNonTaxableEntity();
			$('#frmClientMaster input').attr('readonly', false );
			$('#frmClientMaster select').attr('disabled', false);
			$('#chckdefault').attr('disabled', false);
			$('#cmbgroup1').attr('disabled', true);
			$('#chcknontaxableentity').attr('disabled', false);
			$('#jqxClientDate').jqxDateTimeInput({disabled: false});
			$('#jqxContractDate').jqxDateTimeInput({disabled: false});
			$('#dateOfJoining').jqxDateTimeInput({disabled: false});
			$('#txtaccount').attr('readonly', true);
			$('#txtcode').attr('readonly', true);
			$('#docno').attr('readonly', true);
			//$("#jqxDriver").jqxGrid({ disabled: false});
			$("#jqxReferenceDetails").jqxGrid({ disabled: false});
			$("#jqxCreditCardDetails").jqxGrid({ disabled: false});
		
			
			if ($("#mode").val() == "A") {
					 getDefaultService();getDefaultInvoicingMethod();
		 			 $('#txtsalik').attr('readonly', true );
		 			 $('#txttraffic').attr('readonly', true );
		 			 $('#hidchckdefault').val(1);
					 $('#hidchckadvance').val(0);
					 document.getElementById("chckdefault").checked = true;
					 document.getElementById("chckadvance").checked = false;
					 $('#cmbsalesman').prop('selectedIndex',0);
					 $('#cmbtax').prop('selectedIndex',1);
					 
					$('#jqxClientDate').val(new Date());
					$('#jqxContractDate').val(null);
					$('#dateOfJoining').val(null);
					
					$("#jqxDriver").jqxGrid('clear'); 
					$("#jqxDriver").jqxGrid('addrow', null, {});
					$("#jqxCreditCardDetails").jqxGrid('clear'); 
					$("#jqxCreditCardDetails").jqxGrid('addrow', null, {});
					$("#jqxReferenceDetails").jqxGrid('clear'); 
					$("#jqxReferenceDetails").jqxGrid('addrow', null, {});
			}
			
			if ($("#mode").val() == "E") {
				$("#jqxDriver").jqxGrid('addrow', null, {});
				$("#jqxDriver").jqxGrid('hidecolumn', 'attachbtn');
				$("#jqxCreditCardDetails").jqxGrid('addrow', null, {});
				$("#jqxReferenceDetails").jqxGrid('addrow', null, {});
			}
	 }
	 function funNotify(){	
		 /* Validation */
		 
		 valid=document.getElementById("txtvalidation").value;
		 if(valid==1){
			 document.getElementById("errormsg").innerText="Invalid Values.";
			 return 0;
		 }
		 
		 accgroup=document.getElementById("txtcategoryvalidation").value;
		 if(accgroup==1){
			 document.getElementById("errormsg").innerText="Individual Client should have Retail Client A/C Group.";
			 return 0;
		 }
		 
		 chkvalid=document.getElementById("chkvalid").value;
		 if(chkvalid==1){
			 document.getElementById("errormsg").innerText="Invalid Values.";
			 return 0;
		 }
		 
		 if(window.parent.cardnumbervalidator.value==1){
			 var checkingcard="0";
			 var rows = $("#jqxCreditCardDetails").jqxGrid('getrows');
			 if(rows.length>0){
				 for(var l=0 ; l < rows.length ; l++){
					var cardno=rows[l].cardno;
					if(typeof(cardno) != "undefined"){
						var chckcardno=cardnumber(cardno);
						if(chckcardno=="0"){
							checkingcard="1";
							break;
						} 
					 }
				}
				if(checkingcard=="1"){
					document.getElementById("errormsg").innerText="Invalid Card Number.";
					return 0;
				}
			 }
		 }
		 
		 chkcardvalid=document.getElementById("chkcardvalid").value;
		 if(chkcardvalid==1){
			 document.getElementById("errormsg").innerText="Invalid Credit Card.";
			 return 0;
		 }
		 
		 if($("#personal_tel2").val()==""){
			/*  document.getElementById("errormsg").innerText="Invalid Mobile Number.";
			 return 0; */
		 }
		 
		 mobilevalid=document.getElementById("txtmobilevalidation").value;
		 if(mobilevalid==1){
			 document.getElementById("errormsg").innerText="Invalid Mobile Number.";
			 return 0;
		 }
		 
		 var tax=document.getElementById("cmbtax").value;
		 if(tax.trim()=='' || tax.trim()=='0'){
			 document.getElementById("errormsg").innerText="Tax is Mandatory.";
			 return 0;
		 }
		 
		 if($('#cmbtax').val()=='1'){
			 var registeredtrnno=document.getElementById("txtregisteredtrnno").value;
			 if(registeredtrnno.trim()==''){
				 document.getElementById("errormsg").innerText="TRN No. is Mandatory for VAT.";
				 return 0;
			 } 
		 }
		 
		 document.getElementById("errormsg").innerText="";		 
		 /* Validation Ends*/

	 		 clientname=document.getElementById("txtclient_name").value;
			 salutation=document.getElementById("cmbsalutation").value;
			 docno=document.getElementById("docno").value;
			 mode=document.getElementById("mode").value;
			 getClientAlreadyExists(clientname,salutation,docno,mode);
	    	
		} 
	 
	 function funSearchLoad(){
			changeContent('crmMainSearch.jsp'); 
		 }
	 
	 function funFocus(){
	    	$('#jqxClientDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	 /* function funCurrency(){
		 
		 if($('#hidcmbcurrency').val()!=""){
			 $('#cmbcurrency').val($('#hidcmbcurrency').val());
		 }
	 } */
	 
	 function setValues(){
		 
		    /* Enquiry Form dtype */
		    document.getElementById("formdetail").value="Client";
		    document.getElementById("formdetailcode").value="CRM";
		      
			 if($('#hidjqxClientDate').val()){
				 $("#jqxClientDate").jqxDateTimeInput('val', $('#hidjqxClientDate').val());
			  }
			 
			 if($('#hidjqxContractDate').val()){
				 $("#jqxContractDate").jqxDateTimeInput('val', $('#hidjqxContractDate').val());
			  }
			 
			 if($('#hiddateOfJoining').val()){
				 $("#dateOfJoining").jqxDateTimeInput('val', $('#hiddateOfJoining').val());
			  }
			 
			 if(document.getElementById("hidchckdefault").value==1){
	 			 document.getElementById("chckdefault").checked = true;
	 		 }
	 		 else if(document.getElementById("hidchckdefault").value==0){
	 			document.getElementById("chckdefault").checked = false;
	 		 }
			 
			 if(document.getElementById("hidchckadvance").value==1){
	 			 document.getElementById("chckadvance").checked = true;
	 		 }
	 		 else if(document.getElementById("hidchckadvance").value==0){
	 			document.getElementById("chckadvance").checked = false;
	 		 }
			 
			 if(document.getElementById("hidchcknontaxableentity").value==1){
	 			 document.getElementById("chcknontaxableentity").checked = true;
	 		 }
	 		 else if(document.getElementById("hidchcknontaxableentity").value==0){
	 			document.getElementById("chcknontaxableentity").checked = false;
	 		 }
			 
			 if($('#hidcmbcurrency').val()!=""){
				 getCurrencyIds();
				 $('#cmbcurrency').val($('#hidcmbcurrency').val());
			 }
			 
			// funCurrency();
			//document.getElementById("cmbcurrency").value=document.getElementById("hidcmbcurrency").value;
			document.getElementById("cmbinvoicing_method").value=document.getElementById("hidcmbinvoicing_method").value;
			$('#cmbdel_charges').val($('#hidcmbdel_charges').val());  
			
			 if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			 
			 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
			 funSetlabel();
            
             var indexVal = document.getElementById("docno").value;
			 if(indexVal> 0){
				 var check = 1;
				 $("#jqxDriver1").load("driver.jsp?txtclientdocno1="+indexVal+"&check="+check);
				 $("#creditCardDetailsDiv").load("creditCardDetailsGrid.jsp?txtclientdocno2="+indexVal+"&check="+check);
				 $("#jqxReferenceDetails1").load("referenceDetails.jsp?txtclientdocno3="+indexVal+"&check="+check);
			 }
		}
	 
	 function funChkButton() {
			/* funReset(); */
		}
	 
</script>

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmClientMaster" action="saveClientMaster" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>   

<div class='hidden-scrollbar'>
<fieldset>
<table width="100%">
  <tr>
    <td width="6%" align="right">Date</td>
    <td width="11%"><div id="jqxClientDate" name="jqxClientDate" onchange="getContractDate();" value='<s:property value="jqxClientDate"/>'></div>
    <input type="hidden" id="hidjqxClientDate" name="hidjqxClientDate" value='<s:property value="hidjqxClientDate"/>'/></td>
    <td width="7%" align="right">Code</td>
    <td width="7%"><input type="text" id="txtcode" name="txtcode" style="width:50%;" tabindex="-1" value='<s:property value="txtcode"/>'/></td>
    <td width="4%" align="right">Name</td>
    <td colspan="3"><input type="text" id="txtclient_name" name="txtclient_name" onfocus="getCurrencyIds();" style="width:97%;" value='<s:property value="txtclient_name"/>'/></td>
    <td width="7%"><select id="cmbsalutation" name="cmbsalutation" style="width:75%;" value='<s:property value="cmbsalutation"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbsalutation" name="hidcmbsalutation" value='<s:property value="hidcmbsalutation"/>'/></td>
    <td width="8%" align="right">Currency</td>
    <td width="11%"><select id="cmbcurrency" name="cmbcurrency" value='<s:property value="cmbcurrency"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency" value='<s:property value="hidcmbcurrency"/>'/></td>
    <td width="5%" align="right">Doc No</td>
    <td width="10%"><input type="text" id="docno" name="txtclientdocno" style="width:75%;" tabindex="-1" value='<s:property value="txtclientdocno"/>'/></td>
  </tr>
  <tr>
    <td align="right">Category</td>
    <td><select id="cmbcategory" name="cmbcategory" style="width:90%;" onchange="getCategoryAccountGroup(this.value);" value='<s:property value="cmbcategory"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbcategory" name="hidcmbcategory" value='<s:property value="hidcmbcategory"/>'/></td>
    <td align="right">Ref No.</td>
    <td colspan="3"><select id="cmbsalesman" name="cmbsalesman" style='display:none'  value='<s:property value="cmbsalesman"/>'>
      <option value="0">--Select--</option></select>
      <input type="hidden" id="hidcmbsalesman" name="hidcmbsalesman" value="0"/>
      <input type="text" id="txtrefernceno" name="txtrefernceno" style="width:80%;" value='<s:property value="txtrefernceno"/>'/></td>
    <td width="12%" align="left"><input type="checkbox" id="chcknontaxableentity" name="chcknontaxableentity" style="display: none;"  value="" onchange="nontaxableentitycheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)"><label id="lblnontaxableentity">Taxable Entity</label>
                                 <input type="hidden" id="hidchcknontaxableentity" name="hidchcknontaxableentity" value='<s:property value="hidchcknontaxableentity"/>'/></td>
    <td width="5%" align="left"><input type="checkbox" id="chckadvance" name="chckadvance" value="" onchange="advancecheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)">Advance
                                 <input type="hidden" id="hidchckadvance" name="hidchckadvance" value='<s:property value="hidchckadvance"/>'/></td>
    <td colspan="2" align="right">Invoicing Method</td>
    <td><select id="cmbinvoicing_method" name="cmbinvoicing_method" value='<s:property value="cmbinvoicing_method"/>'>
      <option value="">--Select--</option>
      <option value="1">Month End</option>
      <option value="2">Period</option></select>
      <input type="hidden" id="hidcmbinvoicing_method" name="hidcmbinvoicing_method" value='<s:property value="hidcmbinvoicing_method"/>'/></td>
    <td align="right">Del. Charges</td>
    <td><select id="cmbdel_charges" name="cmbdel_charges" value='<s:property value="cmbdel_charges"/>'>
      <option value="">--Select--</option>
      <option value=1>Yes</option>
      <option value=0>No</option></select>
      <input type="hidden" id="hidcmbdel_charges" name="hidcmbdel_charges" value='<s:property value="hidcmbdel_charges"/>'/></td>
  </tr>
   <tr>
    <td align="right"><label id="lbltaxableentity">Tax</label></td>
    <td><select id="cmbtax" name="cmbtax" style="width:90%;" onchange="taxcheck();" value='<s:property value="cmbtax"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbtax" name="hidcmbtax" value='<s:property value="hidcmbtax"/>'/></td>
    <td align="right"><label id="lbltrnnoentity">TRN No.</label></td>
    <td colspan="10"><input type="text" id="txtregisteredtrnno" name="txtregisteredtrnno" style="width:22%;" value='<s:property value="txtregisteredtrnno"/>'/></td>
  </tr>
</table>
</fieldset>
<table width="100%">
<tr><td width="60%">
<fieldset>
<table width="100%">
  <tr>
    <td width="15%" align="right">Account Group</td>
    <td width="16%"  colspan="3"><select id="cmbgroup1" name="cmbgroup1" style="width:80%;" value='<s:property value="cmbgroup1"/>'>
      <option value="">--Select--</option></select>
       <input type="hidden" id="hidcmbgroup1" name="hidcmbgroup1" value='<s:property value="hidcmbgroup1"/>'/></td>
   <td align="right">Account</td>
    <td width="33%"><input type="text" id="txtaccount" name="txtaccount" style="width:50%;" tabindex="-1" value='<s:property value="txtaccount"/>'/></td>
  </tr>
  <tr>
    <td align="right">Credit Period-Min(Days)</td>
    <td><input type="text" id="txtcredit_period_min" name="txtcredit_period_min" style="width:70%;text-align: right;" value='<s:property value="txtcredit_period_min"/>'/></td>
    <td width="8%" align="right">Max(Days)</td>
    <td width="19%"><input type="text" id="txtcredit_period_max" name="txtcredit_period_max" style="width:50%;text-align: right;" value='<s:property value="txtcredit_period_max"/>'/></td>
    <td width="9%" align="right">Credit Limit</td>
    <td><input type="text" id="txtcredit_limit" name="txtcredit_limit" style="width:50%;text-align: right;" value='<s:property value="txtcredit_limit"/>'/></td>
  </tr>
</table>
</fieldset></td>
<td width="40%">
<fieldset>
<legend>Service Charge</legend>
<table width="100%">
  <tr>
    <td width="40%" align="left"><input type="checkbox" id="chckdefault" name="chckdefault" value="" onchange="defaultcheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)">Default
                                 <input type="hidden" id="hidchckdefault" name="hidchckdefault" value='<s:property value="hidchckdefault"/>'/></td>
    <td width="4%" align="right">Salik</td>
    <td width="37%"><input type="text" id="txtsalik" name="txtsalik" style="text-align: right;"  value='<s:property value="txtsalik"/>'/></td>
    <td width="4%" align="right">Traffic</td>
    <td width="15%"><input type="text" id="txttraffic" name="txttraffic" style="text-align: right;"  value='<s:property value="txttraffic"/>'/></td>
  </tr>
</table>
</fieldset>
</td>
</tr></table>
<br/>

   <ul id="tabs">
    <li><a href="#" name="tab1">Driver Details</a></li>
    <li><a href="#" name="tab2">Know Your Customer</a></li>
    <li><a href="#" name="tab3">Banking Details</a></li>
    <li><a href="#" name="tab4">Others</a></li>
    </ul>
    
<div id="content"> 

<div id="tab1">
<div style="width:100%;">
 <div id="jqxDriver1"> <jsp:include page="driver.jsp"></jsp:include></div><br/>

</div>
</div>

<div id="tab2">
<div style="width:100%;">
<%-- <table width="100%">
  <tr>
    <td width="9%" align="right">Reference No.</td>
    <td width="40%"><input type="text" id="txtref_no" name="txtref_no" style="width:30%;" tabindex="1" value='<s:property value="txtref_no"/>'/></td>
    <td width=36% align="right">Reference Type</td>
    <td width="15%"><input type="text" id="txtref_type" name="txtref_type" style="width:70%;" tabindex="2" value='<s:property value="txtref_type"/>'/></td>
  </tr>
</table><br/> --%>
<table class="table1" style="border-collapse:collapse;" width="100%">
                <thead>
                    <tr> <!-- #81BEF7 -->
                        <th></th>
                        <th scope="col" abbr="personal" style="background: #D1D1D1;">Communication Details</th>
                        <th scope="col" abbr="office">Office Details</th>
                        <th scope="col" abbr="residence">Residence Details</th>
                        <th scope="col" abbr="home">Home Details</th>
                    </tr>
                </thead>
                
                <tbody>
                    <tr>
                        <th scope="row">Address 1</th>
                        <td align="left" style="background: #D5D5D5;"><input type="text" id="txtpersonal_add1" name="txtpersonal_add1" style="width:80%;" tabindex="3" value='<s:property value="txtpersonal_add1"/>'/></td>
                        <td align="left"><input type="text" id="txtoffice_add1" name="txtoffice_add1" style="width:80%;" tabindex="11" value='<s:property value="txtoffice_add1"/>'/></td>
                        <td align="left"><input type="text" id="txtresidence_add1" name="txtresidence_add1" style="width:80%;" tabindex="19" value='<s:property value="txtresidence_add1"/>'/></td>
                        <td align="left"><input type="text" id="txthome_add1" name="txthome_add1" style="width:80%;" tabindex="27" value='<s:property value="txthome_add1"/>'/></td>
                    </tr>
                    <tr>
                        <th scope="row">Address 2</th>
                        <td align="left" style="background: #D5D5D5;"><input type="text" id="txtpersonal_add2" name="txtpersonal_add2" style="width:80%;" tabindex="4" value='<s:property value="txtpersonal_add2"/>'/></td>
                        <td align="left"><input type="text" id="txtoffice_add2" name="txtoffice_add2" style="width:80%;" tabindex="12" value='<s:property value="txtoffice_add2"/>'/></td>
                        <td align="left"><input type="text" id="txtresidence_add2" name="txtresidence_add2" style="width:80%;" tabindex="20" value='<s:property value="txtresidence_add2"/>'/></td>
                        <td align="left"><input type="text" id="txthome_add2" name="txthome_add2" style="width:80%;" tabindex="28" value='<s:property value="txthome_add2"/>'/></td>
                    </tr>
                    <tr>
                        <th scope="row">Telephone</th>
                        <td align="left" style="background: #D5D5D5;"><input type="text" id="txtpersonal_tel1" name="txtpersonal_tel1" style="width:80%;" tabindex="5" value='<s:property value="txtpersonal_tel1"/>'/></td>
                        <td align="left"><input type="text" id="txtoffice_tel1" name="txtoffice_tel1" style="width:80%;" tabindex="13" value='<s:property value="txtoffice_tel1"/>'/></td>
                        <td align="left"><input type="text" id="txtresidence_tel1" name="txtresidence_tel1" style="width:80%;" tabindex="21" value='<s:property value="txtresidence_tel1"/>'/></td>
                        <td align="left"><input type="text" id="txthome_tel1" name="txthome_tel1" style="width:80%;" tabindex="29" value='<s:property value="txthome_tel1"/>'/></td>
                    </tr>
                    <tr>
                        <th scope="row">Mobile</th>
                        <td align="left" style="background: #D5D5D5;"><input type="text" id="personal_tel2" name="personal_tel2" style="width:80%;" onblur="mobileValid(this.value);getMobileNoAlreadyExists(this.value,$('#docno').val(),$('#mode').val());" tabindex="6" value='<s:property value="personal_tel2"/>'/></td>
                        <td align="left"><input type="text" id="office_tel2" name="office_tel2" style="width:80%;" onblur="mobileValid(this.value);" tabindex="14" value='<s:property value="office_tel2"/>'/></td>
                        <td align="left"><input type="text" id="residence_tel2" name="residence_tel2" style="width:80%;" onblur="mobileValid(this.value);" tabindex="22" value='<s:property value="residence_tel2"/>'/></td>
                        <td align="left"><input type="text" id="home_tel2" name="home_tel2" style="width:80%;" onblur="mobileValid(this.value);" tabindex="30" value='<s:property value="home_tel2"/>'/></td>
                    </tr>
                    <tr>
                        <th scope="row">Fax</th>
                        <td align="left" style="background: #D5D5D5;"><input type="text" id="txtpersonal_fax" name="txtpersonal_fax" style="width:80%;" tabindex="7" value='<s:property value="txtpersonal_fax"/>'/></td>
                        <td align="left"><input type="text" id="txtoffice_fax" name="txtoffice_fax" style="width:80%;" tabindex="15" value='<s:property value="txtoffice_fax"/>'/></td>
                        <td align="left"><input type="text" id="txtresidence_fax" name="txtresidence_fax" style="width:80%;" tabindex="23" value='<s:property value="txtresidence_fax"/>'/></td>
                        <td align="left"><input type="text" id="txthome_fax" name="txthome_fax" style="width:80%;" tabindex="31" value='<s:property value="txthome_fax"/>'/></td>
                    </tr>
                    <tr>
                        <th scope="row">Email</th>
                        <td align="left" style="background: #D5D5D5;"><input type="text" id="txtpersonal_email" name="txtpersonal_email" placeholder="someone@example.com" style="width:80%;" tabindex="8" value='<s:property value="txtpersonal_email"/>'/></td>
                        <td align="left"><input type="text" id="txtoffice_email" name="txtoffice_email" placeholder="someone@example.com" style="width:80%;" tabindex="16" value='<s:property value="txtoffice_email"/>'/></td>
                        <td align="left"><input type="text" id="txtresidence_email" name="txtresidence_email" placeholder="someone@example.com" style="width:80%;" tabindex="24" value='<s:property value="txtresidence_email"/>'/></td>
                        <td align="left"><input type="text" id="txthome_email" name="txthome_email" placeholder="someone@example.com" style="width:80%;" tabindex="32" value='<s:property value="txthome_email"/>'/></td>
                    </tr>
                    <tr>
                        <th scope="row">Contact</th>
                        <td align="left" style="background: #D5D5D5;"><input type="text" id="txtpersonal_contact" name="txtpersonal_contact" style="width:80%;" tabindex="9" value='<s:property value="txtpersonal_contact"/>'/></td>
                        <td align="left"><input type="text" id="txtoffice_contact" name="txtoffice_contact" style="width:80%;" tabindex="17" value='<s:property value="txtoffice_contact"/>'/></td>
                        <td align="left"><input type="text" id="txtresidence_contact" name="txtresidence_contact" style="width:80%;" tabindex="25" value='<s:property value="txtresidence_contact"/>'/></td>
                        <td align="left"><input type="text" id="txthome_contact" name="txthome_contact" style="width:80%;" tabindex="33" value='<s:property value="txthome_contact"/>'/></td>
                    </tr>
                    <tr>
                        <th scope="row">Makani No.</th>
                        <td align="left" style="background: #D5D5D5;"><input type="text" id="txtpersonal_extn_no" name="txtpersonal_extn_no" style="width:80%;" tabindex="10" value='<s:property value="txtpersonal_extn_no"/>'/></td>
                        <td align="left"><input type="text" id="txtoffice_extn_no" name="txtoffice_extn_no" style="width:80%;" tabindex="18" value='<s:property value="txtoffice_extn_no"/>'/></td>
                        <td align="left"><input type="text" id="txtresidence_extn_no" name="txtresidence_extn_no" style="width:80%;" tabindex="26" value='<s:property value="txtresidence_extn_no"/>'/></td>
                        <td align="left"><input type="text" id="txthome_extn_no" name="txthome_extn_no" style="width:80%;" tabindex="34" value='<s:property value="txthome_extn_no"/>'/></td>
                    </tr>
                </tbody>
            </table>

</div>
</div>

<div id="tab3">
	<fieldset>
	<legend>Credit Card Details</legend>
	<div id="creditCardDetailsDiv"> <jsp:include page="creditCardDetailsGrid.jsp"></jsp:include></div><br />
	</fieldset>
</div>

<div id="tab4">
<%-- <table width="100%">
<tr><td width="70%">
<fieldset>
<legend>Documents Required</legend>
<table width="100%">
  <tr>
    <td width="81%" align="right"><button  class="myButton" type="button" onclick="">Attach</button></td>
    <td width="19%" align="left"><button class="myButton" type="button" onclick="">&nbsp;&nbsp;Preview</button></td>
  </tr>
</table>
<div id="jqxDocumentsAttach1"> <jsp:include page="documentsAttach.jsp"></jsp:include></div><br/>
</fieldset>
</td>
 <td width="30%">
<fieldset>
<legend>Preview</legend>
<textarea rows="16" style="width:98%;resize: none;"></textarea>
</fieldset>
</td> 
</tr>
</table> --%>
<table width="100%">
<tr><td width="50%">
<fieldset>
<legend>Reference Details</legend>
 <div id="jqxReferenceDetails1"><jsp:include page="referenceDetails.jsp"></jsp:include></div><br/>
</fieldset>
</td>
<td width="50%">
<fieldset>
<legend>Sponsor/Company Details</legend>
<table width="100%">
  <tr>
    <td width="11%" align="right">Name</td>
    <td colspan="5"><input type="text" id="txtname" name="txtname" style="width:95%;" value='<s:property value="txtname"/>'/></td>
  </tr>
  <tr>
    <td align="right">Address</td>
    <td colspan="5"><input type="text" id="txtaddress" name="txtaddress" style="width:95%;" value='<s:property value="txtaddress"/>'/></td>
  </tr>
  <tr>
    <td align="right">Telephone</td>
    <td width="32%"><input type="text" id="txttelephone" name="txttelephone" style="width:90%;" value='<s:property value="txttelephone"/>'/></td>
    <td width="9%" align="right">ID.</td>
    <td width="14%"><input type="text" id="txtid" name="txtid" style="width:80%;" value='<s:property value="txtid"/>'/></td>
    <td width="7%" align="right">Nationality</td>
    <td width="27%"><select id="cmbnationality" name="cmbnationality" style="width:80%;" value='<s:property value="cmbnationality"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbnationality" name="hidcmbnationality" value='<s:property value="hidcmbnationality"/>'/></td>
  </tr>
  <tr>
    <td align="right">Security</td>
    <td><input type="text" id="txtsecurity" name="txtsecurity" style="width:90%;" value='<s:property value="txtsecurity"/>'/></td>
    <td colspan="4"><input type="text" id="txtsecurity1" name="txtsecurity1" style="width:90%;" value='<s:property value="txtsecurity1"/>'/></td>
  </tr>
  <tr>
    <td align="right">Job Title</td>
    <td colspan="2"><input type="text" id="txtjobtitle" name="txtjobtitle" style="width:100%;" value='<s:property value="txtjobtitle"/>'/></td>
    <td colspan="2" align="right">Date of Joining</td>
    <td><div id="dateOfJoining" name="dateOfJoining" value='<s:property value="dateOfJoining"/>'></div>
    <input type="hidden" id="hiddateOfJoining" name="hiddateOfJoining" value='<s:property value="hiddateOfJoining"/>'/></td>
  </tr>
  <tr>
    <td align="right">Bank Name</td>
    <td colspan="5"><input type="text" id="txtbankname" name="txtbankname" style="width:95%;" value='<s:property value="txtbankname"/>'/></td>
  </tr>
</table>
</fieldset>
<div id="sponsorDiv"><br/><br/><br/><br/><br/><br/><br/><br/></div>
<div id="contractDiv" hidden="true">
<fieldset><legend>Trade Licence Details</legend>
<table width="100%">
  <tr>
    <td width="14%" align="right">Trade Licence No.</td>
    <td width="33%"><input type="text" id="txtcontractno" name="txtcontractno" style="width:90%;" value='<s:property value="txtcontractno"/>'/></td>
    <td width="17%" align="right">Trade Licence Date</td>
    <td width="36%"><div id="jqxContractDate" name="jqxContractDate" value='<s:property value="jqxContractDate"/>'></div>
    <input type="hidden" id="hidjqxContractDate" name="hidjqxContractDate" value='<s:property value="hidjqxContractDate"/>'/></td>
  </tr>
  <tr>
    <td align="right">Remarks</td>
    <td colspan="3"><input type="text" id="txtcontractremarks" name="txtcontractremarks" style="width:83%;" value='<s:property value="txtcontractremarks"/>'/></td>
  </tr>
</table>
</fieldset>
</div>
</td>
</tr>
</table>
</div>
</div> 
<input type="hidden" id="mode" name="mode"/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="idpdetailsallowed" name="idpdetailsallowed"  value='<s:property value="idpdetailsallowed"/>'/> 
<input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
<input type="hidden" id="txtforcontractdiv" name="txtforcontractdiv"/>
<input type="text" id="txtmobilevalidation" name="txtmobilevalidation" value='<s:property value="txtmobilevalidation"/>'/>
<input type="hidden" id="txtcategoryvalidation" name="txtcategoryvalidation" value='<s:property value="txtcategoryvalidation"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
<input type="hidden" id="referencelength" name="referencelength"/>
<input type="hidden" id="attachlength" name="attachlength"/>
<input type="hidden" id="creditcardlength" name="creditcardlength"/>
</div>
</form>
<div id="nationalityWindow">
   <div></div>
</div>
<div id="stateWindow">
   <div></div>
</div>
</div>
</body>
</html>
