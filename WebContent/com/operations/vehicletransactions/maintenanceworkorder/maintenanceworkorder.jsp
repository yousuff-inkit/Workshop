 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<% String contextPath=request.getContextPath();%>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- <link href="../../../../css/main.css" rel="stylesheet" type="text/css" />
<link href="../../../../css/body.css" media="screen" rel="stylesheet" type="text/css" />
 -->


 <jsp:include page="../../../../includes.jsp"></jsp:include>
 <style>


form label.error {
color:red;
  font-weight:bold;

}
</style>

<style>

#header1 {
    background-color:#E0ECF8;
   
}
#header2 {
    background-color:#E0ECF8;
   
}
#header3 {
    background-color:#E0ECF8;
   
}
#header4 {
    background-color:#E0ECF8;
   
}
   
      .big-image
        {
            float: left;
            margin-right: 15px;
            margin-bottom: 15px;
            border: 1px solid #999;
            background: #fff;
            padding: 3px;
        }
        .small-image
        {
            border: 0px solid #ccc;
            
            padding: 3px;
        }
        .content-container
        {
            padding-left: 15px;
            padding-top: 15px;
            padding-right: 15px;
        }
        .important-text
        {
            font-size: 13px;
            color: #000;
        }
        .more-text
        {
            color: #444;
            font-size: 11px;
            font-style: italic;
        }
        
      .divclass {
    background-color: #b0c4de;
}  


/* .myButtonss {
	background-color:#44c767;
	-moz-border-radius:37px;
	-webkit-border-radius:37px;
	border-radius:37px;
	border:1px solid #18ab29;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:12px;
	padding:7px 30px;
	text-decoration:none;
}
.myButtonss:hover {
	background-color:#5cbf2a;
}
.myButtonss:active {
	position:relative;
	top:1px;
}
 */
     
        
