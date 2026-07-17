<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- <link href="../../../../css/main.css" rel="stylesheet" type="text/css" />
<link href="../../../../css/body.css" media="screen" rel="stylesheet" type="text/css" />
 -->
 <jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript">

$(document).ready(function () {     
  $("#tsDate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"}); 
  $('#tafficfleetsearchwindow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Fleet Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
  $('#tafficfleetsearchwindow').jqxWindow('close');
  $('#salickfleetsearchwindow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Fleet Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
  $('#salickfleetsearchwindow').jqxWindow('close');	
      		 });
		 
function salickinfoSearchContent(url) {
 	 //alert(url);
 		 $.get(url).done(function (data) {
 			 
 			 $('#salickfleetsearchwindow').jqxWindow('open');
 		$('#salickfleetsearchwindow').jqxWindow('setContent', data);
 
 	}); 
 	} 
     function trafficinfoSearchContent(url) {
      	 //alert(url);
      		 $.get(url).done(function (data) {
      			 
      			 $('#tafficfleetsearchwindow').jqxWindow('open');
      		$('#tafficfleetsearchwindow').jqxWindow('setContent', data);
      
      	}); 
      	} 

function funFocus(){
	document.getElementById("tsDate").focus();
}
function funReset() {
	
}
function funReadOnly() {
	$('#frmsalic input').attr('readonly', true);
	$('#frmsalic select').attr('disabled', true);
	$('#tsDate').jqxDateTimeInput({ disabled: true});
    $("#salikgrid").jqxGrid({ disabled: true});
    $("#traficgrid").jqxGrid({ disabled: true});
	/* 	$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
}
function funRemoveReadOnly() {
	$('#frmsalic input').attr('readonly', false);
	
	$('#frmsalic select').attr('disabled', false);
	$('#tsDate').jqxDateTimeInput({ disabled: false});
    $("#salikgrid").jqxGrid({ disabled: false});
    $("#traficgrid").jqxGrid({ disabled: false});
    
    $('#traficdocno').attr('readonly', true);
    
    if ($("#mode").val() == "A") {
		
		 $('#tsDate').val(new Date());
	     $("#salikgrid").jqxGrid('clear');
	    $("#salikgrid").jqxGrid('addrow', null, {});
	    $("#traficgrid").jqxGrid('clear');
	    $("#traficgrid").jqxGrid('addrow', null, {});
	    $("#trafficdiv").prop("hidden", false);
		 $("#salikdiv").prop("hidden",true);
	   }
    
					  


    
	
        }

function funNotify(){

	 if($('#entry').val()=="salik")
	 {
		  
		   var rows = $("#salikgrid").jqxGrid('getrows');
	   var minaa;
	
	   for(var i=0;i<rows.length;i++){
     	
     		  if(rows[i].fleetno>0)
		        {
			  
	    		minaa=1;
	    		break;
	    	     }
	    	else{
	    		minaa=0;
	    	     }
	    	
	    if(minaa==0){
	    	
	    	 document.getElementById("errormsg").innerText="Enter Salik Details";  
	    	  return 0;
	            } 
	   
	   }  
	 

	   
	   for(var i=0 ; i < rows.length ; i++){
	    	
		   if(rows[i].fleetno>0)
	        {
		        	
			 
							    if(rows[i].hiddate==""||rows[i].hiddate==null)
								{
							    
								           document.getElementById("errormsg").innerText="Enter Date";  
						    	           return 0;
								}
					} 
				 	     
	 
	         }
	   var rows = $("#salikgrid").jqxGrid('getrows');
	    $('#salickgridlenght').val(rows.length);
	  
	   for(var i=0 ; i < rows.length ; i++){
	
	    newTextBox = $(document.createElement("input"))
	       .attr("type", "dil")
	       .attr("id", "salicktest"+i)
	       .attr("name", "salicktest"+i)
	       .attr("hidden", "true"); 

	   newTextBox.val(rows[i].fleetno+"::"+rows[i].regno+" :: "+rows[i].tagno+" :: "
			   +rows[i].hiddate+" :: "+rows[i].hidtime+" :: "+rows[i].transaction+" :: "+rows[i].direction+" :: "
			   +rows[i].source+" :: "+rows[i].amount+" :: "+rows[i].location+" :: ");
	
	   newTextBox.appendTo('form');
	  
	    
	   } 
	 }
	
	   else
		   {
		   var rows = $("#traficgrid").jqxGrid('getrows');
		   var minaa;
		   for(var i=0;i<rows.length;i++){
	     		
			   if(rows[i].fleetno>0)
		        {
		    		minaa=1;
		    		break;
		    	     }
		    	else{
		    		minaa=0;
		    	     }
		    	
		    if(minaa==0){
		    	
		    	 document.getElementById("errormsg").innerText="Enter Traffic Details";  
		    	  return 0;
		            } 
		   
		   }  
		 
		   var rows = $("#traficgrid").jqxGrid('getrows');
		  
		   for(var i=0 ; i < rows.length ; i++){
		    	
			   if(rows[i].fleetno>0)
		        {
					    if(rows[i].hiddate==null)
						{
					 	    
						           document.getElementById("errormsg").innerText="Enter Date";  
				    	           return 0;
						}
				} 
		 
		       }
		 var rows = $("#traficgrid").jqxGrid('getrows');
		    $('#trafficgridlenght').val(rows.length);
		  
		   for(var i=0 ; i < rows.length ; i++){
		
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "traffictest"+i)
		       .attr("name", "traffictest"+i)
		       .attr("hidden", "true"); 
		 
		   newTextBox.val(rows[i].fleetno+"::"+rows[i].regno+" :: "+rows[i].source+" :: "
				   +rows[i].finesource+" :: "+rows[i].fineno+" :: "+rows[i].hiddate+" :: "+rows[i].hidtime
				   +" :: "+rows[i].amount+" :: "+rows[i].description+" :: "+rows[i].location+" :: "+rows[i].pltid+" :: "+rows[i].tcno+" :: ");
		
		   newTextBox.appendTo('form');
		  
		    
		   } 
		   }
	return 1;
}
function funChkButton() {
	   /* funReset(); */
	  }
	  
function funSearchLoad(){
	changeContent('saltrafficMastersearch.jsp'); 
 }
 
 function gridchange()
 {


	 if($('#entry').val()=="salik")
	 {
		
		 $("#trafficdiv").prop("hidden", true);
		 $("#salikdiv").prop("hidden",false);
	 }
	 else
		 {
		 
		 $("#trafficdiv").prop("hidden", false);
		 $("#salikdiv").prop("hidden",true);
		 }
	 
 }
 function  chkChange()
 {
	 

 
 if($('#entryval').val()!="")
	 {
	 
	 $('#entry').val($('#entryval').val());
	 
	 }


		 var indexVal2 = document.getElementById("traficdocno").value;
		
	  if(indexVal2>0)
		 {
		 if($('#entryval').val()=="traffic")
			 {
			
			 $("#trafficdiv").prop("hidden", false);
			 $("#salikdiv").prop("hidden",true);
             $("#trafficdiv").load("traficGrid.jsp?trafficdocno="+indexVal2);
			 }
		 else
			 {
			 $("#trafficdiv").prop("hidden", true);
			 $("#salikdiv").prop("hidden",false);
			 $("#salikdiv").load("salikmainGrid.jsp?salickdocno="+indexVal2);	 
			 }

   		}
	  var indexVal3 = document.getElementById("traficdocno").value;
		
	  if(indexVal3==0)
		  {
		  if($('#entryval').val()=="traffic")
			 {
			
			 $("#trafficdiv").prop("hidden", false);
			 $("#salikdiv").prop("hidden",true);
        
			 }
		 else
			 {
			 $("#trafficdiv").prop("hidden", true);
			 $("#salikdiv").prop("hidden",false);
			
			 }
		  }
 }
 
	function setValues() {
		if($('#hidtsDate').val()){
			$("#tsDate").jqxDateTimeInput('val', $('#hidtsDate').val());
		}
		
		  
	
   	if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
	
   	
   	 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";		
   	chkChange();
		
	}
 
</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmsalic" action="saveSalik" method="post" autocomplete="off" >

<jsp:include page="../../../../header.jsp" /><br/>
<fieldset>
 <table width="100%" >
  <tr>
  <td width="20%" align="right">Entry</td>
  <td width="10%" align="left">
  <select name="entry" id="entry" style="width:50%;"  value='<s:property value="entry"/>' onchange="gridchange()">
      <option value="traffic">Traffic</option>
       <option value="salik">Salik</option>
    </select>
  </td>
   
  <td width="4%" align="right" > 
Date
  </td> 
    <td width="5%" align="left"><div id="tsDate" name="tsDate" value='<s:property value="tsDate"/>'></div>
    
    <input type="hidden" name="hidtsDate" id="hidtsDate" value='<s:property value="hidtsDate"/>'>
    </td>
  
  <td width="4%" align="right"> Doc NO </td>
 
  
    <td width="5%" align="left"><input type="text" name="traficdocno" id="traficdocno"  tabindex="-1" value='<s:property value="traficdocno"/>'></td>
 
   
 <td width="30%"></td>
    </tr>
      
</table> 

</fieldset>
<br>
<fieldset>
 
<div id="trafficdiv"  ><jsp:include page="traficGrid.jsp"></jsp:include></div> 


<div id="salikdiv" hidden="true"><jsp:include page="salikmainGrid.jsp"></jsp:include></div> 




</fieldset> 
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'>
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'>

<input type="hidden" id="entryval" name="entryval" value='<s:property value="entryval"/>'>

<input type="hidden" id="salickgridlenght" name="salickgridlenght" value='<s:property value="salickgridlenght"/>'>
<input type="hidden" id="trafficgridlenght" name="trafficgridlenght" value='<s:property value="trafficgridlenght"/>'>

</form>


<div id="salickfleetsearchwindow">   <div ></div>
</div>




<div id="tafficfleetsearchwindow">    <div ></div></div>



</div>
 
	
</body>
</html>