<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>     
<% String contextPath=request.getContextPath(); %>   

<style>
/* =========================================================
SCOPED UI: Modern Layout (Matches Client Master)
========================================================= */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 5px 15px;
    box-sizing: border-box;
    width: 100%;
}

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"],
.modern-ui select { 
    height: 24px !important; 
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus { 
    border-color: #007bff; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled,
.modern-ui select:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

/* Layout Utilities */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: wrap;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Middle Section Panels */
.modern-ui .middle-panel {
    border: 1px solid #c5d3e0; 
    padding: 20px 10px 10px 10px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 15px;
    margin-top: 12px;
}

.modern-ui .middle-panel-title { 
    position: absolute; 
    top: -12px;
    left: 10px; 
    background: #ffffff; 
    padding: 0 8px; 
    color: #0056b3;
    font-weight: bold; 
    font-size: 14px; 
    border-left: 3px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
}

/* Custom UI Buttons matching 24px height */
.modern-ui .myButton {
    height: 24px !important;
    line-height: 22px !important;
    padding: 0 12px;
    font-family: Arial, sans-serif;
    font-size: 11px;
    font-weight: bold;
    border-radius: 3px;
    cursor: pointer;
    text-shadow: none;
    transition: all 0.2s;
    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    border: none;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    white-space: nowrap;
}
.modern-ui .myButton:hover { background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); }

/* Search Icon Wrapper */
.modern-ui .input-search-container {
    position: relative;
    display: flex;
}
.modern-ui .input-search-container input {
    padding-right: 25px !important;
}
.modern-ui .magnifier-icon {
    position: absolute;
    right: 6px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #64748b; 
    z-index: 10;
}
.modern-ui .magnifier-icon:hover { color: #2563eb; }

/* Grid Wrappers */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 120px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

form label.error { color:red; font-weight:bold; }
#errormsg { color:red; font-weight:bold; text-align:center; margin-bottom: 10px; }
</style>

<%
String modes =request.getParameter("modes")==null?"0":request.getParameter("modes").toString();

System.out.println("====masterdocno===="+request.getParameter("mastertrno"));

String mastertrno =request.getParameter("mastertrno")==null?"0":request.getParameter("mastertrno").toString();
String masterdocno =request.getParameter("masterdocno")==null?"0":request.getParameter("masterdocno").toString();
String isassign =request.getParameter("isassign")==null?"0":request.getParameter("isassign").toString();
%>


<script type="text/javascript">
var modes='<%=modes%>';
var mastertrno='<%=mastertrno%>';
var masterdocno='<%=masterdocno%>';
      $(document).ready(function () {
    	   
    	     
    	     
    	  /* Date */
    	  $("#clientDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    	  
    	  /* force internal alignment AFTER render */
 		 setTimeout(function () {
 		 	$("#clientDate").find("input").css({
 		 		"margin-top": "0px",
 		 		"line-height": "24px",
 		 		"font-size": "12px", 
 		 		"font-family": "Arial, sans-serif", 
 		 		"padding": "0 6px", 
 		 		"box-sizing":"border-box"
 		 	});
 		 	$("#clientDate").find(".jqx-action-button").css({
 		 		"top": "0px",
 		 		"height": "24px"
 		 	});
 		 }, 0);
    	  
    	  $('#areainfowindow').jqxWindow({ width: '55%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    	  $('#areainfowindow').jqxWindow('close');
    	  $('#countryinfowindow').jqxWindow({ width: '20%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Country Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    	  $('#countryinfowindow').jqxWindow('close');
    	  $('#activityinfowindow').jqxWindow({ width: '20%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Activity Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    	  $('#activityinfowindow').jqxWindow('close');
    	  $('#Salesagentinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'SalesMan Search' ,position: { x: 200, y: 120 }, keyboardCloseKey: 27});
		  $('#Salesagentinfowindow').jqxWindow('close');
    	  getGroup();
    	  getCategory();
    	  getCurrency();
    	  
    	  $('#txtarea').dblclick(function(){
    		  $('#areainfowindow').jqxWindow('open');
			  areaSearchContent('area.jsp?getarea=0');
			  });
    	  
    	  $('#txtsalman').dblclick(function(){
    		  $('#Salesagentinfowindow').jqxWindow('open');
    	      salesagentSearchContent('SearchSalesman.jsp?', $('#Salesagentinfowindow'));
			  });
    	  
    	  $('#txtcountry').dblclick(function(){
    		  $('#countryinfowindow').jqxWindow('open');
    		  countrySearchContent('country.jsp'); 
			  });
    	  
    	  
    	  
      }); 
      
      function  funReadOnly(){
    	  
    	  
    		$('#frmClientMaster input').attr('disabled', true );
    		$('#frmClientMaster textarea').attr('disabled', true );
    		$('#frmClientMaster select').attr('disabled', true);
    		$('#cpDetailsGrid').jqxGrid({ disabled: true});
    		 $('#mode').attr('disabled', false);
    		 $('#formdetailcode').attr('disabled', false);
    		 $('#docno').attr('disabled', false);
    		
    		 if(modes=="view")
    			{         
    			
    			document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
    			document.getElementById("formdetail").value=window.parent.formName.value;
    			document.getElementById("formdetailcode").value=window.parent.formCode.value.trim();
    			
    			 $('#maintrno').attr('disabled', false);
    			 $('#txtcode').attr('disabled', false);
    			 $('#mode').attr('disabled', false);
    			 document.getElementById("maintrno").value=mastertrno;
    			 document.getElementById("txtcode").value=mastertrno;   
    			  //document.getElementById("docno").value=masterdocno;     
    			document.getElementById("mode").value=modes;
    			alert(modes+"==="+mastertrno);
    			document.getElementById("frmClientMaster").submit();          
    			
    		/* 	
    		
    			 var names = [];
    			$("form").each(function() {
    			  //alert(this.id);
    			   names.push(this.id);
    			}); 
    			var form=names[0];
    			   document.forms[form].submit(); 
    			 //  document.getElementById("frmClientMaster").submit();
    			    $('#maintrno').attr('disabled', false);
    			 //  $('#docno').attr('disabled', false);
    				 $('#mode').attr('disabled', false);  */
    			   
    			}
    		
    	}
      
      function funSearchLoad(){
    		changeContent('masterSearch.jsp', $('#window'));
    	}
      
      function funRemoveReadOnly(){
    	  
    		$('#frmClientMaster input').attr('disabled', false );
    		$('#frmClientMaster textarea').attr('disabled', false );
    		$('#frmClientMaster select').attr('disabled', false);
    		$('#cpDetailsGrid').jqxGrid({ disabled: false});
    		$('#txtsalman').attr('readonly',true);
    		//$("#cpGridDetails").load('cpGridDetails.jsp?cldocno=0');
    		if(document.getElementById("mode").value=='A')
    			{
			document.getElementById('chknontax').checked=true;
			$('#chknontax').val(1);
    			$("#cpDetailsGrid").jqxGrid('clear');
        		$("#cpDetailsGrid").jqxGrid("addrow", null, {});
    		document.getElementById("txtcredit_period_max").value=0.0;
      	    document.getElementById("txtcredit_period_min").value=0.0;
      	    document.getElementById("txtcredit_limit").value=0.0;
    			}
    		$('#insurTypeGrid').jqxGrid('addrow', null, {});
      
      }
      
      
      
      function getareas(event){
      	 var x= event.keyCode;
      	 //alert("x===="+x);
      	 if(x==114){
      	  $('#areainfowindow').jqxWindow('open');
     
                areaSearchContent('area.jsp?getarea=0');  	 }
       	 else{
       		
      		 }
             	 }
      
      /* function getareas(){
       	//alert("=========");
       	  $('#areainfowindow').jqxWindow('open');
                 areaSearchContent('area.jsp?getarea=0');
        	
         } */
             	 
 function areaSearchContent(url) {
 	 //alert(url);
      	 $.get(url).done(function (data) {
 			 //alert(data);
 	$('#areainfowindow').jqxWindow('setContent', data);

                    	}); 
          	}
 
 function getcountry(event){
  	 var x= event.keyCode;
  	 if(x==114){
  	  $('#countryinfowindow').jqxWindow('open');
  
     // $('#accountWindow').jqxWindow('focus');
            countrySearchContent('country.jsp');  	 }
   	 else{
  		 }
         	 }

         	 
function countrySearchContent(url) {
	 //alert(url);
  	 $.get(url).done(function (data) {
			 //alert(data);
	$('#countryinfowindow').jqxWindow('setContent', data);

                	}); 
      	}
      	
/* function getactivity(event){
 	 var x= event.keyCode;
 	 if(x==114){
 	  $('#activityinfowindow').jqxWindow('open');
 
    // $('#accountWindow').jqxWindow('focus');
           activitySearchContent('activity.jsp');  	 }
  	 else{
 		 }
        	 }
        	 
function activitySearchContent(url) {
	 //alert(url);
 	 $.get(url).done(function (data) {
			 //alert(data);
	$('#activityinfowindow').jqxWindow('setContent', data);

               	}); 
     	} */
 
 function getCurrency()
	{
     		
     		
		var x=new XMLHttpRequest();
		var items,currIdItems,mcloseItems,currCodeItems;
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
					items= x.responseText;
			        items=items.split('####');
			        currIdItems=items[0].split(",");
			        currCodeItems=items[1].split(",");
			      	$('#insurtypegridconfig').val(items[2].trim()); 
			      	//alert($('#insurtypegridconfig').val());
			      	if($('#insurtypegridconfig').val()=='1'){
			    		$('#fieldsetinsurtype').show();
			    	}
			    	else{
			    		$('#fieldsetinsurtype').hide();
			    	} 
			        var optionscurr = '';  
		            for ( var i = 0; i < currCodeItems.length; i++) {
				    	   optionscurr += '<option value="' + currIdItems[i] + '">' + currCodeItems[i] + '</option>';
				        }
		            $("select#currencyid").html(optionscurr);
		        	window.parent.monthclosed.value=mcloseItems;
		        	
				}
			else
				{
				}
			
			if($('#hidcmbcurrencyid').val()){
	   			$("#currencyid").val($('#hidcmbcurrencyid').val());
	   		}
		}
		x.open("GET","getCurrency.jsp",true);
		x.send();
	}
 
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
				$("select#cmbacgroup").html(optionsgroup);
				
			} else {
			}
			//alert("======"+$('#hidcmbacgroup').val());
			if ($('#hidcmbacgroup').val() != null) {
				$('#cmbacgroup').val($('#hidcmbacgroup').val());
			}
		}
		x.open("GET", "getGroup.jsp", true);
		x.send();
	}
 
/*  function getPrivillege() {
		
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var privillege  = items[0].split(",");
				var privillegeId = items[1].split(",");
				//var optionsdept = '<option value="" selected>-- Select -- </option>';
				var optionsdept='<option value="" selected>-- Select -- </option>';
				for (var i = 0; i < privillege.length; i++) {
					optionsdept += '<option  value="' + privillegeId[i].trim() +'">'
					+ privillege[i] + '</option>'; 
				
				}
				 $("select#cmbprivillege").html(optionsdept);
				 
			} else {}
			if($('#hidcmbprivillege').val()){
	   			$("#cmbprivillege").val($('#hidcmbprivillege').val());
	   		}
		}
		x.open("GET","getPrivillege.jsp", true);
		x.send();
	}  */
 
 function getCategoryAccountGroup(a) {
	
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
			    $('#hidcmbacgroup').val(items);
				
				if ($('#hidcmbgroup1').val() != null || $('#hidcmbacgroup').val() != "") {
					$('#cmbacgroup').val($('#hidcmbacgroup').val());
				}
			} else {
			}
		}
		x.open("GET", "getCategoryAccountGroup.jsp?category="+a, true);
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
				
			} else {
			}
			//alert("=========="+$('#hidcmbcategory').val());
			if ($('#hidcmbcategory').val() != null) {
				$('#cmbcategory').val($('#hidcmbcategory').val());
			}
		}
		x.open("GET", "getCategory.jsp", true);
		x.send();
	}


 
 function funFocus(){
	 document.getElementById("txtclient_name").focus();  
	
 }
 
 
 function mobileValid(value){
	   if(value!=""){ 
	    var phoneno = /^\d{12}$/;  
		if(value.match(phoneno)){
			document.getElementById("errormsg").innerText="";
			//$('#txtmobilevalidation').val(0);
			return true;
		}
		else{
			document.getElementById("errormsg").innerText="Invalid Mobile Number";
			//$('#txtmobilevalidation').val(1);
			return false;
		}
	    } 
	   return true;
}
 
 function validateEmail($email) {
	  var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
	  if(emailReg.test( $email )){
		  document.getElementById("errormsg").innerText="";
			//$('#txtmobilevalidation').val(0);
			return true;
		}
		else{
			document.getElementById("errormsg").innerText="Email Address Not Valid";
			//$('#txtmobilevalidation').val(1);
			return false;
		}
	  return true;
	}
 
 
 function vaildMail(emailaddress){
	 if( !validateEmail(emailaddress)) 
	 { 
		 document.getElementById("errormsg").innerText="Email Address Not Valid";
		 return false;
		 
	 }
	 else{
		 document.getElementById("errormsg").innerText="";
	 }
	 return true;
 }
 
 
 
 
 function funNotify(){	
	 
	 
	 
		var txtclient=document.getElementById("txtclient_name").value;
		
		//var acgroup=document.getElementById("cmbacgroup").value;
		
		var cmbcategory=document.getElementById("cmbcategory").value; 
		
		var currency=document.getElementById("currencyid").value;
		
		var tin=document.getElementById("txttinno").value;
		
		var cst=document.getElementById("txtcstno").value;
		  
		 var telephone=document.getElementById("txttelephone").value; 
		 
		 var mobile=document.getElementById("txtmobile").value;
		
		 if(telephone=="" && mobile=="")        
			{
			document.getElementById("errormsg").innerText=" Enter telephone or mobile number";    
			return 0;
			}
		if(cmbcategory=="")    
		{
		document.getElementById("errormsg").innerText=" Enter Category";    
		return 0;
		}
		
		if(txtclient=="")
		{
		document.getElementById("errormsg").innerText=" Enter Client Name";
		return 0;
		}
		
		
		if(!mobileValid($("#txtmobile").val())){
			 return 0;
		 }
		
		if(!validateEmail($("#txtemail").val())){
			 return 0;
		 }
		
		
		/* if(acgroup=="")
		{
		document.getElementById("errormsg").innerText=" Select Account Group";
		return 0;
		} */
		
		/* if(tin=="")
		{
		document.getElementById("errormsg").innerText=" Enter Tin No";
		return 0;
		}
		
		if(cst=="")
		{
		document.getElementById("errormsg").innerText="Enter Cst";
		return 0;
		} */
		
		 var rows = $("#cpDetailsGrid").jqxGrid('getrows');
		   
		    var len=0;
		   for(var i=0;i<rows.length;i++){
			   
		    var cpersion= $.trim(rows[i].cpersion);
		   
			if(cpersion.trim()!="" && typeof(cpersion)!="undefined" && typeof(cpersion)!="NaN" )
				{
				
				
				newTextBox = $(document.createElement("input"))
			       .attr("type", "dil")
			       .attr("id", "test"+len)
			       .attr("name", "test"+len)
			       .attr("hidden", "true");
			    
				   
				
		   newTextBox.val(rows[i].cpersion+"::"+rows[i].mobile+" :: "
				   +rows[i].phone+" :: "+rows[i].extn+" :: "+rows[i].email+" :: "+rows[i].area+" :: "+rows[i].areaid+" :: "+rows[i].activity_id+"");
		   
		   newTextBox.appendTo('form'); 
		   
		   len=len+1;
				 }
		   
		   }
		   $('#cpgridlength').val(len);
		   if($('#insurtypegridconfig').val()=='1'){
		   	var insurrows = $("#insurTypeGrid").jqxGrid('getrows');
		   	var insurlength=0;
		   	for(var k=0;k<insurrows.length;k++){
		   		var insurtypename=$.trim(insurrows[k].typename)
				if(insurtypename!="" && typeof(insurtypename)!="undefined" && typeof(insurtypename)!="NaN" && insurtypename!=null)
				{
					newTextBox = $(document.createElement("input"))
			       		.attr("type", "dil")
			       		.attr("id", "testinsur"+k)
			      		.attr("name", "testinsur"+k)
			       		.attr("hidden", "true");
			    
		   			newTextBox.val(insurtypename+" :: "+insurrows[k].rowno+" :: "+insurrows[k].srno);
		   			newTextBox.appendTo('form'); 
		   			insurlength++;
		   		}
		   	}
		   	$('#insurtypegridlength').val(insurlength);
		   
		   }
		   else{
		   	$('#insurtypegridlength').val(0);
		   }
			
		   return 1;
		
 }
 
 
 function setValues() {
	 
	 document.getElementById("formdetail").value="Client";
     document.getElementById("formdetailcode").value="CRM";
     document.getElementById("formdet").innerText="Client(CRM)";
	 window.parent.formCode.value="CRM";
	 window.parent.formName.value="Client"; 
	 var chknontax=$("#chknontax").val();
		
		if(chknontax>0){
			document.getElementById("chknontax").checked=true;
		}
	  var maindoc=document.getElementById("txtcode").value;
	  if(maindoc>0)
		  {
	 
    var indexVal1 = document.getElementById("txtcode").value;
   
     
    
   $("#cpGridDetails").load('cpGridDetails.jsp?cldocno='+indexVal1);
	  $("#insurtypegriddiv").load('insurTypeGrid.jsp?cldocno='+indexVal1+'&id=1');
  
		  }
 		
	  
 		if(!($('#hidcmbcurrencyid').val()=="")){
 			$("#currencyid").val($('#hidcmbcurrencyid').val());
 		}
 		if(!($('#hidcmbprivillege').val()=="")){
 			$("#cmbprivillege").val($('#hidcmbprivillege').val());
 		}
  
 	   if($('#msg').val()!=""){
 		   $.messager.alert('Message',$('#msg').val());
 		   
 		  }
 	   
 	 delvalueChange();
 	/*document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")"; */
 	
 }
 
 function delvalueChange()
 {

 	  
 }
 
 
 function getsalesAgent(event){
     	 var x= event.keyCode;
     	 if(x==114){
     	  $('#Salesagentinfowindow').jqxWindow('open');
     
       
      salesagentSearchContent('SearchSalesman.jsp?', $('#Salesagentinfowindow')); }
     	 else{
     		 }
     	 }

  function salesagentSearchContent(url) {
               //alert(url);
                 $.get(url).done(function (data) {
        //alert(data);
	           $('#Salesagentinfowindow').jqxWindow('setContent', data);

       	}); 
   }

      
</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmClientMaster" action="clientmaster" method="post" autocomplete="off">

<jsp:include page="../../../../header.jsp"></jsp:include>
   
<div class='modern-ui hidden-scrollbar'>
    <div id="errormsg"></div>
    
    <div class="middle-panel">
        <span class="middle-panel-title">Client Details</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 125px;">
                <div id="clientDate" name="clientDate" value='<s:property value="clientDate"/>'></div>
            </div>
            <input type="hidden" id="hidClientDate" name="hidClientDate" value='<s:property value="hidClientDate"/>'/>
            
            <label class="lbl-right" style="width:60px;">Code</label>
            <input type="text" id="txtcode" readonly="true" name="txtcode" style="width:100px;" tabindex="-1" value='<s:property value="txtcode"/>'/>
            
            <label class="lbl-right" style="width:60px;">Name</label>
            <input type="text" id="txtclient_name" name="txtclient_name" style="flex:1;" value='<s:property value="txtclient_name"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No.</label>
            <input type="text" id="docno" readonly="true" name="docno" style="width:125px;" tabindex="-1" value='<s:property value="docno"/>'/>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Category</label>
            <select id="cmbcategory" name="cmbcategory" style="width:125px;" onchange="getCategoryAccountGroup(this.value);" value='<s:property value="cmbcategory"/>'>
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbcategory" name="hidcmbcategory" value='<s:property value="hidcmbcategory"/>'/>
            
            <label class="lbl-right" style="width:80px;">Acct Group</label>
            <select id="cmbacgroup" name="cmbacgroup" style="width:125px;" value='<s:property value="cmbacgroup"/>'>
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbacgroup" name="hidcmbacgroup" value='<s:property value="hidcmbacgroup"/>'/>
            
            <label class="lbl-right" style="width:80px;">Sales Man</label>
            <div class="input-search-container" style="flex:1;">
                <input type="text" id="txtsalman" name="txtsalman" placeholder="Press F3" value='<s:property value="txtsalman"/>' onKeyDown="getsalesAgent(event);"/>
                <svg class="magnifier-icon" onclick="$('#txtsalman').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Account</label>
            <input type="text" id="txtaccount" readonly="true" name="txtaccount" style="width:125px;" tabindex="-1" value='<s:property value="txtaccount"/>'/>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Tin. No</label>
            <input type="text" id="txttinno" name="txttinno" style="width:125px;" value='<s:property value="txttinno"/>'/>
            
            <label class="lbl-right" style="width:80px;">CST No</label>
            <input type="text" id="txtcstno" name="txtcstno" style="width:125px;" value='<s:property value="txtcstno"/>'/>
            
            <label class="lbl-right" style="width:100px;">Credit Period-Min(Days)</label>
            <input type="text" id="txtcredit_period_min" name="txtcredit_period_min" style="width:60px; text-align:right;" value='<s:property value="txtcredit_period_min"/>'/>
            
            <label class="lbl-right" style="width:60px;">Max(Days)</label>
            <input type="text" id="txtcredit_period_max" name="txtcredit_period_max" style="width:60px; text-align:right;" value='<s:property value="txtcredit_period_max"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Credit Limit</label>
            <input type="text" id="txtcredit_limit" name="txtcredit_limit" style="width:125px; text-align:right;" value='<s:property value="txtcredit_limit"/>'/>
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label style="display:flex; align-items:center; gap:5px; cursor:pointer; font-size:12px; font-weight:bold; color:#444; margin-left: 85px;">
                <input type="checkbox" name="chknontax" id="chknontax" value='<s:property value="chknontax" />' onclick="$(this).attr('value', this.checked ? 1 : 0);" style="width:15px; height:15px; margin:0;">
                Taxable Entity
            </label>
            
            <label class="lbl-right" style="width:80px; margin-left:20px;">Privilege</label>
            <select id="cmbprivillege" name="cmbprivillege" style="width:125px;" value='<s:property value="cmbprivillege"/>'>
                <option value="0">--Select--</option>
                <option value="1">Platinum</option>
                <option value="2">Gold</option>
                <option value="3">Bronze</option>
                <option value="4">Grey</option>
                <option value="5">Red</option>
            </select>
            <input type=hidden id="hidcmbprivillege" name="hidcmbprivillege" value='<s:property value="hidcmbprivillege"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Currency</label>
            <select id="currencyid" name="currencyid" style="width:125px;" value='<s:property value="currencyid"/>'>
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbcurrencyid" name="hidcmbcurrencyid" value='<s:property value="hidcmbcurrencyid"/>'/>
        </div>
    </div>

    <div class="middle-panel">
        <span class="middle-panel-title">Additional Information</span>
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:100px;">Financial Name</label>
            <input type="text" id="txtfinname" name="txtfinname" style="width:250px;" value='<s:property value="txtfinname"/>'/>
            
            <label class="lbl-right" style="width:110px;">Financial Address</label>
            <input type="text" id="txtfinaddress" name="txtfinaddress" style="flex:1;" value='<s:property value="txtfinaddress"/>'/>
        </div>
    </div>

    <div style="display: flex; gap: 15px;">
        <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
            <span class="middle-panel-title">Communication Details</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Address</label>
                <input type="text" id="txtaddress" name="txtaddress" style="flex:1;" value='<s:property value="txtaddress"/>'/>
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Telephone</label>
                <input type="text" id="txttelephone" name="txttelephone" style="width:150px;" value='<s:property value="txttelephone"/>'/>
                
                <label class="lbl-right" style="width:80px;">Extn. No.</label>
                <input type="text" id="txtextnno" name="txtextnno" style="flex:1;" value='<s:property value="txtextnno"/>'/>
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Mobile</label>
                <input type="text" id="txtmobile" name="txtmobile" style="width:150px;" onblur="mobileValid(this.value);" placeholder="With country code" value='<s:property value="txtmobile"/>'/>
                
                <label class="lbl-right" style="width:80px;">Fax</label>
                <input type="text" id="txtfax" name="txtfax" style="flex:1;" value='<s:property value="txtfax"/>'/>
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Email</label>
                <input type="text" id="txtemail" name="txtemail" placeholder="someone@example.com" onblur="validateEmail(this.value);" style="flex:1;" value='<s:property value="txtemail"/>'/>
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Web</label>
                <input type="text" id="txtweb" name="txtweb" style="flex:1;" value='<s:property value="txtweb"/>'/>
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Contact</label>
                <input type="text" id="txtcontact" name="txtcontact" style="flex:1;" value='<s:property value="txtcontact"/>'/>
            </div>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px;">Area</label>
                <div class="input-search-container" style="width: 150px;">
                    <input type="text" id="txtarea" name="txtarea" readonly="true" placeholder="Press F3" value='<s:property value="txtarea"/>' onKeyDown="getareas(event);"/>
                    <svg class="magnifier-icon" onclick="$('#txtarea').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                <input type="text" id="txtareadet" name="txtareadet" readonly="true" style="flex:1;" value='<s:property value="txtareadet"/>'/>
                <input type="hidden" id="txtareaid" name="txtareaid" value='<s:property value="txtareaid"/>'/>
            </div>
        </div>

        <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
            <span class="middle-panel-title">Bank Information</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Account No.</label>
                <input type="text" id="txtaccountno" name="txtaccountno" style="flex:1;" value='<s:property value="txtaccountno"/>'/>
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Bank Name</label>
                <input type="text" id="txtbankname" name="txtbankname" style="flex:1;" value='<s:property value="txtbankname"/>'/>
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Branch Name</label>
                <input type="text" id="txtbranchname" name="txtbranchname" style="flex:1;" value='<s:property value="txtbranchname"/>'/>
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Branch Address</label>
                <input type="text" id="txtbranchaddress" name="txtbranchaddress" style="flex:1;" value='<s:property value="txtbranchaddress"/>'/>
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Swift No.</label>
                <input type="text" id="txtswiftno" name="txtswiftno" style="width:150px;" value='<s:property value="txtswiftno"/>'/>
                
                <label class="lbl-right" style="width:80px;">IBAN No.</label>
                <input type="text" id="txtibanno" name="txtibanno" style="flex:1;" value='<s:property value="txtibanno"/>'/>
            </div>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:100px;">City</label>
                <input type="text" id="txtcity" name="txtcity" style="width:150px;" value='<s:property value="txtcity"/>'/>
                
                <label class="lbl-right" style="width:80px;">Country</label>
                <div class="input-search-container" style="flex:1;">
                    <input type="text" id="txtcountry" name="txtcountry" placeholder="Press F3" value='<s:property value="txtcountry"/>' readonly="true" onKeyDown="getcountry(event);"/>
                    <svg class="magnifier-icon" onclick="$('#txtcountry').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                
                <input type="hidden" id="cityid" name="cityid" value='<s:property value="cityid"/>'/>
                <input type="hidden" id="countryid" name="countryid" value='<s:property value="countryid"/>'/>
                <input type="hidden" id="salid" name="salid" value='<s:property value="salid"/>'/>
            </div>
        </div>
    </div>

    <div class="middle-panel">
        <span class="middle-panel-title">Contact Person Details</span>
        <div id="cpGridDetails" class="grid-container"> 
            <jsp:include page="cpGridDetails.jsp"></jsp:include>
        </div>
    </div>

    <div class="middle-panel" id="fieldsetinsurtype">
        <span class="middle-panel-title">Insurance Type Details</span>
        <div id="insurtypegriddiv" class="grid-container"> 
            <jsp:include page="insurTypeGrid.jsp"></jsp:include>
        </div>
    </div> 

    <!-- Hidden Logic Fields -->
    <div style="display:none;">
        <input type="hidden" id="cpgridlength" name="cpgridlength"/>
        <input type="hidden" id="insurtypegridlength" name="insurtypegridlength"/>
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>    
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" name="maintrno" id="maintrno" value='<s:property value="maintrno"/>'/>
        <input type="hidden" name="insurtypegridconfig" id="insurtypegridconfig" value='<s:property value="insurtypegridconfig"/>'/>
    </div>
</div>   
</form>

<!-- Search Windows -->
<div id="areainfowindow"><div></div></div>
<div id="countryinfowindow"><div></div></div>
<div id="activityinfowindow"><div></div></div>
<div id="Salesagentinfowindow"><div></div></div>

</div>
</body>
</html>