.myButtonss {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #7892c2), color-stop(1, #476e9e));
	background:-moz-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:-webkit-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:-o-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:-ms-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:linear-gradient(to bottom, #7892c2 5%, #476e9e 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#7892c2', endColorstr='#476e9e',GradientType=0);
	background-color:#7892c2;
	-moz-border-radius:6px;
	-webkit-border-radius:6px;
	border-radius:6px;
	border:1px solid #4e6096;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Verdana;
	font-size:11px;
	font-style:italic;
	padding:7px 24px;
	text-decoration:none;
	text-shadow:0px -1px 0px #283966;
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
   input[type="button"]:disabled {
   opacity: 0;
}  
 
        
        
    </style>
<script type="text/javascript">

$(document).ready(function () {  
	
	if(document.getElementById("approvalstatus").value=="1"){
		$('#btnpostdetails').show();
		
	}
	else{
		$('#btnpostdetails').hide();
	}
	
	
	
	
	$("#maintainceDate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
	$('#fleetsearchwindow').jqxWindow({  width: '62%', height: '67%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Fleet Search' , position: { x: 400, y: 60 }, keyboardCloseKey: 27});
	$('#fleetsearchwindow').jqxWindow('close');
	$('#typessearchswindow').jqxWindow({  width: '30%', height: '63%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Type Search' , position: { x: 400, y: 60 }, keyboardCloseKey: 27});
	$('#typessearchswindow').jqxWindow('close');
	$('#damagewindow').jqxWindow({  width: '30%', height: '63%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Search' , position: { x: 400, y: 60 }, keyboardCloseKey: 27});
	$('#damagewindow').jqxWindow('close');
	$('#postwindow').jqxWindow({  width: '40%', height: '50%',  maxHeight: '50%' ,maxWidth: '40%' ,title: 'Posting Details' , position: { x: 400, y: 60 }, keyboardCloseKey: 27});
	$('#postwindow').jqxWindow('close');
/* 	
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>"); */
    
	 $("#invDate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    
    $("#postDate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
	$('#garragesearchwindow').jqxWindow({ width: '30%', height: '63%',  maxHeight: '70%' ,maxWidth: '50%' ,title: 'Garrage Search' , position: { x: 700, y: 60 }, keyboardCloseKey: 27});
	$('#garragesearchwindow').jqxWindow('close');
    $('#typeservsearchwndow').jqxWindow({ width: '30%', height: '59%',  maxHeight: '65%' ,maxWidth: '65%' , title: 'Type Search' ,position: { x: 200, y:100 }, keyboardCloseKey: 27});
    $('#typeservsearchwndow').jqxWindow('close');
     $('#serdescsearchwndow').jqxWindow({ width: '25%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Description Search' ,position: { x: 200, y:100 }, keyboardCloseKey: 27});
    $('#serdescsearchwndow').jqxWindow('close'); 
    $('#jqxTabs').jqxTabs({ width: 1300,  selectionTracker: true, animationType: 'fade',   theme: 'energyblue', });

    $('#postDate').on('change', function (event) 
			   { 
    	var postdate = $('#postDate').jqxDateTimeInput('getDate');
        var dateval=funDateInPeriod(postdate);
        if(dateval==0){
        	return false;
        }
			   });
    $('#maintainceDate').on('change', function (event) {
        var receiptdate = $('#maintainceDate').jqxDateTimeInput('getDate');
        funDateInPeriod(receiptdate);
       });
	$('#garagemaster').dblclick(function(){
		   $('#garragesearchwindow').jqxWindow('open');
		  	  
		  	  garragechangeContent('garragesearch.jsp?', $('#garragesearchwindow'));
				 });
	
	$('#mtfleetno').dblclick(function(){
	   $('#fleetsearchwindow').jqxWindow('open');
	  	  
	  	  fleetchangeContent('fleetsearch.jsp?', $('#fleetsearchwindow'));
			 });
	
      		 }); 
function descservSearchContent(url) {
 	 //alert(url);
 		 $.get(url).done(function (data) {
          
 			 $('#serdescsearchwndow').jqxWindow('open');
 		$('#serdescsearchwndow').jqxWindow('setContent', data);
 
 	}); 
 	}  
function TypeservSearchContent(url) {
  	 //alert(url);
  		 $.get(url).done(function (data) {
           
  			 $('#typeservsearchwndow').jqxWindow('open');
  		$('#typeservsearchwndow').jqxWindow('setContent', data);
  
  	}); 
  	} 
  	
function uppertypeSearchContent(url) {
 	 //alert(url);
 		 $.get(url).done(function (data) {
          
 			 $('#typessearchswindow').jqxWindow('open');
 		$('#typessearchswindow').jqxWindow('setContent', data);
 
 	}); 
 	} 
function damageSearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
         
			 $('#damagewindow').jqxWindow('open');
		$('#damagewindow').jqxWindow('setContent', data);

	}); 
	} 
 	

function getgarrage(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#garragesearchwindow').jqxWindow('open');

	  garragechangeContent('garragesearch.jsp?', $('#garragesearchwindow'));   }
	 else{
		 }
	 }  
	  function garragechangeContent(url) {
      //alert(url);
      
     	   document.getElementById("errormsg").innerText="";   
         $.get(url).done(function (data) {
//alert(data);
       $('#garragesearchwindow').jqxWindow('setContent', data);

	           }); 
   	}

function getfleet(event){
 	 var x= event.keyCode;
 	 if(x==114){
 	  $('#fleetsearchwindow').jqxWindow('open');
 
 	 fleetchangeContent('fleetsearch.jsp?', $('#fleetsearchwindow'));   }
 	 else{
 		 }
 	 }  
	  function fleetchangeContent(url) {
       //alert(url);
          $.get(url).done(function (data) {
//alert(data);
        $('#fleetsearchwindow').jqxWindow('setContent', data);

	           }); 
    	}

function funFocus(){
	
	$('#maintainceDate').jqxDateTimeInput('focus'); 	    		
}
function funReset() {
	
}
function funReadOnly() {
	$('#frmmaint input').attr('readonly', true);
	$('#frmmaint select').attr('disabled', true);
	
	$('#mtfleetno').attr('disabled', true);
	$('#garagemaster').attr('disabled', true);
	   $('#garagemaster').attr('readonly', true);
	   $("#maindowngrid").jqxGrid({ disabled: true});
	   $("#mainuppergrid").jqxGrid({ disabled: true}); 
	   $("#approvel").jqxGrid({ disabled: true});
	   
	   $("#approvel").jqxGrid({ disabled: true});
	   
	   $("#apprsecgrid").jqxGrid({ disabled: true}); 
	   
	   document.getElementById("mainwk").innerText="";

	  // $("#postingss").load("posting.jsp");
	   
		$('#invDate').jqxDateTimeInput({ disabled: true}); 
		$('#postDate').jqxDateTimeInput({ disabled: true}); 
		
		
		
		$('#maintainceDate').jqxDateTimeInput({ disabled: true}); 
		

		$('#jqxTabs').jqxTabs('enableAt', 1);
		$('#jqxTabs').jqxTabs('enableAt', 2);
		$('#jqxTabs').jqxTabs('enableAt', 3);
		
		
		 $('#first').hide();
		 $('#worderdiv').show();
		 $('#jobappdiv').hide();
		 $('#postdiv').hide();
			
			 $('#nextserdue').attr('readonly', true);
			 $('#currkm').attr('readonly', true);
			
		 
			
				$('#currkm').attr('readonly', true);
				$('#nextserdue').attr('readonly', true);
				
				$('#maintype').attr('disabled', true);
				$('#garagemaster').attr('disabled', true);
				
				
				$('#invDate').jqxDateTimeInput({ disabled: true}); 
				
				$('#postDate').jqxDateTimeInput({ disabled: true}); 
				
				
				$('#invno').attr('readonly', true);		
				
				 
				 
		/* 		 if(parseInt(document.getElementById("docno").value)>0)
						 {
						$('#frmmaint select').attr('disabled', false);
						$('#invDate').jqxDateTimeInput({ disabled: false}); 
					 $('#garagemaster').attr('disabled', false);
					 $('#nextserdue').attr('readonly', false);
					 $('#currkm').attr('readonly', false);
					 $('#invno').attr('readonly', false); 
						 } */
				 
						 $("#second").hide();
						 $("#third").hide();
						 $("#last").hide();	 
					// $invno	
}
function funRemoveReadOnly() {
	
	   document.getElementById("mainwk").innerText="";

	 $('#worderdiv').hide();
	 $('#jobappdiv').hide();
	 $('#postdiv').hide();
	
	
	$('#frmmaint input').attr('readonly', false);
	$('#frmmaint select').attr('disabled', false);
	$('#mtfleetno').attr('disabled', false);
	$('#garagemaster').attr('disabled', false);
	$('#nextserdue').attr('disabled', false);
	
	

	// currkm nextserdue maintype garagemaster
	
	
	
	$('#maintainceDate').jqxDateTimeInput({ disabled: false}); 
	$('#invDate').jqxDateTimeInput({ disabled: false}); 
	
	$('#postDate').jqxDateTimeInput({ disabled: false}); 
	
	 
	
	$('#mtfleetno').attr('readonly', true);
	$('#mtflname').attr('readonly', true);
	$('#garagemaster').attr('readonly', true);
	$('#docno').attr('readonly', true);
	$("#maindowngrid").jqxGrid({ disabled: false});
	$("#mainuppergrid").jqxGrid({ disabled: false}); 
	if($('#mode').val()=='A')
		{
		
		
		
		
		 $('#first').hide();
		
		 $('#nextserdue').attr('disabled', false);
		$('#maintainceDate').val(new Date());
		$('#invDate').val(new Date());
		
		
		$('#postDate').val(new Date());
		
		
		
		$("#maindowngrid").jqxGrid('clear');
		$("#maindowngrid").jqxGrid('addrow', null, {});
		$("#mainuppergrid").jqxGrid('clear');
		$("#mainuppergrid").jqxGrid('addrow', null, {});
		
		$("#approvel").jqxGrid('clear');
		$("#approvel").jqxGrid('addrow', null, {});
		
		$("#apprsecgrid").jqxGrid('clear');
		$("#apprsecgrid").jqxGrid('addrow', null, {});
		
		
		   $("#postingss").load("posting.jsp");
		   
		   
		   
		 $('#jqxTabs').jqxTabs('select',0);
		$('#jqxTabs').jqxTabs('disableAt', 1);
		$('#jqxTabs').jqxTabs('disableAt', 2);
		$('#jqxTabs').jqxTabs('disableAt', 3);
		} 
	if($('#mode').val()=='E')
	{
		  $("#mainuppergrid").jqxGrid('addrow', null, {});
		 $('#first').hide();
		 $('#jqxTabs').jqxTabs('select',0);
		
		/* if($('#maintype').val()=="repair" )
		 {
		 
			  $('#nextserdue').attr('disabled', true);
		
		 }	
		else
			{
			 $('#nextserdue').attr('disabled', false);
			} */
		$('#jqxTabs').jqxTabs('disableAt', 1);
		$('#jqxTabs').jqxTabs('disableAt', 2);
		$('#jqxTabs').jqxTabs('disableAt', 3);
	} 
	
	
	
}
function valchange()
{
if($('#maintypeval').val()!="")
 {
	
 
 $('#maintype').val($('#maintypeval').val());
 }
if($('#maintypeval').val()=="service" || $('#maintypeval').val()=="both")
{

	$('#nextserdue').attr('disabled', false);	 

}	
else
	{ 
	 $('#nextserdue').attr('disabled', true);
	}
}

function changetype()
{
	
	//alert($('#maintype').val());
	
	if($('#maintype').val()=="service" || $('#maintype').val()=="both")
	 {
	 
		  $('#nextserdue').attr('disabled', false);
	
	 }	
	else
		{
		 $('#nextserdue').attr('disabled', true);
		}
	
}

function setValues() {
	
	 
	
	 if($('#hidmaintainceDate').val()){
	   $("#maintainceDate").jqxDateTimeInput('val', $('#hidmaintainceDate').val());
	  }
	 if($('#hidinvDate').val()){
		   $("#invDate").jqxDateTimeInput('val', $('#hidinvDate').val());
		  }
	 
	 if($('#hidpostDate').val()){
		   $("#postDate").jqxDateTimeInput('val', $('#hidpostDate').val());
		  }
	 
	 
	 
	  if($('#msg').val()!=""){
		 
		   $.messager.alert('Message',$('#msg').val());
		   $('#jqxTabs').jqxTabs('select', 1);
		  }
	  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";

	  var docval=document.getElementById("masterdoc_no").value;
	  if(docval>0)
		  {
		  document.getElementById("mainwk").innerText=document.getElementById("formstatus").value;
		  
		//	 $('#jobappdiv').show();
			// $('#postdiv').show();
		  var indexVal2 = document.getElementById("masterdoc_no").value;
	     	
	         $("#maingrid").load("maintGrid.jsp?maindoc="+indexVal2);
	         $("#servgrid").load("servicemaingrid.jsp?maindoc1="+indexVal2);

             
	         $("#jobapprovel").load("jobapprovel.jsp?maindoc1="+indexVal2);
	         
			 $("#jobapprovelsec").load("approvelsecondgrid.jsp?maindoc1="+indexVal2);
	         
	         var trno = document.getElementById("maintTrno").value;
	         
	         if(trno>0)
	        	 {

	     		$('#jqxTabs').jqxTabs('enableAt', 1);
	     		$('#jqxTabs').jqxTabs('enableAt', 2);
	     		$('#jqxTabs').jqxTabs('enableAt', 3);
	        	  $("#postingss").load("posting.jsp?maindoc1="+trno);
	        	 
	        	 }

	         
	         
	         
	         if(parseInt(document.getElementById("postvals").value)==1) //posting update
        	 {
	        	 
        	 $.messager.alert('Message','Posting Updated Successfully'); 
        	 document.getElementById("mainwk").innerText="";
        	 $('#invno').attr('readonly', true);   
			 $('#invDate').jqxDateTimeInput({ disabled: true}); 
			 
			 $('#postDate').jqxDateTimeInput({ disabled: true}); 
			 
			 
        	   $('#jqxTabs').jqxTabs('select', 3); 
        	 document.getElementById("postvals").value="";
        	 
			   $('#secondedit').attr('disabled', true);
				$('#second').attr('disabled', true); 
				
				  $('#thirdedit').attr('disabled', true);
					$('#third').attr('disabled', true); 
					
					  $('#lastedit').attr('disabled', true);
						$('#last').attr('disabled', true); 
        	
        	 
        	 }
	       else if(parseInt(document.getElementById("postvals").value)==2)
	        	 {
	    	  
	    	   $('#jqxTabs').jqxTabs('select', 3); 
	        	 $.messager.alert('Message','Posting Not Updated'); 
	        	 document.getElementById("mainwk").innerText="";
	        	 document.getElementById("postvals").value="";
	        	 
	        	 }
	         if(parseInt(document.getElementById("selectgridtype").value)==10) //posting update
        	 {
	        	  
	        	 ///  $('#jqxTabs').jqxTabs('select', 3);
        	 document.getElementById("selectgridtype").value="";
        	 
        	 }
	       else if(parseInt(document.getElementById("selectgridtype").value)==11)
	        	 {
	    	  
	  
	        	 document.getElementById("selectgridtype").value="";
	        	 
	        	 }
	         
	         
	      //   document.getElementById("workstatus").value= $('#mastersearch').jqxGrid('getcelltext', rowBoundIndex, "wostatus");
	      //   document.getElementById("apprstatus").value= $('#mastersearch').jqxGrid('getcelltext', rowBoundIndex, "apstatus");
	        // document.getElementById("postingstatus").value= $('#mastersearch').jqxGrid('getcelltext', rowBoundIndex, "psstatus");
    
	       if(parseInt(document.getElementById("workstatus").value)==1)
	    	   {
	    	
	    
	    	   valchange();   
	    	   $("#btnEdit").attr('disabled', true );
	    	/*    $('#garagemaster').attr('disabled', true);
				$('#frmmaint select').attr('disabled', true); */
		
				
				 var indexVal2 = document.getElementById("masterdoc_no").value; 
				
			    $("#jobapprovelsec").load("approvelsecondgrid.jsp?maindoc1="+indexVal2);
	
	    	   }
	       else
	       {
	    	   $("#btnEdit").attr('disabled', false );
	    	    
	       }
	         
	       var formdetailcodes=document.getElementById("formdetailcode").value;
	       
	 /*       if(formdetailcodes=="MWO")
	    	   {
	    	   
	    	   return 0;
	    	   }
	       
 */
	       if(formdetailcodes=="MAP"|| formdetailcodes=="MPO")
	       	{      
	       
	       if(parseInt(document.getElementById("apprstatus").value)==1)
    	   {
	 	
	    	   $('#garagemaster').attr('disabled', true);
				$('#frmmaint select').attr('disabled', true); 
				   $('#secondedit').attr('disabled', true);
					$('#second').attr('disabled', true); 
					
					$('#btnCreate').attr('disabled', true); 
					$("#btnEdit").attr('disabled', true );
					
				
			
    	   }
	       
	       if(parseInt(document.getElementById("postingstatus").value)==1)
    	   {
	    	   
	    	   $('#thirdedit').attr('disabled', true);
				$('#third').attr('disabled', true); 
				
				  $('#lastedit').attr('disabled', true);
					$('#last').attr('disabled', true); 
					
					$('#btnCreate').attr('disabled', true); 
					$("#btnEdit").attr('disabled', true );   
    	   }
	       
	       
	       	}
	       
	       if(formdetailcodes=="MPO")
	    	   {
	  
	       if(parseInt(document.getElementById("postingstatus").value)==1)
    	   {
	    		 $('#invno').attr('readonly', true);   
				 $('#invDate').jqxDateTimeInput({ disabled: true}); 
				 
				 $('#postDate').jqxDateTimeInput({ disabled: true}); 
				 
				 
				 
				 
				 $('#nextserdue').attr('readonly', true);
				 $('#currkm').attr('readonly', true);
				 
				 
				//  ssecondedit,thirdedit,lastedit second third last
				   $('#secondedit').attr('disabled', true);
					$('#second').attr('disabled', true); 
					
					  $('#thirdedit').attr('disabled', true);
						$('#third').attr('disabled', true); 
						
						  $('#lastedit').attr('disabled', true);
							$('#last').attr('disabled', true); 
							
							$('#btnCreate').attr('disabled', true); 
							$("#btnEdit").attr('disabled', true );
				 
    	   }
	    	   }
	       
	     /*   if(parseInt(document.getElementById("workstatus").value)==1)
    	   {
	    	   
	    	  if(parseInt(document.getElementById("apprstatus").value)==1)
	    		  {
	    		  if(parseInt(document.getElementById("postingstatus").value)==1)
	    			  {
	    		  $('#jqxTabs').jqxTabs('select', 0);
	    		  
	    			$('#jqxTabs').jqxTabs('enableAt', 1);
	    			$('#jqxTabs').jqxTabs('enableAt', 2);
	    			$('#jqxTabs').jqxTabs('enableAt', 3);
	    			
	    			
	    			 $("#second").hide();
	    			 $("#secondedit").show();
	    			 
	    			 $("#third").hide();
	    			 
	    			 $("#thirdedit").show();
	    			 
	    			 $("#last").hide();	
	    			 $("#lastedit").show();	
	    			
	    			
	    			  }
	    		  else
	    		  {

	    			
	    		  $('#jqxTabs').jqxTabs('select', 3);
	    		  
	   	       
	    		  }
	    		  }
	    	  else
	    		  {
	    		  $('#jqxTabs').jqxTabs('select', 2);
	    		
					$('#jqxTabs').jqxTabs('disableAt', 3);
	    		  }
	    	 
	    	   
	    	   
    	   }

	       
	       else{
	    	 
	    	   $('#jqxTabs').jqxTabs('select', 1);
	    	   var trno = document.getElementById("maintTrno").value;
		         
		         if(trno>0)
		        	 {
		        	 $('#jqxTabs').jqxTabs('enableAt', 1);
		    			$('#jqxTabs').jqxTabs('enableAt', 2);
		    			$('#jqxTabs').jqxTabs('enableAt', 3);
		        	 }
		         else{
	    	   $('#jqxTabs').jqxTabs('disableAt', 2);
				$('#jqxTabs').jqxTabs('disableAt', 3);
		         }
	       } */
	       
	 		/* $('#jqxTabs').jqxTabs('enableAt', 1);
			$('#jqxTabs').jqxTabs('enableAt', 2);
			$('#jqxTabs').jqxTabs('enableAt', 3); 
	         */
	         
	           
	         
		  
		  }
	  
		 $('#jobappdiv').show();
		 $('#postdiv').show();

	  var formdetailcodes=document.getElementById("formdetailcode").value;

      if(formdetailcodes=="MWO")
      	{
    	//  $('#jqxTabs').jqxTabs('select', 1);
     	 $('#jobappdiv').hide();
		 $('#postdiv').hide();
      	
      	}
      else if(formdetailcodes=="MAP")
      	
      	
      	{
      	 $('#postdiv').hide();
  		 
      	
      	
      	}
      
      if(formdetailcodes=="MAP"|| formdetailcodes=="MPO")
     	{  
    		$('#btnCreate').attr('disabled', true); 
			$("#btnEdit").attr('disabled', true );
    	  
     	}
     
}


function funNotify(){
	//alert("2");
	  var receiptdate = $('#maintainceDate').jqxDateTimeInput('getDate');
	   var validdate=funDateInPeriod(receiptdate);
	   if(validdate==0){
	   return 0; 
	   }
		//alert("3");
	 var fleetval=document.getElementById("mtfleetno").value;
	   
	   if(fleetval=="")
	   {
		   document.getElementById("errormsg").innerText="Select Fleet No";  
		   document.getElementById("mtfleetno").focus();
		   return 0;
	   }
	   
	   
	   
	   
	   
	  /*  	if($('#maintype').val()=="service" || $('#maintype').val()=="both")
	 {
		 {
	   	var cuurkmval=document.getElementById("currkm").value;
	 	var nextserkmval=document.getElementById("nextserdue").value;
	   if((parseFloat(nextserkmval)<parseFloat(cuurkmval)))
		   
	 	
	 	{
		  
		   document.getElementById("errormsg").innerText="Service Due KM Less Than Current KM";  
		   document.getElementById("nextserdue").focus();
		   return 0;
	 	}
	   else
		   {
		   document.getElementById("errormsg").innerText="";  
		   }
		
		 }
	   var garrage=document.getElementById("garrageid").value;
	   if(garrage=="")
	   {
		   document.getElementById("errormsg").innerText="Select Garrage";  
		   document.getElementById("garagemaster").focus();
		   return 0;
	   }
	 */
		
		if($("#mode").val() == "A" || $("#mode").val() == "E" )
			{
			
			var rows = $("#mainuppergrid").jqxGrid('getrows');
			
			  for(var i=0;i<rows.length;i++){
			    	// dateval=2;
			    	 //alert("date"+rows[i].hidcldate);
			     
			    	if(rows[i].clears==true){
			    		aa=1;
			    		
			    		break;
			    		
			    	}
			    	else{
			    		aa=0;
			    	}
			    	
			    }  

			 if(aa==0){
			    	
			    	 document.getElementById("errormsg").innerText="Select Maintenance Required ";  
					 
			    	return 0;
			    } 
			
			
			
			
			
			
					var rows = $("#mainuppergrid").jqxGrid('getrows');
					  $('#maingridlength').val(rows.length);
				    for(var i=0;i<rows.length;i++){
				 	   // var myvar = rows[i].tarif; 
				 	    newTextBox = $(document.createElement("input"))
				 	       .attr("type", "dil")
				 	       .attr("id", "main"+i)                  
				 	       .attr("name", "main"+i)        
				 	         .attr("hidden", "true");  
				 	   newTextBox.val(rows[i].hidrefdates+"::"+rows[i].clears+" :: "+rows[i].rem+" :: "+rows[i].refsrno+" :: "+rows[i].typedocno+" :: "+rows[i].damageid+" :: ");
				 		
				 	   newTextBox.appendTo('form'); 
				 		
				 	   }
				
			}
	   
		
		
	
	 /*  var rows = $("#maindowngrid").jqxGrid('getrows');
	    $('#servicegridlenght').val(rows.length);
	   //alert($('#gridlength').val());
	   for(var i=0 ; i < rows.length ; i++){
	   // var myvar = rows[i].tarif; 
	    newTextBox = $(document.createElement("input"))
	       .attr("type", "dil")
	       .attr("id", "service"+i)
	       .attr("name", "service"+i)
	    .attr("hidden", "true");
	   newTextBox.val(rows[i].type+"::"+rows[i].description+" :: "+rows[i].remarks+" :: "
			   +rows[i].lbrcost+" :: "+rows[i].partscost+" :: "+rows[i].total+" :: ");
		                                                                            

	   newTextBox.appendTo('form');

	    
	   }  */
	   

/* 
	   var lbrcost=document.getElementById("lbrtotalcost").value;

	
	   if(lbrcost==""||typeof(lbrcost)=="undefined"||typeof(lbrcost)=="NaN")
		   {
		
		   document.getElementById("lbrtotalcost").value=0.00;
		   
		   }
	   
	   
	   var partscost=document.getElementById("partstotalcost").value;
	
	   if(partscost==""||typeof(partscost)=="undefined"||typeof(partscost)=="NaN")
	   {
		   document.getElementById("partstotalcost").value=0.00;
		    
	   }
	   var totalcost=document.getElementById("totalcost").value;
	
	   if(totalcost==""||typeof(totalcost)=="undefined"||typeof(totalcost)=="NaN")
	   {
		   
		   document.getElementById("totalcost").value=0.00;
		  
	   }
	   
	    */
	   
/* 
	   if(parseFloat(lbrcost)>0)
	   {
	 
	   document.getElementById("lbrtotalcost").value=partscost.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
	
	   }

	   if(parseFloat(partscost)>0)
	   {
		  
		   document.getElementById("partstotalcost").value=partscost.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
		  
	   }
	   
	   if(parseFloat(totalcost)>0)
	   {
		  
		   document.getElementById("lbrtotalcost").value=totalcost.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
		  
	   }
	   */
	   
		//alert("4");
		var postdate = $('#postDate').jqxDateTimeInput('getDate');
        var dateval=funDateInPeriod(postdate);
        if(dateval==0){
        	return 0;
        }
return 1;	
}
function funChkButton() {
	   /* funReset(); */
	  }
	  
function funSearchLoad(){
	changeContent('masterSearch.jsp'); 
 }
 
/* $(function(){
    $('#frmmaint').validate({
            rules: {
            	
            	 currkm:{"required":true,number:true},
       
            	 nextserdue:{"required":true,number:true},
       
             },
             messages: {
            
            	 currkm:{required:" *required",number:" inValid"},
          
            	 nextserdue:{required:" *required",number:" inValid"}
           
             }
    });});
 */
 function funPrintBtn(){
	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	  
	   var url=document.URL;

    var reurl=url.split("saveMaint");
    
    $("#docno").prop("disabled", false);                

var win= window.open(reurl[0]+"printmaintWork?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
 
win.focus();
	   } 
	  
	   else {
    	      $.messager.alert('Message','Select a Document....!','warning');
    	      return false;
    	     }
    	
	}  
                              
/* function currkmValidate()
{
        var x = document.maintUpdate.currkm.value;
        if(isNaN(x)|| x.indexOf(" ")!=-1){
            //  alert("Enter numeric value");
              document.getElementById("errormsg").innerText="Enter numeric value";   
              
              return false;
              }
        else
        	{
        	 document.getElementById("errormsg").innerText="";
        	}
       
           
}
function nextserdueValidate()
{
        var x = document.maintUpdate.nextserdue.value;
        if(isNaN(x)|| x.indexOf(" ")!=-1){
            //  alert("Enter numeric value");
              document.getElementById("errormsg").innerText="Enter numeric value";   
              
              return false;
              }
        else
        	{
        	 document.getElementById("errormsg").innerText="";
        	}
       
           
} */
</script>

<%--   <style>
.hidden-scrollbar {
  /* // overflow: auto; */
  height: 530px;
    overflow-x: hidden;
    
} 

</style>  --%>   


<script>

function firstnext()
{
  
 /*   if($("#mode").val() == "A" || $("#mode").val() == "E")
	   {
	   $('#btnSave').mousedown();
	   }
	
	   */
	
}
function secnext()
{
/* 	
	if(!(parseInt(document.getElementById("docno").value))>0)
	 {
		 $('#jqxTabs').jqxTabs('select', 2);  	 
         return false; 
	 }
	
 	var val= $('#approvel').jqxGrid('getcellvalue', 0, "type");	
	
 	
	 if (!(val=="") && !(typeof(val)=="undefined"))
	 {
		  $('#jqxTabs').jqxTabs('select', 2);  	 
  return false; 
	 }
	
	 */
	
	
	   var garrage=document.getElementById("garrageid").value;
	   if(garrage=="")
	   {
		   document.getElementById("errormsg").innerText="Select Garrage";  
		   document.getElementById("garagemaster").focus();
		   return 0;
	   }
	   
	   
		var rows = $("#maindowngrid").jqxGrid('getrows');
		
		  for(var i=0;i<rows.length;i++){
		    	// dateval=2;
		    	 //alert("date"+rows[i].hidcldate);
		    	 
		    	var rateval=rows[i].type;
		    //	 alert(rateval);
		     		if(!(rateval==""||typeof(rateval)=="undefined"||typeof(rateval)=="NaN"))
									{
									
		     			$('#jqxTabs').jqxTabs('enableAt', 2);
		    		aa=1;
		    		
		    		break;
		    		
		    	}
		    	else{
		    		aa=0;
		    	}
		    	
		    }  

		 if(aa==0){
		    	
		    	 document.getElementById("errormsg").innerText="Work Order Details Required ";  
				 
		    	return 0;
		    } 
		
	 
	   
		//$('#jqxTabs').jqxTabs('enableAt', 2);
	   
 
	   
		var rows = $("#maindowngrid").jqxGrid('getrows');
		var list = new Array();
		 
	   for(var i=0 ; i < rows.length-1 ; i++){
	  /*  if(i==0)
		   {
		   del=0;
		   }
	   else
		   {
		   del=10;
		   } */
		   
		   
		   
		   list.push(rows[i].type.replace("&","%26")+"::"+rows[i].description.replace("&","%26")+"::"+rows[i].remarks.replace("&","%26")+"::"+rows[i].lbrcost+"::"+rows[i].partscost+"::"+rows[i].total);
			 // ajaxcall(rows[i].type,rows[i].description,rows[i].remarks,rows[i].lbrcost,rows[i].partscost,rows[i].total,i,rows.length,del);
			 
	   }
			 
	  ajaxcall(list);
	  // $('#jqxTabs').jqxTabs('select', 2);
}






function ajaxcall(list)

{
/*  function ajaxcall(type,description,remarks,lbrcost,partscost,total,i,lgt,del){
	 */
	 
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 var items= x.responseText;
			 	var itemval=items.trim();
			 	
		/* 	  alert(itemval);
			 	
				var rows = $("#maindowngrid").jqxGrid('getrows');
			 
			
				var getval=rows.length;
				var rval=parseInt(getval)-1;
				
				 
				if(parseInt(i)==parseInt(rval))
			 	
					{
				  */
					
					
						 var docval=document.getElementById("masterdoc_no").value;
						  if(docval>0)
							  {
							
								 var indexVal2 = document.getElementById("masterdoc_no").value;
						     	
								 document.getElementById("mainwk").innerText="";
								 $("#second").hide();
								 $("#secondedit").show();
								 
								 $("#third").hide();
				    			 
				    			 $("#thirdedit").show();
				    			 
								 
								   $('#garagemaster').attr('disabled', true);
									$('#frmmaint select').attr('disabled', true); 
								 
								  $("#btnEdit").attr('disabled', true );
						         $("#servgrid").load("servicemaingrid.jsp?maindoc1="+indexVal2);
						         $("#jobapprovel").load("jobapprovel.jsp?maindoc1="+indexVal2);
						 	    $("#jobapprovelsec").load("approvelsecondgrid.jsp?maindoc1="+indexVal2);
						        // $("#postingss").load("posting.jsp?maindoc2="+indexVal2);
						  	/*    $('#jqxTabs').jqxTabs('select', 2); */
						  	$.messager.alert('Message','Successfully Saved');
						 	   
							  }
				/* 	} */
			
			/*     if(parseInt(itemval)=="10")
			    	{
			    	$.messager.alert('Message', 'Allocation Not Processed');
				     funreload(event);
				     $("#hidediv").hide();
			    	}
			    else if(parseInt(itemval)=="11")
			    	{
			    	
			    	   $.messager.alert('Message', '  Record Successfully Allocated ');
			 	      var val ="10";
					  var uptodate=$("#uptodate").val();
					  $("#allodiv").load("allocatelistGrid.jsp?chval="+val+"&uptodate="+uptodate);
				       $("#hidediv").hide();
	
			    	}
			    else
			    	{
			    	
			    	  $.messager.alert('Message', '  Not Allocated ');
				       funreload(event);
				       $("#hidediv").hide();
			    	
			    	} */
			     
			    
			}
		else
			{
			
			}  //type,description,remarks,lbrcost,partscost,total 
	}
