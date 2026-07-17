
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/resample.js"></script>
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
	 
	 
	
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     $("body").prepend('<div id="overlaysub" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWaitsub' style='display: none;position:absolute; z-index: 1;top:230px;left:120px;'><img src='../../../../icons/31load.gif'/></div>");

	 //    $('#fieldnoallot').hide();
	     $('#fieldvehrel').hide();
	     
	     $('#fieldpur').hide();
	     $('#fieldfleet').hide();
	//     $('#fieldcomp').hide();
	     $('#purchasePrint').attr("disabled",true);
	$('#fleetdetaildiv').hide();
	
	 $('#dealerinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '85%' ,maxWidth: '70%' ,title: 'Dealer Search' , position: { x: 200, y: 120 }, keyboardCloseKey: 27});
	 $('#dealerinfowindow').jqxWindow('close');
	 $('#fleetinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '85%' ,maxWidth: '70%' ,title: 'Fleet Search' , position: { x: 200, y: 120 }, keyboardCloseKey: 27});
	 $('#fleetinfowindow').jqxWindow('close');
	 $('#salpersonwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '85%' ,maxWidth: '70%' ,title: 'Sales Person Search' , position: { x: 200, y: 120 }, keyboardCloseKey: 27});
	 $('#salpersonwindow').jqxWindow('close');
	 $('#purdealer').dblclick(function(){
		 var stat="PO";
	  	    $('#dealerinfowindow').jqxWindow('open');
          $('#dealerinfowindow').jqxWindow('focus');
         dealerinfoSearchContent('dealerMSearch.jsp?stat='+stat); 
         });
	 
	 $('#dealer').dblclick(function(){
		 var stat="FU";
	  	    $('#dealerinfowindow').jqxWindow('open');
       $('#dealerinfowindow').jqxWindow('focus');
      dealerinfoSearchContent('dealerMSearch.jsp?stat='+stat); 
      });
	 $('#salperson').dblclick(function(){
		
	  	    $('#salpersonwindow').jqxWindow('open');
       $('#salpersonwindow').jqxWindow('focus');
      salpersonSearchContent('salpersonsearch.jsp'); 
      });
	 $('#txtfleetno').dblclick(function(){
	  	    $('#fleetinfowindow').jqxWindow('open');
    $('#fleetinfowindow').jqxWindow('focus');
    fleetinfoSearchContent('fleetsearch.jsp?brdid='+document.getElementById("brandid").value+'&modid='+document.getElementById("modelid").value); 
   });
	 
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	    
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#fleetdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $('#todate').on('change', function (event) {
			
		   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  }   
	 });
	 
	 
	 fundisable();
});

/* function funExportBtn(){
	   $("#qutfollowgrid").jqxGrid('exportdata', 'xls', 'Quotation Follow Up');
	 } */

function funreload(event)
{
		
	var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));

// out date
	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	 
 if(fromdates>todates){
	   
	   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
	 
 return false;
} 
	/*  
	 
 else
	   {
	
	// fundisable();
	
	
	  /* 
	  $("#overlay, #PleaseWait").show();
		 $("#fleetdetailsgrid").jqxGrid('clear');
	 $("#leasefollowdiv").load("leasefollowGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&radval="+radval); */
	 
	/*  $("#overlaysub, #PleaseWaitsub").show();
	  $("#Readygrid").load("subgrid.jsp?branchval="+barchval+"&fromdate="+fromdate+"&todate="+todate); 
	   }
	 */
	 var barchval = document.getElementById("cmbbranch").value;
	 var salperson =document.getElementById("hidsalperson").value;
     var fromdate= $("#fromdate").val();
	 var todate= $("#todate").val();
	 
  $("#overlaysub, #PleaseWaitsub").show();
 $("#Readygrid").load("subgrid.jsp?branchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&salperson="+salperson+"&id=1");
 $("#fleetdetailsgrid").jqxGrid('clear');
 fundisable();
	}
	

