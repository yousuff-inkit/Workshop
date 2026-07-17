<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
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
.myButtons {
	display: inline-block;
	margin-right:4px;
	margin-left:4px; 
  margin-bottom: 0;
  font-weight: normal;
  line-height: 1.3;
  text-align: center;
  white-space: nowrap;
  vertical-align: middle;
  -ms-touch-action: manipulation;
      touch-action: manipulation;
  cursor: pointer;
  -webkit-user-select: none;
     -moz-user-select: none;
      -ms-user-select: none;
          user-select: none;
  background-image: none;
  border: 1px solid transparent;
  border-radius: 4px;
  color: #fff;
  background-color: grey;
}
.myButtons:hover {
	  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons:active {
  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons:focus {
  color: #fff;
  background-color: grey;
}
input[type=text]{
	height:18px;
} 
select{
    height:15px;
}
</style>

<script type="text/javascript">

$(document).ready(function () {
		/* document.getElementById("branchlabel").style.display="none";
		document.getElementById("branchdiv").style.display="none"; */
		  /*  $("#btnExcel").click(function() {
				JSONToCSVCon(repexceldata, 'Replacement List', true);
				//$("#vehiclelist").jqxGrid('exportdata', 'xls', 'vehiclelist');
			}); */
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	    $('#srvcadvisorwindow').jqxWindow({ width: '40%', height: '50%',  maxHeight: '50%' ,maxWidth: '40%' , title: 'Service Advisor Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#srvcadvisorwindow').jqxWindow('close');
	 	$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 	$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 	var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	    $('#srvcadvisor').dblclick(function(){
		    $('#srvcadvisorwindow').jqxWindow('open');
			$('#srvcadvisorwindow').jqxWindow('focus');
			var fromdate=$('#fromdate').jqxDateTimeInput('val');
			var todate=$('#todate').jqxDateTimeInput('val');
		 	searchContent('srvcAdvisorSearchGrid.jsp?id=1&fromdate='+fromdate+'&todate='+todate, 'srvcadvisorwindow');
		});
});

function getSrvcAdvisor(event){
	var x= event.keyCode;
   	if(x==114){
   		var fromdate=$('#fromdate').jqxDateTimeInput('val');
		var todate=$('#todate').jqxDateTimeInput('val');
	 	searchContent('srvcAdvisorSearchGrid.jsp?id=1&fromdate='+fromdate+'&todate='+todate, 'srvcadvisorwindow');
   }
   else{
   }
}



function searchContent(url,windowid) {
	$.get(url).done(function (data) {
		$('#'+windowid).jqxWindow('setContent', data);
	}); 
}

function funreload(event)
{
    $("#overlay, #PleaseWait").show();
    var fromdate=$('#fromdate').jqxDateTimeInput('val');
    var todate=$('#todate').jqxDateTimeInput('val');
    var srvcadvisor=$('#srvcadvisor').val();
    $('#srvcadvisordiv').load('srvcAdvisorGrid.jsp?fromdate='+fromdate+'&todate='+todate+'&id=1&srvcadvisor='+srvcadvisor);
}
	

	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
	
	}
	
	function funExportBtn(){
		JSONToCSVCon(repexceldata, 'Replacement List', true);
		 }
	
		
	
	function funClearData(){
		$('input[type=text],[type=hidden]').val('');
		$('select').find('option').prop("selected", false);
		$('#fromdate').jqxDateTimeInput('setDate',new Date());
		$('#todate').jqxDateTimeInput('setDate',new Date());
		var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
	
	}
	
	function funNotify(){
		var partrows=$('#partsGrid').jqxGrid('getselectedrowindexes');
		if(partrows.length==0){
			$.messager.alert('Warning','Please Select Valid Documents');
			return false;
		}
		else{
			
			for(var i=0;i<partrows.length;i++){
				var qty=parseInt($('#partsGrid').jqxGrid('getcellvalue',partrows[i],'qty'));
				var stock=parseInt($('#partsGrid').jqxGrid('getcellvalue',partrows[i],'balqty'));
				if(qty>stock){
					$.messager.alert('Warning','Please Make Sure Stock is Available');
					return false;
				}
			}
			for(var i=0;i<partrows.length;i++){
				newTextBox = $(document.createElement("input"))
			    .attr("type", "dil")
			    .attr("id", "partsgrid"+i)
			    .attr("name", "partsgrid"+i)
			    .attr("hidden","true");
				var psrno=$('#partsGrid').jqxGrid('getcellvalue',partrows[i],'psrno');
				var prodoc=$('#partsGrid').jqxGrid('getcellvalue',partrows[i],'prodoc');
				var unitdocno=$('#partsGrid').jqxGrid('getcellvalue',partrows[i],'unitdocno');
				var qty=$('#partsGrid').jqxGrid('getcellvalue',partrows[i],'qty');
				var specid=$('#partsGrid').jqxGrid('getcellvalue',partrows[i],'specid');
				var cost_price=$('#partsGrid').jqxGrid('getcellvalue',partrows[i],'cost_price');
				var savecost_price=$('#partsGrid').jqxGrid('getcellvalue',partrows[i],'savecost_price');
				
				newTextBox.val(psrno+"::"+prodoc+"::"+unitdocno+"::"+qty+"::"+qty+"::"+"1"+"::"+specid+"::"+"0"+"::"+cost_price+"::"+savecost_price);
				
			
				newTextBox.appendTo('form');
			}
			$('#partsgridlength').val(partrows.length);
		}
		
		$('#mode').val('A');
		document.getElementById("frmGoodsIssue").submit();
		
		
	}
	
	
	
	</script>
	
</head>
<body onload="setValues();getBranch();">
<form id="frmGoodsIssue" method="post" action="saveGoodsIssue">
<div id="mainBG" class="homeContent" data-type="background">
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="23%" align="center">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

 <tr>
   <td width="37%" align="right"><label class="branch">From Date</label></td><td width="63%"><div id="fromdate" name="fromdate"></div></td></tr>
 <tr>
   <td align="right"><label class="branch">To Date</label></td>
   <td><div id="todate" name="todate"></div></td>
 </tr>
 <tr>
   <td align="right"><label class="branch">Service Advisor</label></td>
   <td><input type="text" name="srvcadvisor" id="srvcadvisor" value='<s:property value="srvcadvisor"/>' readonly onkeydown="getSrvcAdvisor(event);" placeholder="Press F3 to Search" style="height:18px;"></td>
 </tr>

 <tr >
	<td colspan="2" style="border-top:2px solid #DCDDDE;">
	<div style="text-align:center;">
	<input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();">&nbsp;&nbsp;
	<input type="button" name="btnsave" id="btnsave" value="Save" class="myButtons" onclick="funNotify();">
	</div>
    </td>
	</tr>
<tr ><td colspan="2"><!-- <textarea id="agmtdetails" name="agmtdetails" readonly style="resize:none;" rows="10" cols="35"></textarea> -->
	<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

</td></tr>

	
		
	</table>
	</fieldset>
</td>
<td width="77%">
	<table width="100%" border="0">
  		<tr>
    		<td><div id="srvcadvisordiv"><jsp:include page="srvcAdvisorGrid.jsp"></jsp:include></div></td>
  		</tr>
  		<tr>
    		<td><div id="partsdiv"><jsp:include page="partsGrid.jsp"></jsp:include></div></td>
  		</tr>
	</table>
</td>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
<input type="hidden" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>'>
<input type="hidden" name="fleetno" id="fleetno" value='<s:property value="fleetno"/>'>
<input type="hidden" name="brhid" id="brhid" value='<s:property value="brhid"/>'>
<input type="hidden" name="locationid" id="locationid" value='<s:property value="locationid"/>'>
<input type="hidden" name="srvcdocno" id="srvcdocno" value='<s:property value="srvcdocno"/>'>
<input type="hidden" name="partsgridlength" id="partsgridlength" value='<s:property value="partsgridlength"/>'>
</tr>
</table>
</div>
<div id="srvcadvisorwindow">
	<div></div>
</div>
</div>
</form>
</body>
</html>