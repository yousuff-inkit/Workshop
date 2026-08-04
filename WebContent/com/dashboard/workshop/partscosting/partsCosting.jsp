
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
 String contextPath=request.getContextPath();
 %>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<style>/* ===== MASTER LAYOUT ===== */
html, body, #mainBG, .hidden-scrollbar {
    height: 100%;
    margin: 0;
    overflow: hidden;
    background-color: #f4f7f9;
}

.master-container {
    display: flex;
    width: 100%;
    height: 100vh;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

/* ===== LEFT SIDEBAR ===== */
.sidebar-filters {
    width: 320px; 
    flex: 0 0 320px; 
    background: #fff;
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
    padding: 15px 15px 25px; 
}

/* Cards Layout Rules */
.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

/* Internal Presentation Tables */
.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.filter-table .label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 600;
    width: 90px;
}

/* ===== UNIFORM 24px INPUTS & SELECTS ===== */
input[type="text"], select,
.filter-table input[type="text"],
.filter-table select {
    width: 100%;
    height: 24px !important;             
    padding: 2px 8px !important;         
    border: 1px solid #ccd6e0 !important;
    border-radius: 4px !important;       
    font-size: 12px !important;          
    background-color: #ffffff;
    box-sizing: border-box;
    color: #333;
    outline: none;
}

/* Readonly fields override */
input[readonly],
input:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed !important;
    cursor: text;
}

/* jqx Date Container Mapping Rules */
.filter-table div[id^="fromdate"],
.filter-table div[id^="todate"] {
    width: 100%;
}

/* ===== MASTER 30px BUTTON SYSTEM ===== */
.btn-submit {
    width: 100%;
    height: 30px !important;            
    padding: 0 12px !important;
    background: #2563eb !important;
    color: #fff !important;
    border: none !important;
    border-radius: 4px !important;
    font-size: 13px !important;
    font-weight: 600 !important;
    cursor: pointer;
    line-height: 30px !important;
    white-space: nowrap;
    text-align: center;
    transition: all 0.2s ease;
    box-shadow: none !important;
    display: inline-block;
    box-sizing: border-box;
    margin-bottom: 8px;
}

.btn-submit:hover {
    background: #1d4ed8 !important;
}

/* Button Group Styling */
.button-group-row {
    display: flex;
    gap: 8px;
    margin-bottom: 8px;
}

.button-group-row .btn-submit {
    flex: 1;
    margin-bottom: 0;
}