/*   	x.open("GET","workordersavedata.jsp?type="+type+'&description='+description+'&remarks='+remarks+'&lbrcost='+lbrcost+
			'&partscost='+partscost+'&total='+total+'&ival='+i+'&doc='+document.getElementById("masterdoc_no").value
			+'&maintype='+document.getElementById("maintype").value+'&garrageid='+document.getElementById("garrageid").value+'&lgt='+lgt+'&del='+del); */
	   
	  x.open("GET","workordersavedata.jsp?list="+list+'&doc='+document.getElementById("masterdoc_no").value+'&garrageid='+document.getElementById("garrageid").value+'&maintype='+document.getElementById("maintype").value); 
	x.send();
}






function trdnext()
{
	
	/* if(!(parseInt(document.getElementById("docno").value))>0)
	 {
		 $('#jqxTabs').jqxTabs('select', 3);  	 
         return false; 
	 }
	
	var val= $('#posting').jqxGrid('getcellvalue', 0, "type");	
	 
 	
	 if (!(val=="") && !(typeof(val)=="undefined"))
	 {
		  $('#jqxTabs').jqxTabs('select', 3);  	 
          return false; 
	 }
	 	var cuurkmvals=document.getElementById("currkm").value;
	 if(cuurkmvals=="")
		{
		
		  document.getElementById("errormsg").innerText="Enter Current KM";  
		   document.getElementById("currkm").focus();
		   return 0;
		}
	 else
	   {
	   document.getElementById("errormsg").innerText="";  
	   } */
	   
		var cuurkmvals=document.getElementById("currkm").value;
		 if(cuurkmvals=="")
			{
			
			  document.getElementById("errormsg").innerText="Enter Current KM";  
			   document.getElementById("currkm").focus();
			   return 0;
			}
		 else
		   {
		   document.getElementById("errormsg").innerText="";  
		   }
 
		if($('#maintype').val()=="service" || $('#maintype').val()=="both")
		 {
			  
				   	var cuurkmval=document.getElementById("currkm").value;
				 	var nextserkmval=document.getElementById("nextserdue").value;
				 	
				 	if(nextserkmval=="")
				 		{
				 		
				 		  document.getElementById("errormsg").innerText="Enter Service Due KM ";  
						   document.getElementById("nextserdue").focus();
						   return 0;
				 		}
				 	
				 	 else
					   {
					   document.getElementById("errormsg").innerText="";  
					   }
				   if((parseFloat(nextserkmval)<parseFloat(cuurkmval)))
					   
				 	
				 	{
					  
					   document.getElementById("errormsg").innerText="Service Due KM Less Than Current KM";  
					   document.getElementById("nextserdue").focus();
					   return 0;
				 	}
				   else
					   {
					   document.getElementById("errormsg").innerText="";  
					   }
			
			 }
		$('#jqxTabs').jqxTabs('enableAt', 3);
	 
		 $("#hidediv").show();
	var rows = $("#approvel").jqxGrid('getrows');
 
	    
	var lists = new Array();

   for(var i=0 ; i < rows.length-1 ; i++){
	   
	   if(rows[i].clears==true)
	   {
		   lists.push(rows[i].type.replace("&","%26")+"::"+rows[i].description.replace("&","%26")+"::"+rows[i].remarks.replace("&","%26")+"::"+rows[i].lbrcost+"::"+rows[i].partscost+"::"+rows[i].total);  
	   }  
		 // ajaxcall1(rows[i].type,rows[i].description,rows[i].remarks,rows[i].lbrcost,rows[i].partscost,rows[i].total,i,rows[i].clears,rwo,delval);
	  
   }
   ajaxcall1(lists);  
}

