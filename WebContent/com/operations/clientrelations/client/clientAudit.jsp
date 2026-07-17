<%@ taglib prefix="s" uri="/struts-tags" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%-- <include page="<%=contextPath%>/includes.jsp" /> --%>
<style type="text/css">
 #frmClientAudit {
    background-color: #E0ECF8;
     font-size: 9px; 
    /* font: 10px Tahoma; */
}

.formfont {
	font: 10px Tahoma;
	color: #404040;
	background: #E0ECF8;
	overflow:hidden;
}

</style>

<script type="text/javascript">
      $(document).ready(function (){
    	  $("#jqxClientDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    	  
 		funReadOnly();getGroup();getSalesman();getCategory();getNationality();funCurrency();setValues();
 		 
        $("#jqxDriver1").load("<%=contextPath+"/"%>com/operations/clientrelations/client/driver.jsp?txtclientdocno1="+document.getElementById("docno").value);
        $("#jqxReferenceDetails1").load("<%=contextPath+"/"%>com/operations/clientrelations/client/referenceDetails.jsp?txtclientdocno3="+document.getElementById("docno").value);
		 
      });  
     
      function getGroup() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var groupItems = items[0].split(",");
  				var groupIdItems = items[1].split(",");
  				var optionsgroup = '<option value="">--Select--</option>';
  				for (var i = 0; i < groupItems.length; i++) {
  					optionsgroup += '<option value="' + groupIdItems[i] + '">'
  							+ groupItems[i] + '</option>';
  				}
  				$("select#cmbgroup1").html(optionsgroup);
  				if ($('#hidcmbgroup1').val() != null) {
  					$('#cmbgroup1').val($('#hidcmbgroup1').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "<%=contextPath+"/"%>com/operations/clientrelations/client/getGroup.jsp", true);
  		x.send();
  	}  
     
      function getSalesman() {
    		var x = new XMLHttpRequest();
    		x.onreadystatechange = function() {
    			if (x.readyState == 4 && x.status == 200) {
    				var items = x.responseText;
    				items = items.split('####');
    				var salesagentItems = items[0].split(",");
    				var salesagentIdItems = items[1].split(",");
    				var optionssalesagent = '<option value="">--Select--</option>';
    				for (var i = 0; i < salesagentItems.length; i++) {
    					optionssalesagent += '<option value="' + salesagentIdItems[i] + '">'
    							+ salesagentItems[i] + '</option>';
    				}
    				$("select#cmbsalesman").html(optionssalesagent);
    				if ($('#hidcmbsalesman').val() != null) {
    					$('#cmbsalesman').val($('#hidcmbsalesman').val());
    				}
    			} else {
    			}
    		}
    		x.open("GET", "<%=contextPath+"/"%>com/operations/clientrelations/client/getSalesagent.jsp", true);
    		x.send();
    	} 
      
      function getCategory() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var categoryItems = items[0].split(",");
  				var categoryIdItems = items[1].split(",");
  				var optionscategory = '<option value="">--Select--</option>';
  				for (var i = 0; i < categoryItems.length; i++) {
  					optionscategory += '<option value="' + categoryIdItems[i] + '">'
  							+ categoryItems[i] + '</option>';
  				}
  				$("select#cmbcategory").html(optionscategory);
  				if ($('#hidcmbcategory').val() != null) {
  					$('#cmbcategory').val($('#hidcmbcategory').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "<%=contextPath+"/"%>com/operations/clientrelations/client/getCategory.jsp", true);
  		x.send();
  	} 
      
       function getCurrencyId(){
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 	items= x.responseText;
				 	items=items.split('####');
			        var curidItems=items[0];
			        var curcodeItems=items[1];
			        var currateItems=items[2];
			       
			        var optionscurr = '';
			        if(curcodeItems.indexOf(",")>=0){
			        	curidItems.split(",");
			        	curcodeItems.split(",");
			        	currateItems.split(",");
			        	for ( var i = 0; i < curcodeItems.length; i++) {
			    	   optionscurr += '<option value="' + curidItems[i] + '">' + curcodeItems[i] + '</option>';
			        }
			         $("select#cmbcurrency").html(optionscurr);
			         if ($('#hidcmbcurrency').val() != null && $('#hidcmbcurrency').val() != "") {
			         $('#cmbcurrency').val($('#hidcmbcurrency').val()) ;
			         } 
				   
				    }
			
			       else
				  {
			    	   optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
			    	   $("select#cmbcurrency").html(optionscurr);
			    	   if ($('#hidcmbcurrency').val() != null && $('#hidcmbcurrency').val() != "") {
			    	   		$('#cmbcurrency').val($('#hidcmbcurrency').val()) ;
			    	   } 
				  }
				}
		     }
		      x.open("GET", "<%=contextPath+"/"%>com/operations/clientrelations/client/getCurrencyId.jsp",true);
		     x.send();
		    
	       } 
     
      function getNationality() {
    		var x = new XMLHttpRequest();
    		x.onreadystatechange = function() {
    			if (x.readyState == 4 && x.status == 200) {
    				var items = x.responseText;
    				items = items.split('####');
    				var nationItems = items[0].split(",");
    				var nationIdItems = items[1].split(",");
    				var optionsnation = '<option value="">--Select--</option>';
    				for (var i = 0; i < nationItems.length; i++) {
    					optionsnation += '<option value="' + nationIdItems[i] + '">'
    							+ nationItems[i] + '</option>';
    				}
    				$("select#cmbnationality").html(optionsnation);
    				if ($('#hidcmbnationality').val() != null) {
    					$('#cmbnationality').val($('#hidcmbnationality').val());
    				}
    			} else {
    			}
    		}
    		x.open("GET", "<%=contextPath+"/"%>com/operations/clientrelations/client/getNationality.jsp", true);
    		x.send();
    	}  
      
     function defaultcheck(){
 		 if(document.getElementById("chckdefault").checked){
 			 document.getElementById("hidchckdefault").value = 1;
 			 $('#txtsalik').attr('readonly', true );
 			 $('#txtsalik').val("0.0");
 			 $('#txttraffic').attr('readonly', true );
 			 $('#txttraffic').val("0.0");
 		 }
 		 else{
 			 document.getElementById("hidchckdefault").value = 0;
 			 $('#txtsalik').attr('readonly', false );
 			 $('#txtsalik').val("0.0");
 			 $('#txttraffic').attr('readonly', false );
 			 $('#txttraffic').val("0.0");
 		 }
 	 }
     
	 function funReadOnly(){
			$('#frmClientAudit input').attr('readonly', true );
			$('#frmClientAudit select').attr('disabled', true);
			$('#jqxClientDate').jqxDateTimeInput({disabled: true});
			$("#jqxDriver").jqxGrid({ disabled: true});
			$("#jqxReferenceDetails").jqxGrid({ disabled: true});
	 }
	 function funRemoveReadOnly(){
		
			$('#frmClientAudit input').attr('readonly', false );
			$('#frmClientAudit select').attr('disabled', false);
			$('#chckdefault').attr('disabled', false);
			$('#jqxClientDate').jqxDateTimeInput({disabled: false});
			$('#txtaccount').attr('readonly', true);
			$('#txtcode').attr('readonly', true);
			$('#docno').attr('readonly', true);
			$("#jqxDriver").jqxGrid({ disabled: false});
			$("#jqxReferenceDetails").jqxGrid({ disabled: false});
		
	 }
	 function funNotify(){	
		 
		 document.getElementById("errormsg").innerText="";		 
		 
		 var rows = $("#jqxDriver").jqxGrid('getrows');
		 var length=0;
			 for(var i=0 ; i < rows.length ; i++){
				var chk=rows[i].name;
				if(typeof(chk) != "undefined"){
					length=length+1;
					newTextBox = $(document.createElement("input"))
				    .attr("type", "dil")
				    .attr("id", "test"+i)
				    .attr("name", "test"+i)
				    .attr("hidden", "true");
			
			newTextBox.val(rows[i].name+"::"+rows[i].hiddob+"::"+rows[i].nation1+"::"+rows[i].mobno+"::"+rows[i].passport_no+"::"+rows[i].hidpassexp+"::"+rows[i].dlno+"::"+rows[i].hidissdate+"::"+rows[i].issfrm+"::"+rows[i].hidled+"::"+rows[i].ltype+"::"+rows[i].visano+"::"+rows[i].hidvisaexp);
			newTextBox.appendTo('form');
			 }
			}
 		 $('#gridlength').val(length);
 		
 		 var rows = $("#jqxReferenceDetails").jqxGrid('getrows');
 		 var referencelength=0;
 		 for(var i=0 ; i < rows.length ; i++){
 				var chkd=rows[i].cperson;
				if(typeof(chkd) != "undefined"){
				referencelength=referencelength+1;
				newTextBox = $(document.createElement("input"))
			    .attr("type", "dil")
			    .attr("id", "txtreference"+i)
			    .attr("name", "txtreference"+i)
			    .attr("hidden", "true");
		
			newTextBox.val(rows[i].cperson+" :: "+rows[i].desig+" :: "+rows[i].mob+" :: "+rows[i].email+" ::");
			newTextBox.appendTo('form');
			}
	      }
	      $('#referencelength').val(referencelength);

	      return 1;
	    	
		} 
	 
	 function funSearchLoad(){
			/* changeContent('crmMainSearch.jsp'); */ 
		 }
	 
	 function funFocus(){
	    	$('#jqxClientDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	 function funCurrency(){
		 if($('#hidcmbcurrency').val()!=""){
			 getCurrencyId();
			 $('#cmbcurrency').val($('#hidcmbcurrency').val());
		 }
	 }
	 
	 function setValues(){
		   
			 if($('#hidjqxClientDate').val()){
				 $("#jqxClientDate").jqxDateTimeInput('val', $('#hidjqxClientDate').val());
			  }
			
			 if(document.getElementById("hidchckdefault").value==1){
	 			 document.getElementById("chckdefault").checked = true;
	 		 }
	 		 else if(document.getElementById("hidchckdefault").value==0){
	 			document.getElementById("chckdefault").checked = false;
	 		 }
			 
			document.getElementById("cmbgroup").value=document.getElementById("hidcmbgroup").value;
			document.getElementById("cmbinvoicing_method").value=document.getElementById("hidcmbinvoicing_method").value;
			$('#cmbdel_charges').val($('#hidcmbdel_charges').val());  
			
			 if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
		}
	 
	 function funChkButton() {
			/* funReset(); */
		}
	 
  </script>

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>

</head>
<body id="search" onload="setValues();">

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmClientAudit" action="saveClientMaster" method="post" autocomplete="off">

<div class='hidden-scrollbar'>
<fieldset>
<table width="100%">
  <tr>
    <td width="4%" align="right" class="formfont">Date</td>
    <td width="6%"><div id="jqxClientDate" name="jqxClientDate" value='<s:property value="jqxClientDate"/>'></div>
    <input type="hidden" id="hidjqxClientDate" name="hidjqxClientDate" value='<s:property value="hidjqxClientDate"/>'/></td>
    <td width="5%" align="right" class="formfont">Code</td>
    <td width="15%"><input type="text" id="txtcode" name="txtcode" style="width:50%;" tabindex="-1" value='<s:property value="txtcode"/>'/></td>
    <td width="5%" align="right" class="formfont">Name</td>
    <td colspan="2"><input type="text" id="txtclient_name" name="txtclient_name" onfocus="getCurrencyId();" style="width:95%;" value='<s:property value="txtclient_name"/>'/></td>
    <td width="9%" align="right" class="formfont">Currency</td>
    <td width="12%"><select id="cmbcurrency" name="cmbcurrency" value='<s:property value="cmbcurrency"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency" value='<s:property value="hidcmbcurrency"/>'/></td>
    <td width="5%" align="right" class="formfont">Doc No.</td>
    <td width="14%"><input type="text" id="docno" name="txtclientdocno" style="width:65%;" tabindex="-1" value='<s:property value="txtclientdocno"/>'/></td>
  </tr>
  <tr>
    <td align="right" class="formfont">Group</td>
    <td><select id="cmbgroup" name="cmbgroup" style="width:30%;" value='<s:property value="cmbgroup"/>'>
      <option value="">----</option>
      <option value="A">A</option><option value="B">B</option><option value="C">C</option>
      <option value="D">D</option><option value="E">E</option><option value="N">N</option></select>
      <input type="hidden" id="hidcmbgroup" name="hidcmbgroup" value='<s:property value="hidcmbgroup"/>'/></td>
    <td align="right" class="formfont">Category</td>
    <td><select id="cmbcategory" name="cmbcategory" style="width:70%;" value='<s:property value="cmbcategory"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbcategory" name="hidcmbcategory" value='<s:property value="hidcmbcategory"/>'/></td>
    <td colspan="2" align="right" class="formfont">Salesman</td>
    <td width="13%"><select id="cmbsalesman" name="cmbsalesman" value='<s:property value="cmbsalesman"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbsalesman" name="hidcmbsalesman" value='<s:property value="hidcmbsalesman"/>'/></td>
    <td align="right" class="formfont">Invoicing Method</td>
    <td><select id="cmbinvoicing_method" name="cmbinvoicing_method" value='<s:property value="cmbinvoicing_method"/>'>
      <option value="">--Select--</option>
      <option value="1">Advance</option>
      <option value="2">Month End</option>
      <option value="3">Period</option></select>
      <input type="hidden" id="hidcmbinvoicing_method" name="hidcmbinvoicing_method" value='<s:property value="hidcmbinvoicing_method"/>'/></td>
    <td align="right" class="formfont">Del. Charges</td>
    <td><select id="cmbdel_charges" name="cmbdel_charges" value='<s:property value="cmbdel_charges"/>'>
      <option value="">--Select--</option>
      <option value=1>Yes</option>
      <option value=0>No</option></select>
      <input type="hidden" id="hidcmbdel_charges" name="hidcmbdel_charges" value='<s:property value="hidcmbdel_charges"/>'/></td>
  </tr>
</table>
</fieldset>
<table width="100%">
<tr><td width="60%">
<fieldset>
<table width="100%">
  <tr>
    <td width="15%" align="right" class="formfont">Account Group</td>
    <td width="16%"><select id="cmbgroup1" name="cmbgroup1"  style="width:100%;" value='<s:property value="cmbgroup1"/>'>
      <option value="">--Select--</option></select>
       <input type="hidden" id="hidcmbgroup1" name="hidcmbgroup1" value='<s:property value="hidcmbgroup1"/>'/></td>
   <td colspan="3"  align="right" class="formfont">Account</td>
    <td width="33%"><input type="text" id="txtaccount" name="txtaccount" style="width:50%;" tabindex="-1" value='<s:property value="txtaccount"/>'/></td>
  </tr>
  <tr>
    <td align="right" class="formfont">Credit Period-Min(Days)</td>
    <td><input type="text" id="txtcredit_period_min" name="txtcredit_period_min" style="width:70%;text-align: right;" value='<s:property value="txtcredit_period_min"/>'/></td>
    <td width="8%" align="right" class="formfont">Max(Days)</td>
    <td width="19%"><input type="text" id="txtcredit_period_max" name="txtcredit_period_max" style="width:50%;text-align: right;" value='<s:property value="txtcredit_period_max"/>'/></td>
    <td width="9%" align="right" class="formfont">Credit Limit</td>
    <td><input type="text" id="txtcredit_limit" name="txtcredit_limit" style="width:50%;text-align: right;" value='<s:property value="txtcredit_limit"/>'/></td>
  </tr>
</table>
</fieldset></td>
<td width="40%">
<fieldset>
<legend>Service Charge</legend>
<table width="100%">
  <tr>
    <td width="40%" align="left" class="formfont"><input type="checkbox" id="chckdefault" name="chckdefault" value="" onchange="defaultcheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)">Default
                                 <input type="hidden" id="hidchckdefault" name="hidchckdefault" value='<s:property value="hidchckdefault"/>'/></td>
    <td width="4%" align="right" class="formfont">Salik</td>
    <td width="37%"><input type="text" id="txtsalik" name="txtsalik" style="text-align: right;"  value='<s:property value="txtsalik"/>'/></td>
    <td width="4%" align="right" class="formfont">Traffic</td>
    <td width="15%"><input type="text" id="txttraffic" name="txttraffic" style="text-align: right;"  value='<s:property value="txttraffic"/>'/></td>
  </tr>
</table>
</fieldset>
</td>
</tr></table>
<br/>

<fieldset><legend>Driver Details</legend>
<div id="jqxDriver1"><jsp:include page="driver.jsp"></jsp:include></div><br />
</fieldset>

<fieldset><legend>Know Your Customer</legend>
<table class="table1" style="border-collapse:collapse;" width="100%">
                <thead>
                    <tr> 
                        <th></th>
                        <th scope="col" abbr="personal" style="background: #D1D1D1;">Personal Details</th>
                        <th scope="col" abbr="office">Office Details</th>
                        <th scope="col" abbr="residence">Residence Details</th>
                        <th scope="col" abbr="home">Home Details</th>
                    </tr>
                </thead>
                
                <tbody>
                    <tr>
                        <th scope="row">Address 1</th>
                        <td align="left" style="background: #D5D5D5;"><input type="text" id="txtpersonal_add1" name="txtpersonal_add1" style="width:80%;" tabindex="3" value='<s:property value="txtpersonal_add1"/>'/></td>
                        <td align="left"><input type="text" id="txtoffice_add1" name="txtoffice_add1" style="width:80%;" tabindex="11" value='<s:property value="txtoffice_add1"/>'/></td>
                        <td align="left"><input type="text" id="txtresidence_add1" name="txtresidence_add1" style="width:80%;" tabindex="19" value='<s:property value="txtresidence_add1"/>'/></td>
                        <td align="left"><input type="text" id="txthome_add1" name="txthome_add1" style="width:80%;" tabindex="27" value='<s:property value="txthome_add1"/>'/></td>
                    </tr>
                    <tr>
                        <th scope="row">Address 2</th>
                        <td align="left" style="background: #D5D5D5;"><input type="text" id="txtpersonal_add2" name="txtpersonal_add2" style="width:80%;" tabindex="4" value='<s:property value="txtpersonal_add2"/>'/></td>
                        <td align="left"><input type="text" id="txtoffice_add2" name="txtoffice_add2" style="width:80%;" tabindex="12" value='<s:property value="txtoffice_add2"/>'/></td>
                        <td align="left"><input type="text" id="txtresidence_add2" name="txtresidence_add2" style="width:80%;" tabindex="20" value='<s:property value="txtresidence_add2"/>'/></td>
                        <td align="left"><input type="text" id="txthome_add2" name="txthome_add2" style="width:80%;" tabindex="28" value='<s:property value="txthome_add2"/>'/></td>
                    </tr>
                    <tr>
                        <th scope="row">Telephone</th>
                        <td align="left" style="background: #D5D5D5;"><input type="text" id="txtpersonal_tel1" name="txtpersonal_tel1" style="width:80%;" tabindex="5" value='<s:property value="txtpersonal_tel1"/>'/></td>
                        <td align="left"><input type="text" id="txtoffice_tel1" name="txtoffice_tel1" style="width:80%;" tabindex="13" value='<s:property value="txtoffice_tel1"/>'/></td>
                        <td align="left"><input type="text" id="txtresidence_tel1" name="txtresidence_tel1" style="width:80%;" tabindex="21" value='<s:property value="txtresidence_tel1"/>'/></td>
                        <td align="left"><input type="text" id="txthome_tel1" name="txthome_tel1" style="width:80%;" tabindex="29" value='<s:property value="txthome_tel1"/>'/></td>
                    </tr>
                    <tr>
                        <th scope="row">Mobile</th>
                        <td align="left" style="background: #D5D5D5;"><input type="text" id="personal_tel2" name="personal_tel2" style="width:80%;" onblur="mobileValid(this.value);" tabindex="6" value='<s:property value="personal_tel2"/>'/></td>
                        <td align="left"><input type="text" id="office_tel2" name="office_tel2" style="width:80%;" onblur="mobileValid(this.value);" tabindex="14" value='<s:property value="office_tel2"/>'/></td>
                        <td align="left"><input type="text" id="residence_tel2" name="residence_tel2" style="width:80%;" onblur="mobileValid(this.value);" tabindex="22" value='<s:property value="residence_tel2"/>'/></td>
                        <td align="left"><input type="text" id="home_tel2" name="home_tel2" style="width:80%;" onblur="mobileValid(this.value);" tabindex="30" value='<s:property value="home_tel2"/>'/></td>
                    </tr>
                    <tr>
                        <th scope="row">Fax</th>
                        <td align="left" style="background: #D5D5D5;"><input type="text" id="txtpersonal_fax" name="txtpersonal_fax" style="width:80%;" tabindex="7" value='<s:property value="txtpersonal_fax"/>'/></td>
                        <td align="left"><input type="text" id="txtoffice_fax" name="txtoffice_fax" style="width:80%;" tabindex="15" value='<s:property value="txtoffice_fax"/>'/></td>
                        <td align="left"><input type="text" id="txtresidence_fax" name="txtresidence_fax" style="width:80%;" tabindex="23" value='<s:property value="txtresidence_fax"/>'/></td>
                        <td align="left"><input type="text" id="txthome_fax" name="txthome_fax" style="width:80%;" tabindex="31" value='<s:property value="txthome_fax"/>'/></td>
                    </tr>
                    <tr>
                        <th scope="row">Email</th>
                        <td align="left" style="background: #D5D5D5;"><input type="text" id="txtpersonal_email" name="txtpersonal_email" placeholder="someone@example.com" style="width:80%;" tabindex="8" value='<s:property value="txtpersonal_email"/>'/></td>
                        <td align="left"><input type="text" id="txtoffice_email" name="txtoffice_email" placeholder="someone@example.com" style="width:80%;" tabindex="16" value='<s:property value="txtoffice_email"/>'/></td>
                        <td align="left"><input type="text" id="txtresidence_email" name="txtresidence_email" placeholder="someone@example.com" style="width:80%;" tabindex="24" value='<s:property value="txtresidence_email"/>'/></td>
                        <td align="left"><input type="text" id="txthome_email" name="txthome_email" placeholder="someone@example.com" style="width:80%;" tabindex="32" value='<s:property value="txthome_email"/>'/></td>
                    </tr>
                    <tr>
                        <th scope="row">Contact</th>
                        <td align="left" style="background: #D5D5D5;"><input type="text" id="txtpersonal_contact" name="txtpersonal_contact" style="width:80%;" tabindex="9" value='<s:property value="txtpersonal_contact"/>'/></td>
                        <td align="left"><input type="text" id="txtoffice_contact" name="txtoffice_contact" style="width:80%;" tabindex="17" value='<s:property value="txtoffice_contact"/>'/></td>
                        <td align="left"><input type="text" id="txtresidence_contact" name="txtresidence_contact" style="width:80%;" tabindex="25" value='<s:property value="txtresidence_contact"/>'/></td>
                        <td align="left"><input type="text" id="txthome_contact" name="txthome_contact" style="width:80%;" tabindex="33" value='<s:property value="txthome_contact"/>'/></td>
                    </tr>
                    <tr>
                        <th scope="row">Extn. No.</th>
                        <td align="left" style="background: #D5D5D5;"><input type="text" id="txtpersonal_extn_no" name="txtpersonal_extn_no" style="width:80%;" tabindex="10" value='<s:property value="txtpersonal_extn_no"/>'/></td>
                        <td align="left"><input type="text" id="txtoffice_extn_no" name="txtoffice_extn_no" style="width:80%;" tabindex="18" value='<s:property value="txtoffice_extn_no"/>'/></td>
                        <td align="left"><input type="text" id="txtresidence_extn_no" name="txtresidence_extn_no" style="width:80%;" tabindex="26" value='<s:property value="txtresidence_extn_no"/>'/></td>
                        <td align="left"><input type="text" id="txthome_extn_no" name="txthome_extn_no" style="width:80%;" tabindex="34" value='<s:property value="txthome_extn_no"/>'/></td>
                    </tr>
                </tbody>
            </table>
</fieldset>

<fieldset><legend>Others</legend>
<table width="100%">
<tr><td width="50%">
<fieldset>
<legend>Reference Details</legend>
 <div id="jqxReferenceDetails1"><jsp:include page="referenceDetails.jsp"></jsp:include></div><br/>
</fieldset>
</td>
<td width="50%">
<fieldset>
<legend>Sponsor Details</legend>
<table width="100%">
  <tr>
    <td width="7%" align="right" class="formfont">Name</td>
    <td colspan="5"><input type="text" id="txtname" name="txtname" style="width:55%;" value='<s:property value="txtname"/>'/></td>
  </tr>
  <tr>
    <td align="right" class="formfont">Address</td>
    <td colspan="5"><input type="text" id="txtaddress" name="txtaddress" style="width:79%;" value='<s:property value="txtaddress"/>'/></td>
  </tr>
  <tr>
    <td align="right" class="formfont">Telephone</td>
    <td width="30%"><input type="text" id="txttelephone" name="txttelephone" style="width:80%;" value='<s:property value="txttelephone"/>'/></td>
    <td width="4%" align="right" class="formfont">ID.</td>
    <td width="14%"><input type="text" id="txtid" name="txtid" style="width:80%;" value='<s:property value="txtid"/>'/></td>
    <td width="7%" align="right" class="formfont">Nationality</td>
    <td width="38%"><select id="cmbnationality" name="cmbnationality" style="width:50%;" value='<s:property value="cmbnationality"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbnationality" name="hidcmbnationality" value='<s:property value="hidcmbnationality"/>'/></td>
  </tr>
  <tr>
    <td align="right" class="formfont">Security</td>
    <td><input type="text" id="txtsecurity" name="txtsecurity" style="width:80%;" value='<s:property value="txtsecurity"/>'/></td>
    <td colspan="4"><input type="text" id="txtsecurity1" name="txtsecurity1" style="width:70%;" value='<s:property value="txtsecurity1"/>'/></td>
  </tr>
</table>
<br/><br/><br/><br/><br/>
</fieldset>
</td>
</tr>
</table>
</fieldset>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
<input type="hidden" id="txtmobilevalidation" name="txtmobilevalidation" value='<s:property value="txtmobilevalidation"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
<input type="hidden" id="referencelength" name="referencelength"/>
<input type="hidden" id="attachlength" name="attachlength"/>
</div>
</form>
</div>
</body>
</html>
