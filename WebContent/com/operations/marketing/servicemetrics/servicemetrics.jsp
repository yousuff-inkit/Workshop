
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<%
String contextPath=request.getContextPath();
%>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
form label.error {
color:red;
  font-weight:bold;

}
</style>
<script type="text/javascript">
	$(document).ready(function () {    
	    $("#date").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
	    $('#tarifsearchwindow').jqxWindow({ width: '30%', height: '49%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Tarif Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#tarifsearchwindow').jqxWindow('close');
 
		$('#tarifgroup').dblclick(function(){
			if(document.getElementById("mode").value=="A" || document.getElementById("mode").value=="E" ){
				$('#tarifsearchwindow').jqxWindow('open');
				$('#tarifsearchwindow').jqxWindow('focus');
				tarifSearchContent('tarifGroupSearch.jsp');				
			}
		});
	});
	
	function getTarifGroup(event){
    	var x= event.keyCode;
    	if(x==114){
    		if(document.getElementById("mode").value=="A" || document.getElementById("mode").value=="E" ){
				$('#tarifsearchwindow').jqxWindow('open');
				$('#tarifsearchwindow').jqxWindow('focus');
				tarifSearchContent('tarifGroupSearch.jsp');				
			}
    	}
	}
	
	function tarifSearchContent(url) {
        $.get(url).done(function (data) {
        	$('#tarifsearchwindow').jqxWindow('setContent', data);
    	}); 
    }
	function funSearchLoad(){
		changeContent('mainSearch.jsp', $('#window')); 
	 }
	function funReadOnly() {
		$('#frmServiceMetrics input').attr('readonly', true);
		$('#date').jqxDateTimeInput({
			disabled : true
		});
		
		/* 	$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
	}
	function funRemoveReadOnly() {
		$('#frmServiceMetrics input').attr('readonly', false);
		$('#date').jqxDateTimeInput({
			disabled : false
		});
		$('#docno').attr('readonly', true);
		$('#tarifgroup').attr('readonly', true);
		if(document.getElementById("mode").value=="A"){
			$('#serviceMetricsGrid').jqxGrid('clear');
			$("#serviceMetricsGrid").jqxGrid('addrow', null, {});
		}
		if(document.getElementById("mode").value=="E"){
			$("#serviceMetricsGrid").jqxGrid('addrow', null, {});
		}
	}

	function setValues() {
		
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		 if(document.getElementById("docno").value!=""){
			 $('#srvmetricsdiv').load('serviceMetricsGrid.jsp?docno='+document.getElementById('docno').value+'&id=1');
		 }
	}
	 	 $(function(){
	         $('#frmServiceMetrics').validate({
	                 rules: {
	                 tarifgroup: {
	                	 required:true
	                 }
	                 },
	                 messages: {
	                	 tarifgroup: {
	                	  required:" *"
	                  } 
	                 }
	        }); 
	});
	     function funNotify(){
	    
	    	 if(document.getElementById("tarifgroup").value==""){
	    		 document.getElementById("errormsg").innerText="";
	    		 document.getElementById("errormsg").innerText="Tarif Group is Mandatory";
	    		 document.getElementById("tarifgroup").focus();
	    		 return 0;
	    	 }
	    	 else{
	    		 document.getElementById("errormsg").innerText="";
	    	 }
	    	 var rows=$('#serviceMetricsGrid').jqxGrid('getrows');
	    	 var gridlength=0;
	    	 for(var i=0;i<rows.length;i++){
	    		 newTextBox = $(document.createElement("input"))
				    .attr("type", "dil")
				    .attr("id", "test"+i)
				    .attr("name", "test"+i)
				    .attr("hidden", "true");
					gridlength++;
					newTextBox.val(rows[i].srvckm+"::"+rows[i].srvccost+"::"+rows[i].replacecost+"::"+rows[i].tyrecost);		
					newTextBox.appendTo('form');
	    	 }
	    	 document.getElementById("gridlength").value=gridlength;
	    		return 1;
		} 
	     function funFocus(){
	    	 document.getElementById("tarifgroup").focus();
	     }
	  function funExcelBtn(){
		 // $("#jqxBrandSearch1").jqxGrid('exportdata', 'xls', 'Brand');
	  }
</script>  
 
</head>
<body onLoad="setValues();" >
<form id="frmServiceMetrics" action="saveActionServiceMetrics" autocomplete="off">
	<jsp:include page="../../../../header.jsp" />
	<br/> 
	<fieldset>
    	<table width="100%" border="0">
  			<tr>
			    <td width="4%" align="right">Date</td>
			    <td width="12%"><div id="date" name="date"></div></td>
			    <td width="5%">&nbsp;</td>
			    <td width="12%">&nbsp;</td>
			    <td width="4%">&nbsp;</td>
			    <td width="12%">&nbsp;</td>
			    <td width="4%">&nbsp;</td>
			    <td width="13%">&nbsp;</td>
			    <td width="5%">&nbsp;</td>
			    <td width="12%">&nbsp;</td>
			    <td width="5%" align="right">Doc No</td>
			    <td width="12%"><input type="text" name="docno" id="docno" value='<s:property value="docno"/>' tabindex="-1" readonly></td>
			</tr>
			<tr>
			    <td align="right">Tariff Group</td>
			    <td><input type="text" name="tarifgroup" id="tarifgroup" value='<s:property value="tarifgroup"/>' placeholder="Press F3 to Search" readonly onkeydown="getTarifGroup(event);"></td>
			    <td align="right">Insurance %</td>
			    <td><input type="text" name="insurpercent" id="insurpercent" value='<s:property value="insurpercent"/>' style="text-align:right;"></td>
			    <td align="right">Tracker</td>
			    <td><input type="text" name="tracker" id="tracker" value='<s:property value="tracker"/>' style="text-align:right;"></td>
			    <td align="right">Ex Km Rate</td>
			    <td><input type="text" name="exkmrate" id="exkmrate" value='<s:property value="exkmrate"/>' style="text-align:right;"></td>
			    <td align="right">Insurance Excess</td>
			    <td><input type="text" name="insurexcess" id="insurexcess" value='<s:property value="insurexcess"/>' style="text-align:right;"></td>
			    <td align="right">Reg Cost</td>
			    <td><input type="text" name="regcost" id="regcost" value='<s:property value="regcost"/>' style="text-align:right;"></td>
			</tr>
			<tr>
			    <td colspan="12"><div id="srvmetricsdiv"><jsp:include page="serviceMetricsGrid.jsp"/></div></td>
			</tr>
		</table>
		<input type="hidden" name="hidtarifgroup" id="hidtarifgroup" value='<s:property value="hidtarifgroup"/>' >
		<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>' >
		<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>' >
		<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' >
		<input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>' >
    </fieldset>	
<div id="tarifsearchwindow">
	<div></div>
</div>
</form>
</body>
</html>