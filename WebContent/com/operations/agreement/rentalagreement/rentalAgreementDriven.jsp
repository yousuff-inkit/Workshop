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
<style>
form label.error {
   color:red;
  font-weight:bold;

}

.icon {
	width: 2.5em;
	height: 2em;
	border: none;
	background-color: #E0ECF8;
}
</style>

 <script type="text/javascript">   
 
            $(document).ready(function () {   
            	
            	checkweek();
           
			            /* create jqxMenu */
							           $("#jqxMenuMore").jqxMenu({ width: '40%', height: '26px', autoSizeMainItems: true});
							           $("#jqxMenuMore").jqxMenu('minimize');            
							           $("#jqxMenuMore").css('visibility', 'visible');     
							            
							      /*      Menu-minimized window */ 
							           $('#window1').jqxWindow({width: '71%', height: '70%',  maxHeight: '70%' ,maxWidth: '80%' , title: 'Details',position: { x: 180, y: 60 } , theme: 'energyblue', showCloseButton: true,keyboardCloseKey: 27});
							   		   $('#window1').jqxWindow('close');
							           
							            /* Date */ 	
							           $("#jqxRentalDate").jqxDateTimeInput({ width: '120px', height: '15px', formatString:"dd.MM.yyyy"}); 
							            $("#jqxDateOut").jqxDateTimeInput({ width: '110px', height: '15px', formatString:"dd.MM.yyyy"});
							           $("#jqxOnDate").jqxDateTimeInput({ width: '110px', height: '15px', formatString:"dd.MM.yyyy"});  
							           $("#jqxDeliveryOut").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy",enableBrowserBoundsDetection: true});
							            /* Time */
							            $("#jqxTimeOut").jqxDateTimeInput({ width: '80%', height: '17px', formatString: 'HH:mm', showCalendarButton: false });
							            
							            $("#jqxOnTime").jqxDateTimeInput({ width: '80%', height: '15px', formatString: 'HH:mm', showCalendarButton: false });
							            $("#jqxDelTimeOut").jqxDateTimeInput({ width: '80%', height: '15px', formatString: 'HH:mm', showCalendarButton: false });
							           
							            // window
							            
							             $('#vehinfowindow').jqxWindow({ width: '62%', height: '67%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Fleet Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
							       	     $('#vehinfowindow').jqxWindow('close');
							   		 
								   	     $('#clientinfowindow').jqxWindow({ width: '62%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Client Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
								         $('#clientinfowindow').jqxWindow('close'); 
								         
								      	/*  $('#Driverdlswindow').jqxWindow({ width: '30%', height: '62%',  maxHeight: '80%' ,maxWidth: '50%' ,title: 'Driver Search', position: { x: 250, y: 140 }, keyboardCloseKey: 27});
								   	     $('#Driverdlswindow').jqxWindow('close');  */
								   	   
								   	     $('#driverinfowindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '62%' ,maxWidth: '50%' , title: 'Driver Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
									     $('#driverinfowindow').jqxWindow('close'); 
									  
									     $('#chauffeurinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Driver Search' ,position: { x: 200, y: 70 }, keyboardCloseKey: 27});
									     $('#chauffeurinfowindow').jqxWindow('close');
									  
									     $('#tariffinbtnwindow').jqxWindow({ width: '50%', height: '47%',  maxHeight: '95%' ,maxWidth: '50%' , title: 'Tariff Search' ,position: { x: 150, y: 150 }, keyboardCloseKey: 27});
									     $('#tariffinbtnwindow').jqxWindow('close'); 
									   
								 	     $('#Salesagentinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Sales Agent Search' ,position: { x: 200, y: 120 }, keyboardCloseKey: 27});
									     $('#Salesagentinfowindow').jqxWindow('close');
									   
									     $('#Rentalagentinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Rental Agent Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
										 $('#Rentalagentinfowindow').jqxWindow('close');
										 
										 $('#Checkoutinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Checkout Search' ,position: { x: 700, y: 120 }, keyboardCloseKey: 27});
										 $('#Checkoutinfowindow').jqxWindow('close');
										 
										 
										 $('#usersearchwindow').jqxWindow({ width: '55%', height: '53%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'User Search' ,position: { x: 160, y: 150 }, keyboardCloseKey: 27});
										 $('#usersearchwindow').jqxWindow('close');
										 
										 $("#btnEdit").attr('disabled', true );
									//	 $("#btnDelete").attr('disabled', true );
									  
										
										 
										  $('#jqxRentalDate').on('change', function (event) {
											  
										        var maindate = $('#jqxRentalDate').jqxDateTimeInput('getDate');
										      	 if ($("#mode").val() == "A") {   
										        funDateInPeriod(maindate);
										      	 }
										       });
						/* 				  $('#jqxDateOut').on('change', function (event) {
											
										        var dateout = $('#jqxDateOut').jqxDateTimeInput('getDate');
										   	 if ($("#mode").val() == "A") {  
										        funDateInPeriod(dateout);
										        
										        var checkdate =document.getElementById("rentaltype").value;
												
												  var curdateout=new Date($('#jqxDateOut').jqxDateTimeInput('getDate')); 
												  
										             if(checkdate=="Daily")
										              {
										          			          
										                  var plusoneday=new Date(new Date(curdateout).setDate(curdateout.getDate()+1));
										                  $('#jqxOnDate').jqxDateTimeInput('setDate', new Date(plusoneday));
														
										              }
										             else  if(checkdate=="Weekly")
									              {
										            	 var oneweek=new Date(new Date(curdateout).setDate(curdateout.getDate()+7));
										                  $('#jqxOnDate').jqxDateTimeInput('setDate', new Date(oneweek));
									            	
									              }
										             else  if(checkdate=="Fortnightly")
									              {
										            	 var twoweek=new Date(new Date(curdateout).setDate(curdateout.getDate()+14));
										                  $('#jqxOnDate').jqxDateTimeInput('setDate', new Date(twoweek));
									            	
									              }
										             else if(checkdate=="Monthly")
									              {
										            	    var onemounth=new Date(new Date(curdateout).setMonth(curdateout.getMonth()+1)); 
												    
												                 $('#jqxOnDate').jqxDateTimeInput('setDate', new Date(onemounth));
									            	
									              }
										             else
										            	 {
										            	 
										            	 }
												  
												
											  
										        
										   	 }
										       }); */
										
										  
										  $('#jqxDeliveryOut').on('change', function (event) {
											  if ($("#mode").val() == "ADD") {   
											   var indate1=new Date($('#jqxDateOut').jqxDateTimeInput('getDate'));     // out date
											  var agmtdate1=new Date($('#jqxDeliveryOut').jqxDateTimeInput('getDate')); //del date
											  indate1.setHours(0,0,0,0);
											  agmtdate1.setHours(0,0,0,0);
											   if(indate1>agmtdate1){
											   document.getElementById("errormsg").innerText="Delivery Date Cannot be Less than Out Date";
											   return false;
											  }   
											
											   else{
											  
											   document.getElementById("errormsg").innerText="";  
											   }
											  }
										
										       });
										 
										
										  $('#jqxDelTimeOut').on('change', function (event) {
											   
											  if ($("#mode").val() == "ADD") {    
											   var indate1=new Date($('#jqxDateOut').jqxDateTimeInput('getDate'));     // out date
											  var agmtdate1=new Date($('#jqxDeliveryOut').jqxDateTimeInput('getDate')); //del date
											 
											  var intime1=new Date($('#jqxTimeOut').jqxDateTimeInput('getDate'));  //out time
											  var agmttime1=new Date($('#jqxDelTimeOut').jqxDateTimeInput('getDate')); // del time  
										
											  indate1.setHours(0,0,0,0);
											  agmtdate1.setHours(0,0,0,0);
											   if(indate1>agmtdate1){
											   document.getElementById("errormsg").innerText="Delivery Date Cannot be Less than Out Date";
											   return false;
											  }   
											
											   if(indate1.valueOf()==agmtdate1.valueOf()){
											 
											  var out=intime1.getHours();
											  var del=agmttime1.getHours();
											
											  if(out > del){
												   
											    document.getElementById("errormsg").innerText="Delivery Time Cannot be Less than Out Time";
											    return false;
											   }
											   if(out==del){
											    if(intime1.getMinutes()>agmttime1.getMinutes()){
											     document.getElementById("errormsg").innerText="Delivery Time Cannot be Less than Out Time";
											     return false;
											    }
											   }
											  }
											  
											   document.getElementById("errormsg").innerText="";  
											  
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
					   	    
								   								 
											   $('#rasales_Agent').dblclick(function(){
											  	    $('#Salesagentinfowindow').jqxWindow('open');
											       $('#Salesagentinfowindow').jqxWindow('focus');
								  		       salesagentSearchContent('SearchSalesman.jsp?', $('#Salesagentinfowindow')); 
								              });
											 
											   
										        $('#ratariffbutton').click(function(){
										        	  if(($('#txtfleetno').val()!="") && ($('#txtcusid').val()!=""))
										        		  {
										        		  
										        		  
													  	    $('#tariffinbtnwindow').jqxWindow('open');
													       $('#tariffinbtnwindow').jqxWindow('focus');     
													      if(document.getElementById("weekend").checked==true) 
													    	  {
													    	  
													    	  
													    	  
													    	  tariffbtnSearchContent('getWeekendtariff.jsp?vehgpid='+document.getElementById("veh_fleetgrouptariff").value+"&cldocno="+document.getElementById("txtcusid").value+"&outdate="+document.getElementById("jqxDateOut").value+"&outtime="+document.getElementById("jqxTimeOut").value);
													    	  
													    	  }// jqxDateOut jqxTimeOut
													      else
													    	  {
													    	  tariffbtnSearchContent('gettariffbtn.jsp?vehgpid='+document.getElementById("veh_fleetgrouptariff").value+"&cldocno="+document.getElementById("txtcusid").value);
													    	  
													    	  }
													     
													      
										        		  
										        		  }
										        	  else
										        		  {
										        		  if($('#txtfleetno').val()=="")
										        			  {
										        		  document.getElementById("errormsg").innerText="  Select Vehicle";
										            	  document.getElementById("txtfleetno").focus(); 
										            	  return false;
										        		    }
										        		  if($('#txtcusid').val()=="")
									        			  {
									        		  document.getElementById("errormsg").innerText="  Select Client";
									            	  document.getElementById("txtcusid").focus(); 
									            	  return false;
									        		    }
										        		  
										        		  }
										        	  
										        	  
										              });
										        
										      
										        
										        
										        $('#searchuser').click(function(){
										        	 
										        	   if(($('#ratariffdocno1').val()!=""))
										        		  {
												        
													  	    $('#usersearchwindow').jqxWindow('open');
													       $('#usersearchwindow').jqxWindow('focus');     
										 		   
										        		 
										        		  
										 		  searchuserContent('searchotheruser.jsp?vehgpid='+document.getElementById("veh_fleetgrouptariff").value+"&tarifdoc="+document.getElementById("ratariffdocno1").value); 
										        	
										        		  }
										        	   else
										        		   {
										        		   document.getElementById("errormsg").innerText="  Search Tariff";
										        		   return false;
										        		   }
										        	  
										              });
										        
										        
										        
										        
							   	   											  
												   	 $('#txtcusid').dblclick(function(){
															 
													  	    $('#clientinfowindow').jqxWindow('open');
													  	    $('#clientinfowindow').jqxWindow('focus');
													  	  clieninfoSearchContent('clientINgridsearch.jsp?', $('#clientinfowindow')); 
															 }); 
												       
											  	          $('#txtfleetno').dblclick(function(){
													  	    $('#vehinfowindow').jqxWindow('open');
											                  $('#vehinfowindow').jqxWindow('focus');
											                 vehinfoSearchContent('vehinfo.jsp?', $('#vehinfowindow'));
											                 });
											  	          
											  	     											  	      
												  	        $('#radriverlist').dblclick(function(){
														  	    $('#chauffeurinfowindow').jqxWindow('open');
												  	  
												  	  chauffeurSearchContent('SearchChauffeur.jsp?', $('#chauffeurinfowindow')); 
														 });
												  	      

                             }); // close ready
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
										                function getsalesAgent(event){
											      	       	 var x= event.keyCode;
											      	       	 if(x==114){
											      	       	  $('#Salesagentinfowindow').jqxWindow('open');
											      	       
											      	         
											      	        salesagentSearchContent('SearchSalesman.jsp?', $('#Salesagentinfowindow')); }
											      	       	 else{
											      	       		 }
											      	       	 }

												          function salesagentSearchContent(url) {
													                   //alert(url);
														                 $.get(url).done(function (data) {
											                    //alert(data);
															           $('#Salesagentinfowindow').jqxWindow('setContent', data);
													
													           	}); 
														           	}
            
            
                                                          function tariffbtnSearchContent(url) {
							   	                         //alert(url);
							   		                      $.get(url).done(function (data) {
							   			                    //alert(data);
							   		                    $('#tariffinbtnwindow').jqxWindow('setContent', data);
							            
							                        	}); 
							                        	}

                                                          function searchuserContent(url) {
							   	                         //alert(url);
							   		                      $.get(url).done(function (data) {
							   			                    //alert(data);
							   		                    $('#usersearchwindow').jqxWindow('setContent', data);
							            
							                        	}); 
							                        	}
							            
							          
							
							     	       function driverinfoSearchContent(url) {
							       	       	 //alert(url);
							       	       		 $.get(url).done(function (data) {
							       	       			 
							       	       			 $('#driverinfowindow').jqxWindow('open');
							       	       		$('#driverinfowindow').jqxWindow('setContent', data);
							       	       
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
							     	   
								
								            
								            function getvehinfo(event){
								   	       	 var x= event.keyCode;
								   	       	 if(x==114){
								   	       	  $('#vehinfowindow').jqxWindow('open');
								   	       
								   	          
								   	       vehinfoSearchContent('vehinfo.jsp?', $('#vehinfowindow'));  	 }
								   	       	 else{
								   	       		 }
								   	       	 }
								           
								   	        function vehinfoSearchContent(url) {
								   	      
								   	       		 $.get(url).done(function (data) {
								   	       		
								   	       		$('#vehinfowindow').jqxWindow('setContent', data);
								   	       
								   	       	}); 
								   	       	}
								   	        
								   	  
								   	   function getclientinfo(event){
								   	       	 var x= event.keyCode;
								   	       	 if(x==114){
								   	       	  $('#clientinfowindow').jqxWindow('open');
								   	       
								   	                 clieninfoSearchContent('clientINgridsearch.jsp?', $('#clientinfowindow'));  	 }
								   	        	 else{
								   	       		 }
								   	              	 }
								   	 
								         	function clieninfoSearchContent(url) {
								                     	
								      	                	 $.get(url).done(function (data) {
								                   			
								      	           	$('#clientinfowindow').jqxWindow('setContent', data);
								      
								                                        	}); 
								                              	}
								
 
 			function menuContent(url) {
			   $.get(url).done(function (data) {
   			 	 $('#window1').jqxWindow('open');
				 $('#window1').jqxWindow('setContent', data);
				 $('#window1').jqxWindow('bringToFront');
				 
			 		  });
			 	
			} 
          
             function funReset(){
          
			} 
             
             
             
             function checkconfig()
             {
            	 
            	var aa=0;
            	
				var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
					{
 				 
 			     			
 						var items=x.responseText;
 						
 				var chk=items.trim();
 
 						 if(parseInt(chk)==1)
 							 {
 							document.getElementById("configtarif").value=1;
 							  
 							 
 							 }
 						 else
 							 {
 							document.getElementById("configtarif").value=0; 
 							 }
 				
 						
 						}
 				 
				}
 			x.open("GET","chksetdata.jsp?aa="+aa,true);

 			x.send();
 		 
             	
 				
            	 
             }
             
             
             function checkweek()
             {
      
            	var aa=0;
            	
				var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
					{
 				 
 			     			
 						var items=x.responseText;
 						
 				var chk=items.trim();
 			 
 						 if(parseInt(chk)==1)
 					{
 						     $("#weekend").show();
 							 $("#weekend1").show();
 							 
 							 }
 						 else
 							 {
 							 $("#weekend").hide();
 							 $("#weekend1").hide();
 							 }
 				
 						
 						}
 				 
				}
 			x.open("GET","checkweekend.jsp?aa="+aa,true);

 			x.send();
 		 
             	
 				
            	 
             }
             
             
             
			function funReadOnly(){
				  $("#jqxMenuMore").css('visibility', 'visible');  
				$('#frmRentalAgreement input').attr('readonly', true );
				$('#frmRentalAgreement textarea').attr('readonly', true );
				$('#frmRentalAgreement select').attr('disabled', true);
			    $("#ratariffbutton").attr("disabled", true);
			    $("#searchuser").attr("disabled", true);
			    
			    
			    
				//$('#frmRentalAgreement button').attr('disabled', true);
				
			    $('#jqxRentalDate').jqxDateTimeInput({ disabled: true});
			    $('#jqxDateOut').jqxDateTimeInput({ disabled: true});
			    $('#jqxDeliveryOut').jqxDateTimeInput({ disabled: true});
			    $('#jqxOnDate').jqxDateTimeInput({ disabled: true});
			    $('#jqxTimeOut').jqxDateTimeInput({ disabled: true});
			    $('#jqxOnTime').jqxDateTimeInput({ disabled: true});
			    $("#jqxgrid2").jqxGrid({ disabled: true});
			    
			    $("table#tariffsub input").prop("disabled", true);
			    $("table#tariff input").prop("disabled", true);
			    $("table#tariff select").attr("disabled", true);
			    $("table#payment input").prop("disabled", true);
			    $("table#vehicle input").prop("disabled", true);  
			    $("table#driver input").prop("disabled", false);  
			    $('#delivery_chk').attr('disabled', true);
			    $('#radrivercheck').attr('disabled', true);
			    $("#radriverlist").prop("disabled", true);
			    $("#additional_driver").prop("disabled", true);
			    $("#adidrvcharges").prop("disabled", true);
			    
			    $('#jqxDelTimeOut').jqxDateTimeInput({ disabled: true});
			 
			   $("#jqxgridpayment").jqxGrid({ disabled: true});
			   $("#jqxgridtarif").jqxGrid({ disabled: true}); 
			   document.getElementById("driverUpdate").value="Edit";
			   $("#hiddrivertable").prop("hidden", false); 
			   $("#forspace").prop("hidden", true);
			}
			
			function funRemoveReadOnly(){
				
				
				 if ($("#mode").val() == "D") {
					 $('#docno').attr('disabled', false);
					 $('#txtfleetno').attr('disabled', false);
					 var valfleetno=document.getElementById("txtfleetno").value;
					 var docnos=document.getElementById("masterdoc_no").value;
							
							var x=new XMLHttpRequest();
							x.onreadystatechange=function(){
							if (x.readyState==4 && x.status==200)
								{
								
						     			
									var items=x.responseText;
									
							var chkfleet=items.trim();
							
									 if(parseInt(chkfleet)==1)
										 {
										 $.messager.alert('Message',' Transaction Found Not Deleted ','warning'); 
										 $('#docno').attr('disabled', true);
										 $('#txtfleetno').attr('disabled', true);
										 $("#mode").val("view");	
										  exit(); 
										  return 0;
										 }
									 else
										 {
										 $.messager.alert('Message','RA Is Successfully Deleted ','warning');  
									
										 $('#docno').attr('disabled', true);
										 $('#txtfleetno').attr('disabled', true);
										 $("#mode").val("D");	
										  exit(); 
										 
										 return 0;	
										 }
							
									
									}
								
							}
								
						x.open("GET","deleterantal.jsp?valfleet="+valfleetno+"&docnos="+docnos,true);

						x.send();
						exit(); 	
						}
				
				 
				  $("table#tariff input").prop("disabled", false);                /*  fleet search in after veh came grid */
				$('#frmRentalAgreement input').attr('readonly', false );
				$('#frmRentalAgreement select').attr('disabled', false);
				 $("table#tariffsub input").prop("disabled", false);
				 $("table#tariffsub input").prop("disabled", false);
				 $("#ratariffbutton").attr("disabled", false);
				 $("#searchuser").attr("disabled", false);
				// $("table#tariff input").prop("disabled", false);
				 $("table#tariff select").attr("disabled", false);
				 $("table#payment input").prop("disabled", false);
				$("table#vehicle input").prop("disabled", false);  
				$("table#driver input").prop("disabled", false);  
				$('#jqxRentalDate').jqxDateTimeInput({ disabled: false});
				$('#jqxDateOut').jqxDateTimeInput({ disabled: false});
			    $('#jqxDeliveryOut').jqxDateTimeInput({ disabled: false});
			    $('#jqxOnDate').jqxDateTimeInput({ disabled: false});
			    $('#jqxTimeOut').jqxDateTimeInput({ disabled: false});
			    $('#jqxDelTimeOut').jqxDateTimeInput({ disabled: false});
			    $('#jqxOnTime').jqxDateTimeInput({ disabled: false});
			    $('#delivery_chk').attr('disabled', false);
			    $('#radrivercheck').attr('disabled', false);
			    $("#radriverlist").prop("readonly", true);
			    $("#radriverlist").prop("disabled", true);
			    $("#delcharges").attr("disabled", true);
			    $("#jqxgrid2").jqxGrid({ disabled: false});
			 
			   $("#jqxgridpayment").jqxGrid({ disabled: false});
			   $("#jqxgridtarif").jqxGrid({ disabled: false}); 
			   $('#docno').attr('readonly', true);
				$('#jqxDeliveryOut').jqxDateTimeInput({ disabled: false});
			    $('#jqxDelTimeOut').jqxDateTimeInput({ disabled: false});
			    $('#del_Driver').attr('readonly', true );
			    $('#del_KM').attr('disabled', false);
			    $('#del_Fuel').attr('disabled', false);
			    $('#txtfleetno').attr('readonly', true);
			    $('#vehdetails').attr('readonly', true);
			    $('#txtcusid').attr('readonly', true); 
			    $('#client_Name').attr('readonly', true);
			    $('#re_salman').attr('readonly', true);
			    $('#cusaddress').attr('readonly', true);
			    $("#additional_driver").prop("disabled", false);
			    $("#adidrvcharges").prop("disabled", true);
			    $('#rasales_Agent').attr('readonly', true);
			    $('#rarenral_Agent').attr('readonly', true);
			    $('#re_Km').attr('readonly', true );
			    $('#ratariff_fuel').attr('readonly', true);
			    $('#ratariff_checkout').attr('readonly', true);
			    $('#ratariffdocno1').attr('readonly', true);
			    $('#payment_Conveh').attr('readonly', true);
			    $('#excessinsur').attr('readonly', true);
			    
			 if ($("#mode").val() == "A") {
				  $("#jqxMenuMore").css('visibility', 'hidden');   
			 		$('#jqxRentalDate').val(new Date());
					$('#jqxDateOut').val(new Date());
					$('#jqxOnDate').val(new Date());
					//
					$('#jqxOnTime').val(new Date());
					$('#jqxTimeOut').val(new Date());
					
			        $("#jqxgrid2").jqxGrid('clear');
			      $("#jqxgrid2").jqxGrid('addrow', null, {});
			      $("#jqxgrid2").jqxGrid('addrow', null, {});
			      $("#tariffDivId").load('rateDescription.jsp');
			      $("#divpaymentGrid").load("paymentdetailsgrid.jsp");
			      $("#jqxgrid2").jqxGrid({ disabled: false});
			      $("#jqxgridpayment").jqxGrid({ disabled: false});
			    // $("table#driver input").prop("disabled", true); 
			      $("#hiddrivertable").prop("hidden", true); 
			      
			      $("#forspace").prop("hidden", false);
			    	 document.getElementById("rentalstatus").innerText="";    
			     // $("#branch").prop("hidden", true);
			     
			    	 	checkconfig();
			      
			     }  
			 
			 

					 
					
				 //return 0;
			
			 
			
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
							
							 funSetlabel();
							 
						     $('#advance_chk').attr('disabled', false);
			       	           $('#invoice').attr('disabled', false);
			       	           
			       	    
			       	           
			       	           
								$('#frmRentalAgreement').submit();	
							 }
				
						
						}
					
				}
					
			x.open("GET","chkavailablefleet.jsp?valfleet="+valfleet+"&dateout="+dateout+"&timeout="+timeout,true);

			x.send();
					
			}
			 
			
			
			
			function funNotify(){	
				
					var maindate = $('#jqxRentalDate').jqxDateTimeInput('getDate');
				   var validdate=funDateInPeriod(maindate);
				   if(validdate==0){
				   return 0; 
				   }
	                  
				   var dateout = $('#jqxDateOut').jqxDateTimeInput('getDate');
				   var validdate=funDateInPeriod(dateout);
				   if(validdate==0){
				   return 0; 
				   }
				   
				 $('#jqxDeliveryOut').jqxDateTimeInput({ disabled: false});
				  
				  var valfleet=document.getElementById("txtfleetno").value;
				
					if(valfleet=="")
						{
						 document.getElementById("errormsg").innerText=" Select Vehicle  ";
						 document.getElementById("txtfleetno").focus(); 
						return 0;
						}
					else
						{
						 document.getElementById("errormsg").innerText="";
						}
					
					
					var valid2=document.getElementById("txtcusid").value;
					
					if(valid2=="")
						{
						document.getElementById("errormsg").innerText=" Select Client";
						document.getElementById("txtcusid").focus(); 
						return 0;
						}
					else{
						 document.getElementById("errormsg").innerText="";
					}
					
					
					
					
					var validdesc=document.getElementById("rentaldesc").value;
				
					
					if(validdesc!="")
						{
					
					 var nmaxs = validdesc.length;
	            		
	            		
   		           if(nmaxs>249)
   		        	   {
   		        	document.getElementById("errormsg").innerText="Description Cannot Contain More Than 250 Characters";
					document.getElementById("rentaldesc").focus(); 
   		        	   
					return 0;
						}
					else{
						 document.getElementById("errormsg").innerText="";
					   }
					
						}
					
					
					 if (document.getElementById('additional_driver').checked) {
						   
						   var addcharge=document.getElementById("adidrvcharges").value;
							
							if( addcharge=="")
								{
								document.getElementById("errormsg").innerText=" Enter Additional Driver Charge";
								document.getElementById("adidrvcharges").focus();  
								return 0;
								}
							else{
								 document.getElementById("errormsg").innerText="";
							}
					   }
					 var x = document.rentalform.adidrvcharges.value;
	                  if(isNaN(x)|| x.indexOf(" ")!=-1){
	                	  document.getElementById("errormsg").innerText=" Invalid Amount";   
	                        document.getElementById("adidrvcharges").focus();
	                        
	                        return 0;
	                        }
	                  else
	                  	{
	                  	 document.getElementById("errormsg").innerText="";
	                  	}
	                  
	             
	                  
	                  if(document.getElementById('radrivercheck').checked==false)
                	  {
                	  
          			var rows = $("#jqxgrid2").jqxGrid('getrows');
    			    var aa=0;
    			    for(var i=0;i<rows.length;i++){
    			 
    				   if(parseInt(rows[i].dr_id1)>0)
    					   {
    					   aa=1;
    					   break;
    					   }
    				   else{
    					   
    					   aa=0;
    				       } 
    	   
    			 
    			   
    			                         }
    			   
    			   
    			   
    			   if(parseInt(aa)==0)
    				   {
    				   
    					document.getElementById("errormsg").innerText=" Select Driver";
    				   
    				   return 0;
    				   
    				   }
    			   else
    				   {
    				   document.getElementById("errormsg").innerText="";
    				   }
    			   
                	  
                	  }
                  
	                  
	                  if ((document.getElementById('delivery_chk').checked)||(document.getElementById('radrivercheck').checked)) {
						   
	                	   var drvname=document.getElementById("radriverlist").value;
							
							if(drvname=="")
								{
								document.getElementById("errormsg").innerText=" Select Driver";
								document.getElementById("radriverlist").focus();  
								return 0;
								}
							else{
								 document.getElementById("errormsg").innerText="";
							}
					   }
	                  
	                  
	                
	                  
	      

	                 
	                  
	                	  var raagent=document.getElementById("rarenral_Agent").value;
	                  
	                  if(raagent=="")
						{
						document.getElementById("errormsg").innerText=" Select Rental Agent";
						document.getElementById("rarenral_Agent").focus();  
						return 0;
						}
					else{
						 document.getElementById("errormsg").innerText="";
					       }
   	                      var checkoutagent=document.getElementById("ratariff_checkout").value;
	                  
	                  if(checkoutagent=="")
						{
						document.getElementById("errormsg").innerText=" Select Checkout";
						document.getElementById("ratariff_checkout").focus();  
						return 0;
						}
					else{
						 document.getElementById("errormsg").innerText="";
					       }
	         
	                  var excessinsur=document.getElementById("excessinsur").value;
	              
					
						if(excessinsur=="")
							{
							
							document.getElementById("excessinsur").value=0;  
							
							}
						
					
						
						
									           
							          if ((document.getElementById('delivery_chk').checked)) {
											   
						                	   var delcharge=document.getElementById("delcharges").value;
												
												if(delcharge=="")
													{
													document.getElementById("errormsg").innerText="Enter Delivery Charges ";
													document.getElementById("delcharges").focus();  
													return 0;
													}
												
												else{
													 document.getElementById("errormsg").innerText="";
												}
										   }
							               
							               
							          
							               
							               
							               
				// driver grid
				var rows = $("#jqxgrid2").jqxGrid('getrows');
			    $('#drivergridlength').val(rows.length);
			   //alert($('#gridlength').val());
			   for(var i=0;i<rows.length;i++){
			   // var myvar = rows[i].tarif; 
			    newTextBox = $(document.createElement("input"))
			       .attr("type", "dil")
			       .attr("id", "drvtest"+i)
			       .attr("name", "drvtest"+i)
			        .attr("hidden", "true");  
			    
			   newTextBox.val(rows[i].dr_id1+" :: ");
			 
			   newTextBox.appendTo('form');
				
			   
			   }
				  // tariff grid
							
						 var rows = $("#jqxgridtarif").jqxGrid('getrows');
						    $('#tariffgridlength').val(rows.length);
						   //alert($('#gridlength').val());
						   
						    for(var i=0;i<rows.length;i++){
						  
							var rowlgt= rows.length-1; 
							 
							 if(i==rowlgt)
								 {
								
							 
							
								 
								 
								 var rateval=rows[i].rate;
									
								
								if(rateval==""||typeof(rateval)=="undefined"||typeof(rateval)=="NaN")
									{
									
									document.getElementById("errormsg").innerText="Tariff Is Not Selected";  
							    	return 0;
									}
								
								
								 if(document.getElementById("configtarif").value==1)
								 {
								 
									 var kmrestval=rows[i].kmrest;
		 
									 
										if(parseFloat(kmrestval)>=0)
											{
											
											
											}
										else
											{
											document.getElementById("errormsg").innerText="KM Restrict Is Not Selected";  
									    	return 0;
											}
										
										
										 var exkmrteval=rows[i].exkmrte;
											
											
										 if(parseFloat(exkmrteval)>=0)
											{
												
												
												}
													
										 else
											 {
											 
											 document.getElementById("errormsg").innerText="Excess KM Rate Is Not Selected";  
										    	return 0;
											 }
										
										
								 
								 }  
								
								
								 }
						    }
					 
						   for(var i=0;i<rows.length;i++){
						  
							
							 //  startday starttime endday endtime
						    newTextBox = $(document.createElement("input"))
						       .attr("type", "dil")
						       .attr("id", "test"+i)
						       .attr("name", "test"+i)
						    .attr("hidden", "true");				    
						   newTextBox.val(rows[i].rentaltype+"::"+rows[i].rate+" :: "+rows[i].cdw+" :: "
								   +rows[i].pai+" :: "+rows[i].cdw1+" :: "+rows[i].pai1+" :: "+rows[i].gps+" :: "+rows[i].babyseater+" :: "+rows[i].cooler+" :: "+rows[i].kmrest+" :: "
								   +rows[i].exkmrte+" :: "+rows[i].oinschg+" :: "+rows[i].exhrchg+" :: "+rows[i].chaufchg+" :: "+rows[i].chaufexchg+" :: "+rows[i].status+" :: "
								   +rows[i].startday+" :: "+rows[i].starttime+" :: "+rows[i].endday+" :: "+rows[i].endtime);
                           
						   newTextBox.appendTo('form'); 
							
						 
						   }

					         $('#advance_chk').attr('disabled', false);
			       	           $('#invoice').attr('disabled', false);
			       	           
			       	           
			       	           
			       	           
						     
			               var checkinvoice =document.getElementById("rentaltype").value;
						   var invoicevalue=document.getElementById("invoice").value;
							
						   
				 
							  
					            /*   if(checkinvoice!="Monthly")
					              {
					          		if(invoicevalue=="2")
					          			{
					          			document.getElementById("errormsg").innerText="Rental Type is "+checkinvoice+" Change  Invoice Type" ;
					          			
					          			
					          			 if(document.getElementById("configmethod").value>0)// in client search set this value 
									           
							        	   {	
					          		  $('#advance_chk').attr('disabled', true);
					       	           $('#invoice').attr('disabled', true);
							        	   }
					       	           
					       	           
										document.getElementById("invoice").focus(); 
										return 0;
					          			}
					          		else
					          			{
					          			
					          			
					          			document.getElementById("errormsg").innerText="";
					          			}
					              }
					           
					            	 */ 
					            	 
					            	 
					            	 if(document.getElementById("configmethod").value>0) // in client search set this value 
								           
						        	   {
					            	 
					            
							            	 if(checkinvoice=="Monthly")
								              { 
							            		 
							         
									            		  if(document.getElementById("advchkval").value!=document.getElementById("advance_chk").value)
									            			  {
									            			  
									            			  document.getElementById("errormsg").innerText="Please check the client invoice rule";
									            			return 0;
									            			  }
						            		  
						            	 
						            		  
								            		  
								            		  if(document.getElementById("invval").value!=document.getElementById("invoice").value)
							            			  {
							            			  
								            			  document.getElementById("errormsg").innerText="Please check the client invoice rule";
								            			  return 0;
							            			  }
						            		  
						            		  }
					            	 
						        	   }
					            	 
					            	 
					            	  if(checkinvoice!="Monthly")
						              {
					            		  
					            		
					            		
				            		  
					            	 
						              }
						           
						             
					                
					            	 
							
						   var rows = $("#jqxgridpayment").jqxGrid('getrows');
						   
						   var cardnum="";
						   var cardtype="";
						
						   for(var i=0 ; i < rows.length ; i++){
						    	
						 
							
						    if(rows[i].mode=="CARD"||rows[i].mode=="CASH")
				    		{
						    
			     	  
			     	 	    if(rows[i].amount==""||rows[i].amount=="0.00"||typeof(rows[i].amount)=="undefined"||typeof(rows[i].amount)=="NaN")
				    		
							{
							document.getElementById("errormsg").innerText="Enter Amount In   "+rows[i].payment;  
					    	return 0;
							}
				    		} 
				     	     
							 if(rows[i].mode=="CARD")
								 {
						
								
								 cardtype=rows[i].card;
								 cardnum=rows[i].cardno;
						
						
								 if(!(cardtype=="MASTER"||cardtype=="VISA"))
									{
							
									document.getElementById("errormsg").innerText="Select Card Type In "+rows[i].payment;  
							    	return 0;
									}
								 else {
									 
								  }
								
							
								if(cardnum==""||typeof(cardnum)=="undefined"||typeof(cardnum)=="NaN")
									{
							
									document.getElementById("errormsg").innerText="Enter Card NO In  "+rows[i].payment;  
							    	return 0;
									}
								else
									{
									
									}
								
								var str = ""+cardnum;
								var n = str.length;
						
								if(n!=16)
								{
							
								document.getElementById("errormsg").innerText="Invalid Card Number In  "+rows[i].payment;  
						    	return 0;
								}
							else
								{
								
								}
								
								 }
								
						    }
						   
			 
						    var rows = $("#jqxgridpayment").jqxGrid('getrows');
						    $('#paymentgridlength').val(rows.length);
						   //alert($('#gridlength').val());
						   for(var i=0 ; i < rows.length ; i++){
						   // var myvar = rows[i].tarif; 
						    newTextBox = $(document.createElement("input"))
						       .attr("type", "dil")
						       .attr("id", "paytest"+i)
						       .attr("name", "paytest"+i)
						        .attr("hidden", "true");
						   
						    newTextBox.val(rows[i].payment+"::"+rows[i].mode+" :: "+rows[i].amount+" :: "
									   +rows[i].acode+" :: "+rows[i].cardno+" :: "+rows[i].hidexpdate+" :: "+rows[i].card+" :: "+rows[i].cardtype+" :: "+rows[i].paytype+" :: "
									   +rows[i].invno+" :: "+rows[i].status+" :: ");
						 
						   newTextBox.appendTo('form');
						  
						    
						   }   
						   
					   
						   var valfleetno=document.getElementById("txtfleetno").value;
							var dateout=$('#jqxDateOut').val();
							var timeout=$('#jqxTimeOut').val();
							chkavailable(valfleetno,dateout,timeout);
							
							
				

		    		   
		       } 
			

	
			
			function funSearchLoad(){
				changeContent('masterSearch.jsp', $('#window'));
			}
					
		     function funFocus(){
		    	 document.getElementById("txtfleetno").focus();  
		    	
			 }
				 
			function replacement(){
			  	if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	             $('#window1').jqxWindow('open');
	             menuContent('vehReplaceGrid.jsp?docnovals='+document.getElementById("masterdoc_no").value, $('#window1')); 
			  	}
			  	 else {
		    	      $.messager.alert('Message','Select a Document....!','warning');
		    	      return false;
		    	     }
	        }
	        
	        function fine(){
	          	if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	        	 $('#window1').jqxWindow('open');
	             menuContent('trafficFines.jsp?docnovals='+document.getElementById("masterdoc_no").value, $('#window1'));   
	          	}
	          	 else {
		    	      $.messager.alert('Message','Select a Document....!','warning');
		    	      return false;
		    	     }
	       }
	        
	        function account(){
	          	if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	        	 $('#window1').jqxWindow('open');
	             menuContent('accountsmainForm.jsp?docnovals='+document.getElementById("masterdoc_no").value, $('#window1')); 
	          	}
	          	 else {
		    	      $.messager.alert('Message','Select a Document....!','warning');
		    	      return false;
		    	     }
	       }
	        
	        function closing(){
	        	if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	 	    	   var url=document.URL;
	 	           var reurl=url.split("saveRentalAgreement");
	 	           $("#docno").prop("disabled", false);                
		
	 	           var win= window.open(reurl[0]+"printRAClosingSummary?docno="+document.getElementById("masterdoc_no").value,"_blank","top=85,left=150,Width=1020,Height=600,location=no,scrollbars=no,toolbar=yes");
			 	   win.focus();
	 	    	   } 
	 	    	  
	 	    	   else {
	 		    	      $.messager.alert('Message','Select a Document....!','warning');
	 		    	      return false;
	 		    	     } 
	        }
	        
	        
	         
	        
	        
	        
	        
	        
	        
	        
	        
	        
	        
	    	function funChkButton(){

				frmRentalAgreement.submit();		
			}
		
	      
	    
	    	   
	    	   function funaddidriverview(){
	  	    
		    	   if (document.getElementById('additional_driver').checked) {
		    		   $("#adidrvcharges").prop("disabled", false);
		    		   document.getElementById('adidrvcharges').value="";
		    		  
		    		   
		    		
		    	   }	else
		    		   
		    		   {   
		    		   $("#adidrvcharges").prop("disabled", true);
		    		
		    		   document.getElementById('adidrvcharges').value="";
		    		  
		    		   } 
		                }
	    	  
	       
	       function fundriverdisable(){
	    	 
	    	   if (document.getElementById('delivery_chk').checked) {
	    		   
	    		   document.getElementById("radriverlist").value="";
	    		   $("#radriverlist").prop("disabled", false);
	    		   $("#jqxgrid2").jqxGrid({ disabled: false});
	    		   $("#delcharges").attr("disabled", false);
	    		   document.getElementById("radrivercheck").checked = false;
	    		   $("#radrivercheck").prop("disabled", true);
	    		  
	    	   }	else
	    		   
	    		   {   
	    		   $("#radriverlist").prop("disabled", true);
	    		   $("#jqxgrid2").jqxGrid({ disabled: false});
	    		   $("#radrivercheck").prop("disabled", false);
	    		   $("#delcharges").attr("disabled", true);
	    		   document.getElementById('radriverlist').value="";
	    		   document.getElementById('del_Driver').value="";
	    		   document.getElementById("del_chaufferid").value="";
	    		   document.getElementById("delcharges").value="";
	    		 
	    			   
	    		   
	    		   } 
	                }
	    
	       
           function funShaffurdisable(){
        	  
        	    if (document.getElementById('radrivercheck').checked) {
        	    	document.getElementById("radriverlist").value="";
        	    	 document.getElementById("fordrivervali").value="";
        		   $("#radriverlist").prop("disabled", false);
        		   document.getElementById("delivery_chk").checked = false;
	     		   $("#delivery_chk").prop("disabled", true);
	     		  $("#delcharges").attr("disabled", true);
	     		 document.getElementById("delcharges").value="";
	     		   $("#jqxgrid2").jqxGrid('clear');
				      $("#jqxgrid2").jqxGrid('addrow', null, {});
				      $("#jqxgrid2").jqxGrid('addrow', null, {});
				      $("#jqxgrid2").jqxGrid({ disabled: true});   
	     		   
	     		   document.getElementById("errormsg").innerText="";
	     		
	     		
        	   }
        	   else
        		   {
        		   $("#radriverlist").prop("disabled", true);
	    		   $("#jqxgrid2").jqxGrid({ disabled: false});
	    		   $("#delivery_chk").prop("disabled", false);
	    		   document.getElementById('radriverlist').value="";
	    		   document.getElementById('del_Driver').value="";
	    		   document.getElementById("del_chaufferid").value="";
	    		 
        		   }
           }
           
      
          function  funchkKm()
          {
        	  $("#re_Km").prop("disabled", false);
        		var outkm=document.getElementById("re_Km").value;
        		//alert("out"+outkm);
        	 	var delkm=document.getElementById("del_KM").value;
        	   if((parseFloat(delkm)<parseFloat(outkm)))
        		   
        	 	
        	 	{
        		  
        		   document.getElementById("errormsg").innerText="Delivery KM Less Than Out KM";  
        		   $("#re_Km").prop("disabled", true);
        		   return 0;
        	 	}
        	   else
        		   {
        		   document.getElementById("errormsg").innerText="";  
        		   $("#re_Km").prop("disabled", true);
        		   }
        	  
          }

          function funchkDelStatus()
                  {
       	   var masterdoc=document.getElementById("masterdoc_no").value;
       	  
       	var x=new XMLHttpRequest();
      
       	
       	x.onreadystatechange=function(){
       	if (x.readyState==4 && x.status==200)
       		{
       		 	var items= x.responseText;
       		 		 if(items>0)
       		 		{
       		 		 $.messager.alert('Message',' Already Edited ','warning');   
       		 		
       		 			return  0;
       		 		}
       		 		 else
       		 			 {
       		 			document.getElementById("errormsg").innerText="";
       			       	  $("table#driver input").prop("disabled", false);  
	        		   $("table#driver select").prop("disabled", false);  
		        	    
		        	    $('#jqxDeliveryOut').val(new Date());
		           	    $('#jqxDelTimeOut').val(new Date());
		        	    document.getElementById("del_Fuel").value="";
		        	    document.getElementById("del_KM").value="";
		        	    $('#del_Driver').attr('readonly', true );
		        	    $('#del_KM').attr('readonly', false);
					    $('#del_KM').attr('disabled', false);
					    $('#del_Fuel').attr('disabled', false);
						$('#jqxDeliveryOut').jqxDateTimeInput({ disabled: false});
					    $('#jqxDelTimeOut').jqxDateTimeInput({ disabled: false});
				
					    document.getElementById("driverUpdate").value="Update";
					    document.getElementById("mode").value='ADD';
					    return 0;
       		 			 }
       		 		
       		 }
       	       else
       		  {
       	    	   
       		  }
           }
       	x.open("GET", 'checkUpdate.jsp?masterdocno='+masterdoc, true);
           x.send();
       	}  
          
          
   
          
	         function funupdate()
	         {
	        	 
	        	 if(document.getElementById("driverUpdate").value=="Edit")
	        		 {
	        		  if(document.getElementById("delchkvalue").value==1)
	        			  {
	        			  funchkDelStatus();
	        
	        			  }
	        		  else
	        			  {
	        			  $.messager.alert('Message',' Delivery Update Need Not Be Entered ','warning');   
	        				  
	        			  }
					   return 0;
	        		 }
	        	 else if(document.getElementById("driverUpdate").value=="Update")
      		        {
	        		
	        	
	        		 if(document.getElementById("del_KM").value=="")
	        		 {
	        			 document.getElementById("errormsg").innerText="Enter KM";	 
	        			 document.getElementById("del_KM").focus();
	        			 return false;
	        		 }
	        		 else
	        			 {
	        			 document.getElementById("errormsg").innerText="";
	        			 }
	        		 if($('#del_Fuel').val()=="")
	        		 {
	        			 document.getElementById("errormsg").innerText=" Select Fuel";	
	        			 document.getElementById("del_Fuel").focus();
	        			 return false;
	        		 }
	        		 else
	        			 {
	        			 document.getElementById("errormsg").innerText="";
	        			 }
	        		 $("#re_Km").prop("disabled", false);
	        	   	var outkm=document.getElementById("re_Km").value;
	        	 	var delkm=document.getElementById("del_KM").value;
	        	 	
	        	    if((parseFloat(delkm)<parseFloat(outkm)))
	        		   
	        	 	
	        	 	{
	        		  
	        		   document.getElementById("errormsg").innerText="Delivery KM Less Than Out KM";  
	        		   $("#re_Km").prop("disabled", true);
	        		   return 0;
	        	 	}
	        	   else
	        		   {
	        		   
	        		   document.getElementById("errormsg").innerText="";  
	        		   $("#re_Km").prop("disabled", true);
	        		   }
	        	    
	        	
					  var indate1=new Date($('#jqxDateOut').jqxDateTimeInput('getDate'));     // out date
					  var agmtdate1=new Date($('#jqxDeliveryOut').jqxDateTimeInput('getDate')); //del date
					 
					  var intime1=new Date($('#jqxTimeOut').jqxDateTimeInput('getDate'));  //out time
					  var agmttime1=new Date($('#jqxDelTimeOut').jqxDateTimeInput('getDate')); // del time  
				
					  indate1.setHours(0,0,0,0);
					  agmtdate1.setHours(0,0,0,0);
					   if(indate1>agmtdate1){
					   document.getElementById("errormsg").innerText="Delivery Date Cannot be Less than Out Date";
					   return 0;
					  }   
					
					   if(indate1.valueOf()==agmtdate1.valueOf()){
					 
					  var out=intime1.getHours();
					  var del=agmttime1.getHours();
					
					  if(out > del){
						   
					    document.getElementById("errormsg").innerText="Delivery Time Cannot be Less than Out Time";
					    return 0;
					   }
					   if(out==del){
					    if(intime1.getMinutes()>agmttime1.getMinutes()){
					     document.getElementById("errormsg").innerText="Delivery Time Cannot be Less than Out Time";
					     return 0;
					    }
					   }
					  }
					  
					   document.getElementById("errormsg").innerText="";  
	        	 
					   $.messager.confirm('Confirm', 'Do you want to save changes?', function(r){
							if (r==false){
								
								return 0;
							}
							else
								{
	        		  funSetlabel();  
	   			

    	        $('#frmRentalAgreement txtfleetno').attr('disabled', false);
                $('#frmRentalAgreement txtcusid').attr('disabled', false);
                $('#frmRentalAgreement docno').attr('disabled', false); 
                $("table#vehicle input").prop("disabled", false);  
	   			$('#jqxRentalDate').jqxDateTimeInput({ disabled: false});
				$('#jqxDateOut').jqxDateTimeInput({ disabled: false});
		        $('#jqxDeliveryOut').jqxDateTimeInput({ disabled: false});
		        $('#jqxOnDate').jqxDateTimeInput({ disabled: false});
		        $('#jqxTimeOut').jqxDateTimeInput({ disabled: false});
		        $('#jqxDelTimeOut').jqxDateTimeInput({ disabled: false});
		        $('#jqxOnTime').jqxDateTimeInput({ disabled: false});
		        $('#frmRentalAgreement select').attr('disabled', false);
				$("table#tariffsub input").prop("disabled", false);
				 $("table#tariff input").prop("disabled", false);
				 $("table#tariff select").attr("disabled", false);
				 $("table#payment input").prop("disabled", false);
				$("table#vehicle input").prop("disabled", false);  
				$("table#chauffer input").prop("disabled", false);  
				$('#frmRentalAgreement').submit();
								}
				
				
      		       
      		      });
      		      }
	           }
	    
	    
           function checkReqveh()
            {  
   		 
			               if(document.getElementById("txtfleetno").value=="")
			                	
			           		{ 
			            	  document.getElementById("errormsg").innerText="  Select Vehicle";
			            	  document.getElementById("txtfleetno").focus();
			            	  $('#txtcusid').attr('disabled', true);
			            	 	            	              		          	  
			          		} 
			             
           	}
           
           function checkReqclient()
           {
        	   if(document.getElementById("txtcusid").value=="")
        		  
			                	
			           		{ 
        		   document.getElementById("delivery_chk").checked = false;
            	   document.getElementById("radrivercheck").checked = false;
        		   
        		   if(document.getElementById("txtfleetno").value=="")
			                	
			           		{ 
			            	  document.getElementById("errormsg").innerText="  Select Vehicle";
			            	  document.getElementById("txtfleetno").focus();
			            	  $('#txtcusid').attr('disabled', true);
			            	  $('#delivery_chk').attr('disabled', true);
			       	           $('#radrivercheck').attr('disabled', true);
			       	            $("table#tariffsub input").prop("disabled", true); 
			            	  return false;
			            	 	            	              		          	  
			          		    } 
			           		else{
				        		   document.getElementById("txtcusid").focus();
				       	        
				       	            $('#delivery_chk').attr('disabled', true);
				       	           $('#radrivercheck').attr('disabled', true);
				       	            $("table#tariffsub input").prop("disabled", true); 
				        		   document.getElementById("errormsg").innerText="  Select Client";
				        		   return false;
			           		}
			          		}  
           	}
        
         /* function fundriverreq()
         {
        	 
        	  if(document.getElementById("fordrivervali").value=="")
             	
        		{ 
        		  if (document.getElementById('delivery_chk').checked) {
        	    	  document.getElementById("errormsg").innerText="  Select Client Driver"; 
         	          $("table#tariffsub input").prop("disabled", true); 
         	         return false;     		            	              		          	  
        		       }
        		}
        	  
      
        	  
        	if(document.getElementById("radriverlist").value=="")
        		{
        		   document.getElementById("radriverlist").focus();
        		document.getElementById("errormsg").innerText="  Select A Driver "; 
        	    $("table#tariffsub input").prop("disabled", true); 
        		
        		}
            }
   */
      
      /*     function funsalagentreqs()
         {
        	
        	  if(document.getElementById("rasales_Agent").value=="")
             	
        		{ 
        		  document.getElementById("rasales_Agent").focus();
        		   $('#rarenral_Agent').attr('disabled', true);
         	       $('#ratariff_checkout').attr('disabled', true);
        		  document.getElementById("errormsg").innerText="  Select Sales Agent";
       		}  
         } 
          */
           function  checkReqrental() 
         {
        	 if(document.getElementById("rarenral_Agent").value=="")
             	
        		{ 
        		 document.getElementById("rarenral_Agent").focus();
      	        
       	       $('#ratariff_checkout').attr('disabled', true);
        		 document.getElementById("errormsg").innerText="  Select Rental Agent";  	 
         	              		          	  
       		}  
         } 
          function delvalueChange()
          {
        	  if ($("#mode").val() == "view") { 
        		 if(document.getElementById("delchkvalue").value==1)
          		  {
        			 $("#driverUpdate").attr("disabled", false); 
          		  }
        		 else
        			 {
        			 $("#driverUpdate").attr("disabled", true);
        			 }
        	  }
        //	alert(document.getElementById("delchkvalue").value);
        	  if(document.getElementById("delchkvalue").value==1)
        		  {
        		  document.getElementById("delivery_chk").checked = true;
        		  document.getElementById("delivery_chk").value = 1;
        		  if ($("#mode").val() == "A") {   
        		  $('#radriverlist').attr('disabled', false);
        		  $("#delcharges").attr("disabled", false);
        		  }
        		 
        		  }
        	  
        	  else if(document.getElementById("chaffchkvalue").value==1)
        		  {
        		  document.getElementById("radrivercheck").checked = true;
        		  document.getElementById("radrivercheck").value = 1;
        		  if ($("#mode").val() == "A") {   
        		  $('#radriverlist').attr('disabled', false);
        		
        		  }
        		  }
        	  else
        		  {
        		 /*  document.getElementById("radrivercheck").checked = false; */
        		  $('#radriverlist').attr('disabled', true);
        		  }
        	  if(document.getElementById("add_drchk").value==1)
    		  {
    		  document.getElementById("additional_driver").checked = true;
    		  document.getElementById("additional_driver").value=1;
    		  if ($("#mode").val() == "A") {   
    		  $('#adidrvcharges').attr('disabled', false);
    		  }
    		  }
    	  else
    		  {
    		  document.getElementById("additional_driver").checked = false;
    		  document.getElementById("additional_driver").value=0;
    		  $('#adidrvcharges').attr('disabled', true);
    		  }
        	 // ,invoice
        	    
    	   if($('#systemval').val()!="")
    		  {
    		  
    		  
    		  $('#ratariffsystem').val($('#systemval').val());
    		  }
    	   if($('#invoval').val()!="")
 		  {
 		  
 		 
 		  $('#invoice').val($('#invoval').val());
 		  }
    	   
    	   if($('#hiddel_Fuel').val()!="")
  		  {
  		  
  		 
  		  $('#del_Fuel').val($('#hiddel_Fuel').val());
  		  }
    	   
         
          if(document.getElementById("advance_chkval").value==1)
		  {
		  document.getElementById("advance_chk").checked = true;
		  document.getElementById("advance_chk").value=1;
		
		  }
	  else
		  {
		  document.getElementById("advance_chk").checked = false;
		  document.getElementById("advance_chk").value=0;
		
		  }
           
          
          
          if(document.getElementById("weekendval").value==1)
		  {
		  document.getElementById("weekend").checked = true;
		  document.getElementById("weekend").value=1;
		
		  }
	  else
		  {
		  document.getElementById("weekend").checked = false;
		  document.getElementById("weekend").value=0;
		
		  }
          
          }

	      function setValues() {
	    	 
        	  var maindoc=document.getElementById("masterdoc_no").value;
        	  if(maindoc>0)
        		  {
        	 
               var indexVal1 = document.getElementById("masterdoc_no").value;
               var revehGroup=document.getElementById("veh_fleetgrouptariff").value;
            	  
              $("#tariffDivId").load('rateDescription.jsp?txtrentaldocno='+indexVal1+'&revehGroup='+revehGroup);
              
              var indexVal2 = document.getElementById("masterdoc_no").value;
          	  
              $("#divDrivGrid").load("driverGrid.jsp?txtrentaldocno1="+indexVal2);
            
                   var indexVal3 = document.getElementById("masterdoc_no").value;
        	 
              $("#divpaymentGrid").load("paymentdetailsgrid.jsp?txtrentaldoc="+indexVal3);
        		  }
	        		
        	  
	     	  // main
		    		if($('#hidjqxRentalDate').val()){
		    			$("#jqxRentalDate").jqxDateTimeInput('val', $('#hidjqxRentalDate').val());
		    		}
	    		// tariff OUT date
		    		if($('#hidjqxDateOut').val()){
		    			$("#jqxDateOut").jqxDateTimeInput('val', $('#hidjqxDateOut').val());
		    		}
	    		// tariff OUT time
			    		if($('#hidjqxTimeOut').val()){
			    			
			    			$("#jqxTimeOut").jqxDateTimeInput('val', $('#hidjqxTimeOut').val());
			    		}
	    		// tariff DUE date
		    		if($('#hidjqxOnDate').val()){
		    			$("#jqxOnDate").jqxDateTimeInput('val', $('#hidjqxOnDate').val());
		    		}
	    		// tariff DUE time
			    		if($('#hidjqxOnTime').val()){
			    			$("#jqxOnTime").jqxDateTimeInput('val', $('#hidjqxOnTime').val());
			    		}
	        	// delivery date
		    		if($('#hidjqxDeliveryOut').val()){
		    			$("#jqxDeliveryOut").jqxDateTimeInput('val', $('#hidjqxDeliveryOut').val());
		    		}
		        	    	        	
	        	//deivery time
	        	
			    		if($('#hidjqxDelTimeOut').val()){
			    			$("#jqxDelTimeOut").jqxDateTimeInput('val', $('#hidjqxDelTimeOut').val());
			    		} 
		        	
	        
	        	   if($('#msg').val()!=""){
	        		   $.messager.alert('Message',$('#msg').val());
	        		  }
	        	 delvalueChange();
	        
	        	 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	        	 funSetlabel();
	        }
	/*       function funchknumber()
          {
                  var x = document.rentalform.adidrvcharges.value;
                  if(isNaN(x)|| x.indexOf(" ")!=-1){
                      //  alert("Enter numeric value");
                        document.getElementById("errormsg").innerText=" Invalid Amount";   
                        document.getElementById("adidrvcharges").focus();
                        return false;
                        }
                  else
                  	{
                  	 document.getElementById("errormsg").innerText="";
                  	}
                 
                     
          } */
	     
	       
	       function funPrintBtn(){
	    	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	    	  
	    	      
	    	   var url=document.URL;

	           var reurl=url.split("saveRentalAgreement");
	           
	           $("#docno").prop("disabled", false);                
	           
	     
	   var win= window.open(reurl[0]+"printRA?docno="+document.getElementById("masterdoc_no").value+"&formdetailcode=RAG","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	        
	   win.focus();
	    	   } 
	    	  
	    	   else {
		    	      $.messager.alert('Message','Select a Document....!','warning');
		    	      return false;
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
	       
	    function fundescvalidate()
	    {
	    	var validdescs=document.getElementById("rentaldesc").value;
			
			if(validdescs!="")
				{
			
			 var nmaxs = validdescs.length;
        		
        		
	           if(nmaxs>249)
	        	   {
	        	document.getElementById("errormsg").innerText="Description Cannot Contain More Than 250 Characters";
			document.getElementById("rentaldesc").focus(); 
	        	   
			return 0;
			     }
			else{
				 document.getElementById("errormsg").innerText="";
			   }
			
			
				}
	    }
 </script>
    
<style>
.hidden-scrollbar {
  /* // overflow: auto; */
  height: 530px;
    overflow-x: hidden;
    
} 

</style>  

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmRentalAgreement" action="saveRentalAgreement" name="rentalform" method="post"  autocomplete="off">

<jsp:include page="../../../../header.jsp"></jsp:include><br/> 

<div class='hidden-scrollbar'>
   
      <table  width="100%" id="vehicle">
      
      <tr width="100%">        
      <td width="80%">
       <fieldset>
<table  >             
  <tr>

     <td width="10%" align="right">  <label ><font size="2">Vehicle </font></label></td>
  <td width="8%"> <input type="text" id="txtfleetno" name="txtfleetno" placeholder="Press F3 To Search" value='<s:property value="txtfleetno"/>' onKeyDown="getvehinfo(event);"  />
  </td>
     <td width="80%" ><input type="text" id="vehdetails" name="vehdetails" style="width:96.5%;" tabindex="-1" value='<s:property value="vehdetails"/>' />
  
     </td>
 </tr><tr>
  <td width="10%" align="right">  <label ><font size="2">Client</font></label></td>
  <td width="8"> <input type="text" id="txtcusid" name="txtcusid" placeholder="Press F3 To Search" value='<s:property value="txtcusid"/>' onKeyDown="getclientinfo(event);" onfocus="checkReqveh();"/></td>
     <td width="80%" ><input type="text" id="client_Name" name="client_Name" style="width:50%;" tabindex="-1" value='<s:property value="client_Name"/>'/>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label>Salesman</label>
 <input type="text" id="re_salman" name="re_salman" style="width:25%;" placeholder="Salesman Name"value='<s:property value="re_salman"/>'/>
 
 <input type="hidden" id="re_salmanid" name="re_salmanid" style="width:25%;"  value='<s:property value="re_salmanid"/>'/>
 <input type="hidden" id="re_clcodeno" name="re_clcodeno" style="width:25%;"  value='<s:property value="re_clcodeno"/>'/>
 <input type="hidden" id="re_clacno" name="re_clacno" style="width:25%;"  value='<s:property value="re_clacno"/>'/>
 </td>
  </tr>
  <tr>
  <td align="right"></td><td colspan="2" width="60%"><input type="text" id="cusaddress"  placeholder="Mobil NO-Address" name="cusaddress" style="width:97%; resize: none; " value='<s:property value="cusaddress"/>'></td>
  </tr>
   <tr>
  <td align="right"><label ><font size="2">Description</font></label></td><td colspan="2" width="60%"><input type="text" id="rentaldesc"  placeholder="Description" name="rentaldesc" style="width:97%; resize: none; " value='<s:property value="rentaldesc"/>' onblur="fundescvalidate()"></td>
  </tr>
   </table>

</fieldset>
</td> <td width="20%"> 
<table width="100%"  >
  <tr width="100%">    
    <td width="20%" align="right">Doc No</td>
    <td ><input type="text" id="docno" name="docno" style="width:90%;" tabindex="-1" value='<s:property value="docno"/>'/></td>
   &nbsp; &nbsp;
<td><div id='jqxMenuMore' title="More" align="center" style='visibility: hidden;'>
        <ul>
 
         <li><a href="#trafficFines" onclick="fine();">Traffic Fines</a></li>
       	    <li><a href="#documents" onclick="replacement();">Replacement</a></li>
            <li><a href="#history" onclick="account();">Account Statement</a></li>  
            <li><a href="#close" onclick="closing();">Closing Summary</a></li>               
        </ul>
     </div>
     </td>
   </tr>
   <tr>
   <td width="15%" align="right">Date</td>
    <td width="23%"><div id='jqxRentalDate' name='jqxRentalDate' value='<s:property value="jqxRentalDate"/>'></div>
                   <input type="hidden" id="hidjqxRentalDate" name="hidjqxRentalDate" value='<s:property value="hidjqxRentalDate"/>'/></td>
        </tr>
        <tr>
       <td></td> <td align="center"><i><b><label id="rentalstatus"  name="rentalstatus"   style="font-size: 13px;font-family: Tahoma; color:#6000FC"><s:property value="rentalstatus"/></label></b></i></td></tr>
    </table>
</td></tr></table>

  <fieldset>
<legend>Driver Details</legend>
<table  width="100%">
<tr>
<td width="11%">
<table id="chauffer">
<tr><td>
<font size="1.5">Additional Driver</font>  
<input type="checkbox" id="additional_driver"  name="additional_driver" value="0" onchange="funaddidriverview()" onclick="$(this).attr('value', this.checked ? 1 : 0)"></td></tr><tr><td>
<font size="1.5">Charge</font>&nbsp;&nbsp;&nbsp;<input type="text" id="adidrvcharges"  style="width:60%;text-align: right;" name="adidrvcharges"value='<s:property value="adidrvcharges"/>' onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);"   >
</td></tr><tr>
<td><font size="1.5">Delivery</font>

<input type="checkbox" id="delivery_chk"  name="delivery_chk" value="0"  onchange="fundriverdisable()" onfocus="checkReqclient()"  onclick="$(this).attr('value', this.checked ? 1 : 0)" >
<font size="1.5">Chauffeur</font>

<input type="checkbox"  id="radrivercheck"  name="radrivercheck" value="0" onchange="funShaffurdisable()" onfocus="checkReqclient()" onclick="$(this).attr('value', this.checked ? 1 : 0)"></td>
</tr>
<tr><td><input type="text" id="radriverlist"  name="radriverlist"  placeholder="Press F3 To Search" value='<s:property value="radriverlist"/>' onKeyDown="getchauffeur(event);" />
 <input type="hidden" id="del_chaufferid" name="del_chaufferid"  value='<s:property value="del_chaufferid"/>'/>
    
<input type="hidden" id="client_driverid" name="client_driverid"  value='<s:property value="client_driverid"/>'/>
    <input type="hidden" id="client_driverdoc" name="client_driverdoc"  value='<s:property value="client_driverdoc"/>'/>
                           
</td></tr>
</table>
</td>
<td width="89%">

<table width="100%" id="driverGrid">
<tr><td>
      <div id="divDrivGrid">
  <jsp:include page="driverGrid.jsp"></jsp:include></div>
</td>
  </tr>
</table>
</td>

</tr>
    </table>
    
    <table id="tariffsub"><tr>
 <td  align="right" width="6%" >Sales Agent</td>
    <td  width="8%">
            <input type="text" id="rasales_Agent" name="rasales_Agent"  placeholder="Press F3 To Search"  value='<s:property value="rasales_Agent"/>' onKeyDown="getsalesAgent(event);" />
            <input type="hidden" id="tariffsales_Agentid" name="tariffsales_Agentid" value='<s:property value="tariffsales_Agentid"/>'/>    
                      
            </td>
            
            <td align="right"  width="6%"> Rental Agent </td>
           
    <td colspan="6"  width="10%"><input type="text" id="rarenral_Agent" name="rarenral_Agent" style="width:99%;" placeholder="Press F3 To Search"  value='<s:property value="rarenral_Agent"/>' onKeyDown="getrentalAgent(event);" onfocus="this.placeholder = ''"/>
    <input type="hidden" id="tariffrenral_Agentid" name="tariffrenral_Agentid" style="width:95%;" value='<s:property value="tariffrenral_Agentid"/>'/>
        </td>
<td align="right" width="6%" > OUT :   KM </td>
 <td colspan="6"  width="6%" ><input type="text" id="re_Km" name="re_Km" style="width:95%;" value='<s:property value="re_Km"/>'/></td>
<td align="right"  width="2%">Date</td>
    <td width="6%"><div id='jqxDateOut' name='jqxDateOut' value='<s:property value="jqxDateOut"/>'></div>
                    <input type="hidden" id="hidjqxDateOut" name="hidjqxDateOut" value='<s:property value="hidjqxDateOut"/>'/></td>
    <td  width="3%"align="right"><div >Time</div></td>
    <td width="5%"><div id='jqxTimeOut' name='jqxTimeOut'  value='<s:property value="jqxTimeOut"/>'></div>
                   <input type="hidden" id="hidjqxTimeOut" name="hidjqxTimeOut" value='<s:property value="hidjqxTimeOut"/>'/></td>
   <td  width="2%" align="right"><div >Fuel</div></td>
    <td colspan="6" width="11%" ><input type="text" id="ratariff_fuel" name="ratariff_fuel" style="width:98%;" value='<s:property value="ratariff_fuel"/>'/></td>
   <td align="right" width="3%"> Checkout </td>
           
    <td colspan="6" width="10%" ><input type="text" id="ratariff_checkout" placeholder="Press F3 To Search"  name="ratariff_checkout" style="width:98%;" value='<s:property value="ratariff_checkout"/>'onKeyDown="getcheckout(event);" onfocus="checkReqrental();this.placeholder = ''"/>
    <input type="hidden" id="ratariff_checkoutid" name="ratariff_checkoutid" value='<s:property value="ratariff_checkoutid"/>'/>  
    
    </td>
 <td align="right"  width="5%">Due Date</td>
    <td><div id='jqxOnDate' name='jqxOnDate' value='<s:property value="jqxOnDate"/>'></div>
        <input type="hidden" id="hidjqxOnDate" name="hidjqxOnDate" value='<s:property value="hidjqxOnDate"/>'/></td>
    <td align="right"  width="3%">Time</td>
    <td width="6%"><div id='jqxOnTime' name='jqxOnTime' value='<s:property value="jqxOnTime"/>'></div>
                   <input type="hidden" id="hidjqxOnTime" name="hidjqxOnTime" value='<s:property value="hidjqxOnTime"/>'/></td>
</tr>
</table>
    
    </fieldset>

  <fieldset>
<legend>Tariff Info</legend>
<table width="100%" id="tariff">
<tr>
<td width="10%">         

<table  width="100%">
<tr><td colspan="2" align="center"><input type="checkbox" id="weekend"  hidden="true" name="weekend" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" ><label id="weekend1" hidden="true">Weekend</label> &nbsp;<button type="button"  title="Search Tariff"  class="icon" id="ratariffbutton"  value='<s:property value="ratariffbutton"/>'>
					 <img alt="tariffSearch" src="<%=contextPath%>/icons/tariffsearch.png"> 
					</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button type="button"  title="Search User"  class="icon" id="searchuser"  value='<s:property value="searchuser"/>'>
					 <img alt="Search User" src="<%=contextPath%>/icons/searchusers.png"> 
					</button></td></tr>
<tr><td width="4%">DOCNO</td><td width="1%"><input type="text" id="ratariffdocno1"  name="ratariffdocno1"   value='<s:property value="ratariffdocno1"/>' >
</td></tr>
<tr><td width="4%">Ins.Excess</td><td width="1%"><input type="text" id="excessinsur"  name="excessinsur" style="text-align: right;"  value='<s:property value="excessinsur"/>' onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);" ></td></tr>
<tr><td width="4%">Advance</td><td><input type="checkbox" id="advance_chk"  name="advance_chk" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" > </td></tr>
<tr><td width="4%">Invoice</td><td><select name="invoice" id="invoice" style="width:100%;"  value='<s:property value="invoice"/>'  >
  <option value="1">Month End</option>
  <option value="2">Period</option>
  
</select></td></tr> 
<tr><td>Delivery Charges </td><td><input type="text" id="delcharges"  name="delcharges"   style="text-align: right;"  value='<s:property value="delcharges" />' onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event)" ></td>  </tr>
</table>
</td>
<td width="90%">
<table width="100%">
<tr><td>
        <div id="tariffDivId">
  			 <jsp:include  page="rateDescription.jsp"></jsp:include> 
  		 </div> 
</td>
  </tr>
</table>
</td></tr>    </table>
     </fieldset>


    <fieldset>
      <legend>Payment Info</legend>

<table width="99%" id="payment">
<tr>

<td width="80%">
<table width="100%" >
<tr><td>
      <div id="divpaymentGrid"> <jsp:include page="paymentdetailsgrid.jsp"></jsp:include> </div> 
           
 </td>
  </tr>
</table>
</td>
<td width="20%" >
<table>
<tr>
<td align="right">Manual RA NO</td><td><input type="text" id="payment_Mra"  name="payment_Mra" value='<s:property value="payment_Mra"/>'></td>
</tr>
<tr>
<td align="right"> LPO</td><td><input type="text" id="payment_PO"  name="payment_PO" value='<s:property value="payment_PO"/>'></td>
</tr><tr>
<td align="right">Contract vehicle</td><td><input type="text" id="payment_Conveh"  name="payment_Conveh" value='<s:property value="payment_Conveh"/>'>
</td>
</tr>
</table>
</td>
</tr>
</table>
 </fieldset>
  <DIV id="forspace" hidden="true">
 <br><br><br><br>
 </DIV> 
<div id="hiddrivertable">
 <fieldset>
      <legend>Delivery Details</legend>
 <table width="100%" >
 <tr><td width="3%"></td>
 <td width="7%">
 
 </td>
 <td width="80%">
 
 <table id="driver">
 <tr>
 <td width="12%" align="center">Driver</td>
  </tr>
  <tr>
 <td width="12%"><input type="text" name="del_Driver" id="del_Driver" value='<s:property value="del_Driver"/>' >
  <input type="hidden" id="del_chaufferid2" name="del_chaufferid2"  value='<s:property value="del_chaufferid2"/>'/>
 
 </td>
 <td width="6%" align="right">KM</td> <td><input type="text" name="del_KM" id="del_KM" value='<s:property value="del_KM"/>' onblur="funchkKm()" onkeypress="javascript:return isNumber (event)"></td>
 <td width="6%" align="right">Fuel</td><td width="12%">
 <select name="del_Fuel" id="del_Fuel" style="width:98%;" name="del_Fuel" value='<s:property value="del_Fuel"/>'>
    <option value=1.000>Level 8/8</option>
    <option value=0.875>Level 7/8</option>
    <option value=0.750>Level 6/8</option>
    <option value=0.625>Level 5/8</option>
    <option value=0.500>Level 4/8</option>
    <option value=0.375>Level 3/8</option>
    <option value=0.250>Level 2/8</option>
    <option value=0.125>Level 1/8</option>
    <option value=0.000>Level 0/8</option>
    <option value="" selected>-Select-</option>   
    
       

</select></td>
 <td width="6%" align="right">Date</td><td width="16%"><div id='jqxDeliveryOut' name='jqxDeliveryOut' value='<s:property value="jqxDeliveryOut"/>' onblur="fundelDatechk()"></div>
                    <input type="hidden" id="hidjqxDeliveryOut" name="hidjqxDeliveryOut" value='<s:property value="hidjqxDeliveryOut"/>'/></td>
  <td width="3%" align="right">Time</td><td width="10%"><div id='jqxDelTimeOut' name='jqxDelTimeOut' value='<s:property value="jqxDelTimeOut"/>'  onblur="fundelTimechk()"></div>
                   <input type="hidden" id="hidjqxDelTimeOut" name="hidjqxDelTimeOut" value='<s:property value="hidjqxDelTimeOut"/>'/></td>
 <td width="30%"  align="center"><input type="Button" name="driverUpdate" id="driverUpdate" class="myButton" value="Edit" onclick="funupdate()"></td>
 </tr> </table>
   </td>
  </tr>
  </table>
   </fieldset>
</div>
<div hidden="true"><select name="ratariffsystem" id="ratariffsystem" style="width:100%;"  value='<s:property value="ratariffsystem"/>'  >
  <!-- <option value="">--Select--</option> -->
  <!-- <option value="System">System</option> -->
   <option value="Manual">Manual</option> 

  
</select></div>

<input type="hidden" id="configtarif" name="configtarif" value='<s:property value="configtarif"/>' />  <!-- for tarif -->

 <input type="hidden" id="configmethod" name="configmethod" value='<s:property value="configmethod"/>' /><!--    for client -->

 <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>' />  
  <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />  
   <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
   <input type="hidden" name="rentaltype" id="rentaltype" value='<s:property value="rentaltype"/>' />
    <input type="hidden" name="delete" id="delete" value='<s:property value="delete"/>' />
     <input type="hidden" name="fordrivervali" id="fordrivervali" value='<s:property value="fordrivervali"/>' />
     <input type="hidden" id="veh_fleetgrouptariff"  name="veh_fleetgrouptariff"   value='<s:property value="veh_fleetgrouptariff"/>'  > 
     
        <input type="hidden" id="vehlocation" name="vehlocation"  value='<s:property value="vehlocation"/>' />
     
     <input type="hidden" name="delchkvalue" id="delchkvalue" value='<s:property value="delchkvalue"/>'  />
     <input type="hidden" name="chaffchkvalue" id="chaffchkvalue" value='<s:property value="chaffchkvalue"/>'  />
     <input type="hidden" name="add_drchk" id="add_drchk" value='<s:property value="add_drchk"/>'  />
    
    <input type="hidden" name="systemval" id="systemval" value='<s:property value="systemval"/>'  /> 
     <input type="hidden" name="invoval" id="invoval" value='<s:property value="invoval"/>'  />
      <input type="hidden" name="hiddel_Fuel" id="hiddel_Fuel" value='<s:property value="hiddel_Fuel"/>'  />
     
         <input type="hidden" name="advance_chkval" id="advance_chkval" value='<s:property value="advance_chkval"/>'  /> 
                  <input type="hidden" name="weekendval" id="weekendval" value='<s:property value="weekendval"/>'  /> 
     
      <input type="hidden" name="hidvehfuel" id="hidvehfuel" value='<s:property value="hidvehfuel"/>'  />  <!-- hidden veh search fuel -->
      
      
      
      <input type="hidden" name="normalinsu" id="normalinsu" value='<s:property value="normalinsu"/>'  />
      <input type="hidden" name="cdwinsu" id="cdwinsu" value='<s:property value="cdwinsu"/>'  /> 
      <input type="hidden" name="supercdwinsu" id="supercdwinsu" value='<s:property value="supercdwinsu"/>'  />   <!-- set ex.insu by ratedescription grid cdw super cdw click else normal value set in quary -->
                                                                                                              
     
     
     
     
           <input type="hidden" name="advchkval" id="advchkval" value='<s:property value="advchkval"/>'  /> 
           <input type="hidden" name="invval" id="invval" value='<s:property value="invval"/>' />
     
     
     
    
    <input type="hidden" id="tariffgridlength" name="tariffgridlength"/>
    <input type="hidden" id="paymentgridlength" name="paymentgridlength"/> 
    <input type="hidden" id="drivergridlength" name="drivergridlength"/>
    


</div>
</form>
<div id="window1">
   <div style="background-color: #E0ECF8;"></div>
</div> 
<div id="vehinfowindow">
   <div ></div>
</div> 
 <div id="clientinfowindow">
   <div ></div>
</div>
<!-- <div id="Driverdlswindow">
   <div ></div>
</div>  -->
<div id="driverinfowindow">
   <div ></div>
</div>
<div id="chauffeurinfowindow">
   <div ></div>
</div>
<div id="tariffinbtnwindow">
   <div ></div>
</div>
<div id="Salesagentinfowindow">
   <div ></div>
</div>
<div id="Rentalagentinfowindow">
   <div ></div>
</div>
<div id="Checkoutinfowindow">
   <div ></div>
</div>
<div id="usersearchwindow">
   <div ></div>
</div>


 </div> 
 </body>
</html> 
    