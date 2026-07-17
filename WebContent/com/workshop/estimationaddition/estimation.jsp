<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<jsp:include page="../../../includes.jsp"></jsp:include>
<%-- <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" >
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script> --%>
<style>
.hidden-scrollbar {
  /* // overflow: auto; */
  height: 530px;
    overflow-x: hidden;
    
} 
.headClass
{
    background-color: #FFEBC2;
}
.redClass
{
    background-color: #FFEBEB;
}
.violetClass
{
    background-color: #EBD6FF;
}
.yellowClass
{
    background-color: #FFFFD1;
}
.whiteClass
{
   background-color: #FFF;
}
.greenClass
{
   background-color: #CEFFCE;
}
        
</style>
<script type="text/javascript">
$(document).ready(function() {

$("#date").jqxDateTimeInput({  width:'125px',height : '15px', formatString : "dd.MM.yyyy" });
//$("#policedate").jqxDateTimeInput({  width:'125px',height : '15px', formatString : "dd.MM.yyyy" });
//$("#intime").jqxDateTimeInput({  width:'55px',height : '15px', formatString : "HH:mm",showCalendarButton:false,value:new Date() });
$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;margin-left:50%;margin-right:50%;margin-top:15%;top:200;right:600;'><img src='../../../icons/31load.gif'/></div>");    
//$('#intime').jqxDateTimeInput('setDate', new Date());
$('#searchwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Gate In Pass Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#searchwindow').jqxWindow('close');
$('#partssearchwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Product Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#partssearchwindow').jqxWindow('close');
$('#laboursearchwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Product Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#laboursearchwindow').jqxWindow('close');
//setLumSum();
//document.getElementById("chklumsum").disabled=false;
$( "#jobcardvocno" ).dblclick(function() {
	if(document.getElementById("mode").value=="view"){
		return false;
	}
	$('#searchwindow').jqxWindow('open');
	$('#searchwindow').jqxWindow('focus');
	SearchContent('gateInPassSearch.jsp','searchwindow');
});
$('#btnEdit').mousedown(function(){
	var editstatus=$('#editstatus').val();
	if(editstatus==0){
		$.messager.alert('Warning','Job Card Issued!!Cannot Edit');
		return false;
	}
});
/* $( "#sparepartstotal,#labourtotal,#discount" ).change(function() {
	  var parts=parseFloat($('#sparepartstotal').val());
	  var labour=parseFloat($('#labourtotal').val());
	  var discount=parseFloat($('#discount').val());
	  var total=(parts+labour)-discount;
	  $('#esttotal').val(total);
}); */
$( "#servicestotal,#servicesdiscount" ).change(function() {
	  var services=parseFloat($('#servicestotal').val());
	  var discount=parseFloat($('#servicesdiscount').val());
	  var total=services-discount;
	  $('#netservices').val(total);
});
$('#btnCalculate').click(function(){
	$('#sparePartsAmountGrid').jqxGrid('clear');
	var servicetotal=$('#netservices').val();
	var genuinetotal=$('#genuinetotal').val();
	var markettotal=$('#markettotal').val();
	var usedtotal=$('#usedtotal').val();
	var approvedtotal=$('#approvedtotal').val();
	var date=$('#date').jqxDateTimeInput('val');
	var docno=$('#docno').val();
	var gatedocno=$('#gatedocno').val();
	var lumsumamount=$('#lumsumamount').val();
	var chklumsum=0;
	var addition=$('#addition').val();
	if(document.getElementById("chklumsum").checked==true){
		chklumsum=1;
	}
	else{
		chklumsum=0;
	}
	//alert(chklumsum+"//"+lumsumamount);
	insertSparePartsAmount(servicetotal,genuinetotal,markettotal,usedtotal,approvedtotal,date,docno,gatedocno,lumsumamount,chklumsum,addition,$('#mode').val());
});
});

function insertSparePartsAmount(servicetotal,genuinetotal,markettotal,usedtotal,approvedtotal,date,docno,gatedocno,lumsumamount,chklumsum,addition,mode){
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();
			if($('#mode').val()=='A'){
				$('#sparepartsamountdiv').load('sparePartsAmountGrid.jsp?gatedocno='+items+'&id=1&addition='+(parseInt(addition)+1));				
			}
			else{
				$('#sparepartsamountdiv').load('sparePartsAmountGrid.jsp?gatedocno='+items+'&id=1&addition='+(parseInt(addition)));

			}
		}
	}
	x.open("GET", "insertSparePartsAmount.jsp?servicetotal="+servicetotal+"&genuinetotal="+genuinetotal+"&markettotal="+markettotal+"&usedtotal="+usedtotal+"&approvedtotal="+approvedtotal+"&date="+date+"&docno="+docno+"&gatedocno="+gatedocno+"&lumsumamount="+lumsumamount+"&chklumsum="+chklumsum+"&addition="+addition+"&mode="+mode, true);
	x.send();
}
function getGateInPass(event){
	if(document.getElementById("mode").value=="view"){
		return false;
	}
	var x= event.keyCode;
    if(x==114){
    	$('#searchwindow').jqxWindow('open');
    	$('#searchwindow').jqxWindow('focus');
    	SearchContent('gateInPassSearch.jsp');
      }
}

