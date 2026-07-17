<%@ taglib prefix="s" uri="/struts-tags"%>
 <%@page import="java.util.*" %>
 <%@page import="java.text.SimpleDateFormat" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<%-- <% String contextPath=request.getContextPath();%> --%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>

<style>
form label.error {
color:red;
  font-weight:bold;

}


    
.myButtonss {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #7892c2), color-stop(1, #476e9e));
	background:-moz-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:-webkit-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:-o-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:-ms-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:linear-gradient(to bottom, #7892c2 5%, #476e9e 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#7892c2', endColorstr='#476e9e',GradientType=0);
	background-color:#7892c2;
	border:1px solid #4e6096;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:12px;
	padding:2px 7px;
	text-decoration:none;
}
.myButtonss:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #476e9e), color-stop(1, #7892c2));
	background:-moz-linear-gradient(top, #476e9e 5%, #7892c2 100%);
	background:-webkit-linear-gradient(top, #476e9e 5%, #7892c2 100%);
	background:-o-linear-gradient(top, #476e9e 5%, #7892c2 100%);
	background:-ms-linear-gradient(top, #476e9e 5%, #7892c2 100%);
	background:linear-gradient(to bottom, #476e9e 5%, #7892c2 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#476e9e', endColorstr='#7892c2',GradientType=0);
	background-color:#476e9e;
}
.myButtonss:active {
	position:relative;
	top:1px;
}
/*  div.absolute1 {
    position: absolute;
    top: 350px;
    right: 400px;
   
} */


.myButtonp {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:12px;
	padding:2px 10px;
	text-decoration:none;
}
.myButtonp:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtonp:active {
	position:relative;
	top:1px;
}


   


   
</style>
<script type="text/javascript">
	$(document).ready(function() {
		 // $("#imagedivv").hide(); 
		 $("#vehpurorderDate").jqxDateTimeInput({ width: '120px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#jqxStartDate").jqxDateTimeInput({ width: '120px', height: '15px', formatString:"dd.MM.yyyy",enableBrowserBoundsDetection: true});
		 $("#uptoDate").jqxDateTimeInput({ width: '120px', height: '15px', formatString:"dd.MM.yyyy",enableBrowserBoundsDetection: true});
 
		 
		 $("#vehpurinvDate").jqxDateTimeInput({ width: '120px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#vehpurorderdelDate").jqxDateTimeInput({ width: '120px', height: '15px', formatString:"dd.MM.yyyy"});
		 $('#brandsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Brand Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	     $('#brandsearchwndow').jqxWindow('close'); 

	     $('#modelsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Model Search' ,position: { x: 250, y:100 }, keyboardCloseKey: 27});
	     $('#modelsearchwndow').jqxWindow('close');
	     $('#colorsearchwndow').jqxWindow({ width: '25%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Color Search' ,position: { x: 400, y:60 }, keyboardCloseKey: 27});
	     $('#colorsearchwndow').jqxWindow('close');
	     $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
		 $('#accountSearchwindow').jqxWindow('close');
		     
		     $('#refnosearchwindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
			 $('#refnosearchwindow').jqxWindow('close'); 
		     $('#fleetwindow').jqxWindow({ width: '50%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Fleet Search' , position: { x: 600, y: 60 }, keyboardCloseKey: 27});
			 $('#fleetwindow').jqxWindow('close');
				     
			     $('#slnosearchwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Sl NO Search' ,position: { x: 250, y:100 }, keyboardCloseKey: 27});
			     $('#slnosearchwindow').jqxWindow('close');	     
				     
				 
				 $("#btnEdit").attr('disabled', true );
				 $("#btnDelete").attr('disabled', true );
			  
			   
			   
			   $('#vehrefno').dblclick(function(){
				   
				    if($('#mode').val()=="A")
			          {
			          
			  	    $('#refnosearchwindow').jqxWindow('open');
			  	
			  	  refsearchContent('vehOrderRefnoSearch.jsp?headacccode='+document.getElementById("headacccode").value);
			          }
				     }); 
				    
		  $('#financeaccid').dblclick(function(){
				  	   
			  		  
			  $('#accountSearchwindow').jqxWindow('open');
			 commenSearchContent('finaccountSearch.jsp?');
				        
		  }); 
			   
		  $('#bankaccid').dblclick(function(){
		  	   
	  		  
			  $('#accountSearchwindow').jqxWindow('open');
			 commenSearchContent('bankaccountsearch.jsp?');
				        
		  }); 
	  $('#interestaccid').dblclick(function(){
		  	   
	  		  
			  $('#accountSearchwindow').jqxWindow('open');
			 commenSearchContent('inetestaccsearch.jsp?');
				        
		  }); 
	  $('#loanaccid').dblclick(function(){
	  	   
  		  
		  $('#accountSearchwindow').jqxWindow('open');
		 commenSearchContent('loanaccount.jsp?');
			        
	  }); 
		  
		    
	    $('#vehpurorderDate').on('change', function (event) {
	        var maindate = $('#vehpurorderDate').jqxDateTimeInput('getDate');
	  	 	 if ($("#mode").val() == "A"  ) {   
	     funDateInPeriod(maindate);
	    	 }
	   });  
		    
		    
		 
	    $('#accid').dblclick(function(){
	    	
	    	   if($('#mode').val()=="A")
		          {
		  	    $('#accountSearchwindow').jqxWindow('open');
		  	
		  	  accountSearchContent('accountsDetailsSearch.jsp?');
		          }
	  }); 
	    
	 //   $("#imagedivv").hide(); 
	
	 
	 
	 
		
	});
			   
			   function commenSearchContent(url) {
				 	 //alert(url);
				 		 $.get(url).done(function (data) {
				 			 
				 			 $('#accountSearchwindow').jqxWindow('open');
				 		$('#accountSearchwindow').jqxWindow('setContent', data);
				 
				 	}); 
				 	} 	
			   
			   
				function  getloanacc(event){
				 	 var x= event.keyCode;
				 	 if(x==114){
				 		
				 	  $('#accountSearchwindow').jqxWindow('open');
				 	
				 	 commenSearchContent('loanaccount.jsp?');
					          }
				 		   
				 	 else{
				 		 }
				 	 }    
				function  getInterestacc(event){
				 	 var x= event.keyCode;
				 	 if(x==114){
				 		
				 	  $('#accountSearchwindow').jqxWindow('open');
				 	
				 	 commenSearchContent('inetestaccsearch.jsp?');
					          }
				 		   
				 	 else{
				 		 }
				 	 }   
				function  getbankacc(event){
				 	 var x= event.keyCode;
				 	 if(x==114){
				 		
				 	  $('#accountSearchwindow').jqxWindow('open');
				 	
				 	 commenSearchContent('bankaccountsearch.jsp?');
					          }
				 		   
				 	 else{
				 		 }
				 	 }    
			   
				
				
			 //   getfinacc(event)
			function  getfinacc(event){
	 	 var x= event.keyCode;
	 	 if(x==114){
	 		
	 	  $('#accountSearchwindow').jqxWindow('open');
	 	
	 	 commenSearchContent('finaccountSearch.jsp?');
		          }
	 		   
	 	 else{
	 		 }
	 	 }     
			   
	function slnoSearchContent(url) {
	 	 //alert(url);
	 		 $.get(url).done(function (data) {
	 			 
	 			 $('#slnosearchwindow').jqxWindow('open');
	 		$('#slnosearchwindow').jqxWindow('setContent', data);
	 
	 	}); 
	 	} 
	function fleetSearchContent(url) {
	 	 //alert(url);
	 		 $.get(url).done(function (data) {
	 			 
	 			 $('#fleetwindow').jqxWindow('open');
	 		$('#fleetwindow').jqxWindow('setContent', data);
	 
	 	}); 
	 	} 
	
	function getrefDetails(event){
	 	 var x= event.keyCode;
	 	 if(x==114){
	 		   if($('#mode').val()=="A")
		          {
	 	  $('#refnosearchwindow').jqxWindow('open');
	 	
	 	 refsearchContent('vehOrderRefnoSearch.jsp?headacccode='+document.getElementById("headacccode").value);
		          }
		          }
	 	 else{
	 		 }
	 	 }  
		  function refsearchContent(url) {
	       //alert(url);
	          $.get(url).done(function (data) {
	//alert(data);
	        $('#refnosearchwindow').jqxWindow('setContent', data);

		}); 
	    	}
	function getaccountdetails(event){
	 	 var x= event.keyCode;
	 	 if(x==114){
	 		   if($('#mode').val()=="A")
		          {
	 	  $('#accountSearchwindow').jqxWindow('open');
	 	
	 	 accountSearchContent('accountsDetailsSearch.jsp?'); 
		          }
	 		   }
	 	 else{
	 		 }
	 	 }  
		  function accountSearchContent(url) {
	       //alert(url);
	          $.get(url).done(function (data) {
	//alert(data);
	        $('#accountSearchwindow').jqxWindow('setContent', data);

		}); 
	    	}
    function brandinfoSearchContent(url) {
     	 //alert(url);
     		 $.get(url).done(function (data) {
     			 
     			 $('#brandsearchwndow').jqxWindow('open');
     		$('#brandsearchwndow').jqxWindow('setContent', data);
     
     	}); 
     	} 
         function modelinfoSearchContent(url) {
          	 //alert(url);
          		 $.get(url).done(function (data) {
          			 
          			 $('#modelsearchwndow').jqxWindow('open');
          		$('#modelsearchwndow').jqxWindow('setContent', data);
          
          	}); 
          	} 
         function colorinfoSearchContent(url) {
           	 //alert(url);
           		 $.get(url).done(function (data) {
           			 
           			 $('#colorsearchwndow').jqxWindow('open');
           		$('#colorsearchwndow').jqxWindow('setContent', data);
           
           	}); 
           	} 
        
      

	
	 function funReadOnly(){
			$('#frmpurchase input').attr('readonly', true );
			$('#frmpurchase select').attr('disabled', true);
			
			$('#vehpurorderDate').jqxDateTimeInput({disabled: true});
			$('#vehpurorderdelDate').jqxDateTimeInput({disabled: true});
			$('#vehpurinvDate').jqxDateTimeInput({disabled: true});
			$("#vehoredergrid").jqxGrid({ disabled: true});
			$("#vehoredergrid").jqxGrid({ disabled: true});
			   $("#editss").prop("disabled", false);
			 $('#vehrefno').attr('disabled', true);
			 
			    $("table#finance input").prop("disabled", true);
			    $("table#finance select").prop("disabled", true);
			  
			    $('#jqxStartDate').jqxDateTimeInput({disabled: true});  
			    
			    $('#uptoDate').jqxDateTimeInput({disabled: true});  
			     $("#updatebtn").prop("disabled", true);
			     
			     
			     $("#btnsearch").prop("disabled", true);   
			    
			     
			     
			    // updateposting btnCalculate editss
			       $("#editss").prop("disabled", true);
			       $("#btnCalculate").prop("disabled", true);
			       $("#updateposting").prop("disabled", true);
			     $('#invno').attr('readonly', true);
			 
			   $('#updatefleet').show();
			   $('#updateposting').show();
			   
			   
	 }
	 function funRemoveReadOnly(){
		 
			$('#frmpurchase input').attr('readonly', false );
			$('#frmpurchase select').attr('disabled', false);
			$("#vehoredergrid").jqxGrid({ disabled: false});
			$('#vehpurorderdelDate').jqxDateTimeInput({disabled: false});
			$('#vehpurinvDate').jqxDateTimeInput({disabled: true});
			$('#vehpurorderDate').jqxDateTimeInput({disabled: false});
			 $('#vehrefno').attr('disabled', true);
			$('#docno').attr('readonly', true);
			$('#accid').attr('readonly', true);
			$('#vehrefno').attr('readonly', true);
			  $("#btnsearch").prop("disabled", true);   
			$('#vehpuraccname').attr('readonly', true);
			
			if ($("#mode").val() == "A") {
				$('#vehpurorderdelDate').val(new Date());
				$('#vehpurorderDate').val(new Date());
				$('#vehpurinvDate').val(new Date());
				 $("#vehoredergrid").jqxGrid('clear');
				    $("#vehoredergrid").jqxGrid('addrow', null, {});
				    
				    $("table#finance input").prop("disabled", true);
				    $("table#finance select").prop("disabled", true);
				   // $("table#finance button").prop("disabled", true);
				    $('#jqxStartDate').jqxDateTimeInput({disabled: true});  
				    $('#uptoDate').jqxDateTimeInput({disabled: true});
				    $('#invno').attr('readonly', true);
				    $('#updatefleet').hide();
				    $('#updateposting').hide();
				    $("#editss").prop("disabled", true);
				    $("#btnCalculate").prop("disabled", true);
				    $("#updateposting").prop("disabled", true);
				    
				   	 $("#jqxDistributionGrid").jqxGrid('clear');
					   $("#jqxDistributionGrid").jqxGrid('addrow', null, {});
					   $("#postgrid").jqxGrid('clear');
	             	   $("#postgrid").jqxGrid('addrow', null, {});
	             	  $("#postgrid").jqxGrid('addrow', null, {});
				    
				    
			   }
			
		/* 	if ($("#mode").val() == "E") {
			if($('#vehtype').val()=="VPO")
			  {
			
			  $('#vehrefno').attr('disabled', false);
			  
		  $('#vehrefno').attr('readonly', true);
		
			  }
			} */
			
	 }
	 
	   function funrefdisslno()
	   {
		   if($('#vehtype').val()=="VPO") 
			  {
			   $('#vehrefno').attr('disabled', false);
			   $("#vehoredergrid").jqxGrid('clear');
			   $("#vehoredergrid").jqxGrid('addrow', null, {});
			  } 
		   else
			   {
			   $('#vehrefno').val("");
			
			   $('#vehrefno').attr('disabled', true);
			   $("#vehoredergrid").jqxGrid('clear');
			   $("#vehoredergrid").jqxGrid('addrow', null, {});
			   
			   }
	   }
	 
	 function funSearchLoad(){
		changeContent('vehPurchaseMastersearch.jsp'); 
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus()
	    {
	    	$('#vehpurorderDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	 
	
	   
	  function funNotify(){
		  
		  var maindate = $('#vehpurorderDate').jqxDateTimeInput('getDate');
		   var validdate=funDateInPeriod(maindate);
		   if(validdate==0){
		   return 0; 
		   }
		  
		  if ($("#brchName").val() == ""||$("#brchName").val() == "null" || typeof($("#brchName").val()) == "undefined" ) { 
				
				document.getElementById("errormsg").innerText="Your Secure Session Has Expired";
				return 0;
			}
		  
			
		var purid= document.getElementById("accid").value;

		if(purid=="")
			{
			 document.getElementById("errormsg").innerText=" Select An Account";
			 
			 document.getElementById("accid").focus();
			 return 0;
			   }
		else
			   {
			   document.getElementById("errormsg").innerText="";
			   } 
		
		
/* 		var invno= document.getElementById("invno").value;

		if(invno=="")
			{
			 document.getElementById("errormsg").innerText=" Enter Invoice No";
			 
			 document.getElementById("invno").focus();
			 return 0;
			   }
		else
			   {
			   document.getElementById("errormsg").innerText="";
			   } 
		 */
		
		 if($('#vehtype').val()=="VPO")
		  {
		
			 var vehrefno= document.getElementById("vehrefno").value; 
			 if(vehrefno=="")
				{
              document.getElementById("errormsg").innerText=" Select Refno";
			 
			 document.getElementById("vehrefno").focus();
			 return 0;
				}
			 else
				 {
				  document.getElementById("errormsg").innerText="";
				 }
	
		  }
		
		
		
		/* var refval= document.getElementById("nettotal").value;
		  if(refval=="")
			{
			 document.getElementById("errormsg").innerText="Total is Empty";
			 

			 return 0;
			   }
		else
			   {
			   document.getElementById("errormsg").innerText="";
			   } */
		
			   
			   
			 var rows = $("#vehoredergrid").jqxGrid('getrows');
			 
				
			   for(var i=0 ; i < rows.length ; i++){
			    	
			 
				
			    if(parseInt(rows[i].brdid)>0)
	  		  {
			    
		  
		 	        if(rows[i].price=="" ||typeof(rows[i].price)=="undefined"||typeof(rows[i].price)=="NaN")
	  		
					{
					document.getElementById("errormsg").innerText="Enter Price";  
			    	return 0;
					}
		 	        
		 	   
		 
			
		  	       
	  	       	} 
	   	            
			   }
		   
			   
			   
			   var rows = $("#vehoredergrid").jqxGrid('getrows');   
			   
		    $('#vehpurchasegridlenght').val(rows.length);
		   //alert($('#gridlength').val());
		   for(var i=0 ; i < rows.length ; i++){
		   // var myvar = rows[i].tarif; 
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
           .attr("id", "vehpurchasetest"+i)
		       .attr("name", "vehpurchasetest"+i) 
		           .attr("hidden", "true"); 
		    
		 
		   newTextBox.val(rows[i].srno+"::"+rows[i].brdid+" :: "+rows[i].modid+" :: "
				   +rows[i].specification+" :: "+rows[i].clrid+" :: "+rows[i].price+" :: "+rows[i].tempval+" :: "+rows[i].diff+" :: "
				   +rows[i].chaseno+" :: "+rows[i].enginno+" :: ");
	//s	alert(newTextBox.val());
		   newTextBox.appendTo('form');
		  
		    
		   }   
				 /* Applying Invoice Grid Updating Ends*/
				$('#vehpurinvDate').jqxDateTimeInput({disabled: false});	 
	    		return 1;
		} 
	  
	  function calculate()
	  {
		//  downpayment  perinterest calcumethod instnos
		//document.getElementById("downpayment").value
		  
		 if(document.getElementById("downpayment").value=="")
			 {
			 
			 document.getElementById("errormsg").innerText="Enter Down Payment";  
			 document.getElementById("downpayment").focus();
			 return 0;
			 
			 }
		  
			 if(document.getElementById("perinterest").value=="")
			 {
			 
			 document.getElementById("errormsg").innerText="Enter Percentage Interest";  
			 document.getElementById("perinterest").focus();
			 return 0; 
			 }
		  
			 if(document.getElementById("instnos").value=="")
			 {
			 
			 document.getElementById("errormsg").innerText="Enter Number Of Installments";  
			 document.getElementById("instnos").focus();
			 return 0;
			 
			 }
			 
			 if(document.getElementById("paymentmethod").value=="")
			 {
			 
			 document.getElementById("errormsg").innerText="Select Payment Method";  
			 document.getElementById("paymentmethod").focus();
			 return 0;
			 
			 }  
			 
		 // alert("");
		       var calcumethod= $('#calcumethod option:selected').text();
		 	 // alert("calcumethod"+calcumethod);
		  
			// alert(document.getElementById("calcumethod").text());
			 	  // $("#imagedivv").show(); 
			// return 0;
			 
			  $.messager.confirm('Message', 'Do you want to calculate with '+calcumethod, function(r){
		        	  
     		       
		        	if(r==false)
		        	  {
		        		return false; 
		        	  }
		        	else{ 
		        	      
	  
						  $("#jqxDistributionGrid").jqxGrid('clear');
						   $("#jqxDistributionGrid").jqxGrid('addrow', null, {});
					
					
						  var install=document.getElementById("instnos").value;
						  var payment=document.getElementById("paymentmethod").value;
						  for(var i=0;i<parseInt(install);i++)
							  {
						
								//$("#imagedivv").show();
								         //   var curdateout=new Date($('#jqxStartDate').jqxDateTimeInput('getDate')); 
								           
								         var dtval=$("#jqxStartDate").val();
								      //   alert(dtval);
								         var aa1="yes";
								         var ss=i;
								         
								 		
								 		var x=new XMLHttpRequest();
								 		x.onreadystatechange=function(){
								 		if (x.readyState==4 && x.status==200)
								 			{
											var items = x.responseText;
								 		 	items = items.split('::');
									  
											for (var i = 0; i < install; i++) {
												var data=items[i];
												
											//	alert(""+items[i]);
												
												$('#jqxDistributionGrid').jqxGrid('setcellvalue',i, "date" ,data);   
											}
											
								 		/* 	var aa=x.responseText;
								 		//	alert("aa"+aa);
								 			 $("#hideDate").jqxDateTimeInput('val', aa);
								 			 */
								 			
								 				 }
								 			
								 			
								 			}
								 			
								 		  
								 		
								 x.open("GET","gatedate.jsp?jqxStartDate="+dtval+"&ival="+ss+"&chk="+aa1+"&install="+install,true);


								 x.send();
								         
								         
								        // $("#detailsdiv").load("distributionGrid.jsp?docnos="+document.getElementById("masterdoc_no").value+'&detval='+document.getElementById("detval").value); 
								         //  $("#ssss").load("test.jsp?jqxStartDate="+dtval+"&ival="+ss+"&chk="+aa1); 
								           //alert(document.getElementById("month").value);
								           
								   
								          // var curdateout=new Date($('#hideDate').jqxDateTimeInput('getDate')); 
								    
								         //  alert(curdateout);
										         //  alert($('#hideDate').jqxDateTimeInput('getDate'));
												//   var d = new Date($('#hideDate').jqxDateTimeInput('getDate'));
											    /*  addmnt =  [d.getMonth()]; 
											      var addval=parseInt(addmnt)+(i+1);	
											    d.setMonth(parseInt(addval));  */
								               var loanval=document.getElementById("loanamount").value;
								               var perint=document.getElementById("perinterest").value;
								               var instnos=document.getElementById("instnos").value;
								           //  alert("loanval"+loanval);
								           //  alert("perint"+perint);
								           // alert("instnos"+instnos);
								            var priamount=(parseFloat(loanval)/(parseFloat(instnos))); 
						            var interest=(((((parseFloat(loanval)*parseFloat(perint)/100))*(parseFloat(instnos)/12)))/(parseFloat(instnos))); 
									//var interest=(((parseFloat(loanval)*parseFloat(perint)/100))*(parseFloat(instnos)/12)); 
									
									 var amount=parseFloat(priamount)+parseFloat(interest);
											  if(parseInt(payment)==2)
											  {
											  $('#jqxDistributionGrid').jqxGrid('setcellvalue',i, "chqno" ,i+1+""+"-"+document.getElementById("docno").value);
											  }
											   /*  loanamount,perinterest instnos */
													//alert("----i--------"+i) ;     
											   
											   
								 
											$('#jqxDistributionGrid').jqxGrid('setcellvalue',i, "sr_no" ,i+1);
											
											$('#jqxDistributionGrid').jqxGrid('setcellvalue',i, "priamount" ,priamount);
											$('#jqxDistributionGrid').jqxGrid('setcellvalue',i, "interest" ,interest);
											$('#jqxDistributionGrid').jqxGrid('setcellvalue',i, "amount" ,amount);
											
										if(i<(parseInt(install)-1))
											{
											$("#jqxDistributionGrid").jqxGrid('addrow', null, {});
											//$("#imagedivv").show();
											}
										
								           }
										
							      
						  
				
					
						  
		        	}
		        	}); 
	  }
	  
	  function 	funUpdate()
	  {
		if(document.getElementById("updatebtn").value=="Edit")
			{
				  
		    $('#jqxStartDate').jqxDateTimeInput({disabled: false});  
		    $('#uptoDate').jqxDateTimeInput({disabled: false}); 
			
			   $("table#finance input").prop("disabled", false);
			    $("table#finance select").prop("disabled", false);
			    
				   $("table#finance input").prop("readonly", false);
				    $("table#finance select").prop("readonly", false);
				   
				    
				    $("#loanamount").prop("readonly", true);
				   $("#financeaccname").prop("readonly", true);
				   $("#bankaccname").prop("readonly", true);
				   $("#intaccname").prop("readonly", true);
				   $("#loanaccname").prop("readonly", true);
				  // financeaccid,bankaccid,interestaccid,loanaccid   
				    $("#financeaccid").prop("readonly", true);
					   $("#bankaccid").prop("readonly", true);
					   $("#interestaccid").prop("readonly", true);
					   $("#loanaccid").prop("readonly", true);
					   $("#btnsearch").prop("disabled", false);   
			   // financeaccname  bankaccname intaccname loanaccname
			   
			   //  downpayment  perinterest calcumethod instnos
		//document.getElementById("downpayment").value
		
		          document.getElementById("perinterest").value="";
		          document.getElementById("instnos").value="";
		          document.getElementById("dealno").value="";
			    
			    $('#jqxStartDate').jqxDateTimeInput({disabled: false});  
			    $('#uptoDate').jqxDateTimeInput({disabled: false}); 
			    document.getElementById("updatebtn").value="Save";
			    return 0;
			 
			    
			    
			}
			else if(document.getElementById("updatebtn").value=="Save")
		{
		
				
				 var rows1 = $("#jqxDistributionGrid").jqxGrid('getrows');
					
				   for(var i=0 ; i < rows1.length ; i++){
			
						 var sr_no=rows1[0].sr_no;
							
							
							if(parseInt(sr_no)!=1)
								{
								
								document.getElementById("errormsg").innerText="Calculate Process ";  
								document.getElementById("calculatebtn").focus();
								
						    	return 0;
								}
				 // alert(rows[i].fleet_no);

			         
		 		   
				   }	
				 //  Account(Financier) ,Bank A/C ,  Interest A/C ,Loan A/C, Security Cheque NO,Amount,Name In Cheque, Payment Method Description
				 
				   
				   if(document.getElementById("financeaccid").value=="")
					 {
					 
					 document.getElementById("errormsg").innerText="Search Financier Account ";  
					 document.getElementById("financeaccid").focus();
					 return 0;
					 
					 }
				  
					 if(document.getElementById("bankaccid").value=="")
					 {
					 
						 document.getElementById("errormsg").innerText="Search Bank Account ";  
					 document.getElementById("bankaccid").focus();
					 return 0; 
					 }
				  
					 if(document.getElementById("interestaccid").value=="")
					 {
					 
				    document.getElementById("errormsg").innerText="Search Interest Account ";  
					 document.getElementById("interestaccid").focus();
					 return 0;
					 
					 }  
					  
					 if(document.getElementById("loanaccid").value=="")
					 {
					 
				    document.getElementById("errormsg").innerText="Search Loan Account ";  
					 document.getElementById("loanaccid").focus();
					 return 0;
					 
					 }  
					   if(document.getElementById("secchaqueno").value=="")
						 {
						 
						 document.getElementById("errormsg").innerText="Enter Security Cheque NO";  
						 document.getElementById("secchaqueno").focus();
						 return 0;
						 
						 }
					  
						 if(document.getElementById("chqamount").value=="")
						 {
						 
						 document.getElementById("errormsg").innerText="Enter Amount ";  
						 document.getElementById("chqamount").focus();
						 return 0; 
						 }
						 if(document.getElementById("dealno").value=="")
						 {
						 
						 document.getElementById("errormsg").innerText="Enter Deal No";  
						 document.getElementById("dealno").focus();
						 return 0;
						 
						 } 
						 if(document.getElementById("nameincheque").value=="")
						 {
						 
						 document.getElementById("errormsg").innerText="Enter Name In Cheque";  
						 document.getElementById("nameincheque").focus();
						 return 0;
						 
						 }  
						
				
						
					   
						 if(document.getElementById("txtdescription").value=="")
						 {
						 
						 document.getElementById("errormsg").innerText="Enter Description";  
						 document.getElementById("txtdescription").focus();
						 return 0;
						 
						 }  
					   //aaaaaa
						 if(parseFloat(document.getElementById("priamounts").value)!=parseFloat(document.getElementById("loanamount").value))
						 {
						 
						 document.getElementById("errormsg").innerText="Net Principal Amount Should Be Equal To Loan Amount";  
						 
						 return 0;
						 
						 }  
					   
						 
						 
						 
						 
						 
				
				
			    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
		        	  
	     		       
 		        	if(r==false)
 		        	  {
 		        		return false; 
 		        	  }
 		        	else{		
				
				
				
			 var rows = $("#jqxDistributionGrid").jqxGrid('getrows');
		     $('#distributionlenght').val(rows.length);
		   //alert($('#gridlength').val());
		   for(var i=0 ; i < rows.length ; i++){
		   // var myvar = rows[i].tarif; 
		    newTextBox = $(document.createElement("input")) 
		       .attr("type", "dil")       
               .attr("id", "dettest"+i)   
		       .attr("name", "dettest"+i)  
		       .attr("hidden", "true");    
		    
		  /*   date    priamount interest amount	 */
		 
		   newTextBox.val(rows[i].priamount+"::"+rows[i].date+" :: "+rows[i].interest+" :: "+rows[i].amount+" :: "+rows[i].chqno+" :: ");
	//alert(newTextBox.val());
		   newTextBox.appendTo('form');
		   
		  
		    
		   }
		   $("table#finance input").prop("disabled", false);
		    $("table#finance select").prop("disabled", false);
			   $("table#finance input").prop("readonly", false);
			    $("table#finance select").prop("readonly", false);  
	    $('#jqxStartDate').jqxDateTimeInput({disabled: false});  
	    $('#uptoDate').jqxDateTimeInput({disabled: false}); 
		    $('#frmpurchase input').attr('readonly', false );
			$('#frmpurchase select').attr('disabled', false);
			$("#vehoredergrid").jqxGrid({ disabled: false});
			$('#vehpurorderdelDate').jqxDateTimeInput({disabled: false});
			$('#vehpurinvDate').jqxDateTimeInput({disabled: false});
			$('#vehpurorderDate').jqxDateTimeInput({disabled: false});
			$('#vehrefno').attr('disabled', false);
		   document.getElementById("mode").value="ADD";
		   document.getElementById("fleetupdateval").value="";
		   document.getElementById("msg").value="";
		   document.getElementById("detval").value="";
		   
		   
		   //alert(document.getElementById("loanamount").value);
		// return 0;
		   $('#frmpurchase').submit();
		  
	             
 		        	
 		           
 		       	}
			     });
 		        	
		
		//calculate_new
		
		
		
	  }
	  }
	  
	  
	  
	  
	 function  changeval()
	 {
		 
		 if($('#vehtypeval').val()!="")
		  {
		  
		  
		  $('#vehtype').val($('#vehtypeval').val());
		  }
		 
		 if($('#vehtypeval').val()=="VPO")
		  {
		
		  $('#vehrefno').attr('disabled', false);
		  
	  $('#vehrefno').attr('readonly', true);
	
		  }
	 }

	  
	  function setValues(){
		  
		  if($('#restructure').val()!="" && $('#restructure').val()!=null && $('#restructure').val()=="1"){
				document.getElementById("errormsg").innerText="Loan Restructured";
		  }
		  
		   if($('#hidvehpurorderDate').val()){
				 $("#vehpurorderDate").jqxDateTimeInput('val', $('#hidvehpurorderDate').val());
			  }
		 
		  
		  if($('#hidvehpurorderdelDate').val()){
				 $("#vehpurorderdelDate").jqxDateTimeInput('val', $('#hidvehpurorderdelDate').val());
			  }
		  if($('#hidvehpurinvDate').val()){
				 $("#vehpurinvDate").jqxDateTimeInput('val', $('#hidvehpurinvDate').val());
			  }
		  
			var indexVa5 = document.getElementById("masterdoc_no").value;
		
	         if(parseInt(indexVa5)>0){
	        	
	         $("#updatebtn").attr("disabled", false);	 
	         $("#vehpuchase").load("vehpurchaseDetails.jsp?masterdoc="+indexVa5);  
	       // $("#detailsdiv").load("distributionGrid.jsp?docnos="+document.getElementById("docno").value);  
	         
	     //   alert(document.getElementById("detval").value);
	     
	    /*  var aaa=document.getElementById("detval").value;
	         
	        if(parseInt(document.getElementById("detval").value)!=11)
	        	{
	        $("#detailsdiv").load("distributionGrid.jsp?docnos="+document.getElementById("docno").value);  
	        	}  */
	        	
	         }  
	         
	       //  alert()
	        // alert(document.getElementById("detval").value);
	       
	       
	         
	        if(parseInt(document.getElementById("detval").value)==10)
	        	 {
	        	// jqxStartDate hidjqxStartDate uptoDate 	 
	        	//calcumethod  paymentmethod calcuval paymentval
	      
	     	   if($('#hidjqxStartDate').val()){
					 $("#jqxStartDate").jqxDateTimeInput('val', $('#hidjqxStartDate').val());
				  }
	    	   if($('#hiduptoDate').val()){
					 $("#uptoDate").jqxDateTimeInput('val', $('#hiduptoDate').val());
				  }
	    	   
	    	   
	   		  $('#calcumethod').val($('#calcuval').val());
	   		  $('#paymentmethod').val($('#paymentval').val());
	   		
	   	     $("#detailsdiv").load("distributionGrid.jsp?docnos="+document.getElementById("masterdoc_no").value+'&detval='+document.getElementById("detval").value);  
	       //  detailsdiv  distributionGrid
	         if((parseInt(document.getElementById("clstatus").value)!=1) && (parseInt(document.getElementById("fleetupdateval").value)<1))
	        	 {
	         
	        	 $.messager.alert('Message','Successfully Saved'); 
	       
	        	 }
	        	 document.getElementById("detval").value="";
	        	 document.getElementById("msg").value="";
	        	 
	        	 
	         	
	             document.getElementById("updatebtn").value="Edit";	 
	             
	             $("table#finance input").prop("disabled", true);
				 $("table#finance select").prop("disabled", true);
				 
				 $("table#finance input").prop("readonly", true);
				$("table#finance select").prop("readonly", true);
	        	 
	        	
	        	 }
	         else if(parseInt(document.getElementById("detval").value)==11)
        	 {
	        	 
	        	// alert("1");
	        	  
			 
	        	 
	        	   $("table#finance input").prop("disabled", false);
				   $("table#finance select").prop("disabled", false);
				    
					   $("table#finance input").prop("readonly", false);
					    $("table#finance select").prop("readonly", false);
					    
					    if($('#hidjqxStartDate').val()){
							 $("#jqxStartDate").jqxDateTimeInput('val', $('#hidjqxStartDate').val());
						  }
			    	   if($('#hiduptoDate').val()){  
							 $("#uptoDate").jqxDateTimeInput('val', $('#hiduptoDate').val());
						  }    
					    
					    $("#loanamount").prop("readonly", true);
					   $("#financeaccname").prop("readonly", true);
					   $("#bankaccname").prop("readonly", true);
					   $("#intaccname").prop("readonly", true);
					   $("#loanaccname").prop("readonly", true);
					  // financeaccid,bankaccid,interestaccid,loanaccid   
					       $("#financeaccid").prop("readonly", true);
						   $("#bankaccid").prop("readonly", true);
						   $("#interestaccid").prop("readonly", true);
						   $("#loanaccid").prop("readonly", true);
					
				   // financeaccname  bankaccname intaccname loanaccname
				    
				    $('#jqxStartDate').jqxDateTimeInput({disabled: false});  
				    $('#uptoDate').jqxDateTimeInput({disabled: false});  
				    
				    
				    
				    
	        	 $("#jqxDistributionGrid").jqxGrid('clear');
				   $("#jqxDistributionGrid").jqxGrid('addrow', null, {});
				  var install=document.getElementById("instnos").value;
				 var payment=document.getElementById("paymentval").value;
				  
				  for(var i=0;i<parseInt(install);i++)
					  {
					  	// alert("2");
						// alert("install"+install);

						 /*           var curdateout=new Date($('#jqxStartDate').jqxDateTimeInput('getDate')); 
										  var d = new Date(curdateout);
									     addmnt =  [d.getMonth()]; 
									      var addval=parseInt(addmnt)+(i+1);	
									    d.setMonth(parseInt(addval));
									     */
				         var dtval=$("#jqxStartDate").val();
					      //   alert(dtval);
					         var aa1="yes";
					         var ss=i;
					         
					 		
					 		var x=new XMLHttpRequest();
					 		x.onreadystatechange=function(){
					 		if (x.readyState==4 && x.status==200)
					 			{
								var items = x.responseText;
					 		 	items = items.split('::');
						  
								for (var i = 0; i < install; i++) {
									var data=items[i];
									
								//	alert(""+items[i]);
									
									$('#jqxDistributionGrid').jqxGrid('setcellvalue',i, "date" ,data);   
								}
								
					 		/* 	var aa=x.responseText;
					 		//	alert("aa"+aa);
					 			 $("#hideDate").jqxDateTimeInput('val', aa);
					 			 */
					 			
					 				 }
					 			
					 			
					 			}
					 			
					 		  
					 		
					 x.open("GET","gatedate.jsp?jqxStartDate="+dtval+"&ival="+ss+"&chk="+aa1+"&install="+install,true);


					 x.send();    
									    
									    
									    
						               var loanval=document.getElementById("loanamount").value;
						               var perint=document.getElementById("perinterest").value;
						               var instnos=document.getElementById("instnos").value;
						           //  alert("loanval"+loanval);
						           //  alert("perint"+perint);
						           // alert("instnos"+instnos);
						           var priamount=(parseFloat(loanval)/(parseFloat(instnos))); 
						            var interest=(((((parseFloat(loanval)*parseFloat(perint)/100))*(parseFloat(instnos)/12)))/(parseFloat(instnos))); 
									//var interest=(((parseFloat(loanval)*parseFloat(perint)/100))*(parseFloat(instnos)/12)); 
									
									 var amount=parseFloat(priamount)+parseFloat(interest);
									//  alert("------"+payment);
									  if(parseInt(payment)==2)
										  {
										  $('#jqxDistributionGrid').jqxGrid('setcellvalue',i, "chqno" ,i+1+" "+" - "+document.getElementById("docno").value);
										  }
									   /*  loanamount,perinterest instnos */
											//alert("----i--------"+i) ;     
									$('#jqxDistributionGrid').jqxGrid('setcellvalue',i, "sr_no" ,i+1);
							/* 		$('#jqxDistributionGrid').jqxGrid('setcellvalue',i, "date" ,d); */
									$('#jqxDistributionGrid').jqxGrid('setcellvalue',i, "priamount" ,priamount);
									$('#jqxDistributionGrid').jqxGrid('setcellvalue',i, "interest" ,interest );
									$('#jqxDistributionGrid').jqxGrid('setcellvalue',i, "amount" ,amount);
									
								if(i<(parseInt(install)-1))
									{
									$("#jqxDistributionGrid").jqxGrid('addrow', null, {});
									}
					  }
				         document.getElementById("updatebtn").value="Save";	 
	        	 
	        	 
	        	 
	       	  $('#calcumethod').val($('#calcuval').val());
	   		  $('#paymentmethod').val($('#paymentval').val()); 	 
        	 $.messager.alert('Message','Not Saved');
        	 document.getElementById("detval").value="";
        	 document.getElementById("msg").value="";
        	 return 0;
        	 }
            else
         	 {
          	  
	   		 // $('#paymentmethod').val('');
   			  } 
	         
	         if(parseInt(document.getElementById("fleetupdateval").value)==1) // fleet save
	        	 {
	        	 $.messager.alert('Message','Fleet Updated Successfully'); 
	        	 document.getElementById("fleetupdateval").value="";
	        	 
	        	 }
	         else if(parseInt(document.getElementById("fleetupdateval").value)==2)
	        	 {
	        	 $.messager.alert('Message','Fleet Not Updated');
	        	 document.getElementById("fleetupdateval").value="";
	        	 }
	         if(parseInt(document.getElementById("fleetupdateval").value)==3) //posting update
        	 {
        	 $.messager.alert('Message','Posting Updated Successfully'); 
        	 document.getElementById("fleetupdateval").value="";
        	 
        	 }
         else if(parseInt(document.getElementById("fleetupdateval").value)==4)
        	 {
        	 $.messager.alert('Message','Posting Not Updated');
        	 document.getElementById("fleetupdateval").value="";
        	 }
	         
	         else
	        	 {
	        	  if($('#msg').val()!=""){
	   			   $.messager.alert('Message',$('#msg').val());
	   			  }
	   			 
	        	 document.getElementById("fleetupdateval").value="";
	        	 }
 	         
	        if(parseInt(document.getElementById("tranno").value)>0)
	        		{
	        	
	        	   $("#postingdiv").load("postinggrid.jsp?srno="+document.getElementById("tranno").value);  
	        	
	        		} 
	     
	         if(parseInt(document.getElementById("masterstatus").value)>0)
	        	 {
	        	  
	        	  $("#editss").prop("disabled", false);
	        	 
	        	 }
	         
	         
	         changeval();
	         document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	         
	        
	         if($('#mode').val().trim()=="view" && parseInt(document.getElementById("clstatus").value)==1)
			 {
			 $("#editdeal").show();
			
			 $("#editdeal").prop("disabled", false);
		//	 $("#editdeal").prop("readonly", false);
			 
			// $('#editdeal').attr('disabled', false);
			// $('#editdeal').attr('readonly', false);
			 }
	         
	         
		}
	  
	  $(function(){
	        $('#frmpurchase').validate({
	        	 rules: { 
	        		 vehdesc:{maxlength:200},
	        		 
	        	 },
		                 messages: {
		                	  
		                	 vehdesc: {maxlength:"  Max 200 chars"}
		              
	                 }
	        });});
	  
	  
	  function calculateval()
	  {
		  
		  if(parseInt(document.getElementById("calcumethod").value)==1)
			  
			  {
			  var downpayment=document.getElementById("downpayment").value;
			  var totalamount=document.getElementById("totalamount").value;
			  
			 var loanamount=parseFloat(totalamount)-parseFloat(downpayment);
			
			// document.getElementById("loanamount").value=loanamount;
			 var aa="loanamount";
			  funRoundAmt(loanamount,aa);
			 
			  }
			 // downpayment   loanamount calcumethod totalamount

	  }
	
	function funupdatefleet()
	{
		if (($("#mode").val() == "view") && parseInt(document.getElementById("masterdoc_no").value)>0) {
			
			

			var rows2 = $("#vehoredergrid").jqxGrid('getrows');
			
			var fleetval=0;
			   for(var i=0 ; i < rows2.length ; i++){
		
					 var brdid=rows2[i].brdid;
					
					 if(parseInt(brdid)>=0)
						{
						       
						    var flstatuss=rows2[i].fleet_no;
						  
							if(parseInt(flstatuss)>0)
								{
								fleetval=10;
							     break;
								}
							else
								{
								//fleetval=11;
						    
								}
					
						}
			   }
			 
			   
			   if(parseInt(fleetval)==0)
				   {
					$.messager.alert('Message','Minimum One Fleet Required','warning');
					//document.getElementById("errormsg").innerText="All Fleets Are Updated";  
				    	return 0;
				   
				   }
			
			
			
			var rows1 = $("#vehoredergrid").jqxGrid('getrows');
			
			var aa=0;
			   for(var i=0 ; i < rows1.length ; i++){
		
					 var brdid=rows1[i].brdid;
					
					 if(parseInt(brdid)>=0)
						{
						
						       
						    var flstatus=rows1[i].flstatus;
							if(parseInt(flstatus)==1)
								{
								
								}
							else
								{
						     aa=1;
						     break;
								}
					
						}
			   }
			   
			   if(parseInt(aa)==0)
				   {
					$.messager.alert('Message','All Fleets Are Updated','warning');
					//document.getElementById("errormsg").innerText="All Fleets Are Updated";  
				    	return 0;
				   
				   }
			   
				
			    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
		        	  
	     		       
		        	if(r==false)
		        	  {
		        		return false; 
		        	  }
		        	else{	
			   
						  var rows = $("#vehoredergrid").jqxGrid('getrows');
						    $('#vehpurchasegridlenght').val(rows.length);
						 
						   for(var i=0 ; i < rows.length ; i++){
						  
						    newTextBox = $(document.createElement("input"))
						       .attr("type", "dil")
				               .attr("id", "vehpurchasetest"+i)
						       .attr("name", "vehpurchasetest"+i) 
						       .attr("hidden", "true"); 
						    
						    
						   newTextBox.val(rows[i].fleet_no+"::"+rows[i].rowno+" :: "+rows[i].price+" :: "+rows[i].chaseno+" :: "+rows[i].enginno+" :: "+rows[i].totper+" :: "+rows[i].clrid+" :: ");
					
						   newTextBox.appendTo('form');
						   
						   }
						   $("table#finance input").prop("disabled", false);
						   $("table#finance select").prop("disabled", false);
						   $("table#finance input").prop("readonly", false);
						   $("table#finance select").prop("readonly", false);  
					       $('#jqxStartDate').jqxDateTimeInput({disabled: false});  
					       $('#uptoDate').jqxDateTimeInput({disabled: false}); 
						   $('#frmpurchase input').attr('readonly', false );
							$('#frmpurchase select').attr('disabled', false);
							$("#vehoredergrid").jqxGrid({ disabled: false});
							$('#vehpurorderdelDate').jqxDateTimeInput({disabled: false});
							$('#vehpurinvDate').jqxDateTimeInput({disabled: false});
							$('#vehpurorderDate').jqxDateTimeInput({disabled: false});
							
							$('#frmpurchase input').attr('disabled', false );
												
							$('#vehrefno').attr('disabled', false);
						   document.getElementById("mode").value="UPD";
						   document.getElementById("fleetupdateval").value="";
						   document.getElementById("msg").value="";
						   $('#frmpurchase').submit();
						   
						   
		        	}
	   		     });
					
	     		       	}
	     			   
		
		else {
			$.messager.alert('Message','Select a Document....!','warning');
			return 0;
		}
		
	}
	
	
	function funpostcalcu()
	{
		
        var venacc=$("#headacccode").val();
		var deldate= $("#vehpurorderDate").val();
		var total=$("#totalamount").val();
		
		var loanaccdocno=$("#loanaccdocno").val();
		
		var loanamount=$("#loanamount").val(); 
		 
		
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			
			
			var items=x.responseText;
			var chkstatus=items.trim();

			 if(parseInt(chkstatus)>0)
				 {
				 document.getElementById("tranno").value=chkstatus; 
				 document.getElementById("validatepostcalu").value=1;
				   $("#postingdiv").load("postinggrid.jsp?srno="+chkstatus);  
				   
				   
				   
				 return 0;
				 }
			
			
			}
			
		}    
		
x.open("GET","jurnsave.jsp?vocno="+ document.getElementById("docno").value+"&deldate="+deldate+"&total="+total+"&venacc="+venacc+"&masterdocno="+document.getElementById("masterdoc_no").value+"&invno="+document.getElementById("invno").value+"&vehpurinvDate="+document.getElementById("vehpurinvDate").value+"&loanaccdocno="+loanaccdocno+"&loanamount="+loanamount,true);


x.send();
		
}
	
	function funeditpost()
	{
		if (($("#mode").val() == "view") && parseInt(document.getElementById("masterdoc_no").value)>0) {
			
		
			
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
							if (x.readyState==4 && x.status==200)
								{
								
						     			
									var items=x.responseText;
									var chkstatus=items.trim();
					
									 if(parseInt(chkstatus)==1)
										 {
										 $.messager.alert('Message','Posting Already Done ','warning');   
										 return 0;
										 }
									 else
										 {
										
											var rows1 = $("#vehoredergrid").jqxGrid('getrows');
											
											   for(var i=0 ; i < rows1.length ; i++){
										
													 var brdid=rows1[i].brdid;
													
													 if(parseInt(brdid)>=0)
														{
														       
														 var flstatus=rows1[i].flstatus;
															if(parseInt(flstatus)!=1)
																{
																
																document.getElementById("errormsg").innerText="Update All Fleet Before Posting";  
														    	return 0;
																}
													
														}
											              }
												 
										 
										 
										 
										 
										 
										 
										 $('#vehpurinvDate').jqxDateTimeInput({disabled: false});
										  document.getElementById("invno").value="";
										 
										 $('#invno').attr('readonly', false);
				 
									     $("#btnCalculate").prop("disabled", false);
									     $("#updateposting").prop("disabled", false);
										
										 
										 }
									 
									 
								}
			}
			
			x.open("GET","checkUpdate.jsp?masterdocno="+ document.getElementById("masterdoc_no").value,true);

			x.send();
			
			 
		}
			
			else
			{
 
					$.messager.alert('Message','Select a Document....!','warning');
					return 0;
			 
			}
		 
					
			}
 
	
	function funupdateposting()
	{
	
		
		   if(document.getElementById("invno").value=="")
			 {
			 
			 document.getElementById("errormsg").innerText="Enter Inv No";  
			 document.getElementById("invno").focus();
			 return 0;
			 
			 }
		
		
		
		
           if(parseInt(document.getElementById("validatepostcalu").value)==1)
        	   {
        	   
        		
        	    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
        	   	  
        		       
        	     	if(r==false)
        	     	  {
        	     		return false; 
        	     	  }
        	     	else{
        	     		
        	     	
		
				   

					  var rows = $("#vehoredergrid").jqxGrid('getrows');
					    $('#vehpurchasegridlenght').val(rows.length);
					 
					   for(var i=0 ; i < rows.length ; i++){
					  
					    newTextBox = $(document.createElement("input"))
					       .attr("type", "dil")
			               .attr("id", "vehpurchasetest"+i)
					       .attr("name", "vehpurchasetest"+i) 
					       .attr("hidden", "true"); 
					    
					 
					   newTextBox.val(rows[i].fleet_no+"::"+rows[i].rowno+" :: "+rows[i].price+" :: ");
				
					   newTextBox.appendTo('form');
					   
					   }
					   $("table#finance input").prop("disabled", false);
					    $("table#finance select").prop("disabled", false);
						   $("table#finance input").prop("readonly", false);
						    $("table#finance select").prop("readonly", false);  
				    $('#jqxStartDate').jqxDateTimeInput({disabled: false});  
				    $('#uptoDate').jqxDateTimeInput({disabled: false}); 
					   
						$('#frmpurchase input').attr('disabled', false );
					   $('#frmpurchase input').attr('readonly', false );
						$('#frmpurchase select').attr('disabled', false);
						$("#vehoredergrid").jqxGrid({ disabled: false});
						$('#vehpurorderdelDate').jqxDateTimeInput({disabled: false});
						$('#vehpurinvDate').jqxDateTimeInput({disabled: false});
						$('#vehpurorderDate').jqxDateTimeInput({disabled: false});
						$('#vehrefno').attr('disabled', false);
					   document.getElementById("mode").value="POS";
					   document.getElementById("fleetupdateval").value="";
					   document.getElementById("msg").value="";
					   $('#frmpurchase').submit();
				   
        	     	}
   		     });
				
        	   
        	   }
			
			
			
					 else
						 {
							document.getElementById("errormsg").innerText="Calculate Before Posting";  
					    	return 0;
						 
						 }
						
			
			
				 
											     			   
		
		
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
	
	
	function funcheckaccinvendor()
	{
		if(document.getElementById("accid").value=="")
			{
			
			 document.getElementById("errormsg").innerText="Search Vendor";  
			 document.getElementById("accid").focus();
		       
		        return 0;
			}
		
	}
	
	function paymtchg()
	{
		
		document.getElementById("errormsg").innerText="";  
	}
	
	 function funPrintBtn(){
	  	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	  	  
	  	   var url=document.URL;

	         var reurl=url.split("savePurchase");
	         
	         $("#docno").prop("disabled", false);                
	         
	   
	 var win= window.open(reurl[0]+"printPurchase?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	      
	 win.focus();
	  	   } 
	  	  
	  	   else {
	 	    	      $.messager.alert('Message','Select a Document....!','warning');
	 	    	      return false;
	 	    	     }
	 	    	
	  	} 
	 
	 /* function funchkunique()
	 {

								
	var x =new XMLHttpRequest();
	
	x.onreadystatechange=function()
	{
	if(x.readyState==4 && x.status==200)	
	
	{
		var items=x.responseText;
		var chk=items.trim();
		
	if(parseInt(chk)==1)
		{
		
		//document.getElementById("errormsg").innerText="Deal No "+document.getElementById("dealno").value+" Already Exists "; 
	
	 $.messager.confirm('Confirm', 'Deal No '+document.getElementById('dealno').value+' Already Exists ',function(r){
		    if (r){
		        document.getElementById("dealno").focus();
		    }
		    
	 });

	
	}
	else{}
	}
	}
	x.open("GET","checkdealno.jsp?dealno="+document.getElementById("dealno").value+"&masterdoc="+document.getElementById("masterdoc_no").value,true);

	x.send();
		 
	 } */
	 
	 
	 function funchkunique()
	 {

								
	var x =new XMLHttpRequest();
	
	x.onreadystatechange=function()
	{
	if(x.readyState==4 && x.status==200)	
	
	{
		var items=x.responseText;
		var chk=items.trim();
		
	if(parseInt(chk)==1)
		{
		
		document.getElementById("errormsg").innerText="Deal No "+document.getElementById("dealno").value+" Already Exists ";  
		document.getElementById("dealno").value="";
		//document.getElementById("dealno").focus();
		
		return 0;
		
		}
	else
		{
		 document.getElementById("errormsg").innerText="";
		}
		
		
	
	}
	}
	
	x.open("GET","checkdealno.jsp?dealno="+document.getElementById("dealno").value+"&masterdoc="+document.getElementById("masterdoc_no").value);

	x.send();
		 
	 }

	 
	 
	 function saveExcelDataData(docNo){
		 
		 
		 
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
					var items=x.responseText.trim();
					
					if(items==1){
						
						 
						
						   $("#detailsdiv").load("distributionGrid.jsp?docNo="+docNo);
						$.messager.alert('Message', ' Successfully Imported.', function(r){
					});
					}
					
			  }
			}
				
		x.open("GET","saveData.jsp?docNo="+docNo,true);
		x.send();
		}
		
		function getAttachDocumentNo(){
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
					var items=x.responseText.trim();
					
					if(items>0){
						
						var path=document.getElementById("file").value;
						var fsize = $('#file')[0].files[0].size;
						var extn = path.substring(path.lastIndexOf(".") + 1, path.length);
						
						if((extn=='xls') || (extn=='csv')){ 
					        	ajaxFileUpload(items);	
					     }else{
					        	 $.messager.show({title:'Message',msg: 'File of xlsx Format is not Supported.',showType:'show',
			                         style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
			                     }); 
						            return;
					     } 
					}
					
			  }
			}
				
		x.open("GET","getAttachDocumentNo.jsp",true);
		x.send();
		}
		
		function upload(){
			 
			$('#txtexcelvalidation').val(1);
			getAttachDocumentNo();
			 
		 }
		
		function ajaxFileUpload(docNo) {  
			
		/* 	  var jvtdate = $("#jqxJournalVouchersDate").val();
		      var newDate = jvtdate.split('.');
		      jvtdate = newDate[0] + "-" + newDate[1] + "-" + newDate[2]; */
		  
			    if (window.File && window.FileReader && window.FileList && window.Blob)
			    {
			        var fsize = $('#file')[0].files[0].size;
			        
			        if(fsize>1048576) {
			            $.messager.show({title:'Message',msg: fsize +' bytes too big ! Maximum Size 1 MB.',showType:'show',
                       style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                   }); 
			            return;
			        }
			    }else{
			    	 $.messager.show({title:'Message',msg:'Please upgrade your browser, because your current browser lacks some new features we need!',showType:'show',
	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	                        }); 
			        return;
			    }
			
	          $.ajaxFileUpload  
	          (  
	              {  
	                  url:'fileAttachAction.action?formCode=VPUE&doc_no='+docNo+'&descpt=Excel Import' ,
	                  secureuri:false,  
	                  fileElementId:'file',    
	                  dataType: 'json', 
	                  success: function (data, status)   
	                  {  
	                     
	                     if(status=='success'){
	                         saveExcelDataData(docNo);
	                         $.messager.show({title:'Message',msg:'Successfully Uploaded',showType:'show',
	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	                        }); 
	                      }
	                     
	                      if(typeof(data.error) != 'undefined')  
	                      {  
	                          if(data.error != '')  
	                          {  
	                              $.messager.show({title:'Message',msg: data.error,showType:'show',
	  	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	  	                        }); 
	                          }else  
	                          {  
	                              $.messager.show({title:'Message',msg: data.message,showType:'show',
		  	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
		  	              	          }); 
	                          }  
	                      }  
	                  },  
	                  error: function (data, status, e){  
	                      $.messager.alert('Message',e);
	                  }  
	              });  
	          return false;  
	      }
	
		function funeditdeal()
		{
			 if(document.getElementById("editdeal").value.trim()=="Edit")
				 {
			 	$("#dealno").prop("disabled", false);
			    $("#dealno").prop("readonly", false);
			    document.getElementById("editdeal").value="Save";
				 }
			 
			 else if(document.getElementById("editdeal").value.trim()=="Save" && document.getElementById("errormsg").innerText=="")
				 {
				 var dealno=document.getElementById("dealno").value;
			 
			 var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
					{
						var items=x.responseText.trim();
						
						if(items==1){
							
						$.messager.alert('Message', ' Deal No Successfully Updated.');
						document.getElementById("editdeal").value="Edit";
						$("#dealno").prop("disabled", true);
					    $("#dealno").prop("readonly", true);
							}
						
				  }
				}
					
			x.open("GET","updateDealNo.jsp?dealno="+dealno+"&masterdoc="+document.getElementById("masterdoc_no").value,true);
			x.send();
				}
			 else
				 {
				 }
			
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
<div id="mainBG" class="homeContent" data-type="background" >
<jsp:include page="../../../../header.jsp"></jsp:include><br><br>

