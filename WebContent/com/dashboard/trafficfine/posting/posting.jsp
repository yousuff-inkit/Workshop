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
</style>

<script type="text/javascript">

	$(document).ready(function () {
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '60%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 $('#multiSearchWindow').jqxWindow({width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Ticket  Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#multiSearchWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		
	     var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	     $("#postingJV").jqxGrid({ disabled: true});
	     
		  $('#date').on('change', function (event) {
			  
		        var maindate = $('#date').jqxDateTimeInput('getDate');
		      
		        funDateInPeriod(maindate);
		    
		       });
	     
	     
	     $('#txttypeaccid').dblclick(function(){
	 		 if(document.getElementById("cmbtype").value!=""){
	  		  
			  $('#accountDetailsWindow').jqxWindow('open');
			 commenSearchContent('accountsDetailsSearch.jsp?cmbtype='+document.getElementById("cmbtype").value);
	 		 }
	 		 
	 		 else
	 			 {
	 			 
	 			 $.messager.alert('Message','Select Type.','warning');
				 return 0;
	 			 }
				        
		  }); 
	     
	     
	/*      
	     $('#EnquiryDate').on('change', function (event) {
	         var maindate = $('#EnquiryDate').jqxDateTimeInput('getDate');
	   	 	 if ($("#mode").val() == "A" || $('#mode').val()=="E" ) {   
	      funDateInPeriod(maindate);
	     	 } 
			   */
	     
	     $('#btnticketadd').click(function(){
		 	if(document.getElementById("chkticketno").checked==true){
				var branch=$('#cmbbranch').val();
				var fromdate=$('#fromdate').jqxDateTimeInput('val');
				var todate=$('#todate').jqxDateTimeInput('val');
				var type=$('#cmbtype').val();
				var acno=$('#txtaccid').val();
				$('#multiSearchWindow').jqxWindow('open');
				$('#multiSearchWindow').jqxWindow('focus');
			 	multiSearchContent('multiSearchMaster.jsp?branch='+branch+'&fromdate='+fromdate+'&todate='+todate+'&type='+type+'&acno='+acno);
			}
		 });
	});
	
	
	

	function commenSearchContent(url) {
	 	 //alert(url);
	 		 $.get(url).done(function (data) {
	 			 
	 			 $('#accountDetailsWindow').jqxWindow('open');
	 		$('#accountDetailsWindow').jqxWindow('setContent', data);
	 
	 	}); 
	 	} 	
  function multiSearchContent(url) {
	 		 $.get(url).done(function (data) {
	 			$('#multiSearchWindow').jqxWindow('setContent', data);
	 
	 	}); 
	 	} 	
 
   function funExportBtn(){
		 
		 
		 if(parseInt(window.parent.chkexportdata.value)=="1")
		  {
		  	JSONToCSVCon(data1, 'Traffic-Posting', true);
		  }
		 else
		  {
		                 
			 $("#jqxFleetGrid").jqxGrid('exportdata', 'xls', 'Traffic-Posting');
		  }
		 
	}
	function  getacc(event){
	 	 var x= event.keyCode;
	 	 if(x==114){
	 		 
	 		 if(document.getElementById("cmbtype").value!=""){
	 			 
	 			 
	 		 
	 		
	 	  $('#accountDetailsWindow').jqxWindow('open');
	 	
	 	 commenSearchContent('accountsDetailsSearch.jsp?cmbtype='+document.getElementById("cmbtype").value);
	 	   }
	 		 else
	 			 {
	 			 $.messager.alert('Message','Select Type.','warning');
				 return 0;
	 			 
	 			 }
	 		 
		          }
	 		   
	 	 else{
	 		 }
	 	 }    

	/* function funSearchdblclick(){
		  $('#txtaccid').dblclick(function(){
			  accountsSearchContent('accountsDetailsSearch.jsp');
			  });
	}
	
	function getAccType(event){
        var x= event.keyCode;
        if(x==114){
      	  accountsSearchContent('accountsDetailsSearch.jsp');
        }
        else{
         }
        }
	 */
	    


	
	
	function funreload(event){
		
		 var branchval = document.getElementById("cmbbranch").value;
		 
		 if(branchval=="a")
			 {
			 $.messager.alert('Message','Choose A Specific Branch.','warning');
			 return 0;
			 }
		 
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var paytype = $('#cmbtype').val();
		 var txttypeaccid = $('#txttypeaccid').val();
		 
			var maindate = $('#date').jqxDateTimeInput('getDate');
			   var validdate=funDateInPeriod(maindate);
			   if(validdate==0){
			   return 0; 
			   }
		 
		 if(paytype==''){
			 $.messager.alert('Message','Please Choose Type.','warning');
			 return 0;
		 }
		 
		 if(fromdate==''){
			 $.messager.alert('Message','Please Enter From Date.','warning');
			 return 0;
		 }
		 
		 if(todate==''){
			 $.messager.alert('Message','Please Enter To Date.','warning');
			 return 0;
		 }
		 
		 
		 if(txttypeaccid==''){
			 $.messager.alert('Message','Search Account.','warning');
			 return 0;
		 }
		  $("#postingJV").jqxGrid('clear');
		 $("#overlay, #PleaseWait").show();

		 
			var ticketno=$('#hidticketno').val();
	
			 $("#postingCashDiv").load("postingTrafficgrid.jsp?fromdate="+fromdate+'&todate='+todate+'&chk='+"GO&ticketno="+ticketno);
		
		 
		}
	
	function funCalculate(){
		
	
		 var branchval = document.getElementById("cmbbranch").value;
 		 var txttypeaccid = document.getElementById("txttypeaccid").value;
 		 
 		 if(branchval=="a")
 			 {
 			 $.messager.alert('Message','Choose A Specific Branch.','warning');
 			 return 0;
 			 }
 		var maindate = $('#date').jqxDateTimeInput('getDate');
		   var validdate=funDateInPeriod(maindate);
		   if(validdate==0){
		   return 0; 
		   }
 		if($('#cmbtype').val()==''){
			 $.messager.alert('Message','Please Choose Type.','warning');
			 return 0;
		 }
		
			 if(txttypeaccid==''){
				 $.messager.alert('Message','Search Account.','warning');
				 return 0;
			 }
			 
	  	  document.getElementById("calcu").value=1;
		
	/* 	if($('#txtdocno').val()==''){
			 $.messager.alert('Message','Please Choose Bank Account & Then Calculate.','warning');
			 return 0;
		 } */
	  	var rows = $('#postingJV').jqxGrid('getrows');
	     var rowlength= rows.length;
	  if(rowlength!=0){
	   $.messager.alert('Message','Already calculated.Submit Again. ','warning');
	   return 0;
	  } else{
	   $("#postingJV").jqxGrid('clear');
	  }
	/* 	$("#postingJV").jqxGrid('clear'); */
		
		var temp1="";
		


			
			$("#overlay, #PleaseWait").show();
			var selectedrows=$("#jqxFleetGrid").jqxGrid('selectedrowindexes');
			 
			if(selectedrows.length==0){
				$("#overlay, #PleaseWait").hide();
				$.messager.alert('Warning','Select Items to be Calculated.');
				return false;
			}
			
			
			var rows = $('#postingJV').jqxGrid('getrows');
	    	var rowlength= rows.length;
			if(rowlength==0){
				$("#postingJV").jqxGrid('addrow', null, {});
	  	    	$("#postingJV").jqxGrid('addrow', null, {});
	    	}
			$("#postingJV").jqxGrid({ disabled: false});
				
			var rows = $("#jqxFleetGrid").jqxGrid('getrows');
			
			if(rows.length==1 && (rows[0].amount=="undefined" || rows[0].amount==null || rows[0].amount=="")){
				return false;
			}
			
			var selectedrows=$("#jqxFleetGrid").jqxGrid('selectedrowindexes');
			selectedrows = selectedrows.sort(function(a,b){return a - b});
			if(selectedrows.length==0){
				$("#overlay, #PleaseWait").hide();
				$.messager.alert('Warning','Select Items to be Calculated.');
				return false;
			}
			
			var i=0;var temp="";
	        $('#gridlength').val(selectedrows.length);
	        var j=0;
	        var k=0;
		    for (i = 0; i < rows.length; i++) {
					if(selectedrows[j]==i){
						$("#jqxFleetGrid").jqxGrid('setcellvalue', i, "totalamount", $('#jqxFleetGrid').jqxGrid('getcellvalue', i, "amount"));
						if(k==0){
							k=10;
							temp=rows[i].ticket_no;
						}
						else{
							temp=temp+"::"+rows[i].ticket_no;
						}
						temp1=temp;
					j++; 
				  }
	            }
		  
		

		
	      $('#txttrno').val(temp1);
	      $("#overlay, #PleaseWait").hide();
		/*   $('#postingCardGrid').jqxGrid({ sortable: true}); */
			
		}
	
		/* function cardCommission(cardtype,netamt,paytype,i,length){
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
					{
					 items= x.responseText;
					 items=items.split(":");
					 
					 var amount=items[0];
					 var commission=items[1];
					 var index=items[2];
					 
					  $("#postingCardGrid").jqxGrid('setcellvalue', index, "commission", commission);
					  $("#postingCardGrid").jqxGrid('setcellvalue', index, "amountcomm", amount);
					 
					}
				else
					{
					}
			}
			x.open("GET","getCommissionAmount.jsp?cardtype="+cardtype+"&netamt="+netamt+"&paytype="+paytype+"&index="+i,true);
			x.send();
		}
	 */
     
      
  /*     function funGridType(){

     	 var paytype = $('#cmbtype').val();
     	 
     	$("#postingJV").jqxGrid('clear');$("#postingJV").jqxGrid({ disabled: true});
		
 		 if(paytype==2){
 		       	$("#postingCardDiv").prop("hidden", false);
 		        $("#postingCashDiv").prop("hidden", true);
 		 }else{
 			    $("#postingCashDiv").prop("hidden", false);
 			    $("#postingCardDiv").prop("hidden", true);
 		 }
 		
 		} */
 		
 		
 		
 		
 		function getAccounts(){
 			//txttypeaccid txttypeaccname
 			document.getElementById("txttypeaccid").value="";
 			
 			document.getElementById("txttypeaccname").value="";
 			
 			
 	  		var x = new XMLHttpRequest();
 	  		x.onreadystatechange = function() {
 	  			if (x.readyState == 4 && x.status == 200) {
 	  				var items = x.responseText;
 	  				items = items.split('####');
 	  				var docNoItems = items[0];
 	  				var accountIdItems  = items[1];
 	  				var accountItems = items[2];
 	  				var accountTypeItems = items[3];
 	  				var accountCurIdItems  = items[4];
 	  				var accountRateItems = items[5];
 	  				var accCurrTypeItems = items[6];
 	  				//txtaccid txtaccname txtdocno txtatype txtcurid txtrate txtcurtype
 	  			    $('#txtdocno').val(docNoItems);	
 	  			    $('#txtaccid').val(accountIdItems);
 	  			    $('#txtaccname').val(accountItems);
 	  			  	$('#txtatype').val(accountTypeItems);
 				    $('#txtcurid').val(accountCurIdItems);
 				    $('#txtrate').val(accountRateItems);
 				    $('#txtcurtype').val(accCurrTypeItems);
 	  		}
 	  		}
 	  		x.open("GET", "getAccounts.jsp?paytype="+$('#fromdate').val(), true);
 	  		x.send();
 	 }
 		
      
      function funNotify(){	
    		var maindate = $('#todate').jqxDateTimeInput('getDate');
			   var validdate=funDateInPeriod(maindate);
			   if(validdate==0){
		
			   return 0; 
			   }
 	 
		    	 if(document.getElementById("calcu").value=="")
		    		 
		    		 {
		    		 
		    		 $.messager.alert('Warning','Calculate & then Generate.');
			  			return false;
		    		 
		    		 }
		    	
		 
		    	 
		    	 
    	  var paytype = $('#cmbtype').val();
      	 
 		 if(paytype==""){
	    	  var rows = $("#jqxFleetGrid").jqxGrid('getrows');                    
	      	  if(rows.length>0 && (rows[0].netamt=="undefined" || rows[0].netamt==null || rows[0].netamt=="")){
	      		return false;
	      	  }
	      	  
	      	
	 		 var branchval = document.getElementById("cmbbranch").value;
	 		 var txttypeaccid = document.getElementById("txttypeaccid").value;
	 		 
	 		 if(branchval=="a")
	 			 {
	 			 $.messager.alert('Message','Choose A Specific Branch.','warning');
	 			 return 0;
	 			 }
	        	 if(paytype==''){
					 $.messager.alert('Message','Please Choose Type.','warning');
					 return 0;
				 }
				 if(txttypeaccid==''){
					 $.messager.alert('Message','Search Account.','warning');
					 return 0;
				 }
				 
	      	  
	      	   var selectedrows=$("#jqxFleetGrid").jqxGrid('selectedrowindexes');
	         
		  	   if(selectedrows.length==0){
		  			$.messager.alert('Warning','Select Items,Calculate & then Generate.');
		  			return false;
		  	   }
 		 }
   		
   		 
	  /* 	   var jvrows = $("#postingJV").jqxGrid('getrows');
	  	   if(jvrows.length>0 && (jvrows[0].baseamount=="undefined" || jvrows[0].baseamount==null || jvrows[0].baseamount=="")){
	  			$.messager.alert('Warning','Select Cards,Calculate & then Generate.');
	  			return false;
	  	   } */
   		  
  		   $.messager.confirm('Confirm', 'Do you want to Post?', function(r){
  	 		if (r){
  	 				
	    	/* Journal Voucher Grid Saving */
	    	 var rows = $("#postingJV").jqxGrid('getrows');
	    	 var length=0;
			 for(var i=0 ; i < rows.length ; i++){
				var chk=rows[i].docno;
				if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
					newTextBox = $(document.createElement("input"))
				    .attr("type", "dil")
				    .attr("id", "test"+length)
				    .attr("name", "test"+length)
				    .attr("hidden", "true");
					length=length+1;
					
				var amount,baseamount,id;
				if((rows[i].credit!=null) && (rows[i].credit!='undefined') &&  (rows[i].credit!='NaN') && (rows[i].credit!="") && (rows[i].credit!=0)){
					 amount=rows[i].credit*-1;
					 baseamount=rows[i].baseamount*-1;
					 id=-1;
				}
				
				if((rows[i].debit!=null) && (rows[i].debit!='undefined') && (rows[i].debit!='NaN') && (rows[i].debit!="") && (rows[i].debit!=0)){
					 amount=rows[i].debit;
					 baseamount=rows[i].baseamount;
					 id=1;
				}
				
				newTextBox.val(rows[i].docno+"::"+rows[i].description+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+amount+"::"+baseamount+"::0::"+id+":: :: ");
				newTextBox.appendTo('form');
				}
			 }
			 $('#jvgridlength').val(length);
	 		/* Journal Voucher Grid Saving Ends */
	 		
			 document.getElementById("mode").value='A';
			 $("#overlay, #PleaseWait").show();
			 document.getElementById("frmDashboardPostings").submit();
			 
  	 		 }
  	 		});
    		return 1;
	} 
  
      
    function funClearInfo()
    {

    	 
  	  document.getElementById("txttypeaccid").value="";

	  document.getElementById("txttypedocno").value="";
	  
	  
	  
	  document.getElementById("txttypeatype").value="";
	  document.getElementById("txttypecurid").value="";
	  
	  
	  document.getElementById("txttyperate").value ="";
	  
	  document.getElementById("txttypetype").value=""; 
	  document.getElementById("txttrno").value="";
	  document.getElementById("txtaccid").value=""; 
	  document.getElementById("txtaccname").value="";
	  
	  document.getElementById("txtdocno").value=""; 
	  document.getElementById("txtatype").value="";
	  document.getElementById("txtcurid").value=""; 
	  document.getElementById("txtrate").value="";
	  
	  document.getElementById("txtrate").value="";
	  
	  document.getElementById("txtcurtype").value="";
	  
document.getElementById("hidticketno").value="";
		document.getElementById("ticketdetails").value="";
    	
    	
    }
      
  
  function setValues(){
	 
	document.getElementById("cmbtype").value="";
	  
	  if($('#hidfromdate').val()){
			 $("#fromdate").jqxDateTimeInput('val', $('#hidfromdate').val());
		  }

	  if($('#hidtodate').val()){
			 $("#todate").jqxDateTimeInput('val', $('#hidtodate').val());
		  }
	  
	  if($('#hiddate').val()){
			 $("#date").jqxDateTimeInput('val', $('#hiddate').val());
		  }
	  
	  
	  
	  
	  if($('#msg').val()!=""){
		 $.messager.alert('Message',$('#msg').val());
		 
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 
	
			 $("#postingCashDiv").load("postingTrafficgrid.jsp?fromdate="+fromdate+'&todate='+todate+'&chk='+"GO");
		// funGridType();
		// funreload(event);
		// getAccounts($('#hidcmbtype').val());
		// getCommissionAccounts($('#hidcmbtype').val());
	 }
	  $('#txtdrtotal').val('0.00');$('#txtcrtotal').val('0.00');
	}
	
