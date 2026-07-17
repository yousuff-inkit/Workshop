<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<jsp:include page="../../../includes.jsp"></jsp:include>
<%-- <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" >
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script> --%>
<style>
.hidden-scrollbar {
  /* // overflow: auto; */
  height: 530px;
    overflow-x: hidden;
    
} 
   .headClass
        {
            background-color: #FFEBC2;
        }
        .redClass
        {
            background-color: #FFEBEB;
        }
        .violetClass
        {
            background-color: #EBD6FF;
        }
        .yellowClass
        {
            background-color: #FFFFD1;
        }
        .whiteClass
        {
           background-color: #FFF;
        }
        .greenClass
        {
           background-color: #CEFFCE;
        }
</style>
<%String id=request.getParameter("id")==null?"":request.getParameter("id");
String user=request.getParameter("user")==null?"":request.getParameter("user");
String description=request.getParameter("description")==null?"":request.getParameter("description");
String brandid=request.getParameter("brandid")==null?"":request.getParameter("brandid");
String modelid=request.getParameter("modelid")==null?"":request.getParameter("modelid");
String yomid=request.getParameter("yomid")==null?"":request.getParameter("yomid");
String regno=request.getParameter("regno")==null?"":request.getParameter("regno");
String platecode=request.getParameter("platecode")==null?"":request.getParameter("platecode");
String km=request.getParameter("km")==null?"":request.getParameter("km");
String fuel=request.getParameter("fuel")==null?"":request.getParameter("fuel");
String movdocno=request.getParameter("movdocno")==null?"":request.getParameter("movdocno");
String chassisno=request.getParameter("chassisno")==null?"":request.getParameter("chassisno");
%>
<script type="text/javascript">
$(document).ready(function() {

$("#date").jqxDateTimeInput({  width:'125px',height : '15px', formatString : "dd.MM.yyyy" });
$("#policedate").jqxDateTimeInput({  width:'125px',height : '15px', formatString : "dd.MM.yyyy" });
$("#estdate").jqxDateTimeInput({  width:'125px',height : '15px', formatString : "dd.MM.yyyy" });
$("#regexpirydate").jqxDateTimeInput({  width:'125px',height : '15px', formatString : "dd.MM.yyyy" });
$("#esttime").jqxDateTimeInput({  width:'55px',height : '15px', formatString : "HH:mm",showCalendarButton:false,value:new Date() });
$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;margin-left:50%;margin-right:50%;margin-top:15%;top:200;right:600;'><img src='../../../icons/31load.gif'/></div>");    
//$('#intime').jqxDateTimeInput('setDate', new Date());
$('#fleetwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Fleet Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#fleetwindow').jqxWindow('close');
$('#driverwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Driver Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#driverwindow').jqxWindow('close');
$('#clientwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#clientwindow').jqxWindow('close');
$('#reisterwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '30%' , title: 'Register Number Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#reisterwindow').jqxWindow('close');
$('#complaintwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Complaint Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#complaintwindow').jqxWindow('close');
$('#complaintGrid').jqxGrid({disabled:true});
$('#marketingpersonwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Estimator Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#marketingpersonwindow').jqxWindow('close');
$('#serviceadvisorwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Service Advisor Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#serviceadvisorwindow').jqxWindow('close');
$('#insurancesurvivorwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Insurance Surveyor Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#insurancesurvivorwindow').jqxWindow('close');
$('#referencedbywindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Referred By Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#referencedbywindow').jqxWindow('close');
$('#servicepackagewindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Service Package Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#servicepackagewindow').jqxWindow('close');
$('#teammasterwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Team Master Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#teammasterwindow').jqxWindow('close');
$( "#marketingperson" ).dblclick(function() {
	$('#marketingpersonwindow').jqxWindow('open');
	$('#marketingpersonwindow').jqxWindow('focus');
	SearchContent('marketingPersonSearchGrid.jsp?id=1','marketingpersonwindow');
});
$( "#serviceadvisor" ).dblclick(function() {
	$('#serviceadvisorwindow').jqxWindow('open');
	$('#serviceadvisorwindow').jqxWindow('focus');
	SearchContent('serviceAdvisorSearchGrid.jsp?id=1','serviceadvisorwindow');
});
$( "#insurancesurvivor" ).dblclick(function() {
	$('#insurancesurvivorwindow').jqxWindow('open');
	$('#insurancesurvivorwindow').jqxWindow('focus');
	SearchContent('insuranceSurvivorSearchGrid.jsp?id=1','insurancesurvivorwindow');
});
$( "#referencedby" ).dblclick(function() {
	$('#referencedbywindow').jqxWindow('open');
	$('#referencedbywindow').jqxWindow('focus');
	SearchContent('referencedBySearchGrid.jsp?id=1','referencedbywindow');
});
$( "#servicepackage" ).dblclick(function() {
	$('#servicepackagewindow').jqxWindow('open');
	$('#servicepackagewindow').jqxWindow('focus');
	SearchContent('servicePackageSearchGrid.jsp?id=1','servicepackagewindow');
});
$( "#teammaster" ).dblclick(function() {
	$('#teammasterwindow').jqxWindow('open');
	$('#teammasterwindow').jqxWindow('focus');
	SearchContent('teamMasterSearchGrid.jsp?id=1','teammasterwindow');
});
$( "#fleetno" ).dblclick(function() {
	if(document.getElementById("mode").value=="view"){
		return false;
	}
	$('#fleetwindow').jqxWindow('open');
	$('#fleetwindow').jqxWindow('focus');
	SearchContent('fleetMasterSearch.jsp','fleetwindow');
});
$( "#fleetno" ).dblclick(function() {
	if(document.getElementById("mode").value=="view"){
		return false;
	}
	$('#fleetwindow').jqxWindow('open');
	$('#fleetwindow').jqxWindow('focus');
	SearchContent('fleetMasterSearch.jsp','fleetwindow');
});

$( "#cldocno" ).dblclick(function() {
	if(document.getElementById("mode").value=="view"){
		return false;
	}
	$('#clientwindow').jqxWindow('open');
	$('#clientwindow').jqxWindow('focus');
	SearchclientContent('clientDetailsSearch.jsp?id=1','clientwindow');
});
$( "#insucompany" ).dblclick(function() {
	if(document.getElementById("mode").value=="view"){
		return false;
	}
	$('#clientwindow').jqxWindow('open');
	$('#clientwindow').jqxWindow('focus');
	SearchclientContent('clientDetailsSearch.jsp?id=2','clientwindow');
});
$( "#vehregno" ).dblclick(function() {
	if(document.getElementById("mode").value=="view"){
		return false;
	}
	$('#reisterwindow').jqxWindow('open');
	$('#reisterwindow').jqxWindow('focus');
	SearchRegisterContent('Registersearch.jsp?cldocno='+$('#cldocno').val());
});

$( "#driver" ).dblclick(function() {
	if(document.getElementById("mode").value=="view"){
		return false;
	}
	if($('#cldocno').val()==''){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Please Select Client";
		return false;
	}
	$('#driverwindow').jqxWindow('open');
	$('#driverwindow').jqxWindow('focus');
	SearchContent('driverMasterSearch.jsp?agmtexist='+$('#agmtexist').val()+'&cldocno='+$('#cldocno').val()+'&agmtno='+$('#agmtno').val(),'driverwindow');
});
$('#btnEdit').click(function(){
	if(document.getElementById("docno").value!=""){
		if(document.getElementById("editstatus").value!="1"){
			$.messager.alert('Warning','Cannot Edit,Referencial documents present');
			return false;
		}
	}
});
function getMarketingPerson(event){
	if(document.getElementById("mode").value=="view"){
		return false;
	}
	var x= event.keyCode;
    if(x==114){
    	$('#marketingpersonwindow').jqxWindow('open');
		$('#marketingpersonwindow').jqxWindow('focus');
		SearchContent('marketingPersonSearchGrid.jsp?id=1','marketingpersonwindow');
    }
    else{
    }
}
function getServiceAdvisor(event){
	if(document.getElementById("mode").value=="view"){
		return false;
	}
	var x= event.keyCode;
    if(x==114){
    	$('#serviceadvisorwindow').jqxWindow('open');
		$('#serviceadvisorwindow').jqxWindow('focus');
		SearchContent('serviceAdvisorSearchGrid.jsp?id=1','serviceadvisorwindow');
    }
    else{
    }
}
function getInsuranceSurvivor(event){
	if(document.getElementById("mode").value=="view"){
		return false;
	}
	var x= event.keyCode;
    if(x==114){
    	$('#insurancesurvivorwindow').jqxWindow('open');
		$('#insurancesurvivorwindow').jqxWindow('focus');
		SearchContent('insuranceSurvivorSearchGrid.jsp?id=1','insurancesurvivorwindow');
    }
    else{
    }
}
function getReferencedBy(event){
	if(document.getElementById("mode").value=="view"){
		return false;
	}
	var x= event.keyCode;
    if(x==114){
    	$('#referencedbywindow').jqxWindow('open');
		$('#referencedbywindow').jqxWindow('focus');
		SearchContent('referencedBySearchGrid.jsp?id=1','referencedbywindow');
    }
    else{
    }
}
function getServicePackage(event){
	if(document.getElementById("mode").value=="view"){
		return false;
	}
	var x= event.keyCode;
    if(x==114){
    	$('#servicepackagewindow').jqxWindow('open');
		$('#servicepackagewindow').jqxWindow('focus');
		SearchContent('servicePackageSearchGrid.jsp?id=1','servicepackagewindow');
    }
    else{
    }
}
function getTeamMaster(event){
	if(document.getElementById("mode").value=="view"){
		return false;
	}
	var x= event.keyCode;
    if(x==114){
    	$('#teammasterwindow').jqxWindow('open');
		$('#teammasterwindow').jqxWindow('focus');
		SearchContent('teamMasterSearchGrid.jsp?id=1','teammasterwindow');
    }
    else{
    }
}

getTestModel();
getDocDateConfig();
if($('#docno').val()!='' && $('#docno').val()!='0'){
	checkEditStatus();
}	
	$('#estdate').on('change', function (event) 
	{  
		var estdate=$('#estdate').jqxDateTimeInput('getDate');
		var gipdate=$('#date').jqxDateTimeInput('getDate');
		estdate.setHours(0,0,0,0);
		gipdate.setHours(0,0,0,0);
		if(estdate<gipdate){
			$.messager.alert('Warning','Est.Delivery Date must be greater than GIP Date');
			$('#estdate').jqxDateTimeInput('focus');
			return false;
		} 
	}); 
	$('#regexpirydate').on('change', function (event) 
	{  
		if($('#mode').val()!='view'){
			var regexpirydate=$('#regexpirydate').jqxDateTimeInput('getDate');
			var currentdate=new Date();
			regexpirydate.setHours(0,0,0,0);
			currentdate.setHours(0,0,0,0);
			if(regexpirydate<currentdate){
				$.messager.alert('Warning','Reg.Expiry Date must be greater than Current Date');
				$('#regexpirydate').jqxDateTimeInput('focus');
				return false;
			}
		}		 
	}); 
});



function SearchContent(url,id) {
    $.get(url).done(function (data) {
  $('#'+id).jqxWindow('setContent', data);
}); 
}

/* function funSearchLoad(){
	changeContent('searchGrid.jsp?id=1', $('#window'));
 } */
function funReadOnly() {
	$('#frmGateInPassCarfare input').attr('readonly',true);
	
	getYOM();
	getRtype();
	getBrand();
	getColor();
	 $('#insucompany').attr('disabled', true);
	 $('#excessamount').attr('disabled', true);
	var id='<%=id%>';
	if(id=="1"){
		funCreateBtn();
	}
	if($('#mode').val()=='view'){
		 $('#cmbbrand').attr('disabled', true);
		 $('#cmbmodel').attr('disabled', true);
		 $('#cmbyom').attr('disabled', true);
		 $('#cmbfueltype').attr('disabled', true);
		 $('#cmbrepairtype').attr('disabled', true);
		 $('#cmbinsutype').attr('disabled', true);
		 $('#cmbfaulttype').attr('disabled', true);
		 $('#complaintGrid').jqxGrid({disabled:true});
	}
}
function funRemoveReadOnly() {
	$('#frmGateInPassCarfare input').attr('readonly',false);
	$('#docno').attr('readonly',true);
	$('#cldocno').attr('readonly',true);
	
	if($('#mode').val()=='A'){
		
		
		$('#cmbbrand').attr('disabled', false);
		$('#cmbmodel').attr('disabled', false);
		$('#cmbyom').attr('disabled', false);
		$('#cmbfueltype').attr('disabled',false);
		$('#cmbrepairtype').attr('disabled', false);
		$('#cmbinsutype').attr('disabled', false);
		$('#cmbfaulttype').attr('disabled', false);
		$('#complaintGrid').jqxGrid('clear');
		$('#complaintGrid').jqxGrid({disabled:false});
		$("#complaintGrid").jqxGrid("addrow", null, {});
		$('#agmtexist').val('');
		$('#date,#estdate,#policedate,#regexpirydate').jqxDateTimeInput('setDate',new Date());
		var id='<%=id%>';
		if(id=="1"){
			getAutoClientDetails();
			var user='<%=user%>';
			var description='<%=description%>';
			var brandid='<%=brandid%>';
			var modelid='<%=modelid%>';
			var yomid='<%=yomid%>';
			var regno='<%=regno%>';
			var platecode='<%=platecode%>';
			var km='<%=km%>';
			var fuel='<%=fuel%>';
			var movdocno='<%=movdocno%>';
			var chassisno='<%=chassisno%>';
			$('#refno').val('MOV - '+movdocno);
			$('#vehusername').val(user);
			$('#description').val(description);
			$('#hidcmbbrand').val(brandid);
			$('#hidcmbmodel').val(modelid);
			/* $('#cmbbrand').val(brandid);
			$('#cmbmodel').val(modelid); */
			$('#hidcmbyom').val(yomid);
			$('#vehregno').val(regno);
			$('#vehplatecode').val(platecode);
			$('#vehkm').val(km);
			$('#cmbfueltype').val(fuel);
			$('#vehuserothers').val(chassisno);
			$('#movno').val(movdocno);
			$('#complaintGrid').jqxGrid({disabled:false});
		}
	}
	else if($('#mode').val()=='E'){
		$('#cmbbrand').attr('disabled', false);
		$('#cmbmodel').attr('disabled', false);
		$('#cmbyom').attr('disabled', false);
		$('#cmbfueltype').attr('disabled',false);
		$('#cmbrepairtype').attr('disabled', false);
		$('#cmbinsutype').attr('disabled', false);
		$('#cmbfaulttype').attr('disabled', false);
		$('#complaintGrid').jqxGrid({disabled:false});
		$("#complaintGrid").jqxGrid("addrow", null, {});
	}
	getDocDateConfig();
}
function getDocDateConfig(){
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			items = x.responseText.trim();
			$('#docdateconfig').val(items);
		} else {
		}
	}
	x.open("GET", "getDocDateConfig.jsp", true);
	x.send();
}
function checkEditStatus(){
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			items = x.responseText.trim();
			$('#editstatus').val(items);
		} else {
		}
	}
	x.open("GET", "checkEditStatus.jsp?docno="+$('#docno').val(), true);
	x.send();
}
function getAutoClientDetails(){
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			items = x.responseText.trim();
			items = items.split('***');
			$('#cldocno').val(items[0]);
			$('#clientname').val(items[1]);
			$('#clientdetails').val(items[2]);
		} else {
		}
	}
	x.open("GET", "getAutoClientDetails.jsp", true);
	x.send();
}
function setValues() {
	 document.getElementById("formdetail").value="Gate In-Pass";
     document.getElementById("formdetailcode").value="GIP";
	document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	funSetlabel();
	if($('#docno').val()!='' && $('#docno').val()!='0'){
		checkEditStatus();
	}	
	  if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
	 }
	  if($('#hidcmbbrand').val()!=""){
		  $('#cmbbrand').val($('#hidcmbbrand').val());
	  }
	  if($('#hidcmbmodel').val()!=""){
		  $('#cmbmodel').val($('#hidcmbmodel').val());
	  }
	  if($('#hidcmbyom').val()!=""){
		  $('#cmbyom').val($('#hidcmbyom').val());
	  }
	  if($('#hidcmbfueltype').val()!=""){
		  $('#cmbfueltype').val($('#hidcmbfueltype').val());
	  }
	  if($('#hidcmbrepairtype').val()!=""){
		  $('#cmbrepairtype').val($('#hidcmbrepairtype').val());
	  }
	  if($('#hidcmbinsutype').val()!=""){
		  $('#cmbinsutype').val($('#hidcmbinsutype').val());
	  }
	  if($('#hidcmbfaulttype').val()!=""){
		  $('#cmbfaulttype').val($('#hidcmbfaulttype').val());
	  }
	  if($('#hidcmbpriority').val()!=""){
		  $('#cmbpriority').val($('#hidcmbpriority').val());
	  }
	  if($('#hidcmbcolor').val()!=""){
		  $('#cmbcolor').val($('#hidcmbcolor').val());
	  }
	  if($('#hidchkclname').val()!=0){
		  
			document.getElementById("clname").checked=true;
	  }
		else{
			document.getElementById("clname").checked=false;
		
	} 
	  if($('#hidchkappr').val()!=0){
		  
			document.getElementById("apprvalchk").checked=true;
	  }
		else{
			document.getElementById("apprvalchk").checked=false;
		
	} 
	  if($('#chkbjob').val()!=0){
		  
			document.getElementById("backjob").checked=true;
	  }
		else{
			document.getElementById("backjob").checked=false;
		
	}
	  if($('#hidluxury').val()!=0){
		  
			document.getElementById("luxury").checked=true;
	  }
		else{
			document.getElementById("luxury").checked=false;
		
	}
	  if($('#chkexces').val()!=0){
		  
			document.getElementById("excesschk").checked=true;
	  }
		else{
			document.getElementById("excesschk").checked=false;
		
	}
	if($('#docno').val()!=''){
		$('#complaintdiv').load('complaintGrid.jsp?docno='+$('#docno').val()+'&branch='+$('#brchName').val()+'&id=1');		
	}
	/* if($('#hidcmbinfuel').val()!=''){
		document.getElementById('cmbinfuel').value=$('#hidcmbinfuel').val();
	} */
	
	$('#btnmaintsave,#btnmaintedit').hide();
	if(document.getElementById("docno").value!="" && document.getElementById("docno").value!="0"){
		$('#btnmaintedit').show();
	}
}

 function funFocus()
    {
    	//document.getElementById("fleetno").focus(); 
    }
  function gateinpassregchk(){
	  if($('#vehregno').val()!="" && $('#vehplatecode').val()!=""){
  		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var num = x.responseText.trim();
				document.getElementById("regpltd").value=num;
				if(parseInt(num)>0){
					$.messager.alert('Warning','Vehicle with same Reg No & Plate Code Exists');
					// return false;
				}
			} else {
			}
		}
		x.open("GET", "getregnopltid.jsp?regno="+$('#vehregno').val()+'&platecode='+$('#vehplatecode').val(), true);
		x.send();
  	}
	 
  }
 function funNotify(){
	 var dateval=funDateInPeriod($('#date').jqxDateTimeInput('getDate'));
	 if(dateval==0){
		$('#date').jqxDateTimeInput('focus');
		return false;
	 }	
	 if(document.getElementById("clname").checked==true){
	 	if(document.getElementById("insucompany").value==""){
	 		document.getElementById("insucompany").focus();
	 		document.getElementById("errormsg").innerText="";
	 		document.getElementById("errormsg").innerText="Insurance Company is Mandatory";
	 		return 0;
	 	}
	 	else{
	 		document.getElementById("errormsg").innerText="";
	 	}
	 }
	 else{
	 	document.getElementById("errormsg").innerText="";
	 }
	 var docdateconfig=$('#docdateconfig').val();
		if(docdateconfig=="1"){
			var currentdate=new Date();
			currentdate.setHours(0,0,0,0);
			var docdate=new Date($('#date').jqxDateTimeInput('getDate'));
			docdate.setHours(0,0,0,0);
			if(currentdate.getTime()!=docdate.getTime()){
				if($('#mode').val()!='E'){
					$.messager.alert('Warning','Document Date should be Current Date');
					$('#date').jqxDateTimeInput('focus');
					return 0;
				}
			}
			else{
				
			}
		}
	if($('#estdate').jqxDateTimeInput('getDate')==null){
		 document.getElementById("errormsg").innerText="";
		 document.getElementById("errormsg").innerText="Est Delivery Time is Mandatory";
	 	return 0;
	}
	var estdate=$('#estdate').jqxDateTimeInput('getDate');
	var gipdate=$('#date').jqxDateTimeInput('getDate');
	estdate.setHours(0,0,0,0);
	gipdate.setHours(0,0,0,0);
	if(estdate<gipdate){
		$.messager.alert('Warning','Est.Delivery Date must be greater than GIP Date');
		$('#estdate').jqxDateTimeInput('focus');
		return 0;
	}
	if($('#regexpirydate').jqxDateTimeInput('getDate')==null){
		 document.getElementById("errormsg").innerText="";
		 document.getElementById("errormsg").innerText="Reg.Expiry Date is Mandatory";
	 	return 0;
	}
	var regexpirydate=$('#regexpirydate').jqxDateTimeInput('getDate');
		var currentdatereg=new Date();
		regexpirydate.setHours(0,0,0,0);
		currentdatereg.setHours(0,0,0,0);
		if(regexpirydate<currentdatereg){
			$.messager.alert('Warning','Reg.Expiry Date must be greater than Current Date');
			$('#regexpirydate').jqxDateTimeInput('focus');
			return false;
		} 
	 if($('#esttime').jqxDateTimeInput('getDate')==null){
		 document.getElementById("errormsg").innerText="";
		 document.getElementById("errormsg").innerText="Est Delivery Time is Mandatory";
	 	return 0;
	 }
	 
	 if($('#cmbrepairtype').val()==''){
		 document.getElementById("errormsg").innerText="";
		 document.getElementById("errormsg").innerText="Repair Type is Mandatory";
	 	return 0;
	 }
	 
	 if(parseInt($('#regpltd').val())>0){
		 document.getElementById("errormsg").innerText="";
		 //document.getElementById("errormsg").innerText="Same Register number And Plate code Exists ";
	 	// return 0;
	 }
	 if($('#vehuserothers').val()==''){
		 document.getElementById("errormsg").innerText="";
		 document.getElementById("errormsg").innerText="Chassis Number is Mandatory";
	 	return 0;
	 }
	 
	 if($('#vehregno').val()==''){
		 document.getElementById("errormsg").innerText="";
		 document.getElementById("errormsg").innerText="Register Number is Mandatory";
	 	return 0;
	 }
		
	 if($('#vehplatecode').val()==''){
		 document.getElementById("errormsg").innerText="";
		 document.getElementById("errormsg").innerText="Platecode is Mandatory";
	 	return 0;
	 }
	 if($('#cmbbrand').val()==''){
		 document.getElementById("errormsg").innerText="";
		 document.getElementById("errormsg").innerText="Brand is Mandatory";
	 	return 0;
	 }
	 
	 if($('#cmbmodel').val()==''){
		 document.getElementById("errormsg").innerText="";
		 document.getElementById("errormsg").innerText="Model is Mandatory";
	 	return 0;
	 }
	if($('#cmbcolor').val()==''){
		 document.getElementById("errormsg").innerText="";
		 document.getElementById("errormsg").innerText="Color is Mandatory";
	 	return 0;
	 }
	 if($('#cmbyom').val()==''){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Year Of Model is Mandatory";
	 	return 0;
	 }
	
	 if($('#vehkm').val()==''){
		 document.getElementById("errormsg").innerText="";
		 document.getElementById("errormsg").innerText="Km is Mandatory";
	 	return 0;
	 }
	 if($('#latestkm').val()!='' && $('#latestkm').val()!='0'){
	 	var latestkm=parseInt($('#latestkm').val());
	 	var enteredkm=parseInt($('#vehkm').val());
	 	if(enteredkm<latestkm){
	 		document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Entered Km cannot be less than last Km";
	 		return 0;
	 	}
	 } 
	 if($('#cmbfueltype').val()==''){
		 document.getElementById("errormsg").innerText="";
		 document.getElementById("errormsg").innerText="Fuel Type is Mandatory";
	 	return 0;
	 }
	/*
	 if($('#cmbinfuel').val()==''){
		 document.getElementById("errormsg").innerText="";
		 document.getElementById("errormsg").innerText="In Fuel is Mandatory";
	 	return 0;
	 }
	 if($('#serviceduekm').val()==''){
		 document.getElementById("errormsg").innerText="";
		 document.getElementById("errormsg").innerText="Next Service Due KM is Mandatory";
	 	return 0;
	 }
	 km=parseFloat($('#inkm').val());
	 servicekm=parseFloat($('#serviceduekm').val());
	 if(servicekm<=km){
		 document.getElementById("errormsg").innerText="";
		 document.getElementById("errormsg").innerText="Next Service Due KM must be greater than In Km";
	 	return 0;
	 } */
	/* if(document.getElementById("chkdriver").checked==true){
		$('#hidchkdriver').val('1');
	}
	else{
		$('#hidchkdriver').val('0');
	} */
	var rows = $("#complaintGrid").jqxGrid('getrows');
	var gridlength=0;
	for(var i=0;i<rows.length;i++){
		if(rows[i].complaintdocno!="" && rows[i].complaintdocno!=null && rows[i].complaintdocno!="undefined" && typeof(rows[i].complaintdocno)!="undefined"){
			gridlength++;
			newTextBox = $(document.createElement("input"))
			.attr("type", "dil")
			.attr("id", "test"+i)
			.attr("name", "test"+i)
			.attr("hidden",true);
				
			newTextBox.val(rows[i].complaintdocno+"::"+rows[i].description);
			
			newTextBox.appendTo('form');
			
		}
	}
	$('#gridlength').val(gridlength);
	return 1;
 } 
 function setDriverType(){
	 if(document.getElementById("chkdriver").checked==true){
		 $('#driver').attr('readonly',false);
		 $('#driver').attr('placeholder','Please Type In');
		 $('#hidchkdriver').val('1');
	 }
	 else{
		 $('#driver').attr('readonly',true);
		 $('#driver').attr('placeholder','Press F3 to Search');
		 $('#hidchkdriver').val('0');
	 }
	 
	 
	 
 }
 
