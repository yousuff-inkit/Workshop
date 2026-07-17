<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<link href="../../../../css/body.css" rel="stylesheet" type="text/css">
<style>
form label.error {
color:red;
  font-weight:bold;

}
.hidden-scrollbar {
    overflow: auto;
    height: 600px;
}
</style>
<script type="text/javascript">
$(document).ready(function() {
	document.getElementById("btnGridSave").style.display="none";
	document.getElementById("btnCloseSave").style.display="none";
	document.getElementById("btnClosedetail").disabled=true; 
	//$('#nonPoolRateGrid').jqxGrid('disabled',true); 
	getBranch();
	getTestLocation();
	$('#fleetwindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
    $('#fleetwindow').jqxWindow('close');
    $('#checkwindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
    $('#checkwindow').jqxWindow('close');
    $('#vendorwindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
    $('#vendorwindow').jqxWindow('close');
    $('#invmodewindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
    $('#invmodewindow').jqxWindow('close');
	 $("#closetime").jqxDateTimeInput({ width: '40px', height: '15px', formatString: 'HH:mm', showCalendarButton: false,value:null});
	 $("#timein").jqxDateTimeInput({ width: '40px', height: '15px', formatString: 'HH:mm', showCalendarButton: false,value:null});
	 $("#timedue").jqxDateTimeInput({ width: '40px', height: '15px', formatString: 'HH:mm', showCalendarButton: false,value:null });
 	 $("#temptimein").jqxDateTimeInput({ width: '40px', height: '15px', formatString: 'HH:mm', showCalendarButton: false,value:null }); 
 	 
 	//$('#nonPoolRateGrid').jqxGrid('disabled',true);
 	
$("#closedate").jqxDateTimeInput({
		width : '125px',
		height : '15px',
		formatString : "dd.MM.yyyy",value:null
	});
$("#date").jqxDateTimeInput({
	width : '125px',
	height : '15px',
	formatString : "dd.MM.yyyy"
});
	$("#datein").jqxDateTimeInput({
		width : '125px',
		height : '15px',
		formatString : "dd.MM.yyyy",value:null
	});
	
	$("#datedue").jqxDateTimeInput({
		width : '125px',
		height : '15px',
		formatString : "dd.MM.yyyy",value:null
	});
	$('#vendor').dblclick(function(){
		if(document.getElementById("mode").value=="A"){
	    $('#vendorwindow').jqxWindow('open');
      $('#vendorwindow').jqxWindow('focus');
      vendorSearchContent('masterVendorSearch.jsp', $('#vendorwindow'));
		}
     });
	
	$('#fleetno').dblclick(function(){
		if(document.getElementById("mode").value=="A"){
		$('#fleetwindow').jqxWindow('open');
      $('#fleetwindow').jqxWindow('focus');
      fleetSearchContent('masterFleetSearch.jsp', $('#fleetwindow'));
		}
     });

	
	$('#checkin').dblclick(function(){
	    if(document.getElementById("mode").value=="A"){
		$('#checkwindow').jqxWindow('open');
      $('#checkwindow').jqxWindow('focus');
      checkSearchContent('checkSearch.jsp?id=1', $('#checkwindow'));
	    }
     });
	$('#checkout').dblclick(function(){
	    $('#checkwindow').jqxWindow('open');
      $('#checkwindow').jqxWindow('focus');
      checkSearchContent('checkSearch.jsp?id=2', $('#checkwindow')); 
     });
	
	
	
	 $('#datein').on('change', function (event) 
	   		 {  
	   		   
	   		     setDateDue();
	   		 });
	 

});

function setDateDue(){
 /* if(document.getElementById("cmbperiodtype").value==""){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Period Type is Mandatory";
		return false;
	}
	else if(document.getElementById("cmbperiodno").value==""){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Period No is Mandatory";
		return false;
	}
	var datein=$('#datein').jqxDateTimeInput('getDate');
	var period=document.getElementById("cmbperiodno").value;
	var datedue;
	if(document.getElementById("cmbperiodtype").value=="Years"){
		datedue=new Date(datein.setMonth(datein.getFullYear()+(period*12)));
	}
	else if(document.getElementById("cmbperiodtype").value=="Months"){
		
		datedue=new Date(new Date(datein).setMonth(datein.getMonth()+period));
	}
	else if(document.getElementById("cmbperiodtype").value=="Days"){
		datedue=new Date(datein.setDate(datein.getDate()+period));
	}
	$('#datedue').jqxDateTimeInput('val',datedue); */ 
}
function change1()
{ 
	
	
   if(document.getElementById("m2").value!="")
	   {
	document.getElementById("m3").value=parseInt(document.getElementById("m2").value)+1;
	   }
   else
	   {
	   document.getElementById("m3").value="";
	   }
}
function change2()
{
	
	 if(document.getElementById("m4").value!="")
	   {
	document.getElementById("m5").value=parseInt(document.getElementById("m4").value)+1;
	   }
	 else
	   {
	   document.getElementById("m5").value="";
	   }
}
function change3()
{
	
	 if(document.getElementById("m6").value!="")
	   {
	
	document.getElementById("m7").value=parseInt(document.getElementById("m6").value)+1;
	   }
	 
	 else
		 {
		 
		 document.getElementById("m7").value="";
		 }
}
function change4()
{
	 if(document.getElementById("m8").value!="")
	   {
	document.getElementById("m9").value=parseInt(document.getElementById("m8").value)+1;
	   }
	 else
		 {
		 
		 document.getElementById("m9").value="";
		 
		 }
}
function vendorSearchContent(url) {
	 //alert(url); 
		 $.get(url).done(function (data) {
			 //alert(data);
		$('#vendorwindow').jqxWindow('setContent', data);

	}); 
	}
function fleetSearchContent(url) {
		 $.get(url).done(function (data) {
			 //alert(data);
		$('#fleetwindow').jqxWindow('setContent', data);

	}); 
	}
function checkSearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 //alert(data);
		$('#checkwindow').jqxWindow('setContent', data);

	}); 
	}
function invmodeSearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 //alert(data);
		$('#invmodewindow').jqxWindow('setContent', data);

	}); 
	}	