function SearchContent(url,id) {
    $.get(url).done(function (data) {
  $('#'+id).jqxWindow('setContent', data);
}); 
}

function funSearchLoad(){
	changeContent('masterSearch.jsp?id=1', $('#window'));
 }
function funReadOnly() {
	$('#frmWSEstimationAddition input').attr('readonly',true);
}
function funRemoveReadOnly() {
	$('#frmWSEstimationAddition input').attr('readonly',false);
	$('#docno').attr('readonly',true);
	if($('#mode').val()=='A'){
		$('#sparePartsNewGrid,#labourcostGrid,#sparePartsAmountGrid,#complaintGrid').jqxGrid('clear');
		$('#sparePartsNewGrid,#labourcostGrid,#sparePartsAmountGrid').jqxGrid({disabled:false});
		$("#sparePartsNewGrid,#labourcostGrid").jqxGrid("addrow", null, {});
		/* if($('#discount').val()==""){
			$('#discount').val(0);
		}
		if($('#sparepartstotal').val()==""){
			$('#sparepartstotal').val(0);
		}
		if($('#labourtotal').val()==""){
			$('#labourtotal').val(0);
		}
		$('#esttotal').val(0); */
		$('#servicestotal,#servicesdiscount,#netservices').val(0);
	}
	else if($('#mode').val()=='E' || $('#mode').val()=='D'){
		$('#sparePartsNewGrid,#labourcostGrid').jqxGrid({disabled:false});
		$("#sparePartsNewGrid,#labourcostGrid").jqxGrid("addrow", null, {});
	}
}
function setValues() {
	// document.getElementById("formdetail").value="Gate In-Pass";
    //  document.getElementById("formdetailcode").value="GIP";
	document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	funSetlabel();
	 if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
	 }
	var a=$('#gatedocno').val();
	var b=$('#docno').val();
	var addition=$('#addition').val();
	if($('#docno').val()!=''){
		var b=$('#docno').val();
		$('#complaintdiv').load('../../../com/workshop/estimationaddition/complaintGrid.jsp?docno='+$('#gatedocno').val()+'&branch='+$('#brchName').val()+'&id=1');	
		CheckEditStatus($('#docno').val());
	}
	if($('#docno').val()!=''){
		$('#sparepartsdiv').load('../../../com/workshop/estimationaddition/sparePartsNewGrid.jsp?docno='+$('#docno').val()+'&id=1&addition='+addition);
	}
	if($('#docno').val()!=''){
		$('#labourcostdiv').load('../../../com/workshop/estimationaddition/labourcostGrid.jsp?docno='+$('#docno').val()+'&id=1&addition='+addition);		
	}
	if($('#gatedocno').val()!=''){
		$('#sparepartsamountdiv').load('../../../com/workshop/estimationaddition/sparePartsAmountGrid.jsp?gatedocno='+$('#gatedocno').val()+'&id=1&addition='+addition);		
	}
	//alert(document.getElementById("hidchklumsum").value);
	if(document.getElementById("hidchklumsum").value=='1'){
		document.getElementById("chklumsum").checked=true;
	}
	else{
		document.getElementById("chklumsum").checked=false;
	}
	setLumSum();
}

 function funFocus()
    {
    	document.getElementById("gatevocno").focus(); 
    }
    
     
 function funNotify(){
	if($('#gatedocno').val()==""){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Gate In Pass is Mandatory";
		return 0;
	} 
	var amountrows=$("#sparePartsAmountGrid").jqxGrid('getrows');
	if(amountrows.length==0){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Please Calculate Amount";
		return 0;
	}
	var labourrows = $("#labourcostGrid").jqxGrid('getrows');
	var labourgridlength=0;
	for(var i=0;i<labourrows.length;i++){
		if(labourrows[i].jobid!="" && labourrows[i].jobid!=null && labourrows[i].jobid!="undefined" && typeof(labourrows[i].jobid)!="undefined"){
			labourgridlength++;
			newTextBox = $(document.createElement("input"))
			.attr("type", "dil")
			.attr("id", "labourcostarray"+i)
			.attr("name", "labourcostarray"+i)
			.attr("hidden",true);
				
			newTextBox.val(labourrows[i].jobid+" :: "+labourrows[i].hrs+" :: "+labourrows[i].rate+" :: "+labourrows[i].markuppercent+" :: "+labourrows[i].total+" :: "+labourrows[i].remarks);
			
			newTextBox.appendTo('form');
			
		}
	}
	$('#labourcostgridlength').val(labourgridlength);
	
	var partrows = $("#sparePartsNewGrid").jqxGrid('getrows');
	var partgridlength=0;
	for(var i=0;i<partrows.length;i++){
		if(partrows[i].description!="" && partrows[i].description!=null && partrows[i].description!="undefined" && typeof(partrows[i].description)!="undefined"){
			partgridlength++;
			newTextBox = $(document.createElement("input"))
			.attr("type", "dil")
			.attr("id", "sparepartsarray"+i)
			.attr("name", "sparepartsarray"+i)
			.attr("hidden",true);
			newTextBox.val(partrows[i].description+" :: "+partrows[i].qty+" :: "+partrows[i].genuinerate+" :: "+partrows[i].marketrate+" :: "+partrows[i].usedrate+" :: "+partrows[i].genuinetotal+" :: "+partrows[i].markettotal+" :: "+partrows[i].usedtotal+" :: "+partrows[i].approval+" :: "+partrows[i].approvedvalue);
			newTextBox.appendTo('form');
			
		}
	}
	$('#sparePartsNewGridlength').val(partgridlength);
	if(document.getElementById("chklumsum").checked==true){
 		document.getElementById("hidchklumsum").value="1";
	}
	else{
		document.getElementById("hidchklumsum").value="0";
	}
	return 1;
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
 
 function CheckEditStatus(docno){
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			$('#editstatus').val(items.trim());
			} else {
			}
		}
	x.open("GET", "checkEditStatus.jsp?docno="+docno, true);
	x.send();
 }
 
 function setLumSum(){
	 
 	if(document.getElementById("chklumsum").checked==true){
 		document.getElementById("lumsumamount").disabled=false;
 		document.getElementById("hidchklumsum").value="1";
	}
	else{
		document.getElementById("lumsumamount").disabled=true;
		document.getElementById("hidchklumsum").value="0";
	}
 }
 function funPrintBtn(){
	 if($('#docno').val()!='' && $('#docno').val()!='0'){
		var url=document.URL;
		var reurl=url.split("com");
		/* var path= "com/dashboard/workshop/quotationapproval/printQuotationAproval.action?estDocno="+estdocno; */
		var path= "com/dashboard/workshop/quotationapproval/printQuotationAproval.action?estDocno="+$('#docno').val();
		var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=700,Height=600,location=no,scrollbars=yes,toolbar=yes");		
		win.focus();		
	 }
 }
