<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/body.css" rel="stylesheet" type="text/css">
 <jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
form label.error {
color:red;
  font-weight:bold;

}
  .sep {
        border-bottom:1px solid black;
    }
    .alignright{
    
    text-align:
    }
</style>

<script type="text/javascript">
	$(document).ready(function() {
 
		$("#jqxDate1").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		
			 $('#clientDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
			 $('#clientDetailsWindow').jqxWindow('close');  
			 
		    $('#txtclientname').dblclick(function(){
				  clientSearchContent('clientDetailsSearchGrid.jsp');
				});
		    
		    getBrand();getYOM();getColor();
		    
	});
	 
	
	function clientSearchContent(url) {
	 	$('#clientDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientDetailsWindow').jqxWindow('setContent', data);
		$('#clientDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function funReadOnly() {
		 $('#frmVehicleevaluation input').attr('readonly', true);
		 $('#frmVehicleevaluation select').attr('disabled', true);
		 $('#jqxDate1').jqxDateTimeInput({ disabled: true}); 
		 $('#txtclientname').attr('readonly', true);
		
		
		//getBrch();
		
		//getLocation();
/* 		document.getElementById("frmVehicleevaluation").disabled=true;
		document.getElementById("btnrelease").disabled=false; */
		/* $('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
	}
	
	
	function funEnable(){
		
		
	}
	
	
	function funRemoveReadOnly() {
		
		$('#frmVehicleevaluation input').attr('readonly', false);
		$('#frmVehicleevaluation select').attr('disabled', false);
		//$('#jqxDateTimeInput').jqxDateTimeInput({		disabled : false		});
		$('#txtclientname').attr('disabled', false);
		$('#txtclientname').attr('readonly', true);
		$('#docno').attr('readonly', true);
		
		getBrand();getColor();
		
		 $('#jqxDate1').jqxDateTimeInput({ disabled: false}); 
		 /* if(document.getElementById("cmbbrand").value!=""){
			    getModel(document.getElementById("cmbbrand").value);
			   } */
	}
	
	function getColor() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var colorItems = items[0].split(",");
				var colorIdItems = items[1].split(",");
				var optionscolor = '<option value="">--Select--</option>';
				for (var i = 0; i < colorItems.length; i++) {
					optionscolor += '<option value="' + colorIdItems[i] + '">'
							+ colorItems[i] + '</option>';
				}
				$("select#cmbcolor").html(optionscolor);
				if ($('#hidcmbcolor').val() != null) {
					$('#cmbcolor').val($('#hidcmbcolor').val());
				}
			} else {
			}
		}
		x.open("GET", "vehiclemaster/getColor.jsp", true);
		x.send();
	}
	
	function getBrand() {
		
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('***');
				var brandItems = items[0].split(",");
				var brandidItems = items[1].split(",");
				var optionsbrand = '<option value="">--Select--</option>';
				for (var i = 0; i < brandItems.length; i++) {
					optionsbrand += '<option value="' + brandidItems[i] + '">'
							+ brandItems[i] + '</option>';
				}
				$("select#cmbbrand").html(optionsbrand);
				if ($('#hidcmbbrand').val() != null) {
					$('#cmbbrand').val($('#hidcmbbrand').val());
				}
			} else {
			}
		}
		x.open("GET", "vehiclemaster/getBrand.jsp", true);
		x.send();
	}
	
	
	function getYOM() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('####');
				var yomItems = items[0].split(",");
				var yomidItems = items[1].split(",");
				var optionsyom = '<option value="">--Select--</option>';
				for (var i = 0; i < yomItems.length; i++) {
					optionsyom += '<option value="' + yomidItems[i] + '">'
							+ yomItems[i] + '</option>';
				}
				$("select#cmbyom").html(optionsyom);
				if ($('#hidcmbyom').val() != null) {
					$('#cmbyom').val($('#hidcmbyom').val());
				}
			} else {
			}
		}
		x.open("GET", "vehiclemaster/getYOM.jsp", true);
		x.send();
	}
	
	
	

	
	function setValues() {
		document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		funSetlabel();
		if ($('#hidcmbinterior').val() != null) {
			$('#cmbinterior').val($('#hidcmbinterior').val());
		}
		if ($('#hidcmbtransition').val() != null) {
			$('#cmbtransition').val($('#hidcmbtransition').val());
		}
		if ($('#hidcmbcondition').val() != null) {
			$('#cmbcondition').val($('#hidcmbcondition').val());
		}
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		 // document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		// alert(document.getElementById("docno").value);
		 
		
	}

	 function funFocus()
	    {
	    	
	    		
	    }
	 $(function(){
	        $('#frmVehicleevaluation').validate({
	                 rules: {
	               
	                cmbgroup:"required",
	                //regno:"required",
	                cmbbrand:"required",
	                cmbmodel:"required",
	                cmbyom:"required" ,
	                cmbcolor:"required" ,
	                cmbinterior:"required",
	                cmbtransition:"required",
	                cmbcondition:"required"
	               /*  current_km:"required",
	                accu_dep:"required" */
	               
	                 
	                 }, 
	        messages:{
	        	
	        	cmbgroup:" *",
	        	
	        	cmbbrand:" *",
	        	cmbmodel:" *",
	        	cmbyom:" *",
	        	cmbcolor:" *",
	        	cmbinterior:" *",
	        	cmbtransition:" *",
	        	cmbcondition:" *",
	        	
	        	/* accu_dep:"*" */
	        
	        }
	                 //alert("here");
	        });
	        });
	
	   
	     function funNotify(){
	    	 
	    	 if(document.getElementById("txtclientname").value==""){
	    		 document.getElementById("errormsg").innerText="";
	    		 document.getElementById("errormsg").innerText="Client is Mandatory";
	    		 
	    		 document.getElementById("txtclientname").focus();
	    		 return 0;
	    	 }
		  return 1;
	     } 
	   
	  
