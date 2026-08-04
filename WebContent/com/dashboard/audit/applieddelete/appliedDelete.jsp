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
    width: 300px; 
    flex: 0 0 300px; 
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
    width: 80px; 
}

/* ===== UNIFORM INPUTS & SELECTS (Fixes pink background & text styling) ===== */
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
    height: 80px; 
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
.release-filter-table div[id^="date"] {
    width: 100% !important;
    height: 24px !important;
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
}

.btn-submit:hover {
    background: #1d4ed8;
}

.btn-submit:disabled {
    background: #9ca3af !important;
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
    gap: 15px;
}
</style>

<script type="text/javascript">

	$(document).ready(function () {
		 $("#date").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
		 
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
	     $('#date').jqxDateTimeInput({disabled: true});
         $('#txtreason').attr("readonly",true);
         $('#btndelete').attr("disabled",true);
	     $("#appliedDetailsGrid").jqxGrid({ disabled: true}); 
	});
	
	function accountsSearchContent(url) {
	    $('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	    }); 
	}
	
	function isNumber(evt) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
         {
          $.messager.alert('Message',' Enter Numbers Only ','warning');    
            return false;
         }
        return true;
    }
	
	function funreload(event){
		 var branchval = document.getElementById("cmbbranch").value;
		 var atype = $('#cmbtype').val();
		 var accountno = $('#txtdocno').val();
		 
		 $('#date').val(new Date());
         $('#txtreason').val('');
         $('#txttrno').val('');
		 $('#txtoutamount').val('');
         $('#txtdtype').val('');
         $('#txtbranchid').val('');
         $('#applyinfo').val('');
  	     $("#appliedDetailsGrid").jqxGrid({ disabled: true});
         $("#appliedDetailsGrid").jqxGrid('clear'); 
  	     $('#date').jqxDateTimeInput({disabled: true});
  	     $('#txtreason').attr("readonly",true);
         $('#btndelete').attr("disabled",true);
         
  	     if(accountno==''){
			 $.messager.alert('Message','Account is Mandatory.','warning');
			 return 0;
		 }
  	   
		 $("#overlay, #PleaseWait").show();
		 
		 $("#appliedDiv").load("appliedGrid.jsp?branchval="+branchval+'&atype='+atype+'&accountno='+accountno+'&check=1');
    }
	
	function funDelete(event){
		
		var trno =  $('#txttrno').val();
		var accountno =  $('#txtdocno').val();
		var outamount =  $('#txtoutamount').val();
		var dtype =  $('#txtdtype').val();
		var branchid =  $('#txtbranchid').val();
		var date =  $('#date').val();
		var reason =  $('#txtreason').val();
		
		if(reason==''){
			 $.messager.alert('Message','Please Enter the Reason.','warning');
			 return 0;
		 }
		
		 $.messager.confirm('Message', 'Do you want to delete?', function(r){
		        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		saveGridData(trno,accountno,outamount,dtype,branchid,date,reason);	
		     	}
		});
	}
	    
	function saveGridData(trno,accountno,outamount,dtype,branchid,date,reason){

		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
	     			
				var items=x.responseText;
				$('#txttrno').val('');
				$('#txtoutamount').val('');
				$('#txtdtype').val('');
				$('#txtbranchid').val('');
				$('#date').val(new Date());
				$('#txtreason').val('');
				$('#applyinfo').val('');
				
				$.messager.alert('Message', '  Record Successfully Deleted ', function(r){
			    });
				funreload(event); 
				}
		}
			
	x.open("GET","saveData.jsp?trno="+trno+"&accountno="+accountno+"&outamount="+outamount+"&dtype="+dtype+"&branchid="+branchid+"&date="+date+"&reason="+reason,true);
	x.send();
			
	}
	
	function clearAccountInfo(){
		$('#txtdocno').val('');
        $('#txtaccid').val('');
        $('#txtaccname').val('');
		$('#txttrno').val('');
        $('#txtoutamount').val('');
        $('#txtdtype').val('');
		$('#txtbranchid').val('');
        $('#date').val(new Date());
        $('#txtreason').val('');
		$('#applyinfo').val('');
        
		$("#appliedDetailsGrid").jqxGrid({ disabled: true});
        $("#appliedDetailsGrid").jqxGrid('clear'); 
		$("#appliedDelete").jqxGrid('clear');
        $('#date').jqxDateTimeInput({disabled: true});
  	    $('#txtreason').attr("readonly",true);
        $('#btndelete').attr("disabled",true);
  	    
  	    if (document.getElementById("txtaccid").value == "") {
	        $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
	    }
	}
	
	function getAccTypeFrom(event){
        var x= event.keyCode;
        if(x==114){
      		accountsSearchContent('accountsDetailsSearch.jsp');
        }
    }
	
	function funSearchdblclick(){
		  $('#txtaccid').dblclick(function(){
			  accountsSearchContent('accountsDetailsSearch.jsp');
		  });
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
                            <td class="label-cell">Type</td>
                            <td>
                                <select id="cmbtype" name="cmbtype" onchange="clearAccountInfo();" value='<s:property value="cmbtype"/>'>
                                    <option value="AR">AR</option>
                                    <option value="AP">AP</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Account</td>
                            <td>
                                <input type="text" id="txtaccid" name="txtaccid" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>' ondblclick="funSearchdblclick();" onkeydown="getAccTypeFrom(event);"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell"></td>
                            <td>
                                <input type="text" id="txtaccname" name="txtaccname" readonly="readonly" value='<s:property value="txtaccname"/>' tabindex="-1"/>
                                <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="padding-top: 10px;">
                                <textarea id="applyinfo" name="applyinfo" readonly="readonly"><s:property value="applyinfo" ></s:property></textarea>
                            </td>
                        </tr>
                    </table>

                    <div style="border-top: 1px solid #e3e8ee; margin-top: 15px; padding-top: 15px;">
                        <table class="release-filter-table">
                            <tr>
                                <td class="label-cell">Date</td>
                                <td><div id="date" name="date" value='<s:property value="date"/>'></div></td>
                            </tr>
                            <tr>
                                <td class="label-cell">Reason</td>
                                <td>
                                    <input type="text" id="txtreason" name="txtreason" value='<s:property value="txtreason"/>'/>
                                </td>
                            </tr>
                        </table>
                    </div>

                    <div class="release-actions">
                        <button class="btn-submit" type="button" id="btndelete" name="btndelete" onclick="funDelete(event);">Delete</button>
                    </div>

                    <!-- Hidden Elements -->
                    <input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
                    <input type="hidden" id="txtoutamount" name="txtoutamount" value='<s:property value="txtoutamount"/>'/>
                    <input type="hidden" id="txtdtype" name="txtdtype" value='<s:property value="txtdtype"/>'/>
                    <input type="hidden" id="txtbranchid" name="txtbranchid" value='<s:property value="txtbranchid"/>'/>
                </div>
            </div>
        </div>

        <!-- Main Grid / Data Section -->
        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div id="appliedDiv" style="flex: 1; min-height: 250px;"><jsp:include page="appliedGrid.jsp"></jsp:include></div>
                <div id="detailDiv" style="flex: 1; min-height: 250px;"><jsp:include page="appliedDetailGrid.jsp"></jsp:include></div>
            </div>

        </div>

        <!-- Modals -->
        <div id="accountDetailsWindow">
            <div></div><div></div>
        </div>

    </div> 
</div> 
</body>
</html>