<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../includes.jsp"></jsp:include>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<style type="text/css">
.icon {
	width: 2em;
	height: 1em;
	border: none;
	background-color: #E0ECF8;
}
</style>

<script type="text/javascript">
	$(document).ready(function() {
		
		 $("#jqxRentalReceiptDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#jqxReferenceDate").jqxDateTimeInput({ width: '110px', height: '15px', formatString:"dd.MM.yyyy"});		 
	
		 $('#clientDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#clientDetailsWindow').jqxWindow('close'); 
		 
		 $('#cardDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Card Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#cardDetailsWindow').jqxWindow('close');
		 
		 $('#jqxRentalReceiptDate').on('change', function (event) {
				 var rentalreceiptdate = $('#jqxRentalReceiptDate').jqxDateTimeInput('getDate');
				 funDateInPeriod(rentalreceiptdate);
			 });
		 
		  $('#txtclientid').dblclick(function(){
			  var date = $('#jqxRentalReceiptDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  clientSearchContent("clientAccountDetailsSearch.jsp?atype=AR"+"&date="+date);
			  });
			  
		 $('#txtreceivedfrom').keydown(function (evt) {
			  if (evt.keyCode==9) {
			          event.preventDefault();
			          $('#jqxApplyInvoice').jqxGrid('selectcell',0, 'applying');
			          $('#jqxApplyInvoice').jqxGrid('focus',0, 'applying');
			  }
		 });
		 
		 
		 //Rounding
		 $('#txtapplyinvoicebalance').change(function(){
		 	var targetid=$(this).attr('id');
		 	var targetvalue=$(this).val();
		 	$('#'+targetid).val(funRoundAmt(targetvalue,targetid));
		 });
	});
	
	function clientSearchContent(url) {
	 	$('#clientDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientDetailsWindow').jqxWindow('setContent', data);
		$('#clientDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function cardSearchContent(url) {
	 	$('#cardDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#cardDetailsWindow').jqxWindow('setContent', data);
		$('#cardDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function checkIb(){
		 if(document.getElementById("hidchckib").value==1){
			 document.getElementById("chckib").checked = true;
		 }
		 else if(document.getElementById("hidchckib").value==0){
			document.getElementById("chckib").checked = false;
		  }
		 }
	
	 function funReadOnly(){
			$('#frmCommercialReceipt input').attr('readonly', true );
			$('#frmCommercialReceipt select').attr('disabled', true);
			$('#jqxRentalReceiptDate').jqxDateTimeInput({disabled: true});
			$('#jqxReferenceDate').jqxDateTimeInput({disabled: true});
			$('#btnCardSearch').attr('disabled', true);
			$("#jqxApplyInvoice").jqxGrid({ disabled: true});
			
	 }
	 function funRemoveReadOnly(){
		    getBranch();getCardTypes();checkIb();
			$('#frmCommercialReceipt input').attr('readonly', false );
			$('#frmCommercialReceipt select').attr('disabled', false);
			
			$('#jqxRentalReceiptDate').jqxDateTimeInput({disabled: false});
			$('#jqxReferenceDate').jqxDateTimeInput({disabled: false});
			$('#btnCardSearch').attr('disabled', true);
			$('#docno').attr('readonly', true);
			$('#txtdoctype').attr('readonly', true);
			$('#txtsrno').attr('readonly', true);
			$('#txtaccid').attr('readonly', true);
			$('#txtaccname').attr('readonly', true);
			$('#txtclientid').attr('readonly', true);
			$('#txtclientname').attr('readonly', true);
			$('#txtnetvalue').attr('readonly', true ); 
			$('#txtapplyinvoiceamt').attr('readonly', true );
			$('#txtapplyinvoiceapply').attr('readonly', true );
			$('#txtapplyinvoicebalance').attr('readonly', true );
			$('#cmbbranch').attr('disabled', true);
			$("#jqxApplyInvoice").jqxGrid({ disabled: false}); 
			
			if ($("#mode").val() == "E") {
				if($('#chkstatus').val()=="2"){
					$('#cmbpaytype').attr('disabled', true);
	   			    $('#chckib').attr('disabled', true);
	   			    $('#cmbbranch').attr('disabled', true);
	   			    $('#txtaccid').attr('readonly', true);
	 			    $('#txtaccname').attr('readonly', true);
				}else{
				    $('#cmbpaytype').attr('disabled', true);
	   			    $('#chckib').attr('disabled', true);
	   			    $('#cmbbranch').attr('disabled', true);
	   			    $('#txtaccid').attr('readonly', true);
	 			    $('#txtaccname').attr('readonly', true);
				}
			  }
			
			if ($("#mode").val() == "A") {
				if($('#chkstatus').val()=="1"){
					funchequedate();
				}else{
					$('#cmbpaytype').val('');$('#cmbcardtype').val('');
					$('#jqxRentalReceiptDate').val(new Date());
					$("#jqxApplyInvoice").jqxGrid('clear');
					$("#jqxApplyInvoice").jqxGrid('addrow', null, {});
				}
			}
	 }
	 
	 function funSearchLoad(){
	    changeContent('rrvMainSearch.jsp'); 
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus()
	    {
	    	$('#jqxRentalReceiptDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	 /* Validations */
	    $(function(){
	        $('#frmCommercialReceipt').validate({
	        	    rules: {
	                //txtfromaccid:"required",
	                txtamount:{number:true},
	                txtdiscount:{number:true},
	                txtaddcharges:{number:true},
	                txtdescription:{maxlength:500},
	                txtdescriptions:{maxlength:500}
	                 },
	                 messages: {
	                 //txtfromaccid:" *",
	                 txtamount:{number:"Invalid"},
	                 txtdiscount:{number:"Invalid"},
	                 txtaddcharges:{number:"Invalid"},
	                 txtdescription: {maxlength:"    Max 500 chars"},
	                 txtdescriptions: {maxlength:"    Max 500 chars"}
	                 }
	        });}); 
	   
	  function funNotify(){	
		  /* Validation */
		  
		    var rentalreceiptdate = $('#jqxRentalReceiptDate').jqxDateTimeInput('getDate');
			var validdate=funDateInPeriod(rentalreceiptdate);
			if(validdate==0){
			return 0;	
			}
			
			backdatevalid=document.getElementById("txtbackdatevalidation").value;
			 if(backdatevalid==1){
				 document.getElementById("errormsg").innerText="Past Date, Transaction Restricted.";
				 return 0;
			 }
			 
			ibvalid=document.getElementById("txtibvalidation").value;
			 if(ibvalid==1){
				 document.getElementById("errormsg").innerText="Closing Done For Inter-Branch,Transaction Restricted. ";
				 return 0;
			 }
			 
			 valid=document.getElementById("txtvalidation").value;
			 if(valid==1){
				 document.getElementById("errormsg").innerText="Invalid Transaction !!!";
				 return 0;
			 }
			 
			 if($('#txtcldocno').val()==''){
				 document.getElementById("errormsg").innerText="Client is Mandatory.";
				 return 0;
			 }
			 
			 if($('#cmbpaytype').val()=='2' && $('#cmbcardtype').val()==''){
				 document.getElementById("errormsg").innerText="Choose a Card Type.";
				 return 0;
			 }
		  
	    	document.getElementById("errormsg").innerText="";
	    		
	    /* Validation Ends*/
	    
	  	 		/* Apply Invoice Grid Saving */
	  	 		var rows = $("#jqxApplyInvoice").jqxGrid('getrows');
	  			var length=0;
	  			 for(var i=0 ; i < rows.length ; i++){
	  				var chk=rows[i].applying;
	  				if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
	  					newTextBox = $(document.createElement("input"))
	  				    .attr("type", "dil")
	  				    .attr("id", "txtapply"+length)
	  				    .attr("name", "txtapply"+length)
	  					.attr("hidden", "true");
	  					length=length+1;
	  					
	  				newTextBox.val(rows[i].applying+"::"+parseFloat(rows[i].out_amount+rows[i].applying)+"::"+rows[i].currency+"::"+rows[i].tranid+"::"+rows[i].acno);
	  				newTextBox.appendTo('form');
	  				}
	  			  }
	  			$('#applylength').val(length);
	  			 /* Apply Invoice Grid Saving Ends*/
	  			 
	  			 /* Apply Invoice Grid Updating */
	  		 		var rows = $("#jqxApplyInvoice").jqxGrid('getrows');
	  		 		var lengthupdate=0;
	  				 for(var i=0 ; i < rows.length ; i++){
	  					var chks=rows[i].applying;
		  				if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != ""){
		  					
	  						newTextBox = $(document.createElement("input"))
	  					    .attr("type", "dil")
	  					    .attr("id", "txtapplyupdate"+lengthupdate)
	  					    .attr("name", "txtapplyupdate"+lengthupdate)
	  						.attr("hidden", "true");
	  						lengthupdate=lengthupdate+1;
	  						
	  					newTextBox.val(parseFloat(rows[i].out_amount-rows[i].applying)+"::"+rows[i].tranid);
	  					newTextBox.appendTo('form');
	  				    }
	  				   }
	  				$('#applylengthupdate').val(lengthupdate);
	  				 /* Apply Invoice Grid Updating Ends*/
	  				 
	  				 $('#jqxRentalReceiptDate').jqxDateTimeInput({disabled: false});
			         $('#jqxReferenceDate').jqxDateTimeInput({disabled: false});
			         $('#cmbpaytype').attr('disabled', false);
		   			 $('#chckib').attr('disabled', false);
		   			 $('#cmbbranch').attr('disabled', false);
		   			 
	    		return 1;
		} 
	  
	  function setValues(){
		  getBranch();getCardTypes();checkIb();
		  
		  document.getElementById("cmbpaytype").value=document.getElementById("hidcmbpaytype").value;
		  document.getElementById("cmbcardtype").value=document.getElementById("hidcmbcardtype").value;
		  
		  if($('#chkstatus').val()=="1" || $('#chkstatus').val()=="2"){
				funchequedate();
			}

		  if($('#hidjqxRentalReceiptDate').val()){
				 $("#jqxRentalReceiptDate").jqxDateTimeInput('val', $('#hidjqxRentalReceiptDate').val());
			  }
		  
		  if($('#hidjqxReferenceDate').val()){
				 $("#jqxReferenceDate").jqxDateTimeInput('val', $('#hidjqxReferenceDate').val());
			  }
		  
		   if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		   
		   document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		   funSetlabel();
		
	         var indexVal1 = document.getElementById("txtacno").value;
	         var indexVal2 = document.getElementById("txttranno").value;
	         if(indexVal1>0){
	         $("#applyInvoicing1").load("applyInvoiceGrid.jsp?txttoaccid1="+indexVal1+"&txttotrno1="+indexVal2); 
	         } 
		}
	
	function getBranch() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var branchIdItems  = items[0].split(",");
  				var branchItems = items[1].split(",");
  				var optionsbranch = '<option value="">--Select--</option>';
  				for (var i = 0; i < branchItems.length; i++) {
  					optionsbranch += '<option value="' + branchIdItems[i].trim() + '">'
  							+ branchItems[i] + '</option>';
  				}
  				$("select#cmbbranch").html(optionsbranch);
  				if ($('#hidcmbbranch').val() != null) {
  					$('#cmbbranch').val($('#hidcmbbranch').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", <%=contextPath+"/"%>+"com/operations/commtransactions/getBranch.jsp", true);
  		x.send();
  	}
	 
	 function getAccounts(a){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText;
	  				items = items.split('####');
	  				var accountIdItems  = items[0];
	  				var accountItems = items[1];
	  				var docNoItems = items[2];
	  			$('#txtaccid').val(accountIdItems) ;
	  			$('#txtaccname').val(accountItems) ;
	  			$('#txtdocno').val(docNoItems) ;
	  		}
	  		}
	  		x.open("GET", "getAccounts.jsp?paytype="+a, true);
	  		x.send();
	 }
	 
	 function getCardTypes() {
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText;
	  				items = items.split('####');
	  				var cardIdItems  = items[0].split(",");
	  				var cardItems = items[1].split(",");
	  				var optionscard = '<option value="">--Select--</option>';
	  				for (var i = 0; i < cardItems.length; i++) {
	  					optionscard += '<option value="' + cardIdItems[i].trim() + '">'
	  							+ cardItems[i] + '</option>';
	  				}
	  				$("select#cmbcardtype").html(optionscard);
	  				if ($('#hidcmbcardtype').val() != null) {
	  					$('#cmbcardtype').val($('#hidcmbcardtype').val());
	  				}
	  			} else {
	  			}
	  		}
	  		x.open("GET", "getCardTypes.jsp", true);
	  		x.send();
	  }
	
	function funCardSearch(){
		cardSearchContent('cardDetailsSearchGrid.jsp?clientId='+$('#txtcldocno').val());
	}
       
    function getClient(event){
        var x= event.keyCode;
        if(x==114){
        	var date = $('#jqxRentalReceiptDate').jqxDateTimeInput('getDate');
			$("#maindate").jqxDateTimeInput('val', date);
        	clientSearchContent("clientAccountDetailsSearch.jsp?atype=AR"+"&date="+date);
        }
       }
    
    function funclearchequecardno(){
    	$('#txtrefno').val('');
    }
    
    function funCheck(a){
		  if(document.getElementById("chckib").checked != false){
		 		 $('#hidchckib').val(1);
		 		 $('#cmbbranch').attr('disabled', false );
		  }
		  else{
			  $('#hidchckib').val(0); 
			  $('#cmbbranch').attr('disabled', true );
		  }
	  }
	
    function funchequedate(){
    	  paytype=document.getElementById("cmbpaytype").value;
    	  if(paytype==3){
		      var chequedate = $('#jqxReferenceDate').jqxDateTimeInput('getDate');
			  var chequeDates =new Date(chequedate).setDate(chequedate.getDate()+1); 
			  $('#jqxReferenceDate').jqxDateTimeInput('setDate', new Date(chequeDates)); 
			  $('#cmbcardtype').attr('disabled', true);
			  $('#txtrefno').attr('readonly', false);
			  $('#btnCardSearch').attr('disabled', true);
    	  }
    	  else if(paytype==1){
    		  $('#cmbcardtype').attr('disabled', true); 
    		  $('#txtrefno').attr('readonly', true);
    		  $('#btnCardSearch').attr('disabled', true);
    		  
    	  }
    	  else if(paytype==2){
    		  $('#cmbcardtype').attr('disabled', false); 
    		  $('#txtrefno').attr('readonly', false);
    		  $('#btnCardSearch').attr('disabled', false);
    	  }
    }
    
    function getNetValue(){
        var amount = $('#txtamount').val();
        var discount = $('#txtdiscount').val();
        var additional = $('#txtaddcharges').val();
        var additionalamt = $('#txtamounts').val();
        var netamount=$('#txtnetvalue').val();
        
        if(amount!=''){
        	netamount=(parseFloat(amount));
      	}
        
        if(discount!=''){
      		netamount=((parseFloat(amount)-parseFloat(discount)));
      	}
     	
        if(additional!=''){
     	var chkaddamt=((parseFloat(amount)-parseFloat(discount))*(parseFloat(additional)/100));
     		$('#txtamounts').val(Math.round(chkaddamt*100)/100);
     		netamount=((parseFloat(amount)-parseFloat(discount))) + chkaddamt;
     		$('#txtnetvalue').val(Math.round(netamount*100)/100);
    	}
     
        if(additionalamt!=''){
     		netamount=((parseFloat(amount)-parseFloat(discount))+parseFloat(additionalamt));
     	}
        
     	//$('#txtnetvalue').val(Math.round(netamount*100)/100);
     	funRoundAmt((Math.round(netamount*100)/100),"txtnetvalue");
  }
    
    function getAmount(){
		  var amount = $('#txtamount').val();
		  if(!isNaN(amount)){
		  $('#txtapplyinvoiceamt').val(amount);
		  }
		  else if(isNaN(amount)){
			  $('#txtapplyinvoiceamt').val(0.00);
			  $('#txtamount').val(0.00);
			}
	  }
    
    function funPrintBtn(){
    	if (($("#mode").val() == "view") && $("#txtsrno").val()!="") {
	        var url=document.URL;
	        var reurl=url.split("saveCommercialReceipt");
	        $("#txtsrno").prop("disabled", false);                
	     
	        var win= window.open(reurl[0]+"printCommercialReceipt?srno="+document.getElementById("txtsrno").value+"&branch="+document.getElementById("brchName").value,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        win.focus();
	     }
	    else {
			$.messager.alert('Message','Select a Document....!','warning');
			return;
		}
    }
    
    function datechange(){
		  var date = $('#jqxRentalReceiptDate').jqxDateTimeInput('getDate');
		  var validdate=funDateInPeriod(date);
			if(validdate==0){
			return 0;	
			}
			var validbackdate=funBackDate(date);
			if(validbackdate==0){
			return 0;	
			}
		  $("#maindate").jqxDateTimeInput('val', date);
		  
		  if($('#hidchckib').val()==1){
			  if($('#cmbbranch').val()!='' && $('#cmbbranch').val()!=null){
				funIBDateInPeriod($('#jqxRentalReceiptDate').val(),$('#cmbbranch').val());
			  }
			}
	  }


function funSendmail()
 	{
 			
 		 if (($("#mode").val() == "view") && $("#docno").val()!="") {
 		  
 		if(document.getElementById("email").value=="")
 			{
 			document.getElementById("errormsg").innerText="Email Id Is Not Available.";  
 			return 0;
 			}
 		
 		
 		$("#overlay, #PleaseWait").show();

 		sample();
 		
 		 var recipient1=document.getElementById("email").value; 
     	var recipient=recipient1.replace(/ /g, "%20");
       	
     <%-- window.open("<%=contextPath%>/com/email/Email.jsp?formcode="+document.getElementById("formdetailcode").value+'&recipient='+recipient+'&code='+document.getElementById("docno").value,"E-Mail","menubar=0,resizable=1,width=900,height=525 "); --%>  
 		

     	//getMailservDets();
 		//sendmails();
 		
 		
 		
 		 }
 		else {
   	      $.messager.alert('Message','Select a Document....!','warning');
   	      return false;
   	     }
 		
 	}
 
 	function sample()
 	{  
 		var formcode=document.getElementById("formdetailcode").value;
 		var recep=document.getElementById("email").value.trim();
 		var branch=<%=session.getAttribute("BRANCHID").toString()%>;
 		
 		
 		$.ajaxFileUpload
    	  (  
    	      {  
    	    	
    	    	  url: 'rrjspToPdf.action?docno='+document.getElementById("txtsrno").value+"&formcode="+formcode+"&recep="+recep+"&branch="+branch,  
    	          secureuri:false,//false  
    	          fileElementId:'file', //id  <input type="file" id="file" name="file" />  
    	          dataType: 'string',// json  
    	          success: function (data, status)  //  
    	          {  
    	              // alert(status);
    	             if(status=='success'){
    	            	
    	            	    
						$("#overlay, #PleaseWait").hide();
    	            	 
    	            	 $.messager.show({title:'Message',msg:'E-Mail Send Successfully',showType:'show',
    	                       style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
    	                   });
    	                 
    	              }
    	             if(status=='error'){
    	            	 // $.messager.alert('Message',"E-Mail Sending failed");
    	            	 $.messager.show({title:'Message',msg:' E-Mail Sending failed',showType:'show',
    	                       style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
    	                   });
    	                    
    	             }
    	             
    	              $("#testImg").attr("src",data.message);
    	              if(typeof(data.error) != 'undefined')  
    	              {  
    	                  if(data.error != '')  
    	                  {  
    	                      alert(data.error);  
    	                  }else  
    	                  {  
    	                      alert(data.message);  
    	                  }  
    	              }  
    	          },  
    	           error: function (data, status, e)
    	          {  
    	              alert(e);  
    	          }  
    	      }  
    	  ) 
    	  return false;
      }

	
</script>

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>

</head>
<body onload="setValues();getBranch();getCardTypes();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmCommercialReceipt" action="saveCommercialReceipt" method="post" autocomplete="off">
<jsp:include page="../../../header.jsp"></jsp:include>

<div  class='hidden-scrollbar'>
<table width="100%">
  <tr>
    <td width="3%" height="42" align="right">Date</td>
    <td width="20%"><div id="jqxRentalReceiptDate" name="jqxRentalReceiptDate" onchange="datechange();" value='<s:property value="jqxRentalReceiptDate"/>'></div>
    <input type="hidden" id="hidjqxRentalReceiptDate" name="hidjqxRentalReceiptDate" value='<s:property value="hidjqxRentalReceiptDate"/>'/></td>
    <td width="10%" align="right">Doc Type</td>
    <td width="20%"><input type="text" id="txtdoctype" name="txtdoctype" style="width:50%;" value='<s:property value="txtdoctype"/>' tabindex="-1"/></td>
    <td width="7%" align="right">Doc No.</td>
    <td width="21%"><input type="text" id="docno" name="txtrentalreceiptdocno" style="width:50%;" value='<s:property value="txtrentalreceiptdocno"/>' tabindex="-1"/></td>
    <td width="5%" align="right">Receipt No.</td>
    <td width="14%"><input type="text" id="txtsrno" name="txtsrno" style="width:60%;" value='<s:property value="txtsrno"/>' tabindex="-1"/></td>
  </tr>
</table>
<table width="100%">
<tr>
<td width="50%">
<fieldset>
<table width="100%">
  <tr>
    <td colspan="2" align="center"><input type="checkbox" id="chckib" name="chckib" onclick="funCheck();">&nbsp;Inter-Branch
    <input type="hidden" id="hidchckib" name="hidchckib" value='<s:property value="hidchckib"/>'/></td>
    <td width="20%" align="right">Branch</td>
    <td colspan="2"><select id="cmbbranch" name="cmbbranch" style="width:40%;" onchange="funIBDateInPeriod($('#jqxRentalReceiptDate').val(),this.value);" value='<s:property value="cmbbranch"/>'>
      <option value=""></option></select>
    <input type="hidden" id="hidcmbbranch" name="hidcmbbranch" value='<s:property value="hidcmbbranch"/>'/></td>
  </tr>
  <tr>
    <td width="7%" align="right">Client</td>
    <td width="20%"><input type="text" id="txtclientid" name="txtclientid" style="width:80%;" placeholder="Press F3 to Search" value='<s:property value="txtclientid"/>' onkeydown="getClient(event);"/></td>
    <td colspan="3"><input type="text" id="txtclientname" name="txtclientname" style="width:56%;" value='<s:property value="txtclientname"/>'/>
     <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/>
     <input type="hidden" id="txtacno" name="txtacno" value='<s:property value="txtacno"/>'/></td>
  </tr>
  <tr>
    <td align="right">Email</td>
    <td colspan="4"><input type="text" id="email" name="email" style="width:65%;" value='<s:property value="email"/>'/></td>
  </tr>
</table>
</fieldset>
</td>

<td width="50%">
<fieldset>
<table width="100%">
  <tr>
    <td width="7%" align="right">Pay Type</td>
    <td width="16%"><select id="cmbpaytype" name="cmbpaytype" style="width:95%;" value='<s:property value="cmbpaytype"/>' onchange="funchequedate();getAccounts(this.value);">
      <option value="1">Cash</option><option value="2">Card</option><option value="3">Cheque/Online</option></select>
      <input type="hidden" id="hidcmbpaytype" name="hidcmbpaytype" value='<s:property value="hidcmbpaytype"/>'/></td>
    <td width="11%" align="right">Account</td>
    <td width="15%"><input type="text" id="txtaccid" name="txtaccid" style="width:90%;" value='<s:property value="txtaccid"/>' tabindex="-1"/></td>
    <td colspan="3"><input type="text" id="txtaccname" name="txtaccname" style="width:90%;" value='<s:property value="txtaccname"/>' tabindex="-1"/>
    <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
    <input type="hidden" id="txttranno" name="txttranno" value='<s:property value="txttranno"/>'/></td>
  </tr>
  <tr>
    <td align="center"><button type="button" class="icon" id="btnCardSearch" title="Search Card" onclick="funCardSearch();">
							<img alt="Search Card" src="<%=contextPath%>/icons/cardsearch.png">
						</button></td>
                         <td colspan="2" align="center">Card Type&nbsp;
                           <select id="cmbcardtype" name="cmbcardtype" style="width:50%;" onchange="funclearchequecardno();" value='<s:property value="cmbcardtype"/>'>
                          <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbcardtype" name="hidcmbcardtype" value='<s:property value="hidcmbcardtype"/>'/></td>
    <td align="right">Chq/Card No/Online</td>
    <td width="24%"><input type="text" id="txtrefno" name="txtrefno" style="width:100%;" value='<s:property value="txtrefno"/>'/></td>
   
    <td width="4%" align="right">Date</td>
    <td width="23%"><div id="jqxReferenceDate" name="jqxReferenceDate" value='<s:property value="jqxReferenceDate"/>'></div>
    <input type="hidden" id="hidjqxReferenceDate" name="hidjqxReferenceDate" value='<s:property value="hidjqxReferenceDate"/>'/></td>
  </tr>
  <tr>
    <td align="right">Description</td>
    <td colspan="6"><input type="text" id="txtdescription" name="txtdescription" style="width:95%;" value='<s:property value="txtdescription"/>'/></td>
  </tr>
</table>
</fieldset>
</td>
</tr></table>
<fieldset>
<table width="100%">
  <tr>
    <td width="7%" align="right">Amount</td>
    <td width="14%"><input type="text" id="txtamount" name="txtamount" style="width:50%;text-align: right;" value='<s:property value="txtamount"/>' onblur="funRoundAmt(this.value,this.id);getNetValue();getAmount();"/></td>
    <td width="6%" align="right">Discount</td>
    <td width="14%"><input type="text" id="txtdiscount" name="txtdiscount" style="width:40%;text-align: right;" value='<s:property value="txtdiscount"/>' onblur="funRoundAmt(this.value,this.id);getNetValue();"/></td>
    <td colspan="2">Add. Charges %
      <input type="text" id="txtaddcharges" name="txtaddcharges" style="width:20%;text-align: right;" value='<s:property value="txtaddcharges"/>' onblur="funRoundAmt(this.value,this.id);getNetValue();"/></td>
    <td width="6%" align="right">Amt</td>
    <td width="18%" align="left"><input type="text" id="txtamounts" name="txtamounts" style="width:50%;text-align: right;" value='<s:property value="txtamounts"/>' onblur="funRoundAmt(this.value,this.id);" /></td>
    <td width="4%" align="right">Net Value</td>
    <td width="14%"><input type="text" id="txtnetvalue" name="txtnetvalue" style="width:70%;text-align: right;" value='<s:property value="txtnetvalue"/>' tabindex="-1"/></td>
  </tr>
  <tr>
    <td align="right">Description</td>
    <td colspan="4"><input type="text" id="txtdescriptions" name="txtdescriptions" style="width:100%;" value='<s:property value="txtdescriptions"/>'/></td>
    <td colspan="2" align="right">Received From</td>
    <td colspan="3"><input type="text" id="txtreceivedfrom" name="txtreceivedfrom" style="width:89%;" value='<s:property value="txtreceivedfrom"/>'/></td>
  </tr>
</table>
</fieldset>
<fieldset>
<legend>Apply Invoices</legend>
<div id="applyInvoicing1"><jsp:include page="applyInvoiceGrid.jsp"></jsp:include></div>
<table width="100%">
  <tr>
    <td width="8%" align="right">Amount</td>
    <td width="24%"><input type="text" id="txtapplyinvoiceamt" name="txtapplyinvoiceamt" style="width:50%;text-align: right;" value='<s:property value="txtapplyinvoiceamt"/>'/>
    <input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/></td>
    <td width="5%" align="right">Applied</td>
    <td width="26%"><input type="text" id="txtapplyinvoiceapply" name="txtapplyinvoiceapply" style="width:50%;text-align: right;" value='<s:property value="txtapplyinvoiceapply"/>' tabindex="-1"/></td>
    <td width="10%" align="right">Balance</td>
    <td width="27%"><input type="text" id="txtapplyinvoicebalance" name="txtapplyinvoicebalance" style="width:50%;text-align: right;" value='<s:property value="txtapplyinvoicebalance"/>' tabindex="-1"/></td>
  </tr>
</table>
</fieldset>
<input type="hidden" id="mode" name="mode"/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<div hidden="true" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
<input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
<input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
<input type="hidden" id="txtbackdatevalidation" name="txtbackdatevalidation" value='<s:property value="txtbackdatevalidation"/>'/>
<input type="hidden" id="txtibvalidation" name="txtibvalidation" value='<s:property value="txtibvalidation"/>'/>
<input type="hidden" id="applylength" name="applylength"/>
<input type="hidden" id="applylengthupdate" name="applylengthupdate"/>
</div>
</form> 
<div id="clientDetailsWindow">
	<div></div><div></div>
</div>
<div id="cardDetailsWindow">
	<div></div><div></div>
</div> 
</div>
</body>
</html>