function getClient(event){
	 var x= event.keyCode;
    if(x==114){
    	clientSearchContent('clientDetailsSearchGrid.jsp');
    }
    else{}
    }
function funSearchLoad(){
	changeContent('vehicleevaluationsearch.jsp'); 
 }
function funPrintBtn(){
	   if (($("#mode").val() == "view") && $("#docno").val()!="") {
	  
	   var url=document.URL;
      var reurl=url.split("saveVehicleevaluation1");
      
      $("#docno").prop("disabled", false);                
      

var win= window.open(reurl[0]+"printVehicleevaluation1?docno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
   
win.focus();
	   } 
	  
	   else {
	    	      $.messager.alert('Message','Select a Document....!','warning');
	    	      return false;
	    	     }
	    	
	}
	
</script>
 </head>
<body onLoad="setValues();">
	
	<br/> 
	<div id="mainBG" class="homeContent" data-type="background"> 
		<form id="frmVehicleevaluation" action="saveVehicleevaluation1" method="post" autocomplete="off">
		<jsp:include page="../../../../header.jsp" />
				<fieldset><legend>Vehicle Details</legend>
				<table width="100%" cellspacing="0" >
					<tr>
						
						<td align="right">Date</td>
						<td colspan="2" align="left"><div id='jqxDate1'
								name='jqxDate1' value='<s:property value="jqxDate1"/>'></div>
                        <input
							type="hidden" id="hidjqxDate1" name="hidjqxDate1"
							value='<s:property value="hidjqxDate1"/>' /></td>
						<td align="right">
						Doc No</td>
						<td><input type="text" name="docno" id="docno"  readonly="readonly" value='<s:property value="docno"/>' tabindex="-1">
							</td>
	
					</tr>
					<tr><td width="13%" align="right"><label class="branch">Client</label></td>
	                  <td width="25%"align="left"><input type="text" id="txtclientname" name="txtclientname" style="width:85%;height:15px;" readonly="readonly" placeholder="Press F3 to Search"  onkeydown="getClient(event);" value='<s:property value="txtclientname"/>'/>
                      <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/></td>
				
					<td  height="24" id="f" align="right">
								Car Value</td>
							<td width="25%"><input type="text" name="carval" id="carval" style="width:50%;height:15px;" value='<s:property value="carval"/>'>
							  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Color</td>
					      <td> <select name="cmbcolor" id="cmbcolor"
							value='<s:property value="cmbcolor"/>' style="width:70%;" >
                        <option value="">--Select--</option>
                          </select>
				      <input type="hidden" id="hidcmbcolor" name="hidcmbcolor"
							value='<s:property value="hidcmbcolor"/>' />
							</td> </tr>
					<tr>
						<td height="24" align="right"><span style="text-align: right">Brand</span></td>
						<td width="14"><select name="cmbbrand" id="cmbbrand" value='<s:property value="cmbbrand"/>' style="width:86%;" >
                          <option>--Select--</option>
                        </select>
					 <input type="hidden" id="hidcmbbrand" name="hidcmbbrand"
							value='<s:property value="hidcmbbrand"/>' /> </td>
						<td width="13%" align="right">Model</td>				
							<td><input type="text" name="model" id="model" style="width: 50%;height:15px;" value='<s:property value="model"/>'>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;YoM</td>
						<td><select name="cmbyom" id="cmbyom" value='<s:property value="cmbyom"/>' style="width:70%;" >
                          <option>--Select--</option>
                        </select>
					  <input type="hidden" id="hidcmbyom" name="hidcmbyom"
							value='<s:property value="hidcmbyom"/>' /></td>
							<tr>
						<td width="70" align="right">Interior</td>
						<td align="left"><select name="cmbinterior" id="cmbinterior" value='<s:property value="cmbinterior"/>' style="width:86%;">
                           <option value="">--Select--</option>
                         <option value="1">Beige</option>
                         <option value="2">Grey</option>
                         <option value="3">White</option>
                         <option value="4">Black</option>
                          </select>
					  </td><input type="hidden" id="hidcmbinterior" name="hidcmbinterior"
							value='<s:property value="hidcmbinterior"/>' />
			
							
							<td width="58" align="right">Transition</td>
						<td><select name="cmbtransition" id="cmbtransition" value='<s:property value="cmbtransition"/>' style="width:50%;">
                          <option value="">--Select--</option>
                          <option value="1">Manual</option>
                         <option value="2">Automatic</option>
                        </select>
					  <input type="hidden" id="hidcmbtransition" name="hidcmbtransition"
							value='<s:property value="hidcmbtransition"/>' />
							
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Chassis No</td>
							
						<td><input type="text" id="txtchno" name="txtchno"  value='<s:property value="txtchno"/>' /></td>
						
						</tr>
							<tr>
						<td width="39" align="right">Engine No</td>
						<td width="123" align="left"><input type="text" id="txtengno" name="txtengno"  value='<s:property value="txtengno"/>' style="width:86%;" /></td>
						
						<td width="39" align="right">Odo Metre(KM)</td>
						<td><input type="text" id="txtodno" name="txtodno"  value='<s:property value="txtodno"/>' style="width:50%;"/>
						
					   &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Condition</td>
					    <td>
						 <select name="cmbcondition" id="cmbcondition" value='<s:property value="cmbcondition"/>' style="width:50%;">
                          <option value="">--Select--</option>
                         <option value="1">NotStarting</option>
                         <option value="2">Good Condition</option>
                         <option value="3">Good And Running</option>
                         <option value="4">Nornmal  And Running</option>
                         <option value="5">Excellent</option>
                          </select>
					  <input type="hidden" id="hidcmbcondition" name="hidcmbcondition"
							value='<s:property value="hidcmbcondition"/>' /></td>
					    
					</tr><td><input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/></td></tr>
					
				</table>
<br />

				
					

					<div id="tab3"><table width="100%" >
					
					<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
  <tr><input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
  <input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
    <%-- <td><div id="specdiv"><center><jsp:include page="specificationGrid.jsp"></jsp:include></center></div></td> --%>
    </tr>
</table>

						
						
					</div>

			
			</fieldset>
		</form>
<br/>
<div id="clientDetailsWindow">
				
	<div></div>
</div>
</div>
	
</body>
</html>