<div  class='hidden-scrollbar'>

<form id="frmpurchase" action="savePurchase" method="post" autocomplete="off" >

<fieldset>
<table width="100%"><tr><td>
<table width="100%"  >
  <tr>
    <td width="4.2%"  align="right">&nbsp;&nbsp;Date</td> 
    <td width="5%"><div id="vehpurorderDate" name="vehpurorderDate" value='<s:property value="vehpurorderDate"/>'></div>
    <input type="hidden" id="hidvehpurorderDate" name="hidvehpurorderDate" value='<s:property value="hidvehpurorderDate"/>'/></td>
    
    <td width="75%" align="right">Doc No</td>
    <td width="10%"><input type="text" id="docno" name="docno" style="width:97%;" value='<s:property value="docno"/>' tabindex="-1"/>
    </td>
  </tr>
</table>
</td>
</tr>
<tr><td>                   
<table width="100%" >
  <tr>
    <td width="2%" align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Vendor</td>
  <td width="34%">  <input type="text" id="accid" name="accid" style="width:20%;" placeholder="Press F3 to Search" value='<s:property value="accid"/>'  onkeydown="getaccountdetails(event)"/>
   <input type="text" id="vehpuraccname" name="vehpuraccname" style="width:75%;" value='<s:property value="vehpuraccname"/>'/>
   

    <td align="right"  width="2%">Type</td>
    <td width="7%"><select id="vehtype" name="vehtype" style="width:92%;" value='<s:property value="vehtype"/>' onchange="funrefdisslno()" >
     <option value="DIR">DIR </option>
       <option value="VPO">VPO</option></select>
     </td>
    
    <td width="10%"><input type="text" id="vehrefno" name="vehrefno" style="width:95%;" placeholder="Press F3 to Search" value='<s:property value="vehrefno"/>' onfocus="funcheckaccinvendor();" onkeydown="getrefDetails(event)"/></td>
     <td width="30%"></td>
  </tr>
  </table>
  </td></tr>
  <tr><td>