function getVendor(event){
//	$('#vendorSearch').jqxGrid('clear');
if(document.getElementById("mode").value=="A"){	
var x= event.keyCode;
	 if(x==114){
	  $('#vendorwindow').jqxWindow('open');

   	 vendorSearchContent('masterVendorSearch.jsp?', $('#vendorwindow')); 	
   }
	 else{
		 }
}
	 }
function getFleet(event){
if(document.getElementById("mode").value=="A"){
	var x= event.keyCode;
	 if(x==114){
	  $('#fleetwindow').jqxWindow('open');

  	 fleetSearchContent('masterFleetSearch.jsp?', $('#fleetwindow')); 	
  }
	 else{
		 }
}
	 }	 
function getCheck(event,id){
if(document.getElementById("mode").value!="A" && id=="1"){
	return false;
}
	var x= event.keyCode;
	 if(x==114){
	  $('#checkwindow').jqxWindow('open');

  	 checkSearchContent('checkSearch.jsp?id='+id, $('#checkwindow')); 	
  }
	 else{
		 }
	 }
	 
	 
	 
	 
function getBranch() {
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
			$("select#cmbbranch").html(optionsbrch);
			if ($('#hidcmbbranch').val() != null) {
				$('#cmbbranch').val($('#hidcmbbranch').val());
			}
			
		} else {
		}
	}
	x.open("GET", "../../../../com/controlcentre/masters/vehiclemaster/getBranch.jsp", true);
	x.send();
}



function getLocation(value)
{
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	items= x.responseText;
			 	items=items.split('***');
		        var locationItems=items[0].split(",");
		        var locationidItems=items[1].split(",");
		        	var optionslocation = '<option value="">--Select--</option>';
		       for ( var i = 0; i < locationItems.length; i++) {
		    	   optionslocation += '<option value="' + locationidItems[i] + '">' + locationItems[i] + '</option>';
		        }
		       $("select#cmblocation").html(optionslocation);
			   //	$('#accno').val($('#accnohidden').val()) ;
			   	if ($('#hidcmblocation').val() != null) {
			$('#cmblocation').val($('#hidcmblocation').val());
		}
			}
		else
			{
			}
	}
	x.open("GET","../../../../com/controlcentre/masters/nonpoolvehicle/getLocation.jsp?id="+value,true);
	x.send();
//document.write(document.getElementById("authname").value);

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
		       $("select#cmblocation").html(optionslocation);
			   //	$('#accno').val($('#accnohidden').val()) ;
			   	if ($('#hidcmblocation').val() != null) {
			$('#cmblocation').val($('#hidcmblocation').val());
			}
			}
		else
			{
			}
	}
	x.open("GET","../../../../com/controlcentre/masters/vehiclemaster/getTestLocation.jsp",true);
	x.send();
