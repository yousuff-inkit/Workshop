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
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<style type="text/css">
	.loading-container{
            background-color: #fff;
            position: absolute;
            transform: translate(-50%, -50%);
            left: 50%;
            top: 40%;
            z-index: 99999;
            box-shadow: 0 19px 38px rgba(0,0,0,0.30), 0 15px 12px rgba(0,0,0,0.22);
            border-radius: 5px;
            padding-right: 25px;
            padding-left: 25px;
            display: none;
        }
        .loading-container span{
            padding: 5px 25px 5px 25px;
        }
        .loading-container i{
            padding-top: 15px;
            padding-bottom: 15px;
            font-size: 1.6em !important;
            margin-right: 20px;
        }
</style>
<script type="text/javascript">
$(document).ready(function () {
	 /* $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");  */
	 $('#total,#courtesy,#amount,#netamount,#salikamt,#saliksrvcamt,#trafficamt,#trafficsrvcamt').attr('readonly',true);
	 $("#periodupto").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:new Date()});
	 $("#indate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:new Date()});
	 $("#intime").jqxDateTimeInput({ width: '80%', height: '17px', formatString: 'HH:mm', showCalendarButton: false ,value:new Date()});
	 $('#periodupto').on('change', function (event) 
	 	{  
			var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
			if(docdateval==0){
				$('#periodupto').jqxDateTimeInput('focus');
				return false;
			}
		});
	 $('input[type=text]').css('height','18px');
});

