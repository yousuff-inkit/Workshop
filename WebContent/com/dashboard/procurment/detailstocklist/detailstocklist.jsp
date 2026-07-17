    
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
<%String psrnoss=request.getParameter("temppsrno")==null || request.getParameter("temppsrno")==""?"0":request.getParameter("temppsrno");
String pna=request.getParameter("pna")==null || request.getParameter("pna")==""?"0":request.getParameter("pna");
String mode=request.getParameter("mod")==null || request.getParameter("mod")==""?"0":request.getParameter("mod");

%>

$(document).ready(function () {
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	   $("body").prepend('<div id="overlay2" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait2' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
		
	  var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-6));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate)); 
	     
	     var psrnos='<%=psrnoss%>';
	     var pnas='<%=pna%>';
	     var mod1='<%=mode%>';
	     if(mod1=="v")
			{
	    	 document.getElementById("psrno").value=psrnos;
	    	 document.getElementById("jqxInput").value=pnas;
	    	 var aa="start";
	    	  $("#part").load("part.jsp?psrnos="+psrnos+"&load="+aa);
	    	 funreload(event);
	    	 
	    	 
	        
	             
			}
	     
	  
	     
	     $("#main").show();
	     $("#sub").hide();
});


function hidebranch()
{
	
	 

	  $("#branchdiv").hide();
	  $("#branchlabel").hide();
	  
	  
 	  document.getElementById("lbldetailname").innerText="Detail Stock Enquiry";  
		document.getElementById("lbldetail").innerText="Supply Chain";
	 
}
 
function funreload(event)
{

	  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
	  // out date
	 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	 	 
	   if(fromdates>todates){
		   
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		 
	   return false;
	  } 
	   else
		   {
	  var barchval = document.getElementById("cmbbranch").value;
      var fromdate= $("#fromdate").val();
	  var todate= $("#todate").val();
	  var psrno=$("#psrno").val();
	  var aa="yes";
	  var type="2";
	  $("#overlay, #PleaseWait").show();
	  $("#listdiv1").load("orderlistGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&psrno="+psrno+"&load="+aa);
	  $("#listdiv2").load("purchaselistGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&psrno="+psrno+"&load="+aa);
	  $("#listdiv3").load("saleslistGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&psrno="+psrno+"&load="+aa);
	  $("#listdiv4").load("savelistGrid.jsp?psrno="+psrno+"&load="+aa);
	  $("#listdiv5").load("batchlistGrid.jsp?psrno="+psrno+"&load="+aa);
	 
 
		   }
	 	 
	}
	
	function chgitem(val)
	{
		if(val=="Stock Movement")
			{
			document.getElementById("cs").value="List Details";
			
			 $("#main").hide();
		     $("#sub").show();
		    
			  var barchval = document.getElementById("cmbbranch").value;
		      var fromdate= $("#fromdate").val();
			  var todate= $("#todate").val();
			  var psrno=$("#psrno").val();
			  var aa="yes";
			  var type="2";
			 
	 
		 	  $("#overlay2, #PleaseWait2").show();
			 
			  $("#listdiv7").load("stockLedgerGridDetail.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&psrno="+psrno+"&load="+aa+"&type="+type);
				    
			}
		else
			{
			
			document.getElementById("cs").value="Stock Movement";
			

			  $("#main").show();
			     $("#sub").hide();
			}
		
		 
	}
	
</script>
</head>
<body onload="getBranch();hidebranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 
	  <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                    
                    
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr> 

 
 
 <tr><td colspan="2">&nbsp;</td></tr>
 
     <tr><td align="right"><label class="branch">Product</label></td>
 <td align="left"><div id="part"><jsp:include page="part.jsp"></jsp:include></div> </td></tr>
	<input type="hidden" id="psrno" name="psrno" value='<s:property value="psrno"/>' /> 
	 
 
  <tr><td colspan="2">&nbsp;</td></tr> 
 
<!-- 	  <tr><td colspan="2"> <tr><td colspan="2" align="center"><input type="button" class="myButton" name="cs" id="cs"  value="Current Stock"  ></td></tr>
	   <tr><td colspan="2"> <tr><td colspan="2" align="center"><input type="button" class="myButton" name="cs" id="cs"  value="Pending Purchase Order"  ></td></tr>
	    <tr><td colspan="2"> <tr><td colspan="2" align="center"><input type="button" class="myButton" name="cs" id="cs"  value="Sales Details"  ></td></tr>
	     <tr><td colspan="2"> <tr><td colspan="2" align="center"><input type="button" class="myButton" name="cs" id="cs"  value="Purchase Details"  ></td></tr> -->
	      <tr><td colspan="2"> <tr><td colspan="2" align="center"><input type="button" class="myButton" name="cs" id="cs"  value="Stock Movement"  onclick="chgitem(this.value)"></td></tr>
	    <tr><td colspan="2">&nbsp;</td></tr>   
