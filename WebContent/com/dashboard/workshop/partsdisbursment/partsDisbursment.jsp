<link href="../../../../css/css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%--  <script type="text/javascript" src="../../js/dashboard.js"></script>  --%>
<style type="text/css">
.myButtons {
	display: inline-block;
	margin-right:4px;
	margin-left:4px; 
  margin-bottom: 0;
  font-weight: normal;
  line-height: 1.3;
  text-align: center;
  white-space: nowrap;
  vertical-align: middle;
  -ms-touch-action: manipulation;
      touch-action: manipulation;
  cursor: pointer;
  -webkit-user-select: none;
     -moz-user-select: none;
      -ms-user-select: none;
          user-select: none;
  background-image: none;
  border: 1px solid transparent;
  border-radius: 4px;
  color: #fff;
  background-color: grey;
}
.myButtons:hover {
	  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons:active {
  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons:focus {
  color: #fff;
  background-color: grey;
}
 
select{
    height:18px;
}
.hidden-scrollbar {
  /* // overflow: auto; */
  height: 530px;
    overflow-x: hidden;
    
}
.headClass
        {
            background-color: #FFEBC2;
        }
        .redClass
        {
            background-color: #FFEBEB;
        }
        .violetClass
        {
            background-color: #EBD6FF;
        }
        .yellowClass
        {
            background-color: #FFFFD1;
        }
        .whiteClass
        {
           background-color: #FFF;
        }
        .greenClass
        {
           background-color: #CEFFCE;
        }	  
</style>

<script type="text/javascript">

$(document).ready(function () {
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	    
	$("#Uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});

	$('#accountwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#accountwindow').jqxWindow('close');
	 
	$('#fromaccount').dblclick(function(){
		$('#accountwindow').jqxWindow('open');
		$('#accountwindow').jqxWindow('focus');
		accountSearchContent("accountSearchGrid.jsp?id=1&fromto=1");
	});
	$('#toaccount').dblclick(function(){
		$('#accountwindow').jqxWindow('open');
		$('#accountwindow').jqxWindow('focus');
		accountSearchContent("accountSearchGrid.jsp?id=1&fromto=2");
	});
	 
});
function funExportBtn(){
	JSONToCSVConvertor(floordata, 'Parts Management', true);
}
function funClearData(){
	$('input[type=text],[type=hidden]').val('');
	$('select').find('option').prop("selected", false);
	$('#Uptodate').jqxDateTimeInput('setDate',new Date());
	$("#partsDisbursmentGrid,#cashGrid,#creditGrid").jqxGrid('clear');
}
function funreload(event)
{	
	$("#partsdisbursmentdiv").load("partsDisbursmentGrid.jsp?&id=1");
}
	
function accountSearchContent(url) {
	$.get(url).done(function (data) {
		$('#accountwindow').jqxWindow('setContent', data);
	}); 
}
function getFromAccount(event){
	var x= event.keyCode;
    if(x==114){
    	$('#accountwindow').jqxWindow('open');
		$('#accountwindow').jqxWindow('focus');
		accountSearchContent("accountSearchGrid.jsp?id=1&fromto=1");
    }
    else{
    }
}

function getToAccount(event){
	var x= event.keyCode;
    if(x==114){
    	$('#accountwindow').jqxWindow('open');
		$('#accountwindow').jqxWindow('focus');
		accountSearchContent("accountSearchGrid.jsp?id=1&fromto=2");
    }
    else{
    }
}
function funCreateCot(){
	var jobdocno=$('#jobcarddocno').val();
	var jobvocno=$('#jobcardvocno').val();
	if(jobdocno==''){
		$.messager.alert('Warning','Please select a jobcard');
		return false;
	}
	var selectedrows=$('#cashGrid').jqxGrid('getselectedrowindexes');
	if(selectedrows.length==0){
		$.messager.alert('Warning','Please select any valid documents');
		return false;
	}
	var amount=0.0;
	var rows="";
	for(var i=0;i<selectedrows.length;i++){
		if(i==0){
			rows+=$('#cashGrid').jqxGrid('getcellvalue',selectedrows[i],'rowno')
		}
		else{
			rows+=","+$('#cashGrid').jqxGrid('getcellvalue',selectedrows[i],'rowno')
		}
		amount+=parseFloat($('#cashGrid').jqxGrid('getcellvalue',selectedrows[i],'total'));
	}
	var fromacno=$('#fromacno').val();
	var toacno=$('#toacno').val();
	if(fromacno==''){
		$.messager.alert('Warning','Please select From Account');
		return false;
	}
	if(toacno==''){
		$.messager.alert('Warning','Please select To Account');
		return false;
	}
	funCreateCOTAJAX(jobdocno,amount,fromacno,toacno,jobvocno,rows);
}
	
	function funCreateCOTAJAX(jobdocno,amount,fromacno,toacno,jobvocno,rows){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
				if(items.split("::")[0]=="0"){
					$.messager.alert('Message',items.split("::")[1]);
					funClearData();
					funreload("");
				}
				else{
					$.messager.alert('Warning',items.split("::")[1]);
				}
				} else {
				}
			}
			x.open("GET", "createCOT.jsp?jobdocno="+jobdocno+"&amount="+amount+"&fromacno="+fromacno+"&toacno="+toacno+"&jobvocno="+jobvocno+"&rows="+rows, true);
			x.send();
	}
	
	
	function funServiceUpdate(){  
		
		var jobno=$('#jobcarddocno').val();
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
		{
			var items=x.responseText;
			if(parseInt(items)>=1)
			{
				 $("#partsdisbursmentdiv").load("partsDisbursmentGrid.jsp?&id=1");
				  $("#partflwupgrid").load("partsfllwup.jsp?docno="+jobno+"");
				$.messager.alert('Message', ' Successfully Updated ');
			}
			else
			{
				$.messager.alert('Message', ' Not Updated ');
			}
		}   
		}  
		x.open("GET","saveData.jsp?rowno="+$('#rowsno').val()+"&date="+$('#Uptodate').val()+"&remarks="+$('#txtremarks').val()+"&statusid="+$('#txtstatus').val()+"&jobno="+$('#jobcarddocno').val(),true);    
		x.send();
	}
