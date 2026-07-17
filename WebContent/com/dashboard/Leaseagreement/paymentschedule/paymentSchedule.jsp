
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
	
	 $("#pytdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	// $("#postdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	$('#pytdate').on('change', function (event) 
				{  
					var docdateval=funDateInPeriod($('#pytdate').jqxDateTimeInput('getDate'));
					if(docdateval==0){
						$('#pytdate').jqxDateTimeInput('focus');
						return false;
					}
				});

   
});


 function funExportBtn(){
 
	  
	 JSONToCSVCon(pytdata, 'InvoiceList', true);
	 } 

function funreload(event)
{
	 var barchval = document.getElementById("cmbbranch").value;
	 var pdate = $('#pytdate').val();
 
	  $("#overlay, #PleaseWait").show();
	  $("#pytschedule").load("paymentScheduleGrid.jsp?barchval="+barchval+'&pdate='+pdate);
	
	
	}


/* function fungenerate()
{
        
	 var selectedrows=$("#pmtschedulegrid").jqxGrid('selectedrowindexes');
	 var selectedRowIndexes = $("#pmtschedulegrid").jqxGrid('getselectedrowindexes').length;
	 var listss = new Array();
	
	 if(selectedRowIndexes==0)
		 {
		 $.messager.alert('Message', 'Select Document' );
		 }
	 else{
  
		 $.messager.confirm('Message', 'Do you want to Generate?', function(r){
     	    
     	 if(r==false)
     	  {
     		return false; 
     	  }
     	else{
     		var a = 1;
     		 for(var i=0;i<selectedRowIndexes;i++)
    		 {
    		
    		 listss.push($('#pmtschedulegrid').jqxGrid('getcellvalue', selectedrows[i], "lano")
    				 +"::"+$('#pmtschedulegrid').jqxGrid('getcellvalue', selectedrows[i], "doc_no")
    				 +"::"+$('#pmtschedulegrid').jqxGrid('getcelltext', selectedrows[i], "cldocno")
    				 +"::"+$('#pmtschedulegrid').jqxGrid('getcellvalue', selectedrows[i], "clacno")
    				 +"::"+$('#pmtschedulegrid').jqxGrid('getcellvalue', selectedrows[i], "amount")
    				 +"::"+$('#pmtschedulegrid').jqxGrid('getcellvalue', selectedrows[i], "brhid")
    				// +"::"+$('#pmtschedulegrid').jqxGrid('getcellvalue', selectedrows[i], "userid")
    				 +"::"+$('#pmtschedulegrid').jqxGrid('getcellvalue', selectedrows[i], "fleetno")
    				 +"::"+$('#pmtschedulegrid').jqxGrid('getcellvalue', selectedrows[i], "period2")
    				 +"::"+$('#pmtschedulegrid').jqxGrid('getcellvalue', selectedrows[i], "srno")
    				  +"::"+$('#pmtschedulegrid').jqxGrid('getcelltext', selectedrows[i], "dates")+"::"+a+"::");
    		 
    		 }
    		    
    		  //   var postdate= $("#postdate").val(); 
    		     
     	 		var x=new XMLHttpRequest();
     			x.onreadystatechange=function(){
     			if (x.readyState==4 && x.status==200)
     				{
     				 var items= x.responseText;
     				 	var itemval=items.trim();
     				 	
       	  if(parseInt(itemval)==1)
     	  	{
     		  $.messager.alert('Message', 'Invoice Generated Successfully' );
     		
     		  funreload(event);
     				 	
     				}
     			else
     				{
     				$.messager.alert('Message', '  Not Generated ');
     				}  
     		}
     		}
     		 
     	x.open("POST","savedata.jsp?list="+listss);
    //	x.open("GET","savedata.jsp?list="+listss+"&postdate="+postdate);
     		x.send();
     		 
     	}
    });
  
}
} */

