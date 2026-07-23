<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Job Card</title>
<jsp:include page="../../../includes.jsp"></jsp:include>
<style>
/* =========================================================
SCOPED UI: Modern Layout (Plain White & Blue Headings)
========================================================= */
body {
    background: #ffffff;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #ffffff;
    border-radius: 16px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    border: 1px solid #e2e8f0;
    box-shadow: none;
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
.modern-ui input[type="email"],
.modern-ui select { 
    height: 24px !important; 
    border: 1px solid #cbd5e1; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui input[type="email"]:focus,
.modern-ui select:focus { 
    border-color: #64748b; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled,
.modern-ui select:disabled,
.readonly { 
    background-color: #f8f9fa !important; 
    color: #6b7280;
}

.modern-ui input[type="checkbox"] {
    width: 14px !important;
    height: 14px !important;
    margin: 0;
    cursor: pointer;
}

/* Layout Utilities - Tightened Spacing */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: wrap;
    justify-content: flex-start;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Middle Section Panels - Plain White with Blue Title */
.modern-ui .middle-panel {
    border: 1px solid #e2e8f0; 
    padding: 18px 10px 10px 10px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 12px;
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
    font-size: 13px; 
    border-left: 3px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
    display: flex;
    align-items: center;
}

/* Custom UI Buttons matching 24px height - Monochrome */
.modern-ui .myButton,
.modern-ui input[type="button"] {
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
    box-shadow: 0 1px 2px rgba(0,0,0,0.05);
    border: 1px solid #cbd5e1;
    background: #f8fafc;
    color: #0f172a;
    white-space: nowrap;
    display: inline-flex;
    align-items: center;
    justify-content: center;
}
.modern-ui .myButton:hover,
.modern-ui input[type="button"]:hover { 
    background: #e2e8f0; 
}

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
.modern-ui .magnifier-icon:hover { color: #333; }

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-x: hidden;
    overflow-y: auto;
    height: calc(100vh - 120px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

form label.error { color: #dc2626; font-weight:bold; }
#errormsg { color: #dc2626; font-weight:bold; text-align:center; margin-bottom: 10px; }
</style>
<%String id=request.getParameter("id")==null?"":request.getParameter("id");
String gipno=request.getParameter("gipno")==null?"":request.getParameter("gipno");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
%>
<script type="text/javascript">
var rawconfig={};
$(document).ready(function() {

$("#date").jqxDateTimeInput({  width:'100%', height: 24, formatString : "dd.MM.yyyy", theme: 'energyblue' });

/* force internal alignment AFTER render */
setTimeout(function () {
     $("#date").find("input").css({
         "margin-top": "0px",
         "line-height": "24px",
         "font-size": "12px", 
         "font-family": "Arial, sans-serif", 
         "padding": "0 6px", 
         "box-sizing":"border-box"
     });
     $("#date").find(".jqx-action-button").css({
         "top": "0px",
         "height": "24px"
     });
}, 0);

$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;margin-left:50%;margin-right:50%;margin-top:15%;top:200;right:600;'><img src='../../../icons/31load.gif'/></div>");  

$('#searchwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Gate In Pass Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#searchwindow').jqxWindow('close');
$('#partssearchwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Product Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#partssearchwindow').jqxWindow('close');
$('#laboursearchwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Service Type Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#laboursearchwindow').jqxWindow('close');
$('#printWindow').jqxWindow({width: '51%', height: '28%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
$('#printWindow').jqxWindow('close');
$('#emailWindow').jqxWindow({width: '51%', height: '28%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Email',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
$('#emailWindow').jqxWindow('close');   
getDocDateConfig();
$( "#gatevocno" ).dblclick(function() {
    if(document.getElementById("mode").value=="view"){
        return false;
    }
    $('#searchwindow').jqxWindow('open');
    $('#searchwindow').jqxWindow('focus');
    SearchContent('gateInPassSearch.jsp','searchwindow');
});
$('#btnEdit').mousedown(function(){
    var editstatus=$('#editstatus').val();
    if(editstatus==0){
        $.messager.alert('Warning','Job Card Completed!!Cannot Edit');
        return false;
    }
    if(editstatus==2){
        $.messager.alert('Warning','Parts Updated !!Cannot Edit');
        return false;
    }
});

$( "#servicestotal,#servicesdiscount" ).change(function() {
    var services=parseFloat($('#servicestotal').val());
    var discount=parseFloat($('#servicesdiscount').val());
    var total=services-discount;
    $('#netservices').val(total);
});
$( "#sparetotal,#sparediscount" ).change(function() {
    
    var spare=parseFloat($('#sparetotal').val());
    var discount=parseFloat($('#sparediscount').val());
    var total=spare-discount;
    $('#netspare').val(total.toFixed(2));   
    
});
$('#btnCalculate').click(function(){
    $('#sparePartsAmountGrid').jqxGrid('clear');
    var servicetotal=$('#netservices').val();
    var total=$('#netspare').val();
    var date=$('#date').jqxDateTimeInput('val');
    var docno=$('#docno').val();
    var gatedocno=$('#gatedocno').val();
    var lumsumamount=$('#lumsumamount').val();
    var servicelumsumamt=$('#servicelumsumamt').val();
    var randomlumsumamt=$('#randomlumsumamt').val();
    var chklumsum=0;
    var chkservicelumsum=0;
    var chkrandomlumsum=0;
    if(document.getElementById("chklumsum").checked==true){
        chklumsum=1;
    }
    else{
        chklumsum=0;
    }
    if(document.getElementById("chkservicelumsum").checked==true){
        chkservicelumsum=1;
    }
    else{
        chkservicelumsum=0;
    }
    if(document.getElementById("chkrandomlumsum").checked==true){
        chkrandomlumsum=1;
    }
    else{
        chkrandomlumsum=0;
    }
    
    insertSparePartsAmount(total,servicetotal,date,docno,gatedocno,lumsumamount,chklumsum,chkservicelumsum,servicelumsumamt,chkrandomlumsum,randomlumsumamt);
});


var gipno='<%=gipno%>';
if(gipno!="" && gipno!="undefined" && gipno!=null && typeof(gipno)!="undefined"){
    var ajaxbrhid='<%=brhid%>';
    
    if(ajaxbrhid!="" && ajaxbrhid!=null && ajaxbrhid!="undefined"){
        $('#brchName').val(ajaxbrhid);  
    }
    getRefData(gipno);
     $('#jobtypeinputdiv').load('jobtypeinput.jsp?id=1');
}

});
function getRefData(gipno){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            items=JSON.parse(items);
            $('#gatedocno').val(items.gatedocno);
            $('#gatevocno').val(items.gatevocno);
            $('#gateuserdetails').val(items.gateuserdetails);
            $('#gatevehicledetails').val(items.gatevehicledetails);
            $('#gipdatetime').val(items.gipdatetime);
            $('#gipinsurcomp').val(items.gipinsurcomp);
            $('#gipclaimno').val(items.gipclaimno);
            $('#complaintdiv').load('complaintGrid.jsp?docno='+$('#gatedocno').val()+'&id=1');      
        }
        else{
            }
        }
    
    x.open("GET", "getGateDataAJAX.jsp?gipno="+gipno, true);
    x.send();
}
function insertSparePartsAmount(total,servicetotal,date,docno,gatedocno,lumsumamount,chklumsum,chkservicelumsum,servicelumsumamt,chkrandomlumsum,randomlumsumamt){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            $('#sparepartsamountdiv').load('sparePartsAmountGrid.jsp?gatedocno='+items+'&id=1');
        }
    }
    x.open("GET", "insertSparePartsAmount.jsp?total="+total+"&servicetotal="+servicetotal+"&date="+date+"&docno="+docno+"&gatedocno="+gatedocno+"&lumsumamount="+lumsumamount+"&chklumsum="+chklumsum+"&chkservicelumsum="+chkservicelumsum+"&servicelumsumamt="+servicelumsumamt+"&chkrandomlumsum="+chkrandomlumsum+"&randomlumsumamt="+randomlumsumamt, true);
    x.send();
}
function getGateInPass(event){
    if(document.getElementById("mode").value=="view"){
        return false;
    }
    var x= event.keyCode;
    if(x==114){
        $('#searchwindow').jqxWindow('open');
        $('#searchwindow').jqxWindow('focus');
        SearchContent('gateInPassSearch.jsp');
      }
}

function SearchContent(url,id) {
    $.get(url).done(function (data) {
  $('#'+id).jqxWindow('setContent', data);
}); 
}

function funSearchLoad(){
    changeContent('masterSearch.jsp', $('#window'));
 }
function funReadOnly() {
    $('#frmWSEstimationPal input').attr('readonly',true);
var id='<%=id%>';
     if(id=="3"){
         var ajaxbrhid='<%=brhid%>';
        if(ajaxbrhid!="" && ajaxbrhid!=null && ajaxbrhid!="undefined"){
            $('#brchName').val(ajaxbrhid);  
        }
        $.get('getEstPrintConfig.jsp',function(data){
            var items=JSON.parse(data);
            $("#estprintconfig").val(items.estPagePrint.method);
                rawconfig=items;
                if(rawconfig.estSpareDiscount.method=="1"){
                    $('.spare-row').show();
                }
                else{
                    $('.spare-row').hide();
                }
                if(rawconfig.estLumSum.method=="1"){
                    $('.lumsum-row').show();
                }
                else{
                    $('.lumsum-row').hide();
                }
                funCreateBtn();
                var gipno='<%=gipno%>';
                getRefData(gipno);
                $('#jobtypeinputdiv').load('jobtypeinput.jsp?id=1');
        });
      
     }
}
function funRemoveReadOnly() {
    $('#frmWSEstimationPal input').attr('readonly',false);
    $('#docno').attr('readonly',true);
    if($('#mode').val()=='A'){
        $('#sparePartsNewGrid,#labourcostGrid,#sparePartsAmountGrid,#complaintGrid').jqxGrid('clear');
        $('#sparePartsNewGrid,#labourcostGrid,#sparePartsAmountGrid').jqxGrid({disabled:false});
        $("#sparePartsNewGrid,#labourcostGrid").jqxGrid("addrow", null, {});
        var id='<%=id%>';
        if(id!="3"){
        }
        
        $('#servicestotal,#servicesdiscount,#netservices').val(0);
        $('#sparetotal,#sparediscount,#netspare').val(0);
        if(rawconfig.serviceConsumables.method=="1"){
            $("#sparePartsNewGrid").jqxGrid("setcellvalue",0,"description","Consumables");
            $("#sparePartsNewGrid").jqxGrid("addrow", null, {});
        }
    }
    else if($('#mode').val()=='E' || $('#mode').val()=='D'){
        $('#sparePartsNewGrid,#labourcostGrid').jqxGrid({disabled:false});
        $("#sparePartsNewGrid,#labourcostGrid").jqxGrid("addrow", null, {});
    }
    if($('#mode').val()=='E'){
        $('#sparePartsAmountGrid').jqxGrid('clear');
    }
    getDocDateConfig();
    
}

function setValues() {
    getEstPrintConfig();     
    if(document.getElementById("formdet")) {
        document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
    }
    
     if($('#msg').val()!=""){
           $.messager.alert('Message',$('#msg').val());
     }
    var a=$('#gatedocno').val();
    var b=$('#docno').val();
    if($('#docno').val()!=''){
        var b=$('#docno').val();
        $('#complaintdiv').load('../../../com/workshop/estimationpal/complaintGrid.jsp?docno='+$('#gatedocno').val()+'&branch='+$('#brchName').val()+'&id=1');  
        $('#jobtypeinputdiv').load('jobtypeinput.jsp?id=1');
        CheckEditStatus($('#docno').val());
    }
    if($('#docno').val()!=''){
        $('#sparepartsdiv').load('../../../com/workshop/estimationpal/sparePartsNewGrid.jsp?docno='+$('#docno').val()+'&id=1');
    }
    if($('#docno').val()!=''){
        $('#labourcostdiv').load('../../../com/workshop/estimationpal/labourcostGrid.jsp?docno='+$('#docno').val()+'&id=1');     
    }
    if($('#gatedocno').val()!=''){
        $('#sparepartsamountdiv').load('../../../com/workshop/estimationpal/sparePartsAmountGrid.jsp?gatedocno='+$('#gatedocno').val()+'&id=1');       
    }
    if(document.getElementById("hidchklumsum").value=='1'){
        document.getElementById("chklumsum").checked=true;
    }
    else{
        document.getElementById("chklumsum").checked=false;
    }
    
    //Setting Service Lumsum Checkbox
    if(document.getElementById("hidchkservicelumsum").value=='1'){
        document.getElementById("chkservicelumsum").checked=true;
    }
    else{
        document.getElementById("chkservicelumsum").checked=false;
    }
    
    //Setting Random Lumsum Checkbox
    if(document.getElementById("hidchkrandomlumsum").value=='1'){
        document.getElementById("chkrandomlumsum").checked=true;
    }
    else{
        document.getElementById("chkrandomlumsum").checked=false;
    }
    
    setLumSum();
    setServiceLumSum();
    setRandomLumSum();
    var ajaxbrhid='<%=brhid%>';
    if(ajaxbrhid!="" && ajaxbrhid!=null && ajaxbrhid!="undefined"){
        $('#brchName').val(ajaxbrhid);  
    }
    if($('#brhid').val()!='' && $('#brhid').val()!='undefined' && $('#brhid').val()!=null && typeof($('#brhid').val())!='undefined'){
        $('#brchName').val($('#brhid').val());  
    }
    funSetlabel();
    
    
}

 function funFocus() {
        document.getElementById("gatevocno").focus(); 
 }
    
 function funNotify(){
    var dateval=funDateInPeriod($('#date').jqxDateTimeInput('getDate'));
     if(dateval==0){
        $('#date').jqxDateTimeInput('focus');
        return false;
     }
     var docdateconfig=$('#docdateconfig').val();
    if(docdateconfig=="1"){
        var currentdate=new Date();
        currentdate.setHours(0,0,0,0);
        var docdate=new Date($('#date').jqxDateTimeInput('getDate'));
        docdate.setHours(0,0,0,0);
        if(currentdate.getTime()!=docdate.getTime()){
            $.messager.alert('Warning','Document Date should be Current Date');
            $('#date').jqxDateTimeInput('focus');
            return 0;
        }
        else{
            
        }
    }
    if($('#gatedocno').val()==""){
        document.getElementById("errormsg").innerText="";
        document.getElementById("errormsg").innerText="Gate In Pass is Mandatory";
        return 0;
    } 
    var amountrows=$("#sparePartsAmountGrid").jqxGrid('getrows');
    if(amountrows.length==0){
        document.getElementById("errormsg").innerText="";
        document.getElementById("errormsg").innerText="Please Calculate Amount";
        return 0;
    }
    var labourrows = $("#labourcostGrid").jqxGrid('getrows');
    var labourgridlength=0;
    for(var i=0;i<labourrows.length;i++){
        if(labourrows[i].jobid!="" && labourrows[i].jobid!=null && labourrows[i].jobid!="undefined" && typeof(labourrows[i].jobid)!="undefined"){
            var j=labourgridlength;
            newTextBox = $(document.createElement("input"))
            .attr("type", "hidden")
            .attr("id", "labourcostarray"+j)
            .attr("name", "labourcostarray"+j);
                
            newTextBox.val(labourrows[j].jobid+" :: "+labourrows[j].hrs+" :: "+labourrows[j].rate+" :: "+labourrows[j].markuppercent+" :: "+labourrows[j].total+" :: "+labourrows[j].remarks+" :: "+labourrows[j].jobtype+" :: "+labourrows[j].jobdesc+" :: "+labourrows[j].seqno);
            
            newTextBox.appendTo('form');
            labourgridlength++;
        }
    }
    $('#labourcostgridlength').val(labourgridlength);
    
    var partrows = $("#sparePartsNewGrid").jqxGrid('getrows');
    var partgridlength=0;
    for(var i=0;i<partrows.length;i++){
        if(partrows[i].description!="" && partrows[i].description!=null && partrows[i].description!="undefined" && typeof(partrows[i].description)!="undefined"){
            partgridlength++;
            newTextBox = $(document.createElement("input"))
            .attr("type", "hidden")
            .attr("id", "sparepartsarray"+i)
            .attr("name", "sparepartsarray"+i);
            newTextBox.val(partrows[i].description+" :: "+partrows[i].qty+" :: "+partrows[i].sprate+" :: "+partrows[i].approvedvalue);
            newTextBox.appendTo('form'); 
        }
    }
    
     $('#sparePartsNewGridlength').val(partgridlength);
    
    if(document.getElementById("chklumsum").checked==true){
        document.getElementById("hidchklumsum").value="1";
    }
    else{
        document.getElementById("hidchklumsum").value="0";
    }
    
    //Checking for User Clicked Calculate
    var gridsum=($("#sparePartsAmountGrid").jqxGrid("getcellvalue",2, "approvedtotal"))+"";
    gridsum=gridsum.replace(/,/g, '');
    var netsum=0.0;
    var sparesum=0.0,servicesum=0.0;
    if(document.getElementById("chkrandomlumsum").checked==true){
        netsum=$('#randomlumsumamt').val();
    }
    else{
        if(document.getElementById("chkservicelumsum").checked==true){
            servicesum=$('#servicelumsumamt').val();
        }
        else{
            servicesum=$('#netservices').val();
        }
        if(document.getElementById("chklumsum").checked==true){
            sparesum=$('#lumsumamount').val();
        }
        else{
            sparesum=$('#netspare').val();
        }
        netsum=(parseFloat(servicesum)+parseFloat(sparesum)).toFixed(2);
    }
    
    if(parseFloat(netsum)!=parseFloat(gridsum)){
        $.messager.alert('Warning','Please Calculate');
        return 0;
    }
    return 1;
 } 

 function isNumber(evt,id) {
    //Function to restrict characters and enter number only
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
    {
        $.messager.alert('Warning','Enter Numbers Only');
        $("#"+id+"").focus();
        return false;
    }
    return true;
}
 
 function CheckEditStatus(docno){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            $('#editstatus').val(items.trim());
            } else {
            }
        }
    x.open("GET", "checkEditStatus.jsp?docno="+docno, true);
    x.send();
 }
 
 function setLumSum(){
    if(document.getElementById("chklumsum").checked==true){
        document.getElementById("lumsumamount").disabled=false;
        document.getElementById("hidchklumsum").value="1";
    }
    else{
        document.getElementById("lumsumamount").disabled=true;
        document.getElementById("hidchklumsum").value="0";
    }
 }
 
 function setServiceLumSum(){
    if(document.getElementById("chkservicelumsum").checked==true){
        document.getElementById("servicelumsumamt").disabled=false;
        document.getElementById("hidchkservicelumsum").value="1";
    }
    else{
        document.getElementById("servicelumsumamt").disabled=true;
        document.getElementById("hidchkservicelumsum").value="0";
    }
 }
 
 function setRandomLumSum(){
    if(document.getElementById("chkrandomlumsum").checked==true){
        document.getElementById("randomlumsumamt").disabled=false;
        document.getElementById("hidchkrandomlumsum").value="1";
    }
    else{
        document.getElementById("randomlumsumamt").disabled=true;
        document.getElementById("hidchkrandomlumsum").value="0";
    }
 }
 function funPrintBtn(){
     getEstPrintConfig();   
     if($('#estprintconfig').val()=='1'){            
         estimationPrintContent('printVoucherWindow.jsp');    
     }else{
         if($('#docno').val()!='' && $('#docno').val()!='0'){
                var url=document.URL;
                var reurl=url.split("com");
                var docno=$('#docno').val();
                var gatedoc=$('#gatedocno').val();
                var path= "com/dashboard/workshop/quotationapproval/printQuotationAproval.action?estDocno="+$('#vocno').val()+"&docno="+docno+"&gatedocno="+gatedoc;
                var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=700,Height=600,location=no,scrollbars=yes,toolbar=yes");      
                win.focus();        
             }
     }  
 }
 function funSendmail(){
     getEstPrintConfig();   
     if($('#estprintconfig').val()=='1'){            
         estimationPrintContent('emailVoucherWindow.jsp');    
     }else{
     }  
 }
 function estimationPrintContent(url) {
        $('#printWindow').jqxWindow('open');
        $.get(url).done(function (data) {
        $('#printWindow').jqxWindow('setContent', data);
        $('#printWindow').jqxWindow('bringToFront');
    }); 
}

 function getDocDateConfig(){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            items = x.responseText.trim();
            $('#docdateconfig').val(items);
        } else {
        }
    }
    x.open("GET", "getDocDateConfig.jsp", true);
    x.send();
}
 function getEstPrintConfig(){       
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = JSON.parse(x.responseText.trim());
                
                $("#estprintconfig").val(items.estPagePrint.method);
                rawconfig=items;
                if(rawconfig.estSpareDiscount.method=="1"){
                    $('.spare-row').show();
                }
                else{
                    $('.spare-row').hide();
                }
                if(rawconfig.estLumSum.method=="1"){
                    $('.lumsum-row').show();
                }
                else{
                    $('.lumsum-row').hide();
                }
                
            } else {
            }
        }
        x.open("GET", "getEstPrintConfig.jsp", true);        
        x.send();
    }