//document.write(document.getElementById("authname").value);

}
function funReadOnly(){
	$('#frmNonPoolCreate input').attr('readonly', true);
	$('#frmNonPoolCreate select').attr('disabled', true );
	$('#datein').jqxDateTimeInput('disabled',true);
	$('#timein').jqxDateTimeInput('disabled',true);
	$('#datedue').jqxDateTimeInput('disabled',true);
	$('#timedue').jqxDateTimeInput('disabled',true);
	$('#closedate').jqxDateTimeInput('disabled',true);
	$('#closetime').jqxDateTimeInput('disabled',true);
	$('#rateGrid').jqxGrid('disabled',true);
}
function funChkButton(){
	
}
function funNotify(){
	if(document.getElementById("fleetno").value==""){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Fleet is Mandatory";
		document.getElementById("fleetno").focus();
		return 0;
	}
	if(document.getElementById("vendor").value==""){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Vendor is Mandatory";
		document.getElementById("vendor").focus();
		return 0;
	}
	if(document.getElementById("cmbperiodtype").value==""){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Period Type is Mandatory";
		document.getElementById("cmbperiodtype").focus();
		return 0;
	}
	if(document.getElementById("cmbperiodno").value==""){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Period No is Mandatory";
		document.getElementById("cmbperiodno").focus();
		return 0;
	}
	if($('#datein').jqxDateTimeInput('getDate')==null){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Date In is Mandatory";
		$('#datein').jqxDateTimeInput('focus');
		return 0;
		
	}
	if($('#datedue').jqxDateTimeInput('getDate')==null){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Date Due is Mandatory";
		$('#datein').jqxDateTimeInput('focus');
		return 0;
		
	}
	if(document.getElementById("inkm").value==""){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="In KM is Mandatory";
		document.getElementById("inkm").focus();
		return 0;
	}
	if(parseFloat(document.getElementById("inkm").value)==0.0){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="In KM cannot be empty";
		document.getElementById("inkm").focus();
		return 0;
	}
	if(document.getElementById("cmbinfuel").value==""){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Please Select In Fuel";
		document.getElementById("cmbinfuel").focus();
		return 0;
	}
	if(document.getElementById("checkin").value==""){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Please Select CheckIn";
		document.getElementById("checkin").focus();
		return 0;
		
	}
	var rows = $("#rateGrid").jqxGrid('getrows');
	//alert(rows);
	if(rows[0].rate=="undefined" || rows[0].rate==""){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Rates are Mandatory";
		return 0;	
	}
	$('#gridlength').val(rows.length);
		//alert($('#gridlength').val());
		//for(var i=0 ; i < rows.length ; i++){
		//	var myvar = rows[i].tarif; 
		var i=0;	
		newTextBox = $(document.createElement("input"))
		    .attr("type", "dil")
		    .attr("id", "test"+i)
		    .attr("name", "test"+i)
		    .attr("hidden", "true");
		
			newTextBox.val(rows[i].rate+"::"+rows[i].cdw+"::"+rows[i].pai+"::"+rows[i].cdw1+"::"+rows[i].pai1+"::"+rows[i].gps+"::"+rows[i].babyseater+"::"+rows[i].cooler+"::"+rows[i].kmrest+"::"
					   +rows[i].exkmrte+"::"+rows[i].chaufchg+"::"+rows[i].chaufexchg+"::"+rows[i].status+"::");
		newTextBox.appendTo('form');
		
			//alert("ddddd"+$("#test"+i).val());
		//}
		return 1;
}
function setValues(){
	 funSetlabel();
	 document.getElementById("btnClosedetail").disabled=true;
	 //$('#nonPoolRateGrid').jqxGrid('disabled',true);
	 //document.getElementById("btnClose").disabled=true;
	 if(document.getElementById("closestatus").value=="0"){
		 document.getElementById("btnClosedetail").disabled=false;
		 //$('#nonPoolRateGrid').jqxGrid('disabled',false);
	 }
	 
	 if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
	 if($('#hidtimein').val()){
			$("#timein").jqxDateTimeInput('val', $('#hidtimein').val());
		}
	 if($('#hidtimedue').val()){
			$("#timedue").jqxDateTimeInput('val', $('#hidtimedue').val());
		}
	 if($('#hidclosetime').val()){
			$("#closetime").jqxDateTimeInput('val', $('#hidclosetime').val());
		}
	 if ($('#hidcmbinfuel').val() != null) {
			$('#cmbinfuel').val($('#hidcmbinfuel').val());
		}
	 if ($('#hidcmbclosefuel').val() != null) {
			$('#cmbclosefuel').val($('#hidcmbclosefuel').val());
		}
	
	 
	 if ($('#hidcmbperiodtype').val() != null) {
			$('#cmbperiodtype').val($('#hidcmbperiodtype').val());
		}
	 setPeriods($('#cmbperiodtype').val());
	 if ($('#hidcmbperiodno').val() != null) {
			$('#cmbperiodno').val($('#hidcmbperiodno').val());
		}
	 if(document.getElementById("docno").value!=""){
		 $('#ratediv').load('rateGrid.jsp?docno='+document.getElementById("docno").value);
	 }
	 if(document.getElementById("docno").value!="" && document.getElementById("closestatus").value=="1"){
		 $('#nonpoolratediv').load('nonPoolRate.jsp?docno='+document.getElementById("docno").value+'&closestatus='+document.getElementById("closestatus").value);
	 }
	 

	 $('#nonPoolRateGrid').jqxGrid('disabled',true);
}
function funRemoveReadOnly(){
	$('#frmNonPoolCreate input').attr('readonly', false);
	$('#frmNonPoolCreate select').attr('disabled', false);
	$('#datein').jqxDateTimeInput('disabled',false);
	$('#timein').jqxDateTimeInput('disabled',false);
	$('#datedue').jqxDateTimeInput('disabled',false);
	$('#timedue').jqxDateTimeInput('disabled',false);
	$('#closedate').jqxDateTimeInput('disabled',false);
	$('#closetime').jqxDateTimeInput('disabled',false);
	$('#rateGrid').jqxGrid('disabled',false);
	$('#docno').prop('readonly',true);
	$('#fleetno').prop('readonly',true);
	$('#fleetname').prop('readonly',true);
	$('#vendor').prop('readonly',true);
	$('#vendorname').prop('readonly',true);
	$('#checkin').prop('readonly',true);
	$('#inuser').prop('readonly',true);
	$('#totalkm').prop('readonly',true);
	$('#avgkm').prop('readonly',true);
	$('#checkout').prop('readonly',true);
	$('#closeuser').prop('readonly',true);
	$('#m3').prop('readonly',true);
	$('#m5').prop('readonly',true);
	$('#m7').prop('readonly',true);
	$('#m9').prop('readonly',true);
	if(document.getElementById("mode").value=="A"){
		$('#closefield').prop('disabled',true);
		funClearData();
	}
	
}
function funClearData(){
$('#fleetno').val('');
$('#fleetname').val('');
$('#vendor').val('');
$('#vendorname').val('');
$('#docno').val('');
$('#cmbperiodtype').val('');
$('#cmbperiodno').val('');
$('#rateGrid').jqxGrid('clear');
$("#rateGrid").jqxGrid("addrow", null, {});	
$('#datein').jqxDateTimeInput('val',null);
$('#timein').jqxDateTimeInput('val',null);
$('#datedue').jqxDateTimeInput('val',null);
$('#timedue').jqxDateTimeInput('val',null);
$('#datein').jqxDateTimeInput('val',null);
$('#cmbbranch').val('');
$('#cmblocation').val('');
$('#inkm').val('');
$('#cmbinfuel').val('');
$('#checkin').val('');
$('#inuser').val('');
$('#m1').val('');
$('#m2').val('');
$('#m3').val('');
$('#m4').val('');
$('#m5').val('');
$('#m6').val('');
$('#m7').val('');
$('#m8').val('');
$('#m9').val('');
$('#m10').val('');
$('#amt1').val('');
$('#amt2').val('');
$('#amt3').val('');
$('#amt4').val('');
$('#amt5').val('');
$('#closedate').jqxDateTimeInput('val',null);
$('#closetime').jqxDateTimeInput('val',null);
$('#closekm').val('');
$('#cmbclosefuel').val('');
$('#totalkm').val('');
$('#avgkm').val('');
$('#checkout').val('');
$('#closeuser').val('');
$('#nonPoolRateGrid').jqxGrid('clear');
$("#nonPoolRateGrid").jqxGrid("addrow", null, {});	


}
function funFocus(){
	document.getElementById("fleetno").focus();
}
function setPeriods(value){
	var end=0;
	if(value=="Days"){
		end=31;
	}
	if(value=="Months"){
		end=12;
	}
	if(value=="Years"){
		end=15;
	}
	var optionsperiod= '<option value="">--Select--</option>';
	for(var i=1;i<=end;i++){
		optionsperiod += '<option value="'+i+'">'+i+'</option>';
	}
	$("select#cmbperiodno").html(optionsperiod);
}
function funClose(){
	$('#closedate').jqxDateTimeInput('disabled',false);
	$('#closetime').jqxDateTimeInput('disabled',false);
	$('#closekm').prop('disabled',false);
	$('#closekm').prop('readonly',false);
	$('#cmbclosefuel').prop('disabled',false);
	$('#totalkm').prop('disabled',false);
	$('#avgkm').prop('disabled',false);
	$('#checkout').prop('disabled',false);
	$('#closeuser').prop('disabled',false);
	//$('#nonPoolRateGrid').jqxGrid('disabled',false); 
	document.getElementById("btnClosedetail").style.display="none";
	document.getElementById("btnCloseSave").style.display="block";
	
}