<table >

  <tr>
    <td align="right"  width="1%">Exp.Delivery</td>
    <td width="5%"><div id="vehpurorderdelDate" name="vehpurorderdelDate" value='<s:property value="vehpurorderdelDate"/>'></div>
   
     <input type="hidden" id="hidvehpurorderdelDate" name="hidvehpurorderdelDate" value='<s:property value="hidvehpurorderdelDate"/>'/></td>
    <td >Description&nbsp;<input type="text" id="vehdesc" name="vehdesc" style="width:71.7%;" value='<s:property value="vehdesc"/>'/>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   
    <input type="button" class="myButtonss" name="updatefleet" id="updatefleet" onclick="funupdatefleet()"  value="Fleet Update"  >
    </td>
  </tr>
</table>
</td></tr></table>
</fieldset>
<br>
<fieldset>

<div id="vehpuchase"><jsp:include page="vehpurchaseDetails.jsp"></jsp:include></div> 
</fieldset>

<table width="100%">
<tr>
<td width="40%">
<fieldset><legend>Finance Details</legend>
<table width="100%"   id="finance" >
   <tr>
 
    <td align="right" align="right" width="20%">Down Payment</td>
    <td width="20%"><input type="text" id="downpayment" name="downpayment" style="width:97%;" onblur="funRoundAmt(this.value,this.id);calculateval();" onkeypress="javascript:return isNumber (event)" value='<s:property value="downpayment"/>'/>
    </td> 
    <td  width="20%" align="right">Loan Amount</td><td width="20%"><input type="text" id="loanamount" tabindex="-1" name="loanamount" style="width:97%;"  value='<s:property value="loanamount"/>'/></td>
    
  </tr>
  
  <tr>
  <td width="20%" align="right">
    Start Date</td><td width="20%"><div id="jqxStartDate" name="jqxStartDate"  value='<s:property value="jqxStartDate"/>'></div>
    <input type="hidden" id="hidjqxStartDate" name="hidjqxStartDate" value='<s:property value="hidjqxStartDate"/>'/></td>
    <td align="right" align="right">% Of Interest</td><td><input type="text" id="perinterest" name="perinterest" onkeypress="javascript:return isNumber (event)" style="width:97%;"  value='<s:property value="perinterest"/>'/></td>
        
  </tr>
   
   <tr>
  <td align="right" align="right">Calculation Method</td><td><Select id="calcumethod" name="calcumethod" style="width:97%;"  >
 
   <option value=1>Flat Rate</option>
    <option value=2>Diminishing rate</option>
