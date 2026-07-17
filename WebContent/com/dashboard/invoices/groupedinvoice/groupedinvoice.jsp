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

<style>
.myButtons {
  display: inline-block;
  margin-right:4px;
  margin-left:4px; 
  margin-bottom: 0;
  font-weight: normal;
  line-height: 1.3;
  text-align: center;
  white-space: nowrap;
  vertical-align: middle;
  -ms-touch-action: manipulation;
  touch-action: manipulation;
  cursor: pointer;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
  background-image: none;
  border: 1px solid transparent;
  border-radius: 4px;
  color: #fff;
  background-color: grey;
}
.myButtons:hover {
  color: #fff;
  background-color: #31b0d5;
}
.myButtons:active {
  color: #fff;
  background-color: #31b0d5;
}
.myButtons:focus {
  color: #fff;
  background-color: grey;
}

</style>
<script type="text/javascript">

$(document).ready(function () {
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>"); 


	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});

	 $('#clientDetailsWindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	 $('#clientDetailsWindow').jqxWindow('close');
	 
	 $('#agreementDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Agreement Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#agreementDetailsWindow').jqxWindow('close');
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));

	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	    
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
     /*$('#fromdate').on('change', function (event) {
    	var docdateval=funDateInPeriod($('#fromdate').jqxDateTimeInput('getDate'));
		if(docdateval==0){
			$('#fromdate').jqxDateTimeInput('focus');
			return false;
		}
     });*/
     $('#todate').on('change', function (event) {
		
    	/*var docdateval=funDateInPeriod($('#todate').jqxDateTimeInput('getDate'));
 		if(docdateval==0){
 			$('#todate').jqxDateTimeInput('focus');
 			return false;
 		}*/
		   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  }   
	 });
	  $('#txtclientname').dblclick(function(){
		  clientSearchContent('clientDetailsSearchGrid.jsp');
		});
	  
	  $('#agmtvocno').dblclick(function(){
		 if(document.getElementById("rentaltype").value==""){
			 $.messager.alert('Warning','Please Select Agreement Type');
			 return false;
		 }
		  agreementSearchContent('agreementDetailsSearch.jsp'); 
		});
});

	function clientSearchContent(url) {
	    $('#clientDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientDetailsWindow').jqxWindow('setContent', data);
		$('#clientDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function agreementSearchContent(url) {
	 	$('#agreementDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#agreementDetailsWindow').jqxWindow('setContent', data);
		$('#agreementDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getClient(event){
	    var x= event.keyCode;
	    if(x==114){
	    	clientSearchContent('clientDetailsSearchGrid.jsp');
	    }
	    else{}
	    }
	
	function getAgreement(event){
		 if(document.getElementById("rentaltype").value==""){
			 $.messager.alert('Warning','Please Select Agreement Type');
			 return false;
		 }
		var x= event.keyCode;
	    if(x==114){
	    	 
  		    agreementSearchContent('agreementDetailsSearch.jsp');
	    }
	    else{}
	    }
	
/* 	function funSearchdblclick(){
		
	}
	 */
	 function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1")
		  {
		  	JSONToCSVCon(invoicedata, 'Grouped Invoice', true);
		  }
		 else
		  {
			 $("#rentalInvoiceGrid").jqxGrid('exportdata', 'xls', 'Grouped Invoice');
		  }
		
		   
		 }


	function  funClearData(){
		 $('#txtclientname').val('');$('#agmtvocno').val('');$('#txtcldocno').val('');$('#rentaltype').val('');$('#txtagreementno').val('');$('#todate').val(new Date());$('#clstatuss').val('');
		
		 var onemounth=new Date(new Date((new Date())).setMonth(new Date().getMonth()-1)); 
		
		 $('#fromdate').val(onemounth);
           $('#todate').val(new Date());
	     
		 if (document.getElementById("txtclientname").value == "") {
		        $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
		    }
		 if (document.getElementById("txtagreementno").value == "") {
		        $('#txtagreementno').attr('placeholder', 'Press F3 to Search'); 
		        $('#agmtvocno').attr('placeholder', 'Press F3 to Search');
		    }
	 }
	
	function funreload(event){
		

		  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  } 
		   else
			   {
	/* 	if(document.getElementById("txtcldocno").value==""){
			 $.messager.alert('Message','Client is Mandatory','warning');
			 document.getElementById("txtcldocno").focus();
			 return false;
		} */
		 var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var cldocno = $('#txtcldocno').val();
		 var rentaltype = $('#rentaltype').val();
		 var agmtno = $('#txtagreementno').val();
		 var clstatuss= $('#clstatuss').val();
		 $("#overlay, #PleaseWait").show();
		 $("#notInvoicedDiv").load("rentalInvoiceGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&cldocno='+cldocno+'&rentaltype='+rentaltype+'&agmtno='+agmtno+'&clstatuss='+clstatuss);
			   }
			   }
	function chktype()
	{
		
		
		 if($('#rentaltype').val()=="")
		  {
			  $.messager.alert('Message','Select Type  ','warning');   
				 document.getElementById("rentaltype").focus(); 
			   return false;
	
		  }
		
		
	}
	
	
	function clearagno()
	{
		$('#txtagreementno').val('');
		$('#agmtvocno').val('');
	}
	
	
	function funGroupPrint(){
		if(document.getElementById("txtcldocno").value==""){
			 $.messager.alert('Message','Client is Mandatory','warning');
			 document.getElementById("txtcldocno").focus();
			 return false;
		}
		else{
			
			var z=0;
		    var rows = $("#rentalInvoiceGrid").jqxGrid('getrows');                    
if(rows.length>0 && (rows[0].rano=="undefined" || rows[0].rano==null || rows[0].rano=="")){
	return false;
}
		    var selectedRecords = new Array();
            var selectedrows=$("#rentalInvoiceGrid").jqxGrid('selectedrowindexes');

if(selectedrows.length==0){
	$.messager.alert('Warning','Select an Invoice');
	return false;
}
document.getElementById("invgridlength").value="";
   $.messager.confirm('Confirm', 'Do you want to Print Invoice?', function(r){
			if (r){
				
				var i=0;
           
            
		    for (i = 0; i < rows.length; i++) {
				for(var j=0;j<selectedrows.length;j++){
					if(selectedrows[j]==i){
			
					if(document.getElementById("invgridlength").value==""){
						document.getElementById("invgridlength").value=rows[i].doc_no;	
					}
					else{
						document.getElementById("invgridlength").value=document.getElementById("invgridlength").value+","+rows[i].doc_no;
					}
					
					z++;
					
					}
				}
				if(i==rows.length-1){
			
					 var url=document.URL;
				    	
				    var reurl=url.split("groupedinvoice.jsp");
				    
				    var win= window.open(reurl[0]+"printGroupedInvoice?cldocno="+document.getElementById("txtcldocno").value+"&fromdate="+$('#fromdate').val()+"&todate="+$('#todate').val()+"&rentaltype="+$('#rentaltype').val()+"&agmtno="+$('#txtagreementno').val()+"&clstatus="+$('#clstatuss').val()+"&griddocno="+$('#invgridlength').val(),"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");	
				    win.focus(); 
				}
	}
		 
	 			}
	 	 		});

			
			/* var url=document.URL;
	    	
	    	var reurl=url.split("groupedinvoice.jsp");
	    	
	    		
	    	var win= window.open(reurl[0]+"printGroupedInvoice?cldocno="+document.getElementById("txtcldocno").value+"&fromdate="+$('#fromdate').val()+"&todate="+$('#todate').val()+"&rentaltype="+$('#rentaltype').val()+"&agmtno="+$('#txtagreementno').val()+"&clstatus="+$('#clstatuss').val(),"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");	
	    		win.focus(); */
		}
	}


function funSendmail()
 	{
 			
		if(document.getElementById("txtcldocno").value==""){
			 $.messager.alert('Message','Client is Mandatory','warning');
			 document.getElementById("txtcldocno").focus();
			 return false;
		}
		
		else{
			
			var selectedRecords = new Array();
            var selectedrows=$("#rentalInvoiceGrid").jqxGrid('selectedrowindexes');

			if(selectedrows.length==0){
				$.messager.alert('Warning','Select an Invoice');
				return false;
			}
			
			var z=0;
		    var rows = $("#rentalInvoiceGrid").jqxGrid('getrows');                    
if(rows.length>0 && (rows[0].rano=="undefined" || rows[0].rano==null || rows[0].rano=="")){
	return false;
    }

 		  
 		if(document.getElementById("email").value=="")
 			{
 			document.getElementById("errormsg").innerText="Email Id Is Not Available.";  
 			return 0;
 			}
 		
 		
 		$("#overlay, #PleaseWait").show();

 		
 		document.getElementById("invgridlength").value="";
 	   $.messager.confirm('Confirm', 'Do you want to Send this Invoice?', function(r){
 				if (r){
 					
 					var i=0;
 	           
 	            
 			    for (i = 0; i < rows.length; i++) {
 					for(var j=0;j<selectedrows.length;j++){
 						if(selectedrows[j]==i){
 				
 						if(document.getElementById("invgridlength").value==""){
 							document.getElementById("invgridlength").value=rows[i].doc_no;	
 						}
 						else{
 							document.getElementById("invgridlength").value=document.getElementById("invgridlength").value+","+rows[i].doc_no;
 						}
 						
 						z++;
 						
 						}
 					}
 					if(i==rows.length-1){
 				
 				
 					   sample();	
 					     
 					}
 		}
 			 
 		 			}
 		 	 		});
 		
 		/*  var recipient1=document.getElementById("email").value; 
     	var recipient=recipient1.replace(/ /g, "%20");
       	 */
		}
 		
 	}
 
 	function sample()
 	{  
 		var frdate=document.getElementById("fromdate").value.trim();
 		var todate=document.getElementById("todate").value.trim();
 		var cldocno=document.getElementById("txtcldocno").value.trim();
 		var clstatus=document.getElementById("clstatuss").value.trim();
 		var retype=document.getElementById("rentaltype").value.trim();
 		var agmtvocno=document.getElementById("agmtvocno").value.trim();
 		var txtagmtno=document.getElementById("txtagreementno").value.trim();
 		var recep=document.getElementById("email").value.trim();
 		var formcode=document.getElementById("lbldetailname").innerText.trim();
 		var branch=<%=session.getAttribute("BRANCHID").toString()%>;
 		
   //alert("==frdate==="+frdate+"==todate=="+todate+"===cldocno=="+cldocno+"====clstatus==="+clstatus+"===retype=="+retype+"==agmtvocno==="+agmtvocno+"==txtagmtno=="+txtagmtno+"==recep==="+recep+"===formcode=="+formcode);		
 		
 		$.ajaxFileUpload
    	  (  
    	      {  
    	    	
    	    	  url: 'grpdinvjspToPdf.action?cldocno='+document.getElementById("txtcldocno").value+"&fromdate="+$('#fromdate').val()+"&todate="+$('#todate').val()+"&rentaltype="+$('#rentaltype').val()+"&agmtno="+$('#txtagreementno').val()+"&clstatus="+$('#clstatuss').val()+"&griddocno="+$('#invgridlength').val()+"&recep="+recep+"&formcode="+formcode,  
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
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<form id="frmGroupedInvoice" action="saveGroupedInvoice">
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	<tr><td colspan="2">&nbsp;</td></tr>
    <tr>
	 <td align="right"><label class="branch">From</label></td>
     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr>
	<td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr>
	<tr><td align="right"><label class="branch">Client</label></td>
	<td align="left"><input type="text" id="txtclientname" name="txtclientname" style="width:100%;height:20px;" readonly placeholder="Press F3 to Search"  onkeydown="getClient(event);" value='<s:property value="txtclientname"/>'/>
    <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/></td></tr>
    <tr><td align="right"><label class="branch">E-Mail</label></td><td align="left">
<input type="text" id="email" name="email" style="width:100%;height:20px;" readonly  value='<s:property value="email"/>'/></td></tr>
    <tr><td align="right"><label class="branch">Status</label></td>
     <td align="left"><select id="clstatuss" name="clstatuss"  value='<s:property value="clstatuss"/>'>
     <option value="">--Select--</option><option value=0>Open</option><option value=1>Close</option>
     </select></td></tr>
	<tr><td align="right"><label class="branch">Type</label></td>
     <td align="left"><select id="rentaltype" name="rentaltype" onchange="clearagno()" value='<s:property value="rentaltype"/>'>
     <option value="">--Select--</option><option value="RAG">Rental</option><option value="LAG">Lease</option>
     </select></td></tr>
	<tr><td align="right"><label class="branch">Agreement</label></td>
	<td align="left"><input type="text" id="agmtvocno" name="agmtvocno" style="width:100%;height:20px;" readonly onfocus="chktype()" placeholder="Press F3 to Search" ondblclick="funSearchdblclick();" onkeydown="getAgreement(event);" value='<s:property value="agmtvocno"/>'/></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearData();">
    <input type="button" class="myButton" name="btnGroupPrint" id="btnGroupPrint"  value="Print" onclick="funGroupPrint();">
<!-- 	<button class="myButton" type="button" id="btnSalikInvoicePrint" name="btnSalikInvoicePrint" onclick="funSalikInvoicePrint();">Print</button> --></td></tr> 



	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<br><br>
	
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="notInvoicedDiv"><jsp:include page="rentalInvoiceGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>
<input type="hidden" name="invgridlength" id="invgridlength" value='<s:property value="invgridlength"/>'>
<input type="hidden" id="txtagreementno" name="txtagreementno" style="width:100%;height:20px;" readonly onfocus="chktype()" placeholder="Press F3 to Search" ondblclick="funSearchdblclick();" onkeydown="getAgreement(event);" value='<s:property value="txtagreementno"/>'/>
</form>
<div id="clientDetailsWindow">
	<div></div><div></div>
</div>
<div id="agreementDetailsWindow">
	<div></div><div></div>
</div>
</div> 
</body>
</html>