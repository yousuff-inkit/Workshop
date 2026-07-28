<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<% String contextPath=request.getContextPath();%>
<%
	String mod = request.getParameter("mod") == null ? "view" : request
			.getParameter("mod").toString();
 String purchasearray = request.getParameter("purchaseorderarray") == null? "0": request.getParameter("purchaseorderarray").toString() ;
 
 String itemdocno = request.getParameter("itemdocno") == null? "0": request.getParameter("itemdocno").toString() ;
 
 String costranno = request.getParameter("costranno") == null? "0": request.getParameter("costranno").toString() ;
 String prjnames = request.getParameter("prjnames") == null? "0": request.getParameter("prjnames").toString() ;
 
 String contrtypes = request.getParameter("contrtypes") == null? "0": request.getParameter("contrtypes").toString() ;
 String hideitemtype = request.getParameter("hideitemtype") == null? "0": request.getParameter("hideitemtype").toString() ;
 
 System.out.println("purchasearray==="+purchasearray);

%>
<html>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includeso.jsp"></jsp:include>

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
    overflow-x: hidden;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

form label.error { color:red; font-weight:bold; }
#errormsg { color:red; font-weight:bold; text-align:center; margin-bottom: 10px; }

/* Original specific styling for psearch background adopted to modern panel if necessary */
#psearch { background: #fdfdfd; }

</style>

<script type="text/javascript">
var mod1='<%=mod%>';
var prcharray='<%=purchasearray%>';

