<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
 <style>
 .hidden-scrollbar {
    overflow: auto;
    height: 530px;
}
 </style>
<script type="text/javascript">
   
        $(document).ready(function () {
        	document.getElementById("btnconfirm").style.display="none";
    		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
   	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
   	  $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	     $('#reqsearchwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Lease Price Request Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#reqsearchwindow').jqxWindow('close');
		   $('#dealerWindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Dealer Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#dealerWindow').jqxWindow('close');
		   $('#authoritywindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Authority Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#authoritywindow').jqxWindow('close');
		   
		   $("#btnExcel").click(function() {
		   		if(document.getElementById("docno").value==""){
					var topic=document.getElementById("lblvehicle").innerText;
		   			$("#jqxleasecalculator").jqxGrid('exportdata', 'xls', 'Lease Calculation of '+topic);
		   		}
		       });
		   
		   $("#overheadper").focusout(function(){
			  $("#others").focus(); 
		   });
		   $('#leasereqdoc').dblclick(function(){
				 $('#reqsearchwindow').jqxWindow('open');
					$('#reqsearchwindow').jqxWindow('focus');
					 reqSearchContent('masterLeaseRequest.jsp?branch='+document.getElementById("brchName").value);
				});
		   $('#dealer').dblclick(function(){
				 $('#dealerWindow').jqxWindow('open');
					$('#dealerWindow').jqxWindow('focus');
					 dealerSearchContent('../../../search/masterssearch/dealerMSearch.jsp');
				});
		   $('#authority').dblclick(function(){
				 $('#authoritywindow').jqxWindow('open');
					$('#authoritywindow').jqxWindow('focus');
					 authoritySearchContent('authoritySearch.jsp');
				});
        
        
        
        if(document.getElementById("docno").value==""){
        	document.getElementById("btncalculate").style.display="none";
        	document.getElementById("btnleasesave").style.display="none";
   			document.getElementById("btnleaseedit").style.display="none";
   			
   		 $('#dealer').attr('readonly', true);
		  $('#dealer').attr('disabled',true);
		  $('#purchcost').attr('readonly',true);
		  $('#downpytper').attr('readonly',true);
		  $('#interestper').attr('readonly',true);
		  $('#creditper').attr('readonly',true);
		  $('#authority').attr('readonly', true);
		  $('#authority').attr('disabled',true);
		  $('#profitper').attr('readonly', true);
		  $('#overheadper').attr('readonly', true);
		  $('#others').attr('readonly', true);
		  $('#discount').attr('readonly', true);
        }
        
        
        });
        
        function getLeaseReq(event){
        	var x= event.keyCode;
        	if(x==114){
        		 $('#reqsearchwindow').jqxWindow('open');
					$('#reqsearchwindow').jqxWindow('focus');
					 reqSearchContent('masterLeaseRequest.jsp?branch='+document.getElementById("brchName").value);	 
        	}
         	 

        }

        function getDealer(event){
        	var x= event.keyCode;
        	if(x==114){
        		 $('#dealerWindow').jqxWindow('open');
					$('#dealerWindow').jqxWindow('focus');
					 dealerSearchContent('../../../search/masterssearch/dealerMSearch.jsp');	 
        	}
        }
        
        
        function getAuthority(event){
        	var x= event.keyCode;
        	if(x==114){
        		 $('#authoritywindow').jqxWindow('open');
					$('#authoritywindow').jqxWindow('focus');
					 authoritySearchContent('authoritySearch.jsp');	 
        	}
         	 
        }

        function reqSearchContent(url) {
            $.get(url).done(function (data) {
            $('#reqsearchwindow').jqxWindow('setContent', data);
        }); 
        }
        
        function dealerSearchContent(url) {
            $.get(url).done(function (data) {
            $('#dealerWindow').jqxWindow('setContent', data);
        }); 
        }
        
        function authoritySearchContent(url) {
            $.get(url).done(function (data) {
            $('#authoritywindow').jqxWindow('setContent', data);
        }); 
        }


    function funReadOnly(){
		$('#frmLeaseCalculator input').attr('readonly', true );
		$('#date').jqxDateTimeInput({disabled:true});
		document.getElementById("btncalculate").disabled=true;
		document.getElementById("btnleasesave").disabled=true;
		//$("#jqxleasecalculator").jqxGrid({ disabled: true});
     }
        
	 function funRemoveReadOnly(){
			$('#frmLeaseCalculator input').attr('readonly', false );
			//$("#jqxleasecalculator").jqxGrid({ disabled: false});
			$('#date').jqxDateTimeInput({disabled:false});
			if(document.getElementById("mode").value=="A"){
  			  $('#dealer').attr('readonly', true);
			  $('#dealer').attr('disabled',true);
			  $('#purchcost').attr('readonly',true);
			  $('#downpytper').attr('readonly',true);
			  $('#interestper').attr('readonly',true);
			  $('#creditper').attr('readonly',true);
			  $('#authority').attr('readonly', true);
			  $('#authority').attr('disabled',true);
			  $('#profitper').attr('readonly', true);
			  $('#overheadper').attr('readonly', true);
			  $('#others').attr('readonly', true);
			  $('#discount').attr('readonly', true);
			  document.getElementById("btnleaseedit").style.display="none";
			  document.getElementById("btnleasesave").style.display="none";
			  document.getElementById("btncalculate").style.display="none";
			  document.getElementById("lblvehicle").innerText="";
			  document.getElementById("hidleasereqdoc").value="";
			  document.getElementById("reqgridlength").value="";
			  document.getElementById("hiddealer").value="";
			  document.getElementById("hidauthority").value="";
			  document.getElementById("authid").value="";
			  document.getElementById("leasemonths").value="";
			  document.getElementById("kmpermonth").value="";
			  document.getElementById("grpid").value="";
			  document.getElementById("srno").value="";
			  document.getElementById("totalvalue").value="";
			  document.getElementById("savestatus").value="";
			  document.getElementById("confirmstatus").value="";
			  $('#leaseReqGrid').jqxGrid('clear');
			  $('#jqxleasecalculator').jqxGrid('clear');
				$('#date').jqxDateTimeInput('setDate',new Date());
			}
			$('#docno').attr('readonly', true);
			$('#leasereqdoc').attr('readonly', true);
			$('#leasereqclient').attr('readonly', true);
			$('#clientmob').attr('readonly', true);
			//$('#txtinsurancecomp').attr('readonly', true);	
	 }
	 
	 function funSearchLoad(){
		 changeContent('masterSearch.jsp');  
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus()
	    {
	    	//document.getElementById("txtvehicle").focus(); 	    		
	    }
	 
	   
	  function funNotify(){	
	  				 
		  var rows = $("#leaseReqGrid").jqxGrid('getrows');
			if(rows[0].brand=="undefined" || rows[0].brand==""){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Please Select a valid document";
				return 0;	
			}
		
		  $('#reqgridlength').val(rows.length);
  			var  valid=0;
  			
		  for(var i=0 ; i < rows.length ; i++){
				var brand=rows[i].brand;
				var model=rows[i].model;
				var group=rows[i].gname;
  				if(group=="" || group=="undefined" || typeof(group)=="undefined" || group==null){
  					valid=-1;
  					$.messager.alert('warning','Cost Group of '+brand+' '+model+' not updated');
  					break;
  				}
  				newTextBox = $(document.createElement("input"))
			    .attr("type", "dil")
			    .attr("id", "testreq"+i)
			    .attr("name", "testreq"+i)
			    .attr("hidden", "true");
				var leasefromdate = $('#leaseReqGrid').jqxGrid('getcelltext', i, "leasefromdate");
				newTextBox.val(leasefromdate+"::"+rows[i].brdid+"::"+rows[i].modelid+"::"+rows[i].specification+"::"+rows[i].clrid+"::"+rows[i].leasemonths+"::"+rows[i].kmpermonth+"::"+rows[i].grpid);
			
			newTextBox.appendTo('form');
			
				//alert("ddddd"+$("#test"+i).val());
			}
		  if(valid==-1){
			  
			  return 0;
		  }
	    		return 1;
		} 
	  
	  function setValues(){
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  	document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  	funSetlabel();
		
		  	$("#leaseCalculator").load("leaseCalculatorGrid.jsp");
		  	if(document.getElementById("docno").value!="" && document.getElementById("leasereqdoc").value!=""){
			  	$('#leasereqdiv').load('leaseReqGrid.jsp?reqdocno='+document.getElementById("leasereqdoc").value+'&docno='+document.getElementById("docno").value+'&id=1');
			  	document.getElementById("btncalculate").style.display="none";
	        	document.getElementById("btnleasesave").style.display="none";
	   			document.getElementById("btnleaseedit").style.display="block";
	   			document.getElementById("btnleaseedit").disabled=true;
	   		  $('#dealer').attr('readonly', true);
			  $('#dealer').attr('disabled',true);
			  $('#purchcost').attr('readonly',true);
			  $('#downpytper').attr('readonly',true);
			  $('#interestper').attr('readonly',true);
			  $('#creditper').attr('readonly',true);
			  $('#authority').attr('readonly', true);
			  $('#authority').attr('disabled',true);
			  $('#profitper').attr('readonly', true);
			  $('#overheadper').attr('readonly', true);
			  $('#others').attr('readonly', true);
			  $('#discount').attr('readonly', true);
		  	}
		  	
		}       
	  
	  function funLoadCalculation(){
		  if(document.getElementById("srno").value==""){
		    	 $.messager.alert('warning','Please select a valid document');
		    	 return false;
		     }
		  if($('#frmLeaseCalculator').valid()) { 
			     var dealer=document.getElementById("hiddealer").value;
			     var purchcost=document.getElementById("purchcost").value;
			     var downpytper=document.getElementById("downpytper").value;
			     var interestper=document.getElementById("interestper").value;
			     var creditper=document.getElementById("creditper").value;
			     var authority=document.getElementById("hidauthority").value;
			     var profitper=document.getElementById("profitper").value;
			     var overheadper=document.getElementById("overheadper").value;
			     var others=document.getElementById("others").value;
			     var discount=document.getElementById("discount").value;
			     var leasemonths=document.getElementById("leasemonths").value;
			     var kmpermonth=document.getElementById("kmpermonth").value;
			     var grpid=document.getElementById("grpid").value;
			     var authid=document.getElementById("authid").value;
			     var docno=document.getElementById("docno").value;
			     var leasereqdocno=document.getElementById("leasereqdoc").value;
			     var srno=document.getElementById("srno").value;
				if(purchcost!="" && $.isNumeric(purchcost)==false){
					document.getElementById("errormsg").innerText="Only Numbers allowed";
					document.getElementById("purchcost").focus();
					return false;
				}
				if(downpytper!="" && $.isNumeric(downpytper)==false){
					document.getElementById("errormsg").innerText="Only Numbers allowed";
					document.getElementById("downpytper").focus();
					return false;
				}
				if(interestper!="" && $.isNumeric(interestper)==false){
					document.getElementById("errormsg").innerText="Only Numbers allowed";
					document.getElementById("interestper").focus();
					return false;
				}
				if(creditper!="" && $.isNumeric(creditper)==false){
					document.getElementById("errormsg").innerText="Only Numbers allowed";
					document.getElementById("creditper").focus();
					return false;
				}
				if(profitper!="" && $.isNumeric(profitper)==false){
					document.getElementById("errormsg").innerText="Only Numbers allowed";
					document.getElementById("profitper").focus();
					return false;
				}
				if(overheadper!="" && $.isNumeric(overheadper)==false){
					document.getElementById("errormsg").innerText="Only Numbers allowed";
					document.getElementById("overheadper").focus();
					return false;
				}
				if(others!="" && $.isNumeric(others)==false){
					document.getElementById("errormsg").innerText="Only Numbers allowed";
					document.getElementById("others").focus();
					return false;
				}
				if(discount!="" && $.isNumeric(discount)==false){
					document.getElementById("errormsg").innerText="Only Numbers allowed";
					document.getElementById("discount").focus();
					return false;
				}
				if(downpytper>100){
					document.getElementById("errormsg").innerText="Maximum 100% allowed";
					document.getElementById("downpytper").focus();
					return false;
				}
				if(interestper>100){
					document.getElementById("errormsg").innerText="Maximum 100% allowed";
					document.getElementById("interestper").focus();
					return false;
				}
				if(creditper>100){
					document.getElementById("errormsg").innerText="Maximum 100% allowed";
					document.getElementById("creditper").focus();
					return false;
				}
				if(profitper>100){
					document.getElementById("errormsg").innerText="Maximum 100% allowed";
					document.getElementById("profitper").focus();
					return false;
				}
				if(overheadper>100){
					document.getElementById("errormsg").innerText="Maximum 100% allowed";
					document.getElementById("overheadper").focus();
					return false;
				}
				document.getElementById("errormsg").innerText="";
			     $('#leasecalculatordiv').load('leaseCalculatorGrid.jsp?purchcost='+purchcost+'&downpytper='+downpytper+'&interestper='+interestper+'&creditper='+creditper+'&authority='+authority+'&profitper='+profitper+'&overheadper='+overheadper+'&others='+others+'&discount='+discount+'&leasemonths='+leasemonths+'&kmpermonth='+kmpermonth+'&grpid='+grpid+'&authid='+authid+'&docno='+docno+'&leasereqdocno='+leasereqdocno+'&srno='+srno+'&id=1');
		
		  }
		
	  }
	   
	  $(function(){
		  if(document.getElementById("docno").value!=""){
			  $('#frmLeaseCalculator').validate({
	                 rules: {
	                 purchcost: {
	                	required:true
	                }
	                 },
	                 messages: {
	                	purchcost:{
	                	  required:" *"
	                 }
	                 }
	        });  
		  }
	        
	  });
	  
	  function funDetailSave(){
		  if(document.getElementById("srno").value==""){
			  $.messager.alert('warning','Please select a valid document');
			  return false;
			  
		  }
		  if(document.getElementById("purchcost")==""){
			  $.messager.alert('warning','Purchase cost is mandatory');
			  return false;
			  
		  }
		  var rows=$('#jqxleasecalculator').jqxGrid('getrows');
		  if(rows.length==0){
			  $.messager.alert('warning','Please Calculate');
			  return false;
		  }
		   var dealer=document.getElementById("hiddealer").value;
		     var purchcost=document.getElementById("purchcost").value;
		     var downpytper=document.getElementById("downpytper").value;
		     var interestper=document.getElementById("interestper").value;
		     var creditper=document.getElementById("creditper").value;
		     var authority=document.getElementById("hidauthority").value;
		     var profitper=document.getElementById("profitper").value;
		     var overheadper=document.getElementById("overheadper").value;
		     var others=document.getElementById("others").value;
		     var discount=document.getElementById("discount").value;
		     
		     var docno=document.getElementById("docno").value;
		     var leasereqdocno=document.getElementById("leasereqdoc").value;
		     var srno=document.getElementById("srno").value;
		     var totalvalue=document.getElementById("totalvalue").value;
		  	saveDetail(dealer,purchcost,downpytper,interestper,creditper,authority,profitper,overheadper,others,discount,docno,leasereqdocno,srno,totalvalue);
	  }
	  function saveDetail(dealer,purchcost,downpytper,interestper,creditper,authority,profitper,overheadper,others,discount,docno,leasereqdocno,srno,totalvalue){
		  var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText.trim();
					if(items=="1"){
						$.messager.alert('message','Successfully Saved');
						document.getElementById("btncalculate").style.display="none";
						  document.getElementById("btnleasesave").style.display="none";
						  document.getElementById("btncalculate").disabled=true;
						  document.getElementById("btnleasesave").disabled=true;
						  document.getElementById("btnconfirm").style.display="block";
						  $('#dealer').attr('readonly', true);
						  $('#dealer').attr('disabled',true);
						  $('#purchcost').attr('readonly',true);
						  $('#downpytper').attr('readonly',true);
						  $('#interestper').attr('readonly',true);
						  $('#creditper').attr('readonly',true);
						  $('#authority').attr('readonly', true);
						  $('#authority').attr('disabled',true);
						  $('#profitper').attr('readonly', true);
						  $('#overheadper').attr('readonly', true);
						  $('#others').attr('readonly', true);
						  $('#discount').attr('readonly', true);
						  $('#btnleaseedit').text('Edit');
						  $('#leasereqdiv').load('leaseReqGrid.jsp?reqdocno='+document.getElementById("leasereqdoc").value+'&docno='+document.getElementById("docno").value+'&id=1');
					}
					else{
						$.messager.alert('message','Not Saved');
					}
					}
				else {
					
				}
			}
			x.open("GET", "detailSave.jsp?dealer="+dealer+"&purchcost="+purchcost+"&downpytper="+downpytper+"&interestper="+interestper+"&creditper="+creditper+"&authority="+authority+"&profitper="+profitper+"&overheadper="+overheadper+"&others="+others+"&discount="+discount+"&docno="+docno+"&leasereqdocno="+leasereqdocno+"&srno="+srno+"&totalvalue="+totalvalue, true);
			x.send();
	  }
	  
	  function funLeaseEdit(){
		  var  text=$('#btnleaseedit').text();
		  if(text=="Edit"){
			  document.getElementById("btncalculate").style.display="block";
			  document.getElementById("btnleasesave").style.display="block";
			  document.getElementById("btncalculate").disabled=false;
			  document.getElementById("btnleasesave").disabled=false;
			  $('#dealer').attr('readonly', true);
			  $('#dealer').attr('disabled',false);
			  $('#purchcost').attr('readonly',false);
			  $('#downpytper').attr('readonly',false);
			  $('#interestper').attr('readonly',false);
			  $('#creditper').attr('readonly',false);
			  $('#authority').attr('readonly', true);
			  $('#authority').attr('disabled',false);
			  $('#profitper').attr('readonly', false);
			  $('#overheadper').attr('readonly', false);
			  $('#others').attr('readonly', false);
			  $('#discount').attr('readonly', false);
			  $('#btnleaseedit').text('Cancel');
		  }
		  else if(text=="Cancel"){
			  document.getElementById("btncalculate").style.display="none";
			  document.getElementById("btnleasesave").style.display="none";
			  document.getElementById("btncalculate").disabled=true;
			  document.getElementById("btnleasesave").disabled=true;
			  $('#dealer').attr('readonly', true);
			  $('#dealer').attr('disabled',true);
			  $('#purchcost').attr('readonly',true);
			  $('#downpytper').attr('readonly',true);
			  $('#interestper').attr('readonly',true);
			  $('#creditper').attr('readonly',true);
			  $('#authority').attr('readonly', true);
			  $('#authority').attr('disabled',true);
			  $('#profitper').attr('readonly', true);
			  $('#overheadper').attr('readonly', true);
			  $('#others').attr('readonly', true);
			  $('#discount').attr('readonly', true);
			  $('#btnleaseedit').text('Edit');
		  }

	  }
	  
	  function funConfirm(){
		  var docno=document.getElementById("docno").value;
		  var leasereqdocno=document.getElementById("leasereqdoc").value;
		  var srno=document.getElementById("srno").value;
		  var savestatus=document.getElementById("savestatus").value;
		  var confirmstatus=document.getElementById("confirmstatus").value;
		  
		  if(docno=="" || docno==null || leasereqdocno=="" || leasereqdocno==null || srno=="" || srno==null){
			  $.messager.alert('warning','Please select a valid document');
			  return false;
		  }
		  else{
			  if(savestatus=="0"){
				  $.messager.alert('warning','Please save the document');
				  return false;
			  }
			  if(confirmstatus=="1"){
				  $.messager.alert('warning','Already Confirmed');
				  return false;
			  }
			  confirmStatus(docno,leasereqdocno,srno);
		  }
	  }
	  
	  function confirmStatus(docno,leasereqdocno,srno){
		  var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText.trim();
					if(items=="1"){
						$.messager.alert('message','Successfully Confirmed');
						$('#leasereqdiv').load('leaseReqGrid.jsp?reqdocno='+document.getElementById("leasereqdoc").value+'&docno='+document.getElementById("docno").value+'&id=1');
						document.getElementById("btnleaseedit").style.display="none";
						document.getElementById("btnconfirm").style.display="none";
					}
					else{
						$.messager.alert('message','Not Confirmed');
					}
					}
				else {
					}
			}
			x.open("GET", "confirm.jsp?docno="+docno+"&leasereqdocno="+leasereqdocno+"&srno="+srno, true);
			x.send();
	  }
	  
	  function funPrintBtn() {
			var url=document.URL;
			var reurl="";
			if(document.getElementById("submitstatus").value=="1"){
				reurl=url.split("saveLeaseCalculator");
			}
			else{
				reurl=url.split("leaseCalculator.jsp");
			}
			
			var branch='<%=request.getParameter("branch")%>'; 
		    var win= window.open(reurl[0]+"printLeaseCalculator1?docno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
		    win.focus();
	  }
	  
</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">

<form id="frmLeaseCalculator" action="saveLeaseCalculator1" >
<jsp:include page="../../../../header.jsp"></jsp:include><br/>
<div class="hidden-scrollbar">
<fieldset>
<table width="100%">
  <tr>
    <td width="3%" align="right">Date</td>
    <td width="11%"><div id="date" name="date" value='<s:property value="date"/>'></div></td>
    <td width="10%" align="right">Lease Req Doc</td>
    <td width="12%"><input type="text" id="leasereqdoc" name="leasereqdoc" value='<s:property value="leasereqdoc"/>' placeholder="Press F3 to Search" onkeydown="getLeaseReq(event);"/></td>
    <td width="7%" align="right">Client</td>
    <td width="21%" align="left"><input type="text" name="leasereqclient" id="leasereqclient" style="width:99%;" readonly value='<s:property value="leasereqclient"/>'></td>
    <td width="17%" align="left"><input type="text" name="clientmob" id="clientmob" readonly value='<s:property value="clientmob"/>'></td>
    <td width="7%" align="right">Doc No</td>
    <td width="12%"><input type="text" id="docno" name="docno" value='<s:property value="docno"/>'/></td>
  </tr>
</table>
 </fieldset><br/>
 <table width="100%"><tr><td><div id="leasereqdiv"><jsp:include page="leaseReqGrid.jsp"></jsp:include></div></td></tr></table>
 <%-- <fieldset>
 <table width="100%">
  <tr>
    <td width="7%" align="right">Dealer</td>
    <td width="14%"><input type="text" id="txtdealer" name="txtdealer" value='<s:property value="txtdealer"/>'/></td>
    <td width="10%" align="right">Purchase Cost</td>
    <td width="18%"><input type="text" id="txtpurchasecost" name="txtpurchasecost" style="text-align: right;" value='<s:property value="txtpurchasecost"/>'/></td>
    <td width="9%" align="right">Insurance Comp.</td>
    <td width="16%"><input type="text" id="txtinsurancecomp" name="txtinsurancecomp" placeholder="Press F3 to Search" value='<s:property value="txtinsurancecomp"/>'/></td>
    <td width="10%" align="right">Insurance %</td>
    <td width="17%"><input type="text" id="txtinsuranceperc" name="txtinsuranceperc" style="text-align: right;" value='<s:property value="txtinsuranceperc"/>'/></td>
  </tr>
  <tr>
    <td align="right">Bank Interest %</td>
    <td><input type="text" id="txtbankinterest" name="txtbankinterest" style="text-align: right;" value='<s:property value="txtbankinterest"/>'/></td>
    <td align="right">Overhead</td>
    <td><input type="text" id="txtoverhead" name="txtoverhead" style="text-align: right;" value='<s:property value="txtoverhead"/>'/></td>
    <td align="right">Credit Card Charges</td>
    <td><input type="text" id="txtcreditcardcharges" name="txtcreditcardcharges" style="text-align: right;" value='<s:property value="txtcreditcardcharges"/>'/></td>
    <td align="right">Downpayment Amount</td>
    <td><input type="text" id="txtdownpayamount" name="txtdownpayamount" style="text-align: right;" value='<s:property value="txtdownpayamount"/>'/></td>
  </tr>
</table>
 </fieldset> --%>
 <div style="padding-top:5px;padding-bottom:5px;text-align:center;color:red;font-weight:bold;"><label id="lblvehicle" name="lblvehicle"></label></div>
 <fieldset>
 <table width="100%">
   <tr>
     <td>Dealer</td>
     <td>Purchase Cost</td>
     <td>Down Payment %</td>
     <td>Interest %</td>
     <td>Credit Card %</td>
     <td>Authority</td>
     <td>Profit %</td>
     <td>Over head %</td>
   </tr>
   <tr>
     <td><input type="text" id="dealer" name="dealer" value='<s:property value="dealer"/>' onkeydown="getDealer(event);" placeholder="Press F3 to Search" readonly/></td>
     <td><input type="text" id="purchcost" name="purchcost" value='<s:property value="purchcost"/>'/></td>
     <td><input type="text" id="downpytper" name="downpytper" value='<s:property value="downpytper"/>'/></td>
     <td><input type="text" id="interestper" name="interestper" value='<s:property value="interestper"/>'/></td>
     <td><input type="text" id="creditper" name="creditper" value='<s:property value="creditper"/>'/></td>
     <td><input type="text" id="authority" name="authority" value='<s:property value="authority"/>' onkeydown="getAuthority(event);" placeholder="Press F3 to Search" readonly/></td>
     <td><input type="text" id="profitper" name="profitper" value='<s:property value="profitper"/>'/></td>
     <td><input type="text" id="overheadper" name="overheadper" value='<s:property value="overheadper"/>'/></td>
   </tr>
   <tr>
     <td>Others</td>
     <td>Discount</td>
     <td>&nbsp;</td>
     <td rowspan="2" align="center"><button type="button" name="btnleaseedit" id="btnleaseedit" class="myButton" onclick="funLeaseEdit();">Edit</button></td>
     <td rowspan="2" align="center"><button type="button" name="btncalculate" id="btncalculate" class="myButton" onclick="funLoadCalculation();">Calculate</button></td>
     <td rowspan="2" align="center"><button type="button" name="btnleasesave" id="btnleasesave" class="myButton" onclick="funDetailSave();">Save</button></td>
     <td rowspan="2" align="center"><button type="button" name="btnconfirm" id="btnconfirm" class="myButton" onclick="funConfirm();">Confirm</button></td>
     <td>&nbsp;</td>
   </tr>
   <tr>
     <td><input type="text" id="others" name="others" value='<s:property value="others"/>'/></td>
     <td><input type="text" id="discount" name="discount" value='<s:property value="discount"/>'/></td>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
   </tr>
 </table>
 </fieldset>
 <br/>
 
<div id="leasecalculatordiv"><jsp:include page="leaseCalculatorGrid.jsp"></jsp:include></div>
 
<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="hidleasereqdoc" name="hidleasereqdoc"  value='<s:property value="hidleasereqdoc"/>'/>
<input type="hidden" id="reqgridlength" name="reqgridlength" value='<s:property value="reqgridlength"/>'/>
<input type="hidden" id="hiddealer" name="hiddealer" value='<s:property value="hiddealer"/>'/>
<input type="hidden" id="hidauthority" name="hidauthority" value='<s:property value="hidauthority"/>'/>
<input type="hidden" id="authid" name="authid" value='<s:property value="authid"/>'/>
<input type="hidden" id="leasemonths" name="leasemonths" value='<s:property value="leasemonths"/>'/>
<input type="hidden" id="kmpermonth" name="kmpermonth" value='<s:property value="kmpermonth"/>'/>
<input type="hidden" id="grpid" name="grpid" value='<s:property value="grpid"/>'/>
<input type="hidden" id="srno" name="srno" value='<s:property value="srno"/>'/>
<input type="hidden" id="totalvalue" name="totalvalue" value='<s:property value="totalvalue"/>'/>
<input type="hidden" id="savestatus" name="savestatus" value='<s:property value="savestatus"/>'/>
<input type="hidden" id="submitstatus" name="submitstatus" value='<s:property value="submitstatus"/>'/>
<input type="hidden" id="confirmstatus" name="confirmstatus" value='<s:property value="confirmstatus"/>'/>
</div>
<div id="reqsearchwindow">
<div></div>
</div>
<div id="dealerWindow">
<div></div>
</div>
<div id="authoritywindow">
<div></div>
</div>
</form>
</div>
</body>
</html>