<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<% String contextPath=request.getContextPath();%>
<html>
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
.ff { display: none; }
</style>

<script type="text/javascript">
$(document).ready(function () { 
    $('#FixedDiv').hide();
    $('#btnvaluechange').hide();
    
    /* Formatted jqxDateTimeInput heights to match modern UI 24px */
    $("#masterdate, #deliverydate, #invdate, #expdate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    
    /* force internal alignment AFTER render */
    setTimeout(function () {
        $("#masterdate, #deliverydate, #invdate, #expdate").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#masterdate, #deliverydate, #invdate, #expdate").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);
    
    $('#lastpurchasewindow').jqxWindow({ width: '50%', height: '32%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Search' ,position: { x: 500, y: 120 }, keyboardCloseKey: 27, theme: 'energyblue'});
	$('#lastpurchasewindow').jqxWindow('close');
	
    $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27, theme: 'energyblue'});
	$('#accountSearchwindow').jqxWindow('close');
	
    $('#searchwndow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Product Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27, theme: 'energyblue'});
	$('#searchwndow').jqxWindow('close');  
	 	
    $('#searchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27, theme: 'energyblue'});
	$('#searchwindow').jqxWindow('close');
		    
    $('#expencewindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Search ' , position : { x : 420, y : 87 }, keyboardCloseKey: 27, theme: 'energyblue'});
	$('#expencewindow').jqxWindow('close');
	     
    $('#sidesearchwndow').jqxWindow({ width: '55%', height: '95%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Product Search ' , position: { x: 600, y: 0 }, keyboardCloseKey: 27, theme: 'energyblue'});
	$('#sidesearchwndow').jqxWindow('close');   
	     
    $('#refnosearchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27, theme: 'energyblue'});
	$('#refnosearchwindow').jqxWindow('close'); 
	 
    $('#locationwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Location Search' ,position: { x: 200, y: 70 }, keyboardCloseKey: 27, theme: 'energyblue'});
	$('#locationwindow').jqxWindow('close');  
		   
    $('#importwindow').jqxWindow({ width: '30%', height: '24.4%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Import Options' , position: { x: 500, y: 200 }, theme: 'energyblue', showCloseButton: false});
	$('#importwindow').jqxWindow('close');   
		     
    $('#calculationwindow').jqxWindow({ width: '80%', height: '60%',  maxHeight: '80%' ,maxWidth: '80%'  , title: 'Calculation ' ,animationType: 'slide',position: { x: 150, y: 50 }, keyboardCloseKey: 27, theme: 'energyblue'});
	$('#calculationwindow').jqxWindow('close');
		     
    if($('#reftypeval').val()=="GRN") {
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
            if(document.getElementById('reftype').value=="GRN") {
                $('#refnosearchwindow').jqxWindow('open');
                refsearchContent('refnosearch.jsp?'); 
            } else if(document.getElementById('reftype').value=="PO") {	 
                $('#refnosearchwindow').jqxWindow('open');
                refsearchContent('purchaseorderrefsearch.jsp?');
            }
        }
    }); 
    
    $('#txtlocation').dblclick(function(){
        if($("#mode").val() == "A" || $("#mode").val() == "E") {
            $('#locationwindow').jqxWindow('open');
            locationsearchContent('searchlocation.jsp?'); 
        }
    }); 
		   
    $('#puraccid').dblclick(function(){
        if($('#mode').val()!= "view") {
            $('#accountSearchwindow').jqxWindow('open');
            accountSearchContent('accountsDetailsSearch.jsp?');
        }
    });   
    
    $("#btnShowData").click(function(){
        if($('#mode').val()== "view") {
            $('#calculationwindow').jqxWindow('open');
            calculationsearchContent('calcutionmaster.jsp?');
        }
    });   
    
    $('#itemdocno').dblclick(function(){
        if($("#mode").val() == "A" || $("#mode").val() == "E") {
            $('#searchwindow').jqxWindow('open');
            if(document.getElementById("itemtype").value=="1") {
                refsearchContent1('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costCodeSearchGrid.jsp?docno='+document.getElementById("itemtype").value); 	
            } else if(document.getElementById("itemtype").value=="6") {
                refsearchContent1('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/fleetGrid.jsp?'); 	
            } else {
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
        } else if(document.getElementById("itemtype").value=="6") {
            refsearchContent1('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/fleetGrid.jsp?'); 	
        } else {
            refsearchContent1('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costunitsearch.jsp?docno='+document.getElementById("itemtype").value); 	
        }
 	}
}

function refsearchContent1(url) {
    $.get(url).done(function (data) {
        $('#searchwindow').jqxWindow('setContent', data);
 	}); 
}

function funcheckaccinvendor() {
	if(document.getElementById("puraccid").value=="") {
        document.getElementById("errormsg").innerText="Search Vendor";  
        document.getElementById("puraccid").focus();
        return 0;
	}
}

function expenceSearchContent(url) {
    $('#expencewindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#expencewindow').jqxWindow('setContent', data);
        $('#expencewindow').jqxWindow('bringToFront');
    }); 
} 

function getloc(event){
    var x= event.keyCode;
    if(x==114){
        $('#locationwindow').jqxWindow('open');
        locationsearchContent('searchlocation.jsp?');   
    }
}  

function priceSearchContent(url) {
    $('#lastpurchasewindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#lastpurchasewindow').jqxWindow('setContent', data);
	}); 
}  