function funreload(event)
{
	if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=='a'){
		$.messager.alert('Warning','Please Select Branch');
		return false;
	}
	
	
	$('#overlay').show();
	
	//Tracker Km Update
    
    var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			items = x.responseText;
			items=items.trim();
			//alert(items);
			/* if(parseInt(items)>0){
				$('#docno').val(parseInt(items));
				$('#overlay,PleaseWait').show();
				$('#gpsdiv').load('gpsGrid.jsp?docno='+items+'&id=1');
			}
			else{
				$.messager.alert('Warning','Download Not Completed');
				return false;
			} */
			} else {
		}
	}
	x.open("GET", "updateTrackerKm.jsp", true);
	x.send();
	
	var dateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
	if(dateval==1){
		var branch = document.getElementById("cmbbranch").value;
    	var date= $('#periodupto').jqxDateTimeInput('getText');
    	$("#detaildiv").load("detailGrid.jsp?branch="+branch+"&date="+date+"&id=1");
	}
}
	function funNotify(){
/* 		var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
		if(docdateval==0){
			$('#periodupto').jqxDateTimeInput('focus');
			return false;
		}
		var z=0;
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
		document.getElementById("mode").value='A';
		 $("#overlay, #PleaseWait").show();
		 document.getElementById("frmRentalAgmtEMCClose").submit();
	}
	function setValues(){

		 if($('#msg').val()!=""){
   		  $.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
   		  }
		 funClearData();
	}
	function funExportBtn(){

			 if(parseInt(window.parent.chkexportdata.value)=="1")
		  {
		  	JSONToCSVCon(data, 'Rental Agreement Close', true);
		  }
		 else
		  {
			 $("#detailGrid").jqxGrid('exportdata', 'xls', 'Rental Invoice');
		  }

		
		
	}
	
	function isNumber(evt,id) {
		//Function to restrict characters and enter number only
			  var iKeyCode = (evt.which) ? evt.which : evt.keyCode
		        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
		         {
		        	 $.messager.alert('Warning','Enter Numbers Only');
		           $("#"+id+"").focus();
		            return false;
		            
		         }
		        
		        return true;
	}
	function funCalculate(){
		var rowindex=$('#rowindex').val();
	    $('#client').val($('#detailGrid').jqxGrid('getcellvalue',rowindex,'refname'));
	    $('#outkm').val($('#detailGrid').jqxGrid('getcellvalue',rowindex,'outkm'));
	    $('#outfuel').val($('#detailGrid').jqxGrid('getcellvalue',rowindex,'outfuelvalue'));
	    if($('#indate').jqxDateTimeInput('getDate')==null){
	    	$.messager.alert('Warning','In Date is Mandatory');
	    	return false;
	    }
	    if($('#intime').jqxDateTimeInput('getDate')==null){
	    	$.messager.alert('Warning','In Time is Mandatory');
	    	return false;
	    }
	    if($('#inkm').val()==''){
	    	$.messager.alert('Warning','In Km is Mandatory');
	    	return false;
	    }
	    if($('#cmbinfuel').val()==''){
	    	$.messager.alert('Warning','In Fuel is Mandatory');
	    	return false;
	    }
	    
	    var indate=$('#indate').jqxDateTimeInput('getText');
	    var intime=$('#intime').jqxDateTimeInput('getText');
	    var inkm=$('#inkm').val();
	    var agmtno=$('#detailGrid').jqxGrid('getcellvalue',rowindex,'doc_no');
	    
	    calculateData(indate,intime,agmtno,inkm);
	}
	
	function calculateData(indate,intime,agmtno,inkm){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split("::");
				if(items[10]=='1'){
					$.messager.alert('Warning','In Date cannot be less than Out Date');
					return false;
				}
				else if(items[11]=='1'){
					$.messager.alert('Warning','In Time cannot be less than Out Time');
					return false;
				}
				else if(items[12]=='1'){
					$.messager.alert('Warning','In Km cannot be less than Out Km');
					return false;
				}
				if(items[10]!='1' && items[11]!='1' && items[12]!='1'){
					$('#useddays').val(items[1]);
					$('#usedhours').val(items[0]);
					$('#total').val(items[2]);
					$('#courtesy').val(items[3]);
					var remainamt=parseFloat($('#total').val())-parseFloat($('#courtesy').val());
					$('#amount').val(remainamt);
					$('#netamount').val(remainamt);
					$('#salikamt').val(items[4]);
					$('#trafficamt').val(items[5]);
					$('#saliksrvcamt').val(items[6]);
					$('#trafficsrvcamt').val(items[7]);
					$('#salikcount').val(items[8]);
					$('#trafficcount').val(items[9]);
					
			    	if($('#discount').val()!='' && parseFloat($('#discount').val())!=0.0){
			    		$('#netamount').val(remainamt)-parseFloat($('#discount').val());
			    	}
			    	
			    	/* funSetNetAmount($('#discount').val()); */
			    	$('#total,#amount,#netamount,#salikamt,#trafficamt,#saliksrvcamt,#trafficsrvcamt,#discount,#courtesy').trigger('blur');	
				}
				
			}
		}
	     x.open("GET","calculateData.jsp?indate="+indate+"&intime="+intime+"&agmtno="+agmtno+"&inkm="+inkm,true);
	    x.send();
	   
	}	

	function funSetNetAmount(value){
		if(value!="" && parseFloat(value)!=0.0){
			var netamount=parseFloat($('#amount').val())-parseFloat($('#discount').val());
			$('#netamount').val(netamount);
		}
		else{
			$('#netamount').val($('#amount').val());
		}
	}
	
	function funClearData(){
		$('input[type=text],input[type=hidden]').val('');
		$('#indate,#intime').jqxDateTimeInput('setDate',new Date());
	}
	</script>
</head>
<body onload="getBranch();setValues();">
<div id="overlay" class="loading-container">
    <span><i class="fa fa-refresh fa-spin"></i>Please Wait</span>
