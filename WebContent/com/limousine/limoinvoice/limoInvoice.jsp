<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../includes.jsp"></jsp:include>
<% String contextPath=request.getContextPath();%>
<link rel="stylesheet" type="text/css" href="../../../css/body.css">
<script type="text/javascript">
     $(document).ready(function () { 
    	$("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"}); 
	 	$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
        $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
        $('#clientwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '55%' ,maxWidth: '60%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
 	   	$('#clientwindow').jqxWindow('close');
 	   	$('#guestwindow').jqxWindow({ width: '30%', height: '50%',  maxHeight: '50%' ,maxWidth: '30%' , title: 'Guest Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   	$('#guestwindow').jqxWindow('close');
	   	$('#jobwindow').jqxWindow({ width: '30%', height: '50%',  maxHeight: '50%' ,maxWidth: '30%' , title: 'Job Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   	$('#jobwindow').jqxWindow('close');
	   	$('#fleetwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '55%' ,maxWidth: '60%' , title: 'Fleet Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   	$('#fleetwindow').jqxWindow('close');
	   	$('#locationwindow').jqxWindow({ width: '30%', height: '50%',  maxHeight: '50%' ,maxWidth: '30%' , title: 'Guest Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   	$('#locationwindow').jqxWindow('close');
	   	$('#typewindow').jqxWindow({ width: '30%', height: '50%',  maxHeight: '50%' ,maxWidth: '30%' , title: 'Type Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   	$('#typewindow').jqxWindow('close');
	   	$("#client").dblclick(function() {
        	if(document.getElementById("mode").value!="A" && document.getElementById("mode").value!="E"){
        		return false;
        	}
        	$('#clientwindow').jqxWindow('open');
			$('#clientwindow').jqxWindow('focus');
			clientSearchContent('masterClientSearch.jsp?', $('#clientwindow'));
        });
     });
     function getClient(event){
    	 if(document.getElementById("mode").value!="A" && document.getElementById("mode").value!="E"){
     		return false;
     	}
    	  var x= event.keyCode;
          if(x==114){
        	$('#clientwindow').jqxWindow('open');
  			$('#clientwindow').jqxWindow('focus');
  			clientSearchContent('masterClientSearch.jsp?', $('#clientwindow'));
          }
          else{
           }
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
     function jobSearchContent(url) {
	      $.get(url).done(function (data) {
	    $('#jobwindow').jqxWindow('setContent', data);
	}); 
	}
     function typeSearchContent(url) {
	      $.get(url).done(function (data) {
	    $('#typewindow').jqxWindow('setContent', data);
	}); 
	}
     function fleetSearchContent(url) {
	      $.get(url).done(function (data) {
	    $('#fleetwindow').jqxWindow('setContent', data);
	}); 
	}
     function locationSearchContent(url) {
	      $.get(url).done(function (data) {
	    $('#locationwindow').jqxWindow('setContent', data);
	}); 
	}
     
     function funReadOnly(){
    	$('#frmLimoInvoice input').attr('readonly', true );
 	    $('#date').jqxDateTimeInput({ disabled: true});
 	    $("#fromdate").jqxDateTimeInput({ disabled: true});
        $("#todate").jqxDateTimeInput({ disabled: true});
     }
     
     function funRemoveReadOnly(){
    	$('#frmLimoInvoice input').attr('readonly', false );
  	    $('#date').jqxDateTimeInput({ disabled: false});
  	    $("#fromdate").jqxDateTimeInput({ disabled: false});
        $("#todate").jqxDateTimeInput({ disabled: false});
        $('#docno').attr('readonly',true);
        $('#vocno').attr('readonly',true);
        $('#client').attr('readonly',true);
        $('#clientdetails').attr('readonly',true);
     }
     
     function funNotify(){
    	//Month Close Validation
 		var docdateval=funDateInPeriod($('#date').jqxDateTimeInput('getDate'));
 		if(docdateval==0){
 			$('#date').jqxDateTimeInput('focus');
 			return 0;
 		}
 		
    	 if(document.getElementById("client").value==""){
    		 document.getElementById("errormsg").value="";
    		 document.getElementById("errormsg").value="Client is Mandatory";
    		 return 0;
    	 }
    	//From Date and todate validation
 		if($('#fromdate').jqxDateTimeInput('getDate')==null){
 			document.getElementById("errormsg").innerText="";
 			document.getElementById("errormsg").innerText="Invoice From Date is Mandatory";
 			return 0;
 		}
 		if($('#todate').jqxDateTimeInput('getDate')==null){
 			document.getElementById("errormsg").innerText="";
 			document.getElementById("errormsg").innerText="Invoice To Date is Mandatory";
 			return 0;
 		}
 		var rows = $("#limoInvoiceGrid").jqxGrid('getrows');
		document.getElementById("gridlength").value=rows.length;
 		if(rows[0].guest=="undefined" || rows[0].guest==null || rows[0].guest==""){
		
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Cannot Generate Empty Invoice";
			return 0;
		}
		
		if(rows[0].total=="undefined" || rows[0].total==null || rows[0].total==""){
			
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Cannot Generate Empty Invoice";
			return 0;
		}
		
		for(var i=0 ; i < rows.length ; i++){
			
				newTextBox = $(document.createElement("input"))
	    		.attr("type", "dil")
	    		.attr("id", "invoice"+i)
	    		.attr("name", "invoice"+i)
	    		.attr("hidden", "true");
			
				newTextBox.val(rows[i].guestno+"::"+rows[i].jobtype+"::"+rows[i].jobdocno+"::"+rows[i].bookdocno+"::"+rows[i].jobnametemp+"::"+rows[i].total+"::"+rows[i].tarif+"::"+rows[i].nighttarif+"::"+rows[i].excesskmchg+"::"+rows[i].excesshrchg+"::"+rows[i].excessnighthrchg+"::"+rows[i].fuelchg+"::"+rows[i].parkingchg+"::"+rows[i].otherchg+"::"+rows[i].greetchg+"::"+rows[i].vipchg+"::"+rows[i].boquechg+"::"+"0"+"::"+"0"+"::"+"0"+"::"+"0");		
				newTextBox.appendTo('form');
			}
		
		/* var summaryData1= $("#limoInvoiceGrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
		document.getElementById("mastertotal").value=summaryData1.sum; */
		document.getElementById("manual").value="1";
    	 return 1;
     }
     
     function setValues(){
		 if($('#msg').val()!=""){
  		   $.messager.alert('Message',$('#msg').val());
  		  }
		 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
     
		 if(document.getElementById("docno").value!=""){
			 $('#limoinvoicediv').load('limoInvoiceGrid2.jsp?docno='+document.getElementById("docno").value+'&id=1');
		 }
     }
     
     function funSearchLoad(){
			changeContent('masterSearch.jsp?branch='+$('#brchName').val(), $('#window'));
	 }
     
     function funFocus(){
		   document.getElementById("client").focus(); 	    		
	 }
	 
	function funPrintBtn(){
    	if(document.getElementById("docno").value!=""){
        	var url=document.URL;
        	var reurl=url.split("limoInvoice.jsp");
        	var win= window.open(reurl[0]+"printLimoInvoice?docno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
            win.focus();    		
    	}
    }
</script>
<style>
.hidden-scrollbar {
overflow: hidden;
height: 530px;
}
</style>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmLimoInvoice" action="saveLimoInvoice" autocomplete="off">
	<script>
			window.parent.formName.value="Limousine Invoice";
			window.parent.formCode.value="LIN";
	</script>
	<jsp:include page="../../../header.jsp" />
	<br>
	<table width="100%">
	  <tr>
	    <td width="10%" align="right">Date</td>
	    <td width="15%"><div id="date" name="date" value='<s:property value="date"/>'></div></td>
	    <td width="11%">&nbsp;</td>
	    <td width="21%">&nbsp;</td>
	    <td width="20%">&nbsp;</td>
	    <td width="11%" align="right">Doc No</td>
	    <td width="12%"><input type="text" name="vocno" id="vocno" value='<s:property value="vocno"/>'></td>
      </tr>
	  <tr>
	    <td align="right">Client</td>
	    <td><input type="text" name="client" id="client" value='<s:property value="client"/>' readonly placeholder="Press F3 to Search"></td>
        <input type="hidden" name="hidclient" id="hidclient" value='<s:property value="hidclient"/>'>
	    <td align="right">Details</td>
	    <td colspan="2"><input type="text" name="clientdetails" id="clientdetails" value='<s:property value="clientdetails"/>' style="width:100%;"></td>
	    <td>&nbsp;</td>
	    <td>&nbsp;</td>
      </tr>
	  <tr>
	    <td align="right">From Date</td>
	    <td><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
	    <td align="right">Ledger Note</td>
	    <td colspan="2"><input type="text" name="ledgernote" id="ledgernote" value='<s:property value="ledgernote"/>' style="width:100%;"></td>
	    <td>&nbsp;</td>
	    <td>&nbsp;</td>
      </tr>
	  <tr>
	    <td align="right">To Date</td>
	    <td><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	    <td align="right">Invoice Note</td>
	    <td colspan="2"><input type="text" name="invoicenote" id="invoicenote" value='<s:property value="invoicenote"/>' style="width:100%;"></td>
	    <td>&nbsp;</td>
	    <td>&nbsp;</td>
      </tr>
      <tr><td colspan="8"><div id="limoinvoicediv"><jsp:include page="limoInvoiceGrid2.jsp"></jsp:include></div></td></tr>
    </table>
	<br/> 
<!-- <div class='hidden-scrollbar'>
</div> -->
<input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>'>
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" name="mastertotal" id="mastertotal" value='<s:property value="mastertotal"/>'/>
<input type="hidden" name="manual" id="manual" value='<s:property value="manual"/>'/>
<input type="hidden" name="trno" id="trno" value='<s:property value="trno"/>'/>
<input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'/>
<div id="clientwindow">
   <div ><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
</div>
<div id="locationwindow">
   <div ><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
</div>
<div id="guestwindow">
   <div ><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
</div>
<div id="jobwindow">
   <div ><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:50%;margin-top:25%;" /></div>
</div>
<div id="fleetwindow">
   <div ><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
</div>
<div id="typewindow">
   <div ><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
</div>
</form>
</div>
</body>
</html>