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

$(document).ready(function () {
	$('#btnsave').hide();
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$("#currentdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$("#postingdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
    var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
    var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
    $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
    $('#purchasewindow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Purchase Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#purchasewindow').jqxWindow('close'); 
    $('#balanceloanacwindow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Purchase Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#balanceloanacwindow').jqxWindow('close'); 
    $('#vehiclewindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Vehicle Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#vehiclewindow').jqxWindow('close');
	
	$('#postingdate').on('change', function (event) 
			{  
	//checkfuturedate();
	if($('#postingdate').jqxDateTimeInput('getDate')!=null){
		var date=new Date($('#postingdate').jqxDateTimeInput('getDate'));
		var status=funDateInPeriod(date);//Checking Future date.Written on 11-07-2016	
		if(status){
			document.getElementById("errormsg").innerText="";
			return true;
		}
		else{
			$('#postingdate').jqxDateTimeInput('focus');
			return false;
		}
	}
	});
	
    $('#purchasedocno,#vendor,#dealno').dblclick(function(){
    	if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=="a"){
			$.messager.alert('warning','Please select a branch');
			return false;
		}
    	$('#mortgageGrid').jqxGrid('clear');
		$('#deleteGrid').jqxGrid('clear');
    	$('#purchasewindow').jqxWindow('open');
    	var branch=$('#cmbbranch').val();
		purchaseSearchContent('purchaseSearchGrid.jsp?branch='+branch);
    });
    
    $('#balanceloanacno').dblclick(function(){
    	$('#balanceloanacwindow').jqxWindow('open');
	  	balanceLoanAcnoSearchContent('balanceLoanAcnoSearchGrid.jsp');
    });
    
    $('#purchasedocno,#vendor,#dealno,#total,#balanceloanacno,#balanceloanamt').attr('disabled',true);
    $('#fromdate').jqxDateTimeInput({disabled:true});
    $('#todate').jqxDateTimeInput({disabled:true});
});

