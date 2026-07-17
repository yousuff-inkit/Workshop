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
<script type="text/javascript">
$(document).ready(function () {
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");    
	$("#periodupto").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	document.getElementById("imgloading").style.display="none";
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();
			$('#periodupto').jqxDateTimeInput('val',items);
			
		} else {

		}
	}
	x.open("GET","getLastDay.jsp?date="+$('#periodupto').jqxDateTimeInput('val'), true);
	x.send();
	
	
	$('#periodupto').on('change', function (event) 
			{  
				var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
				if(docdateval==0){
					$('#periodupto').jqxDateTimeInput('focus');
					return false;
				}
			    var jsDate = event.args.date; 
			    var type = event.args.type; // keyboard, mouse or null depending on how the date was selected.
			 	var date=$('#uptodate').jqxDateTimeInput('val');
				var x = new XMLHttpRequest();
				x.onreadystatechange = function() {
					if (x.readyState == 4 && x.status == 200) {
						var items = x.responseText.trim();
						if(items=="0"){
							$.messager.alert('Warning','Date should be month end');
							return false;
						}
						else{
							return true;
						}
					} else {

					}
				}
				x.open("GET","checkMonthEnd.jsp?date="+date, true);
				x.send();

			});
});

function funreload(event)
{
	if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=='a'){
		$.messager.alert('Warning','Please Select Branch');
		return false;
	}
	var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
	if(docdateval==0){
		$('#periodupto').jqxDateTimeInput('focus');
		return false;
	}
	/* $("#Readygrid").load("invnoGrid.jsp?barchval="+barchval+"&date1="+date1+"&client="+client+"&status=1"); */
	 var date=$('#periodupto').jqxDateTimeInput('val');
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
				if(items=="0"){
					$.messager.alert('Warning','Date should be month end');
					return false;
				}
				else{
					$("#overlay, #PleaseWait").show(); 
					var branch=$('#cmbbranch').val();
					var uptodate=$('#periodupto').jqxDateTimeInput('val');
					$('#invoicediv').load('invoiceGrid.jsp?branch='+branch+'&uptodate='+uptodate+'&mode=1');
				}
			} else {

			}
		}
		x.open("GET","checkMonthEnd.jsp?date="+date, true);
		x.send();
	}
