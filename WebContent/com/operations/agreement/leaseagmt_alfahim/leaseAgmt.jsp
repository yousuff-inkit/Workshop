<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 <link href="../../../../css/body.css" rel="stylesheet" type="text/css"> 
<% String contextPath=request.getContextPath();%>
<%
	String mod = request.getParameter("mod") == null ? "view" : request
			.getParameter("mod").toString();
String nmonth = request.getParameter("nmonth") == null? "0": request.getParameter("nmonth").toString();
int nomon = Integer.parseInt(nmonth);

String tot = request.getParameter("totalval") == null? "0": request.getParameter("totalval").toString();
float totalval=Float.parseFloat(tot);
String larefdoc = request.getParameter("larefdoc") == null? "0": request.getParameter("larefdoc").toString();
String blaf_srno = request.getParameter("blaf_srno") == null? "0": request.getParameter("blaf_srno").toString();
String clientid = request.getParameter("clientid") == null? "0": request.getParameter("clientid").toString();
String clientname = request.getParameter("clientname") == null? "0": request.getParameter("clientname").toString();
String le_clacno = request.getParameter("le_clacno") == null? "0": request.getParameter("le_clacno").toString();
String le_clcodeno = request.getParameter("le_clcodeno") == null? "0": request.getParameter("le_clcodeno").toString();
String salesman = request.getParameter("salesman") == null? "0": request.getParameter("salesman").toString();
String le_salmanid = request.getParameter("le_salmanid") == null? "0": request.getParameter("le_salmanid").toString();
 String fulldetail = request.getParameter("fulldetail") == null? "0": request.getParameter("fulldetail").toString();
 String kmuse = request.getParameter("kmuse") == null? "0": request.getParameter("kmuse").toString();
 String exrate = request.getParameter("exrate") == null? "0": request.getParameter("exrate").toString();
 	
%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<!-- <link rel="stylesheet" type="text/css" href="../../../../css/body.css"> -->

