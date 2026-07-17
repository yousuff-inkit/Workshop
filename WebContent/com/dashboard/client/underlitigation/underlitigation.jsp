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
<script type="text/javascript">

	$(document).ready(function () {
		   $('#clientwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search'  , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
		   $('#clientwindow').jqxWindow('close');
		  
		   $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
		   $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	
		   $("#disputeDate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		
		   $("#underdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		   $('#clientname').dblclick(function(){
		  	    
		   $('#clientwindow').jqxWindow('open');
		       		clientSearchContent('clientsearch.jsp', $('#clientwindow')); 
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

	function funExportBtn(){
	   $("#undergrid").jqxGrid('exportdata', 'xls', 'Under Litigation');
	 }

	function getinfo() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			items = items.split('####');
			var srno  = items[0].split(",");
			var process = items[1].split(",");
			var optionsbranch = '<option value="" selected>-- Select -- </option>';
			for (var i = 0; i < process.length; i++) {
				optionsbranch += '<option value="' + srno[i].trim() + '">'
						+ process[i] + '</option>';
			}
			$("select#cmbinfo").html(optionsbranch);	
		} else { }
	}
	x.open("GET","getinfo.jsp", true);
	x.send();
	}
	
	function funreload(event) {
	 	var barchval = document.getElementById("cmbbranch").value;
	 	var aa="yes";
	 
	 	$("#duedetailsgrid").jqxGrid('clear');
	   	$("#overlay, #PleaseWait").show();
	  	$("#rtaupdiv").load("underlitigationGrid.jsp?barchval="+barchval+"&chk="+aa);
	}

	function funupdate() {
	
	 	if(document.getElementById("cmbinfo").value=="") {
		 	$.messager.alert('Message','Select Process ','warning');   
			return 0;
	    }
	
	 	if($('#remarks').val()=="") {
		 	$.messager.alert('Message','Enter Remarks ','warning');   
		 	return 0;
	 	}
	 	
	 	var remarkss = document.getElementById("remarks").value;
	 	var nmax = remarkss.length;
      	if(nmax>99) {
   	  		$.messager.alert('Message',' Remarks cannot contain more than 100 characters ','warning');   
			return false; 
   	   }
      	
/*    	  document.getElementById("disdoc").value=$('#undergrid').jqxGrid('getcellvalue', rowindex1, "disdoc"); 
	  document.getElementById("choice").value=$('#undergrid').jqxGrid('getcellvalue', rowindex1, "choice"); 
	  
	   */
		
	   var disdoc = document.getElementById("disdoc").value;
	   var choice = document.getElementById("choice").value;
	   var rentaldocno = document.getElementById("rentaldoc").value;
	   var branchids = document.getElementById("branchids").value;
	   var remarks = document.getElementById("remarks").value;
	   var cmbinfo = document.getElementById("cmbinfo").value;
	 
	   var cldocno=document.getElementById("cldocno").value;
	   var underdate =  $('#underdate').val();

	   $.messager.confirm('Message', 'Do you want to save changes?', function(r){
	     	if(r==false) {
	     		return false; 
	     	  }
	     	else{
	     		 savegriddata(rentaldocno,branchids,remarks,cmbinfo,underdate,cldocno,disdoc,choice);	
	     	}
		 });
	}
	
	function savegriddata(rentaldocno,branchids,remarks,cmbinfo,underdate,cldocno,disdoc,choice) {
	
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200) {
			 var items=x.responseText;
			 document.getElementById("rentaldoc").value="";
			 document.getElementById("branchids").value="";
			 document.getElementById("remarks").value="";
			 document.getElementById("cmbinfo").value="";
			 document.getElementById("cldocno").value="";
			 $('#underdate').val(new Date());
			  
			 $.messager.alert('Message', '  Record Successfully Updated ', function(r){
			     
		     });
			 funreload(event); 
			 $("#duedetailsgrid").jqxGrid('clear');     //,disdoc,choice
			 disitems();
			}
	}
		
	x.open("GET","savedata.jsp?rentaldocno="+rentaldocno+"&branchids="+branchids+"&remarks="+remarks+"&cmbinfo="+cmbinfo+"&underdate="+underdate+"&cldocno="+cldocno+"&disdoc="+disdoc+"&choice="+choice,true);
	x.send();
		
	}


	function disitems() { 
		$('#underdate').jqxDateTimeInput({ disabled: true});

		$('#cmbinfo').attr("disabled",true);
		$('#remarks').attr("readonly",true);
		$('#driverUpdate').attr("disabled",true);
		$('#disputeDate').jqxDateTimeInput({ disabled: true});
		$('#caseno').attr("disabled",true);
		$('#station').attr("disabled",true);
		$('#value').attr("disabled",true);
		$('#casenote').attr("disabled",true); 
		$('#cmbchangestatus').attr("disabled",true);
		$('#driverUpdates').attr("disabled",true); 	
		$('#clientname').attr('placeholder', 'Press F3 To Search'); 
		document.getElementById("clientname").value="";
	}

	function funchangeinfo() {
		 $('#underdate').jqxDateTimeInput( 'focus');
	}
	
	function funupdatess() {
	
	 if(document.getElementById("cmbchangestatus").value=="") {
			 $.messager.alert('Message','Choose a Status ','warning');  
			 return 0;
	 }
	
	 if(document.getElementById("cmbchangestatus").value=="1") {
		 
		 if(document.getElementById("caseno").value=="") {
			 $.messager.alert('Message','Enter Case No ','warning');  
			 return 0;
		 }
		 
		 if(document.getElementById("station").value=="") {
			 $.messager.alert('Message','Enter Station ','warning');  
			 return 0;
		 }
		 
		 if(document.getElementById("value").value=="") {
			 $.messager.alert('Message','Enter Value ','warning');  
			 return 0;
		 }
		 
		 if(document.getElementById("casenote").value=="") {
			 $.messager.alert('Message','Enter Note ','warning');  
			 return 0;
		 }
	 }
	 
	 var casenoteval = document.getElementById("casenote").value;
	 var nmax = casenoteval.length;
     if(nmax>199) {
   	       $.messager.alert('Message','Note cannot contain more than 200 characters ','warning');   
		   return false; 
   	 } 
     
     var changestatus = document.getElementById("cmbchangestatus").value;
	 var disputedate =  $('#disputeDate').val();
	 var caseno = document.getElementById("caseno").value;
	 var station = document.getElementById("station").value;
	 var value = document.getElementById("value").value;
	 var casenote = document.getElementById("casenote").value;
	 var cldocno=document.getElementById("cldocno").value;

	    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
            	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		 savegriddatas(changestatus,disputedate,caseno,station,value,casenote,cldocno);	
		     	}
		});
	}
	
	function savegriddatas(changestatus,disputedate,caseno,station,value,casenote,cldocno) {
	
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200) {
			
				 var items=x.responseText;
				 $('#clientname').attr('placeholder', 'Press F3 To Search'); 
				 document.getElementById("clientname").value="";
				 document.getElementById("cmbchangestatus").value="";
				 document.getElementById("caseno").value="";
				 document.getElementById("station").value="";
				 document.getElementById("value").value="";
				 document.getElementById("casenote").value="";
				 document.getElementById("cldocno").value="";
				  $('#disputeDate').val(new Date());
	
				 $.messager.alert('Message', '  Record Successfully Updated ', function(r){
			 		 
			 		 
				     
			     });
				 funreload(event);
				 $("#duedetailsgrid").jqxGrid('clear');
				 disitems();
				}
		}
	x.open("GET","saveclientdata.jsp?changestatus="+changestatus+"&disputedate="+disputedate+"&caseno="+caseno+"&station="+station+"&value="+value+"&casenote="+casenote+"&cldocno="+cldocno,true);
	x.send();
	}
	
	function isNumber(evt) {
    	var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    	if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
    	
    	 	$.messager.alert('Message',' Enter Numbers Only ','warning');  
	        return false;
    	}
    return true;
	}    

