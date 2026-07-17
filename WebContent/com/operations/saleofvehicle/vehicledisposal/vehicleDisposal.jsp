<%@page import="com.connection.ClsConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
 
<!DOCTYPE html>
<html>
<head>
<s:head/>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
 <jsp:include page="../../../../includes.jsp"></jsp:include>
<style>

.hidden-scrollbar {
    overflow: auto;
    height: 520px;
}
</style>
<script type="text/javascript">
$(document).ready(function() {
	document.getElementById("btnEdit").disabled=true;  
	document.getElementById("btnDelete").disabled=true;
	 $('#clientwindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '53%' ,maxWidth: '50%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#clientwindow').jqxWindow('close');
	   $('#fleetwindow').jqxWindow({ width: '60%', height: '58%',  maxHeight: '58%' ,maxWidth: '50%' , title: 'Fleet Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#fleetwindow').jqxWindow('close');
	   $('#detailwindow').jqxWindow({ autoOpen:false,width: '90%', height: '70%',  maxHeight: '70%' ,maxWidth: '90%' , title: 'Asset List' ,position: { x: 100, y: 60 }, keyboardCloseKey: 27});
	   
$("#date").jqxDateTimeInput({
	width : '125px',
	height : '15px',
	formatString : "dd.MM.yyyy"
});
$("#fromdate").jqxDateTimeInput({
	width : '125px',
	height : '15px',
	formatString : "dd.MM.yyyy"
});
$("#todate").jqxDateTimeInput({
	width : '125px',
	height : '15px',
	formatString : "dd.MM.yyyy"
});
$('#client').dblclick(function(){
    $('#clientwindow').jqxWindow('open');
$('#clientwindow').jqxWindow('focus');
clientSearchContent('masterClientSearch.jsp');
});
});
function getClient(event){
	 var x= event.keyCode;
     if(x==114){
    	 $('#clientwindow').jqxWindow('open');
    	 $('#clientwindow').jqxWindow('focus');
    	 clientSearchContent('masterClientSearch.jsp');
     }
     else{
      }
}
function funSearchLoad(){
	 changeContent('mainSearch.jsp', $('#window')); 
}
function clientSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#clientwindow').jqxWindow('setContent', data);

}); 
}
function fleetnoSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#fleetwindow').jqxWindow('setContent', data);

}); 
}

function detailSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#detailwindow').jqxWindow('setContent', data);

}); 
}
function funChkButton(){
	
}
function funReadOnly(){
	 $('#date').jqxDateTimeInput({ disabled: true}); 
	 $('#disposalGrid').jqxGrid({ disabled: true}); 
		$('#frmVehicleDisposal input').attr('readonly', true );
		 $('#frmVehicleDisposal select').attr('disabled', true );
		 $('#frmVehicleDisposal textarea').attr('readonly', true );
		 $('#btncalculate').prop('disabled',true);

}
function funRemoveReadOnly(){
	 $('#date').jqxDateTimeInput({ disabled: false});
	 $('#disposalGrid').jqxGrid({ disabled: false}); 
		$('#frmVehicleDisposal input').attr('readonly', false );
		 $('#frmVehicleDisposal select').attr('disabled', false );
		 $('#frmVehicleDisposal textarea').attr('readonly', false );
		 $('#btncalculate').prop('disabled',false);
		 $('#client').prop('readonly',true);
		 $('#clientname').prop('readonly',true);
		 $('#docno').prop('readonly',true);
		 if(document.getElementById("mode").value=='A'){
			 $("#disposalGrid").jqxGrid('clear');
			 $("#disposalGrid").jqxGrid('addrow', null, {});
			 $("#jvGrid").jqxGrid('clear');
		 }
}
function funFocus(){
	document.getElementById("client").focus();
}
function setValues(){
funSetlabel();
	
	 if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
	 if ($('#hidcmbtype').val() != null) {
			$('#cmbtype').val($('#hidcmbtype').val());
		}
	 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";

	if(document.getElementById("docno").value!=""){
		document.getElementById("brchName").disabled=false;
		$('#disposaldiv').load('vehDisposalGrid.jsp?docno='+document.getElementById("docno").value+'&branch='+document.getElementById("hidbranch").value+'&id=1');
		$('#jvdiv').load('jvGrid.jsp?trno='+document.getElementById("trno").value+'&id=1');
	}
	//alert(document.getElementById("mode").value);
}
function funNotify(){
	if(document.getElementById("cmbtype").value==""){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Type is Mandatory";
		document.getElementById("cmbtype").focus();
		return 0;
	}
	var rows = $("#disposalGrid").jqxGrid('getrows');
	if(!((rows[0].fleet_no=="undefined") || (rows[0].fleet_no==null) || (rows[0].fleet_no==""))){
	
		var rowlength=0;
		for(var i=0 ; i < rows.length ; i++){
		
			newTextBox = $(document.createElement("input"))
		    .attr("type", "dil")
		    .attr("id", "test"+i)
		    .attr("name", "test"+i)
		    .attr("hidden", "true");
			if(rows[i].fleet_no!="" && rows[i].fleet_no!="undefined" && rows[i].fleet_no!=null){
				
		newTextBox.val(rows[i].fleet_no+"::"+rows[i].flname+"::"+rows[i].salesprice+"::"+rows[i].dep_posted+"::"+rows[i].pur_value+"::"+rows[i].acc_dep+"::"+rows[i].cur_dep+"::"+rows[i].net_pl+"::"+rows[i].netbook);
		
		newTextBox.appendTo('form');
		rowlength++;
			}
			
			//alert("ddddd"+$("#test"+i).val());
		}
		
		$('#gridlength').val(rowlength);
		
	}
 return 1;	
}