<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
.hidden-scrollbar {
    overflow: auto;
    height: 530px;
}
.custom-checkbox{
	width: 15px; 
	height: 15px;
	border: 1px solid #aaa;
  background: #f8f8f8;
  border-radius: 5px;
  /*box-shadow: inset 0 1px 3px rgba(0,0,0,.3);*/
  transition: all .2s;
}
</style>
<script type="text/javascript">
var mod1='<%=mod%>';
$(document).ready(function () {
	$('#pyttotalrent,#pytadvance,#pytbalance,#pytstartdate,#pytmonthsno,#pytbankacno').change(function(){
		$('#pytDetailsGrid').jqxGrid('clear');
	});
	  /* create jqxMenu */
     $("#jqxMenuMore").jqxMenu({ width: '20%', height: '30px', autoSizeMainItems: true});
    $("#jqxMenuMore").jqxMenu('minimize');            
    $("#jqxMenuMore").css('visibility', 'visible');     
     
   /*   Menu-minimized window  */
     $('#windows2').jqxWindow({width: '71%', height: '70%',  maxHeight: '70%' ,maxWidth: '80%' , title: 'Details',position: { x: 180, y: 60 } , theme: 'energyblue', showCloseButton: true,keyboardCloseKey: 27});
	$('#windows2').jqxWindow('close');   
	$('#btnpytsave,#btnpytcancel,#btnprocess').hide();
	$('#btnpytedit').attr('disabled',true);	
	if(document.getElementById("docno").value!=""){
		$('#btnpytedit').attr('disabled',false);	
	}
	//SetLeaseOwn();
$("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
$("#pytstartdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});

$("#dateout").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection: true,value:null});
$("#deldateout").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection: true,value:null});
$("#timeout").jqxDateTimeInput({ width: '80%', height: '17px', formatString: 'HH:mm', showCalendarButton: false ,value:null});
$("#deltimeout").jqxDateTimeInput({ width: '80%', height: '17px', formatString: 'HH:mm', showCalendarButton: false,value:null });
$('#clientinfowindow').jqxWindow({ width: '62%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Client Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#clientinfowindow').jqxWindow('close');
$('#driverinfowindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '62%' ,maxWidth: '50%' , title: 'Driver Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#driverinfowindow').jqxWindow('close');
$('#chauffeurinfowindow').jqxWindow({ width: '30%', height: '58%',  maxHeight: '62%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#chauffeurinfowindow').jqxWindow('close');
$('#vehinfowindow').jqxWindow({ width: '60%', height: '67%',  maxHeight: '70%' ,maxWidth: '70%' , title: ' Fleet Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#vehinfowindow').jqxWindow('close');
$('#deldrvwindow').jqxWindow({ width: '30%', height: '62%',  maxHeight: '54%' ,maxWidth: '50%' , title: 'Driver Search' ,position: { x: 650, y: 110 }, keyboardCloseKey: 27});
$('#deldrvwindow').jqxWindow('close');


$('#projectwindow').jqxWindow({ width: '30%', height: '62%',  maxHeight: '54%' ,maxWidth: '50%' , title: 'Project Search' ,position: { x: 800, y: 150 }, keyboardCloseKey: 27});
$('#projectwindow').jqxWindow('close');
$('#servicelevelwindow').jqxWindow({ width: '30%', height: '62%',  maxHeight: '54%' ,maxWidth: '50%' , title: 'Service Level Search' ,position: {  x: 250, y: 60 }, keyboardCloseKey: 27});
$('#servicelevelwindow').jqxWindow('close');
$('#bankacnowindow').jqxWindow({ width: '30%', height: '62%',  maxHeight: '54%' ,maxWidth: '50%' , title: 'Bank Account Search' ,position: {  x: 250, y: 60 }, keyboardCloseKey: 27});
$('#bankacnowindow').jqxWindow('close');
/* $("#btnEdit").attr('disabled', true );
 */

$('#clientid').dblclick(function(){
	
	if($('#mode').val()!='E'){
		  $('#clientinfowindow').jqxWindow('open');
	      $('#clientinfowindow').jqxWindow('focus');
	      clieninfoSearchContent('clientINgridsearch.jsp', $('#clientinfowindow'));		
	}

     });
     
$('#leaseproject').dblclick(function(){
    $('#projectwindow').jqxWindow('open');
  $('#projectwindow').jqxWindow('focus');
 projectinfoSearchContent('searchproject.jsp');
 });   
   
$('#servicelevel').dblclick(function(){
    $('#servicelevelwindow').jqxWindow('open');
  $('#servicelevelwindow').jqxWindow('focus');
 servicelevelSearchContent('getServicelevel.jsp?id=1&latype='+$('#latype').val()+'&larefdocno='+$('#larefdoc').val());
 });
$('#pytbankacno').dblclick(function(){
    $('#bankacnowindow').jqxWindow('open');
  $('#bankacnowindow').jqxWindow('focus');
 bankacnoSearchContent('getBankAccount.jsp?id=1');
 });

$('#deldrvname').dblclick(function(){
    $('#deldrvwindow').jqxWindow('open');
  $('#deldrvwindow').jqxWindow('focus');
  drvdelSearchContent('Searchdeldriver.jsp?', $('#deldrvwindow'));  
 });  
     
$('#ladriverlist').dblclick(function(){
    $('#chauffeurinfowindow').jqxWindow('open');
  $('#chauffeurinfowindow').jqxWindow('focus');
  chauffeurSearchContent('SearchChauffeur.jsp', $('#chauffeurinfowindow'));
 });

$('#permanentfleet').dblclick(function(){
	
	   $('#vehinfowindow').jqxWindow('open');
  $('#vehinfowindow').jqxWindow('focus');
  vehinfoSearchContent('vehinfo.jsp', $('#vehinfowindow'));
 }); 

$('#tempfleet').dblclick(function(){

    $('#vehinfowindow').jqxWindow('open');
  $('#vehinfowindow').jqxWindow('focus');
  vehinfoSearchContent('vehinfotemp.jsp', $('#vehinfowindow'));
		
 }); 
     
$('#date').on('change', function (event) {
	  
    var maindate = $('#date').jqxDateTimeInput('getDate');
  	 if ($("#mode").val() == "A") {   
    funDateInPeriod(maindate);
  	 }
   });
$('#dateout').on('change', function (event) {
	 
    var dateout = $('#dateout').jqxDateTimeInput('getDate');
    
	 if ($("#mode").val() == "ADD") {  
		
	
    funDateInPeriod(dateout);
	 }
	
	 
   });
     
$('#deldateout').on('change', function (event) {
	
	 if ($("#mode").val() == "DLY") {  
		
	   var indate1=new Date($('#dateout').jqxDateTimeInput('getDate')); 
	// out date
	  var agmtdate1=new Date($('#deldateout').jqxDateTimeInput('getDate')); //del date
	  
	  indate1.setHours(0,0,0,0);
	  agmtdate1.setHours(0,0,0,0);
	  
	  
	   if(indate1>agmtdate1){
	   document.getElementById("errormsg").innerText="Delivery Date Cannot be Less than Out Date";
	   
	   return false;
	  }   
	
	   else{
	  
	   document.getElementById("errormsg").innerText="";  
	   }
		
	 }
    });


$('#deltimeout').on('change', function (event) {
	   
	 if ($("#mode").val() == "DLY") {  
		 $('#dateout').jqxDateTimeInput({ disabled: false}); 
		 $('#timeout').jqxDateTimeInput({ disabled: false}); 
		 
	   var indate1=new Date($('#dateout').jqxDateTimeInput('getDate'));     // out date
	  var agmtdate1=new Date($('#deldateout').jqxDateTimeInput('getDate')); //del date
	 
	  var intime1=new Date($('#timeout').jqxDateTimeInput('getDate'));  //out time
	  var agmttime1=new Date($('#deltimeout').jqxDateTimeInput('getDate')); // del time  
	 
	  indate1.setHours(0,0,0,0);
	  agmtdate1.setHours(0,0,0,0);
	  
	  
	   if(indate1>agmtdate1){
	   document.getElementById("errormsg").innerText="Delivery Date Cannot be Less than Out Date";
		 $('#dateout').jqxDateTimeInput({ disabled: true}); 
		 $('#timeout').jqxDateTimeInput({ disabled: true}); 
	   return false;
	  }   
	
	   if(indate1.valueOf()==agmtdate1.valueOf()){
	 
	  var out=intime1.getHours();
	  var del=agmttime1.getHours();
	
	  if(out > del){
		   
	    document.getElementById("errormsg").innerText="Delivery Time Cannot be Less than Out Time";
		 $('#dateout').jqxDateTimeInput({ disabled: true}); 
		 $('#timeout').jqxDateTimeInput({ disabled: true}); 
	    return false;
	   }
	   if(out==del){
	    if(intime1.getMinutes()>agmttime1.getMinutes()){
	     document.getElementById("errormsg").innerText="Delivery Time Cannot be Less than Out Time";
		 $('#dateout').jqxDateTimeInput({ disabled: true}); 
		 $('#timeout').jqxDateTimeInput({ disabled: true}); 
	     return false;
	    }
	   }
	  }
		 $('#dateout').jqxDateTimeInput({ disabled: true}); 
		 $('#timeout').jqxDateTimeInput({ disabled: true}); 
	   document.getElementById("errormsg").innerText="";  
	  
	 }

    });
  
  
});
function  funReadOnly(){
	
	$("#jqxMenuMore").css('visibility', 'visible');  
	$('#docno').attr('disabled', true);
	$('#date').jqxDateTimeInput({ disabled: true});
	$('#dateout').jqxDateTimeInput({ disabled: true});
	$('#deldateout').jqxDateTimeInput({ disabled: true});
	$('#frmLeaseAgreement_AlFahim input').attr('disabled', true );
	$('#frmLeaseAgreement_AlFahim textarea').attr('disabled', true );
	$('#frmLeaseAgreement_AlFahim select').attr('disabled', true);
	 $('#nwevehgrid').jqxGrid({ disabled: true}); 
	
	$('#rateGrid').jqxGrid({ disabled: true});
	  $('#ladriverlist').attr('readonly', true);
	  $('#adidrvcharges').attr('readonly', true);
	
	$('#btnupdate').attr('disabled', false);
	$('#leaseprintbtn').attr('disabled', false);
	
	if($('#delchkvalue').val()==1)
	  {
		
	$('#btndelupdate').attr('disabled', false);
	  }
	
	else
		{
		$('#btndelupdate').attr('disabled', true);
		}
	 $("#jqxgrid2").jqxGrid({ disabled: true});
	 $("#jqxgridpayment").jqxGrid({ disabled: true});
	 document.getElementById("btndelupdate").value="Edit";
	 document.getElementById("btnupdate").value="Edit";
	 

	 $("#cleardata").hide();	
	 
	 
	 $('#pytstartdate').jqxDateTimeInput({disabled:true});
	 $('#btnprocess,#btncreatecheque').attr('disabled',true);
	 
	 if(document.getElementById("status").value.trim()=="0" )
		{
		mod1="view";
		}
		if(mod1=="A")
			{
			
			 document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
			document.getElementById("formdetail").value=window.parent.formName.value;
			document.getElementById("formdetailcode").value=window.parent.formCode.value.trim(); 
			funCreateBtn();
			}
	 
		
		
		$("#docno").attr('disabled', false );
}

function btndisabled()
{
	

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
function getclientinfo(event){
     	 var x= event.keyCode;
     	 if(x==114){
     		if($('#mode').val()!='E'){
     			  $('#clientinfowindow').jqxWindow('open');
     		      $('#clientinfowindow').jqxWindow('focus');
     		      clieninfoSearchContent('clientINgridsearch.jsp', $('#clientinfowindow'));		
     		}
		}
      	 else{
     		 }
}
            	 
function clieninfoSearchContent(url) {
	 //alert(url);
     	 $.get(url).done(function (data) {
			 //alert(data);
	$('#clientinfowindow').jqxWindow('setContent', data);

                   	}); 
         	}
function getproject(event){
	
	 var x= event.keyCode;
	 if(x==114){
	  $('#projectwindow').jqxWindow('open');

 // $('#accountWindow').jqxWindow('focus');
	  projectinfoSearchContent('searchproject.jsp'); 	 }
	 else{
		 }
	 }
	 
function getServiceLevel(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#servicelevelwindow').jqxWindow('open');
	  servicelevelSearchContent('getServicelevel.jsp?id=1'); 	 }
	 else{
		 }
	 }
function getBankacno(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#bankacnowindow').jqxWindow('open');
	  bankacnoSearchContent('getBankAccount.jsp?id=1');
	  }
	 else{
		 }
	 }

function projectinfoSearchContent(url) {
   //alert(url);
$.get(url).done(function (data) {
	 //alert(data);
 $('#projectwindow').jqxWindow('setContent', data);

	   }); 
}
function servicelevelSearchContent(url) {
	$.get(url).done(function (data) {
	$('#servicelevelwindow').jqxWindow('setContent', data);
	  }); 
	}
function bankacnoSearchContent(url) {
	$.get(url).done(function (data) {
	$('#bankacnowindow').jqxWindow('setContent', data);
	  }); 
	}
function funRemoveReadOnly(){

	 if ($("#mode").val() == "D") {
		 $('#docno').attr('disabled', false);
		 $('#permanentfleet').attr('disabled', false);
		 $('#tempfleet').attr('disabled', false);
	
		 var docnos=document.getElementById("masterdoc_no").value;
				
			if($('#permanentfleet').val()=="")
			{
			fleet_no=document.getElementById("tempfleet").value;
			}
		else if($('#tempfleet').val()=="")
			{
			fleet_no=document.getElementById("permanentfleet").value;
			}
		 
		 
				var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
					{
					
			     			
						var items=x.responseText;
						
				var chkfleet=items.trim();
				
						 if(parseInt(chkfleet)==1)
							 {
							 $.messager.alert('Message',' Transaction Found Not Deleted ','warning'); 
							 $('#docno').attr('disabled', true);
							 $('#permanentfleet').attr('disabled', true);
							 $('#tempfleet').attr('disabled', true);
							 $("#mode").val("view");	
							  exit(); 
							  return 0;
							 }
						 else
							 {
							 $.messager.alert('Message','LA Is Successfully Deleted ','warning');  
						
							 $('#docno').attr('disabled', true);
							 $('#permanentfleet').attr('disabled', true);
							 $('#tempfleet').attr('disabled', true);
							 $("#mode").val("D");	
							  exit(); 
							 
							 return 0;	
							 }
				
						
						}
					
				}
					
			x.open("GET","deletelease.jsp?valfleet="+fleet_no+"&docnos="+docnos,true);

			x.send();
			exit(); 	
			}
	
	
	$('#frmLeaseAgreement_AlFahim input').attr('disabled', false );
	$('#frmLeaseAgreement_AlFahim textarea').attr('disabled', false );
	$('#frmLeaseAgreement_AlFahim select').attr('disabled', false);
	$('#date').jqxDateTimeInput({ disabled: false});
	$('#jqxgrid2').jqxGrid({ disabled: false});
	$('#jqxgridpayment').jqxGrid({ disabled: false});
	 $('#rateGrid').jqxGrid({ disabled: false}); 
	 
	 $('#nwevehgrid').jqxGrid({ disabled: false}); 
	 
	$("#adidrvcharges").prop("disabled", true);
	$("#ladriverlist").prop("readonly", true);
    $("#ladriverlist").prop("disabled", true);
    $("#delkmout").attr("disabled", true);
    $('#adidrvcharges').attr('readonly', false);
	   $("#cmbdelfuelout").attr("disabled", true);
	   $('#deldateout').jqxDateTimeInput({ disabled: true});
	   $('#deltimeout').jqxDateTimeInput({ disabled: true});
	   $('#deltimeout').attr("disabled", true);
	   $('#delkmout').attr("disabled", true);
	   $('#cmbdelfuelout').attr("disabled", true);
	   
	
	   
	   
	   $('#vehdetailsupdate').attr('disabled', true);
	   
	   $('#delupdatefd').attr('disabled', true); 
		$('#btnupdate').attr('disabled', false);
		$('#btndelupdate').attr('disabled', false);
		$('#leaseprintbtn').attr('disabled', true);
		if($('#mode').val()=='E'){
			   var driverrows=$('#jqxgrid2').jqxGrid('getrows');
			   var srvcrows=$('#nwevehgrid').jqxGrid('getrows');
			   for(var i=srvcrows.length;i<5;i++){
				   $('#nwevehgrid').jqxGrid('addrow', null, {});
			   }
			   if(driverrows.length==0){
				   $("#jqxgrid2").jqxGrid('addrow', null, {});
				   $("#jqxgrid2").jqxGrid('addrow', null, {});
			   }
			   else if(driverrows.length==1){
				   $("#jqxgrid2").jqxGrid('addrow', null, {});
			   }			
		}

		      
	   
       
	      
	    if($("#mode").val()=='A')  
	    	{
	    	$("#jqxgrid2").jqxGrid('clear');
		      $("#jqxgrid2").jqxGrid('addrow', null, {});
		      $("#jqxgrid2").jqxGrid('addrow', null, {});
		      $("#rateGrid").jqxGrid('clear');
		       
			      $("#rateGrid").jqxGrid('addrow', null, {});
			    
		      $("#paymentdiv").load("paymentdetailsgrid.jsp?");
	    	$("#jqxMenuMore").css('visibility', 'hidden');   
	    	$("#date").val(new Date);
	        $("#dateout").val("");
	        $("#timeout").val("");
	 	   $("#deldateout").val(""); 
	 	  $("#deltimeout").val("");
	 	 $("#nwevehgrid").jqxGrid('clear');
	 	  $("#nwevehgrid").jqxGrid('addrow', null, {});
          $("#nwevehgrid").jqxGrid('addrow', null, {});
          $("#nwevehgrid").jqxGrid('addrow', null, {});
          $("#nwevehgrid").jqxGrid('addrow', null, {});
          
          $("#nwevehgrid").jqxGrid('addrow', null, {});
	 	   
	    	}
	      
	    $("#cleardata").hide();	
	    if(document.getElementById("mode").value=="A"){
		    SetLeaseOwn();
		    $('#servicelevel,#pyttotalrent,#pytadvance,#pytbalance,#pytmonthsno,#pytbankacno').attr('readonly',true);
		    $('#pytstartdate').jqxDateTimeInput({disabled:true});
		    $('#servicelevel').attr('placeholder','Press F3 to Search');
		    $('#pytDetailsGrid').jqxGrid('clear');
		    $('#pytstartdate').jqxDateTimeInput('setDate',new Date());
		    $('#hidpytbankacno,#hidservicelevel').val('');
		    $('#btnprocess,#btncreatecheque').attr('disabled',true);
		    $('#pytDetailsGrid').jqxGrid({disabled:true});
	    }
	    
	    if(mod1=="A")
		{
	   
	var totval='<%=totalval%>';
	var nomonth='<%=nomon%>';
	var yearly=nomonth/12;
	var num=yearly;
	 var m=1;
	 var amt=1;
	var fst=0;
	var sp=0;
	var amtval=3;
	if((num)>=1)
		{
	for(i=0;i<num;i++)
		{
		sp=sp+12;
		
		document.getElementById("m"+m).value=fst;
		document.getElementById("m"+(m+1)).value=sp;
		document.getElementById("amt"+amt).value=amtval*totval;
		m=m+2;
		amt++;
		fst=sp+1;
		amtval--;
		}
		} 
	else{
		document.getElementById("m1").value=0;
		document.getElementById("m2").value=nomonth;
		document.getElementById("amt1").value=3*totval;
		
	}
	//pervalue and pername
	if((yearly)>=1)
		{
		document.getElementById("per_value").value=yearly;
		document.getElementById("per_name").value=1;
		}
	else{
		document.getElementById("per_value").value=nomonth;
		document.getElementById("per_name").value=2;
	}
	
	
		 document.getElementById("cusaddress").value='<%=fulldetail%>'; 
         document.getElementById("le_salmanid").value='<%=le_salmanid%>';
        document.getElementById("salesman").value='<%=salesman%>';
        document.getElementById("le_clacno").value='<%=le_clacno%>';
        document.getElementById("le_clcodeno").value='<%=le_clcodeno%>';
        document.getElementById("clientid").value='<%=clientid%>';
        document.getElementById("clientname").value='<%=clientname%>';
     document.getElementById("latype").value=2;
     document.getElementById("larefdoc").value='<%=larefdoc%>';
     document.getElementById("hidblaf_srno").value='<%=blaf_srno%>';	 
     
     $("#ratediv").load('rateGrid.jsp?modee='+mod1+'&totval='+totval+'&kmuse='+kmuse+'&exrate='+exrate);
		}

		$("#masterdoc_no").attr('disabled', false );
		$("#docno").attr('disabled', false );
		if($('#mode').val()=='E'){
			$('#latype,#larefdoc').attr('disabled',true);
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText.trim();
					if(items=="1"){
						return true;				
					}
					else{
						$.messager.alert('warning','Cannot Edit Document');
						$('#btnClose').trigger('click');
						return false;
					}
					
				} else {

				}
			}
			x.open("GET","checkPaymentStatus.jsp?docno="+$('#masterdoc_no').val()+"&brhid="+$('#brchName').val(), true);
			x.send();
		}
				
			
}    

function menuContent(url) {
	   $.get(url).done(function (data) {
	 	 $('#windows2').jqxWindow('open');
		 $('#windows2').jqxWindow('setContent', data);
		 $('#windows2').jqxWindow('bringToFront');
		 
	 		  });
	 	
	} 
function replacement(){
	if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
    $('#windows2').jqxWindow('open');
    menuContent('vehReplaceGrid.jsp?docnovals='+document.getElementById("masterdoc_no").value, $('#windows2')); 
	  } 
    
    else {
           $.messager.alert('Message','Select a Document....!','warning');
           return false;
          } 
}

function fine(){
	if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	 $('#windows2').jqxWindow('open');
    menuContent('trafficFines.jsp?docnovals='+document.getElementById("masterdoc_no").value, $('#windows2'));  
	  } 
    
    else {
           $.messager.alert('Message','Select a Document....!','warning');
           return false;
          } 
}