</Select>
  </td>
  <td align="right">Number Of Inst</td><td><input type="text" id="instnos" name="instnos" style="width:97%;" onkeypress="javascript:return isNumber (event)"   value='<s:property value="instnos"/>'/>
   <%--  <input type="hidden" id="txtinstamt" name="txtinstamt" value='<s:property value="txtinstamt"/>'/></td> --%>
    
    </tr>
  
 <%--  <tr>
    <td align="right">Down Payment</td>
    <td><input type="text" id="txtcostgroup" name="txtcostgroup" style="width:80%;"  value='<s:property value="txtcostgroup"/>'/>
    <input type="hidden" id="txtcosttype" name="txtcosttype" style="width:80%;" value='<s:property value="txtcosttype"/>'/></td>
    <td width="26%" align="right">% Of Interest</td>
    <td colspan="2"><input type="text" id="txtcostno" name="txtcostno" style="width:30%;"  value='<s:property value="txtcostno"/>'/>
    &nbsp;&nbsp;&nbsp;&nbsp;Loan Amount&nbsp;
    <input type="text" id="loanamount" name="loanamount" style="width:30%;" onblur="funRoundAmt(this.value,this.id);" value='<s:property value="loanamount"/>'/>
    </td>
  </tr> --%>
<tr>
    <td  align="right" >Account(Financier)</td> 
    <td ><input type="text" id="financeaccid" name="financeaccid" style="width:97%;"  placeholder="Press F3 to Search" value='<s:property value="financeaccid"/>' onkeydown="getfinacc(event);"/></td>
    <td colspan="2"><input type="text" id="financeaccname" name="financeaccname" tabindex="-1" style="width:99%;"  value='<s:property value="financeaccname"/>'/>
   <%--  <input type="hidden" id="txtdistributiondocno" name="txtdistributiondocno" value='<s:property value="txtdistributiondocno"/>'/>
    <input type="hidden" id="txtaccountdocno" name="txtaccountdocno" value='<s:property value="txtaccountdocno"/>'/>
    <input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
    <input type="hidden" id="txtdtype" name="txtdtype" value='<s:property value="txtdtype"/>'/>
    <input type="hidden" id="txttranid" name="txttranid" value='<s:property value="txttranid"/>'/></td> --%>
  </tr>
  <tr>
    <td  align="right" >Bank A/C</td> 
    <td ><input type="text" id="bankaccid" name="bankaccid" style="width:97%;"  placeholder="Press F3 to Search" value='<s:property value="bankaccid"/>'  onkeydown="getbankacc(event);"/></td>
    <td colspan="2"><input type="text" id="bankaccname" name="bankaccname" style="width:99%;" tabindex="-1" value='<s:property value="bankaccname"/>'/>
  </td>
  </tr>
   <tr>
    <td  align="right" >Interest A/C</td>
    <td ><input type="text" id="interestaccid" name="interestaccid" style="width:97%;"  placeholder="Press F3 to Search" value='<s:property value="interestaccid"/>'  onkeydown="getInterestacc(event);"/></td>
    <td colspan="2"><input type="text" id="intaccname" name="intaccname" style="width:99%;" tabindex="-1" value='<s:property value="intaccname"/>'/>
  </td>
  </tr>
  <tr>
    <td  align="right" >Loan A/C</td>
    <td ><input type="text" id="loanaccid" name="loanaccid" style="width:97%;"  placeholder="Press F3 to Search" value='<s:property value="loanaccid"/>' onkeydown="getloanacc(event);"/></td>
    <td colspan="2"><input type="text" id="loanaccname" name="loanaccname"  tabindex="-1" style="width:99%;"  value='<s:property value="loanaccname"/>'/>
  </td>
  </tr>
  <%-- <tr>
  <td align="right" width="20%" align="right">Bank A/C</td><td width="20%"><input type="text" id="bankacc" name="bankacc" style="width:90%;"  value='<s:property value="bankacc"/>'/></td>
    <td width="20%" align="right">
    Interest A/C</td><td width="20%"> <input type="text" id="interestacc" name="interestacc" style="width:90%;"  value='<s:property value="interestacc"/>'/></td>
     <td width="20%" align="right">Loan A/C</td> <td><input type="text" id="loanacc" name="loanacc" style="width:90%;"  value='<s:property value="loanacc"/>'/></td>
  </tr> --%>
  <tr> 
 
    <td align="right">Security Cheque NO</td> <td><input type="text" id="secchaqueno" name="secchaqueno" style="width:97%;"  value='<s:property value="secchaqueno"/>' /></td>
     <td align="right">Amount</td><td> <input type="text" id="chqamount" name="chqamount" style="width:97%;" onkeypress="javascript:return isNumber (event)" value='<s:property value="chqamount"/>' onblur="funRoundAmt(this.value,this.id);"></td>
  </tr>
   <tr>
  <td width="20%" align="right"> 
    Upto Date</td><td width="20%"><div id="uptoDate" name="uptoDate"  value='<s:property value="uptoDate"/>'></div>
    <input type="hidden" id="hiduptoDate" name="hiduptoDate" value='<s:property value="hiduptoDate"/>'/></td>
   
    <td align="right"><input type="button" class="myButton" name="editdeal" id="editdeal" onclick="funeditdeal()"  value="Edit" style="display:none;" >Deal No</td><td> <input type="text" id="dealno" name="dealno" style="width:97%;" onblur="funchkunique()"  value='<s:property value="dealno"/>'></td>
        
  </tr>
  <tr>
   <td align="right">Name In Cheque</td><td colspan="3"><input type="text" id="nameincheque" name="nameincheque" style="width:99%;"  value='<s:property value="nameincheque"/>'/></td>
  
  
  </tr>
     <tr>
   <td align="right" >Payment Method</td><td><Select id="paymentmethod" name="paymentmethod" style="width:97%;" onchange="paymtchg()" >
  <option value="">--Select--</option>
   <option value=1>Cheque</option> 
    <option value=2>Direct Debit</option> 