$(document).ready(function () { 
    
    $('#btnvaluechange').hide();

    /* Formatted jqxDateTimeInput heights to match modern UI 24px */
    $("#nipurchaseorderdate").jqxDateTimeInput({  width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    $("#deliverydate").jqxDateTimeInput({  width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    
    /* force internal alignment AFTER render */
    setTimeout(function () {
        $("#nipurchaseorderdate, #deliverydate").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#nipurchaseorderdate, #deliverydate").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);


    $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
	$('#accountSearchwindow').jqxWindow('close');
	
    $('#lastpurchasewindow').jqxWindow({ width: '50%', height: '32%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Search' ,position: { x: 500, y: 120 }, theme: 'energyblue', keyboardCloseKey: 27});
	$('#lastpurchasewindow').jqxWindow('close');
	
	$('#searchwndow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Product Search' , position: { x: 250, y: 120 }, theme: 'energyblue', keyboardCloseKey: 27});
	$('#searchwndow').jqxWindow('close');  
	      
    $('#tremwndow').jqxWindow({ width: '30%', height: '58%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Search ' , position : { x : 420, y : 87 }, theme: 'energyblue', keyboardCloseKey: 27});
    $('#tremwndow').jqxWindow('close');
	     
    $('#sidesearchwndow').jqxWindow({ width: '55%', height: '95%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Product Search ' , position: { x: 600, y: 0 }, theme: 'energyblue', keyboardCloseKey: 27});
    $('#sidesearchwndow').jqxWindow('close');   
	     
    $('#refnosearchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
    $('#refnosearchwindow').jqxWindow('close'); 
	 
    $('#searchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
    $('#searchwindow').jqxWindow('close');
		   
    $('#importwindow').jqxWindow({ width: '30%', height: '24.4%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Import Options' , position: { x: 500, y: 200 }, theme: 'energyblue', showCloseButton: false});
    $('#importwindow').jqxWindow('close');   
		     
    if($('#reftypeval').val()!="DIR") {
        $("#btnDelete").attr('disabled', true );
    } else {
        $("#btnDelete").attr('disabled', false );
    }
			   
    $('#rrefno').dblclick(function(){
        if($("#mode").val() == "A") {
            if(document.getElementById("puraccid").value=="") {
                document.getElementById("errormsg").innerText="Search Vendor";  
                document.getElementById("puraccid").focus();
                return 0;
            }
            $('#refnosearchwindow').jqxWindow('open');
            refsearchContent('refnosearch.jsp?acno='+document.getElementById("accdocno").value); 
        }
    });
			 
    $('#puraccid').dblclick(function(){
    	if($('#mode').val()!= "view") {
	  	    $('#accountSearchwindow').jqxWindow('open');
	  	    accountSearchContent('accountsDetailsSearch.jsp?');
    	}
    });   
    
    $('#shipto').dblclick(function(){
    	if($('#mode').val()!= "view") {
	  	    shipSearchContent('shipmasterSearch.jsp?');
    	}
    });   
    
    $('#itemdocno').dblclick(function(){
        if($("#mode").val() == "A" || $("#mode").val() == "E") {
            $('#searchwindow').jqxWindow('open');
            if(document.getElementById("itemtype").value=="1") {
                refsearchContent1('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costCodeSearchGrid.jsp?docno='+document.getElementById("itemtype").value); 	
            }
            else if(document.getElementById("itemtype").value=="6") {
                refsearchContent1('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/fleetGrid.jsp?'); 	
            }
            else {
                refsearchContent1('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costunitsearch.jsp?docno='+document.getElementById("itemtype").value); 	
            }
        }
	}); 

}); 

function getitem(event){
 	 var x= event.keyCode;
 	 if(x==114){
 		$('#searchwindow').jqxWindow('open');
 		if(document.getElementById("itemtype").value=="1") {
		    refsearchContent1('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costCodeSearchGrid.jsp?docno='+document.getElementById("itemtype").value); 	
		}
		else if(document.getElementById("itemtype").value=="6") {
		    refsearchContent1('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/fleetGrid.jsp?'); 	
		}
	    else {
		    refsearchContent1('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costunitsearch.jsp?docno='+document.getElementById("itemtype").value); 	
		}
 	 }
}  

function refsearchContent1(url) {
    $.get(url).done(function (data) {
        $('#searchwindow').jqxWindow('setContent', data);
 	}); 
}

function getshipdetails(event){
 	 var x= event.keyCode;
 	if($('#mode').val()!="view") {
 	    if(x==114){
 	        shipSearchContent('shipmasterSearch.jsp?');    
        }
 	}
}  

function shipSearchContent(url) {
	$('#accountSearchwindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#accountSearchwindow').jqxWindow('setContent', data);
	}); 
}  
 	
function priceSearchContent(url) {
	$('#lastpurchasewindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#lastpurchasewindow').jqxWindow('setContent', data);
	}); 
}  

function shipdescSearchContent(url) {
    $.get(url).done(function (data) {
        $('#tremwndow').jqxWindow('open');
        $('#tremwndow').jqxWindow('setContent', data);
	}); 
}  

function termsSearchContent(url) {
    $('#tremwndow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#tremwndow').jqxWindow('setContent', data);
        $('#tremwndow').jqxWindow('bringToFront');
    }); 
} 

function getrefno(event) {
	 var x= event.keyCode;
	 if(x==114){
		  if(document.getElementById("puraccid").value=="") {
			 document.getElementById("errormsg").innerText="Search Vendor";  
			 document.getElementById("puraccid").focus();
		     return 0;
		  }
	      $('#refnosearchwindow').jqxWindow('open');
	      refsearchContent('refnosearch.jsp?acno='+document.getElementById("accdocno").value);  
     }
}  
	 
function refsearchContent(url) {
    $.get(url).done(function (data) {
        $('#refnosearchwindow').jqxWindow('setContent', data);
	}); 
}

function importsearchcontent(url) {
    $('#importwindow').jqxWindow('open');
    $.get(url).done(function (data) {
	    $('#importwindow').jqxWindow('setContent', data);
	}); 
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

function accountSearchContent(url) {
    $.get(url).done(function (data) {
        $('#accountSearchwindow').jqxWindow('setContent', data);
	}); 
}
	  
function reqproductSearchContent(url) {
    $.get(url).done(function (data) {
        $('#sidesearchwndow').jqxWindow('open');
        $('#sidesearchwndow').jqxWindow('setContent', data);
    }); 
} 

function productSearchContent(url) {
    $.get(url).done(function (data) {
        $('#sidesearchwndow').jqxWindow('open');
        $('#sidesearchwndow').jqxWindow('setContent', data);
    }); 
} 

function funReset(){}

function funReadOnly(){
	$('#purchaseOrder input').attr('readonly', true );
	$('#purchaseOrder select').attr('disabled', true );
	$('#nipurchaseorderdate').jqxDateTimeInput({ disabled: true});
	$('#deliverydate').jqxDateTimeInput({ disabled: true});
    $("#descdetailsGrid").jqxGrid({ disabled: true});
    $("#serviecGrid").jqxGrid({ disabled: true});
    $("#shipdata").jqxGrid({ disabled: true});
    $('#rrefno').attr('disabled', true);
    $('#descPercentage').attr('disabled', true);
    $('#descountVal').attr('disabled', true);
    $('#chkdiscount').attr('disabled', true);	 
    $('#process1').attr('disabled', true);
    $('#producttype').val(0);	 
    $('#psearch').attr('disabled', true );
    $("#jqxTerms").jqxGrid({ disabled: true});
    $('#btnCalculate').attr('disabled', true);
	$('#cmbcurr').attr('disabled', true);		
	$('#btnvaluechange').hide();
	$('#acctype').attr('disabled', true);
	 
    if(mod1=="A") {
        document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
        document.getElementById("formdetail").value=window.parent.formName.value;
        document.getElementById("formdetailcode").value=window.parent.formCode.value.trim(); 
        funCreateBtn();
    } else {
        mod1="view";
    }
}

function funRemoveReadOnly(){
	 chklastpurchase();
	 document.getElementById("editdata").value="";
	 reloads();
	if ($("#mode").val() == "A") {
	    gridLoad();
	}
	getround();
	chkmultiqty();
	
	$('#purchaseOrder input').attr('readonly', false );
	$('#serviecGrid').jqxGrid('setcolumnproperty', 'discount',  "editable", true);
	$('#serviecGrid').jqxGrid('setcolumnproperty', 'discper',  "editable", true);
	
	$('#purchaseOrder select').attr('disabled', false );
    $('#currate').attr('readonly', true);
    $('#puraccid').attr('readonly', true);
    $('#puraccname').attr('readonly', true);
    $('#rrefno').attr('disabled', true);
    $('#rrefno').attr('readonly', true);
    $('#btnvaluechange').hide();
		 
    gettaxaccount(1);	
    $('#st').attr('readonly', true );
    $('#taxontax1').attr('readonly', true );
    $('#taxontax2').attr('readonly', true );
    $('#taxontax3').attr('readonly', true );
    $('#taxtotal').attr('readonly', true );
    $('#process1').attr('disabled', false);
		 
    $('#shipto').attr('readonly', true);
    $('#shipaddress').attr('readonly', true);
    $('#contactperson').attr('readonly', true);
    $('#shiptelephone').attr('readonly', true);
    $('#shipmob').attr('readonly', true);
    
    $('#shipemail').attr('readonly', true);
    $('#shipfax').attr('readonly', true);
		 
    $('#producttype').val(0);	 
		 
	$('#nipurchaseorderdate').jqxDateTimeInput({ disabled: false});
	$('#deliverydate').jqxDateTimeInput({ disabled: false});

	$('#cmbcurr').attr('disabled', false);
	$('#acctype').attr('disabled', false);
	 
	$('#docno').attr('readonly', true);
	$("#descdetailsGrid").jqxGrid({ disabled: false});
	$("#serviecGrid").jqxGrid({ disabled: false});
	$("#shipdata").jqxGrid({ disabled: false});
	 
    $('#descPercentage').attr('disabled', true);
    $('#descountVal').attr('disabled', true);
    $('#docno').attr('readonly', true);
    
    $('#orderValue').attr('readonly', true);
    
    $('#productTotal').attr('readonly', true);
    $('#netTotaldown').attr('readonly', true);
	 
    $('#totamt').attr('readonly', true );
    $('#taxpers').attr('readonly', true );
    $('#taxamounts').attr('readonly', true );
    $('#taxamountstotal').attr('readonly', true );
    
    $('#amounts').attr('readonly', true );  
	 
	if ($("#mode").val() == "A") {
        $('#chkdiscount').attr('disabled', false);
        $('#nipurchaseorderdate').val(new Date());
        $('#deliverydate').val(new Date());
        $("#descdetailsGrid").jqxGrid('clear');
        $("#descdetailsGrid").jqxGrid('addrow', null, {});
        $("#serviecGrid").jqxGrid('clear');
        $("#serviecGrid").jqxGrid('addrow', null, {});
        $("#shipdata").jqxGrid('clear');
        $("#shipdata").jqxGrid('addrow', null, {});
        
        $("#jqxTerms").jqxGrid('addrow', null, {});
        $("#jqxTerms").jqxGrid({ disabled: false});
        $('#psearch').attr('disabled', false );
    }
	
  	if ($("#mode").val() == "E") {
  		$("#descdetailsGrid").jqxGrid({ disabled: true});
		$("#serviecGrid").jqxGrid({ disabled: true});
		$("#shipdata").jqxGrid({ disabled: true});
		$("#jqxTerms").jqxGrid({ disabled: true});
		$('#btnCalculate').attr('disabled', true);
		
        var rows = $("#serviecGrid").jqxGrid('getrows');
        var aa=0;
        for(var i=0;i<rows.length;i++){
            if(parseInt(rows[i].clstatus)==1) {
                aa=1;
                break;
            } else {
                aa=0;
            } 
        }
      	    
        if(parseInt(aa)==1) {
            $('#serviecGrid').jqxGrid('render');
            $('#btnvaluechange').hide();
        } else {
   		    $('#btnvaluechange').show();
   		}
	}  
  
  	if(mod1=="A") {
  		var costranno='<%=costranno%>';
  		var contrtypes='<%=contrtypes%>';
  		var itemdocno='<%=itemdocno%>';
  		var prjnames='<%=prjnames%>';
  		var hideitemtype='<%=hideitemtype%>';
  		
  		$("#sevdesc").load("serviecgrid.jsp?prcharray="+'<%=purchasearray.replaceAll("\\s","a@b@c")%>'+"&modebprf=a1");
  		document.getElementById("costtr_no").value=costranno;
  		
  		document.getElementById("hideitemtype").value=hideitemtype;
  		document.getElementById("itemdocno").value=itemdocno;
  		document.getElementById("itemname").value=prjnames;
    }
	
	getCurrencyIds();
	chkcostcode();
	 
	$('#itemdocno').attr('readonly', true);
	$('#itemname').attr('readonly', true);
}

function gridLoad(){
    var dtype=document.getElementById("formdetailcode").value;
    $("#termsDiv").load("termsGrid.jsp?dtype="+dtype);
}

function funFocus(){
   	$('#nipurchaseorderdate').jqxDateTimeInput('focus'); 	    		
}

function funNotify(){	
    var purid= document.getElementById("puraccid").value;
    if(purid=="") {
        document.getElementById("errormsg").innerText=" Select An Account";
        document.getElementById("puraccid").focus();
        return 0;
    } else {
        document.getElementById("errormsg").innerText="";
    }
	   
    if(document.getElementById('reftype').value=="DIR") {
    } else {
        if(document.getElementById("rrefno").value=="") {
            document.getElementById("errormsg").innerText="Search Purchase Request";  
            document.getElementById("rrefno").focus();
            return 0;
        }
    }  
	   
    var refval= document.getElementById("nettotal").value;
    if(refval=="") {
        document.getElementById("nettotal").value=0;
    } else {
        document.getElementById("errormsg").innerText="";
    }

    var rows = $("#serviecGrid").jqxGrid('getrows');
    $('#serviecGridlength').val(rows.length);
    for(var i=0 ; i < rows.length ; i++){
        newTextBox = $(document.createElement("input")) 
            .attr("type", "dil")
            .attr("id", "sertest"+i)
            .attr("name", "sertest"+i)
            .attr("hidden", "true");          
            
        newTextBox.val(rows[i].psrno+"::"+rows[i].prodoc+" :: "+rows[i].unitdocno+" :: "+rows[i].qty+" :: "
                    +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "+rows[i].saveqty
                    +" :: "+rows[i].checktype+" :: "+rows[i].specid+" :: "+rows[i].discper+" :: "+rows[i].unitprice1+"::"+rows[i].disper1
                    +"::"+rows[i].taxper+"::"+rows[i].taxperamt+"::"+rows[i].taxamount+"::"+rows[i].taxdocno+"::"+"0000"+"::"); 
        
        newTextBox.appendTo('form');
    }   

    var rows = $("#descdetailsGrid").jqxGrid('getrows');
    $('#descgridlenght').val(rows.length);
    for(var i=0 ; i < rows.length ; i++){
        newTextBox = $(document.createElement("input"))
            .attr("type", "dil")
            .attr("id", "desctest"+i)
            .attr("name", "desctest"+i)
            .attr("hidden", "true"); 
        
        newTextBox.val(rows[i].srno+"::"+rows[i].qty1+" :: "+rows[i].description+" :: "
                +rows[i].unitprice1+" :: "+rows[i].total1+" :: "+rows[i].discount1+" :: "+rows[i].nettotal1+" :: ");
        newTextBox.appendTo('form');
    }  
	   
    var rows = $("#shipdata").jqxGrid('getrows');
    $('#shipdatagridlenght').val(rows.length);
    for(var i=0 ; i < rows.length ; i++){
        newTextBox = $(document.createElement("input"))
            .attr("type", "dil")
            .attr("id", "shiptest"+i)
            .attr("name", "shiptest"+i)
            .attr("hidden", "true"); 
        
        newTextBox.val(rows[i].doc_nos+"::"+rows[i].desc1+" :: "+rows[i].refno+" :: "+rows[i].date+" :: ");
        newTextBox.appendTo('form');
    }  
	   
    var termrows = $("#jqxTerms").jqxGrid('getrows');
    $('#termsgridlength').val(termrows.length);
    for(var i=0 ; i < termrows.length ; i++){ 
        newTextBox = $(document.createElement("input"))
            .attr("type", "dil")
            .attr("id", "termg"+i)
            .attr("name", "termg"+i)
            .attr("hidden", "true");
        newTextBox.val(termrows[i].voc_no+"::"+termrows[i].dtype+"::"+termrows[i].terms+"::"+termrows[i].conditions+"::");
        newTextBox.appendTo('form');
    }
	   
    if ($("#mode").val() == "E") {
        if($('#reftypeval').val()!="DIR") {
            $('#rrefno').attr('disabled', false);
            $('#rrefno').attr('readonly', true);
        }
        
        $('#chkdiscount').attr('disabled', false);
        if(document.getElementById("chkdiscountval").value==1) {
            document.getElementById("chkdiscount").value = 1;
            $('#descPercentage').attr('disabled', false);
            $('#btnCalculate').attr('disabled', false);
            $('#descountVal').attr('disabled', false);
        }
        
        $('#rrefno').attr('disabled', false);
        $('#rrefno').attr('readonly', true);
        
        $("#descdetailsGrid").jqxGrid({ disabled: false});
        $("#serviecGrid").jqxGrid({ disabled: false});
        $("#shipdata").jqxGrid({ disabled: false});
        $("#jqxTerms").jqxGrid({ disabled: false});	 
    } 
	return 1;
} 

function funwarningopen(){
    $.messager.confirm('Confirm', 'Transaction Will Affect Already Inserted Values.', function(r){
        if (r){
            $('#chkdiscount').attr('disabled', false);
            if(document.getElementById("chkdiscountval").value==1) {
                document.getElementById("chkdiscount").checked = true;
                document.getElementById("chkdiscount").value = 1;
                
                $('#descPercentage').attr('disabled', false);
                $('#btnCalculate').attr('disabled', false);
                $('#descountVal').attr('disabled', false);
                    
                if($('#reftypeval').val()!="DIR") {
                    $('#psearch').attr('disabled', true );
                    $('#setbtn').attr('disabled', true );  
                } else {
                    $('#psearch').attr('disabled', false );
                    $('#setbtn').attr('disabled', false );     
                }
            }
        
            document.getElementById("editdata").value="Editvalue";
            $("#jqxTerms").jqxGrid({ disabled: false});
            $("#descdetailsGrid").jqxGrid({ disabled: false});
            $("#serviecGrid").jqxGrid({ disabled: false});
            $("#shipdata").jqxGrid({ disabled: false});
            $("#shipdata").jqxGrid('addrow', null, {});
            $("#descdetailsGrid").jqxGrid('addrow', null, {});
            $("#serviecGrid").jqxGrid('addrow', null, {});
            $("#jqxTerms").jqxGrid('addrow', null, {});
        }
    });
}

function funChkButton() {}

function funSearchLoad(){
	changeContent('mainsearch.jsp'); 
}

function getCurrencyIds(){
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            items= x.responseText;
            items=items.split('####');
            var curidItems=items[0];
            var curcodeItems=items[1];
            var currateItems=items[2];
            var multiItems=items[3];
            var optionscurr = '';
            if(curcodeItems.indexOf(",")>=0){
                curidItems.split(",");
                curcodeItems.split(",");
                currateItems.split(",");
                for ( var i = 0; i < curcodeItems.length; i++) {
                    optionscurr += '<option value="' + curidItems[i] + '">' + curcodeItems[i] + '</option>';
                }
                $("select#cmbcurr").html(optionscurr);
            } else {
                optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
                $("select#cmbcurr").html(optionscurr);
                funRoundRate(currateItems,"currate");
                $('#currate').attr('readonly', true);
            }
        }
    }
    x.open("GET","getCurrencyId.jsp",true);
    x.send();
}
	   