function account(){ 
	if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {

	 $('#windows2').jqxWindow('open');
    menuContent('accountsmainForm.jsp?docnovals='+document.getElementById("masterdoc_no").value, $('#windows2'));
	  } 
    
    else {
           $.messager.alert('Message','Select a Document....!','warning');
           return false;
          } 
}

function closing(){
	 if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	      var url=document.URL;
	        var reurl=url.split("saveLeaseAgreement");
	        $("#docno").prop("disabled", false);                

	        var win= window.open(reurl[0]+"printLAGClosingSummary?docno="+document.getElementById("masterdoc_no").value,"_blank","top=85,left=150,Width=1020,Height=600,location=no,scrollbars=no,toolbar=yes");
	      win.focus();
	     } 
	    
	     else {
	            $.messager.alert('Message','Select a Document....!','warning');
	            return false;
	           } 
	}


function funFocus(){
	 document.getElementById("clientid").focus();  
	
}

function driverinfoSearchContent(url) {
     	 //alert(url);
     		 $.get(url).done(function (data) {
     			 
     			 $('#driverinfowindow').jqxWindow('open');
     		$('#driverinfowindow').jqxWindow('setContent', data);
     
     	}); 
     	}
     	
function funaddidriverview(){
	    
	   if (document.getElementById('additional_driver').checked) {
		   $("#adidrvcharges").prop("disabled", false);
		   document.getElementById('adidrvcharges').value="";
		   document.getElementById('add_drchk').value=1;
		   
		 /*   $("#jqxgrid2").jqxGrid({ disabled: true});
		  */
	   }	else
		   
		   {   
		   $("#adidrvcharges").prop("disabled", true);
		
		   document.getElementById('adidrvcharges').value="";
		   document.getElementById('add_drchk').value=0;
		   } 
     }

function funShaffurdisable(){
	  
    if (document.getElementById('ladrivercheck').checked) {
	   $("#ladriverlist").prop("disabled", false);
		   /* $("#divDrivGrid").load("driverGrid.jsp"); */
		   
		     $("#jqxgrid2").jqxGrid('clear');
			$("#jqxgrid2").jqxGrid('addrow', null, {});
		   $("#jqxgrid2").jqxGrid('addrow', null, {});
		   
		   $("#jqxgrid2").jqxGrid({ disabled: true});
		   document.getElementById("errormsg").innerText="";	
		
   }
   else
	   {
	   $("#ladriverlist").prop("disabled", true);
	   $("#jqxgrid2").jqxGrid({ disabled: false});
	   document.getElementById('ladriverlist').value="";
	   document.getElementById('del_chaufferid').value="";
	   
	   }
	     
}



function getchauffeur(event){
			
    	 var x= event.keyCode;
    	 if(x==114){
    	  $('#chauffeurinfowindow').jqxWindow('open');
    
       // $('#accountWindow').jqxWindow('focus');
     chauffeurSearchContent('SearchChauffeur.jsp?', $('#chauffeurinfowindow'));  	 }
    	 else{
    		 }
    	 }
function chauffeurSearchContent(url) {
       //alert(url);
    $.get(url).done(function (data) {
	 //alert(data);
     $('#chauffeurinfowindow').jqxWindow('setContent', data);

	   }); 
    }
    
    
function getdeldrv(event){
	
	 var x= event.keyCode;
	 if(x==114){
	  $('#deldrvwindow').jqxWindow('open');

  // $('#accountWindow').jqxWindow('focus');
drvdelSearchContent('Searchdeldriver.jsp?', $('#deldrvwindow'));  	 }
	 else{
		 }
	 }
function drvdelSearchContent(url) {
  //alert(url);
$.get(url).done(function (data) {
//alert(data);
$('#deldrvwindow').jqxWindow('setContent', data);

  }); 
}



    
    
function getvehinfo(eventval){
     	 var x= event.keyCode;
     	 if(x==114){
     	  $('#vehinfowindow').jqxWindow('open');
     
        // $('#accountWindow').jqxWindow('focus');
        
        if(eventval==1)
        {
     vehinfoSearchContent('vehinfo.jsp?', $('#vehinfowindow')); 
        }
        else{
        	
        	
        	 vehinfoSearchContent('vehinfotemp.jsp?', $('#vehinfowindow')); 	
        }
        
        
        
        
        }
     	 else{
     		 }
     	 }
     	 
function vehinfoSearchContent(url) {
     	 //alert(url);
     		 $.get(url).done(function (data) {
     			 //alert(data);
     		$('#vehinfowindow').jqxWindow('setContent', data);
     
     	}); 
     	}
/* 
function fundeliverydisable(){
	 
	   if (document.getElementById('chkdelivery').checked) {
		   
		  
		   $("#delkmout").attr("disabled", false);
		   $("#cmbdelfuelout").attr("disabled", false);
		   $('#deldateout').jqxDateTimeInput({ disabled: false});
		   $('#deltimeout').jqxDateTimeInput({ disabled: false});
		   $('#deltimeout').attr("disabled", false);
		   $('#delkmout').attr("disabled", false);
		   $('#cmbdelfuelout').attr("disabled", false);
		   
		 
	   }	else
		   
		   {   
		  
		   $("#delkmout").attr("disabled", true);
		   $("#cmbdelfuelout").attr("disabled", true);
		   $('#deldateout').jqxDateTimeInput({ disabled: true});
		   $('#deltimeout').jqxDateTimeInput({ disabled: true});
		   $('#deltimeout').attr("disabled", true);
		   $('#delkmout').attr("disabled", true);
		   $('#cmbdelfuelout').attr("disabled", true);
		      
		   
		   } 
         } */
function funNotify(){	
        		var maindate = $('#date').jqxDateTimeInput('getDate');
				   var validdate=funDateInPeriod(maindate);
				   if(validdate==0){
				   return 0; 
				   }
		var valid2=document.getElementById("clientid").value;
		
	
		
		if(valid2=="")
			{
			document.getElementById("errormsg").innerText=" Select Client";
			document.getElementById("clientid").focus();  
			return 0;
			}
		
		var validdesc=document.getElementById("description").value;
		
		
		if(validdesc!="")
			{
		
		 var nmaxs = validdesc.length;
    		
    		
          if(nmaxs>99)
       	   {
       	document.getElementById("errormsg").innerText="Description Cannot Contain More Than 100 Characters";
		document.getElementById("description").focus(); 
       	   
		return 0;
			}
		else{
			 document.getElementById("errormsg").innerText="";
		   }
		
			}
		if(document.getElementById("servicelevel").value==""){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Please select Service Level";
			return 0;
		}
		else{
			document.getElementById("errormsg").innerText="";
		}
		/* if(pfleet=="")
		{
		document.getElementById("errormsg").innerText=" Select Fleet";
		return 0;
		}
		else{
			 document.getElementById("errormsg").innerText="";
		} */
		 if (document.getElementById('additional_driver').checked) {
			   
			   var addcharge=document.getElementById("adidrvcharges").value;
				
				if( addcharge=="")
					{
					document.getElementById("errormsg").innerText=" Enter Additional Driver Charge";
					document.getElementById("adidrvcharges").focus();  
					return 0;
					}
				else{
					 document.getElementById("errormsg").innerText="";
				}
		   }
		
        if(document.getElementById('ladrivercheck').checked==false)
  	  {
  	  
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
	   
  	  
  	  }
    
        
        if ((document.getElementById('ladrivercheck').checked)) {
			   
			   var drvname=document.getElementById("ladriverlist").value;
				
				if(drvname=="")
					{
					document.getElementById("errormsg").innerText=" Select Driver";
					document.getElementById("ladriverlist").focus();  
					return 0;
					}
				else{
					 document.getElementById("errormsg").innerText="";
				}
		   }
		
	
        var excessinsur=document.getElementById("excessinsur").value;
        
		
		if(excessinsur=="")
			{
			
			document.getElementById("excessinsur").value=0;  
			
			}
	
	
	
	// driver grid
	var rows = $("#jqxgrid2").jqxGrid('getrows');
   $('#drivergridlength').val(rows.length);
  //alert($('#gridlength').val());
  for(var i=0;i<rows.length;i++){
  // var myvar = rows[i].tarif; 
   newTextBox = $(document.createElement("input"))
      .attr("type", "dil")
      .attr("id", "drvtest"+i)
      .attr("name", "drvtest"+i)
      .attr("hidden", "true");
   
  newTextBox.val(rows[i].dr_id1+" :: ");

  newTextBox.appendTo('form');
	
  
  }
	  // tariff grid
				
			 var rows = $("#rateGrid").jqxGrid('getrows');
			    $('#tariffgridlength').val(rows.length);
			    for(var i=0;i<rows.length;i++){
					  
					var rowlgt= rows.length-1; 
					var srv_lvl_selct=$('#hidservicelevel').val(); 
					 if(i==rowlgt)
						 {
						 	var rateval=rows[i].rate;
							if(rateval==""||typeof(rateval)=="undefined"||typeof(rateval)=="NaN")
							{
								document.getElementById("errormsg").innerText="Tariff Is Not Entered";  
					    		return 0;
							}
							var cdw_val=rows[i].cdw;
							if(parseInt(srv_lvl_selct)!=1)
							{
								if(cdw_val==""||typeof(cdw_val)=="undefined"||typeof(cdw_val)=="NaN")
								{
									document.getElementById("errormsg").innerText="CDW Is Not Entered";  
						    		return 0;
								}
							}
						 }
				    }
			   //alert($('#gridlength').val());
			   for(var i=0;i<rows.length;i++){
			   // var myvar = rows[i].tarif; 
			    newTextBox = $(document.createElement("input"))
			       .attr("type", "dil")
			       .attr("id", "test"+i)
			       .attr("name", "test"+i)
			       .attr("hidden", "true");
			   						    
			   newTextBox.val(rows[i].rate+" :: "+rows[i].cdw+" :: "
					   +rows[i].pai+" :: "+rows[i].cdw1+" :: "+rows[i].pai1+" :: "+rows[i].gps+" :: "+rows[i].babyseater+" :: "+rows[i].cooler+" :: "+rows[i].kmrest+" :: "
					   +rows[i].exkmrte+" :: "+rows[i].chaufchg+" :: "+rows[i].chaufexchg+" :: "+rows[i].status+" :: ");
              
			  // alert("tariff grid"+newTextBox.val);
			   
			   newTextBox.appendTo('form'); 
				
			 
			   }				
         
  
  // payment  grid 
         /*       var rowval = $("#jqxgridpayment").jqxGrid('getrows');
			   var minaa;
			   for(var i=0;i<rowval.length;i++){
		     		 
			    	if(rowval[i].mode=="CARD"||rowval[i].mode=="CASH")
			    		{
			    		minaa=1;
			    		break;
			    	     }
			    	else{
			    		minaa=0;
			    	     }
			    	
			    if(minaa==0){
			    	
			    	 document.getElementById("errormsg").innerText="Payment Details Not Entered For Transaction";  
			    	  return 0;
			            } 
				
			   
			   }  
			    */
			   
				
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
			
			
					 if(!(cardtype=="MASTER"||cardtype=="VISA"))
						{
				
						document.getElementById("errormsg").innerText="Select Card Type In "+rows[i].payment;  
				    	return 0;
						}
					 else {
						 
					  }
					
				
					if(cardnum==""||typeof(cardnum)=="undefined"||typeof(cardnum)=="NaN")
						{
				
						document.getElementById("errormsg").innerText="Enter Card NO In  "+rows[i].payment;  
				    	return 0;
						}
					else
						{
						
						}
					
					var str = ""+cardnum;
					var n = str.length;
			
					if(n!=16)
					{
				
					document.getElementById("errormsg").innerText="Invalid Card Number In  "+rows[i].payment;  
			    	return 0;
					}
				else
					{
					
					}
					
					 }
					
			    }
			   

			    var rows = $("#jqxgridpayment").jqxGrid('getrows');
			    $('#paymentgridlength').val(rows.length);
			   //alert($('#gridlength').val());
			   for(var i=0 ; i < rows.length ; i++){
			   // var myvar = rows[i].tarif; 
			    newTextBox = $(document.createElement("input"))
			       .attr("type", "dil")
			       .attr("id", "paytest"+i)
			       .attr("name", "paytest"+i)
			        .attr("hidden", "true");
			    newTextBox.val(rows[i].payment+"::"+rows[i].mode+" :: "+rows[i].amount+" :: "
						   +rows[i].acode+" :: "+rows[i].cardno+" :: "+rows[i].hidexpdate+" :: "+rows[i].card+" :: "+rows[i].cardtype+" :: "+rows[i].paytype+" :: "
						   +rows[i].invno+" :: "+rows[i].status+" :: ");
			
			    //alert("payment grid"+newTextBox.val);
			   newTextBox.appendTo('form');
			  
			   
			    
			   }   
			   
				var rows = $("#nwevehgrid").jqxGrid('getrows');
				
				   $('#newvehdetalslenght').val(rows.length);
				  //alert($('#gridlength').val());
				  for(var i=0;i<rows.length;i++){
				  // var myvar = rows[i].tarif; 
				   newTextBox = $(document.createElement("input"))
				      .attr("type", "dil")
				      .attr("id", "vehtest"+i)
				      .attr("name", "vehtest"+i)
				      .attr("hidden", "true");
				 
				  newTextBox.val(rows[i].name+" :: "+rows[i].price+" :: ");
				
				  newTextBox.appendTo('form');
					
				  
				  }  
			   
			   
			   
			   
			   return 1;

		   
  }
  
