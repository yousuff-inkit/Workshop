<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<!-- <link href="../../../../css/body.css" rel="stylesheet" type="text/css"> -->
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <link rel="stylesheet" type="text/css" href="../../../../css/body.css"> 
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
.hidden-scrollbar {
    overflow: auto;
    height: 500px;
}
.fullwidth{
	width:99%;
}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		$("#outdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		$("#duedate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		$("#outtime").jqxDateTimeInput({ width: '80%', height: '17px', formatString: 'HH:mm', showCalendarButton: false ,value:null});
		$("#duetime").jqxDateTimeInput({ width: '80%', height: '17px', formatString: 'HH:mm', showCalendarButton: false ,value:null});
	
	    $('#vehinfowindow').jqxWindow({ width: '62%', height: '67%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Fleet Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
  	    $('#vehinfowindow').jqxWindow('close');
		 
  	    $('#clientinfowindow').jqxWindow({ width: '62%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Client Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
        $('#clientinfowindow').jqxWindow('close'); 
        
  	    $('#driverinfowindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '62%' ,maxWidth: '50%' , title: 'Driver Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	    $('#driverinfowindow').jqxWindow('close');
	
	    $('#cardwindow').jqxWindow({ width: '30%', height: '53%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Card Search' ,position: { x: 650, y: 150 }, keyboardCloseKey: 27});
		$('#cardwindow').jqxWindow('close');
		
		$('#cldocno').dblclick(function(){
	  	    $('#clientinfowindow').jqxWindow('open');
	  	    $('#clientinfowindow').jqxWindow('focus');
		  	clieninfoSearchContent('clientINgridsearch.jsp?', $('#clientinfowindow')); 
		}); 
		
	    $('#fleetno').dblclick(function(){
			$('#vehinfowindow').jqxWindow('open');
            $('#vehinfowindow').jqxWindow('focus');
            vehinfoSearchContent('vehinfo.jsp?', $('#vehinfowindow'));
        });
	    
	    
	});
	
	function cardSearchContent(url) {
    	$.get(url).done(function (data) {
      		$('#cardwindow').jqxWindow('open');
      		$('#cardwindow').jqxWindow('setContent', data);
      	}); 
    } 
	
	function driverinfoSearchContent(url) {
		$.get(url).done(function (data) {
	    	$('#driverinfowindow').jqxWindow('open');
	       	$('#driverinfowindow').jqxWindow('setContent', data);
	    }); 
	}
	
	
	function funReadOnly(){
		$('#frmRentalAgmtEMC input').attr('readonly',true);
		$('#frmRentalAgmtEMC select').attr('disabled',true);
		$('#date,#outdate,#duedate,#outtime,#duetime').jqxDateTimeInput({ disabled: true});
		
	}
	
	function funNotify(){
		
		if($('#cldocno').val()==''){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Client is Mandatory";
			return 0;
		}
		if($('#fleetno').val()==''){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Client is Mandatory";
			return 0;
		}
		if($('#outdate').jqxDateTimeInput('getDate')==null){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Out Date is Mandatory";
			return 0;
		}
		if($('#outtime').jqxDateTimeInput('getDate')==null){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Out Time is Mandatory";
			return 0;
		}
		if($('#courtesydays').val()==''){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Courtesy is Mandatory";
			return 0;
		}
		if($('#rate').val()==''){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Rate is Mandatory";
			return 0;
		}
		var rows = $("#jqxgrid2").jqxGrid('getrows');
	    var aa=0;
	    for(var i=0;i<rows.length;i++){
	 
		   if(parseInt(rows[i].dr_id1)>0)
			   {
			   aa=1;
			   break;
			   }
		   else{
			   
			   aa=0;
		       } 
	   }
	   
	   if(parseInt(aa)==0)
		   {
		   
			document.getElementById("errormsg").innerText=" Select Driver";
		   
		   return 0;
		   
		   }
	   else
		   {
		   document.getElementById("errormsg").innerText="";
		   }
	   
		var rows = $("#jqxgrid2").jqxGrid('getrows');
	    $('#drivergridlength').val(rows.length);
	   	for(var i=0;i<rows.length;i++){
/* 	   		if(parseInt(rows[i].dr_id1)>0)
			   {

			   } */
	    	newTextBox = $(document.createElement("input"))
	       		.attr("type", "dil")
	       		.attr("id", "drvtest"+i)
	       		.attr("name", "drvtest"+i)
	        	.attr("hidden", "true");  
	    
	   		newTextBox.val(rows[i].dr_id1+" :: ");
			newTextBox.appendTo('form');
	   	}
		
		var rows = $("#jqxgridpayment").jqxGrid('getrows');
		var cardnum="";
		var cardtype="";
		for(var i=0 ; i < rows.length ; i++){
			if(rows[i].mode=="CARD"||rows[i].mode=="CASH")
 			{
		 	    if(rows[i].amount==""||rows[i].amount=="0.00"||typeof(rows[i].amount)=="undefined"||typeof(rows[i].amount)=="NaN")
 				{
					document.getElementById("errormsg").innerText="Enter Amount In   "+rows[i].payment;  
	    			return 0;
				}
 			} 
  	     	if(rows[i].mode=="CARD")
			{
				cardtype=rows[i].card;
				cardnum=rows[i].cardno;
				
					if(cardtype==""||typeof(cardtype)=="undefined"||typeof(cardtype)=="NaN")
					{
						document.getElementById("errormsg").innerText="Select Card Type In "+rows[i].payment;  
			    		return 0;
					}
				 	else{
					}
				
					if(cardnum==""||typeof(cardnum)=="undefined"||typeof(cardnum)=="NaN")
					{
						document.getElementById("errormsg").innerText="Enter Card NO In  "+rows[i].payment;  
				    	return 0;
					}
				else
					{
					
					}
		
			}
				
	}
		
		  var rows = $("#jqxgridpayment").jqxGrid('getrows');
		  $('#paymentgridlength').val(rows.length);
		  for(var i=0 ; i < rows.length ; i++){
		  newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "paytest"+i)
		       .attr("name", "paytest"+i)
		        .attr("hidden", "true");
		   
		    newTextBox.val(rows[i].payment+"::"+rows[i].mode+" :: "+rows[i].amount+" :: "
					   +rows[i].acode+" :: "+rows[i].cardno+" :: "+rows[i].hidexpdate+" :: "+rows[i].card+" :: "+rows[i].cardtype+" :: "+rows[i].paytype+" :: "
					   +rows[i].invno+" :: "+rows[i].status+" :: ");
		 
		   newTextBox.appendTo('form');
		  
		    
		   }   
		return 1;
	}
	
	function funRemoveReadOnly(){
		$('#frmRentalAgmtEMC input').attr('readonly',false);
		$('#frmRentalAgmtEMC select').attr('disabled',false);
		$('#date,#outdate,#duedate,#outtime,#duetime').jqxDateTimeInput({ disabled: false});
		$('#jqxgridpayment,#jqxgrid2').jqxGrid({disabled:false});
		if($('#mode').val()=='A'){
			$('#date,#outdate,#duedate,#outtime,#duetime').jqxDateTimeInput('setDate',new Date());
			$("#jqxgrid2,#jqxgridpayment").jqxGrid('clear');
		    $("#jqxgrid2").jqxGrid('addrow', null, {});
		    $("#jqxgrid2").jqxGrid('addrow', null, {});
		    $("#divpaymentGrid").load("paymentGrid.jsp");
		    $("#jqxgrid2").jqxGrid({ disabled: false});
		    $("#jqxgridpayment").jqxGrid({ disabled: false});
		    $("#paymentdiv").load("paymentGrid.jsp");
		    
		    //Tracker Km Update
		    
		    var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					items = x.responseText;
					items=items.trim();
					//alert(items);
					/* if(parseInt(items)>0){
						$('#docno').val(parseInt(items));
						$('#overlay,PleaseWait').show();
						$('#gpsdiv').load('gpsGrid.jsp?docno='+items+'&id=1');
					}
					else{
						$.messager.alert('Warning','Download Not Completed');
						return false;
					} */
					} else {
				}
			}
			x.open("GET", "updateTrackerKm.jsp", true);
			x.send();
			
		}
	}
	
	function funFocus(){
		document.getElementById("cldocno").focus();
	}
	
	function setValues(){
		funSetlabel(); 
		if($('#msg').val()!=""){
  		   $.messager.alert('Message',$('#msg').val());
  		}
		$('#frmRentalAgmtEMC select').attr('disabled',false);
		$('#date,#outdate,#duedate,#outtime,#duetime').jqxDateTimeInput({ disabled: false});
		$('#jqxgridpayment,#jqxgrid2').jqxGrid({disabled:false});
		
		if($('#hidoutttime').val()!=''){
			$('#outtime').jqxDateTimeInput('val',$('#hidouttime').val());
		}
		if($('#hidcmboutfuel').val()!=''){
			$('#cmboutfuel').val($('#hidcmboutfuel').val());
		}
		if($('#hidduetime').val()!=''){
			$('#duetime').jqxDateTimeInput('val',$('#hidduetime').val());
		}
		if($('#docno').val()!='' && $('#docno').val()!='0'){
			$("#driverdiv").load("driverGrid.jsp?txtrentaldocno1="+$('#docno').val());
       		$("#paymentdiv").load("paymentGrid.jsp?txtrentaldoc="+$('#docno').val());
		}
		$('#frmRentalAgmtEMC select').attr('disabled',true);
		$('#date,#outdate,#duedate,#outtime,#duetime').jqxDateTimeInput({ disabled: true});
		$('#jqxgridpayment,#jqxgrid2').jqxGrid({disabled:true});
	}
	
	function funSearchLoad(){
		changeContent('masterSearch.jsp', $('#window'));
	}
	
	function funPrintBtn() {
    	if(document.getElementById("docno").value=='' || document.getElementById("docno").value=='0'){
    		 $.messager.alert('Warning','Select a Document');
    		 return false;
    	}
    	var url=document.URL;
    	var reurl=url.split("saveRentalAgmtEMC");
    	var win= window.open(reurl[0]+"printRAEMC?docno="+document.getElementById("docno").value+"&formdetailcode=RAC","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
    	win.focus();
    }
	
	
    function getvehinfo(event){
   		var x= event.keyCode;
   	 	if(x==114){
   	 		$('#vehinfowindow').jqxWindow('open');
   			vehinfoSearchContent('vehinfo.jsp?', $('#vehinfowindow'));  	 
   		}
   	 	else{
   		}
   	}
      
	function vehinfoSearchContent(url) {
		$.get(url).done(function (data) {
	    	$('#vehinfowindow').jqxWindow('setContent', data);
	    }); 
	}
	
	
	function getclientinfo(event){
 		var x= event.keyCode;
 	    if(x==114){
 	    	$('#clientinfowindow').jqxWindow('open');
 	        clieninfoSearchContent('clientINgridsearch.jsp?', $('#clientinfowindow'));
 	    }
 	    else{
 	    }
 	}
 	 
    function clieninfoSearchContent(url) {
    	$.get(url).done(function (data) {
    		$('#clientinfowindow').jqxWindow('setContent', data);
    	}); 
    }

    function isNumber(evt,id) {
		//Function to restrict characters and enter number only
			  var iKeyCode = (evt.which) ? evt.which : evt.keyCode
		        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
		         {
		        	 $.messager.alert('Warning','Enter Numbers Only');
		           $("#"+id+"").focus();
		            return false;
		            
		         }
		        
		        return true;
	}
    
    function setDueDate(value){
    	if($('#outdate').jqxDateTimeInput('getDate')==null){
    		$.messager.alert('warning','Please Select Out Date');
    		return false;
    	}
    	else{
        	var outdate=new Date($('#outdate').jqxDateTimeInput('getDate'));
    	    var duedate=new Date(outdate.setDate(outdate.getDate()+(parseInt(value))));
    	    $('#duedate').jqxDateTimeInput('setDate',duedate);    		
    	}

    }
</script>
</head>
<body onload="setValues();">
	<div id="mainBG" class="homeContent" data-type="background" >
		<form id="frmRentalAgmtEMC" action="saveRentalAgmtEMC" autocomplete="off">
			<jsp:include page="../../../../header.jsp" />
			<br/> 
			<div class='hidden-scrollbar'>
				<table width="100%" border="0">
				  <tr>
				    <td width="81%">
				    	<fieldset><legend>Document Info</legend>
				            <table width="100%" border="0">
				              <tr>
				                <td width="11%" align="right">Date</td>
				                <td width="16%"><div id="date" name="date" value='<s:property value="date"/>'></div></td>
				                <td width="14%">&nbsp;</td>
				                <td width="13%" align="right">Doc No</td>
				                <td width="11%"><input type="text" name="vocno" id="vocno" value='<s:property value="vocno"/>' readonly tabindex="-1"></td>
				                <td width="12%">&nbsp;</td>
				                <td width="12%">&nbsp;</td>
				                <td width="11%">&nbsp;</td>
				              </tr>
				              <tr>
				                <td align="right">Client</td>
				                <td><input type="text" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>' placeholder="Press F3 to Search" readonly onkeydown="getclientinfo(event);"></td>
				                <td colspan="3"><input type="text" name="clientname" id="clientname" value='<s:property value="clientname"/>' class="fullwidth"></td>
				                <td align="right">Salesman</td>
				                <td colspan="2"><input type="text" name="salesman" id="salesman" value='<s:property value="salesman"/>' style="width:96%;"></td>
				              </tr>
								<input type="hidden" name="hidsalesman" id="hidsalesman" value='<s:property value="hidsalesman"/>'>
				              <tr>
				                <td>&nbsp;</td>
				                <td colspan="7"><input type="text" name="clientdetails" id="clientdetails" value='<s:property value="clientdetails"/>' class="fullwidth"></td>
				              </tr>
				              <tr>
				                <td align="right">Description</td>
				                <td colspan="7"><input type="text" name="description" id="description" value='<s:property value="description"/>' class="fullwidth"></td>
				              </tr>
				            </table>
				      </fieldset>
				    </td>
				    <td width="19%">&nbsp;</td>
				  </tr>
				
				</table>
				<fieldset><legend>Vehicle Out Info</legend>
				    <table width="100%" border="0">
				      <tr>
				        <td width="12%" align="right">Fleet No</td>
				        <td width="14%"><input type="text" name="fleetno" id="fleetno" value='<s:property value="fleetno"/>' onkeydown="getvehinfo(event);" readonly></td>
				        <td colspan="6"><input type="text" name="fleetdetails" id="fleetdetails" value='<s:property value="fleetdetails"/>' class="fullwidth"></td>
				      </tr>
				      <tr>
				        <td align="right">Date</td>
				        <td><div id="outdate" name="outdate" value='<s:property value="outdate"/>'></div></td>
				        <td width="11%" align="right">Time</td>
				        <td width="11%"><div id="outtime" name="outtime" value='<s:property value="outtime"/>'></div></td>
				        
				        <td width="14%" align="right">Km</td>
				        <td width="13%"><input type="text" name="outkm" id="outkm" value='<s:property value="outkm"/>' onkeypress="javascript:return isNumber (event,id)"></td>
				        <td width="12%" align="right">Fuel</td>
				        <td width="13%">
				        	<select name="cmboutfuel" id="cmboutfuel">
				                <option value="">-Select-</option>
				                <option value=0.000>Level 0/8</option>
				                <option value=0.125>Level 1/8</option>
				                <option value=0.250>Level 2/8</option>
				                <option value=0.375>Level 3/8</option>
				                <option value=0.500>Level 4/8</option>
				                <option value=0.625>Level 5/8</option>
				                <option value=0.750>Level 6/8</option>
				                <option value=0.875>Level 7/8</option>
				                <option value=1.000>Level 8/8</option>
				            </select>
				        </td>
				      </tr>
				      <input type="hidden" name="hidouttime" id="hidouttime" value='<s:property value="hidouttime"/>'>
				      <input type="hidden" name="hidcmboutfuel" id="hidcmboutfuel" value='<s:property value="hidcmboutfuel"/>'>
				      
				    </table>
				    </fieldset>
				<fieldset>
				    	<legend>Client Vehicle Info</legend>
				  <table width="100%" border="0">
				              <tr>
				                <td width="12%" align="right">Plate Code</td>
				                <td width="17%"><input type="text" name="platecode" id="platecode" value='<s:property value="platecode"/>'></td>
				                
				                <td width="16%" align="right">Reg No</td>
				                <td width="18%"><input type="text" name="regno" id="regno" value='<s:property value="regno"/>'></td>
				                <td width="16%" align="right">Chassis No</td>
				                <td colspan="3"><input type="text" name="chassisno" id="chassisno" value='<s:property value="chassisno"/>'></td>
				              </tr>
				              <tr>
				                <td align="right">Job Card No</td>
				                <td><input type="text" name="jobcardno" id="jobcardno" value='<s:property value="jobcardno"/>'></td>
				                <td align="right">Remarks</td>
				                <td colspan="5"><input type="text" name="clientvehremarks" id="clientvehremarks" value='<s:property value="clientvehremarks"/>' class="fullwidth"></td>
				              </tr>
				              <input type="hidden" name="hidplatecode" id="hidplatecode" value='<s:property value="hidplatecode"/>'>
				        </table>
				        </fieldset>
				        <fieldset><legend>Driver Details</legend>
				            <table width="100%" border="0">
				              <tr>
				                <td><div id="driverdiv"><jsp:include page="driverGrid.jsp"></jsp:include></div></td>
				              </tr>
				            </table>
				  </fieldset>
				  <fieldset><legend>Rate Info</legend>
				<table width="100%" border="0">
				  <tr>
				    <td width="12%" align="right">Courtesy Days</td>
				    <td width="17%"><input type="text" name="courtesydays" id="courtesydays" value='<s:property value="courtesydays"/>' onkeypress="javascript:return isNumber (event,id)" onblur="setDueDate(value);"></td>
				    <td width="16%" align="right">Rate/Day</td>
				    <td width="12%"><input type="text" name="rate" id="rate" value='<s:property value="rate"/>' style="text-align:right;" onkeypress="javascript:return isNumber (event,id)" onblur="funRoundAmt(value,id);"></td>
				    <td width="37%">&nbsp;</td>
				    <td width="6%">&nbsp;</td>
				  </tr>
				  <tr>
				    <td align="right">Due Date</td>
				    <td><div id="duedate" name="duedate" value='<s:property value="duedate"/>'></div></td>
				    <td align="right">Time</td>
				    <td><div id="duetime" name="duetime" value='<s:property value="duetime"/>'></div></td>
				    <td>&nbsp;</td>
				    <td>&nbsp;</td>
				  </tr>
					<input type="hidden" name="hidduetime" id="hidduetime" value='<s:property value="hidduetime"/>' >
				</table>
				</fieldset>
				<fieldset><legend>Payment Info</legend>
				  	<table width="100%" border="0">
				  	  <tr>
				  	    <td><div id="paymentdiv"><jsp:include page="paymentGrid.jsp"></jsp:include></div></td>
				      </tr>
				</table>
				</fieldset>
			</div>
<input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>' >
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
<input type="hidden" name="clientacno" id="clientacno" value='<s:property value="clientacno"/>'>
<div id="movdin" name="movdin" value='<s:property value="movdin"/>' hidden="true"></div>
<div id="movtin" name="movtin" value='<s:property value="movtin"/>' hidden="true"></div>
<input type="hidden" name="movkmin" id="movkmin" value='<s:property value="movkmin"/>'>
<input type="hidden" name="movfin" id="movfin" value='<s:property value="movfin"/>'>
<input type="hidden" id="paymentgridlength" name="paymentgridlength"/> 
<input type="hidden" id="drivergridlength" name="drivergridlength"/>
<div id="vehinfowindow">
   <div ></div>
</div> 
 <div id="clientinfowindow">
   <div ></div>
</div>
<!-- <div id="Driverdlswindow">
   <div ></div>
</div>  -->
<div id="driverinfowindow">
   <div ></div>
</div>
<div id="cardwindow">
   <div ></div>
</div>
		</form>
		
	</div>

</body>
</html>