<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script> 

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

.modern-ui .myButton-delete {
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
    background: linear-gradient(135deg, #dc2626 0%, #b91c1c 100%);
    color: #ffffff;
    white-space: nowrap;
}
.modern-ui .myButton-delete:hover { background: linear-gradient(135deg, #b91c1c 0%, #991b1b 100%); }

.modern-ui .myButton-success {
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
    background: linear-gradient(135deg, #16a34a 0%, #15803d 100%);
    color: #ffffff;
    white-space: nowrap;
}
.modern-ui .myButton-success:hover { background: linear-gradient(135deg, #15803d 0%, #166534 100%); }

.modern-ui .myButton-clear {
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
    background: linear-gradient(135deg, #64748b 0%, #475569 100%);
    color: #ffffff;
    white-space: nowrap;
}
.modern-ui .myButton-clear:hover { background: linear-gradient(135deg, #475569 0%, #334155 100%); }


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
    overflow: auto;
    height: calc(100vh - 120px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

form label.error { color:red; font-weight:bold; }
#errormsg { color:red; font-weight:bold; text-align:center; margin-bottom: 10px; }
</style>

<script type="text/javascript">
      $(document).ready(function () {
    	  $('#btnClose').attr('disabled', true );$('#btnCreate').attr('disabled', true );$('#btnEdit').attr('disabled', true );$('#btnPrint').attr('disabled', true );
 		  $('#btnExcel').attr('disabled', true );$('#btnDelete').attr('disabled', true );$('#btnSearch').attr('disabled', true );$('#btnAttach').attr('disabled', true );
 		 
    	  /* Formatted jqxDateTimeInput heights to match modern UI 24px */
    	  $("#overtime").jqxDateTimeInput({ width: '125px', height: 24, formatString:'HH:mm', showCalendarButton: false, theme: 'energyblue'});
    	  
          /* force internal alignment AFTER render */
          setTimeout(function () {
              $("#overtime").find("input").css({
                  "margin-top": "0px",
                  "line-height": "24px",
                  "font-size": "12px", 
                  "font-family": "Arial, sans-serif", 
                  "padding": "0 6px", 
                  "box-sizing":"border-box"
              });
              $("#overtime").find(".jqx-action-button").css({
                  "top": "0px",
                  "height": "24px"
              });
          }, 0);

    	  /* Searching Window */
     	 $('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employee Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
  		 $('#employeeDetailsWindow').jqxWindow('close');
  		 
  		 $('#txtemployeeid').dblclick(function(){
  			employeeSearchContent("employeeDetailsSearch.jsp");
		  });
  		 
  		 $('#btnApply').attr('disabled', true);
		 $('#btnApplyDelete').attr('disabled', true);
		 document.getElementById("rdholiday").checked=true;
	     document.getElementById("chckhalfday").checked=false;
	     document.getElementById("hidchckhalfday").value = 0;
		 document.getElementById("chckmarkall").checked=false;
	     document.getElementById("hidchckmarkall").value = 0; 
		 $('#overtime').jqxDateTimeInput({disabled: true});
		 $("#attendanceGridID").jqxGrid('clear');
		 $("#attendanceGridID").jqxGrid('addrow', null, {});
		 $("#attendanceGridID").jqxGrid({ disabled: true});radioClick();
		 $('#txtemployeeid').attr('readonly', true);
		 $('#txtemployeename').attr('readonly', true);
		 $('#txtmarkedattendance').val('0');
		 
    	  getDepartment();getPayrollCategory();getYear();getDay();getLeaveType();getHoliday();getAttendanceLeaveEditEnable();
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
  				if ($('#hidcmbempdepartment').val() != null) {
  					$('#cmbempdepartment').val($('#hidcmbempdepartment').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "getDepartment.jsp", true);
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
				if ($('#hidcmbempcategory').val() != null) {
					$('#cmbempcategory').val($('#hidcmbempcategory').val());
				}
			} else {
			}
		}
		x.open("GET", "getPayrollCategory.jsp", true);
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
				if ($('#hidcmbyear').val() != null) {
					$('#cmbyear').val($('#hidcmbyear').val());
				}
			} else {
			}
		}
		x.open("GET", "getYear.jsp", true);
		x.send();
	}
    
    function getDay() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var daysItems = items[0].split(",");
				var daysIdItems = items[1].split(",");
				var optionsdays = '<option value="">--Select--</option>';
				for (var i = 0; i < daysItems.length; i++) {
					optionsdays += '<option value="' + daysIdItems[i] + '">'
							+ daysItems[i] + '</option>';
				}
				$("select#cmbday").html(optionsdays);
				if ($('#hidcmbday').val() != null) {
					$('#cmbday').val($('#hidcmbday').val());
				}
			} else {
			}
		}
		x.open("GET", "getDay.jsp?year="+$('#cmbyear').val()+"&month="+$('#cmbmonth').val(), true);
		x.send();
	}
    
    function getLeaveType() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var leavetypeItems = items[0].split(",");
				var leavetypeIdItems = items[1].split(",");
				var optionsleavetype = '<option value="">--Select--</option>';
				for (var i = 0; i < leavetypeItems.length; i++) {
					optionsleavetype += '<option value="' + leavetypeIdItems[i] + '">'
							+ leavetypeItems[i] + '</option>';
				}
				$("select#cmbleavetype").html(optionsleavetype);
				if ($('#hidcmbleavetype').val() != null) {
					$('#cmbleavetype').val($('#hidcmbleavetype').val());
				}
			} else {
			}
		}
		x.open("GET", "getLeaveType.jsp", true);
		x.send();
	}
    
    function getHoliday() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var holidayItems = items[0].split(",");
				var holidayIdItems = items[1].split(",");
				var optionsholiday = '<option value="">--Select--</option>';
				for (var i = 0; i < holidayItems.length; i++) {
					optionsholiday += '<option value="' + holidayIdItems[i] + '">'
							+ holidayItems[i] + '</option>';
				}
				$("select#cmbholiday").html(optionsholiday);
				if ($('#hidcmbholiday').val() != null) {
					$('#cmbholiday').val($('#hidcmbholiday').val());
				}
			} else {
			}
		}
		x.open("GET", "getHoliday.jsp", true);
		x.send();
	}
    
    function getNewGridValue(a){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText.trim();
  				
  			    $('#txtselectedcelltextvalue').val(items);
  		}
  		}
  		x.open("GET", "getNewGridValue.jsp?refno="+a, true);
  		x.send();
    }
    
    function getHolidaysOfMonth(year,month) {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  			    $('#txtholidaysofmonth').val(items);
  		}
  		}
  		
  		x.open("GET", "getHolidaysOfMonth.jsp?year="+year+"&month="+month, true);
  		x.send();
     }
    
    function getAttendanceLeaveEditEnable(){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  			    $('#txtattendanceleaveseditgrid').val(items);
  			    
  			  	if(parseInt($('#txtattendanceleaveseditgrid').val())==0){
  				 	 $("#rdtotalleaves_container").hide();document.getElementById("rdtotalleaves1").innerText=" ";$("#btnRecheck").show();
	  			 } else {
	  				 $("#rdtotalleaves_container").show();document.getElementById("rdtotalleaves1").innerText="Total Leaves";$("#btnRecheck").hide();
  				 }
  		}
  		}
  		x.open("GET", "getAttendanceLeaveEditEnable.jsp", true);
  		x.send();
    }
    
    function getEmployeeId(event){
        var x= event.keyCode;
        if(x==114){
        	employeeSearchContent("employeeDetailsSearch.jsp");
        }
        else{}
        }
      
	function funReadOnly(){} 
	
	function funRemoveReadOnly(){}
	
	function funSearchLoad(){}
	
	function funChkButton(){
		/* funReset(); */
	}
	 
	 function funNotify(){	
 		 return 1;
		} 
	 
	 function funFocus(){
		    document.getElementById("cmbyear").focus();
	    }
	 
	 function setValues(){
		 
			 if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			 
			 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
			 funSetlabel();
            
             var indexVal = document.getElementById("docno").value;
			 if(indexVal> 0){
	         	 $("#attendanceDiv").load("attendanceGrid.jsp?docno="+indexVal);
			 } 
		}
	 
	 function radioClick(){
		 if(document.getElementById("rdovertime").checked==true){
			 $('#overtime').jqxDateTimeInput({disabled: false});
			 $('#cmbholiday').attr('disabled', true);
			 $('#cmbleavetype').attr('disabled', true);
			 $('#chckhalfday').attr('disabled', true);
			 document.getElementById("cmbholiday").value = "";
			 document.getElementById("cmbleavetype").value = "";
			 document.getElementById("chckhalfday").checked=false;
			 document.getElementById("hidchckhalfday").value = 0;
			 
			 var overtimes = $('#overtime').val();
			 var overtime = overtimes.split(":");
			 var value = ((overtime[0]*60)+overtime[1]);
			 $('#txtselectedcellvalue').val(value);
			 
		 }else if(document.getElementById("rdleavetype").checked==true){
			 $('#cmbleavetype').attr('disabled', false);
			 $('#chckhalfday').attr('disabled', false);
			 $('#cmbholiday').attr('disabled', true);
			 $('#overtime').jqxDateTimeInput({disabled: true});
			 document.getElementById("cmbholiday").value = "";
			 var settime=new Date();
			 settime.setHours(0,0,0,0);
			 $('#overtime').jqxDateTimeInput('setDate',settime);
		 }else if(document.getElementById("rdtotalleaves").checked==true){
			 $('#cmbleavetype').attr('disabled', true);
			 $('#chckhalfday').attr('disabled', true);
			 $('#cmbholiday').attr('disabled', true);
			 $('#overtime').jqxDateTimeInput({disabled: true});
			 document.getElementById("cmbholiday").value = "";
			 var settime=new Date();
			 settime.setHours(0,0,0,0);
			 $('#overtime').jqxDateTimeInput('setDate',settime);
		 }else{
			 $('#cmbleavetype').attr('disabled', true);
			 $('#chckhalfday').attr('disabled', true);
			 $('#overtime').jqxDateTimeInput({disabled: true});
			 $('#cmbholiday').attr('disabled', false);
			 document.getElementById("cmbleavetype").value = "";
			 document.getElementById("chckhalfday").checked=false;
			 document.getElementById("hidchckhalfday").value = 0;
			 var settime=new Date();
			 settime.setHours(0,0,0,0);
			 $('#overtime').jqxDateTimeInput('setDate',settime);
		   }	 
	 }
	 
	 function clearhalfdaycheck(){
		    document.getElementById("chckhalfday").checked=false;
			document.getElementById("hidchckhalfday").value = 0;
	 }
	 
	 function markallcheck(){
	 		 if(document.getElementById("chckmarkall").checked){
	 			 document.getElementById("hidchckmarkall").value = 1;
	 		 }
	 		 else{
	 			 document.getElementById("hidchckmarkall").value = 0;
		 	} 
		}
	 
	 function halfdaycheck(){
 		 if(document.getElementById("chckhalfday").checked){
 			 document.getElementById("hidchckhalfday").value = 1;
 		 }
 		 else{
 			 document.getElementById("hidchckhalfday").value = 0;
 		 }
 		 
 		 var leavetype = $('#cmbleavetype').val();
		 var halfday = $('#hidchckhalfday').val();
		 var celltextvalue = ($('#txtselectedcelltextvalue').val()).charAt(0);
		 if(halfday=='0'){
			 $('#txtselectedcellvalue').val(leavetype);
			 $('#txtselectedcelltextvalue').val(celltextvalue);
		 }
		 if(halfday=='1'){
			 $('#txtselectedcellvalue').val(leavetype+"2");
			 $('#txtselectedcelltextvalue').val(celltextvalue+"2");
		 } 
 	 }
	 
	 function newValueSet(){
		 if(document.getElementById("rdovertime").checked==true){
			 var overtimes = $('#overtime').val();
			 var overtime = overtimes.split(":");
			 var value = ((parseInt(overtime[0])*60)+parseInt(overtime[1]));
			 $('#txtselectedcellvalue').val(value);
			 $('#txtselectedcelltextvalue').val(overtimes);
			 
		 }else if(document.getElementById("rdleavetype").checked==true){
			 var leavetype = $('#cmbleavetype').val();
			 var halfday = $('#hidchckhalfday').val();
			 
			 if(halfday=='0'){
			 	$('#txtselectedcellvalue').val(leavetype);
			 }
			 if(halfday=='1'){
				 $('#txtselectedcellvalue').val(leavetype+"2");
			 } 
		 }else{
			 var holiday = $('#cmbholiday').val();
			 $('#txtselectedcellvalue').val(holiday);
		   }	 
	 }
	 
	 function funViewAttendance(){
		    if(document.getElementById("btnView").value =="View"){
		    	
		    	if($('#cmbyear').val()==''){
		    		 document.getElementById("errormsg").innerText="Year is Mandatory.";
					 return 0;
				 }
		    	
		    	if($('#cmbmonth').val()==''){
		    		 document.getElementById("errormsg").innerText="Month is Mandatory.";
					 return 0;
				 }
		    	
		    	document.getElementById("errormsg").innerText="";
		    	
		    	$('#txtmarkedattendance').val('0');
		    	var x = document.getElementById("cmbday").length;
		    	var totdays=(x-1);
		    	$("#overlay, #PleaseWait").show();
		    	$("#attendanceDiv").load("attendanceGrid.jsp?totdays="+totdays+"&year="+$('#cmbyear').val()+"&month="+$('#cmbmonth').val()+"&day="+$('#cmbday').val()+"&department="+$('#cmbempdepartment').val()+"&category="+$('#cmbempcategory').val()+"&empid="+$('#txtemployeedocno').val()+"&check=1");
		    	document.getElementById("btnView").value ="Mark Attendance";
		    	$('#btnApply').attr('disabled', false);$('#btnApplyDelete').attr('disabled', false);
		    	$("#attendanceGridID").jqxGrid({ disabled: false});

		    }else if(document.getElementById("btnView").value =="Mark Attendance"){
		    	
		    	if($('#txtmonthlypayrollprocessed').val()=='1'){
		    		 $.messager.alert('Message','Payroll Processed,Attendance cannot be Changed.','warning');
					 return 0;
				} else {
					document.getElementById("errormsg").innerText="";
					$('#attendanceGridID').jqxGrid({ editable: false});
					
					if($('#hidchckmarkall').val()=='1'){
						var rows = $("#attendanceGridID").jqxGrid('getrows');
						for(var i=0 ; i < rows.length ; i++){
							$("#overlay, #PleaseWait").show();
							$('#attendanceGridID').jqxGrid('setcellvalue', i, $('#txtselectedcellcolumn').val() ,$('#txtselectedcelltextvalue').val()); 
						}
						
						$("#overlay, #PleaseWait").hide();
						
					} else { 
		    			$('#attendanceGridID').jqxGrid('setcellvalue', $('#txtselectedcellrow').val(), $('#txtselectedcellcolumn').val(),$('#txtselectedcelltextvalue').val());
					} 
					
					if($('#txtattendanceleaveseditgrid').val().trim()=='0'){
						$('#txtmarkedattendance').val('1');	
					}
				}
		    }
		    
	 }
	 
	function  funClearInfo(){
			
			var attendanceleavesedit = document.getElementById("txtattendanceleaveseditgrid").value;
		
		 	$('input[type=text]').val('');
		    $('select').find('option').prop("selected", false);
			$('input[type=radio]').prop("checked", false);
			$('input:checkbox').removeAttr('checked');
			
			
			document.getElementById("txtattendanceleaveseditgrid").value=attendanceleavesedit;
			$('#txtmarkedattendance').val('0');
			document.getElementById("rdholiday").checked=true;
			document.getElementById("chckhalfday").checked=false;
			document.getElementById("hidchckhalfday").value = 0;
			document.getElementById("chckmarkall").checked=false;
	        document.getElementById("hidchckmarkall").value = 0; 
			
			document.getElementById("txtrecheckemptotalleaves").value="";
			document.getElementById("txtrecheckemptotalleavesgridlength").value="";
		 
			radioClick();
			var settime=new Date();
			settime.setHours(0,0,0,0);
			$('#overtime').jqxDateTimeInput('setDate',settime);
			
			$("#attendanceGridID").jqxGrid('clear');
			$("#attendanceGridID").jqxGrid('addrow', null, {});
			$("#attendanceGridID").jqxGrid({ disabled: true});
			
			 if (document.getElementById("txtemployeeid").value == "") {
			        $('#txtemployeeid').attr('placeholder', 'Press F3 to Search'); 
			        $('#txtemployeename').attr('placeholder', 'Employee Name');
			    }
			 
			 document.getElementById("btnView").value ="View";
			 $('#btnApply').attr('disabled', true);
		     $('#btnApplyDelete').attr('disabled', true);
		     document.getElementById("savemsg").innerText="";
		     document.getElementById("errormsg").innerText="";
	}
	 
	 function  funClearYearInfo(){
			
		    var year = document.getElementById("cmbyear").value;
		    var attendanceleavesedit = document.getElementById("txtattendanceleaveseditgrid").value;
			
		    $('input[type=text]').val('');
		    $('select').find('option').prop("selected", false);
			$('input[type=radio]').prop("checked", false);
			$('input:checkbox').removeAttr('checked');

			document.getElementById("cmbyear").value=year;
			document.getElementById("txtattendanceleaveseditgrid").value=attendanceleavesedit;
			$('#txtmarkedattendance').val('0');
			document.getElementById("rdholiday").checked=true;
			document.getElementById("chckhalfday").checked=false;
			document.getElementById("hidchckhalfday").value = 0;
			document.getElementById("chckmarkall").checked=false;
	        document.getElementById("hidchckmarkall").value = 0; 
			
			document.getElementById("txtrecheckemptotalleaves").value="";
			document.getElementById("txtrecheckemptotalleavesgridlength").value="";
			
			radioClick();
			var settime=new Date();
			settime.setHours(0,0,0,0);
			$('#overtime').jqxDateTimeInput('setDate',settime);
			
			$("#attendanceGridID").jqxGrid('clear');
			$("#attendanceGridID").jqxGrid('addrow', null, {});
			$("#attendanceGridID").jqxGrid({ disabled: true});
			
			 if (document.getElementById("txtemployeeid").value == "") {
			        $('#txtemployeeid').attr('placeholder', 'Press F3 to Search'); 
			        $('#txtemployeename').attr('placeholder', 'Employee Name');
			    }
			 
			 document.getElementById("btnView").value ="View";
			 $('#btnApply').attr('disabled', true);
		     $('#btnApplyDelete').attr('disabled', true);
		     document.getElementById("savemsg").innerText="";
		     document.getElementById("errormsg").innerText="";
	}
	 
	 function  funClearMonthInfo(){
			
		    var year = document.getElementById("cmbyear").value;
			var month = document.getElementById("cmbmonth").value;
			var attendanceleavesedit = document.getElementById("txtattendanceleaveseditgrid").value;
			
		    $('input[type=text]').val('');
		    $('select').find('option').prop("selected", false);
			$('input[type=radio]').prop("checked", false);
			$('input:checkbox').removeAttr('checked');

			document.getElementById("cmbyear").value=year;
			document.getElementById("cmbmonth").value=month;
			document.getElementById("txtattendanceleaveseditgrid").value=attendanceleavesedit;
			$('#txtmarkedattendance').val('0');
			document.getElementById("rdholiday").checked=true;
			document.getElementById("chckhalfday").checked=false;
			document.getElementById("hidchckhalfday").value = 0;
			document.getElementById("chckmarkall").checked=false;
	        document.getElementById("hidchckmarkall").value = 0; 
			
			document.getElementById("txtrecheckemptotalleaves").value="";
			document.getElementById("txtrecheckemptotalleavesgridlength").value="";
			
			radioClick();
			var settime=new Date();
			settime.setHours(0,0,0,0);
			$('#overtime').jqxDateTimeInput('setDate',settime);
			
			$("#attendanceGridID").jqxGrid('clear');
			$("#attendanceGridID").jqxGrid('addrow', null, {});
			$("#attendanceGridID").jqxGrid({ disabled: true});
			
			 if (document.getElementById("txtemployeeid").value == "") {
			        $('#txtemployeeid').attr('placeholder', 'Press F3 to Search'); 
			        $('#txtemployeename').attr('placeholder', 'Employee Name');
			    }
			 
			 document.getElementById("btnView").value ="View";
			 $('#btnApply').attr('disabled', true);
		     $('#btnApplyDelete').attr('disabled', true);
		     document.getElementById("savemsg").innerText="";
		     document.getElementById("errormsg").innerText="";
	}
	 
	 function funApplyAttendance(event){
		    var year = $('#cmbyear').val();
		    var month = $('#cmbmonth').val();
			var employee = $('#txtselectedemployee').val();
			var cellcolumn = $('#txtselectedcellcolumn').val();
			var cellvalue = $('#txtselectedcellvalue').val();
			var leave1total = $('#txtselectedcellleave1totalvalue').val();
			var leave2total = $('#txtselectedcellleave2totalvalue').val();
			var leave3total = $('#txtselectedcellleave3totalvalue').val();
			var leave4total = $('#txtselectedcellleave4totalvalue').val();
			var leave5total = $('#txtselectedcellleave5totalvalue').val();
			var leave6total = $('#txtselectedcellleave6totalvalue').val();
			var overtimevalue = $('#txtselectedcellovertimevalue').val();
			var holidayovertimevalue = $('#txtselectedcellholidayovertimevalue').val();
			var holidaysofmonth = $('#txtholidaysofmonth').val();
			var monthlypayrollprocessed = $('#txtmonthlypayrollprocessed').val();
			var category = $('#cmbempcategory').val();
			var department = $('#cmbempdepartment').val();
			var markall = $('#hidchckmarkall').val();
			var emptotalleavesarray="";
			var emptotalleavesgridlength="0";
			
			var funtype="1";
			
			if(document.getElementById("rdtotalleaves").checked==true){
				funtype="3";
			}
			
			if(cellcolumn.trim()==''){
				 document.getElementById("errormsg").innerText="Choose a Cell.";
				 return 0;
			 }
			
			if(year==''){
	    		 document.getElementById("errormsg").innerText="Year is Mandatory.";
				 return 0;
			 }
	    	
	    	if(month==''){
	    		 document.getElementById("errormsg").innerText="Month is Mandatory.";
				 return 0;
			 }
	    	
	    	if(monthlypayrollprocessed=='1'){
	    		 $.messager.alert('Message','Payroll Processed,Attendance cannot be Changed.','warning');
				 return 0;
			}
	    	
	    	if(document.getElementById("rdovertime").checked==true){
				 if($('#overtime').val()=='00:00'){
		    		 document.getElementById("errormsg").innerText="Enter a Valid Time.";
					 return 0;
				 }
			 } 
				 
			 if(document.getElementById("rdleavetype").checked==true){
				 if($('#cmbleavetype').val()==''){
		    		 document.getElementById("errormsg").innerText="Choose an Leave Type.";
					 return 0;
				 }
				
			 }
			 
			 if(document.getElementById("rdholiday").checked==true){
				 if($('#cmbholiday').val()==''){
		    		 document.getElementById("errormsg").innerText="Choose an Holiday Type.";
					 return 0;
				 }
			   }
			 
			 if($('#txtattendanceleaveseditgrid').val().trim()=='0' && $('#txtmarkedattendance').val().trim()=='0'){
				 document.getElementById("errormsg").innerText="Mark Attendance & Apply.";
				 return 0;
			}
			 	
	    	document.getElementById("errormsg").innerText="";
	    	
	    	var x = document.getElementById("cmbday").length;
	    	var totdays=(x-1);
	    	
			    $.messager.confirm('Message', 'Do you want to apply changes?', function(r){
				        
			     	if(r==false)
			     	  {
			     		return false; 
			     	  }
			     	else{
			     		
			     		 if(document.getElementById("rdtotalleaves").checked==true && $('#hidchckmarkall').val()=='1'){
			     			 
			     		 	var rows = $("#attendanceGridID").jqxGrid('getrows');
			     		 	
			     		 	var i=0;var tempemptotalleaves="",tempemptotalleaves1="";
			    	        $('#txtemptotalleavesgridlength').val(rows.length);
			    		    for (i = 0; i < rows.length; i++) {
			    		    	if(i==0){
			    		    		tempemptotalleaves=rows[i].employeedocno+"::"+rows[i].leave1total+"::"+rows[i].leave2total+"::"+rows[i].leave3total+"::"+rows[i].leave4total+"::"+rows[i].leave5total+"::"+rows[i].leave6total;
								}
								else{
									tempemptotalleaves=tempemptotalleaves+","+rows[i].employeedocno+"::"+rows[i].leave1total+"::"+rows[i].leave2total+"::"+rows[i].leave3total+"::"+rows[i].leave4total+"::"+rows[i].leave5total+"::"+rows[i].leave6total;
								}
			    		    	tempemptotalleaves1=tempemptotalleaves+",";
			    		    }
			    		    $('#txtemptotalleaves').val(tempemptotalleaves1);
			    		    emptotalleavesarray=$('#txtemptotalleaves').val();
			    		    emptotalleavesgridlength=$('#txtemptotalleavesgridlength').val();
			     		 }
			     		 
			     		 $("#overlay, #PleaseWait").show();
			     		 saveAttendanceData(year,month,employee,cellcolumn,cellvalue,totdays,leave1total,leave2total,leave3total,leave4total,leave5total,leave6total,emptotalleavesarray,emptotalleavesgridlength,overtimevalue,holidayovertimevalue,category,department,markall,funtype);	
			     	}
			 });
		}
	 
	 function funDeleteAttendance(event){
		    var year = $('#cmbyear').val();
		    var month = $('#cmbmonth').val();
			var employee = $('#txtselectedemployee').val();
			var cellcolumn = $('#txtselectedcellcolumn').val();
			var cellvalue = $('#txtselectedcelltextvalue').val();
			var leave1total = $('#txtselectedcellleave1totalvalue').val();
			var leave2total = $('#txtselectedcellleave2totalvalue').val();
			var leave3total = $('#txtselectedcellleave3totalvalue').val();
			var leave4total = $('#txtselectedcellleave4totalvalue').val();
			var leave5total = $('#txtselectedcellleave5totalvalue').val();
			var leave6total = $('#txtselectedcellleave6totalvalue').val();
			var overtimevalue = $('#txtselectedcellovertimevalue').val();
			var holidayovertimevalue = $('#txtselectedcellholidayovertimevalue').val();
			var holidaysofmonth = $('#txtholidaysofmonth').val();
			var monthlypayrollprocessed = $('#txtmonthlypayrollprocessed').val();
			var category = $('#cmbempcategory').val();
			var department = $('#cmbempdepartment').val();
			var markall = $('#hidchckmarkall').val();
			var emptotalleavesarray="";
			var emptotalleavesgridlength="0";
			
			var funtype="2";
			
			if(document.getElementById("rdtotalleaves").checked==true){
				funtype="3";
			}
			
			if(document.getElementById("rdtotalleaves").checked==true){
				 document.getElementById("errormsg").innerText="Invalid Click.";
				 return 0;
			}
			
			if(cellcolumn==''){
				 document.getElementById("errormsg").innerText="Choose a Cell.";
				 return 0;
			 }
			
			if(year==''){
	    		 document.getElementById("errormsg").innerText="Year is Mandatory.";
				 return 0;
			 }
	    	
	    	if(month==''){
	    		 document.getElementById("errormsg").innerText="Month is Mandatory.";
				 return 0;
			 }
	    	
	    	if(monthlypayrollprocessed=='1'){
	    		 $.messager.alert('Message','Payroll Processed,Attendance cannot be Changed.','warning');
				 return 0;
			}
				
	    	document.getElementById("errormsg").innerText="";
	    	
	    	var x = document.getElementById("cmbday").length;
	    	var totdays=(x-1);
	    	
			    $.messager.confirm('Message', 'Do you want to apply changes?', function(r){
				        
			     	if(r==false)
			     	  {
			     		return false; 
			     	  }
			     	else{
			     		 $("#overlay, #PleaseWait").show();
			     		 saveAttendanceData(year,month,employee,cellcolumn,cellvalue,totdays,leave1total,leave2total,leave3total,leave4total,leave5total,leave6total,emptotalleavesarray,emptotalleavesgridlength,overtimevalue,holidayovertimevalue,category,department,markall,funtype);	
			     	}
			 });
		}	

		function funReCheckAttendance(event){
		    var year = $('#cmbyear').val();
		    var month = $('#cmbmonth').val();
			var monthlypayrollprocessed = $('#txtmonthlypayrollprocessed').val();
			
			if(year==''){
	    		 document.getElementById("errormsg").innerText="Year is Mandatory.";
				 return 0;
			}
	    	
	    	if(month==''){
	    		 document.getElementById("errormsg").innerText="Month is Mandatory.";
				 return 0;
			}
			
			var rows = $('#attendanceGridID').jqxGrid('getrows');
	    	if(rows.length==1 && (rows[0].employeedocno=="undefined" || rows[0].employeedocno==null || rows[0].employeedocno=="")){
				$.messager.alert('Message','View Attendance and Re-Check. ','warning');
				return 0;
			} 
	    	
	    	if(monthlypayrollprocessed=='1'){
	    		 $.messager.alert('Message','Payroll Processed,Attendance cannot be Changed.','warning');
				 return 0;
			}
			 	
	    	document.getElementById("errormsg").innerText="";
	    	
			    $.messager.confirm('Message', 'Do you want to Re-Check Attendance?', function(r){
				        
			     	if(r==false)
			     	  {
			     		return false; 
			     	  }
			     	else{
			     		
			     		    $("#overlay, #PleaseWait").show();
			     		    getLeavesGridTotal("2");
			     		 
			     	}
			 });
		}
		
		function saveAttendanceData(year,month,employee,cellcolumn,cellvalue,totdays,leave1total,leave2total,leave3total,leave4total,leave5total,leave6total,emptotalleavesarray,emptotalleavesgridlength,overtimevalue,holidayovertimevalue,category,department,markall,funtype){
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
					var items=x.responseText;

					var employee = $('#txtselectedemployee').val(' ');
					var cellcolumn = $('#txtselectedcellcolumn').val(' ');
					var cellvalue = $('#txtselectedcellvalue').val(' ');
					
					document.getElementById("cmbday").value="";
					document.getElementById("cmbempdepartment").value="";
					document.getElementById("cmbempcategory").value="";
					document.getElementById("txtemployeeid").value="";
					document.getElementById("txtemployeedocno").value="";
					document.getElementById("txtemployeename").value="";
					document.getElementById("cmbholiday").value="";
					document.getElementById("cmbleavetype").value="";
					
					document.getElementById("rdholiday").checked=true;
					document.getElementById("chckhalfday").checked=false;
					document.getElementById("hidchckhalfday").value = 0;
					
					document.getElementById("chckmarkall").checked=false;
				    document.getElementById("hidchckmarkall").value = 0; 
					
					document.getElementById("txtselectedcellrow").value="";
					document.getElementById("txtselectedcelltextvalue").value="";
					
					document.getElementById("txtselectedcellleave1totalvalue").value="";
					document.getElementById("txtselectedcellleave2totalvalue").value="";
					document.getElementById("txtselectedcellleave3totalvalue").value="";
					document.getElementById("txtselectedcellleave4totalvalue").value="";
					document.getElementById("txtselectedcellleave5totalvalue").value="";
					document.getElementById("txtselectedcellleave6totalvalue").value="";
					document.getElementById("txtemptotalleaves").value="";
					document.getElementById("txtemptotalleavesgridlength").value="";
					document.getElementById("txtselectedcellovertimevalue").value="";
					document.getElementById("txtselectedcellholidayovertimevalue").value="";
					document.getElementById("txtmonthlypayrollprocessed").value="";
					document.getElementById("txtmarkedattendance").value="0";
					
					document.getElementById("txtrecheckemptotalleaves").value="";
					document.getElementById("txtrecheckemptotalleavesgridlength").value="";
					
					var settime=new Date();
					settime.setHours(0,0,0,0);
					$('#overtime').jqxDateTimeInput('setDate',settime);
					
					$("#attendanceGridID").jqxGrid('clear');
					$("#attendanceGridID").jqxGrid('addrow', null, {});
					$("#attendanceGridID").jqxGrid({ disabled: true});
					
					 if (document.getElementById("txtemployeeid").value == "") {
					        $('#txtemployeeid').attr('placeholder', 'Press F3 to Search'); 
					        $('#txtemployeename').attr('placeholder', 'Employee Name');
					    }
					 
					 document.getElementById("btnView").value ="View";
					 $('#btnApply').attr('disabled', true);
				     $('#btnApplyDelete').attr('disabled', true);
				     
				     document.getElementById("savemsg").innerText="";
				     document.getElementById("errormsg").innerText="";
				     
					$.messager.alert('Message', '  Record Successfully Updated ', function(r){
				  });
					funViewAttendance();
					radioClick();
			  }
			}
																	
		x.open("GET","saveData.jsp?year="+year+"&month="+month+"&employee="+employee+"&cellcolumn="+cellcolumn+"&cellvalue="+cellvalue+"&totdays="+totdays+"&leave1total="+leave1total+"&leave2total="+leave2total+"&leave3total="+leave3total+"&leave4total="+leave4total+"&leave5total="+leave5total+"&leave6total="+leave6total+"&emptotalleavesarray="+emptotalleavesarray+"&emptotalleavesgridlength="+emptotalleavesgridlength+"&overtimevalue="+overtimevalue+"&holidayovertimevalue="+holidayovertimevalue+"&category="+category+"&department="+department+"&markall="+markall+"&funtype="+funtype,true);
		x.send();
		}
		
		function updateAttendanceData(year,month,emptotalleavesarray,emptotalleavesgridlength){
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
					var items=x.responseText;

					var employee = $('#txtselectedemployee').val(' ');
					var cellcolumn = $('#txtselectedcellcolumn').val(' ');
					var cellvalue = $('#txtselectedcellvalue').val(' ');
					
					document.getElementById("cmbday").value="";
					document.getElementById("cmbempdepartment").value="";
					document.getElementById("cmbempcategory").value="";
					document.getElementById("txtemployeeid").value="";
					document.getElementById("txtemployeedocno").value="";
					document.getElementById("txtemployeename").value="";
					document.getElementById("cmbholiday").value="";
					document.getElementById("cmbleavetype").value="";
					
					document.getElementById("rdholiday").checked=true;
					document.getElementById("chckhalfday").checked=false;
					document.getElementById("hidchckhalfday").value = 0;
					
					document.getElementById("chckmarkall").checked=false;
				    document.getElementById("hidchckmarkall").value = 0; 
					
					document.getElementById("txtselectedcellrow").value="";
					document.getElementById("txtselectedcelltextvalue").value="";
					
					document.getElementById("txtselectedcellleave1totalvalue").value="";
					document.getElementById("txtselectedcellleave2totalvalue").value="";
					document.getElementById("txtselectedcellleave3totalvalue").value="";
					document.getElementById("txtselectedcellleave4totalvalue").value="";
					document.getElementById("txtselectedcellleave5totalvalue").value="";
					document.getElementById("txtselectedcellleave6totalvalue").value="";
					document.getElementById("txtemptotalleaves").value="";
					document.getElementById("txtemptotalleavesgridlength").value="";
					document.getElementById("txtselectedcellovertimevalue").value="";
					document.getElementById("txtselectedcellholidayovertimevalue").value="";
					document.getElementById("txtmonthlypayrollprocessed").value="";
					document.getElementById("txtmarkedattendance").value="0";
					
					document.getElementById("txtrecheckemptotalleaves").value="";
					document.getElementById("txtrecheckemptotalleavesgridlength").value="";
					
					var settime=new Date();
					settime.setHours(0,0,0,0);
					$('#overtime').jqxDateTimeInput('setDate',settime);
					
					$("#attendanceGridID").jqxGrid('clear');
					$("#attendanceGridID").jqxGrid('addrow', null, {});
					$("#attendanceGridID").jqxGrid({ disabled: true});
					
					 if (document.getElementById("txtemployeeid").value == "") {
					        $('#txtemployeeid').attr('placeholder', 'Press F3 to Search'); 
					        $('#txtemployeename').attr('placeholder', 'Employee Name');
					    }
					 
					 document.getElementById("btnView").value ="View";
					 $('#btnApply').attr('disabled', true);
				     $('#btnApplyDelete').attr('disabled', true);
				     
				     document.getElementById("savemsg").innerText="";
				     document.getElementById("errormsg").innerText="";
				     
					$.messager.alert('Message', '  Record Successfully Re-Checked ', function(r){
				  });
					funViewAttendance();
					radioClick();
			  }
			}
																	
		x.open("GET","updateData.jsp?year="+year+"&month="+month+"&emptotalleavesarray="+emptotalleavesarray+"&emptotalleavesgridlength="+emptotalleavesgridlength,true);
		x.send();
		}
	 
