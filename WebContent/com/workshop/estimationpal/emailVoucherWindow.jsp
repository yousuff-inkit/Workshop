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
 	function funWithVatPrint(){      
 		/*var url=document.URL;
		var reurl=url.split("com/");
		var docno=$('#docno').val();   
		var gatedoc=$('#gatedocno').val();
		var printchk=$('#printchk').val(); 
		
		var path= "com/workshop/wsestimationpal/printEstimation1.action?estDocno="+$('#vocno').val()+"&docno="+docno+"&gatedocno="+gatedoc+"&branch="+$('#brchName').val()+"&addition="+0+"&withvat="+1+"&printchk="+printchk+"&email=1";       
		console.log(reurl[0]+" = "+path);
		var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=700,Height=600,location=no,scrollbars=yes,toolbar=yes");	          	
		win.focus();*/
		funSendPrintEmail(1);
 	}    

 	function funWithoutVatPrint(){      
 		/*var url=document.URL;
		var reurl=url.split("com/");
		var docno=$('#docno').val();   
		var gatedoc=$('#gatedocno').val(); 
		var printchk=$('#printchk').val(); 
		var path= "com/workshop/wsestimationpal/printEstimation1.action?estDocno="+$('#vocno').val()+"&docno="+docno+"&gatedocno="+gatedoc+"&branch="+$('#brchName').val()+"&addition="+0+"&withvat="+0+"&printchk="+printchk+"&email=1";       
		console.log(reurl[0]+" = "+path);
		var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=700,Height=600,location=no,scrollbars=yes,toolbar=yes");	          	
		win.focus();    	*/
		funSendPrintEmail(0);
	}
	$(document).ready(function(){
		var htmldata='';
		if(rawconfig.restrictNonVATPrint=="1"){
			$('#btnwithoutjobdetails').hide();
		}
		else{
			$('#btnwithoutjobdetails').show();
		}
		if(rawconfig.estPrintDropdown.method=="1"){
			//Client Comes First
			htmldata+='<option value="2">Insurance Company</option>';
			htmldata+='<option value="1">Client</option>';
		    
		}
		else{
			//Insurance Comp. Comes First
			htmldata+='<option value="1">Client</option>';
			htmldata+='<option value="2">Insurance Company</option>';
		}
		$('#printchk').html($.parseHTML(htmldata));
	});
	
	function funSendPrintEmail(vattype){
		var estdocno=$('#vocno').val();
		var docno=$('#docno').val();   
		var gatedocno=$('#gatedocno').val();
		var brhid=$('#brchName').val();
		var printchk=$('#printchk').val();
		var withvat=vattype; 
		$.post('uploadPrints.jsp',{'estdocno':estdocno,'docno':docno,'gatedocno':gatedocno,'brhid':brhid,'printchk':printchk,'withvat':withvat},function(data,status){
			console.log(data);
			data=JSON.parse(data);
			if(data.errorstatus=='0'){
				/*var fname="Estimation",frmdet="EST";
				var userid="<%=session.getAttribute("USERID").toString()%>";     
				var email=data.mailid,cldocno="0",client="";
				var subject=data.subject;
				var msg=data.msg;
				console.log("<%=contextPath%>/com/emailnew/Email.jsp?msg="+msg+"&formcode=EST&docno="+docno+"&brchid="+brhid+"&frmname="+fname+"&recipient="+email+"&cldocno="+cldocno+"&client="+client+"&userid="+userid+"&dtype="+frmdet);
				var win=window.open("<%=contextPath%>/com/emailnew/Email.jsp?subject="+subject+"&msg="+msg+"&formcode=EST&docno="+docno+"&brchid="+brhid+"&frmname="+fname+"&recipient="+email+"&cldocno="+cldocno+"&client="+client+"&userid="+userid+"&dtype="+frmdet,"E-Mail","menubar=0,resizable=1,width=900,height=950");	
				win.focus();*/
				$.messager.alert('Message','Email Sent Successfully','Message');
			}
			
		});
	}
</script>

<body>
<div id=search>
<br/><br/><br/><br/><br/><br/>     
<table width="100%">
	<tr>
		<td align="center" colspan=2>
			<select name="printchk" id="printchk" value='<s:property value="printchk"/>'>
		    	<option value=1>Client</option>
		        <option value=2>Insurance Company</option>  
		    </select>
		</td>
	</tr>
  	<tr>
   		<td align="center"><input type="button" name="btnjobdetails" id="btnjobdetails" class="myButton" value="With Vat"  onclick="funWithVatPrint();"></td>
    	<td align="center"><input type="button" name="btnwithoutjobdetails" id="btnwithoutjobdetails" class="myButton" value="Without Vat"  onclick="funWithoutVatPrint()"></td>
  	</tr>
</table>
<br/><br/><br/><br/><br/><br/>
  </div>
</body>
</html>