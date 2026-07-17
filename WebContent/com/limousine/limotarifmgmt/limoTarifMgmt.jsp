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
    height: 600px;
}

</style>

 <jsp:include page="../../../includes.jsp"></jsp:include>
 
<script type="text/javascript">
	
	$(document).ready(function() {
	  	$("#date").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });
	  	$("#fromdate").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });
	  	$("#todate").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });
	  	$('#locationwindow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '55%' ,maxWidth: '40%' , title: 'Location Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#locationwindow').jqxWindow('close');
		$('#clientwindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '58%' ,maxWidth: '50%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#clientwindow').jqxWindow('close');
		$('.tarifbuttons').hide();
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;margin-left:50%;margin-right:50%;margin-top:15%;top:200;right:600;'><img src='../../../icons/31load.gif'/></div>");    
	    $("body").prepend("<div id='Trash' style='display: none;position:absolute; z-index: 1005;margin-left:40%;margin-right:50%;margin-top:15%;top:200;'><img src='../../../icons/trash.png'/></div>");
	    setTarifClient();
	   // $('#Trash').show();
	    $('#tarifclient').dblclick(function(){
	    	
		    $('#clientwindow').jqxWindow('open');
			$('#clientwindow').jqxWindow('focus');
		 	clientSearchContent('masterClientSearch.jsp?tariftype='+document.getElementById("cmbtariftype").value, $('#clientwindow'));
		});
	     
	});
	
	function getClient(event){
		
        var x= event.keyCode;
        if(x==114){
        	$('#clientwindow').jqxWindow('open');
			$('#clientwindow').jqxWindow('focus');
		 	clientSearchContent('masterClientSearch.jsp?tariftype='+document.getElementById("cmbtariftype").value, $('#clientwindow'));
        }
        else{
        }
        
	}
	
	function clientSearchContent(url) {
		
		$.get(url).done(function (data) {
	  		$('#clientwindow').jqxWindow('setContent', data);
	  	}); 
	}
	function locationSearchContent(url) {
	      $.get(url).done(function (data) {
	    $('#locationwindow').jqxWindow('setContent', data);
	}); 
	}	
    function funSearchLoad(){
		changeContent('limoTarifSearch.jsp', $('#window'));
	 }
	function funReadOnly() {
		 $('#frmLimoTarifMgmt input').attr('readonly', true);
		 $('#frmLimoTarifMgmt select').attr('disabled', true);
		 $('#date').jqxDateTimeInput({ disabled: true}); 
		 $('#fromdate').jqxDateTimeInput({ disabled: true}); 
		 $('#todate').jqxDateTimeInput({ disabled: true}); 
		 
	}
	function funRemoveReadOnly() {
		$('#frmLimoTarifMgmt input').attr('readonly', false);
		$('#docno').attr('readonly', true);
		$('#date').jqxDateTimeInput({ disabled: false}); 
		$('#frmLimoTarifMgmt select').attr('disabled', false);
		 $('#date').jqxDateTimeInput({ disabled: false}); 
		 $('#fromdate').jqxDateTimeInput({ disabled: false}); 
		 $('#todate').jqxDateTimeInput({ disabled: false});
		 $('#tarifclient').attr('readonly', true);
		if(document.getElementById("mode").value=="A" || document.getElementById("mode").value=="E"){
			setDeliveryCharge();
			$('#Trash').hide();
		}
		if(document.getElementById("mode").value=="A"){
			$('.tarifbuttons').hide();
			$('#gridTarifTransfer').jqxGrid('clear');
			$('#gridTarifHour').jqxGrid('clear');
			$('#gridGroup1').jqxGrid('clear');
			$('#gridGroup2').jqxGrid('clear');
			$('#gridgroup1div').load('gridGroup1.jsp?id=0'); 
			document.getElementById("lblgroupdetails").innerText="";
			document.getElementById("errormsg").innerText="";
			$("#gridTarifTransfer").jqxGrid({ disabled: true});
			$("#gridTarifHour").jqxGrid({ disabled: true});
			document.getElementById("chkdelivery").checked=false;	
			$('#date').jqxDateTimeInput('val',new Date());
			$('#fromdate').jqxDateTimeInput('val',new Date());
			$('#todate').jqxDateTimeInput('val',new Date());
			$('#commondiv').load('limoCommonGrid.jsp');
		}
	}
	function setValues() {
		document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		funSetlabel();
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
		 }
		 
		 if(document.getElementById("hidchkdelivery").value=="1"){
			 document.getElementById("chkdelivery").checked=true;
		 }
		 else{
			 document.getElementById("chkdelivery").checked=false;
		 }
		 
		 if(document.getElementById("hidcmbtariftype").value!=""){
			 $('#cmbtariftype').val($('#hidcmbtariftype').val());
		 }
		 
		 if(document.getElementById("hidcmbtariffor").value!=""){
			 $('#cmbtariffor').val($('#hidcmbtariffor').val());
		 }
		 
		 
		 if(document.getElementById("docno").value!=""){
			 $('#btnTarifEdit').show();
			 $('#gridgroup1div').load('gridGroup1.jsp?id=1&docno='+document.getElementById("docno").value);
			 $('#gridgroup2div').load('gridGroup2.jsp?id=1&docno='+document.getElementById("docno").value);
			 
		 }
		 if($('#msg').val()=='Successfully Deleted'){
			 $('#Trash').show();
		 }
		 else{
			$('#Trash').hide();
		 }
	}
	
	function funTarifEdit(){
		if(document.getElementById("lblgroupdetails").innerText==""){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Please select a valid group";
			return false;
		}
		else{
			document.getElementById("errormsg").innerText="";
		}
		$('#btnTarifEdit').hide();
		$('#btnTarifSave').show();
		$('#btnTarifCancel').show();
				
		$("#gridTarifTransfer").jqxGrid({ disabled: false});
		$("#gridTarifHour").jqxGrid({ disabled: false});
		$("#gridTarifTransfer").jqxGrid("addrow", null, {});
		$("#gridTarifHour").jqxGrid("addrow", null, {});
	}
	function funTarifCancel(){
		$('#btnTarifEdit').show();
		$('#btnTarifSave').hide();
		$('#btnTarifCancel').hide();
		$("#gridTarifTransfer").jqxGrid({ disabled: true});
		$("#gridTarifHour").jqxGrid({ disabled: true});
	}
	function funTarifSave(){
		if(document.getElementById("lblgroupdetails").innerText==""){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Please select a valid group";
			return false;
		}
		var rows = $("#gridTarifTransfer").jqxGrid('getrows');
    	var rows2=$("#gridTarifHour").jqxGrid('getrows');
    	/* if(rows[0].pickuploc=="undefined" || rows[0].pickuploc==null || rows[0].pickuploc=="" || typeof(rows[0].pickuploc)=="undefined"){
    		document.getElementById("errormsg").innerText="";
    		document.getElementById("errormsg").innerText="Please enter valid details";
    		return false;
    	} */
    	document.getElementById("tariftransferlength").value=rows.length;
    	document.getElementById("tarifhourslength").value=rows2.length;
    	for(var i=0;i<rows.length;i++){
		
    			newTextBox = $(document.createElement("input"))
			    .attr("type", "dil")
			    .attr("id", "tariftransfer"+i)
			    .attr("name", "tariftransfer"+i);
    			var time1=new Date(rows[i].esttime);
    			var newtime=(time1.getHours()<10?'0'+time1.getHours():time1.getHours())+":"+(time1.getMinutes()<10?'0':'') + time1.getMinutes();
				newTextBox.val(rows[i].pickuplocid+"::"+rows[i].dropofflocid+"::"+rows[i].estdistance+"::"+newtime+"::"+rows[i].tarif+"::"+rows[i].exdistancerate+"::"+rows[i].extimerate);
			
				newTextBox.appendTo('form');
    		
    	}
    	
    	for(var i=0;i<rows2.length;i++){
    		
    			newTextBox = $(document.createElement("input"))
			    .attr("type", "dil")
			    .attr("id", "tarifhours"+i)
			    .attr("name", "tarifhours"+i);
    			
				newTextBox.val(rows2[i].blockhrs+"::"+rows2[i].limotarif+"::"+rows2[i].exhrrate+"::"+rows2[i].nighttarif+"::"+rows2[i].nightexhrrate);
			
				newTextBox.appendTo('form');
    		
    		}	
    	
    	$.messager.confirm('Confirm', 'Do you want to save tarif?', function(r){
    		if (r){
				document.getElementById("mode").value="tarifinsert";
				$('#date').jqxDateTimeInput({ disabled: false}); 
				$('#fromdate').jqxDateTimeInput({ disabled: false}); 
				$('#todate').jqxDateTimeInput({ disabled: false}); 
				$('#cmbtariftype').attr('disabled',false);
				$('#cmbtariffor').attr('disabled',false);
				$('#tarifclient').attr('disabled',false);
				$("#overlay, #PleaseWait").show(); 
				document.getElementById("frmLimoTarifMgmt").submit();
				$('#date').jqxDateTimeInput({ disabled: true}); 
				$('#fromdate').jqxDateTimeInput({ disabled: true}); 
				$('#todate').jqxDateTimeInput({ disabled: true}); 
				$('#cmbtariftype').attr('disabled',true);
				$('#cmbtariffor').attr('disabled',true);
				$('#tarifclient').attr('disabled',true);
    		}
     		});

	}
	 function funFocus()
	    {
	    	/* document.getElementById("iata").focus(); */
	    		
	    }
	    $(function(){
	        $('#frmLimoTarifMgmt').validate({
	        	rules: {
	                cmbtariftype:"required",
	                cmbtariffor:"required"
	                 
	            }, 
	        	messages:{
	        		cmbtariftype:" *",
	        		cmbtariffor:" *"
	               
	        	}
	        });
	     }); 
	     
	     
	     function funNotify(){
	    	 
	    	 if($('#date').jqxDateTimeInput('getDate')==null){
	    		 document.getElementById("errormsg").innerText="";
	    		 document.getElementById("errormsg").innerText="Document date is mandatory";
	    		 $('#date').jqxDateTimeInput('focus'); 
	    		 return 0;
	    	 }
	    	 if($('#fromdate').jqxDateTimeInput('getDate')==null){
	    		 document.getElementById("errormsg").innerText="";
	    		 document.getElementById("errormsg").innerText="Tarif valid from is mandatory";
	    		 $('#fromdate').jqxDateTimeInput('focus'); 
	    		 return 0;
	    	 }
	    	 if($('#todate').jqxDateTimeInput('getDate')==null){
	    		 document.getElementById("errormsg").innerText="";
	    		 document.getElementById("errormsg").innerText="Tarif valid from is mandatory";
	    		 $('#todate').jqxDateTimeInput('focus'); 
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
	    	 if(document.getElementById("hidtarifclient").value==""){
	    		 document.getElementById("hidtarifclient").value="0";
	    	 }
	    	 
	    	 var desc=document.getElementById("desc").value;
	    	 if(desc.length>250){
	    		 document.getElementById("errormsg").innerText="";
	    		 document.getElementById("errormsg").innerText="Description: Max 250 chars allowed";
	    		 document.getElementById("desc").focus();
	    		 return 0;
	    	 }
	    	 document.getElementById("errormsg").innerText="";
	    		return 1;
	     } 
		 
	     function setDeliveryCharge(){
	    	 if(document.getElementById("chkdelivery").checked==true){
	    		 document.getElementById("hidchkdelivery").value="1";
	    	 }
	    	 else{
	    		 document.getElementById("hidchkdelivery").value="0";
	    	 }
	     }
	     function setTarifClient(){
	    	 var value=document.getElementById("cmbtariftype").value;
	    	 if(value=="client" || value=="corporate"){
	    		 document.getElementById("tarifclient").disabled=false;
	    	 }
	    	 else{
	    		 document.getElementById("tarifclient").disabled=true;
	    	 }
	     }
</script>
 </head>
<body onLoad="setValues();">
	
   	<br/> 
	<div id="mainBG" class="homeContent" data-type="background"> 
		<form id="frmLimoTarifMgmt" action="saveLimoTarifMgmt" method="post" autocomplete="off">
			<jsp:include page="../../../header.jsp" />
   			<br>
    <div class='hidden-scrollbar'>
	<table width="100%">
	  <tr>
	    <td width="7%" align="right">Date</td>
	    <td width="7%"><div id="date" name="date" value='<s:property value="date"/>'></div> </td>
	    <td width="6%" align="right">Tarif type</td>
	    <td width="8%"><select name="cmbtariftype" id="cmbtariftype" onchange="setTarifClient();">
	    <option value="">--Select--</option>
	    <option value="regular">Regular</option>
	    <option value="corporate">Corporate</option>
	    <option value="client">Client</option>
	    </select>
	    </td>
	    <input type="hidden" name="hidcmbtariftype" id="hidcmbtariftype" value='<s:property value="hidcmbtariftype"/>'>
	    <td width="12%"><input type="text" name="tarifclient" id="tarifclient" readonly placeholder="Press F3 to Search" onkeydown="getClient(event);" value='<s:property value="tarifclient"/>'> </td>
	    <input type="hidden" name="hidtarifclient" id="hidtarifclient" value='<s:property value="hidtarifclient"/>' value='<s:property value="hidtarifclient"/>'>
	    <td width="5%" align="right">Tariff for</td>
	    <td width="8%"><select name="cmbtariffor" id="cmbtariffor">
	    <option value="">--Select--</option>
	    <option value="vehicle">Vehicle</option>
	    </select></td>
		<input type="hidden" name="hidcmbtariffor" id="hidcmbtariffor" value='<s:property value="hidcmbtariffor"/>'>
	    <td width="9%" align="right">Validity From</td>
	    <td width="1%"><div id="fromdate" name="fromdate" value='<s:property value="fromdate" />'></div></td>
	    <td width="7%" align="right">Validity To</td>
	    <td width="3%"><div  id="todate" name="todate" value='<s:property value="todate" />'></div></td>
	    <td width="10%" align="center">&nbsp;&nbsp;&nbsp;<label for="chkdelivery">Del.Chg</label>&nbsp;<input type="checkbox" name="chkdelivery" id="chkdelivery" onchange="setDeliveryCharge();"></td>
	    <input type="hidden" name="hidchkdelivery" id="hidchkdelivery" value='<s:property value="hidchkdelivery"/>' >
	    <td width="5%" align="right">Doc No</td>
	    <td width="12%"><input type="text" name="docno" id="docno" tabindex="-1" readonly value='<s:property value="docno" />'></td>
      </tr>
	  <tr>
	    <td align="right">Description</td>
	    <td colspan="12"><input type="text" name="desc" id="desc" style="width:98%;" value='<s:property value="desc" />'></td>
      	<td><button type="button"  id="btnTarifEdit" title="Tarif Edit" style="border:none;background:none;" onclick="funTarifEdit();" class="tarifbuttons">
							<img alt="Tarif Edit" src="<%=contextPath%>/icons/tarifedit.png" width="30" height="30">
		  </button>
    
		  <button type="button" id="btnTarifCancel" title="Tarif Cancel"  style="border:none;background:none;" onclick="funTarifCancel();" class="tarifbuttons">
							<img alt="Tarif Cancel" src="<%=contextPath%>/icons/tarifcancel.png" width="30" height="30">
		  </button>
		  <button type="button" id="btnTarifSave" title="Tarif Save"  style="border:none;background:none;" onclick="funTarifSave();" class="tarifbuttons">
							<img alt="Tarif Save" src="<%=contextPath%>/icons/tarifsave.png" width="30" height="30">
		  </button>
          </td>
      </tr>
      <tr>
	    <td colspan="4" align="right">&nbsp;</td>
	    <td colspan="3" align="right"><label id="lblgroupdetails" style="color:red;font-weight:bold;"></label></td>
	    <td colspan="6" align="right">&nbsp;</td>
	    <td >&nbsp;</td>
      </tr>
</table>

    <table width="100%">
      <tr>
        <td width="9%" rowspan="2"><div id="gridgroup1div"><jsp:include page="gridGroup1.jsp"></jsp:include></div></td>
        <td width="81%"><div id="gridtariftransferdiv"><jsp:include page="gridTarifTransfer.jsp"></jsp:include></div></td>
        <td width="10%" rowspan="2"><div id="gridgroup2div"><jsp:include page="gridGroup2.jsp"></jsp:include></div></td>
      </tr>
      <tr>
        <td><br>
        <div id="gridtarifhourdiv"><jsp:include page="gridTarifHour.jsp"></jsp:include></div></td>
      </tr>
    </table>
    
      <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
      <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
      <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
      <input type="hidden" name="tariftransferlength" id="tariftransferlength" value='<s:property value="tariftransferlength"/>'/>
      <input type="hidden" name="tarifhourslength" id="tarifhourslength" value='<s:property value="tarifhourslength"/>'/>
      <input type="hidden" name="hidgroup" id="hidgroup" value='<s:property value="hidgroup"/>'/>
  <div id="locationwindow">
   <div ><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:40%;" /></div>
</div>
<div id="clientwindow">
   <div ><img id="loadingImage1" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:50%;margin-top:30%;" /></div>
</div>
</div>
		</form>
	</div> 		
		
</body>
</html>