//function ajaxcall1(type,description,remarks,lbrcost,partscost,total,i,clears,rwo,delval){
	function ajaxcall1(lists){
	 
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 var items= x.responseText;
			 	var itemval=items.trim();
			 	
			  
			/* alert("i"+i);
			alert("items"+itemval);
				var rows = $("#approvel").jqxGrid('getrows');
				 var ss=rows.length-1;
				alert("ss"+ss);
				//alert("i="+i);
			
			 	if(i==ss)
			 	
					{ */
			 		
			 		apprsecgrid();
			 		
			 		//document.getElementById("stop").value="one";
					
			/* 		if(document.getElementById("stop").value=="one")
					
			 		{
					apprsecgrid();
			 		}
					
					document.getElementById("stop").value="";
					 */
					/* }  */
					
					
		/* 	 	if(parseInt(cc)==parseInt(itemval))
			 	{	
			 		 
	
					//apprsecgrid();
					
					}
					 */
						/*  var docval=document.getElementById("masterdoc_no").value;
						  if(docval>0)
							  {
							  
								 var indexVal2 = document.getElementById("masterdoc_no").value;
						     	
						       
								  $("#btnEdit").attr('disabled', true );
						         $("#servgrid").load("servicemaingrid.jsp?maindoc1="+indexVal2);
						         $("#jobapprovel").load("jobapprovel.jsp?maindoc1="+indexVal2);
						         $("#postingss").load("posting.jsp?maindoc2="+indexVal2);
						         $('#jqxTabs').jqxTabs('select',3);
							  } */
				/* 	} */
			

			     
			    
			}
		else
			{
			
			}  //type,description,remarks,lbrcost,partscost,total
	}
	x.open("GET","approvelsavedata.jsp?list="+lists+'&doc='+document.getElementById("masterdoc_no").value+'&currkm='+document.getElementById("currkm").value+'&nextserdue='+document.getElementById("nextserdue").value);   
	//x.open("GET","approvelsavedata.jsp?+'&doc='+document.getElementById("masterdoc_no").value+'&currkm='+document.getElementById("currkm").value+'&nextserdue='+document.getElementById("nextserdue").value+"&clears="+clears+"&rwo="+rwo+'&delval='+delval);     