</Select>
  </td>
  
   
  </tr>
  <tr>
    
    <td align="right">Description</td>
    <td colspan="3"><input type="text" id="txtdescription" name="txtdescription" style="width:99%;"  value='<s:property value="txtdescription"/>'/>
   
  </tr>
   <tr>
  <td>&nbsp;</td>
  </tr>
   <tr>
  <td>&nbsp;</td>
  </tr>
  <tr>
<!--   <td>&nbsp;</td> -->
 <td align="center" colspan="4">
 <input type="button" class="myButton"  id="calculatebtn" name="calculatebtn" value="Calculate"  onclick="calculate();">
 
  <input type="button" class="myButton"  id="updatebtn" name="updatebtn" value="Edit"  onclick="funUpdate();">
 

  </td>
<%--   
  <td width="28%" align="right"><input type="file" id="file" name="file"/></td>
    <td width="11%" align="center"> <button class="icon" id="btnsearch" name="btnsearch" title="Import Excel" type="button" onclick="return upload();">
							<img alt="Import Excel" src="<%=contextPath%>/icons/import_excel.png">
						</button></td> --%>
	</tr>
	<tr>					
	
  <td align="right">
  <button class="icon" id="btnsearch" name="btnsearch" title="Import Excel" type="button" onclick="return upload();">
							<img alt="Import Excel" src="<%=contextPath%>/icons/import_excel.png"></button>
						 </td>	
						<td colspan="3" >
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
	
	   <input type="file" id="file" name="file"/>
  </td>				
  </tr>
  <tr>

 <td align="center" colspan="4">
 

  </td>
  </tr>
