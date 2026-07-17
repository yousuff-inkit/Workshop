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
</style>

 <jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript">
	
	$(document).ready(function() {
  	  $("#date").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });  
	});
	
    function funSearchLoad(){
		changeContent('airportSearch.jsp', $('#window')); 
	 }
	function funReadOnly() {
		 $('#frmairport input').attr('readonly', true);
		 $('#date').jqxDateTimeInput({ disabled: true}); 
	}
	function funRemoveReadOnly() {
		$('#frmairport input').attr('readonly', false);
		$('#docno').attr('readonly', true);
		 $('#date').jqxDateTimeInput({ disabled: false}); 
	}
	function setValues() {
		document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		funSetlabel();
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
	}

	 function funFocus()
	    {
	    	document.getElementById("iata").focus();
	    		
	    }
	     $(function(){
	        $('#frmairport').validate({
	        	rules: {
	                iata:"required",
	                airport:"required",
	                location:"required",
					country:"required",
	                 
	            }, 
	        	messages:{
	        		 iata:" *",
	                airport:" *",
	                location:" *",
					country:" *",
	               
	        	}
	        });
	     }); 
	     
	     
	     function funNotify(){
	    		return 1;
	     } 

</script>
 </head>
<body onLoad="setValues();">
	
   
    
	<br/> 
	<div id="mainBG" class="homeContent" data-type="background"> 
		<form id="frmairport" action="saveAirport" method="post" autocomplete="off">
			<jsp:include page="../../../../header.jsp" />
 <table width="100%">
  <tr>
    <td width="13%" align="right">Date</td>
    <td width="13%"><div id="date" name="date" value='<s:property value="date" />'></div></td>
    <td width="14%">&nbsp;</td>
    <td width="34%">&nbsp;</td>
    <td width="11%" align="right">Doc No</td>
    <td width="15%"><input type="text" name="docno" id="docno" value='<s:property value="docno" />' readonly tabindex="-1"></td>
  </tr>
  <tr>
    <td align="right">IATA</td>
    <td><input type="text" name="iata" id="iata" value='<s:property value="iata" />'></td>
    <td align="right">Airport</td>
    <td><input type="text" name="airport" id="airport" value='<s:property value="airport" />' style="width:80%;"></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="right">Location</td>
    <td><input type="text" name="location" id="location" value='<s:property value="location" />'></td>
    <td align="right">Country</td>
    <td><input type="text" name="country" id="country" value='<s:property value="country" />'></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
		</form>
	</div>			
</body>
</html>