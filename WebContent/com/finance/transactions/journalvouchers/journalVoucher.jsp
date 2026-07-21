<%@ taglib prefix="s" uri="/struts-tags"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		 $("#btnvaluechange").hide();
		 
		 $("#jqxJournalVouchersDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
		 $('#journalVoucherGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Account Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#journalVoucherGridWindow').jqxWindow('close');
		 
		 $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#costTypeSearchGridWindow').jqxWindow('close');
 		 
 		 $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeSearchWindow').jqxWindow('close');
		 
		 $('#jqxJournalVouchersDate').on('change', function (event) {
		    if ($("#mode").val() != "view") {
				var journaldate = $('#jqxJournalVouchersDate').jqxDateTimeInput('getDate');
				funDateInPeriod(journaldate);
			}
		 });
		 
		 $('#txtdescription').keydown(function (evt) {
			  if (evt.keyCode==9) {
			          event.preventDefault();
			          $('#jqxJournalVoucher').jqxGrid('selectcell',0, '');
			          $('#jqxJournalVoucher').jqxGrid('focus',0, '');
			  }
		 });
		 
	});
	
	function AccountSearchContent(url) {
		$('#journalVoucherGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#journalVoucherGridWindow').jqxWindow('setContent', data);
		$('#journalVoucherGridWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function costTypeSearchContent(url) {
	    $('#costTypeSearchGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costTypeSearchGridWindow').jqxWindow('setContent', data);
		$('#costTypeSearchGridWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function costCodeSearchContent(url) {
	    $('#costCodeSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costCodeSearchWindow').jqxWindow('setContent', data);
		$('#costCodeSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	 function funwarningopen(){
		 $.messager.confirm('Confirm', 'Transaction will affect Links to the applied Bank Reconcilations & Prepayments.', function(r){
			    if (r){
			    	$("#mode").val("EDIT");
					 $('#txtrefno').attr('readonly', false );$('#txtdescription').attr('readonly', false );
					 $('#txtdrtotal').attr('readonly', true );$('#txtcrtotal').attr('readonly', true );
					 $("#jqxJournalVoucher").jqxGrid({ disabled: false});
					 $('#docno').attr('readonly', true);  
			    }
			   });
	  }
	
	 function funReadOnly(){
		    $("#btnvaluechange").hide();
			$('#frmJournalVoucher input').attr('readonly', true );
			$('#jqxJournalVouchersDate').jqxDateTimeInput({disabled: true});
			$("#jqxJournalVoucher").jqxGrid({ disabled: true});
			$('#fileexcelimport').attr('hidden', true );
			$('#btnsearch').attr('hidden', true );
	 }
	 function funRemoveReadOnly(){
			$('#frmJournalVoucher input').attr('readonly', false );
			$('#txtdrtotal').attr('readonly', true );
			$('#txtcrtotal').attr('readonly', true );
			$('#jqxJournalVouchersDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$("#jqxJournalVoucher").jqxGrid({ disabled: false}); 
			$('#fileexcelimport').attr('hidden', false );
			$('#btnsearch').attr('hidden', false );
			
			if ($("#mode").val() == "E") {
         	    $("#btnvaluechange").show();
         	    $('#frmJournalVoucher input').attr('readonly', true );
			    $("#jqxJournalVoucher").jqxGrid({ disabled: true});
   			    $('#txtrefno').attr('readonly', false );
   			    $('#txtdescription').attr('readonly', false );
   			    $("#jqxJournalVoucher").jqxGrid('addrow', null, {});
   			 	$('#fileexcelimport').attr('disabled', true );
 				$('#btnsearch').attr('disabled', true );
			  }
			 else{
				$("#btnvaluechange").hide();
			}
			
			if ($("#mode").val() == "A") {
				$('#jqxJournalVouchersDate').val(new Date());
				document.getElementById("lblformposted").innerText="";
				$('#btnEdit').attr('disabled', false );
				$("#jqxJournalVoucher").jqxGrid('clear');
				$("#jqxJournalVoucher").jqxGrid('addrow', null, {});
			}
	 }
	 
	 function funSearchLoad(){
		   changeContent('jvtMainSearch.jsp');  
	 }
	 
	 function funExcelBtn(){
		 if (($("#mode").val() == "view") && $("#docno").val()!="") {
		 	   $("#jqxJournalVoucher").jqxGrid('exportdata', 'xls', 'JournalVoucher');
		 }else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#jqxJournalVouchersDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	 
	   $(function(){
	        $('#frmJournalVoucher').validate({
	                rules: {
	                   txtdescription:{maxlength:500}
	                 },
	                 messages: {
	                   txtdescription: {maxlength:"    Max 500 chars"}
	                 }
	        });}); 
	   
	  function funNotify(){	
			  /* Validation */
			     
		        var journaldate = $('#jqxJournalVouchersDate').jqxDateTimeInput('getDate');
			    var validdate=funDateInPeriod(journaldate);
			    if(validdate==0){
			    return 0;	
		     	}
			    
			     exceltypevalid=document.getElementById("txtexceltypevalidation").value;
				 if(exceltypevalid!=0){
					 document.getElementById("errormsg").innerText="Invalid Account-Type !!!";
					 return 0;
				 }
				 
				 excelaccvalid=document.getElementById("txtexcelaccvalidation").value;
				 if(excelaccvalid!=0){
					 document.getElementById("errormsg").innerText="Invalid Account !!!";
					 return 0;
				 }
				 
				 excelgrtypevalid=document.getElementById("txtexcelgrtypevalidation").value;
				 if(excelgrtypevalid!=0){
					 document.getElementById("errormsg").innerText="Invalid Cost-Type and Cost-Code !!!";
					 return 0;
				 }
				 
				 excelcostvalid=document.getElementById("txtexcelcostvalidation").value;
				 if(excelcostvalid!=0){
					 document.getElementById("errormsg").innerText="Invalid Cost-Type and Cost-Code !!!";
					 return 0;
				 }
				 
				 valid=document.getElementById("txtvalidation").value;
				 if(valid==1){
					 document.getElementById("errormsg").innerText="Invalid Transaction !!!";
					 return 0;
				 }
			  
			    var drtot = document.getElementById("txtdrtotal").value;
		 		var crtot = document.getElementById("txtcrtotal").value;
		 		if(drtot>crtot || drtot<crtot){
		 			 document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should be Equal.";
	            return 0;
		 		}
		 		
		 		if(drtot=="" || crtot=="" || drtot=="NaN" || crtot=="NaN" || drtot==0 || crtot==0 || drtot==0.0 || crtot==0.0 || drtot==0.00 || crtot==0.00){
		 			  document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should not be Zero.";
		              return 0;
			 		}
		 		
		    	document.getElementById("errormsg").innerText="";
		    	/* Validation  Ends*/
		    	
		    	/* Journal Voucher Grid Saving */
		    	 var rows = $("#jqxJournalVoucher").jqxGrid('getrows');
		    	 var length=0;
				 for(var i=0 ; i < rows.length ; i++){
					var chk=rows[i].docno;
					if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
						newTextBox = $(document.createElement("input"))
					    .attr("type", "dil")
					    .attr("id", "test"+length)
					    .attr("name", "test"+length)
					    .attr("hidden", "true");
						length=length+1;
						
					var amount,baseamount,id;
					if((rows[i].credit!=null) && (rows[i].credit!='undefined') &&  (rows[i].credit!='NaN') && (rows[i].credit!="") && (rows[i].credit!=0)){
						 amount=rows[i].credit*-1;
						 baseamount=rows[i].baseamount*-1;
						 id=-1;
					}
					
					if((rows[i].debit!=null) && (rows[i].debit!='undefined') && (rows[i].debit!='NaN') && (rows[i].debit!="") && (rows[i].debit!=0)){
						 amount=rows[i].debit;
						 baseamount=rows[i].baseamount;
						 id=1;
					}
					
					newTextBox.val(rows[i].docno+"::"+rows[i].description+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+amount+"::"+baseamount+"::"+rows[i].sr_no+"::"+id+":: "+rows[i].costtype+":: "+rows[i].costcode);
					newTextBox.appendTo('form');
					}
				 }
				 $('#gridlength').val(length);
		 		/* Journal Voucher Grid Saving Ends */
		    	
		 		if ($("#mode").val() == "E") {
			         $('#frmJournalVoucher select').attr('disabled', false); 
			    }
		 		
	    		return 1;
		} 
	  
	  
	  function setValues(){
		 
		  if($('#hidjqxJournalVouchersDate').val()){
			 $("#jqxJournalVouchersDate").jqxDateTimeInput('val', $('#hidjqxJournalVouchersDate').val());
		  }
		  
		  if($('#hidmaindate').val()){
				 $("#maindate").jqxDateTimeInput('val', $('#hidmaindate').val());
			  }
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
			
		  if(document.getElementById("lblformposted").innerText.trim()!=""){
			    $('#btnEdit').attr('disabled', true );$('#btnDelete').attr('disabled', true );
		  } else {
			    $('#btnEdit').attr('disabled', false );$('#btnDelete').attr('disabled', false );
		  }
		  
			 var indexVal = document.getElementById("docno").value;
			 if(indexVal>0){
				 var check=1;
	         	 $("#jqxJournalVoucherGrid").load("journalVoucherGrid.jsp?txtjournalvouchersdocno2="+indexVal+"&check="+check); 
			 }
		}
	  
	  function funPrintBtn() {
			
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
		        var reurl="";
				var url=document.URL;
				if( url.indexOf('saveJournalVoucher') >= 0){
					reurl=url.split("saveJournalVoucher");
				}else {
					reurl=url.split("journalVoucher.jsp");
				}
		        $("#docno").prop("disabled", false);  
		     
		        $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
					if (r){
	 
var win= window.open(reurl[0]+"printJournalVoucher?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					     win.focus();

/*  var win= window.open(reurl[0]+"JournalVoucherPrint?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
						    win.focus();  */
					 }
					else{

						var win= window.open(reurl[0]+"printJournalVoucher?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					    win.focus();
/* 
var win= window.open(reurl[0]+"JournalVoucherPrint?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
						    win.focus(); */ 
					}
				   });
		     }
		    else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
	    }
	  
	  function datechange(){
		  var date = $('#jqxJournalVouchersDate').jqxDateTimeInput('getDate');
		  $("#maindate").jqxDateTimeInput('val', date);
	  }
		
		function saveExcelDataData(docNo){
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
					var items=x.responseText.trim();
					
					if(items==1){
						$("#jqxJournalVoucherGrid").load("journalVoucherGrid.jsp?docNo="+docNo+'&date='+$('#maindate').val());
						$.messager.alert('Message', ' Successfully Imported.', function(r){
					});
					}
					
			  }
			}
				
		x.open("GET","saveData.jsp?docNo="+docNo,true);
		x.send();
		}
		
		function getAttachDocumentNo(){
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
					var items=x.responseText.trim();
					
					if(items>0){
						
						var path=document.getElementById("fileexcelimport").value;
						var fsize = $('#fileexcelimport')[0].files[0].size;
						var extn = path.substring(path.lastIndexOf(".") + 1, path.length);
						
						if((extn=='xls') || (extn=='csv')){ 
					        	ajaxFileUpload(items);	
					     }else{
					        	 $.messager.show({title:'Message',msg: 'File of xlsx Format is not Supported.',showType:'show',
			                         style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
			                     }); 
						            return;
					     } 
					}
					
			  }
			}
				
		x.open("GET","getAttachDocumentNo.jsp",true);
		x.send();
		}
		
		function upload(){
			 
			$('#txtexcelvalidation').val(1);
			getAttachDocumentNo();
			 
		 }
		
		function ajaxFileUpload(docNo) {  
			
			  var jvtdate = $("#jqxJournalVouchersDate").val();
   		      var newDate = jvtdate.split('.');
   		      jvtdate = newDate[0] + "-" + newDate[1] + "-" + newDate[2];
   		  
			    if (window.File && window.FileReader && window.FileList && window.Blob)
			    {
			        var fsize = $('#fileexcelimport')[0].files[0].size;
			        
			        if(fsize>1048576) {
			            $.messager.show({title:'Message',msg: fsize +' bytes too big ! Maximum Size 1 MB.',showType:'show',
                          style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                      }); 
			            return;
			        }
			    }else{
			    	 $.messager.show({title:'Message',msg:'Please upgrade your browser, because your current browser lacks some new features we need!',showType:'show',
	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	                        }); 
			        return;
			    }
			
	          $.ajaxFileUpload  
	          (  
	              {  
	                  url:'fileAttachAction.action?formCode=JVTE&doc_no='+docNo+'&descpt=Excel Import' ,
	                  secureuri:false,  
	                  fileElementId:'fileexcelimport',    
	                  dataType: 'json', 
	                  success: function (data, status)   
	                  {  
	                     
	                     if(status=='success'){
	                         saveExcelDataData(docNo);
	                         $.messager.show({title:'Message',msg:'Successfully Uploaded',showType:'show',
	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	                        }); 
	                      }
	                     
	                      if(typeof(data.error) != 'undefined')  
	                      {  
	                          if(data.error != '')  
	                          {  
	                              $.messager.show({title:'Message',msg: data.error,showType:'show',
	  	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	  	                        }); 
	                          }else  
	                          {  
	                              $.messager.show({title:'Message',msg: data.message,showType:'show',
		  	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
		  	              	          }); 
	                          }  
	                      }  
	                  },  
	                  error: function (data, status, e){  
	                      $.messager.alert('Message',e);
	                  }  
	              });  
	          return false;  
	      }
	 