function setValues() {
	  var maindoc=document.getElementById("masterdoc_no").value;
	  if(maindoc>0)
		  {
	 
     var indexVal1 = document.getElementById("masterdoc_no").value;
    
  	  
    $("#ratediv").load('rateGrid.jsp?rateGriddocno='+indexVal1);
	  
    $("#divDrivGrid").load("driverGrid.jsp?driverGriddocno="+indexVal1);
  
	 
    $("#paymentdiv").load("paymentdetailsgrid.jsp?paymentGriddocno="+indexVal1);
    $("#newvehdiv").load("newvehdetails.jsp?vehdivdoc="+indexVal1);
    

    
		  }
  		
	  
	   // main
  		if($('#hiddate').val()){
  			$("#date").jqxDateTimeInput('val', $('#hiddate').val());
  		}
		// tariff OUT date
  		if($('#hidoutdate').val()){
  			$("#dateout").jqxDateTimeInput('val', $('#hidoutdate').val());
  		}
		// tariff OUT time
	    		if($('#hidouttime').val()){
	    			
	    			$("#timeout").jqxDateTimeInput('val', $('#hidouttime').val());
	    		}
		
  	// delivery date
  		if($('#hiddeloutdate').val()){
  			$("#deldateout").jqxDateTimeInput('val', $('#hiddeloutdate').val());
  		}
      	    	        	
  	//deivery time
  	
	    		if($('#hiddelouttime').val()){
	    			$("#deltimeout").jqxDateTimeInput('val', $('#hiddelouttime').val());
	    		} 
      	
   
  	   if($('#msg').val()!=""){
  		   $.messager.alert('Message',$('#msg').val());
  		   
  		  }
  	   
  	 delvalueChange();
  	document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")"; 
  	
  	
  	 
	 if(document.getElementById("checkbranch").value=="WOB")
	  {
	  
	  $("#btnDelete").attr('disabled', true );
	  $("#btndelupdate").attr('disabled', true );
	  
	  $("#btnupdate").attr('disabled', true );
	  
	  
	   
	  
	  }

	 $('#pytdetailsdiv').load('pytDetailsGrid.jsp?docno='+document.getElementById('masterdoc_no').value+'&id=2');
	 
	 if($('#hidchkleaseown').val()=='1'){
		 document.getElementById("chkleaseown").checked=true;
	 }
	 else{
		 document.getElementById("chkleaseown").checked=false;
	 }
	 
	 
	 if ($('#hidlatype').val() != null && $('#hidlatype').val() !="") {
			$('#latype').val($('#hidlatype').val());
		}
	 
	 
	 
	 
	 
	 
  }
function fundescvalidate()
{
	var validdesc=document.getElementById("description").value;
	
	
	if(validdesc!="")
		{
	
	 var nmaxs = validdesc.length;
		
		
      if(nmaxs>99)
   	   {
   	document.getElementById("errormsg").innerText="Description Cannot Contain More Than 100 Characters";
	document.getElementById("description").focus(); 
   	   
	return 0;
		}
	else{
		 document.getElementById("errormsg").innerText="";
	   }
	
		}
	
}
function delvalueChange()
{

	  if(document.getElementById("delchkvalue").value==1)
		  {
		  document.getElementById("chkdelivery").checked = true;
		  document.getElementById("chkdelivery").value = 1;
		  document.getElementById("del_chaufferid").value = "";
		  document.getElementById("ladriverlist").value = "";
		  
		
		  }
	  
	
	  if(document.getElementById("add_drchk").value==1)
	  {
	  document.getElementById("additional_driver").checked = true;
	  document.getElementById("additional_driver").value = 1;
	  if ($("#mode").val() == "A") {     
	  $('#adidrvcharges').attr('disabled', false);
	  }
	  
	  }
	  if(document.getElementById("chaffchkvalue").value==1)
	  {
	  document.getElementById("ladrivercheck").checked = true;
	  document.getElementById("ladrivercheck").value = 1;
	   document.getElementById('deldrvname').value="";
	   document.getElementById('deldrvid').value="";
	
	  
	  if ($("#mode").val() == "A") {   
	  $('#ladriverlist').attr('disabled', false);
	  }
	  
	  }
	  if(document.getElementById("hidadvance_chk").value==1)
	  {
	  document.getElementById("advance_chk").checked = true;
	  document.getElementById("advance_chk").value = 1;
	  }

	  if($('#hidcmbtype').val()!="")
	  {
	  $('#cmbfuelout').val($('#hidcmbtype').val());
	  
	  }
	  if($('#hiddelcmbtype').val()!="")
	  {
	  $('#cmbdelfuelout').val($('#hiddelcmbtype').val());
	  }
	  if($('#hidper_value').val()!="")
	  {
	  $('#per_value').val($('#hidper_value').val());
	  }
	  if($('#hidper_name').val()!="")
	  {
	  $('#per_name').val($('#hidper_name').val());
	  }
	  if($('#hidinvoice').val()!="")
	  {
	  $('#invoice').val($('#hidinvoice').val());
	  }
	 // $('#rateGrid').jqxGrid({ disabled: true});
	  
}
function funSearchLoad(){
	changeContent('masterSearch.jsp', $('#window'));
}


function funchkvehStatus()
{
var masterdoc=document.getElementById("masterdoc_no").value;

var x=new XMLHttpRequest();


x.onreadystatechange=function(){
if (x.readyState==4 && x.status==200)
{
	var items= x.responseText;
		 if(items>0)
		{
			 $.messager.alert('Message',' Already Edited ','warning');   
			
		
			return  0;
		}
		 else
			 {
			 $("#cleardata").show();	
			 $('#dateout').jqxDateTimeInput({ disabled: false});
			 $("#vehdetailsupdate input").prop("disabled", false);
			 
	
			 
			 $("#vehdetailsupdate select").prop("disabled", true);
			 $("#kmout").attr("readonly",true); 
			
			 
			 $('#dateout').jqxDateTimeInput({ disabled: false});
			  $("#dateout").val(new Date);
			   $("#timeout").val(new Date);
			
			  if($('#chaffchkvalue').val()=="1")
				  {
				
				  $("#chkdelivery").attr("disabled", true); 
				  }
		
			 
			 
			// $("#delcharges ").prop("disabled", true);
			 if (document.getElementById('chkdelivery').checked) {
				   $("#delcharges").prop("disabled", false);
				   $("#deldrvname").prop("disabled", false);
				   
				   
				   

			   }
			   else
				   {
				   $("#delcharges").prop("disabled", true);
				   $("#deldrvname").prop("disabled", true);
				 
				   document.getElementById('delcharges').value="";
				   document.getElementById('deldrvname').value="";
				   document.getElementById('deldrvid').value="";
				   
				   }
			 
			 
			 
		      document.getElementById("btnupdate").value="Update";
		      document.getElementById("mode").value='ADD';
		     return 0;
	
			 }
		
}
else
{
	   
}
}
x.open("GET", 'checkvehUpdate.jsp?masterdocno='+masterdoc, true);
x.send();
}  



function funupdate()
{
	
	if(document.getElementById("btnupdate").value=="Edit")
	{
		
		$('#docno').attr('disabled',false);
		if(($('#masterdoc_no').val()=="0") || ($('#masterdoc_no').val()==""))
			{
			 $.messager.alert('Message',' Search Details ','warning');   
			
			$('#docno').attr('disabled',true);
			return 0;
			
			}
		
		  funchkvehStatus();
		

		  return 0;
	
	}
	else
		{
	var fleet_no=0;
		 $.messager.confirm('Confirm', 'Do you want to save changes?', function(r){
				if (r==false){
					
					return 0;
				}
				else
					{
					
					if($('#tempfleet').val()=="" && $('#permanentfleet').val()=="")
					{
						 document.getElementById("errormsg").innerText=" Search Fleet";	 
	        			 return false;	
					}
					else
						{
					
						 document.getElementById("errormsg").innerText="";	 
						}
					
					if($('#permanentfleet').val()=="")
					{
					fleet_no=document.getElementById("tempfleet").value;
					}
				else if($('#tempfleet').val()=="")
					{
					fleet_no=document.getElementById("permanentfleet").value;
					}
				
					
					
					
				       if ((document.getElementById('chkdelivery').checked)) {
						   
	                
	                	   
	                	  var  deldrvname=document.getElementById("deldrvname").value;
	                	  if(deldrvname=="")
							{
							document.getElementById("errormsg").innerText=" Select Driver";
							document.getElementById("deldrvname").focus();  
							return 0;
							}
						
						else{
							 document.getElementById("errormsg").innerText="";
						}
							
	               	   var delcharge=document.getElementById("delcharges").value;
							if(delcharge=="")
								{
								document.getElementById("errormsg").innerText="Enter Delivery Charges ";
								document.getElementById("delcharges").focus();  
								return 0;
								}
							
							else{
								 document.getElementById("errormsg").innerText="";
							}
							
						
							
					   }
					
					
					
					 var dateout = $('#dateout').jqxDateTimeInput('getDate');
					   var validdate=funDateInPeriod(dateout);
					   if(validdate==0){
					   return 0; 
					   }
				
					
					 /* if(document.getElementById("kmout").value=="")
	        		 {
	        			 document.getElementById("errormsg").innerText=" Enter Out KM";	 
	        			 return false;
	        		 }
	        		 else
	        			 {
	        			 document.getElementById("errormsg").innerText="";
	        			 }
	        		 if($('#cmbfuelout').val()=="")
	        		 {
	        			 document.getElementById("errormsg").innerText=" Select Out Fuel";	 
	        			 return false;
	        		 } */
	        		 else
	        			 {
	        			 document.getElementById("errormsg").innerText="";
	        			 }
	        		 //  var valfleetno=document.getElementById("txtfleetno").value;
						var dateout=$('#dateout').val();
						var timeout=$('#timeout').val();
	        		 chkavailable(fleet_no,dateout,timeout);
	        		 
	        		 
/* 					funSetlabel();
					$('#frmLeaseAgreement_AlFahim input').attr('disabled', false );
					$('#frmLeaseAgreement_AlFahim textarea').attr('disabled', false );
					$('#frmLeaseAgreement_AlFahim select').attr('disabled', false);
					$('#date').jqxDateTimeInput({ disabled: false});
					$('#jqxgrid2').jqxGrid({ disabled: false});
					$('#jqxgridpayment').jqxGrid({ disabled: false});
					 $('#rateGrid').jqxGrid({ disabled: false}); 
					$('#date').jqxDateTimeInput({ disabled: false});
					$('#jqxgrid2').jqxGrid({ disabled: false});
					$('#jqxgridpayment').jqxGrid({ disabled: false});
					 $('#rateGrid').jqxGrid({ disabled: false}); 
					  $('#dateout').jqxDateTimeInput({ disabled: false});
					   
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
					  			   
		
					$('#frmLeaseAgreement_AlFahim').submit();
					 */
						
					}
				
			   });
		}
	
	
	       
	 
  }
  
  function funPytCalc(){
	  $('#pername,#per_value').attr('disabled',false);
	  var periodtype=$('#per_name').val();
	  var periodno=$('#per_value').val();
	  var monthno=0;
	  if(periodtype=="1"){
		  monthno=(periodno*12);
	  }
	  else if(periodtype=="2"){
		  monthno=periodno;
	  }
	  $('#rateGrid').jqxGrid({disabled:false});
	  var rent=$('#rateGrid').jqxGrid('getcellvalue',0,'rate');
	  var cdw=$('#rateGrid').jqxGrid('getcellvalue',0,'cdw');
	  var pai=$('#rateGrid').jqxGrid('getcellvalue',0,'pai');
	  var cdw1=$('#rateGrid').jqxGrid('getcellvalue',0,'cdw1');
	  var pai1=$('#rateGrid').jqxGrid('getcellvalue',0,'pai1');
	  var gps=$('#rateGrid').jqxGrid('getcellvalue',0,'gps');
	  var babyseater=$('#rateGrid').jqxGrid('getcellvalue',0,'babyseater');
	  var cooler=$('#rateGrid').jqxGrid('getcellvalue',0,'cooler');
	  var chauffer=$('#rateGrid').jqxGrid('getcellvalue',0,'chauffer');
	  rent=parseFloat(rent==null || rent=="" || typeof(rent)=="undefined" || rent=="undefined"?"0":rent);
	  cdw=parseFloat(cdw==null || cdw=="" || typeof(cdw)=="undefined" || cdw=="undefined"?"0":cdw);
	  pai=parseFloat(pai==null || pai=="" || typeof(pai)=="undefined" || pai=="undefined"?"0":pai);
	  cdw1=parseFloat(cdw1==null || cdw1=="" || typeof(cdw1)=="undefined" || cdw1=="undefined"?"0":cdw1);
	  pai1=parseFloat(pai1==null || pai1=="" || typeof(pai1)=="undefined" || pai1=="undefined"?"0":pai1);
	  gps=parseFloat(gps==null || gps=="" || typeof(gps)=="undefined" || gps=="undefined"?"0":gps);
	  babyseater=parseFloat(babyseater==null || babyseater=="" || typeof(babyseater)=="undefined" || babyseater=="undefined"?"0":babyseater);
	  cooler=parseFloat(cooler==null || cooler=="" || typeof(cooler)=="undefined" || cooler=="undefined"?"0":cooler);
	  chauffer=parseFloat(chauffer==null || chauffer=="" || typeof(chauffer)=="undefined" || chauffer=="undefined"?"0":chauffer);
	  var total=(rent*monthno)+(cdw*monthno)+(pai*monthno)+(cdw1*monthno)+(pai1*monthno)+(gps*monthno)+(babyseater*monthno)+(cooler*monthno)+(chauffer*monthno);
	  document.getElementById("pyttotalrent").value=total;
	  document.getElementById("pytmonthsno").value=monthno;
	  //alert($('#latype').val());
	  if(document.getElementById("latype").value=="2"){
			getPytAdvanceAJAX($('#larefdoc').val());
		}
  }
