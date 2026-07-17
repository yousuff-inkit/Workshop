
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
	 
	 
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#importfromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#importtodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	     
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	  $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
     
	 
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
	 
	 
	 
	 
    
});




function funreload(event)
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
	  $("#autolinediv").load("autolineGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&check=1");
		   }
		 
	
	}

function funExportBtn(){
	JSONToCSVCon(dataexcelautoline, 'Autoline', true);
	 }



function funimport(){
	var fromdates=new Date($('#importfromdate').jqxDateTimeInput('getDate'));
	var todates=new Date($('#importtodate').jqxDateTimeInput('getDate'));  
	 
  if(fromdates>todates){
	   
	   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
  	   return false;
 	} 
  else{
	    
	   
  	 var fromdate= $("#importfromdate").val();
		var todate= $("#importtodate").val(); 
		$("#overlay, #PleaseWait").show();
				
		 importdata(fromdate,todate);
  	}
}

function  importdata(fromdate,todate)
{
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		 	var items= x.responseText.trim();
		 	if(parseInt(items)==1)
			{
		 		$("#overlay, #PleaseWait").hide();	
			  $.messager.alert('Message',' Data Imported ','warning'); 
  
			   return 0;
			
			}
     }
	}
	x.open("GET","importdata.jsp?importfromdate="+fromdate+"&importtodate="+todate,true);
     x.send();
	
	
 
	}
	
function hiddenbrh(){
	
	$("#branchlabel").attr('hidden',true);
	$("#branchdiv").attr('hidden',true);
 
	
}

</script>
</head>
<body onload="hiddenbrh();">
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
       	 
 
   <tr> <td colspan="2">
<!-- 	<fieldset> -->
 
<table width="100%"  >
<tr><td>
	
	
	
	<div id="out" style="width: 100% ; align:left; height: 120px;  "  > 
		<fieldset>
	<legend>Import Data</legend> 
<table width="100%" >
			<tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id="importfromdate" name="importfromdate" value='<s:property value="importfromdate"/>'></div>
			<tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id="importtodate" name="importtodate" value='<s:property value="importtodate"/>'></div>
			<tr>
				<td colspan="2" align="center"><input type="Button" name="import" id="import" class="myButton" value="import" onclick="funimport();">&nbsp;

			</tr>


</table>
		</fieldset>

</div>

</td>
 <tr> 

	<tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>

	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>


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
			 <td><div id="autolinediv"><jsp:include page="autolineGrid.jsp"></jsp:include></div></td>
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