</table>
 </fieldset></td> 
<td width="60%">
<div id="detailsdiv"><jsp:include page="distributionGrid.jsp"></jsp:include></div>
</td>
</tr>
</table>
<fieldset>
<legend>Posting</legend>







<table  align="center" width="50%" >

<tr>


    <td align="right"  width="6%">Inv No</td>  
    <td width="12%">  <input type="text" id="invno" name="invno"   value='<s:property value="invno"/>'/></td>
    <td align="right"  width="12%">Purchase Date</td>
    <td width="5%"><div id="vehpurinvDate" name="vehpurinvDate" value='<s:property value="vehpurinvDate"/>'></div>
    <input type="hidden" id="hidvehpurinvDate" name="hidvehpurinvDate" value='<s:property value="hidvehpurinvDate"/>'/>
    <td>
  
   
     <td align="center"><button type="button" class="icon" id="btnCalculate" title="Calculate" onclick="funpostcalcu();">
       <img alt="Calculate" src="<%=contextPath%>/icons/calculate_new.png">
      </button> 
      
      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
  <input type="button" class="myButtonp" name="updateposting" id="updateposting" onclick="funupdateposting()"  value="Posting"  >
   
    
          
      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
  <input type="button" class="myButton" name="editss" id="editss" onclick="funeditpost()"  value="Edit"  >
    
        
    </td>

