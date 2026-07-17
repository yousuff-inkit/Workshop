<%@page import="com.controlcentre.masters.salesmanmaster.insurancesurvivor.*" %>
<%ClsInsuranceSurvivorDAO crad =new ClsInsuranceSurvivorDAO(); %>

<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<script type="text/javascript">
  $(document).ready(function () {     
		 
	  $('#accountWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	  $('#accountWindow').jqxWindow('close');

	 $("#rentalagentdate").jqxDateTimeInput({width : '125px',height : '15px',formatString : "dd.MM.yyyy"});
      		    $('#cldocno').dblclick(function(){
		  	    $('#accountWindow').jqxWindow('open');
		  	    var url=document.URL;
	            var reurl=url.split("com/");
		  	        accountSearchContent(reurl[0]+'com/search/clientaccountsearch/vendorSearch.jsp?dtype='+document.getElementById("formdetailcode").value);
      		 }); 
      		    
      		    document.getElementById("formdet").innerText="Insurance Surveyor(WIS)";
	     		document.getElementById("formdetail").value="Insurance Surveyor";
	     		document.getElementById("formdetailcode").value="WIS";
	     		window.parent.formCode.value="WIS";
	     		window.parent.formName.value="Insurance Surveyor";
	     		var data='<%=crad.searchDetails()%>';
	      		 var source =
	            {
	                datatype: "json",
	                datafields: [
	                          	{name : 'doc_no' , type: 'int' },
	     						{name : 'sal_name', type: 'String'  },
	                          	{name : 'mail', type: 'String'  },
	                          	{name : 'cldocno',type:'string'},
	                          	{name : 'refname',type:'String'},
	                          	{name : 'mobile',type:'string'},
	                          	{name : 'sal_code',type:'string'},
	                          	{name :'date',type:'date'},
	                          	{name : 'acdoc',type:'String'},
	                          	{name : 'active',type:'String'}
	                 ],
	                 localdata: data,
	                
	                
	                pager: function (pagenum, pagesize, oldpagenum) {
	                    // callback called when a page or page size is changed.
	                }
	            };
	            
	            var dataAdapter = new $.jqx.dataAdapter(source,
	            		 {
	                		loadError: function (xhr, status, error) {
	   	                   // alert(error);    
	   	                    }
	   		            }		
	            ); 
	            $("#jqxRentalagentSearch1").jqxGrid(
	                    {
	                    	width: '100%',
	                    	height:310,
	                        source: dataAdapter,
	                        showfilterrow: true,
	                        filterable: true,
	                        selectionmode: 'singlerow',
	                        sortable: true,
	                        altrows:true,
	                        //Add row method
	                        columns: [
	        					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
	        					{ text: 'Code',datafield: 'sal_code', width: '10%',hidden:true },
	        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
	        					{ text: 'Name', datafield: 'sal_name', width: '20%' },
	        					{ text: 'Vendor',columntype: 'textbox', filtertype: 'input', datafield: 'refname', width: '30%' },
	        					{ text: 'Vendor No',columntype: 'textbox', filtertype: 'input', datafield: 'cldocno', width: '50%' ,hidden:true},
	        					{ text: 'Email',columntype: 'textbox', filtertype: 'input', datafield: 'mail', width: '15%' },
	        					{ text: 'Mobile',columntype: 'textbox', filtertype: 'input', datafield: 'mobile', width: '15%' },
	        					{ text: 'Ac No',columntype: 'textbox', filtertype: 'input', datafield: 'acdoc', width: '15%',hidden:true },
	        					{ text: 'Active',columntype: 'textbox', filtertype: 'input', datafield: 'active', width: '15%',hidden:true },

	        	              ]
	                    });

	            $('#jqxRentalagentSearch1').on('rowdoubleclick', function (event) 
	            		{ 
	   		            	var rowindex1=event.args.rowindex;
	   		                document.getElementById("docno").value= $('#jqxRentalagentSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
	   		                document.getElementById("code").value = $("#jqxRentalagentSearch1").jqxGrid('getcellvalue', rowindex1, "sal_code");
	   		                document.getElementById("name").value = $("#jqxRentalagentSearch1").jqxGrid('getcellvalue', rowindex1, "sal_name");
	   		                document.getElementById("mail").value = $("#jqxRentalagentSearch1").jqxGrid('getcellvalue', rowindex1, "mail");
	   		                document.getElementById("mobile").value = $("#jqxRentalagentSearch1").jqxGrid('getcellvalue', rowindex1, "mobile");
	   		                $("#rentalagentdate").jqxDateTimeInput('val', $("#jqxRentalagentSearch1").jqxGrid('getcellvalue', rowindex1, "date")); 
	   		                document.getElementById("cldocno").value = $("#jqxRentalagentSearch1").jqxGrid('getcellvalue', rowindex1, "cldocno");
	   		                document.getElementById("clientname").value = $("#jqxRentalagentSearch1").jqxGrid('getcellvalue', rowindex1, "refname");
	   		             document.getElementById("hidacno").value = $("#jqxRentalagentSearch1").jqxGrid('getcellvalue', rowindex1, "acdoc");
	   		          document.getElementById("cmbactive").value = $("#jqxRentalagentSearch1").jqxGrid('getcellvalue', rowindex1, "active");
	            		 }); 
	      		  
	      		  
	      		  
	     		
	     		
	     		
      		 });

 function getAcc(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#accountWindow').jqxWindow('open');
	    var url=document.URL;
	     var reurl=url.split("com/");
		  	  accountSearchContent(reurl[0]+'com/search/clientaccountsearch/vendorSearch.jsp?dtype='+document.getElementById("formdetailcode").value);
	 }
	 else{}
	 }

 function accountSearchContent(url) {
		 $.get(url).done(function (data) {
		$('#accountWindow').jqxWindow('setContent', data);
	}); 
	}

function funSearchLoad(){
	changeContent('insuranceSurvivorSearch.jsp'); 
 }

function funReadOnly(){
	$('#frmRentalAgent input').attr('readonly', true );
	$('#rentalagentdate').jqxDateTimeInput({ disabled: true}); 
}

function funRemoveReadOnly(){
	$('#frmRentalAgent input').attr('readonly', false );
	$('#rentalagentdate').jqxDateTimeInput({ disabled: false}); 
	$('#docno').attr('readonly', true);
	$('#txtaccno').attr('readonly', true);
	$('#txtaccname').attr('readonly', true);
}

function setValues() {
	if($('#hidrentalagentdate').val()){
		$("#rentalagentdate").jqxDateTimeInput('val', $('#hidrentalagentdate').val());
	}

	if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
	
	
	
if($('#hidactive').val()!=""){
		
		document.getElementById("cmbactive").value=$('#hidactive').val();
}
	
	
	
}

function funFocus(){
	document.getElementById("code").focus();
}

function funNotify(){
	if(document.getElementById("cldocno").value==''){
		document.getElementById("errormsg").innerText="Vendor is Mandatory.";
		return 0;
	}
	document.getElementById("errormsg").innerText="";
	return 1;
}

$(function(){
    $('#frmRentalAgent').validate({
        rules: {
            code: {required:true,maxlength:10},
            name:{required:true,maxlength:40},
            cldocno:{required:true},
            mobile:{required:true,digits:true,minlength:12,maxlength:12},
            mail:{email:true}
            },
            messages: {
           	 code:{required:" *",maxlength:"Max 10 Chars."},
           	 name:{required:" *",maxlength:"Max 40 Chars."},
           	 cldocno:{required:" *"},
             mobile:{required:" *",digits:"Digits only.",minlength:"Min 12 Chars.",maxlength:'Max 12 Chars.'},
             mail:{email:"Not a valid Email"}
            }
   });});
function funExcelBtn(){
  	 $("#jqxRentalagentSearch1").jqxGrid('exportdata', 'xls', 'Rental Agents');
  }
</script>
</head>
<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmRentalAgent" action="saveActionInsuranceSurvivor"  autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/> 
<fieldset>
<legend>Insurance Surveyor Details</legend>
<table width="100%">
  <tr>
    <td width="5%" align="right">Date</td>
    <td width="16%"><div id="rentalagentdate" name="rentalagentdate" value='<s:property value="rentalagentdate"/>'></div></td>
    
    
    
    
    <td align="right" width="10%" >Active</td>
    <td align="left" width="10%" ><select name="cmbactive" id="cmbactive" style="width:40%;"  value='<s:property value="cmbactive"/>' >
      <option value="1" >Active</option>
      <option value="0" >Inactive</option>
    </select></td>
    
    
    
    
    
    
    
    <td colspan="1" align="right">Doc No.</td>
    <td width="30%"><input type="text" id="docno" name="docno" value='<s:property value="docno"/>' readonly tabindex="-1"></td>
  </tr>
  <tr>
    <td align="right">Code</td>
    <td><input type="text" id="code" name="code" placeholder="Code" value='<s:property value="code"/>' ></td>
    <td width="11%" align="right">Name</td>
    <td width="33%"><input type="text" name="name" id="name" placeholder="Code Name" value='<s:property value="name"/>' style="width:59%;" ></td>
    <td width="5%" align="right">Email</td>
    <td><input type="email" name="mail" id="mail" style="width:80%;" placeholder="someone@example.com" value='<s:property value="mail"/>'></td>
  </tr>
  <tr>
    <td align="right">Vendor</td>
    <td><input type="text" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>' onKeyDown="getAcc(event);" readonly placeholder="Press F3 to Search"></td>
    <td colspan="2"><input type="text" name="clientname" id="clientname" value='<s:property value="clientname"/>'  style="width:70%;" readonly></td>
    <td align="right">Mobile</td>
    <td><input type="text" name="mobile" id="mobile" value='<s:property value="mobile"/>'></td>
  </tr>
</table>
</fieldset>

<input type="hidden" name="hidrentalagentdate" id="hidrentalagentdate" value='<s:property value="hidrentalagentdate"/>'>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
<input type="hidden" name="hidacno" id="hidacno" value='<s:property value="hidacno"/>'/>
<input type="hidden" name="hidactive" id="hidactive" value='<s:property value="hidactive"/>'/>
</form>
<div id="accountWindow">
	<div ></div>
</div>
		<div id="jqxRentalagentSearch1"></div>	 
</div>
</body>
</html>