//	x.open("GET","savedata.jsp?fleet_no="+fleet_no+"&rdocno="+rdocno+"&trancode="+trancode+"&trans="+trans+"&tagno="+tagno+"&saveval="+saveval,true);
	x.send();
}

function apprsecgrid()
{
 
	var rows = $("#apprsecgrid").jqxGrid('getrows');
    //$('#servicegridlenght1').val(rows.length);
 	var listss = new Array();
   for(var i=0 ; i < rows.length-1 ; i++){
 
	   if(rows[i].clears==true)  
	   { 
     
    
		   listss.push(rows[i].hidrefdates+"::"+rows[i].rem.replace("&","%26")+"::"+rows[i].refsrno+"::"+rows[i].typedocno+"::"+rows[i].damageid+"::"+rows[i].hidcldate+"::"+rows[i].hidcltime);  
		 
	   }
	  
	 //  ajaxcallsub(rows[i].hidrefdates,aa,rows[i].rem,rows[i].refsrno,rows[i].typedocno,rows[i].damageid,rows[i].hidcldate,rows[i].hidcltime,i,row,rows[i].clears,del);
	   
   }
   ajaxcallsub(listss);
	
	}



// ajaxcallsub(hidrefdates,aa,remarks,refsrno,typedocno,damageid,hidcldate,hidcltime,i,row,clearss,del){
	function ajaxcallsub(listss){
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 var items= x.responseText;
			 	var itemval=items.trim();
		 
			 	
		 	/* 	var rows = $("#apprsecgrid").jqxGrid('getrows');
				
				if(i==rows.length-1)
			 	
					{   */
					/* if(document.getElementById("stop1").value=="two")
						
			 		{ */
					jurnsave();
			 		/* }
					document.getElementById("stop1").value=""; */
						/* } */
					/* 
						  var docval=document.getElementById("masterdoc_no").value;
						  if(docval>0)
							  {
							  
								 var indexVal2 = document.getElementById("masterdoc_no").value;
						     	
						       
								  $("#btnEdit").attr('disabled', true );
						         $("#servgrid").load("servicemaingrid.jsp?maindoc1="+indexVal2);
						         $("#jobapprovel").load("jobapprovel.jsp?maindoc1="+indexVal2);
						 /*         $("#postingss").load("posting.jsp?maindoc2="+indexVal2); */
						     /*     $("#jobapprovelsec").load("approvelsecondgrid.jsp?maindoc1="+indexVal2);
						         $('#jqxTabs').jqxTabs('select',3); 
							  }   */
					 
			

			     
			    
			}
		else
			{
			
			}  //hidrefdates,aa,remarks,refsrno,typedocno,damageid,hidcldate,hidcltime,i
	}
	//x.open("GET","apprsndsave.jsp?hidrefdates="+hidrefdates+'&aa='+aa+'&remarks='+remarks+'&refsrno='+refsrno+'&typedocno='+typedocno+'&damageid='+damageid+'&hidcldate='+hidcldate+'&hidcltime='+hidcltime+'&ival='+i+'&doc='+document.getElementById("masterdoc_no").value+'&row='+row+'&clearss='+clearss+'&del='+del);
