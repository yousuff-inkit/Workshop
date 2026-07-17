
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
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
	
	 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
    /* Partial Pie Chart Starts*/
    	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    
	$("#cmbbranch").attr('hidden',true);
    $("#hidediv").hide();
    $('#commenwindow1').jqxWindow({width: '71%', height: '70%',  maxHeight: '70%' ,maxWidth: '80%' , title: 'Details',position: { x: 180, y: 60 } , theme: 'energyblue', showCloseButton: true,keyboardCloseKey: 27});
	   $('#commenwindow1').jqxWindow('close');
 
	   
	   $('#commenwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#commenwindow').jqxWindow('close');
   
	     
	   $('#fleetwindow').jqxWindow({ width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Fleet Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#fleetwindow').jqxWindow('close');
	   
	    $('#typesearch').dblclick(function(){
	  	    
	    	  if(document.getElementById("trftype").value=="RAG")
			   {
		   $('#commenwindow1').jqxWindow('open');
	       raSearchContent('ramasterSearch.jsp'); 
		   }
	    	  else if(document.getElementById("trftype").value=="LAG")
			   {
	    		  $('#commenwindow1').jqxWindow('open');
	    		     raSearchContent('lamasterSearch.jsp'); 
			   }
	    	  else if(document.getElementById("trftype").value=="DRV" || document.getElementById("trftype").value=="STF")
			   {
	    		  $('#commenwindow').jqxWindow('open');
	    		     SearchContent('searchdrvandstaff.jsp?values='+document.getElementById("trftype").value); 
			   }
	    	  
	       
       });
	    
	    
	    $('#fleet_no').dblclick(function(){
	  	    $('#fleetwindow').jqxWindow('open');
	   
	       fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow')); 
       });
});

function getfleet(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#fleetwindow').jqxWindow('open');


	 fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow'));    }
	 else{
		 }
	 } 
function fleetSearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 
			 $('#fleetwindow').jqxWindow('open');
		$('#fleetwindow').jqxWindow('setContent', data);

	}); 
	} 


function gettypessearch(event){
	 var x= event.keyCode;
	 if(x==114){

   	  if(document.getElementById("trftype").value=="RAG")
		   {
	   $('#commenwindow1').jqxWindow('open');
      raSearchContent('ramasterSearch.jsp'); 
	   }
   	  else if(document.getElementById("trftype").value=="LAG")
		   {
   		  $('#commenwindow1').jqxWindow('open');
   		     raSearchContent('lamasterSearch.jsp'); 
		   }
   	  else if(document.getElementById("trftype").value=="DRV" || document.getElementById("trftype").value=="STF")
		   {
   		  $('#commenwindow').jqxWindow('open');
   		     SearchContent('searchdrvandstaff.jsp?values='+document.getElementById("trftype").value); 
		   }
	 
	 
	 
	 
	 }
	 else{
		 }
	 } 
	 
	 
function SearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 
			 $('#commenwindow').jqxWindow('open');
		$('#commenwindow').jqxWindow('setContent', data);

	}); 
	} 
function raSearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 
			 $('#commenwindow1').jqxWindow('open');
		$('#commenwindow1').jqxWindow('setContent', data);

	}); 
	} 


function funExportBtn(){
	   $("#trafficGrid").jqxGrid('exportdata', 'xls', 'Traffic Fine-Unallocated');
	 }


function funreload(event)
{     
	dis();

	  var val ="2";
	  var uptodate=$("#uptodate").val();
	   $("#overlay, #PleaseWait").show();
	  $("#allodiv").load("allocatelistGrid.jsp?chval="+val+"&uptodate="+uptodate);
	
	
	}
	
	
	function hiddenbrh(){
		
		$("#branchlabel").attr('hidden',true);
		$("#branchdiv").attr('hidden',true);
		$('#gridlength').val(""); 
		getsubBranch();
	}
	
	
	function funallocate()
	{
	

	    $.messager.confirm('Message', 'Do you want to Allocate?', function(r){
	     	  
		        
	     	if(r==false)
	     	  {
	     		return false; 
	     	  }
	     	else{
	  
	     		$("#hidediv").show();
		/*    for(var i=0 ; i < rows.length ; i++){ */
		var saveval="10";

			 /*   ajaxcall(rows[i].fleet_no,rows[i].rdocno,rows[i].trancode,rows[i].trans,rows[i].tagno,saveval); */
			   ajaxcall(saveval);
	
		/*    }    */
	     	}
	    });
	}
	
