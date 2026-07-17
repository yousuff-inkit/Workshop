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
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");
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
	 var branchval = document.getElementById("cmbbranch").value;
	 if(branchval.trim()=='a'){
		 $.messager.alert('Warning','Branch is Mandatory');
		 document.getElementById("cmbbranch").focus();
		 return false;
	 }
	 if($('#periodupto').jqxDateTimeInput('getDate')==null){
		 $.messager.alert('Warning','Upto Date is Mandatory');
		 $('#periodupto').jqxDateTimeInput('focus');
		 return false;
	 }
	 var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
		if(docdateval==0){
			$('#periodupto').jqxDateTimeInput('focus');
			return false;
		}
		 $('#extraserviceinvdiv').load('extraServiceInvGrid.jsp?branch='+branchval+'&uptodate='+$('#periodupto').jqxDateTimeInput('val')+'&temp=1');	 
	 
	 
	
	}
	function funNotify(){
	
	 var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
			if(docdateval==0){
				$('#periodupto').jqxDateTimeInput('focus');
				return false;
			}
			
		var z=0;
    	 var rows = $("#extraServiceInvGrid").jqxGrid('getrows');                    
  	
    	 if(rows.length>0 && (rows[0].doc_no=="undefined" || rows[0].doc_no==null || rows[0].doc_no=="")){
    		 return 0;
    	}
        var selectedrows=$("#extraServiceInvGrid").jqxGrid('selectedrowindexes');
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
								
							newTextBox.val(rows[i].doc_no+"::"+rows[i].rano+"::"+rows[i].ratype+"::"+rows[i].cldocno+"::"+rows[i].acno+"::"+rows[i].date);
							
							newTextBox.appendTo('form');
							z++;
							//alert("ddddd"+$("#testinvoice"+z).val());
							}
						}
			}
    			    $.messager.confirm('Confirm', 'Do you want to Generate Invoice?', function(r){
    		 			if (r){
    	document.getElementById("mode").value='A';
    	$("#overlay, #PleaseWait").show();
		document.getElementById("frmExtraServiceInvoice").submit();
    		 			}
    			    });
	}
	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
		
	}
	 function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1")
		  {
		  	JSONToCSVCon(exservicedata, 'Extra Services', true);
		  }
		 else
		  {
			 $("#extraServiceInvGrid").jqxGrid('exportdata', 'xls', 'Extra Services');
		  }
		 
		
		
	}
</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmExtraServiceInvoice" action="saveExtraServiceInvoice">
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
			 <td> <div id="extraserviceinvdiv"><jsp:include page="extraServiceInvGrid.jsp"></jsp:include></div> </td>
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