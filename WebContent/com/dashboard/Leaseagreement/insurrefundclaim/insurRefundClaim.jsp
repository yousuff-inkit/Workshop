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
</style>
<script type="text/javascript">

$(document).ready(function () {

	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#griddate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");    
	 $('#insurwindow').jqxWindow({ width: '30%', height: '62%',  maxHeight: '54%' ,maxWidth: '50%' , title: 'Insurance Search' ,position: { x: 300, y: 100 }, keyboardCloseKey: 27});
	 $('#insurwindow').jqxWindow('close');
	 $('#expenseacnowindow').jqxWindow({ width: '30%', height: '62%',  maxHeight: '54%' ,maxWidth: '50%' , title: 'Expense Account Search' ,position: { x: 300, y: 100 }, keyboardCloseKey: 27});
	 $('#expenseacnowindow').jqxWindow('close');
	 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
     
     $('#insurcomp').dblclick(function(){
 	   $('#insurwindow').jqxWindow('open');
       $('#insurwindow').jqxWindow('focus');
       insurSearchContent('insurCompGridSearch.jsp', $('#insurwindow'));
     });
     
     $('#expenseaccount').dblclick(function(){
    	if(parseFloat(document.getElementById("expenseamount").value)!=0){
    		$('#expenseacnowindow').jqxWindow('open');
       		$('#expenseacnowindow').jqxWindow('focus');
       		expenseAcnoSearchContent('expenseAcnoGridSearch.jsp', $('#expenseacnowindow'));
    	}
     });
});

function insurSearchContent(url) {
	$.get(url).done(function (data) {
		$('#insurwindow').jqxWindow('setContent', data);
    }); 
}
function expenseAcnoSearchContent(url) {
	$.get(url).done(function (data) {
		$('#expenseacnowindow').jqxWindow('setContent', data);
    }); 
}

function getInsurCompany(event){
	var x= event.keyCode;
	if(x==114){
		$('#insurwindow').jqxWindow('open');
	    $('#insurwindow').jqxWindow('focus');
	    insurSearchContent('insurCompGridSearch.jsp', $('#insurwindow'));
    }
 	else{
	}
}

function getExpenseAcno(event){
	var x= event.keyCode;
	if(parseFloat(document.getElementById("expenseamount").value)!=0){
		if(x==114){
		   	   $('#expenseacnowindow').jqxWindow('open');
		       $('#expenseacnowindow').jqxWindow('focus');
		       expenseAcnoSearchContent('expenseAcnoGridSearch.jsp', $('#expenseacnowindow'));
		}
	 	else{
		}		
	}

}
function funreload(event)
{
	var fromdate=$('#fromdate').jqxDateTimeInput('val');
	var todate=$('#todate').jqxDateTimeInput('val');
	$('#insurrefunddiv').load('insurRefundGrid.jsp?fromdate='+fromdate+'&todate='+todate+'&id=1');
}
	function funNotify(){
		var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
		if(docdateval==0){
			$('#periodupto').jqxDateTimeInput('focus');
			return false;
		}
	}
	function setValues(){

		 if($('#msg').val()!=""){
   		  $.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
   		  }
		
		 $('#fromdate').jqxDateTimeInput('setDate',new Date());
		 $('#todate').jqxDateTimeInput('setDate',new Date());
		 $('#griddate').jqxDateTimeInput('setDate',new Date());
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	     $('#refno,#amount,#tempamount,#insurcomp,#hidinsurcomp,#expenseamount,#expenseaccount,#hidexpenseaccount,#tranid').val('');
	}
	function funExportBtn(){
		
	}
	
	function setExpenseAmount(){
		var tempamount=document.getElementById("tempamount").value;
		var amount=document.getElementById("amount").value;
		var diff=parseFloat(tempamount)-parseFloat(amount);
		document.getElementById("expenseamount").value=diff;
	}
	function funInsurRefundSave(){
		if($('#griddate').jqxDateTimeInput('getDate')==null){
			$.messager.alert('warning','Date is Mandatory');
			return false;
		}
		if(document.getElementById("amount").value==""){
			$.messager.alert('warning','Amount is Mandatory');
			return false;
		}
		if(parseFloat(document.getElementById("expenseamount").value)>0){
			if(document.getElementById("expenseaccount").value==""){
				$.messager.alert('warning','Expense Account is Mandatory');
				return false;
			}
		}
		if(document.getElementById("insurcomp").value==""){
			$.messager.alert('warning','Insurance Company is Mandatory');
			return false;
		}
		
		insurRefundSaveAJAX();
	}
	
	
	function insurRefundSaveAJAX(){
		document.getElementById("mode").value="A";
		document.getElementById("frmInsurRefundClaim").submit();
	}
