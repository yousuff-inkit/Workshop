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
	$('#clientwindow').jqxWindow({ width: '62%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#clientwindow').jqxWindow('close');
	$('#client').dblclick(function(){
		$('#clientwindow').jqxWindow('open');
		$('#clientwindow').jqxWindow('focus');
		clientSearchContent('clientINgridsearch.jsp', $('#clientwindow'));
	});
	
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
function getClient(event){
	var x= event.keyCode;
    if(x==114){
    	$('#clientwindow').jqxWindow('open');
  		$('#clientwindow').jqxWindow('focus');
  		clientSearchContent('clientINgridsearch.jsp', $('#clientwindow'));
    }
    else{
    }
}

function clientSearchContent(url) {
	$.get(url).done(function (data) {
    	$('#clientwindow').jqxWindow('setContent', data);
	}); 
}

function funreload(event)
{
	if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=='a'){
		$.messager.alert('Warning','Please Select Branch');
        return false;
	}
	
	if($('#cmbtype').val()==''){
		$.messager.alert('Warning','Please Select Type');
        return false;
	}
	
	var dateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
	if(dateval==1){
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
					var branchvalue = document.getElementById("cmbbranch").value;
			     	var date1= $('#periodupto').jqxDateTimeInput('getText');
					var client=document.getElementById("hidclient").value;
			     	var type=$('#cmbtype').val();
			     	$('#leaseinvoicediv').load('leaseInvoiceGrid.jsp?date1='+date1+'&branch='+branchvalue+'&client='+client+'&id=1&type='+type);
				}
			} else {

			}
		}
		x.open("GET","checkMonthEnd.jsp?date="+date, true);
		x.send();
		
		
		
	}
	}
function funCalculate(){
	/* $("#overlay, #PleaseWait").show();  */
	/* var rows = $("#leaseInvoiceGrid").jqxGrid('getrows');
	if(rows.length==1 && (rows[0].rano=="undefined" || rows[0].rano==null || rows[0].rano=="")){
		return false;
	}
	 var date1= $('#periodupto').jqxDateTimeInput('getText');
		 var client=document.getElementById("hidclient").value;
		 var agmtno=document.getElementById("hidagmtno").value;
		 var branchvalue =document.getElementById("cmbbranch").value;
	$('#leaseinvoicediv').load('leaseInvoiceGrid.jsp?temp='+null+'&desc1='+document.getElementById("desc").value+'&date1='+date1+'&branch='+branchvalue+'&client='+client+'&mode=1&agmtno='+agmtno);
 */
	}
	

