<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%@page import="com.dashboard.operations.vehicleinsurposting.*"%>
<%ClsVehicleInsurPostingDAO postdao=new ClsVehicleInsurPostingDAO();%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<style type="text/css">
input[type=text]{
	height:18px;
}
</style>
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<script type="text/javascript">
$(document).ready(function () {
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
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

	$('#branchlabel,#branchdiv').hide();
	setGridType();
});


function setGridType(){
	if($('#cmbgrouping').val()==''){
		$('#detailsdiv').show();
		$('#distributiondiv').hide();
	}
	else{
		$('#detailsdiv').hide();
		$('#distributiondiv').show();
	}
}
function funreload(event)
{
	var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 
	 if(fromdates>todates){
		   
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		 
	 return false;
	} 
	     var fromdate= $("#fromdate").val();
		 var todate= $("#todate").val();
		 var grouping=$('#cmbgrouping').val();
		 $("#overlay, #PleaseWait").show();
		 if(grouping==""){
			 $("#detailsdiv").load("detailsGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1");		 
		 }
		 else{
			 $("#distributiondiv").load("distributionGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&check=1&grouping="+grouping);
		 }
	  
	  
	 
}
	
	

	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
	getBranch();
	}
	
	function funExportBtn(){
		 
	 	JSONToCSVCon(insuranceanalysisexcel, 'Insurance Analysis', true); 
		 }
	
	</script>
	
</head>
<body onload="setValues();">
<form id="frmVehicleInsurancePosting" method="post" >
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%" align="center">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>
<tr><td colspan="2" ></td></tr>
 <tr><td  align="right" width="25%" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
           <tr><td colspan="2" ></td></tr>         
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>
                    <tr><td  align="right" ><label class="branch">Distribution</label></td>
                    	<td align="left">
                    		<select name="cmbgrouping" id="cmbgrouping" onchange="setGridType();">
                    			<option value="">--Select--</option>
		                    	<option value="2">Monthly</option>
		                    	<option value="3">Quarterly</option>
		                    	<option value="4">Yearly</option>
		                    </select>
                    </td></tr>
 <tr>
   <td colspan="2">
  
   </td>
   </tr>

<tr ><td colspan="2"><br><br><br><br><br><br><br><br><!-- <textarea id="agmtdetails" name="agmtdetails" readonly style="resize:none;" rows="10" cols="35"></textarea> -->
</td></tr>

<tr colspan="2"><td>&nbsp;</td></tr><tr colspan="2"><td>&nbsp;</td></tr>
<tr colspan="2"><td>&nbsp;</td></tr><tr colspan="2"><td>&nbsp;</td></tr>
<tr colspan="2"><td>&nbsp;</td></tr><tr colspan="2"><td>&nbsp;</td></tr>
<tr colspan="2"><td>&nbsp;</td></tr><tr colspan="2"><td>&nbsp;</td></tr>	
		
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td>
			 <div id="detailsdiv"><jsp:include page="detailsGrid.jsp"></jsp:include></div>
			 <div id="distributiondiv"><jsp:include page="distributionGrid.jsp"></jsp:include></div>	
			 </td>
			 
		</tr>
		<tr>
		<td>
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  <input type="hidden" name="expenseacno" id="expenseacno" value='<s:property value="expenseacno"/>'>
		<input type="hidden" name="invgridlength" id="invgridlength" value='<s:property value="invgridlength"/>'>
		</td>
		</tr>
	</table>
</tr>
</table>
</div>
</div>

</form>
</body>
</html>