<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<style>
form label.error {
color:red;
  font-weight:bold;

}

.hidden-scrollbar {
    overflow: auto;
    height: 500px;
}

</style>

 <jsp:include page="../../../includes.jsp"></jsp:include>
 
<script type="text/javascript">
$(document).ready(function() {
	$("#date").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });
	$("#fromdate").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });
	$("#todate").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });
	$('.detailbuttons').hide();
	$('#airportwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '55%' ,maxWidth: '30%' , title: 'Airport Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#airportwindow').jqxWindow('close');
	});
	$(function(){
	    $('#frmExtraSrvc').validate({
	    	rules: {
	            desc:"required"
	        }, 
	    	messages:{
	    		desc:" *"
	    	}
	    });
	 });  
	
	 function airportSearchContent(url) {
	     $.get(url).done(function (data) {
	   $('#airportwindow').jqxWindow('setContent', data);
	}); 
	}
	
	function funSearchLoad(){
		changeContent('extraSrvcTarifSearch.jsp', $('#window'));
	 }
	function funReadOnly() {
		 $('#frmExtraSrvc input').attr('readonly', true);
		 $('#date').jqxDateTimeInput({ disabled: true});
		 $('#fromdate').jqxDateTimeInput({ disabled: true});
		 $('#todate').jqxDateTimeInput({ disabled: true});
		 
	}
	function funRemoveReadOnly() {
		$('#frmExtraSrvc input').attr('readonly', false);
		 $('#date').jqxDateTimeInput({ disabled: false});
		 $('#fromdate').jqxDateTimeInput({ disabled: false});
		 $('#todate').jqxDateTimeInput({ disabled: false});
		 $("#docno").attr('readonly',true);
		 if(document.getElementById("mode").value=="A"){
			 $('#date').jqxDateTimeInput('setDate',new Date());
			 $('#fromdate').jqxDateTimeInput('setDate',new Date());
			 $('#todate').jqxDateTimeInput('setDate',new Date());
		 }
	}
	function setValues() {
		document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		funSetlabel();
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
		 }
		 
		 if(document.getElementById("docno").value!=""){
			 $('#btnDetailEdit').show();
			 $('#btnDetailCancel').hide();
			 $('#btnDetailSave').hide();
			 $('#extrasrvcdiv').load('extraSrvcGrid.jsp?docno='+document.getElementById("docno").value+'&id=1');
		 }
	}

	 function funFocus()
	    {
	    	 $('#date').jqxDateTimeInput('focus'); 
	    		
	    }
	    
	     
	     function funNotify(){
	    	 if($('#date').jqxDateTimeInput('getDate')==null){
	    		 document.getElementById("errormsg").innerText="";
	    		 document.getElementById("errormsg").innerText="Date is mandatory";
	    		 return 0;
	    	 }
	    	 if($('#fromdate').jqxDateTimeInput('getDate')==null){
	    		 document.getElementById("errormsg").innerText="";
	    		 document.getElementById("errormsg").innerText="Valid fromdate is mandatory";
	    		 return 0;
	    	 }
	    	 if($('#todate').jqxDateTimeInput('getDate')==null){
	    		 document.getElementById("errormsg").innerText="";
	    		 document.getElementById("errormsg").innerText="Valid todate is mandatory";
	    		 return 0;
	    	 }
	    	 if($('#fromdate').jqxDateTimeInput('getDate')!=null && $('#todate').jqxDateTimeInput('getDate')!=null){
	    		 var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	    		 var todate=new Date($('#todate').jqxDateTimeInput('getDate'));
	    		 fromdate.setHours(0,0,0,0);
	    		 todate.setHours(0,0,0,0);
	    		 if(todate<fromdate){
	    			 document.getElementById("errormsg").innerText="";
		    		 document.getElementById("errormsg").innerText="Valid to cannot be less than valid from date";
		    		 $('#todate').jqxDateTimeInput('focus'); 
		    		 return 0;
	    		 }
	    	 }
	        		return 1;
	     }
	     
	     function funDetailEdit(){
	    	 $("#extraSrvcGrid").jqxGrid({ disabled: false});
	    	 $("#extraSrvcGrid").jqxGrid("addrow", null, {});
	    	 $('#btnDetailEdit').hide();
			 $('#btnDetailCancel').show();
			 $('#btnDetailSave').show();
	     }
	     function funDetailCancel(){
	    	 $("#extraSrvcGrid").jqxGrid({ disabled: true});
	    	 $('#btnDetailEdit').show();
			 $('#btnDetailCancel').hide();
			 $('#btnDetailSave').hide();
	     }
	     function funDetailSave(){
	    	 var rows=$('#extraSrvcGrid').jqxGrid('getrows');
	    	 document.getElementById("gridlength").value=rows.length;
	    	 for(var i=0;i<rows.length;i++){
	    		 newTextBox = $(document.createElement("input"))
	 		    .attr("type", "dil")
	 		    .attr("id", "grid"+i)
	 		    .attr("name", "grid"+i)
	 		    .attr("hidden",true);
	 			
	 			newTextBox.val(rows[i].airportid+"::"+rows[i].greetrate+"::"+rows[i].viprate+"::"+rows[i].boquerate);
	 			newTextBox.appendTo('form');
	 		
	 			
	    	 }
	    	 document.getElementById("mode").value="tarifinsert";
	    	 $('#date').jqxDateTimeInput({ disabled: false});
			 $('#fromdate').jqxDateTimeInput({ disabled: false});
			 $('#todate').jqxDateTimeInput({ disabled: false});
	    	 document.getElementById("frmExtraSrvc").submit();
	    	 $('#date').jqxDateTimeInput({ disabled: true});
			 $('#fromdate').jqxDateTimeInput({ disabled: true});
			 $('#todate').jqxDateTimeInput({ disabled: true});
	     }