</script>
</head> 
<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background"> 
    <form id="frmWSEstimationPal" action="saveWSEstimationPal" method="post" autocomplete="off" class="form-inline">
        <jsp:include page="../../../header.jsp" />
        <script type="text/javascript">
            var ajaxbrhid='<%=brhid%>';
            var id='<%=id%>';
            if(id=="3"){
                $('#brchName').val(ajaxbrhid);  
            }
        </script>
        
        <div class="modern-ui hidden-scrollbar">
            <input type="hidden" id="test">
            <div id="errormsg"></div>

            <!-- Top Header info -->
            <div class="middle-panel">
                <span class="middle-panel-title">Estimation Details</span>
                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Date</label>
                    <div style="flex:1; max-width:125px;">
                        <div id="date" name="date" value='<s:property value="date"/>'></div>
                    </div>
                    
                    <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
                    <input type="text" name="vocno" id="vocno" readonly tabindex="-1" value='<s:property value="vocno"/>' class="readonly" style="width:120px;">
                    <input type="hidden" name="docno" id="docno" readonly tabindex="-1" value='<s:property value="docno"/>' class="readonly">
                    <input type="hidden" name="editstatus" id="editstatus" readonly tabindex="-1" value='<s:property value="editstatus"/>'>
                </div>
            </div>

            <!-- Gate In Pass Details -->
            <div class="middle-panel">
                <span class="middle-panel-title">Gate In Pass Details</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:120px;">Gate In Pass Doc No</label>
                    <div class="input-search-container" style="flex:1; max-width:150px;">
                        <input type="text" name="gatevocno" id="gatevocno" readonly placeholder="Press F3" value='<s:property value="gatevocno"/>' onkeydown="getGateInPass(event);" class="readonly">
                        <svg class="magnifier-icon" onclick="$('#gatevocno').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    
                    <label class="lbl-right" style="width:100px; margin-left:15px;">User Details</label>
                    <input type="text" name="gateuserdetails" id="gateuserdetails" readonly value='<s:property value="gateuserdetails"/>' class="readonly" style="flex:2;">
                </div>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:120px;">Ins. Company</label>
                    <input type="text" name="gipinsurcomp" id="gipinsurcomp" readonly class="readonly" value='<s:property value="gipinsurcomp"/>' style="flex:1; max-width:150px;">
                    
                    <label class="lbl-right" style="width:100px; margin-left:15px;">Vehicle Details</label>
                    <input type="text" name="gatevehicledetails" id="gatevehicledetails" readonly class="readonly" value='<s:property value="gatevehicledetails"/>' style="flex:2;">
                </div>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:120px;">Claim No</label>
                    <input type="text" name="gipclaimno" id="gipclaimno" value='<s:property value="gipclaimno"/>' style="flex:1; max-width:150px;">
                    
                    <label class="lbl-right" style="width:100px; margin-left:15px;">Header</label>
                    <input type="text" name="header" id="header" readonly value='<s:property value="header"/>' class="readonly" style="flex:2;">
                </div>

                <div class="field-row">
                    <label class="lbl-right" style="width:120px;">GIP Date Time</label>
                    <input type="text" name="gipdatetime" id="gipdatetime" value='<s:property value="gipdatetime"/>' style="flex:1; max-width:150px;">
                    
                    <label class="lbl-right" style="width:100px; margin-left:15px;">Notes</label>
                    <input type="text" name="notes" id="notes" readonly value='<s:property value="notes"/>' class="readonly" style="flex:2;">
                </div>

                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:120px;">Estimate Days</label>
                    <input type="text" name="estimatedays" id="estimatedays" value='<s:property value="estimatedays"/>' style="flex:1; max-width:150px;">
                    
                    <label class="lbl-right" style="width:100px; margin-left:15px;">Internal Remarks</label>
                    <input type="text" name="internalremarks" id="internalremarks" readonly value='<s:property value="internalremarks"/>' class="readonly" style="flex:2;">
                </div>

                <input type="hidden" name="gatedocno" id="gatedocno" readonly tabindex="-1" value='<s:property value="gatedocno"/>'>
            </div>

            <!-- Complaints -->
            <div class="middle-panel">
                <span class="middle-panel-title">Complaints</span>
                <div id="complaintdiv">
                    <jsp:include page="complaintGrid.jsp"></jsp:include>
                </div>
            </div>

            <!-- Services -->
            <div class="middle-panel">
                <span class="middle-panel-title">Services</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:60px;">Job Type</label>
                    <div id="jobtypeinputdiv" style="width:150px;">
                        <jsp:include page="jobtypeinput.jsp"></jsp:include>
                    </div>
                    
                    <label class="lbl-right" style="width:70px; margin-left:15px;">Description</label>
                    <input type="text" name="jobdescription" id="jobdescription" style="flex:2;">
                    <input type="hidden" name="jobhrs" id="jobhrs">
                    
                    <label class="lbl-right" style="width:40px; margin-left:15px;">Rate</label>
                    <input type="text" name="jobrate" id="jobrate" style="flex:1; max-width:80px; text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);">
                    
                    <label class="lbl-right" style="width:60px; margin-left:15px;">Remarks</label>
                    <input type="text" name="jobremarks" id="jobremarks" style="flex:2;">
                    
                    <input type="button" class="myButton" id="btnaddjob" name="btnaddjob" value="Add" onclick="funAddJob();" style="margin-left:15px;">
                </div>
                
                <div id="labourcostdiv" style="margin-top:10px;">
                    <jsp:include page="labourcostGrid.jsp"></jsp:include>
                </div>
                
                <div class="field-row" style="margin-top:12px; justify-content: flex-end;">
                    <label class="lbl-right">Total</label>
                    <input type="text" name="servicestotal" id="servicestotal" value='<s:property value="servicestotal"/>' style="width:100px; text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);">
                    
                    <label class="lbl-right" style="margin-left:15px;">Discount</label>
                    <input type="text" name="servicesdiscount" id="servicesdiscount" value='<s:property value="servicesdiscount"/>' style="width:100px; text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);">
                    
                    <label class="lbl-right" style="margin-left:15px;">Net Services Total</label>
                    <input type="text" name="netservices" id="netservices" value='<s:property value="netservices"/>' style="width:120px; text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);">
                </div>
                
                <div class="field-row lumsum-row" style="justify-content: flex-end; margin-bottom:0;">
                    <label style="display:flex; align-items:center; gap:5px; margin-right:5px; font-weight:bold; font-size:12px; color:#444; cursor:pointer;">
                        <input type="checkbox" name="chkservicelumsum" id="chkservicelumsum" onchange="setServiceLumSum();"> Service Lumpsum
                    </label>
                    <input type="hidden" name="hidchkservicelumsum" id="hidchkservicelumsum" value='<s:property value="hidchkservicelumsum"/>'>
                    <input type="text" name="servicelumsumamt" id="servicelumsumamt" value='<s:property value="servicelumsumamt"/>' style="width:120px; text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);">
                </div>
            </div>

            <!-- Spare Parts -->
            <div class="middle-panel">
                <span class="middle-panel-title">Spare Parts</span>
                <div id="sparepartsdiv">
                    <jsp:include page="sparePartsNewGrid.jsp"></jsp:include>
                </div>
                
                <div class="field-row spare-row" style="margin-top:12px; justify-content: flex-end;">
                    <label class="lbl-right">Total</label>
                    <input type="text" name="sparetotal" id="sparetotal" value='<s:property value="sparetotal"/>' style="width:100px; text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);">
                    
                    <label class="lbl-right" style="margin-left:15px;">Discount</label>
                    <input type="text" name="sparediscount" id="sparediscount" value='<s:property value="sparediscount"/>' style="width:100px; text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);">
                    
                    <label class="lbl-right" style="margin-left:15px;">Net Spare Total</label>
                    <input type="text" name="netspare" id="netspare" value='<s:property value="netspare"/>' style="width:120px; text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);">
                </div>
                
                <div class="field-row lumsum-row" style="margin-top:8px; margin-bottom:0; justify-content: space-between;">
                    <div style="display:flex; align-items:center;">
                        <label style="display:flex; align-items:center; gap:5px; margin-right:5px; font-weight:bold; font-size:12px; color:#444; cursor:pointer;">
                            <input type="checkbox" id="chklumsum" name="chklumsum" onChange="setLumSum();"> Spare Lumpsum
                        </label>
                        <input type="text" id="lumsumamount" name="lumsumamount" value='<s:property value="lumsumamount"/>' style="width:100px; text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);">
                        <input type="hidden" name="hidchklumsum" id="hidchklumsum" value='<s:property value="hidchklumsum"/>'>
                    </div>
                    
                    <div style="display:flex; align-items:center;">
                        <label style="display:flex; align-items:center; gap:5px; margin-right:5px; font-weight:bold; font-size:12px; color:#444; cursor:pointer;">
                            <input type="checkbox" id="chkrandomlumsum" name="chkrandomlumsum" onchange="setRandomLumSum();"> Lumpsum
                        </label>
                        <input type="hidden" id="hidchkrandomlumsum" name="hidchkrandomlumsum" value='<s:property value="hidchkrandomlumsum"/>'>
                        <input type="text" id="randomlumsumamt" name="randomlumsumamt" value='<s:property value="randomlumsumamt"/>' style="width:120px; text-align:right;" onKeyPress="javascript:return isNumber (event,id)" onBlur="funRoundAmt(value,id);"/>
                    </div>
                </div>
            </div>

            <div class="field-row" style="justify-content: center; margin: 15px 0;">
                <button type="button" class="myButton" id="btnCalculate" style="padding: 0 20px;">Calculate Amount</button>
            </div>

            <!-- Spare Parts Amount -->
            <div class="middle-panel" style="margin-bottom:0;">
                <span class="middle-panel-title">Spare Parts Amount</span>
                <div id="sparepartsamountdiv">
                    <jsp:include page="sparePartsAmountGrid.jsp"></jsp:include>
                </div>
            </div>

            <!-- Hidden Properties -->
            <div style="display:none;">
                <input type="hidden" id="brhid" name="brhid" value='<s:property value="brhid"/>'/>
                <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
                <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
                <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
                <input type="hidden" name="sparePartsNewGridlength" id="sparePartsNewGridlength" value='<s:property value="sparePartsNewGridlength"/>'/>
                <input type="hidden" name="labourcostgridlength" id="labourcostgridlength" value='<s:property value="labourcostgridlength"/>'/>
                <input type="hidden" name="total" id="total" value='<s:property value="total"/>'/>
                <input type="hidden" name="docdateconfig" id="docdateconfig" value='<s:property value="docdateconfig"/>'/>
                <input type="hidden" name="estprintconfig" id="estprintconfig" value='<s:property value="estprintconfig"/>'/>  
            </div>
            
        </div>
    </form>
</div>

<!-- Popup Windows -->
<div id="searchwindow">
    <div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
</div>
<div id="partssearchwindow">
    <div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
</div>
<div id="laboursearchwindow">
    <div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
</div>
<div id="clientwindow">
    <div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
</div>
<div id="printWindow">
    <div></div><div></div>
</div>
<div id="emailWindow">
    <div></div><div></div>
</div>

</body>
</html>