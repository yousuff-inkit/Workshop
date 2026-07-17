<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Job Card</title>
<jsp:include page="../../../includes.jsp"></jsp:include>
<style>
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
<%
String id=request.getParameter("id")==null?"":request.getParameter("id");
String estdocno=request.getParameter("estdocno")==null?"":request.getParameter("estdocno");
String gatedocno=request.getParameter("gatedocno")==null?"":request.getParameter("gatedocno");
%>
<script type="text/javascript">

$(document).ready(function() {

	$("#date").jqxDateTimeInput({  width:'125px',height : '15px', formatString : "dd.MM.yyyy",maxDate:new Date() });
	$('#searchwindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	$('#searchwindow').jqxWindow('close'); 
	$('#refno').dblclick(function(){

	    var reftype=document.getElementById("cmbreftype").value;
	    if(reftype=="GIP" || reftype=="EST"){
	    	SearchContent("refnoSearch.jsp?reftype="+reftype+"&branch="+$('#brchName').val());
	    }
	    else{
	    }
	});
	getDocDateConfig();
	var estdocno='<%=estdocno%>';
	if(estdocno!="" && estdocno!="undefined" && estdocno!=null && typeof(estdocno)!="undefined"){
		getRefData(estdocno);
	}

});

function getRefData(estdocno){
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim().split("::");
			$('#cmbreftype').val("EST");
			$('#refno').val(items[0]);
            $('#hidrefno').val(items[1]);
            $('#regno').val(items[2]);
            $('#vehicledetails').val(items[3]);
            $('#userdetails').val(items[4]);
            $('#cldocno').val(items[5]);
            if($('#cmbreftype').val()=="EST"){
            	$('#sparediv').load('sparepartsGrid.jsp?docno='+$('#hidrefno').val()+'&id=1');
            	$('#labourdiv').load('labourcostGrid.jsp?docno='+$('#hidrefno').val()+'&id=1');
            	$('#labourcostGrid,#sparepartsGrid').jqxGrid({disabled:false});
            }
		}
		else{
			}
		}
	
	x.open("GET", "getRefData.jsp?estdocno="+estdocno, true);
	x.send();
}
 function SearchContent(url) {
 	$('#searchwindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#searchwindow').jqxWindow('setContent', data);
	$('#searchwindow').jqxWindow('bringToFront');
}); 
}
	
function funReadOnly() {
	
	$('#frmjobcard input').attr('readonly',true);
	$('#frmjobcard select').attr('disabled',true);
var id='<%=id%>';
	 if(id=="3"){
	  funCreateBtn();
	 }
	
}
function funRemoveReadOnly() {
	$('#frmjobcard input').attr('readonly',false);
	$('#frmjobcard select').attr('disabled',false);
	var id='<%=id%>';
	var est
	if(id=="3"){
		$('#sparediv').load('../../../com/workshop/jobcard/sparepartsGrid.jsp?docno='+$('#hidrefno').val()+'&id=1');
		$('#labourdiv').load('../../../com/workshop/jobcard/labourcostGrid.jsp?docno='+$('#hidrefno').val()+'&id=1');
	}
	getDocDateConfig();
}
function setValues() {
	if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
	 }
	if($('#hidcmbreftype').val()!=""){
		$('#cmbreftype').val($('#hidcmbreftype').val());
	 }
	
	$('#sparediv').load('../../../com/workshop/jobcard/sparepartsGrid.jsp?docno='+$('#hidrefno').val()+'&id=1');
	$('#labourdiv').load('../../../com/workshop/jobcard/labourcostGrid.jsp?docno='+$('#hidrefno').val()+'&id=1');
	
}
function funNotify(){
	var docdateval=funDateInPeriod($('#date').jqxDateTimeInput('getDate'));
	if(docdateval==0){
		$('#date').jqxDateTimeInput('focus');
		return 0;
	}
	var docdateconfig=$('#docdateconfig').val();
	if(docdateconfig=="1"){
		var currentdate=new Date();
		currentdate.setHours(0,0,0,0);
		var docdate=new Date($('#date').jqxDateTimeInput('getDate'));
		docdate.setHours(0,0,0,0);
		if(currentdate.getTime()!=docdate.getTime()){
			$.messager.alert('Warning','Document Date should be Current Date');
			$('#date').jqxDateTimeInput('focus');
			return 0;
		}
		else{
			
		}
	}
	return 1;
}

 function funFocus(){
	document.getElementById("cmbreftype").focus();
} 