function chkavailable(valfleet,dateout,timeout)
{
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		
     			
			var items=x.responseText;
	var chkfleet=items.trim();

			 if(chkfleet==1)
				 {
				 $.messager.alert('Message','Fleet Is Not Available ','warning');   
				 return 0;
				 }
			 else
				 {
				
				    funSetlabel();
					$('#frmLeaseAgreement_AlFahim input').attr('disabled', false );
					$('#frmLeaseAgreement_AlFahim textarea').attr('disabled', false );
					$('#frmLeaseAgreement_AlFahim select').attr('disabled', false);
					$('#date').jqxDateTimeInput({ disabled: false});
					$('#jqxgrid2').jqxGrid({ disabled: false});
					$('#jqxgridpayment').jqxGrid({ disabled: false});
					$('#rateGrid').jqxGrid({ disabled: false}); 
					$('#date').jqxDateTimeInput({ disabled: false});
					$('#jqxgrid2').jqxGrid({ disabled: false});
					$('#jqxgridpayment').jqxGrid({ disabled: false});
					$('#rateGrid').jqxGrid({ disabled: false}); 
					$('#dateout').jqxDateTimeInput({ disabled: false});
					   
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
					  			   
		
					$('#frmLeaseAgreement_AlFahim').submit();
				 }
	
			
			}
		
	}
		
x.open("GET","chkavailablefleet.jsp?valfleet="+valfleet+"&dateout="+dateout+"&timeout="+timeout,true);

x.send();
		
}
 
  
function funchkDelStatus()
{
var masterdoc=document.getElementById("masterdoc_no").value;

var x=new XMLHttpRequest();


x.onreadystatechange=function(){
if (x.readyState==4 && x.status==200)
{
	var items= x.responseText;
		 if(items>0)
		{
			
	 $.messager.alert('Message',' Already Edited ','warning');   
			return  0;
		}
		 else
			 {
			 $("#delupdatefd input").prop("disabled", false);
			 $("#delupdatefd select").prop("disabled", false);
			/*  $('#dateout').jqxDateTimeInput({ disabled: false}); */
			 $('#deldateout').jqxDateTimeInput({ disabled: false});
			  $("#deldateout").val(new Date);
			  $("#deltimeout").val(new Date);
		     document.getElementById("btndelupdate").value="Update";
		     document.getElementById("mode").value='DLY';
		     return 0;
	
			 }
		
}
else
{
	   
}
}
x.open("GET", 'checkdelUpdate.jsp?masterdocno='+masterdoc, true);
x.send();
}  

function fundelupdate()
{
	
	if(document.getElementById("btndelupdate").value=="Edit")
	{
		$('#delchkvalue').attr('disabled',false);
		if(($('#delchkvalue').val()==1))
			
			 {
   			  funchkDelStatus();
   
   			  }
   		  else
   			  {
   			
   		 $.messager.alert('Message','Delivery Update Need Not Be Entered ','warning');   
   				
			   return 0;
   		      }
		
	
	     return 0;
	}
	else
		{
	
		 $.messager.confirm('Confirm', 'Do you want to save changes?', function(r){
				if (r==false){
					
					return 0;
				}
				else
					{
					
					   var indate1=new Date($('#dateout').jqxDateTimeInput('getDate'));     // out date
					 
						  var agmtdate1=new Date($('#deldateout').jqxDateTimeInput('getDate')); //del date
						 
						  var intime1=new Date($('#timeout').jqxDateTimeInput('getDate'));  //out time
						  var agmttime1=new Date($('#deltimeout').jqxDateTimeInput('getDate')); // del time  

						  indate1.setHours(0,0,0,0);
						  agmtdate1.setHours(0,0,0,0);
						  
						  
						   if(indate1>agmtdate1){
						   document.getElementById("errormsg").innerText="Delivery Date Cannot be Less than Out Date";
						   return false;
						  }   
						
						   if(indate1.valueOf()==agmtdate1.valueOf()){
						 
						  var out=intime1.getHours();
						  var del=agmttime1.getHours();
						
						  if(out > del){
							   
						    document.getElementById("errormsg").innerText="Delivery Time Cannot be Less than Out Time";
						    return false;
						   }
						   if(out==del){
						    if(intime1.getMinutes()>agmttime1.getMinutes()){
						     document.getElementById("errormsg").innerText="Delivery Time Cannot be Less than Out Time";
						     return false;
						    }
						   }
						  }
						  
						   document.getElementById("errormsg").innerText="";  
					
					
						 if(document.getElementById("delkmout").value=="")
		        		 {
		        			 document.getElementById("errormsg").innerText=" Enter Delivery KM";
		        			 document.getElementById("delkmout").focus();
		        			 return false;
		        		 }
		        		 else
		        			 {
		        			 document.getElementById("errormsg").innerText="";
		        			 }
		        		 if($('#cmbdelfuelout').val()=="")
		        		 {
		        			 document.getElementById("errormsg").innerText=" Select Delivery Fuel";	 
		        			 document.getElementById("cmbdelfuelout").focus();
		        			 return false;
		        		 }
		        		 else
		        			 {
		        			 document.getElementById("errormsg").innerText="";
		        			 }
       
		        		 $("#kmout").prop("disabled", false);
		        			var outkm=document.getElementById("kmout").value;
		        			// alert("out"+outkm);
		        		 	var delkm=document.getElementById("delkmout").value;
		        		   if((parseFloat(delkm)<parseFloat(outkm)))
		        			   
		        		 	
		        		 	{
		        			  
		        			   document.getElementById("errormsg").innerText="Delivery KM Less Than Out KM";  
		        			   $("#kmout").prop("disabled", true);
		        			   return 0;
		        		 	}
		        		   else
		        			   {
		        			   document.getElementById("errormsg").innerText="";  
		        			   $("#kmout").prop("disabled", true);
		        			   }
					
					
					funSetlabel();
					
					$('#frmLeaseAgreement_AlFahim input').attr('disabled', false );
					$('#frmLeaseAgreement_AlFahim textarea').attr('disabled', false );
					$('#frmLeaseAgreement_AlFahim select').attr('disabled', false);
					$('#date').jqxDateTimeInput({ disabled: false});
					$('#jqxgrid2').jqxGrid({ disabled: false});
					$('#jqxgridpayment').jqxGrid({ disabled: false});
					 $('#rateGrid').jqxGrid({ disabled: false}); 
					$('#date').jqxDateTimeInput({ disabled: false});
					$('#jqxgrid2').jqxGrid({ disabled: false});
					$('#jqxgridpayment').jqxGrid({ disabled: false});
				    $('#rateGrid').jqxGrid({ disabled: false}); 
					$('#dateout').jqxDateTimeInput({ disabled: false});
					$('#deldateout').jqxDateTimeInput({ disabled: false}); 
				    $('#frmLeaseAgreement_AlFahim').submit();
					
						
					}
				
			   });
		}
	
	
	       
	 
  }

  
function  funchkKm()
{
	  $("#kmout").prop("disabled", false);
		var outkm=document.getElementById("kmout").value;
		// alert("out"+outkm);
	 	var delkm=document.getElementById("delkmout").value;
	   if((parseFloat(delkm)<parseFloat(outkm)))
		   
	 	
	 	{
		  
		   document.getElementById("errormsg").innerText="Delivery KM Less Than Out KM";  
		   document.getElementById("delkmout").focus();
		   $("#kmout").prop("disabled", true);
		   return 0;
	 	}
	   else
		   {
		   document.getElementById("errormsg").innerText="";  
		   $("#kmout").prop("disabled", true);
		   }
	  
}
  
function isNumber(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
     {
    	
    	document.getElementById("errormsg").innerText="Enter Numbers Only";  

        return false;
     }
    document.getElementById("errormsg").innerText="";  

    return true;
}

function fundelivarytick(){
	  
    if (document.getElementById('chkdelivery').checked) {
	   $("#delcharges").prop("disabled", false);
	   
	   $("#deldrvname").prop("disabled", false);

   }
   else
	   {
	   $("#delcharges").prop("disabled", true);
	   $("#deldrvname").prop("disabled", true);
	 
	   document.getElementById('delcharges').value="";
	   document.getElementById('deldrvname').value=""; 
	   document.getElementById('deldrvid').value="";
	   
	   
	   }
	     
} 