</script>

<style>

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

#frmJournalVoucher input[type="text"],
#frmJournalVoucher input[type="file"],
#frmJournalVoucher select,
.textbox { 
    height: 24px !important; 
    width: 100% ;
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    font-family: Arial, sans-serif;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    box-shadow: none !important;
    outline: none;
}

#frmJournalVoucher input[type="text"]:focus,
#frmJournalVoucher input[type="file"]:focus,
#frmJournalVoucher select:focus,
.textbox:focus { 
    border-color: #007bff; 
}

#frmJournalVoucher input[readonly],
#frmJournalVoucher input:disabled,
#frmJournalVoucher select:disabled,
.textbox[readonly] { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

form label.error {
    color: red;
    font-weight: bold;
    font-size: 11px;
    font-family: Arial, sans-serif;
}

.myButton, .btn {
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
    display: inline-block;
    box-sizing: border-box;
}

.myButton:hover, .btn:hover { 
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); 
}

.icon {
    background: none;
    border: none;
    cursor: pointer;
    padding: 0;
    display: flex;
    align-items: center;
    justify-content: center;
}

.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 100px);
    padding-right: 5px;
    overflow-x: hidden;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

/* Grid Containers */
.grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}

/* JQX Widget Overrides for 24px Alignment */
.jqx-datetimeinput-input { 
    height: 24px !important; 
    line-height: 24px !important; 
    margin-top: 0px !important; 
    padding-top: 0px !important;
    box-sizing: border-box !important;
    font-size: 12px !important;
}
.jqx-action-button {
    height: 24px !important;
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

.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: nowrap; /* Prevent wrapping */
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
    flex-shrink: 0; /* Keep labels from squishing */
}
</style>