function getRatevalue(angel) {
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items= x.responseText;
            funRoundRate(items,"currate"); 
        }
    }
    x.open("GET","getRateTo.jsp?curr="+a,true);
    x.send();
}
	   
function combochange() {
    if($('#cmbcurrval').val()!="") {
        $('#cmbcurr').val($('#cmbcurrval').val());   
    }
    if($('#reftypeval').val()!="") {
        $('#reftype').val($('#reftypeval').val());
    }
    if($('#hidcmbbilltype').val()!="") {
        $('#cmbbilltype').val($('#hidcmbbilltype').val());   
    }
    
    if($('#reftypeval').val()!="DIR") {
        $('#rrefno').attr('disabled', false);
        $('#rrefno').attr('readonly', true);
    }
    
    if(document.getElementById("chkdiscountval").value==1) {
        document.getElementById("chkdiscount").checked = true;
        document.getElementById("chkdiscount").value = 1;
    } else {
        document.getElementById("chkdiscount").checked = false;
        document.getElementById("chkdiscount").value = 0;
    }
}

function setValues() {
    if($('#hidnipurchaseorderdate').val()){
        $("#nipurchaseorderdate").jqxDateTimeInput('val', $('#hidnipurchaseorderdate').val());
    }
    
    if($('#hiddeliverydate').val()){
        $("#deliverydate").jqxDateTimeInput('val', $('#hiddeliverydate').val());
    }
    var dis=document.getElementById("masterdoc_no").value;
    if(dis>0) {     
        combochange();
        funchkforedit();
        var indexval1 = document.getElementById("masterdoc_no").value;   

        $("#descdetail").load("descgridDetails.jsp?purdoc="+indexval1);
        var reftypeval = document.getElementById("reftypeval").value;  
        var reqmasterdocno = document.getElementById("reqmasterdocno").value;  
        
        $("#sevdesc").load("serviecgrid.jsp?purdoc="+indexval1+"&reftype="+reftypeval+"&reqmasterdocno="+reqmasterdocno);
        $("#termsDiv").load("termsGrid.jsp?masterdoc="+indexval1);
        $("#shipdetdiv").load("shipdetailsGrid.jsp?masterdoc="+indexval1+"&formcode="+$('#formdetailcode').val());
    } 

    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    } 
    
    document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";  
    gettaxaccount(1);
    funSetlabel();
} 

function funPrintBtn(){
    if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
        var url=document.URL;
        var reurl=url.split("saveActionpurOrders");
        $("#docno").prop("disabled", false);                
        var brhid=<%= session.getAttribute("BRANCHID").toString()%>
        var dtype=$('#formdetailcode').val();
        var win= window.open(reurl[0]+"printpurchaseorder1?docno="+document.getElementById("masterdoc_no").value+"&brhid="+brhid+"&dtype="+dtype,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
        win.focus();
    } else {
        $.messager.alert('Message','Select a Document....!','warning');
        return false;
    }
}

