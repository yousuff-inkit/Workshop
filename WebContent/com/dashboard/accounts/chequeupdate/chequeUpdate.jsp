<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

<style type="text/css">
/* ===== MASTER LAYOUT (Modern Flexbox matching image_55e599.png) ===== */
html, body, #mainBG {
    height: 100%;
    margin: 0;
    overflow: hidden;
    background-color: #f4f7f9;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.master-container {
    display: flex;
    width: 100%;
    height: 100vh;
}

/* ===== LEFT SIDEBAR ===== */
.sidebar-filters {
    width: 290px; 
    flex: 0 0 290px; 
    background: #f4f7f9;
    border-right: 1px solid #e1e8ed;
    display: flex;
    flex-direction: column;
    height: 100%;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
    z-index: 10;
}

.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 12px; 
}

/* Cards */
.filter-card {
    background: #ffffff;
    border: 1px solid #e2e8f0;
    border-radius: 6px;
    padding: 15px;
    margin-bottom: 12px;
}

/* Tables & Spacing */
.release-filter-table {
    width: 100%;
    border-collapse: collapse;
}

.release-filter-table td {
    padding: 6px 2px; 
    vertical-align: middle;
}

.release-filter-table .label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 12px !important; 
    color: #4b5563;
    font-weight: normal;
    width: 85px; 
}

/* ===== UNIFORM INPUTS & SELECTS ===== */
input[type="text"], select, textarea,
.release-filter-table input[type="text"],
.release-filter-table select,
.release-filter-table textarea {
    width: 100%;
    height: 24px;             
    padding: 2px 6px;         
    border: 1px solid #cbd5e1 !important;
    border-radius: 3px;       
    font-size: 12px !important; 
    background-color: #ffffff !important; 
    color: #333333 !important; 
    box-sizing: border-box;
    font-family: inherit;
    outline: none;
}

select:focus, input[type="text"]:focus, textarea:focus {
    border-color: #3b82f6 !important;
    box-shadow: 0 0 0 1px rgba(59, 130, 246, 0.1);
}

.release-filter-table textarea {
    height: auto;
    resize: none;
    margin-top: 4px;
}

/* Readonly / disabled look */
input[readonly], input:disabled, textarea[readonly],
.release-filter-table input[readonly], .release-filter-table select:disabled {
    background-color: #f8fafc !important;
    color: #6b7280 !important;
    border-color: #e2e8f0 !important;
}

/* jqx date/time containers */
.release-filter-table div[id^="fromdate"],
.release-filter-table div[id^="todate"],
.release-filter-table div[id^="chequedate"] {
    width: 100% !important;
    height: 24px !important;
}

/* Radio buttons layout */
.radio-group {
    display: flex;
    gap: 12px;
    align-items: center;
    font-size: 12px !important;
    color: #333;
    height: 24px;
    flex-wrap: wrap;
    padding-top: 4px;
}
.radio-group label {
    display: flex;
    align-items: center;
    cursor: pointer;
    margin: 0;
}
.radio-group input[type="radio"] {
    margin: 0 4px 0 0;
    padding: 0;
}

fieldset.radio-fieldset {
    border: 1px solid #e2e8f0;
    border-radius: 4px;
    padding: 10px;
    margin-bottom: 12px;
}
fieldset.radio-fieldset legend {
    font-size: 12px;
    font-weight: 600;
    color: #4b5563;
    padding: 0 5px;
}

/* ===== BUTTONS ===== */
.release-actions {
    margin-top: 15px;
    display: flex;
    flex-direction: column;
    gap: 8px;
    border-top: 1px solid #e3e8ee;
    padding-top: 15px;
}

.btn-submit {
    width: 100%;
    height: 32px;            
    background: #2563eb;
    color: #ffffff;
    border: none;
    border-radius: 4px;      
    font-size: 12px !important;
    font-weight: 600;
    cursor: pointer;
    transition: background 0.2s;
    display: flex;
    align-items: center;
    justify-content: center;
}

.btn-submit:hover {
    background: #1d4ed8;
}

.btn-submit:disabled {
    background: #9ca3af;
    cursor: not-allowed;
}

/* ===== RIGHT CONTENT AREA ===== */
.main-content-area {
    flex: 1;
    display: flex;
    flex-direction: column;
    background: #ffffff;
    height: 100%;
    overflow: hidden;
}

.top-toolbar-container {
    width: 100%;
    padding: 10px 15px;
    background: #ffffff;
    border-bottom: 1px solid #e1e8ed;
    box-sizing: border-box;
}

.grid-content-container {
    flex: 1;
    padding: 15px;
    overflow: auto; 
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
}
</style>