function deleteTempData(value){
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			
		} else {
		}
	}
	x.open("GET", "deleteTempData.jsp?mdoc="+value, true);
	x.send();
}

function funCalculate(){
	
	
		deleteTempData(document.getElementById("mdoc").value);
	
	var date=$('#date').jqxDateTimeInput('val');
	
	var rows=$('#disposalGrid').jqxGrid('getrows');
	var temp=0;
	var count=0;
	for(var i=0;i<rows.length;i++){
		var fleet=$("#disposalGrid").jqxGrid('getcellvalue',i,'fleet_no');
		temp=1;
		document.getElementById("errormsg").innerText="";
		if(fleet=="" || fleet=="undefined"){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Fleet is Mandatory";
			$('#disposalGrid').jqxGrid('selectcell', i, 'fleet_no');
			return false;
		}
		var salesprice=$("#disposalGrid").jqxGrid('getcellvalue',i,'salesprice');
		if(salesprice=="" || salesprice=="undefined"){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Sales Price is Mandatory";
			$('#disposalGrid').jqxGrid('selectcell', i, 'salesprice');
			return false;
		}
		
		if(document.getElementById("errormsg").innerText=="" && fleet!="" && fleet!="undefined" && fleet!=null){
			getCalData(fleet,salesprice,i,date);
			count++;
		}
			
	}
	

	if(temp==0){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Please Select Fleet";
		return false;
	}
	
}