/*  function isNumber(evt,id) {
		//Function to restrict characters and enter number only
			  var iKeyCode = (evt.which) ? evt.which : evt.keyCode
		        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
		         {
		        	 $.messager.alert('Warning','Enter Numbers Only');
		           $("#"+id+"").focus();
		            return false;
		            
		         }
		        
		        return true;
		    } */
 
 function funCheckKm(value){
	 var srvcdue=$('#hidsrvcdue').val();
	 if(parseFloat(value)>parseFloat(srvcdue)){
		 $.messager.alert('Warning','Service Due Limit Exceeded');
	 }
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
 function getBrand() {
		
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('***');
				var brandItems = items[0].split(",");
				var brandidItems = items[1].split(",");
				var optionsbrand = '<option value="">--Select--</option>';
				for (var i = 0; i < brandItems.length; i++) {
					optionsbrand += '<option value="' + brandidItems[i] + '">'
							+ brandItems[i] + '</option>';
				}
				$("select#cmbbrand").html(optionsbrand);
				if ($('#hidcmbbrand').val() != null) {
					$('#cmbbrand').val($('#hidcmbbrand').val());
				}
/* 				if($('#hidcmbfueltype').val()!=""){
					  $('#cmbfueltype').val($('#hidcmbfueltype').val());
				  } */
			} else {
			}
		}
		x.open("GET", "getBrand.jsp", true);
		x.send();
	}
 function getModel(value) {
	
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				//alert("Response"+x.responseText);
				items = items.split('####');
				var modelItems = items[0].split(",");
				/* alert("=="+modelItems+"=="); */
				var modelidItems = items[1].split(",");
				//alert("=="+modelidItems+"==");
				var optionsmodel = '<option value="">--Select--</option>';
				if(modelItems!=''){
				for (var i = 0; i < modelItems.length; i++) {
					optionsmodel += '<option value="' + modelidItems[i] + '">'
							+ modelItems[i] + '</option>';
				}
				}
				$("select#cmbmodel").html(optionsmodel);
				if ($('#hidcmbmodel').val()!="") {
					$('#cmbmodel').val($('#hidcmbmodel').val());
				}
			} else {
			}
		}
		x.open("GET","getModel.jsp?id="+value, true);
		x.send();
	}
	
	 function getColor() {
	
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('***');
				var modelItems = items[0].split(",");
				var modelidItems = items[1].split(",");
				var optionsmodel = '<option value="">--Select--</option>';
				if(modelItems!=''){
				for (var i = 0; i < modelItems.length; i++) {
					optionsmodel += '<option value="' + modelidItems[i] + '">'
							+ modelItems[i] + '</option>';
				}
				}
				$("select#cmbcolor").html(optionsmodel);
				if ($('#hidcmbcolor').val()!="") {
					$('#cmbcolor').val($('#hidcmbcolor').val());
				}
			} else {
			}
		}
		x.open("GET","getColor.jsp", true);
		x.send();
	}
	function setGroup(){
		var modelid=$('#cmbmodel').val();
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText.trim();
				$('#group').val(items);
				
			} else {
			}
		}
		x.open("GET","getGroup.jsp?modelid="+modelid, true);
		x.send();
	}
 function getRtype() {
	
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('####');
				var rtypeItems = items[0].split(",");
				var rtypeidItems = items[1].split(",");
				var optionsrtype = '<option value="">--Select--</option>';
				for (var i = 0; i < rtypeItems.length; i++) {
					optionsrtype += '<option value="' + rtypeidItems[i] + '">'
							+ rtypeItems[i] + '</option>';
				}
				$("select#cmbrepairtype").html(optionsrtype);
				if ($('#hidcmbrepairtype').val() != null) {
					$('#cmbrepairtype').val($('#hidcmbrepairtype').val());
				}
			} else {
			}
		}
		x.open("GET", "getRtype.jsp", true);
		x.send();
	}
 function getFleetName(){
 	//alert("here");
 
 	/* var x = document.getElementById("cmbbrand");
     var i = x.selectedIndex;
     var x1=document.getElementById("cmbmodel");
     var i1=x1.selectedindex;
     var r=x.options[i].text;
     var r1=x1.options[i].text; */
     //alert("***"+r+"***"+r1);
     var r=$("#cmbbrand option:selected").text();
     var r1=$("#cmbmodel option:selected").text();
     document.getElementById("fleetname").value = r+" "+r1;
 }
 function getRegister(event){
     var x= event.keyCode;
     if(x==114){
    	 
    	 SearchRegisterContent('clientDetailsSearch.jsp?cldocno='+$('#cldocno').val());
     }
     else{}
     }
 function SearchRegisterContent(url) {
	    $('#reisterwindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#reisterwindow').jqxWindow('setContent', data);
		$('#reisterwindow').jqxWindow('bringToFront');
	}); 
	}
 function getClientAccount(event){
     var x= event.keyCode;
     if(x==114){
    	 SearchclientContent('clientDetailsSearch.jsp?id=1');
     }
     else{}
     }
 function SearchclientContent(url) {
	    $('#clientwindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientwindow').jqxWindow('setContent', data);
		$('#clientwindow').jqxWindow('bringToFront');
	}); 
	}
 
 function getClientinsu(event){
     var x= event.keyCode;
     if(x==114){
    	 SearchclientContent('clientDetailsSearch.jsp?id=2');
     }
     else{}
     }
 function getTestModel(){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('####');
				var modelItems = items[0].split(",");
				var modelidItems = items[1].split(",");
				var optionsmodel = '<option value="">--Select--</option>';
				for (var i = 0; i < modelItems.length; i++) {
					optionsmodel += '<option value="' + modelidItems[i] + '">'
							+ modelItems[i] + '</option>';
				}
				$("select#cmbmodel").html(optionsmodel);
				if ($('#hidcmbmodel').val() != "") {
					$('#cmbmodel').val($('#hidcmbmodel').val());
					//alert($('#hidcmbmodel').val());
				}
			} else {
			}
		}
		x.open("GET", "getTestModel.jsp", true);
		x.send();
	}
 function funSearchLoad(){
	 changeContent('Mastersearch.jsp'); 
}
 function getYOM() {
		
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('####');
				var yomItems = items[0].split(",");
				var yomidItems = items[1].split(",");
				var optionsyom = '<option value="">--Select--</option>';
				for (var i = 0; i < yomItems.length; i++) {
					optionsyom += '<option value="' + yomidItems[i] + '">'
							+ yomItems[i] + '</option>';
				}
				$("select#cmbyom").html(optionsyom);
				if ($('#hidcmbyom').val() != null) {
					$('#cmbyom').val($('#hidcmbyom').val());
				}
			} else {
			}
		}
		x.open("GET", "getYOM.jsp", true);
		x.send();
	}
 function company(){
		if(document.getElementById("clname").checked==true){
			 $('#insucompany').attr('disabled', false);
			
		}
		else{
			$('#insucompany').attr('disabled', true);
		}
	 
 }
 function excess(){
		if(document.getElementById("excesschk").checked==true){
			 $('#excessamount').attr('disabled', false);
			
		}
		else{
			$('#excessamount').attr('disabled', true);
		}
	 
} 
 function funPrintBtn(){
	   if (($("#mode").val() != "A") && $("#docno").val()!="") {
	  
	      
	   var url=document.URL;
	   if(url.includes("gateInPass.jsp")){
	 		 reurl=url.split("gateInPass.jsp");
	 	  }
	 	  else{
	 		 reurl=url.split("GateInPassSave");
	 	  }
 // var reurl=url.split("gateInPass.jsp");
  $("#docno").prop("disabled", false);                
  
//var win= window.open(reurl[0]+"printRA?docno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");

//var win= window.open(reurl[0]+"/epicraprint1.jsp","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
  var win= window.open(reurl[0]+"Gateinpassprint?docno="+document.getElementById("docno").value+"&formdetailcode=GIP","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
  win.focus(); 
	   } 
	  
	   else {
	      $.messager.alert('Message','Select a Document....!','warning');
	      return false;
	     }
	
	}
	
	
	function funMaintenanceEdit(){
		if($('#docno').val()=='0' || $('#docno').val()==''){
			$.messager.alert('Warning','Please select a valid document');
		}
		else{
			$('#maintenanceremarks,#policereport,#policedate,#policestation,#cmbinsutype,#cmbfaulttype,#claim,#lpo,#lpoamount,#excesschk').attr('disabled',false);
			$('#maintenanceremarks,#policereport,#policedate,#policestation,#cmbinsutype,#cmbfaulttype,#claim,#lpo,#lpoamount,#excesschk,#excessamount').attr('readonly',false);
			$('#btnmaintedit').hide();
			$('#btnmaintsave').show();
		}
	}  
	function funMaintenanceSave(){
		var docno=$('#docno').val();
		var branch=$('#brchName').val();
		var remarks=$('#maintenanceremarks').val();
		var policereport=$('#policereport').val();
		var policedate=$('#policedate').jqxDateTimeInput('val');
		var policestation=$('#policestation').val();
		var cmbinsurtype=$('#cmbinsutype').val();
		var cmbfaulttype=$('#cmbfaulttype').val();
		var claim=$('#claim').val();
		var lpo=$('#lpo').val();
		var lpoamount=$('#lpoamount').val();
		var chkexcess=0;
		if(document.getElementById("excesschk").checked==true){
			chkexcess=1;
		}
		else{
			chkexcess=0;
		}
		var excessamount=$('#excessamount').val();
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText.trim();
				if(items=="1"){
					$.messager.alert('Message','Successfully Updated');
					$('#maintenanceremarks,#policereport,#policedate,#policestation,#cmbinsutype,#cmbfaulttype,#claim,#lpo,#lpoamount,#excesschk,#excessamount').attr('readonly',true);
					$('#btnmaintedit').show();
					$('#btnmaintsave').hide();
				}
				else if(items=="2"){
					$.messager.alert('Message','Invoiced, Cannot Update');
					$('#maintenanceremarks,#policereport,#policedate,#policestation,#cmbinsutype,#cmbfaulttype,#claim,#lpo,#lpoamount,#excesschk,#excessamount').attr('readonly',true);
					$('#btnmaintedit').show();
					$('#btnmaintsave').hide();
				}
				else{
					$.messager.alert('Message','Not Updated');
				}
			} else {
			}
		}
		x.open("GET", "maintenanceDetailsUpdate.jsp?docno="+docno+"&remarks="+remarks+"&policereport="+policereport+"&policedate="+policedate+"&policestation="+policestation+"&cmbinsurtype="+cmbinsurtype+"&cmbfaulttype="+cmbfaulttype+"&claim="+claim+"&lpo="+lpo+"&lpoamount="+lpoamount+"&chkexcess="+chkexcess+"&excessamount="+excessamount+"&branch="+branch, true);
		x.send();
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
</script>
<style>
	
