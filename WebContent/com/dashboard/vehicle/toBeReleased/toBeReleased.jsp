
 <jsp:include page="../../../../includes.jsp"></jsp:include>
<%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%> 

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<script type="text/javascript">
$(document).ready(function () {
	
	document.getElementById("dashfleetwarning").style.display="none";
	document.getElementById("dashbtnrelease").disabled=true;
	document.getElementById("dashreleasefuel").disabled=true;
	document.getElementById("btnvehicle").disabled=true;
	document.getElementById("btnattach").disabled=true;
	 $("#dashreleasedate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#dashreleasetime").jqxDateTimeInput({ width: '20%', height: '17px', formatString: 'HH:mm', showCalendarButton: false ,value: new Date()});
	/*  $('#vehiclewindow').jqxWindow({ autoOpen: false,width: '80%', height: '70%',  maxHeight: '70%' ,maxWidth: '80%' , title: 'Vehicle Details' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27, showCloseButton: true,closeButtonAction:'hide'});
	   $('#vehiclewindow').jqxWindow('close'); */
	 /*   $('#clientWindow').jqxWindow({ autoOpen: false,width: '78%', height: '85%',  maxHeight: '85%' ,maxWidth: '78%' , title: 'Client Details' , theme: 'energyblue', position: { x: 280, y: 10 }, keyboardCloseKey: 27, showCloseButton: true,closeButtonAction:'hide'});
	   $('#clientWindow').jqxWindow('close'); */
	   $('#vehiclewindow').jqxWindow({width: '80%', height: '70%',  maxHeight: '80%' ,maxWidth: '90%' , title: 'Vehicle Details',position: { x: 250, y: 60} , theme: 'energyblue', showCloseButton: true,closeButtonAction:'hide'});
	   $('#vehiclewindow').jqxWindow('close');
	 
	   $('#clientAttachWindow').jqxWindow({autoOpen: false,width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Attach',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
	   $('#clientAttachWindow').jqxWindow('close');
	   $('input[type=text]').val('');
	   $('select').find('option').prop("selected", false);
	 $.jqx._jqxDateTimeInput.getDateTime(new Date());
getBrch();	
getTestLocation(); 
});
function funExportBtn(){
	 //$("#toBeReleasedGrid").jqxGrid('exportdata', 'xls', 'ToBeReleased');

   
	   if(parseInt(window.parent.chkexportdata.value)=="1")
	    {
	    JSONToCSVCon(datarelease, 'ToBeReleased', true);
	    }
	   else
	    {
		   $("#toBeReleasedGrid").jqxGrid('exportdata', 'xls', 'ToBeReleased');
	    }
	   
	   



}
function getTestLocation(){
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	items= x.responseText;
					//alert(items);
			 	items=items.split('***');
		        var locationItems=items[0].split(",");
		        var locationidItems=items[1].split(",");
		        	var optionslocation = '<option value="">--Select--</option>';
		       for ( var i = 0; i < locationItems.length; i++) {
		    	   optionslocation += '<option value="' + locationidItems[i] + '">' + locationItems[i] + '</option>';
		        }
		       $("select#dashcmbrlsloc").html(optionslocation);
			   //	$('#accno').val($('#accnohidden').val()) ;
			   	if ($('#dashhidcmbrlsloc').val() != null) {
			$('#dashcmbrlsloc').val($('#dashhidcmbrlsloc').val());
		}
			}
		else
			{
			}
	}
	x.open("GET","getTestLocation.jsp",true);
	x.send();
//document.write(document.getElementById("authname").value);

}
function getBrch() {
	var x = new XMLHttpRequest();
	var items, brchItems, currItems;
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			items = x.responseText;
			items = items.split('####');
			brchIdItems = items[0].split(",");
			brchItems = items[1].split(",");
			var optionsbrch = '<option value="">--Select--</option>';
			for (var i = 0; i < brchItems.length; i++) {
				optionsbrch += '<option value="' + brchIdItems[i] + '">'
						+ brchItems[i] + '</option>';
			}
			
			$("select#dashcmbrlsbranch").html(optionsbrch);
			if ($('#dashhidcmbrlsbranch').val() != null) {
				$('#dashcmbrlsbranch').val($('#dashhidcmbrlsbranch').val());
			}
		} else {
		}
	}
	x.open("GET", "getBranch.jsp", true);
	x.send();
}
function getLocation(value)
{
	//alert(here);
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	items= x.responseText;
					//alert(items);
			 	items=items.split('***');
		        var locationItems=items[0].split(",");
		        var locationidItems=items[1].split(",");
		        	var optionslocation = '<option value="">--Select--</option>';
		       for ( var i = 0; i < locationItems.length; i++) {
		    	   optionslocation += '<option value="' + locationidItems[i] + '">' + locationItems[i] + '</option>';
		        }
		       $("select#dashcmbrlsloc").html(optionslocation);
			   //	$('#accno').val($('#accnohidden').val()) ;
			   	if ($('#dashhidcmbrlsloc').val() != null) {
			$('#dashcmbrlsloc').val($('#dashhidcmbrlsloc').val());
		}
			}
		else
			{
			}
	}
	x.open("GET","getLocation.jsp?id="+value,true);
	x.send();