/* 	function ajaxcall(fleet_no,rdocno,trancode,trans,tagno,saveval){ */
	
		function ajaxcall(saveval){
	
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 var items= x.responseText;
				 	var itemval=items.trim();
				
				
				    if(parseInt(itemval)=="10")
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
				    	
				    	}
				    
				    
				}
			else
				{
				
				}
		}
		x.open("GET","savedata.jsp?saveval="+saveval);
	//	x.open("GET","savedata.jsp?fleet_no="+fleet_no+"&rdocno="+rdocno+"&trancode="+trancode+"&trans="+trans+"&tagno="+tagno+"&saveval="+saveval,true);
		x.send();
	}
		function getsubBranch() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
			 
					items = items.split('####');
					var optionsbranch ="" ;
					var branchIdItems  = items[0].split(",");
					var branchItems = items[1].split(",");
				
					for (var i = 0; i < branchItems.length; i++) {
						optionsbranch += '<option value="' + branchIdItems[i].trim() + '">'
								+ branchItems[i] + '</option>';
					}
					$("select#branchsss").html(optionsbranch);
					/* if ($('#hidcmbbranch').val() != null) {
						$('#cmbbranch').val($('#hidcmbbranch').val());
					} */
				} else {
					//alert("Error");
				}
			}
			x.open("GET","<%=contextPath%>/com/dashboard/getBranch.jsp", true);
			x.send();
		}
		
	function funoneallocate()
	{

		
		
		if(document.getElementById("fleet_no").value=="")
			{
			
			 $.messager.alert('Message',' Search Fleet ','warning');    
	                	 
	            return false;
			
			}
		if(document.getElementById("typesearch").value=="")
			
			{
			
			 $.messager.alert('Message','Convict Search  ','warning');    
        	 
	            return false;
			
			
			}
		
		   $.messager.confirm('Message', 'Do you want to Allocate?', function(r){
	        	  
 		       
		        	if(r==false)
		        	  {
		        		return false; 
		        	  }
		        	else{
		        		doprocess();
		        	   }
     });
	
	
	}
		
		
		
		
		
		
		
	function doprocess()
	{
		  
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 var items= x.responseText;
				 	var itemval=items.trim();
				
				
				 
				   if(parseInt(itemval)=="10")
				    	{
				    	
				    	   $.messager.alert('Message', '  Record Successfully Allocated ');
				    var val="2";
						  var uptodate=$("#uptodate").val();
						  $("#allodiv").load("allocatelistGrid.jsp?chval="+val+"&uptodate="+uptodate);
					       $("#hidediv").hide();
					       dis();
					       funreload(event);
		
				    	}
				    else
				    	{
				    	
				    	  $.messager.alert('Message', '  Not Allocated ');
					      // funreload(event);
					       $("#hidediv").hide();
				    	
				    	}
				    
				    
				}
			else
				{
				
				}                                                                // trftype branchsss   rentaldoc leasedoc drdoc staffdoc
		}
		x.open("GET","saveonedata.jsp?ticketno="+document.getElementById("ticketno").value+"&trftype="+document.getElementById("trftype").value
				+"&branchsss="+document.getElementById("branchsss").value+"&rentaldoc="+document.getElementById("rentaldoc").value
				+"&leasedoc="+document.getElementById("leasedoc").value+"&drdoc="+document.getElementById("drdoc").value
				+"&staffdoc="+document.getElementById("staffdoc").value+"&fleet_no="+document.getElementById("fleet_no").value);
	
		x.send();	
		
	}
		function dis()
		{
	
		
			
			document.getElementById("ticketno").value="";
			document.getElementById("fleet_no").value="";
			document.getElementById("typesearch").value="";
			 
		 
			 		
			document.getElementById("rentaldoc").value="";
			document.getElementById("leasedoc").value="";
			document.getElementById("drdoc").value="";
			document.getElementById("staffdoc").value="";
			
			
			 $('#ticketno').attr("disabled",true);
			 
			 $('#fleet_no').attr("disabled",true);
			 $('#trftype').attr("disabled",true);
			 $('#branchsss').attr("disabled",true);
			 $('#allocates').attr("disabled",true);
			 $('#typesearch').attr("disabled",true);
			 

			
			
		//	ticketno fleet_no trftype branchsss typesearch allocates  rentaldoc leasedoc drdoc staffdoc
		
		}
		
		
	function cleardatas()
	{
		document.getElementById("typesearch").value="";
		document.getElementById("rentaldoc").value="";
		document.getElementById("leasedoc").value="";
		document.getElementById("drdoc").value="";
		document.getElementById("staffdoc").value="";
	
	}
		
		function funExportBtn()
{
	
	
	
	 if(parseInt(window.parent.chkexportdata.value)=="1")
	  {
	  	JSONToCSVCon(dats, 'Un Allocated', true);
	  }
	 else
	  {
	                 
		 $("#trafficGrid").jqxGrid('exportdata', 'xls', 'Un Allocated');
	  }
	 
	
	}