</tr>


</table>




<table   width="100%" >

<tr>

<td   height="150px">
 <div id="postingdiv"> <jsp:include page="postinggrid.jsp"></jsp:include></div> 

</td>

</tr>


</table>

</fieldset>
<br><br>
<input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'/>   


<input type="hidden" id="masterrefno" name="masterrefno" value='<s:property value="masterrefno"/>'/>

<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="brandval" name="brandval" value='<s:property value="brandval"/>'/>
<input type="hidden" id="nettotal" name="nettotal" value='<s:property value="nettotal"/>'/>
<input type="hidden" id="pricetottal" name="pricetottal" value='<s:property value="pricetottal"/>'/>
<input type="hidden" id="headacccode" name="headacccode" value='<s:property value="headacccode"/>'/>

<input type="hidden" id="vehpurchasegridlenght" name="vehpurchasegridlenght" value='<s:property value="vehpurchasegridlenght"/>'/>
<input type="hidden" id="vehtypeval" name="vehtypeval" value='<s:property value="vehtypeval"/>'/>

<!--  -->


<input type="hidden" id="dimqty" name="dimqty" value='<s:property value="dimqty"/>'/>

<input type="hidden" id="fleetupdateval" name="fleetupdateval" value='<s:property value="fleetupdateval"/>'/> 
<input type="hidden" id="detval" name="detval" value='<s:property value="detval"/>'/>