function getCalData(fleet,salesprice,row,date){
	var client=document.getElementById("client").value;
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			items=items.split("::");
			
			$('#disposalGrid').jqxGrid('setcellvalue', row, 'dep_posted',items[0]); 
			$('#disposalGrid').jqxGrid('setcellvalue', row, 'pur_value',items[1]);
			$('#disposalGrid').jqxGrid('setcellvalue', row, 'acc_dep',items[2]);
			$('#disposalGrid').jqxGrid('setcellvalue', row, 'cur_dep',items[3]);
			$('#disposalGrid').jqxGrid('setcellvalue', row, 'net_pl',items[4]);
			$('#disposalGrid').jqxGrid('setcellvalue', row, 'netbook',items[5]);
			var dep_posted=$('#disposalGrid').jqxGrid('getcelltext', row, 'dep_posted'); 
			var pur_value=$('#disposalGrid').jqxGrid('getcelltext', row, 'pur_value').replace(/,/g , "");
			var acc_dep=$('#disposalGrid').jqxGrid('getcelltext', row, 'acc_dep').replace(/,/g , "");
			var cur_dep=$('#disposalGrid').jqxGrid('getcelltext', row, 'cur_dep').replace(/,/g , "");
			var net_pl=$('#disposalGrid').jqxGrid('getcelltext', row, 'net_pl').replace(/,/g , "");
			var netbook=$('#disposalGrid').jqxGrid('getcelltext', row, 'netbook').replace(/,/g , "");
			var salesprice=$('#disposalGrid').jqxGrid('getcelltext', row, 'salesprice').replace(/,/g , "");
			var fleetno=$('#disposalGrid').jqxGrid('getcelltext', row, 'fleet_no').replace(/,/g , "");
			var dtype=document.getElementById("formdetailcode").value;
			//alert(dtype);
			document.getElementById("days").value=items[3];
			if(pur_value!=null && typeof(pur_value)!="undefined"){
				
				funLoadTempJv(dep_posted,pur_value,acc_dep,cur_dep,net_pl,netbook,client,salesprice,fleetno,dtype);	
			}
			
		} else {
		}
	}
	x.open("GET", "getCalData.jsp?fleet="+fleet+"&salesprice="+salesprice+"&date="+date, true);
	x.send();
}
function funLoadTempJv(dep_posted,pur_value,acc_dep,cur_dep,net_pl,netbook,client,salesprice,fleetno,dtype){
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();
			//alert(items);
			document.getElementById("mdoc").value=items;
			$('#jvdiv').load('jvGrid.jsp?trno='+document.getElementById("mdoc").value+'&id=2');
		} else {
		}
	}
	x.open("GET", "loadTempJv.jsp?salesprice="+salesprice+"&dep_posted="+dep_posted+"&purvalue="+pur_value+"&accdep="+acc_dep+"&curdep="+cur_dep+"&netpl="+net_pl+"&netbook="+netbook+"&client="+client+"&fleetno="+fleetno+"&dtype="+dtype, true);
	x.send();
}


function getDetail(){
	if(document.getElementById("docno").value==""){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Please Select a Document";
		return false;
	}
	var detail="";
	
	if(document.getElementById("rdosummary").checked==false && document.getElementById("rdodetail").checked==false && document.getElementById("rdotabular").checked==false){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Please Select any Valid Option";
		return false;
	}
	$('#detailwindow').jqxWindow('open');
	 $('#detailwindow').jqxWindow('focus');
	if(document.getElementById("rdosummary").checked==true){
		detailSearchContent('getGridSummary.jsp');
	}
	else if(document.getElementById("rdodetail").checked==true){
		detailSearchContent('getGridDetail.jsp');
	}
	else{
		detailSearchContent('getGridTabular.jsp?docno='+document.getElementById("docno").value+'&fromdate='+$('#fromdate').jqxGrid('val')+'&todate='+$('#todate').jqxGrid('val'));
	}
	
}
/* function funPrintBtn(){
	var url=document.URL;
	var reurl=url.split("saveActionVehicleDisposal");
    var win= window.open(reurl[0]+"printSaleInvoice?doc_no="+document.getElementById("doc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
    win.focus();
}
 */
