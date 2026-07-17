 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"> 
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<script type="text/javascript">
$(document).ready(function() {
    var bulkconfig=$("#bulkconfig").val();
    if(parseInt(bulkconfig)!=1){
    	$("#btnbulk").hide();
    }else{
    	$("#btnbulk").show();   
    }
});
   function funbulkinvoicePrint(){   
		/*var url=document.URL;
		var reurl=url.split("com/");
		var path= "WSInvoicePrintActionpal.action?docno="+$('#docno').val()+"&header="+1+"&branch="+$('#brchName').val()+"&jobcarddocno="+$('#hidrefno').val()+"&type="+3;              
		var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");		
		win.focus();
		*/
		funSendPrintEmail(3);
	}   
	
 	function funinsurancePrint(){ 
 		/*var url=document.URL;
		var reurl=url.split("com/");
		var path= "WSInvoicePrintActionpal.action?docno="+$('#docno').val()+"&header="+1+"&branch="+$('#brchName').val()+"&jobcarddocno="+$('#hidrefno').val()+"&type="+1;            
		var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");		
		win.focus();*/
		funSendPrintEmail(1);
 	}    

 	function funcustomerPrint(){          
 		/*var url=document.URL;
		var reurl=url.split("com/");
		var path= "WSInvoicePrintActionpal.action?docno="+$('#docno').val()+"&header="+1+"&branch="+$('#brchName').val()+"&jobcarddocno="+$('#hidrefno').val()+"&type="+2;            
		var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");		
		win.focus();*/  
		funSendPrintEmail(2);	
	}
	
	function funSendPrintEmail(mailtype){
		var docno=$('#docno').val();
		var header=1;
		var branch=$('#brchName').val();
		var jobcarddocno=$('#hidrefno').val();
		$.post('uploadPrints.jsp',{'docno':docno,'header':header,'branch':branch,'jobcarddocno':jobcarddocno,'type':mailtype},function(data,status){
			console.log(data);
			data=JSON.parse(data);
			if(data.errorstatus=='0'){
				var fname="Workshop Invoice",frmdet="MNT";
				var userid="<%=session.getAttribute("USERID").toString()%>";     
				var email=data.mailid,cldocno="0",client="";
				var subject=data.subject;
				var msg=data.msg;
				//console.log("<%=contextPath%>/com/emailnew/Email.jsp?msg="+msg+"&formcode=EST&docno="+docno+"&brchid="+branch+"&frmname="+fname+"&recipient="+email+"&cldocno="+cldocno+"&client="+client+"&userid="+userid+"&dtype="+frmdet);
				var win=window.open("<%=contextPath%>/com/emailnew/Email.jsp?subject="+subject+"&msg="+msg+"&formcode=MNT&docno="+docno+"&brchid="+branch+"&frmname="+fname+"&recipient="+email+"&cldocno="+cldocno+"&client="+client+"&userid="+userid+"&dtype="+frmdet,"E-Mail","menubar=0,resizable=1,width=900,height=950");	
				win.focus();
			}
			
		});
	}
</script>

<body>
<div id=search>
<br/><br/><br/><br/><br/><br/>     
<table width="100%">
  <tr>
    <td align="center"><input type="button" name="btnbulk" id="btnbulk" class="myButton" value="Bulk Invoice"  onclick="funbulkinvoicePrint();"></td>
    <td align="center"><input type="button" name="btnjobdetails" id="btnjobdetails" class="myButton" value="Insurance Invoice"  onclick="funinsurancePrint();"></td>
    <td align="center"><input type="button" name="btnwithoutjobdetails" id="btnwithoutjobdetails" class="myButton" value="Customer Invoice"  onclick="funcustomerPrint()"></td>
  </tr>
</table>
<br/><br/><br/><br/><br/><br/>
  </div>
</body>
</html>