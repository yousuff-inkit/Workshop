
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/resample.js"></script>
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
	 
	 
	
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	     /*  $("body").prepend('<div id="overlaysub" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWaitsub' style='display: none;position:absolute; z-index: 1;top:230px;left:120px;'><img src='../../../../icons/31load.gif'/></div>");

	 //    $('#fieldnoallot').hide();
	     $('#fieldvehrel').hide();
	     
	     $('#fieldpur').hide();
	     $('#fieldfleet').hide();
	//     $('#fieldcomp').hide();
	     $('#purchasePrint').attr("disabled",true);
	$('#fleetdetaildiv').hide();
	
	 $('#dealerinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '85%' ,maxWidth: '70%' ,title: 'Dealer Search' , position: { x: 200, y: 120 }, keyboardCloseKey: 27});
	 $('#dealerinfowindow').jqxWindow('close');
	 $('#fleetinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '85%' ,maxWidth: '70%' ,title: 'Fleet Search' , position: { x: 200, y: 120 }, keyboardCloseKey: 27});
	 $('#fleetinfowindow').jqxWindow('close');
	 $('#salpersonwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '85%' ,maxWidth: '70%' ,title: 'Sales Person Search' , position: { x: 200, y: 120 }, keyboardCloseKey: 27});
	 $('#salpersonwindow').jqxWindow('close');
	 $('#purdealer').dblclick(function(){
		 var stat="PO";
	  	    $('#dealerinfowindow').jqxWindow('open');
          $('#dealerinfowindow').jqxWindow('focus');
         dealerinfoSearchContent('dealerMSearch.jsp?stat='+stat); 
         });
	 
	 $('#dealer').dblclick(function(){
		 var stat="FU";
	  	    $('#dealerinfowindow').jqxWindow('open');
       $('#dealerinfowindow').jqxWindow('focus');
      dealerinfoSearchContent('dealerMSearch.jsp?stat='+stat); 
      });
	 $('#salperson').dblclick(function(){
		
	  	    $('#salpersonwindow').jqxWindow('open');
       $('#salpersonwindow').jqxWindow('focus');
      salpersonSearchContent('salpersonsearch.jsp'); 
      });
	 $('#txtfleetno').dblclick(function(){
	  	    $('#fleetinfowindow').jqxWindow('open');
    $('#fleetinfowindow').jqxWindow('focus');
    fleetinfoSearchContent('fleetsearch.jsp?brdid='+document.getElementById("brandid").value+'&modid='+document.getElementById("modelid").value); 
   });
	 
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	    
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#fleetdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $('#todate').on('change', function (event) {
			
		   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  }   
	 });
	 
	 
	 fundisable(); */
});

/* function funExportBtn(){
	   $("#qutfollowgrid").jqxGrid('exportdata', 'xls', 'Quotation Follow Up');
	 } */

function funreload(event)
{
		 var barchval = document.getElementById("cmbbranch").value;
		
		 if (document.getElementById('radio_cancel').checked) {
				
			 satcateg=$("#radio_cancel").val();
			 //alert(satcateg);
			
			 $("#overlay, #PleaseWait").show();
			 
			  $("#leasefollowdiv").load("leasecancelGrid.jsp?barchval="+barchval+"&satcateg="+satcateg);
			  
			}
		 else if (document.getElementById('radio_cancellist').checked) {
				
			 satcateg=$("#radio_cancellist").val();
			// alert(satcateg);
			 $("#overlay, #PleaseWait").show();
			 
			  $("#leasefollowdiv").load("leasecancelGrid.jsp?barchval="+barchval+"&satcateg="+satcateg);
			  
			}
		 
		 
		 
		 
}

	

function funupdate()
{
	var testdate= $('#date').val();
	if(document.getElementById("srno").value==""){
		 $.messager.alert('Message',"Select Document");
		 return false;
	}
	
	
	if(document.getElementById("remarks").value==""){
		 $.messager.alert('Message',"Please Enter Remarks");
		 return false;
	}
	//alert(testdate);
	var srno = document.getElementById("srno").value;
	var leasereqdocno = document.getElementById("leasereqdocno").value;
	var remarks = document.getElementById("remarks").value;
	var refno =document.getElementById("refno").value;
	var clientname =document.getElementById("clientname").value;
	//var username =document.getElementById("username").value;
	 $.messager.confirm('Message', 'Do you want to Update?', function(r){
    	  
	        
	     	if(r==false)
	     	  {
	     		return false; 
	     	  }
	     	else{
	     		 savegriddata(srno,leasereqdocno,testdate,remarks,refno,clientname);
	     		}
		     });
	
}

