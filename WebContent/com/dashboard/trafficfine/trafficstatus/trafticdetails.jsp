
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
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		
     $('#ticketnowindow').jqxWindow({ width: '38%', height: '48%',  maxHeight: '48%' ,maxWidth: '38%' , title: 'Ticket Search' , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	 $('#ticketnowindow').jqxWindow('close');  
	 $('#regnowindow').jqxWindow({ width: '38%', height: '48%',  maxHeight: '48%' ,maxWidth: '38%' , title: 'Reg No. Search' , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	 $('#regnowindow').jqxWindow('close');
	 $("#cmbbranch").attr('hidden',true); 
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
	 
	 $('#ticketno').dblclick(function(){
		 ticketSearchContent('ticketSearchGrid.jsp?id=1&fromdate='+$('#fromdate').jqxDateTimeInput('val')+'&todate='+$('#todate').jqxDateTimeInput('val')); 
	});
	 $('#regno').dblclick(function(){
		 regnoSearchContent('regnoSearchGrid.jsp?id=1&fromdate='+$('#fromdate').jqxDateTimeInput('val')+'&todate='+$('#todate').jqxDateTimeInput('val')); 
	});
	 
});

function ticketSearchContent(url) {
	$('#ticketnowindow').jqxWindow('open');
	$.get(url).done(function (data) {
		$('#ticketnowindow').jqxWindow('setContent', data);
		$('#ticketnowindow').jqxWindow('bringToFront');
	});
}
function getTicket(event){
    var x= event.keyCode;
    if(x==114){
    	ticketSearchContent('ticketSearchGrid.jsp?id=1&fromdate='+$('#fromdate').jqxDateTimeInput('val')+'&todate='+$('#todate').jqxDateTimeInput('val'));
    }
    else{}
}
function regnoSearchContent(url) {
	$('#regnowindow').jqxWindow('open');
	$.get(url).done(function (data) {
		$('#regnowindow').jqxWindow('setContent', data);
		$('#regnowindow').jqxWindow('bringToFront');
	});
}
function getRegno(event){
    var x= event.keyCode;
    if(x==114){
    	regnoSearchContent('regnoSearchGrid.jsp?id=1&fromdate='+$('#fromdate').jqxDateTimeInput('val')+'&todate='+$('#todate').jqxDateTimeInput('val'));
    }
    else{}
}
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
var regno= $("#regno").val();
var test ="10"; 

$("#Readygrid").load("subgrid.jsp?test="+test+"&from="+fromdate+"&regno="+regno+"&to="+todate+"&ticketno="+$('#ticketno').val());


$("#posgrid").load("subposting.jsp?test="+test+"&from="+fromdate+"&regno="+regno+"&to="+todate+"&ticketno="+$('#ticketno').val());


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
	  	JSONToCSVCon(dataexcel, 'Trafficstatus', true);
	  }
	 else
	  {
	                 
		 $("#jqxFleetGrid").jqxGrid('exportdata', 'xls', 'Trafficstatus');
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
	 function clearTicket(){
		 $('#ticketno').val('');
		 $('#ticketno').attr('placeholder','Press F3 to Search');
		 $('#ticketno').attr('readonly',true);
		 return false;
	 }
	 function clearRegno(){
		 $('#regnono').val('');
		 $('#regnono').attr('placeholder','Press F3 to Search');
		 $('#regnono').attr('readonly',true);
		 return false;
	 }
</script>
</head>
<body onload="getBranch();hiddenbrh()">
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
                    <tr><td  align="right" ><label class="branch">Ticket No</label></td><td align="left"><input type="text" name="ticketno" id="ticketno" style="height:20px;" placeholder="Press F3 to Search" onclick="getTicket(event)" readonly="readonly">
                    <button type="button" onclick="clearTicket();" style="border:none;background-color:transparent;"><img src="../../../../icons/cancel_new.png" alt=""></button>
                    </td></tr>
                     <tr><td  align="right" ><label class="branch">Reg No</label></td><td align="left"><input type="text" name="regno" id="regno" style="height:20px;" placeholder="Press F3 to Search" onclick="getRegno(event)" readonly="readonly">
                   <button type="button" onclick="clearRegno();" style="border:none;background-color:transparent;"><img src="../../../../icons/cancel_new.png" alt=""></button>
                    </td></tr>
		 <tr>
	<td colspan="2" ><div id="Readygrid"><jsp:include page="subgrid.jsp"></jsp:include>
	</div></td>
	</tr> 

<tr><td colspan="2">&nbsp;</td></tr>
 	 <tr>
	<td colspan="2" ><div id="posgrid"><jsp:include page="subposting.jsp"></jsp:include>
	</div></td>
	</tr>


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
   <div id="ticketnowindow">
	<div></div><div></div>
</div>
<div id="regnowindow">
	<div></div><div></div>
</div>
   
</div>
</div>

</body>
</html>