</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmDashboardPostings" action="saveDbTrafficPosting" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td align="right"><label class="branch">Period</label></td>
	
    <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div>
    <input type="hidden" id="hidfromdate" name="hidfromdate" style="width:60%;height:20px;" readonly value='<s:property value="hidfromdate"/>'/></td></tr> 
    <tr><td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div>
    <input type="hidden" id="hidtodate" name="hidtodate" style="width:60%;height:20px;" readonly value='<s:property value="hidtodate"/>'/></td></tr> 
	<tr><td align="right"><label class="branch">Type</label></td>
	<td align="left"><select id="cmbtype" name="cmbtype" style="width:50%;"  value='<s:property value="cmbtype"/>' onchange="getAccounts();">
    <option value="">--Select--</option><option value="1">Cash</option><option value="2">Bank</option><option value="3">GL</option></select>
    <input type="hidden" id="hidcmbtype" name="hidcmbtype" style="width:60%;height:20px;" readonly value='<s:property value="hidcmbtype"/>' /></td></tr>
  
    <tr><td align="right"><label class="branch">Account</label></td>
	<td align="left"><input type="text" id="txttypeaccid" name="txttypeaccid" style="width:80%;height:20px;" placeholder="Press F3 To search" readonly value='<s:property value="txttypeaccid"/>' tabindex="-1" onkeydown="getacc(event);"/></td></tr> 
	<tr><td>&nbsp;</td> 
	<td><input type="text" id="txttypeaccname" name="txttypeaccname" style="width:100%;height:20px;" readonly value='<s:property value="txttypeaccname"/>' tabindex="-1"/>
    <input type="hidden" id="txttypedocno" name="txttypedocno" style="width:60%;height:20px;" readonly value='<s:property value="txttypedocno"/>'/>
    <input type="hidden" id="txttypeatype" name="txttypeatype" style="width:60%;height:20px;" readonly value='<s:property value="txttypeatype"/>'/>
    <input type="hidden" id="txttypecurid" name="txttypecurid" style="width:60%;height:20px;" readonly value='<s:property value="txttypecurid"/>'/>
    <input type="hidden" id="txttyperate" name="txttyperate" style="width:60%;height:20px;" readonly value='<s:property value="txttyperate"/>'/>
    <input type="hidden" id="txttypetype" name="txttypetype" style="width:60%;height:20px;" readonly value='<s:property value="txttypetype"/>'/></td></tr>
      <tr><td>&nbsp;</td>
        <td><input type="checkbox" name="chkticketno" id="chkticketno"><label for="chkticketno" class="branch">Ticket No</label><button type="button" name="btnticketadd" id="btnticketadd" class="myButtons" onclick="funTicketAdd();">+</button>&nbsp;&nbsp;<button type="button" name="btnticketremove" id="btnticketremove" class="myButtons" onClick="funTicketRemove();">-</button></td>
      </tr>
       <input type="hidden" name="txttrno" id="txttrno" style="width:100%;height:20px;" value='<s:property value="txttrno"/>'>      <input type="hidden" id="txtaccid" name="txtaccid" style="width:60%;height:20px;" readonly   value='<s:property value="txtaccid"/>'  />      <input type="hidden" id="txtaccname" name="txtaccname" style="width:100%;height:20px;" readonly value='<s:property value="txtaccname"/>' tabindex="-1"/>      <input type="hidden" id="txtdocno" name="txtdocno" style="width:60%;height:20px;" readonly value='<s:property value="txtdocno"/>'/>      <input type="hidden" id="txtatype" name="txtatype" style="width:60%;height:20px;" readonly value='<s:property value="txtatype"/>'/> <input type="hidden" id="txtcurid" name="txtcurid" style="width:60%;height:20px;" readonly value='<s:property value="txtcurid"/>'/>      <input type="hidden" id="txtrate" name="txtrate" style="width:60%;height:20px;" readonly value='<s:property value="txtrate"/>'/> <input type="hidden" id="txtcurtype" name="txtcurtype" style="width:60%;height:20px;" readonly value='<s:property value="txtcurtype"/>'/>
    <tr><td colspan="2"><textarea id="ticketdetails" style="width:100%;height:150px;resize:none;"></textarea></td></tr> 
    