function funPrintBtn(){
	   if (($("#mode").val() != "A") && $("#masterdoc_no").val()!="") {
	  
	      
	   var url=document.URL;

    var reurl=url.split("saveLeaseAgmtAlFahim");

    $("#docno").prop("disabled", false);                
    
//var win= window.open(reurl[0]+"printRA?docno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
 
// var win= window.open(reurl[0]+"/epicraprint1.jsp","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
    var win= window.open(reurl[0]+"Leasemainprint1?docno="+document.getElementById("masterdoc_no").value+"&formdetailcode=LAG","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
    win.focus(); 
	   } 
	  
	   else {
 	      $.messager.alert('Message','Select a Document....!','warning');
 	      return false;
 	     }
 	
	}  

 function funPrintdown(){ 
	   if (($("#mode").val() != "A") && $("#masterdoc_no").val()!="") {
	  
	      
	   var url=document.URL;
	   
	 

 var reurl=url.split("saveLeaseAgmtAlFahim");

 $("#docno").prop("disabled", false);                
 
var win= window.open(reurl[0]+"LeasemasterPrintAlfahim?docno="+document.getElementById("masterdoc_no").value+"&formdetailcode=LAG","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
win.focus(); 
	   } 
	  
	   else {
	      $.messager.alert('Message','Select a Document....!','warning');
	      return false;
	     }
	
	} 


function clearvehdata()
{
	if(document.getElementById("mode").value="ADD")
		{
	
	  document.getElementById("mode").value="view";
	  
	
	  document.getElementById("tempfleet").value="";
	  document.getElementById("permanentfleet").value="";
	  document.getElementById("delcharges").value="";
	  document.getElementById("fleetname").value="";
	  document.getElementById("kmout").value="";
	  
	  document.getElementById("cmbfuelout").value="";
	  
	  
	   document.getElementById('deldrvname').value=""; 
	   document.getElementById('deldrvid').value="";
	  
	  
	 $('#dateout').jqxDateTimeInput({ disabled: true});
	 $("#vehdetailsupdate input").prop("disabled", true);
	 $("#vehdetailsupdate select").prop("disabled", true);
	 $("#kmout").attr("readonly",true); 
	  $("#dateout").val('');
	   $("#timeout").val('');
	
	
	document.getElementById('chkdelivery').checked=false;
	 
	$("#btnupdate").prop("disabled", false);
	$("#leaseprintbtn").prop("disabled", false);
	 
      document.getElementById("btnupdate").value="Edit";
      
      $("#cleardata").hide();	
     return 0;
		}
	
	}


function SetLeaseOwn(){
	if(document.getElementById("chkleaseown").checked==true){
		document.getElementById("hidchkleaseown").value="1";
		document.getElementById("leaseserviceamt").disabled=false;
		document.getElementById("leaseserviceamt").focus();
	}
	else{
		document.getElementById("hidchkleaseown").value="0";
		document.getElementById("leaseserviceamt").disabled=true;
	}
}

$(function(){
    $('#frmLeaseAgreement_AlFahim').validate({
             rules: {
             per_value: {
            	 required:true
             },
             per_name:{
            	 required:true
             },
             servicelevel:{
            	 required:true
             }
             },
             messages: {
            	 per_value: {
            	  required:" *"
              },
              per_name: {
            	  required:" *"
              },
              servicelevel:{
            	  required:" *"
              }
             }
    });
});

function getPytBalance(){
	var total=parseFloat(document.getElementById("pyttotalrent").value==null || document.getElementById("pyttotalrent").value=="" ?"0":document.getElementById("pyttotalrent").value);
	var advance=parseFloat(document.getElementById("pytadvance").value==null || document.getElementById("pytadvance").value=="" ?"0":document.getElementById("pytadvance").value);
	document.getElementById("pytbalance").value=total-advance;	
}


function funPytProcess(){
	var totalrent=document.getElementById("pyttotalrent").value;
	var advance=document.getElementById("pytadvance").value;
	if(advance==""){
		advance=0;
	}
	document.getElementById("pytbalance").value=totalrent-advance;
	document.getElementById("pytadvance").value=advance;
	if($('#pytstartdate').jqxDateTimeInput('getDate')==null){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Payment Start Date is Mandatory";
		return false;
	}
	else{
		document.getElementById("errormsg").innerText="";
		$('#pytdetailsdiv').load('pytDetailsGrid.jsp?docno='+document.getElementById('masterdoc_no').value+'&pytstartdate='+$('#pytstartdate').jqxDateTimeInput('val')+'&pytadvance='+$('#pytadvance').val()+'&pytbalance='+$('#pytbalance').val()+'&pytmonthno='+$('#pytmonthsno').val()+"&id=1");
	}
	
}

function funCreateCheques(){
	var pytrows=$('#pytDetailsGrid').jqxGrid('getrows');
	var bpvno=$('#pytDetailsGrid').jqxGrid('getcellvalue',0,'bpvno');
	if(bpvno!="" && bpvno!="undefined" && typeof(bpvno)!="undefined" && bpvno!=null){
		return false;
	}
	
if(document.getElementById("pytbankacno").value==""){
	document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Bank Account is Mandatory";
		return false;
}
else{
		document.getElementById("errormsg").innerText="";
}

if(pytrows.length==0){
	document.getElementById("errormsg").innerText="";
	document.getElementById("errormsg").innerText="Please Process";
	return false;
}
else{
	document.getElementById("errormsg").innerText="";
	var chequearray=new Array();
	var mstr_frm_date=$('#date').val();
	//alert("mstr_frm_date=="+mstr_frm_date);
	var docno=$('#masterdoc_no').val();
	var bankacno=$('#hidpytbankacno').val();
	var clientacno=$('#le_clacno').val();
	var selectedrows=$('#pytDetailsGrid').jqxGrid('getselectedrowindexes');
	for(var i=0;i<parseInt(pytrows.length);i++){
		for(var j=0;j<parseInt(selectedrows.length);j++){
			if(i==selectedrows[j]){
				var date=$('#pytDetailsGrid').jqxGrid('getcellvalue',i,'date');
				var amount=$('#pytDetailsGrid').jqxGrid('getcellvalue',i,'amount');
				var chequeno=$('#pytDetailsGrid').jqxGrid('getcellvalue',i,'chequeno');
				var detaildocno=$('#pytDetailsGrid').jqxGrid('getcellvalue',i,'detaildocno');
				
				
				chequearray.push(date+"::"+amount+"::"+chequeno+"::"+detaildocno);				
			}
		}

	}
	var cashlength=parseInt(pytrows.length)-parseInt(selectedrows.length);
	$.messager.confirm('Confirm', ''+cashlength+' payments are considered as cash/card payments', function(r){
		if (r){
			createchequesAJAX(chequearray,docno,bankacno,clientacno,mstr_frm_date);	
		}
 		});
	
	}
	

	
}

function createchequesAJAX(chequearray,docno,bankacno,clientacno,mstr_frm_date){
	var masterdocno=document.getElementById("masterdoc_no").value;
	var pyttotalrent=document.getElementById("pyttotalrent").value;
	var pytadvance=document.getElementById("pytadvance").value;
	var pytbalance=document.getElementById("pytbalance").value;
	var pytmonthsno=document.getElementById("pytmonthsno").value;
	var pytstartdate=$('#pytstartdate').jqxDateTimeInput('val');
	var pytbankacno=document.getElementById("hidpytbankacno").value;
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
	{
		var items= x.responseText.trim();
		if(items=="1"){
			
			/* $('#pytdetailsdiv').load('pytDetailsGrid.jsp?docno='+document.getElementById('masterdoc_no').value+'&id=2');
			var rows=$('#pytDetailsGrid').jqxGrid('getrows');
	    	var count=0;
	    	for(var i=0;i<rows.length;i++){
	    		var reciept=$('#pytDetailsGrid').jqxGrid('getcellvalue',i,'bpvno');
	    		if(reciept!="undefined" && reciept!=null && reciept!="" && typeof(reciept)!="undefined"){

	    		}
	    		else{
	    			count++;
	    		}
	    	}
			if(count!=0){
				$.messager.alert('message',''+count+' payments are considered as cash/card payments');				
			}
			else{
				$.messager.alert('message','Successfully Generated');
			} */
			$.messager.alert('message','Successfully Generated');
			funPytCancel();
			$('#pytdetailsdiv').load('pytDetailsGrid.jsp?docno='+document.getElementById('masterdoc_no').value+'&id=2');
		}
		else{
			$.messager.alert('message','Not Generated');
		}
		
	}
	else
	{
	}
	}
	x.open("GET", 'createChequeAJAX.jsp?chequearray='+chequearray+'&docno='+docno+'&bankacno='+bankacno+'&clientacno='+clientacno+'&masterdocno='+masterdocno+'&pyttotalrent='+pyttotalrent+'&pytadvance='+pytadvance+'&pytbalance='+pytbalance+'&pytmonthsno='+pytmonthsno+'&pytstartdate='+pytstartdate+'&pytbankacno='+pytbankacno+'&mstr_frm_date='+mstr_frm_date, true);
	x.send();
}


function funPytEdit(){
	var pytrows=$('#pytDetailsGrid').jqxGrid('getrows');
	var bpvno=0;
	for(var i=0;i<pytrows.length;i++){
		var checkbpvno=$('#pytDetailsGrid').jqxGrid('getcellvalue',i,'bpvno');
		if(checkbpvno!="" && checkbpvno!="undefined" && typeof(checkbpvno)!="undefined" && checkbpvno!=null){
			bpvno=checkbpvno;
			break;
		}
	}
	if(bpvno>0){
		return false;
	}
	/*var bpvno=$('#pytDetailsGrid').jqxGrid('getcellvalue',0,'bpvno');
	if(bpvno!="" && bpvno!="undefined" && typeof(bpvno)!="undefined" && bpvno!=null){
		return false;
	}*/
	$('#btnpytedit').hide();
	$('#btnpytsave,#btnpytcancel,#btnprocess').show();
	$('#pyttotalrent,#pytadvance,#pytbalance,#pytmonthsno,#pytbankacno').attr('disabled',false);
	$('#pytbankacno').attr('readonly',true);
    $('#pytbankacno').attr('placeholder','Press F3 to Search');
	$('#pytstartdate').jqxDateTimeInput({disabled:false});
	$('#btnprocess,#btncreatecheque').attr('disabled',false);
	if(document.getElementById("pyttotalrent").value==""){
		funPytCalc();
	}
	
}

function getPytAdvanceAJAX(value){
	//alert("asd");
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
	{
		var items= x.responseText.trim();
		$('#pytadvance').val(items.split("::")[0]);
		$('#pytmonthsno').val(items.split("::")[1]);
		$('#pytbalance').val($('#pyttotalrent').val()-$('#pytadvance').val());
		
	}
	else
	{
	}
	}
	x.open("GET", 'getPytAdvanceAJAX.jsp?larefdocno='+value, true);
	x.send();
}
function funPytCancel(){
	$('#btnpytedit').show();
	$('#btnpytsave,#btnpytcancel,#btnprocess').hide();
	$('#pyttotalrent,#pytadvance,#pytbalance,#pytmonthsno,#pytbankacno').attr('disabled',true);
	$('#pytbankacno').attr('readonly',true);
    $('#pytbankacno').attr('placeholder','Press F3 to Search');
	$('#pytstartdate').jqxDateTimeInput({disabled:true});
	$('#btnprocess,#btncreatecheque').attr('disabled',true);
}
function funPytSave(){
	var rows=$('#pytDetailsGrid').jqxGrid('getrows');
	if(rows.length==0){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Please Process";
		return false;
	}
	var gridsum=$('#pytDetailsGrid').jqxGrid('getcolumnaggregateddata', 'amount', ['sum'], true);
	var gridsumtemp=gridsum.sum;
	var gridnewsum=gridsumtemp.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
	var total=parseFloat($('#pyttotalrent').val());
	if(parseFloat(gridnewsum)==parseFloat(total)){
		pytSaveAJAX();
	}
	else{
		$.messager.alert('warning','Amount is not tally');
		return false;
	}
}

function pytSaveAJAX(){
	var masterdocno=document.getElementById("masterdoc_no").value;
	var pyttotalrent=document.getElementById("pyttotalrent").value;
	var pytadvance=document.getElementById("pytadvance").value;
	var pytbalance=document.getElementById("pytbalance").value;
	var pytmonthsno=document.getElementById("pytmonthsno").value;
	var pytstartdate=$('#pytstartdate').jqxDateTimeInput('val');
	var pytbankacno=document.getElementById("hidpytbankacno").value;
	var rows=$('#pytDetailsGrid').jqxGrid('getrows');
	var arr=new Array();
	for(var i=0;i<rows.length;i++){
		arr.push($('#pytDetailsGrid').jqxGrid('getcelltext',i,'date')+" :: "+$('#pytDetailsGrid').jqxGrid('getcellvalue',i,'amount')+" :: "+$('#pytDetailsGrid').jqxGrid('getcellvalue',i,'chequeno')+" :: "+$('#pytDetailsGrid').jqxGrid('getcellvalue',i,'bpvno')+" :: ");
	}
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
	{
		var items= x.responseText.trim();
		if(items=="1"){
			$.messager.alert('message','Successfully Updated');	
			funPytCancel();
			$('#pytdetailsdiv').load('pytDetailsGrid.jsp?docno='+document.getElementById('masterdoc_no').value+'&id=2');
			 
		}
		else{
			$.messager.alert('message','Not Updated');
		}
		
	}
	else
	{
	}
	}
	x.open("GET", "pytSavePaymentAJAX.jsp?masterdocno="+masterdocno+"&pyttotalrent="+pyttotalrent+"&pytadvance="+pytadvance+"&pytbalance="+pytbalance+"&pytmonthsno="+pytmonthsno+"&pytstartdate="+pytstartdate+"&pytbankacno="+pytbankacno+"&gridarray="+arr, true);
	x.send();
}



