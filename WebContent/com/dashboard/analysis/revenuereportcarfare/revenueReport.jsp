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
 
select{
    height:15px;
}
</style>

<script type="text/javascript">

$(document).ready(function () {
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	    
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	 var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	 var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	 $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	 	 
	 $('#clientToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#clientToWindow').jqxWindow('close');
	 
	 $('#repairtypeSearchWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Repair Type Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#repairtypeSearchWindow').jqxWindow('close');
	 
	 $('#serviceAdvisorSearchWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Service Advisor Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#serviceAdvisorSearchWindow').jqxWindow('close');
	 
	 $('#salesmanSearchWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Salesman Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#salesmanSearchWindow').jqxWindow('close');
	 
	 document.getElementById("rdall").checked=true;
	 summaryDisable();
	 
});


function funreload(event)
{
	
    var fromdate=$('#fromdate').jqxDateTimeInput('val');
    var todate=$('#todate').jqxDateTimeInput('val');
    var hidclient=document.getElementById("hidclient").value;
    var hidclientslm=document.getElementById("hidclientslm").value;
    var hidrepairtype=document.getElementById("hidrepairtype").value;
    var hidserviceadvisor=document.getElementById("hidserviceadvisor").value;
  //  alert(jcno+"  "+techid);
  
  
  
    if(document.getElementById("rdall").checked==true){
    	$("#overlay, #PleaseWait").show(); 
   	   	$("#revenuereportdiv").load("detailGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1"+"&hidclient="+hidclient+"&hidclientslm="+hidclientslm+"&hidrepairtype="+hidrepairtype+"&hidserviceadvisor="+hidserviceadvisor);
		
	}else if(document.getElementById("rdsummary").checked==true){

		 	if($('#cmbsummarytype').val()=='') {
				$.messager.alert('Message','Please Choose a Summary Type.','warning');
		 	}
	   	var x=$("#cmbsummarytype option:selected").val();
	   	if(x=="clt"){
	   		/* alert(x); */
	   		$("#overlay, #PleaseWait").show(); 
	   	   	$("#revenuereportdiv").load("summaryGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1"+"&hidclient="+hidclient+"&hidclientslm="+hidclientslm+"&hidrepairtype="+hidrepairtype+"&hidserviceadvisor="+hidserviceadvisor+"&sumtype=clt"); 
	   		
	   	}else if(x=="sm"){
	   		$("#overlay, #PleaseWait").show(); 
	   	   	$("#revenuereportdiv").load("summaryGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1"+"&hidclient="+hidclient+"&hidclientslm="+hidclientslm+"&hidrepairtype="+hidrepairtype+"&hidserviceadvisor="+hidserviceadvisor+"&sumtype=sm"); 
	   		
	   	}else if(x=="rt"){
	   		$("#overlay, #PleaseWait").show(); 
	   	   	$("#revenuereportdiv").load("summaryGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1"+"&hidclient="+hidclient+"&hidclientslm="+hidclientslm+"&hidrepairtype="+hidrepairtype+"&hidserviceadvisor="+hidserviceadvisor+"&sumtype=rt"); 
	   		
	   	}else if(x=="wsa"){
	   		$("#overlay, #PleaseWait").show(); 
	   	   	$("#revenuereportdiv").load("summaryGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1"+"&hidclient="+hidclient+"&hidclientslm="+hidclientslm+"&hidrepairtype="+hidrepairtype+"&hidserviceadvisor="+hidserviceadvisor+"&sumtype=wsa"); 
	   		
	   	}else if(x=="dly"){
	   		$("#overlay, #PleaseWait").show(); 
	   	   	$("#revenuereportdiv").load("summaryGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1"+"&hidclient="+hidclient+"&hidclientslm="+hidclientslm+"&hidrepairtype="+hidrepairtype+"&hidserviceadvisor="+hidserviceadvisor+"&sumtype=dly"); 
	   		
	   	}else if(x=="mly"){
	   		$("#overlay, #PleaseWait").show(); 
	   	   	$("#revenuereportdiv").load("summaryGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1"+"&hidclient="+hidclient+"&hidclientslm="+hidclientslm+"&hidrepairtype="+hidrepairtype+"&hidserviceadvisor="+hidserviceadvisor+"&sumtype=mly"); 
	   		
	   	}else if(x=="yly"){
	   		$("#overlay, #PleaseWait").show(); 
	   	   	$("#revenuereportdiv").load("summaryGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1"+"&hidclient="+hidclient+"&hidclientslm="+hidclientslm+"&hidrepairtype="+hidrepairtype+"&hidserviceadvisor="+hidserviceadvisor+"&sumtype=yly"); 
	   		
	   	}
		
	}
      	
}
	
	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
	
	}
	function setSearch(){
			
			var value=$('#searchby').val().trim();
			
			 if(value=="client"){
				getClient();
			}
			else if(value=="clientslm"){
				getClientSalesman();
			}
			else if(value=="repairtype"){
				getRepairType();
			}
			else if(value=="wsa"){
				getServiceAdvisor();
			}
			else{}
	}
	function getClient(){
		 clientSearchContent('clientSearch.jsp');
	}
	
	function getRepairType(){
		 repairTypeSearchContent('repairTypeSearch.jsp?id=1');
	}
	
	function getServiceAdvisor(){
		 serviceAdvisorSearchContent('serviceAdvisorSearchGrid.jsp?id=1');
	}
	
	function getClientSalesman(){
		salesmanSearchContent('clientSalesManSearch.jsp?id=2');
	}
	
	function clientSearchContent(url) {
	    $('#clientToWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#clientToWindow').jqxWindow('setContent', data);
			$('#clientToWindow').jqxWindow('bringToFront');
		}); 
	}
	function salesmanSearchContent(url) {
	    $('#salesmanSearchWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#salesmanSearchWindow').jqxWindow('setContent', data);
			$('#salesmanSearchWindow').jqxWindow('bringToFront');
		}); 
	}
	function repairTypeSearchContent(url) {
	    $('#repairtypeSearchWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#repairtypeSearchWindow').jqxWindow('setContent', data);
			$('#repairtypeSearchWindow').jqxWindow('bringToFront');
		}); 
	}
	
	function serviceAdvisorSearchContent(url) {
	    $('#serviceAdvisorSearchWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#serviceAdvisorSearchWindow').jqxWindow('setContent', data);
			$('#serviceAdvisorSearchWindow').jqxWindow('bringToFront');
		}); 
	}
