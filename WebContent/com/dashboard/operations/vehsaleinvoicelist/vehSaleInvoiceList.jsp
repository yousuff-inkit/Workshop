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

<script type="text/javascript">

	$(document).ready(function () {
		 
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 
		 $('#inspectionWindow').jqxWindow({ autoOpen: false,width: '78%', height: '85%',  maxHeight: '85%' ,maxWidth: '78%' , title: 'Inspection Details' , theme: 'energyblue', position: { x: 280, y: 10 }, keyboardCloseKey: 27, showCloseButton: true,closeButtonAction:'hide'});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		
	     var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	    
	});
	
	
	
	function inspectionSearchContent(url) {
		 $('#inspectionWindow').jqxWindow('focus'); 
		 $.get(url).done(function (data) {
		 $('#inspectionWindow').jqxWindow('setContent', data);
		}); 
		}
	 
	
	
	function funreload(event){
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var type = $('#cmbtype').val();
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 
		 if(type==''){
			 $.messager.alert('Message','Please Choose a Type','warning');
			 return 0;
		 }

		$("#overlay, #PleaseWait").show();
		 
		 if(type==1){
			 $("#detailDiv").prop("hidden", true);
	       	 $("#summaryDiv").prop("hidden", false);
	          $("#summaryDiv").load("summaryGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate);
		 }
		 else{
			 $("#summaryDiv").prop("hidden", true); 
	      	 $("#detailDiv").prop("hidden", false);
	     
	          $("#detailDiv").load("detailGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate);
		 }
		}
	
	
	   
	    function funExportBtn(){
	    	var type = $('#cmbtype').val();
	    	  
			   if(type==1)
			   {
				   JSONToCSVCon(summaryexceldata, 'Vehicle sale Invoice List(Summary)', true);
	 		 
			   }
			    
			   else
			   {
			
				   JSONToCSVCon(detailexceldata, 'Vehicle sale Invoice List(Detail)', true);
	 		 
			   }
	 } 
	
</script>
</head>
<body onload="getBranch();">
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
	 <td align="right"><label class="branch">From</label></td>
     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr>
	<td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td align="right"><label class="branch">Type</label></td>
	<td align="left"><select id="cmbtype" name="cmbtype" style="width:70%;" value='<s:property value="cmbtype"/>'>
    <option value="">--Select--</option><option value="1">Summary</option><option value="2">Detail</option></select></td></tr> 
	 <tr>
	<td>
    <tr><td colspan="2">&nbsp;</td></tr> 
    <tr><td colspan="2">&nbsp;</td></tr> 
    <tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr><tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr><tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr><tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr><tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr><tr><td colspan="2">&nbsp;</td></tr>
	
	
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="summaryDiv"><jsp:include page="summaryGrid.jsp"></jsp:include></div>
			 <div id="detailDiv" hidden="true"><jsp:include page="detailGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>


<div id="inspectionWindow">
<div></div>
</div>
</div> 
</body>
</html>