function getCloseDetails(){
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	items= x.responseText;
				items=items.split('::');
				var datein=new Date(items[0].trim());
				datein.setHours(0,0,0,0);
				$('#temptimein').jqxDateTimeInput('val',items[1].trim());
				var timein=$('#temptimein').jqxDateTimeInput('getDate');
				var kmin=items[2].trim();
			//	var fuelin=parseFloat(items[3].trim());
				var closedate=$('#closedate').jqxDateTimeInput('getDate');
				closedate.setHours(0,0,0,0);
				var closetime=new Date($('#closetime').jqxDateTimeInput('getDate'));
				var closekm=document.getElementById("closekm").value;
				if(parseInt(items[4].trim())>0){
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="Active Transactions in Progress";
					return false;
				}
				else if(closedate<datein){
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="Close Date Cannot be less than Vehicle In Date";
					$('#closedate').jqxDateTimeInput('focus');
					return false;
				}
				else if(closedate-datein==0){
					if(closetime.getHours()<timein.getHours()){
						document.getElementById("errormsg").innerText="";
						document.getElementById("errormsg").innerText="Close Time Cannot be less than Vehicle In Time";
						$('#closetime').jqxDateTimeInput('focus');
						return false;
					}
					else if(closetime.getHours()==timein.getHours()){
						if(closetime.getMinutes()<timein.getMinutes()){
							document.getElementById("errormsg").innerText="";
							document.getElementById("errormsg").innerText="Close Time Cannot be less than Vehicle In Time";
							$('#closetime').jqxDateTimeInput('focus');
							return false;
						}
					}
					
				}
				
				if(parseFloat(closekm)<parseFloat(kmin)){
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="Close KM Cannot be less than Vehicle In KM";
					document.getElementById("closekm").focus();
					return false;
			
				}
				else{
					
						
						
						 $.messager.confirm('Confirm', 'Do you want to Save Changes?', function(r){
								if (r){
									document.getElementById("mode").value="E";
									$('#frmNonPoolCreate select').attr('disabled', false);
									$('#datein').jqxDateTimeInput('disabled',false);
									$('#timein').jqxDateTimeInput('disabled',false);
									$('#datedue').jqxDateTimeInput('disabled',false);
									$('#timedue').jqxDateTimeInput('disabled',false);
									$('#closedate').jqxDateTimeInput('disabled',false);
									$('#closetime').jqxDateTimeInput('disabled',false);
									//$('#rateGrid').jqxGrid('disabled',false);
									funSetlabel();
									document.getElementById("frmNonPoolCreate").submit();
								}
							});
				}
			}
		else
			{
			}
	}
	x.open("GET","getCloseDetails.jsp?fleetno="+document.getElementById("fleetno").value,true);
	x.send();
}
function funCloseSave(){
	
	if($('#closedate').jqxDateTimeInput('getDate')==null){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Close Date is Mandatory";
		$('#closedate').jqxDateTimeInput('focus');
		return false;
	}
	else if($('#closetime').jqxDateTimeInput('getDate')==null){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Close Time is Mandatory";
		$('#closetime').jqxDateTimeInput('focus');
		return false;
	}
	else if(document.getElementById("closekm").value==""){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Close Km is Mandatory";
		document.getElementById("closekm").focus();
		return false;
	}
	else if(document.getElementById("checkout").value==""){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Check Out is Mandatory";
		document.getElementById("checkout").focus();
		return false;
	}
	else if(document.getElementById("cmbclosefuel").value==""){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Close Fuel is Mandatory";
		document.getElementById("cmbclosefuel").focus();
		return false;
	}	
	else{
		document.getElementById("errormsg").innerText="";
		getCloseDetails();
	}
			
	
	
}
function funSearchLoad(){
	changeContent('masterSearch.jsp'); 
 }
 
 
 
 function getTotalkm(value){
	 var indate=$('#datein').jqxDateTimeInput('val');
	 var closedate=$('#closedate').jqxDateTimeInput('val');
	 //alert(indate+"::::"+closedate);
	 var inkm=document.getElementById("inkm").value;
	 
	 var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				 var items=x.responseText.trim();
				//alert("Response items"+items);
				items=items.split("::");
				document.getElementById("totalkm").value=items[0];
				document.getElementById("avgkm").value=items[1];
			
			}
		}
		x.open("GET", "getAvg.jsp?indate="+indate+"&closedate="+closedate+"&inkm="+inkm+"&closekm="+value, true);
		x.send();
 }
 
 
 
 
 function funGridEdit(){
	 
	 if(document.getElementById("docno").value==""){
		 document.getElementById("errormsg").innerText="";
		 document.getElementById("errormsg").innerText="Please Select a Document";
		 return false;
	 }
	 document.getElementById("btnGridEdit").style.display="none";
	 document.getElementById("btnGridSave").style.display="block";
	$('#nonPoolRateGrid').jqxGrid('disabled',false);
 }
 function funGridSave(){
	 var rows = $("#nonPoolRateGrid").jqxGrid('getrows');
	 if(rows[0].idno=="" || rows[0].idno=="undefined" || rows[0].idno==null){
		 document.getElementById("errormsg").innerText="";
		 document.getElementById("errormsg").innerText="Grid Cannot be Empty";
		 return false;
	 }
		$('#nonpoolgridlength').val(rows.length);
			
			for(var i=0 ; i < rows.length ; i++){
				
			newTextBox = $(document.createElement("input"))
			    .attr("type", "dil")
			    .attr("id", "nonpoollist"+i)
			    .attr("name", "nonpoollist"+i)
			    .attr("hidden", "true");
			
				newTextBox.val(rows[i].idno+"::"+rows[i].acno+"::"+rows[i].qty+"::"+rows[i].amount);
			newTextBox.appendTo('form');
			
			}
			 $.messager.confirm('Confirm', 'Do you want to Save Changes?', function(r){
					if (r){
						document.getElementById("mode").value="R";
						$('#frmNonPoolCreate select').attr('disabled', false);
						$('#datein').jqxDateTimeInput('disabled',false);
						$('#timein').jqxDateTimeInput('disabled',false);
						$('#datedue').jqxDateTimeInput('disabled',false);
						$('#timedue').jqxDateTimeInput('disabled',false);
						$('#closedate').jqxDateTimeInput('disabled',false);
						$('#closetime').jqxDateTimeInput('disabled',false);
						$('#rateGrid').jqxGrid('disabled',false);
						funSetlabel();
						document.getElementById("frmNonPoolCreate").submit();
					}
				});
 }