//	x.open("GET","savedata.jsp?fleet_no="+fleet_no+"&rdocno="+rdocno+"&trancode="+trancode+"&trans="+trans+"&tagno="+tagno+"&saveval="+saveval,true);

x.open("GET","apprsndsave.jsp?list="+listss+'&doc='+document.getElementById("masterdoc_no").value);
	x.send();
}

function jurnsave()
{
	

	  
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 var items= x.responseText.trim();
			 //	var itemval=items.trim();
			
			
			
						 var docval=document.getElementById("masterdoc_no").value;
						  if(docval>0)
							  {
							       
							  
							  document.getElementById("maintTrno").value =items; 
							  
								 var indexVal2 = document.getElementById("masterdoc_no").value;
						     	
								 $("#btnEdit").attr('disabled', true );
								
								   $('#garagemaster').attr('disabled', true);
								   $('#frmmaint select').attr('disabled', true); 
									// secondedit,thirdedit,lastedit second third last
									     $('#secondedit').attr('disabled', true);
									     $('#second').attr('disabled', true); 
										
										 $('#currkm').attr('readonly', true);
										 $('#nextserdue').attr('readonly', true);
										 
										 $("#second").hide();
										 $("#secondedit").show();
										 
										 
										 $("#third").hide();
										 $("#thirdedit").show();
										 
										 $("#last").hide();	
										 $("#lastedit").show();	
						    			 
									 
									
								 
						         $("#servgrid").load("servicemaingrid.jsp?maindoc1="+indexVal2);
						         $("#jobapprovel").load("jobapprovel.jsp?maindoc1="+indexVal2);
						 	     $("#jobapprovelsec").load("approvelsecondgrid.jsp?maindoc1="+indexVal2);
						         $("#postingss").load("posting.jsp?maindoc1="+items);
						  	   /*   $('#jqxTabs').jqxTabs('select', 3); */
						  	     
						  	     document.getElementById("mainwk").innerText="";
						  	 	$.messager.alert('Message','Successfully Saved');
						  	   document.getElementById("invno").value="";
						  	   
						  	   $("#hidediv").hide();
						  	    // exit();
							  }
				
			    
			}
		else
			{
			
			}  //type,description,remarks,lbrcost,partscost,total 
	}
	x.open("GET","jurnsave.jsp?docno="+document.getElementById("masterdoc_no").value+'&garragename='+document.getElementById("garagemaster").value+"&garrageid="+document.getElementById("garrageid").value);
	 
	x.send();
}




function lastsave(){
/* 	 var rows = $("#posting").jqxGrid('getrows');
	 
	 if(parseInt(rows.length)<=0)
		 {
		 
		 return 0; 
		 }
	 
	    */
	  
	
	
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 var items= x.responseText.trim();
			 if(parseInt(items)==1)
				 {
			
				 $.messager.alert('Message','Posting Already Done ','warning');   
				 return 0; 
				 
				 }
			 else
				 {
				 checkposting();
				 
				 }
			    
			}
		else
			{
			
			}  //type,description,remarks,lbrcost,partscost,total
	}
	x.open("GET","checkpostingstatus.jsp?doc="+document.getElementById("masterdoc_no").value);

	x.send();
}




