<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../includes.jsp"></jsp:include>
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

.modern-ui input[type="checkbox"] {
    width: 14px !important;
    height: 14px !important;
    margin: 0;
    cursor: pointer;
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
.modern-ui .myButton,
.modern-ui button.icon {
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
.modern-ui .myButton:hover,
.modern-ui button.icon:hover { background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); }

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

<script type="text/javascript">
    $(document).ready(function() {
        
        /* Set jqxDateTimeInput to 24px height with modern UI theme */
        $("#jqxRentalReceiptDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
        $("#maindate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
        $("#jqxReferenceDate").jqxDateTimeInput({ width: '110px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});       
    
        /* force internal alignment AFTER render */
        setTimeout(function () {
            $("#jqxRentalReceiptDate, #maindate, #jqxReferenceDate").find("input").css({
                "margin-top": "0px",
                "line-height": "24px",
                "font-size": "12px", 
                "font-family": "Arial, sans-serif", 
                "padding": "0 6px", 
                "box-sizing":"border-box"
            });
            $("#jqxRentalReceiptDate, #maindate, #jqxReferenceDate").find(".jqx-action-button").css({
                "top": "0px",
                "height": "24px"
            });
        }, 0);

        $('#clientDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
        $('#clientDetailsWindow').jqxWindow('close'); 
        
        $('#cardDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Card Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
        $('#cardDetailsWindow').jqxWindow('close');
        
        $('#jqxRentalReceiptDate').on('change', function (event) {
                 var rentalreceiptdate = $('#jqxRentalReceiptDate').jqxDateTimeInput('getDate');
                 funDateInPeriod(rentalreceiptdate);
             });
        
         $('#txtclientid').dblclick(function(){
              var date = $('#jqxRentalReceiptDate').jqxDateTimeInput('getDate');
              $("#maindate").jqxDateTimeInput('val', date);
              clientSearchContent("clientAccountDetailsSearch.jsp?atype=AR"+"&date="+date);
              });
              
         $('#txtreceivedfrom').keydown(function (evt) {
              if (evt.keyCode==9) {
                  event.preventDefault();
                  $('#jqxApplyInvoice').jqxGrid('selectcell',0, 'applying');
                  $('#jqxApplyInvoice').jqxGrid('focus',0, 'applying');
              }
         });
        
        
         //Rounding
         $('#txtapplyinvoicebalance').change(function(){
            var targetid=$(this).attr('id');
            var targetvalue=$(this).val();
            $('#'+targetid).val(funRoundAmt(targetvalue,targetid));
         });
    });
    
    function clientSearchContent(url) {
        $('#clientDetailsWindow').jqxWindow('open');
        $.get(url).done(function (data) {
        $('#clientDetailsWindow').jqxWindow('setContent', data);
        $('#clientDetailsWindow').jqxWindow('bringToFront');
    }); 
    }
    
    function cardSearchContent(url) {
        $('#cardDetailsWindow').jqxWindow('open');
        $.get(url).done(function (data) {
        $('#cardDetailsWindow').jqxWindow('setContent', data);
        $('#cardDetailsWindow').jqxWindow('bringToFront');
    }); 
    }
    
    function checkIb(){
         if(document.getElementById("hidchckib").value==1){
             document.getElementById("chckib").checked = true;
         }
         else if(document.getElementById("hidchckib").value==0){
            document.getElementById("chckib").checked = false;
          }
         }
    
     function funReadOnly(){
            $('#frmCommercialReceipt input').attr('readonly', true );
            $('#frmCommercialReceipt select').attr('disabled', true);
            $('#jqxRentalReceiptDate').jqxDateTimeInput({disabled: true});
            $('#jqxReferenceDate').jqxDateTimeInput({disabled: true});
            $('#btnCardSearch').attr('disabled', true);
            $("#jqxApplyInvoice").jqxGrid({ disabled: true});
            
     }
     function funRemoveReadOnly(){
            getBranch();getCardTypes();checkIb();
            $('#frmCommercialReceipt input').attr('readonly', false );
            $('#frmCommercialReceipt select').attr('disabled', false);
            
            $('#jqxRentalReceiptDate').jqxDateTimeInput({disabled: false});
            $('#jqxReferenceDate').jqxDateTimeInput({disabled: false});
            $('#btnCardSearch').attr('disabled', true);
            $('#docno').attr('readonly', true);
            $('#txtdoctype').attr('readonly', true);
            $('#txtsrno').attr('readonly', true);
            $('#txtaccid').attr('readonly', true);
            $('#txtaccname').attr('readonly', true);
            $('#txtclientid').attr('readonly', true);
            $('#txtclientname').attr('readonly', true);
            $('#txtnetvalue').attr('readonly', true ); 
            $('#txtapplyinvoiceamt').attr('readonly', true );
            $('#txtapplyinvoiceapply').attr('readonly', true );
            $('#txtapplyinvoicebalance').attr('readonly', true );
            $('#cmbbranch').attr('disabled', true);
            $("#jqxApplyInvoice").jqxGrid({ disabled: false}); 
            
            if ($("#mode").val() == "E") {
                if($('#chkstatus').val()=="2"){
                    $('#cmbpaytype').attr('disabled', true);
                    $('#chckib').attr('disabled', true);
                    $('#cmbbranch').attr('disabled', true);
                    $('#txtaccid').attr('readonly', true);
                    $('#txtaccname').attr('readonly', true);
                }else{
                    $('#cmbpaytype').attr('disabled', true);
                    $('#chckib').attr('disabled', true);
                    $('#cmbbranch').attr('disabled', true);
                    $('#txtaccid').attr('readonly', true);
                    $('#txtaccname').attr('readonly', true);
                }
              }
            
            if ($("#mode").val() == "A") {
                if($('#chkstatus').val()=="1"){
                    funchequedate();
                }else{
                    $('#cmbpaytype').val('');$('#cmbcardtype').val('');
                    $('#jqxRentalReceiptDate').val(new Date());
                    $("#jqxApplyInvoice").jqxGrid('clear');
                    $("#jqxApplyInvoice").jqxGrid('addrow', null, {});
                }
            }
     }
    
     function funSearchLoad(){
        changeContent('rrvMainSearch.jsp'); 
     }
        
     function funChkButton() {
            /* funReset(); */
        }
    
     function funFocus()
    {
        $('#jqxRentalReceiptDate').jqxDateTimeInput('focus');           
    }
    
     /* Validations */
        $(function(){
            $('#frmCommercialReceipt').validate({
                    rules: {
                //txtfromaccid:"required",
                txtamount:{number:true},
                txtdiscount:{number:true},
                txtaddcharges:{number:true},
                txtdescription:{maxlength:500},
                txtdescriptions:{maxlength:500}
                 },
                 messages: {
                 //txtfromaccid:" *",
                 txtamount:{number:"Invalid"},
                 txtdiscount:{number:"Invalid"},
                 txtaddcharges:{number:"Invalid"},
                 txtdescription: {maxlength:"   Max 500 chars"},
                 txtdescriptions: {maxlength:"   Max 500 chars"}
                 }
        });}); 
       
      function funNotify(){ 
          /* Validation */
          
            var rentalreceiptdate = $('#jqxRentalReceiptDate').jqxDateTimeInput('getDate');
            var validdate=funDateInPeriod(rentalreceiptdate);
            if(validdate==0){
            return 0;   
            }
            
            backdatevalid=document.getElementById("txtbackdatevalidation").value;
             if(backdatevalid==1){
                 document.getElementById("errormsg").innerText="Past Date, Transaction Restricted.";
                 return 0;
             }
            
            ibvalid=document.getElementById("txtibvalidation").value;
             if(ibvalid==1){
                 document.getElementById("errormsg").innerText="Closing Done For Inter-Branch,Transaction Restricted. ";
                 return 0;
             }
            
             valid=document.getElementById("txtvalidation").value;
             if(valid==1){
                 document.getElementById("errormsg").innerText="Invalid Transaction !!!";
                 return 0;
             }
            
             if($('#txtcldocno').val()==''){
                 document.getElementById("errormsg").innerText="Client is Mandatory.";
                 return 0;
             }
            
             if($('#cmbpaytype').val()=='2' && $('#cmbcardtype').val()==''){
                 document.getElementById("errormsg").innerText="Choose a Card Type.";
                 return 0;
             }
          
        document.getElementById("errormsg").innerText="";
            
    /* Validation Ends*/
    
                /* Apply Invoice Grid Saving */
                var rows = $("#jqxApplyInvoice").jqxGrid('getrows');
                var length=0;
                 for(var i=0 ; i < rows.length ; i++){
                    var chk=rows[i].applying;
                    if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
                        newTextBox = $(document.createElement("input"))
                        .attr("type", "hidden")
                        .attr("id", "txtapply"+length)
                        .attr("name", "txtapply"+length)
                        .attr("hidden", "true");
                        length=length+1;
                        
                    newTextBox.val(rows[i].applying+"::"+parseFloat(rows[i].out_amount+rows[i].applying)+"::"+rows[i].currency+"::"+rows[i].tranid+"::"+rows[i].acno);
                    newTextBox.appendTo('form');
                    }
                  }
                $('#applylength').val(length);
                 /* Apply Invoice Grid Saving Ends*/
                
                 /* Apply Invoice Grid Updating */
                    var rows = $("#jqxApplyInvoice").jqxGrid('getrows');
                    var lengthupdate=0;
                     for(var i=0 ; i < rows.length ; i++){
                        var chks=rows[i].applying;
                        if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != ""){
                            
                            newTextBox = $(document.createElement("input"))
                            .attr("type", "hidden")
                            .attr("id", "txtapplyupdate"+lengthupdate)
                            .attr("name", "txtapplyupdate"+lengthupdate)
                            .attr("hidden", "true");
                            lengthupdate=lengthupdate+1;
                            
                        newTextBox.val(parseFloat(rows[i].out_amount-rows[i].applying)+"::"+rows[i].tranid);
                        newTextBox.appendTo('form');
                        }
                       }
                    $('#applylengthupdate').val(lengthupdate);
                     /* Apply Invoice Grid Updating Ends*/
                    
                     $('#jqxRentalReceiptDate').jqxDateTimeInput({disabled: false});
                     $('#jqxReferenceDate').jqxDateTimeInput({disabled: false});
                     $('#cmbpaytype').attr('disabled', false);
                     $('#chckib').attr('disabled', false);
                     $('#cmbbranch').attr('disabled', false);
                    
            return 1;
        } 
    
      function setValues(){
          getBranch();getCardTypes();checkIb();
          
          document.getElementById("cmbpaytype").value=document.getElementById("hidcmbpaytype").value;
          document.getElementById("cmbcardtype").value=document.getElementById("hidcmbcardtype").value;
          
          if($('#chkstatus').val()=="1" || $('#chkstatus').val()=="2"){
                funchequedate();
            }

          if($('#hidjqxRentalReceiptDate').val()){
                 $("#jqxRentalReceiptDate").jqxDateTimeInput('val', $('#hidjqxRentalReceiptDate').val());
              }
          
          if($('#hidjqxReferenceDate').val()){
                 $("#jqxReferenceDate").jqxDateTimeInput('val', $('#hidjqxReferenceDate').val());
              }
          
           if($('#msg').val()!=""){
               $.messager.alert('Message',$('#msg').val());
              }
           
           document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
           funSetlabel();
        
             var indexVal1 = document.getElementById("txtacno").value;
             var indexVal2 = document.getElementById("txttranno").value;
             if(indexVal1>0){
             $("#applyInvoicing1").load("applyInvoiceGrid.jsp?txttoaccid1="+indexVal1+"&txttotrno1="+indexVal2); 
             } 
        }
    
    function getBranch() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                var branchIdItems  = items[0].split(",");
                var branchItems = items[1].split(",");
                var optionsbranch = '<option value="">--Select--</option>';
                for (var i = 0; i < branchItems.length; i++) {
                    optionsbranch += '<option value="' + branchIdItems[i].trim() + '">'
                            + branchItems[i] + '</option>';
                }
                $("select#cmbbranch").html(optionsbranch);
                if ($('#hidcmbbranch').val() != null) {
                    $('#cmbbranch').val($('#hidcmbbranch').val());
                }
            } else {
            }
        }
        x.open("GET", <%=contextPath+"/"%>+"com/operations/commtransactions/getBranch.jsp", true);
        x.send();
    }
    
     function getAccounts(a){
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    items = items.split('####');
                    var accountIdItems  = items[0];
                    var accountItems = items[1];
                    var docNoItems = items[2];
                $('#txtaccid').val(accountIdItems) ;
                $('#txtaccname').val(accountItems) ;
                $('#txtdocno').val(docNoItems) ;
            }
            }
            x.open("GET", "getAccounts.jsp?paytype="+a, true);
            x.send();
     }
    
     function getCardTypes() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    items = items.split('####');
                    var cardIdItems  = items[0].split(",");
                    var cardItems = items[1].split(",");
                    var optionscard = '<option value="">--Select--</option>';
                    for (var i = 0; i < cardItems.length; i++) {
                        optionscard += '<option value="' + cardIdItems[i].trim() + '">'
                                + cardItems[i] + '</option>';
                    }
                    $("select#cmbcardtype").html(optionscard);
                    if ($('#hidcmbcardtype').val() != null) {
                        $('#cmbcardtype').val($('#hidcmbcardtype').val());
                    }
                } else {
                }
            }
            x.open("GET", "getCardTypes.jsp", true);
            x.send();
      }
    
    function funCardSearch(){
        cardSearchContent('cardDetailsSearchGrid.jsp?clientId='+$('#txtcldocno').val());
    }
       
    function getClient(event){
        var x= event.keyCode;
        if(x==114){
            var date = $('#jqxRentalReceiptDate').jqxDateTimeInput('getDate');
            $("#maindate").jqxDateTimeInput('val', date);
            clientSearchContent("clientAccountDetailsSearch.jsp?atype=AR"+"&date="+date);
        }
       }
    
    function funclearchequecardno(){
        $('#txtrefno').val('');
    }
    
    function funCheck(a){
          if(document.getElementById("chckib").checked != false){
                 $('#hidchckib').val(1);
                 $('#cmbbranch').attr('disabled', false );
          }
          else{
              $('#hidchckib').val(0); 
              $('#cmbbranch').attr('disabled', true );
          }
      }
    
    function funchequedate(){
          paytype=document.getElementById("cmbpaytype").value;
          if(paytype==3){
              var chequedate = $('#jqxReferenceDate').jqxDateTimeInput('getDate');
              var chequeDates =new Date(chequedate).setDate(chequedate.getDate()+1); 
              $('#jqxReferenceDate').jqxDateTimeInput('setDate', new Date(chequeDates)); 
              $('#cmbcardtype').attr('disabled', true);
              $('#txtrefno').attr('readonly', false);
              $('#btnCardSearch').attr('disabled', true);
          }
          else if(paytype==1){
              $('#cmbcardtype').attr('disabled', true); 
              $('#txtrefno').attr('readonly', true);
              $('#btnCardSearch').attr('disabled', true);
              
          }
          else if(paytype==2){
              $('#cmbcardtype').attr('disabled', false); 
              $('#txtrefno').attr('readonly', false);
              $('#btnCardSearch').attr('disabled', false);
          }
    }
    
    function getNetValue(){
        var amount = $('#txtamount').val();
        var discount = $('#txtdiscount').val();
        var additional = $('#txtaddcharges').val();
        var additionalamt = $('#txtamounts').val();
        var netamount=$('#txtnetvalue').val();
        
        if(amount!=''){
            netamount=(parseFloat(amount));
        }
        
        if(discount!=''){
            netamount=((parseFloat(amount)-parseFloat(discount)));
        }
        
        if(additional!=''){
        var chkaddamt=((parseFloat(amount)-parseFloat(discount))*(parseFloat(additional)/100));
            $('#txtamounts').val(Math.round(chkaddamt*100)/100);
            netamount=((parseFloat(amount)-parseFloat(discount))) + chkaddamt;
            $('#txtnetvalue').val(Math.round(netamount*100)/100);
        }
     
        if(additionalamt!=''){
            netamount=((parseFloat(amount)-parseFloat(discount))+parseFloat(additionalamt));
        }
        
        funRoundAmt((Math.round(netamount*100)/100),"txtnetvalue");
  }
    
    function getAmount(){
          var amount = $('#txtamount').val();
          if(!isNaN(amount)){
          $('#txtapplyinvoiceamt').val(amount);
          }
          else if(isNaN(amount)){
              $('#txtapplyinvoiceamt').val(0.00);
              $('#txtamount').val(0.00);
            }
      }
    
    function funPrintBtn(){
        if (($("#mode").val() == "view") && $("#txtsrno").val()!="") {
            var url=document.URL;
            var reurl=url.split("saveCommercialReceipt");
            $("#txtsrno").prop("disabled", false);                
         
            var win= window.open(reurl[0]+"printCommercialReceipt?srno="+document.getElementById("txtsrno").value+"&branch="+document.getElementById("brchName").value,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
            win.focus();
         }
        else {
            $.messager.alert('Message','Select a Document....!','warning');
            return;
        }
    }
    
    function datechange(){
          var date = $('#jqxRentalReceiptDate').jqxDateTimeInput('getDate');
          var validdate=funDateInPeriod(date);
            if(validdate==0){
            return 0;   
            }
            var validbackdate=funBackDate(date);
            if(validbackdate==0){
            return 0;   
            }
          $("#maindate").jqxDateTimeInput('val', date);
          
          if($('#hidchckib').val()==1){
              if($('#cmbbranch').val()!='' && $('#cmbbranch').val()!=null){
                funIBDateInPeriod($('#jqxRentalReceiptDate').val(),$('#cmbbranch').val());
              }
            }
      }

function funSendmail(){
         if (($("#mode").val() == "view") && $("#docno").val()!="") {
        
        if(document.getElementById("email").value=="")
            {
            document.getElementById("errormsg").innerText="Email Id Is Not Available.";  
            return 0;
            }
        
        $("#overlay, #PleaseWait").show();
        sample();
        
         var recipient1=document.getElementById("email").value; 
        var recipient=recipient1.replace(/ /g, "%20");
         }
        else {
              $.messager.alert('Message','Select a Document....!','warning');
              return false;
             }
        
    }
 
    function sample()
    {  
        var formcode=document.getElementById("formdetailcode").value;
        var recep=document.getElementById("email").value.trim();
        var branch=<%=session.getAttribute("BRANCHID").toString()%>;
        
        $.ajaxFileUpload
          (  
              {  
                
                  url: 'rrjspToPdf.action?docno='+document.getElementById("txtsrno").value+"&formcode="+formcode+"&recep="+recep+"&branch="+branch,  
                  secureuri:false,//false  
                  fileElementId:'file', //id  <input type="file" id="file" name="file" />  
                  dataType: 'string',// json  
                  success: function (data, status)  //  
                  {  
                      // alert(status);
                       if(status=='success'){
                        
                            
                        $("#overlay, #PleaseWait").hide();
                        
                         $.messager.show({title:'Message',msg:'E-Mail Send Successfully',showType:'show',
                               style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                         });
                         
                       }
                       if(status=='error'){
                         // $.messager.alert('Message',"E-Mail Sending failed");
                         $.messager.show({title:'Message',msg:' E-Mail Sending failed',showType:'show',
                               style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                         });
                           
                       }
                       
                       $("#testImg").attr("src",data.message);
                       if(typeof(data.error) != 'undefined')  
                       {  
                           if(data.error != '')  
                           {  
                               alert(data.error);  
                           }else  
                           {  
                               alert(data.message);  
                           }  
                       }  
                  },  
                   error: function (data, status, e)
                  {  
                      alert(e);  
                  }  
              }  
          ) 
          return false;
      }
</script>
</head>

<body onload="setValues();getBranch();getCardTypes();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmCommercialReceipt" action="saveCommercialReceipt" method="post" autocomplete="off">
<jsp:include page="../../../header.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>
    <div id="errormsg"></div>

    <div class="middle-panel" style="background: #fdfdfd;">
        <span class="middle-panel-title">Receipt Info</span>
        
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 125px;">
                <div id="jqxRentalReceiptDate" name="jqxRentalReceiptDate" onchange="datechange();" value='<s:property value="jqxRentalReceiptDate"/>'></div>
            </div>
            <input type="hidden" id="hidjqxRentalReceiptDate" name="hidjqxRentalReceiptDate" value='<s:property value="hidjqxRentalReceiptDate"/>'/>

            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc Type</label>
            <input type="text" id="txtdoctype" name="txtdoctype" style="width:120px;" value='<s:property value="txtdoctype"/>' tabindex="-1" readonly/>

            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No.</label>
            <input type="text" id="docno" name="txtrentalreceiptdocno" style="width:150px;" value='<s:property value="txtrentalreceiptdocno"/>' tabindex="-1" readonly/>

            <label class="lbl-right" style="width:80px; margin-left:auto;">Receipt No.</label>
            <input type="text" id="txtsrno" name="txtsrno" style="width:120px;" value='<s:property value="txtsrno"/>' tabindex="-1" readonly/>
        </div>
    </div>

    <div style="display:flex; gap:15px; margin-bottom:15px;">
        <!-- Client Details Panel -->
        <div class="middle-panel" style="background: #fdfdfd; flex:1; margin-bottom:0; margin-top:12px;">
            <span class="middle-panel-title">Client Details</span>
            <div class="field-row">
                <label style="display:flex; align-items:center; gap:5px; font-size:12px; font-weight:bold; color:#444; cursor:pointer;">
                    <input type="checkbox" id="chckib" name="chckib" onclick="funCheck();"> Inter-Branch
                </label>
                <input type="hidden" id="hidchckib" name="hidchckib" value='<s:property value="hidchckib"/>'/>

                <label class="lbl-right" style="width:80px; margin-left:auto;">Branch</label>
                <select id="cmbbranch" name="cmbbranch" style="width:150px;" onchange="funIBDateInPeriod($('#jqxRentalReceiptDate').val(),this.value);" value='<s:property value="cmbbranch"/>'>
                    <option value=""></option>
                </select>
                <input type="hidden" id="hidcmbbranch" name="hidcmbbranch" value='<s:property value="hidcmbbranch"/>'/>
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:60px;">Client</label>
                <div class="input-search-container" style="width: 120px;">
                    <input type="text" id="txtclientid" name="txtclientid" placeholder="Press F3" value='<s:property value="txtclientid"/>' onkeydown="getClient(event);"/>
                    <svg class="magnifier-icon" onclick="$('#txtclientid').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                <input type="text" id="txtclientname" name="txtclientname" style="flex:1; margin-left:8px;" value='<s:property value="txtclientname"/>' tabindex="-1" readonly/>
                
                <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/>
                <input type="hidden" id="txtacno" name="txtacno" value='<s:property value="txtacno"/>'/>
            </div>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:60px;">Email</label>
                <input type="text" id="email" name="email" style="flex:1;" value='<s:property value="email"/>'/>
            </div>
        </div>

        <!-- Payment Details Panel -->
        <div class="middle-panel" style="background: #fdfdfd; flex:1; margin-bottom:0; margin-top:12px;">
            <span class="middle-panel-title">Payment Details</span>
            <div class="field-row">
                <label class="lbl-right" style="width:60px;">Pay Type</label>
                <select id="cmbpaytype" name="cmbpaytype" style="width:120px;" onchange="funchequedate();getAccounts(this.value);" value='<s:property value="cmbpaytype"/>'>
                    <option value="1">Cash</option>
                    <option value="2">Card</option>
                    <option value="3">Cheque/Online</option>
                </select>
                <input type="hidden" id="hidcmbpaytype" name="hidcmbpaytype" value='<s:property value="hidcmbpaytype"/>'/>
                
                <label class="lbl-right" style="width:60px; margin-left:auto;">Account</label>
                <input type="text" id="txtaccid" name="txtaccid" style="width:100px;" value='<s:property value="txtaccid"/>' tabindex="-1" readonly/>
                <input type="text" id="txtaccname" name="txtaccname" style="flex:1; margin-left:8px;" value='<s:property value="txtaccname"/>' tabindex="-1" readonly/>
                
                <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
                <input type="hidden" id="txttranno" name="txttranno" value='<s:property value="txttranno"/>'/>
            </div>
            
            <div class="field-row">
                <button type="button" class="myButton" id="btnCardSearch" title="Search Card" onclick="funCardSearch();" style="width: 32px; padding: 0; display:flex; justify-content:center; align-items:center;">
                    <img alt="Search Card" src="<%=contextPath%>/icons/cardsearch.png" style="height:16px;">
                </button>

                <label class="lbl-right" style="width:70px; margin-left:auto;">Card Type</label>
                <select id="cmbcardtype" name="cmbcardtype" style="width:100px;" onchange="funclearchequecardno();" value='<s:property value="cmbcardtype"/>'>
                    <option value="">--Select--</option>
                </select>
                <input type="hidden" id="hidcmbcardtype" name="hidcmbcardtype" value='<s:property value="hidcmbcardtype"/>'/>

                <label class="lbl-right" style="width:110px; margin-left:auto;">Chq/Card/Online</label>
                <input type="text" id="txtrefno" name="txtrefno" style="width:120px;" value='<s:property value="txtrefno"/>'/>
            </div>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:60px;">Date</label>
                <div style="width: 110px;">
                    <div id="jqxReferenceDate" name="jqxReferenceDate" value='<s:property value="jqxReferenceDate"/>'></div>
                </div>
                <input type="hidden" id="hidjqxReferenceDate" name="hidjqxReferenceDate" value='<s:property value="hidjqxReferenceDate"/>'/>
                
                <label class="lbl-right" style="width:60px; margin-left:auto;">Desc.</label>
                <input type="text" id="txtdescription" name="txtdescription" style="flex:1;" value='<s:property value="txtdescription"/>'/>
            </div>
        </div>
    </div>

    <!-- Value Details Panel -->
    <div class="middle-panel" style="background: #fdfdfd;">
        <span class="middle-panel-title">Value Details</span>
        <div class="field-row">
            <label class="lbl-right" style="width:60px;">Amount</label>
            <input type="text" id="txtamount" name="txtamount" style="width:120px; text-align:right;" value='<s:property value="txtamount"/>' onblur="funRoundAmt(this.value,this.id);getNetValue();getAmount();"/>

            <label class="lbl-right" style="width:60px; margin-left:auto;">Discount</label>
            <input type="text" id="txtdiscount" name="txtdiscount" style="width:100px; text-align:right;" value='<s:property value="txtdiscount"/>' onblur="funRoundAmt(this.value,this.id);getNetValue();"/>

            <label class="lbl-right" style="width:100px; margin-left:auto;">Add. Charges %</label>
            <input type="text" id="txtaddcharges" name="txtaddcharges" style="width:80px; text-align:right;" value='<s:property value="txtaddcharges"/>' onblur="funRoundAmt(this.value,this.id);getNetValue();"/>

            <label class="lbl-right" style="width:40px; margin-left:auto;">Amt</label>
            <input type="text" id="txtamounts" name="txtamounts" style="width:100px; text-align:right;" value='<s:property value="txtamounts"/>' onblur="funRoundAmt(this.value,this.id);"/>

            <label class="lbl-right" style="width:70px; margin-left:auto;">Net Value</label>
            <input type="text" id="txtnetvalue" name="txtnetvalue" style="width:120px; text-align:right;" value='<s:property value="txtnetvalue"/>' tabindex="-1" readonly/>
        </div>
        
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:60px;">Desc.</label>
            <input type="text" id="txtdescriptions" name="txtdescriptions" style="flex:1;" value='<s:property value="txtdescriptions"/>'/>

            <label class="lbl-right" style="width:100px; margin-left:15px;">Received From</label>
            <input type="text" id="txtreceivedfrom" name="txtreceivedfrom" style="flex:1;" value='<s:property value="txtreceivedfrom"/>'/>
        </div>
    </div>

    <!-- Apply Invoices Panel -->
    <div class="middle-panel" style="background: #fdfdfd;">
        <span class="middle-panel-title">Apply Invoices</span>
        <div id="applyInvoicing1" style="margin-bottom: 10px;">
            <jsp:include page="applyInvoiceGrid.jsp"></jsp:include>
        </div>
        <div class="field-row" style="justify-content: flex-end; margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Amount</label>
            <input type="text" id="txtapplyinvoiceamt" name="txtapplyinvoiceamt" style="width:120px; text-align:right;" value='<s:property value="txtapplyinvoiceamt"/>'/>

            <label class="lbl-right" style="width:80px; margin-left:15px;">Applied</label>
            <input type="text" id="txtapplyinvoiceapply" name="txtapplyinvoiceapply" style="width:120px; text-align:right;" value='<s:property value="txtapplyinvoiceapply"/>' tabindex="-1" readonly/>

            <label class="lbl-right" style="width:80px; margin-left:15px;">Balance</label>
            <input type="text" id="txtapplyinvoicebalance" name="txtapplyinvoicebalance" style="width:120px; text-align:right;" value='<s:property value="txtapplyinvoicebalance"/>' tabindex="-1" readonly/>
        </div>
    </div>

    <!-- Hidden Fields -->
    <div style="display:none;">
        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <div id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
        <input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
        <input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
        <input type="hidden" id="txtbackdatevalidation" name="txtbackdatevalidation" value='<s:property value="txtbackdatevalidation"/>'/>
        <input type="hidden" id="txtibvalidation" name="txtibvalidation" value='<s:property value="txtibvalidation"/>'/>
        <input type="hidden" id="applylength" name="applylength"/>
        <input type="hidden" id="applylengthupdate" name="applylengthupdate"/>
    </div>
</div>
</form> 

<div id="clientDetailsWindow">
    <div></div><div></div>
</div>
<div id="cardDetailsWindow">
    <div></div><div></div>
</div> 
</div>
</body>
</html>