</script> 
	
</head>
<!-- setValues(); -->
<body onload="getBranch();disablepart();">
<!-- <form id="frmWorkQuotationApproval" method="post"> -->
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
	<tr>
		<td width="20%" align="center">
    		<fieldset style="background: #ECF8E0;">
				<table width="100%">
					<jsp:include page="../../heading.jsp"></jsp:include>
					<tr>
   						<td width="37%" align="right"><label class="branch">Status</label></td>            
         				<td ><select id="txtstatus" name="txtstatus" style="width:75%;height:20px;" value='<s:property value="txtstatus"/>'>   
      							<option value="">--select--</option>
      							<option value="Available">Available</option>
      							<option value="PartAvail">Partially Available</option>
      							<option value="Delayed">Delayed</option>
      							<option value="Ordered">Ordered</option>
      						</select>
  						</td>
  					</tr>
					<tr>
   						<td width="37%" align="right"><label class="branch">Parts exp.Dt</label></td><td width="63%"><div id="Uptodate"></div></td>
 					</tr>
					 <tr>
   <td width="37%" align="right"><label class="branch">Remarks</label></td>
   <td width="63%"><input type="text" name="txtremarks" id="txtremarks" style="height:20px;width:90%;" value='<s:property value="txtremarks"/>' ></td>
 </tr>
 					<tr>
 						<td align="right"><label class="branch">Account From</label></td>
 						<td align="left"><input type="text" name="fromaccount" id="fromaccount" readonly placeholder="Press F3 to Search" onkeydown="getFromAccount();" style="height:18px;"></td>
 					</tr>
 					<tr>
 						<td colspan="2"><input type="text" name="fromaccountname" id="fromaccountname" style="width:100%;height:18px;" readonly disabled></td>
 					</tr>
 					<input type="hidden" name="fromacno" id="fromacno" >
 					<tr>
 						<td align="right"><label class="branch">Account To</label></td>
 						<td align="left"><input type="text" name="toaccount" id="toaccount" readonly placeholder="Press F3 to Search" onkeydown="getToAccount();" style="height:18px;"></td>
 					</tr>
 					<tr>
 						<td colspan="2"><input type="text" name="toaccountname" id="toaccountname" style="width:100%;height:18px;" readonly disabled></td>
 					</tr>
 					<input type="hidden" name="toacno" id="toacno" >
 					
 					<tr colspan="2"><td>&nbsp;</td></tr>
 					<tr>
 						<td colspan="2" style="border-top:2px solid #DCDDDE;" align="center">
							<input type="button" name="btnupdate" id="btnupdate" value="Update" class="myButtons" onclick="funServiceUpdate();">
  							<input type="button" name="btncreatecot" id="btncreatecot" value="Create Contra Trans" class="myButtons" onclick="funCreateCot();">
  						</td>
  					</tr>
					<tr ><td colspan="2">&nbsp;</td></tr>
					<tr colspan="2"><td><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br></td></tr>
				</table>
			</fieldset>
		</td>
		<td width="80%">
			<fieldset class="violetClass">
				<legend>Parts Disbursment Details </legend>
	    		<table width="100%" >
		  			<tr>
	   					<td><div id="partsdisbursmentdiv"><jsp:include page="partsDisbursmentGrid.jsp"></jsp:include></div></td>
	   	  			</tr>
				</table>
			</fieldset>
			<fieldset class="violetClass">
				<legend>Cash Details</legend>
	    		<table width="100%" border="0">
		  			<tr>
	   					<td><div id="cashgriddiv"><jsp:include page="cashGrid.jsp"></jsp:include></div></td>
	   	  			</tr>  
				</table>
			</fieldset>
			<fieldset class="violetClass">
				<legend>Credit Details</legend>
	    		<table width="100%">
		 			<tr>
	   					<td><div id="creditgriddiv"><jsp:include page="creditGrid.jsp"></jsp:include></div></td>
	   	  			</tr> 
				</table>
			</fieldset>
			<fieldset class="violetClass">
				<legend>Parts Followup</legend>
	    		<table width="100%" border="0">
		 			<tr>
	   					<td><div id="partflwupgrid"><jsp:include page="partsfllwup.jsp"></jsp:include></div></td>
	   	  			</tr> 
				</table>
			</fieldset> 
		</tr>
	</table>