//document.write(document.getElementById("authname").value);

}
function funReleaseClick(){
	/* alert("Inside"); */
	document.getElementById("mode").value='R';
	var testfleet=document.getElementById("dashreleasefleet").value;
	var testbranch=document.getElementById("dashcmbrlsbranch").value;
	var testloc=document.getElementById("dashcmbrlsloc").value;
	var testkm=document.getElementById("dashreleasekm").value;
	var testfuel=document.getElementById("dashreleasefuel").value;
	var testdate= $('#dashreleasedate').jqxDateTimeInput('getDate');
	var testtime= $('#dashreleasetime').jqxDateTimeInput('getDate');
	var teststatus=document.getElementById("dashcmbrentalstatus").value;
	if((testfleet=='')||(testbranch=='')||(testloc=='')||(testkm=='')||(testfuel=='')){
		document.getElementById("dashfleetwarning").style.display="block";
		return false;
	}
	else{
		document.getElementById("dashfleetwarning").style.display="none";
		 
		 if(document.getElementById("dashreleasefleet").value<=0){
			 return false;
		 }
			document.getElementById("dashreleasefuel").disabled=false;
		 document.getElementById("frmReleaseDashBoard").submit();
		//funVehRelease(testfleet,testbranch,testloc,testkm,testfuel,testdate,testtime,teststatus);
		
		
	}
	document.getElementById("dashreleasefuel").disabled=true;
}

function setValues(){
	/* if($('#dashhidreleasetime').val()){
		$("#dashreleasetime").jqxDateTimeInput('val', $('#dashhidreleasetime').val());
	}
	/*  if (($('#hidcmbrentalstatus').val() != null)||($('#hidcmbrentalstatus').val() != "")) {
		$('#cmbrentalstatus').val($('#hidcmbrentalstatus').val());
	} 
	//alert("AAA"+$('#hidcmbrentalstatus').val()+"BBB");
	 /* if($('#dashhidreleasedate').val()){
			$("#dashreleasedate").jqxDateTimeInput('val', $('#hidreleasedate').val());
		} 
	 if ($('#dashhidreleasefuel').val() != null) {
			$('#dashreleasefuel').val($('#dashhidreleasefuel').val());
		}
	 if ($('#dashhidcmbrlsbranch').val() != null) {
			$('#dashcmbrlsbranch').val($('#dashhidcmbrlsbranch').val());
		} 
	 if ($('#dashhidcmbrlsloc').val() != null) {
			$('#dashcmbrlsloc').val($('#dashhidcmbrlsloc').val());
		}  */
	
	 if(($('#msg').val()!="")){
		   $.messager.alert('Message',$('#msg').val());
		  }
	/*  if(document.getElementById("cmbbranch").value==''){
			document.getElementById("msg").value="Invalid Branch";
			 $.messager.alert('Message',$('#msg').val());
			 return false;
		} */
	
	  var brchval = document.getElementById("cmbbranch").value;
	    $("#releasediv").load("toBeReleasedGrid.jsp?brchval="+brchval);

}
function funreload(event)
{
	
  var brchval = document.getElementById("cmbbranch").value;
 // var exdate = $('#insuexpdate').val();
 
   $("#releasediv").load("toBeReleasedGrid.jsp?brchval="+brchval);
 
 
 }

function getVehicle(){
	if(document.getElementById("dashreleasefleet").value==""){
		 $.messager.alert('Message',"Please Select Fleet");
		 return false;
	}
	$('#vehiclewindow').jqxWindow('setContent', '');
	$('#vehiclewindow').jqxWindow('open');	
	 vehicleSearchContent("<%=contextPath%>/com/controlcentre/masters/vehicle/saveVehicle1.action?mode=view&fleetno="+document.getElementById("dashreleasefleet").value);
}
function vehicleSearchContent(url) {
	//$('#vehiclewindow').jqxWindow('open');	
	$('#vehiclewindow').jqxWindow('focus');	
	$.get(url).done(function (data) {
$('#vehiclewindow').jqxWindow('setContent', data);
}); 
}
function getAttach(){
	if(document.getElementById("dashreleasefleet").value==""){
		 $.messager.alert('Message',"Please Select Fleet");
		 return false;
	}
	changeClientAttachContent("<%=contextPath%>/com/common/attachGrid.jsp?formCode=VEH&docno="+document.getElementById("docno").value);  

}
function changeClientAttachContent(url) {
	   $.get(url).done(function (data) {
	        $('#clientAttachWindow').jqxWindow('open');
	     $('#clientAttachWindow').jqxWindow('setContent',data);
	     $('#clientAttachWindow').jqxWindow('bringToFront');
	  }); 
	  }
</script>

</head>
<body onload="getBranch();setValues();">
<form id="frmReleaseDashBoard" action="saveReleaseDashBoard">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>
	
	<!--  <tr><td colspan="2">&nbsp;</td></tr> -->
    <tr><td width="31%" align="right"><label class="branch">Fleet No</label></td><td width="69%"><input type="text" name="dashreleasefleet" id="dashreleasefleet" value='<s:property value="dashreleasefleet"/>' style="height:18px;width:84%"></td></tr>