function funupdate()
{
	var statval = document.getElementById("hidstat").value;
	
	 var srno = document.getElementById("srno").value;
	 var podate=  $('#date').val();
	 var fleetdate=  $('#fleetdate').val();
	 var purdealer =document.getElementById("hidpurdealer").value;
	 var dealer =document.getElementById("hiddealer").value;
	 var brndid =document.getElementById("brandid").value;
	 var modid =document.getElementById("modelid").value;
	 var nmonth =document.getElementById("nomonth").value;
	 var vcost =document.getElementById("vehcost").value;
	 var fleetdoc =document.getElementById("fleetdoc").value;
	 var fleetno =document.getElementById("hidfleetno").value;
	 var resval= document.getElementById("resval").value;
	 var purcost= document.getElementById("purcost").value;
	 var leaseappdoc= document.getElementById("leaseappdoc").value;
	 var vendacno= document.getElementById("vendacno").value;
	 var allocno= document.getElementById("txtalloc").value;
	 var invno= document.getElementById("txtinv").value;
	var allotno= document.getElementById("txtallot").value;
	var chassisno= document.getElementById("txtchasis").value;
	var allotrmk =document.getElementById("txtallotremark").value;
	var vehrmk =document.getElementById("txtvehremark").value;
	var lasrno =document.getElementById("lasrno").value;
	 var costval = document.getElementById("txtcostval").value;
	   var extraval = document.getElementById("txtcostadd").value;
	 var costrslt=document.getElementById("txtcostresult").value;
	
	 var msg="";
	if(statval=="NA")
	{
	 if(document.getElementById("txtallot").value=="")
	 {
		 $.messager.alert('Message','Please Enter Allocation No. ','warning');   
					 
		 return 0;
	 }
			
	}
	else if(statval=="PO")
		{
		 if(document.getElementById("hidpurdealer").value=="")
		 {
			 $.messager.alert('Message','Select Dealer ','warning');   
						 
			 return 0;
		 }
				
		}
	else if(statval=="FU")
	{
		if(document.getElementById("hidfleetno").value=="")
		 {
			 $.messager.alert('Message','Select Fleet ','warning');   
						 
			 return 0;
		 }
	
		if(document.getElementById("hiddealer").value=="")
		 {
			 $.messager.alert('Message','Select Dealer ','warning');   
						 
			 return 0;
		 }
	}
	else if(statval=="VR")
	{
		var yes_no=$('#instock_veh').val();
		if(costrslt=="")
		 {
			costrslt=costval;
		 }
		 if(yes_no=="1"){
			msg="";
		 }	
		 if(yes_no=="0"){
				msg=msg+" Total Purchase Value is "+costrslt+" ,  ";
			 }	
	
	}
	
	    $.messager.confirm('Message', ''+msg+' Do you want to Update?', function(r){
	     	  
		        
	     	if(r==false)
	     	  {
	     		return false; 
	     	  }
	     	else{
	     		 savegriddata(statval,srno,podate,purdealer,qty,brndid,modid,nmonth,vcost,dealer,fleetno,fleetdoc,resval,fleetdate,purcost,leaseappdoc,vendacno,allocno,invno,allotno,allotrmk,vehrmk,chassisno,lasrno,costval,extraval,costrslt,yes_no);	
	     	}
		     });
	
}
function savegriddata(statval,srno,podate,purdealer,qty,brndid,modid,nmonth,vcost,dealer,fleetno,fleetdoc,resval,fleetdate,purcost,leaseappdoc,vendacno,allocno,invno,allotno,allotrmk,vehrmk,chassisno,lasrno,costval,extraval,costrslt,yes_no)
{
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
     			
			var items=x.responseText;
			if(items==1) 
			{
				 document.getElementById("txtfleetno").value="";
				 document.getElementById("purdealer").value="";
				 document.getElementById("dealer").value="";
				document.getElementById("srno").value="";
				 document.getElementById("hidpurdealer").value="";
				 document.getElementById("hiddealer").value="";
				document.getElementById("brandid").value="";
				 document.getElementById("modelid").value="";
				document.getElementById("nomonth").value="";
				 document.getElementById("vehcost").value="";
				 document.getElementById("fleetdoc").value="";
				 document.getElementById("hidfleetno").value="";
				 document.getElementById("resval").value="";
				 document.getElementById("purcost").value="";
				 document.getElementById("leaseappdoc").value="";
				 document.getElementById("vendacno").value="";
				 document.getElementById("txtalloc").value="";
				 document.getElementById("txtinv").value="";
				 document.getElementById("txtallot").value="";
				 document.getElementById("txtallotremark").value="";
				 document.getElementById("txtvehremark").value="";
				 document.getElementById("hidstat").value="";
				 document.getElementById("txtchasis").value="";
				 document.getElementById("lasrno").value="";
 document.getElementById("txtcostval").value="";
				  document.getElementById("txtcostadd").value="";
				 document.getElementById("txtcostresult").value="";
				  $('#date').val(new Date());
				  $('#fleetdate').val(new Date());
				  $.messager.alert('Message', '  Record Successfully Updated ');
				 funreload(event); 
				 disitems();
				 $("#fleetdetailsgrid").jqxGrid('clear');
			}
			else{
				$.messager.alert('Message', 'Not Updated ');
				 $("#fleetdetailsgrid").jqxGrid('clear');
			}
			
			}
	}            
		