function savegriddata(srno,leasereqdocno,testdate,remarks,refno,clientname)
{
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
	{
			
		var items=x.responseText;
		if(items==1) 
		{
			document.getElementById("srno").value="";
		document.getElementById("leasereqdocno").value="";
		document.getElementById("remarks").value="";
		document.getElementById("refno").value="";
		document.getElementById("clientname").value="";
		//$('#date').val(new Date());
		 $.messager.alert('Message', '  Record Successfully Updated ');
		}
			
		else{
			$.messager.alert('Message', 'Not Updated ');
			 $("#fleetdetailsgrid").jqxGrid('clear');
		}		
			
		}
}
	x.open("GET","leasesavedata.jsp?leasereqdocno="+leasereqdocno+"&srno="+srno+"&testdate="+testdate+"&remarks="+remarks+"&refno="+refno+"&clientname="+clientname,true);

	x.send();

}
	
	
function fundisable(){
 //	 $('#leasefollowgrid').jqxGrid({ height: 530 });
//$("#leasefollowdiv").load("leasefollowGrid.jsp?chkval=1");
 		
 	if(document.getElementById("radio_cancel").checked==true){
		
		
		document.getElementById("radio_cancel").checked=true;
		document.getElementById("radio_cancellist").checked=false;
		$("#enqlistgrid").jqxGrid('clear');
		
		
	}
	else if(document.getElementById("radio_cancellist").checked==true){
		
		document.getElementById("radio_cancellist").checked=true;
		document.getElementById("radio_cancel").checked=false;
		$("#enqlistgrid").jqxGrid('clear');
		
		
	} 
}
 
function funExportBtn(){
	if(document.getElementById("radio_cancellist").checked==true){
		
	 JSONToCSVCon(cancelexcel, 'Lease Application Cancel', true);
}
} 
	  
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%"  >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
		<tr><td colspan="2"></td></tr> 
		<tr ><td align="right" > <label class="branch">Cancel</label></td> <td ><input type="radio" checked="checked" id="radio_cancel" name="category" value="cancel" onchange="fundisable();"> 
	 	 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label class="branch">Cancel List</label>
         <input type="radio" id="radio_cancellist" name="category" value="cancellist" onchange="fundisable();">
         
         </td>
	 	</tr> 
	 	<tr><td colspan="2">&nbsp;</td></tr> 
	 	 
	 	 <tr><td  align="right" ><label class="branch">Date</label></td><td align="left"><div id='date' name='date' value='<s:property value="date"/>'></div>
                   </td></tr>
	 		<tr><td colspan="2">&nbsp;</td></tr>
	 		
	 	 <tr><td align="right"><label class="branch">Remarks </label></td><td align="left"><input type="text" id="remarks" style="height:20px;width:88%;" name="remarks"  value='<s:property value="remarks"/>'> </td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr> 
	 
	<tr><td  align="center" colspan="2"><input type="Button" name="Update" id="Update" class="myButton" value="UPDATE" onclick="funupdate()"></td> </tr>
<input type="hidden" name="srno" id="srno" style="height:20px;width:70%;" value='<s:property value="srno"/>' >
<input type="hidden" name="leasereqdocno" id="leasereqdocno" style="height:20px;width:70%;" value='<s:property value="leasereqdocno"/>' >
<input type="hidden" name="refno" id="refno" style="height:20px;width:70%;" value='<s:property value="refno"/>' >
<input type="hidden" name="username" id="username" style="height:20px;width:70%;" value='<s:property value="username"/>' >
<input type="hidden" name="clientname" id="clientname" style="height:20px;width:70%;" value='<s:property value="clientname"/>' >

<tr><td colspan="2">&nbsp;</td></tr> 
<tr><td colspan="2">&nbsp;</td></tr> 
<tr><td colspan="2">&nbsp;</td></tr> 
<tr><td colspan="2">&nbsp;</td></tr> 
<tr><td colspan="2">&nbsp;</td></tr> 
<tr><td colspan="2">&nbsp;</td></tr> 
<tr><td colspan="2">&nbsp;</td></tr> 

<tr><td colspan="2">&nbsp;</td></tr> 
<tr><td colspan="2">&nbsp;</td></tr> 
<tr><td colspan="2">&nbsp;</td></tr> 
<tr><td colspan="2">&nbsp;</td></tr>  

 </table>
</fieldset>


</div>

</div>
</div>
	
	  <table width="100%" > 
	
	
 </table>

</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td>
			  <div id="leasefollowdiv"><jsp:include page="leasecancelGrid.jsp"></jsp:include></div>  
			 </td>
			
		</tr>
		
		

	</table>
</tr>
</table>

</div>
</div>
</body>
</html>