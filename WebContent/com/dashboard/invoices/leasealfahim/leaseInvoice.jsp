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
	document.getElementById("btninvoicesave").style.display="none";
    /* Partial Pie Chart Starts*/
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
	  document.getElementById("chkall").checked=true;
		setAll();
		setSalik();
	   setTraffic();
	   $('#saperatefield,#notfield,#lblchkall,#chkall').hide();
	   
	   $('#periodupto').on('change', function (event) 
				{  
					var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
					if(docdateval==0){
						$('#periodupto').jqxDateTimeInput('focus');
						return false;
					}
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
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#clientwindow').jqxWindow('setContent', data);

}); 
}
function funreload(event)
{
	if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=='a'){
		 $.messager.alert('Warning','Please Select Branch');
         return false;
	}
	var dateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
	if(dateval==1){
	 var barchval = document.getElementById("cmbbranch").value;
     	 var date1= $('#periodupto').jqxDateTimeInput('getText');
     		 //alert("barchval"+barchval);
     		 var client=document.getElementById("hidclient").value;
     		$('#leaseInvoiceGrid').jqxGrid('clear');
     		$("#leaseInvoiceGrid").jqxGrid("addrow", null, {});	
     		document.getElementById("btninvoicesave").style.display="none";
     		/* document.getElementById("client").value="";
     		document.getElementById("hidclient").value=""; */
	  $("#Readygrid").load("invnoGrid.jsp?barchval="+barchval+"&date1="+date1+"&client="+client+"&status=1");
	}
	}
function funCalculate(){
	var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
	if(docdateval==0){
		$('#periodupto').jqxDateTimeInput('focus');
		return false;
	}
	$("#overlay, #PleaseWait").show(); 
	var rows = $("#leaseInvoiceGrid").jqxGrid('getrows');
	if(rows.length==1 && (rows[0].rano=="undefined" || rows[0].rano==null || rows[0].rano=="")){
		return false;
	}
	 var date1= $('#periodupto').jqxDateTimeInput('getText');
		 var client=document.getElementById("hidclient").value;
		 var branchvalue =document.getElementById("cmbbranch").value;
	$('#leaseinvoicediv').load('leaseInvoiceGrid.jsp?temp='+null+'&desc1='+document.getElementById("desc").value+'&date1='+date1+'&branch='+branchvalue+'&client='+client+'&mode=1');

	}
	

	function funNotify(){
		var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
		if(docdateval==0){
			$('#periodupto').jqxDateTimeInput('focus');
			return false;
		}
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
		$.messager.confirm('Confirm', 'Do you want to Generate Revenue?', function(r){
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
						if(typeof(rows[i].rano)!="undefined" && rows[i].rano!="" && typeof(rows[i].acno)!="undefined" && rows[i].acno!="" && typeof(rows[i].amount)!="undefined" && rows[i].amount!=""){		
							newTextBox.val(rows[i].rano+"::"+rows[i].ratype+"::"+rows[i].fromdate+"::"+rows[i].todate+"::"+rows[i].acno+"::"+rows[i].acname+"::"+rows[i].amount+"::"+rows[i].cldocno+"::"+rows[i].rentalsum+"::"+rows[i].accsum+"::"+rows[i].salikamt+"::"+rows[i].trafficamt+"::"+rows[i].saliksrvc+"::"+rows[i].trafficsrvc+"::"+rows[i].datediff+"::"+rows[i].brhid+"::"+rows[i].curid+"::"+rows[i].insurchg+"::"+rows[i].salikcount+"::"+rows[i].trafficcount+"::"+rows[i].salamount+"::"+rows[i].salrate);
							
							newTextBox.appendTo('form');
							}
							//alert("ddddd"+$("#testinvoice"+z).val());
							z++;
							
							}
							
						}
						//alert(i+"::::::"+rows.length);
						
							 document.getElementById("mode").value='A';
							 $("#overlay, #PleaseWait").show();
	    	    				document.getElementById("frmDashboardLeaseInvoiceAlFahim").submit();
						
			}
    		 		
    	    			   
    		 			}
    		 	 		});

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

	 	function setSalik(){
			
	 		if(document.getElementById("chksalik").checked==true){
				document.getElementById("hidchksalik").value="1";
				document.getElementById("hidchkexsalik").value="0";
				document.getElementById("chkall").checked=false;
	 		}
	 		if(document.getElementById("chkexsalik").checked==true){
				document.getElementById("hidchkexsalik").value="1";
				document.getElementById("hidchksalik").value="0";
				document.getElementById("chkall").checked=false;
	 		} 
		}
		
		function setTraffic(){
			
			if(document.getElementById("chktraffic").checked==true){
				document.getElementById("hidchktraffic").value="1";
				document.getElementById("hidchkextraffic").value="0";
				document.getElementById("chkall").checked=false;
			}
			if(document.getElementById("chkextraffic").checked==true){
				document.getElementById("hidchkextraffic").value="1";
				document.getElementById("hidchktraffic").value="0";
				document.getElementById("chkall").checked=false;
			}
			}
		
		 function setAll(){
			 if(document.getElementById("chkall").checked==true){
				 document.getElementById("hidchkall").value="1";
				 $('#chksalik').removeAttr('checked');
				 $('#chkexsalik').removeAttr('checked');
				 $('#chktraffic').removeAttr('checked');
				 $('#chkextraffic').removeAttr('checked');
				 document.getElementById("hidchksalik").value="0";
				 document.getElementById("hidchkexsalik").value="0";
				 document.getElementById("hidchktraffic").value="0";
				 document.getElementById("hidchkextraffic").value="0";
			 }
			 else{
				 document.getElementById("hidchkall").value="0";
				
			 }
		 }