</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<jsp:include page="../../../../header.jsp"></jsp:include>
<br>
<div class="hidden-scrollbar">
<form id="frmNonPoolCreate" action="saveNonPoolCreate" method="post" autocomplete="off">




<fieldset><legend>Vehicle Info</legend>
<table width="100%" >
  <tr>
    <td align="right">Date</td>
    <td width="26%" align="left"><div id="date" name="date" value='<s:property value="date"/>'></div></td>
    <td width="47.5%"  align="right">Doc No</td>
    <td width="18%" align="left"><input type="text" name="voucherno" id="voucherno" value='<s:property value="voucherno"/>'></td>
  </tr>
  <tr>
    <td width="9%" align="right">Vehicle</td>
    <td colspan="3"><input type="text" id="fleetno" name="fleetno" value='<s:property value="fleetno"/>' onkeydown="getFleet(event);" readonly placeholder="Press F3 to Search" />&nbsp;&nbsp;
    <input type="text" name="fleetname" id="fleetname" value='<s:property value="fleetname"/>' style="width:80%;">
    </td>
  </tr>
  <tr>
    <td align="right">Vendor</td>
    <td colspan="3"><input type="text" name="vendor" id="vendor" value='<s:property value="vendor"/>'  readonly placeholder="Press F3 to Search" onkeydown="getVendor(event);">&nbsp;&nbsp;
    <input type="text" name="vendorname" id="vendorname" value='<s:property value="vendorname"/>' style="width:80%;" >
    </td>
  </tr>