function funPytPrint(){
	if (($("#mode").val() != "A") && $("#masterdoc_no").val()!="") {
		var url=document.URL;
	 	var reurl=url.split("saveLeaseAgmtAlFahim");
		$("#docno").prop("disabled", false);                
		var win= window.open(reurl[0]+"leasePytPrint?docno="+document.getElementById("masterdoc_no").value+"&formdetailcode=LAG","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
		win.focus(); 
	} 
	else{
		$.messager.alert('Message','Select a Document....!','warning');
		return false;
	}
}

</script>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmLeaseAgreement_AlFahim" action="saveLeaseAgmtAlFahim" method="post" autocomplete="off">
<input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
		<jsp:include page="../../../../header.jsp" /><br/>

<div class='hidden-scrollbar'>
  <table width="100%" >
    <tr>
       <td colspan="2">
       <table width="100%" >            
   <tr>
   <td width="85%">
   <fieldset>
   <table width="100%">            
   <tr>
   
    <td width="60" align="right">Date</td>
    <td ><div id='date' name='date'  value='<s:property value="date"/>'></div></td>
    <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddate"/>'/>
    <td width="240" >Type&nbsp;<select name="latype" id="latype" value='<s:property  value="latype"/>'>
												<option value=1>DIR</option>
												<option value=2>LQT</option>
	</select>&nbsp;&nbsp;&nbsp;&nbsp;Ref Doc No.&nbsp;<input type="text" id="larefdoc" name="larefdoc" readonly="readonly" value='<s:property value="larefdoc"/>' />
				<input type="hidden" id="hidblaf_srno" name="hidblaf_srno" value='<s:property value="hidblaf_srno"/>' /></td>

    <td align="right">Doc NO</td>
    <td><input type="text" id="docno" name="docno"  readonly="readonly" tabindex="-1" value='<s:property value="docno"/>'/></td>
    <td width="167">&nbsp;</td>
    <tr>
  <td width="60" align="right"> Client</td>
  <td width="97"> <input type="text" id="clientid" name="clientid" readonly placeholder="Press F3 To Search" value='<s:property value="clientid"/>' onKeyDown="getclientinfo(event);" ondoubleclick="getclientinfo(event);"/></td>
     <td ><input type="text" id="clientname" readonly name="clientname" style="width:100%;" tabindex="-1" value='<s:property value="clientname"/>' />
      
 </td>
 <input type="hidden" id="le_salmanid" name="le_salmanid" style="width:25%;"  value='<s:property value="le_salmanid"/>'/>
 <input type="hidden" id="le_clcodeno" name="le_clcodeno" style="width:25%;"  value='<s:property value="le_clcodeno"/>'/>
 <input type="hidden" id="le_clacno" name="le_clacno" style="width:25%;"  value='<s:property value="le_clacno"/>'/>
     <td align="right">Salesman</td>
     <td ><input type="text" id="salesman" name="salesman" readonly style="width:100%;" placeholder="Salesman Name" value='<s:property value="salesman"/>'/></td>
 <td>&nbsp;</td>
 </tr>
  <tr>
  <td align="right"></td><td colspan="4"><input type="text" id="cusaddress"  placeholder="Mobil NO-Address" readonly name="cusaddress" style="width:100%; resize: none; " value='<s:property value="cusaddress"/>'>

     </td>
     <td>&nbsp;</td>
  </tr>
  <tr>
          <td align="right">Description</td>
          <td colspan="4" align="left"><input type="text" name="description" id="description" placeholder="Description"  value='<s:property value="description"/>' style="width:100%;" onblur="fundescvalidate()"></td>
          <td align="left">&nbsp;</td>
         
        
        </tr>
        <!-- Adding Rows for Alfahim Service Level -->
        <tr>
        	<td align="right">Service Level</td>
        	<td align="left"><input type="text" name="servicelevel" id="servicelevel" value='<s:property value="servicelevel" />' placeholder="Press F3 to Search" onkeydown="getServiceLevel(event);"></td>
        	<td align="right"><input type="checkbox" name="chkleaseown" id="chkleaseown" onchange="SetLeaseOwn();" class="custom-checkbox">&nbsp;
        	<label for="chkleaseown">Lease to own</label></td>
        	<td width="79" align="right">Amount</td>
        	<td width="225" align="left"><input type="text" name="leaseserviceamt" id="leaseserviceamt" value='<s:property value="leaseserviceamt"/>' onkeypress="javascript:return isNumber (event);"></td>
        	<td align="left">&nbsp;</td>
        </tr>
        <input type="hidden" name="hidservicelevel" id="hidservicelevel" value='<s:property value="hidservicelevel"/>'>
        <input type="hidden" name="hidchkleaseown" id="hidchkleaseown" value='<s:property value="hidchkleaseown"/>'>
        
        
 </table>
   </fieldset>
 </td>

 <td width="15%">
 <table width="100%" >
 <tr>
 
 <td align="center">
 <div id='jqxMenuMore' title="More" align="center" style='visibility: hidden;'>
        <ul>
         <li><a href="#trafficFines" onclick="fine();">Traffic Fines</a></li>
       	    <li><a href="#documents" onclick="replacement();">Replacement</a></li>
            <li><a href="#history" onclick="account();">Account Statement</a></li>   
            <li><a href="#close" onclick="closing();">Closing Summary</a></li>               
        </ul>
     </div> 
 </td>
 </tr>

<tr> <td align="center"><i><b><label id="leasestatus"  name="leasestatus"   style="font-size: 13px;font-family: Tahoma; color:#6000FC"><s:property value="leasestatus"/></label></b></i></td></tr>

</table>
 </td>
 </tr>
 </table>
</td>
    </tr>
    <tr>
      <td colspan="2">  <fieldset>
<legend>Driver Details</legend>
<table  width="100%">
<tr>
<td width="11%">
<table id="chauffer" >
<tr><td>
<font size="1.5">Additional Driver</font>  
<input type="checkbox" id="additional_driver"  name="additional_driver" value="0" onchange="funaddidriverview()" onclick="$(this).attr('value', this.checked ? 1 : 0)"></td></tr><tr><td>
<font size="1.5">charge</font>&nbsp;&nbsp;&nbsp;<input type="text" id="adidrvcharges"  style="width:60%;text-align: right;" name="adidrvcharges"value='<s:property value="adidrvcharges"/>' onblur="funRoundAmt(this.value,this.id);"  onkeypress="javascript:return isNumber (event)"  >
</td></tr><tr>
<td>
<font size="1.5">Chauffeur</font>

<input type="checkbox"  id="ladrivercheck" style="width:50%;"  name="ladrivercheck" value="0" onchange="funShaffurdisable()"  onclick="$(this).attr('value', this.checked ? 1 : 0)"></td>
</tr>
<tr><td><input type="text" id="ladriverlist"  name="ladriverlist"  placeholder="Press F3 To Search" value='<s:property value="ladriverlist"/>' onKeyDown="getchauffeur(event);" onfocus="this.placeholder = ''"/>
 <input type="hidden" id="del_chaufferid" name="del_chaufferid"  value='<s:property value="del_chaufferid"/>'/>
    
<input type="hidden" id="client_driverid" name="client_driverid"  value='<s:property value="client_driverid"/>'/>
    <input type="hidden" id="client_driverdoc" name="client_driverdoc"  value='<s:property value="client_driverdoc"/>'/>
   
</td></tr>
</table>
</td>
<td width="89%">
  <!--  <div align="center" hidden="true" id="errodriver"></div><div align="center" hidden="true" id="errodriveryear"></div>  -->
<table width="100%" id="driverGrid">
<tr><td>
      <div id="divDrivGrid">
  <jsp:include page="driverGrid.jsp"></jsp:include></div>
</td>
  </tr>
</table>
</td>

</tr>
    </table>
      </fieldset></td>
    </tr>
    <tr>
      <td colspan="2"><fieldset>
        <legend>Rate Info</legend>
        <table width="100%"  >
        
<tr>
<td width="5%" align="right">Period</td>
<td width="16%">
    <select name="per_value" id="per_value" value='<s:property value="per_value"/>'>
    <option value=1>1</option>
    <option value=2>2</option>
    <option value=3>3</option>
    <option value=4>4</option>
    <option value=5>5</option>
    <option value=6>6</option>
    <option value=7>7</option>
    <option value=8>8</option>
    <option value=9>9</option>
    <option value=10>10</option>
    <option value=11>11</option>
    <option value=12>12</option>
    <option value="" selected>-Select-</option>      

</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<select name="per_name" id="per_name" value='<s:property value="per_name"/>'>
    <option value=1>Years</option>
    <option value=2>Months</option>
    <option value="" selected>-Select-</option>      

</select></td>
<td width="26%"><input type="checkbox" id="advance_chk"  name="advance_chk" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" > &nbsp;Advance

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ins.Excess&nbsp;<input type="text" id="excessinsur"  name="excessinsur" style="text-align: right;"  value='<s:property value="excessinsur"/>' onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);" >
</td>
<td width="13%">Invoice&nbsp;&nbsp;&nbsp;<select name="invoice" id="invoice"   value='<s:property value="invoice"/>'  >
   <option value="1">Month End</option> 
  <!-- <option value="2" selected>Period</option> -->