function funPrintBtn() {
 	   if(document.getElementById("docno").value=='' || document.getElementById("docno").value=='0'){
		 $.messager.alert('Warning','Select a Document');
		 return false;
	}
	 var url=document.URL;

		 var reurl=url.split("com/");	 
	 	 var win= window.open(reurl[0]+"com/operations/saleofvehicle/vehicledisposal/printSaleInvoice.action?docno="+document.getElementById("docno").value+"&trno="+document.getElementById("trno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
		 win.focus();      
	 
	 }
</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmVehicleDisposal" action="saveActionVehicleDisposal" autocomplete="off" >

	<jsp:include page="../../../../header.jsp" />
	<br/> 
<div class="hidden-scrollbar">
<fieldset>
<table width="100%" >
  <tr>
    <td width="6%" align="right">Date</td>
    <td width="11%" align="left"><div id="date" name="date" value='<s:property value="date"/>'></div></td>
    <td width="29%">&nbsp;</td>
    <td width="4%">&nbsp;</td>
    <td width="8%">&nbsp;</td>
    <td width="9%" align="right">Doc No</td>
    <td width="11%" align="left"><input type="text" name="vocno" id="vocno" value='<s:property value="vocno"/>' tabindex="-1"  readonly></td>
    <td colspan="2" align="left">&nbsp;</td>
  </tr>
  <tr>
    <td align="right">Client</td>
    <td align="left"><input type="text" name="client" id="client" value='<s:property value="client"/>' readonly placeholder="Press F3 to Search" onkeydown="getClient(event);"></td>
    <td colspan="3" align="left"><input type="text" name="clientname" id="clientname" value='<s:property value="clientname"/>' style="width:99%;" readonly></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td al align="right">Description</td>
    <td colspan="2" align="left"><input type="text" name="description" id="description" value='<s:property value="description"/>' style="width:97.5%;"></td>
    <td align="left">Type</td>
    <td align="left"><select name="cmbtype" id="cmbtype" >
      <option value="">--Select--</option>
      <option value="S">Sale</option>
      <option value="L">Total Loss</option>
    </select></td>
    <td align="center"><input type="button" name="btncalculate" id="btncalculate" class="myButton" onclick="funCalculate();" value="Calculate"></td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td align="right">&nbsp;</td>
    <td colspan="7" align="left"><div id="disposaldiv"><jsp:include page="vehDisposalGrid.jsp"></jsp:include></div></td>
    <td width="10%" align="left">&nbsp;</td>
  	
  </tr>
  
  <tr>
    
 <td align="right">&nbsp;</td>
    <td colspan="7" align="left"><div id="jvdiv"><jsp:include page="jvGrid.jsp"></jsp:include></div></td>
    <td width="10%" align="left">&nbsp;</td>
  </tr>
</table>



   <%--  <td><fieldset>
    <table width="100%">
  <tr>
    <td width="50%"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
    <td width="50%"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
  </tr>
  <tr>
    <td align="left"><input type="radio" id="rdosummary" name="rdo" value="rdosummary"><label for="rdosummary">Summarised</label></td>
    <td align="left">&nbsp;</td>
    </tr>
  <tr>
    <td align="left"><input type="radio" id="rdodetail" name="rdo" value="rdodetail" ><label for="rdodetail">Detailed</label></td>
    <td align="center"><input type="button" name="btnList" id="btnList" value="get Detail" class="myButton" onclick="getDetail();"></td>
    </tr>
  <tr>
    <td align="left"><input type="radio" id="rdotabular" name="rdo" value="rdotabular" ><label for="rdotabular">Tabular</label></td>
    <td align="left">&nbsp;</td>
    </tr>
</table>

    </fieldset> --%>
    
    
    
    <div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>' hidden=true></div>
    <div id="todate" name="todate" value='<s:property value="todate"/>' hidden=true></div>
    <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
    <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
    <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
    <input type="hidden" name="hiddate" id="hiddate" value='<s:property value="hiddate"/>'>
    <input type="hidden" name="hidcmbtype" id="hidcmbtype" value='<s:property value="hidcmbtype"/>'>
    <input type="hidden" name="trno" id="trno" value='<s:property value="trno"/>'> 
    <input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
    <input type="hidden" name="clientacno" id="clientacno" value='<s:property value="clientacno"/>'>
    <input type="hidden" name="hidbranch" id="hidbranch" value='<s:property value="hidbranch"/>'>
    <input type="hidden" name="days" id="days" value='<s:property value="days"/>'>
    <input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>' tabindex="-1"  readonly>
    <input type="hidden" name="mdoc" id="mdoc" value='<s:property value="mdoc"/>' tabindex="-1"  readonly><!-- Temperory jv docno -->
  </div>
</form>
<div id=clientwindow>
   <div ></div>
</div>
<div id="fleetwindow">
   <div ></div>
</div>
<div id="detailwindow">
   <div ></div>
</div>
</div>
</body>
</html>