</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmInsurRefundClaim" action="saveInsurRefundClaim">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
	<tr>
		<td width="20%">
    		<fieldset style="background: #ECF8E0;">
				<table width="100%">
					<jsp:include page="../../heading.jsp"></jsp:include>
						<tr>
                        	<td width="34%" align="right"><label class="branch">From Date</label></td>
                            <td width="66%"><div id="fromdate"></div></td>
                        </tr>
		 				<tr>
                        	<td width="34%" align="right"><label class="branch">To Date</label></td>
         					<td width="66%"><div id="todate"></div></td>
                        </tr> 
        				<tr>
	  						<td align="right" colspan="2">&nbsp;</td>
	  					</tr>
						<tr>
							<td align="right"><label class="branch" id="lblrefno">Ref No</label></td>
                            <td><input type="text" name="refno" id="refno"  style="height:18px;"></td>
						</tr>
						<tr>
						  <td align="right"><label class="branch" id="lbldate">Date</label></td>
						  <td><div id="griddate" name="griddate" value='<s:property value="griddate"/>'></div></td>
				  		</tr>
						<tr>
	  						<td align="right"><label class="branch" id="lblamount">Amount</label></td>
	  						<td><input type="text" name="amount" id="amount" value='<s:property value="amount"/>' style="height:18px;" onchange="setExpenseAmount();"></td>
	  					</tr>
                        <tr>
                          <td align="right"><label class="branch" id="lblinsurcomp">Insur Company</label></td>
                          <td><input type="text" name="insurcomp" id="insurcomp" value='<s:property value="insurcomp" />' onkeydown="getInsurCompany(event);" readonly="readonly" style="height:18px;"></td>
                        	<input type="hidden" name="hidinsurcomp" id="hidinsurcomp" value='<s:property value="hidinsurcomp" />' >
                        </tr>
                        <tr>
                          <td align="right"><label class="branch" id="lblexpenseamount" >Expense Amount</label></td>
                          <td><input type="text" name="expenseamount" id="expenseamount" value='<s:property value="expenseamount"/>' style="height:18px;"></td>
                        </tr>
                        <tr>
                          <td align="right"><label class="branch" id="lblexpenseaccount">Expense Account</label></td>
                          <td><input type="text" id="expenseaccount" name="expenseaccount" value='<s:property value="expenseaccount"/>' style="height:18px;" readonly="readonly" onkeydown="getExpenseAcno(event);"></td>
                        	<input type="hidden" name="hidexpenseaccount" id="hidexpenseaccount" value='<s:property value="hidexpenseaccount" />' >
                        </tr>
                        <tr>
                          <td colspan="2">&nbsp;</td>
                          </tr>
                        <tr>
                          <td colspan="2"><center><input type="button" name="btnsave" id="btnsave" class="myButton" value="Save" onclick="funInsurRefundSave();"></center></td>
                          </tr>
                        <tr>
                          <td colspan="2">&nbsp;</td>
                          </tr>
                        <tr>
                          <td colspan="2">&nbsp;</td>
                          </tr>
                       <tr>
                          <td colspan="2">&nbsp;</td>
                          </tr>
                          <tr>
                          <td colspan="2">&nbsp;</td>
                          </tr>
                          <tr>
                          <td colspan="2">&nbsp;</td>
                          </tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="insurrefunddiv"><jsp:include page="insurRefundGrid.jsp"></jsp:include></div></td>
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  <input type="hidden" name="tempamount" id="tempamount" value='<s:property value="tempamount"/>'>
			  <input type="hidden" name="tranid" id="tranid" value='<s:property value="tranid"/>'>
		</tr>
	</table>
</tr>
</table>
</div>
<div id="insurwindow">
   <div ></div>
</div>
<div id="expenseacnowindow">
   <div ></div>
</div>
</div>
</form>
</body>
</html>