</select></td>
<td width="3%" align="right">PO</td>
<td width="10%"><input type="text" id="leasePo"  name="leasePo" value='<s:property value="leasePo"/>'></td>
<td width="6%" align="right">Project</td>
<td width="21%" align="left"><input type="text" id="leaseproject"  readonly="readonly" onkeydown="getproject(event);" placeholder="Press F3 To Search"  name="leaseproject" value='<s:property value="leaseproject"/>'></td>
<input type="hidden" id="leaseprojectDoc"  name="leaseprojectDoc" value='<s:property value="leaseprojectDoc"/>'>
</tr>
                                                        
            <tr><td colspan="8"><div id="ratediv">
              <jsp:include page="rateGrid.jsp"></jsp:include>
            </div></td>
          </tr>
        </table>
        <br>
      </fieldset></td>
    </tr>
    <tr>
      <td colspan="2"><fieldset hidden="true">
        <legend>Payment Info</legend>
             <table width="99%" id="payment">
             <tr>

                <td width="80%">

        
        
        <table width="100%">
          <tr>
            <td><div id="paymentdiv" hidden="true">
               <jsp:include page="paymentdetailsgrid.jsp"></jsp:include> 
            </div>                                                           
            </td></tr></table>
          </td>
              <td width="20%">
				      <table width="100%"> 
						<tr>
				<td align="right">PO</td><td>&nbsp;</td>
				</tr><tr>
				<td align="right">Project</td><td>
				
				</td>
				</tr>
				</table>
            
            </td>
          </tr>
        </table>
      </fieldset></td>
    </tr>
    <tr>
  </table>
   
  <table width="100%"  >
    <tr>
      <td width="40%">
        <table width="100%" >
          <tr>
          
          <td width="50%"> 
          <fieldset>
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
            <td align="left"><input type="text" id="amt2" name="amt2" value='<s:property value="amt2"/>' onkeypress="javascript:return isNumber (event)"  /></td>
          </tr>
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
        </fieldset>
     </td>
     <td width="50%">

        <fieldset>
        <legend>Other Income</legend>
     <div id="newvehdiv">
              <jsp:include page="newvehdetails.jsp"></jsp:include>
            </div>
     </fieldset>
     </td>
        </tr>
        </table>
        
        <br>
      </td>
      <td width="60%"><fieldset id="vehdetailsupdate">
      <legend>Vehicle Info</legend>
      <table width="100%" > 
        <tr>
          <td  align="left" colspan="8" >Temperory Fleet&nbsp;&nbsp;<!-- </td>&nbsp;
          <td colspan="2" align="left"> --><input type="text" readonly id="tempfleet" style="width:14%;" name="tempfleet" placeholder="Press F3 To Search" value='<s:property value="tempfleet"/>' onKeyDown="getvehinfo(2);">&nbsp;&nbsp;Permanent Fleet
   <!--        </td>
          <td colspan="2"> -->&nbsp;&nbsp;<input type="text" readonly id="permanentfleet" style="width:14%;" placeholder="Press F3 To Search"  name="permanentfleet" value='<s:property value="permanentfleet"/>' onKeyDown="getvehinfo(1);">
      <!--     
          </td>
          <td width="15%" align="center" colspan="3"> -->&nbsp;Delivery&nbsp;
           &nbsp; <input type="checkbox" id="chkdelivery" name="chkdelivery" value="0"  onclick="$(this).attr('value', this.checked ? 1 : 0)" onchange="fundelivarytick();">
           &nbsp; <input type="text" readonly id="deldrvname" placeholder="Press F3 To Search" style="width:16%;" name="deldrvname" value='<s:property value="deldrvname"/>' onKeyDown="getdeldrv(event);">
           <!--  </td>
          <td> -->&nbsp;Del.Charges&nbsp;<!--  </td><td> --><input type="text" id="delcharges" name="delcharges"   style="width:13%;text-align: right;"  value='<s:property value="delcharges" />' onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event)" ></td>  </tr>
  
        <tr>
          <td align="right" width="8%">Fleet Details</td>
          <td colspan="5" align="left"><input type="text" readonly name="fleetname" id="fleetname" value='<s:property value="fleetname"/>' style="width:99.4%;"></td>
          <td colspan="2">
       
          
          <input type="button" name="btnupdate" id="btnupdate" class="myButton" value="Edit"  onclick="funupdate()" > &nbsp;&nbsp;&nbsp;<input type="button"  name="leaseprintbtn" id="leaseprintbtn" class="myButton" value="Print" onclick="funPrintdown()" ></td>
          
           
        </tr>
        <tr>
          <td align="right">OUT     :&nbsp;&nbsp;  Date</td>
          <input type="hidden" name="hiddateout" id="hiddateout" value='<s:property value="hiddateout"/>'>
          <td width="16%" align="left"><div id="dateout" name="dateout" ></div></td>
          <td width="15%" align="right">Time</td>
          <input type="hidden" name="hidtimeout" id="hidtimeout" value='<s:property value="hidtimeout"/>'>
          <td width="11%" align="left"><div id="timeout" name="timeout"></div></td>
          <td width="8%" align="right">Km</td>
          <td align="left"><input type="text" name="kmout" id="kmout" value='<s:property value="kmout"/>' onkeypress="javascript:return isNumber (event)" ></td>
          <td align="left" colspan="4">&nbsp;&nbsp;&nbsp;Fuel&nbsp;&nbsp;<!-- </td>
          <td align="left" colspan="3"> --><select name="cmbfuelout" id="cmbfuelout">  
            <option value="" selected>-Select-</option>
             <option value=0.000 >Level 0/8</option>
             <option value=0.125>Level 1/8</option><option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option><option value=0.500>Level 4/8</option>
             <option value=0.625>Level 5/8</option><option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
             </select> <input type="hidden" name="hidcmbfuelout" id="hidcmbfuelout" value='<s:property value="hidcmbfuelout"/>'>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <button type="button"  title="Reset"  class="icon" id="cleardata" onclick="clearvehdata()"  value='<s:property value="cleardata"/>'>
					 <img alt="Reset" src="<%=contextPath%>/icons/cancel_new.png"> 
					</button>
            </td>
          
        </tr>
      </table >
      </fieldset>
      <fieldset   id="delupdatefd">
        <legend>Delivery Details</legend>
      <table  width="100%">
        <tr>
          <td align="right" width="7%">Del Date</td>
          <input type="hidden" name="hiddeldateout" id="hiddeldateout" value='<s:property value="hiddeldateout"/>'>
          <td align="left"><div id="deldateout" name="deldateout"></div></td>
          <td align="right">Del Time</td>
          <input type="hidden" name="hiddeltimeout" id="hiddeltimeout" value='<s:property value="hiddeltimeout"/>'>
          <td align="left"  width="10%"><div id="deltimeout" name="deltimeout"></div></td>
          <td align="right">Del Km</td> 
          <td align="left"><input type="text" name="delkmout" id="delkmout" value='<s:property value="delkmout"/>' onblur="funchkKm();"  onkeypress="javascript:return isNumber (event);"></td>
          <td align="right">Del Fuel</td>
          <td align="left"><select name="cmbdelfuelout" id="cmbdelfuelout">
           <option value="" selected>-Select-</option>
            <option value=0.000 >Level 0/8</option>
             <option value=0.125>Level 1/8</option><option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option><option value=0.500>Level 4/8</option>
           <option value=0.625>Level 5/8</option><option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
          </select></td>
           <td  align="center"><input type="button" name="btndelupdate" id="btndelupdate" class="myButton" value="Edit"  onclick="fundelupdate()">&nbsp;&nbsp;&nbsp;&nbsp;</td>
        </tr>
      </table>
      </fieldset>
      </td>

    </tr>
  </table>
  <fieldset><legend>Payment Details</legend>
  <table width="100%" border="0">
  <tr>
    <td width="10%" align="right">Total Rent</td>
    <td width="14%" align="left"><input type="text" name="pyttotalrent" id="pyttotalrent" value='<s:property value="pyttotalrent"/>' style="text-align:right;"  onblur="funRoundAmt(value,id);"></td>
    <td width="12%" align="right">Advance</td>
    <td width="12%" align="left"><input type="text" name="pytadvance" id="pytadvance" value='<s:property value="pytadvance"/>' onblur="getPytBalance();funRoundAmt(value,id);"  style="text-align:right;" ></td>
    <td width="10%" align="right">Balance</td>
    <td colspan="2" align="left"><input type="text" name="pytbalance" id="pytbalance" value='<s:property value="pytbalance"/>'  style="text-align:right;"  onblur="funRoundAmt(value,id);"></td>
    <td align="center"><button type="button" name="btnpytprint" id="btnpytprint" class="myButton" onClick="funPytPrint();">Print</button></td>
  </tr>
  <tr>
    <td align="right">Start Date</td>
    <td align="left"><div id="pytstartdate" name="pytstartdate" value='<s:property value="pytstartdate"/>'></div></td>
    <td align="right">No. of Months</td>
    <td align="left"><input type="text" name="pytmonthsno" id="pytmonthsno" value='<s:property value="pytmonthsno"/>'></td>
    <td colspan="2" align="center"><button type="button" name="btnpytedit" id="btnpytedit" class="myButton" onClick="funPytEdit();">Edit</button>
      
      <button type="button" name="btnprocess" id="btnprocess" style="background-color:transparent;border:none;outline:none;" onclick="funPytProcess();"><img src="../../../../icons/process2.png" alt="" width="32" height="30"></button>
    </td>
    <td width="17%" align="center">
    <button type="button" name="btnpytsave" id="btnpytsave" class="myButton" onClick="funPytSave();">Save</button>&nbsp;&nbsp;
      <button type="button" name="btnpytcancel" id="btnpytcancel" class="myButton">Cancel</button>
    </td>
    <td width="19%" align="center"><button type="button" name="btncreatecheque" id="btncreatecheque" class="myButton" onClick="funCreateCheques();">Create Uncleared Cheque Reciepts</button></td>
    </tr>
  <tr>
    <td align="right">Bank A/c</td>
    <td><input type="text" name="pytbankacno" id="pytbankacno" value='<s:property value="pytbankacno"/>' readonly onkeydown="getBankAcc(event);" placeholder="Press F3 to Search" style="width:100%;"></td>
    <input type="hidden" name="hidpytbankacno" id="hidpytbankacno" value='<s:property value="hidpytbankacno"/>'>
    <td colspan="3" align="center"></td>
    <td colspan="3">&nbsp;</td>
  </tr>
  <!--<tr>
    <td colspan="8"><div id="pytdetailsdiv"><jsp:include page="pytDetailsGrid.jsp"></jsp:include></div></td>
    <!-- <td width="28%">&nbsp;</td> 
    </tr>
  -->
  </table>
<table width="100%"  border="0">

 <tr>
    <td colspan="8" height="200px">&nbsp;<div id="pytdetailsdiv"><jsp:include page="pytDetailsGrid.jsp"></jsp:include></div></td>
    <!-- <td width="28%">&nbsp;</td> -->
    </tr>
</table>
  </fieldset>
  
   <input type="hidden" name="checkbranch" id="checkbranch" value='<s:property value="checkbranch"/>'>
  
 <input type="hidden" name="masterdoc_no" id="masterdoc_no" value='<s:property value="masterdoc_no"/>'>
  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
  <input type="hidden" id="tariffgridlength" name="tariffgridlength"/>
    <input type="hidden" id="paymentgridlength" name="paymentgridlength"/> 
    
     <input type="hidden" id="drivergridlength" name="drivergridlength"/> 
    
    
<input type="hidden" id="newvehdetalslenght" name="newvehdetalslenght"/>
    
    
      <input type="hidden" name="deldrvid" id="deldrvid" value='<s:property value="deldrvid"/>'  />
    
    <input type="hidden" name="delchkvalue" id="delchkvalue" value='<s:property value="delchkvalue"/>'  />
     <input type="hidden" name="chaffchkvalue" id="chaffchkvalue" value='<s:property value="chaffchkvalue"/>'  />
     <input type="hidden" name="add_drchk" id="add_drchk" value='<s:property value="add_drchk"/>'  />
     <input type="hidden" name="hidper_value" id="hidper_value" value='<s:property value="hidper_value"/>'  />
     <input type="hidden" name="hidper_name" id="hidper_name" value='<s:property value="hidper_name"/>'  />
     <input type="hidden" name="hidadvance_chk" id="hidadvance_chk" value='<s:property value="hidadvance_chk"/>'  />
     <input type="hidden" name="hidinvoice" id="hidinvoice" value='<s:property value="hidinvoice"/>'  />
     <input type="hidden" name="hidoutdate" id="hidoutdate" value='<s:property value="hidoutdate"/>'  />
     <input type="hidden" name="hidouttime" id="hidouttime" value='<s:property value="hidouttime"/>'  />
     <input type="hidden" name="hidcmbtype" id="hidcmbtype" value='<s:property value="hidcmbtype"/>'  />
     <input type="hidden" name="hiddeloutdate" id="hiddeloutdate" value='<s:property value="hiddeloutdate"/>'  />
     <input type="hidden" name="hiddelouttime" id="hiddelouttime" value='<s:property value="hiddelouttime"/>'  />
     <input type="hidden" name="hiddelcmbtype" id="hiddelcmbtype" value='<s:property value="hiddelcmbtype"/>'  />
     <input type="hidden" id="vehlocation" name="vehlocation"  value='<s:property value="vehlocation"/>' />
     <input type="hidden" id="hidlatype" name="hidlatype"  value='<s:property value="hidlatype"/>' />
     <input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>' />
</div>

</form>
 <div id="windows2">
   <div style="background-color: #E0ECF8;"></div>
</div>  

<div id="clientinfowindow">
   <div ></div>
   </div>
   <div id="driverinfowindow">
   <div ></div></div>
   <div id="vehinfowindow">
   <div ></div></div>
   <div id="chauffeurinfowindow">
   <div ></div>
</div>
  <div id="deldrvwindow">
   <div ></div>
</div>

  <div id="projectwindow">
   <div ></div>
</div>
<div id="servicelevelwindow">
   <div ></div>
</div>
<div id="bankacnowindow">
   <div ></div>
</div>
</div>

</body>
</html>