function checkposting(){

	
	
	/* if(document.getElementById("invno").value=="")
		
		{
		 document.getElementById("errormsg").innerText=" Enter Invoice No";  
		 document.getElementById("invno").focus();
		return 0;
		} */
		
		$('#frmmaint input').attr('readonly', false);
		$('#frmmaint select').attr('disabled', false);
		$('#mtfleetno').attr('disabled', false);
		$('#garagemaster').attr('disabled', false);
		 $('#nextserdue').attr('disabled', false);
		$('#maintainceDate').jqxDateTimeInput({ disabled: false}); 
		$('#invDate').jqxDateTimeInput({ disabled: false});  
		
		$('#postDate').jqxDateTimeInput({ disabled: false}); 
		
		
		
		$('#mtfleetno').attr('readonly', true);
		$('#mtflname').attr('readonly', true);
		$('#garagemaster').attr('readonly', true);
		$('#docno').attr('readonly', true);
		
		/*  var rows = $("#approvel").jqxGrid('getrows');
		    $('#servicegridlenght').val(rows.length);
		   //alert($('#gridlength').val());
		   for(var i=0 ; i < rows.length ; i++){
		   // var myvar = rows[i].tarif; 
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "service"+i)
		       .attr("name", "service"+i)
		    .attr("hidden", "true");
		   newTextBox.val(rows[i].type+"::"+rows[i].description+" :: "+rows[i].remarks+" :: "
				   +rows[i].lbrcost+" :: "+rows[i].partscost+" :: "+rows[i].total+" :: ");
			                                                                            

		   newTextBox.appendTo('form');

		    
		   } */
		   document.getElementById("mainwk").innerText="";   
		   document.getElementById("mode").value="POS";
		   document.getElementById("frmmaint").submit();
	
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

/* ('#secondedit').attr('disabled', true);
$('#').attr('disabled', true); 

  $('#thirdedit').attr('disabled', true);
	$('#').attr('disabled', true); 
	
	  $('#lastedit').attr('disabled', true);
		$('#last').attr('disabled', true);  */
function secondedits()    
{
	
	$('#maintype').attr('disabled', false);
	$('#garagemaster').attr('disabled', false);	
	$('#garagemaster').attr('readonly', true);
	$("#maindowngrid").jqxGrid({ disabled: false});
	

	 $("#second").show();
	 $("#secondedit").hide();
	 

	
/* 	 $("#second").hide();
	 $("#third").hide();
	 $("#last").hide();	  */
	
/* 	$("#maindowngrid").jqxGrid({ disabled: true});
	   $("#mainuppergrid").jqxGrid({ disabled: true}); 
	   $("#approvel").jqxGrid({ disabled: true});
	   
	   $("#approvel").jqxGrid({ disabled: true});
	   
	   $("#apprsecgrid").jqxGrid({ disabled: true}); 
	   
	   $("#postingss").jqxGrid({ disabled: true});  */
	
}


function thirdedits()
{
	
	//alert("=="+document.getElementById("currkm").value+"===");
if(document.getElementById("currkm").value.trim()==""){
	$('#mtfleetno').attr('disabled', false);
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 var items= x.responseText.trim();
			 if(parseInt(items)>0)
				 {
			
				 
				 document.getElementById("currkm").value=items;
				 }
			 else
				 {
				 
				 
				 }
			    
			}
		else
			{
			
			}  //type,description,remarks,lbrcost,partscost,total
	}
	x.open("GET","searchfleetkm.jsp?fleet_no="+document.getElementById("mtfleetno").value);

	x.send();
	
	
}
	 
	 $("#third").show();
	 
	 $("#thirdedit").hide();
	 

	
	$('#mtfleetno').attr('disabled', true);

	$('#currkm').attr('readonly', false);
	$('#nextserdue').attr('readonly', false);
	
	  $("#approvel").jqxGrid({ disabled: false});
	  $("#approvel").jqxGrid('addrow', null, {}); 
	   $("#apprsecgrid").jqxGrid({ disabled: false}); 
	   $("#apprsecgrid").jqxGrid('addrow', null, {});
	
}
function lastedits()
{
	
	 $("#last").show();	
	 $("#lastedit").hide();	
	
	 $("#posting").jqxGrid({ disabled: false});
	
	$('#invDate').jqxDateTimeInput({ disabled: false}); 
	
	
	$('#postDate').jqxDateTimeInput({ disabled: false}); 
	
	
	$('#invno').attr('readonly', false);

	
}




/* $('#currkm').attr('readonly', true);
$('#nextserdue').attr('readonly', true);

$('#maintype').attr('readonly', true);
$('#garagemaster').attr('disabled', true);


$('#invDate').jqxDateTimeInput({ disabled: true}); 
('#invno').attr('readonly', true); */




function getPostDetails(){
	var docno=$('#masterdoc_no').val();
	$('#postwindow').jqxWindow('open');
	postDetailsSearchContent('postDetailsGrid.jsp?docno='+docno+'&id=1');
}
function postDetailsSearchContent(url) {
	$.get(url).done(function (data) {
		$('#postwindow').jqxWindow('setContent', data);
	}); 
} 

</script>
    
<%-- <style>
.hidden-scrollbar {
 
  height: 580px;
    overflow-x: hidden;
    
} 

</style>   --%>


</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmmaint" action="saveMaintworkorder" name="maintworkorder" method="post" autocomplete="OFF">
<div class='hidden-scrollbar'> 
<jsp:include page="../../../../header.jsp" /><br/>



<fieldset>
<legend>Maintenance Work Order</legend>      
<table width="100%" >
<tr>
<td width="5%" align="right">Date</td> 
<td width="5%" align="left"><div id="maintainceDate" name="maintainceDate"  value='<s:property value="date_accountmaster"/>'></div>
<input type="hidden" id="hidmaintainceDate" name="hidmaintainceDate" value='<s:property value="hidmaintainceDate"/>'>

</td>
<td width="23.7%" align="right">Fleet No</td> <td width="11%" align="left"><input type="text" id="mtfleetno" name="mtfleetno" style="width:85%;" placeholder="Press F3 To Search"    value='<s:property value="mtfleetno"/>' onkeydown="getfleet(event)"></td>
<td align="right" width="8.5%">Name</td> <td align="left" width="30%"><input type="text" id="mtflname" style="width:89.7%;" tabindex="-1" name="mtflname" value='<s:property value="mtflname"/>'></td>

<td align="right" width="15%"> Doc No</td> <td align="left"><input type="text" id="docno" name="docno" tabindex="-1" value='<s:property value="docno"/>'></td>

</tr>
<tr>
<td align="right">Remarks</td><td colspan="5" align="left"> <input type="text" id="mtremark" name="mtremark" style="width:96.4%;"   value='<s:property value="mtremark"/>'></td>
<td>&nbsp;&nbsp;<label id="mainwk" name="mainwk" style="color:#b22222;font-weight:bold;font-size: 12px;"></label> </td><td>&nbsp;</td>
 
</tr>
</table>
 <%-- <table width="100%" >

<tr>
 <td align="right" width="3.4%">Type</td>
<td align="left" width="2%" ><select id="maintype" name="maintype" onchange="changetype()" value='<s:property value="maintype"/>'>
<option value="service">Service</option>
<option value="repair">Repair</option>   
</select>
</td> 

<td  align="right" width="2%"> Inv NO</td><td  align="left" width="1%"> <input type="text" id="invno" name="invno" value='<s:property value="invno"/>'></td>
<td  align="right" width="3%"> Inv Date</td><td  align="left" width="14%"> <div id="invDate" name="invDate"  value='<s:property value="invDate"/>'></div>
<input type="hidden" id="hidinvDate" name="hidinvDate" value='<s:property value="hidinvDate"/>'>

</td>

                                
</tr>
                        

</table>  --%> 
</fieldset>
<br>
 <table  width="100%">
<tr>
<td  width="100%">

<div class="divclass">
    <div id='jqxWidget'>
        <div style="float: left"  >
            <div id='jqxTabs' class='jqx-rc-all'  >
                <ul style="margin-left:1px;" id="unorderedList"   >
                    <li >
                        <div style="height: 30px;">
                           <img style='float: left;' width='24' height='24'   src="<%=contextPath%>/icons/maintreq.png" alt="" class="small-image" /> 
                            <div style="float: left; margin-left: 6px; text-align: center; margin-top: 5px; font-size: 13px;">
                                 Maintenance Required 
                               </div>
                        </div>
                    </li>
                    <li>
                        <div style="height: 30px;" id="worderdiv"  >   
                    <img style='float: left;' width='24' height='24' src="<%=contextPath%>/icons/maintworkorder.png" alt="" class="small-image" /> 
                            <div style="float: left; margin-left: 6px; text-align: center; margin-top: 5px; font-size: 13px;">
                                Work Order</div>
                        </div>
                    </li>
                    <li>
                        <div style="height: 30px;" id="jobappdiv"  >
                     <img style='float: left;' width='24' height='24' src="<%=contextPath%>/icons/maintapproval.png" alt="" class="small-image" /> 
                            <div style="float: left; margin-left: 6px; text-align: center; margin-top: 5px; font-size: 13px;">
                           Job Approval
                              </div>
                        </div>
                    </li>
                         <li>
                        <div style="height: 30px;" id="postdiv" >
                         <img style='float: left;' width='24' height='24' src="<%=contextPath%>/icons/maintposting.png" alt="" class="small-image" />
                            <div style="float: left; margin-left: 6px; text-align: center; margin-top: 5px; font-size: 13px;">
                          Posting
                              </div>
                        </div>
                    </li>
                </ul>
                <div class="content-container" style="width: 100%;" id="header1">
                    <div style="height: 350px">
                    <table width="100%">
                    <tr> <td width="2%">&nbsp;</td>
                    <td width="86%">
                    <div id="maingrid">
               <jsp:include page="maintGrid.jsp"></jsp:include></div></td> <td width="12%"> <br><br><br><br><br>
               <br><br><br><br><br><br><br><br><br><br><br><br>
               &nbsp; &nbsp; &nbsp; &nbsp;<input type="hidden" hidden="true" id="first" onclick="firstnext();"    ></td> </tr></table>
                    </div>
                    
                </div>
      
                         <div class="content-container" style="width: 100%;"  id="header2">
                    <div style="height: 350px">     
			   <table width="100%"  >
					
					<tr>
					<td align="right" width="1%">Type</td>
					<td align="left" width="2%" ><select id="maintype" name="maintype" onchange="changetype()" value='<s:property value="maintype"/>'>
					<option value="service">Service</option>
					<option value="repair">Repair</option>  
					<option value="both">Both</option>  
					<option value="accidentrepair">Accident Repair</option>    
					 
					</select>
					
					</td>
					<td align="right" width="1.2%">Garage</td><td align="left" width="12.5%"><input type="text" id="garagemaster"  name="garagemaster" placeholder="Press F3 To Search" style="width:30%;"  value='<s:property value="garagemaster"/>' onkeydown="getgarrage(event)"></td>
					</tr>
					</table>
					                    
                    
                                <table width="100%">
                    <tr> <td width="2%">&nbsp;</td>     
                    <td width="86%">
                        <div id="servgrid">
                              <jsp:include page="servicemaingrid.jsp"></jsp:include></div></td> <td width="12%"> <br><br><br><br><br>
               <br><br><br><br><br><br><br><br>
               &nbsp; &nbsp; <input type="button" id="secondedit" onclick="secondedits();" class="myButtonss" value="EDIT"><input type="button" id="second" hidden="true" onclick="secnext();" class="myButtonss" value="SAVE"></td> </tr></table>
                    </div>
                </div>
                <div class="content-container" style="width: 100%;" id="header3">  
                    <div style="height: 350px">
                    <table width="100%" >