<script type="text/javascript">

	$(document).ready(function () {
		 // Adapted width to 100% and height to 24px for Master UI
		 $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
		 $("#chequedate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy",value:null});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
	     $('#printWindow').jqxWindow({width: '51%', height: '48%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Cheque Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#printWindow').jqxWindow('close');
		 
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
			
	     var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	     document.getElementById("rdosingle").checked=true;
	     
		 $('#txtchequeno').attr('readonly', true);
         $('#chequedate').jqxDateTimeInput({disabled: true});
	});
	
	function ChequePrintContent(url) {
		$('#printWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		    $('#printWindow').jqxWindow('setContent', data);
		    $('#printWindow').jqxWindow('bringToFront');
	    }); 
	} 
	
	function accountsSearchContent(url) {
	    $('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		    $('#accountDetailsWindow').jqxWindow('setContent', data);
		    $('#accountDetailsWindow').jqxWindow('bringToFront');
	    }); 
	}

	function funreload(event){
		var branchval = document.getElementById("cmbbranch").value;
		var fromdate = $('#fromdate').val();
		var todate = $('#todate').val();
		
        $('#txtchequeno').val('');
        $('#chequedate').val('');
        $('#txtbranch').val('');
        $('#txttrno').val('');
        $('#txtdocumentno').val('');
        $('#txtdoctype').val('');
		
        $('#chequedate').jqxDateTimeInput({disabled: true});
		$("#overlay, #PleaseWait").show();
		var check = 1;
		 
		$("#chequeUpdateDiv").load("chequeUpdateGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&check='+check);
	}
	
	function getChequeNoAlreadyExists(chequeno,bankacno,docno){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText.trim();

  				if(parseInt(items)==1){
  					$.messager.alert('Message','Cheque No. Already Exists.','warning');
  					return 0;
  				}else{
  					funUpdate(event);
  				}
  		    }
	    }
	    x.open("GET", "getChequeNoAlreadyExists.jsp?chequeno="+chequeno+'&bankacno='+bankacno+'&docno='+docno, true);
	    x.send();
    }
   
    function getChequePrintAvailability(bankacno){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText.trim();

  				if(parseInt(items)==0){
  					$.messager.alert('Message','Cheque Print is Unavailable.','warning');
  					return 0;
  				}else if(parseInt(items)==1){
  					if(document.getElementById("rdosingle").checked==true){
	  				    var url=document.URL;
	  				    var reurl=url.split("com");
	  				    $("#docno").prop("disabled", false);  
	  				    
	  					var win= window.open(reurl[0]+"printPaymentCheques?docno="+document.getElementById("txtdocumentno").value+"&dtype="+document.getElementById("txtdoctype").value+"&branch="+document.getElementById("txtbranch").value,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	  				    win.focus(); 
  					} 		    
  				}
  		    }
	    }
	    x.open("GET", "getChequePrintAvailable.jsp?bankacno="+bankacno, true);
	    x.send();
    } 
	
	function funUpdate(event){
		var chequeno = $('#txtchequeno').val();
		var chequedate = $('#chequedate').val();
		var branchid = $('#txtbranch').val();
		var trno = $('#txttrno').val();
		var docno = $('#txtdocumentno').val();
		var dtype = $('#txtdoctype').val();
		
		if(chequeno==''){
			$.messager.alert('Message','Please Enter Cheque No.','warning');
			return 0;
		}
		
		if(chequedate==''){
			$.messager.alert('Message','Please Enter Cheque Date.','warning');
			return 0;
		}
			
		$.messager.confirm('Message', 'Do you want to save changes?', function(r){
		    if(r==false) {
		        return false; 
		    }
		    else{
		        saveGridData(branchid,chequeno,chequedate,trno,docno,dtype);	
		    }
		});
	}
	
	function saveGridData(branchid,chequeno,chequedate,trno,docno,dtype){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		    if (x.readyState==4 && x.status==200) {
				var items=x.responseText;

				$('#fromdate').val(new Date());
		    	var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
			    var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
			    var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
			    $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
				$('#todate').val(new Date());
                
				var chequeno = $('#txtchequeno').val('');
				var chequedate = $('#chequedate').val('');
				var branchid = $('#txtbranch').val('');
				var trno = $('#txttrno').val('');
				var docno = $('#txtdocumentno').val('');
				var dtype = $('#txtdoctype').val('');
				
				$.messager.alert('Message', '  Record Successfully Updated ', function(r){
			    });
		        funreload(event); 
		    }
		}
			
	    x.open("GET","saveData.jsp?branchid="+branchid+"&chequeno="+chequeno+"&chequedate="+chequedate+"&trno="+trno+"&docno="+docno+"&dtype="+dtype,true);
	    x.send();
	}
	
	function funChequePrint(){
		if(document.getElementById("rdosingle").checked==true){
			var rows = $('#chequeUpdate').jqxGrid('getrows');
	    	var rowlength= rows.length;
	    	if(rowlength==0){
	    		$.messager.alert('Message','Submit & Please Select a Cheque.','warning');
				return;
	    	}
	    	
			if ($("#txtdocumentno").val()!="") {
				getChequePrintAvailability($('#txtbankacno').val());
			}
		    else {
				$.messager.alert('Message','Please Select a Cheque.','warning');
				return;
			}
		} else {
			 $('#chequedate').val(null);
             $("#txtchequeno").val('');
             $("#txtchqbankname").val('');
             $("#txtchqbankdocno").val('');
			 $("#txtbankacno").val('');
             $("#txtdocumentno").val('');
             $("#txtdoctype").val('');
             $("#printdocno").val('');
             $("#printdtype").val('');
			 
             $('#txtchequeno').attr('readonly', true);
             $('#chequedate').jqxDateTimeInput({disabled: true});
             $("#chequeUpdate").jqxGrid('clear');	
			 
             ChequePrintContent('printChequeVoucherWindow.jsp');
		}
    }
	
	function funClearInfo(){
        $('#cmbbranch').val('a');
        $('#fromdate').val(new Date());
        var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
        var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
        var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
        $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
        
        $('#todate').val(new Date());
        $('#chequedate').val(null);
        
        $("#txtchequeno").val('');
        $("#txtbranch").val('');
        $("#txtbankacno").val('');
        $("#txtdocumentno").val('');
        $("#txtdoctype").val('');
        $("#txtchqbankname").val('');
        $("#txtchqbankdocno").val('');
        $("#printdocno").val('');
        $("#printdtype").val('');
        
        document.getElementById("rdosingle").checked=true;
        document.getElementById("rdomultiple").checked=false;
        $('#txtchequeno').attr('readonly', true);
        $('#chequedate').jqxDateTimeInput({disabled: true});
        
        $("#chequeUpdate").jqxGrid('clear');	
        $('#accountDetailsWindow').jqxWindow('close');
        $('#printWindow').jqxWindow('close');  
        
        if (document.getElementById("txtchqbankname").value == "") {
            $('#txtchqbankname').attr('placeholder', 'Press F3 to Search'); 
        }
    }
		
    function funExportBtn(){
        if(parseInt(window.parent.chkexportdata.value)=="1") {
            JSONToCSVCon(data1, 'ChequeUpdate', true);
        } else {
            $("#chequeUpdate").jqxGrid('exportdata', 'xls', 'ChequeUpdate');
        }
    }
		
