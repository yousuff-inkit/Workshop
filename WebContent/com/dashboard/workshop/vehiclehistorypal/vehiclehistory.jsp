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
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/resample.js"></script> 

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
    height: 60px; /* Specific height for textareas */
    resize: vertical;
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
.release-filter-table div[id^="todate"] {
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
    gap: 20px;
}

/* Headings for the different grids */
.account-header {
    font-size: 13px;
    font-weight: 600;
    color: #1e293b;
    padding: 8px 12px;
    background: #f8fafc;
    border: 1px solid #e2e8f0;
    border-radius: 4px;
    margin-bottom: -10px; /* Pulled up slightly closer to the grid */
}
</style>

<script type="text/javascript">

	$(document).ready(function () {
		 getConfig();
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
		 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:380px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 $('#regwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Register Number Search'  , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
		 $('#regwindow').jqxWindow('close');
		 $('#productDetailsWindow').jqxWindow({width: '51%', height: '59%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Products Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#productDetailsWindow').jqxWindow('close');
			 
		 // Updated for new UI sizes
		 $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
		 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
		  
	     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
		 $('#todate').on('change', function (event) {
			   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
			   if(fromdates>todates){
				   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			       return false;
			   }   
		 });
		 
		 $('#regno').dblclick(function(){
			   $('#regwindow').jqxWindow('open');
			   regSearchContent('regnosearch.jsp', $('#regwindow')); 
		 });
		 $('#txtpartno').dblclick(function(){
			 productSearchContent('productSearch.jsp', $('#productDetailsWindow'));
		 }); 
		 
	});

	function funreload(event){
		 var branchval = document.getElementById("cmbbranch").value;
		 var psrno=$("#psrno").val();
		 var regno = document.getElementById("regno").value;
		 var pltid = document.getElementById("txtpltid").value;
		 if(regno==''){
				$.messager.alert('Warning','Please Select A Register Number');
				return false;
			}
		    var fromdate=$('#fromdate').jqxDateTimeInput('val');
		    var todate=$('#todate').jqxDateTimeInput('val');
		 
		 $("#overlay, #PleaseWait").show();
		 
		 $("#complaints").load("serviceGrid.jsp?branchval="+branchval+'&regno='+regno+'&pltid='+encodeURIComponent(pltid)+'&fromdate='+fromdate+'&todate='+todate+'&id=1');
		 $("#overlay, #PleaseWait").show();
		 $("#sparesgrid").load("sparepartGrid.jsp?branchval="+branchval+'&regno='+regno+'&pltid='+encodeURIComponent(pltid)+'&fromdate='+fromdate+'&todate='+todate+'&psrno='+psrno+'&id=1');
	}

	function getregno(event){
		 var x= event.keyCode;
		if(x==114){
	 		$('#regwindow').jqxWindow('open');
			regSearchContent('regnosearch.jsp', $('#regwindow'));    
        }
	} 
    
	function productSearchContent(url) {
	    $('#productDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#productDetailsWindow').jqxWindow('setContent', data);
		$('#productDetailsWindow').jqxWindow('bringToFront');
	}); 
	}

	function getProduct(){
		 $('#productDetailsWindow').jqxWindow('open');
		 $('#productDetailsWindow').jqxWindow('focus');
		 productSearchContent('productSearch.jsp', $('#productDetailsWindow'));
	}
    
	function funExportBtn(){
		 $("#sparesgrid").excelexportjs({
				containerid: "sparesgrid",   
				datatype: 'json',
				dataset: null,
				gridId: "sparegrid",
				columns: getColumns("sparegrid") ,   
				worksheetName:"Vehicle history Parts Reports"  
		});  
		 $("#complaints").excelexportjs({
				containerid: "complaints",   
				datatype: 'json',
				dataset: null,
				gridId: "complaint",
				columns: getColumns("complaint") ,   
				worksheetName:"Vehicle history Service Reports"  
		});  
	} 

	function regSearchContent(url) {
		$.get(url).done(function (data) {
			$('#regwindow').jqxWindow('open');
			$('#regwindow').jqxWindow('setContent', data);
	    }); 
	} 
	
	function funPrintalfahin(){
 		var branchval = document.getElementById("cmbbranch").value;
		var cmbrepairtype='';
		if($('#cmbrepairtype option:selected').text().trim()!='All'){
			cmbrepairtype=document.getElementById("cmbrepairtype").value;
		}
		
		 var regno = document.getElementById("regno").value;
		 var pltid = document.getElementById("txtpltid").value;
		 if(regno==''){
				$.messager.alert('Warning','Please Select A Register Number');
				return false;
		 }
		 var dtype='BVH';

		var fromdate=$('#fromdate').jqxDateTimeInput('val');
		var todate=$('#todate').jqxDateTimeInput('val');
        var url=document.URL;
        var reurl=url.split("vehiclehistory.jsp"); 
        var win= window.open(reurl[0]+"printvehiclehistrypal?dtype="+dtype+'&branchval='+branchval+'&regno='+regno+'&pltid='+pltid+'&fromdate='+fromdate+'&todate='+todate+'&id=1&cmbrepairtype='+cmbrepairtype,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
        win.focus();
    }
    
	function funPrintpartwise(){
 		var branchval = document.getElementById("cmbbranch").value;
		var cmbrepairtype='';
		if($('#cmbrepairtype option:selected').text().trim()!='All'){
			cmbrepairtype=document.getElementById("cmbrepairtype").value;
		}
		 var psrno=$("#psrno").val();
		 var regno = document.getElementById("regno").value;
		 var pltid = document.getElementById("txtpltid").value;
		 if(regno==''){
				$.messager.alert('Warning','Please Select A Register Number');
				return false;
			}
		 var dtype='BVH';

		var fromdate=$('#fromdate').jqxDateTimeInput('val');
		var todate=$('#todate').jqxDateTimeInput('val');
        var url=document.URL;
        var reurl=url.split("vehiclehistory.jsp"); 
        var win= window.open(reurl[0]+"printpartwisepal?dtype="+dtype+'&branchval='+branchval+'&regno='+regno+'&pltid='+pltid+'&fromdate='+fromdate+'&todate='+todate+'&id=1&psrno='+psrno+'&cmbrepairtype='+cmbrepairtype,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
        win.focus();
    }	
    
	function funPrintRepairType(evt){
		var branchval = document.getElementById("cmbbranch").value;
		var regno = document.getElementById("regno").value;
		var pltid = document.getElementById("txtpltid").value;
		if(regno==''){
			$.messager.alert('Warning','Please Select A Register Number');
			return false;
		}
		var dtype='BVH';
		var fromdate=$('#fromdate').jqxDateTimeInput('val');
		var todate=$('#todate').jqxDateTimeInput('val');
       	var url=document.URL;
       	var reurl=url.split("vehiclehistory.jsp"); 
       	var win= window.open(reurl[0]+"printVehicleHistoryRepairTypepal?dtype="+dtype+'&branchval='+branchval+'&regno='+regno+'&pltid='+pltid+'&fromdate='+fromdate+'&todate='+todate+'&id=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
       	win.focus();
	}
    
	function getConfig(){   
	    var x=new XMLHttpRequest();
		x.onreadystatechange=function(){  
			if (x.readyState==4 && x.status==200){                     
				var items=x.responseText.trim();  
				if(parseInt(items.split("::")[0])>0){                                          
					document.getElementById('txtalice').value=1;    
				}else{
					document.getElementById('txtalice').value=0;  
				}
				var rawdata=JSON.parse(items.split("::")[1]);
				var htmldata='';
				$.each(rawdata.repairdata, function( index, value ) {
					htmldata+='<option value="'+value.id+'">'+value.name+'</option>';
				});
				$('#cmbrepairtype').html($.parseHTML(htmldata));
			}      
		}
		x.open("GET","getConfig.jsp",true);             
		x.send();
	}
	
	function funClear(event){
		 var fromdates=new Date();
		 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
		  
	     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	     $('#todate').jqxDateTimeInput('setDate', new Date());
		 $('#todate').on('change', function (event) {
			   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
			   if(fromdates>todates){
				   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			       return false;
			  }   
		 });
		 
		 document.getElementById("regno").value='';
		 document.getElementById("txtpltid").value='';
		 getConfig();
		 document.getElementById("clientinfo").value='';
		 document.getElementById("txtpartno").value='';
		 document.getElementById("psrno").value='';
		 document.getElementById("txtproductname").value='';
		 $('#complaint').jqxGrid('clear');
		 $('#sparegrid').jqxGrid('clear');
	}
</script>
</head>
<body onload="getBranch();getConfig();">
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
                                <td class="label-cell">Reg No.</td>
                                <td>
                                    <input type="text" name="regno" id="regno" placeholder="Press F3 To Search" readonly="readonly" onKeyDown="getregno(event);" onclick="this.placeholder=''" value='<s:property value="regno"/>'>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">Repair Type</td>
                                <td>
                                    <select name="cmbrepairtype" id="cmbrepairtype">
                                        <option value="">--Select--</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">Client Info</td>
                                <td>
                                    <textarea id="clientinfo" name="clientinfo" readonly="readonly"><s:property value="clientinfo"/></textarea>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell">Product</td>
                                <td>
                                    <input type="text" id="txtpartno" name="txtpartno" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtpartno"/>' onKeyDown="getProduct(event);"/>
                                    <!-- Hidden field logical grouping -->
                                    <input type="hidden" id="psrno" name="psrno" value='<s:property value="psrno"/>' /> 
                                </td>
                            </tr>
                            <tr>
                                <td class="label-cell"></td>
                                <td>
                                    <input type="text" id="txtproductname" name="txtproductname" readonly="readonly" value='<s:property value="txtproductname"/>' tabindex="-1"/>
                                </td>
                            </tr>
                        </table>

                        <div class="release-actions">
                            <button type="button" class="btn-submit" id="btnPrintalfahin" name="btnPrintalfahin" onclick="funPrintalfahin(event);">Print</button>
                            <button type="button" class="btn-submit" id="btnprinttype" name="btnprinttype" onclick="funPrintRepairType(event);">Print Repair Type</button>
                            <button type="button" class="btn-submit" id="btnPrintpartwise" name="btnPrintpartwise" onclick="funPrintpartwise(event);">Part Wise</button>
                            <button type="button" class="btn-submit" id="btnclear" name="btnclear" onclick="funClear(event);">Clear</button>
                        </div>

                        <!-- Preserved Hidden Fields -->
                        <input type="hidden" id="txtalice" name="txtalice" value='<s:property value="txtalice"/>'/>
                        <input type="hidden" id="txtbranch" name="txtbranch" value='<s:property value="txtbranch"/>'/>
                        <input type="hidden" id="txtpltid" name="txtpltid" value='<s:property value="txtpltid"/>'/>
                        <input type="hidden" id="txtdocument" name="txtdocument" value='<s:property value="txtdocument"/>'/>
                    </div>
                </div>
            </div>

            <!-- Main Grid / Data Section -->
            <div class="main-content-area">
                
                <div class="top-toolbar-container">
                    <jsp:include page="../../heading.jsp"></jsp:include>
                </div>

                <div class="grid-content-container">
                    
                    <div class="account-header">Services</div>
                    <div id="complaints" style="display: flex; flex-direction: column; flex: 1; min-height: 250px;">
                        <jsp:include page="serviceGrid.jsp"></jsp:include>
                    </div>

                    <div class="account-header" style="margin-top: 5px;">Spare Parts</div>
                    <div id="sparesgrid" style="display: flex; flex-direction: column; flex: 1; min-height: 250px;">
                        <jsp:include page="sparepartGrid.jsp"></jsp:include>
                    </div>

                </div>

            </div>

        </div>

        <!-- Modals -->
        <div id="regwindow">
            <div></div>
        </div>
        <div id="productDetailsWindow">
            <div></div><div></div>
        </div>

    </div>
</body>
</html>