</script>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
    <form id="frmEmployeeAttendance" action="saveEmployeeAttendance" method="post" autocomplete="off">
        <jsp:include page="../../../../header.jsp"></jsp:include>
        
        <div class="modern-ui hidden-scrollbar">
            <div id="errormsg"></div>
            
            <div style="display: flex; gap: 15px; align-items: flex-start;">
                
                <!-- LEFT PANEL : Controls -->
                <div class="middle-panel" style="width: 320px; flex-shrink: 0; margin-bottom: 0;">
                    <span class="middle-panel-title">Attendance Controls</span>
                    
                    <div class="field-row">
                        <label class="lbl-right" style="width:75px;">Year</label>
                        <select id="cmbyear" name="cmbyear" style="flex:1;" onchange="funClearYearInfo();getDay();" value='<s:property value="cmbyear"/>'>
                            <option value="">--Select--</option>
                        </select>
                        <input type="hidden" id="hidcmbyear" name="hidcmbyear" value='<s:property value="hidcmbyear"/>'/>
                    </div>
                    
                    <div class="field-row">
                        <label class="lbl-right" style="width:75px;">Month</label>
                        <select id="cmbmonth" name="cmbmonth" style="flex:1;" onchange="funClearMonthInfo();getDay();getHolidaysOfMonth($('#cmbyear').val(),this.value);" value='<s:property value="cmbmonth"/>'>
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
                        <input type="hidden" id="hidcmbmonth" name="hidcmbmonth" value='<s:property value="hidcmbmonth"/>'/>
                    </div>
                    
                    <div class="field-row">
                        <label class="lbl-right" style="width:75px;">Day</label>
                        <select id="cmbday" name="cmbday" style="flex:1;" value='<s:property value="cmbday"/>'>
                            <option value="">--Select--</option>
                        </select>
                        <input type="hidden" id="hidcmbday" name="hidcmbday" value='<s:property value="hidcmbday"/>'/>
                    </div>
                    
                    <div class="field-row">
                        <label class="lbl-right" style="width:75px;">Department</label>
                        <select id="cmbempdepartment" name="cmbempdepartment" style="flex:1;" value='<s:property value="cmbempdepartment"/>'>
                            <option value="">--Select--</option>
                        </select>
                        <input type="hidden" id="hidcmbempdepartment" name="hidcmbempdepartment" value='<s:property value="hidcmbempdepartment"/>'/>
                    </div>
                    
                    <div class="field-row">
                        <label class="lbl-right" style="width:75px;">Category</label>
                        <select id="cmbempcategory" name="cmbempcategory" style="flex:1;" value='<s:property value="cmbempcategory"/>'>
                            <option value="">--Select--</option>
                        </select>
                        <input type="hidden" id="hidcmbempcategory" name="hidcmbempcategory" value='<s:property value="hidcmbempcategory"/>'/>
                    </div>
                    
                    <div class="field-row">
                        <label class="lbl-right" style="width:75px;">Employee</label>
                        <div class="input-search-container" style="flex:1;">
                            <input type="text" id="txtemployeeid" name="txtemployeeid" placeholder="Press F3" value='<s:property value="txtemployeeid"/>' onkeydown="getEmployeeId(event);"/>
                            <svg class="magnifier-icon" onclick="$('#txtemployeeid').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                        </div>
                        <input type="hidden" id="txtemployeedocno" name="txtemployeedocno" value='<s:property value="txtemployeedocno"/>'/>
                    </div>
                    
                    <div class="field-row">
                        <label class="lbl-right" style="width:75px;"></label>
                        <input type="text" id="txtemployeename" name="txtemployeename" placeholder="Employee Name" style="flex:1;" tabindex="-1" value='<s:property value="txtemployeename"/>'/>
                    </div>
                    
                    <!-- Inner Control Panel for Mode Selection -->
                    <div class="middle-panel" style="margin-top: 20px; padding: 15px 10px 5px 10px;">
                        <span class="middle-panel-title" style="font-size: 12px; color: #475569; border-left-color: #475569;">Mode Selection</span>
                        
                        <div class="field-row">
                            <input type="radio" id="rdholiday" name="rdo" value="rdholiday" onclick="radioClick();">
                            <label for="rdholiday" style="font-size:12px; margin-right:5px; width:75px;">Holiday</label>
                            <select id="cmbholiday" name="cmbholiday" style="flex:1;" onchange="newValueSet();getNewGridValue(this.value);" value='<s:property value="cmbholiday"/>'>
                                <option value="">--Select--</option>
                            </select>
                            <input type="hidden" id="hidcmbholiday" name="hidcmbholiday" value='<s:property value="hidcmbholiday"/>'/>
                        </div>
                        
                        <div class="field-row">
                            <input type="radio" id="rdleavetype" name="rdo" value="rdleavetype" onclick="radioClick();">
                            <label for="rdleavetype" style="font-size:12px; margin-right:5px; width:75px;">Leave Type</label>
                            <select id="cmbleavetype" name="cmbleavetype" style="flex:1;" onchange="clearhalfdaycheck();newValueSet();getNewGridValue(this.value);" value='<s:property value="cmbleavetype"/>'>
                                <option value="">--Select--</option>
                            </select>
                            <input type="hidden" id="hidcmbleavetype" name="hidcmbleavetype" value='<s:property value="hidcmbleavetype"/>'/>
                        </div>
                        <div class="field-row" style="padding-left: 105px;">
                            <input type="checkbox" id="chckhalfday" name="chckhalfday" value="" onchange="halfdaycheck();newValueSet();" onclick="$(this).attr('value', this.checked ? 1 : 0)"> 
                            <label style="font-size:12px;">Half Day</label>
                            <input type="hidden" id="hidchckhalfday" name="hidchckhalfday" value='<s:property value="hidchckhalfday"/>'/>
                        </div>
                        
                        <div class="field-row">
                            <input type="radio" id="rdovertime" name="rdo" value="rdovertime" onclick="radioClick();">
                            <label for="rdovertime" style="font-size:12px; margin-right:5px; width:75px;">Over Time</label>
                            <div style="flex:1;">
                                <div id="overtime" name="overtime" onchange="newValueSet();" value='<s:property value="overtime"/>'></div>
                            </div>
                            <input type="hidden" id="hidovertime" name="hidovertime" value='<s:property value="hidovertime"/>'/>
                        </div>
                        
                        <div class="field-row" id="rdtotalleaves_container">
                            <input type="radio" id="rdtotalleaves" name="rdo" value="rdtotalleaves" onclick="radioClick();">
                            <label id="rdtotalleaves1" for="rdtotalleaves" style="font-size:12px; font-weight:bold; margin-left:5px;"></label>
                        </div>
                    </div>
                    
                    <div class="field-row" style="justify-content: space-between; margin-top: 15px;">
                        <label style="font-size: 12px; display: flex; align-items: center; gap: 4px;">
                            <input type="checkbox" id="chckmarkall" name="chckmarkall" value="" onchange="markallcheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)"> Mark All
                        </label>
                        <input type="button" class="myButton" name="btnView" id="btnView" value="View" onclick="funViewAttendance();">
                        <input type="hidden" id="hidchckmarkall" name="hidchckmarkall" value='<s:property value="hidchckmarkall"/>'/>
                    </div>
                    
                    <div class="field-row" style="justify-content: center; gap: 6px; margin-top: 10px;">
                        <input type="button" class="myButton" name="btnApply" id="btnApply" value="Apply" onclick="funApplyAttendance(event);">
                        <input type="button" class="myButton-delete" name="btnApplyDelete" id="btnApplyDelete" value="Delete" onclick="funDeleteAttendance(event);">
                        <input type="button" class="myButton-clear" name="clear" id="clear" value="Clear" onclick="funClearInfo();">
                    </div>
                    
                    <div class="field-row" style="justify-content: center; margin-top: 10px;">
                        <input type="button" class="myButton-success" name="btnRecheck" id="btnRecheck" value="Re-Check" onclick="funReCheckAttendance(event);">
                    </div>
                    
                </div>
                
                <!-- RIGHT PANEL : Grid -->
                <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
                    <span class="middle-panel-title">Attendance Records</span>
                    <div id="attendanceDiv" class="grid-container" style="border: none; height: 100%;">
                        <jsp:include page="attendanceGrid.jsp"></jsp:include>
                    </div>
                </div>
                
            </div>

            <!-- Hidden Logic Fields -->
            <div style="display:none;">
                <input type="hidden" id="mode" name="mode"/>
                <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
                <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
                <input type="hidden" id="docno" name="txtattendancedocno" style="width:75%;" value='<s:property value="txtattendancedocno"/>'/>
                <input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
                <input type="hidden" id="txtselectedemployee" name="txtselectedemployee" value='<s:property value="txtselectedemployee"/>'/>
                <input type="hidden" id="txtselectedcellrow" name="txtselectedcellrow" value='<s:property value="txtselectedcellrow"/>'/>
                <input type="hidden" id="txtselectedcellcolumn" name="txtselectedcellcolumn" value='<s:property value="txtselectedcellcolumn"/>'/>
                <input type="hidden" id="txtselectedcellvalue" name="txtselectedcellvalue" value='<s:property value="txtselectedcellvalue"/>'/>
                <input type="hidden" id="txtselectedcelltextvalue" name="txtselectedcelltextvalue" value='<s:property value="txtselectedcelltextvalue"/>'/>
                <input type="hidden" id="txtselectedcellleave1totalvalue" name="txtselectedcellleave1totalvalue" value='<s:property value="txtselectedcellleave1totalvalue"/>'/>
                <input type="hidden" id="txtselectedcellleave2totalvalue" name="txtselectedcellleave2totalvalue" value='<s:property value="txtselectedcellleave2totalvalue"/>'/>
                <input type="hidden" id="txtselectedcellleave3totalvalue" name="txtselectedcellleave3totalvalue" value='<s:property value="txtselectedcellleave3totalvalue"/>'/>
                <input type="hidden" id="txtselectedcellleave4totalvalue" name="txtselectedcellleave4totalvalue" value='<s:property value="txtselectedcellleave4totalvalue"/>'/>
                <input type="hidden" id="txtselectedcellleave5totalvalue" name="txtselectedcellleave5totalvalue" value='<s:property value="txtselectedcellleave5totalvalue"/>'/>
                <input type="hidden" id="txtselectedcellleave6totalvalue" name="txtselectedcellleave6totalvalue" value='<s:property value="txtselectedcellleave6totalvalue"/>'/>
                <input type="hidden" id="txtemptotalleaves" name="txtemptotalleaves" value='<s:property value="txtemptotalleaves"/>'/>
                <input type="hidden" id="txtemptotalleavesgridlength" name="txtemptotalleavesgridlength" value='<s:property value="txtemptotalleavesgridlength"/>'/>
                <input type="hidden" id="txtselectedcellovertimevalue" name="txtselectedcellovertimevalue" value='<s:property value="txtselectedcellovertimevalue"/>'/>
                <input type="hidden" id="txtselectedcellholidayovertimevalue" name="txtselectedcellholidayovertimevalue" value='<s:property value="txtselectedcellholidayovertimevalue"/>'/>
                <input type="hidden" id="txtholidaysofmonth" name="txtholidaysofmonth" value='<s:property value="txtholidaysofmonth"/>'/>
                <input type="hidden" id="txtmonthlypayrollprocessed" name="txtmonthlypayrollprocessed" value='<s:property value="txtmonthlypayrollprocessed"/>'/>
                <input type="hidden" id="txtattendanceleaveseditgrid" name="txtattendanceleaveseditgrid" value='<s:property value="txtattendanceleaveseditgrid"/>'/>
                <input type="hidden" id="txtmarkedattendance" name="txtmarkedattendance" value='<s:property value="txtmarkedattendance"/>'/>
                <input type="hidden" id="txtrecheckemptotalleaves" name="txtrecheckemptotalleaves" value='<s:property value="txtrecheckemptotalleaves"/>'/>
                <input type="hidden" id="txtrecheckemptotalleavesgridlength" name="txtrecheckemptotalleavesgridlength" value='<s:property value="txtrecheckemptotalleavesgridlength"/>'/>
            </div>
        </div>
    </form>

    <!-- Search Windows Outside of Form Content -->
    <div id="employeeDetailsWindow">
        <div></div><div></div>
    </div>
</div>
</body>
</html>