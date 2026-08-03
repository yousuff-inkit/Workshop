<link href="../../../../css/css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%--  <script type="text/javascript" src="../../js/dashboard.js"></script>  --%>
<style type="text/css">/* ===== MASTER LAYOUT ===== */
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
    width: 100px;
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

/* Select specific styling */
select {
    padding: 2px 24px 2px 8px !important; 
    font-family: inherit;
    cursor: pointer;
    appearance: none;
    -webkit-appearance: none;
    background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%234e5e71' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
    background-repeat: no-repeat;
    background-position: right 6px center;
    background-size: 12px;
}

/* Readonly fields override */
input[readonly],
input:disabled {
    color: #555;
    border-color: #e1e8ed !important;
}

/* jqx Date Container Mapping Rules */
.filter-table div[id^="Uptodate"] {
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
}

/* Custom Grid Wrappers */
.grid-fieldset {
    border: 1px solid #e1e8ed; 
    border-radius: 8px; 
    padding: 15px; 
    margin-bottom: 15px;
}
.grid-fieldset legend {
    font-weight: 600; 
    color: #4e5e71; 
    padding: 0 5px; 
    background: transparent;
}

/* Original Native Color Classes Maintained */
.headClass { background-color: #FFEBC2; }
.redClass { background-color: #FFEBEB; }
.violetClass { background-color: #fff; }
.yellowClass { background-color: #FFFFD1; }
.whiteClass { background-color: #FFF; }
.greenClass { background-color: #CEFFCE; }</style>

<script type="text/javascript">

$(document).ready(function () {
	$('#chkavail').attr('disabled', true);
	$('#chkavail1').attr('disabled', true);
	$('#chkavail2').attr('disabled', true);
	$('#chkavail3').attr('disabled', true);
	
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	    
	 $("#Uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 /* $("#Invdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"}); */

	 $('#bayWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Bay Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#bayWindow').jqxWindow('close');
	 
	 $('#TechnicianWindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Technician Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	 $('#TechnicianWindow').jqxWindow('close');
	 
	 $('#sparePartWindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Spare Part Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	 $('#sparePartWindow').jqxWindow('close');
	 
	 $('#jobcard').dblclick(function(){
		 jobCardSearchContent("jobCardSearch.jsp");

		});
	 $('#vendorToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Vendor Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		$('#vendorToWindow').jqxWindow('close');
	 $('#jobCardToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Job Card Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#jobCardToWindow').jqxWindow('close');
	 
	 $("#vendor").dblclick(function(){
			vendorSearchContent("vendorSearch.jsp");
		});
	 
	 
	 
});
function funExportBtn(){
	//JSONToCSVCon(floordataexcel, 'Parts Management', true);
	$("#floorMgmtGrid").excelexportjs({
		containerid: "floorMgmtGrid",
		datatype: 'json',
		dataset: null,
		gridId: "floorMgmtGrid",
		columns: getColumns("floorMgmtGrid"),
		worksheetName: "Parts Management"
	});
}

	function vendorSearchContent(url) {
	 	$('#vendorToWindow').jqxWindow('open');
		$.get(url).done(function (data) {
			$('#vendorToWindow').jqxWindow('setContent', data);
		});
	}

	
	/* function funLoadData(){
		$("#nidescdetailsGrid").jqxGrid('clear');
		funsetnigrid();
		 
		
	} */
	

	function funUpdateParts(){ 
	
   
	var rows = $("#jqxpartsgrid3").jqxGrid('getrows');
	var g=0;
	var selectedrows=$("#jqxpartsgrid3").jqxGrid('selectedrowindexes');
	selectedrows = selectedrows.sort(function(a,b){return a - b});
	if(selectedrows.length==0){
		$("#overlay, #PleaseWait").hide();
		$.messager.alert('Warning','Select documents.');
		return false;
		}
     
	 for (var k=0; k < selectedrows.length; k++) {
		var chks=$('#jqxpartsgrid3').jqxGrid('getcellvalue', selectedrows[k], "status");  
		if(chks == ''){
			g=g+1;
		
		}
	}
	if(g>=1){
		$.messager.alert('Warning','Select a Status.');	
	}
	if(!(g>=1)){
		$.messager.confirm('Message', 'Do you want to save changes?', function(r){
	if(r==false)
	{
	return false; 
	}
	else
	{
	$("#overlay, #PleaseWait").show();
	var i=0;var temptrno=0;var temtbpur=0;var temaddval=0;var remrk=0;var costprice=0;
	var temptrno1=0;var temtbpur1=0;var temaddval1=0;var remrk1=0;var cspri1=0;
	for (i = 0; i < selectedrows.length; i++) {
		
			var srvdetmtrno= $('#jqxpartsgrid3').jqxGrid('getcellvalue', selectedrows[i], "rowno");
			temptrno=temptrno+","+srvdetmtrno;
			
			var chngntb= $('#jqxpartsgrid3').jqxGrid('getcellvalue', selectedrows[i], "status");
			
			temtbpur=temtbpur+","+chngntb;
			
			var addval= $('#jqxpartsgrid3').jqxGrid('getcellvalue', selectedrows[i], "availability");
			temaddval=temaddval+","+addval;
			
			var remr= $('#jqxpartsgrid3').jqxGrid('getcellvalue', selectedrows[i], "remarks");
			if(remr==''){
				remr=0;
			}
			
			 $('#hiddesc').val(remr);               
			    if (($(hiddesc).val()).includes('$')) { $(hiddesc).val($(hiddesc).val().replace('$', ''));};if (($(hiddesc).val()).includes('%')) { $(hiddesc).val($(hiddesc).val().replace('%', ''));};
		    	if (($(hiddesc).val()).includes('^')) { $(hiddesc).val($(hiddesc).val().replace('^', ''));};if (($(hiddesc).val()).includes('`')) { $(hiddesc).val($(hiddesc).val().replace('`', ''));};
		    	if (($(hiddesc).val()).includes('~')) { $(hiddesc).val($(hiddesc).val().replace('~', ''));};if ($(hiddesc).val().indexOf('\'')  >= 0 ) { $(hiddesc).val($(hiddesc).val().replace(/'/g, ''));};
		    	if ($(hiddesc).val().indexOf('"') >= 0) { $(hiddesc).val($(hiddesc).val().replace(/["']/g, ''));};if (($(hiddesc).val()).match(/\\/g)) { $(hiddesc).val($(hiddesc).val().replace(/\\/g, ''));};
            var change=$('#hiddesc').val();  
			remrk=remrk+","+change;
			
			var cspr= $('#jqxpartsgrid3').jqxGrid('getcellvalue', selectedrows[i], "total");
			costprice=costprice+","+cspr;
		
		
	temptrno1=temptrno;
	temtbpur1=temtbpur;
	temaddval1=temaddval;
	remrk1=remrk;
	cspri1=costprice;
	}
	$('#srvdetmtrno').val(temptrno1);
	$('#chngntb').val(temtbpur1);
	$('#addval').val(temaddval1);
	$('#remr').val(remrk1);
	$('#cspr').val(cspri1);
	
	savegriddata($('#srvdetmtrno').val(),$('#chngntb').val(),$('#addval').val(),$('#remr').val(),$('#cspr').val());
	
	}
	});
	}
	}
	
	function savegriddata(srvdetmtrno,chngntb,addval,remr,cspr){
		
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
		{
		var items=x.responseText;
		if(parseInt(items)>0)
		{
			$.messager.alert('Message','Successfully Updated');
			$("#overlay, #PleaseWait").hide();
		var reld=$('#jobcarddocno').val();
		$("#partsgrid3div").load("partsGrid.jsp?rowno="+reld+"&check="+1);
		$('#srvdetmtrno').val("");
		$('#chngntb').val("");
		$('#addval').val("");
		$('#remr').val("");
		$('#cspr').val("");
		
		
		}
		else
		{
		$.messager.alert('Message', ' Not Updated ');
		}
		} 
		}  
		x.open("GET","savgdata.jsp?srvdetmtrno="+srvdetmtrno+"&chngsntb="+chngntb+"&addval="+addval+"&costpr="+cspr+"&remarks="+remr,true);
		x.send();
		
		}  
	
	/* function funcolctnipurchdet() {
    
		$.messager.confirm('Message', 'Do you want to save changes?', function(r){
		if(r==false)
		{
		return false; 
		}
		else
		{
		//var accno=$('#raccno').val();
		var rval=$('#roundoff').val();
		var acno=$('#vendacno').val();
		var vtax=$('#vendtax').val();
		var idate=$('#Invdate').val();
		var ino=$('#invno').val();
		var jobno=$('#jobcarddocno').val();
		var ntotal=$('#nettotalval').val();
		var rows=$("#nidescdetailsGrid").jqxGrid('getrows');
		var gridarray=new Array();
		for(var i=0 ; i < rows.length ; i++){          
		 	    chks=rows[i].description;
		 	   if((typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != "") ){  
		 		  
		 		  gridarray.push((i+1)+" :: "+rows[i].qty+" :: "+rows[i].description+" :: "+rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "+rows[i].nuprice+" :: "+0+" :: "+0+" :: "+0+" :: "+rows[i].headdoc+" :: "+rows[i].refrow+" :: "+rows[i].taxper+" :: "+rows[i].taxperamt+" :: "+rows[i].taxamount+"::");
			 }    
		}
	savepurrchgridData(gridarray,acno,idate,ino,jobno,ntotal,vtax,rval);
    }
	});
	}
	function savepurrchgridData(gridarray,acno,idate,ino,jobno,ntotal,vtax,rval){
		
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
		{
		var items=x.responseText;
		if(parseInt(items)>0)
		{
		$.messager.alert('Message', 'Document'+items+' Successfully Updated In Ni Purchase');
		$("#overlay, #PleaseWait").hide();
		$("#nidescdetailsGrid").jqxGrid('clear');
		document.getElementById("invno").value="";
		document.getElementById("vendor").value="";
		document.getElementById("nettotalval").value="";
		document.getElementById("roundoff").value="";
		}
		else
		{
		$.messager.alert('Message', ' Not Updated ');
		}
		} 
		}  
		x.open("GET","savepurrchgridData.jsp?gridarray="+gridarray+"&acno="+acno+"&idate="+idate+"&ino="+ino+"&jobno="+jobno+"&ntotal="+ntotal+"&vtax="+vtax+"&roundval="+rval,true);
		x.send();
		
		
	} */
	function funcPrint(){
	  		
		var rows = $("#jqxpartsgrid3").jqxGrid('getrows');

		var selectedrows=$("#jqxpartsgrid3").jqxGrid('selectedrowindexes');
		selectedrows = selectedrows.sort(function(a,b){return a - b});

		if(selectedrows.length==0){
		$("#overlay, #PleaseWait").hide();
		$.messager.alert('Warning','Select documents.');
		return false;
		}


		 var i=0;var temptrno="";
		var j=0;
		for (i = 0; i < rows.length; i++) {
		if(selectedrows[j]==i){

		if(i==0){
		var srvdetmtrno= $('#jqxpartsgrid3').jqxGrid('getcellvalue', i, "rowno");
		temptrno=srvdetmtrno;
		}
		else{
		var srvdetmtrno= $('#jqxpartsgrid3').jqxGrid('getcellvalue', i, "rowno");
		temptrno=temptrno+","+srvdetmtrno;
		}
// 		temptrno1=temptrno+",";
        temptrno1=temptrno;
		j++; 
		}
		}
		$('#remtrno').val(temptrno1); 
		
	
	  		var jobno=$('#remtrno').val();
		    //alert(jobno);
	  	    var url=document.URL;
	  	    var reurl=url.split("com/");
	  	    //alert(reurl[0]+"printPartsCosting?jobno="+document.getElementById("hidjobno").value);
	  	  
	  	    var win= window.open(reurl[0]+"com/dashboard/workshop/partsmanagement/printParts?rowno="+$('#jobcarddocno').val()+"&jobdocno="+$('#remtrno').val(),"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	  	    win.focus();
	  		
	  	}
	
	/* function funsetnigrid(){
		//$("#nidescdetailsGrid").load("nipurchaseGrid.jsp");
		
		
	 	 if($('#invno').val()==""){
	  		   $.messager.alert('Message','Input a invoice number.');
	  		  }
 	 if($('#vendor').val()=="" || $('#invno').val()=="" ){
	  		   $.messager.alert('Message','Select a vendor and invoice number.');
	  		  }
		 else{
		var taxcal=$('#vendtax').val();
	    if(taxcal==1){
	    	taxcal=5;
	    }else{
	    	taxcal=0;
	    }
	    
	   // if(taxcal==0)
		var rowcn = $("#jqxpartsgrid3").jqxGrid('getrows');
        var selectedrows=$("#jqxpartsgrid3").jqxGrid('selectedrowindexes');
        selectedrows = selectedrows.sort(function(a,b){return a-b;});
        
        var i=0;var j=0;
        for (i=0; i<rowcn.length; i++) {
	        
	        if(selectedrows[j]==i){
	        	$("#nidescdetailsGrid").jqxGrid('addrow', null, {});
	        	var rows = $("#nidescdetailsGrid").jqxGrid('getrows');
	 	        var rowlength= rows.length;
	        var bal=$('#jqxpartsgrid3').jqxGrid('getcellvalue', i, "toberequested");
	        if(bal==0){
	        	 $.messager.alert('Message','Sufficient balance not available.');
	        }else{
	        $('#nidescdetailsGrid').jqxGrid('setcellvalue',  rowlength-1, "description",$('#jqxpartsgrid3').jqxGrid('getcellvalue', i, "description"));
	        $('#nidescdetailsGrid').jqxGrid('setcellvalue',  rowlength-1, "qty",$('#jqxpartsgrid3').jqxGrid('getcellvalue', i, "toberequested"));
	        
	        $('#nidescdetailsGrid').jqxGrid('setcellvalue',  rowlength-1, "unitprice",$('#jqxpartsgrid3').jqxGrid('getcellvalue', i, "total"));
	        $('#nidescdetailsGrid').jqxGrid('setcellvalue',  rowlength-1, "taxper",taxcal);
	        $('#nidescdetailsGrid').jqxGrid('setcellvalue',  rowlength-1, "refrow",$('#jqxpartsgrid3').jqxGrid('getcellvalue', i, "rowno"));
	        $('#nidescdetailsGrid').jqxGrid('setcellvalue',  rowlength-1, "headdoc",$('#jqxpartsgrid3').jqxGrid('getcellvalue', i, "accno"));
	        $('#nidescdetailsGrid').jqxGrid('setcellvalue',  rowlength-1, "account",$('#jqxpartsgrid3').jqxGrid('getcellvalue', i, "raccno"));
	    	var raccno=$('#jqxpartsgrid3').jqxGrid('getcellvalue', i, "raccno");
	        }
	    	//alert(raccno);
			j++;
	        }
			
	     }
		 }
     
	} */
	
	function funClearData(){
		/* $('input[type=text],[type=hidden]').val('');
		$('select').find('option').prop("selected", false);
		$('#Uptodate').jqxDateTimeInput('setDate',new Date());
	    $('input[type=radio]').prop("checked",false);
	    $('input[type=checkbox]').prop("checked",false);
	    $("#servicegrid2").jqxGrid('clear');
	    $("#partsgrid3").jqxGrid('clear');  
	    $("#jobgrid1").jqxGrid('clear'); */
	}
	
	
	 function isNumber(evt) {
	        var iKeyCode = (evt.which) ? evt.which : evt.keyCode;
	        
	        		 if (iKeyCode == 45)
	        			       			 
	        			  {
	        			 
	        			 
	        			  return true;
	        		     } 
	        		
	        		
	        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
	        	{
	     	   document.getElementById("errormsg").innerText=" Enter Numbers Only";  
	           
	            return false;
	        	}
	        document.getElementById("errormsg").innerText="";  
	        return true;
	    }
	   
	   
	function funreload(event)
	
	{	
		$("#overlay, #PleaseWait").show();
		var brhid=$('#cmbbranch').val();
		 $("#floorMgmtGridDiv").load("partsmanagementGrid.jsp?&id=1&brhid="+brhid);
			
	   	
	}
	
	 function SearchContent(url,id) {
	    $.get(url).done(function (data) {
	  $('#'+id).jqxWindow('setContent', data);
	}); 
	}
	 
   
 function funServiceUpdate(){  
	    var x=new XMLHttpRequest();
	    
		var jobno=$('#jobcarddocno').val();
		var stat=$('#txtstatus').val();
		if(stat==''){
			$.messager.alert('Message', ' Select a Status ');
		}
		else{
		if(jobno==''){
				$.messager.alert('Message', ' Select Document ');
		}
	    else{	
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
		{
			var items=x.responseText;
			if(parseInt(items)>=1)
			{
				 $("#floorMgmtGridDiv").load("partsmanagementGrid.jsp?&id="+1);
				  $("#partflwupgrid").load("partsfllwup.jsp?docno="+jobno+"");
				$.messager.alert('Message', ' Successfully Updated ');
				$('#txtremarks').val("");
				$('#txtstatus').val("");
			}
			else
			{
				$.messager.alert('Message', ' Not Updated ');
			}
		}   
		} 
	    }
		}
		x.open("GET","saveData.jsp?rowno="+$('#rowsno').val()+"&date="+$('#Uptodate').val()+"&remarks="+$('#txtremarks').val()+"&statusid="+$('#txtstatus').val()+"&jobno="+$('#jobcarddocno').val(),true);    
		x.send();
	}	 



	   


	function disablepart(){
		
		
		 $("#amcfollowupGrid").jqxGrid('clear');
		 $("#amcfollowupGrid").jqxGrid({ disabled: true});
	}


	



	
	</script> 
	
</head>
<!-- setValues(); -->
<body onload="getBranch();disablepart();">
<form id="frmWorkQuotationApproval" method="post">
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
                        <td class="label-cell">Status</td>            
                        <td>
                            <select id="txtstatus" name="txtstatus" value='<s:property value="txtstatus"/>'>   
                                <option value="">--select--</option>
                                <option value="Available">Available</option>
                                <option value="PartAvail">Partially Available</option>
                                <option value="Delayed">Delayed</option>
                                <option value="Ordered">Ordered</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Parts exp.Dt</td>
                        <td><div id="Uptodate"></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Remarks</td>
                        <td><input type="text" name="txtremarks" id="txtremarks" value='<s:property value="txtremarks"/>'></td>
                    </tr>
                </table>
            </div>

            <!-- Legend/Color Details Card -->
            <div class="filter-card">
                <div style="font-weight: 600; font-size: 12px; margin-bottom: 8px; color: #4e5e71;">Legend Overview</div>
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Parts Pending</td>
                        <td>
                            <input type="text" name="chkavail3" id="chkavail3" style="background-color:#FDFF79 !important; border-color:#e1e8ed !important;" value='<s:property value="chkavail3"/>'>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Not Available</td>
                        <td>
                            <input type="text" name="chkavail1" id="chkavail1" style="background-color:#FF8579 !important; border-color:#e1e8ed !important;" value='<s:property value="chkavail1"/>'>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Available</td>
                        <td>
                            <input type="text" name="chkavail" id="chkavail" style="background-color:#79FFA0 !important; border-color:#e1e8ed !important;" value='<s:property value="chkavail"/>'>
                        </td>
                    </tr>
                </table>
            </div>

            <!-- Action Buttons Card -->
            <div class="filter-card">
                <input type="button" name="btnupdate" id="btnupdate" value="Update" class="btn-submit" onclick="funServiceUpdate();"> 
                <hr style="border: 0; border-top: 1px solid #e1e8ed; margin: 12px 0;">
                <input type="button" name="btnupdateparts" id="btnupdateparts" value="Update Parts Detail" class="btn-submit" onclick="funUpdateParts();"> 
                <input type="button" name="btnPrint" id="btnPrint" value="Print" class="btn-submit" onclick="funcPrint();" style="background:#10b981 !important;">
            </div>

            <!-- Hidden Inputs Maintained Safely Outside Visual Layout -->
            <div style="display:none;">
                <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                <input type="hidden" name="rowsno" id="rowsno" value='<s:property value="rowsno"/>'>
                <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                <input type="hidden" name="jobcarddocno" id="jobcarddocno" value='<s:property value="jobcarddocno"/>'>
                <input type="hidden" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>'>
                <input type="hidden" name="jobno" id="jobno" value='<s:property value="jobno"/>'>
                <input type="hidden" name="techno" id="techno" value='<s:property value="techno"/>'>
                <input type="hidden" name="bayno" id="bayno" value='<s:property value="techno"/>'>
                <input type="hidden" name="part" id="part" value='<s:property value="part"/>'>
                <input type="hidden" name="qnty" id="qnty" value='<s:property value="qnty"/>'>
                <input type="hidden" name="rownum" id="rownum" value='<s:property value="rownum"/>'>
                <input type="hidden" name="purqty" id="purqty" value='<s:property value="purqty"/>'>
                <input type="hidden" name="tbpur" id="tbpur" value='<s:property value="tbpur"/>'>
                <input type="hidden" id="srvdetmtrno" name="srvdetmtrno" value='<s:property value="srvdetmtrno"/>'>
                <input type="hidden" id="chngntb" name="chngntb" value='<s:property value="chngntb"/>'>
                <input type="hidden" id="addval" name="addval" value='<s:property value="addval"/>'>
                <input type="hidden" id="vendorname" name="vendorname" value='<s:property value="vendorname"/>'>
                <input type="hidden" id="vendorid" name="vendorid" value='<s:property value="vendorid"/>'>
                <input type="hidden" id="vendtax" name="vendtax" value='<s:property value="vendtax"/>'>
                <input type="hidden" id="vendacno" name="vendacno" value='<s:property value="vendacno"/>'>
                <input type="hidden" id="raccno" name="raccno" value='<s:property value="raccno"/>'>
                <input type="hidden" id="nettotal" name="nettotal" value='<s:property value="nettotal"/>'>
                <input type="hidden" id="remtrno" name="remtrno" value='<s:property value="remtrno"/>'>
                <input type="hidden" id="hiddesc" name="hiddesc" value='<s:property value="hiddesc"/>'>
                <input type="hidden" id="remr" name="remr" value='<s:property value="remr"/>'>
                <input type="hidden" id="cspr" name="cspr" value='<s:property value="cspr"/>'>
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
            
            <fieldset class="violetClass grid-fieldset">
                <legend>Parts Management</legend>
                <div id="floorMgmtGridDiv"><jsp:include page="partsmanagementGrid.jsp"></jsp:include></div>
            </fieldset>
            
            <fieldset class="violetClass grid-fieldset">
                <legend>Parts</legend>
                <div id="partsgrid3div"><jsp:include page="partsGrid.jsp"></jsp:include></div>
            </fieldset>
            
            <fieldset class="violetClass grid-fieldset">
                <legend>Parts Followup</legend>
                <div id="partflwupgrid"><jsp:include page="partsfllwup.jsp"></jsp:include></div>
            </fieldset> 

        </div>

    </div>

</div>

<!-- Popups Maintained Outside the Layout Flow -->
<div id="TechnicianWindow">
    <div></div>
</div>
<div id="bayWindow">
    <div></div>
</div>
<div id="sparePartWindow">
    <div></div>
</div>
<div id="jobCardToWindow">
    <div></div>
</div>
<div id="vendorToWindow">
    <div></div>
</div>

</div>
</form>
</body>
</html>