$(function(){
    $('#purchaseOrder').validate({
        rules: { 
            delterms:{maxlength:200},
            purdesc:{maxlength:200},
            payterms:{maxlength:200},
            puraccid:{required:true}
        },
        messages: {
            delterms: {maxlength:"  Max 200 chars"},
            purdesc: {maxlength:"  Max 200 chars"},
            payterms: {maxlength:"  Max 200 chars"},
            puraccid: {required:" *"}
        }
    });
});

function isNumber(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
        document.getElementById("errormsg").innerText=" Enter Numbers Only";  
        return false;
    }
    document.getElementById("errormsg").innerText="";  
    return true;
}

function fundisable() {
    if (document.getElementById('chkdiscount').checked) {
        $.messager.confirm('Confirm', 'Line Discount Will Override With Bill Discount', function(r){
            if (r==false){
                document.getElementById('chkdiscount').checked=false;
                return 0;
            } else {
                if (document.getElementById('chkdiscount').checked) {
                    $('#descPercentage').attr('disabled', false);
                    $('#descountVal').attr('disabled', false);
                    $('#btnCalculate').attr('disabled', false);
                }
            }
        });
    } else {
        document.getElementById('descPercentage').value="";
        document.getElementById('descountVal').value="";
        var summaryData3= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'discount', ['sum'],true);
        document.getElementById("prddiscount").value=summaryData3.sum.replace(/,/g,'');
        $('#descPercentage').attr('disabled', true);
        $('#descountVal').attr('disabled', true);
        
        $('#btnCalculate').attr('disabled', true);
        $('#serviecGrid').jqxGrid('setcolumnproperty', 'discount',  "editable", true);
        $('#serviecGrid').jqxGrid('setcolumnproperty', 'discper',  "editable", true);
    }
}

function funcalcu() {
	document.getElementById('prddiscount').value="";
	$('#serviecGrid').jqxGrid('setcolumnproperty', 'discount',  "editable", false);
	$('#serviecGrid').jqxGrid('setcolumnproperty', 'discper',  "editable", false);
	var  productTotal=document.getElementById('productTotal').value;
	var  descPercentage=document.getElementById('descPercentage').value;
	
	var descvalue=parseFloat(productTotal)*(parseFloat(descPercentage)/100);
	var netval=parseFloat(productTotal)-parseFloat(descvalue);
	
	var rows = $('#serviecGrid').jqxGrid('getrows');
    var rowlength= rows.length-1;
  	var disval=parseFloat(descvalue)/(parseInt(rowlength));
  	
    for(var i=0;i<rowlength;i++) {
        var totamt=rows[i].total;
        var discounts=(parseFloat(descvalue)/parseFloat(productTotal))*parseFloat(totamt);
        var	discper=(100/parseFloat(totamt))*parseFloat(discounts);
        var nettot=parseFloat(totamt)-parseFloat(discounts);
        
        $('#serviecGrid').jqxGrid('setcellvalue',i, "discount" ,discounts);
        $('#serviecGrid').jqxGrid('setcellvalue',i, "discper" ,discper);
        $('#serviecGrid').jqxGrid('setcellvalue',i, "nettotal" ,nettot);
    }
	 
    var  productTotal=document.getElementById('productTotal').value;
    var  descPercentage=document.getElementById('descPercentage').value;
    var descvalue=parseFloat(productTotal)*(parseFloat(descPercentage)/100);
    var netval=parseFloat(productTotal)-parseFloat(descvalue);
    
    var  roundOf=document.getElementById('roundOf').value;
    
    if(roundOf!="" ||roundOf==null || typeof(roundOf)=="undefiend") {
        netval=parseFloat(netval)+parseFloat(roundOf);
    }
    
    var aa;
    if(document.getElementById("nettotal").value!="" ||document.getElementById("nettotal").value==null || document.getElementById("nettotal").value=="undefiend") {
        aa=parseFloat(document.getElementById("netTotaldown").value)+parseFloat(document.getElementById("nettotal").value);
    } else {
        aa=document.getElementById("netTotaldown").value;
    }
    
    funRoundAmt(aa,"orderValue");
}
	
function funvalcalcu() {
	document.getElementById('prddiscount').value="";
	$('#serviecGrid').jqxGrid('setcolumnproperty', 'discount',  "editable", false);
	var  productTotal=document.getElementById('productTotal').value;
	var  descountVal=document.getElementById('descountVal').value;
 
	var descper=(100/parseFloat(productTotal))*parseFloat(descountVal);
	var netval=parseFloat(productTotal)-parseFloat(descountVal);
	
	funRoundAmt(descper,"descPercentage");
	funRoundAmt(netval,"netTotaldown");
	funcalcu();
}
	
function getround(){ 
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            items= x.responseText;
            items=items.split('::');
            document.getElementById("roundmethod").value=items[0];
            document.getElementById("roundvals").value=items[1];
        }
    }
    x.open("GET","getroundval.jsp?",true);
    x.send();
}
	
function roundval() {
	if(parseInt(document.getElementById("roundmethod").value)>0) {
	    var roundOf1=document.getElementById('roundOf').value;
	    var roundval1=document.getElementById('roundvals').value;
	    var id=1;
	    if(parseFloat(roundOf1)<0) {
	    	roundOf1=roundOf1*-1;
	    	id=-1;
	    }
	    
	    if(parseFloat(roundOf1)>parseFloat(roundval1)) {
	 		document.getElementById("errormsg").innerText="Maximum Allowed Round of Is "+roundval1*id;
	 		document.getElementById('roundOf').value=0;
	 		document.getElementById('roundOf').focus();
	    } else {
	   	    document.getElementById("errormsg").innerText="";
	    }
	}

    var roundOf=document.getElementById('roundOf').value;
 
    if(roundOf!="") {
        var summaryData= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true);
        var  netTotaldown=summaryData.sum.replace(/,/g,'');
        var	 netval=parseFloat(netTotaldown)+parseFloat(roundOf);
        
        funRoundAmt(netval,"netTotaldown"); 
        
        var ordertotal="0";
        var nettotalval="0";
        if(document.getElementById("nettotal").value!="" && !(document.getElementById("nettotal").value==null) && !(document.getElementById("nettotal").value=="undefiend")) {
            nettotalval=parseFloat(document.getElementById("nettotal").value);
        }
        
        ordertotal=parseFloat(nettotalval)+parseFloat(document.getElementById("netTotaldown").value);
        funRoundAmt(ordertotal,"orderValue");
    }
} 
	
function funrefdisslno() {
	if(document.getElementById('reftype').value=="DIR") {
        $('#rrefno').attr('disabled', true);
        $('#rrefno').attr('readonly', true);
        document.getElementById("errormsg").innerText="";
        document.getElementById("rrefno").value="";
        document.getElementById("reqmasterdocno").value="";
        $("#serviecGrid").jqxGrid('clear');
        $("#serviecGrid").jqxGrid('addrow', null, {});
        $('#setbtn').attr('disabled', false );  
        $('#psearch').attr('disabled', false );
	} else {
        $('#rrefno').attr('disabled', false);
        $('#rrefno').attr('readonly', true);
        $('#setbtn').attr('disabled', true );  
        $('#psearch').attr('disabled', true );
        document.getElementById("rrefno").value="";
        document.getElementById("reqmasterdocno").value="";
        $("#serviecGrid").jqxGrid('clear');
        $("#serviecGrid").jqxGrid('addrow', null, {});
	}
}
 
function funchkforedit() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();	
            if(parseInt(items)>0) {
                $("#btnEdit").attr('disabled', true );
                $("#btnDelete").attr('disabled', true ); 
            }
        }
    }
    x.open("GET", "linkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value+"&reftype="+document.getElementById("reftype").value+"&refmasterdocno="+document.getElementById("reqmasterdocno").value, true);
    x.send();    
}

function isNumber1(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode;
    if (iKeyCode == 45) {
        return true;
    } 
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
        document.getElementById("errormsg").innerText=" Enter Numbers Only";  
        return false;
    }
    document.getElementById("errormsg").innerText="";  
    return true;
}
	   