</style>
</head>	
<body onLoad="setValues();">
	<div id="mainBG" class="homeContent" data-type="background"> 
		<form id="frmGateInPassCarfare" action="carfareGateInPassSave" method="post" autocomplete="off" class="form-inline">
			<jsp:include page="../../../header.jsp" />
            <br>
            <div class='hidden-scrollbar'>
   				<table  width="100%" >
   			  		<tr>
   			    		<td width="9%" align="right">Date</td>
   			    		<td width="31%"><div id="date" name="date" value='<s:property value="date"/>'></div></td>
   			   			<td width="9%" align="right">Ref No</td>
   			    		<td width="31%"><input type="text" name="refno" id="refno" readonly tabindex="-1" value='<s:property value="refno"/>'>
   			    		<td width="20%" align="right">Doc No</td>
   			    		<td width="20%"><input type="text" name="vocno" id="vocno" readonly tabindex="-1" value='<s:property value="vocno"/>'>
   			    		<input type="hidden" name="docno" id="docno" readonly tabindex="-1" value='<s:property value="docno"/>'></td>              
		      		</tr>
		  		</table>
		  		<fieldset class="headClass"><legend>Client Details</legend>
           	  		<table width="100%" >
  						<tr>
						    <td width="9%" align="right">Client Doc No</td>
						    <td width="5%"><input type="text" name="cldocno" id="cldocno" placeholder="Press F3 to Search" readonly value='<s:property value="cldocno"/>' onkeydown="getClientAccount(event);" style="width:99%;"></td>
						    <td width="5%" align="right">Name</td>
						    <td width="30%"><input type="text" name="clientname" id="clientname" readonly value='<s:property value="clientname"/>' style="width:85%;"></td>
   							<td width="20%" align="left"><input type="checkbox" id="clname" name="clname"  onclick="$(this).attr('value', this.checked ? 1 : 0)" onchange="company()" value='<s:property value="clname"/> '/>Bill To Insurance Company
                        	<input type="hidden"  name="hidchkclname" id="hidchkclname" value='<s:property value="hidchkclname"/> '/></td>
      						<td width="5%" align="right">Name</td> 
    						<td width="30%"><input type="text" name="insucompany" id="insucompany" placeholder="Press F3 to Search" readonly value='<s:property value="insucompany"/>'onkeydown="getClientinsu(event);" style="width:85%;" ></td>
  						</tr>
  					</table>
  					<table width="100%" border="0" >
  						<tr>
    						<td width="6%" align="right">Details</td>
						    <td width="35%"><input type="text" name="clientdetails" id="clientdetails"  placeholder="Enter Details" readonly value='<s:property value="clientdetails"/>' style="width:99%;"></td>
						    <td width="8%" align="right"></td>
						    <td width="16%"><input type="hidden" name="salesmandocno" id="salesmandocno" readonly value='<s:property value="salesmandocno"/>'></td>
  						</tr>
  						<tr>
    						<td align="right">Description</td>
    						<td colspan="6"><input type="text" name="description" id="description"  value='<s:property value="description"/>'  placeholder="Enter Description" style="width:99%;"></td>
   						</tr>
   					</table>
     				<table width="100%" >
    					<tr>
     						<td width="9.3%" align="right"></td>
    						<td colspan="1%" align="left"><input type="checkbox" id="backjob" name="backjob"  onclick="$(this).attr('value', this.checked ? 1 : 0)" value='<s:property value="backjob"/> '/>Back Job
							<input type="hidden"  name="chkbjob" id="chkbjob" value='<s:property value="chkbjob"/> '/></td>
    						<td colspan="1%" align="left"><input type="checkbox" id="luxury" name="luxury"  onclick="$(this).attr('value', this.checked ? 1 : 0)" value='<s:property value="luxury"/> '/>Luxury
							<input type="hidden"  name="hidluxury" id="hidluxury" value='<s:property value="hidluxury"/> '/></td>
    						<td width="9.3%" align="right"></td>
    						<td width="10%" align="left"><input type="hidden" id="apprvalchk" name="apprvalchk"  onclick="$(this).attr('value', this.checked ? 1 : 0)" value='<s:property value="apprvalchk"/> style="opacity:0;'/>
    						<input type="hidden"  name="hidchkappr" id="hidchkappr" value='<s:property value="hidchkappr"/> '/></td>
       					</tr>
					</table>
            	</fieldset>
    			<fieldset class="violetClass"><legend>Vehicle Details</legend>