function funCalculate(){
	/* $("#overlay, #PleaseWait").show(); 
	var rows = $("#rentalInvoiceGrid").jqxGrid('getrows');
	//alert(rows);
	if(rows.length==1 && (rows[0].rano=="undefined" || rows[0].rano==null || rows[0].rano=="")){
		return false;
	}
	 var date1= $('#periodupto').jqxDateTimeInput('getText');
	 var client=document.getElementById("hidclient").value;
	 var branchvalue =document.getElementById("cmbbranch").value;
	 $('#rentalinvoicediv').load('rentalInvoiceGrid.jsp?temp='+null+'&desc1='+document.getElementById("desc").value+'&date1='+date1+'&branch='+branchvalue+'&client='+client+'&mode=1');
 */
	if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=='a'){
		$.messager.alert('Warning','Please Select Branch');
		return false;
	}
	
	
	 var date=$('#periodupto').jqxDateTimeInput('val');
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
				if(items=="0"){
					$.messager.alert('Warning','Date should be month end');
					return false;
				}
				else{
					$("#overlay, #PleaseWait").show(); 
					var branch=$('#cmbbranch').val();
					var uptodate=$('#periodupto').jqxDateTimeInput('val');
					$('#invoicediv').load('invoiceGrid.jsp?branch='+branch+'&uptodate='+uptodate+'&mode=2');
				}
			} else {

			}
		}
		x.open("GET","checkMonthEnd.jsp?date="+date, true);
		x.send();
 }
	

	function funNotify(){
		var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
		if(docdateval==0){
			$('#periodupto').jqxDateTimeInput('focus');
			return false;
		}
/* 		var z=0;
    			    var rows = $("#rentalInvoiceGrid").jqxGrid('getrows');                    
    	if(rows.length>0 && (rows[0].rano=="undefined" || rows[0].rano==null || rows[0].rano=="")){
    		return false;
    	}
    			    var selectedRecords = new Array();
                    var selectedrows=$("#rentalInvoiceGrid").jqxGrid('selectedrowindexes');
        if(rows[0].amount=="undefined" || rows[0].amount==null || rows[0].amount==""){
            $.messager.alert('Warning','Please Calculate the Amount');
            return false;
        }
		if(selectedrows.length==0){
			$.messager.alert('Warning','Select an Invoice');
			return false;
		}
		   $.messager.confirm('Confirm', 'Do you want to Generate Invoice?', function(r){
	 			if (r){
	 				
	 				var i=0;
                    $('#invgridlength').val(selectedrows.length);
    			    for (i = 0; i < rows.length; i++) {
						for(var j=0;j<selectedrows.length;j++){
							if(selectedrows[j]==i){
								
								//alert("Inside"+z);
								//selectedRecords[j]=$("#rentalInvoiceGrid").jqxGrid('getrowdata', selectedrows[j]);
								newTextBox = $(document.createElement("input"))
							    .attr("type", "dil")
							    .attr("id", "testinvoice"+z)
							    .attr("name", "testinvoice"+z)
							    .attr("hidden","true");
								
							newTextBox.val(rows[i].rano+"::"+rows[i].ratype+"::"+rows[i].fromdate+"::"+rows[i].todate+"::"+rows[i].acno+"::"+rows[i].acname+"::"+rows[i].amount+"::"+rows[i].cldocno+"::"+rows[i].rentalsum+"::"+rows[i].accsum+"::"+rows[i].salikamt+"::"+rows[i].trafficamt+"::"+rows[i].saliksrvc+"::"+rows[i].trafficsrvc+"::"+rows[i].datediff+"::"+rows[i].brhid+"::"+rows[i].curid+"::"+rows[i].insurchg+"::"+rows[i].salikcount+"::"+rows[i].trafficcount+"::"+rows[i].salamount+"::"+rows[i].salrate);
							
							newTextBox.appendTo('form');
							z++;
							//alert("ddddd"+$("#testinvoice"+z).val());
							}
						}
						if(i==rows.length-1){
							 document.getElementById("mode").value='A';
							 $("#overlay, #PleaseWait").show();
							 document.getElementById("frmDashboardRentalInvoice").submit();
						}
			}
    			 
    		 			}
    		 	 		});
		 */
		 
		 
		 var selectedrows=$('#invoiceGrid').jqxGrid('selectedrowindexes');
		 if(selectedrows.length==0){
			 $.messager.alert('message','Please select any valid document');
			 return false;
		 }
		 $('#invgridlength').val(selectedrows.length);
		 
		 for(var i=0;i<selectedrows.length;i++){
			 var agmtno=$('#invoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'agmtno');
			 var rentaltype=$('#invoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'rentaltype');
			 newTextBox = $(document.createElement("input"))
			    .attr("type", "dil")
			    .attr("id", "testinvoice"+i)
			    .attr("name", "testinvoice"+i)
			    .attr("hidden","true");
				
			newTextBox.val(agmtno+"::"+rentaltype);
			newTextBox.appendTo('form');
		 }
		 document.getElementById("mode").value='A';
		 $("#overlay, #PleaseWait").show();
		 document.getElementById("frmDailyWeeklyInvoice").submit();
	}
	function setValues(){

		 if($('#msg').val()!=""){
   		  $.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
   		  }
	}
	function funExportBtn(){

/* 			 if(parseInt(window.parent.chkexportdata.value)=="1")
		  {
		  	JSONToCSVCon(invoicedata, 'Rental Invoice', true);
		  }
		 else
		  {
			 $("#rentalInvoiceGrid").jqxGrid('exportdata', 'xls', 'Rental Invoice');
		  }

		 */
		
	}
		
	
</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmDailyWeeklyInvoice" action="saveDailyWeeklyInvoice" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
	<tr>
		<td width="20%">
    		<fieldset style="background: #ECF8E0;">
				<table width="100%">
					<jsp:include page="../../heading.jsp"></jsp:include>
					<tr><td width="40%" align="right"><label class="branch">Period Upto</label></td><td width="60%"><div id="periodupto" name="periodupto"></div></td></tr>
					<tr>
						<td colspan="2"><center><input type="button" name="btninvoicesave" id="btninvoicesave" class="myButton" value="Generate" onclick="funNotify();"></center></td>
					</tr>
					<tr><td colspan="2"><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br></td></tr>	
				</table>
			</fieldset>
		</td>
		<td width="80%">
			<table width="100%">
				<tr>
			 		<td>
			 			<div id="imgdiv" style="position:absolute; z-index: 1;top:200;right:600;">
							<img id="imgloading" alt="" src="../../../../icons/29load.gif"/>
						</div>
						<div id="invoicediv">
							<jsp:include page="invoiceGrid.jsp"></jsp:include>
						</div>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>
</div>
<input type="hidden" name="invgridlength" id="invgridlength" >
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
</form>
</body>
</html>