
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
	 $('#userwindow').jqxWindow({ width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'User Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#userwindow').jqxWindow('close');
	
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");    
	
	 $('#btnblock').attr("disabled",true);
	 
	 $('#user').dblclick(function(){
	  	    $('#userwindow').jqxWindow('open');
	   
	  	  userSearchContent('usersearch.jsp?', $('#userwindow')); 
    });
});

function getuser(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#userwindow').jqxWindow('open');


	  userSearchContent('usersearch.jsp?', $('#userwindow'));    }
	 else{
		 }
	 } 
function userSearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 
			 $('#userwindow').jqxWindow('open');
		$('#userwindow').jqxWindow('setContent', data);

	}); 
	} 

function funreload(event)
{
	
	
	
	var branch=$('#cmbbranch').val();
	var doc_no=$('#docno').val();
	
	
	$('#overlay,#PleaseWait').show();
	$("#userblockdiv").load("userblockGrid.jsp?doc_no="+doc_no+"&branch="+branch+"&check=1");
}

function funExportBtn(){

/* 		 if(parseInt(window.parent.chkexportdata.value)=="1")
	  {
	  	JSONToCSVCon(invoicedata, 'Rental Invoice', true);
	  }
	 else
	  {
		 $("#rentalInvoiceGrid").jqxGrid('exportdata', 'xls', 'Rental Invoice');
	  }
*/
	
	
}
function funBlock()
{
	
		
		if(document.getElementById("bdocno").value==""){
			 $.messager.alert('Message',"Please Select user");
			 return false;
		}
		//alert(testdate);
		var doc_no = document.getElementById("bdocno").value;
		
		//var username =document.getElementById("username").value;
		 $.messager.confirm('Message', 'Do you want to Block?', function(r){
	    	  
		        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		 savegriddata(doc_no);
		     		}
			     });
		
	}

	function savegriddata(doc_no)
	{
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
		{
				
			var items=x.responseText;
			if(items==1) 
			{
				document.getElementById("bdocno").value="";
			
			//$('#date').val(new Date());
			 $.messager.alert('Message', '  Blocked Successfully ');
			 funreload(event);
			}
				
			else{
				$.messager.alert('Message', 'Not Updated ');
				 $("#fleetdetailsgrid").jqxGrid('clear');
			}		
				
			}
	}
		x.open("GET","userblockdata.jsp?doc_no="+doc_no,true);

		x.send();

	}
		
	

</script>
</head>
<body onload="getBranch();">

<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>
	 <tr>
	<td colspan="2">&nbsp;</td></tr>
 <tr><td align="right"><label class="branch">User</label></td>
	<td align="left"><input type="text" name="user" id="user"  placeholder="Press F3 To Search"  readonly="readonly"   onkeydown="getuser(event)" onclick="this.placeholder='' "  style="height:20px;width:70%;" value='<s:property value="user"/>' ></td></tr> <tr>
	<tr>
	<td colspan="2">&nbsp;</td>
	</tr> 
	<tr><td colspan="2" align="center"><textarea id="txtclientname" style="height:60px;width:200px;font: 10px Tahoma;resize:none" name="txtclientname"  readonly="readonly"  ><s:property value="txtclientname" ></s:property></textarea></td></tr>
	<tr>
	<td colspan="2">&nbsp;</td>
	</tr> 
	<tr><td colspan="2" align="center"><input type="button" name="btnblock" id="btnblock" class="myButton" value="Block" onclick="funBlock();"></td>
	</tr>
		
	<tr>
	<td colspan="2"><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br></td>
	</tr>	
	</table>
	</fieldset>
	<input type="hidden" name="docno" id="docno"  style="height:20px;width:70%;" value='<s:property value="docno"/>'>
	<input type="hidden" name="bdocno" id="bdocno"  style="height:20px;width:70%;" value='<s:property value="bdocno"/>'>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="userblockdiv"><jsp:include page="userblockGrid.jsp"></jsp:include></div> </td>
			  
			   
		</tr>
	</table>
</tr>
</table>
<div id="userwindow">
<div ></div>
   </div>
</div>
</body>
</html>