<tr><td  width="20%" align="right"><label class="branch">Post Date</label></td><td colspan="1">
  <div id="date"  name="date" value='<s:property value="date"/>'></div>
  <input type="hidden" id="hiddate" name="hiddate" style="width:100%;height:20px;" value='<s:property value="hiddate"/>'/>
</td></tr>
		<tr><td colspan="2">&nbsp;</td></tr>
    <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();">
    <button class="myButton" type="button" id="btnGenerate" name="btnGenerate" onclick="funNotify();">Post</button></td></tr>

	<tr><td colspan="2"><%-- <input type="hidden" id="txtcommdocno" name="txtcommdocno" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txtcommdocno"/>'/>
	<input type="hidden" id="txtcommaccid" name="txtcommaccid" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txtcommaccid"/>'/>
	<input type="hidden" id="txtcommaccname" name="txtcommaccname" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txtcommaccname"/>'/>
    <input type="hidden" id="txtcommatype" name="txtcommatype" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txtcommatype"/>'/>
    <input type="hidden" id="txtcommcurid" name="txtcommcurid" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txtcommcurid"/>'/>
    <input type="hidden" id="txtcommrate" name="txtcommrate" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txtcommrate"/>'/>
    <input type="hidden" id="txtcommtype" name="txtcommtype" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="txtcommtype"/>'/> --%>
    <input type="hidden" id="gridlength" name="gridlength" style="width:100%;height:20px;"/>
    <input type="hidden" id="jvgridlength" name="jvgridlength" style="width:100%;height:20px;"/>

    <input type="hidden" name="mode" id="mode" style="width:100%;height:20px;" value='<s:property value="mode"/>'>
    
     <input type="hidden" name="calcu" id="calcu" style="width:100%;height:20px;" value='<s:property value="calcu"/>'>
    
	<input type="hidden" name="msg" id="msg" style="width:100%;height:20px;" value='<s:property value="msg"/>'>
	</td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr><td><div id="postingCashDiv"><jsp:include page="postingTrafficgrid.jsp"></jsp:include></div>

		<tr><td><div id="JVTDiv"><jsp:include page="journalVoucherGrid.jsp"></jsp:include></div></td></tr> 
		<tr><td>
		<table width="100%">
		  <tr>
		    <td width="7%" align="right" style="font-family: Myriad Pro;font-size: 12px;font-weight: bold;">Dr. Total :&nbsp;</td>
		    <td width="68%"><input type="text" id="txtdrtotal" name="txtdrtotal" class="textbox" style="width:15%;text-align: right;" readonly value='<s:property value="txtdrtotal"/>'/></td>
		    <td width="6%" align="right" style="font-family: Myriad Pro;font-size: 12px;font-weight: bold;">Cr. Total :&nbsp;</td>
		    <td width="19%"><input type="text" id="txtcrtotal" name="txtcrtotal" class="textbox" style="width:50%;text-align: right;" readonly value='<s:property value="txtcrtotal"/>' tabindex="-1"/></td>
		  </tr>
		</table>
		</td></tr>
	</table>
</tr>
</table>
<input type="hidden" name="hidticketno" id="hidticketno">
</div>

<div id="accountDetailsWindow">
	<div></div><div></div>
</div>
<div id="multiSearchWindow">
	<div></div><div></div>
</div>
</div>
</form>
</body>
</html>