/* ===== RIGHT CONTENT AREA (Horizontally Aligned Heading) ===== */
.main-content-wrapper {
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

.scrollable-grid-area {
    flex: 1;
    padding: 15px 20px;
    overflow: auto; 
    box-sizing: border-box;
}</style>

<script type="text/javascript">

$(document).ready(function () {
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    
    $("#fromdate").jqxDateTimeInput({ width: '112px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '112px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	 var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	 var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	 $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	 
	 $('#clientwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search'  , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#clientwindow').jqxWindow('close');
	   
	   $('#estmwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Estimation Search'  , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#estmwindow').jqxWindow('close');
	   
	   $('#vendorwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Vendor Search'  , theme: 'energyblue', position: { x: 500, y: 120 }, keyboardCloseKey: 27});
	   $('#vendorwindow').jqxWindow('close');
	   
	   $('#productswindow').jqxWindow({ width: '51%', height: '54%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Product Search'  , theme: 'energyblue', position: { x: 500, y: 120 }, keyboardCloseKey: 27});
	   $('#productswindow').jqxWindow('close');
	   
	   
	   
	   $('#clientname').dblclick(function(){
	  	    
		   $('#clientwindow').jqxWindow('open');
		       		clientSearchContent('clientsearch.jsp', $('#clientwindow')); 
	       });
	 
	 $('#estimation').dblclick(function(){
	  	    
		   $('#estmwindow').jqxWindow('open');
		       		estmSearchContent('estsearch.jsp', $('#estwindow')); 
	       });
});


function getclinfo(event){
	 var x= event.keyCode;
	if(x==114){
 		$('#clientwindow').jqxWindow('open');
		clientSearchContent('clientsearch.jsp', $('#clientwindow'));    }
	else{}
}

function clientSearchContent(url) {
 	$.get(url).done(function (data) {
	$('#clientwindow').jqxWindow('open');
	$('#clientwindow').jqxWindow('setContent', data);
}); 
} 

function getestinfo(event){
	var x=event.keyCode;
	if(x==114){
		$('#estmwindow').jqxWindow('open');
		estmSearchContent('estsearch.jsp', $('#estmwindow'))
	}
}
function estmSearchContent(url){
		$.get(url).done(function(data){
			$('#estmwindow').jqxWindow('open');
		    $('#estmwindow').jqxWindow('setContent',data);
	    });	
}

function funreload(event)
{
	var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
    var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	if(fromdates>todates){
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		   return false;
	} 
	else{
	        var fromdate= $("#fromdate").val();
			var todate= $("#todate").val(); 
			var cldocno=$("#cldocno").val();
			var estno=$('#estno').val();
			$('#overlay,#PleaseWait').show();
			$("#partscostinggriddiv").load("partsCostingGrid.jsp?from="+fromdate+"&to="+todate+"&cldocno="+cldocno+"&estno="+estno+'&check=1');

       }
    $("#partsGridId").jqxGrid('clear');
}

function funpartsload(num){
	$("#partsgriddiv").load("partsGrid.jsp?estno="+num+'&check=1');
}

function funproductsearch(row){
	$('#productswindow').jqxWindow('open');
	productSearchContent('productsearch.jsp?index='+row, $('#productswindow'));
}

function productSearchContent(url) {
 	$.get(url).done(function (data) {
	$('#productswindow').jqxWindow('open');
	$('#productswindow').jqxWindow('setContent', data);
});
}

function funvendorsearch(row){
		$('#vendorwindow').jqxWindow('open');
		vendorSearchContent('vendorSearch.jsp?index='+row, $('#vendorwindow'));
	}

function vendorSearchContent(url) {
	 	$.get(url).done(function (data) {
		$('#vendorwindow').jqxWindow('open');
		$('#vendorwindow').jqxWindow('setContent', data);
	});
}

function attach(){
  var fcode="EST";
  var fname="Estimation";
  if(document.getElementById("hidestm").value=="") {
	  $.messager.alert('Message','Choose a document','warning');
  }
  else{
  var  myWindow= window.open("<%=contextPath%>/com/common/Attachmaster.jsp?formCode="+fcode+"&docno="+document.getElementById("hidestm").value+"&brchid=1&frmname="+fname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
      myWindow.focus();
  }
 }

function funcleardata()
  {
	  
  	document.getElementById("clientname").value="";
    	document.getElementById("estimation").value="";
   	
  	
  	 if (document.getElementById("clientname").value == "") {
  			
  		 
  	        $('#clientname').attr('placeholder', 'Press F3 TO Search'); 
  	    }
  	if (document.getElementById("estimation").value == "") {
			
  		 
	        $('#estimation').attr('placeholder', 'Press F3 TO Search'); 
	    }
  	else{}
  		  		
  	}
  	
  	function funUpdate(){
  		var rows = $('#partsGridId').jqxGrid('getrows');
  	    var result = "";
  	    if(rows.length==0){
  	    	$.messager.alert('Message','Choose a document','warning');
  	    }
  	    else{
		  $.messager.confirm('Confirm', 'Do you want to Save Changes?', function(r){
		     if (r){ 
			  	   var gridarray=new Array();
			  	    for(var i = 0; i < rows.length; i++)
			  	    {
			  	        var row = rows[i];
			  	        gridarray[i]=(rows[i].rowno+" :: "+rows[i].psrno+" :: "+rows[i].stdcost+" :: "+rows[i].vndno);
			  	      //  result += row.firstname + " " + row.lastname + " " + row.productname + " " + row.date + " " + row.quantity + " " + row.price + "\n";        
			  	    }
			  	    funSave(gridarray);
			  	    
		  	}
		  });
  	    }
  	}
  	
  	function funSave(gridarray){
  	var estno=document.getElementById("hidestm").value; 
  	  var x=new XMLHttpRequest();
  	  x.onreadystatechange=function(){
  	  if (x.readyState==4 && x.status==200){
  	         
  	    var items=x.responseText.trim();
   	    
  	    if(parseInt(items)=="0")  
  	    { 
  	    
  	    $.messager.alert('Message', '  Record Successfully Updated ','info');
  	    funreload();
  	    }
  	    else
  	    {
  	    $.messager.alert('Message', '  Not Updated  ','warning');
  	    }
  	    }
  	  }
  	    x.open("GET","partsUpdate.jsp?gridarray="+gridarray+"&estno="+estno,true);    
  	 x.send();
  	}
  	
  	
  	function funCreate(){
  		var selectedrows=$("#partsGridId").jqxGrid('selectedrowindexes');
  	  		
  	  		
  	  		var estno=document.getElementById("hidestm").value;
  	  		var date=document.getElementById("fromdate").value;
  	  		var jobno=$("#partsGridId").jqxGrid('getcellvalue', selectedrows[0], "voc_no");
  	  		var vndno=$("#partsGridId").jqxGrid('getcellvalue', 0, "vndno");
  	  		var vendorprice=0;
  	  		var i=0;
  	  		
  	  		
  	 
  	  		var rows = $("#partsGridId").jqxGrid('getrows');
  	  		var purchaseorderarray=new Array();
  	  		 var rownorarray=new Array();
  	  		
  			if(rows.length>0 && (rows[0].rowno=="undefined" || rows[0].rowno==null || rows[0].rowno=="")){
  				return false;
  			}
  				       
  		    
  			if(selectedrows.length==0){
  				$.messager.alert('Warning','Select a document');
  				return false;
  			}
  			   $.messager.confirm('Confirm', 'Do you want to Save Changes?', function(r){
  		 			if (r){
  		 				
  		 				var i=0;
  		            //    $('#partsGridId').val(selectedrows.length);
  		  	
  		              var listss = new Array();
  		            var selectedrows=$("#partsGridId").jqxGrid('selectedrowindexes');
  		            selectedrows = selectedrows.sort(function(a,b){return a - b});
  		            
  		         		var nettotal=0;
  		               for(var i=0 ; i < selectedrows.length ; i++){
  		            	 var total= parseFloat($("#partsGridId").jqxGrid('getcellvalue',selectedrows[i],'qty')) *
  		  		        parseFloat($("#partsGridId").jqxGrid('getcellvalue',selectedrows[i],'stdcost'));
  		            	 var taxamt=total*0.05;
  		            	 var nettaxamt=total+taxamt;
  		  		    purchaseorderarray.push($("#partsGridId").jqxGrid('getcellvalue',selectedrows[i],'psrno')+"::"
  		  		    	+$("#partsGridId").jqxGrid('getcellvalue',selectedrows[i],'prdid')+"::"
  		                 +$("#partsGridId").jqxGrid('getcellvalue',selectedrows[i],'munit')+"::"
  		                 +$("#partsGridId").jqxGrid('getcellvalue',selectedrows[i],'qty')+"::"
  		                 +$("#partsGridId").jqxGrid('getcellvalue',selectedrows[i],'stdcost')+"::"
  		                 +total+"::"+0+"::"+total+"::"+0+"::"+0+"::"
  		                 +$("#partsGridId").jqxGrid('getcellvalue',selectedrows[i],'mspecno')+"::"+0+"::"+0+"::"+0+"::"+5+"::"+taxamt+"::"+nettaxamt+"::"+1+"::");
  		           
  		  		    rownorarray.push($("#partsGridId").jqxGrid('getcellvalue',selectedrows[i],'rowno'));
  		           nettotal+=total;
  		         /*      purchaseorderarray.push($("#partsGridId").jqxGrid('getcellvalue',selectedrows[i],'psrno')+"::"+prodoc+"::"
  		            		  +unitdocno+"::"+purorderqty+"::"+unitprice+"::"
								+total+"::"+discount+"::"+nettotal+"::"+saveqty+"::"+checktype+"::"
								+specid+"::"+discper+"::"+unitprice1+"::"+disper1+"::"+taxper+"::"
								+taxperamt+"::"+taxamount+"::"+taxdocno+"::");
					 */
  		               }
  		             funPurchaseSave(estno,date,jobno,vndno,nettotal,purchaseorderarray,rownorarray,nettotal);
  		 			}});
  	  		
  	  		
  	}
  	
  	
  	function funPurchaseSave(estno,date,jobno,vndno,vendorprice,purchaseorderarray,rownorarray,nettotal){
  		var x=new XMLHttpRequest();
    	  x.onreadystatechange=function(){
    	  if (x.readyState==4 && x.status==200){
    	         
    	    var items=x.responseText.trim();
     	    
    	    if(parseInt(items)>"0")  
    	    { 
    	    
    	    $.messager.alert('Message', '  Order no '+parseInt(items)+' Successfully Created ','info');
    	    
    	    }
    	    else
    	    {
    	    $.messager.alert('Message', '  Not Created  ','warning');
    	    }
    	    }
    	  }
    	  
    	    x.open("GET","purchaseOrderCreate.jsp?date="+date+"&jobno="+jobno+"&vndno="+vndno+"&vendorprice="+vendorprice+"&purchaseorderarray="+purchaseorderarray+"&rownorarray="+rownorarray+"&nettotal="+nettotal,true);    
    	 x.send();
  	}
  	
  	function funcPrint(){
  		
  		var jobno = document.getElementById("hidjobno").value;

  		 if(jobno=="")
  			 {
  			   $.messager.alert('Message','Select a document  ','warning'); 
  			   return false;
  			 }
  		 else
  			 {
  	    var url=document.URL;
  	    var reurl=url.split("partsCosting.jsp");
  	    //alert(reurl[0]+"printPartsCosting?jobno="+document.getElementById("hidjobno").value);
  	  
  	    var win= window.open(reurl[0]+"printPartsCosting?jobno="+document.getElementById("hidjobno").value,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
  	    win.focus();
  		}
  	}
	function funExportBtn(){
		JSONToCSVConvertor(pcexceldata, 'PARTS COSTING', true);
	}
	
	function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {
		
	    var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
	    
	   // alert("arrData");
	    var CSV = '';    
	    //Set Report title in first row or line
	    
	    CSV += ReportTitle + '\r\n\n';

	    //This condition will generate the Label/Header
	    if (ShowLabel) {
	        var row = "";
	        
	        //This loop will extract the label from 1st index of on array
	        for (var index in arrData[0]) {
	            
	            //Now convert each value to string and comma-seprated
	            row += index + ',';
	        }

	        row = row.slice(0, -1);
	        
	        //append Label row with line break
	        CSV += row + '\r\n';
	    }
	    
	    //1st loop is to extract each row
	    for (var i = 0; i < arrData.length; i++) {
	        var row = "";
	        
	        //2nd loop will extract each column and convert it in string comma-seprated
	        for (var index in arrData[i]) {
	            row += '"' + arrData[i][index] + '",';
	        }

	        row.slice(0, row.length - 1);
	        
	        //add a line break after each row
	        CSV += row + '\r\n';
	    }

	    if (CSV == '') {        
	        alert("Invalid data");
	        return;
	    }   
	    
	    //Generate a file name
	    var fileName = "";
	    //this will remove the blank-spaces from the title and replace it with an underscore
	    fileName += ReportTitle.replace(/ /g,"_");   
	    
	    //Initialize file format you want csv or xls
	    var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
	    
	    // Now the little tricky part.
	    // you can use either>> window.open(uri);
	    // but this will not work in some browsers
	    // or you will not get the correct file extension    
	    
	    //this trick will generate a temp <a /> tag
	    var link = document.createElement("a");    
	    link.href = uri;
	    
	    //set the visibility hidden so it will not effect on your web-layout
	    link.style = "visibility:hidden";
	    link.download = fileName + ".csv";
	    
	    //this part will append the anchor tag and remove it after automatic click
	    document.body.appendChild(link);
	    link.click();
	    document.body.removeChild(link);
	}
	 
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<div class="master-container">

    <!-- ================= LEFT PANEL (SIDEBAR) ================= -->
    <div class="sidebar-filters">
        <div class="sidebar-scroll-content">

            <!-- Primary Filters Card -->
            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">From Date</td>
                        <td><div id='fromdate' name='fromdate'></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">To Date</td>
                        <td><div id='todate' name='todate'></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Client</td>
                        <td>
                            <input type="text" name="clientname" id="clientname" placeholder="Press F3 To Search" readonly onKeyDown="getclinfo(event);" onclick="this.placeholder=''" value='<s:property value="clientname"/>'>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Estimation</td>
                        <td>
                            <input type="text" name="estimation" id="estimation" placeholder="Press F3 To Search" readonly onKeyDown="getestinfo(event);" onclick="this.placeholder=''" value='<s:property value="estimation"/>'>
                        </td>
                    </tr>
                </table>
            </div>

            <!-- Action Buttons Card -->
            <div class="filter-card">
                <button type="button" class="btn-submit" name="clear" id="clear" onclick="funcleardata()" style="background:#64748b !important;">Clear</button>
                
                <div class="button-group-row">
                    <button type="button" class="btn-submit" name="btnAttach" id="btnAttach" onclick="attach();">Attach</button>
                    <button type="button" class="btn-submit" name="btnUpdate" id="btnUpdate" onclick="funUpdate();">Update</button>
                </div>
                
                <button type="button" class="btn-submit" name="btnCreate" id="btnCreate" onclick="funCreate();">Purchase Order Create</button>
                <button type="button" class="btn-submit" name="btnPrint" id="btnPrint" onclick="funcPrint();" style="background:#10b981 !important;">Print</button>
            </div>

            <!-- Hidden Inputs Maintained Safely Outside Visual Layout -->
            <div style="display:none;">
                <input type="hidden" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>' >
                <input type="hidden" name="estno" id="estno" value='<s:property value="estno"/>' >
                <input type="hidden" name="hidestm" id="hidestm" value='<s:property value="hidestm"/>' >
                <input type="hidden" name="hidjobno" id="hidjobno" value='<s:property value="hidjobno"/>'>
            </div>

        </div>
    </div>

    <!-- ================= RIGHT PANEL (WORKSPACE GRIDS) ================= -->
    <div class="main-content-wrapper">
        
        <!-- Horizontally Aligned Heading Toolbar -->
        <div class="top-toolbar-container">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>

        <div class="scrollable-grid-area">
            
            <div id="partscostinggriddiv" style="margin-bottom: 15px;">
                <jsp:include page="partsCostingGrid.jsp"></jsp:include>
            </div>  
            
            <div id="partsgriddiv">
                <jsp:include page="partsGrid.jsp"></jsp:include>
            </div>  

        </div>

    </div>

</div>

<!-- Popups Maintained Outside the Layout Flow -->
<div id="clientwindow">
   <div></div>
</div>

<div id="estmwindow">
   <div></div>
</div>
   
<div id="productswindow">
   <div></div>
</div>

<div id="vendorwindow">
   <div></div>
</div>

</div>
</div>

</body>
</html>