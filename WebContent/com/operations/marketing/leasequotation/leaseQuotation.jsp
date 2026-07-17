<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<% String mod = request.getParameter("mod") == null ? "view" : request.getParameter("mod").toString();
   String docno = request.getParameter("docno") == null? "0": request.getParameter("docno").toString();
   String leasereqdocno = request.getParameter("leasereqdocno") == null? "0": request.getParameter("leasereqdocno").toString();
   String cldocno = request.getParameter("cldocno") == null? "0": request.getParameter("cldocno").toString();
   String client = request.getParameter("client") == null? "0": request.getParameter("client").toString();
   String address = request.getParameter("address") == null? "0": request.getParameter("address").toString();
   String mobile = request.getParameter("mobile") == null? "0": request.getParameter("mobile").toString();
   String email = request.getParameter("email") == null? "0": request.getParameter("email").toString();
   String sal_name = request.getParameter("sal_name") == null? "0": request.getParameter("sal_name").toString();
    String vocno = request.getParameter("vocno") == null? "0": request.getParameter("vocno").toString(); %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<script type="text/javascript">
var mod1='<%=mod%>';
	 
	$(document).ready(function () {
		 /* $('#btnClose').attr('disabled', true );$('#btnCreate').attr('disabled', true );$('#btnEdit').attr('disabled', true );$('#btnPrint').attr('disabled', true );
		 $('#btnExcel').attr('disabled', true );$('#btnDelete').attr('disabled', true );$('#btnAttach').attr('disabled', true ); */
		 
		$("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		
		$('#leaseCalculatorDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Lease Calculator Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		$('#leaseCalculatorDetailsWindow').jqxWindow('close');  
		
		$('#termsAndConditionGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Terms and Condition Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		$('#termsAndConditionGridWindow').jqxWindow('close');
		 
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
  	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
  	     
  	   $('#txtquotationvocno').dblclick(function(){
		  if($('#cmbtype').val()==''){
			 document.getElementById("errormsg").innerText="Please Choose Lease Calculator & Search.";
			 return 0;
		  }
		  leaseCalculatorSearchContent('leaseCalculatorDetailsSearch.jsp');
		});
  	    
	});
	
	function leaseCalculatorSearchContent(url) {
		$('#leaseCalculatorDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#leaseCalculatorDetailsWindow').jqxWindow('setContent', data);
		$('#leaseCalculatorDetailsWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function termsSearchContent(url) {
		$('#termsAndConditionGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#termsAndConditionGridWindow').jqxWindow('setContent', data);
		$('#termsAndConditionGridWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function getLeaseCalcInfo(event){
        var x= event.keyCode;
        if(x==114){
        	if($('#cmbtype').val()==''){
   			 document.getElementById("errormsg").innerText="Please Choose Lease Calculator & Search.";
   			 return 0;
   		  }
   		  leaseCalculatorSearchContent('leaseCalculatorDetailsSearch.jsp');
        }
        else{}
        }
	
	function changeInsertTypeInfo(){
		
		var leasecalc = $("#cmbtype").val();
		
		if(leasecalc=='LEC') {
			$("#txtquotationno").val('');$("#txtquotationvocno").val('');$("#txtquotationvocno").show();
			
			if (document.getElementById("txtquotationvocno").value == "") {
		        $('#txtquotationvocno').attr('placeholder', 'Press F3 to Search'); 
		    }
		} else {
			$("#txtquotationvocno").hide();
		}
	}
	 
	function gridLoad(){
	    var dtype=document.getElementById("formdetailcode").value;
	    $("#termsDiv").load("termsGrid.jsp?dtype="+dtype);
	}
	
	 /* Validations */
	   $(function(){
	        $('#frmLeaseQuotation').validate({
	        	 rules: {
	        		    cmbtype:"required",
	        		    txtcustomername:"required"
		                 },
		       messages: {
		    	         cmbtype:" *",
		    	         txtcustomername:{required:" *"}
		                 }
	        });});
	
	function funReadOnly() {
		$('#frmLeaseQuotation input').attr('readonly', true);
		$('#frmLeaseQuotation select').attr('disabled', true);
		$('#date').jqxDateTimeInput({disabled:true});
		$('#chckleasetoown').attr('disabled', true);
		$("#leaseReqGrid").jqxGrid({ disabled: true});
		$("#jqxTerms").jqxGrid({ disabled: true});

		if(document.getElementById("status").value.trim()=="0" )
		{
		mod1="view";
		}
		if(mod1=="A")
			{
			
			 document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
			document.getElementById("formdetail").value=window.parent.formName.value;
			document.getElementById("formdetailcode").value=window.parent.formCode.value.trim(); 
			funCreateBtn();
			}
	}
	
	function funRemoveReadOnly() {
		$('#frmLeaseQuotation input').attr('readonly', false);
		$('#frmLeaseQuotation select').attr('disabled', false);
		$('#date').jqxDateTimeInput({disabled:false});
		$("#leaseReqGrid").jqxGrid({ disabled: false});
		$("#jqxTerms").jqxGrid({ disabled: false});
		$('#chckleasetoown').attr('disabled', false);
		$('#docno').attr('readonly', true);
		$('#txtquotationvocno').attr('readonly', true);
		$('#txtcustomername').attr('readonly', true);
		$('#txtcustomeraddress').attr('readonly', true);
		$('#txtcustomermobile').attr('readonly', true);
		$('#txtcustomeremail').attr('readonly', true);
		$('#txtsalesman').attr('readonly', true);
		
		if ($("#mode").val() == "A") {
			gridLoad();
			$('#date').val(new Date());
			$('#cmbtype').val('LEC');
			$('#hidchckleasetoown').val(1);
			document.getElementById("chckleasetoown").checked = true;
			$("#leaseReqGrid").jqxGrid('clear');
			$("#leaseReqGrid").jqxGrid('addrow', null, {});
		}
		
		if ($("#mode").val() == "E") {
			//$("#leaseReqGrid").jqxGrid('addrow', null, {});
			$("#leaseQuotationDiv").load("leaseQuotationGrid.jsp?leaseQuotationDocno="+$('#docno').val()+"&reqdocno="+$('#leasereqdoc').val()+"&docno="+$('#txtquotationno').val()+"&mode="+$('#mode').val());
		}

		 if(mod1=="A")
			{
			
			  document.getElementById("txtquotationno").value='<%=docno%>'; 
              document.getElementById("leasereqdoc").value = '<%=leasereqdocno%>';
              document.getElementById("txtcustomerdocno").value='<%=cldocno%>';
              document.getElementById("txtcustomername").value='<%=client%>';
              document.getElementById("txtcustomeraddress").value='<%=address%>';
              document.getElementById("txtcustomermobile").value='<%=mobile%>';
              document.getElementById("txtcustomeremail").value='<%=email%>';
              document.getElementById("txtsalesman").value='<%=sal_name%>';
              document.getElementById("txtquotationvocno").value='<%=vocno%>';
              $('#leaseQuotationDiv').load('leaseQuotationGrid.jsp?reqdocno='+document.getElementById("leasereqdoc").value+'&docno='+document.getElementById("txtquotationno").value);
              
			}

	}
	
	function funNotify(){	
		
		 valid=document.getElementById("txtadvanceamountvalidation").value;
		 if(valid==1){
			 document.getElementById("errormsg").innerText="Limit Already Reached,Invalid Advance Amount.";
			 return 0;
		 }
		 
		 valid=document.getElementById("txtinstallmentvalidation").value;
		 if(valid==1){
			 document.getElementById("errormsg").innerText="Installment/Month need not be greater than Lease in Months.";
			 return 0;
		 }
		 
		 type=document.getElementById("cmbtype").value;
		 quotationno=document.getElementById("txtquotationno").value;
		 if(type=="LEC" && quotationno.trim()==""){
			 document.getElementById("errormsg").innerText="Type & Lease Calculator Number is Mandatory.";
			 return 0;
		 }
		
		/* Lease Application Grid  Saving*/
		  var rows = $("#leaseReqGrid").jqxGrid('getrows');
		  var length=0;
		  for(var i=0 ; i < rows.length ; i++) {
			    var chk=rows[i].amountpermonth;
			    var chks=rows[i].advance;
			    if((typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != "" && chk != "0") || (typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != "" && chks != "0")){
					newTextBox = $(document.createElement("input"))
				    .attr("type", "dil")
				    .attr("id", "test"+length)
				    .attr("name", "test"+length)
				    .attr("hidden", "true");
					length=length+1;
					
				newTextBox.val(rows[i].leasefromdate+":: "+rows[i].brdid+":: "+rows[i].modelid+":: "+rows[i].specification+":: "+rows[i].clrid+":: "+rows[i].leasemonths+":: "+rows[i].kmpermonth+":: "+rows[i].grpid+":: "+rows[i].rateperamount+":: "+rows[i].totalcost+":: "+rows[i].advance+":: "+rows[i].noofinstallments+":: "+rows[i].amountpermonth+"::"+rows[i].cdw+"::"+rows[i].qty+"::"+rows[i].reqsrno); 
				newTextBox.appendTo('form');
				}
		      }
		      $('#gridlength').val(length);
	 		  /* Lease Application Grid  Saving Ends*/	
	 		  
		   var rows1 = $("#jqxTerms").jqxGrid('getrows');
		   $('#termsgridlen').val(rows1.length);

		   for(var j=0 ; j < rows1.length ; j++){
		      				   
   				   newTextBox = $(document.createElement("input"))
   				      .attr("type", "dil")
   				      .attr("id", "termg"+j)
   				      .attr("name", "termg"+j)
   				      .attr("hidden", "true");
   				   
   				   
   				  newTextBox.val(rows1[j].voc_no+"::"+rows1[j].dtype+"::"+rows1[j].terms+"::"+rows1[j].conditions+"::");
   				  newTextBox.appendTo('form');
		     }
	 		   
		   return 1;
	} 
	 
	function funChkButton() {
		/* funReset(); */
	}
	
	function funSearchLoad(){
	   changeContent('lqtMainSearch.jsp');  
	}
	 
	function funFocus() {
		$('#date').jqxDateTimeInput('focus');
	 }
	
	function setValues(){
		
		document.getElementById("cmbtype").value=document.getElementById("hidcmbtype").value;
		  
		  if($('#hiddate').val()){
				 $("#date").jqxDateTimeInput('val', $('#hiddate').val());
			  }
		  
		  if(document.getElementById("hidchckleasetoown").value==1){
	 			 document.getElementById("chckleasetoown").checked = true;
	 	  } else if(document.getElementById("hidchckleasetoown").value==0){
	 			document.getElementById("chckleasetoown").checked = false;
	 	  }
		  
		if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		 funSetlabel();
		 
		 var indexVal = document.getElementById("docno").value;
		 if(indexVal>0){
			var dtype=$('#formdetailcode').val().trim();
         	$("#leaseQuotationDiv").load("leaseQuotationGrid.jsp?leaseQuotationDocno="+indexVal);
			$("#termsDiv").load("termsGrid.jsp?dtype="+dtype+"&qotdoc="+indexVal);
		 } 

		if(mod1=="A")
			{
			 document.getElementById("cmbtype").value="LEC";
			}

	}
	
	function funPrintBtn() {
		
		if (($("#mode").val() == "view") && $("#docno").val()!="") {
			
			 var url=document.URL;
		     var reurl=url.split("saveLeaseQuotation");
		     $("#docno").prop("disabled", false);
				  
			var win= window.open(reurl[0]+"printLeaseQuotation?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&leasereqdocno="+document.getElementById("txtquotationno").value,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
		    win.focus();
					
	     }
	    else {
			$.messager.alert('Message','Select a Document....!','warning');
			return;
		}
    }
	
	 function funleaseToOwn(){
 		 if(document.getElementById("chckleasetoown").checked){
 			 document.getElementById("hidchckleasetoown").value = 1;
 		 }
 		 else{
 			 document.getElementById("hidchckleasetoown").value = 0;
 		 }
 	 }
	
</script>

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>
			
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmLeaseQuotation" action="saveLeaseQuotation" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div  class='hidden-scrollbar'>
<table width="100%">
  <tr>
    <td width="3%" height="42" align="right">Date</td>
    <td width="11%"><div id="date" name="date" value='<s:property value="date"/>'></div>
    <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddate"/>'/></td>
    <td width="26%" align="right">Type</td>
    <td width="8%"><select id="cmbtype" name="cmbtype" style="width:90%;" onchange="changeInsertTypeInfo();" value='<s:property value="cmbtype"/>'>
    <option value="LEC">Lease Calculator</option></select>
    <input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'/></td>
    <td width="25%"><input type="text" id="txtquotationvocno" name="txtquotationvocno" placeholder="Press F3 to Search" style="width:40%;" onkeydown="getLeaseCalcInfo(event);" value='<s:property value="txtquotationvocno"/>'/>
    <input type="hidden" id="txtquotationno" name="txtquotationno" value='<s:property value="txtquotationno"/>'></td>
    <td width="6%" align="right">Doc No.</td>
    <td width="21%"><input type="text" id="docno" name="docno" style="width:50%;" value='<s:property value="docno"/>' tabindex="-1"/></td>
  </tr>
</table>

<fieldset>
<table width="100%">
  <tr>
    <td width="10%" align="right">Customer Name</td>
    <td colspan="3"><input type="text" id="txtcustomername" name="txtcustomername" style="width:56%;" value='<s:property value="txtcustomername"/>'>
    <input type="hidden" id="txtcustomerdocno" name="txtcustomerdocno" value='<s:property value="txtcustomerdocno"/>'></td>
  </tr>
  <tr>
    <td align="right">Address</td>
    <td colspan="3"><input type="text" id="txtcustomeraddress" name="txtcustomeraddress" style="width:56%;" value='<s:property value="txtcustomeraddress"/>'></td>
  </tr>
  <tr>
    <td align="right">Mobile</td>
    <td width="21%"><input type="text" id="txtcustomermobile" name="txtcustomermobile" style="width:60%;" value='<s:property value="txtcustomermobile"/>'></td>
    <td width="6%" align="right">Email</td>
    <td width="63%"><input type="text" id="txtcustomeremail" name="txtcustomeremail" style="width:37%;" value='<s:property value="txtcustomeremail"/>'></td>
  </tr>
  <tr>
    <td align="right">Salesman</td>
    <td colspan="3"><input type="text" id="txtsalesman" name="txtsalesman" style="width:56%;" value='<s:property value="txtsalesman"/>'>&nbsp;&nbsp;
    <input type="checkbox" id="chckleasetoown" name="chckleasetoown" value="" onchange="funleaseToOwn();" onclick="$(this).attr('value', this.checked ? 1 : 0)">Lease to Own
                                 <input type="hidden" id="hidchckleasetoown" name="hidchckleasetoown" value='<s:property value="hidchckleasetoown"/>'/></td>
  </tr>
</table>
</fieldset><br/>

<div id="leaseQuotationDiv"><jsp:include page="leaseQuotationGrid.jsp"></jsp:include></div><br/>
<div id="termsDiv"><jsp:include page="termsGrid.jsp"></jsp:include></div>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
<input type="hidden" id="termsgridlen" name="termsgridlen"/>
<input type="hidden" id="leasereqdoc" name="leasereqdoc" value='<s:property value="leasereqdoc"/>'/>
<input type="hidden" id="txtadvanceamountvalidation" name="txtadvanceamountvalidation" value='<s:property value="txtadvanceamountvalidation"/>'/>
<input type="hidden" id="txtinstallmentvalidation" name="txtinstallmentvalidation" value='<s:property value="txtinstallmentvalidation"/>'/>
</div>
</form>

<div id="leaseCalculatorDetailsWindow">
	<div></div><div></div>
</div>  

<div id="termsAndConditionGridWindow">
	<div></div><div></div>
</div> 	
		
</div>
</body>
</html>