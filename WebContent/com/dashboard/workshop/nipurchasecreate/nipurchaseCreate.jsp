<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@page import="javax.servlet.http.HttpSession.*"%>
<%@page import="javax.servlet.http.HttpServletRequest.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%String contextPath=request.getContextPath(); %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>
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
select{
    height:15px;
}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	    
	    $("#fromdate").jqxDateTimeInput({width:'125px', height: '15px', formatString:'dd.MM.yyyy'});
	    $("#todate").jqxDateTimeInput({width:'125', height:'15px', formatString:'dd.MM.yyyy'});
	    $("#invdate").jqxDateTimeInput({width:'125', height:'15px', formatString:'dd.MM.yyyy'});
	    var curfromdate=$("#fromdate").jqxDateTimeInput('getDate');
	    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	    $("#fromdate").jqxDateTimeInput('setDate',onemonthbackdate);
	    
	    $('#vendorToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Vendor Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		$('#vendorToWindow').jqxWindow('close');
		$('#poToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Po Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		$('#poToWindow').jqxWindow('close');
		
		$("#vendor").dblclick(function(){
			vendorSearchContent("vendorSearch.jsp");
		});
		$("#pono").dblclick(function(){
			poSearchContent("purchaseOrderSearch.jsp");
		});
	    
	 
	});
	function vendorSearchContent(url) {
	 	$('#vendorToWindow').jqxWindow('open');
		$.get(url).done(function (data) {
			$('#vendorToWindow').jqxWindow('setContent', data);
		});
	}
	function poSearchContent(url) {
	 	$('#poToWindow').jqxWindow('open');
		$.get(url).done(function (data) {
			$('#poToWindow').jqxWindow('setContent', data);
		});
	}
	function getPoDetails(event){
		var x= event.keyCode;
	    if(x==114){
	    	poSearchContent("purchaseOrderSearch.jsp");
	    }
	    else{
	     }
	}
	
	function funreload(event)
	{
		
	    var fromdate=$('#fromdate').jqxDateTimeInput('val');
	    var todate=$('#todate').jqxDateTimeInput('val');
	    var vendorid=document.getElementById("vendorid").value;
	    var podocno=document.getElementById("podocno").value;
	    
	    	$("#overlay, #PleaseWait").show(); 
	   	   	$("#nipurchaseCreateDiv").load("nipurchaseCreateGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1"+"&vendorid="+vendorid+"&podocno="+podocno);
	}
	function setValues(){

		 if($('#msg').val()!=""){
  		   $.messager.alert('Message',$('#msg').val());
  		  }
	
	}
	function funClearData(){
		$('input[type=text],[type=hidden]').val('');
		$('select').find('option').prop("selected", false);
		$('#fromdate').jqxDateTimeInput('setDate',new Date());
		$('#todate').jqxDateTimeInput('setDate',new Date());
		var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	
	}
	function funPoCreate(){
		var atype=$('#atype').val();
		var acno=$('#acno').val();
		var acname=$('#acname').val();
		var curid=$('#curid').val();
		var rate=$('#rate').val();
		var orderdate=$('#orderdate').val();
		var orderno=$('#hdocno').val();
		var amount=$('#amount').val();
		var invdate=$('#invdate').jqxDateTimeInput('val');
		var invno=$('#invno').val();
		var vendorname=$('#vendorname').val();
		var costtype="9";
		var remarks="";
		var costcode=$('#costcode').val();
		var headdoc=$('#headdoc').val();
		var curdate=$('#curntdate').val();
		
		if(orderno==null || orderno=="" || orderno===undefined){
			$.messager.alert('Message','Please select a document');
			return 0;
		}else{
			if(invno=="" || invno==null){
				$.messager.alert('Message','Inv No is mandatory');
				return 0;
			}else if(invdate=="" || invdate==null){
				$.messager.alert('Message','Inv Date is mandatory');
				return 0;
			}else{
				
			}
		}
		
		var descarray=[];
		
	   var rows = $("#detailGridID").jqxGrid('getrows');
	   for(var i=0 ; i < rows.length ; i++){
	   
		   /* descarray.push(rows[i].srno+"::"+rows[i].qty+" :: "+rows[i].description+" :: "
			   +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "+rows[i].nuprice+" :: "+rows[i].taxper+"::"+rows[i].taxperamt+"::"+rows[i].taxamount+"::"); */
	
		   descarray.push(rows[i].srno+"::"+rows[i].qty+" :: "+rows[i].description+" :: "
				   +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "+rows[i].nuprice+" :: "
				   +costtype+" :: "+costcode+" :: "+remarks+" :: "+headdoc+" :: "+orderno+" :: "+rows[i].taxper+"::"+rows[i].taxperamt+"::"+rows[i].taxamount+"::");
	   }
	   //alert(descarray);
		 var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var sts = x.responseText;
					if(sts==1){
						$.messager.alert('Message','Not Updated');
					}
					if(sts==0){
						$.messager.alert('Message','Updated Succesfully');
						
						funreload(event);
						funClearData();
						$("#detailGridID").jqxGrid('clear');
					}
				}
		
				
		}
		x.open("GET", "poCreate.jsp?orderno="+orderno+"&atype="+atype+"&acno="+acno+"&acname="+acname+"&curid="+curid+"&rate="+rate+"&orderdate="+orderdate+"&descarray="+descarray+"&amount="+amount+"&invno="+invno+"&invdate="+invdate+"&vendorname="+vendorname+"&curdate="+curdate, true);
		x.send(); 
	}
	function funExportBtn(){
		//alert("inside Export");
		JSONToCSVCon(poexportdata, 'Purchase Order List', true);
		}