<table width="100%" border="0">
<tr>
<td width="9%" align="right">User Name</td>
<td width="16%"><input type="text" name="vehusername" id="vehusername" placeholder="Enter User Name" value='<s:property value="vehusername"/>'></td>
<td width="11%" align="right">Mobile</td>
<td width="17%"><input type="text" name="vehusermobile" id="vehusermobile" placeholder="Enter Mobile Number" value='<s:property value="vehusermobile"/>'></td>
<td width="7%" align="right">Email</td>
<td width="15%"><input type="text"name="vehuseremail" id="vehuseremail" placeholder="Enter Email" value='<s:property value="vehuseremail"/>'></td>
<td width="7%" align="right">Chassis no</td>
<td width="18%"><input type="text"name="vehuserothers" id="vehuserothers" placeholder="Enter chassis Number" value='<s:property value="vehuserothers"/>'></td>
<td width="6%" align="right">Reg No</td>
<td width="16%"><input type="text"name="vehregno" id="vehregno" onkeypress="javascript:return isNumber (event,id)" onchange="gateinpassregchk();" value='<s:property value="vehregno"/>'placeholder="Enter Register Number" onkeydown="getRegister(event);"></td>
<input type="hidden" name="regnoexist" id="regnoexist" value='<s:property value="regnoexist"/>'>
<input type="hidden" name="regnoexistgipvocno" id="regnoexistgipvocno" value='<s:property value="regnoexistgipvocno"/>'>
</tr>
<tr>
<td align="right">Plate Code/ Authorities</td>
<td><input type="text" name="vehplatecode" id="vehplatecode" onchange="gateinpassregchk();" placeholder="Enter Platecode" value='<s:property value="vehplatecode"/>'></td>
<td width="11%" align="right">Brand</td>
<td width="17%"><select name="cmbbrand" id="cmbbrand" value='<s:property value="cmbbrand"/>' style="width:81%;" onchange="getModel(this.value);">
<option>--Select--</option>
</select></td>
<td align="right">Model</td>
<td><select name="cmbmodel" id="cmbmodel" value='<s:property value="cmbmodel"/>' style="width:75%;" onchange="setGroup();getFleetName();">
<option>--Select--</option>
</select>
<input type="hidden" id="hidcmbmodel" name="hidcmbmodel" value='<s:property value="hidcmbmodel"/>' /></td>
<input type="hidden" id="hidcmbbrand" name="hidcmbbrand" value='<s:property value="hidcmbbrand"/>'/>
<td align="right">Group</td>
<td><input type="text" id="group" name="group" value='<s:property value="group"/>' /></td>
<td align="right">YOM</td>
<td><select name="cmbyom" id="cmbyom" value='<s:property value="cmbyom"/>'>
<option>--Select--</option>
</select>
<input type="hidden" id="hidcmbyom" name="hidcmbyom" value='<s:property value="hidcmbyom"/>' /></td>

