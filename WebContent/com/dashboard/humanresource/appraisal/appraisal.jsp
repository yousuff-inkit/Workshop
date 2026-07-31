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
		$('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employee Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		$('#employeeDetailsWindow').jqxWindow('close');
		 
 		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
		$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		$('#txtemployeeid').attr('readonly', true);
		$('#txtemployeename').attr('readonly', true);
		 
		$('#txtemployeeid').dblclick(function(){
	  		employeeSearchContent("employeeDetailsSearch.jsp");
		});
	});

	function employeeSearchContent(url) {
	 	$('#employeeDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		    $('#employeeDetailsWindow').jqxWindow('setContent', data);
		    $('#employeeDetailsWindow').jqxWindow('bringToFront');
	    }); 
	}

    function getDepartment() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var departmentItems = items[0].split(",");
				var departmentIdItems = items[1].split(",");
				var optionsdepartment = '<option value="">--Select--</option>';
				for (var i = 0; i < departmentItems.length; i++) {
					optionsdepartment += '<option value="' + departmentIdItems[i] + '">'
							+ departmentItems[i] + '</option>';
				}
				$("select#cmbempdepartment").html(optionsdepartment);
			}
		}
		x.open("GET", "getDepartment.jsp", true);
		x.send();
	}
	
    function getYear() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var yearItems = items[0].split(",");
				var yearIdItems = items[1].split(",");
				var optionsyear = '<option value="">--Select--</option>';
				for (var i = 0; i < yearItems.length; i++) {
					optionsyear += '<option value="' + yearIdItems[i] + '">'
							+ yearItems[i] + '</option>';
				}
				$("select#cmbyear").html(optionsyear);
			}
		}
		x.open("GET", "getYear.jsp", true);
		x.send();
	}
    
    function getPayrollCategory() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var payrollcategoryItems = items[0].split(",");
				var payrollcategoryIdItems = items[1].split(",");
				var optionspayrollcategory = '<option value="">--Select--</option>';
				for (var i = 0; i < payrollcategoryItems.length; i++) {
					optionspayrollcategory += '<option value="' + payrollcategoryIdItems[i] + '">'
							+ payrollcategoryItems[i] + '</option>';
				}
				$("select#cmbempcategory").html(optionspayrollcategory);
			}
		}
		x.open("GET", "getPayrollCategory.jsp", true);
		x.send();
	}
    
    function getAllowancesType() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var allowancetypeItems = items[0].split(",");
				var allowancetypeIdItems = items[1].split(",");
				var optionsallowancetype = '<option value="">--Select--</option>';
				for (var i = 0; i < allowancetypeItems.length; i++) {
					optionsallowancetype += '<option value="' + allowancetypeIdItems[i] + '">'
							+ allowancetypeItems[i] + '</option>';
				}
				$("select#cmballowancetype").html(optionsallowancetype);
			}
		}
		x.open("GET", "getAllowancesType.jsp", true);
		x.send();
	}
    
    function getEmployeeId(event){
        var x= event.keyCode;
        if(x==114){
        	employeeSearchContent("employeeDetailsSearch.jsp");
        }
    }
    
    function funallowancestype() {
   	    var leavetype=$('#cmballowancetype').children("option").length;
		for(var k=1 ; k <= leavetype ; k++){
			$('#txtallowancetype'+k).val($('#cmballowancetype option').eq(k).text().trim());
		} 
    }
    
    function funClearInfo(){
		$('#cmbbranch').val('a');
        $('#cmbyear').val('');
        $('#cmbmonth').val('');
        $('#cmbempdepartment').val('');
        $('#cmbempcategory').val('');
		$('#txtemployeeid').val('');
        $('#txtemployeedocno').val('');
        $('#txtemployeename').val('');
		$("#appraisalDetailsGridID").jqxGrid('clear');
        $("#appraisalDetailsGridID").jqxGrid('addrow', null, {});
	}
    
    function funClearYearInfo(){
		$('#cmbmonth').val('');
        $('#cmbempdepartment').val('');
        $('#cmbempcategory').val('');
		$('#txtemployeeid').val('');
        $('#txtemployeedocno').val('');
        $('#txtemployeename').val('');
		$("#appraisalDetailsGridID").jqxGrid('clear');
        $("#appraisalDetailsGridID").jqxGrid('addrow', null, {});
	}
	
	function funExportBtn(){
		//JSONToCSVCon(dataExcelExport, 'LeaveDetails', true);
	} 
	
	function funreload(event){
		 var year=$('#cmbyear').val();
		 var month=$('#cmbmonth').val();
		 var department=$('#cmbempdepartment').val();
		 var category=$('#cmbempcategory').val();
		 var empId=$('#txtemployeedocno').val();
		 if(year==''){
			 $.messager.alert('Message','Year is Mandatory.','warning');
			 return 0;
		 }
		 
		 funallowancestype();
		 
		 $("#overlay, #PleaseWait").show();
		 
		 $("#appraisalDiv").load("appraisalGrid.jsp?year="+year+"&month="+month+"&department="+department+"&category="+category+"&empId="+empId+"&check=1");
	}
	