</script>
</head>
<body onload="hiddenbrh();dis();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>
 
	<!--  <tr><td colspan="2">&nbsp;</td></tr> -->

  <tr><td colspan="2">&nbsp;</td></tr> 
   <tr><td colspan="2">&nbsp;</td></tr> 
   
    <tr><td width="20%" align="right"><label class="branch">Up To</label></td><td align="left"><div id='uptodate' name='uptodate' value='<s:property value="uptodate"/>'></div></td></tr> 
     <tr><td colspan="2">&nbsp;</td></tr> 
     
   <tr><td  align="center" colspan="2"><input type="Button" name="driverUpdate" id="driverUpdate" class="myButton" value="Allocate" onclick="funallocate()"></td> </tr>     
   <tr><td colspan="2">&nbsp;</td></tr> 
	    <tr><td colspan="2">&nbsp;</td></tr> 
 <tr>
	<td colspan="2"><div id='cpppp' >
	<fieldset>
	<legend>Manual Allocate</legend>
	<table width="100%" >
              <tr><td width="24%" align="right"><label class="branch">Ticket No</label></td><td align="left"><input type="text" id="ticketno"  readonly="readonly"   style="height:20px;"  name="ticketno" value='<s:property value="ticketno"/>'></td></tr>
         
            
             <tr><td width="20%" align="right"><label class="branch">Fleet NO</label></td><td align="left"><input type="text" id="fleet_no" placeholder="Press F3 TO Search"  readonly="readonly" onkeydown="getfleet(event);"  style="height:20px;"  name="fleet_no" value='<s:property value="fleet_no"/>'></td></tr>
             <tr><td width="20%" align="right"><label class="branch">Type</label></td><td align="left">
             <select id="trftype" style="height:20px;width:86%; " onchange="cleardatas()" > 
             <option value="RAG" >Rental</option>
             <option value="LAG">Lease</option>
             <option value="STF">Staff</option>
             <option value="DRV">Driver</option>
              
             </select>
             
    <tr><td width="20%" align="right"><label class="branch">Branch</label></td><td align="left"> 
          <select id="branchsss" style="height:20px;width:86%; " name="branchsss"   value='<s:property value="branchsss"/>'>
      <option value="">--Select--</option></select></td></tr>
      
      <tr><td width="20%" align="right"><label class="branch">Convict</label></td><td align="left"><input type="text" id="typesearch"  placeholder="Press F3 TO Search" readonly="readonly"    onkeydown="gettypessearch(event)" onclick="this.placeholder='' "  style="height:20px;"  name="typesearch" value='<s:property value="typesearch"/>'></td></tr>
              <tr><td colspan="2">&nbsp;</td></tr> 
                <tr><td  align="center" colspan="2"><input type="Button" name="allocates" id="allocates" class="myButton" value="Manual" onclick="funoneallocate()"></td> </tr>  

          <tr><td colspan="2"><input type="hidden" id="gridlength" name="gridlength"></td></tr> 
          <tr><td colspan="2"><input type="hidden" id="rentaldoc" name="rentaldoc"></td></tr> 
          <tr><td colspan="2"><input type="hidden" id="leasedoc" name="leasedoc"></td></tr> 
          <tr><td colspan="2"><input type="hidden" id="drdoc" name="drdoc"></td></tr> 
         <tr><td colspan="2"><input type="hidden" id="staffdoc" name="staffdoc"></td></tr> 

	</table>
	
	    
	</fieldset>
	</div>
	</td>
	
	</tr>
	 <tr><td colspan="2">&nbsp;</td></tr> 
	  
	</table>
	
	  
	 <div id="imgdiv" style="position:absolute; z-index: 1;top:200;right:600;"><div hidden="true" id="hidediv"><img  alt="Search User" src="<%=contextPath%>/icons/31load.gif"> </div></div>
	</fieldset>
</td>

<td width="80%">
<form action="">
	<table width="100%">
		<tr>
 <td><div id="allodiv"><jsp:include page="allocatelistGrid.jsp"></jsp:include></div></td>
 
		</tr>
	</table>
	</form>
	</td>
</tr>
</table>
</div>
<div id="fleetwindow">
   <div ></div>
</div>
<div id="commenwindow1">
   <div ></div>
</div>

<div id="commenwindow">
   <div ></div>
</div>

</div>
</body>
</html>