function purchaseSearchContent(url) {
	$.get(url).done(function (data) {
    	$('#purchasewindow').jqxWindow('setContent', data);
	}); 
}
function balanceLoanAcnoSearchContent(url) {
	$.get(url).done(function (data) {
    	$('#balanceloanacwindow').jqxWindow('setContent', data);
	}); 
}
function getPurchaseDoc(event){
	var x= event.keyCode;
	if(x==114){
		if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=="a"){
			$.messager.alert('warning','Please select a branch');
			return false;
		}
		$('#purchasewindow').jqxWindow('open');
		var branch=$('#cmbbranch').val();
		purchaseSearchContent('purchaseSearchGrid.jsp?branch='+branch);
	}
	else{
	}
}
function getBalanceLoanAcno(event){
	var x= event.keyCode;
	if(x==114){
		$('#balanceloanacwindow').jqxWindow('open');
	  	balanceLoanAcnoSearchContent('balanceLoanAcnoSearchGrid.jsp');
	}
	else{
	}
}
	function funreload(event){
		
		if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=="a"){
			$.messager.alert('warning','Please select a branch');
			return false;
		}
		if(document.getElementById("purchasedocno").value==""){
			$.messager.alert('warning','Please select a document');
			return false;
		}
		var fromdate=$('#fromdate').jqxDateTimeInput('val');
		var todate=$('#todate').jqxDateTimeInput('val');
		var purchasedocno=$('#purchasedocno').val();
		
		$('#mortgageGrid').jqxGrid('clear');
		$('#deleteGrid').jqxGrid('clear');
		$("#overlay, #PleaseWait").show();
		$('#mortgagediv').load('mortgageGrid.jsp?fromdate='+fromdate+'&todate='+todate+'&id=1&purchasedocno='+purchasedocno);
		$('#deletediv').load('deleteGrid.jsp?id=1&purchasedocno='+purchasedocno);
	}
	
	
	function funSave(){
		if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=="a"){
			$.messager.alert('warning','Please select a branch');
			return false;
		}
		if(document.getElementById("purchasedocno").value==""){
			$.messager.alert('warning','Please select a document');
			return false;
		}
		var principal=$('#mortgageGrid').jqxGrid('getcolumnaggregateddata', 'principalamt', ['sum'], true);
        var principalsum=principal.sum;
        var totalloanamount=$('#total').val();
        principalsum=principalsum.replace(/,/g,'');
        if(principalsum!=totalloanamount){
        	if($('#hidbalanceloanacno').val()==''){
            	$.messager.alert('warning','Please Select Balance Loan A/c');
            	return false;        		
        	}
			if($('#postingdate').jqxDateTimeInput('getDate')==null){
				$.messager.alert('warning','Please Select Posting Date');
            	return false;        		
			}

        }
        else{
        	
                    	
        }
        var balanceloanacno=$('#hidbalanceloanacno').val();
        funSaveAJAX(principalsum,totalloanamount,balanceloanacno);
	}
	function funSaveAJAX(principalsum,totalloanamount,balanceloanacno){
		var branch=$('#cmbbranch').val();
		var vehicleremove=$('#hidvehicle').val();
		var rows=$('#mortgageGrid').jqxGrid('getrows');
		var purchasearray=new Array();
		var deleterows=$('#deleteGrid').jqxGrid('getrows');
		var deletearray=new Array();
		
		for(var i=0;i<rows.length;i++){
			var purchasedocno=$('#mortgageGrid').jqxGrid('getcellvalue',i,'purchasedocno');
			var ucrdocno=$('#mortgageGrid').jqxGrid('getcellvalue',i,'ucrdocno');
			var detaildocno=$('#mortgageGrid').jqxGrid('getcellvalue',i,'detaildocno');
			var date=$('#mortgageGrid').jqxGrid('getcellvalue',i,'date');
			var chequeno=$('#mortgageGrid').jqxGrid('getcellvalue',i,'chequeno');
			var principalamt=$('#mortgageGrid').jqxGrid('getcellvalue',i,'principalamt');
			var interestamt=$('#mortgageGrid').jqxGrid('getcellvalue',i,'interestamt');
			var amount=$('#mortgageGrid').jqxGrid('getcellvalue',i,'amount');
			var bpvno=$('#mortgageGrid').jqxGrid('getcellvalue',i,'bpvno');
			var defaultrow=$('#mortgageGrid').jqxGrid('getcellvalue',i,'defaultrow');
			var editstatus=$('#mortgageGrid').jqxGrid('getcellvalue',i,'editstatus');
			purchasearray.push(purchasedocno+"::"+ucrdocno+"::"+detaildocno+"::"+date+"::"+chequeno+"::"+principalamt+"::"+interestamt+"::"+amount+"::"+bpvno+"::"+defaultrow+"::"+editstatus);
		}
		for(var i=0;i<deleterows.length;i++){
			var purchasedocno=$('#deleteGrid').jqxGrid('getcellvalue',i,'purchasedocno');
			var ucrdocno=$('#deleteGrid').jqxGrid('getcellvalue',i,'ucrdocno');
			var detaildocno=$('#deleteGrid').jqxGrid('getcellvalue',i,'detaildocno');
			var date=$('#deleteGrid').jqxGrid('getcellvalue',i,'date');
			var chequeno=$('#deleteGrid').jqxGrid('getcellvalue',i,'chequeno');
			var principalamt=$('#deleteGrid').jqxGrid('getcellvalue',i,'principalamt');
			var interestamt=$('#deleteGrid').jqxGrid('getcellvalue',i,'interestamt');
			var amount=$('#deleteGrid').jqxGrid('getcellvalue',i,'amount');
			var bpvno=$('#deleteGrid').jqxGrid('getcellvalue',i,'bpvno');
			var defaultdeleterow=$('#deleteGrid').jqxGrid('getcellvalue',i,'defaultdeleterow');
			deletearray.push(purchasedocno+"::"+ucrdocno+"::"+detaildocno+"::"+date+"::"+chequeno+"::"+principalamt+"::"+interestamt+"::"+amount+"::"+bpvno+"::"+defaultdeleterow);
		}
		var x=new XMLHttpRequest();
 		x.onreadystatechange=function(){
 		if (x.readyState==4 && x.status==200)
 			{
			var items = x.responseText;
			if(items.trim()=="0"){
				$.messager.alert('message','Successfully Restructured');
			}
			else{
				$.messager.alert('message','Not Restructured');
			}
			funreload("");
			
 			}
 		}
 		
		x.open("GET","saveAJAX.jsp?purchasearray="+purchasearray+"&deletearray="+deletearray+"&deleteucrdocno="+$("#deleteucrdocno").val()+"&purchasedocno="+$("#hidpurchasedocno").val()+"&currentdate="+$("#currentdate").jqxDateTimeInput("val")+"&vendor="+$("#vendor").val()+"&principalsum="+principalsum+"&totalloanamount="+totalloanamount+"&balanceloanacno="+balanceloanacno+"&branch="+branch+"&vehicleremove="+vehicleremove+"&postingdate="+$('#postingdate').jqxDateTimeInput('val'),true);
		x.send();
         
	}
	
	function funEdit(){
		$('#purchasedocno,#vendor,#dealno,#total,#balanceloanacno,#balanceloanamt,#vehicleremove').attr('disabled',false);
	    $('#fromdate').jqxDateTimeInput({disabled:false});
	    $('#todate').jqxDateTimeInput({disabled:false});
	    $('#btnedit').hide();
	    $('#btnsave').show();
	    $('#tempmode').val('E');
	}
	
	function funAddFleet(){
		if($('#tempmode').val()!='E'){
			return false;
		}
		else{
			if(document.getElementById("purchasedocno").value=="" && document.getElementById("dealno").value==""){
				$.messager.alert('warning','Please select a document');
				return false;
			}
			else{
				getVehicle();
			}
		}
	}
	
	function getVehicle(){
		 $('#vehiclewindow').jqxWindow('open');
			$('#vehiclewindow').jqxWindow('focus');
			 vehicleSearchContent('vehicleSearch.jsp?id=1&purchasedocno='+$('#purchasedocno').val()+'&dealno='+$('#dealno').val(), $('#vehiclewindow'));

	}
	
	function vehicleSearchContent(url) {
	    //alert(url);
	      $.get(url).done(function (data) {
	//alert(data);
	    $('#vehiclewindow').jqxWindow('setContent', data);

	}); 
	}