function getrefno(event) {
    var x= event.keyCode;
    if(x==114){
        if(document.getElementById('reftype').value=="GRN") {	 
            $('#refnosearchwindow').jqxWindow('open');
            refsearchContent('refnosearch.jsp?');
        } else if(document.getElementById('reftype').value=="PO") {	 
            $('#refnosearchwindow').jqxWindow('open');
            refsearchContent('purchaseorderrefsearch.jsp?');
        }
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

function locationsearchContent(url) {
    $.get(url).done(function (data) {
        $('#locationwindow').jqxWindow('setContent', data);
    }); 
}

function calculationsearchContent(url) {
    $.get(url).done(function (data) {
        $('#calculationwindow').jqxWindow('setContent', data);
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

function funReset(){
	//$('#purchaseInv')[0].reset(); 
}

function funReadOnly(){
	$('#purchaseInv input').attr('readonly', true );
	$('#purchaseInv select').attr('disabled', true );
	$('#masterdate').jqxDateTimeInput({ disabled: true});
	$('#invdate').jqxDateTimeInput({ disabled: true});
	$('#deliverydate').jqxDateTimeInput({ disabled: true});
    $("#descdetailsGrid").jqxGrid({ disabled: true});
    $("#serviecGrid").jqxGrid({ disabled: true});
    $('#rrefno').attr('disabled', true);
    $('#descPercentage').attr('disabled', true);
    $('#descountVal').attr('disabled', true);
    $('#chkdiscount').attr('disabled', true);	 
    $('#producttype').val(0);	 
    $('#process1').attr('disabled', true);
    $("#purchexpgrid").jqxGrid({ disabled: true});
    $('#btnCalculate').attr('disabled', true);
    $('#cmbcurr').attr('disabled', true);		
    $('#btnvaluechange').hide();
    $('#acctype').attr('disabled', true);
	 
    if(document.getElementById('reftype').value=="DIR") {
        chkfoc(); 
    } else {
        $('#serviecGrid').jqxGrid('hidecolumn', 'foc');
    }
}

function funRemoveReadOnly(){
	chklastpurchase();
	reloads();
	document.getElementById("editdata").value="";
	$('#FixedDiv').hide();
	$('#purchaseInv input').attr('readonly', false );
	$('#serviecGrid').jqxGrid('setcolumnproperty', 'discount',  "editable", true);
	$('#serviecGrid').jqxGrid('setcolumnproperty', 'discper',  "editable", true);
    chkmultiqty();
	getround();
	$('#purchaseInv select').attr('disabled', false );
	$('#totamt').attr('readonly', true );
	$('#taxpers').attr('readonly', true );
	$('#taxamounts').attr('readonly', true );
	$('#taxamountstotal').attr('readonly', true );
	$('#amounts').attr('readonly', true );  
	gettaxaccount(1);	
    $('#st').attr('readonly', true );
    $('#taxontax1').attr('readonly', true );
    $('#taxontax2').attr('readonly', true );
    $('#taxontax3').attr('readonly', true );
    $('#taxtotal').attr('readonly', true );
    $('#process1').attr('disabled', false);

    $('#currate').attr('readonly', true);
    $('#puraccid').attr('readonly', true);
    $('#puraccname').attr('readonly', true);
    $('#rrefno').attr('disabled', true);
    $('#rrefno').attr('readonly', true);
    $('#btnvaluechange').hide();
    $('#txtlocation').attr('readonly', true);
    $('#producttype').val(0);	 
		 
    $('#invdate').jqxDateTimeInput({ disabled: false});
	$('#masterdate').jqxDateTimeInput({ disabled: false});
	$('#deliverydate').jqxDateTimeInput({ disabled: false});

    $('#cmbcurr').attr('disabled', false);
	$('#acctype').attr('disabled', false);
	 
	$('#docno').attr('readonly', true);
	$("#descdetailsGrid").jqxGrid({ disabled: false});
	$("#serviecGrid").jqxGrid({ disabled: false});
    $("#purchexpgrid").jqxGrid({ disabled: false});
	 
    $('#descPercentage').attr('disabled', true);
	$('#descountVal').attr('disabled', true);
	$('#docno').attr('readonly', true);
	$('#orderValue').attr('readonly', true);
	$('#productTotal').attr('readonly', true);
	$('#netTotaldown').attr('readonly', true);
	 
	if ($("#mode").val() == "A") {
        $('#chkdiscount').attr('disabled', false);
		$('#masterdate').val(new Date());
		$('#deliverydate').val(new Date());
		$('#invdate').val(new Date());
		
        $("#descdetailsGrid").jqxGrid('clear');
        $("#descdetailsGrid").jqxGrid('addrow', null, {});
        $("#serviecGrid").jqxGrid('clear');
        $("#serviecGrid").jqxGrid('addrow', null, {});
        $("#purchexpgrid").jqxGrid('clear');
        $("#purchexpgrid").jqxGrid('addrow', null, {});
			    
        if(document.getElementById('reftype').value=="DIR") {
            chkfoc(); 
        } else {
            $('#serviecGrid').jqxGrid('hidecolumn', 'foc');
        }
    }
	
  	if ($("#mode").val() == "E") {
		$('#btnvaluechange').show();
  		$("#descdetailsGrid").jqxGrid({ disabled: true});
		$("#serviecGrid").jqxGrid({ disabled: true});
        $('#btnCalculate').attr('disabled', true);
		$("#purchexpgrid").jqxGrid({ disabled: true});
	}  
  
  	$('#serviecGrid').jqxGrid('hidecolumn', 'cost_price');  
	getCurrencyIds();
    chkcostcode();
	 
    $('#itemdocno').attr('readonly', true);
    $('#itemname').attr('readonly', true);
}

function funFocus(){
   	$('#masterdate').jqxDateTimeInput('focus'); 	    		
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

function funNotify(){	
	var purid= document.getElementById("puraccid").value;
	if(purid=="") {
        document.getElementById("errormsg").innerText=" Select An Account";
        document.getElementById("puraccid").focus();
        return 0;
	} else {
        document.getElementById("errormsg").innerText="";
	}
	   
    if(document.getElementById("txtlocation").value=="") {
        document.getElementById("errormsg").innerText="Search Location";  
        document.getElementById("txtlocation").focus();
        return 0;
    } else {
        document.getElementById("errormsg").innerText="";
	}
	   
    if(document.getElementById("invno").value=="") {
        document.getElementById("errormsg").innerText="Enter Invno";  
        document.getElementById("invno").focus();
        return 0;
    } else {
        document.getElementById("errormsg").innerText="";
	}
	   
    if(document.getElementById('reftype').value=="DIR") {
        // do nothing
    } else {
        if(document.getElementById("rrefno").value=="") {
            document.getElementById("errormsg").innerText="Search Goods Receipt Note";  
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
            +" :: "+rows[i].checktype+" :: "+rows[i].specid+" :: "+rows[i].discper+" :: "+rows[i].stockid+" :: "+rows[i].oldqty+" :: "+rows[i].foc
            +" :: "+rows[i].orderdiscper+" :: "+rows[i].orderamount+"::"+rows[i].taxper+"::"+rows[i].taxperamt+"::"+rows[i].taxamount+"::"+rows[i].batch_no+"::"
            +$('#serviecGrid').jqxGrid('getcelltext', i, "exp_date")+"::"+rows[i].taxdocno+"::"+"0000"+"::"); 
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
	   
    var rows = $("#purchexpgrid").jqxGrid('getrows');
    $('#expgridlength').val(rows.length);
    for(var i=0 ; i < rows.length ; i++){
        newTextBox = $(document.createElement("input"))
            .attr("type", "dil")
            .attr("id", "exptest"+i)
            .attr("name", "exptest"+i)
            .attr("hidden", "true"); 
        newTextBox.val(rows[i].srno+"::"+rows[i].qty2+" :: "+rows[i].descsrno+" :: "
            +rows[i].unitprice2+" :: "+rows[i].total2+" :: "+rows[i].discount2+" :: "+rows[i].nettotal2+" :: "+rows[i].accountdono+" :: ");
        newTextBox.appendTo('form');
    }   
	   
    if ($("#mode").val() == "E") {
        if($('#reftypeval').val()=="GRN") {
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
        $("#purchexpgrid").jqxGrid({ disabled: false});	 
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
            }
            document.getElementById("editdata").value="Editvalue";
            if(document.getElementById('reftype').value=="DIR") {
                $('#rrefno').attr('disabled', true);
                $('#rrefno').attr('readonly', true);
            } else {
                $('#rrefno').attr('disabled', false);
                $('#rrefno').attr('readonly', true);
            }
            $("#purchexpgrid").jqxGrid({ disabled: false});
            $("#descdetailsGrid").jqxGrid({ disabled: false});
            $("#serviecGrid").jqxGrid({ disabled: false});
            $("#purchexpgrid").jqxGrid('addrow', null, {});
            $("#descdetailsGrid").jqxGrid('addrow', null, {});
            $("#serviecGrid").jqxGrid('addrow', null, {});
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
    if($('#hidcmbbilltype').val()!="") {
        $('#cmbbilltype').val($('#hidcmbbilltype').val());   
    }
    if($('#reftypeval').val()!="") {
        $('#reftype').val($('#reftypeval').val());
    }
    if($('#reftypeval').val()=="GRN") {
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

function setValues() {
    if($('#hidmasterdate').val()){
        $("#masterdate").jqxDateTimeInput('val', $('#hidmasterdate').val());
    }
    if($('#hiddeliverydate').val()){
        $("#deliverydate").jqxDateTimeInput('val', $('#hiddeliverydate').val());
    }
    if($('#hidinvdate').val()){
        $("#invdate").jqxDateTimeInput('val', $('#hidinvdate').val());
    }
    
    var dis=document.getElementById("masterdoc_no").value;
    if(dis>0) {     
        combochange();
        funchkforedit();	
        var indexval1 = document.getElementById("masterdoc_no").value;   
        $("#descdetail").load("descgridDetails.jsp?purdoc="+indexval1); 
        $("#expDiv").load("purchaseexpGrid.jsp?masterdoc="+indexval1);
        var reftypeval = document.getElementById("reftypeval").value;  
        var reqmasterdocno = document.getElementById("reqmasterdocno").value;  
        $("#sevdesc").load("serviecgrid.jsp?purdoc="+indexval1+"&reftype="+reftypeval+"&reqmasterdocno="+reqmasterdocno);
        $('#FixedDiv').show(); 
    } 

    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    } 
    document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
    gettaxaccount(1);
} 

function funPrintBtn(){
    if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
        var url=document.URL;
        var reurl=url.split("saveActionpurInv");
        $("#docno").prop("disabled", false);                
        var dtype=$('#formdetailcode').val();
        var brhid=<%=session.getAttribute("BRANCHID").toString()%>;
        var win= window.open(reurl[0]+"printpurchase?docno="+document.getElementById("masterdoc_no").value+"&dtype="+dtype+"&brhid="+brhid,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
        win.focus();
    } else {
        $.messager.alert('Message','Select a Document....!','warning');
        return false;
    }
}

$(function(){
    $('#purchaseInv').validate({
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
	var productTotal=document.getElementById('productTotal').value;
	var descPercentage=document.getElementById('descPercentage').value;
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
	 
    var productTotal=document.getElementById('productTotal').value;
    var descPercentage=document.getElementById('descPercentage').value;
    var descvalue=parseFloat(productTotal)*(parseFloat(descPercentage)/100);
    var netval=parseFloat(productTotal)-parseFloat(descvalue);
    
    var roundOf=document.getElementById('roundOf').value;
    if(roundOf!="" ||roundOf==null || typeof(roundOf)=="undefiend") {
        netval=parseFloat(netval)+parseFloat(roundOf);
    }
 
    funRoundAmt(descvalue,"descountVal");
    funRoundAmt(netval,"netTotaldown");
    
    var ordertotal="0";
    var nettotalval="0";
    var exptotalval="0";
        
    if(document.getElementById("nettotal").value!="" && !(document.getElementById("nettotal").value==null) && !(document.getElementById("nettotal").value=="undefiend")) {
        nettotalval=parseFloat(document.getElementById("nettotal").value);
    }
    if(document.getElementById("expencenettotal").value!="" && !(document.getElementById("expencenettotal").value==null) && !(document.getElementById("expencenettotal").value=="undefiend")) {
        exptotalval=parseFloat(document.getElementById("expencenettotal").value);
    }
    ordertotal=parseFloat(nettotalval)+parseFloat(exptotalval)+parseFloat(document.getElementById("netTotaldown").value);
    funRoundAmt(ordertotal,"orderValue");
}
	
function funvalcalcu() {
	document.getElementById('prddiscount').value="";
	$('#serviecGrid').jqxGrid('setcolumnproperty', 'discount',  "editable", false);
	var productTotal=document.getElementById('productTotal').value;
	var descountVal=document.getElementById('descountVal').value;
	var descper=(100/parseFloat(productTotal))*parseFloat(descountVal);
	var netval=parseFloat(productTotal)-parseFloat(descountVal);
	
	funRoundAmt(descper,"descPercentage");
	funRoundAmt(netval,"netTotaldown");
	funcalcu();
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

    var summaryData= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true);
    var netTotaldown=summaryData.sum.replace(/,/g,'');
    var roundOf=document.getElementById('roundOf').value;
 
    if(roundOf!="") {	 
        var	netval=parseFloat(netTotaldown)+parseFloat(roundOf);
        funRoundAmt(netval,"netTotaldown"); 
		
        var ordertotal="0";
        var nettotalval="0";
        var exptotalval="0";
        
        if(document.getElementById("nettotal").value!="" && !(document.getElementById("nettotal").value==null) && !(document.getElementById("nettotal").value=="undefiend")) {
            nettotalval=parseFloat(document.getElementById("nettotal").value);
        }
        if(document.getElementById("expencenettotal").value!="" && !(document.getElementById("expencenettotal").value==null) && !(document.getElementById("expencenettotal").value=="undefiend")) {
            exptotalval=parseFloat(document.getElementById("expencenettotal").value);
        }
        ordertotal=parseFloat(nettotalval)+parseFloat(exptotalval)+parseFloat(document.getElementById("netTotaldown").value);
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
        chkfoc();
    } else {
        $('#rrefno').attr('disabled', false);
        $('#rrefno').attr('readonly', true);
        document.getElementById("rrefno").value="";
        document.getElementById("reqmasterdocno").value="";
        $("#serviecGrid").jqxGrid('clear');
        $("#serviecGrid").jqxGrid('addrow', null, {});
        $('#serviecGrid').jqxGrid('hidecolumn', 'foc');
    }
}
 
function removemsg() {
    document.getElementById("errormsg").innerText="";
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
    x.open("GET","gettaxaccount.jsp?date="+document.getElementById("masterdate").value+"&cmbbilltype="+document.getElementById("cmbbilltype").value,true);
    x.send();
} 
	
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
        }
    }
			
    funRoundAmt4(tax1val,"taxontax1"); 
    funRoundAmt4(tax2val,"taxontax2");
    funRoundAmt4(tax3val,"taxontax3");
    
    finaltax=parseFloat(st)+parseFloat(tax1val)+parseFloat(tax2val)+parseFloat(tax3val);
    funRoundAmt4(finaltax,"taxtotal");
}
	
function funRoundAmt4(value,id){
    var res=parseFloat(value).toFixed(4);
    var res1=(res=='NaN'?"0":res);
    document.getElementById(id).value=res1;  
} 

function reloads() {
    var dates=$('#masterdate').val();
    var cmbbilltype=document.getElementById("cmbbilltype").value;
    var puraccid=document.getElementById("puraccid").value;
    $("#part").load('part.jsp?dates='+dates+"&cmbbilltype="+cmbbilltype+"&puraccid="+puraccid);
    $("#pnames").load('name.jsp?dates='+dates+"&cmbbilltype="+cmbbilltype+"&puraccid="+puraccid);
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
        } else{
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
    $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "foc", document.getElementById("focs").value);
    $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "unitdocno", document.getElementById("unit").value);
    $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "unitprice", document.getElementById("uprice").value);  
    $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "total", document.getElementById("totamt").value);
    if(parseFloat(document.getElementById("dispers").value)>0){
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
		     
    if(document.getElementById("unit").value>0) {
        $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "unit", $("#unit option:selected").text());
    }
    $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "psrno", document.getElementById("temppsrno").value);
    $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "prodoc", document.getElementById("temppsrno").value);
    $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "specid", document.getElementById("tempspecid").value);
    $('#serviecGrid').jqxGrid('setcellvalue', rowlength-1, "productid" ,document.getElementById("jqxInput").value);
    $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "productname", document.getElementById("jqxInput1").value);
    $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "qty", document.getElementById("quantity").value);

    document.getElementById("jqxInput").value ="";
    document.getElementById("jqxInput1").value="";
    document.getElementById("brand").value=""; 
    document.getElementById("collqty").value ="";
    document.getElementById("quantity").value ="";
    document.getElementById("unit").value ="";
    document.getElementById("extrafocs").value="";
    document.getElementById("focs").value="";
    document.getElementById("dispers").value=""
    document.getElementById("uprice").value="";
    document.getElementById("totamt").value="";
    document.getElementById("amounts").value="";
    document.getElementById("dict").value="";
    document.getElementById("taxpers").value="";
    document.getElementById("taxamounts").value="";
    document.getElementById("taxamountstotal").value="";
    document.getElementById("multi").checked=false;
    document.getElementById("batch").value="";
    document.getElementById("colbatch").value="";

    $('#batch').attr('readonly', false);
    $('#expdate').jqxDateTimeInput({ disabled: false});
    $('#expdate').val(null);
    document.getElementById("temppsrno").value="";
    document.getElementById("tempspecid").value="";
		     
    document.getElementById("jqxInput").value ="";
    document.getElementById("jqxInput1").value="";
    document.getElementById("brand").value=""; 
    document.getElementById("collqty").value ="";
    document.getElementById("quantity").value ="";
    document.getElementById("unit").value ="";
    document.getElementById("focs").value="";
    document.getElementById("batch").value="";
    document.getElementById("colbatch").value="";
    document.getElementById("temppsrno").value="";
    document.getElementById("tempspecid").value="";
    $('#expdate').val(null); 										
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
			
    if(quantity=="" || quantity==null || quantity==0 ||typeof(width)=="quantity"|| typeof(quantity)=="NaN") { quantity=0; }
    if(uprice=="" || uprice==null || uprice==0 || typeof(uprice)=="undefined"|| typeof(uprice)=="NaN") { uprice=0; }
    if(disper=="" || disper==null || disper==0 || typeof(disper)=="undefined"|| typeof(disper)=="NaN") { disper=0; }
    if(discount=="" || discount==null || discount==0 || typeof(discount)=="undefined"|| typeof(discount)=="NaN") { discount=0; }
    
    var netamount=0; 
    if(taxpers=="" || taxpers==null || taxpers==0 || typeof(taxpers)=="undefined"|| typeof(taxpers)=="NaN") { taxpers=0; }
			
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