</div>

</div>
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="rowsno" id="rowsno" value='<s:property value="rowsno"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  <input type="hidden" name="jobcarddocno" id="jobcarddocno" value='<s:property value="jobcarddocno"/>'>
			  <input type="hidden" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>'>
			  <input type="hidden" name="jobno" id="jobno" value='<s:property value="jobno"/>'>
			  <input type="hidden" name="techno" id="techno" value='<s:property value="techno"/>'>
			  <input type="hidden" name="bayno" id="techno" value='<s:property value="techno"/>'>
			  <input type="hidden" name="part" id="part" value='<s:property value="part"/>'>
			  <input type="hidden" name="qnty" id="qnty" value='<s:property value="qnty"/>'>
			  <input type="hidden" name="rownum" id="rownum" value='<s:property value="rownum"/>'>
			  <input type="hidden" name="purqty" id="purqty" value='<s:property value="purqty"/>'>
			   <input type="hidden" name="tbpur" id="tbpur" value='<s:property value="tbpur"/>'>
			  <input type="hidden"  id="srvdetmtrno" name="srvdetmtrno" value='<s:property value="srvdetmtrno"/>' >
			  <input type="hidden"  id="chngntb" name="chngntb" value='<s:property value="chngntb"/>' >
			  <input type="hidden"  id="addval" name="addval" value='<s:property value="addval"/>' >
			  <input type="hidden" id="vendorname" name=vendorname value='<s:property value="vendorname"/>'>
			  <input type="hidden" id="vendorid" name=vendorid value='<s:property value="vendorid"/>'>
			  <input type="hidden" id="vendtax" name=vendtax value='<s:property value="vendtax"/>'>
			  <input type="hidden" id="vendacno" name=vendacno value='<s:property value="vendacno"/>'>
			   <input type="hidden" id="raccno" name=raccno value='<s:property value="raccno"/>'>
			     <input type="hidden" id="nettotal" name=nettotal value='<s:property value="nettotal"/>'>
			     <input type="hidden" id="remtrno" name=remtrno value='<s:property value="remtrno"/>'>
			     <input type="hidden" id="hiddesc" name=hiddesc value='<s:property value="hiddesc"/>'>
</form>
<div id="TechnicianWindow">
	<div></div>
	</div>
	<div id="bayWindow">
	<div></div>
	</div>
	<div id="accountwindow">
	<div></div>
	</div>
	<div id="jobCardToWindow">
	<div></div>
	</div>
	<div id="vendorToWindow">
	<div></div>
</div>
</body>
</html>