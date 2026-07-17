<%@page import="com.controlcentre.masters.vehiclemaster.enginesize.*" %>
<%ClsEngineSizeDAO coa=new ClsEngineSizeDAO(); %>

<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../../includes.jsp"></jsp:include>
<style>
form label.error {
color:red;
  font-weight:bold;

}
</style>
<script type="text/javascript">
var data= '<%=coa.getEngineSizeData()%>';
$(document).ready(function () { 	
    
    	document.getElementById("formdet").innerText="Engine Size(ENG)";
		document.getElementById("formdetail").value="Engine Size";
		document.getElementById("formdetailcode").value="ENG";
		window.parent.formCode.value="ENG";
		window.parent.formName.value="Engine Size";
		
    var source =
    {
        datatype: "json",
        datafields: [
                  	{name : 'doc_no' , type: 'number' },
					{name : 'enginesize', type: 'String'  },
                  	
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

    $("#engineSizeGrid").jqxGrid(
            {
            	width: '70%',
                height: 315,
                source: dataAdapter,
                showfilterrow: true,
                filterable: true,
                selectionmode: 'singlerow',
                //pagermode: 'default',
                sortable: true,
                //pageable: true,
                altrows:true,
                //Add row method
                columns: [
					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '40%' },
					{ text: 'Engine Size',columntype: 'textbox', filtertype: 'input', datafield: 'enginesize', width: '60%' }
	              ]
            });
    $('#engineSizeGrid').on('rowdoubleclick', function (event) 
    		{ 
    			var rowindex1=event.args.rowindex;
      		 	 document.getElementById("docno").value= $('#engineSizeGrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
       			 document.getElementById("enginesize").value = $("#engineSizeGrid").jqxGrid('getcellvalue', rowindex1, "enginesize");                
    	 		 $('#window').jqxWindow('hide');
    		 }); 
});
function funReadOnly(){
	$('#frmEngineSize input').attr('readonly', true );
	/* $('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
}
function funRemoveReadOnly(){
	$('#frmEngineSize input').attr('readonly', false );
	//$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: false});
	$('#docno').attr('readonly', true);
}
function setValues(){	
   
	 if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }

	}
    function funFocus()
    {
    	document.getElementById("enginesize").focus();
    		
    }
   
    $(function(){
    	
        $('#frmEngineSize').validate({
                 rules: {
                 enginesize: {
                	 required:true,
                	 maxlength:45
                 }
                 
                 
                 },
                 messages: {
                  enginesize:{
                	  required:" *",
                	  maxlength:"max 45 chars"
                  }
                  
                  
                 }
        });});
     function funNotify(){
    	
    		return 1;
	} 
     function funSearchLoad(){
			changeContent('engineSizeSearchGrid.jsp?id=1', $('#window')); 
		 }
     function funExcelBtn(){
		  $("#engineSizeGrid").jqxGrid('exportdata', 'xls', 'Color');
	  }
</script>
</head>
<body onload="setValues();" >
	<div id="mainBG" class="homeContent" data-type="background">
		<form id="frmEngineSize" action="saveEngineSizeAction" autocomplete="off">
			<jsp:include page="../../../../../header.jsp" />
			<br/>  
			<fieldset><legend>Engine Size Details</legend>
				<table>
					<tr>
						<td width="8%" align="right">Engine Size</td><td width="62%"><input type="text" name="enginesize" id="enginesize" value='<s:property value="enginesize"/>'></td>
  						<td width="14%" align="right">Doc No</td>
  						<td width="16%"><input type="text" name="docno"  id="docno" readonly="readonly" value='<s:property value="docno"/>' tabindex="-1"></td>
					</tr>
				</table>
				<br/>
			</fieldset>	
			<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
			<input type="hidden" id="mode" name="mode"/>
			<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
		</form>
		<br/>
		<div id="engineSizeGrid"></div>
	</div>
</body>
</html>