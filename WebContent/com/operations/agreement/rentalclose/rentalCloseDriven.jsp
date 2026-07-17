<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<!-- <link href="../../../../css/body.css" rel="stylesheet" type="text/css"> -->
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <link rel="stylesheet" type="text/css" href="../../../../css/body.css"> 
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
.hidden-scrollbar {
    overflow: auto;
    height: 600px;
}
</style>
<script type="text/javascript">
$(document).ready(function () {
	document.getElementById("chkcollection").unchecked=true;
	document.getElementById("chauffer").disabled="true";
	 checkConvertion(); 
	getConvertion();
	getBranch();
	getTestLocation();
	$('#brchName').change(function(){
  getAgmtLocation();
 });
	if(document.getElementById("hidchkcollection").value=="1"){
		document.getElementById("chkcollection").checked=true;
	}
	else{
		document.getElementById("chkcollection").checked=false;
	}
	// setCollection();
	//$("#tarifreferencegrid").jqxGrid({ disabled: true});
	 $("#closedate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#indate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	 $("#collectdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	 $("#datehidden").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#agmtdeliverydate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#closedatehidden").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#closeinvdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	// $("#accidentdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	// $("#policecollecteddate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#intime").jqxDateTimeInput({ width: '80%', height: '17px', formatString: 'HH:mm', showCalendarButton: false ,value:null});
	 $("#collecttime").jqxDateTimeInput({ width: '80%', height: '17px', formatString: 'HH:mm', showCalendarButton: false,value:null});
	//Minimize Button
	 $("#jqxMenuMore").jqxMenu({ width: '40%', height: '26px', autoSizeMainItems: true});
     $("#jqxMenuMore").jqxMenu('minimize');            
     $("#jqxMenuMore").css('visibility', 'visible');
     //Common window for minimize button
     $('#window1').jqxWindow({width: '71%', height: '70%',  maxHeight: '70%' ,maxWidth: '80%' , title: 'Details',position: { x: 180, y: 60 } , theme: 'energyblue', showCloseButton: true,keyboardCloseKey: 27});
     $('#window1').jqxWindow('close');
	 //$("#accidenttime").jqxDateTimeInput({ width: '100%', height: '17px', formatString: 'HH:mm', showCalendarButton: false });
	  $('#agmtnowindow').jqxWindow({ width: '60%', height: '68%',  maxHeight: '68%' ,maxWidth: '60%' , title: 'Agreement Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#agmtnowindow').jqxWindow('close');
	   $('#collectionWindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '58%' ,maxWidth: '50%' , title: 'Collection Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#collectionWindow').jqxWindow('close');
	   $('#checkinWindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '58%' ,maxWidth: '50%' , title: 'Check In Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#checkinWindow').jqxWindow('close');
	   $('#rentalAgentWindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '58%' ,maxWidth: '50%' , title: 'Rental Agent Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#rentalAgentWindow').jqxWindow('close');
	   
	      $('#indate').on('change', function (event) 
			   {  
		  if(document.getElementById("mode").value=="A"){
			
			document.getElementById("useddays").value="";
			document.getElementById("usedhours").value="";
			document.getElementById("totalkm").value="";
			document.getElementById("excesskm").value="";
			document.getElementById("lblinvoicedone").innerText="";
			 $('#totalgrid').jqxGrid('clear');
	    	 $("#totalgrid").jqxGrid("addrow", null, {});
	    	 $('#calculationgrid').jqxGrid('clear');
	    	 $("#calculationgrid").jqxGrid("addrow", null, {});
		  }
			   });
	   $('#intime').on('change', function (event) 
			   {  
		   if(document.getElementById("mode").value=="A"){
			document.getElementById("useddays").value="";
			document.getElementById("usedhours").value="";
			document.getElementById("totalkm").value="";
			document.getElementById("excesskm").value="";
			document.getElementById("lblinvoicedone").innerText="";
			 $('#totalgrid').jqxGrid('clear');
	    	 $("#totalgrid").jqxGrid("addrow", null, {});
	    	 $('#calculationgrid').jqxGrid('clear');
	    	 $("#calculationgrid").jqxGrid("addrow", null, {});
		   }
			   });
	   $( "#inkm" ).change(function() {
		   if(document.getElementById("mode").value=="A"){
			document.getElementById("useddays").value="";
			document.getElementById("usedhours").value="";
			document.getElementById("totalkm").value="";
			document.getElementById("excesskm").value="";
			document.getElementById("lblinvoicedone").innerText="";
			 $('#totalgrid').jqxGrid('clear');
	    	 $("#totalgrid").jqxGrid("addrow", null, {});
	    	 $('#calculationgrid').jqxGrid('clear');
	    	 $("#calculationgrid").jqxGrid("addrow", null, {});
		   }
		 });
	   $( "#cmbinfuel" ).change(function() {
		   if(document.getElementById("mode").value=="A"){
			document.getElementById("useddays").value="";
			document.getElementById("usedhours").value="";
			document.getElementById("totalkm").value="";
			document.getElementById("excesskm").value="";
			document.getElementById("lblinvoicedone").innerText="";
			 $('#totalgrid').jqxGrid('clear');
	    	 $("#totalgrid").jqxGrid("addrow", null, {});
	    	 $('#calculationgrid').jqxGrid('clear');
	    	 $("#calculationgrid").jqxGrid("addrow", null, {});
		   }
		 });
	   
	   
	   $('#vocno').dblclick(function(){
			 if(document.getElementById("mode").value=="A"){
					if(document.getElementById("cmbagmtbranch").value==""){
						document.getElementById("errormsg").innerText="";
						document.getElementById("errormsg").innerText="Agreement Branch is Mandatory";
						return false;
					}
		    $('#agmtnowindow').jqxWindow('open');
		$('#agmtnowindow').jqxWindow('focus');
		 agmtnoSearchContent('agmtnoSearch.jsp?', $('#agmtnowindow'));
			 }
			 });
	   $('#checkin').dblclick(function(){
			 if(document.getElementById("mode").value=="A"){

		    $('#checkinWindow').jqxWindow('open');
		$('#checkinWindow').jqxWindow('focus');
		 checkinSearchContent('checkinGrid.jsp?', $('#checkinWindow'));
			 }
			 });
	   $('#rentalagent').dblclick(function(){
			 if(document.getElementById("mode").value=="A"){

		    $('#rentalAgentWindow').jqxWindow('open');
		$('#rentalAgentWindow').jqxWindow('focus');
		 rentalSearchContent('rentalAgentGrid.jsp?', $('#rentalAgentWindow'));
			 }
			 });
	   $('#chauffer').dblclick(function(){
		    $('#collectionWindow').jqxWindow('open');
		$('#collectionWindow').jqxWindow('focus');
		 collectSearchContent('collectSearch.jsp', $('#collectionWindow'));
		});
	   //alert(document.getElementById("mode").value);
	   if(document.getElementById("mode").value=='view'){
		  $('#btnprocess').attr('disabled',true);
		  $('#btncalculate').attr('disabled',true);
	   }
 });
 
 function getBranch(){
	var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('***');
				var locItems = items[0].split(",");
				var locIdItems = items[1].split(",");
				var optionsloc = '<option value="">--Select--</option>';
				for (var i = 0; i < locItems.length; i++) {
					optionsloc += '<option value="' + locIdItems[i] + '">'
							+ locItems[i] + '</option>';
				}
				$("select#cmbagmtbranch").html(optionsloc);
				
				if ($('#hidcmbagmtbranch').val() != null) {
					$('#cmbagmtbranch').val($('#hidcmbagmtbranch').val());
				}
			} else {
			}
		}
		x.open("GET", "getBranch.jsp", true);
		x.send();
	}
	
	
function menuContent(url) {
    $.get(url).done(function (data) {
       $('#window1').jqxWindow('open');
   $('#window1').jqxWindow('setContent', data);
   $('#window1').jqxWindow('bringToFront');
   
      });
}
function replacement(){
	if (($("#mode").val() == "view") && $("#agreementno").val()!="") {
    $('#window1').jqxWindow('open');
    menuContent('vehReplaceGrid.jsp?docnovals='+document.getElementById("agreementno").value, $('#window1'));
	}

	   else {
	    	      $.messager.alert('Message','Select a Document....!','warning');
	    	      return false;
	    	     } 
}

function fine(){
	if (($("#mode").val() == "view") && $("#agreementno").val()!="") {
 $('#window1').jqxWindow('open');
    menuContent('trafficFines.jsp?docnovals='+document.getElementById("agreementno").value, $('#window1'));         
	}

	   else {
	    	      $.messager.alert('Message','Select a Document....!','warning');
	    	      return false;
	    	     } 
	}

function account(){
	if (($("#mode").val() == "view") && $("#agreementno").val()!="") {
 $('#window1').jqxWindow('open');
    menuContent('accountsmainForm.jsp?docnovals='+document.getElementById("agreementno").value, $('#window1')); 
	}

	   else {
	    	      $.messager.alert('Message','Select a Document....!','warning');
	    	      return false;
	    	     } 
}

function closing(){
	//alert($("#mode").val());
	if (($("#mode").val() == "view") && $("#agreementno").val()!="") {
 	   var url=document.URL;
        var reurl=url.split("saveRentalClose");
        //$("#docno").prop("disabled", false);                

        var win= window.open(reurl[0]+"printRAClosingSummary?docno="+document.getElementById("agreementno").value,"_blank","top=85,left=150,Width=1020,Height=600,location=no,scrollbars=no,toolbar=yes");
 	   win.focus();
 	   } 
 	  
 	   else {
	    	      $.messager.alert('Message','Select a Document....!','warning');
	    	      return false;
	    	     } 
}

function getAgmt(event){
	
	  /*  $('#gridRaSearch').jqxGrid('clear');
  	 $("#gridRaSearch").jqxGrid("addrow", null, {}); */
	if(document.getElementById("mode").value=='A'){
  	 if(document.getElementById("cmbagmtbranch").value==""){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Agreement Branch is Mandatory";
		return false;
	}
  	 var x= event.keyCode;
     if(x==114){
    	 
 	    $('#agmtnowindow').jqxWindow('open');
		$('#agmtnowindow').jqxWindow('focus');
		 agmtnoSearchContent('agmtnoSearch.jsp?', $('#agmtnowindow'));
     }
     else{
      }
	}
}
function getChauffer(event){
	 var x= event.keyCode;
     if(x==114){
    	   $('#collectionWindow').jqxWindow('open');
   		$('#collectionWindow').jqxWindow('focus');
   		 collectSearchContent('collectSearch.jsp', $('#collectionWindow'));
     }
     else{
      }
}
function getCheckin(event){
	 var x= event.keyCode;
    if(x==114){
    	 $('#checkinWindow').jqxWindow('open');
 		$('#checkinWindow').jqxWindow('focus');
 		 checkinSearchContent('checkinGrid.jsp?', $('#checkinWindow'));
    }
    else{
     }
}
function getRentalAgent(event){
	 var x= event.keyCode;
   if(x==114){
   	 $('#rentalAgentWindow').jqxWindow('open');
		$('#rentalAgentWindow').jqxWindow('focus');
		rentalSearchContent('rentalAgentGrid.jsp?', $('#rentalAgentWindow'));
   }
   else{
    }
}
 function checkConvertion(){
		
		$("#tarifreferencegrid").jqxGrid({ disabled: true});
	
	
}
 function agmtnoSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#agmtnowindow').jqxWindow('setContent', data);

}); 
}
 function checkinSearchContent(url) {
	    //alert(url);
	      $.get(url).done(function (data) {
	//alert(data);
	    $('#checkinWindow').jqxWindow('setContent', data);

	}); 
	}
 function rentalSearchContent(url) {
	    //alert(url);
	      $.get(url).done(function (data) {
	//alert(data);
	    $('#rentalAgentWindow').jqxWindow('setContent', data);

	}); 
	}
function collectSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#collectionWindow').jqxWindow('setContent', data);

}); 
}
function setCollection(){
	if(document.getElementById("chkcollection").checked==true){
		document.getElementById("chauffer").disabled=false;
		document.getElementById("collectchg").disabled=false;
		document.getElementById("collectkm").disabled=false;
		document.getElementById("cmbcollectfuel").disabled=false;
		$('#collectdate').jqxDateTimeInput({ disabled: false});
		$('#collecttime').jqxDateTimeInput({ disabled: false});
		document.getElementById("hidchkcollection").value=1;
	}
	else if(document.getElementById("chkcollection").checked==false){
		document.getElementById("chauffer").disabled=true;
		document.getElementById("collectchg").disabled=true;
		document.getElementById("collectkm").disabled=true;
		document.getElementById("cmbcollectfuel").disabled=true;
		$('#collectdate').jqxDateTimeInput({ disabled: true});
		$('#collecttime').jqxDateTimeInput({ disabled: true});
		document.getElementById("hidchkcollection").value=0;
	}
}

	function getConvertion(){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				 var items=x.responseText.trim();
				//alert("Response items"+items);
					if(items=='noconvert'){
		
						document.getElementById("referencefield").style.display="none";
		
					}
			else {
				
			}
			}
		}
		x.open("GET", "getConvertion.jsp", true);
		x.send();
	}

	function funReadOnly(){
		 setCollection();
		$('#frmRentalClose input').attr('readonly',true);
		$('#frmRentalClose select').attr('disabled',true);
		 $('#closedate').jqxDateTimeInput({ disabled: true});
		 $('#indate').jqxDateTimeInput({ disabled: true});
		 $('#collectdate').jqxDateTimeInput({ disabled: true});
		 $('#intime').jqxDateTimeInput({ disabled: true});
		 $('#collecttime').jqxDateTimeInput({ disabled: true});
		 $('#tarifreferencegrid').jqxGrid({ disabled: true});
		  $('#totalgrid').jqxGrid({ disabled: true});
		   $('#trafficGrid').jqxGrid({ disabled: true});
		   $('#tarifagmtgrid').jqxGrid({ disabled: true});
		    $('#calculationgrid').jqxGrid({ disabled: true});
		   
/* 		getCheckin();
		getRentalAgent(); */
	}
	function funNotify(){

		if(document.getElementById("agreementno").value==""){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Please select an Agreement";
    		return false;
		}
		
		if(document.getElementById("cmbcloseloc").value==""){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Please select Close Location";
			document.getElementById("cmbcloseloc").focus();
    		return false;
		}
		var docdateval=funDateInPeriod($('#closedate').jqxDateTimeInput('getDate'));
		if(docdateval==0){
			$('#closedate').jqxDateTimeInput('focus');
			return false;
		}
		
		if($('#indate').jqxDateTimeInput('getDate')==null){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="In Date is Mandatory";
    		return false;
    	}
		var indateval=funDateInPeriod($('#indate').jqxDateTimeInput('getDate'));
		if(indateval==0){
			$('#indate').jqxDateTimeInput('focus');
			return false;
		}	
		if($('#intime').jqxDateTimeInput('getDate')==null){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="In Time is Mandatory";
    		return false;
    	}
		if($('#inkm').val()==''){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="In Km is Mandatory";
    		return false;
    	}
    	if(document.getElementById("chkcollection").checked==true){
    		if(document.getElementById("chauffer").value==""){
    			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="Driver is Mandatory";
    			return false;
    		}
    		if(document.getElementById("collectchg").value==""){
    			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="Collection Charge is Mandatory";
    			return false;
    		}
    		if($('#collectdate').jqxDateTimeInput('getDate')==null){
    			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="Collection Date cannot be Empty";
    			return false;
    		}
    		var collectdateval=funDateInPeriod($('#collectdate').jqxDateTimeInput('getDate'));
    		if(collectdateval==0){
    			$('#collectdate').jqxDateTimeInput('focus');
    			return false;
    		}
    		if($('#collecttime').jqxDateTimeInput('getDate')==null){
    			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="Collection Time is Mandatory";
        		return false;
        	}
    		if(document.getElementById("collectkm").value==""){
    			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="Collection Km is Mandatory";
        		return false;
    		}
    		var collectdate=$('#collectdate').jqxDateTimeInput('getDate');
    		var indate=$('#indate').jqxDateTimeInput('getDate');
    		var collecttime=$('#collecttime').jqxDateTimeInput('getDate');
    		var intime=$('#intime').jqxDateTimeInput('getDate');
    		collectdate.setHours(0,0,0,0);
    		indate.setHours(0,0,0,0);
    		var inkm=parseFloat(document.getElementById("inkm").value);
    		var collectkm=parseFloat(document.getElementById("collectkm").value);
    		if(indate<collectdate){
    			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="In Date cannot be less than Collection Date";
    			return false;
    		}
    		if(indate-collectdate==0){
    			if(intime.getHours()<collecttime.getHours()){
    				document.getElementById("errormsg").innerText="";
    				document.getElementById("errormsg").innerText="In Time cannot be less than Collection Time";
    				return false;
    			}
    			if(intime.getHours()==collecttime.getHours()){
    				if(intime.getMinutes()<collecttime.getMinutes()){
    					document.getElementById("errormsg").innerText="";
    					document.getElementById("errormsg").innerText="In Time cannot be less than Collection Time";
    					return false;
    				}
    				
    			}
    		}
    		if(inkm<collectkm){
    			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="In Km cannot be less than Collection Km";
    			return false;
    		}
    	}
		if(document.getElementById("cmbinfuel").value==""){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="In Fuel is Mandatory";
			return false;
		}
		if(document.getElementById("checkin").value==""){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Check In is Mandatory";
			return false;
		}
		
		
	/* 	if(typeof($("#totalgrid").jqxGrid("getcellvalue",0,"rate"))=="undefined" || $("#totalgrid").jqxGrid("getcellvalue",0,"rate")==""){
			
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Please Process";
			return 0;
		}
		if($('#calculationgrid').jqxGrid('getcellvalue',0,'description')=='' || typeof($('#calculationgrid').jqxGrid('getcellvalue',0,'description'))=='undefined'){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Please Calculate";
			return 0;
		} */

		
		var rows = $("#totalgrid").jqxGrid('getrows');
		//alert(rows);
		if(rows[0].rentaltype=="undefined" || rows[0].rentaltype==""){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Please Process";
			return 0;	
		}
    	$('#gridlength').val(rows.length);
    		//alert($('#gridlength').val());
    		for(var i=0 ; i < rows.length ; i++){
			//	var myvar = rows[i].tarif; 
				newTextBox = $(document.createElement("input"))
			    .attr("type", "dil")
			    .attr("id", "test"+i)
			    .attr("name", "test"+i)
			    .attr("hidden", "true");
			
				newTextBox.val(rows[i].rentaltype+"::"+rows[i].rate+"::"+rows[i].cdw+"::"+rows[i].pai+"::"+rows[i].cdw1+"::"+rows[i].pai1+"::"+rows[i].gps+"::"+rows[i].babyseater+"::"+rows[i].cooler+"::"+rows[i].exkmrte+"::"+rows[i].exhrchg+"::"+rows[i].chaufchg);
			
			newTextBox.appendTo('form');
			
				//alert("ddddd"+$("#test"+i).val());
			}
    		var rowscalc = $("#calculationgrid").jqxGrid('getrows');
    		//alert(rows);
    		if(rowscalc.length>0){
			if(rowscalc[0].description=="undefined" || rowscalc[0].description==""){
    			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="Please Calculate";
    			return 0;
    			
    		}
			}
    		document.getElementById("errormsg").innerText="";
        	$('#calcgridlength').val(rowscalc.length);
        		//alert($('#gridlength').val());
        		for(var i=0 ; i < rowscalc.length ; i++){
    			//	var myvar = rows[i].tarif; 
    				newTextBox = $(document.createElement("input"))
    			    .attr("type", "dil")
    			    .attr("id", "testcalc"+i)
    			    .attr("name", "testcalc"+i)
    			    .attr("hidden", "true");
    				  var summaryData= $("#calculationgrid").jqxGrid('getcolumnaggregateddata', 'creditnote', ['sum'],true);
                      document.getElementById("creditnotesum").value=summaryData.sum;
    				//newTextBox.val(rows[i].idno+"::"+rows[i].account+"::"+rows[i].description+"::"+rows[i].qty+"::"+rows[i].rate+"::"+rows[i].total);
    				newTextBox.val(rowscalc[i].idno+"::"+rowscalc[i].acno+"::"+rowscalc[i].description+"::"+rowscalc[i].qty+"::"+rowscalc[i].invoiced+"::"+rowscalc[i].invoice+"::"+rowscalc[i].creditnote+"::"+rowscalc[i].salamount+"::"+rowscalc[i].salikrate+"::"+rowscalc[i].saliksrvc+"::"+rowscalc[i].salikamt+"::"+rowscalc[i].trafficamt+"::"+rowscalc[i].trafficsrvc);
    			
    			newTextBox.appendTo('form');
    			
    				//alert("ddddd"+$("#testcalc"+i).val());
    			}
        	
        	document.getElementById("errormsg").innerText="";
		return 1;
	}
	
	function funRemoveReadOnly(){
		$('#frmRentalClose input').attr('readonly',false);
		$('#frmRentalClose select').attr('disabled',false);
		 $('#closedate').jqxDateTimeInput({ disabled: false});
		 $('#indate').jqxDateTimeInput({ disabled:false});
		 $('#intime').jqxDateTimeInput({ disabled: false});
		 $('#useddays').attr('readonly',true);
		 $('#usedhours').attr('readonly',true);
		 $('#totalkm').attr('readonly',true);
		 $('#excesskm').attr('readonly',true);
		 $('#agreementno').attr('readonly',true);
		 $('#vehicle').attr('readonly',true);
		 $('#clientid').attr('readonly',true);
		 $('#chauffer').attr('readonly',true);
		 $('#client').attr('readonly',true);
		 $('#docno').attr('readonly',true);
		 $('#checkin').attr('readonly',true);
		 $('#rentalagent').attr('readonly',true);
		 $('#tarifreferencegrid').jqxGrid({ disabled: false});
		  $('#totalgrid').jqxGrid({ disabled: false});
		   $('#trafficGrid').jqxGrid({ disabled:false});
		   $('#tarifagmtgrid').jqxGrid({ disabled: false});
		    $('#calculationgrid').jqxGrid({ disabled: false});
		    if(document.getElementById("mode").value=='A'){
		    	 $('#tarifreferencegrid').jqxGrid('clear');
		    	 $("#tarifreferencegrid").jqxGrid("addrow", null, {});
		    	 $('#totalgrid').jqxGrid('clear');
		    	 $("#totalgrid").jqxGrid("addrow", null, {});
		    	 $('#trafficGrid').jqxGrid('clear');
		    	 $("#trafficGrid").jqxGrid("addrow", null, {});
		    	 $('#tarifagmtgrid').jqxGrid('clear');
		    	 $("#tarifagmtgrid").jqxGrid("addrow", null, {});
		    	 $('#calculationgrid').jqxGrid('clear');
		    	 $("#calculationgrid").jqxGrid("addrow", null, {});
		    	 $('#btnprocess').attr('disabled',false);
				  $('#btncalculate').attr('disabled',false);
				  resetvalues();
		    	
		    }
			if(document.getElementById("brchName").value!=""){
				getAgmtLocation();
			}
			if(document.getElementById("mode").value!="A"){
				document.getElementById("btnprocess").disabled=true;
				document.getElementById("btncalculate").disabled=true;
			}
		    setCollection();
		    
	}
	function funChkButton(){
		
	}
	  function isNumber(evt,id) {
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
		document.getElementById("agreementno").focus();
	}

	function funChecking(){
	//Mandatory Validation for calculation starts here
		var docdateval=funDateInPeriod($('#closedate').jqxDateTimeInput('getDate'));
		if(docdateval==0){
			$('#closedate').jqxDateTimeInput('focus');
			return false;
		}
		
		if($('#indate').jqxDateTimeInput('getDate')==null){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="In Date is Mandatory";
    		return false;
    	}
		var indateval=funDateInPeriod($('#indate').jqxDateTimeInput('getDate'));
		if(indateval==0){
			$('#indate').jqxDateTimeInput('focus');
			return false;
		}	
		if($('#intime').jqxDateTimeInput('getDate')==null){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="In Time is Mandatory";
    		return false;
    	}
    	if(document.getElementById("chkcollection").checked==true){
    		if(document.getElementById("chauffer").value==""){
    			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="Driver is Mandatory";
    			return false;
    		}
    		if(document.getElementById("collectchg").value==""){
    			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="Collection Charge is Mandatory";
    			return false;
    		}
    		if($('#collectdate').jqxDateTimeInput('getDate')==null){
    			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="Collection Date cannot be Empty";
    			return false;
    		}
    		var collectdateval=funDateInPeriod($('#collectdate').jqxDateTimeInput('getDate'));
    		if(collectdateval==0){
    			$('#collectdate').jqxDateTimeInput('focus');
    			return false;
    		}
    		if($('#collecttime').jqxDateTimeInput('getDate')==null){
    			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="Collection Time is Mandatory";
        		return false;
        	}
    		if(document.getElementById("collectkm").value==""){
    			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="Collection Km is Mandatory";
        		return false;
    		}
    		var collectdate=$('#collectdate').jqxDateTimeInput('getDate');
    		var indate=$('#indate').jqxDateTimeInput('getDate');
    		var collecttime=$('#collecttime').jqxDateTimeInput('getDate');
    		var intime=$('#intime').jqxDateTimeInput('getDate');
    		collectdate.setHours(0,0,0,0);
    		indate.setHours(0,0,0,0);
    		var inkm=parseFloat(document.getElementById("inkm").value);
    		var collectkm=parseFloat(document.getElementById("collectkm").value);
    		if(indate<collectdate){
    			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="In Date cannot be less than Collection Date";
    			return false;
    		}
    		if(indate-collectdate==0){
    			if(intime.getHours()<collecttime.getHours()){
    				document.getElementById("errormsg").innerText="";
    				document.getElementById("errormsg").innerText="In Time cannot be less than Collection Time";
    				return false;
    			}
    			if(intime.getHours()==collecttime.getHours()){
    				if(intime.getMinutes()<collecttime.getMinutes()){
    					document.getElementById("errormsg").innerText="";
    					document.getElementById("errormsg").innerText="In Time cannot be less than Collection Time";
    					return false;
    				}
    				
    			}
    		}
    		if(inkm<collectkm){
    			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="In Km cannot be less than Collection Km";
    			return false;
    		}
    	}
		if(document.getElementById("cmbinfuel").value==""){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="In Fuel is Mandatory";
			return false;
		}
		if(document.getElementById("checkin").value==""){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Check In is Mandatory";
			return false;
		}
		
		
		//Mandatory validations ends here.
		document.getElementById("errormsg").innerText="";
		checkFuel();
		
		 
		
	}
	
	function checkFuel(){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
				
				if(parseInt(items)==1){
					
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="Please Configure Valid Fuel Rate";
					
					
					return false;
				}
				else{
					
					checkAgmtDelivery();//Calling Ajax Method for calculation	
				}
				
		}
	}
		x.open("GET", "checkFuel.jsp?indate="+$('#indate').jqxDateTimeInput('val'), true);
		x.send();
	}
	function funProcess(){
		//Method for calculation and displaying the data in the Total grid// 
		if(document.getElementById("errormsg").innerText!=""){
			return false;
		}
		var useddays=document.getElementById("useddays").value;
		var usedhours=document.getElementById("usedhours").value;
		var totalkm=document.getElementById("totalkm").value;
		var excesskm=document.getElementById("excesskm").value;
		var agmtno=document.getElementById("agreementno").value;
		var rentaltype=$('#tarifagmtgrid').jqxGrid('getcellvalue', 0, "rentaltype");
		var agmtdate=$('#datehidden').jqxDateTimeInput('getText');
		var closedate=$('#closedatehidden').jqxDateTimeInput('getText');
		var closeinvdate=$('#closeinvdate').jqxDateTimeInput('val');
		$('#totaldiv').load("totalGrid.jsp?useddays="+useddays+"&usedhours="+usedhours+"&totalkm="+totalkm+"&excesskm="+excesskm+"&agmtno="+agmtno+"&rentaltype="+rentaltype+"&agmtdate="+agmtdate+"&closedate="+closedate+"&temp=1&closecalflag="+$('#closecalflag').val()+"&closeinvdate="+closeinvdate);
	/* } */
	}
	
	 function checkAgmtDelivery(){
		 //Ajax Method for date,time,km,fuel Calculation 
		
		 var coldate=null;
		 var coltime="";
		 var colkm=0.0,colfuel=0.0;
		 document.getElementById("hidchkcollection").value="0";
		 if(document.getElementById("chkcollection").checked==true){
			 document.getElementById("hidchkcollection").value="1";
			 colkm=document.getElementById("collectkm").value;
			 colfuel=document.getElementById("cmbcollectfuel").value;
			 coltime=$('#collecttime').jqxDateTimeInput('getText');
			 coldate=$('#collectdate').jqxDateTimeInput('getText');
		 }
		 var temprentaltype= $("#tarifagmtgrid").jqxGrid("getcellvalue",0,"rentaltype");
		 //alert("Inside checkAgmtDelivery");
		 var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('***');
				document.getElementById("useddays").value="";
				document.getElementById("usedhours").value="";
				document.getElementById("totalkm").value="";
				document.getElementById("totalfuel").value="";
				document.getElementById("agmtkm").value="";
				
				 $('#totalgrid').jqxGrid('clear');
		    	 $("#totalgrid").jqxGrid("addrow", null, {});
		    	 $('#calculationgrid').jqxGrid('clear');
		    	 $("#calculationgrid").jqxGrid("addrow", null, {});
		    	 document.getElementById("excesskm").value="";
		    	 //alert($("#datehidden").jqxDateTimeInput('val'));
				//alert($("#datehidden").jqxDateTimeInput('val'));
				if(items[5].trim()=='1'){
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="In KM cannot be less than Out KM";
					return false;
				}
				if(items[6].trim()=='1'){
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="In Date cannot be less than Out Date";
					return false;
				}
				if(items[7].trim()=='1'){
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="In Time cannot be less than Out Time";
					return false;
				}
				if(items[11].trim()=='1'){
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="In Km cannot be less than Collection Km";
					return false;
				}
				if(items[12].trim()=='1'){
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="Agreement Delivery is not Completed";
					return false;
				}
				if(items[9].trim()=='1'){
					
					 $.messager.alert('Warning','Invoice has been done till '+items[10].trim());
					
				}
				if(items[13].trim()=='1'){
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="Invoice's are Pending";
					return false;
				}
				if(items[17].trim()!='1'){
					document.getElementById("lblinvoicedone").innerText="Invoice has been done till "+items[10].trim();	
				}
				if(items[18].trim()=='1'){
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="Vehicle In Date cannot be less than last out date";
					return false;
				}
				
				
				document.getElementById("errormsg").innerText="";
				//alert("finish");
				document.getElementById("fuel2").value=items[19].trim();
				document.getElementById("delcheckstatus").value=items[12].trim();
				document.getElementById("useddays").value=items[0];
				document.getElementById("usedhours").value=items[1];
				document.getElementById("totalkm").value=items[2];
				document.getElementById("totalfuel").value=items[3];
				document.getElementById("agmtkm").value=items[4];
				$("#datehidden").jqxDateTimeInput('val',items[8].trim());
				$("#closedatehidden").jqxDateTimeInput('val',items[14].trim());
				document.getElementById("closecalflag").value=items[15].trim();
				$("#closeinvdate").jqxDateTimeInput('val',items[16].trim());
				/* if(document.getElementById("delcheckstatus").value=="1"){
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="Agreement Delivery is not Completed";
					return false;
				} */
				funProcess();
			//alert(items[0]+"====="+items[1]+"====="+items[2]+"======"+items[3]);
			/* return "2"; */
		}
	}
		x.open("GET", "checkDeliverykm.jsp?delstatus="+document.getElementById("delstatus").value+"&agmtno="+document.getElementById("agreementno").value+"&collectkm="+colkm+"&inkm="+document.getElementById("inkm").value+"&indate="+$('#indate').jqxDateTimeInput('getText')+"&infuel="+document.getElementById("cmbinfuel").value+"&collectfuel="+colfuel+"&intime="+$('#intime').jqxDateTimeInput('getText')+"&collecttime="+coltime+"&collectdate="+coldate+"&hidchkcollection="+document.getElementById("hidchkcollection").value+"&rentaltype="+temprentaltype, true);
		x.send();
	 }
	function funCalculate(){
		//Method for calculating and displaying final amount and data in the Calculation grid
		if(document.getElementById("agreementno").value==''){
			document.getElementById("errormsg").innerText="Please Enter Necessary Details";
			return false;
		}
		var temp=$('#totalgrid').jqxGrid('getcellvalue', 0, "rate");
		//alert(temp);
		 if((temp=='undefined')||(temp==null)){
			//alert(temp);
			document.getElementById("errormsg").innerText="Please process again, total is not calculated";
			return false;
		}
		
		document.getElementById("errormsg").innerText="";
		var agmtno=document.getElementById("agreementno").value;
		var tarif=$('#totalgrid').jqxGrid('getcellvalue', 2, "rate");
		var cdwtotal=0;
		cdwtotal=$('#totalgrid').jqxGrid('getcellvalue', 2, "cdw");
		cdwtotal=cdwtotal+$('#totalgrid').jqxGrid('getcellvalue', 2, "pai");
		cdwtotal=cdwtotal+$('#totalgrid').jqxGrid('getcellvalue', 2, "cdw1");
		cdwtotal=cdwtotal+$('#totalgrid').jqxGrid('getcellvalue', 2, "pai1");
		var acc=0;
		acc=$('#totalgrid').jqxGrid('getcellvalue', 2, "gps");
		acc=acc+$('#totalgrid').jqxGrid('getcellvalue', 2, "babyseater");
		acc=acc+$('#totalgrid').jqxGrid('getcellvalue', 2, "cooler");
		var chauffer=0;
		chauffer=$('#totalgrid').jqxGrid('getcellvalue', 2, "chaufchg");
		var excesskmchg=0.0,excesshrchg=0.0;
		excesskmchg=$('#totalgrid').jqxGrid('getcellvalue', 2, "exkmrte");
		excesshrchg=$('#totalgrid').jqxGrid('getcellvalue', 2, "exhrchg");
		var clientid=document.getElementById("clientid").value;
		var fuel=document.getElementById("totalfuel").value;
		var agmtdate=$('#datehidden').jqxDateTimeInput('getText');
		var closedate=$('#closedatehidden').jqxDateTimeInput('getText');
		var closeinvdate=$('#closeinvdate').jqxDateTimeInput('val');
		var calctype=document.getElementById("calctype").value;
		//alert("===="+agmtno+":"+tarif+":"+cdwtotal+":"+":"+acc+":"+chauffer+":"+excesskmchg+":"+excesshrchg+"===");
	$('#calcdiv').load("calculationGrid.jsp?agmtno="+agmtno+"&tarif="+tarif+"&cdwtotal="+cdwtotal+"&acctotal="+acc+"&chauffer="+chauffer+"&excesskmchg="+excesskmchg+"&excesshrchg="+excesshrchg+"&temp=1&usedhours="+document.getElementById("usedhours").value+"&clientid="+clientid+"&fuel="+fuel+"&deliverychg="+document.getElementById("deliverychg").value+"&collectchg="+document.getElementById("collectchg").value+"&outdate="+agmtdate+"&indate="+closedate+"&cmbinfuel="+document.getElementById("fuel2").value+"&exkm="+document.getElementById("excesskm").value+"&closeinvdate="+closeinvdate+"&closecalflag="+$('#closecalflag').val()+"&calctype="+calctype);
	}
	
	function checkCollection(){
		if(document.getElementById("hidchkcollection").value=="1"){
			document.getElementById("chkcollection").checked=true;
			document.getElementById("chauffer").disabled=false;
			document.getElementById("collectchg").disabled=false;
			document.getElementById("collectkm").disabled=false;
			document.getElementById("cmbcollectfuel").disabled=false;
			$('#collectdate').jqxDateTimeInput({ disabled: false});
			$('#collecttime').jqxDateTimeInput({ disabled: false});
		}
		else{
			document.getElementById("chkcollection").checked=false;
			document.getElementById("chauffer").disabled=true;
			document.getElementById("collectchg").disabled=true;
			document.getElementById("collectkm").disabled=true;
			document.getElementById("cmbcollectfuel").disabled=true;
			$('#collectdate').jqxDateTimeInput({ disabled: true});
			$('#collecttime').jqxDateTimeInput({ disabled: true});
		}
	}
	function setValues(){
		 //document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		// checkCollection();
		if(document.getElementById("mode").value!="A"){
			document.getElementById("btnprocess").disabled=true;
			document.getElementById("btncalculate").disabled=true;
		}
		 funSetlabel();
		 if($('#msg').val()!=""){
  		   $.messager.alert('Message',$('#msg').val());
  		  }
	
		 if($('#hidcollecttime').val()){
				$("#collecttime").jqxDateTimeInput('val', $('#hidcollecttime').val());
			}
		 if($('#hidintime').val()){
				$("#intime").jqxDateTimeInput('val', $('#hidintime').val());
			}
			if ($('#hidcmbcollectfuel').val() != null) {
				$('#cmbcollectfuel').val($('#hidcmbcollectfuel').val());
			}
		
			if ($('#hidcmbinfuel').val() != null) {
				$('#cmbinfuel').val($('#hidcmbinfuel').val());
			}
			
		
			if((document.getElementById("agreementno").value!='')&&(document.getElementById("docno").value!='')){

				$("#agmttarifdiv").load("agreementTarifGrid.jsp?agmt="+document.getElementById("agreementno").value);
				$('#totaldiv').load("totalGrid.jsp?agmtno="+document.getElementById("agreementno").value+"&temp=2");
				$("#trafficdiv").load("trafficGrid.jsp?id="+document.getElementById("agreementno").value);
				$('#calcdiv').load("calculationGrid.jsp?agmtno="+document.getElementById("agreementno").value+"&temp=2");
				$('#referencetarifdiv').load("referenceTarifGrid.jsp?id="+document.getElementById("agreementno").value);
			}
}
	//Master Document Search
	function funSearchLoad(){
		changeContent('masterSearch.jsp', $('#window'));
	}
	
			function getReplace(){
				//Function for Displaying Replaced Vehicle in the Agreement
				 $('#agmtnowindow').jqxWindow('open');
					$('#agmtnowindow').jqxWindow('focus');
					 agmtnoSearchContent('vehReplaceGrid.jsp?docno='+document.getElementById("agreementno").value, $('#agmtnowindow'));
			}
			function funPrintBtn() {
				//Function for Print the Agreement
		    	if(document.getElementById("docno").value=='' || document.getElementById("docno").value=='0'){
		    		 $.messager.alert('Warning','Select a Document');
		    		 return false;
		    	}
		    	var url=document.URL;
		    	  var reurl=url.split("saveRentalClose");
		    	    	var win= window.open(reurl[0]+"printRentalClose?docno="+document.getElementById("agreementno").value+"&formdetailcode=RAC","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
		    	win.focus();
		    	 }

			
			
			function resetvalues(){
				$("#indate").jqxDateTimeInput('setDate', null);
				$("#intime").jqxDateTimeInput('setDate', null);		
				$("#collectdate").jqxDateTimeInput('setDate', null);
				$("#collecttime").jqxDateTimeInput('setDate', null);
				document.getElementById("chkcollection").checked=false;
				document.getElementById("agreementno").value="";
				document.getElementById("vehicle").value="";
				document.getElementById("client").value="";
				document.getElementById("clientid").value="";
				document.getElementById("description").value="";
				document.getElementById("chauffer").value="";
				document.getElementById("collectchg").value="";
				document.getElementById("collectkm").value="";
				$('#cmbcollectfuel').val('');
				document.getElementById("rentalagent").value="";
				document.getElementById("checkin").value="";
				document.getElementById("useddays").value="";
				document.getElementById("usedhours").value="";
				document.getElementById("totalkm").value="";
				document.getElementById("excesskm").value="";
				document.getElementById("inkm").value="";
				document.getElementById("lblinvoicedone").innerText="";
				$('#cmbinfuel').val('');
				$('#tarifreferencegrid').jqxGrid('clear');
		    	 $("#tarifreferencegrid").jqxGrid("addrow", null, {});
		    	 $('#totalgrid').jqxGrid('clear');
		    	 $("#totalgrid").jqxGrid("addrow", null, {});
		    	 $('#trafficGrid').jqxGrid('clear');
		    	 $("#trafficGrid").jqxGrid("addrow", null, {});
		    	 $('#tarifagmtgrid').jqxGrid('clear');
		    	 $("#tarifagmtgrid").jqxGrid("addrow", null, {});
		    	 $('#calculationgrid').jqxGrid('clear');
		    	 $("#calculationgrid").jqxGrid("addrow", null, {});
		    	 
		    	 setCollection();
		    	 
			}
			function getAgmtLocation(){
				var value=document.getElementById("brchName").value;
				var x = new XMLHttpRequest();
				x.onreadystatechange = function() {
					if (x.readyState == 4 && x.status == 200) {
						var items = x.responseText;
						items = items.split('***');
						var locItems = items[0].split(",");
						var locIdItems = items[1].split(",");
						var optionsloc = '<option value="">--Select--</option>';
						for (var i = 0; i < locItems.length; i++) {
							optionsloc += '<option value="' + locIdItems[i] + '">'
									+ locItems[i] + '</option>';
						}
						$("select#cmbcloseloc").html(optionsloc);
						
						if ($('#hidcmbcloseloc').val() != null) {
							$('#cmbcloseloc').val($('#hidcmbcloseloc').val());
						}
					} else {
					}
				}
				x.open("GET", "getLocation.jsp?branch="+value, true);
				x.send();			
			}
			
			
			function getTestLocation(){
				var x = new XMLHttpRequest();
				x.onreadystatechange = function() {
					if (x.readyState == 4 && x.status == 200) {
						var items = x.responseText;
						items = items.split('***');
						var locItems = items[0].split(",");
						var locIdItems = items[1].split(",");
						var optionsloc = '<option value="">--Select--</option>';
						for (var i = 0; i < locItems.length; i++) {
							optionsloc += '<option value="' + locIdItems[i] + '">'
									+ locItems[i] + '</option>';
						}
						$("select#cmbcloseloc").html(optionsloc);
						
						 if ($('#hidcmbcloseloc').val() != null) {
							$('#cmbcloseloc').val($('#hidcmbcloseloc').val());
						} 
					} else {
					}
				}
				x.open("GET", "getTestLocation.jsp", true);
				x.send();
			}
			
			
</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmRentalClose" action="saveRentalClose" autocomplete="off">
	<%-- <script>
			window.parent.formName.value="Rental Agreement Close";
			window.parent.formCode.value="RAC";
	</script> --%>
	<jsp:include page="../../../../header.jsp" />
	<br/> 
<div class='hidden-scrollbar'>
<table width="100%">
  <tr>
    <td colspan="2"><fieldset>
      <table width="100%">
        <tr>
          <td width="4%" align="right">Branch</td>
          <td width="8%" align="left"><select name="cmbagmtbranch" id="cmbagmtbranch" value='<s:property value="cmbagmtbranch"/>' style="width:100%;"><option value="">--Select--</option></select></td>
          
          <td width="6%" align="right">Agmt No</td>
          <td width="8%" align="left"><input type="text" name="vocno" id="vocno" value='<s:property value="vocno"/>' onKeyDown="getAgmt(event);" placeholder="Press F3 to Search" ></td>
          <td width="5%" align="right">Vehicle</td>
          <td width="47%" align="left"><input type="text" name="vehicle" id="vehicle" value='<s:property value="vehicle"/>' style="width:98.8%;"></td>
          <td width="6%" align="right">Doc No</td>
          <td width="8%" align="left"><input type="text" name="voucherno" id="voucherno" value='<s:property value="voucherno"/>' readonly></td>
          <td width="8%" rowspan="2" align="left"><div id='jqxMenuMore' title="More" align="center" style='visibility: hidden;'>
        <ul>
         <li><a href="#trafficFines" onclick="fine();">Traffic Fines</a></li>
            <li><a href="#documents" onclick="replacement();">Replacement</a></li>
            <li><a href="#history" onclick="account();">Account Statement</a></li>   
             <li><a href="#close" onclick="closing();">Closing Summary</a></li>                  
        </ul>
     </div></td>
        </tr>
        <tr>
          <td align="right">Client</td>
          <td align="left"><input type="text" name="clientid" id="clientid" value='<s:property value="clientid"/>' ></td>
          <td colspan="4" align="left"><input type="text" name="client" id="client" value='<s:property value="client"/>' style="width:99%;"></td>
          <input type="hidden" name="txtaccno" id="txtaccno" value='<s:property value="txtaccno"/>'>
          <td align="right">Date</td>
          <td align="left"><div id="closedate" name="closedate" value='<s:property value="closedate"/>'></div></td>
          <input type="hidden" name="hidclosedate" id="hidclosedate" value='<s:property value="hidclosedate"/>'>
        </tr>
        <tr>
          <td align="right">Description</td>
          <td colspan="5" align="left"><input type="text" name="description" id="description" value='<s:property value="description"/>' style="width:99%;"></td>
          <td align="right">Location</td>
          <td align="left"><select name="cmbcloseloc" id="cmbcloseloc" value='<s:property value="cmbcloseloc"/>' style="width:100%;" >
            <option value="">--Select--</option>
          </select></td>
          <input type="hidden" name="hidcmbagmtbranch" id="hidcmbagmtbranch" value='<s:property value="hidcmbagmtbranch"/>'>
          <input type="hidden" name="hidcmbcloseloc" id="hidcmbcloseloc" value='<s:property value="hidcmbcloseloc"/>'>
          <td align="left">&nbsp;</td>
        </tr>
      </table>
    </fieldset></td>
  </tr>
  <tr>
    <td colspan="2"><fieldset>
      <legend>In Info</legend>
      <table width="100%">
        <tr>
          <td width="11%" rowspan="2">Collection
            <input type="checkbox" name="chkcollection" id="chkcollection" onchange="setCollection();">
            &nbsp;
            <input type="text" name="chauffer" id="chauffer" value='<s:property value="chauffer"/>' onkeydown="getChauffer(event);" readonly placeholder="Press F3 to Search"><br>
            <input type="text" name="collectchg" id="collectchg" value='<s:property value="collectchg"/>' placeholder="Collection Charge"/>
            </td>
          <input type="hidden" name="hidchkcollection" id="hidchkcollection" value='<s:property value="hidchkcollection"/>'>
          <td width="8%" align="right">Collection Details</td>
          <td width="1%" align="right">KM</td>
          <td width="8%" align="left"><input type="text" name="collectkm" id="collectkm" value='<s:property value="collectkm"/>'></td>
          <td width="2%" align="right">Fuel</td>
          <input type="hidden" name="hidcmbcollectfuel" id="hidcmbcollectfuel" value='<s:property value="hidcmbcollectfuel"/>'>
          <td width="7%" align="left">
          <select name="cmbcollectfuel" id="cmbcollectfuel"><option value="">-Select-</option><option value=0.000>Level 0/8</option><option value=0.125>Level 1/8</option><option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option><option value=0.500>Level 4/8</option>
    <option value=0.625>Level 5/8</option><option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option></select></td>
          <td width="2%" align="right">Date</td>
          <td width="7%" align="left"><div id="collectdate" name="collectdate" value='<s:property value="collectdate"/>'></div></td>
          <input type="hidden" name="hidcollectdate" id="hidcollectdate" value='<s:property value="hidcollectdate"/>'>
          <td width="2%" align="right">Time</td>
          <td width="5%" align="left"><div id="collecttime" name="collecttime" value='<s:property value="collecttime"/>'></div></td>
          <input type="hidden" id="hidcollecttime" name="hidcollecttime" value='<s:property value="hidcollecttime"/>'>
          <td width="5%" align="right">Rental Agent</td>
          <%-- <select name="cmbrentalagent" id="cmbrentalagent" value='<s:property value="cmbrentalagent"/>'>
            <option value="">--Select--</option>
          </select> --%>
          <td width="6%" align="left">
          <input type="text" name="rentalagent" id="rentalagent" value='<s:property value="rentalagent"/>' readonly placeholder="Press F3 to Search" onkeydown="getRentalAgent(event);">
          </td>
          <input type="hidden" name="hidrentalagent" id="hidrentalagent" value='<s:property value="hidrentalagent"/>'>
          <input type="hidden" name="hidcmbcheckin" id="hidcmbcheckin" value='<s:property value="hidcmbcheckin"/>'>
          <td width="7%" align="right">Days Used</td>
          <td width="8%" align="left"><input type="text" name="useddays" id="useddays" value='<s:property value="useddays"/>' style="width:60%;"  readonly></td>
          <td width="5%" align="right">Hours Used</td>
          <td width="10%" align="left"><input type="text" name="usedhours" id="usedhours" value='<s:property value="usedhours"/>' readonly style="width:60%;" ></td>
          <td width="6%" align="center" rowspan="2"> <button type="button" id="btnprocess" title="Process"  style="border:none;background:none;" onclick="funChecking();">
							<img alt="Process" src="<%=contextPath%>/icons/process2.png" width="30" height="30"></button></td>
        </tr>
        <tr>
          <td align="right">In Details</td>
          <td align="right">KM</td>
          <td align="left"><input type="text" name="inkm" id="inkm" value='<s:property value="inkm"/>' onkeypress="javascript:return isNumber (event,id)"></td>
          <td align="right">Fuel</td>
          <td align="left"><!--<input type="text" name="infuel" id="infuel" value='<s:property value="infuel"/>'>-->
          <select name="cmbinfuel" id="cmbinfuel"><option value="">-Select-</option><option value=0.000>Level 0/8</option><option value=0.125>Level 1/8</option><option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option><option value=0.500>Level 4/8</option>
    <option value=0.625>Level 5/8</option><option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option></select></td>
          <td align="right">Date</td>
          <td align="left"><div id="indate" name="indate" value='<s:property value="indate"/>'></div></td>
          <input type="hidden" name="hidindate" id="hidindate" value='<s:property value="hidindate"/>'>
          <td align="right">Time</td>
          <td align="left"><div id="intime" name="intime" value='<s:property value="intime"/>'></div></td>
          <input type="hidden" name="hidintime" id="hidintime" value='<s:property value="hidintime"/>'>
          <td align="right">Check In</td>
          <%-- <select name="cmbcheckin" id="cmbcheckin" value='<s:property value="cmbcheckin"/>' onchange="checkAgmtDelivery();">
            <option value="">--Select--</option>
          </select> --%>
          <td align="left">
          <input type="text" name="checkin" id="checkin" value='<s:property value="checkin"/>' readonly placeholder="Press F3 to Search" onkeydown="getCheckin(event);">
          </td>
          <input type="hidden" name="hidcheckin" id="hidcheckin" value='<s:property value="hidcheckin"/>'>
          <input type="hidden" name="hidcmbrentalagent" id="hidcmbrentalagent" value='<s:property value="hidcmbrentalagent"/>'>
         <div border="1">
          <td align="right">Total KM</td>
          <td align="left"><input type="text" name="totalkm" id="totalkm" value='<s:property value="totalkm"/>' style="width:60%;"  readonly></td>
          <td align="right">Excess KM</td>
          <td align="left"><input type="text" name="excesskm" id="excesskm" value='<s:property value="excesskm"/>' style="width:60%;" readonly></td>
          <td width="0%" align="left">&nbsp;</td>
         </div>
        </tr>
      </table>
    </fieldset></td>
  </tr>
  <tr>
    <td width="66%"><fieldset>
      
      <table width="100%">
        <tr>
          <td><div id="agmttarifdiv"><jsp:include page="agreementTarifGrid.jsp"></jsp:include></div></td>
        </tr>
      </table>
    </fieldset></td>
    
    
    
    <td width="34%" rowspan="3">
    <center><label name="lblinvoicedone" id="lblinvoicedone" style="color:red;font-weight:bold;font-size:14;"></label>    </center>
    <center><input type="button" name="btncalculate" id="btncalculate" class="myButton" value="Calculate" onclick="funCalculate();"></center>
    <fieldset><legend>Calculation Info
      </legend>
      <table width="100%">
        <tr>
          <td><div id="calcdiv"><jsp:include page="calculationGrid.jsp"></jsp:include></div></td>
          <input type="hidden" name="hidchkconvert" id="hidchkconvert" value='<s:property value="hidchkconvert"/>'>
          </tr>
        </table>
      </fieldset>
    </td>
  </tr>
  <tr id="referencefield">
    <td>
    <fieldset>
      
      <table width="100%">
        <tr>
          <td><div id="referencetarifdiv"><jsp:include page="referenceTarifGrid.jsp"></jsp:include></div></td>
          </tr>
       </table>
    </fieldset></td>
  </tr>
  <tr>
    <td><fieldset><table width="100%">
      <tr>
        <td><div id="totaldiv"><jsp:include page="totalGrid.jsp"></jsp:include></div></td>
        </tr>
      </table>
    </fieldset></td>
    </tr>
  <tr>
    <td><fieldset><table width="100%">
      <tr>
        <td><div id="trafficdiv"><jsp:include page="trafficGrid.jsp"></jsp:include></div></td>
        </tr>
      </table>
    </fieldset></td>
    </tr>
</table>
<br><br><br><br><br><br>
<input type="hidden" name="agmttime" id="agmttime" value='<s:property value="agmttime"/>'>
<input type="hidden" name="agmtdeliverytime" id="agmtdeliverytime" value='<s:property value="agmtdeliverytime"/>'>
<input type="hidden" name="agmtdate" id="agmtdate" value='<s:property value="agmtdate"/>'>
<input type="hidden" name="agmtkm" id="agmtkm" value='<s:property value="agmtkm"/>'>
<input type="hidden" name="agmtfuel" id="agmtfuel" value='<s:property value="agmtfuel"/>'>
<input type="hidden" name="agmtdeliveryfuel" id="agmtdeliveryfuel" value='<s:property value="agmtdeliveryfuel"/>'>
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
<div id="datehidden" name="datehidden" hidden="true"></div> 
<div id="closedatehidden" name="closedatehidden" hidden="true"></div>
<div id="agmtdeliverydate" name="agmtdeliverydate" hidden="true"></div>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
<input type="hidden" name="chaufferid" id="chaufferid" value='<s:property value="chaufferid"/>'>
<input type="hidden" name="agmtdeliverykm" id="agmtdeliverykm" value='<s:property value="agmtdeliverykm"/>'>
<input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
<input type="hidden" name="hidcmbinfuel" id="hidcmbinfuel" value='<s:property value="hidcmbinfuel"/>' >
<input type="hidden" name="totkm" id="totkm" value='<s:property value="totkm"/>' >
<input type="hidden" name="totfuel" id="totfuel" value='<s:property value="totfuel"/>' >
<input type="hidden" name="totalfuel" id="totalfuel" value='<s:property value="totalfuel"/>' >
<input type="hidden" name="calcgridlength" id="calcgridlength" value='<s:property value="calcgridlength"/>' >
<input type="hidden" name="clientacno" id="clientacno" value='<s:property value="clientacno"/>' >
<input type="hidden" name="hidfleet" id="hidfleet" value='<s:property value="hidfleet"/>' >
<input type="hidden" name="creditnotesum" id="creditnotesum" value='<s:property value="creditnotesum"/>' >
<input type="hidden" name="delstatus" id="delstatus" value='<s:property value="delstatus"/>' >
<input type="hidden" name="deliverychg" id="deliverychg" value='<s:property value="deliverychg"/>' >
<input type="hidden" name="tempuseddays" id="tempuseddays" value='<s:property value="tempuseddays"/>' >
<input type="hidden" name="delcheckstatus" id="delcheckstatus" value='<s:property value="delcheckstatus"/>' >
<input type="hidden" name="fuelstatus" id="fuelstatus" value='<s:property value="fuelstatus"/>' >
<input type="hidden" name="closecalflag" id="closecalflag" value='<s:property value="closecalflag"/>' >
<input type="hidden" name="calctype" id="calctype" value='<s:property value="calctype"/>' >
<div name="closeinvdate" id="closeinvdate" value='<s:property value="closeinvdate"/>' hidden="true"></div>
<input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>' readonly>
<input type="hidden" name="fuel2" id="fuel2" value='<s:property value="fuel2"/>' >
<input type="hidden" name="agreementno" id="agreementno" value='<s:property value="agreementno"/>' onkeydown="getAgmt(event);" placeholder="Press F3 to Search"  >
</div>
</form>
<div id="agmtnowindow">
   <div ></div>
</div>
<div id="collectionWindow">
   <div ></div>
</div>
<div id="checkinWindow">
   <div ></div>
</div>
<div id="rentalAgentWindow">
   <div ></div>
</div>
<div id="window1">
   <div ></div>
</div>
</div>
</body>
</html>