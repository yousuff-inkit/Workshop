
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
 String contextPath=request.getContextPath();
 %>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<style>
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

</style>

<script type="text/javascript">

$(document).ready(function () {
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    
    $("#fromdate").jqxDateTimeInput({ width: '112px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '112px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	 var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	 var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	 $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	 
	 $('#clientwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search'  , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#clientwindow').jqxWindow('close');
	   
	   $('#estmwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Estimation Search'  , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#estmwindow').jqxWindow('close');
	   
	   $('#vendorwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Vendor Search'  , theme: 'energyblue', position: { x: 500, y: 120 }, keyboardCloseKey: 27});
	   $('#vendorwindow').jqxWindow('close');
	   
	   $('#productswindow').jqxWindow({ width: '51%', height: '54%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Product Search'  , theme: 'energyblue', position: { x: 500, y: 120 }, keyboardCloseKey: 27});
	   $('#productswindow').jqxWindow('close');
	   
	   
	   
	   $('#clientname').dblclick(function(){
	  	    
		   $('#clientwindow').jqxWindow('open');
		       		clientSearchContent('clientsearch.jsp', $('#clientwindow')); 
	       });
	 
	 $('#estimation').dblclick(function(){
	  	    
		   $('#estmwindow').jqxWindow('open');
		       		estmSearchContent('estsearch.jsp', $('#estwindow')); 
	       });
});


function getclinfo(event){
	 var x= event.keyCode;
	if(x==114){
 		$('#clientwindow').jqxWindow('open');
		clientSearchContent('clientsearch.jsp', $('#clientwindow'));    }
	else{}
}

function clientSearchContent(url) {
 	$.get(url).done(function (data) {
	$('#clientwindow').jqxWindow('open');
	$('#clientwindow').jqxWindow('setContent', data);
}); 
} 

function getestinfo(event){
	var x=event.keyCode;
	if(x==114){
		$('#estmwindow').jqxWindow('open');
		estmSearchContent('estsearch.jsp', $('#estmwindow'))
	}
}
function estmSearchContent(url){
		$.get(url).done(function(data){
			$('#estmwindow').jqxWindow('open');
		    $('#estmwindow').jqxWindow('setContent',data);
	    });	
}

function funreload(event)
{
	var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
    var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	if(fromdates>todates){
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		   return false;
	} 
	else{
	        var fromdate= $("#fromdate").val();
			var todate= $("#todate").val(); 
			var cldocno=$("#cldocno").val();
			var estno=$('#estno').val();
			
			$("#partscostinggriddiv").load("partsCostingGrid.jsp?from="+fromdate+"&to="+todate+"&cldocno="+cldocno+"&estno="+estno+'&check=1');

       }
    $("#partsGridId").jqxGrid('clear');
}

function funpartsload(num){
	$("#partsgriddiv").load("partsGrid.jsp?estno="+num+'&check=1');
}

function funproductsearch(row){
	$('#productswindow').jqxWindow('open');
	productSearchContent('productsearch.jsp?index='+row, $('#productswindow'));
}

function productSearchContent(url) {
 	$.get(url).done(function (data) {
	$('#productswindow').jqxWindow('open');
	$('#productswindow').jqxWindow('setContent', data);
});
}

function funvendorsearch(row){
		$('#vendorwindow').jqxWindow('open');
		vendorSearchContent('vendorSearch.jsp?index='+row, $('#vendorwindow'));
	}

function vendorSearchContent(url) {
	 	$.get(url).done(function (data) {
		$('#vendorwindow').jqxWindow('open');
		$('#vendorwindow').jqxWindow('setContent', data);
	});
}

function attach(){
  var fcode="EST";
  var fname="Estimation";
  if(document.getElementById("hidestm").value=="") {
	  $.messager.alert('Message','Choose a document','warning');
  }
  else{
  var  myWindow= window.open("<%=contextPath%>/com/common/Attachmaster.jsp?formCode="+fcode+"&docno="+document.getElementById("hidestm").value+"&brchid=1&frmname="+fname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
      myWindow.focus();
  }
 }

function funcleardata()
  {
	  
  	document.getElementById("clientname").value="";
    	document.getElementById("estimation").value="";
   	
  	
  	 if (document.getElementById("clientname").value == "") {
  			
  		 
  	        $('#clientname').attr('placeholder', 'Press F3 TO Search'); 
  	    }
  	if (document.getElementById("estimation").value == "") {
			
  		 
	        $('#estimation').attr('placeholder', 'Press F3 TO Search'); 
	    }
  	else{}
  		  		
  	}
  	
  	function funUpdate(){
  		var rows = $('#partsGridId').jqxGrid('getrows');
  	    var result = "";
  	    if(rows.length==0){
  	    	$.messager.alert('Message','Choose a document','warning');
  	    }
  	    else{
		  $.messager.confirm('Confirm', 'Do you want to Save Changes?', function(r){
		     if (r){ 
			  	   var gridarray=new Array();
			  	    for(var i = 0; i < rows.length; i++)
			  	    {
			  	        var row = rows[i];
			  	        gridarray[i]=(rows[i].rowno+"::"+rows[i].psrno+"::"+rows[i].stdcost+"::"+rows[i].vndno);
			  	      //  result += row.firstname + " " + row.lastname + " " + row.productname + " " + row.date + " " + row.quantity + " " + row.price + "\n";        
			  	    }
			  	    funSave(gridarray);
			  	    
		  	}
		  });
  	    }
  	}
  	
  	function funSave(gridarray){
  		
  	var estno=document.getElementById("hidestm").value; 
  	  var x=new XMLHttpRequest();
  	  x.onreadystatechange=function(){
  	  if (x.readyState==4 && x.status==200){
  	         
  	    var items=x.responseText.trim();
   	    
  	    if(parseInt(items)=="0")  
  	    { 
  	    
  	    $.messager.alert('Message', '  Record Successfully Updated ','info');
  	    funreload();
  	    }
  	    else
  	    {
  	    $.messager.alert('Message', '  Not Updated  ','warning');
  	    }
  	    }
  	  }
  	    x.open("GET","partsUpdate.jsp?gridarray="+gridarray+"&estno="+estno,true);    
  	 x.send();
  	}
  	
  	
  	function funCreate(){
  		var selectedrows=$("#partsGridId").jqxGrid('selectedrowindexes');
  	  		
  	  		
  	  		var estno=document.getElementById("hidestm").value;
  	  		var date=document.getElementById("fromdate").value;
  	  		var jobno=$("#partsGridId").jqxGrid('getcellvalue', selectedrows[0], "voc_no");
  	  		var vndno=$("#partsGridId").jqxGrid('getcellvalue', 0, "vndno");
  	  		var vendorprice=0;
  	  		var i=0;
  	  		
  	  		
  	 
  	  		var rows = $("#partsGridId").jqxGrid('getrows');
  	  		var purchaseorderarray=new Array();
  	  		 var rownorarray=new Array();
  	  		
  			if(rows.length>0 && (rows[0].rowno=="undefined" || rows[0].rowno==null || rows[0].rowno=="")){
  				return false;
  			}
  				       
  		    
  			if(selectedrows.length==0){
  				$.messager.alert('Warning','Select a document');
  				return false;
  			}
  			   $.messager.confirm('Confirm', 'Do you want to Save Changes?', function(r){
  		 			if (r){
  		 				
  		 				var i=0;
  		            //    $('#partsGridId').val(selectedrows.length);
  		  	
  		              var listss = new Array();
  		            var selectedrows=$("#partsGridId").jqxGrid('selectedrowindexes');
  		            selectedrows = selectedrows.sort(function(a,b){return a - b});
  		            
  		         		var nettotal=0;
  		               for(var i=0 ; i < selectedrows.length ; i++){
  		            	 var total= parseFloat($("#partsGridId").jqxGrid('getcellvalue',selectedrows[i],'qty')) *
  		  		        parseFloat($("#partsGridId").jqxGrid('getcellvalue',selectedrows[i],'stdcost'));
  		            	 var taxamt=total*0.05;
  		            	 var nettaxamt=total+taxamt;
  		  		    purchaseorderarray.push($("#partsGridId").jqxGrid('getcellvalue',selectedrows[i],'psrno')+"::"
  		  		    	+$("#partsGridId").jqxGrid('getcellvalue',selectedrows[i],'prdid')+"::"
  		                 +$("#partsGridId").jqxGrid('getcellvalue',selectedrows[i],'munit')+"::"
  		                 +$("#partsGridId").jqxGrid('getcellvalue',selectedrows[i],'qty')+"::"
  		                 +$("#partsGridId").jqxGrid('getcellvalue',selectedrows[i],'stdcost')+"::"
  		                 +total+"::"+0+"::"+total+"::"+0+"::"+0+"::"
  		                 +$("#partsGridId").jqxGrid('getcellvalue',selectedrows[i],'mspecno')+"::"+0+"::"+0+"::"+0+"::"+5+"::"+taxamt+"::"+nettaxamt+"::"+1+"::");
  		           
  		  		    rownorarray.push($("#partsGridId").jqxGrid('getcellvalue',selectedrows[i],'rowno'));
  		           nettotal+=total;
  		         /*      purchaseorderarray.push($("#partsGridId").jqxGrid('getcellvalue',selectedrows[i],'psrno')+"::"+prodoc+"::"
  		            		  +unitdocno+"::"+purorderqty+"::"+unitprice+"::"
								+total+"::"+discount+"::"+nettotal+"::"+saveqty+"::"+checktype+"::"
								+specid+"::"+discper+"::"+unitprice1+"::"+disper1+"::"+taxper+"::"
								+taxperamt+"::"+taxamount+"::"+taxdocno+"::");
					 */
  		               }
  		             funPurchaseSave(estno,date,jobno,vndno,nettotal,purchaseorderarray,rownorarray,nettotal);
  		 			}});
  	  		
  	  		
  	}
  	
  	function funCreateNI(){
  		var selectedrows=$("#partsGridId").jqxGrid('selectedrowindexes');
  	  	var estno=document.getElementById("hidestm").value;
  	  	var date=document.getElementById("fromdate").value;
  	  	var jobno=$("#partsGridId").jqxGrid('getcellvalue', selectedrows[0], "voc_no");
  	  	var vndno=$("#partsGridId").jqxGrid('getcellvalue', 0, "vndno");
  	  	var vendorprice=0;
  	  	var i=0;
  	  	var rows = $("#partsGridId").jqxGrid('getrows');
  	  	var purchaseorderarray=new Array();
  	  	var rownorarray=new Array();
  	  		
  		if(rows.length>0 && (rows[0].rowno=="undefined" || rows[0].rowno==null || rows[0].rowno=="")){
  			return false;
  		}
		if(selectedrows.length==0){
			$.messager.alert('Warning','Select a document');
			return false;
		}
  		$.messager.confirm('Confirm', 'Do you want to Save Changes?', function(r){
  			if(r){
  		 		var i=0;
  		        var listss = new Array();
  		        var selectedrows=$("#partsGridId").jqxGrid('selectedrowindexes');
  		        selectedrows = selectedrows.sort(function(a,b){return a - b});
  		        var nettotal=0;
  		        for(var i=0,j=1; i < selectedrows.length ; i++,j++){
  		        	var total= parseFloat($("#partsGridId").jqxGrid('getcellvalue',selectedrows[i],'qty')) * parseFloat($("#partsGridId").jqxGrid('getcellvalue',selectedrows[i],'stdcost'));
  		            var taxamt=total*0.05;
  		            var nettaxamt=total+taxamt;
  		          /* rows[i].srno+"::"+rows[i].qty+" :: "+rows[i].description+" :: "
  				   +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "+rows[i].nuprice+" :: "+rows[i].taxper+"::"+rows[i].taxperamt+"::"+rows[i].taxamount+"::" */
  		  		    /* purchaseorderarray.push($("#partsGridId").jqxGrid('getcellvalue',selectedrows[i],'psrno')+"::"
  		  		    	+$("#partsGridId").jqxGrid('getcellvalue',selectedrows[i],'prdid')+"::"
  		                 +$("#partsGridId").jqxGrid('getcellvalue',selectedrows[i],'munit')+"::"
  		                 +$("#partsGridId").jqxGrid('getcellvalue',selectedrows[i],'qty')+"::"
  		                 +$("#partsGridId").jqxGrid('getcellvalue',selectedrows[i],'stdcost')+"::"
  		                 +total+"::"+0+"::"+total+"::"+0+"::"+0+"::"
  		                 +$("#partsGridId").jqxGrid('getcellvalue',selectedrows[i],'mspecno')+"::"+0+"::"+0+"::"+0+"::"+5+"::"+taxamt+"::"+nettaxamt+"::"+1+"::");
  		            */
  		          /* srno,qty,desc1,unitprice,total,discount,nettotal,nuprice,taxper,taxamount,nettaxamount */
  		          purchaseorderarray.push(j+"::"+$("#partsGridId").jqxGrid('getcellvalue',selectedrows[i],'qty')+" :: "+
  		        	$("#partsGridId").jqxGrid('getcellvalue',selectedrows[i],'description')+" :: "+
  		        	$("#partsGridId").jqxGrid('getcellvalue',selectedrows[i],'stdcost')+" :: "+total+" :: "+"0.00 :: "+total+" :: 0.00 :: 0.00 :: 0.00 :: "+total);
  		  		   rownorarray.push($("#partsGridId").jqxGrid('getcellvalue',selectedrows[i],'rowno'));
  		           nettotal+=total;
	  		   }
  		       funPurchaseSaveNI(estno,date,jobno,vndno,nettotal,purchaseorderarray,rownorarray,nettotal);
  		 	}
  		});
  	  		
  	}
  	
  	function funPurchaseSaveNI(estno,date,jobno,vndno,vendorprice,purchaseorderarray,rownorarray,nettotal){
  		var x=new XMLHttpRequest();
    	  x.onreadystatechange=function(){
    	  if (x.readyState==4 && x.status==200){
    	         
    	    var items=x.responseText.trim();
     	    
    	    if(parseInt(items)>"0")  
    	    { 
    	    
    	    $.messager.alert('Message', ' NI Order no '+parseInt(items)+' Successfully Created ','info');
    	    
    	    }
    	    else
    	    {
    	    $.messager.alert('Message', '  Not Created  ','warning');
    	    }
    	    }
    	  }
    	  
    	    x.open("GET","purchaseOrderCreateNI.jsp?date="+date+"&jobno="+jobno+"&vndno="+vndno+"&vendorprice="+vendorprice+"&purchaseorderarray="+purchaseorderarray+"&rownorarray="+rownorarray+"&nettotal="+nettotal,true);    
    	 x.send();
  	}
  	
  	function funPurchaseSave(estno,date,jobno,vndno,vendorprice,purchaseorderarray,rownorarray,nettotal){
  		var x=new XMLHttpRequest();
    	  x.onreadystatechange=function(){
    	  if (x.readyState==4 && x.status==200){
    	         
    	    var items=x.responseText.trim();
     	    
    	    if(parseInt(items)>"0")  
    	    { 
    	    
    	    $.messager.alert('Message', '  Order no '+parseInt(items)+' Successfully Created ','info');
    	    
    	    }
    	    else
    	    {
    	    $.messager.alert('Message', '  Not Created  ','warning');
    	    }
    	    }
    	  }
    	  
    	    x.open("GET","purchaseOrderCreate.jsp?date="+date+"&jobno="+jobno+"&vndno="+vndno+"&vendorprice="+vendorprice+"&purchaseorderarray="+purchaseorderarray+"&rownorarray="+rownorarray+"&nettotal="+nettotal,true);    
    	 x.send();
  	}
  	
  	function funcPrint(){
  		
  		var jobno = document.getElementById("hidjobno").value;

  		 if(jobno=="")
  			 {
  			   $.messager.alert('Message','Select a document  ','warning'); 
  			   return false;
  			 }
  		 else
  			 {
  	    var url=document.URL;
  	    var reurl=url.split("partsCosting.jsp");
  	    //alert(reurl[0]+"printPartsCosting?jobno="+document.getElementById("hidjobno").value);
  	  
  	    var win= window.open(reurl[0]+"printPartsCosting?jobno="+document.getElementById("hidjobno").value,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
  	    win.focus();
  		}
  	}
	function funExportBtn(){
		JSONToCSVConvertor(pcexceldata, 'PARTS COSTING', true);
	}
	
	function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {
		
	    var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
	    
	   // alert("arrData");
	    var CSV = '';    
	    //Set Report title in first row or line
	    
	    CSV += ReportTitle + '\r\n\n';

	    //This condition will generate the Label/Header
	    if (ShowLabel) {
	        var row = "";
	        
	        //This loop will extract the label from 1st index of on array
	        for (var index in arrData[0]) {
	            
	            //Now convert each value to string and comma-seprated
	            row += index + ',';
	        }

	        row = row.slice(0, -1);
	        
	        //append Label row with line break
	        CSV += row + '\r\n';
	    }
	    
	    //1st loop is to extract each row
	    for (var i = 0; i < arrData.length; i++) {
	        var row = "";
	        
	        //2nd loop will extract each column and convert it in string comma-seprated
	        for (var index in arrData[i]) {
	            row += '"' + arrData[i][index] + '",';
	        }

	        row.slice(0, row.length - 1);
	        
	        //add a line break after each row
	        CSV += row + '\r\n';
	    }

	    if (CSV == '') {        
	        alert("Invalid data");
	        return;
	    }   
	    
	    //Generate a file name
	    var fileName = "";
	    //this will remove the blank-spaces from the title and replace it with an underscore
	    fileName += ReportTitle.replace(/ /g,"_");   
	    
	    //Initialize file format you want csv or xls
	    var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
	    
	    // Now the little tricky part.
	    // you can use either>> window.open(uri);
	    // but this will not work in some browsers
	    // or you will not get the correct file extension    
	    
	    //this trick will generate a temp <a /> tag
	    var link = document.createElement("a");    
	    link.href = uri;
	    
	    //set the visibility hidden so it will not effect on your web-layout
	    link.style = "visibility:hidden";
	    link.download = fileName + ".csv";
	    
	    //this part will append the anchor tag and remove it after automatic click
	    document.body.appendChild(link);
	    link.click();
	    document.body.removeChild(link);
	}
	 
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table  width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>

	<tr width="100%">
	  <td align="right" width="40%" ><label class="branch">From Date</label></td>
	  <td align="left" width="60%"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
        </td></tr>
      <tr width="100%">
	  <td align="right" width="45%" ><label class="branch">To Date</label></td>
	  <td align="left" width="55%"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
        </td></tr>
      
      
                    <tr><td colspan="2">&nbsp;</td></tr>
   <tr><td align="right"><label class="branch">Client</label></td><td align="left"><input type="text" name="clientname" id="clientname" placeholder="Press F3 To Search" readonly onKeyDown="getclinfo(event);" onclick="this.placeholder='' "  style="height:20px;width:90%;" value='<s:property value="clientname"/>'></td></tr>                 
		<tr>
		  <td align="right"><label class="branch">Estimation</label></td>
		  <td><input type="text" name="estimation" id="estimation" placeholder="Press F3 To Search" readonly onKeyDown="getestinfo(event);" onclick="this.placeholder='' "  style="height:20px;width:90%;" value='<s:property value="estimation"/>'></td>
		</tr>
	
	
	<tr><td colspan="2" align="center">
	<input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funcleardata()">
  </td></tr>
	
	 <tr>
	   <td colspan="2" align="center">
	   <input type="button" class="myButton" name="btnAttach" id="btnAttach" value="Attach"  onclick="attach();">
	 <input type="button" class="myButton" name="btnUpdate" id="btnUpdate"  value="Update" onclick="funUpdate();">
	 </td>
  </tr>
  <tr>
	   <td colspan="2" align="center">
	   <input type="button" class="myButton" name="btnCreate" id="btnCreate" value="Purchase Order Create" style="" onclick="funCreate();">
	 </td>
  </tr>
  <tr>
  	<td colspan="2" align="center">
	   <input type="button" class="myButton" name="btnCreateNI" id="btnCreateNI" value="NI Purchase Order Create" style="" onclick="funCreateNI();">
	 </td>
  </tr>
  <tr>
	   <td colspan="2" align="center">
	   <input type="button" class="myButton" name="btnPrint" id="btnPrint"  value="Print" onclick="funcPrint();">
	 </td>
  </tr>

  
  

	</table>
	
	<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
	
	</fieldset>
	<input type="hidden" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>' >
	<input type="hidden" name="estno" id="estno" value='<s:property value="estno"/>' >
	<input type="hidden" name="hidestm" id="hidestm" value='<s:property value="hidestm"/>' >
	<input type="hidden" name="hidjobno" id="hidjobno" value='<s:property value="hidjobno"/>'>

</td>
<td width="80%"><div  >
	<table width="100%" id="grid1">
		<tr><td >
		<div  id="partscostinggriddiv"><jsp:include page="partsCostingGrid.jsp"></jsp:include></div>  
	    </td></tr>
	    <tr><td >
			<div  id="partsgriddiv"><jsp:include page="partsGrid.jsp"></jsp:include></div>  
	    </td></tr>
	    
	</table>
</div></td>
</tr>
</table>

</div>

<div id="clientwindow">
   <div></div>
</div>

<div id="estmwindow">
   <div></div></div>
   
<div id="productswindow">
   <div></div>
</div>

<div id="vendorwindow">
   <div></div>
</div>
</div>

</body>
</html>
