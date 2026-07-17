<%@ taglib prefix="s" uri="/struts-tags"%>
<%@page import="java.util.logging.Logger" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
  <% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../includes.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/css/loading.css">

<script type="text/javascript">
	$(document).ready(function() {
		 $("#btnClose").hide();$("#status").hide();$("#btnSave").hide();$("#btnCancel").hide();$("#btnApproval").hide();$("#btnCreate").hide();
		 $("#btnEdit").hide();$("#btnPrint").hide();$("#btnExcel").hide();$("#btnDelete").hide();$("#btnSearch").hide();$("#btnAttach").hide();  
		 $("#btnGuideLine").hide();$("#btnSendmail").hide();
		
		 $("#jqxStartDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd MMM yyyy"});
		 $("#jqxEndDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd MMM yyyy"});
		 
		 $('#unameWindow').jqxWindow({width: '30%', height: '40%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
	     $('#unameWindow').jqxWindow('close');
	     
	     $('#filenameWindow').jqxWindow({width: '30%', height: '40%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
	     $('#filenameWindow').jqxWindow('close');
	     
	     $('#sourceWindow').jqxWindow({width: '30%', height: '50%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
	     $('#sourceWindow').jqxWindow('close');
	     
	     $('#colorWindow').jqxWindow({width: '30%', height: '50%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
	     $('#colorWindow').jqxWindow('close');
	     
	     $('#platenoWindow').jqxWindow({width: '30%', height: '50%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
	     $('#platenoWindow').jqxWindow('close');
	     
	     $('#fleetWindow').jqxWindow({width: '41%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
	     $('#fleetWindow').jqxWindow('close');
	     
	     $('#vehinfowindow').jqxWindow({ width: '60%', height: '67%',  maxHeight: '70%' ,maxWidth: '70%' , title: ' Fleet Search' ,position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
	     $('#vehinfowindow').jqxWindow('close');
		 
	     $('#loadcaptcha').hide();$('#loadsalikdata').hide();$('#loadtrafficdata').hide();
		 
		 
		 $('#txtusername').dblclick(function(){
			 unameSearchContent('satUsernameSearch.jsp');
		 });
		 
		 $('#txttrafficplateno').dblclick(function(){
			 var site=document.getElementById("cmbtrafficsite").value;
       	     filenameSearchContent('satfilenameSearch.jsp?site='+site);
		 });
		 
		 $('#txttrafficpsource').dblclick(function(){
			 var site=document.getElementById("cmbtrafficsite").value;
       	  	 filesourceSearchContent('satSourceSearch.jsp?site='+site);
		 });
		 
		 $('#txttrafficpcolor').dblclick(function(){
			 var site=document.getElementById("cmbtrafficsite").value;
       	     var source=document.getElementById("txttrafficpsource").value;
       	     filecolorSearchContent('satColorSearch.jsp?source='+source+'&site='+site);
		 });
		 
		 $('#txtsaliktagno').dblclick(function(){
			 plateNoSearchContent('satPlateNoSearch.jsp');
		 });
		 
		 $('#txtsalikfleetno').dblclick(function(){
			  vehinfoSearchContent('vehinfo.jsp');
		 });
	});
	
	function unameSearchContent(url) {
	    $('#unameWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#unameWindow').jqxWindow('setContent', data);
		$('#unameWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function filenameSearchContent(url) {
	 	$('#filenameWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#filenameWindow').jqxWindow('setContent', data);
		$('#filenameWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function filesourceSearchContent(url) {
	    $('#sourceWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#sourceWindow').jqxWindow('setContent', data);
		$('#sourceWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function filecolorSearchContent(url) {
	    $('#colorWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#colorWindow').jqxWindow('setContent', data);
		$('#colorWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function plateNoSearchContent(url) {
	    $('#platenoWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#platenoWindow').jqxWindow('setContent', data);
		$('#platenoWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function fleetSearchContent(url) {
	    $('#fleetWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#fleetWindow').jqxWindow('setContent', data);
		$('#fleetWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function vehinfoSearchContent(url) {
		$('#vehinfowindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#vehinfowindow').jqxWindow('setContent', data);
		$('#vehinfowindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function getCaptcha() {
		//setTimeout(function() {location.reload();},5000);
		var x=new XMLHttpRequest();
		var uname=document.getElementById("txtusername").value;
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
		            items= x.responseText;
			        var path=items.trim()+"/captcha.png";
		        	
			        isfileexist(path);
		     }
			else
				{
				}
		}
		x.open("GET",'getCaptcha.jsp',true);
		x.send();
 	}
	
	function fundisable(){
		
		  if (document.getElementById('radio_salik').checked) {
			
			 $("table#traffic input").prop("disabled", true);
			 $("table#traffic select").prop("disabled", true);
			 $('#radio_traffic').attr('disabled', false);
			 $("#chck_salikautomatic").attr("disabled", false);
			 $('#chck_salikautomatic').attr('checked', true);
			 $('#chck_trafficautomatic').attr('checked', false);
			 $("table#salik input").prop("disabled", false);
			 $("table#salik select").prop("disabled", false);
			 $('#jqxStartDate').jqxDateTimeInput({ disabled: true});
			 $('#jqxEndDate').jqxDateTimeInput({ disabled: true}); 
			 document.getElementById("chck_trafficautomatic").checked = false;
			 document.getElementById("chck_trafficfileno").checked = false;
			 
			  if(document.getElementById('chck_salikautomatic').checked) {
				  
				 $("#txtusername").attr("disabled", true);
				 $("table#salik input").prop("disabled", true);
				 $("#cmbsaliksite").attr("disabled", false);
				 $("#chck_salikautomatic").attr("disabled", false);
				 $('#jqxStartDate').jqxDateTimeInput({ disabled: true});
				 $('#jqxEndDate').jqxDateTimeInput({ disabled: true});
			     //$("#txtusername").attr("disabled", false);
				 $("#radio_salik").attr("disabled", false);
				 
			 }
			  
			  if ($("#cmbtype").val() == "customdates") {
				  
				  $('#jqxStartDate').jqxDateTimeInput({ disabled: false});
				  $('#jqxEndDate').jqxDateTimeInput({ disabled: false}); 
			  }
			  
			  /* else{
				  $("#txtsaliktagno").attr("disabled", false);
				  $("#txtsalikfleetno").attr("disabled", true);
			  } */
			  /* if((document.getElementById('cmbtype').value=='lcdays')) {
				  //document.getElementById("errormsg").innerHTML="Sorry,This option is not availble right now";
				  $('#jqxStartDate').jqxDateTimeInput({ disabled: false});
					 $('#jqxEndDate').jqxDateTimeInput({ disabled: false});
					 $("#txtsaliktagno").attr("disabled", true);
					 $("#txtsalikfleetno").attr("disabled", false);
				 }
			   else{
				  document.getElementById("errormsg").innerHTML="";
			  } */ 
			  $('#loadsalikdata').show();
			  $('#loadtrafficdata').hide();
			  
			}
		 else if (document.getElementById('radio_traffic').checked) {
			 $("table#salik input").prop("disabled", true);
			 $("table#salik select").prop("disabled", true);
			 $("#chck_salikautomatic").attr("checked", false);
			 $('#chck_trafficautomatic').attr('checked', true);
			 $('#radio_salik').attr('disabled', false);
			 $("table#traffic input").prop("disabled", false);
			 $("table#traffic select").prop("disabled", false);
			 $('#jqxStartDate').jqxDateTimeInput({ disabled: true});
			 $('#jqxEndDate').jqxDateTimeInput({ disabled: true}); 
			 
			  if ((document.getElementById('chck_trafficautomatic').checked)) {
				 $("table#traffic input").prop("disabled", true);
				 $("table#traffic select").prop("disabled", true);
				 $("#cmbtrafficsite").attr("disabled", false);
				 $("#chck_trafficautomatic").attr("disabled", false);
				 $("#radio_traffic").attr("disabled", false);
				 
			 }
			  
			 if (!(document.getElementById('chck_trafficautomatic').checked)) {
				 document.getElementById("chck_trafficfileno").checked = true;
				 $("#txttrafficpsource").attr("disabled", true);
				 $("#txttrafficpcolor").attr("disabled", true);
				 $("#txttrafficptype").attr("disabled", true);
				 $("#txttrafficpno").attr("disabled", true);
			 }
			 
			 if ((document.getElementById('chck_trafficfileno').checked)) {
				 $('#txttrafficplateno').attr('disabled', false); 
			 }

			 if ((document.getElementById('chck_trafficpdata').checked)) {
				 $("#txttrafficpsource").attr("disabled", false);
				 $("#txttrafficpcolor").attr("disabled", false);
				 $("#txttrafficptype").attr("disabled", false);
				 $("#txttrafficpno").attr("disabled", false);
			 }
			 
			  $('#loadsalikdata').hide();
			  $('#loadtrafficdata').show();
			 
			}
		 }
	
	 function funReadOnly(){
		 fundisable();
	 }
	 
	 function funRemoveReadOnly(){}
	 
	 function funSearchLoad(){}
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
//	    	$('#jqxCashPaymentDate').jqxDateTimeInput('focus'); 	    		
	    }
	   
	  function funNotify(){	
	    		return 1;
		} 
	  
	  
	  function setValues(){
		  if($('#hiddencategory').val()=='salik'){
				
				if($('#hidcmbsaliksite').val()){
		   			$("#cmbsaliksite").val($('#hidcmbsaliksite').val());
		   		}
				
				if($('#hidcmbtype').val()){
		   			$("#cmbtype").val($('#hidcmbtype').val());
		   		}
				
				if($('#hidjqxStartDate').val()){
					 $("#jqxStartDate").jqxDateTimeInput('val', $('#hidjqxStartDate').val());
				  }
				
				if($('#hidjqxEndDate').val()){
					 $("#jqxEndDate").jqxDateTimeInput('val', $('#hidjqxEndDate').val());
				  }
				
				/* if($('#hidcmbtype').val()=='lcdays'){
					
					 $('#jqxStartDate').jqxDateTimeInput({ disabled: false});
					 $('#jqxEndDate').jqxDateTimeInput({ disabled: false});
					 $("#txtsaliktagno").attr("disabled", true);
					 $("#txtsalikfleetno").attr("disabled", false);
					
				} */
			
			/* 	 $('#jqxStartDate').jqxDateTimeInput({ disabled: true});
				 $('#jqxEndDate').jqxDateTimeInput({ disabled: true});
				 $("#txtsaliktagno").attr("disabled", false); */
				 
				 
				 if ((document.getElementById('chck_trafficautomatic').checked)) {
					 //$("#txtsaliktagno").attr("disabled", true);
				 }
				
				 $("table#traffic input").prop("disabled", true);
				 $("table#traffic select").prop("disabled", true);
				document.getElementById("radio_salik").checked = true;
				$('#loadtrafficdata').hide();
				
				var indexVal =document.getElementById("docs").value;
				$("#loadsalikdata").load("SATloadDetails.jsp?xdocs="+indexVal);
		        $('#loadsalikdata').show();
			}
			
			if($('#hiddencategory').val()=='traffic'){
				
				if($('#hidcmbtrafficsite').val()){
		   			$("#cmbtrafficsite").val($('#hidcmbtrafficsite').val());
		   		}
			
				$("table#salik input").prop("disabled", true);
				 $("table#salik select").prop("disabled", true);
				 /* $('#jqxStartDate').jqxDateTimeInput({ disabled: true});
				 $('#jqxEndDate').jqxDateTimeInput({ disabled: true}); */
				document.getElementById("radio_traffic").checked = true;
				$('#loadsalikdata').hide();
				var indexVal =document.getElementById("docs").value;
				var plateno =document.getElementById("txttrafficplateno").value;
				var txttrafficpno=document.getElementById("txttrafficpno").value;
				if(plateno!=""){
					document.getElementById("chck_trafficfileno").checked = true;
					
				}
				if(txttrafficpno!=""){
					document.getElementById("chck_trafficpdata").checked = true;
					
				}
				//alert("indexVal"+indexVal);
				 $("#loadtrafficdata").load("SATTrafficloadDetails.jsp?trxdocs="+indexVal);
				 $('#loadtrafficdata').show();
			}
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
		  
		}
	  
	 
	  
	  function getUname(event){
          var x= event.keyCode;
          if(x==114){
        	  unameSearchContent('satUsernameSearch.jsp');
          }
          else{
           }
          }
	  
	  function getFilename(event){
          var x= event.keyCode;
          if(x==114){
        	  var site=document.getElementById("cmbtrafficsite").value;
        	  filenameSearchContent('satfilenameSearch.jsp?site='+site);
          }
          else{
           }
          }
	  
	  function getSource(event){
          var x= event.keyCode;
          if(x==114){
        	  var site=document.getElementById("cmbtrafficsite").value;
        	  filesourceSearchContent('satSourceSearch.jsp?site='+site);
          }
          else{
           }
          }
	  
	  function getColor(event){
          var x= event.keyCode;
          if(x==114){
        	  var site=document.getElementById("cmbtrafficsite").value;
        	  var source=document.getElementById("txttrafficpsource").value;
        	  filecolorSearchContent('satColorSearch.jsp?source='+source+'&site='+site);
          }
          else{
           }
          }
	  
	  function getPlateNo(event){
          var x= event.keyCode;
          if(x==114){
        	  plateNoSearchContent('satPlateNoSearch.jsp');
          }
          else{
           }
          }
	  
	  function getFleet(event){
          var x= event.keyCode;
          if(x==114){
        	  fleetSearchContent('satFleetSearch.jsp');
          }
          else{
           }
          }
	  
	  function getvehinfo(event){
          var x= event.keyCode;
          if(x==114){
        	  vehinfoSearchContent('vehinfo.jsp');
          }
          else{
           }
          }
	  
	  	window.setInterval(function(){
		    funDivload();
		    }, 5000);

		function funDivload(){
			var txtcaptcha=document.getElementById("txtcaptcha").value;
			if(txtcaptcha==""){
		
				getCaptcha();
			}
			if(!(txtcaptcha=="")){
				document.getElementById("errormsg").innerHTML="Download under Progress...Please wait...";
			}
		}
	  
		function iscaptcha(){
			
			//document.getElementById("iscaptcha").value=1;
			var iscaptcha=document.getElementById("iscaptcha").value;
			if(iscaptcha==1){
				document.getElementById("errormsg").innerHTML="Please Wait...Loading Captcha...";
				getCaptcha();
				//captchaload();
			}
			else{
				return false;
			}
		}

		function isfileexist(fileURL){
		 	var host = window.location.origin;
		  	//alert("==fileURL===="+fileURL);
		   	var splt = fileURL.split("webapps"); 
		   	//alert("after split"+splt[1]);
		   	var repl = splt[1].replace( /\\/g, "/");
		   	fileURL=host+repl; 
		   
		   $.ajax({
			   
			   url: fileURL, //or your url
			   success: function(data){
				  
			     captchaload();
			   },
			   error: function(data){
			     
			   },
			 })
		   
		}


		function captchaload(){
			$('#loadcaptcha').show();
			$("#loadcaptcha").load("captcha.jsp");
			document.getElementById("errormsg").innerHTML="Please fill the captcha with in 60 seconds";
		}

		function getBrowser(){
			
			 if (document.getElementById('radio_salik').checked) {
				
					if(!(document.getElementById('chck_salikautomatic').checked)) {
								
								if($('#txtusername').val()==''){
									document.getElementById("errormsg").innerHTML="Please select a User Name to continue!!";
									return 0;
									
								}
								
								
							}
							
					/* if((document.getElementById('cmbtype').value=='lcdays')) {
						  document.getElementById("errormsg").innerHTML="Sorry,This option is not availble right now";
						  return false;
					} */

							document.getElementById("frmnewSATdownload").submit();
							document.getElementById("errormsg").innerHTML="Download under Progress...Please wait...";
							setTimeout(function() {iscaptcha();$("#btnGo").attr("disabled", true);},5000);
		    }
			
			if (document.getElementById('radio_traffic').checked) {
				
				if(!(document.getElementById('chck_trafficautomatic').checked)) {
					if($('#txttrafficplateno').val()==''){
						document.getElementById("errormsg").innerHTML="Please select a Traffic File No";
						return false;
					}
				}
				
				document.getElementById("frmnewSATdownload").submit();
				document.getElementById("errormsg").innerHTML="Download under Progress...Please wait...";
				setTimeout(function() {iscaptcha();$("#btnGo").attr("disabled", true);},5000);
				
		   }
			
		}
</script>

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmnewSATdownload" action="newSATdownload" method="post" autocomplete="off">
<jsp:include page="../../header.jsp"></jsp:include>

<div  class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="50%">
<fieldset><legend>Salik</legend>
<table width="100%" id="salik">
  <tr>
    <td width="11%" align="left"><input type="radio" id="radio_salik" name="category" value="salik" onchange="fundisable();">Site</td>
    <td width="20%"><input type="hidden" id="hiddencategory" name="hiddencategory" value='<s:property value="hiddencategory"/>'></td>
    <td width="13%" align="right">Site</td>
    <td width="19%"><select id="cmbsaliksite" name="cmbsaliksite" style="width:40%;" value='<s:property value="cmbsaliksite"/>'>
    <option value="DXB">DXB</option></select>
    <input type="hidden" id="hidcmbsaliksite" name="hidcmbsaliksite" value='<s:property value="hidcmbsaliksite"/>'/></td>
    <td colspan="2" align="center"><input type="checkbox" id="chck_salikautomatic" name="chck_salikautomatic" value="salikautomatic" onchange="fundisable();">&nbsp;Automatic</td>
  </tr>
  <tr>
    <td colspan="6">
    <fieldset> 
<table width="100%">
  <tr>
    <td align="right" width="10%">Time-Period</td>
    <td width="26%"><select id="cmbtype" name="cmbtype" style="width:95%;" value='<s:property value="cmbtype"/>' onchange="fundisable();">
    <option value="lhrs">Last 24 Hours</option>
    <option value="ldays">Last 7 Days</option>
    <option value="l30d">Last 30 Days</option>
    <option value="customdates">Custom Dates</option></select>
    <input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'/> </td>
    <td width="8%" align="right">Start Date</td>
    <td width="23%"><div id="jqxStartDate" name="jqxStartDate" value='<s:property value="jqxStartDate"/>'></div>
    <input type="hidden" id="hidjqxStartDate" name="hidjqxStartDate" value='<s:property value="hidjqxStartDate"/>'/></td>
    <td width="9%" align="right">End Date</td>
    <td width="24%"><div id="jqxEndDate" name="jqxEndDate" value='<s:property value="jqxEndDate"/>'></div>
    <input type="hidden" id="hidjqxEndDate" name="hidjqxEndDate" value='<s:property value="hidjqxEndDate"/>'/></td>
  </tr>
  <tr>
   <td width="10%" align="right">Username</td>
    <td colspan="5"><input type="text" id="txtusername" name="txtusername" style="width:60%;" value='<s:property value="txtusername"/>' onkeydown="getUname(event);" readonly placeholder="Press F3 to Search" />
    <!-- <input type="checkbox" id="chck_salikpdata" name="chck_salikpdata"  value="salikpdata" onchange="fundisable();">Inquiry by Fleet --></td>
   </tr>
</table>
 </fieldset>
    </td>
  </tr>
  <tr>
    <td align="right">Fleet No.</td>
    <td colspan="2"><input type="text" id="txtsalikfleetno" name="txtsalikfleetno" style="width:50%;" value='<s:property value="txtsalikfleetno"/>'  onkeydown="getvehinfo(event);" readonly placeholder="Press F3 to Search" /></td>
    <td  align="right" colspan="2">Reg No.</td>
    <td width="28%"><input type="text" id="txtxslregno" name="txtxslregno" style="width:50%;" readonly value='<s:property value="txtxslregno"/>'/></td>
  </tr>
  <tr>
    <td align="right">Fleet Name</td>
    <td colspan="2"><input type="text" id="txtsalfleetnme" name="txtsalfleetnme" style="width:95%;" readonly value='<s:property value="txtsalfleetnme"/>'/></td>
    <td align="right" colspan="2">Plate Code</td>
    <td width="28%"><input type="text" id="txtsalplcode" name="txtsalplcode" style="width:50%;" readonly value='<s:property value="txtsalplcode"/>'/></td>
  </tr>
  <tr>
    <td align="right">Salik Tag</td>
    <td colspan="5"><input type="text" id="txtsaliktagno" name="txtsaliktagno" readonly onkeydown="getPlateNo(event);" style="width:20%;" value='<s:property value="txtsaliktagno"/>'/></td>
  </tr>
</table>
</fieldset>
</td>

<td width="50%">
<fieldset><legend>Traffic</legend>
<table width="100%" id="traffic">
  <tr>
    <td width="11%"><input type="radio" id="radio_traffic" name="category" value="traffic" onchange="fundisable();">Traffic</td>
    
    <td width="25%" align="right">Site</td>
    <td width="30%"><select id="cmbtrafficsite" name="cmbtrafficsite" style="width:40%;" onchange="fundisable();" value='<s:property value="cmbtrafficsite"/>' >
    <option value="AUH">AUH</option><option value="DXB">DXB</option></select></select>
    <input type="hidden" id="hidcmbtrafficsite" name="hidcmbtrafficsite" value='<s:property value="hidcmbtrafficsite"/>'/> </td>
    <td width="30%" align="center" colspan="2"><input type="checkbox" id="chck_trafficautomatic" name="chck_trafficautomatic" value="trafficautomatic" onchange="fundisable();">&nbsp;Automatic</td>
  </tr>
  <tr>
    <td colspan="5">
    <fieldset>
  <table width="100%">
 <tr>
    <td align="center" colspan="2"><input type="checkbox" id="chck_trafficfileno" name="chck_trafficfileno"  value="trafficfileno" onchange="fundisable();">&nbsp;Traffic File No.</td>
    <td width="11%" align="right">Traffic File  No.</td>
    <td width="47%"><input type="text" id="txttrafficplateno" name="txttrafficplateno" style="width:60%;" placeholder="Press F3 to Search" onkeydown="getFilename(event);" readonly value='<s:property value="txttrafficplateno"/>'/></td>
    </tr>
</table>

<table width="100%">
<tr><td colspan="4" align="left"><input type="checkbox" id="chck_trafficpdata" name="chck_trafficpdata"  value="trafficpdata" onchange="fundisable();">Inquiry by plate data</td></tr>
</table>
<fieldset>
<table width="100%">
  <tr>
  
    <td width="18%" align="right">Plate No.</td>
    <td width="24%"><input type="text" id="txttrafficpno" name="txttrafficpno" placeholder="Press F3 to Search" onkeydown="getPlateNo(event);"   style="width:70%;" value='<s:property value="txttrafficpno"/>'/></td>
    <td width="11%" align="right">Plate Source</td>
    <td width="47%"><input type="text" id="txttrafficpsource" name="txttrafficpsource" placeholder="Press F3 to Search" onkeydown="getSource(event);"  readonly style="width:40%;" value='<s:property value="txttrafficpsource"/>'/></td>
    </tr>
  
    <tr>
    <td align="right">Plate Color</td>
    <td><input type="text" id="txttrafficpcolor" name="txttrafficpcolor" style="width:70%;" placeholder="Press F3 to Search" onkeydown="getColor(event);" readonly value='<s:property value="txttrafficpcolor"/>'/></td>
    <td align="right">Plate Type</td>
    <td><input type="text" id="txttrafficptype" name="txttrafficptype" style="width:50%;"  readonly value='<s:property value="txttrafficptype"/>'/></td>
  </tr>
</table>

</fieldset>
</fieldset>
</td></tr>
</table><br/>
</fieldset>
</td></tr>
</table>

<table width="99%">
<tr>
    <td colspan="2" align="center"><button class="myButton" type="button"  id="btnGo" name="btnGo" onClick="getBrowser();" >Download Now !!!</button> </td>
</tr>
<tr>
    <td colspan="2" align="center"><div id="loadsalikdata"><jsp:include page="SATloadDetails.jsp"></jsp:include></div>
		<div id="loadtrafficdata"><jsp:include page="SATTrafficloadDetails.jsp"></jsp:include></div></td>
</tr>
</table>



<input type="hidden" id="docs" name="docs" value='<s:property value="docs"/>'/>
<input type="hidden"  id="captcha" name="captcha"  value='<s:property value="captcha"/>'/>
<input type="hidden"  id="captchacount" name="captchacount"  value='<s:property value="captchacount"/>'/>
<input type="hidden" id="iscaptcha" name="iscaptcha"  value='<s:property value="iscaptcha"/>'/>
<input type="hidden" id="iscaptchaloaded" name="iscaptchaloaded"  value='<s:property value="iscaptchaloaded"/>'/>
<input type="hidden" id="captchapath" name="captchapath"  value='<s:property value="captchapath"/>'/>
<input type="hidden"  id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden"  id="txtsalikregno" name="txtsalikregno"  value='<s:property value="txtsalikregno"/>'/>
<input type="hidden"  id="txttrafficpsourceid" name="txttrafficpsourceid"  value='<s:property value="txttrafficpsourceid"/>'/>
<input type="hidden"  id="txttrafficpcolorid" name="txttrafficpcolorid"  value='<s:property value="txttrafficpcolorid"/>'/>
<input type="hidden"  id="txttrafficptypeid" name="txttrafficptypeid"  value='<s:property value="txttrafficptypeid"/>'/>
</div>
</form>
	
<div id="flash"></div>
<div id="display"></div>
<div id="unameWindow">
   <div></div><div></div>
</div>
 
<div id="filenameWindow">
   <div></div><div></div>
</div> 

<div id="sourceWindow">
   <div></div><div></div>
</div>

<div id="colorWindow">
	<div></div><div></div>
</div> 				 				

<div id="fleetWindow">
    <div></div><div></div>
</div>

<div id="vehinfowindow">
   <div></div><div></div>
</div>

<div id="platenoWindow">
	<div></div><div></div>
</div>				

<div class="modal"></div>
	
</div>
</body>
</html>