function getRefno(event){
    var x= event.keyCode;
    if(x==114){
    	var reftype=document.getElementById("cmbreftype").value;
	    if(reftype=="GIP" || reftype=="EST"){
	    	SearchContent("refnoSearch.jsp?reftype="+reftype+"&branch="+$('#brchName').val());
	    }
	    else{
	    }
    }
}
function funSearchLoad(){
	changeContent('masterSearch.jsp', $('#window'));
 }
 
function funPrintBtn(){
	 if($('#docno').val()!='' && $('#docno').val()!='0'){
		var url=document.URL;
		var reurl=url.split("com");
		/* var path= "com/dashboard/workshop/quotationapproval/printQuotationAproval.action?estDocno="+estdocno; */
		var path= "com/workshop/jobcard/printVoucherWindow.jsp?docno="+$('#docno').val();
		var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=400,Height=200,location=no,scrollbars=no,toolbar=yes");		
		win.focus();		
	 }
}   

function getDocDateConfig(){
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			items = x.responseText.trim();
			$('#docdateconfig').val(items);
		} else {
		}
	}
	x.open("GET", "getDocDateConfig.jsp", true);
	x.send();
}
</script>

</head>
<body onLoad="setValues();">
<div>
<form id="frmWSJobCard" action="saveWSJobCard">
	<jsp:include page="../../../header.jsp" />
	<br>
	<div class='hidden-scrollbar'>
	
	<table width="100%" border="0" >
      <tr>
        <td width="13%" height="31" align="right">Date</td>
        <td width="14%"><div id="date" name="date" value='<s:property value="date"/>'></div></td>
        <td colspan="2">&nbsp;</td>
        <td width="6%" align="right">Doc No</td>
        <td width="14%"><input type="text" name="vocno" id="vocno" value='<s:property value="vocno"/>'></td>
      </tr>
      <tr>
        <td align="right">Ref Type</td>
        <td><select name="cmbreftype" id="cmbreftype" value='<s:property value="cmbreftype"/>' style="width:126px; text-align:center;">
          <option value="">--Select--</option>
          <!-- <option value="GIP">Gate In Pass</option> -->
          <option value="EST">Estimation</option>
        </select></td>
        <input type="hidden" name="hidcmbreftype" id="hidcmbreftype" value='<s:property value="hidcmbreftype"/>'>
        <td width="6%" align="right">Ref No</td>
        <td colspan="3"><input type="text" name="refno" id="refno" value='<s:property value="refno"/>' placeholder="Press F3 to Search" onkeydown="getRefno(event)" readonly></td>
      </tr>
      <input type="hidden" name="hidrefno" id="hidrefno" value='<s:property value="hidrefno"/>'>
      <tr>
        <td align="right">Reg no</td>
        <td><input type="text" name="regno" id="regno" value='<s:property value="regno"/>' ></td>
        <td align="right"> Veh.Details</td>
        <td colspan="3"><input type="text" name="vehicledetails" id="vehicledetails" style="width:95%" value='<s:property value="vehicledetails"/>'></td>
      </tr>
      <tr>
        <td align="right">Client</td>
        <td><input type="text" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>' ></td>
        <td align="right">Client Details</td>
        <td colspan="3"><input type="text" name="userdetails" id="userdetails" style="width:95%" value='<s:property value="userdetails"/>'></td>
      </tr>
    </table>
    
    <fieldset class="redClass">
	<legend>Services </legend>
	    <table width="100%" border="0">
		  <tr>
	   		<td colspan="10"><div id="labourdiv"><jsp:include page="labourcostGrid.jsp"></jsp:include></div></td>
	   	  </tr>
		</table>
	</fieldset>
	
	<fieldset class="violetClass">
	<legend>Spares Details </legend>
	    <table width="100%" border="0">
		  <tr>
	   		<td colspan="10"><div id="sparediv"><jsp:include page="sparepartsGrid.jsp"></jsp:include></div></td>
	   	  </tr>
		</table>
	</fieldset>
	
			<input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>'>
      		<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
		    <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
      		<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
	<input type="hidden" name="docdateconfig" id="docdateconfig" value='<s:property value="docdateconfig"/>'/>
		</div>
	</form>
	<div id="searchwindow">
	<div></div>
	</div>
</div>
</body>
</html>