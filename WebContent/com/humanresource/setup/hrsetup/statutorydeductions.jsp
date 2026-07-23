<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<%
String contextPath=request.getContextPath();
%>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>

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

<%@page import="com.humanresource.setup.hrsetup.statutorydeductions.ClsStatutorydeductionsDAO"%>
<% ClsStatutorydeductionsDAO showDAO = new ClsStatutorydeductionsDAO(); %>  

<script type="text/javascript">
	$(document).ready(function () {    
		document.getElementById("formdet").innerText="Statutory Deductions(STD)";
		document.getElementById("formdetail").value="Statutory Deductions";
		document.getElementById("formdetailcode").value="STD";
		window.parent.formCode.value="STD";
		window.parent.formName.value="Statutory Deductions";
	   
        /* Formatted jqxDateTimeInput heights to match modern UI 24px */
		$("#statudate").jqxDateTimeInput({ width: '125px', height: 24 ,formatString : "dd.MM.yyyy", theme: 'energyblue' });
	    
        /* force internal alignment AFTER render */
        setTimeout(function () {
            $("#statudate").find("input").css({
                "margin-top": "0px",
                "line-height": "24px",
                "font-size": "12px", 
                "font-family": "Arial, sans-serif", 
                "padding": "0 6px", 
                "box-sizing":"border-box"
            });
            $("#statudate").find(".jqx-action-button").css({
                "top": "0px",
                "height": "24px"
            });
        }, 0);

	    $('#accountSearchwindow').jqxWindow({ width: '60%', height: '62%',  maxHeight: '75%' ,maxWidth: '60%' , title: 'Account Search' ,position: { x: 150, y: 60 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		$('#accountSearchwindow').jqxWindow('close');
		   
		$('#acno').dblclick(function(){
            if($('#mode').val()!= "view") {
                $('#accountSearchwindow').jqxWindow('open');
                accountSearchContent('accountsDetailsSearch.jsp?');
            }
		});   
		   
        var alcdata='<%=showDAO.searchstatu()%>';
            
        var source =
        {
            datatype: "json",
            datafields: [
                        {name : 'doc_no' , type: 'number' },
                        {name : 'date', type: 'date'  },
                        {name : 'satudeduction', type: 'String'  },
                        {name : 'acno', type: 'String'  },
                        {name : 'accname', type: 'String'  },
                        {name : 'remarks', type: 'String'  },
                        {name : 'accdocno', type: 'String'  },
                    {name : 'chktype', type: 'String'  },
                        
                ],
                localdata: alcdata,
                
            pager: function (pagenum, pagesize, oldpagenum) {
                
            }
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source);

        $("#deductiongrid").jqxGrid(
                {
                    width: "100%",
                    height:375,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                    theme: 'energyblue',
                    columns: [
                        { text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '7%' },
                        { text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '7%',cellsformat:'dd.MM.yyyy' },
                        { text: 'Statutory Deductions',columntype: 'textbox', filtertype: 'input', datafield: 'satudeduction', width: '20%' },
                        { text: 'Account',columntype: 'textbox', filtertype: 'input', datafield: 'acno', width: '10%' },
                        { text: 'Account Name',columntype: 'textbox', filtertype: 'input', datafield: 'accname', width: '26%' },
                        { text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks', width: '30%' },
                        { text: 'accdocno',columntype: 'textbox', filtertype: 'input', datafield: 'accdocno', width: '10%' ,hidden: true},
                        { text: 'chktype',columntype: 'textbox', filtertype: 'input', datafield: 'chktype', width: '10%' ,hidden: true},
                        ]
                });

        $('#deductiongrid').on('rowdoubleclick', function (event) {
            var rowindex1=event.args.rowindex;
            
            document.getElementById("docno").value= $('#deductiongrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
            document.getElementById("satudeduction").value = $("#deductiongrid").jqxGrid('getcellvalue', rowindex1, "satudeduction");
            $("#statudate").jqxDateTimeInput('val', $("#deductiongrid").jqxGrid('getcellvalue', rowindex1, "date"));
            document.getElementById("remarks").value = $("#deductiongrid").jqxGrid('getcellvalue', rowindex1, "remarks");
            document.getElementById("acno").value = $("#deductiongrid").jqxGrid('getcellvalue', rowindex1, "acno");
            document.getElementById("accname").value = $("#deductiongrid").jqxGrid('getcellvalue', rowindex1, "accname");
            document.getElementById("accdocno").value = $("#deductiongrid").jqxGrid('getcellvalue', rowindex1, "accdocno");
            $('#frmstatudeduction select').attr('disabled', false);
            document.getElementById("type").value = $("#deductiongrid").jqxGrid('getcellvalue', rowindex1, "chktype");
            
            if ($("#mode").val() == "view") {
                $('#frmstatudeduction select').attr('disabled', true);
            }
        });   
    });
	
	function funSearchLoad(){
		 changeContent('statutorydeductionsearch.jsp'); 
	}
	 
    function accountSearchContent(url) {
        $.get(url).done(function (data) {
            $('#accountSearchwindow').jqxWindow('setContent', data);
        }); 
    }
  	  
	function funReadOnly() {
		$('#frmstatudeduction input').attr('readonly', true);
		$('#frmstatudeduction select').attr('disabled', true);
		$('#statudate').jqxDateTimeInput({ disabled: true});
	}
	
	function funRemoveReadOnly() {
		$('#frmstatudeduction input').attr('readonly', false);
		$('#frmstatudeduction select').attr('disabled', false);
		$('#docno').attr('readonly', true);
		$('#acno').attr('readonly', true);
		$('#accname').attr('readonly', true);
		$('#statudate').jqxDateTimeInput({ disabled: false});

		if ($("#mode").val() == "A") {
			 $('#statudate').val(new Date());
		}
	}
 
	function setValues() {
		if($('#datehidden').val()){
			$("#statudate").jqxDateTimeInput('val', $('#datehidden').val());
		}
		
		if($('#msg').val()!=""){
			$.messager.alert('Message',$('#msg').val());
		}
		 
		if($('#hidtype').val()=="1") {
			$('#type').val("1");
		} else {
			$('#type').val("0");
		}
	}
	
	function getaccountdetails(event){
        var x= event.keyCode;
        if($('#mode').val()!="view") {
            if(x==114){
                $('#accountSearchwindow').jqxWindow('open');
                accountSearchContent('accountsDetailsSearch.jsp?');    
            }
        }
    }
	     
    function funNotify(){
        if(document.getElementById("satudeduction").value=="") {
            document.getElementById("errormsg").innerText=" Enter Statutory Deductions";
            document.getElementById("satudeduction").focus();
            return 0;
        }
        
        if(document.getElementById("acno").value=="") {
            document.getElementById("errormsg").innerText=" Search Account";
            document.getElementById("acno").focus();
            return 0;
        }
        return 1;
    } 
	     
    function funFocus(){
        $('#statudate').jqxDateTimeInput('focus');
    }
	  
</script>   
 
</head>
<body onLoad="setValues();" > 
<div id="mainBG" class="homeContent" data-type="background">
    <form id="frmstatudeduction" action="savestatuDeduction" method="post" autocomplete="off">
        <jsp:include page="../../../../header.jsp" />
        
        <div class='modern-ui hidden-scrollbar'>
            <div id="errormsg"></div>

            <div class="middle-panel">
                <span class="middle-panel-title">Statutory Deductions Details</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Date</label>
                    <div style="width: 125px;">
                        <div id="statudate" name="statudate" value='<s:property value="statudate"/>'> </div>
                    </div>
                    
                    <label class="lbl-right" style="width:130px; margin-left:15px;">Statutory Deductions</label>
                    <input type="text" name="satudeduction" id="satudeduction" style="flex:1;" placeholder="Statutory Deductions" value='<s:property value="satudeduction"/>'>
                    
                    <label class="lbl-right" style="width:60px; margin-left:15px;">Doc No</label>
                    <input type="text" name="docno" id="docno" style="width:100px;" value='<s:property value="docno"/>' readonly="readonly" tabindex="-1">
                </div>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Account</label>
                    <div class="input-search-container" style="width: 125px;">
                        <input type="text" name="acno" id="acno" readonly="readonly" placeholder="Press F3" onKeyDown="getaccountdetails(event);" value='<s:property value="acno"/>'>
                        <svg class="magnifier-icon" onclick="$('#acno').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    <input type="text" name="accname" id="accname" style="flex:1;" readonly="readonly" value='<s:property value="accname"/>'>
                    
                    <label class="lbl-right" style="width:40px; margin-left:15px;">Type</label>
                    <select name="type" id="type" style="width:120px;" value='<s:property value="type"/>'>
                        <option value="0">Amount</option>
                        <option value="1">Percentage</option>
                    </select>
                </div>
                
                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:80px;">Remarks</label>
                    <input type="text" name="remarks" id="remarks" style="flex:1;" placeholder="Remarks" value='<s:property value="remarks"/>'>
                </div>
            </div>
            
            <div class="middle-panel">
                <span class="middle-panel-title">Statutory Deductions Records</span>
                <div id="deductiongrid" class="grid-container"></div>
            </div>

            <!-- Hidden Logic Fields -->
            <div style="display:none;">
                <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
                <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/> 
                <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/> 
                <input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/> 
                <input type="hidden" name="accdocno" id="accdocno" value='<s:property value="accdocno"/>' >
                <input type="hidden" name="hidtype" id="hidtype" value='<s:property value="hidtype"/>' >
            </div>
        </div>
    </form>
</div>

<!-- Search Windows Outside of Form Content to prevent scrolling issues -->
<div id="accountSearchwindow">
    <div></div><div></div>
</div>	

</body>
</html>