</head>
<body onload="setValues();">

<!-- JQX input alignment fix -->
<script type="text/javascript">
    $(document).ready(function() {
         setTimeout(function () {
             $("#jqxJournalVouchersDate, #maindate").find("input").css({
                 "margin-top": "0px",
                 "line-height": "24px",
                 "font-size": "12px", 
                 "font-family": "Arial, sans-serif", 
                 "padding": "0 6px", 
                 "box-sizing":"border-box"
             });
             $("#jqxJournalVouchersDate, #maindate").find(".jqx-action-button").css({
                 "top": "0px",
                 "height": "24px"
             });
         }, 0);
         
         $("#jqxJournalVouchersDate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
         $("#maindate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    });
</script>

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmJournalVoucher" action="saveJournalVoucher" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>

    <!-- General Info -->
    <div class="middle-panel">
        <span class="middle-panel-title">General Info</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px; flex-shrink:0;">Date</label>
            <div style="width: 125px; flex-shrink:0;">
                <div id="jqxJournalVouchersDate" name="jqxJournalVouchersDate" onchange="datechange();" value='<s:property value="jqxJournalVouchersDate"/>'></div>
                <input type="hidden" id="hidjqxJournalVouchersDate" name="hidjqxJournalVouchersDate" value='<s:property value="hidjqxJournalVouchersDate"/>'/>
            </div>
            
            <label class="lbl-right" style="width:80px; flex-shrink:0; margin-left: 15px;">Import Excel</label>
            <input type="file" id="fileexcelimport" name="file" style="width:220px; flex-shrink:0; padding:1px;"/>
            
            <button class="icon" id="btnsearch" name="btnsearch" title="Import Excel" type="button" onclick="return upload();" style="flex-shrink:0;">
                <img alt="Import Excel" src="<%=contextPath%>/icons/import_excel.png">
            </button>
            
            <label class="lbl-right" style="width:80px; flex-shrink:0; margin-left:auto;">Doc No</label>
            <div style="display:flex; align-items:center; gap:8px; flex-shrink:0;">
                <input type="text" id="docno" name="txtjournalvouchersdocno" style="width:120px;" value='<s:property value="txtjournalvouchersdocno"/>' tabindex="-1" readonly/>
                <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button>
            </div>
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px; flex-shrink:0;">Ref. No.</label>
            <input type="text" id="txtrefno" name="txtrefno" style="width:200px; flex-shrink:0;" value='<s:property value="txtrefno"/>'/>
            
            <label class="lbl-right" style="width:80px; flex-shrink:0; margin-left: 15px;">Description</label>
            <input type="text" id="txtdescription" name="txtdescription" style="flex:1; min-width:0;" value='<s:property value="txtdescription"/>'/>
            
            <div style="flex-shrink:0; margin-left:15px;">
                <i><b><label id="lblformposted" name="lblformposted" style="font-size: 13px; font-family: Tahoma; color:#6000FC;"><s:property value="lblformposted"/></label></b></i>
            </div>
        </div>
    </div>

    <!-- Journal Voucher Grid -->
    <div class="middle-panel">
        <span class="middle-panel-title">Voucher Entries</span>
        <div id="jqxJournalVoucherGrid" class="grid-container">
            <jsp:include page="journalVoucherGrid.jsp"></jsp:include>
        </div>
        
        <div class="field-row" style="margin-top: 15px; justify-content: flex-end; margin-bottom:0;">
            <label class="lbl-right" style="width:60px; flex-shrink:0;">Dr. Total</label>
            <input type="text" id="txtdrtotal" name="txtdrtotal" style="width:120px; text-align:right; flex-shrink:0;" value='<s:property value="txtdrtotal"/>' tabindex="-1" readonly/>
            
            <label class="lbl-right" style="width:60px; flex-shrink:0; margin-left:15px;">Cr. Total</label>
            <input type="text" id="txtcrtotal" name="txtcrtotal" style="width:120px; text-align:right; flex-shrink:0;" value='<s:property value="txtcrtotal"/>' tabindex="-1" readonly/>
        </div>
    </div>

    <!-- Hidden Inputs -->
    <div style="display:none;">
        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" id="txtexceltypevalidation" name="txtexceltypevalidation" value='<s:property value="txtexceltypevalidation"/>'/>
        <input type="hidden" id="txtexcelaccvalidation" name="txtexcelaccvalidation" value='<s:property value="txtexcelaccvalidation"/>'/>
        <input type="hidden" id="txtexcelgrtypevalidation" name="txtexcelgrtypevalidation" value='<s:property value="txtexcelgrtypevalidation"/>'/>
        <input type="hidden" id="txtexcelcostvalidation" name="txtexcelcostvalidation" value='<s:property value="txtexcelcostvalidation"/>'/>
        <input type="hidden" id="gridlength" name="gridlength"/>
        <div hidden="true" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
        <input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
        <input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
        <input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
    </div>

</div>
</form>

<div id="journalVoucherGridWindow"><div></div><div></div></div>
<div id="costTypeSearchGridWindow"><div></div><div></div></div>
<div id="costCodeSearchWindow"><div></div><div></div></div>

</div>
</body>
</html>