function setRemove(){
		
		var value=$('#searchby').val().trim();
		
		if(value=="client"){
			document.getElementById("searchdetails").value="";
			document.getElementById("client").value="";
			document.getElementById("hidclient").value="";
			if(document.getElementById("clientslm").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("clientslm").value; 
			} if(document.getElementById("repairtype").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("repairtype").value; 
			}
			if(document.getElementById("serviceadvisor").value!=""){
				document.getElementById("searchdetails").value+=document.getElementById("serviceadvisor").value; 
			}
		}  else if(value=="clientslm"){
			document.getElementById("searchdetails").value="";
			document.getElementById("clientslm").value="";
			document.getElementById("hidclientslm").value="";
			if(document.getElementById("client").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("client").value; 
			} if(document.getElementById("repairtype").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("repairtype").value; 
			} 
			if(document.getElementById("serviceadvisor").value!=""){
				document.getElementById("searchdetails").value+=document.getElementById("serviceadvisor").value; 
			}
		} else if(value=="repairtype"){
			document.getElementById("searchdetails").value="";
			document.getElementById("repairtype").value="";
			document.getElementById("hidrepairtype").value="";
			if(document.getElementById("client").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("client").value; 
			} if(document.getElementById("clientslm").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("clientslm").value; 
			} 
			if(document.getElementById("serviceadvisor").value!=""){
				document.getElementById("searchdetails").value+=document.getElementById("serviceadvisor").value; 
			}
		} else if(value=="wsa"){
			document.getElementById("searchdetails").value="";
			document.getElementById("serviceadvisor").value="";
			document.getElementById("hidserviceadvisor").value="";
			if(document.getElementById("client").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("client").value; 
			} if(document.getElementById("clientslm").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("clientslm").value; 
			} 
			if(document.getElementById("repairtype").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("repairtype").value; 
			}
		}
	}
		
	function funClearData(){
		$('input[type=text],[type=hidden]').val('');
		$('select').find('option').prop("selected", false);
		$('#fromdate').jqxDateTimeInput('setDate',new Date());
		$('#todate').jqxDateTimeInput('setDate',new Date());
		var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	    document.getElementById("searchdetails").value="";
	}
	
	function summaryDisable(){
		if(document.getElementById("rdall").checked==true){
			$('#cmbsummarytype').attr('disabled', true);
			$('select').find('option').prop("selected", false);
			
		}else if(document.getElementById("rdsummary").checked==true){
			$('#cmbsummarytype').attr('disabled', false);
		}
	}
	function funExportBtn(){
		JSONToCSVCon(rrexportdata, 'Revenue Report List', true);
	}
	
	
	function funAccwisePrint(){
    	
        var url=document.URL;
        var reurl=url.split("revenueReport.jsp");
        var hidclient=document.getElementById("hidclient").value;
        var hidclientslm=document.getElementById("hidclientslm").value;
        var hidrepairtype=document.getElementById("hidrepairtype").value;
        var hidserviceadvisor=document.getElementById("hidserviceadvisor").value;
        var branch=document.getElementById("cmbbranch").value;
        var type=document.getElementById("cmbsummarytype").value;
        //alert(type);
        
       /*  $("#txtdocno").prop("disabled", false); */
        var win= window.open(reurl[0]+"../../../../com/dashboard/analysis/revenuereport/printRevenueReport?client="+hidclient+'&clientslm='+hidclientslm+'&repairtype='+hidrepairtype+'&hidserviceadvisor='+hidserviceadvisor+'&type='+type+'&branch='+branch+'&fromDate='+document.getElementById("fromdate").value+'&toDate='+$('#todate').val()+'&email=Nil&print=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
        win.focus();
    
}
	
	function funMnthwisePrint(){
    	
        var url=document.URL;
        var reurl=url.split("revenueReport.jsp");
       
        var branch=document.getElementById("cmbbranch").value;
       
        /* $("#txtdocno").prop("disabled", false); */
        var win= window.open(reurl[0]+"../../../../com/dashboard/analysis/revenuereport/RevenueReportmnthwise?branch="+branch+'&fromDate='+document.getElementById("fromdate").value+'&toDate='+$('#todate').val()+'&email=Nil&print=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
        win.focus();
    
}
	
	
	/* setValues(); */
	</script>
	
</head>
<body onload="getBranch();">
	<form id="revenueReport" method="post">
		<div id="mainBG" class="homeContent" data-type="background"> 
			<div class='hidden-scrollbar'>
				<table width="100%">
					<tr>
						<td width="20%" align="center">
   	 						<fieldset style="background: #ECF8E0;">
								<table width="100%">
									<jsp:include page="../../heading.jsp"></jsp:include>
		 							<tr>
		   								<td width="37%" align="right"><label class="branch">From Date</label></td><td width="63%"><div id="fromdate"></div></td>
		   							</tr>
		 							<tr>
		   								<td align="right"><label class="branch">To Date</label></td>
		   								<td><div id="todate"></div></td>
		 							</tr>
									<tr>
										<td colspan="2">
				  							<fieldset>
					  							<table width="100%">
				      								<tr>
					      								<td width="40%" align="left">
					      									<input type="radio" id="rdall" name="rdo" onclick="summaryDisable();" value="rdall">
					      									<label for="rdall" class="branch">Detail</label>
					      								</td>
					      								<td width="60%">&nbsp;</td>
				      								</tr>
				      								<tr>
				     	 								<td align="left">
				     	 									<input type="radio" id="rdsummary" name="rdo" onclick="summaryDisable();" value="rdsummary">
				     	 									<label for="rdsummary" class="branch">Summary</label>
				     	 								</td>
				      									<td>
				      										<select id="cmbsummarytype" name="cmbsummarytype" style="width:80%;"  value='<s:property value="cmbsummarytype"/>'>
				      											<option value="">--Select--</option>
				      											<option value="clt">Client</option>
				      											<option value="sm">Sales Man</option>
				      											<option value="rt">Repair Type</option>
				      											<option value="wsa">Service Advisor</option>
				      											<option value="dly">Daily</option>
				      											<option value="mly">Monthly</option>
				      											<option value="yly">Yearly</option>
					  										</select>
				      									</td>
				      								</tr>
				      							</table>
			      							</fieldset>
										</td>
									</tr>
									<tr>
										<td colspan="2">
											<table width="100%">
				  								<tr>
				    								<td align="right"><label class="branch">Search By</label></td>
				    								<td align="left">
				    									<select name="searchby" id="searchby">
				    										<option value="">--Select--</option>
															<option value="client">Client</option>
															<option value="clientslm">Salesman</option>
															<option value="repairtype">Repair Type</option>
															<option value="wsa">Service Advisor</option>
														</select>
													</td>
				    								<td><button type="button" name="btnadditem" id="additem" class="myButtons1" onClick="setSearch();">+</button></td>
				    								<td><button type="button" name="btnremoveitem" id="btnremoveitem" class="myButtons1" onclick="setRemove();">-</button></td>
				  								</tr>
				  								<tr>
				    								<td colspan="4" align="center">
				    									<textarea id="searchdetails" style="height:140px;width:230px;font: 10px Tahoma;resize:none" name="searchdetails" readonly="readonly"><s:property value="searchdetails"></s:property></textarea>
				    								</td>
				  								</tr>
											</table>
										</td>
									</tr>  
		 							<tr>
										<td colspan="2" style="border-top:2px solid #DCDDDE;">
											<div style="text-align:center;">
												<input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();"> &nbsp;&nbsp;
												<input type="button" name="btnrepprint" id="btnrepprint" value="Account Wise Print" class="myButtons" onclick="funAccwisePrint();" style="display:none;">
											</div>
		    							</td>
		    						</tr>
									<tr>
										<td colspan="2" >
											<div style="text-align:center;">
												<input type="button" name="btnrepprint" id="btnrepprint" value="Month Wise Print" class="myButtons" onclick="funMnthwisePrint();" style="display:none;">
											</div>
										</td>
									</tr>
									<tr >
										<td colspan="2">
											<!-- <textarea id="agmtdetails" name="agmtdetails" readonly style="resize:none;" rows="10" cols="35"></textarea> -->
											<br><br><br><br>
										</td>
									</tr>
									<tr colspan="2"><td>&nbsp;</td></tr>		
								</table>
							</fieldset>
						</td>
						<td width="80%">
							<table width="100%">
								<tr>
		  							<td><div id="revenuereportdiv"><jsp:include page="detailGrid.jsp"></jsp:include></div></td>
		  							<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
									<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
									<input type="hidden" name="client" id="client"><input type="hidden" name="hidclient" id="hidclient">
									<input type="hidden" name="clientslm" id="clientslm"><input type="hidden" name="hidclientslm" id="hidclientslm">
									<input type="hidden" name="repairtype" id="repairtype"><input type="hidden" name="hidrepairtype" id="hidrepairtype">
									<input type="hidden" name="serviceadvisor" id="serviceadvisor"><input type="hidden" name="hidserviceadvisor" id="hidserviceadvisor">
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</form>
	<div id="clientToWindow">
		<div></div>
	</div>
	<div id="salesmanSearchWindow">
		<div></div>
	</div>	
	<div id="repairtypeSearchWindow">
		<div></div>
	</div>
	<div id="serviceAdvisorSearchWindow">
		<div></div>
	</div>
</body>
</html>