</tr>
<tr>
<td align="right">Color</td>
<td><select name="cmbcolor" id="cmbcolor" value='<s:property value="cmbcolor"/>'>
<option>--Select--</option>
</select>
<input type="hidden" id="hidcmbcolor" name="hidcmbcolor" value='<s:property value="hidcmbcolor"/>' /></td>
<td align="right">Remarks</td>
<td colspan="3"><input type="text"name="vehothers" id="vehothers" placeholder="Enter Remarks" value='<s:property value="vehothers"/>' style="width:99%;"></td>
<td align="right">Km</td>
<td align="left"><input type="text"name="vehkm" id="vehkm" placeholder="Enter km" value='<s:property value="vehkm"/>'></td>
<td align="right">Fuel</td>
<td align="left"><input type="hidden" id="hidcmbfueltype" name="hidcmbfueltype" value='<s:property value="hidcmbfueltype"/>' />
<select name="cmbfueltype" id="cmbfueltype" value='<s:property value="cmbfueltype"/>'>
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
</select></td>
</tr>
<tr>
<td align="right">Repair Type</td>
<td><select name="cmbrepairtype" id="cmbrepairtype" >
<option value="">-Select-</option>
</select>
<input type="hidden" id="hidcmbrepairtype" name="hidcmbrepairtype" value='<s:property value="hidcmbrepairtype"/>' /></td>
<td align="right">Priority</td>
<td><select name="cmbpriority" id="cmbpriority" >
<option value="1" selected>Normal</option>
<option value="2">High</option>
<option value="3">Back Job</option>
</select>
<input type="hidden" id="hidcmbpriority" name="hidcmbpriority" value='<s:property value="hidcmbpriority"/>' /></td>
<td align="right">Est Delivery Date</td>
<td><div id="estdate" name="estdate" value='<s:property value="estdate"/>'></div></td>
<td align="right">Est Delivery Time</td>
<td align="left"><div id="esttime" name="esttime" value='<s:property value="esttime"/>'></div></td>
<td align="right">Reg. Expiry</td>
<td align="left"><div id="regexpirydate" name="regexpirydate" value='<s:property value="regexpirydate"/>'></div></td>
</tr>
</table>
</fieldset>
					<fieldset class="greenClass"><legend>Maintenance Details</legend>
						<table width="100%" border="0">
  							<tr> 
    							<td width="11%"  align="right">Remarks</td>
    							<td colspan="3"><input type="text"name="maintenanceremarks" id="maintenanceremarks" placeholder="Enter Remarks" value='<s:property value="maintenanceremarks"/>' style="width:99%;"></td>
    						</tr>
  							<tr>
							    <td  align="right">Police Report</td>
							    <td><input type="text"name="policereport" id="policereport" placeholder="Enter Police Report" value='<s:property value="policereport"/>'></td>
							    <td  align="right">Report Date</td>
							    <td width="17%"><div id="policedate" name="policedate" value='<s:property  value="policedate"/>'></div></td>
							    <td width="7%"  align="right">Station Name</td>
							    <td width="40%"><input type="text"name="policestation" id="policestation" placeholder="Enter Station Name" value='<s:property value="policestation"/>' style="width:99%;"></td>
  							</tr>
  							<tr>
    							<td  align="right">Insurance Type</td>
     							<td width="15%">
     								<select name="cmbinsutype" id="cmbinsutype" >
		 								<option value="">--Select--</option>
		 								<option value="1">comprehensive</option>
		  								<option value="2">Third party </option>	
		  								<option value="3">Unknown</option>
	    							</select>
	    							<input type="hidden" id="hidcmbinsutype" name="hidcmbinsutype" value='<s:property value="hidcmbinsutype"/>' />
	    						</td>
    							<td  align="right">Fault Type</td>
    							<td width="15%">
    								<select name="cmbfaulttype" id="cmbfaulttype" >
		 								<option value="">--Select--</option>
		  								<option value="1">Third party </option>
		  								<option value="2">Own</option>
	    							</select>
	    							<input type="hidden" id="hidcmbfaulttype" name="hidcmbfaulttype" value='<s:property value="hidcmbfaulttype"/>' />
	    						</td>
    							<td>&nbsp;</td>
    							<td>&nbsp;</td>
  							</tr>
  							<tr>
    							<td  align="right">Claim no.</td>
    							<td><input type="text" name="claim"id="claim" placeholder="Enter Claim Number" value='<s:property value="claim"/>'> </td>
    							<td  align="right">LPO</td>
    							<td><input type="text"name="lpo" id="lpo" placeholder="Enter lpo" value='<s:property value="lpo"/>'></td>
							    <td  align="right">LPO Amount</td>
							    <td><input type="text"name="lpoamount" id="lpoamount"  placeholder="Enter lpo Amount" value='<s:property value="lpoamount"/>' style="text-align:right;" onkeypress="javascript:return isNumber (event,id)" onblur="funRoundAmt(value,id);"></td>
							    <td  align="right">
							    	<button type="button" name="btnmaintedit" id="btnmaintedit" class="myButton" onclick="funMaintenanceEdit();">EDIT</button>
    								<button type="button" name="btnmaintsave" id="btnmaintsave" class="myButton" onclick="funMaintenanceSave();">SAVE</button>
    							</td>
  							</tr>
  							<tr>
  								<td  align="right">Excess</td>
  								<td width="10%" align="left">
  									<input type="checkbox" id="excesschk" name="excesschk"  onclick="$(this).attr('value', this.checked ? 1 : 0)" onchange="excess()" value='<s:property value="excesschk"/> '/>
  									<input type="hidden"  name="chkexces" id="chkexces" value='<s:property value="chkexces"/> '/>
  								</td>
    							<td  align="right">Excess Amount</td>
    							<td><input type="text"name="excessamount" id="excessamount" placeholder="Enter Excess Amount" value='<s:property value="excessamount"/>' style="text-align:right;" onkeypress="javascript:return isNumber (event,id)" onblur="funRoundAmt(value,id);"></td>
    							<td>&nbsp;</td>
    							<td>&nbsp;</td>
  							</tr>
    					</table>
					</fieldset>
					<fieldset style="margin-top:15px;margin-bottom:10px;">
						<table>
							<tr>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td>Estimator</td>
								<td><input type="text" name="marketingperson" id="marketingperson" value='<s:property value="marketingperson"/>' onkeydown="getMarketingPerson(event);" placeholder="Press F3 to Search"></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td>Service Advisor</td>
								<td><input type="text" name="serviceadvisor" id="serviceadvisor" value='<s:property value="serviceadvisor"/>' onkeydown="getServiceAdvisor(event);" placeholder="Press F3 to Search"></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td><!-- Insurance Surveyor --></td>
								<td><input type="hidden" name="insurancesurvivor" id="insurancesurvivor" value='<s:property value="insurancesurvivor"/>' onkeydown="getInsuranceSurvivor(event);" placeholder="Press F3 to Search"></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td><!-- Referred By --></td>
								<td><input type="hidden" name="referencedby" id="referencedby" value='<s:property value="referencedby"/>' onkeydown="getReferencedBy(event);" placeholder="Press F3 to Search"></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td><!-- Service Package --></td>
								<td><input type="hidden" name="servicepackage" id="servicepackage" value='<s:property value="servicepackage"/>' onkeydown="getServicePackage(event);" placeholder="Press F3 to Search"></td>
								<input type="hidden" name="teammaster" id="teammaster" value='<s:property value="teammaster"/>' onkeydown="getTeamMaster(event);" placeholder="Press F3 to Search">
							</tr>
						</table>
					</fieldset>
					<fieldset class="redClass">
						<legend>Complaints</legend>
    					<table width="100%" border="0">
  							<tr>
    							<td><div id="complaintdiv"><jsp:include page="complaintGrid.jsp"></jsp:include></div></td>
  							</tr>
						</table>
					</fieldset>
					<input type="hidden" id="hidmarketingperson" name="hidmarketingperson" value='<s:property value="hidmarketingperson"/>'/>
					<input type="hidden" id="hidserviceadvisor" name="hidserviceadvisor" value='<s:property value="hidserviceadvisor"/>'/>
					<input type="hidden" id="hidinsurancesurvivor" name="hidinsurancesurvivor" value='<s:property value="hidinsurancesurvivor"/>'/>
					<input type="hidden" id="hidreferencedby" name="hidreferencedby" value='<s:property value="hidreferencedby"/>'/>
					<input type="hidden" id="hidservicepackage" name="hidservicepackage" value='<s:property value="hidservicepackage"/>'/>
					<input type="hidden" id="hidteammaster" name="hidteammaster" value='<s:property value="hidteammaster"/>'/>
					<input type="hidden" id="movno" name="movno" value='<s:property value="movno"/>'/>
					<input type="hidden" id="gridlength" name="gridlength" value='<s:property value="gridlength"/>'/>
					<input type="hidden" id="clientid" name="clientid" value='<s:property value="clientid"/>'/>
					<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
					<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
					<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
					<input type="hidden" name="regpltd" id="regpltd" value='<s:property value="regpltd"/>'/>
					<input type="hidden" name="docdateconfig" id="docdateconfig" value='<s:property value="docdateconfig"/>'/>
					<input type="hidden" name="latestkm" id="latestkm" value='<s:property value="latestkm"/>'/>
					<input type="hidden" name="editstatus" id="editstatus" value='<s:property value="editstatus"/>'/>
				</div>
			</form>
		</div>
	<div id="marketingpersonwindow">
		<div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
	</div>
	<div id="serviceadvisorwindow">
		<div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
	</div>
	<div id="insurancesurvivorwindow">
		<div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
	</div>
	<div id="referencedbywindow">
		<div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
	</div>
	<div id="servicepackagewindow">
		<div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
	</div>
	<div id="teammasterwindow">
		<div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
	</div>
	<div id="fleetwindow">
		<div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
	</div>
	<div id="driverwindow">
	<div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
	</div>
	<div id="complaintwindow">
		<div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
	</div>
	<div id="clientwindow">
		<div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
	</div>
	<div id="reisterwindow">
		<div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
	</div>
</body>
</html>