</script>
</head>
<body onload="getBranch();getYear();getDepartment();getPayrollCategory();getAllowancesType();">
    <div id="mainBG" class="homeContent" data-type="background"> 
        <div class="master-container">

            <!-- Sidebar / Filter Section -->
            <div class="sidebar-filters">
                <div class="sidebar-scroll-content">
                    <div class="filter-card">
                        <table class="release-filter-table">
                            <tr>
                                <td class="label-cell">Year</td>
                                <td>
                                    <select name="cmbyear" id="cmbyear" onchange="funClearYearInfo();" value='<s:property value="cmbyear"/>'></select>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">Month</td>
                                <td>
                                    <select id="cmbmonth" name="cmbmonth" value='<s:property value="cmbmonth"/>'>
                                        <option value="">--Select--</option>
                                        <option value="01">January</option>
                                        <option value="02">February</option>
                                        <option value="03">March</option>
                                        <option value="04">April</option>
                                        <option value="05">May</option>
                                        <option value="06">June</option>
                                        <option value="07">July</option>
                                        <option value="08">August</option>
                                        <option value="09">September</option>
                                        <option value="10">October</option>
                                        <option value="11">November</option>
                                        <option value="12">December</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">Department</td>
                                <td>
                                    <select id="cmbempdepartment" name="cmbempdepartment" value='<s:property value="cmbempdepartment"/>'>
                                        <option value="">--Select--</option>
                                    </select>
                                </td>
                            </tr> 
                            <tr>
                                <td class="label-cell">Category</td>
                                <td>
                                    <select id="cmbempcategory" name="cmbempcategory" value='<s:property value="cmbempcategory"/>'>
                                        <option value="">--Select--</option>
                                    </select>
                                </td>
                            </tr> 
                            <tr>
                                <td class="label-cell">Employee</td>
                                <td>
                                    <input type="text" id="txtemployeeid" name="txtemployeeid" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtemployeeid"/>' onkeydown="getEmployeeId(event);"/>
                                    <input type="hidden" id="txtemployeedocno" name="txtemployeedocno" value='<s:property value="txtemployeedocno"/>'/>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell"></td>
                                <td>
                                    <input type="text" id="txtemployeename" name="txtemployeename" readonly="readonly" placeholder="Employee Name" tabindex="-1" value='<s:property value="txtemployeename"/>'/>
                                </td>
                            </tr>	
                        </table>

                        <div class="release-actions">
                            <button type="button" class="btn-submit" name="clear" id="clear" onclick="funClearInfo();">Clear</button>
                        </div>

                        <!-- Hidden elements logically preserved -->
                        <div style="display: none;">
                            <select id="cmballowancetype" name="cmballowancetype" value='<s:property value="cmballowancetype"/>'></select>
                            <input type="hidden" id="txtallowancetype1" name="txtallowancetype1" value='<s:property value="txtallowancetype1"/>'/>
                            <input type="hidden" id="txtallowancetype2" name="txtallowancetype2" value='<s:property value="txtallowancetype2"/>'/>
                            <input type="hidden" id="txtallowancetype3" name="txtallowancetype3" value='<s:property value="txtallowancetype3"/>'/>
                            <input type="hidden" id="txtallowancetype4" name="txtallowancetype4" value='<s:property value="txtallowancetype4"/>'/>
                            <input type="hidden" id="txtallowancetype5" name="txtallowancetype5" value='<s:property value="txtallowancetype5"/>'/>
                            <input type="hidden" id="txtallowancetype6" name="txtallowancetype6" value='<s:property value="txtallowancetype6"/>'/>
                            <input type="hidden" id="txtallowancetype7" name="txtallowancetype7" value='<s:property value="txtallowancetype7"/>'/>
                            <input type="hidden" id="txtallowancetype8" name="txtallowancetype8" value='<s:property value="txtallowancetype8"/>'/>
                            <input type="hidden" id="txtallowancetype9" name="txtallowancetype9" value='<s:property value="txtallowancetype9"/>'/>
                            <input type="hidden" id="txtallowancetype10" name="txtallowancetype10" value='<s:property value="txtallowancetype10"/>'/>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Main Grid / Data Section -->
            <div class="main-content-area">
                
                <div class="top-toolbar-container">
                    <jsp:include page="../../heading.jsp"></jsp:include>
                </div>

                <div class="grid-content-container">
                    <div id="appraisalDiv"><jsp:include page="appraisalGrid.jsp"></jsp:include></div>
                </div>

            </div>

        </div>

        <!-- Modals -->
        <div id="employeeDetailsWindow">
            <div></div>
        </div>

    </div> 
</body>
</html>