<input type="hidden" id="calcuval" name="calcuval" value='<s:property value="calcuval"/>'/>
<input type="hidden" id="paymentval" name="paymentval" value='<s:property value="paymentval"/>'/> 




<!-- ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss -->

<input type="hidden" id="distributionlenght" name="distributionlenght" value='<s:property value="distributionlenght"/>'/>

<input type="hidden" id="txtinstamttotal" name="txtinstamttotal" value='<s:property value="txtinstamttotal"/>'/>


<input type="hidden" id="totalamount" name="totalamount" value='<s:property value="totalamount"/>'/>

<input type="hidden" id="validatepostcalu" name="validatepostcalu" value='<s:property value="validatepostcalu"/>'/>


<input type="hidden" id="bankcurrency" name="bankcurrency" value='<s:property value="bankcurrency"/>'/>
<input type="hidden" id="bankrate" name="bankrate" value='<s:property value="bankrate"/>'/>


<input type="hidden" id="intercurrency" name="intercurrency" value='<s:property value="intercurrency"/>'/>
<input type="hidden" id="interrate" name="interrate" value='<s:property value="interrate"/>'/>

<input type="hidden" id="loancurrecy" name="loancurrecy" value='<s:property value="loancurrecy"/>'/>
<input type="hidden" id="loanrate" name="loanrate" value='<s:property value="loanrate"/>'/>



<input type="hidden" id="vendorcurr" name="vendorcurr" value='<s:property value="vendorcurr"/>'/>
<input type="hidden" id="vendorrate" name="vendorrate" value='<s:property value="vendorrate"/>'/>

 





 
<!--acc docno  -->

<input type="hidden" id="finaccdocno" name="finaccdocno" value='<s:property value="finaccdocno"/>'/>
<input type="hidden" id="banckaccdocno" name="banckaccdocno" value='<s:property value="banckaccdocno"/>'/>  


<input type="hidden" id="interestaccdocno" name="interestaccdocno" value='<s:property value="interestaccdocno"/>'/>
<input type="hidden" id="loanaccdocno" name="loanaccdocno" value='<s:property value="loanaccdocno"/>'/>

<input type="hidden" id="clstatus" name="clstatus" value='<s:property value="clstatus"/>'/>


<input type="hidden" id="masterstatus" name="masterstatus" value='<s:property value="masterstatus"/>'/>
 
<input type="hidden" id="tranno" name="tranno" value='<s:property value="tranno"/>'/>


<input type="hidden" id="priamounts" name="priamounts" value='<s:property value="priamounts"/>'/> <!--  distribution grid validation total principle amt=loan amt -->

<input type="hidden" id="dealver" name="dealver" value="0"/>
<input type="hidden" id="restructure" name="restructure" value='<s:property value="restructure"/>'/>


<%-- <input type="text" id="prinamtval" name="prinamtval" value='<s:property value="prinamtval"/>'/> 
<input type="text" id="intamount" name="intamount" value='<s:property value="intamount"/>'/> 
<input type="text" id="totamount" name="totamount" value='<s:property value="totamount"/>'/>
 --%>
 
 

</form>
<div id="colorsearchwndow">
   <div ></div>
</div>
<div id="modelsearchwndow">
   <div ></div>
</div>
<div id="brandsearchwndow">
   <div ></div>
</div>
	<div id="accountSearchwindow">
   <div ></div>
</div>
<div id="refnosearchwindow">
   <div ></div>
</div>
<div id="fleetwindow"><div></div>
</div>
<div id="slnosearchwindow"><div></div>
</div>
</div>
</div>
</body>
</html>