</div>
<form id="frmRentalAgmtEMCClose" action="saveRentalAgmtEMCClose" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<table width="100%">
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>
	<tr><td width="40%" align="right"><label class="branch">Period Upto</label></td><td width="60%"><div id="periodupto"></div></td></tr>
	<tr><td align="right"><label class="branch">Client</label></td><td><input type="text" id="client" name="client"></td></tr>
    <tr><td align="right"><label class="branch">In Date</label></td><td><div id="indate" name="indate"></div></td></tr>
    <tr><td align="right"><label class="branch">In Time</label></td><td><div id="intime" name="intime"></div></td></tr>
    <tr><td align="right"><label class="branch">In Km</label></td><td><input type="text" id="inkm" name="inkm"></td></tr>
    <tr><td align="right"><label class="branch">In Fuel</label></td>
    	<td>
    		<select name="cmbinfuel" id="cmbinfuel">
               <option value="">-Select-</option>
               <option value=0.000>Level 0/8</option>
               <option value=0.125>Level 1/8</option>
               <option value=0.250>Level 2/8</option>
               <option value=0.375>Level 3/8</option>
               <option value=0.500>Level 4/8</option>
               <option value=0.625>Level 5/8</option>
               <option value=0.750>Level 6/8</option>
               <option value=0.875>Level 7/8</option>
               <option value=1.000>Level 8/8</option>
           </select>
        </td>
    </tr>
    <tr><td align="right"><label class="branch">Total</label></td><td><input type="text" id="total" name="total" style="text-align:right;" onkeypress="javascript:return isNumber (event,id)" onblur="funRoundAmt(value,id);"></td></tr>
    <tr><td align="right"><label class="branch">Courtesy Cost</label></td><td><input type="text" id="courtesy" name="courtesy" style="text-align:right;" onkeypress="javascript:return isNumber (event,id)" onblur="funRoundAmt(value,id);"></td></tr>
    <tr><td align="right"><label class="branch">Amount</label></td><td><input type="text" id="amount" name="amount" style="text-align:right;" onkeypress="javascript:return isNumber (event,id)" onblur="funRoundAmt(value,id);"></td></tr>
    <tr><td align="right"><label class="branch">Discount</label></td><td><input type="text" id="discount" name="discount" style="text-align:right;" onkeypress="javascript:return isNumber (event,id)" onblur="funRoundAmt(value,id);funSetNetAmount(value);"></td></tr>
    <tr><td align="right"><label class="branch">Net Amount</label></td><td><input type="text" id="netamount" name="netamount" style="text-align:right;" onkeypress="javascript:return isNumber (event,id)" onblur="funRoundAmt(value,id);"></td></tr>
    <tr><td align="right"><label class="branch">Salik</label></td><td><input type="text" id="salikamt" name="salikamt" style="text-align:right;" onkeypress="javascript:return isNumber (event,id)" onblur="funRoundAmt(value,id);"></td></tr>
    <tr><td align="right"><label class="branch">Salik Srvc</label></td><td><input type="text" id="saliksrvcamt" name="saliksrvcamt" style="text-align:right;" onkeypress="javascript:return isNumber (event,id)" onblur="funRoundAmt(value,id);"></td></tr>
    <tr><td align="right"><label class="branch">Traffic</label></td><td><input type="text" id="trafficamt" name="trafficamt" style="text-align:right;" onkeypress="javascript:return isNumber (event,id)" onblur="funRoundAmt(value,id);"></td></tr>
    <tr><td align="right"><label class="branch">Traffic Srvc</label></td><td><input type="text" id="trafficsrvcamt" name="trafficsrvcamt" style="text-align:right;" onkeypress="javascript:return isNumber (event,id)" onblur="funRoundAmt(value,id);"></td></tr>
	<tr><td colspan="2"><hr style="width=100%;"></td></tr>
	<tr>
	<td colspan="2"><center><input type="button" name="btnclose" id="btnclose" class="myButton" value="Close Agreement" onclick="funNotify();"></center></td>
	</tr>
		
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td> <div id="imgdiv" style="position:absolute; z-index: 1;top:200;right:600;">
<img id="imgloading" alt="" src="../../../../icons/29load.gif"/></div> <div id="detaildiv"><jsp:include page="detailGrid.jsp"></jsp:include></div></td>
			 <input type="hidden" name="gridlength" id="gridlength" >
			  <input type="hidden" name="invgridlength" id="invgridlength" >
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  <input type="hidden" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>'>
			  <input type="hidden" name="outkm" id="outkm" value='<s:property value="outkm"/>'>
			  <input type="hidden" name="outfuel" id="outfuel" value='<s:property value="outfuel"/>'>
			  <input type="hidden" name="useddays" id="useddays" value='<s:property value="useddays"/>'>
			  <input type="hidden" name="usedhours" id="usedhours" value='<s:property value="usedhours"/>'>
			  <input type="hidden" name="agmtno" id="agmtno" value='<s:property value="agmtno"/>'>
			  <input type="hidden" name="salikcount" id="salikcount" value='<s:property value="salikcount"/>'>
			  <input type="hidden" name="trafficcount" id="trafficcount" value='<s:property value="trafficcount"/>'>
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