</script>
<style>
	
</style>
</head>	
<body onLoad="setValues();">
	<div id="mainBG" class="homeContent" data-type="background"> 
		<form id="frmWSEstimationAddition" action="saveEstimationAddition" method="post" autocomplete="off" class="form-inline">
			<jsp:include page="../../../header.jsp" />
            <br>
            <div class='hidden-scrollbar'>
   			<table width="100%" border="0">
   			  <tr>
   			    <td width="9%" align="right">Date</td>
   			    <td width="31%"><div id="date" name="date" value='<s:property value="date"/>'></div></td>
   			    <td width="20%">&nbsp;</td>
   			    <td width="20%" align="right">Doc No</td>
   			    <td width="20%"><input type="text" name="vocno" id="vocno" readonly="readonly" tabindex="-1" value='<s:property value="vocno"/>'></td>
                <input type="hidden" name="docno" id="docno" readonly tabindex="-1" value='<s:property value="docno"/>'>
		      </tr>
		  </table>
          <fieldset class="headClass"><legend>Job Card Details</legend>
          <table width="100%" border="0">
  <tr>
    <td width="12%" align="right">Job Card Doc No</td>
    <td width="12%"><input type="text" name="jobcardvocno" id="jobcardvocno" readonly placeholder="Press F3 to Search" value='<s:property value="jobcardvocno"/>' onkeydown="getGateInPass(event);"></td>
    <td width="10%"  align="right">User Details</td>
    <td width="66%"><input type="text" name="gateuserdetails" id="gateuserdetails" readonly value='<s:property value="gateuserdetails"/>' style="width:99%;"></td>
  </tr>
  <input type="hidden" name="gatevocno" id="gatevocno" readonly placeholder="Press F3 to Search" value='<s:property value="gatevocno"/>' onkeydown="getGateInPass(event);">
  <input type="hidden" name="gatedocno" id="gatedocno" readonly tabindex="-1" value='<s:property value="gatedocno"/>'>
  <input type="hidden" name="jobcarddocno" id="jobcarddocno" readonly tabindex="-1" value='<s:property value="jobcarddocno"/>'>
  <input type="hidden" name="estdocno" id="estdocno" readonly tabindex="-1" value='<s:property value="estdocno"/>'>
  <input type="hidden" name="addition" id="addition" readonly tabindex="-1" value='<s:property value="addition"/>'>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td  align="right">Vehicle Details</td>
    <td><input type="text" name="gatevehicledetails" id="gatevehicledetails" readonly value='<s:property value="gatevehicledetails"/>' style="width:99%;"></td>
  </tr>
