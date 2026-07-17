<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/resample.js"></script>
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
</style>

<script type="text/javascript">

$(document).ready(function () 
{
	$("#btnExcel").click(function() {
if(parseInt(window.parent.chkexportdata.value)=="1")
		  {
		  	JSONToCSVCon(invoicedata, 'Invoice Dispatch List', true);
		  }
		 else
		  {
			 $("#rentalInvoiceGrid").jqxGrid('exportdata', 'xls', 'Invoice Dispatch List');
		  }
			}); 

	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>"); 
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});

	 $('#clientDetailsWindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	 $('#clientDetailsWindow').jqxWindow('close');
	 
	 $('#agreementDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Agreement Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#agreementDetailsWindow').jqxWindow('close');
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
	  $('#txtclientname').dblclick(function(){
		  clientSearchContent('clientDetailsSearchGrid.jsp');
		});
	  
	  $('#agmtvocno').dblclick(function(){
		
		  agreementSearchContent('agreementDetailsSearch.jsp'); 
		});
});

	function clientSearchContent(url) {
	    $('#clientDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientDetailsWindow').jqxWindow('setContent', data);
		$('#clientDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function agreementSearchContent(url) {
	 	$('#agreementDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#agreementDetailsWindow').jqxWindow('setContent', data);
		$('#agreementDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getClient(event){
	    var x= event.keyCode;
	    if(x==114){
	    	clientSearchContent('clientDetailsSearchGrid.jsp');
	    }
	    else{}
	    }
	
	function getAgreement(event){
	    var x= event.keyCode;
	    if(x==114){
	    
	    	var branchval = document.getElementById("cmbbranch").value; 
  		    agreementSearchContent('agreementDetailsSearch.jsp');
	    }
	    else{}
	    }
	
/* 	function funSearchdblclick(){
		
	}
	 */
	 function funExportBtn(){
		   $("#rentalInvoiceGrid").jqxGrid('exportdata', 'xls', 'Invoices List');
		 }

	function  funClearData(){
		 $('#txtclientname').val('');$('#agmtvocno').val('');$('#txtcldocno').val('');$('#rentaltype').val('');$('#txtagreementno').val('');$('#todate').val(new Date());$('#clstatuss').val('');
		
		 var onemounth=new Date(new Date((new Date())).setMonth(new Date().getMonth()-1)); 
		
		 $('#fromdate').val(onemounth);
           $('#todate').val(new Date());
	     
		 if (document.getElementById("txtclientname").value == "") {
		        $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
		    }
		 if (document.getElementById("txtagreementno").value == "") {
		        $('#txtagreementno').attr('placeholder', 'Press F3 to Search'); 
		    }
	 }
	
	function funreload(event){
		

		  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  } 
		   else
			   {
			   
			   var docdateval=funDateInPeriod($('#todate').jqxDateTimeInput('getDate'));
				if(docdateval==0){
					$('#todate').jqxDateTimeInput('focus');
					return false;
				}
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var cldocno = $('#txtcldocno').val();
		 var rentaltype = $('#rentaltype').val();
		 var agmtno = $('#agmtvocno').val();
		 var clstatuss= $('#clstatuss').val();
		 var invtype=$('#cmbinvtype').val();
		 $("#overlay, #PleaseWait").show();
		 $("#notInvoicedDiv").load("rentalInvoiceGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&cldocno='+cldocno+'&rentaltype='+rentaltype+'&agmtno='+agmtno+'&clstatuss='+clstatuss+'&invtype='+invtype);
			   }
			   }
	function chktype()
	{
		
		
		 if($('#rentaltype').val()=="")
		  {
			  $.messager.alert('Message','Select Type  ','warning');   
				 document.getElementById("rentaltype").focus(); 
			   return false;
	
		  }
		
		
	}
	
	
	function clearagno()
	{
		$('#txtagreementno').val('');
		$('#agmtvocno').val('');
	}
	
	function funPrintData(){
		
		var selectedrows=$('#rentalInvoiceGrid').jqxGrid('selectedrowindexes');
		var rows=$('#rentalInvoiceGrid').jqxGrid('getrows');
		document.getElementById("printdocno").value="";
		if(selectedrows.length==0){
			$.messager.alert('Warning','Please select valid invoice');
			return false;
		}
		for(var j=0;j<rows.length;j++){
			for(var i=0;i<selectedrows.length;i++){
				if(selectedrows[i]==j){
					if(i==0){
						document.getElementById("printdocno").value+=rows[j].doc_no;
					}
					else{
						document.getElementById("printdocno").value+=","+rows[j].doc_no;	
					}
				}
			}	
		}
		if(document.getElementById("printdocno").value!=""){
			var url=document.URL;
			 var docno="";
			 var reurl=url.split("com");
	    	 var win= window.open(reurl[0]+"com/operations/commtransactions/invoice/printManualInvoice?fromno="+docno+"&tono="+docno+"&branch="+document.getElementById("cmbbranch").value+"&printdocno="+document.getElementById("printdocno").value+"&allbranch=1","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	    	win.focus();	
		}
		 
		
	}
	function funDispatchData(){
		var selectedrows=$('#rentalInvoiceGrid').jqxGrid('selectedrowindexes');
		if(selectedrows.length==0){
			$.messager.alert('Warning','Please select valid invoice');
			return false;
		}
		document.getElementById("printdocno").value="";
		for(var i=0;i<selectedrows.length;i++){
			if(i==0){
				document.getElementById("printdocno").value+=$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
			}
			else{
				document.getElementById("printdocno").value+=":"+$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
			}
		}
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			
			
			 	var items= x.responseText;
			 	if(parseInt(items)>0){
			 		$.messager.alert('Message','Record Successfully Dispatched','warning');   
			 	}
			 	else{
			 		$.messager.alert('Message','Not Dispatched','warning');
			 	}
			
			 	 
			 	funreload(event);
				
			 	 
	    }
		}
	     x.open("GET","dispatchData.jsp?invno="+document.getElementById("printdocno").value,true);
	    x.send();
	   

	}

function funSendingEmail() {  
		var selectedrows=$('#rentalInvoiceGrid').jqxGrid('selectedrowindexes');
		var rows=$('#rentalInvoiceGrid').jqxGrid('getrows');
		var email="";
		var printdoc="";
		var vocno="";
		var res;var part1;var part2;var dotsplt;
	
	var docno="";
		
		if(selectedrows.length==0){
			$.messager.alert('Warning','Please select valid invoice');
			return false;
		}
		if(selectedrows.length>1){
			$.messager.alert('Warning','Select Only One Invoice');
			return false;
		}
		for(var j=0;j<rows.length;j++){
			for(var i=0;i<selectedrows.length;i++){
				if(selectedrows[i]==j){
					/* if(i==0){
						document.getElementById("printdocno").value+=rows[j].doc_no;
					}
					else{
						document.getElementById("printdocno").value+=","+rows[j].doc_no;	
					} */
					email=rows[j].mail1;
					printdoc=rows[j].doc_no;
					vocno=rows[j].voc_no;
					brhid=rows[j].brhid;
				}
			}	
		}
		if(printdoc!=""){
			docno="";
		}
    
	    if(email.indexOf("@")>=0) {
		    res = email.split('@');
		    part1=res[0];
		    part2=res[1];
		    dotsplt=part2.split('.');
	    }
	  
	  if(email.trim()=="" || typeof(email.trim())=="undefined" || typeof(email.trim())=="NaN") {
		    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
	  } else if(email.indexOf("@")<0) {
		    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
	  } else if(email.split('@').length!=2) {
		    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
	  } else if(part1.length==0) {
		    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
	  } else if(part1.split(" ").length>2) {
		    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
    } else if(part2.split(".").length<2) {
  	    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
    } else if(dotsplt[0].length==0 ) {
  	    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
    } else if(dotsplt[1].length<2 ||dotsplt[1].length>4) {
  	    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
    } else {
		
		    $("#overlay, #PleaseWait").show();
		   
	 		$.ajaxFileUpload ({  
	 			
	    	    	  url: "printManualInvoiceJasper.action?fromno="+docno+"&tono="+docno+"&branch="+document.getElementById("cmbbranch").value+"&printdocno="+printdoc+"&email="+email+"&vocno="+vocno+"&brhid="+brhid+"&allbranch=1",  
	    	          secureuri:false,//false  
	    	          fileElementId:'file', //id  <input type="file" id="file" name="file" />  
	    	          dataType: 'string',// json  
	    	          success: function (data, status) {  
	    	        	
	    	             if(status=='success'){
							$("#overlay, #PleaseWait").hide();
							$.messager.alert('Message','E-Mail Send Successfully');
	    	              }
	    	             if(status=='error'){
	    	            	 $("#overlay, #PleaseWait").hide();
	    	            	 $.messager.alert('Message','E-Mail Sending failed');
	    	             }
	    	             
	    	              $("#testImg").attr("src",data.message);
	    	              if(typeof(data.error) != 'undefined')  
	    	              {  
	    	                  if(data.error != '')  
	    	                  {  
	    	                      alert(data.error);  
	    	                  }else  
	    	                  {  
	    	                      alert(data.message);  
	    	                  }  
	    	              }  
	    	          },  
	    	           error: function (data, status, e)
	    	          {  
	    	              alert(e);  
	    	          }  
	    	      }) 
	    	     return false;
		
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
	<tr><td align="right"><label class="branch">Client</label></td>
	<td align="left"><input type="text" id="txtclientname" name="txtclientname" style="width:100%;height:20px;" readonly="readonly" placeholder="Press F3 to Search"  onkeydown="getClient(event);" value='<s:property value="txtclientname"/>'/>
    <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/></td></tr>
    <tr><td align="right"><label class="branch">Inv Type</label></td>
	<td align="left"><select id="cmbinvtype" name="cmbinvtype">
						<option value="">--Select--</option>
						<option value="rental">Rental</option>
						<option value="lease">Lease</option>
						<option value="traffic">Traffic</option>
						<option value="salik">Salik</option>
						<option value="damage">Damage</option>
						<option value="extrasrvc">Extra Services</option>
						<option value="extrakm">Extra KM</option>
					</select>
	</td></tr>
    
    <tr><td align="right"><label class="branch">Status</label></td>
     <td align="left"><select id="clstatuss" name="clstatuss"  value='<s:property value="clstatuss"/>'>
     <option value="">--Select--</option><option value=0>Open</option><option value=1>Close</option>
     </select></td></tr>
	<tr><td align="right"><label class="branch">Agmt Type</label></td>
     <td align="left"><select id="rentaltype" name="rentaltype" onchange="clearagno()" value='<s:property value="rentaltype"/>'>
     <option value="">--Select--</option><option value="RAG">Rental</option><option value="LAG">Lease</option>
     </select></td></tr>
	<tr><td align="right"><label class="branch">Agreement</label></td>
	<td align="left"><input type="text" id="agmtvocno" name="agmtvocno" style="width:100%;height:20px;" readonly="readonly" onfocus="chktype()" placeholder="Press F3 to Search"  onkeydown="getAgreement(event);" value='<s:property value="agmtvocno"/>'/></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearData();">
	<input type="button" class="myButtons" name="print" id="print"  value="Print" onclick="funPrintData();">
	<input type="button" class="myButtons" name="dispatch" id="dispatch"  value="Dispatch" onclick="funDispatchData();">
<!-- 	<button class="myButton" type="button" id="btnSalikInvoicePrint" name="btnSalikInvoicePrint" onclick="funSalikInvoicePrint();">Print</button> --></td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="notInvoicedDiv"><jsp:include page="rentalInvoiceGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>

<div id="clientDetailsWindow">
	<div></div><div></div>
</div>
<div id="agreementDetailsWindow">
	<div></div><div></div>
</div>
<input type="hidden" name="printdocno" id="printdocno">
<input type="hidden" id="txtagreementno" name="txtagreementno" style="width:100%;height:20px;" readonly="readonly" onfocus="chktype()" placeholder="Press F3 to Search" ondblclick="funSearchdblclick();" onkeydown="getAgreement(event);" value='<s:property value="txtagreementno"/>'/>
</div> 
</body>
</html>