function gettaxaccount(val) {
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items= x.responseText.trim();
            var item = items.split('::');
            var method=item[0];
            var aa=item[1];
            
            if(parseInt(method)>0) {
                if(parseInt(aa)==0) {
                    $('#taxsss').hide();
                    $('#process1').hide(); 
                    $('#taxontax1').hide();
                    $('#taxontax2').hide();
                    $('#taxontax3').hide();
                }
                
                if(parseInt(aa)==1) {
                    document.getElementById("tax1per").value=item[3];
                    document.getElementById("labeltax1").innerText=item[2];
                    document.getElementById("typeoftaken").value=item[6];
                    $('#taxontax2').hide();
                    $('#taxontax3').hide();
                }
                
                if(parseInt(aa)==2) {
                    document.getElementById("tax1per").value=item[3];
                    document.getElementById("labeltax1").innerText=item[2];
                    
                    document.getElementById("tax2per").value=item[5];
                    document.getElementById("labeltax2").innerText=item[4];
                    
                    document.getElementById("typeoftaken").value=item[6];
                    $('#taxontax3').hide();
                }
                
                if(parseInt(aa)==3) {
                    document.getElementById("tax1per").value=item[3];
                    document.getElementById("labeltax1").innerText=item[2];
                    
                    document.getElementById("tax2per").value=item[5];
                    document.getElementById("labeltax2").innerText=item[4];
                    
                    document.getElementById("typeoftaken").value=item[6];
                    
                    document.getElementById("tax3per").value=item[8];
                    document.getElementById("labeltax3").innerText=item[7];
                }
            }
        }
    }
    x.open("GET","gettaxaccount.jsp?date="+document.getElementById("nipurchaseorderdate").value+"&cmbbilltype="+document.getElementById("cmbbilltype").value,true);
    x.send();
} 

function getunit(val){ 
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            items= x.responseText;
            items=items.split('####');
            var docno=items[0].split(",");
            var type=items[1].split(",");
            var optionstype;

            for ( var i = 0; i < type.length; i++) {
                optionstype += '<option value="' + docno[i] + '">' + type[i] + '</option>';
            }
            $("select#unit").html(optionstype); 	
        }
    }
    x.open("GET","getunit.jsp?psrno="+val,true);
    x.send();
}

function calculatedata(val) {}

function gettaxaccounts() {
    $("#serviecGrid").jqxGrid('clear');
    $("#serviecGrid").jqxGrid('addrow', null, {});
    gettaxaccount(1);
}
		
function funcalutax() {
    var tax1=document.getElementById("tax1per").value;
    var tax2=document.getElementById("tax2per").value;
    var tax3=document.getElementById("tax3per").value;
    var typeoftaken=document.getElementById("typeoftaken").value;
    var st=document.getElementById("st").value;
    var producttotal=document.getElementById("netTotaldown").value;
    var tax1val=0;
    var tax2val=0;
    var tax3val=0;
    var finaltax=0;
    
    if(parseInt(typeoftaken)==-1) {
        if(parseFloat(tax1)>0) {
            tax1val=parseFloat(producttotal)*(parseFloat(tax1)/100);
            
            if(parseFloat(tax2)>0) {
                tax2val=parseFloat(tax1val)*(parseFloat(tax2)/100);
            } else {
                tax2val=0;
            }
            
            if(parseFloat(tax3)>0) {
                tax3val=parseFloat(tax2val)*(parseFloat(tax3)/100);
            } else {
                tax3val=0;
            }
            
            finaltax=parseFloat(st)+parseFloat(tax1val)+parseFloat(tax2val)+parseFloat(tax3val);
        }
    } else {
        if(parseFloat(tax1)>0) {
            tax1val=parseFloat(st)*(parseFloat(tax1)/100);
            if(parseFloat(tax2)>0) {
                tax2val=parseFloat(tax1val)*(parseFloat(tax2)/100);
            } else {
                tax2val=0;
            }
            

            if(parseFloat(tax3)>0) {
                tax3val=parseFloat(tax2val)*(parseFloat(tax3)/100);
            } else {
                tax3val=0;
            }
            
            finaltax=parseFloat(st)+parseFloat(tax1val)+parseFloat(tax2val)+parseFloat(tax3val);
        }
    }
    
    funRoundAmt4(tax1val,"taxontax1"); 
    funRoundAmt4(tax2val,"taxontax2");
    funRoundAmt4(tax3val,"taxontax3");
    funRoundAmt4(finaltax,"taxtotal");
}
		
function funRoundAmt4(value,id){
    var res=parseFloat(value).toFixed(4);
    var res1=(res=='NaN'?"0":res);
    document.getElementById(id).value=res1;  
}     
		
function getitemtype(){ 
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            items= x.responseText;
            items=items.split('####');
            var docno=items[0].split(",");
            var type=items[1].split(",");
            var optionstype = '';

            for ( var i = 0; i < type.length; i++) {
                optionstype += '<option value="' + docno[i] + '">' + type[i] + '</option>';
            }
            
            $("select#itemtype").html(optionstype); 	
            
            if($('#hideitemtype').val()!="") {
                $('#itemtype').val($('#hideitemtype').val());   
            }
        }
    }
    x.open("GET","getitem.jsp?",true);
    x.send();
}
		 
function chkcostcode() {
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items= x.responseText.trim();
            if(parseInt(items)>0) {
                document.getElementById("costcheck").value=1;
                $('#hcostcodes').show();
            } else { 
                document.getElementById("costcheck").value=0;
                $('#hcostcodes').hide();
            }
        }
    }
    x.open("GET","<%=contextPath%>/com/Procurement/Purchase/costcodesearch/checkcostcode.jsp?",true);
    x.send();
} 
	     
function cleardata() {
    document.getElementById("itemdocno").value="";
    document.getElementById("itemname").value="";
}

function setgrid() {
    var temppsrno=document.getElementById("temppsrno").value; 
    var unit=document.getElementById("unit").value; 
    var rows1 = $("#serviecGrid").jqxGrid('getrows');
    var aa=0;
    
    for(var i=0;i<rows1.length;i++){
        if(parseInt(rows1[i].prodoc)==parseInt(temppsrno)) {
            if((parseInt(document.getElementById("multimethod").value)==1)) {	
                if(parseInt(rows1[i].unitdocno)==parseInt(unit)) {
                    aa=1;
                    break;
                }
            } else {
                aa=1;
                break;
            }
        } else {
            aa=0;
        } 
    }
			 
    if(parseInt(aa)==1) {
        document.getElementById("errormsg").innerText="You have already select this product";
        document.getElementById("jqxInput1").focus();
        return 0;
    } else {
        document.getElementById("errormsg").innerText="";
    }
    
    var rows = $('#serviecGrid').jqxGrid('getrows');
    var rowlength= rows.length;
    $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "proid", document.getElementById("jqxInput").value);
    $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "proname", document.getElementById("jqxInput1").value);
    $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "brandname", document.getElementById("brand").value);
    $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "qty", document.getElementById("quantity").value);
    $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "unitprice", document.getElementById("uprice").value);  
    $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "total", document.getElementById("totamt").value);
    
    if(parseFloat(document.getElementById("dispers").value)>0) {
        $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "discper", document.getElementById("dispers").value);  
        $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "discount", document.getElementById("dict").value);
        $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "nettotal", document.getElementById("amounts").value);	 
    } else {  	  
        $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1,"discper", 0);  
        $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1,"discount", 0);
        $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "nettotal", document.getElementById("totamt").value);
    }
		     
    if(parseFloat(document.getElementById("taxpers").value)>0) {
        $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "taxper", document.getElementById("taxpers").value);
        $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "taxperamt", document.getElementById("taxamounts").value);
        $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "taxamount", document.getElementById("taxamountstotal").value);	    		 
    } else {
        $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "taxper", 0);
        $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "taxperamt", 0);
        $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "taxamount",  document.getElementById("amounts").value);  
    }
		    
    $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "unitdocno", document.getElementById("unit").value);
    if(document.getElementById("unit").value>0) {
        $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "unit", $("#unit option:selected").text());
    }
    $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "psrno", document.getElementById("temppsrno").value);
    $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "prodoc", document.getElementById("temppsrno").value);
    $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "specid", document.getElementById("tempspecid").value);
    $('#serviecGrid').jqxGrid('setcellvalue', rowlength-1, "productid" ,document.getElementById("jqxInput").value);
    $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "productname", document.getElementById("jqxInput1").value);
		  
    document.getElementById("jqxInput").value ="";
    document.getElementById("jqxInput1").value="";
    document.getElementById("brand").value=""; 
    document.getElementById("quantity").value ="";
    document.getElementById("unit").value ="";
    document.getElementById("dispers").value=""
    document.getElementById("uprice").value="";
    document.getElementById("totamt").value="";
    document.getElementById("amounts").value="";
    document.getElementById("dict").value="";
    document.getElementById("taxpers").value="";
    document.getElementById("taxamounts").value="";
    document.getElementById("taxamountstotal").value="";
    document.getElementById("temppsrno").value="";
    document.getElementById("tempspecid").value="";
    
    $("#serviecGrid").jqxGrid('addrow', null, {});
    document.getElementById("jqxInput1").focus();
}  
		