x.open("GET","leasesavedata.jsp?statval="+statval+"&srno="+srno+"&podate="+podate+"&purdealer="+purdealer+"&brndid="+brndid
		+"&modid="+modid+"&nmonth="+nmonth+"&vcost="+vcost+"&dealer="+dealer+"&fleetdoc="+fleetdoc+"&fleetno="+fleetno
		+"&resval="+resval+"&fleetdate="+fleetdate+"&purcost="+purcost+"&leaseappdoc="+leaseappdoc+"&vendacno="+vendacno
		+"&allocno="+allocno+"&invno="+invno+"&allotno="+allotno+"&allotrmk="+allotrmk+"&vehrmk="+vehrmk
		+"&chassisno="+chassisno+"&lasrno="+lasrno+"&costval="+costval+"&extraval="+extraval+"&costrslt="+costrslt+"&yes_no="+yes_no,true);

x.send();
		
}


function funchangeinfo()
{
	
	 $('#date').jqxDateTimeInput( 'focus');
	
	}
	
function fundisable(){
//	 $('#leasefollowgrid').jqxGrid({ height: 530 });
//$("#leasefollowdiv").load("leasefollowGrid.jsp?chkval=1");
 		
	  $("#leasefollowdiv").load("leasefollowGrid.jsp?check=0");  
	//	$('#leasefollowgridid').jqxGrid({ height: 530 });
		
		$("#leasefollowgridid").jqxGrid('clear');
 		$('#fleetdetaildiv').hide();
		 disitems();
		 $('#fieldnoallot').show();
	     $('#fieldvehrel').hide();
	     
	     $('#fieldpur').hide();
	     $('#fieldfleet').hide();
	    
		 document.getElementById("txtfleetno").value="";
		 document.getElementById("srno").value="";
		 document.getElementById("purdealer").value="";
		 document.getElementById("dealer").value="";
		 document.getElementById("hidpurdealer").value="";
		 document.getElementById("hiddealer").value="";
		document.getElementById("brandid").value="";
		 document.getElementById("modelid").value="";
		document.getElementById("nomonth").value="";
		 document.getElementById("vehcost").value="";
		 document.getElementById("fleetdoc").value="";
		 document.getElementById("hidfleetno").value="";
		 document.getElementById("resval").value="";
		 document.getElementById("purcost").value="";
		 document.getElementById("leaseappdoc").value="";
		 document.getElementById("vendacno").value="";
		 document.getElementById("txtalloc").value="";
		 document.getElementById("txtinv").value="";
		 document.getElementById("txtallot").value="";
		 document.getElementById("txtallotremark").value="";
		 document.getElementById("txtvehremark").value="";
		 document.getElementById("hidstat").value="";
		 document.getElementById("txtchasis").value="";
		 document.getElementById("lasrno").value="";
 document.getElementById("txtcostval").value="";
		   document.getElementById("txtcostadd").value="";
		 document.getElementById("txtcostresult").value="";
}

function getfleetinfo(event){
 	 var x= event.keyCode;
 	 if(x==114){
 	  $('#fleetinfowindow').jqxWindow('open');
    
 	 fleetinfoSearchContent('fleetsearch.jsp?brdid='+document.getElementById("brandid").value+'&modid='+document.getElementById("modelid").value);
 	 }
 	 else{
 		 }
 	 }

  function fleetinfoSearchContent(url) {

 		 $.get(url).done(function (data) {
 		
 		$('#fleetinfowindow').jqxWindow('setContent', data);
 
 	}); 
 	}

