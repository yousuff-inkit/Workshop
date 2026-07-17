 
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 

<style type="text/css">
 
.myButtons {
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
}

</style>

<script type="text/javascript">

$(document).ready(function () {
	

	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

	     $('#accountDetailsWindow').jqxWindow({width: '51%', height: '60%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
	       $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
		   $('#accountSearchwindow').jqxWindow('close');
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 /*$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	    
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	 $('#todate').on('change', function (event) {
			
		   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  }   
	 }); */
	 
		$('#fromdate').jqxDateTimeInput({disabled: true});
     $('#acno').attr('disabled', true);
     $('#accname').attr('disabled', true);
     $('#txtpaydetails').attr('disabled', true);
     $('#txtdeldetails').attr('disabled', true);
     $('#create').attr('disabled', true);
	 
	   $('#account').dblclick(function(){
	    
	    	
	    		
		  	    $('#accountSearchwindow').jqxWindow('open');
		  	
		  	  accountSearchContent('accountsDetailsSearch.jsp?');
	    		 
	  });   
	   $('#acno').dblclick(function(){
		    
	    	
   		
	  	    $('#accountDetailsWindow').jqxWindow('open');
	  	
	  	  accountSearchContent('accountsDetailsSearch.jsp?');
   		 
 });   
	  
});

function funExportBtn(){
	   //$("#orderlist").jqxGrid('exportdata', 'xls', 'Puchase Order List');
	   
		JSONToCSVCon(datass, 'Puchase Order List', true);
	   
	   
	 }

function getaccountdetails(event){
	 var x= event.keyCode;
  	
 
		
	 if(x==114){
	  $('#accountSearchwindow').jqxWindow('open');
	
	 accountSearchContent('accountsDetailsSearch.jsp?');    }
	 else{
		 }
		 
	 }  
	  function accountSearchContent(url) {
 
         $.get(url).done(function (data) {
 
       $('#accountDetailsWindow').jqxWindow('setContent', data);

	}); 
   	}
function funreload(event)
{

	 	 
	   
	 var barchval = document.getElementById("cmbbranch").value;
	 if((barchval=="a") || (barchval=="")){
			$.messager.alert('Warning','Please Select Branch');
			return false;
	 }
     var fromdate= $("#fromdate").val();
	var chk=1;
	 
	   $("#overlay, #PleaseWait").show();
	  $("#listdiv").load("purchaseordercreateGrid.jsp?barchval="+barchval+"&chk="+chk+"&fromdate="+fromdate);
	
		   
	}

function  funcleardata()
{
	document.getElementById("acno").value="";
	document.getElementById("accdocno").value="";
	document.getElementById("accname").value="";
	document.getElementById("txtpaydetails").value="";
	document.getElementById("txtdeldetails").value="";
 
	
 
	
	
	
	
	 if (document.getElementById("acno").value == "") {
			
		 
	        $('#acno').attr('placeholder', 'Press F3 TO Search'); 
	    }
	  
		
	}
	
function  getacc(event){
	 var x= event.keyCode;
	 if(x==114){
	
	  $('#accountDetailsWindow').jqxWindow('open');
	
	 commenSearchContent('accountsDetailsSearch.jsp?');
	 }
	 }   
function commenSearchContent(url) {
	 
		 $.get(url).done(function (data) {
			 
			 $('#accountDetailsWindow').jqxWindow('open');
		$('#accountDetailsWindow').jqxWindow('setContent', data);

	}); 
	} 	
	
	function funcreatepo(){
		 var barchval = document.getElementById("cmbbranch").value;
	    
		var chk=1;
		var podate=$("#fromdate").val();
		var acno=$("#acno").val();
		var pay=$("#txtpaydetails").val();
		var del=$("#txtdeldetails").val();
		var prdtotal=0,nettotaldown=0,ordervalue=0,nettax=0;
		  var temp1="";
		var rows=$('#orderlistgrid').jqxGrid('getrows');
		var selectedrows=$('#orderlistgrid').jqxGrid('getselectedrowindexes');
		if(selectedrows.length==0){
			$.messager.alert('Warning','Please select any document');
			return false;
		}
		$.messager.confirm('Confirm', 'Do you want to create purhchase order?', function(r){
			if (r){
				$("#overlay, #PleaseWait").show();
				var invoicearray=new Array();
				for(var i=0;i<selectedrows.length;i++){
					var chk=selectedrows[i];
					temp1=temp1+rows[chk].doc_no+",";
					var uprice=rows[chk].amount;
					//alert("uprice=="+uprice);
					if((typeof(uprice)==="undefined") || (uprice=="")){
						$("#overlay, #PleaseWait").hide();
						$.messager.alert('Warning','Enter Unit Price for Selected Documents');
						return false;
						break;
					}
					//alert(rowno+"::"+insurstatus+"::"+billtoacno+"::"+claimno+"::"+description+"::"+amount+"::"+discount+"::"+net+"::"+vat+"::"+total+"::"+excess+"::"+roundoff+"::"+netbill);
					/*  newTextBox.val(rows[i].psrno+"::"+rows[i].prodoc+" :: "+rows[i].unitdocno+" :: "+rows[i].qty+" :: "
						   +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "+rows[i].saveqty
						   +" :: "+rows[i].checktype+" :: "+rows[i].specid+" :: "+rows[i].discper+" :: "+rows[i].unitprice1+"::"+rows[i].disper1
						   +"::"+rows[i].taxper+"::"+rows[i].taxperamt+"::"+rows[i].taxamount+"::"+rows[i].taxdocno+"::"+"0000"+"::");  */
					invoicearray.push(rows[chk].psrno+" :: "+rows[chk].psrno+" :: "+rows[chk].unitdoc+" :: "+rows[chk].qty+" :: "
							   +rows[chk].amount+" :: "+rows[chk].total+" :: "+"0000"+" :: "+rows[chk].nettotal+" :: "+rows[chk].qty
							   +" :: "+"0000"+" :: "+rows[chk].specid+" :: "+"0000"+" :: "+"0000"+" :: "+"0000"
							   +" :: "+rows[chk].taxper+" :: "+rows[chk].taxamount+" :: "+rows[chk].nettaxamount+" :: "+rows[chk].taxdocno+" :: "+"0000"+" :: ");
					prdtotal=parseFloat(prdtotal)+parseFloat(rows[chk].total);
					nettotaldown=parseFloat(nettotaldown)+parseFloat(rows[chk].nettotal);
					ordervalue=parseFloat(ordervalue)+parseFloat(rows[chk].nettaxamount);
					nettax=parseFloat(nettax)+parseFloat(rows[chk].taxamount);
				}
				temp1=temp1.replace(/,\s*$/, "");
				//alert("temp1=="+temp1);
				var x = new XMLHttpRequest();
				x.onreadystatechange = function() {
					if (x.readyState == 4 && x.status == 200) {
						var items = x.responseText.trim();
						if(parseInt(items.split("::")[0])>0){
							$("#overlay, #PleaseWait").hide();
							$.messager.alert('Message','Purchase Order '+items.split("::")[1]+' Created');
							 $("#listdiv").load("purchaseordercreateGrid.jsp?barchval="+barchval+"&chk="+chk+"&fromdate="+podate);
						}
						else{
							$("#overlay, #PleaseWait").hide();
							$.messager.alert('Message',' Not Created');
							return false;
						}
					} else {
					}
				}
				x.open("GET", "createPo.jsp?podate="+podate+"&poarray="+invoicearray+"&vndacno="+acno+"&paydetails="+pay+"&deldetails="+del+"&rrefno="+temp1+"&prdtotal="+prdtotal+"&nettotaldown="+nettotaldown+"&ordervalue="+ordervalue+"&nettax="+nettax, true);
				x.send();
			}
		});
	}
	
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
	 <tr><td colspan="2">&nbsp;</td></tr>
		<tr><td colspan="2"><fieldset><legend>Purchase Order</legend>
		<table width="100%"  >
		 <tr><td  align="right" ><label class="branch">PODate</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                    
                    
                    
   
	 	
	 <tr><td align="right"><label class="branch">Vendor</label></td>
	<td align="left"><input type="text" id="acno" name="acno" style="width:88%;height:20px;" placeholder="Press F3 To search" readonly="readonly" value='<s:property value="acno"/>' tabindex="-1" onkeydown="getacc(event);" /></td></tr> 
<tr><td>&nbsp;</td> 
	<td><input type="text" id="accname" name="accname" style="width:100%;height:20px;" readonly="readonly" value='<s:property value="accname"/>' tabindex="-1"/>
     <input type="hidden" id="accdocno" name="accdocno" style="width:100%;height:20px;" readonly="readonly" value='<s:property value="accdocno"/>' tabindex="-1"/>
     </td></tr>
 <tr><td align="right"><label class="branch">Pay Details</label></td>
	 <td align="left"><input type="text" id="txtpaydetails" name="txtpaydetails" style="width:100%;height:20px;" value='<s:property value="txtpaydetails"/>'/></td></tr>
 
 <tr><td align="right"><label class="branch">Del Details</label></td>
	 <td align="left"><input type="text" id="txtdeldetails" name="txtdeldetails" style="width:100%;height:20px;" value='<s:property value="txtdeldetails"/>'/></td></tr>
		</table>
		</fieldset></td></tr>
	
	 
 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2" align="center"><input type="button" class="myButton" name="create" id="create"  value="Create" onclick="funcreatepo()"></td></tr>
 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funcleardata()"></td></tr>
	<tr>
	<td colspan="2"><div id='paychaaaaa' style="width: 100% ; align:right; height: 150px;"></div></td>
	</tr>	
	</table>
	</fieldset>
   <input type="hidden" id="acno" name="acno" value='<s:property value="acno"/>'>
   <input type="hidden" id="vndtax" name="vndtax" value='<s:property value="vndtax"/>'>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="listdiv"><jsp:include page="purchaseordercreateGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>

</div>
<div id="accountSearchwindow">
   <div ></div>
</div>
<div id="accountDetailsWindow">
	<div></div> 
</div> 
</div>
</body>
</html>