</script>
</head>
<body onload="getBranch()">
<form id="nipurchaseCreate" action="post">
<div id="mainBG" class="homeContent" data-type="background">
<div class="hidden-scrollbar">

 <table width="100%">
 <tr>
 	<td width="20%">
 	<fieldset style="background: #ECF8E0;">
 	<table width="100%" id=>
 		<jsp:include page="../../heading.jsp"></jsp:include>
 		<tr>
		   <td width="34%" align="right"><label class="branch">From Date</label></td>
		   <td width="66%"><div id="fromdate"></div></td></tr>
		 <tr>
		   <td align="right"><label class="branch">To Date</label></td>
		   <td><div id="todate"></div></td>
		 </tr>
		 <tr>
		   <td align="right"><label class="branch">Purchase Order</label></td>
		   <td><input type="text" name="pono" id="pono" style="height: 18px;" readonly="readonly" placeholder="Press F3 to search" onkeydown="getPodetails(event)" value='<s:property value="pono" />'></td>
		 </tr>
		 <tr>
		   <td align="right"><label class="branch">Vendor</label></td>
		   <td><input type="text" name="vendor" id="vendor" style="height: 18px;" readonly="readonly" placeholder="Press F3 to search" onkeydown="getVendorDetails(event)" value='<s:property value="vendor" />'></td>
		 </tr>
		 <tr>
		   <td align="right"><label class="branch">Inv No</label></td>
		   <td><input type="text" name="invno" id="invno" style="height: 18px;"  placeholder="Enter Inv No"  value='<s:property value="invno" />'></td>
		 </tr>
		 <tr>
		   <td align="right"><label class="branch">Inv Date</label></td>
		   <td><div id="invdate"></div></td>
		 </tr>
		 <tr><td colspan="2" style="border-top:2px solid #DCDDDE;"></tr>
		 <tr><td colspan="2" align="center">
		 	<input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();">&nbsp;&nbsp;
		 	<input type="button" name="btncreate" id="btncreate" value="Create" class="myButtons" onclick="funPoCreate();">
		 </td></tr>
		 <tr>
		 	<td colspan="2" height="216">&nbsp;</td>
		 </tr>
 	</table>
 	</fieldset>
 	</td>
 	<td width="80%">
 	<table width="100%">
 		<tr>
 			<td><div id="nipurchaseCreateDiv"><jsp:include page="nipurchaseCreateGrid.jsp"></jsp:include></div></td>
 		</tr>
 		<tr>
 			<td><div id="detaildiv"><jsp:include page="detailGrid.jsp"></jsp:include></div></td>
 		</tr>
 		<tr>
 			<td></td>
 			<input type="hidden" id="msg" name=msg value='<s:property value="msg"/>'>
 			<input type="hidden" id="vendorid" name=vendorid value='<s:property value="vendorid"/>'>
 			<input type="hidden" id="podocno" name=podocno value='<s:property value="podocno"/>'>
 			<input type="hidden" id="hdocno" name=hdocno value='<s:property value="hdocno"/>'>
 			<input type="hidden" id="atype" name=atype value='<s:property value="atype"/>'>
 			<input type="hidden" id="acno" name=acno value='<s:property value="acno"/>'>
 			<input type="hidden" id="acname" name=acname value='<s:property value="acname"/>'>
 			<input type="hidden" id="curid" name=curid value='<s:property value="curid"/>'>
 			<input type="hidden" id="rate" name=rate value='<s:property value="rate"/>'>
 			<input type="hidden" id="orderdate" name=orderdate value='<s:property value="orderdate"/>'>
 			<input type="hidden" id="amount" name=amount value='<s:property value="amount"/>'>
 			<input type="hidden" id="vendorname" name=vendorname value='<s:property value="vendorname"/>'>
 			<input type="hidden" id="costcode" name="costcode" value='<s:property value="costcode"/>'>
 			<input type="hidden" id="headdoc" name="headdoc" value='<s:property value="headdoc"/>'>
 			<input type="hidden" id="curntdate" name="curntdate" value='<s:property value="curntdate"/>'>
 		</tr>
 	</table>
 	</td>	
 </tr>
 </table>
	
</div>
</div>
</form>

<div id="vendorToWindow">
	<div></div>
</div>
<div id="poToWindow">
	<div></div>
</div>

</body>
</html>