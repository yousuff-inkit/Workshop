
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
 
	$("#cmbbranch").attr('hidden',true); 
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	 $("body").prepend('<div id="suboverlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='subPleaseWait' style='display: none;position:absolute; z-index: 1;top:280px;left:100px;'><img src='../../../../icons/31load.gif'/></div>");
	
	
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
});

function funreload(event)
{
	  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
	  // out date
	 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	 	 
	   if(fromdates>todates){
		   
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		 
	   return false;
	  } 
	   else
	   {
	

 var fromdate= $("#fromdate").val();
 var todate= $("#todate").val(); 
 var chkincrecv= $("#hidchckincrecv").val(); 
	 var test ="10"; 
     	 $("#suboverlay, #subPleaseWait").show();
	  $("#Readygrid").load("subgrid.jsp?test="+test+"&from="+fromdate+"&to="+todate+"&chkincrecv="+chkincrecv+"&id=1");
	//  $("#detlist").load("detailsGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate);
	   }
	
	}
	
function hiddenbrh(){
	
	$("#branchlabel").attr('hidden',true);
	$("#branchdiv").attr('hidden',true);
	//$('#gridlength').val(""); 
}

	
function funExportBtn()
{

	 if(parseInt(window.parent.chkexportdata.value)=="1")
		  {
		  	JSONToCSVCon(data1, 'Salik Status', true);
		  }
		 else
		  {
			 $("#jqxFleetGrid").jqxGrid('exportdata', 'xls', 'Salik Status');
		  }
		
	
	
	}	
 function increcvcheck(){
	 if(document.getElementById("chckincrecv").checked){
		 document.getElementById("hidchckincrecv").value = 1;
		 
	 }
	 else{
		 document.getElementById("hidchckincrecv").value = 0;
		
	 }
} 
	
	/* function funsetaval()
	{
		  if (document.getElementById('det_chk').checked) {
		
		document.getElementById("chkdatails").value="search";
		   $('#jqxFleetGrid').jqxGrid('showcolumn', 'empid');
		   $('#jqxFleetGrid').jqxGrid('showcolumn', 'empname');
		  }
		  else
			  {
			  document.getElementById("chkdatails").value="";
			   $('#jqxFleetGrid').jqxGrid('hidecolumn', 'empid');
			   $('#jqxFleetGrid').jqxGrid('hidecolumn', 'empname');
			  }
	}
	  */
	 
</script>
</head>
<body onload="getBranch();hiddenbrh();increcvcheck();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
 
	<!--  <tr><td colspan="2">&nbsp;</td></tr> -->
<!--  <tr><td colspan="2" align="center"><label class="branch">Detail</label><input type="checkbox" id="det_chk"  name="det_chk" value="0"   onclick="funsetaval()" >
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>  -->
	 <tr><td colspan="2">&nbsp;</td></tr>
	  <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>
                    
                    	
<tr><td colspan="2"></td></tr>
<tr><td colspan="2" align="center"><input type="checkbox" id="chckincrecv" name="chckincrecv" value="" onchange="increcvcheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)" /> 
                                 <input type="hidden" id="hidchckincrecv" name="hidchckincrecv" value='<s:property value="hidchckincrecv"/>'/>
                                 <label class="branch">Including Received</label></td>
                                 </tr>
   <tr><td colspan="2"></td></tr>

		 <tr>

	<td colspan="2" ><div id="Readygrid"><jsp:include page="subgrid.jsp"></jsp:include>
	</div></td>
	</tr> 
<tr><td colspan="2">&nbsp;</td></tr>
<%--  	 <tr>
	<td colspan="2" ><div id="posgrid"><jsp:include page="subposting.jsp"></jsp:include>
	</div></td>
	</tr> --%>

 
	</table>
	</fieldset>
</td>
<td width="80%">
<div  >
	<table width="100%" id="grid1">
			<tr>
			  <td ><div  id="fleetdiv"><jsp:include page="detailsgrid.jsp"></jsp:include></div> 
			</td></tr>
	</table>
</div>
<div >
	<!-- <table width="100%" id="chart">
		<tr>
			 <td width="50%">
			<div id='fleetStatus1' style="width: 100%; height: 250px;"></div>
			  <div id='sec1' style="width: 100%; height: 250px;"></div>
			   </td><td>  <div id='thr1' style="width: 100%; height: 250px;"></div>
			   <div id='four1' style="width: 100%; height: 250px;"></div></td></tr>
	</table> -->
</div>
</tr>
</table>
 <input type="hidden" id="chkdatails" name="chkdatails" value='<s:property value="chkdatails"/>'>
  <input type ="hidden" id="emptype" value='<s:property value="chkdatails"/>'>
   <input type ="hidden" id="empname"  value='<s:property value="chkdatails"/>'>
</div>
</div>

</body>
</html>