function calculatedata(val) {
    var quantity=document.getElementById("quantity").value;
    var uprice=document.getElementById("uprice").value;
    var taxpers=document.getElementById("taxpers").value;
    var disper=document.getElementById("dispers").value;
    var discount=document.getElementById("dict").value;
    var totamt=0;
    var taxamounts=0;
    var taxamountstotal=0;
    if(val=="dispers"){discount=0; }
    if(val=="dict"){disper=0; }
    
    if(quantity=="" || quantity==null || quantity==0 ||typeof(width)=="quantity"|| typeof(quantity)=="NaN") {
        quantity=0;
    }
    
    if(uprice=="" || uprice==null || uprice==0 || typeof(uprice)=="undefined"|| typeof(uprice)=="NaN") {
        uprice=0;
    }
    
    if(disper=="" || disper==null || disper==0 || typeof(disper)=="undefined"|| typeof(disper)=="NaN") {
        disper=0;
    }
    
    if(discount=="" || discount==null || discount==0 || typeof(discount)=="undefined"|| typeof(discount)=="NaN") {
        discount=0;
    }
    
    var netamount=0; 
    if(taxpers=="" || taxpers==null || taxpers==0 || typeof(taxpers)=="undefined"|| typeof(taxpers)=="NaN") {
        taxpers=0;
    }
    
    if(parseFloat(quantity)>0 && parseFloat(uprice)>0) {
        totamt=parseFloat(quantity)*parseFloat(uprice);
    }
    
    if(parseFloat(disper)>0 || parseFloat(discount)>0) {
        if(parseFloat(disper)>0) {
            discount=(parseFloat(totamt)*parseFloat(disper))/100;
        } else if(parseFloat(discount)>0) {
            disper=(100/parseFloat(totamt))*parseFloat(discount);
        }
        netamount=parseFloat(totamt)-parseFloat(discount);
    } else {
        disper=0;
        discount=0;
        netamount=totamt;
    }
    
    if(parseFloat(taxpers)>0) {
        taxamounts=parseFloat(netamount)*(parseFloat(taxpers)/100);
        taxamountstotal=parseFloat(netamount)+parseFloat(taxamounts);
    } else {
        taxamountstotal=netamount;
    }

    document.getElementById("totamt").value=(totamt).toFixed(2);
    document.getElementById("dispers").value=parseFloat(disper).toFixed(2);
    document.getElementById("dict").value=parseFloat(discount).toFixed(2);
    document.getElementById("amounts").value=(netamount).toFixed(2);
    document.getElementById("taxamounts").value=(taxamounts).toFixed(2);
    document.getElementById("taxamountstotal").value=(taxamountstotal).toFixed(2);
}  

function reloads() {
    var accdocno = document.getElementById("accdocno").value;    
    var reqmasterdocno = document.getElementById("reqmasterdocno").value;    
    var dates=$('#nipurchaseorderdate').val();    
    var cmbbilltype=document.getElementById("cmbbilltype").value;     	
    var puraccid=document.getElementById("puraccid").value;
    $("#part").load('part.jsp?acno='+accdocno+"&dates="+dates+"&cmbbilltype="+cmbbilltype+"&puraccid="+puraccid);
    $("#pnames").load('name.jsp?acno='+accdocno+"&dates="+dates+"&cmbbilltype="+cmbbilltype+"&puraccid="+puraccid);
}     
		 
</script>            

</head>
<body onLoad="getCurrencyIds();setValues();chkcostcode();getitemtype();">