function getpurDealer(event){
	var stat="PO";
  	 var x= event.keyCode;
  	 if(x==114){
  	  $('#dealerinfowindow').jqxWindow('open');
     
     dealerinfoSearchContent('dealerMSearch.jsp?stat='+stat);   }
  	 else{
  		 }
  	 }
function getDealer(event){
	var stat="FU"
 	 var x= event.keyCode;
 	 if(x==114){
 	  $('#dealerinfowindow').jqxWindow('open');
    
    dealerinfoSearchContent('dealerMSearch.jsp?stat='+stat);   }
 	 else{
 		 }
 	 }
function getsalperson(event){
	
 	 var x= event.keyCode;
 	 if(x==114){
 	  $('#salpersonwindow').jqxWindow('open');
    
 	 salpersonSearchContent('salpersonsearch.jsp');   }
 	 else{
 		 }
 	 }
function salpersonSearchContent(url) {
	 
		 $.get(url).done(function (data) {
		
		$('#salpersonwindow').jqxWindow('setContent', data);

	}); 
	}
   function dealerinfoSearchContent(url) {
 
  		 $.get(url).done(function (data) {
  		
  		$('#dealerinfowindow').jqxWindow('setContent', data);
  
  	}); 
  	}
   function disitems()
   {
	   if(document.getElementById("txtfleetno").value=="")
		   {
	   $("#txtfleetno").attr('placeholder', 'Press F3 To Search');
		   }
	   if(document.getElementById("dealer").value=="")
	   {
   $("#dealer").attr('placeholder', 'Press F3 To Search');
	   }
	   if(document.getElementById("purdealer").value=="")
	   {
   $("#purdealer").attr('placeholder', 'Press F3 To Search');
	   }
	   $('#date').jqxDateTimeInput({ disabled: true});
	   $('#fleetdate').jqxDateTimeInput({ disabled: true});
		 $('#purdealer').attr("disabled",true);
		 $('#purchasePrint').attr("disabled",true);
		 $('#purchaseUpdate').attr("disabled",true);
		 
		 $('#allotUpdate').attr("disabled",true);
		 $('#vehreleaseUpdate').attr("disabled",true);
		 //$('#vehreleasePrint').attr("disabled",true);
		 
		 $('#txtfleetno').attr("disabled",true);
		 $('#dealer').attr("disabled",true);
		 $('#fleetUpdate').attr("disabled",true);
		 $('#txtalloc').attr("disabled",true);
		 $('#txtinv').attr("disabled",true);
		 
		 $('#txtallot').attr("disabled",true);
		 $('#txtchasis').attr("disabled",true);
		 $('#txtallotremark').attr("disabled",true);
		 $('#txtvehremark').attr("disabled",true);

		 $('#txtcostval').attr("disabled",true);
		 $('#txtcostadd').attr("disabled",true);
		 $('#txtcostresult').attr("disabled",true);
	
		 $('#txtvehremark').attr("disabled",true);
		 $('#instock_veh').attr("disabled",true);
		 
   }

   function funprint(){
       var url=document.URL;
       var reurl=url.split("leasefollowmaster.jsp");
    //   var win= window.open(reurl[0]+"printPurchaseOrder?&branch="+document.getElementById("cmbbranch").value+'&fromDate='+document.getElementById("fromdate").value+'&toDate='+$("#todate").val(),"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
       var win= window.open(reurl[0]+"printPurchaseOrder?srno="+document.getElementById("srno").value,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
       win.focus();
  }
  
  function funvehprint(){
      var url=document.URL;
      var reurl=url.split("leasefollowmaster.jsp");
   //   var win= window.open(reurl[0]+"printPurchaseOrder?&branch="+document.getElementById("cmbbranch").value+'&fromDate='+document.getElementById("fromdate").value+'&toDate='+$("#todate").val(),"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
      var win= window.open(reurl[0]+"VehicleRequestPrint?srno="+document.getElementById("srno").value+"&printsrno="+document.getElementById("printsrno").value+"&printdocno="+document.getElementById("printdocno").value+"&printbrhid="+document.getElementById("printbrhid").value+'&print=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
      win.focus();
 }
   
  function funSendingEmail() {  
	    var email = document.getElementById("hidemail").value;
	    var res;var part1;var part2;var dotsplt;
	    if(email.indexOf("@")>=0) {
		    res = email.split('@');
		    part1=res[0];
		    part2=res[1];
		    dotsplt=part2.split('.');
	    }
	   /* if ($("#txtdocno").val().trim()=="" || typeof($("#txtdocno").val().trim())=="undefined" || typeof($("#txtdocno").val().trim())=="NaN") {
		    $('#txtaccid').val('');$('#txtaccname').val('');$('#txtdocno').val('');$('#txtaccemail').val('');
			
			if (document.getElementById("txtaccid").value == "") {
		        $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
		    }
			$.messager.alert('Message','Account is Mandatory.','warning');
			return;
	  } else  */
	  if(email.trim()=="" || typeof(email.trim())=="undefined" || typeof(email.trim())=="NaN") {
		    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
	  } else if(email.indexOf("@")<0) {
		    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
	  } else if(email.split('@').length!=2) {
		    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
	  } else if(part1.length==0) {
		    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
	  } else if(part1.split(" ").length>2) {
		    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
    } else if(part2.split(".").length<2) {
  	    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
    } else if(dotsplt[0].length==0 ) {
  	    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
    } else if(dotsplt[1].length<2 ||dotsplt[1].length>4) {
  	    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
    } else {
		
		    $("#overlay, #PleaseWait").show();
		   
	 		$.ajaxFileUpload ({  
	    	    	
	    	    	  url: "VehicleRequestPrint.action?srno="+document.getElementById("srno").value+"&printsrno="+document.getElementById("printsrno").value+"&printdocno="+document.getElementById("printdocno").value+"&printbrhid="+document.getElementById("printbrhid").value+"&email="+document.getElementById("hidemail").value+"&cldocno="+document.getElementById("hidcldocno").value+"&print=0",  
	    	          secureuri:false,//false  
	    	          fileElementId:'file', //id  <input type="file" id="file" name="file" />  
	    	          dataType: 'string',// json  
	    	          success: function (data, status) {  
	    	        	  $('#btnSendingEmail').attr("disabled",true);
	    	             if(status=='success'){
							$("#overlay, #PleaseWait").hide();
							$.messager.alert('Message','E-Mail Send Successfully');
	    	              }
	    	             if(status=='error'){
	    	            	 $("#overlay, #PleaseWait").hide();
	    	            	 $.messager.alert('Message','E-Mail Sending failed');
	    	             }
	    	             
	    	              $("#testImg").attr("src",data.message);
	    	              if(typeof(data.error) != 'undefined')  
	    	              {  
	    	                  if(data.error != '')  
	    	                  {  
	    	                      alert(data.error);  
	    	                  }else  
	    	                  {  
	    	                      alert(data.message);  
	    	                  }  
	    	              }  
	    	          },  
	    	           error: function (data, status, e)
	    	          {  
	    	              alert(e);  
	    	          }  
	    	      }) 
	    	     return false;
		
		  } 
    }
   function setval()
   {
	   $('#btnSendingEmail').attr("disabled",true);
   }
 function setaddcost()
   {
	   var cost = document.getElementById("txtcostval").value;
	   var add = document.getElementById("txtcostadd").value;
	   if(cost!="" && add!="")
		   {
	   document.getElementById("txtcostresult").value=parseFloat(cost)+parseFloat(add);
		   }
   }
   function setsubcost()
   {
	   var cost = document.getElementById("txtcostval").value;
	   var add = document.getElementById("txtcostadd").value;
	   if(cost!="" && add!="")
		   {
		   document.getElementById("txtcostresult").value=parseFloat(cost)-parseFloat(add);
		   }
   }

   function instockVechile(){
	   if($('#instock_veh').val()=="1")
		   {
		   		$('#txtcostval').attr('disabled',true);
		   		$('#txtcostadd').attr('disabled',true);
		   		$("#btnadditem").attr('disabled',true);
		   		$('#btnremoveitem').attr('disabled',true);
		   		$('#txtcostresult').attr('disabled',true);
		   		$('#txtvehremark').attr('disabled',false);
		   }
	   if($('#instock_veh').val()=="0")
	   {
	   		$('#txtcostval').attr('disabled',false);
	   		$('#txtcostadd').attr('disabled',false);
	   		$("#btnadditem").attr('disabled',false);
	   		$('#btnremoveitem').attr('disabled',false);
	   		$('#txtcostresult').attr('disabled',false);
	   		$('#txtvehremark').attr('disabled',false);
	   }
	   
   }
</script>
</head>
<body onload="getBranch();setval()">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%"  >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
		<tr><td colspan="2"></td></tr>  
		  <tr><td  align="right" width="25%" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                    
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>
                    <tr><td align="right">
         <label class="branch">Sales Person</label></td><td><input type="text" id="salperson" readonly="readonly"  name="salperson"  style="height:20px;width:99%;" value='<s:property value="salperson"/>'  onKeyDown="getsalperson(event);" placeholder="Press F3 to Search"  />
                  
      </td>
      </tr> 
                    <tr><td colspan="2"></td></tr>  
                    
  	<!-- <tr  ><td  align="right" > <label class="branch">Purchase Order</label></td><td><input type="radio" id="radio_purchase" name="category" value="purchase" onchange="fundisable();" checked="true"> 
	 	&nbsp;<label class="branch">Fleet Update</label>
         <input type="radio" id="radio_fleet" name="category" value="fleet" onchange="fundisable();">
      
         </td>
	 	</tr> -->
	  <tr>
	 <td colspan="2" align="center" ><div id="Readygrid"><jsp:include page="subgrid.jsp"></jsp:include>
	</div></td>
	<!-- <td colspan="2"><div id='paychaaaaa' style="width: 100% ; align:right; height: 280px;"></div></td> --> 
	</tr>		
	
	  </table> 
	  <div style="display: table; height: 170px; width:100%; overflow: hidden; ">
  		 <div style="display: table-cell; vertical-align: middle;">
	  <div id="divprocess" >
	  <fieldset id="fieldnoallot" >
	  <legend>Not Allotted</legend>
	  <table width="100%"> 
	
      <tr><td align="right"><label class="branch">Allotment No. </label></td><td align="left"><input type="text" id="txtallot" style="height:20px;width:99%;" name="txtallot"  value='<s:property value="txtallot"/>'> </td></tr>
      <tr><td align="right"><label class="branch">Chassis No. </label></td><td align="left"><input type="text" id="txtchasis" style="height:20px;width:99%;" name="txtchasis"  value='<s:property value="txtchasis"/>'> </td></tr>
      <tr><td align="right"><label class="branch">Remarks </label></td><td align="left"><input type="text" id="txtallotremark" style="height:20px;width:99%;" name="txtallotremark"  value='<s:property value="txtallotremark"/>'> </td></tr>
      
	 <tr><td colspan="2"></td></tr> 
	<tr><td  align="center" colspan="2"><input type="Button" name="allotUpdate" id="allotUpdate" class="myButton" value="UPDATE" onclick="funupdate()"></td> </tr>
 </table>
</fieldset>
<fieldset id="fieldvehrel">
	  <legend>Vehicle Release Request</legend>
	  <table width="100%"> 
	 <tr> <td  align="right"><label class="branch">Instock Vehicle</label></td><td align="left">
 			<select name="instock_veh" id="instock_veh" style="width:70%;" name="instock_veh" onchange="instockVechile();" value='<s:property value="instock_veh"/>'>
       		<option value="" selected>-Select-</option>  
     		<option value=1>Yes</option>
     		<option value=0>No</option></select></td></tr>
	<tr><td align="left" width="25%"><label class="branch">Cost Value</label></td><td align="left"><input type="text" id="txtcostval" style="height:20px;width:99%;" readonly name="txtcostval"  value='<s:property value="txtcostval"/>'> </td></tr>
	<tr><td align="right"><label class="branch">Extra</label></td><td align="left"><input type="text" id="txtcostadd" style="height:20px;width:58%;" name="txtcostadd" value='<s:property value="txtcostadd"/>'> 
 
<button type="button" name="btnadditem" id="additem" class="myButtons" onClick="setaddcost();">+</button><button  type="button" name="btnremoveitem" id="btnremoveitem" class="myButtons" onclick="setsubcost();">-</button>
	</td>
	</tr>
	
	
	<tr><td align="right"><label class="branch">Total </label></td><td align="left"><input type="text" id="txtcostresult" style="height:20px;width:99%;" name="txtcostresult"  value='<s:property value="txtcostresult"/>' readonly="readonly"> </td></tr>
      
      <tr><td align="right"><label class="branch">Remarks </label></td><td align="left"><input type="text" id="txtvehremark" style="height:20px;width:99%;" name="txtvehremark"  value='<s:property value="txtvehremark"/>'> </td></tr>
      
	 <tr><td colspan="2"></td></tr> 
	<tr><td  align="center" colspan="2"><input type="Button" name="vehreleaseUpdate" id="vehreleaseUpdate" class="myButton" value="UPDATE" onclick="funupdate()"></td> </tr>
 </table>
</fieldset>
	  <fieldset id="fieldpur">
	  <legend>Purchase Order</legend>
	  <table width="100%" > 
	<tr><td align="right"><label class="branch">Dealer</label></td><td><input type="text" id="purdealer" readonly="readonly"  name="purdealer"  style="height:20px;width:99%;"  value='<s:property value="purdealer"/>' onKeyDown="getpurDealer(event);" placeholder="Press F3 to Search"/>
                  
      </td>
      </tr> 
	<tr><td  align="right" ><label class="branch">Date</label></td><td align="left"><div id='date' name='date' value='<s:property value="date"/>'></div>
                   </td></tr>
	 
	 <tr><td colspan="2"></td></tr> 
	<tr><td  align="center" colspan="2"><input type="Button" name="purchaseUpdate" id="purchaseUpdate" class="myButton" value="UPDATE" onclick="funupdate()">
	
	</td>
	
	 </tr>
 </table>
</fieldset>

<fieldset id="fieldfleet">
	  <legend>Fleet Purchase Update</legend>
	  <table width="100%"> 
	<tr>
		 <td align="right" ><label class="branch">Fleet</label> </td> 
          
	 <td ><input type="text" id="txtfleetno" name="txtfleetno" readonly="readonly" placeholder="Press F3 To Search" style="height:20px;width:99%;" value='<s:property value="txtfleetno"/>' onKeyDown="getfleetinfo(event);" onfocus="this.placeholder = ''" />
  
        </td>
        </tr>
         <tr><td align="right">
         <label class="branch">Dealer</label></td><td><input type="text" id="dealer" readonly="readonly"  name="dealer"  style="height:20px;width:99%;" value='<s:property value="dealer"/>'  onKeyDown="getDealer(event);" placeholder="Press F3 to Search"  />
                  
      </td>
      </tr> 
      <tr><td align="right"><label class="branch">Allotment No. </label></td><td align="left"><input type="text" id="txtalloc" style="height:20px;width:99%;" name="txtalloc"  value='<s:property value="txtalloc"/>'> </td></tr>
      <tr><td align="right"><label class="branch">Invoice No. </label></td><td align="left"><input type="text" id="txtinv" style="height:20px;width:99%;" name="txtinv"  value='<s:property value="txtinv"/>'> </td></tr>
      <tr><td  align="right" ><label class="branch">Date</label></td><td align="left"><div id='fleetdate' name='fleetdate' value='<s:property value="fleetdate"/>'></div>
                   </td></tr>
	 <tr><td colspan="2"></td></tr> 
	<tr><td  align="center" colspan="2"><input type="Button" name="fleetUpdate" id="fleetUpdate" class="myButton" value="UPDATE" onclick="funupdate()"></td> </tr>
 </table>
</fieldset>
<!-- <fieldset id="fieldcomp">
<table  width="100%"><tr>
<td align="center"><b></b><label class="branch" style="font-family: Times New Roman, Times, serif;color:Blue; font-size: 20px;font-weight:700">Completed </label></b>
</td></tr></table>
</fieldset> -->

</div>

</div>
</div>
	<!-- <div id='paychaaaaa' style="width: 100% ;  height: 2px;"></div> -->
	  <table width="100%" > 
	
	<tr><td  align="center" colspan="2">
	<input type="Button" name="vehreleasePrint" id="vehreleasePrint" class="myButton" value="Vehicle Req" onclick="funvehprint()"></td><td align="left">
	<input type="Button" name="purchasePrint" id="purchasePrint" class="myButton" value="Purchase Order" onclick="funprint()">
	</td>
	
	 </tr>
 </table>

<!-- </fieldset> -->
	
<input type="hidden" name="hiddealer" id="hiddealer" style="height:20px;width:70%;" value='<s:property value="hiddealer"/>' >
<input type="hidden" name="hidpurdealer" id="hidpurdealer" style="height:20px;width:70%;" value='<s:property value="hidpurdealer"/>' >
<input type="hidden" name="srno" id="srno" style="height:20px;width:70%;" value='<s:property value="srno"/>' >
<input type="hidden" name="qty" id="qty" style="height:20px;width:70%;" value='<s:property value="qty"/>' >
<input type="hidden" name="brandid" id="brandid" style="height:20px;width:70%;" value='<s:property value="brandid"/>' >
<input type="hidden" name="modelid" id="modelid" style="height:20px;width:70%;" value='<s:property value="modelid"/>' >
<input type="hidden" name="nomonth" id="nomonth" style="height:20px;width:70%;" value='<s:property value="nomonth"/>' >
<input type="hidden" name="vehcost" id="vehcost" style="height:20px;width:70%;" value='<s:property value="vehcost"/>' >
<input type="hidden" name="fleetdoc" id="fleetdoc" style="height:20px;width:70%;" value='<s:property value="fleetdoc"/>' >
<input type="hidden" name="hidfleetno" id="hidfleetno" style="height:20px;width:70%;" value='<s:property value="hidfleetno"/>' >
<input type="hidden" name="resval" id="resval" style="height:20px;width:70%;" value='<s:property value="resval"/>' >
<input type="hidden" name="purcost" id="purcost" style="height:20px;width:70%;" value='<s:property value="purcost"/>' >
<input type="hidden" name="leaseappdoc" id="leaseappdoc" style="height:20px;width:70%;" value='<s:property value="leaseappdoc"/>' >
<input type="hidden" name="vendacno" id="vendacno" style="height:20px;width:70%;" value='<s:property value="vendacno"/>' >
<input type="hidden" name="hidstat" id="hidstat" style="height:20px;width:70%;" value='<s:property value="hidstat"/>' >
<input type="hidden" name="lasrno" id="lasrno" style="height:20px;width:70%;" value='<s:property value="lasrno"/>' >
<input type="hidden" name="hidemail" id="hidemail" style="height:20px;width:70%;" value='<s:property value="hidemail"/>' >
<input type="hidden" name="hidcldocno" id="hidcldocno" style="height:20px;width:70%;" value='<s:property value="hidcldocno"/>' >
<input type="hidden" name="printdocno" id="printdocno" style="height:20px;width:70%;" value='<s:property value="printdocno"/>' >
<input type="hidden" name="printsrno" id="printsrno" style="height:20px;width:70%;" value='<s:property value="printsrno"/>' >
<input type="hidden" name="printbrhid" id="printbrhid" style="height:20px;width:70%;" value='<s:property value="printbrhid"/>' >
<input type="hidden" name="hidsalperson" id="hidsalperson" style="height:20px;width:70%;" value='<s:property value="hidsalperson"/>' >
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="leasefollowdiv"><jsp:include page="leasefollowGrid.jsp"></jsp:include></div></td>
		</tr>
		
		<!-- <tr>
		<td   >
		<div id="detaildiv">
		<table>
    <tr><td colspan="2">&nbsp;</td></tr>
	   <tr><td colspan="2">&nbsp;</td></tr>
	    <tr><td colspan="2">&nbsp;</td></tr>
	     <tr><td colspan="2">&nbsp;</td></tr>
	      <tr><td colspan="2">&nbsp;</td></tr>
	     <tr><td colspan="2">&nbsp;</td></tr>
	  </table> 
		</div>
	
		</td></tr> -->
		
		<tr>
		<td>
		
		<div id="fleetdetaildiv"><jsp:include page="fleetdetailgrid.jsp"></jsp:include></div>
		</td></tr>

	</table>
</tr>
</table>

</div>
<div id="dealerinfowindow">
   <div ></div>
</div> 
<div id="fleetinfowindow">
   <div ></div>
</div> 
<div id="salpersonwindow">
   <div ></div>
</div> 
</div>
</body>
</html>