</script>
</head>
<body onload="getBranch();getinfo();disitems();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr> <td  align="right"><label class="branch">Process</label></td><td align="left">
 <select name="cmbinfo" id="cmbinfo" style="width:70%;" name="cmbinfo"  value='<s:property value="cmbinfo"/>' onchange="funchangeinfo()">
       

</select></td></tr>
<tr><td  align="right" ><label class="branch">Date</label></td><td align="left"><div id='underdate' name='underdate' value='<s:property value="underdate"/>'></div>
	 <tr><td align="right"><label class="branch">Remarks </label></td><td align="left"><input type="text" id="remarks" style="height:20px;width:88%;" name="remarks"  value='<s:property value="remarks"/>'> </td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td  align="center" colspan="2"><input type="Button" name="driverUpdate" id="driverUpdate" class="myButton" value="UPDATE" onclick="funupdate()"></td> </tr>
			<tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">
	 <div>
	 <fieldset>
	 <legend>Change Status</legend>
	 <table width="100%" >
	 
	 <tr><td align="right"><label class="branch">Client</label></td><td align="left"><input type="text" name="clientname" id="clientname" placeholder="Press F3 To Search" readonly="readonly" onKeyDown="getclinfo(event);" onclick="this.placeholder='' "  style="height:20px;width:90%;" value='<s:property value="clientname"/>'></td></tr>
	 <tr><td align="right"><label class="branch">Status</label></td><td align="left"><select id="cmbchangestatus" style="width:70%;" name="cmbchangestatus"  value='<s:property value="cmbchangestatus"/>'>
	 <option value=''>-- Select --</option><option value='1'>Litigation</option><option value='2'>Dispute</option><option value='3'>Bad Debts</option></select></td></tr>
	 <tr><td  align="right" ><label class="branch">Date</label></td><td align="left"><div id='disputeDate' name='disputeDate' value='<s:property value="disputeDate"/>'></div></td></tr>
	 <tr><td align="right"><label class="branch">Case No </label></td><td align="left"><input type="text" id="caseno" style="height:20px;width:70%;" name="caseno"  value='<s:property value="caseno"/>'> </td></tr>
	 <tr><td align="right"><label class="branch">Station </label></td><td align="left"><input type="text" id="station" style="height:20px;width:70%;" name="station"  value='<s:property value="station"/>'> </td></tr>
	  <tr><td align="right"><label class="branch">Value </label></td><td align="left"><input type="text" id="value" style="height:20px;width:70%;" name="value"  value='<s:property value="value"/>' onkeypress="javascript:return isNumber (event)" > </td></tr>
	 <tr><td align="right" ><label class="branch">Note</label></td><td align="left"><input type="text" id="casenote" style="height:20px;width:88%;" name="casenote"  value='<s:property value="casenote"/>'> </td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td  align="center" colspan="2"><input type="Button" name="driverUpdates" id="driverUpdates" class="myButton" value="UPDATE" onclick="funupdatess()"></td> </tr>
	 </table>
	 </fieldset>
	 </div>
	</td></tr> 
  </table>
  </fieldset>
    	  
<input type="hidden" name="disdoc" id="disdoc" style="height:20px;width:70%;" value='<s:property value="disdoc"/>' >
<input type="hidden" name="choice" id="choice" style="height:20px;width:70%;" value='<s:property value="choice"/>' >
<input type="hidden" name="branchids" id="branchids" style="height:20px;width:70%;" value='<s:property value="branchids"/>' >
<input type="hidden" name="rentaldoc" id="rentaldoc" style="height:20px;width:70%;" value='<s:property value="rentaldoc"/>' >
<input type="hidden" name="cldocno" id="cldocno" style="height:20px;width:70%;" value='<s:property value="cldocno"/>' >
</td>
<td width="80%">
	<table width="100%">
		<tr><td><div id="rtaupdiv"><jsp:include page="underlitigationGrid.jsp"></jsp:include></div></td> </tr>
		<tr><td colspan="2" align="left" ><div id="detaildiv"><jsp:include page="followDetailgrid.jsp"></jsp:include></div></td></tr>
	</table>
</tr>
</table>
</div>
<div id="clientwindow">
   <div></div>
</div>
</div>
</body>
