

<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link rel="stylesheet" type="text/css" href="../../../../css/body.css">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script>
$(document).ready(function () { 
	/* if(document.getElementById("docno").value==""){
		document.getElementById("btnServiceEdit").disabled=true;
	} */
	document.getElementById("btnServiceSave").style.display="none";
	$("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$("#srvcfromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$("#srvctodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	
	$("#servicedate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	  $('#garagewindow').jqxWindow({ autoOpen:false,width: '60%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Garage Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	  $('#fleetwindow').jqxWindow({ autoOpen:false,width: '60%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Fleet Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	  //Garage Double Click Search
 	 $('#garage').dblclick(function(){
		    $('#garagewindow').jqxWindow('open');
		$('#garagewindow').jqxWindow('focus');
		 garageSearchContent('garageSearch.jsp?', $('#garagewindow'));
		});
	  //Fleet Double Click Search
 	 $('#fleetno').dblclick(function(){
    		
		    $('#fleetwindow').jqxWindow('open');
		$('#fleetwindow').jqxWindow('focus');
		 fleetSearchContent('fleetSearch.jsp?', $('#fleetwindow'));
		});
});
function fleetSearchContent(url) {
	      $.get(url).done(function (data) {
	    $('#fleetwindow').jqxWindow('setContent', data);

	}); 
	}
function getFleet(event){
	   	//alert("Here");
     var x= event.keyCode;
     if(x==114){
   	   $('#fleetwindow').jqxWindow('open');
  		$('#fleetwindow').jqxWindow('focus');
  		 fleetSearchContent('fleetSearch.jsp?', $('#fleetwindow'));
     }
     else{
      }
     }
function garageSearchContent(url) {
	      $.get(url).done(function (data) {
	    $('#garagewindow').jqxWindow('setContent', data);

	}); 
	}
function getGarage(event){
    var x= event.keyCode;
    if(x==114){
  	  $('#garagewindow').jqxWindow('open');
		$('#garagewindow').jqxWindow('focus');
		 garageSearchContent('garageSearch.jsp?', $('#garagewindow'));
    }
    else{
     }
	
}
function funNotify(){	
	if(document.getElementById("garage").value==""){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Garage is Mandatory";
		return 0;
	}
	if($('#date').jqxDateTimeInput('getDate')==null){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Date is Mandatory";
		return 0;
	}
	if($('#srvcfromdate').jqxDateTimeInput('getDate')==null){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Service From Date is Mandatory";
		return 0;
	}
	if($('#srvctodate').jqxDateTimeInput('getDate')==null){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Service To Date is Mandatory";
		return 0;
	}
	var srvcfromdate=$('#srvcfromdate').jqxDateTimeInput('getDate');
	var srvctodate=$('#srvctodate').jqxDateTimeInput('getDate');
	srvcfromdate.setHours(0,0,0,0);
	srvctodate.setHours(0,0,0,0);
	if(srvctodate<srvcfromdate){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Service To Date cannot be less than From Date";
		return 0;
	}
	return 1;
}
function funChkButton() {

}
function funSearchLoad(){
	changeContent('quickServiceSearch.jsp'); 
 }

	function funReadOnly(){
		$('#frmQuickServiceUpdate input').attr('readonly', true );
  		$('#frmQuickServiceUpdate select').attr('disabled', true);
  		$('#frmQuickServiceUpdate checkbox').attr('disabled', true);
  		$('#frmQuickServiceUpdate textarea').attr('readonly', true );
  		$('#fleetno').prop('readonly',true);
  		$('#fleetname').prop('readonly',true);
  		$('#garage').prop('readonly',true);
  		$('#garagename').prop('readonly',true);
  	  $('#date').jqxDateTimeInput({ disabled: true});
  	$('#srvcfromdate').jqxDateTimeInput({ disabled: true});
  	$('#srvctodate').jqxDateTimeInput({ disabled: true});
  	$('#servicedate').jqxDateTimeInput({ disabled: true});
  		
	}
	function funRemoveReadOnly(){
		$('#frmQuickServiceUpdate input').attr('readonly', false);
  		$('#frmQuickServiceUpdate select').attr('disabled', false);
  		$('#frmQuickServiceUpdate checkbox').attr('disabled', false);
  		$('#frmQuickServiceUpdate textarea').attr('readonly', false );
  		$('#fleetno').prop('readonly',true);
  		$('#fleetname').prop('readonly',true);
  		$('#garage').prop('readonly',true);
  		$('#garagename').prop('readonly',true);

    	  $('#date').jqxDateTimeInput({ disabled: false});
    	$('#srvcfromdate').jqxDateTimeInput({ disabled: false});
    	$('#srvctodate').jqxDateTimeInput({ disabled: false});
    	$('#servicedate').jqxDateTimeInput({ disabled: false});
    	if(document.getElementById("mode").value=="A"){
    		$('#fleetno').prop('disabled',true);
    		$('#fleetname').prop('disabled',true);
    		$('#currentkm').prop('disabled',true);
    		$('#nextduekm').prop('disabled',true);
    		$('#billno').prop('disabled',true);
    		$('#partscost').prop('disabled',true);
    		$('#labourcost').prop('disabled',true);
    		 $('#gridService').jqxGrid('clear');
	    	 $("#gridService").jqxGrid("addrow", null, {});
    	}
	}
	function setValues(){
		funSetlabel();
		 if($('#msg').val()!=""){
	  		   $.messager.alert('Message',$('#msg').val());
	  		  }
		 if(document.getElementById("docno").value!=""){
			 $('#servicediv').load('serviceUpdateGrid.jsp?docno='+document.getElementById("docno").value);	 
		 }
		
	}
	function resetValues(){
		$('#fleetno').val('');
		$('#fleetname').val('');
		$('#currentkm').val('');
		$('#nextduekm').val('');
		$('#billno').val('');
		$('#partscost').val('');
		$('#labourcost').val('');
		
	}
	function funServiceEdit(){
		if(document.getElementById("docno").value==""){
			$.messager.alert('Warning','Please Select a Document');
			return false;
		}
	//	alert(document.getElementById("confirmstatus").value);
		if(document.getElementById("confirmstatus").value=="1"){
			$.messager.alert('Warning','Services Confirmed,Cannot Add');
			return false;
		}
		resetValues();
		$('#fleetno').prop('disabled',false);
		$('#fleetname').prop('disabled',false);
		$('#currentkm').prop('disabled',false);
		$('#nextduekm').prop('disabled',false);
		$('#billno').prop('disabled',false);
		$('#partscost').prop('disabled',false);
		$('#labourcost').prop('disabled',false);
		
		$('#currentkm').prop('readonly',false);
		$('#nextduekm').prop('readonly',false);
		$('#billno').prop('readonly',false);
		$('#partscost').prop('readonly',false);
		$('#labourcost').prop('readonly',false);
		
	    	$('#servicedate').jqxDateTimeInput({ disabled: false});
	    	$('#frmQuickServiceUpdate checkbox').attr('disabled', false);
		
		document.getElementById("btnServiceEdit").disabled=false;
		document.getElementById("btnServiceEdit").style.display="none";
		document.getElementById("btnServiceSave").style.display="block";
		document.getElementById("fleetno").focus();
	}
	function funServiceSave(){
		if(document.getElementById("currentkm").value==""){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Current Km is Mandatory";
			return false;
		}
		if(document.getElementById("nextduekm").value==""){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Next Due Km is Mandatory";
			return false;
		}
		if(document.getElementById("billno").value==""){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Next Due Km is Mandatory";
			return false;
		}
		if(document.getElementById("chkwashing").checked==true){
			document.getElementById("hidchkwashing").value="1";
		}
		else{
			document.getElementById("hidchkwashing").value="0";
		}
		if(document.getElementById("chkoil").checked==true){
			document.getElementById("hidchkoil").value="1";
			
		}
		else{
			document.getElementById("hidchkoil").value="0";
		}
		if(document.getElementById("chkoilfilter").checked==true){
			document.getElementById("hidchkoilfilter").value="1";
			
		}
		else{
			document.getElementById("hidchkoilfilter").value="0";
		}
		if(document.getElementById("chkfuelfilter").checked==true){
			document.getElementById("hidchkfuelfilter").value="1";
		}
		else{
			document.getElementById("hidchkfuelfilter").value="0";
		}
		if(document.getElementById("chkairfilter").checked==true){
			document.getElementById("hidchkairfilter").value="1";
		}
		else{
		 	document.getElementById("hidchkairfilter").value="0";
		}
		
		$.messager.confirm('Confirm', 'Do you want to Save?', function(r){
 			if (r){
 				document.getElementById("mode").value="E";
				document.getElementById("frmQuickServiceUpdate").submit();
 			}
		});
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
	 function funFocus(){
		 $('#srvcfromdate').jqxDateTimeInput('focus');
		 
	 }
	 function confirmService(){
		 var garage=document.getElementById("garage").value;
		 var branch=document.getElementById("brchName").value; 
		 var totalamt=$('#gridService').jqxGrid('getcolumnaggregateddata', 'total', ['sum'], true);
		 var partsamt=$('#gridService').jqxGrid('getcolumnaggregateddata', 'partscost', ['sum'], true);
		 var labouramt=$('#gridService').jqxGrid('getcolumnaggregateddata', 'labourcost', ['sum'], true);
		 document.getElementById("sumtotal").value=totalamt.sum;
		 document.getElementById("sumparts").value=partsamt.sum;
		 document.getElementById("sumlabour").value=labouramt.sum;
		 var formdetailcode=document.getElementById("formdetailcode").value;
		var date=$('#date').jqxDateTimeInput('val');
		
		//alert(garage+":"+branch+":"+totalamt.sum+":"+partsamt.sum+":"+labouramt.sum+":"+date+":"+formdetailcode);
		 var testfleet=$('#gridService').jqxGrid('getcellvalue',0,'fleetno');
		 if(testfleet="" || testfleet==null || testfleet=="undefined"){
				$.messager.alert('Warning','Cannot Confirm Empty Service');
				return false;
		 }
		 if(document.getElementById("confirmstatus").value=="1"){
			 $.messager.alert('Warning','Already Confirmed');
				return false;
		 }
			$.messager.confirm('Confirm', 'Do you want to Confirm Services?', function(r){
	 			if (r){
	 				var x = new XMLHttpRequest();
	 				x.onreadystatechange = function() {
	 					if (x.readyState == 4 && x.status == 200) {
	 						var items = x.responseText;
	 						if(items.trim()=="1"){
	 							document.getElementById("confirmstatus").value=items.trim();
		 						$.messager.alert('Message','Services Confirmed');	
	 						}
	 						
	 						} 
	 					else {
	 						}
	 				}
	 				x.open("GET", "confirmService.jsp?docno="+document.getElementById("docno").value+"&garage="+garage+"&branch="+branch+"&total="+totalamt.sum+"&partscost="+partsamt.sum+"&labourcost="+labouramt.sum+"&date="+date+"&formdetailcode="+formdetailcode, true);
	 				x.send();
	 			}
			});
		
	 }
</script>

</head>

<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmQuickServiceUpdate" action="saveQuickServiceUpdate" autocomplete="off">

	<jsp:include page="../../../../header.jsp" />
	<br/> 
<!--
<div class='hidden-scrollbar'>

</div>-->
<fieldset>
<table width="100%">
  <tr>
    <td width="4%" align="right">Date</td>
    <td width="8%" align="left"><div id="date" name="date" value='<s:property value="date"/>'></div></td>
    <td>&nbsp;</td>
    <td align="right">From</td>
    <td align="left"><div id="srvcfromdate" name="srvcfromdate" value='<s:property value="srvcfromdate"/>'></div></td>
    <td align="right">To</td>
    <td align="left"><div id="srvctodate" name="srvctodate" value='<s:property value="srvctodate"/>'></div></td>
    <td width="6%" align="right">&nbsp;</td>
    <td width="8%" align="left">&nbsp;</td>
    <td align="right">Doc No</td>
    <td align="left"><input type="text" name="docno" id="docno" value='<s:property value="docno"/>'></td>
  </tr>
  <tr>
    <td align="right">Garage</td>
    <td align="left"><input type="text" name="garage" id="garage" value='<s:property value="garage"/>' onkeydown="getGarage(event);" placeholder="Press F3 to Search"></td>
    <td width="26%" align="left"><input type="text" name="garagename" id="garagename" value='<s:property value="garagename"/>' style="width:95%;"></td>
    <td width="6%" align="right">&nbsp;</td>
    <td width="8%" align="left">&nbsp;</td>
    <td width="6%" align="right">&nbsp;</td>
    <td width="11%" align="left">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="left">&nbsp;</td>
       <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
 
  <tr>
    <td align="right">Remarks</td>
    <td colspan="9"><input type="text" name="remarks" id="remarks" value='<s:property value="remarks"/>' style="width:100%;"></td>
    <td >&nbsp;</td>
  <tr>
    <td width="4%" align="right">Fleet</td>
    <td><input type="text" name="fleetno" id="fleetno" readonly value='<s:property value="fleetno"/>' onkeydown="getFleet(event);" placeholder="Press F3 to Search"></td>
    <td><input type="text" name="fleetname" id="fleetname" readonly value='<s:property value="fleetname"/>' style="width:95%;"></td>
    <td width="6%" align="right">Current KM</td>
    <td width="8%" align="left"><input type="text" name="currentkm" id="currentkm" readonly value='<s:property value="currentkm"/>' style="text-align:right;"></td>
    <td width="6%" align="right">Next Due KM</td>
    <td width="11%" align="left"><input type="text" name="nextduekm" id="nextduekm" value='<s:property value="nextduekm"/>' style="text-align:right;"></td>
    <td width="6%" align="right">Bill No</td>
    <td width="8%" align="left"><input type="text" name="billno" id="billno" value='<s:property value="billno"/>'></td>
    <td width="9%" align="right">Service Date</td>
    <td width="8%" ><div id="servicedate" name="servicedate" value='<s:property value="servicedate"/>'></div></td>
  <tr>
    <td align="right">&nbsp;</td>
    <td colspan="9" align="left">
      <fieldset>
        <legend>Service</legend>
        <table width="100%">
          <tr>
            <td width="6%"><input type="checkbox" name="chkwashing" id="chkwashing" >
      Washing</td>
            <input type="hidden" name="hidchkwashing" id="hidchkwashing" value='<s:property value="hidchkwashing"/>'>
            <td width="7%"><input type="checkbox" name="chkoil" id="chkoil" >
              Oil</td>
            <input type="hidden" name="hidchkoil" id="hidchkoil" value='<s:property value="hidchkoil"/>'>
            <td width="13%"><input type="checkbox" name="chkoilfilter" id="chkoilfilter" >Oil Filter</td>
            <input type="hidden" name="hidchkoilfilter" id="hidchkoilfilter" value='<s:property value="hidchkoilfilter"/>'>
            <td width="12%"><input type="checkbox" name="chkfuelfilter" id="chkfuelfilter" >Fuel Filter</td>
            <input type="hidden" name="hidchkfuelfilter" id="hidchkfuelfilter" value='<s:property value="hidchkfuelfilter"/>'>
            <td width="10%"><input type="checkbox" name="chkairfilter" id="chkairfilter" >Air Filter</td>
            <input type="hidden" name="hidchkairfilter" id="hidchkairfilter" value='<s:property value="hidchkairfilter"/>'>
            <td width="13%" align="right">Parts Cost</td>
            <td width="12%" align="left"><input type="text" name="partscost" id="partscost" value='<s:property value="partscost"/>' onkeypress="javascript:return isNumber (event,id)" onblur="funRoundAmt(value,id);" style="text-align:right;"></td>
            <td width="7%" align="right">Labour Cost</td>
            <td width="20%" align="left"><input type="text" name="labourcost" id="labourcost" value='<s:property value="labourcost"/>' onkeypress="javascript:return isNumber (event,id)" onblur="funRoundAmt(value,id);" style="text-align:right;"></td>
            </tr>
          </table>
        
      </fieldset></td>
      <td><center>
     <button type="button"  id="btnServiceEdit" title="Service Edit" style="border:none;background:none;" onclick="funServiceEdit();">
							<img alt="Service Edit" src="<%=contextPath%>/icons/detail_add.png" width="30" height="30">
		  </button>   
		  <button type="button"  id="btnServiceSave" title="Service Save" style="border:none;background:none;" onclick="funServiceSave();">
							<img alt="Tarif Save" src="<%=contextPath%>/icons/tarifsave.png" width="30" height="30">
		  </button>    
		   <center>
		  
		  </td>
    </tr>
    </table>
    
    </td>
    </tr>
</table>
</fieldset>
<fieldset>
    <table width="100%" >
  <tr>
    <td width="92%">
<div id="servicediv">
    <jsp:include page="serviceUpdateGrid.jsp"></jsp:include>
</div>
    </td>
  <td width="8%" align="center">
  <input type="button" name="btnServiceConfirm" id="btnServiceConfirm" class="myButton" value="Confirm" onclick="confirmService();">
  </td>
  </tr>
</table>
</fieldset>

<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
   <input type="hidden" id="mode" name="mode"/>
<input type="text" name="delete" id="delete" value='<s:property value="delete"/>' hidden="true"/>
<input type="hidden" name="confirmstatus" id="confirmstatus" value='<s:property value="confirmstatus"/>' hidden="true"/>
<input type="hidden" name="sumtotal" id="sumtotal">
<input type="hidden" name="sumparts" id="sumparts">
<input type="hidden" name="sumlabour" id="sumlabour">

<div id="garagewindow">
   <div ></div>
</div>
<div id="fleetwindow">
   <div ></div>
</div>
</form>
</div>
</body>
</html>