/* 	function funNotify(){
		
		var z=0;
    			    var rows = $("#leaseInvoiceGrid").jqxGrid('getrows');                    
    	if(rows.length>0 && (rows[0].rano=="undefined" || rows[0].rano==null || rows[0].rano=="")){
    		return false;
    	}
    			    var selectedRecords = new Array();
                    var selectedrows=$("#leaseInvoiceGrid").jqxGrid('selectedrowindexes');
        if(rows[0].amount=="undefined" || rows[0].amount==null || rows[0].amount==""){
            $.messager.alert('Warning','Please Calculate the Amount');
            return false;
        }
		if(selectedrows.length==0){
			$.messager.alert('Warning','Select an Invoice');
			return false;
		}
		var dataarray=new Array();
		$.messager.confirm('Confirm', 'Do you want to Generate Invoice?', function(r){
 			if (r){
		var i=0;
                    $('#invgridlength').val(selectedrows.length);
    			     for (i = 0; i < rows.length; i++) {
						for(var j=0;j<selectedrows.length;j++){
							if(selectedrows[j]==i){
								
								//alert("Inside"+z);
								//selectedRecords[j]=$("#rentalInvoiceGrid").jqxGrid('getrowdata', selectedrows[j]);
								/* newTextBox = $(document.createElement("input"))
							    .attr("type", "dil")
							    .attr("id", "testinvoice"+z)
							    .attr("name", "testinvoice"+z)
							    .attr("hidden","true");
						if(typeof(rows[i].rano)!="undefined" && rows[i].rano!="" && typeof(rows[i].acno)!="undefined" && rows[i].acno!="" && typeof(rows[i].amount)!="undefined" && rows[i].amount!=""){		
							dataarray.push(rows[i].rano+"::"+rows[i].ratype+"::"+rows[i].fromdate+"::"+rows[i].todate+"::"+rows[i].acno+"::"+rows[i].acname+"::"+rows[i].amount+"::"+rows[i].cldocno+"::"+rows[i].rentalsum+"::"+rows[i].accsum+"::"+rows[i].salikamt+"::"+rows[i].trafficamt+"::"+rows[i].saliksrvc+"::"+rows[i].trafficsrvc+"::"+rows[i].datediff+"::"+rows[i].brhid+"::"+rows[i].curid+"::"+rows[i].insurchg+"::"+rows[i].salikcount+"::"+rows[i].trafficcount+"::"+rows[i].salamount+"::"+rows[i].salrate);
							
							}
							//alert("ddddd"+$("#testinvoice"+z).val());
							z++;
							
							}
							
						}
						 var temprows=$("#leaseInvoiceGrid").jqxGrid('selectedrowindexes');
						
						for(var i=0;i<temprows.length;i++){
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							+"::"+rows[i].ratype+"::"+rows[i].fromdate+"::"+rows[i].todate+"::"+rows[i].acno+"::"+rows[i].acname+"::"+rows[i].amount+"::"+rows[i].cldocno+"::"+rows[i].rentalsum+"::"+rows[i].accsum+"::"+rows[i].salikamt+"::"+rows[i].trafficamt+"::"+rows[i].saliksrvc+"::"+rows[i].trafficsrvc+"::"+rows[i].datediff+"::"+rows[i].brhid+"::"+rows[i].curid+"::"+rows[i].insurchg+"::"+rows[i].salikcount+"::"+rows[i].trafficcount+"::"+rows[i].salamount+"::"+rows[i].salrate
							checkarray.push($('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano'));
						} 
						$('#reqhidden').val(dataarray);
							 document.getElementById("mode").value='A';
							 $("#overlay, #PleaseWait").show();
	    	    				document.getElementById("frmDashboardLeaseInvoice").submit();
						
		 }
    		 		
    	    			   
    		 			}
    		 	 		});

	} */
	
	function funNotify(){
		var selectedrows=$('#agmtDetailGrid').jqxGrid('selectedrowindexes');
		if(selectedrows.length==0){
			$.messager.alert('Warning','Please select valid documents');
			return false;
		}
		var agmtarray=new Array();
		for(var i=0;i<selectedrows.length;i++){
			var rano=$('#agmtDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'rano');
			var ratype=$('#agmtDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'ratype');
			var fromdate=$('#agmtDetailGrid').jqxGrid('getcelltext',selectedrows[i],'fromdate');
			var todate=$('#agmtDetailGrid').jqxGrid('getcelltext',selectedrows[i],'todate');
			var acno=$('#agmtDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'acno');
			var amount=$('#agmtDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'amount');
			var cldocno=$('#agmtDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'cldocno');
			var rentalsum=$('#agmtDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'rentalsum');
			var accsum=$('#agmtDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'accsum');
			var datediff=$('#agmtDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'datediff');
			var brhid=$('#agmtDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'brhid');
			var curid=$('#agmtDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'curid');
			var insurchg=$('#agmtDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'insurchg');
			var acname=$('#agmtDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'acname');
			agmtarray.push(rano+"::"+ratype+"::"+fromdate+"::"+todate+"::"+acno+"::"+amount+"::"+cldocno+"::"+rentalsum+"::"+accsum+"::"+datediff+"::"+brhid+"::"+curid+"::"+insurchg+"::"+acname);
			
		}
		document.getElementById("selectedagmt").value=agmtarray;
		$('#mode').val('A');
		document.getElementById("frmDashboardLeaseInvoiceEasy").submit();
		
	}
	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
   		  }
		
	}
	 function funExportBtn(){
		if(parseInt(window.parent.chkexportdata.value)=="1")
		  {
		  	JSONToCSVCon(invoicedata, 'Lease Invoice', true);
		  }
		 else
		  {
			 $("#leaseInvoiceGrid").jqxGrid('exportdata', 'xls', 'Lease Invoice');
		  }
		 
	}

		
</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmDashboardLeaseInvoiceEasy" action="saveDashboardLeaseInvoiceEasy" method="post" >
<input type="hidden" id="selectedagmt" name="selectedagmt">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>
	
	<!--  <tr><td colspan="2">&nbsp;</td></tr> -->
 <tr><td><label class="branch">Period Upto</label></td><td><div id="periodupto" name="periodupto"></div></td></tr>
<tr><td><label class="branch">Client</label></td><td><input type="text" name="client" id="client" onkeydown="getClient(event);" readonly value='<s:property value="client"/>'></td></tr>
<tr><td><label class="branch">Type</label></td><td><select name="cmbtype"><option value="1">Monthly</option><option value="2">Period</option></select></td></tr>

<%--<tr>
  <td colspan="2" align="center"><label class="branch" for="chkall">All</label><input type="checkbox" name="chkall" id="chkall" onchange="setAll();"></td>
  <td width="28%" rowspan="3" align="left">&nbsp;</td>
</tr>
 <tr>
  <td colspan="2" align="left"><fieldset><legend>Separate Invoice</legend>
    <div align="center">
      <input type="radio" name="chksalik" id="chksalik" onChange="setSalik();">&nbsp;<label class="branch">Salik</label>&nbsp;&nbsp;
      <input type="radio" name="chktraffic" id="chktraffic" onchange="setTraffic();">&nbsp;<label class="branch">Traffic</label>
      </div>
  </fieldset></td>
  </tr> 
 
  <tr>
  <td colspan="2" align="left"><fieldset><legend>Not To Be Invoiced</legend>
    <div align="center">
      <input type="radio" name="chksalik" id="chkexsalik" onChange="setSalik();">&nbsp;<label class="branch">Salik</label>&nbsp;&nbsp;
      <input type="radio" name="chktraffic" id="chkextraffic" onchange="setTraffic();">&nbsp;<label class="branch">Traffic</label>
      </div>
  </fieldset></td>
  </tr>  
 <input type="hidden" name="hidchkall" id="hidchkall" value='<s:property value="hidchkall"/>'>
  <input type="hidden" name="hidchksalik" id="hidchksalik" value='<s:property value="hidchksalik"/>'>
  <input type="hidden" name="hidchktraffic" id="hidchktraffic" value='<s:property value="hidchktraffic"/>'>
   <input type="hidden" name="hidchkexsalik" id="hidchkexsalik" value='<s:property value="hidchkexsalik"/>'>
  <input type="hidden" name="hidchkextraffic" id="hidchkextraffic" value='<s:property value="hidchkextraffic"/>'> --%>
  <input type="hidden" name="hidagmtno" id="hidagmtno" value='<s:property value="hidagmtno"/>'>
<input type="hidden" name="hidclient" id="hidclient" >

		<%--  <tr>
	<td colspan="2"> <div id="Readygrid" ><jsp:include page="invnoGrid.jsp"></jsp:include>
	</div> </td>
	</tr> --%> 
	<tr>
	<td colspan="2"><center><input type="button" name="btninvoicesave" id="btninvoicesave" class="myButton" value="Generate" onclick="funNotify();"></center></td>
	</tr>
   
	<tr>
	<td colspan="2"><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br></td>
	</tr>	
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td> <div id="imgdiv" style="position:absolute; z-index: 1;top:200;right:600;">
<img id="imgloading" alt="" src="../../../../icons/31load.gif"/></div> <div id="leaseinvoicediv"> <!-- 29load -->
<jsp:include page="leaseInvoiceGrid.jsp"></jsp:include></div><div id="leaseagmtdiv"> <!-- 29load -->
<jsp:include page="agmtDetailGrid.jsp"></jsp:include></div></td>
			 <input type="hidden" name="gridlength" id="gridlength" >
			  <input type="hidden" name="invgridlength" id="invgridlength" >
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
		</tr>
	</table>
</tr>
</table>
</div>
<div id="clientwindow">
<div></div>
</div>
<div id="agmtwindow">
<div></div>
</div>
</div>
</form>
</body>
</html>