</table>
</fieldset>
<br />
      <fieldset>
    <legend>Rate Info</legend>
    <table width="100%">
      <tr>
        <td width="7%" align="right">Period</td>
        <input type="hidden" id="hidcmbperiodno" name="hidcmbperiodno" value='<s:property value="hidcmbperiodno"/>'>
        <td width="93%" align="left">
          
            <select name="cmbperiodtype" id="cmbperiodtype" value='<s:property value="cmbperiodtype"/>' onblur="setPeriods(this.value);">
              <option value="">--Select--</option><option value="Months">Months</option><option value="Years">Years</option><option value="Days">Days</option>
          </select>
            <select name="cmbperiodno" id="cmbperiodno" value='<s:property value="cmbperiodno"/>'><option value="">--Select--</option>
              
          </select></td><input type="hidden" name="hidcmbperiodtype" id="hidcmbperiodtype" value='<s:property value="hidcmbperiodtype"/>'>
          <%-- 
        <td width="8%" align="right">Rent</td>
        <td width="10%" align="left"><input type="text" name="rent" id="rent" value='<s:property value="rent"/>' style="text-align:right;"></td>
        <td width="6%" align="right">CDW</td>
        <td width="15%" align="left"><input type="text" name="cdw" id="cdw" value='<s:property value="cdw"/>' style="text-align:right;"></td>
        <td width="8%" align="right">PAI </td>
        <td width="26%" align="left"><input type="text" name="pai" id="pai" value='<s:property value="pai"/>' style="text-align:right;"></td> --%>
      </tr>
      <tr>
        <td colspan="8" align="right"><div id="ratediv"><jsp:include page="rateGrid.jsp"></jsp:include></div></td>
      </tr>
    </table>
    </fieldset></td>
  </tr>
  <tr>
    <td colspan="2"><fieldset>
      <legend>Opening Details</legend>
      <table width="100%">
        <tr>
          <td width="6%" align="right">Date In</td>
          <td width="12%" align="left"><div id="datein" name="datein" value='<s:property value="datein"/>'></div></td>
          <input type="hidden" name="hiddatein" id="hiddatein" value='<s:property value="hiddatein"/>'>
          
          <td width="8%" align="right">Time</td>
          <td width="11%" align="left"><div id="timein" name="timein" value='<s:property value="timein"/>'></div></td>
          <input type="hidden" name="hidtimein" id="hidtimein" value='<s:property value="hidtimein"/>'>
          
          <td width="7%" align="right">Date Due</td>
          <td width="10%" align="left"><div id="datedue" name="datedue" value='<s:property value="datedue"/>'></div></td>
          <input type="hidden" name="hiddatedue" id="hiddatedue" value='<s:property value="hiddatedue"/>'>
          
          <td width="8%" align="right">Time Due</td>
          <td align="left"><div id="timedue" name="timedue" value='<s:property value="timedue"/>'></div></td>
          <td align="right">Branch</td>
          <td align="left"><select name="cmbbranch" id="cmbbranch" value='<s:property value="cmbbranch"/>' style="width:70%;" onchange="getLocation(this.value);"><option value="">--Select--</option></select> </td>
          <input type="hidden" name="hidcmbbranch" id="hidcmbbranch" value='<s:property value="hidcmbbranch"/>' />
          <input type="hidden" name="hidtimedue" id="hidtimedue" value='<s:property value="hidtimedue"/>'>
          
        </tr>
        <tr>
          <td align="right" >KM</td>
          <td align="left"><input type="text" name="inkm" id="inkm" value='<s:property value="inkm"/>'></td>
          <td align="right">Fuel</td><input type="hidden" name="hidcmbinfuel" id="hidcmbinfuel" value='<s:property value="hidcmbinfuel"/>'>
          <td align="left">
          <select name="cmbinfuel" id="cmbinfuel" value='<s:property value="cmbinfuel"/>'><option value="">--Select--</option><option value=0.000>Level 0/8</option>
        <option value=0.125 >Level 1/8</option>
        <option value=0.250>Level 2/8</option>
        <option value=0.375>Level 3/8</option>
        <option value=0.500>Level 4/8</option>
        <option value=0.625>Level 5/8</option>
        <option value=0.750>Level 6/8</option>
        <option value=0.875>Level 7/8</option>
        <option value=1.000>Level 8/8</option>
        </select>
          <%-- <input type="text" name="hidinfuel" id="hidinfuel" value='<s:property value="hidinfuel"/>' readonly tabindex="-1"> --%></td>
          <td align="right">Check In</td>
          <td align="left"><input type="text" name="checkin" id="checkin"  value='<s:property value="checkin"/>' readonly onkeydown="getCheck(event,1);" placeholder="Press F3 to Search" />
          
        </td><%--   <select name="cmbcheckin" id="cmbcheckin" value='<s:property value="cmbcheckin"/>' style="width:85%;">
              <option value="">--Select--</option></select> --%>
              <input type="hidden" name="hidcheckin" id="hidcheckin" value='<s:property value="hidcheckin"/>'>
            
          <td align="right">User</td>
          <td width="10%" align="left"><input type="text" name="inuser" id="inuser" value='<s:property value="inuser"/>' ></td>
          <input type="hidden" name="hidinuser" id="hidinuser" value='<s:property value="hidinuser"/>' >
          <td width="14%" align="right">Location</td>
          <td width="14%" align="left"><select name="cmblocation" id="cmblocation" value='<s:property value="cmblocation"/>' style="width:70%;"  ><option value="">--Select--</option></select></td>
          <input type="hidden" name="hidcmblocation" id="hidcmblocation" value='<s:property value="hidcmblocation"/>' />
        </tr>
      </table>
    </fieldset>    </td>
  </tr>
 
  <tr>
    <td width="49%">
    
    
    <!--<fieldset>
      
      <legend>Charges Info</legend>
      <table width="100%">
        <tr>
          <td width="15%" align="right">Own Claim Excess</td>
          <td width="17%" align="left"><input type="text" name="ownclaimexcess" id="ownclaimexcess" value='<s:property value="ownclaimexcess"/>' style="text-align:right;"></td>
          <td width="16%" align="right">Salik Serv Chrgs</td>
          <td align="left"><input type="text" name="salikservchg" id="salikservchg" value='<s:property value="salikservchg"/>' style="text-align:right;"></td>
          <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
          <td align="right">KM Restriction</td>
          <td align="left"><input type="text" name="kmrestrict" id="kmrestrict" value='<s:property value="kmrestrict"/>' style="text-align:right;"></td>
          <td align="right">T.Fine Serv Chrgs</td>
          <td width="20%" align="left"><input type="text" name="tfineservchg" id="tfineservchg" value='<s:property value="tfineservchg"/>' style="text-align:right;"></td>
          <td width="16%" align="right">&nbsp;</td>
          <td width="16%" align="left"><input type="text" name="within12" id="within12" value='<s:property value="within12"/>' readonly style="text-align:right;"></td>
        </tr>
        <tr>
          <td align="right">Excess KM Charges</td>
          <td align="left"><input type="text" name="excesskmchg" id="excesskmchg" value='<s:property value="excesskmchg"/>' style="text-align:right;"></td>
          <td align="right">KM Total</td>
          <td align="left"><input type="text" name="kmtotal" id="kmtotal" value='<s:property value="kmtotal"/>' style="text-align:right;"></td>
          <td align="right">&nbsp;</td>
          <td align="left"><input type="text" name="within24" id="within24" value='<s:property value="within24"/>' readonly style="text-align:right;"></td>
        </tr>
        <tr>
          <td align="right">Total</td>
          <td align="left"><input type="text" name="total" id="total" value='<s:property value="total"/>' style="text-align:right;"></td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td align="right">&nbsp;</td>
          <td align="left"><input type="text" name="within36" id="within36" value='<s:property value="within36"/>' readonly style="text-align:right;"></td>
        </tr>
      </table>
    </fieldset>-->   
    
    <table width="100%">
  <tr>
    <td width="24%"><fieldset>
      <legend>Termination Clauses Info</legend>
      <table width="100%"  >
        <tr>
          <td width="50%" align="right"><input type="text" name="m1" id="m1"   value='<s:property value="m1"/>'  onkeypress="javascript:return isNumber (event)" style="width:35%;text-align: center;">
            &nbsp;to&nbsp;
            <input type="text" name="m2"  id="m2" value='<s:property value="m2"/>' style="width:35%;text-align: center;" onkeypress="javascript:return isNumber (event)" onblur="change1();"></td>
          <td width="50%" align="left"><input type="text" id="amt1" name="amt1"  value='<s:property value="amt1"/>' onkeypress="javascript:return isNumber (event)"/></td>
        </tr>
        <tr>
          <td align="right"><input type="text" name="m3" id="m3"   value='<s:property value="m3"/>' onkeypress="javascript:return isNumber (event)" readonly style="width:35%;text-align: center;  ">
            &nbsp;to&nbsp;
            <input type="text" name="m4" id="m4" value='<s:property value="m4"/>' onkeypress="javascript:return isNumber (event)"  style="width:35%;text-align: center;" onblur="change2();"></td>
          <td align="left"><input type="text" id="amt2" name="amt2"  value='<s:property value="amt2"/>' onkeypress="javascript:return isNumber (event)"/></td> </tr>
        <tr>
          <td align="right"><input type="text" name="m5" id="m5"  value='<s:property value="m5"/>' onkeypress="javascript:return isNumber (event)"  readonly="true" style="width:35%;text-align: center;">
            &nbsp;to&nbsp;
            <input type="text" name="m6" id="m6" value='<s:property value="m6"/>' onkeypress="javascript:return isNumber (event)" style="width:35%;text-align: center;"onblur="change3();"></td>
          <td align="left"><input type="text" id="amt3" name="amt3" value='<s:property value="amt3"/>' onkeypress="javascript:return isNumber (event)" /></td>
        </tr>
        <tr>
          <td align="right"><input type="text" name="m7" id="m7" value='<s:property value="m7"/>' onkeypress="javascript:return isNumber (event)"  readonly="true" style="width:35%;text-align: center;">
            &nbsp;to&nbsp;
            <input type="text"  value='<s:property value="m8"/>' name="m8" id="m8" onkeypress="javascript:return isNumber (event)"  style="width:35%;text-align: center;" onblur="change4();"></td>
          <td align="left"><input type="text" id="amt4" name="amt4"   value='<s:property value="amt4"/>' onkeypress="javascript:return isNumber (event)" /></td>
        </tr>
        <tr>
          <td align="right"><input type="text" name="m9" id="m9" value='<s:property value="m9"/>' onkeypress="javascript:return isNumber (event)" readonly style="width:35%;text-align: center;">
            &nbsp;to&nbsp;
            <input type="text" name="m10"  id="m10" value='<s:property value="m10"/>' onkeypress="javascript:return isNumber (event)"  style="width:35%;text-align: center;"></td>
          <td align="left"><input type="text" id="amt5" name="amt5"  value='<s:property value="amt5"/>' onkeypress="javascript:return isNumber (event)" /></td>
        </tr>
      </table>
    </fieldset></td>
    <td width="76%"><fieldset id="closefield"><legend>Closing Info</legend>
    <table width="100%" >
  <tr>
    <td align="right">&nbsp;</td>
    <td align="left">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="left">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="left">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="center"><input type="button" name="btnClosedetail" id="btnClosedetail" value="Close" class="myButton" onclick="funClose();" ><input type="button" name="btnCloseSave" id="btnCloseSave" value="Save" class="myButton" onclick="funCloseSave();" ></td>
  </tr>
  <tr>
    <td width="13%" align="right">Date</td>
    <td width="20%" align="left"><div id="closedate" name="closedate" value='<s:property value="closedate"/>'></div></td>
    <input type="hidden" name="hidclosedate" id="hidclosedate" value='<s:property value="hidclosedate"/>'>
    <td width="8%" align="right">Time</td>
    <input type="hidden" name="hidclosetime" id="hidclosetime" value='<s:property value="hidclosetime"/>'>
    <td width="16%" align="left"><div id="closetime" name="closetime" value='<s:property value="closetime"/>'></div></td>
    <td width="6%" align="right">KM</td>
    <td width="15%" align="left"><input type="text" name="closekm" id="closekm" value='<s:property value="closekm"/>' onblur="getTotalkm(this.value);"></td>
    <td width="5%" align="right">Fuel</td>
    <td width="17%" align="left"><select id="cmbclosefuel" name="cmbclosefuel" value='<s:property value="cmbclosefuel"/>' style="width:76%;"><option value="">--Select--</option>     <option value=0.000>Level 0/8</option>
        <option value=0.125 >Level 1/8</option>
        <option value=0.250>Level 2/8</option>
        <option value=0.375>Level 3/8</option>
        <option value=0.500>Level 4/8</option>
        <option value=0.625>Level 5/8</option>
        <option value=0.750>Level 6/8</option>
        <option value=0.875>Level 7/8</option>
        <option value=1.000>Level 8/8</option></select></td>
        <input type="hidden" name="hidcmbclosefuel" id="hidcmbclosefuel" value='<s:property value="hidcmbclosefuel"/>'>
  </tr>
  <tr>
    <td align="right">Total Km</td>
    <td align="left"><input type="text" name="totalkm" id="totalkm" value='<s:property value="totalkm"/>' /></td>
    <td align="right">Avg Km/M</td>
    <td align="left"><input type="text" name="avgkm" id="avgkm" value='<s:property value="avgkm"/>'></td>
    <td align="right">Check Out</td>
    <td align="left">
        <input type="text" name="checkout" id="checkout"  value='<s:property value="checkout"/>' onkeydown="getCheck(event,2);"readonly placeholder="Press F3 to Search">
        </td><%-- <select name="cmbcheckout" id="cmbcheckout" value='<s:property value="cmbcheckout"/>' style="width:90%;">
          <option value="">--Select--</option>
        </select> --%>
        <input type="hidden" name="hidcheckout" id="hidcheckout" value='<s:property value="hidcheckout"/>'>
    <td align="right">User</td>
    <td align="left"><input type="text" name="closeuser" id="closeuser" value='<s:property value="closeuser"/>'></td>
  </tr>
  <tr>
    <td align="right">&nbsp;</td>
    <td align="left">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="left">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="left">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="left">&nbsp;</td>
  </tr>
  <tr>
    <td align="right">&nbsp;</td>
    <td align="left">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="left">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="left">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="left">&nbsp;</td>
  </tr>
  <tr>
    <td align="right">&nbsp;</td>
    <td align="left">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="left">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="left">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="left">&nbsp;</td>
  </tr>

    </table>