</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmDashboardLeaseInvoiceAlFahim" action="saveDashboardLeaseInvoiceAlFahim" method="post">

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
<tr>
  <td colspan="2" align="center"><label class="branch" for="chkall" id="lblchkall">All</label><input type="checkbox" name="chkall" id="chkall" onchange="setAll();"></td>
  <td width="28%" rowspan="3" align="left">&nbsp;</td>
</tr>
<tr>
  <td colspan="2" align="left"><fieldset id="saperatefield"><legend>Separate Invoice</legend>
    <div align="center">
      <input type="radio" name="chksalik" id="chksalik" onChange="setSalik();">&nbsp;<label class="branch">Salik</label>&nbsp;&nbsp;
      <input type="radio" name="chktraffic" id="chktraffic" onchange="setTraffic();">&nbsp;<label class="branch">Traffic</label>
      </div>
  </fieldset></td>
  </tr> 
 
  <tr>
  <td colspan="2" align="left"><fieldset id="notfield"><legend>Not To Be Invoiced</legend>
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
  <input type="hidden" name="hidchkextraffic" id="hidchkextraffic" value='<s:property value="hidchkextraffic"/>'>
<input type="hidden" name="hidclient" id="hidclient" >
		 <tr>
	<td colspan="2"> <div id="Readygrid" ><jsp:include page="invnoGrid.jsp"></jsp:include>
	</div> </td>
	</tr> 
	<tr>
	<td colspan="2"><center><input type="button" name="btninvoicesave" id="btninvoicesave" class="myButton" value="Generate" onclick="funNotify();"></center></td>
	</tr>
   
	<tr>
	<td colspan="2"><br><br><br><br><br><br></td>
	</tr>	
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td> <div id="imgdiv" style="position:absolute; z-index: 1;top:200;right:600;">
<img id="imgloading" alt="" src="../../../../icons/31load.gif"/></div> <div id="leaseinvoicediv"> <!-- 29load -->
<jsp:include page="leaseInvoiceGrid.jsp"></jsp:include></div> </td>
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
</div>
</form>
</body>
</html>