<div id="mainBG" class="homeContent" data-type="background">
    <form id="purchaseOrder" action="saveActionpurOrders" method="post" autocomplete="off"> 
        <jsp:include page="../../../../header.jsp" />  
        <jsp:include page="multiqty.jsp"></jsp:include>  
        
        <input type="hidden" id="roundmethod">
        <input type="hidden" id="roundvals">
        
        <div class="modern-ui hidden-scrollbar">
            <div id="errormsg"></div>

            <div class="middle-panel">
                <span class="middle-panel-title">Purchase Order Details</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Date</label>
                    <div style="width: 125px;">
                        <div id="nipurchaseorderdate" name="nipurchaseorderdate" value='<s:property value="nipurchaseorderdate"/>'></div>
                    </div>
                    <input type="hidden" name="hidnipurchaseorderdate" id="hidnipurchaseorderdate" value='<s:property value="hidnipurchaseorderdate"/>'>
                    
                    <label class="lbl-right" style="width:80px; margin-left:15px;">Ref No</label>
                    <input type="text" name="refno" id="refno" style="width:125px;" value='<s:property value="refno"/>'>
                    
                    <label class="lbl-right" style="width:80px; margin-left:15px;" id="billname">Bill Type</label>
                    <select id="cmbbilltype" name="cmbbilltype" onchange="gettaxaccounts()" style="width:125px;" value='<s:property value="cmbbilltype"/>'>
                        <option value="1">ST</option>
                        <option value="2">CST</option>
                    </select>
                    <input type="hidden" id="hidcmbbilltype" name="hidcmbbilltype" value='<s:property value="hidcmbbilltype"/>'/>
                    
                    <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
                    <input type="text" name="docno" id="docno" style="width:125px;" tabindex="-1" value='<s:property value="docno"/>' readonly>
                </div>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Curr</label>
                    <select name="cmbcurr" id="cmbcurr" style="width:125px;" value='<s:property value="cmbcurr"/>' onload="getRatevalue(this.value);">
                        <option value="-1">--Select--</option>
                    </select>
                    
                    <label class="lbl-right" style="width:80px; margin-left:15px;">Rate</label>
                    <input type="text" name="currate" id="currate" style="width:125px; text-align:right;" value='<s:property value="currate"/>'>
                </div>
            </div>

            <div class="middle-panel">
                <span class="middle-panel-title">Vendor & Reference</span>
                
                <input type="hidden" name="acctype" id="acctype" value='<s:property value="acctype"/>'>
                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Vendor</label>
                    <div class="input-search-container" style="width: 125px;">
                        <input type="text" name="puraccid" id="puraccid" placeholder="Press F3" value='<s:property value="puraccid"/>' onKeyDown="getaccountdetails(event);">
                        <svg class="magnifier-icon" onclick="$('#puraccid').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    <input type="text" id="puraccname" name="puraccname" value='<s:property value="puraccname"/>' style="flex:1;" readonly>
                    
                    <label class="lbl-right" style="width:80px; margin-left:15px;">Ref Type</label>
                    <select name="reftype" id="reftype" style="width:125px;" value='<s:property value="reftype"/>' onchange="funrefdisslno()">
                        <option value="DIR">DIR</option>
                        <option value="PR">PR</option>
                        <option value="SOR">SOR</option>
                        <option value="RFQ">RFQ</option>
                    </select>
                    
                    <label class="lbl-right" style="width:80px; margin-left:15px;">Ref Search</label>
                    <div class="input-search-container" style="width: 125px;">
                        <input type="text" name="rrefno" id="rrefno" placeholder="Press F3" value='<s:property value="rrefno"/>' onKeyDown="getrefno(event);">
                        <svg class="magnifier-icon" onclick="$('#rrefno').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                </div>

                <div id="hcostcodes" style="display:none; width:100%; margin-top:5px;">
                    <div class="field-row">
                        <label class="lbl-right" style="width:80px;">Group</label>
                        <select id="itemtype" name="itemtype" style="width:125px;" onchange="cleardata()"> 
                            <option></option>   
                        </select>
                        
                        <label class="lbl-right" style="width:80px; margin-left:15px;">Job No</label>
                        <div class="input-search-container" style="width:125px;">
                            <input type="text" id="itemdocno" name="itemdocno" placeholder="Press F3" onkeydown="getitem(event);" value='<s:property value="itemdocno"/>'>
                            <svg class="magnifier-icon" onclick="$('#itemdocno').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                        </div>
                        <input type="text" id="itemname" name="itemname" style="flex:1; margin-left:8px;" value='<s:property value="itemname"/>' readonly>
                    </div>
                </div>
            </div>

            <div class="middle-panel">
                <span class="middle-panel-title">Terms & Description</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Del Date</label>
                    <div style="width: 125px;">
                        <div id="deliverydate" name="deliverydate" value='<s:property value="deliverydate"/>'></div>
                    </div>
                    <input type="hidden" name="hiddeliverydate" id="hiddeliverydate" value='<s:property value="hiddeliverydate"/>'>
                    
                    <label class="lbl-right" style="width:80px; margin-left:15px;">Del Terms</label>
                    <input type="text" name="delterms" id="delterms" value='<s:property value="delterms"/>' style="flex:1;">
                </div>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Pay Terms</label>
                    <input type="text" name="payterms" id="payterms" value='<s:property value="payterms"/>' style="flex:1;">
                </div>
                
                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:80px;">Description</label>
                    <input type="text" name="purdesc" id="purdesc" value='<s:property value="purdesc"/>' style="flex:1;">
                    <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();" style="margin-left:15px;">Value Change</button>
                </div>
            </div>

            <div class="middle-panel" id="psearch">
                <span class="middle-panel-title">Item Details Entry</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Product ID</label>
                    <div id="part" style="width:125px;"><jsp:include page="part.jsp"></jsp:include></div>
                    
                    <label class="lbl-right" style="width:80px; margin-left:15px;">Product Name</label>
                    <div id="pnames" style="flex:1;"><jsp:include page="name.jsp"></jsp:include></div>
                    
                    <label class="lbl-right" style="width:60px; margin-left:15px;">Brand</label>
                    <input type="text" id="brand" style="width:100px;">
                    <input type="hidden" id="collqty">
                    
                    <label class="lbl-right" style="width:40px; margin-left:15px;">Unit</label>
                    <select id="unit" style="width:80px;"></select>
                    <input type="hidden" id="prddesc">
                </div>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Qty</label>
                    <input type="hidden" id="loads" class="myButton" value="Load Data" onclick="loaddatass()">
                    <input type="text" id="quantity" onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1(event);" onchange="calculatedata(this.id);" style="width:125px; text-align:right;">
                    
                    <label class="lbl-right" style="width:80px; margin-left:15px;">Unit Price</label>
                    <input type="text" id="uprice" onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1(event);" onchange="calculatedata(this.id);" style="width:125px; text-align:right;">
                    <input type="hidden" id="extrafocs" onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1(event);">
                    
                    <label class="lbl-right" style="width:60px; margin-left:15px;">Total</label>
                    <input type="text" id="totamt" tabindex="-1" style="width:100px; text-align:right;" readonly>
                    
                    <label class="lbl-right" style="width:70px; margin-left:15px;">Discount %</label>
                    <input type="text" id="dispers" onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1(event);" onchange="calculatedata(this.id);" style="width:70px; text-align:right;">
                    
                    <label class="lbl-right" style="width:70px; margin-left:15px;">Discount</label>
                    <input type="text" id="dict" onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1(event);" onchange="calculatedata(this.id);" style="width:70px; text-align:right;">
                </div>
                
                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:80px;">Net Amount</label>
                    <input type="text" id="amounts" tabindex="-1" style="width:125px; text-align:right;" readonly>
                    
                    <label class="lbl-right" style="width:80px; margin-left:15px;">Tax %</label>
                    <input type="text" id="taxpers" tabindex="-1" style="width:125px; text-align:right;" readonly>
                    
                    <label class="lbl-right" style="width:60px; margin-left:15px;">Tax Amt</label>
                    <input type="text" id="taxamounts" tabindex="-1" onkeypress="javascript:return isNumber1(event);" style="width:100px; text-align:right;" readonly>
                    
                    <label class="lbl-right" style="width:70px; margin-left:15px;">Net Total</label>
                    <input type="text" id="taxamountstotal" tabindex="-1" onkeypress="javascript:return isNumber1(event);" style="width:100px; text-align:right;" readonly>
                    
                    <input type="hidden" id="cleardata">
                    <input type="button" id="setbtn" class="myButton-success" onclick="setgrid()" value="ADD" style="margin-left:auto;">
                    <input type="hidden" id="det" class="myButton" value="Detail Stock Enquiry" onclick="detailsstock()">
                </div>
            </div>

            <div style="display:none;">
                <input type="hidden" name="gridtext" id="gridtext" value='<s:property value="gridtext"/>'/>   
                <input type="hidden" name="gridtext1" id="gridtext1" value='<s:property value="gridtext1"/>'/>   
            </div>

            <div class="middle-panel">
                <span class="middle-panel-title">Purchase Records</span>
                <div id="sevdesc" class="grid-container" style="border: none;">
                    <jsp:include page="serviecgrid.jsp"></jsp:include>
                </div>
            </div>

            <div class="middle-panel">
                <span class="middle-panel-title">Summary</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Product</label>
                    <input type="text" name="productTotal" readonly="readonly" id="productTotal" value='<s:property value="productTotal"/>' style="width:125px; text-align:right;">
                    
                    <label class="lbl-right" style="width:80px; margin-left:15px;">Discount</label>
                    <input type="checkbox" value="0" id="chkdiscount" name="chkdiscount" onchange="fundisable()" onclick="$(this).attr('value', this.checked ? 1 : 0)" style="margin-right:15px;">
                    
                    <label class="lbl-right" style="width:80px;">Discount %</label>
                    <input type="text" name="descPercentage" id="descPercentage" value='<s:property value="descPercentage"/>' onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);" style="width:80px; text-align:right;">
                    
                    <button type="button" id="btnCalculate" class="myButton" title="Calculate" onclick="funcalcu();" style="margin-left: 5px; height: 24px; padding: 0 8px;">
                        <img alt="Calculate" src="<%=contextPath%>/icons/calculate_new.png" style="width:14px; height:14px; vertical-align:middle; margin-right:4px;"> Calc
                    </button>
                    
                    <label class="lbl-right" style="width:100px; margin-left:15px;">Discount Value</label>
                    <input type="text" name="descountVal" id="descountVal" value='<s:property value="descountVal"/>' onblur="funvalcalcu();" onkeypress="javascript:return isNumber (event);" style="width:100px; text-align:right;">
                    <input type="hidden" name="prddiscount" id="prddiscount" value='<s:property value="prddiscount"/>' onkeypress="javascript:return isNumber (event);">
                </div>
                
                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:80px;">Round off</label>
                    <input type="text" name="roundOf" id="roundOf" value='<s:property value="roundOf"/>' onblur="roundval();funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);" style="width:125px; text-align:right;">
                    
                    <label class="lbl-right" style="width:100px; margin-left:15px;">Net Total</label>
                    <input type="text" name="netTotaldown" readonly="readonly" id="netTotaldown" value='<s:property value="netTotaldown"/>' onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);" style="width:125px; text-align:right; font-weight:bold;">
                </div>
            </div>

            <div class="middle-panel">
                <span class="middle-panel-title">Service</span>
                <div id="descdetail" class="grid-container" style="border: none;">
                    <jsp:include page="descgridDetails.jsp"></jsp:include>
                </div>
            </div>

            <div class="middle-panel">
                <div class="field-row" style="margin-bottom:0; justify-content: flex-end;">
                    <label class="lbl-right" style="font-size: 14px;">Order Value :</label>
                    <input type="text" id="orderValue" readonly="readonly" tabindex="-1" name="orderValue" style="width:150px; text-align:right; font-size:14px; font-weight:bold; color:#0b45a2;" value='<s:property value="orderValue"/>'/>
                </div>
            </div>

            <div style="display: flex; gap: 15px; align-items: flex-start;">
                
                <!-- LEFT PANEL : Shipping Address -->
                <div class="middle-panel" style="width: 45%; flex-shrink: 0; margin-bottom: 0;">
                    <span class="middle-panel-title">Shipping Address</span>
                    
                    <div class="field-row">
                        <label class="lbl-right" style="width:100px;">Name</label>
                        <div class="input-search-container" style="flex:1;">
                            <input type="text" id="shipto" name="shipto" placeholder="Press F3" value='<s:property value="shipto"/>' onkeydown="getshipdetails(event);">
                            <svg class="magnifier-icon" onclick="$('#shipto').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                        </div>
                    </div>
                    
                    <div class="field-row">
                        <label class="lbl-right" style="width:100px;">Address</label>
                        <input type="text" id="shipaddress" name="shipaddress" style="flex:1;" value='<s:property value="shipaddress"/>'>
                    </div>
                    
                    <div class="field-row">
                        <label class="lbl-right" style="width:100px;">Contact Person</label>
                        <input type="text" id="contactperson" name="contactperson" style="flex:1;" value='<s:property value="contactperson"/>'>
                    </div>
                    
                    <div class="field-row">
                        <label class="lbl-right" style="width:100px;">Telephone</label>
                        <input type="text" id="shiptelephone" name="shiptelephone" style="width:120px;" value='<s:property value="shiptelephone"/>'>
                        
                        <label class="lbl-right" style="width:60px; margin-left:auto;">MOB</label>
                        <input type="text" id="shipmob" name="shipmob" style="width:120px;" value='<s:property value="shipmob"/>'>
                    </div>
                    
                    <div class="field-row" style="margin-bottom:0;">
                        <label class="lbl-right" style="width:100px;">Email</label>
                        <input type="text" id="shipemail" name="shipemail" style="width:120px;" value='<s:property value="shipemail"/>'>
                        
                        <label class="lbl-right" style="width:60px; margin-left:auto;">FAX</label>
                        <input type="text" id="shipfax" style="width:120px;" name="shipfax" value='<s:property value="shipfax"/>'>
                    </div>
                </div>
                
                <!-- RIGHT PANEL : Shipping Details Grid -->
                <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
                    <span class="middle-panel-title">Shipping Details</span>
                    <div id="shipdetdiv" class="grid-container" style="border: none; height: 100%;">
                        <jsp:include page="shipdetailsGrid.jsp"></jsp:include>
                    </div> 
                </div>
                
            </div>

            <div class="middle-panel">
                <span class="middle-panel-title">Terms and Conditions</span>
                <div id="termsDiv" class="grid-container" style="border: none;">
                    <jsp:include page="termsGrid.jsp"></jsp:include>
                </div>
            </div>

            <div class="middle-panel" id="taxsss">
                <span class="middle-panel-title">Tax Details</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Total Tax</label>
                    <input type="text" id="st" name="st" style="width:150px; text-align:right;" value='<s:property value="st"/>'>
                    
                    <button type="button" class="myButton" id="process1" title="Process" onclick="funcalutax();" style="margin-left: 5px; height: 24px; padding: 0 8px;">
                        <img alt="process" src="<%=contextPath%>/icons/process2.png" style="width:14px; height:14px; vertical-align:middle; margin-right:4px;"> Calc Tax
                    </button>
                    
                    <label class="lbl-right" style="width:100px; margin-left:15px;" id="labeltax1"></label>
                    <input type="text" id="taxontax1" name="taxontax1" style="width:125px; text-align:right;" value='<s:property value="taxontax1"/>'>
                    
                    <label class="lbl-right" style="width:100px; margin-left:15px;" id="labeltax2"></label>
                    <input type="text" id="taxontax2" name="taxontax2" style="width:125px; text-align:right;" value='<s:property value="taxontax2"/>'>
                </div>
                
                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:100px;" id="labeltax3"></label>
                    <input type="text" id="taxontax3" name="taxontax3" style="width:150px; text-align:right;" value='<s:property value="taxontax3"/>'>
                    
                    <label class="lbl-right" style="width:150px; margin-left:auto;">Net Tax Total</label>
                    <input type="text" id="taxtotal" name="taxtotal" style="width:150px; text-align:right; font-weight:bold;" value='<s:property value="taxtotal"/>'>
                </div>
            </div>

            <!-- Hidden Logic Fields -->
            <div style="display:none;">
                <input type="hidden" id="chkdiscountval" name="chkdiscountval" value='<s:property value="chkdiscountval"/>'/>      
                <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'/>  
                <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
                <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>   
                <input type="hidden" id="nettotal" name="nettotal" value='<s:property value="nettotal"/>'/>   
                <input type="hidden" id="descgridlenght" name="descgridlenght" value='<s:property value="descgridlenght"/>'/>   
                <input type="hidden" id="serviecGridlength" name="serviecGridlength" value='<s:property value="serviecGridlength"/>'/>    
                <input type="hidden" id="cmbcurrval" name="cmbcurrval" value='<s:property value="cmbcurrval"/>'/>    
                <input type="hidden" id="acctypeval" name="acctypeval" value='<s:property value="acctypeval"/>'/>  
                <input type="hidden" id="accdocno" name="accdocno" value='<s:property value="accdocno"/>'/>    
                <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
                <input type="hidden" id="reftypeval" name="reftypeval" value='<s:property value="reftypeval"/>'/> 
                <input type="hidden" id="reqmasterdocno" name="reqmasterdocno" value='<s:property value="reqmasterdocno"/>'/>
                <input type="hidden" id="producttype" name="producttype" value='<s:property value="producttype"/>'/>
                <input type="hidden" id="termsgridlength" name="termsgridlength" value='<s:property value="termsgridlength"/>'/>
                <input type="hidden" id="editdata" name="editdata" value='<s:property value="editdata"/>'/>
                <input type="hidden" id="shipdocno" name="shipdocno" value='<s:property value="shipdocno"/>'/>
                <input type="hidden" id="shipdatagridlenght" name="shipdatagridlenght" value='<s:property value="shipdatagridlenght"/>'/>
                <input type="hidden" id="costtr_no" name="costtr_no" value='<s:property value="costtr_no"/>'/>  
                <input type="hidden" id="costcheck" name="costcheck" value='<s:property value="costcheck"/>'/> 
                <input type="hidden" id="hideitemtype" name="hideitemtype" value='<s:property value="hideitemtype"/>'/> 
                <input type="hidden" id="hidetype" name="hidetype" value='<s:property value="hidetype"/>'/>
                <input type="hidden" id="puchasechk"/> 
                <input type="hidden" id="typeoftaken">
                <input type="hidden" id="tax1per">
                <input type="hidden" id="tax2per">
                <input type="hidden" id="tax3per">
                <input type="hidden" id="temppsrno">  
                <input type="hidden" id="tempspecid"> 
                <input type="hidden" id="tempunitdocno">   
            </div>
            
        </div>
    </form>

    <!-- Search Windows Outside of Form Content to prevent scrolling issues -->
    <div id="searchwindow">
       <div></div><div></div>
    </div>
    <div id="refnosearchwindow">
       <div></div><div></div>
    </div>
    <div id="accountSearchwindow">
       <div></div><div></div>
    </div>
    <div id="sidesearchwndow">
       <div></div><div></div>
    </div>
    <div id="importwindow">
       <div></div><div></div>
    </div>
    <div id="searchwndow">
       <div></div><div></div>
    </div>
    <div id="tremwndow">
       <div></div><div></div>
    </div>
    <div id="lastpurchasewindow">
       <div></div><div></div>
    </div>

</div>
</body>
</html>