function getbatch(event){
    if(document.getElementById("multi").checked) {  
        var x= event.keyCode;
        if(x==114){
            $('#bacthWindow1').jqxWindow('open');
            btsearchContent('batchsearchform.jsp?');
        }
    }  
}
</script>
</head>

<body onLoad="getCurrencyIds();setValues();chkcostcode();getitemtype();">

<div id="mainBG" class="homeContent" data-type="background">
<form id="purchaseInv" action="saveActionpurInv" method="post" autocomplete="off"> 
<jsp:include page="../../../../header.jsp" />    
<jsp:include page="multiqty.jsp"></jsp:include>
<button type="button" class="myButton" id="FixedDiv" style="position:fixed; z-index:1000; right:130px; top:15px;">Show data</button>

<div class="modern-ui hidden-scrollbar">
    <div id="errormsg"></div>
    <input type="hidden" id="roundmethod">
    <input type="hidden" id="roundvals">
    
    <!-- Top Details Panel -->
    <div class="middle-panel">
        <span class="middle-panel-title">Purchase Invoice Details</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Date</label>
            <div style="width: 125px;">
                <div id="masterdate" name="masterdate" value='<s:property value="masterdate"/>'></div>
            </div>
            <input type="hidden" name="hidmasterdate" id="hidmasterdate" value='<s:property value="hidmasterdate"/>'>
            
            <label class="lbl-right" style="width:100px; margin-left:auto;">Location</label>
            <div class="input-search-container" style="width:200px;">
                <input type="text" id="txtlocation" name="txtlocation" placeholder="Press F3" value='<s:property value="txtlocation"/>' onkeydown="getloc(event);"/>
                <svg class="magnifier-icon" onclick="$('#txtlocation').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="hidden" id="txtlocationid" name="txtlocationid" value='<s:property value="txtlocationid"/>'/>
            
            <label class="lbl-right" id="billname" style="width:100px; margin-left:auto;">Bill Type</label>
            <select id="cmbbilltype" name="cmbbilltype" onchange="gettaxaccounts()" style="width:125px;" value='<s:property value="cmbbilltype"/>'>
                <option value="1">ST</option>
                <option value="2">CST</option>
            </select>
            <input type="hidden" id="hidcmbbilltype" name="hidcmbbilltype" value='<s:property value="hidcmbbilltype"/>'/>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Ref No</label>
            <input type="text" name="refno" id="refno" style="width:125px;" value='<s:property value="refno"/>'>
            
            <label class="lbl-right" style="width:100px; margin-left:auto;">Doc No</label>
            <input type="text" name="docno" id="docno" style="width:200px;" tabindex="-1" value='<s:property value="docno"/>' readonly>
            
            <label class="lbl-right" style="width:100px; margin-left:auto;">Vendor</label>
            <div class="input-search-container" style="width:125px;">
                <input type="text" name="puraccid" id="puraccid" placeholder="Press F3" value='<s:property value="puraccid"/>' onKeyDown="getaccountdetails(event);">
                <svg class="magnifier-icon" onclick="$('#puraccid').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="text" id="puraccname" name="puraccname" value='<s:property value="puraccname"/>' style="flex:1; max-width:200px;" tabindex="-1" readonly>
        </div>
        
        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Ref Type</label>
            <select name="reftype" id="reftype" style="width:125px;" value='<s:property value="reftype"/>' onchange="funrefdisslno();">
                <option value="DIR">DIR</option>
                <option value="PO">PO</option>
                <option value="GRN">GRN</option>
            </select>
            
            <div class="input-search-container" style="width:150px; margin-left: 5px;">
                <input type="text" name="rrefno" id="rrefno" placeholder="Press F3" value='<s:property value="rrefno"/>' onfocus="funcheckaccinvendor();" onKeyDown="getrefno(event);">
                <svg class="magnifier-icon" onclick="$('#rrefno').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            
            <label class="lbl-right" style="width:100px; margin-left:auto;">Currency</label>
            <select name="cmbcurr" id="cmbcurr" style="width:100px;" value='<s:property value="cmbcurr"/>' onchange="getRatevalue(this.value);">
                <option value="-1">--Select--</option>
            </select>
            
            <label class="lbl-right" style="width:60px;">Rate</label>
            <input type="text" name="currate" id="currate" style="width:80px;" value='<s:property value="currate"/>'>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Inv. Date</label>
            <div style="width: 125px;">
                <div id="invdate" name="invdate" value='<s:property value="invdate"/>'></div>
            </div>
            <input type="hidden" name="hidinvdate" id="hidinvdate" value='<s:property value="hidinvdate"/>'>
            
            <label class="lbl-right" style="width:100px; margin-left:auto;">Inv. No</label>
            <input type="text" name="invno" id="invno" style="width:200px;" onblur="removemsg()" value='<s:property value="invno"/>'>
            
            <label class="lbl-right" style="width:100px; margin-left:auto;">Delivery Date</label>
            <div style="width: 125px;">
                <div id="deliverydate" name="deliverydate" value='<s:property value="deliverydate"/>'></div>
            </div>
            <input type="hidden" name="hiddeliverydate" id="hiddeliverydate" value='<s:property value="hiddeliverydate"/>'>
        </div>
        
        <div id="hcostcodes" hidden="true" style="border: 1px dashed #c5d3e0; padding: 10px; margin: 10px 0; border-radius: 4px; background: #fafafa;">
            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Group</label>
                <select id="itemtype" name="itemtype" style="width:200px;" onchange="cleardata()"><option></option></select>
                
                <label class="lbl-right" style="width:100px; margin-left:auto;">Job No</label>
                <div class="input-search-container" style="width:150px;">
                    <input type="text" id="itemdocno" name="itemdocno" placeholder="Press F3" value='<s:property value="itemdocno"/>' onkeydown="getitem(event);">
                    <svg class="magnifier-icon" onclick="$('#itemdocno').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                
                <input type="text" id="itemname" name="itemname" style="flex:1; margin-left:10px;" value='<s:property value="itemname"/>' tabindex="-1" readonly>
            </div>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Delivery Terms</label>
            <input type="text" name="delterms" id="delterms" style="width:400px;" value='<s:property value="delterms"/>'>
            
            <label class="lbl-right" style="width:100px; margin-left:auto;">Payment Terms</label>
            <input type="text" name="payterms" id="payterms" style="flex:1;" value='<s:property value="payterms"/>'>
        </div>
        
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:100px;">Description</label>
            <input type="text" name="purdesc" id="purdesc" style="flex:1;" value='<s:property value="purdesc"/>'>
            <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();" style="margin-left: 10px;">Value Change</button>
        </div>
    </div>
    
    <!-- Item Details Entry Panel -->
    <div class="middle-panel" id="psearch">
        <span class="middle-panel-title">Item Details</span>
        <div class="field-row">
            <label class="lbl-right" style="width:70px;">Product</label>
            <div style="width:100px;"><div id="part"><jsp:include page="part.jsp"></jsp:include></div></div>
            
            <label class="lbl-right" style="width:70px;">Name</label>
            <div style="flex:1;"><div id="pnames"><jsp:include page="name.jsp"></jsp:include></div></div>
            
            <label class="lbl-right" style="width:50px;">Brand</label>
            <input type="text" id="brand" style="width:100px;">
            <input type="hidden" id="collqty">
            
            <label class="lbl-right" style="width:50px;">Unit</label>
            <select id="unit" style="width:100px;"></select>
            
            <label class="lbl-right" style="width:50px;">Qty</label>
            <input type="hidden" id="loads" value="Load Data" onclick="loaddatass()">
            <input type="text" id="quantity" style="width:80px;" onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1(event);" onchange="calculatedata(this.id);">
        </div>
        
        <div class="field-row ff">
            <label class="lbl-right" style="width:70px;">FOC</label>
            <input type="text" id="focs" style="width:80px;" onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1(event);">
            
            <label class="lbl-right" style="width:70px;">Extra FOC</label>
            <input type="text" id="extrafocs" style="width:80px;" onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1(event);">
        </div>
        
        <div class="field-row">
            <label class="lbl-right" style="width:70px;">Unit Price</label>
            <input type="text" id="uprice" style="width:100px; text-align:right;" onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1(event);" onchange="calculatedata(this.id);">
            
            <label class="lbl-right" style="width:70px;">Total</label>
            <input type="text" id="totamt" style="width:100px; text-align:right;" tabindex="-1">
            
            <label class="lbl-right" style="width:70px;">Discount%</label>
            <input type="text" id="dispers" style="width:80px; text-align:right;" onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1(event);" onchange="calculatedata(this.id);">
            
            <label class="lbl-right" style="width:70px;">Discount</label>
            <input type="text" id="dict" style="width:100px; text-align:right;" onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1(event);" onchange="calculatedata(this.id);">
            
            <label class="lbl-right" style="width:70px;">Net Amt</label>
            <input type="text" id="amounts" style="width:100px; text-align:right;" tabindex="-1">
        </div>
        
        <div class="field-row">
            <label class="lbl-right" style="width:70px;">Tax%</label>
            <input type="text" id="taxpers" style="width:100px; text-align:right;" tabindex="-1" onchange="calculatedata(this.id);">
            
            <label class="lbl-right" style="width:70px;">Tax Amt</label>
            <input type="text" id="taxamounts" style="width:100px; text-align:right;" tabindex="-1" onkeypress="javascript:return isNumber1(event);">
            
            <label class="lbl-right" style="width:70px;">Tax Total</label>
            <input type="text" id="taxamountstotal" style="width:100px; text-align:right;" tabindex="-1" onkeypress="javascript:return isNumber1(event);">
            
            <div class="field-row ff" style="margin-left:auto; margin-bottom:0;">
                <label class="lbl-right">Multi Batch</label>
                <input type="checkbox" id="multi" onchange="chkmultis()" style="margin-top:5px;">
                <label class="lbl-right" style="margin-left:10px;">Batch</label>
                <input type="text" id="batch" style="width:80px;" onkeydown="getbatch(event)">
                <label class="lbl-right" style="margin-left:10px;">Exp Date</label>
                <div style="width:125px;"><div id="expdate" name="expdate" value='<s:property value="expdate"/>'></div></div>
            </div>
            
            <input type="hidden" id="cleardata">
            <button type="button" class="myButton" id="setbtn" onclick="setgrid()" style="margin-left:auto;">ADD</button>
        </div>
    </div>
    
    <input type="text" name="gridtext" id="gridtext" style="display:none;" value='<s:property value="gridtext"/>'/>   
    <input type="text" name="gridtext1" id="gridtext1" style="display:none;" value='<s:property value="gridtext1"/>'/>   
    
    <div class="middle-panel">
        <span class="middle-panel-title">Service Details Grid</span>
        <div class="grid-container">
            <div id="sevdesc"><jsp:include page="serviecgrid.jsp"></jsp:include></div>  
        </div>
    </div>
  
    <!-- Summary Panel -->
    <div class="middle-panel">
        <span class="middle-panel-title">Summary</span>
        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Product Total</label>
            <input type="text" name="productTotal" id="productTotal" style="width:125px; text-align:right;" readonly="readonly" value='<s:property value="productTotal"/>'>
            
            <label class="lbl-right" style="width:100px; margin-left:20px;">Discount</label>
            <input type="checkbox" id="chkdiscount" name="chkdiscount" value="0" onchange="fundisable()" onclick="$(this).attr('value', this.checked ? 1 : 0)" style="margin-top:5px;">
            
            <label class="lbl-right" style="width:100px; margin-left:20px;">Discount %</label>
            <input type="text" name="descPercentage" id="descPercentage" style="width:100px; text-align:right;" value='<s:property value="descPercentage"/>' onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber(event);">
            
            <button type="button" class="myButton" id="btnCalculate" title="Calculate" onclick="funcalcu();" style="margin-left:5px;">Calculate</button> 
            
            <label class="lbl-right" style="width:120px; margin-left:auto;">Discount Value</label>
            <input type="text" name="descountVal" id="descountVal" style="width:125px; text-align:right;" value='<s:property value="descountVal"/>' onblur="funvalcalcu();" onkeypress="javascript:return isNumber(event);">
            
            <input type="hidden" name="prddiscount" id="prddiscount" value='<s:property value="prddiscount"/>'>
        </div>
        
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:100px;">Round of</label>
            <input type="text" name="roundOf" id="roundOf" style="width:125px; text-align:right;" value='<s:property value="roundOf"/>' onblur="roundval();funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1(event);">
            
            <label class="lbl-right" style="width:100px; margin-left:20px;">Net Total</label>
            <input type="text" name="netTotaldown" id="netTotaldown" style="width:125px; text-align:right; font-weight:bold; color:#0b45a2;" readonly="readonly" value='<s:property value="netTotaldown"/>' onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber(event);">
            
            <label class="lbl-right" style="width:100px; margin-left:auto;">Order Value</label>
            <input type="text" id="orderValue" name="orderValue" style="width:150px; text-align:right; font-weight:bold; color:#0b45a2;" readonly="readonly" tabindex="-1" value='<s:property value="orderValue"/>'>
        </div>
    </div>
 
    <div class="middle-panel">
        <span class="middle-panel-title">Service</span>
        <div class="grid-container">
            <div id="descdetail"><jsp:include page="descgridDetails.jsp"></jsp:include></div>
        </div>
    </div>

    <div class="middle-panel">
        <span class="middle-panel-title">Purchase Expense</span>
        <div class="grid-container">
            <div id="expDiv"><jsp:include page="purchaseexpGrid.jsp"></jsp:include></div>
        </div>
    </div>

    <!-- Tax Details -->
    <div id="taxsss">
        <div class="middle-panel">
            <span class="middle-panel-title">Tax Details</span>
            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Total Tax</label>
                <input type="text" id="st" name="st" style="width:150px;" value='<s:property value="st"/>'>
                
                <button type="button" class="myButton" id="process1" title="Process1" onclick="funcalutax();" style="margin-left:5px;">Process</button>
                
                <label class="lbl-right" id="labeltax1" style="width:100px; margin-left:20px;"></label>
                <input type="text" id="taxontax1" name="taxontax1" style="width:125px;" value='<s:property value="taxontax1"/>'>
                
                <label class="lbl-right" id="labeltax2" style="width:100px; margin-left:20px;"></label>
                <input type="text" id="taxontax2" name="taxontax2" style="width:125px;" value='<s:property value="taxontax2"/>'>
                
                <label class="lbl-right" id="labeltax3" style="width:100px; margin-left:20px;"></label>
                <input type="text" id="taxontax3" name="taxontax3" style="width:125px;" value='<s:property value="taxontax3"/>'>
            </div>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:100px;">Net Tax Total</label>
                <input type="text" id="taxtotal" name="taxtotal" style="width:150px; text-align:right; font-weight:bold; color:#0b45a2;" value='<s:property value="taxtotal"/>'>
            </div>
        </div>
    </div>

    <!-- Hidden Logic Fields -->
    <div style="display:none;">
        <input type="hidden" id="expencenettotal" name="expencenettotal" value='<s:property value="expencenettotal"/>'/>    
        <input type="hidden" id="nettotal" name="nettotal" value='<s:property value="nettotal"/>'/>   
        <input type="hidden" id="chkdiscountval" name="chkdiscountval" value='<s:property value="chkdiscountval"/>'/>      
        <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'/>  
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>   
        <input type="hidden" id="descgridlenght" name="descgridlenght" value='<s:property value="descgridlenght"/>'/>   
        <input type="hidden" id="serviecGridlength" name="serviecGridlength" value='<s:property value="serviecGridlength"/>'/>    
        <input type="hidden" id="cmbcurrval" name="cmbcurrval" value='<s:property value="cmbcurrval"/>'/>    
        <input type="hidden" id="acctypeval" name="acctypeval" value='<s:property value="acctypeval"/>'/>  
        <input type="hidden" id="accdocno" name="accdocno" value='<s:property value="accdocno"/>'/>    
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="reftypeval" name="reftypeval" value='<s:property value="reftypeval"/>'/>
        <input type="hidden" id="reqmasterdocno" name="reqmasterdocno" value='<s:property value="reqmasterdocno"/>'/>
        <input type="hidden" id="producttype" name="producttype" value='<s:property value="producttype"/>'/>
        <input type="hidden" id="expgridlength" name="expgridlength" value='<s:property value="expgridlength"/>'/>
        <input type="hidden" id="editdata" name="editdata" value='<s:property value="editdata"/>'/>
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
        <input type="hidden" id="colbatch">     
    </div>

</div> 
</form>
</div> 

<!-- Search Windows -->
<div id="searchwindow"><div></div></div>
<div id="refnosearchwindow"><div></div></div>
<div id="accountSearchwindow"><div></div></div>
<div id="sidesearchwndow"><div></div></div>
<div id="importwindow"><div></div></div>
<div id="searchwndow"><div></div></div>
<div id="expencewindow"><div></div></div>
<div id="locationwindow"><div></div></div>
<div id="calculationwindow"><div></div></div>
<div id="lastpurchasewindow"><div></div></div>

</body>
</html>