</script>
</head>
<body onLoad="setValues();">
	
   	<br/> 
	<div id="mainBG" class="homeContent" data-type="background"> 
		<form id="frmExtraSrvc" action="saveExtraSrvcTarif" method="post" autocomplete="off">
			<jsp:include page="../../../header.jsp" />
   			<br>
    <div class='hidden-scrollbar'>
<table width="100%">
  <tr>
    <td width="9%" align="right">Date</td>
    <td width="19%"><div id="date" name="date" value='<s:property value="date"/>'></div></td>
    <td width="15%" align="right">Valid from</td>
    <td width="17%"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
    <td width="8%" align="right">Valid to</td>
    <td width="11%"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
    <td width="9%" align="right">Doc No</td>
    <td width="12%"><input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly tabindex="-1"></td>
  </tr>
  <tr>
    <td align="right">Description</td>
    <td colspan="5"><input type="text" name="desc" id="desc" value='<s:property value="desc"/>' style="width:100%;"></td>
    <td><button type="button"  id="btnDetailEdit" title="Detail Edit" style="border:none;background:none;" onclick="funDetailEdit();" class="detailbuttons">
		<img alt="Detail Edit" src="<%=contextPath%>/icons/tarifedit.png" width="30" height="30">
	</button>
    
	<button type="button" id="btnDetailCancel" title="Detail Cancel"  style="border:none;background:none;" onclick="funDetailCancel();" class="detailbuttons">
		<img alt="Detail Cancel" src="<%=contextPath%>/icons/tarifcancel.png" width="30" height="30">
	</button>
	<button type="button" id="btnDetailSave" title="Detail Save"  style="border:none;background:none;" onclick="funDetailSave();" class="detailbuttons">
		<img alt="Detail Save" src="<%=contextPath%>/icons/tarifsave.png" width="30" height="30">
	</button></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="right">&nbsp;</td>
    <td colspan="6"><div id="extrasrvcdiv"><jsp:include page="extraSrvcGrid.jsp"></jsp:include></div></td>
    <td>&nbsp;</td>
  </tr>
</table>
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
<input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
<div id="airportwindow">
   <div ><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
</div>
</div>
</form>
</div>
</body>
</html>