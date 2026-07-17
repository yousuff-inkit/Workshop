<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<style>
form label.error {
color:red;
  font-weight:bold;

}

.hidden-scrollbar {
    overflow: auto;
    height: 500px;
}

</style>

 <jsp:include page="../../../includes.jsp"></jsp:include>
 <%
 String detailmode=request.getParameter("detailmode")==null?"":request.getParameter("detailmode");
 String tempdocno=request.getParameter("tempdocno")==null?"":request.getParameter("tempdocno");
 %>
<script type="text/javascript">
$(document).ready(function() {
	
$("#date").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });
$('#locationwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '55%' ,maxWidth: '30%' , title: 'Location Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#locationwindow').jqxWindow('close');
$('#srvctarifwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '55%' ,maxWidth: '30%' , title: 'Other Service Tarif Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#srvctarifwindow').jqxWindow('close');
$('#airportwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '55%' ,maxWidth: '30%' , title: 'Airport Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#airportwindow').jqxWindow('close');
$('#brandwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '55%' ,maxWidth: '30%' , title: 'Brand Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#brandwindow').jqxWindow('close');
$('#modelwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '55%' ,maxWidth: '30%' , title: 'Model Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#modelwindow').jqxWindow('close');
$('#guestwindow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '55%' ,maxWidth: '40%' , title: 'Guest Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#guestwindow').jqxWindow('close');
$('#tarifwindow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '55%' ,maxWidth: '40%' , title: 'Tarif Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#tarifwindow').jqxWindow('close');
$('#clientwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '55%' ,maxWidth: '60%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#clientwindow').jqxWindow('close');
$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;margin-left:50%;margin-right:50%;margin-top:15%;top:200;right:600;'><img src='../../../icons/31load.gif'/></div>");    
setNewGuest();
$('.bookingbuttons').hide();
$('.srvcbuttons').hide();
$( "#client" ).dblclick(function() {
	if(document.getElementById("mode").value=="view"){
		return false;
	}
	$('#clientwindow').jqxWindow('open');
	$('#clientwindow').jqxWindow('focus');
	clientSearchContent('masterClientSearch.jsp', $('#clientwindow'));
});

$( "#guest" ).dblclick(function() {
	if(document.getElementById("mode").value=="view"){
		return false;
	}
	if(document.getElementById("chknewguest").checked==false){
		
	
	$('#guestwindow').jqxWindow('open');
	$('#guestwindow').jqxWindow('focus');
	guestSearchContent('guestSearchGrid.jsp', $('#guestwindow'));
	}
});
});

function getValues(value){
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			items = x.responseText;
			items = items.split('::');
			document.getElementById("docno").value=items[1];
            document.getElementById("client").value=items[5];
            document.getElementById("hidclient").value=items[6];
            var details="Mobile: "+items[7]+" License: "+items[8];
            document.getElementById("clientdetails").value=details;
            document.getElementById("hidguest").value=items[3];
            document.getElementById("guest").value=items[9];
            document.getElementById("guestcontactno").value=items[10];
            $('#date').jqxDateTimeInput('val',items[2]);
            document.getElementById("hidchknewguest").value=items[4];
            document.getElementById("description").value=items[0];
           // setValues();
		} else {
		}
	}
	x.open("GET", "getBookingData.jsp?docno="+value, true);
	x.send();
}
function setNewGuest(){
	if(document.getElementById("mode").value=="view"){
		return false;
	}
	if(document.getElementById("chknewguest").checked==true){
		document.getElementById("guest").readOnly=false;
		$("#guest").attr("placeholder", "Please type in");
		document.getElementById("guestcontactno").readOnly=false;
		document.getElementById("hidchknewguest").value="1";
	}
	else{
		document.getElementById("guest").readOnly=true;
		$("#guest").attr("placeholder", "Press F3 to search");
		document.getElementById("guestcontactno").readOnly=true;
		document.getElementById("hidchknewguest").value="0";
	}
}
function getClient(event){
	if(document.getElementById("mode").value=="view"){
		return false;
	}
	var x= event.keyCode;
    if(x==114){
    	$('#clientwindow').jqxWindow('open');
    	$('#clientwindow').jqxWindow('focus');
    	clientSearchContent('masterClientSearch.jsp', $('#clientwindow')); 
      }
}
function getGuest(event){
	if(document.getElementById("mode").value=="view"){
		return false;
	}
	if(document.getElementById("chknewguest").checked==false){
	var x= event.keyCode;
    if(x==114){
	$('#guestwindow').jqxWindow('open');
	$('#guestwindow').jqxWindow('focus');
	guestSearchContent('guestSearchGrid.jsp', $('#guestwindow'));
      }
	}
}
$(function(){
    $('#frmLimoBooking').validate({
    	rules: {
            client:"required"
        }, 
    	messages:{
    		client:" *"
    	}
    });
 }); 
 
 function locationSearchContent(url) {
      $.get(url).done(function (data) {
    $('#locationwindow').jqxWindow('setContent', data);
}); 
}
 function srvctarifSearchContent(url) {
     $.get(url).done(function (data) {
   $('#srvctarifwindow').jqxWindow('setContent', data);
}); 
}
 function airportSearchContent(url) {
     $.get(url).done(function (data) {
   $('#airportwindow').jqxWindow('setContent', data);
}); 
}
 function brandSearchContent(url) {
     $.get(url).done(function (data) {
   $('#brandwindow').jqxWindow('setContent', data);
}); 
}
 function modelSearchContent(url) {
     $.get(url).done(function (data) {
   $('#modelwindow').jqxWindow('setContent', data);
}); 
}
 function clientSearchContent(url) {
     $.get(url).done(function (data) {
   $('#clientwindow').jqxWindow('setContent', data);
}); 
}
 function guestSearchContent(url) {
     $.get(url).done(function (data) {
   $('#guestwindow').jqxWindow('setContent', data);
}); 
}
 function tarifSearchContent(url) {
     $.get(url).done(function (data) {
   $('#tarifwindow').jqxWindow('setContent', data);
}); 
}

function funSearchLoad(){
	changeContent('mainSearch.jsp', $('#window'));
 }
function funReadOnly() {
	 $('#frmLimoBooking input').attr('readonly', true);
	 $('#frmLimoBooking select').attr('disabled', true);
	 $('#date').jqxDateTimeInput({ disabled: true}); 
	 var detailmode='<%=detailmode%>';
	 var tempdocno='<%=tempdocno%>';
	 if(detailmode=="1"){
		 window.parent.formName.value="Limousine Booking";
  		  window.parent.formCode.value="LBK"
	 	getValues(tempdocno);
	 }
}
function funRemoveReadOnly() {
	$('#frmLimoBooking input').attr('readonly', false);
	$('#docno').attr('readonly', true);
	$('#date').jqxDateTimeInput({ disabled: false}); 
	$('#frmLimoBooking select').attr('disabled', false);
	$('#client').attr('readonly', true);
	$('#guest').attr('readonly', true);
	$('#guestcontactno').attr('readonly', true);
	$('#clientdetails').attr('readonly', true);
	setNewGuest();
	if(document.getElementById("mode").value=="A"){
		$("#transferGrid").jqxGrid({ disabled: false});
		$("#hoursGrid").jqxGrid({ disabled: false});
		$("#billingGrid").jqxGrid({ disabled: false});
		$("#transferGrid").jqxGrid('clear');
		$("#hoursGrid").jqxGrid('clear');
		$("#billingGrid").jqxGrid('clear');
		$("#otherSrvcGrid").jqxGrid('clear');
		$("#transferGrid").jqxGrid("addrow", null, {});
		$("#hoursGrid").jqxGrid("addrow", null, {});
		//$("#otherSrvcGrid").jqxGrid("addrow", null, {});
		$("#billingGrid").jqxGrid("addrow", null, {});
		var transferrows=$("#transferGrid").jqxGrid('getrows');
		var hoursrows=$("#hoursGrid").jqxGrid('getrows');
		if(transferrows.length==0){
			$("#transferGrid").jqxGrid('setcellvalue',0,'docname','T1');
			$("#transferGrid").jqxGrid('setcellvalue',0,'btnappend','Append');
		}
		else{
			$("#transferGrid").jqxGrid('setcellvalue',transferrows.length-1,'docname','T'+transferrows.length);
			$("#transferGrid").jqxGrid('setcellvalue',transferrows.length-1,'btnappend','Append');
		}
		if(hoursrows.length==0){
			$("#hoursGrid").jqxGrid('setcellvalue',0,'docname','L1');
			$("#hoursGrid").jqxGrid('setcellvalue',0,'btnappend','Append');
		}
		else{
			$("#hoursGrid").jqxGrid('setcellvalue',transferrows.length-1,'docname','L'+hoursrows.length);
			$("#hoursGrid").jqxGrid('setcellvalue',transferrows.length-1,'btnappend','Append');
		}
		
		//Setting Default value for billing grid
		$('#billingGrid').jqxGrid('setcellvalue',0,'billto','Client');
		$('#billingGrid').jqxGrid('setcellvalue',0,'billmode','On Account');
		$('#billingGrid').jqxGrid('setcellvalue',0,'billper',100);
	}
	
}
function setValues() {
	 document.getElementById("formdetail").value="Limousine Booking";
     document.getElementById("formdetailcode").value="LBK";
	document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	//funSetlabel();
	 if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
	 }
	if(document.getElementById("hidchknewguest").value=="1"){
		document.getElementById("chknewguest").checked=true;
	}
	else{
		document.getElementById("chknewguest").checked=false;
	}
	if(document.getElementById("docno").value!=""){
		$('#btnBookEdit').show();
		$('#btnSrvcEdit').show();
		$('#btnSrvcReload').show();
	}
	if(document.getElementById("docno").value!=""){
		$('#transferdiv').load('transferGrid.jsp?docno='+document.getElementById("docno").value+'&id=1');
		$('#hoursdiv').load('hoursGrid.jsp?docno='+document.getElementById("docno").value+'&id=1');
		$('#othersrvcdiv').load('otherSrvcGrid.jsp?docno='+document.getElementById("docno").value+'&id=1');
		$('#billingdiv').load('billingGrid.jsp?docno='+document.getElementById("docno").value+'&id=1');
	}
	$("#transferGrid").jqxGrid({ disabled: false});
	$("#hoursGrid").jqxGrid({ disabled: false});
	var transferrows=$('#transferGrid').jqxGrid('getrows');
	var hoursrows=$('#hoursGrid').jqxGrid('getrows');
	$("#transferGrid").jqxGrid({ disabled: true});
	$("#hoursGrid").jqxGrid({ disabled: true});
	if(transferrows.length>0 || hoursrows.length>0){
		document.getElementById("savestatus").value="2";
	}
	
	
}

 function funFocus()
    {
    	 document.getElementById("client").focus(); 
    		
    }
    
     
     function funNotify(){
    	/* var dateval=funDateInPeriod($('#date').jqxDateTimeInput('getDate'));
 		if(dateval==0){
 			$('#date').jqxDateTimeInput('focus');
 			return false;
 		} */
    	 var transferrows=$('#transferGrid').jqxGrid('getrows');
 		document.getElementById("transfergridlength").value=transferrows.length;
 		for(var i=0;i<transferrows.length;i++){
 			newTextBox = $(document.createElement("input"))
 		    .attr("type", "dil")
 		    .attr("id", "transfer"+i)
 		    .attr("name", "transfer"+i)
 		    .attr("hidden", "true");
 			var pickuptime=new Date(transferrows[i].pickuptime);
 			var picktime=(pickuptime.getHours()<10?'0'+pickuptime.getHours():pickuptime.getHours())+":"+(pickuptime.getMinutes()<10?'0':'') + pickuptime.getMinutes();
 			var othersrvcstatus="0";
 			if(transferrows[i].chkothersrvc==true){
 				othersrvcstatus="1";
 			}
 			else{
 				othersrvcstatus="0";
 			}
 			newTextBox.val(transferrows[i].docname+"::"+transferrows[i].pickupdate+"::"+picktime+"::"+transferrows[i].pickuplocationid+"::"+transferrows[i].pickupaddress+"::"+transferrows[i].dropofflocationid+"::"+transferrows[i].dropoffaddress+"::"+transferrows[i].brandid+"::"+transferrows[i].modelid+"::"+transferrows[i].nos+"::"+transferrows[i].tarifdocno+"::"+othersrvcstatus+"::"+transferrows[i].gid+"::"+transferrows[i].tarifdetaildocno);
 			newTextBox.appendTo('form');
 		}
 		 var hoursrows=$('#hoursGrid').jqxGrid('getrows');
 		document.getElementById("hoursgridlength").value=hoursrows.length;
 		for(var i=0;i<hoursrows.length;i++){
 			newTextBox = $(document.createElement("input"))
 		    .attr("type", "dil")
 		    .attr("id", "hours"+i)
 		    .attr("name", "hours"+i)
 		    .attr("hidden", "true");
 			
 			var pickuptime=new Date(hoursrows[i].pickuptime);
 			var picktime=(pickuptime.getHours()<10?'0'+pickuptime.getHours():pickuptime.getHours())+":"+(pickuptime.getMinutes()<10?'0':'') + pickuptime.getMinutes();
 			var othersrvcstatus="0";
 			if(transferrows[i].chkothersrvc==true){
 				othersrvcstatus="1";
 			}
 			else{
 				othersrvcstatus="0";
 			}
 			newTextBox.val(hoursrows[i].docname+"::"+hoursrows[i].pickupdate+"::"+picktime+"::"+hoursrows[i].pickuplocationid+"::"+hoursrows[i].pickupaddress+"::"+hoursrows[i].brandid+"::"+hoursrows[i].modelid+"::"+hoursrows[i].nos+"::"+hoursrows[i].tarifdocno+"::"+othersrvcstatus+"::"+hoursrows[i].gid+"::"+hoursrows[i].blockhrs+"::"+hoursrows[i].tarifdetaildocno+"::"+hoursrows[i].days);
 			newTextBox.appendTo('form');
 		} 
 		
 		var billrows=$('#billingGrid').jqxGrid('getrows');
		document.getElementById("billinggridlength").value=billrows.length;
		if(billrows[0].billto=="" || billrows[0].billto=="undefined" || billrows[0].billto==null || typeof(billrows[0].billto)=="undefined" || billrows[0].billmode=="" || billrows[0].billmode=="undefined" || billrows[0].billmode==null || typeof(billrows[0].billmode)=="undefined" || billrows[0].billper=="" || billrows[0].billper=="undefined" || billrows[0].billper==null || typeof(billrows[0].billper)=="undefined"){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Please enter valid data";
			return false;
		}
		else{
			document.getElementById("errormsg").innerText="";
		}
		for(var j=0;j<billrows.length;j++){
			newTextBox = $(document.createElement("input"))
		    .attr("type", "dil")
		    .attr("id", "bill"+j)
		    .attr("name", "bill"+j)
		    .attr("hidden",true); 
			
			newTextBox.val(billrows[j].billto+"::"+billrows[j].billmode+"::"+billrows[j].billper);
			newTextBox.appendTo('form');
		}
        		return 1;
     } 
	function funBookEdit(){
		$('#btnBookEdit').hide();
		$('#btnBookSave').show();
		$('#btnBookCancel').show();
				
		$("#transferGrid").jqxGrid({ disabled: false});
		$("#hoursGrid").jqxGrid({ disabled: false});
		//$("#otherSrvcGrid").jqxGrid({ disabled: false});
		$("#billingGrid").jqxGrid({ disabled: false});
		$("#transferGrid").jqxGrid("addrow", null, {});
		$("#hoursGrid").jqxGrid("addrow", null, {});
		//$("#otherSrvcGrid").jqxGrid("addrow", null, {});
		$("#billingGrid").jqxGrid("addrow", null, {});
		var transferrows=$("#transferGrid").jqxGrid('getrows');
		var hoursrows=$("#hoursGrid").jqxGrid('getrows');
		if(transferrows.length==0){
			$("#transferGrid").jqxGrid('setcellvalue',0,'docname','T1');
			$("#transferGrid").jqxGrid('setcellvalue',0,'btnappend','Append');
		}
		else{
			$("#transferGrid").jqxGrid('setcellvalue',transferrows.length-1,'docname','T'+transferrows.length);
			$("#transferGrid").jqxGrid('setcellvalue',transferrows.length-1,'btnappend','Append');
		}
		if(hoursrows.length==0){
			$("#hoursGrid").jqxGrid('setcellvalue',0,'docname','L1');
			$("#hoursGrid").jqxGrid('setcellvalue',0,'btnappend','Append');
		}
		else{
			$("#hoursGrid").jqxGrid('setcellvalue',hoursrows.length-1,'docname','L'+hoursrows.length);
			$("#hoursGrid").jqxGrid('setcellvalue',hoursrows.length-1,'btnappend','Append');
		}
		
		
	}
	function funBookCancel(){
		$("#transferGrid").jqxGrid({ disabled: true});
		$("#hoursGrid").jqxGrid({ disabled: true});
		//$("#otherSrvcGrid").jqxGrid({ disabled: true});
		$("#billingGrid").jqxGrid({ disabled: true});
		$('#btnBookEdit').show();
		$('#btnBookSave').hide();
		$('#btnBookCancel').hide();
	}
	function funBookSave(){
		var transferrows=$('#transferGrid').jqxGrid('getrows');
		document.getElementById("transfergridlength").value=transferrows.length;
		for(var i=0;i<transferrows.length;i++){
			newTextBox = $(document.createElement("input"))
		    .attr("type", "dil")
		    .attr("id", "transfer"+i)
		    .attr("name", "transfer"+i)
		    .attr("hidden", "true");
			var pickuptime=new Date(transferrows[i].pickuptime);
			var picktime=(pickuptime.getHours()<10?'0'+pickuptime.getHours():pickuptime.getHours())+":"+(pickuptime.getMinutes()<10?'0':'') + pickuptime.getMinutes();
			var othersrvcstatus="0";
			if(transferrows[i].chkothersrvc==true){
				othersrvcstatus="1";
			}
			else{
				othersrvcstatus="0";
			}
			newTextBox.val(transferrows[i].docname+"::"+transferrows[i].pickupdate+"::"+picktime+"::"+transferrows[i].pickuplocationid+"::"+transferrows[i].pickupaddress+"::"+transferrows[i].dropofflocationid+"::"+transferrows[i].dropoffaddress+"::"+transferrows[i].brandid+"::"+transferrows[i].modelid+"::"+transferrows[i].nos+"::"+transferrows[i].tarifdocno+"::"+othersrvcstatus+"::"+transferrows[i].gid+"::"+transferrows[i].tarifdetaildocno);
			newTextBox.appendTo('form');
		}
		 var hoursrows=$('#hoursGrid').jqxGrid('getrows');
		document.getElementById("hoursgridlength").value=hoursrows.length;
		for(var i=0;i<hoursrows.length;i++){
			newTextBox = $(document.createElement("input"))
		    .attr("type", "dil")
		    .attr("id", "hours"+i)
		    .attr("name", "hours"+i)
		    .attr("hidden", "true");
			
			var pickuptime=new Date(hoursrows[i].pickuptime);
			var picktime=(pickuptime.getHours()<10?'0'+pickuptime.getHours():pickuptime.getHours())+":"+(pickuptime.getMinutes()<10?'0':'') + pickuptime.getMinutes();
			var othersrvcstatus="0";
			if(transferrows[i].chkothersrvc==true){
				othersrvcstatus="1";
			}
			else{
				othersrvcstatus="0";
			}
			newTextBox.val(hoursrows[i].docname+"::"+hoursrows[i].pickupdate+"::"+picktime+"::"+hoursrows[i].pickuplocationid+"::"+hoursrows[i].pickupaddress+"::"+hoursrows[i].brandid+"::"+hoursrows[i].modelid+"::"+hoursrows[i].nos+"::"+hoursrows[i].tarifdocno+"::"+othersrvcstatus+"::"+hoursrows[i].gid+"::"+hoursrows[i].blockhrs+"::"+hoursrows[i].tarifdetaildocno+"::"+hoursrows[i].days);
			newTextBox.appendTo('form');
		} 
		$.messager.confirm('Confirm', 'Do you want to save?', function(r){
    		if (r){
    			$("#overlay, #PleaseWait").show();
    			 $('#date').jqxDateTimeInput({ disabled: false}); 
    			 
    				document.getElementById("mode").value="tarifinsert";
    				document.getElementById("frmLimoBooking").submit();
    				 $('#date').jqxDateTimeInput({ disabled: true}); 
				
    		}
     		});
		
	}
	
	
	function funSrvcReload(){
		$('#othersrvcdiv').load('otherSrvcGrid.jsp?docno='+document.getElementById("docno").value+'&id=1');
	}
	function funSrvcEdit(){
		$("#otherSrvcGrid").jqxGrid({ disabled: false});
		$("#billingGrid").jqxGrid({ disabled: false});
		$("#billingGrid").jqxGrid("addrow", null, {});
		$("#billingGrid").jqxGrid("addrow", null, {});
		$('#btnSrvcEdit').hide();
		$('#btnSrvcCancel').show();
		$('#btnSrvcSave').show();
	}
	function funSrvcCancel(){
		$("#otherSrvcGrid").jqxGrid({ disabled: true});
		$('#btnSrvcEdit').show();
		$('#btnSrvcCancel').hide();
		$('#btnSrvcSave').hide();
	}
	function funSrvcSave(){
		
		
		var summaryData1= $("#billingGrid").jqxGrid('getcolumnaggregateddata', 'billper', ['sum'],true);
		var billsum=summaryData1.sum;
		if(parseFloat(billsum)<100){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Total Bill Percentage must be 100%";
			return false;
		}
		else{
			document.getElementById("errormsg").innerText="";
		}
		var billrows=$('#billingGrid').jqxGrid('getrows');
		document.getElementById("billinggridlength").value=billrows.length;
		if(billrows[0].billto=="" || billrows[0].billto=="undefined" || billrows[0].billto==null || typeof(billrows[0].billto)=="undefined" || billrows[0].billmode=="" || billrows[0].billmode=="undefined" || billrows[0].billmode==null || typeof(billrows[0].billmode)=="undefined" || billrows[0].billper=="" || billrows[0].billper=="undefined" || billrows[0].billper==null || typeof(billrows[0].billper)=="undefined"){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Please enter valid data";
			return false;
		}
		else{
			document.getElementById("errormsg").innerText="";
		}
		for(var j=0;j<billrows.length;j++){
			newTextBox = $(document.createElement("input"))
		    .attr("type", "dil")
		    .attr("id", "bill"+j)
		    .attr("name", "bill"+j)
		    .attr("hidden",true); 
			if(billrows[j].billto!="" || billrows[j].billto!="undefined" || billrows[j].billto!=null || typeof(billrows[j].billto)!="undefined" || billrows[j].billmode!="" 
				|| billrows[j].billmode!="undefined" || billrows[j].billmode!=null || typeof(billrows[j].billmode)!="undefined" || billrows[j].billper!="" || 
				billrows[j].billper!="undefined" || billrows[j].billper!=null || typeof(billrows[j].billper)!="undefined"){
				
				newTextBox.val(billrows[j].billto+"::"+billrows[j].billmode+"::"+billrows[j].billper);
				newTextBox.appendTo('form');
			}
		}
		var srvcrows=$('#otherSrvcGrid').jqxGrid('getrows');
		document.getElementById("othersrvcgridlength").value=srvcrows.length;
		
		for(var i=0;i<srvcrows.length;i++){
			if(srvcrows[i].airport=="undefined" || srvcrows[i].airport=="" || typeof(srvcrows[i].airport)=="undefined"){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Must Complete all services";
				return false;
			}
			else{
				document.getElementById("errormsg").innerText="";
			}
			if((srvcrows[i].greetdate=="undefined" || srvcrows[i].greetdate=="" || typeof(srvcrows[i].greetdate)=="undefined") && (srvcrows[i].vipdate=="undefined" || srvcrows[i].vipdate=="" || typeof(srvcrows[i].vipdate)=="undefined") && (srvcrows[i].boquedate=="undefined" || srvcrows[i].boquedate=="" || typeof(srvcrows[i].boquedate)=="undefined")){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Must select minimum 1 service";
				return false;
			}
			else{
				document.getElementById("errormsg").innerText="";
			}
			newTextBox = $(document.createElement("input"))
		    .attr("type", "dil")
		    .attr("id", "srvc"+i)
		    .attr("name", "srvc"+i)
		    .attr("hidden",true);
			var greettime1,viptime1,boquetime1;
			if(srvcrows[i].greettime!="undefined" && srvcrows[i].greettime!="" && srvcrows[i].greettime!=null && typeof(srvcrows[i].greettime)!="undefined"){
				var greettime=new Date(srvcrows[i].greettime);
				greettime1=(greettime.getHours()<10?'0'+greettime.getHours():greettime.getHours())+":"+(greettime.getMinutes()<10?'0':'') + greettime.getMinutes();
			}
			else{
				greettime1=null;
			}
			if(srvcrows[i].viptime!="undefined" && srvcrows[i].viptime!="" && srvcrows[i].viptime!=null && typeof(srvcrows[i].viptime)!="undefined"){
				var viptime=new Date(srvcrows[i].viptime);
				viptime1=(viptime.getHours()<10?'0'+viptime.getHours():viptime.getHours())+":"+(viptime.getMinutes()<10?'0':'') + viptime.getMinutes();
			}
			else{
				viptime1=null;
			}
			if(srvcrows[i].boquetime!="undefined" && srvcrows[i].boquetime!="" && srvcrows[i].boquetime!=null && typeof(srvcrows[i].boquetime)!="undefined"){
				var boquetime=new Date(srvcrows[i].boquetime);
				boquetime1=(boquetime.getHours()<10?'0'+boquetime.getHours():boquetime.getHours())+":"+(boquetime.getMinutes()<10?'0':'') + boquetime.getMinutes();
			}
			else{
				boquetime1=null;
			}
			
			
			if(srvcrows[i].boquetarifdocno==""){
				srvcrows[i].boquetarifdocno="1";
			}
			newTextBox.val(srvcrows[i].docname+"::"+srvcrows[i].detaildocno+"::"+srvcrows[i].airportid+"::"+srvcrows[i].greetdate+"::"+greettime1+"::"+srvcrows[i].greettarifdocno+"::"+srvcrows[i].vipdate+"::"+viptime1+"::"+srvcrows[i].viptarifdocno+"::"+srvcrows[i].boquedate+"::"+boquetime1+"::"+srvcrows[i].boquetarifdocno);
			newTextBox.appendTo('form');
		}
		
		$.messager.confirm('Confirm', 'Do you want to save?', function(r){
    		if (r){
    			$("#overlay, #PleaseWait").show();
    			$('#date').jqxDateTimeInput({ disabled: false}); 
    			document.getElementById("mode").value="srvcinsert";
    			document.getElementById("frmLimoBooking").submit();
    			$('#date').jqxDateTimeInput({ disabled: true});
    		}
     		});
		
		
	}
	
	function funBackDateChecking(date){
		var currentdate=new Date();
		var status=-1;
		date.setHours(0,0,0,0);
		currentdate.setHours(0,0,0,0);
		if(date<currentdate){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Back Date Not Allowed";
			status=0;
		}
		else{
			status=1;
		}
		return status;
	}
</script>
</head>	
<body onLoad="setValues();">
	
   	<br/> 
	<div id="mainBG" class="homeContent" data-type="background"> 
		<form id="frmLimoBooking" action="saveLimoBooking" method="post" autocomplete="off">
			<jsp:include page="../../../header.jsp" />
   			<br>
    <div class='hidden-scrollbar'>
<table width="100%">
  <tr>
    <td width="13%" align="right">Date</td>
    <td width="16%"><div id="date" name="date" value='<s:property value="date" />'></div></td>
    <td width="15%">&nbsp;</td>
    <td width="11%">&nbsp;</td>
    <td width="23%">&nbsp;</td>
    <td width="8%" align="right">Doc No</td>
    <td width="14%"><input type="text" name="docno" id="docno" value='<s:property value="docno" />'></td>
  </tr>
  <tr>
    <td align="right">Client</td>
    <td><input type="text" name="client" id="client" value='<s:property value="client" />' style="width:100%;" readonly placeholder="Press F3 to Search" onkeydown="getClient(event);"></td>
    <input type="hidden" name="hidclient" id="hidclient" value='<s:property value="hidclient" />'>
    <td colspan="2"><input type="text" name="clientdetails" id="clientdetails" value='<s:property value="clientdetails" />' style="width:94%;"></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="right"><label for="chknewguest">New Guest</label><input type="checkbox" name="chknewguest" id="chknewguest" onChange="setNewGuest();">&nbsp;&nbsp;&nbsp;&nbsp;Guest</td>
    <input type="hidden" name="hidchknewguest" id="hidchknewguest" value='<s:property value="hidchknewguest" />'>
    <td><input type="text" name="guest" id="guest" value='<s:property value="guest" />' style="width:100%;" ></td>
    <input type="hidden" name="hidguest" id="hidguest" value='<s:property value="hidguest" />'>
    <td align="right">Contact No</td>
    <td><input type="text" name="guestcontactno" id="guestcontactno" value='<s:property value="guestcontactno" />'></td>
    <td>&nbsp;</td>
    <td colspan="2" align="center">
    <button type="button"  id="btnBookEdit" title="Booking Edit" style="border:none;background:none;" onclick="funBookEdit();" class="bookingbuttons">
		<img alt="Booking Edit" src="<%=contextPath%>/icons/tarifedit.png" width="30" height="30">
	</button>
    
	<button type="button" id="btnBookCancel" title="Booking Cancel"  style="border:none;background:none;" onclick="funBookCancel();" class="bookingbuttons">
		<img alt="Book Cancel" src="<%=contextPath%>/icons/tarifcancel.png" width="30" height="30">
	</button>
	<button type="button" id="btnBookSave" title="Booking Save"  style="border:none;background:none;" onclick="funBookSave();" class="bookingbuttons">
		<img alt="Book Save" src="<%=contextPath%>/icons/tarifsave.png" width="30" height="30">
	</button>
    </td>
    </tr>
  <tr>
    <td align="right">Description</td>
    <td colspan="4"><input type="text" name="description" id="description" value='<s:property value="description" />' style="width:99%;"></td>
    <td colspan="2" align="center">&nbsp;</td>
  </tr>
</table>
 <table width="100%">
   <tr>
    <td colspan="2"><fieldset><legend>Transfer Details</legend><div id="transferdiv"><jsp:include page="transferGrid.jsp"></jsp:include></div></fieldset></td>
  </tr>
   <tr>
    <td colspan="2"><fieldset><legend>Limo Details</legend><div id="hoursdiv"><jsp:include page="hoursGrid.jsp"></jsp:include></div></fieldset></td>
  </tr>
 <tr>
    <td colspan="2"><fieldset><legend>Other Services  <button type="button" id="btnSrvcReload" title="Booking Save"  style="border:none;background:none;" onclick="funSrvcReload();" class="srvcbuttons">
		<img alt="Other Srvc Reload" src="<%=contextPath%>/icons/btnbookreload.png" width="30" height="30">
	</button>
	<button type="button"  id="btnSrvcEdit" title="Other Srvc Edit" style="border:none;background:none;" onclick="funSrvcEdit();" class="srvcbuttons">
		<img alt="Other Srvc Edit" src="<%=contextPath%>/icons/tarifedit.png" width="30" height="30">
	</button>
    
	<button type="button" id="btnSrvcCancel" title="Other Srvc Cancel"  style="border:none;background:none;" onclick="funSrvcCancel();" class="srvcbuttons">
		<img alt="Other Srvc Cancel" src="<%=contextPath%>/icons/tarifcancel.png" width="30" height="30">
	</button>
	<button type="button" id="btnSrvcSave" title="Other Srvc Save"  style="border:none;background:none;" onclick="funSrvcSave();" class="srvcbuttons">
		<img alt="Other Srvc Save" src="<%=contextPath%>/icons/tarifsave.png" width="30" height="30">
	</button>
	</legend><div id="othersrvcdiv"><jsp:include page="otherSrvcGrid.jsp"></jsp:include></div></fieldset></td>
  </tr>
  <tr>
    <td width="50%"><fieldset><legend>Billing Details</legend><div id="billingdiv"><jsp:include page="billingGrid.jsp"></jsp:include></div></fieldset></td>
    <td width="50%">&nbsp;</td>
  </tr> 
</table> 
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
      <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
      <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
      <input type="hidden" name="transfergridlength" id="transfergridlength" value='<s:property value="transfergridlength"/>'/>
      <input type="hidden" name="hoursgridlength" id="hoursgridlength" value='<s:property value="hoursgridlength"/>'/>
      <input type="hidden" name="othersrvcgridlength" id="othersrvcgridlength" value='<s:property value="othersrvcgridlength"/>'/>
      <input type="hidden" name="billinggridlength" id="billinggridlength" value='<s:property value="billinggridlength"/>'/>
      <input type="hidden" name="savestatus" id="savestatus" value='<s:property value="savestatus"/>'/>
   <div id="locationwindow">
   <div ><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
</div>
<div id="srvctarifwindow">
   <div ><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
</div>
<div id="airportwindow">
   <div ><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
</div>
<div id="clientwindow">
   <div ><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
</div>
<div id="guestwindow">
   <div ><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
</div>
<div id="modelwindow">
   <div ><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
</div>
<div id="brandwindow">
   <div ><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
</div>
<div id="tarifwindow">
   <div ><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
</div>
</div>

</form>
</div>
</body>
</html>