<tr><td align="right"><label class="branch">Branch</label></td><td><select name="dashcmbrlsbranch"  id="dashcmbrlsbranch" value='<s:property value="dashcmbrlsbranch"/>' onChange="getLocation(this.value);" style="width:84%;"  >
  <option value="">--Select--</option>
</select>
    <input type="hidden" name="dashhidcmbrlsbranch" id="dashhidcmbrlsbranch" value='<s:property value="dashhidcmbrlsbranch"/>' style="width:84%" ></td></tr> 
<input type="hidden" name="hidclient" id="hidclient" >
		 <tr>
	<td colspan="2"></td>
	</tr>
		 <tr>
		   <td align="right"><label class="branch">Location</label></td>
		   <td><select name="dashcmbrlsloc" id="dashcmbrlsloc" value='<s:property value="dashcmbrlsloc"/>' style="width:84%;"  >
		     <option value="">--Select--</option>
		     </select>
		     <input type="hidden" name="dashhidcmbrlsloc" id="dashhidcmbrlsloc" value='<s:property value="dashhidcmbrlsloc"/>'></td>
		   </tr>
		 <tr>
		   <td align="right"><label class="branch">Rental Status</label></td>
		   <td><select name="dashcmbrentalstatus" id="dashcmbrentalstatus" value='<s:property value="dashcmbrentalstatus"/>' style="width:84%;" >
		     <option value="R" selected>Rental</option>
		     <option value="L">Lease</option>
		     <option value="LM">Limousine</option>
		     <option value="A">All</option>
		     </select>
		     <input type="hidden"  name="dashhidcmbrentalstatus" id="dashhidcmbrentalstatus" value='<s:property value="dashhidcmbrentalstatus"/>'></td>
		   </tr>
		 <tr>
		   <td align="right"><label class="branch">Date</label></td>
		   <td><div id="dashreleasedate" name="dashreleasedate" value='<s:property value="dashreleasedate"/>'></td>
		   </tr>
		 <tr>
		   <td align="right"><label class="branch">Time</label></td>
		   <td><div id="dashreleasetime" name="dashreleasetime" value='<s:property value="dashreleasetime"/>'></td>
		   </tr>
		 <tr>
		   <td align="right"><label class="branch">KM</label></td>
		   <td><input type="text" name="dashreleasekm" id="dashreleasekm" value='<s:property value="dashreleasekm"/>' tabindex="-1" readonly style="height:18px;width:84%"></td>
		   </tr>
		 <tr>
		   <td align="right"><label class="branch">Fuel</label></td>
		   <td><select name="dashreleasefuel" id="dashreleasefuel" value='<s:property value="dashreleasefuel"/>' style="width:84%;">
		     <option value="">--Select--</option>
		     <option value=0.000 selected>Level 0/8</option>
		     <option value=0.125>Level 1/8</option>
		     <option value=0.250>Level 2/8</option>
		     <option value=0.375>Level 3/8</option>
		     <option value=0.500>Level 4/8</option>
		     <option value=0.625>Level 5/8</option>
		     <option value=0.750>Level 6/8</option>
		     <option value=0.875>Level 7/8</option>
		     <option value=1.000>Level 8/8</option>
		     </select></td>
		   </tr>
		 <tr>
		   <td align="right"><label class="branch">Op. Status</label></td>
		   <td><input type="text"
							name="dashopstatus" id="dashopstatus"  value='IN' tabindex="-1" disabled="true" style="height:18px;width:84%"></td>
		   </tr>
		 <tr>
		   <td align="right"><label class="branch">Ast status</label></td>
		   <td align="left"><input type="text" name="dashaststatus" id="dashaststatus"   value='<s:property value="dashaststatus"/>'  tabindex="-1" readonly style="height:18px;width:84%"></td>
		   </tr>
		 <tr>
		   <td colspan="2"><div id="dashfleetwarning" align="center" style="color:red;font:10px Tahoma;font-weight:bold;">All fields are Mandatory</div></td>
		   </tr> 
	<tr>
	<td colspan="2"><center> 
	  <input type="button" name="btnvehicle" id="btnvehicle" value="Vehicle" class="myButton" onclick="getVehicle();">  <input type="button" name="btnattach" id="btnattach" value="Attach" class="myButton" onclick="getAttach();"></center></td>
	</tr>
	<tr>
	<td colspan="2"><center><input type="button" name="dashbtnrelease" id="dashbtnrelease" class="myButton"  value="Release" onClick="funReleaseClick();"></center></td>
	</tr>
	<tr>
	<td colspan="2"><br><br><br><br><br></td>
	</tr>	
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="releasediv"><jsp:include page="toBeReleasedGrid.jsp"></jsp:include></div></td>
			 <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>' > 

<input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>' >
		</tr>
	</table>
</tr>
</table>
</div>
<!-- <div id="clientwindow">
<div></div>
</div> -->
<div id="vehiclewindow">
<div></div>
</div>
<div id="clientAttachWindow">
   <div></div>
</div>
</div>
</form>
</body>
</html>