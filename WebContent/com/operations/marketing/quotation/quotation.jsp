<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="java.io.*,java.util.*" %>
 <%@page import="javax.servlet.http.HttpServletRequest" %>
 <%@page import="javax.servlet.http.HttpServletResponse" %>
<%@page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<% String contextPath=request.getContextPath();%>
 <script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}


.icons {
	width: 3em;
	height: 3em;
	border: none;
	background-color: #E0ECF8;
}
</style>
<script type="text/javascript">   
 
   $(document).ready(function () { 
      
	   /* Date */ 	
       $("#jqxQuoteDate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
       $('#descsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: ' Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
       $('#descsearchwndow').jqxWindow('close');
       $('#brandsearchwndows').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Brand Search' ,position: { x: 250, y: 100 }, keyboardCloseKey: 27});
       $('#brandsearchwndows').jqxWindow('close'); 
       $('#modelsearchwndows').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Model Search' ,position: { x: 250, y: 100 }, keyboardCloseKey: 27});
       $('#modelsearchwndows').jqxWindow('close');
       $('#yomsearchwindow').jqxWindow({ width: '10%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'YOM Search' ,position: { x: 500, y: 100 }, keyboardCloseKey: 27});
       $('#yomsearchwindow').jqxWindow('close');
       $('#colorsearchwndows').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Color Search' ,position: { x: 600, y: 100 }, keyboardCloseKey: 27});
       $('#colorsearchwndows').jqxWindow('close');
       $('#groupsearchwndows').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Group Search' ,position: { x: 1080, y: 100 }, keyboardCloseKey: 27});
       $('#groupsearchwndows').jqxWindow('close');
       $('#qotclientsearch').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
       $('#qotclientsearch').jqxWindow('close');
       $('#qotenqsearch').jqxWindow({ width: '55%', height: '59%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Enquiry Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
       $('#qotenqsearch').jqxWindow('close');
       $('#tariffinbtnwindow').jqxWindow({ width: '50%', height: '47%',  maxHeight: '95%' ,maxWidth: '50%' , title: 'Tariff Search' ,position: { x: 150, y: 150 }, keyboardCloseKey: 27});
	     $('#tariffinbtnwindow').jqxWindow('close'); 
			
			$('#emailwindow').jqxWindow({width: '75%', height: '85%',  maxHeight: '90%' ,maxWidth: '75%' , title: 'E-Mail',position: { x: 150, y: 77 } , theme: 'energyblue', showCloseButton: true,resizable: false});
			   $('#emailwindow').jqxWindow('close');
			   
       $('#jqxQuoteDate').on('change', function (event) {
			  
	        var maindate = $('#jqxQuoteDate').jqxDateTimeInput('getDate');
	      	 if ($("#mode").val() == "A" || $("#mode").val() == "E") {   
	        funDateInPeriod(maindate);
	      	 }
	       });
       
       		       $('#cl_dcocno').dblclick(function(){
       		      	 if ($("#mode").val() == "A" || $("#mode").val() == "E") { 
						  	    $('#qotclientsearch').jqxWindow('open');
						   
						  	  quotclientSearchContent('quotclientINgridsearch.jsp?', $('#qotclientsearch')); 
       		      	 }
					      });  
					        $('#refno').dblclick(function(){
						  	    $('#qotenqsearch').jqxWindow('open');
						   
						       enqSearchContent('enqMastersearch.jsp?', $('#qotenqsearch')); 
					      }); 
					        
					        
					        $('#ratariffbutton').click(function(){
					       	  if(($('#tarigrpid').val()!=""))
					       		  { 
					       		  
					       		  
					      		  	    $('#tariffinbtnwindow').jqxWindow('open');
					      		       $('#tariffinbtnwindow').jqxWindow('focus');     
					      		      
					      		       tariffbtnSearchContent('gettariffbtn.jsp?vehgpid='+document.getElementById("tarigrpid").value+"&cldocno="+document.getElementById("cl_dcocno").value);
					       		  
					       		  }
					       	  else
					       		  {
					       		
					       		  document.getElementById("errormsg").innerText="  Select Group";
					       
					           	  return false;
					       		    }
					       		
					       	  
					       	  
					             });
					        
       });
   
   function tariffbtnSearchContent(url) {
          //alert(url);
           $.get(url).done(function (data) {
             //alert(data);
         $('#tariffinbtnwindow').jqxWindow('setContent', data);

  	}); 
  	}
 
					                     function descinfoSearchContent(url) {
										   	
												 $.get(url).done(function (data) {
													 
													 $('#descsearchwndow').jqxWindow('open');
												$('#descsearchwndow').jqxWindow('setContent', data);
										
											}); 
											} 
										   function brandSearchContent(url) {
										    	 //alert(url);
										    		 $.get(url).done(function (data) {
										    			 
										    			 $('#brandsearchwndows').jqxWindow('open');
										    		$('#brandsearchwndows').jqxWindow('setContent', data);
										    
										    	}); 
										    	} 
										   function yomSearchContent(url) {
										
										    		 $.get(url).done(function (data) {
										    			 
										    			 $('#yomsearchwindow').jqxWindow('open');
										    		$('#yomsearchwindow').jqxWindow('setContent', data);
										    
										    	}); 
										    	} 
										   
										   
										
										   function modelSearchContent(url) {
										    	 //alert(url);
										    		 $.get(url).done(function (data) {
										    			 
										    			 $('#modelsearchwndows').jqxWindow('open');
										    		$('#modelsearchwndows').jqxWindow('setContent', data);
										    
										    	}); 
										    	} 
										   function colorSearchContent(url) {
										  	 //alert(url);
										  		 $.get(url).done(function (data) {
										  			 
										  			 $('#colorsearchwndows').jqxWindow('open');
										  		$('#colorsearchwndows').jqxWindow('setContent', data);
										  
										  	}); 
										  	}
										   function groupSearchContent(url) {
											  	 //alert(url);
											  		 $.get(url).done(function (data) {
											  			 
											  			 $('#groupsearchwndows').jqxWindow('open');
											  		$('#groupsearchwndows').jqxWindow('setContent', data);
											  
											  	}); 
											  	}
										  function getclinfo1(event){
										      	 if ($("#mode").val() == "A" || $("#mode").val() == "E") { 
										  	 var x= event.keyCode;
										  	 if(x==114){
										  	  $('#qotclientsearch').jqxWindow('open');
										  
										  	 quotclientSearchContent('quotclientINgridsearch.jsp?', $('#qotclientsearch'));  }  }
										  	 else{
										  		 }
										  	 }  
											  function quotclientSearchContent(url) {
										        //alert(url);
										           $.get(url).done(function (data) {
										 //alert(data);
										         $('#qotclientsearch').jqxWindow('setContent', data);
										
											}); 
										     	} 
											  function getenq(event){
											    	 var x= event.keyCode;
											    	 if(x==114){
											    	  $('#qotenqsearch').jqxWindow('open');
											    
											    	  enqSearchContent('enqMastersearch.jsp?', $('#qotenqsearch'));   }
											    	 else{
											    		 }
											    	 }  
												  function enqSearchContent(url) {
											          //alert(url);
											             $.get(url).done(function (data) {
											   //alert(data);
											           $('#qotenqsearch').jqxWindow('setContent', data);
										
											  	}); 
											       	} 
		  
		  
			function funReadOnly(){
				$('#frmQuote input').attr('readonly', true);
				$('#frmQuote textarea').attr('readonly', true );
				$('#jqxQuoteDate').jqxDateTimeInput({ disabled: true});
				$('#refno').attr('disabled', true);
				$('#frmQuote select').attr('disabled', true );
			      $("#qutgrid").jqxGrid({ disabled: true});
			      $("#tarifcalGrid").jqxGrid({ disabled: true});
			      $("#tarifGrid").jqxGrid({ disabled: true});
			      $("#descgrid").jqxGrid({ disabled: true});
			  	  $('#ratariffbutton').attr('disabled', true);   
			      
			  	$('#Sendmail').show();
				  // $('#updateposting').show();
				
			}
			
			function funRemoveReadOnly(){
				  $('#Sendmail').hide();
				$('#frmQuote input').attr('readonly', false );
			
				  $('#cl_dcocno').attr('readonly', true);
				  $('#client_details').attr('readonly', true);
				  $('#frmQuote textarea').attr('readonly', false );
				  $('#jqxQuoteDate').jqxDateTimeInput({ disabled: false});
				 $('#refno').attr('disabled', true);
				  $('#frmQuote select').attr('disabled', false );
				  $('#docno').attr('readonly', true);
				  $('#refno').attr('readonly', true);
				  
				  $('#txt_mobile').attr('readonly', true);
				  $('#txt_email').attr('readonly', true);
				  
					$('#ratariffbutton').attr('disabled', false);   
				  
			      $("#qutgrid").jqxGrid({ disabled: false});
			      $("#tarifcalGrid").jqxGrid({ disabled: false});
			      $("#tarifGrid").jqxGrid({ disabled: false});
			      $("#descgrid").jqxGrid({ disabled: false});
				
				if ($("#mode").val() == "A") {
					
					
					$('#jqxQuoteDate').val(new Date());
				      $("#qutgrid").jqxGrid('clear');
				    $("#qutgrid").jqxGrid('addrow', null, {});
				     $("#tarifcalGrid").jqxGrid('clear');
				    $("#tarifcalGrid").jqxGrid('addrow', null, {});
				     $("#descgrid").jqxGrid('clear');
				    $("#descgrid").jqxGrid('addrow', null, {});
				       $("#tarifcalGrid").jqxGrid('addrow', null,  {});
				       
		     	  		 $("#tarifDivId").load("tarifGrid.jsp?");
			
					 
			    	      
				   }
				if ($("#mode").val() == "E") {''
					
					
			             
			            
					 $("#qutgrid").jqxGrid({ disabled: false});
				      $("#tarifcalGrid").jqxGrid({ disabled: false});
				      
				      $("#tarifGrid").jqxGrid({ disabled: false});
				      $("#descgrid").jqxGrid({ disabled: false});
				      $("#qutgrid").jqxGrid('addrow', null, {});
					if( document.getElementById("cmbreftype").value=="CEQ")
					{
					$('#refno').attr('disabled', false);
					
					}
				else{
					$('#refno').attr('disabled', true);
				   }
					 
					
				   }
				
				if ($("#mode").val() == "D") {	  
					
					
					$('#refno').attr('disabled', false);
					$('#cmbreftype').attr('disabled', false);
					
					
				}
				
				
			}
			
   function funReset(){
	//	$('#frmQuote')[0].reset(); 
	}
  /*  
   function checkEmail() {

	    var email = document.getElementById('txt_email');
	    var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;

	    if (!filter.test(email.value)) {
	   // alert('Please provide a valid email address');
	    document.getElementById("errormsg").innerText="Please provide a valid email address";
	    email.focus;
	    return false;
	 }
	    else
	    	{
	    	 document.getElementById("errormsg").innerText="";
	    	}
	    
	    
   } */
	function funNotify(){	
		
	    var maindate = $('#jqxQuoteDate').jqxDateTimeInput('getDate');
     	 if ($("#mode").val() == "A" || $("#mode").val() == "E") {   
     		   var validdate=funDateInPeriod(maindate);
			   if(validdate==0){
			   return 0; 
			   }
     	 }
		
		if ($("#mode").val() == "A") {
		var saveval=document.getElementById("errorvalid").value;
		if(saveval==1)
			{
			 document.getElementById("errormsg").innerText="Select Rental Type";
			 return false;
			}
		else
			{
			document.getElementById("errormsg").innerText="";
			}
		
		
		}
		
		 if( document.getElementById("cmbreftype").value=="CEQ")
			{
	      var refno= document.getElementById('refno').value;
			 
			 if(refno=="")
			 {
				 document.getElementById("errormsg").innerText=" Select Ref NO";	
				 document.getElementById('refno').focus();
				 return 0;
			 }
			 
			 else
				 {
				 document.getElementById("errormsg").innerText="";
				 }
			 
		 
			}
		 
		 else
			 {
			 document.getElementById("errormsg").innerText="";
			 }
		
		var cldcocno=document.getElementById("cl_dcocno").value;
		
		if(cldcocno==""){
			 document.getElementById("errormsg").innerText="Select Client";
			 document.getElementById("cl_dcocno").focus();
			 return  0;
	                 	}
		else
			{
			 document.getElementById("errormsg").innerText="";
			}
		
		
/* 		if(document.getElementById("txt_email").value=="")
			{
			document.getElementById("errormsg").innerText="Recipient Is  Mandatory";  
			document.getElementById("txt_email").focus();
			return 0; 
			}
		else
			{ */
		
		  /*    var email = document.getElementById('txt_email');
		    var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;

		    if (!filter.test(email.value)) {
		   // alert('Please provide a valid email address');
		    document.getElementById("errormsg").innerText="Please provide a valid email address";
		    email.focus;
			document.getElementById("txt_email").focus();
		    return false; */
		
		    /* } */
		/* var fromval=document.getElementById("fromdatesvals").value;
		if(parseInt(fromval)==1)
			{
			
			document.getElementById("errormsg").innerText="From Date Less Than Current Date";
			return 0;
			
			}
		var toval=document.getElementById("todatevals").value;
		if(parseInt(toval)==1)
			{
			document.getElementById("errormsg").innerText="To Date Less Than From Date "; 
			return 0;
			
			} */
		

		    	
				 
				 var rows1 = $("#qutgrid").jqxGrid('getrows');
				  for(var i=0 ; i < rows1.length ; i++){
				    	
				  
					
					 
					 if(i==0)
						 {
						
						 var brdid=rows1[i].brdid;
							//alert("brdid--------"+brdid);
						
						if(brdid==""||typeof(brdid)=="undefined"||typeof(brdid)=="NaN")
							{
							
							document.getElementById("errormsg").innerText="Select Brand";  
					    	return 0;
							}
						 }
				    }
			
		  	 
		
		
		
		 var rows = $("#qutgrid").jqxGrid('getrows');
		 
	/*		
		   for(var i=0 ; i < rows.length ; i++){
		    	
		 
			
		    if(parseInt(rows[i].brdid)>0)
		  {
		    
	  
	 	        if(rows[i].hidfromdate==""||rows[i].hidfromdate=="0.00"||typeof(rows[i].hidfromdate)=="undefined"||typeof(rows[i].hidfromdate)=="NaN")
		
				{
				document.getElementById("errormsg").innerText="Enter From Date";  
		    	return 0;
				}
	 	        
	 	       if(rows[i].hidtodate==""||rows[i].hidfromdate=="0.00"||typeof(rows[i].hidtodate)=="undefined"||typeof(rows[i].hidtodate)=="NaN")
	 	    		
				{
				document.getElementById("errormsg").innerText="Enter To Date";  
		    	return 0;
				}
	 
		
	  	       
	       	} 
			
 	            
		   }
	*/
		
		
	 var rows = $("#qutgrid").jqxGrid('getrows');
		    $('#quotgridlenght').val(rows.length);
		   //alert($('#gridlength').val());
		   for(var i=0 ; i < rows.length ; i++){
		   // var myvar = rows[i].tarif; 
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "quottest"+i)
		       .attr("name", "quottest"+i)
		           .attr("hidden", "true"); 
		 
		   newTextBox.val(rows[i].sr_no+"::"+rows[i].brdid+" :: "+rows[i].modid+" :: "
				   +rows[i].specification+" :: "+rows[i].clrid+" :: "+rows[i].renttype+" :: "
				   +rows[i].hidfromdate+" :: "+rows[i].hidtodate+" :: "+rows[i].unit+" :: "+rows[i].grpid+" :: "+rows[i].yomid+" :: ");
		
		//alert(newTextBox.val());
		   newTextBox.appendTo('form'); 
		
	               } 
		   
			/*  var rows = $("#tarifGrid").jqxGrid('getrows');
			    $('#tarifGrid').val(rows.length);
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
					 }
			    }
			   
		    */
		  
		   
		   var rows = $("#tarifcalGrid").jqxGrid('getrows');
		    $('#tarifgridlength').val(rows.length);
		   //alert($('#gridlength').val());
		   for(var i=0;i<rows.length;i++){
		   // var myvar = rows[i].tarif; 
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "test"+i)
		       .attr("name", "test"+i)
		           .attr("hidden", "true"); 
		   						    
		   newTextBox.val(rows[i].rentaltype+"::"+rows[i].rate+" :: "+rows[i].cdw+" :: "
				   +rows[i].pai+" :: "+rows[i].cdw1+" :: "+rows[i].pai1+" :: "+rows[i].gps+" :: "+rows[i].babyseater+" :: "+rows[i].cooler+" :: "+rows[i].kmrest+" :: "
				   +rows[i].exkmrte+" :: "+rows[i].oinschg+" :: "+rows[i].exhrchg+" :: "+rows[i].grpid+"::"+rows[i].sr_no+"::"+rows[i].tdocno);
			//alert(newTextBox.val());
		   newTextBox.appendTo('form'); 
			
		   }
			
			 var rows = $("#descgrid").jqxGrid('getrows');
				    $('#descgridlenght').val(rows.length);
				   for(var i=0 ; i < rows.length ; i++){
				    newTextBox = $(document.createElement("input"))
				       .attr("type", "dil")
				       .attr("id", "desctest"+i)
				       .attr("name", "desctest"+i)
				           .attr("hidden", "true"); 
				 
				   newTextBox.val(rows[i].sr_no+"::"+rows[i].desid+" :: "+rows[i].descplus+" :: " );
				//	alert(newTextBox.val());
				   newTextBox.appendTo('form'); 
				
			            } 
					
					
		   return 1;
	}

	function funChkButton() {
		/* funReset(); */
	}

	function funSearchLoad(){
		changeContent('quotmasterSearch.jsp'); 
	}
		
	function funFocus(){
	   	$('#jqxQuoteDate').jqxDateTimeInput('focus'); 	    		
	}
	function fundisrefno()
	{
		if( document.getElementById("cmbreftype").value=="CEQ")
			{
			$('#refno').attr('disabled', false);
			
			document.getElementById("reftypeval").value="CEQ";
			}
		else{
			document.getElementById("reftypeval").value="";
			$('#refno').attr('disabled', true);
		}
				
		if( document.getElementById("cmbreftype").value=="DIR")
		{
			$('#refno').attr('disabled', false);
			document.getElementById("refno").value="";
			$('#refno').attr('disabled', true);
		}
	
	}
	
	function funval()
	{
		 if($('#reftypeval').val()!="")
		  {
		  
		  
		  $('#cmbreftype').val($('#reftypeval').val());
		  }
		 var docvall=document.getElementById("masterdoc_no").value;
		 if(docvall<=0)
			 {
			
		    if(document.getElementById("reftypeval").value=="CEQ")
			{
		    	
			$('#refno').attr('disabled', false);
			
			}
		else{
			
			$('#refno').attr('disabled', true);
		   }
	}
	}
	
	
	
	function setValues() {
		if($('#hidjqxQuoteDate').val()){
			$("#jqxQuoteDate").jqxDateTimeInput('val', $('#hidjqxQuoteDate').val());
		       }
		 if($('#msg').val()!=""){
				
			   $.messager.alert('Message',$('#msg').val());
			  }
		 var indexval2 = document.getElementById("masterdoc_no").value;
		 if(indexval2>0)
			 {
 		
		       //   var indexval1 = document.getElementById("docno").value;
		         
     	  		 $("#qutdetaildiv").load("quatDetails.jsp?qutdocno1="+indexval2);
     	  		 $("#targridcalc").load("taricalcu.jsp?qutdocno2="+indexval2);
     	  		 $("#descdiv").load("descgrid.jsp?qutdocno3="+indexval2);
		 
			 }
		 
		    
		 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		
		funval();
	}
	
	
    function funPrintBtn(){
  	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
  	  
  	   var url=document.URL;

         var reurl=url.split("saveQuote");
         
         $("#docno").prop("disabled", false);                
         
   
 var win= window.open(reurl[0]+"printQuot?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
      
 win.focus();
  	   } 
  	  
  	   else {
 	    	      $.messager.alert('Message','Select a Document....!','warning');
 	    	      return false;
 	    	     }
 	    	
  	}
  	function funSendmail()
 	{
 			
 		 if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
 		  
 		if(document.getElementById("txt_email").value=="")
 			{
			document.getElementById("errormsg").innerText="Recipient Is  Mandatory";  
 			return 0;
 			}
 			 
 			 
 	//	document.getElementById("errormsg").innerText="Email is Sending. Please Wait...";  
 		sample();
 		
 		 var recipient1=document.getElementById("txt_email").value; 
     	var recipient=recipient1.replace(/ /g, "%20");
     	//alert(""+recipient);
     	
 	<%-- 	 window.open("<%=contextPath%>/com/common/Email.jsp?formcode="+document.getElementById("formdetailcode").value+'&recipient='+recipient,"E-Mail","menubar=0,resizable=1,width=900,height=525 "); --%> 
 		
 		 <%-- window.open("<%=contextPath%>/com/email/Email.jsp?formcode="+document.getElementById("formdetailcode").value+'&recipient='+recipient+'&code='+document.getElementById("masterdoc_no").value,"E-Mail","menubar=0,resizable=1,width=900,height=525 "); --%>
 		 //getMailservDets();
 		//sendmails();
 		 }
 		else {
   	      $.messager.alert('Message','Select a Document....!','warning');
   	      return false;
   	     }
 		
 	}
 
  	function sample()
 	{
 		var formcode=document.getElementById("formdetailcode").value;
 		var recep=document.getElementById("txt_email").value.trim();
 		
 		var genterms=document.getElementById("desc_main").value.trim();
 		
 		
 		$.ajaxFileUpload
    	  (  
    	      {  
    	    	
    	    	  url: 'jspToPdf.action?docno='+document.getElementById("docno").value+"&formcode="+formcode+"&recep="+recep+"&genterms="+genterms,  
    	          secureuri:false,//false  
    	          fileElementId:'file', //id  <input type="file" id="file" name="file" />  
    	          dataType: 'json',// json  
    	          success: function (data, status)  //  
    	          {  
    	              //alert(status);
    	             if(status=='success'){
    	            	
    	            	
    	              }
    	             if(status=='error'){
    	            	 // $.messager.alert('Message',"E-Mail Sending failed");
    	             }
    	             
    	              $("#testImg").attr("src",data.message);
    	              if(typeof(data.error) != 'undefined')  
    	              {  
    	                  if(data.error != '')  
    	                  {  
    	                      alert(data.error);  
    	                  }else  
    	                  {  
    	                      alert(data.message);  
    	                  }  
    	              }  
    	          },  
    	           error: function (data, status, e)
    	          {  
    	              alert(e);  
    	          }  
    	      }  
    	  ) 
    	  return false;
      }

    
 		
 	        
 	<%-- <%-- 
 	function getMailservDets()
		{
            return 0;
		var x=new XMLHttpRequest();
		var items,smtphost,smtpport,signature,email,pass;
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
		        items= x.responseText;
		        items=items.split('####');
		        smtphost=items[0];
		        smtpport=items[1];
		        signature=items[2];
		        email=items[3];
		        pass=items[4];
		        	$("#host").val(smtphost); 	
		        	$("#port").val(smtpport);
		        	$("#signature").val(signature); 
		        	$("#userName").val(email);
		        	$("#password").val(pass);
		        	/* var recipient1=document.getElementById("txt_email").value;
		        	var recipient=recipient1.replace(/ /g, "%20");
		        //	alert("1");
		     //   alert("recipient"+recipient);
		      //  alert("host"+$("#host").val());
		      //  alert("port"+$("#port").val());
		      //  alert("docno"+$("#docno").val());
		        //alert("formdetailcode"+$("#formdetailcode").val());
		        	$.ajaxFileUpload
		      	  (  
		      	      {  
		      	    	 url: 'doEmail.action?recipient='+recipient+'&host='+$("#host").val()+'&port='+$("#port").val()+'&docno='+$("#docno").val()+'&formdetailcode='+document.getElementById("formdetailcode").value,
		      	    	 // url: 'doEmail.action?recipient='+recipient+'&CC='+$("#CC").val()+'&BCC='+$("#BCC").val()+'&subject='+$("#subject").val()+'&message='+$("#message").val()+'&host='+$("#host").val()+'&port='+$("#port").val()+'&docno='+$("#docno").val(),  
		      	          secureuri:false,//false  
		      	          fileElementId:'file',//id  <input type="file" id="file" name="file" />  
		      	          dataType: 'json',// json  
		      	          success: function (data, status)  //  
		      	          {  
		      	      
		      	             if(status=='success'){
		      	            	document.getElementById("errormsg").innerText="";  
		      	            	 $.messager.alert('Message',"E-Mail Send Successfully");
		      	            //	 document.getElementById("message").value="";
		      	            	// document.getElementById("subject").value="";
		      	            	// document.getElementById("CC").value="";
		      	            	// document.getElementById("BCC").value="";
		      	            	
		      	              }
		      	             if(status=='error'){
		      	            	document.getElementById("errormsg").innerText="";  
		      	            	 $.messager.alert('Message',"E-Mail Sending failed");
		      	             }
		      	             
		      	              $("#testImg").attr("src",data.message);
		      	              if(typeof(data.error) != 'undefined')  
		      	              {  
		      	                  if(data.error != '')  
		      	                  {  
		      	                	document.getElementById("errormsg").innerText="";  
		      	                      alert(data.error);  
		      	                  }else  
		      	                  {  
		      	                	document.getElementById("errormsg").innerText="";  
		      	                      alert(data.message);  
		      	                  }  
		      	              }  
		      	          },  
		      	          error: function (data, status, e)//  
		      	          {  
		      	              alert(e);  
		      	          }  
		      	      }  
		      	  ) 
		      	
		      	  return false;
		        }
			else
				{
				} 
		}
		x.open("GET","<%=contextPath%>/com/email/getMailservDet.jsp",true);
		x.send();
		} 
 	 --%> 
 	/* function sendmails()
 	{
 		
 		var recipient1=document.getElementById("txt_email").value;
    	var recipient=recipient1.replace(/ /g, "%20");
    //	alert("1");
 //   alert("recipient"+recipient);
  //  alert("host"+$("#host").val());
  //  alert("port"+$("#port").val());
  //  alert("docno"+$("#docno").val());
    //alert("formdetailcode"+$("#formdetailcode").val());
    	$.ajaxFileUpload
  	  (  
  	      {  
  	    	 url: 'doEmail.action?recipient='+recipient+'&host='+$("#host").val()+'&port='+$("#port").val()+'&docno='+$("#docno").val()+'&formdetailcode='+document.getElementById("formdetailcode").value,
  	    	 // url: 'doEmail.action?recipient='+recipient+'&CC='+$("#CC").val()+'&BCC='+$("#BCC").val()+'&subject='+$("#subject").val()+'&message='+$("#message").val()+'&host='+$("#host").val()+'&port='+$("#port").val()+'&docno='+$("#docno").val(),  
  	          secureuri:false,//false  
  	          fileElementId:'file',//id  <input type="file" id="file" name="file" />  
  	          dataType: 'json',// json  
  	          success: function (data, status)  //  
  	          {  
  	      
  	             if(status=='success'){
  	            	document.getElementById("errormsg").innerText="";  
  	            	 $.messager.alert('Message',"E-Mail Send Successfully");
  	            //	 document.getElementById("message").value="";
  	            	// document.getElementById("subject").value="";
  	            	// document.getElementById("CC").value="";
  	            	// document.getElementById("BCC").value="";
  	            	
  	              }
  	             if(status=='error'){
  	            	document.getElementById("errormsg").innerText="";  
  	            	 $.messager.alert('Message',"E-Mail Sending failed");
  	             }
  	             
  	              $("#testImg").attr("src",data.message);
  	              if(typeof(data.error) != 'undefined')  
  	              {  
  	                  if(data.error != '')  
  	                  {  
  	                	document.getElementById("errormsg").innerText="";  
  	                      alert(data.error);  
  	                  }else  
  	                  {  
  	                	document.getElementById("errormsg").innerText="";  
  	                      alert(data.message);  
  	                  }  
  	              }  
  	          },  
  	          error: function (data, status, e)//  
  	          {  
  	              alert(e);  
  	          }  
  	      }  
  	  ) 
  	
  	  return false;
    }
else
	{
	}
 	} */
 	
 	
</script>
 
</head>

<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmQuote" action="saveQuote" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class='hidden-scrollbar'>
<div>
<fieldset>

<legend>Quotation Info</legend>
 
 <table width="100%" ><tr><td> 
<table width="100%"  >
      <tr>
        <td width="6%" align="right">Date</td>
        <td colspan="3" width="20%"><div id='jqxQuoteDate' name='jqxQuoteDate' value='<s:property value="jqxQuoteDate"/>'></div>
                   <input type="hidden" id="hidjqxQuoteDate" name="hidjqxQuoteDate" value='<s:property value="hidjqxQuoteDate"/>'/></td>
       
       <td align="right" width="4%">Ref Type</td>
        <td width="20%"><select id="cmbreftype" name="cmbreftype" style=width:60%  value='<s:property value="cmbreftype"/>' onchange="fundisrefno();">
            <option value="DIR">Direct</option>
            <option value="CEQ">Enquiry</option>
                        </select></td>
  
        <td width="4%" align="right">Ref No</td>
        <td colspan="3" width="20%"><input type="text" id="refno" name="refno" placeholder="Press F3 To Search" readonly="readonly" value='<s:property value="refno"/>' onKeyDown="getenq(event);" /></td>
           <td width="20%" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           User Name : <label ><font size="2PX"><%=session.getAttribute("USERNAME")%></font></label></td>
      <td width="25%" align="right">Doc No</td>
        <td width="29%"><input type="text" id="docno" name="docno" tabindex="-1" value='<s:property value="docno"/>'/></td> 
     </tr>
     </table>
</td>
</tr>
<tr>
<td>

<table width="100%">
     <tr>
        <td align="right" width="5.3%">Client</td>
        <td > <input type="text" id="cl_dcocno" name="cl_dcocno"  placeholder="Press F3 To Search"  value='<s:property value="cl_dcocno"/>' onKeyDown="getclinfo1(event);" onfocus="this.placeholder = ''"/>
             <input type="text" id="client_details" name="client_details" style=width:61.2%;resize:none; value='<s:property value="client_details"/>'></td>
      </tr>
      </table>  
   </td>
   </tr>
<tr>
   <td> 
   <table width="100%" >
   <tr>
   <td width="83%">
<table width="100%">
      <tr>
       
         <td align="right"  width="6%" >Mobile</td>
        <td colspan="3" width="18%"><input type="text" id="txt_mobile" name="txt_mobile" readonly="readonly" style=width:90% value='<s:property value="txt_mobile"/>'></td>
        <td align="right" width="2%">Email</td>
        <td colspan="3"  width="25%" ><input type="email" id="txt_email" name="txt_email" style=width:98% value='<s:property value="txt_email"/>' ></td>
      	<td align="right" width="6%">Attention To</td>
        <td><input type="text" id="txt_attention" name="txt_attention" style=width:72.8% value='<s:property value="txt_attention"/>'></td>
      </tr>
      </table>
<table width="100%">
      <tr>
       <td align="right"  width="6%">Subject</td>
        <td colspan="1"><input type="text" id="txt_remarks" name="txt_remarks" style="width:89.4%;resize:none;" value='<s:property value="txt_remarks"/>'></td>
        <td>
       <%--  <button type="button"  title="Send Mail"  class="icons" id="Sendmail"  value='<s:property value="Sendmail"/>'>
					 <img alt="Send Mail" src="<%=contextPath%>/icons/qtmail.png"> 
					</button> --%> </td>
      </tr>
  
        </table>  
        </td>
      <td width="17%"  ><!--    email2.png-->
      <%--  <div> 
        <button type="button"   title="Send Mail"  class="icons" id="Sendmail"  onclick="funSendmail()" value='<s:property value="Sendmail" />'  >
					 <img alt="Send Mail" src="<%=contextPath%>/icons/sendmailto.png "> 
					</button> 
				</div>
 --%>
<!-- <input type="file" value="YourDefaultPathAndFilename.AndExtension"> -->
					 
        </td>
        </tr>
        </table>
     </td>
        </tr>
        </table>
        

        
  </fieldset>
</div>
<br>
<fieldset>



    <div id="qutdetaildiv" ><jsp:include page="quatDetails.jsp"></jsp:include></div>
     

</fieldset>
<br>
<fieldset>
<table width="100%">
<tr>
<td width="5%"><div  ><button type="button"  title="Search Tariff"  class="icon" id="ratariffbutton"  value='<s:property value="ratariffbutton"/>'>
					 <img alt="tariffSearch" src="<%=contextPath%>/icons/tariffsearch.png"> 
					</button>
					</div>
</td>
<td width="95%">
 <div id="tarifDivId" ><jsp:include page="tarifGrid.jsp"></jsp:include></div>
     
</td>
</tr>
</table>
</fieldset>

<br>
<fieldset>
 <table width="100%">
  
    
         <tr>
     <td colspan="2"> <div id="targridcalc" ><jsp:include page="taricalcu.jsp"></jsp:include></div></td>
      </tr>
<%--  <tr>
    <td width="90%" align="right">Net Total</td>
    <td width="10%"><input type="text" id="txtnettotal" name="txtnettotal" value='<s:property value="txtnettotal"/>'/></td>
  </tr> --%>
</table>
</fieldset>
<br>
<fieldset>
 <table width="99.9%" >
 
  <tr>
        <td align="right" width=7%>General Terms</td>
        <td width=90%>
            
            <input type="text" id="desc_main" name="desc_main" style="width:99.8%;" value='<s:property value="desc_main"/>'/></td>
      </tr>
     <tr>
     
     <td colspan="2"> <div id="descdiv"><jsp:include page="descgrid.jsp"></jsp:include></div></td>
      </tr>
 
</table>
</fieldset>
<input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'/>
<input type="hidden" id="enqrefno" name="enqrefno" value='<s:property value="enqrefno"/>'/>
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
<input type="hidden" name="qubrandval" id="qubrandval" value='<s:property value="qubrandval"/>'/>

<input type="hidden" name="tagrup" id="tagrup" value='<s:property value="tagrup"/>'/>
<input type="hidden" name="tagrupid" id="tagrupid" value='<s:property value="tagrupid"/>'/>
<input type="hidden" name="quotgridlenght" id="quotgridlenght" value='<s:property value="quotgridlenght"/>'/>

<input type="hidden" name="tarifgridlength" id="tarifgridlength" value='<s:property value="tarifgridlength"/>'/>
<input type="hidden" name="maingridlength" id="maingridlength" value='<s:property value="maingridlength"/>'/>
<input type="hidden" name="tacalrowindex" id="tacalrowindex" value='<s:property value="tacalrowindex"/>'/>
<input type="hidden" name="descgridlenght" id="descgridlenght" value='<s:property value="descgridlenght"/>'/>

<input type="hidden" name="errorvalid" id="errorvalid" value='<s:property value="errorvalid"/>'/>   <!--  rental type validation -->


<input type="hidden" name="fromdatesvals" id="fromdatesvals" value='<s:property value="fromdatesvals"/>' />  
<input type="hidden" name="todatevals" id="todatevals" value='<s:property value="todatevals"/>' />  


<input type="hidden" name="reftypeval" id="reftypeval" value='<s:property value="reftypeval"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>

<input type="hidden" id="tarigrpid" name="tarigrpid"  value='<s:property value="tarigrpid"/>'/>

<input type="hidden" id="tdocnos" name="tdocnos"  value='<s:property value="tdocnos"/>'/>

<!-- //-------------------------------------- -->
<%-- <input type="hidden"  id="host" name="host"  value='<s:property value="host"/>'/>
<input type="hidden"  id="port" name="port"  value='<s:property value="port"/>'/>
<input type="hidden"  id="userName" name="userName"  value='<s:property value="userName"/>'/>
<input type="hidden"  id="password" name="password"  value='<s:property value="password"/>'/>
<input type="hidden"  id="signature" name="signature"  value='<s:property value="signature"/>'/>
<input type="hidden" id="filename" name="filename"  value='<s:property value="filename"/>'/> --%>

<!-- <input type="hidden" id="CC" name="CC"  value=""/>
<input type="hidden" id="BCC" name="BCC"  value=""/>

<input type="hidden" id="subject" name="subject"  value=""/>
<input type="hidden" id="message" name="message"  value=""/> -->


</div>

</form>
<div id="descsearchwndow">
   <div ></div>
</div>
<div id="brandsearchwndows">
   <div ></div>
</div>
<div id="modelsearchwndows">
   <div ></div>
</div>
<div id="colorsearchwndows">
   <div ></div>
</div>
<div id="groupsearchwndows">
   <div ></div>
</div>
<div id="qotclientsearch">
   <div ></div>
</div>
<div id="qotenqsearch">
   <div ></div>
</div>
<div id="tariffinbtnwindow">
   <div ></div>
</div>
<div id="yomsearchwindow">
   <div ></div>
</div>
 <div id="emailwindow">
				<div></div><div></div>
				</div>

</div>
</body>
</html>