</script>

</head>
<body onload="getBranch();">
    <div id="mainBG" class="homeContent" data-type="background"> 
        <div class="master-container">

            <!-- Sidebar / Filter Section -->
            <div class="sidebar-filters">
                <div class="sidebar-scroll-content">
                    <div class="filter-card">
                        <table class="release-filter-table">
                            <tr>
                                <td class="label-cell">From</td>
                                <td>
                                    <div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div>
                                </td>
                            </tr> 
                            <tr>
                                <td class="label-cell">To</td>
                                <td>
                                    <div id="todate" name="todate" value='<s:property value="todate"/>'></div>
                                </td>
                            </tr>  
                            <tr>
                                <td class="label-cell">Cheque Date</td>
                                <td>
                                    <div id="chequedate" name="chequedate" value='<s:property value="chequedate"/>'></div>
                                </td>
                            </tr> 
                            <tr>
                                <td class="label-cell">Cheque No.</td>
                                <td>
                                    <input type="text" id="txtchequeno" name="txtchequeno" value='<s:property value="txtchequeno"/>'/>
                                </td>
                            </tr>
                        </table>

                        <fieldset class="radio-fieldset" style="margin-top: 15px;">
                            <legend>Print Type</legend>
                            <div class="radio-group">
                                <label><input type="radio" id="rdosingle" name="rdoprint" value="rdosingle" checked>Single</label>
                                <label><input type="radio" id="rdomultiple" name="rdoprint" value="rdomultiple">Multiple</label>
                            </div>
                        </fieldset>

                        <div class="release-actions">
                            <button type="button" class="btn-submit" id="btnUpdate" name="btnUpdate" onclick="getChequeNoAlreadyExists($('#txtchequeno').val(),$('#txtbankacno').val(),$('#txtdocumentno').val());">Update</button>
                            <button type="button" class="btn-submit" id="btnChequePrint" name="btnChequePrint" onclick="funChequePrint();">Cheque Print</button>
                            <button type="button" class="btn-submit" name="clear" id="clear" onclick="funClearInfo();">Clear</button>
                        </div>

                        <!-- Hidden Form Variables logically grouped inside the sidebar -->
                        <input type="hidden" id="txtbranch" name="txtbranch" value='<s:property value="txtbranch"/>'/>
                        <input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
                        <input type="hidden" id="txtbankacno" name="txtbankacno" value='<s:property value="txtbankacno"/>'/>
                        <input type="hidden" id="txtdocumentno" name="txtdocumentno" value='<s:property value="txtdocumentno"/>'/>
                        <input type="hidden" id="txtdoctype" name="txtdoctype" value='<s:property value="txtdoctype"/>'/>
                    </div>
                </div>
            </div>

            <!-- Main Grid / Data Section -->
            <div class="main-content-area">
                
                <div class="top-toolbar-container">
                    <jsp:include page="../../heading.jsp"></jsp:include>
                </div>

                <div class="grid-content-container">
                    
                    <div id="chequeUpdateDiv" style="flex: 1; display: flex; flex-direction: column;">
                        <jsp:include page="chequeUpdateGrid.jsp"></jsp:include>
                    </div>

                </div>

            </div>

        </div>

        <!-- Modals -->
        <div id="printWindow">
            <div></div><div></div>
        </div> 

        <div id="accountDetailsWindow">
            <div></div><div></div>
        </div>

    </div> 
</body>
</html>