<tr><td align="right"><label class="branch">Stock</label></td> <td><input type="text" id="stock" name="stock" style="width:100%;height:20px;text-align: right;" readonly="readonly" value='<s:property value="stock"/>' /></td></tr> 
<tr><td align="right"><label class="branch">Reserve</label></td> <td><input type="text" id="rsv" name="rsv" style="width:100%;height:20px;text-align: right;" readonly="readonly" value='<s:property value="rsv"/>' /></td></tr> 
	
	<tr><td align="right"><label class="branch">Balance</label></td> <td><input type="text" id="bal" name="bal" style="width:100%;height:20px;text-align: right;" readonly="readonly" value='<s:property value="bal"/>' /></td></tr> 
	
	<tr><td align="right"><label class="branch">Selling Price</label></td> <td><input type="text" id="sellprice" name="sellprice" style="width:100%;height:20px;text-align: right;" readonly="readonly" value='<s:property value="sellprice"/>' /></td></tr> 
	
	<tr><td align="right"><label class="branch">MRP</label></td> <td><input type="text" id="mrp" name="mrp" style="width:100%;height:20px;text-align: right;" readonly="readonly" value='<s:property value="mrp"/>' /></td></tr> 
		      

	
		
			 <tr><td colspan="2">&nbsp;</td></tr> 
		 	 <tr><td colspan="2">&nbsp;	<label id="prdname" name="prdname" style="color:blue;font-weight:bold;font-size: 10px;"><s:property value="prdname"/></td></tr>
		 		 <tr><td colspan="2">	&nbsp;<label id="brname" name="brname" style="color:blue;font-weight:bold;font-size: 10px;"><s:property value="brname"/></td></tr>
		 	 	 <tr><td colspan="2">&nbsp;</td></tr>
		 	 	 	  <tr><td colspan="2">&nbsp;</td></tr>
		 	 	 	 	 	 	 	 	 	       
	</table>
	</fieldset>
	
	 <input type="hidden" id="statusselect" name="statusselect" value='<s:property value="statusselect"/>'>
   <input type="hidden" id="acno" name="acno" value='<s:property value="acno"/>'>
   
 
   
</td>
<td width="80%">


<div id="main" >
  <table width="100%"  >
		<tr>
			 <td colspan="2"><label style="  font-size: 12PX;font-family: sans-serif; "><u><b>Pending Purchase Order</b></u></label><br><div id="listdiv1"><jsp:include page="orderlistGrid.jsp"></jsp:include></div></td>
			 <td width="1%">&nbsp;</td>  
			 <td  colspan="1" rowspan="3"  width="49.5%"><label style="  font-size: 12PX;font-family: sans-serif; "><u><b>Sales Details</b></u></label><br><div id="listdiv3"><jsp:include page="saleslistGrid.jsp"></jsp:include></div></td>
		</tr>
		<tr>
			 <td  colspan="2" rowspan="2" width="49.5%"><label style="  font-size: 12PX;font-family: sans-serif; "><u><b>Purchase Details</b></u></label><br><div id="listdiv2"><jsp:include page="purchaselistGrid.jsp"></jsp:include></div></td>
			<td width="1%">&nbsp;</td>  
			  
		</tr>
		 
		<%-- <tr>
			 <td  colspan="1" align="left"><label style="font-size: 12PX;font-family: sans-serif; "><u><b>Sales Slab</b></u></label><br><div id="listdiv4"><jsp:include page="savelistGrid.jsp"></jsp:include></div></td>
			 
			  <td  colspan="1" align="left"><label style="font-size: 12PX;font-family: sans-serif; "><u><b>Batch Wise Stock</b></u></label><br><div id="listdiv5"><jsp:include page="batchlistGrid.jsp"></jsp:include></div></td>
		 <td width="1%">&nbsp;</td>  
		</tr> --%>
	</table> 
	
	</div>
	
	<div id="sub">
	
	
	  <table width="100%" >
		<tr>
			 <td  ><div id="listdiv7"><jsp:include page="stockLedgerGridDetail.jsp"></jsp:include></div></td>
			 
		</tr>
	 
	</table> 
	
	
	
	</div>
	
 </td>
	
</tr>
</table>

</div>
 
<div id="productDetailsWindow">
	<div></div><div></div>
</div>
</div>
</body>
</html>