function fungenerate(){
	var docdateval=funDateInPeriod($('#pytdate').jqxDateTimeInput('getDate'));
					if(docdateval==0){
						$('#pytdate').jqxDateTimeInput('focus');
						return false;
					}
	var selectedrows=$("#pmtschedulegrid").jqxGrid('selectedrowindexes');
	var selectedRowIndexes = $("#pmtschedulegrid").jqxGrid('getselectedrowindexes').length;
	if(selectedRowIndexes==0)
	 {
	 	$.messager.alert('Message', 'Select Document' );
	 }
	else{
	 	$.messager.confirm('Message', 'Do you want to Generate?', function(r){
	 		if(r==false)
	  		{
				return false; 
	  		}
			else{
				var a = 1;
				var z=0;
				$('#invgridlength').val(selectedRowIndexes);
		 		for(var i=0;i<selectedRowIndexes;i++)
		 			{
		 			newTextBox = $(document.createElement("input"))
				    .attr("type", "dil")
				    .attr("id", "testinvoice"+z)
				    .attr("name", "testinvoice"+z)
				    .attr("hidden","true");
					
					newTextBox.val($('#pmtschedulegrid').jqxGrid('getcellvalue', selectedrows[i], "lano")
						 +"::"+$('#pmtschedulegrid').jqxGrid('getcellvalue', selectedrows[i], "doc_no")
						 +"::"+$('#pmtschedulegrid').jqxGrid('getcelltext', selectedrows[i], "cldocno")
						 +"::"+$('#pmtschedulegrid').jqxGrid('getcellvalue', selectedrows[i], "clacno")
						 +"::"+$('#pmtschedulegrid').jqxGrid('getcellvalue', selectedrows[i], "amount")
						 +"::"+$('#pmtschedulegrid').jqxGrid('getcellvalue', selectedrows[i], "brhid")
						// +"::"+$('#pmtschedulegrid').jqxGrid('getcellvalue', selectedrows[i], "userid")
						 +"::"+$('#pmtschedulegrid').jqxGrid('getcellvalue', selectedrows[i], "fleetno")
						 +"::"+$('#pmtschedulegrid').jqxGrid('getcellvalue', selectedrows[i], "period2")
						 +"::"+$('#pmtschedulegrid').jqxGrid('getcellvalue', selectedrows[i], "srno")
						  +"::"+$('#pmtschedulegrid').jqxGrid('getcelltext', selectedrows[i], "dates"));
				
					newTextBox.appendTo('form');
					z++;		 
				}
		 		document.getElementById("mode").value='A';
				$("#overlay, #PleaseWait").show();
				document.getElementById("frmPaymentScheduler").submit();
			}
	 	});
	}
}

function setValues(){
	if($('#msg').val()!=''){
		$.messager.alert('Message',''+$('#msg').val());
	}
}
</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmPaymentScheduler" action="saveDashboardPaymentScheduler" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	  <tr>
	<td align="right" width="20%"><label class="branch">Up To</label></td>
            <td align="left"><div id="pytdate" name="pytdate" value='<s:property value="pytdate"/>'></div></td>
	</tr> 
	 <tr><td colspan="2">&nbsp;</td></tr> 
 
  <%--  <tr>
	<td align="right"><label class="branch">Post Date</label></td>
            <td align="left"><div id="postdate" name="postdate" value='<s:property value="postdate"/>'></div></td>
	</tr>  --%>
 
 <tr><td colspan="2">&nbsp;</td></tr> 
 
 <tr><td colspan="2" align="center"><input type="button" class="myButton" name="generate" id="generate"  value="Generate" onclick="fungenerate()"></td></tr>
 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 
	<tr>
	<td colspan="2"><div id='payt' style="width: 100% ; align:right; height: 150px;"></div></td> 
	</tr> 
	
	<tr>
	<td colspan="2">
	
	<%-- <input type="hidden" name="cldocno" id="cldocno"  value='<s:property value="cldocno"/>'>
	<input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>'>
	<input type="hidden" name="clacno" id="clacno"  value='<s:property value="clacno"/>'>
	<input type="hidden" name="amt" id="amt" value='<s:property value="amt"/>'>
	<input type="hidden" name="lano" id="lano" value='<s:property value="lano"/>'>
	<input type="hidden" name="branchid" id="branchid" value='<s:property value="branchid"/>'> --%>
	</td> 
	</tr> 
	
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="pytschedule"><jsp:include page="paymentScheduleGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>
	 <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
	 <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
	 <input type="hidden" name="invgridlength" id="invgridlength" value='<s:property value="invgridlength"/>'>
</div>
</form>
</body>
</html>