function funClearFleet(){
		$('#vehicleremove,#vehicle,#hidvehicle').val('');
	}
</script>

</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" rowspan="2" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<tr><td colspan="2"><jsp:include page="../../heading.jsp"></jsp:include></td></tr>
    <tr><td width="35%" align="right"><label class="branch">From Date</label></td>
	<td width="65%" align="left"><div id="fromdate" name="fromdate"></div></td></tr> 
	<tr>
	  <td align="right"><label class="branch">To Date</label></td>
	  <td><div id="todate" name="todate"></div></td>
	</tr>
	<tr><td align="right"><label class="branch">Purchase Docno</label></td>
	  <td><input type="text" name="purchasedocno" id="purchasedocno" placeholder="Press F3 to Search" readonly onKeyDown="getPurchaseDoc(event);" style="height:18px;"></td>
	  <input type="hidden" name="hidpurchasedocno" id="hidpurchasedocno">
	</tr>
	<tr>
	  <td align="right"><label class="branch" >Vendor</label></td>
	  <td><input type="text" name="vendor" id="vendor" placeholder="Press F3 to Search" readonly onKeyDown="getPurchaseDoc(event);" style="height:18px;"></td>
	</tr>
	<tr><td align="right"><label class="branch">Deal No</label></td>
	  <td><input type="text" id="dealno" name="dealno" placeholder="Press F3 to Search" readonly onKeyDown="getPurchaseDoc(event);" style="height:18px;"></td>
	</tr>
		<tr><td align="right"><label class="branch">Total Loan Amt</label></td>
	  <td><input type="text" id="total" name="total" style="height:18px;"></td>
	</tr>
	 <tr><td align="right"><label class="branch">Balance Loan A/c</label></td>
	  <td><input type="text" id="balanceloanacno" name="balanceloanacno" style="height:18px;" placeholder="Press F3 to Search" readonly onkeydown="getBalanceLoanAcno(event);"></td>
	  <input type="hidden" id="hidbalanceloanacno" name="hidbalanceloanacno" style="height:18px;" >
	</tr> 
	<tr>
	  <td align="right"><label class="branch">Balance Amt</label></td>
	  <td><input type="text" id="balanceloanamt" name="balanceloanamt" style="height:18px;" readonly ></td>
	</tr>
    <tr>
      <td align="right"><label class="branch">Vehicle to Remove</label></td>
      <td>
      <textarea name="vehicleremove" id="vehicleremove" readonly style="margin-bottom:10px;resize:none;" rows="5"></textarea></td></tr>
      <tr><td colspan="2" align="center">
      <button type="button" class="myButtons" id="btnaddfleet" onclick="funAddFleet();">Search Fleet</button>&nbsp;
      <button type="button" class="myButtons" id="btnremovefleet" onclick="funClearFleet();">Clear Fleet</button>
      </td>
    </tr>
    <input type="hidden" name="hidvehicleremove" id="hidvehicleremove">
	<tr><td align="right"><label class="branch">Posting Date</label></td>
	  <td align="left"><div id="postingdate" name="postingdate" value='<s:property value="postingdate"/>'></div></td>
	</tr>
<!--     <tr><td colspan="2">&nbsp;</td></tr>  -->
    
	
	<tr><td colspan="2" align="center"><button type="button" id="btnedit" name="btnedit" class="myButton" onClick="funEdit();">Edit</button>
	<button type="button" id="btnsave" name="btnsave" class="myButton" onClick="funSave();">Save</button></td></tr> 
	
	<tr><td colspan="2">&nbsp;</td></tr>
<tr><td colspan="2">&nbsp;</td></tr>
<tr><td colspan="2">&nbsp;</td></tr>
	
	</table>
	</fieldset>
</td>
<td width="80%" height="255">
	<table width="100%">
		<tr>
			 <td><div id="mortgagediv"><jsp:include page="mortgageGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
<tr>
  <td><div id="deletediv"><jsp:include page="deleteGrid.jsp"></jsp:include></div></td>
</tr>
</table>
</div>

<div id="purchasewindow">
   <div ></div>
</div>
<div id="balanceloanacwindow">
   <div ></div>
</div>
<div id="vehiclewindow">
   <div ></div>
</div>
<div id="currentdate" name="currentdate" hidden="true"></div>
<input type="hidden" name="tempmode" id="tempmode">
<input type="hidden" name="hidvehicle" id="hidvehicle">
<input type="hidden" name="vehicle" id="vehicle">
</div> 
</body>
</html>