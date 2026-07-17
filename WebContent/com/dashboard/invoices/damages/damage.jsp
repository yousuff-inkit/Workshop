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

	 $("#periodupto").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $('#periodupto').on('change', function (event) 
				{  
					var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
					if(docdateval==0){
						$('#periodupto').jqxDateTimeInput('focus');
						return false;
					}
				});
	  
});

function funreload(event)
{
	if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=='a'){
		$.messager.alert('Warning','Select a single Branch');
		return false;
	} 
	var branchval = document.getElementById("cmbbranch").value;
	 var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
	if(docdateval==0){
		$('#periodupto').jqxDateTimeInput('focus');
		return false;
	}
	 $("#damageinvoicediv").load("damageInvGrid.jsp?branchval="+branchval);
	
	}
	function funNotify(){
	var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
		if(docdateval==0){
			$('#periodupto').jqxDateTimeInput('focus');
			return false;
		}
		var z=0;
    	 var rows = $("#damageInvGrid").jqxGrid('getrows');                    
  	
    	 if(rows.length>0 && (rows[0].refdocno=="undefined" || rows[0].refdocno==null || rows[0].refdocno=="")){
    		 return 0;
    	}
                    var selectedrows=$("#damageInvGrid").jqxGrid('selectedrowindexes');
		if(selectedrows.length==0){
			$.messager.alert('Warning','Select an Invoice');
			return 0;
		}
		
                    $('#invgridlength').val(selectedrows.length);
    			    for (var i = 0; i < rows.length; i++) {
						for(var j=0;j<selectedrows.length;j++){
							if(selectedrows[j]==i){
							
								newTextBox = $(document.createElement("input"))
							    .attr("type", "dil")
							    .attr("id", "testinvoice"+z)
							    .attr("name", "testinvoice"+z)
							    .attr("hidden","true");
								
							newTextBox.val(rows[i].refdocno+"::"+rows[i].reftype+"::"+rows[i].date+"::"+rows[i].date+"::"+rows[i].amount+"::"+rows[i].cldocno+"::"+rows[i].brhid+"::"+rows[i].curid+"::"+rows[i].doc_no+"::"+rows[i].acno+"::"+rows[i].accfines);
							
							newTextBox.appendTo('form');
							z++;
							//alert("ddddd"+$("#testinvoice"+z).val());
							}
						}
			}
    	document.getElementById("mode").value='A';
		document.getElementById("frmDashboardDamageInvoice").submit();
	}
	function setValues(){

		 if($('#msg').val()!=""){
   		  $.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
   		  }
		
	}
	 function funExportBtn(){
		 
		 if(parseInt(window.parent.chkexportdata.value)=="1")
		  {
		  	JSONToCSVCon(damagedata, 'Damages', true);
		  }
		 else
		  {
			 $("#damageInvGrid").jqxGrid('exportdata', 'xls', 'Damages');
		  }
		  
		  }
</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmDashboardDamageInvoice" action="saveDashboardDamageInvoice">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>
	
	<!--  <tr><td colspan="2">&nbsp;</td></tr> -->
 <tr><td><label class="branch">Period Upto</label></td><td><div id="periodupto"></div></td></tr>
<tr><td><!-- <label class="branch">Client</label> --></td><td><%-- <input type="text" name="client" id="client" onkeydown="getClient(event);" readonly value='<s:property value="client"/>'> --%></td></tr> 
<!-- <input type="hidden" name="hidclient" id="hidclient" > -->
		 <tr>
	<td colspan="2"> <%-- <div id="Readygrid" ><jsp:include page="invnoGrid.jsp"></jsp:include>
	</div> --%> </td>
	</tr> 
	<tr>
	<td colspan="2"><center><input type="button" name="btninvoicesave" id="btninvoicesave" class="myButton" value="Generate" onclick="funNotify();"></center></td>
	</tr>
	<tr>
	  <td colspan="2">&nbsp;</td>
	  </tr>
	<tr>
	  <td colspan="2">&nbsp;</td>
	  </tr>
	<tr>
	  <td colspan="2">&nbsp;</td>
	  </tr>
	<tr>
	  <td colspan="2">&nbsp;</td>
	  </tr>
	<tr>
	  <td colspan="2">&nbsp;</td>
	  </tr>
	<tr>
	  <td colspan="2">&nbsp;</td>
	  </tr>
	<tr>
	  <td colspan="2">&nbsp;</td>
	  </tr>
	<tr>
	  <td colspan="2">&nbsp;</td>
	  </tr>
	<tr>
	  <td colspan="2">&nbsp;</td>
	  </tr>
	  <tr>
	  <td colspan="2">&nbsp;</td>
	  </tr>
	<tr>
	<td colspan="2"><br><br><br><br><br></td>
	</tr>	
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td> <div id="damageinvoicediv"><jsp:include page="damageInvGrid.jsp"></jsp:include></div> </td>
			 <input type="hidden" name="invgridlength" id="invgridlength"  value='<s:property value="invgridlength"/>'>
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
		</tr>
	</table>
</tr>
</table>
</div>

</div>
</form>
</body>
</html>