</table>
</fieldset>
<table width="100%" border="0">
  <tr>
    <td colspan="8"><fieldset class="greenClass"><legend>Complaints</legend>
    	<div id="complaintdiv"><jsp:include page="complaintGrid.jsp"></jsp:include></div>
        </fieldset>
    </td>
    </tr>
    <tr>
    <td colspan="8"><fieldset class="yellowClass"><legend>Services</legend>
    	<div id="labourcostdiv"><jsp:include page="labourcostGrid.jsp"></jsp:include></div>
        </fieldset></td>
    </tr>
    <tr>
    	<td align="right">Total</td>
    	<td><input type="text" name="servicestotal" id="servicestotal"  value='<s:property value="servicestotal"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
    	<td align="right">Discount</td>
    	<td><input type="text" name="servicesdiscount" id="servicesdiscount"  value='<s:property value="servicesdiscount"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
    	<td align="right">Net Services Total</td>
    	<td><input type="text" name="netservices" id="netservices"  value='<s:property value="netservices"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
    </tr>
  <tr>
    <td colspan="8"><fieldset class="redClass"><legend>Spare Parts</legend>
    	<div id="sparepartsdiv"><jsp:include page="sparePartsNewGrid.jsp"></jsp:include></div>
        </fieldset></td>
    </tr>
  <tr><td colspan="2" align="center"><input type="checkbox" id="chklumsum" name="chklumsum" onChange="setLumSum();">&nbsp;&nbsp Lumpsum &nbsp;&nbsp;<input type="text" id="lumsumamount" name="lumsumamount" value='<s:property value="lumsumamount"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
  <input type="hidden" name="hidchklumsum" id="hidchklumsum" value='<s:property value="hidchklumsum"/>'>
    <td colspan="2" align="center"><button type="button" class="myButton" id="btnCalculate">Calculate Amount</button></td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="8">
    	<fieldset class=""><legend>Spare Parts Amount</legend>
    		<div id="sparepartsamountdiv"><jsp:include page="sparePartsAmountGrid.jsp"></jsp:include></div>
        </fieldset>
    </td>
 </tr>
<%--   <tr>
    <td  align="right">Spare Parts Total</td>
    <td><input type="text" name="sparepartstotal" id="sparepartstotal"  value='<s:property value="sparepartstotal"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
    <td align="right">Labour Total</td>
    <td><input type="text" name="labourtotal" id="labourtotal"  value='<s:property value="labourtotal"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
    <td  align="right">Discount </td>
    <td><input type="text" name="discount" id="discount"  value='<s:property value="discount"/>' style="text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
    <td  align="right">Estimation Total</td>
    <td><input type="text" name="esttotal" id="esttotal"  value='<s:property value="esttotal"/>' style="text-align:right;" readonly onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"></td>
  </tr> --%>
</table>

    	<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
		<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
      	<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
      	<input type="hidden" name="sparePartsNewGridlength" id="sparePartsNewGridlength" value='<s:property value="sparePartsNewGridlength"/>'/>
      	<input type="hidden" name="labourcostgridlength" id="labourcostgridlength" value='<s:property value="labourcostgridlength"/>'/>
      	<input type="hidden" name="genuinetotal" id="genuinetotal" value='<s:property value="genuinetotal"/>'/>
      	<input type="hidden" name="markettotal" id="markettotal" value='<s:property value="markettotal"/>'/>
      	<input type="hidden" name="usedtotal" id="usedtotal" value='<s:property value="usedtotal"/>'/>
      	<input type="hidden" name="approvedtotal" id="approvedtotal" value='<s:property value="approvedtotal"/>'/>
      	
            </div>
      </form>
    </div>
    <div id="searchwindow">
   		<div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
	</div>
	<div id="partssearchwindow">
   		<div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
	</div>
	<div id="laboursearchwindow">
   		<div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
	</div>
	<div id="clientwindow">
   		<div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
	</div>
</body>
</html>