</fieldset>
    
    </td>
  </tr>
  <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
      <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
      <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
      <input type="hidden" name="vendoracno" id="vendoracno" value='<s:property value="vendoracno"/>'>
      <input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
      <input type="hidden" name="nonpoolgridlength" id="nonpoolgridlength" value='<s:property value="nonpoolgridlength"/>'>
      <input type="hidden" name="amttotal" id="amttotal" value='<s:property value="amttotal"/>'>
      <input type="hidden" name="closestatus" id="closestatus" value='<s:property value="closestatus"/>'>
     <input type="hidden" name="gridstatus" id="gridstatus" value='<s:property value="gridstatus"/>'>
      <div id="temptimein" name="temptimein" hidden="true"></div>
      <input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>'>
</table>

     </td>

</tr>

</table>
<table width="100%">
  <tr>
    <td width="86%"><div id="nonpoolratediv"><jsp:include page="nonPoolRate.jsp"></jsp:include></div></td>
    <td width="14%" align="center"><input type="button" name="btnGridEdit" id="btnGridEdit" value="Edit" class="myButton" onclick="funGridEdit();" >
    <input type="button" name="btnGridSave" id="btnGridSave" value="Save" class="myButton" onclick="funGridSave();" ></td>
  </tr>
</table>

<div id="fleetwindow">
				<div></div><div></div>
				</div>
				<div id="checkwindow">
				<div></div><div></div>
				</div>
				<div id="vendorwindow">
				<div></div><div></div>
				</div>
				<div id="invmodewindow">
				<div></div><div></div>
				</div>
				<br><br><br><br><br><br><br><br><br><br>