<tr>
 
<td align="right" width="1%">Curr.KM</td><td align="left" width="2%"><input type="text" id="currkm" name="currkm"  onkeypress="javascript:return isNumber (event)"  value='<s:property value="currkm"/>'> </td>
<td align="right" width="1.2%">Next Ser.Due KM</td><td align="left" width="12.5%"><input type="text" id="nextserdue" name="nextserdue" onkeypress="javascript:return isNumber (event)" style="width:15%;" value='<s:property value="nextserdue"/>' > </td>
 

 
                                
</tr>
                       

</table>  

               
                        
                         <table width="100%"  >
                    <tr> <td width="2%">&nbsp;</td> 
                    <td width="86%">
                        
                  
                     <div id="imgdiv" ><div hidden="true" style="position:absolute;align:center; z-index: 1;top:300;right:400;" id="hidediv">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <br> <br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <img  alt="Search User" src="<%=contextPath%>/icons/31load.gif"> </div></div>     
                         
                              <div id="jobapprovel"> <jsp:include page="jobapprovel.jsp"></jsp:include></div>
                              <br>
                              <div id="jobapprovelsec">  <jsp:include page="approvelsecondgrid.jsp"></jsp:include></div>
                             
                              
                              
                              
                              </td> <td width="12%" align="center"> <br><br><br><br><br><br>
               <br><br> &nbsp;&nbsp;<input type="button" id="thirdedit" onclick="thirdedits();" class="myButtonss" value="EDIT"><input type="button" hidden="true" id="third" onclick="trdnext();" class="myButtonss" value="SAVE"></td> </tr></table>
                      
                    </div>
                </div>
                    <div class="content-container" style="width: 100%;" id="header4">
                    <div style="height: 350px">
                              <table width="100%" >

<tr>
 
<td  align="right" width="5%"> Inv No</td><td  align="left" width="2%"> <input type="text" id="invno" name="invno"   value='<s:property value="invno"/>'></td>
<td  align="right" width="5%"> Inv Date</td><td  align="left" width="12.5%"> <div id="invDate" name="invDate"  value='<s:property value="invDate"/>'></div>
<input type="hidden" id="hidinvDate" name="hidinvDate" value='<s:property value="hidinvDate"/>'>
</td>
<td  align="right" width="10%"> Posting Date</td>
<td  width="12.2%">
<div id="postDate" name="postDate"  value='<s:property value="postDate"/>'></div>
<input type="hidden" id="hidpostDate" name="hidpostDate" value='<s:property value="hidpostDate"/>'>


</td>
<td><button type="button" id="btnpostdetails" class="myButton" onclick="getPostDetails();">Post Details</button></td>
                                
</tr>
                        

</table>  
                     <table width="100%">
                    <tr> <td width="2%">&nbsp;</td>
                    <td width="86%">
                      
                         
                         
               
                         
                                <div id="postingss"> <jsp:include page="posting.jsp"></jsp:include></div></td> <td width="12%"> <br><br><br><br><br>
               <br><br><br><br><br><br> 
               
                <br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="button" id="lastedit" onclick="lastedits();" class="myButtonss" value="EDIT"><input type="button" id="last" hidden="true" onclick="lastsave();" class="myButtonss" value="SAVE"></td> </tr></table>
                      
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</td>
</tr>
</table> 
<%-- <fieldset>
<div id="maingrid">
<jsp:include page="maintGrid.jsp"></jsp:include></div>
</fieldset>

</div>

<fieldset>
<div id="servgrid">
<jsp:include page="servicemaingrid.jsp"></jsp:include></div>
</fieldset>  --%>



<input type="hidden" id="formstatus" name="formstatus" value='<s:property value="formstatus"/>'>

<input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'>
<input type="hidden" id="garrageid" name="garrageid" value='<s:property value="garrageid"/>'>
<input type="hidden" id="mtypename" name="mtypename" value='<s:property value="mtypename"/>'> <!--  mtypesearch from serviece grid -->
<input type="hidden" id="mtypename1" name="mtypename1" value='<s:property value="mtypename1"/>'> <!--  mtypesearch from appr grid -->

<input type="hidden" id="lbrtotalcost" name="lbrtotalcost" value='<s:property value="lbrtotalcost"/>'>  
<input type="hidden" id="partstotalcost" name="partstotalcost" value='<s:property value="partstotalcost"/>'> 	
<input type="hidden" id="totalcost" name="totalcost" value='<s:property value="totalcost"/>'>    


<input type="hidden" id="maintypeval" name="maintypeval" value='<s:property value="maintypeval"/>'>    


<input type="hidden" id="maintTrno" name="maintTrno" value='<s:property value="maintTrno"/>'>      

<input type="hidden" id="jvmDovno" name="jvmDovno" value='<s:property value="jvmDovno"/>'>    <!-- for docno jvm table  -->

<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'>
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'>
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>

<input type="hidden" id="maingridlength" name="maingridlength" value='<s:property value="maingridlength"/>'>

<input type="hidden" id="servicegridlenght" name="servicegridlenght" value='<s:property value="servicegridlenght"/>'>


<input type="hidden" id="postvals" name="postvals" value='<s:property value="postvals"/>'>



<input type="hidden" id="selectgridtype" name="selectgridtype" value='<s:property value="selectgridtype"/>'>
<!-- 
//status -->
<input type="hidden" id="stop" name="stop" value='<s:property value="stop"/>'>

<input type="hidden" id="stop1" name="stop1" value='<s:property value="stop1"/>'>

<input type="hidden" id="workstatus" name="workstatus" value='<s:property value="workstatus"/>'>
<input type="hidden" id="apprstatus" name="apprstatus" value='<s:property value="apprstatus"/>'>
<input type="hidden" id="approvalstatus" name="approvalstatus" value='<s:property value="approvalstatus"/>'>              
<input type="hidden" id="postingstatus" name="postingstatus" value='<s:property value="postingstatus"/>'>

 </div>  


</form>
<div id="fleetsearchwindow">
   <div ></div>
</div>
<div id="typeservsearchwndow">
   <div ></div>
</div>
 <div id="serdescsearchwndow">
   <div ></div>
</div> 
 <div id="garragesearchwindow">
   <div ></div>
</div>
 <div id="typessearchswindow">
   <div ></div>
</div>
 <div id="damagewindow">
   <div ></div>
</div>
<div id="postwindow">
   <div ></div>
</div>

</div>
 
	
</body>
</html>