</form>
</div>
</div>
</body>
</html>

   <!-- <td width="51%"><fieldset>
    <legend>Closing Details</legend>
    <table width="100%">
      <tr>
        <td align="right">&nbsp;</td>
        <td colspan="3" align="left">&nbsp;</td><input type="hidden" id="hidcmbbranch" name="hidcmbbranch" value='<s:property value="hidcmbbranch"/>'>
          
        <td align="right">&nbsp;</td>
        <td width="15%" align="left">&nbsp;</td>
        <td width="10%" align="right">&nbsp;</td><input type="hidden" id="hidclosedate" name="hidclosedate" value='<s:property value="hidclosedate"/>'>
        
        <td width="17%" align="left"><input type="button" name="btnvehclose" id="btnvehclose" value="Close" class="myButton" style="width:99%;"></td>
        <input type="hidden" id="hidclosetime" name="hidclosetime" value='<s:property value="hidclosetime"/>'>
        
        <td width="1%">&nbsp;</td>
      </tr>
      <tr>
        <td width="12%" align="right">Branch</td>
        <td colspan="3" align="left"><select name="cmbbranch" id="cmbbranch" value='<s:property value="cmbbranch"/>' style="width:99%;">
          <option value="">--Select--</option>
        </select></td>
        <input type="hidden" name="hidcmbclosefuel" id="hidcmbclosefuel" value='<s:property value="hidcmbclosefuel"/>'>
          
        <td width="8%" align="right">Date Out</td>
        <td align="left"><div id="closedate" name="closedate" value='<s:property value="closedate"/>'></div></td>
        <td align="right">Time</td>
        <td align="left"><div id="closetime" name="closetime" value='<s:property value="closetime"/>'></div></td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td align="right">KM</td>
        <td width="19%" align="left"><input type="text" name="closekm" id="closekm" value='<s:property value="closekm"/>'></td>
        <td width="6%" align="right">Fuel</td>
        <td width="12%" align="left"><select name="cmbclosefuel" id="cmbclosefuel" value='<s:property value="cmbclosefuel"/>' style="width:90%;">
          <option value="">-Select-</option><option value=0.000>Level 0/8</option><option value=0.125 selected>Level 1/8</option><option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option><option value=0.500>Level 4/8</option>
    <option value=0.625>Level 5/8</option><option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
        </select></td>
        <input type="hidden" name="hidcmbcheckout" id="hidcmbcheckout" value='<s:property value="hidcmbcheckout"/>' >
          
        <td align="right">Total KM</td>
        <td align="left"><input type="text" id="closetotalkm" name="closetotalkm" value='<s:property value="closetotalkm"/>'></td>
        <td align="right">Avg KM/M</td>
        <td align="left"><input type="text" id="closeavgkm" name="closeavgkm" value='<s:property value="closeavgkm"/>'></td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td align="right">Check Out</td>
        <td colspan="3" align="left"><select name="cmbcheckout" id="cmbcheckout" value='<s:property value="cmbcheckout"/>' style="width:99%;">
          <option value="">--Select--</option>
        </select></td>
        <td align="right">User</td>
        <td colspan="3" align="left"><input type="text" name="closeuser" id="closeuser" value='<s:property value="closeuser"/>' style="width:99%;"></td>
        <td>&nbsp;</td>-->
      