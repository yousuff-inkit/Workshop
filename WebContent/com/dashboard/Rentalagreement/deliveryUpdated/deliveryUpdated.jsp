
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<% String contextPath=request.getContextPath();%>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 



<script type="text/javascript">

$(document).ready(function () {
	
	 $("#jqxDeliveryOut").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	 $("#jqxDelTimeOut").jqxDateTimeInput({  width: '20%', height: '17px', formatString: 'HH:mm', showCalendarButton: false ,value: new Date()});
	 $("#jqxDateOut").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#jqxTimeOut").jqxDateTimeInput({  width: '20%', height: '17px', formatString: 'HH:mm', showCalendarButton: false });
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     $('#chauffeurinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Driver Search' ,position: { x: 200, y: 70 }, keyboardCloseKey: 27});
	     $('#chauffeurinfowindow').jqxWindow('close');

	 $('#jqxDeliveryOut').on('change', function (event) {
		 if( $('#del_Driver').val()!="")
			{
		   var indate1=new Date($('#jqxDateOut').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var agmtdate1=new Date($('#jqxDeliveryOut').jqxDateTimeInput('getDate')); //del date
				
			  indate1.setHours(0,0,0,0);
			  agmtdate1.setHours(0,0,0,0); 
		   if(indate1>agmtdate1){
			   $.messager.alert('Message',' Delivery Date Cannot be Less than Out Date','warning');   
			  /*  $.messager.alert('Warning', ' Delivery Date Cannot be Less than Out Date ', function(r){
				     
			     }); */
		   return false;
		  }   
		
			}
		  
	
	       });
	 
	 
	  $('#jqxDelTimeOut').on('change', function (event) {
		   
		  if( $('#del_Driver').val()!="")
			{  
		   var indate1=new Date($('#jqxDateOut').jqxDateTimeInput('getDate'));     // out date
		  var agmtdate1=new Date($('#jqxDeliveryOut').jqxDateTimeInput('getDate')); //del date
		 
		  var intime1=new Date($('#jqxTimeOut').jqxDateTimeInput('getDate'));  //out time
		  var agmttime1=new Date($('#jqxDelTimeOut').jqxDateTimeInput('getDate')); // del time  
		  indate1.setHours(0,0,0,0);
		  agmtdate1.setHours(0,0,0,0); 
		  
		   if(indate1>agmtdate1){
			   $.messager.alert('Message',' Delivery Date Cannot be Less than Out Date','warning');   
			 
		//  alert("Delivery Date Cannot be Less than Out Date");
		   return false;
		  }   
		
		   if(indate1.valueOf()==agmtdate1.valueOf()){
		 
		  var out=intime1.getHours();
		  var del=agmttime1.getHours();
		
		  if(out > del){
			  $.messager.alert('Message',' Delivery Time Cannot be Less than Out Time ','warning');   
			  
		  // alert("Delivery Time Cannot be Less than Out Time");
		    return false;
		   }
		   if(out==del){
		    if(intime1.getMinutes()>agmttime1.getMinutes()){
		    	  $.messager.alert('Message',' Delivery Time Cannot be Less than Out Time ','warning');   
		    	
		    // alert("Delivery Time Cannot be Less than Out Time");
		     return false;
		    }
		   }
		  }
		  
			}
		  
		  
	
	       });
	  
	  
      $('#del_Driver').dblclick(function(){
    	  
    	  if($("#chktype").val()=="VCU")
    		  {
	  	    $('#chauffeurinfowindow').jqxWindow('open');
  
  chauffeurSearchContent('SearchDriver.jsp?', $('#chauffeurinfowindow')); 
    		  }
	 });
      
	  
    
});
function getchauffeur(event){
	  if($("#chktype").val()=="VCU")
	  {
    	 var x= event.keyCode;
    	 if(x==114){
    	  $('#chauffeurinfowindow').jqxWindow('open');
    
       
     chauffeurSearchContent('SearchDriver.jsp?', $('#chauffeurinfowindow'));  	 }
    	 else{
    		 }
	  }
    	 }

function chauffeurSearchContent(url) {
     
  $.get(url).done(function (data) {
	
   $('#chauffeurinfowindow').jqxWindow('setContent', data);

	   }); 
  }


function funAttachBtn(){
	if ($("#rentaldoc").val()!="" && $("#chktype").val()=="RAG" ) {
		  $("#windowattach").jqxWindow('setTitle',"RAG - "+document.getElementById("rentaldoc").value);
		changeAttachContent("<%=contextPath%>/com/dashboard/Attach.jsp?formCode=RAG&docno="+document.getElementById("rentaldoc").value+"&barchvals="+document.getElementById("branchids").value);		
	}
<%-- 	else if ($("#rentaldoc").val()!="" && $("#chktype").val()=="VCU" ) {
		  $("#windowattach").jqxWindow('setTitle',"VCU - "+document.getElementById("rentaldoc").value);
		changeAttachContent("<%=contextPath%>/com/dashboard/Attach.jsp?formCode=RAG&docno="+document.getElementById("rentaldoc").value+"&barchvals="+document.getElementById("branchids").value);		
	} --%>
	
	else {
		$.messager.alert('Message','Select a Document....!','warning');
		return;
	}
}
function changeAttachContent(url) {
	$.get(url).done(function (data) {
		    $('#windowattach').jqxWindow('open');
			$('#windowattach').jqxWindow('setContent',data);
			 $('#windowattach').jqxWindow('bringToFront');
}); 
}

function funreload(event)
{
	disitems();
	 var barchval = document.getElementById("cmbbranch").value;
	   $("#overlay, #PleaseWait").show();
 
	  $("#delupdiv").load("delupdateGrid.jsp?barchval="+barchval);
	
	
	}

function funupdate()
{
	
	
	
	 if(document.getElementById("del_Driver").value=="")
	 {
 
				 
		  $.messager.alert('Message',' Search Driver','warning'); 
		 return 0;
	 }
	
	 if(document.getElementById("del_KM").value=="")
	 {
 
				 
		  $.messager.alert('Message',' Enter KM ','warning'); 
		 return 0;
	 }
	
	 if($('#del_Fuel').val()=="")
	 {
		 $.messager.alert('Message',' Select Fuel','warning'); 
		
		 return 0;
	 }
	 
	
	 var outkm=document.getElementById("out_km").value;
		//alert("out"+outkm);
	 	var delkm=document.getElementById("del_KM").value;
	   if((parseFloat(delkm)<parseFloat(outkm)))
		   
	 	
	 	{
		   
		   $.messager.alert('Message',' Delivery KM Less Than Out KM','warning'); 
		
		 
		   return 0;
	 	}
	  var indate1=new Date($('#jqxDateOut').jqxDateTimeInput('getDate'));     // out date
	  var agmtdate1=new Date($('#jqxDeliveryOut').jqxDateTimeInput('getDate')); //del date
	 
	  var intime1=new Date($('#jqxTimeOut').jqxDateTimeInput('getDate'));  //out time
	  var agmttime1=new Date($('#jqxDelTimeOut').jqxDateTimeInput('getDate')); // del time  

	  indate1.setHours(0,0,0,0);
	  agmtdate1.setHours(0,0,0,0); 
	   if(indate1>agmtdate1){
		   $.messager.alert('Message',' Delivery Date Cannot be Less than Out Date ','warning');     
		 
	
	   return 0;
	  }   
	
	   if(indate1.valueOf()==agmtdate1.valueOf()){
	 
	  var out=intime1.getHours();
	  var del=agmttime1.getHours();
	
	  if(out > del){
		   $.messager.alert('Message',' Delivery Time Cannot be Less than Out Time ','warning');    
		 
	 
	    return 0;
	   }
	   if(out==del){
	    if(intime1.getMinutes()>agmttime1.getMinutes()){
	    	 $.messager.alert('Message','Delivery Time Cannot be Less than Out Time ','warning');    
	    	 
	     return 0;
	    }
	   }
	  }
	
	var rentaldoc=document.getElementById("rentaldoc").value;
	var rentaldate=document.getElementById("rentaldate").value;
	var fleetno=document.getElementById("fleetno").value;
	var del_Driverid=document.getElementById("del_Driverid").value;
	var del_KM=document.getElementById("del_KM").value;
	var del_Fuel=document.getElementById("del_Fuel").value;
	var jqxDeliveryOut= $('#jqxDeliveryOut').val();
	var jqxDelTimeOut= $('#jqxDelTimeOut').val();
	 var group=document.getElementById("group").value;
	var vlocation=document.getElementById("vehloca").value;
	
	var branchval=document.getElementById("branchids").value;
	var cldocno=document.getElementById("cldocno").value;
	
	
	
	
    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
   	  
	       
     	if(r==false)
     	  {
     		return false; 
     	  }
     	else{
     		delsave(rentaldoc,rentaldate,fleetno,del_Driverid,del_KM,del_Fuel,jqxDeliveryOut,jqxDelTimeOut,group,vlocation,branchval,cldocno);
     	}
	     });
	
	
}
	function delsave(rentaldoc,rentaldate,fleetno,del_Driverid,del_KM,del_Fuel,jqxDeliveryOut,jqxDelTimeOut,group,vlocation,branchval,cldocno)
         {
		
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
		
			 	var items= x.responseText;
			 	document.getElementById("cldocno").value="";
				document.getElementById("rentaldoc").value="";
				document.getElementById("chktype").value="";
				 $('#del_Driver').attr('placeholder', ''); 
				
				document.getElementById("rentaldate").value="";
			    document.getElementById("fleetno").value="";
				document.getElementById("del_Driverid").value="";
				document.getElementById("del_Driver").value="";
				document.getElementById("del_KM").value="";
				document.getElementById("del_Fuel").value="";
				$('#jqxDeliveryOut').val(new Date());
				$('#jqxDelTimeOut').val(new Date());
				document.getElementById("group").value="";
				document.getElementById("vehloca").value="";
				document.getElementById("out_km").value="";
				document.getElementById("out_fuel").value="";
				document.getElementById("branchids").value="";
				
				$('#jqxDateOut').val(new Date());
				$('#jqxTimeOut').val(new Date());
				disitems();
				funreload(event);
			 	$.messager.alert('Message', '  Record successfully Updated ', function(r){
					     
				     });
	    }
		}
	     x.open("GET","savedeldate.jsp?rentaldoc="+rentaldoc+"&rentaldate="+rentaldate+"&fleetno="+fleetno+"&del_Driverid="+del_Driverid+"&del_KM="+del_KM+"&del_Fuel="+del_Fuel+"&jqxDeliveryOut="+jqxDeliveryOut+"&jqxDelTimeOut="+jqxDelTimeOut+"&group="+group+"&vlocation="+vlocation+"&branchval="+branchval+"&cldocno="+cldocno+"&chktype="+document.getElementById("chktype").value,true);
	     x.send();
		
		}
	
	function disitems()
	{
		document.getElementById("rentaldoc").value="";
		document.getElementById("chktype").value="";
		 $('#del_Driver').attr('placeholder', ''); 
		
		document.getElementById("rentaldate").value="";
	    document.getElementById("fleetno").value="";
		document.getElementById("del_Driverid").value="";
		document.getElementById("del_Driver").value="";
		document.getElementById("del_KM").value="";
		document.getElementById("del_Fuel").value="";
		$('#jqxDeliveryOut').val(new Date());
		$('#jqxDelTimeOut').val(new Date());
		document.getElementById("group").value="";
		document.getElementById("vehloca").value="";
		document.getElementById("out_km").value="";
		document.getElementById("out_fuel").value="";
		document.getElementById("branchids").value="";
		document.getElementById("cldocno").value="";
		$('#jqxDateOut').val(new Date());
		$('#jqxTimeOut').val(new Date());
		
		
		 $('#jqxDeliveryOut').jqxDateTimeInput({ disabled: true});
		 $('#jqxDelTimeOut').jqxDateTimeInput({ disabled: true});
		 
		 
		 $('#del_KM').attr("readonly",true);
		 $('#del_Fuel').attr("disabled",true);
		 $('#driverUpdate').attr("disabled",true);
		 $('#driverUpdate').attr("disabled",true);
		
		 $('#attachbtns').attr("disabled",true);
		
	}
    function isNumber(evt) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
        	{
        	
        
        	 $.messager.alert('Message',' Enter Numbers Only ','warning');    
        	
        	 
            return false;
        	}
        
        return true;
    }	
	function funchkkm()
	{
		 var outkm=document.getElementById("out_km").value;
			//alert("out"+outkm);
		 	var delkm=document.getElementById("del_KM").value;
		   if((parseFloat(delkm)<parseFloat(outkm)))
			   
		 	
		 	{
			   
			   $.messager.alert('Message',' Delivery KM Less Than Out KM','warning'); 
			
			 
			   return 0;
		 	}
	
		
	}
	
	
	function funExportBtn(){
		 //  $("#delupdategrid").jqxGrid('exportdata', 'xls', 'RAG-Delivery Update');
		   
		   
		   
		   if(parseInt(window.parent.chkexportdata.value)=="1")
		    {
		    JSONToCSVCon(datasssss, 'RAG-Delivery Update', true);
		    }
		   else
		    {
		    $("#delupdategrid").jqxGrid('exportdata', 'xls', 'RAG-Delivery Update');
		    }
		   
		   
		   
		 }	
	
</script>
</head>
<body onload="getBranch();disitems();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
		<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>

<tr><td align="right"><label class="branch">Driver</label></td><td  align="left" ><input type="text" name="del_Driver" id="del_Driver" style="height:20px;width:70%;" value='<s:property value="del_Driver"/>' readonly="readonly" onKeyDown="getchauffeur(event);">
 
<tr> <td  align="right"><label class="branch">KM</label></td> <td align="left"><input type="text" name="del_KM" id="del_KM"  style="height:20px;width:70%;" value='<s:property value="del_KM"/>' onblur="funchkkm()"  onkeypress="javascript:return isNumber (event)"></td></tr>
 
<tr> <td  align="right"><label class="branch">Fuel</label></td><td align="left">
 <select name="del_Fuel" id="del_Fuel" style="width:70%;" name="del_Fuel"  value='<s:property value="del_Fuel"/>'>
       <option value="" selected>-Select-</option>  
     <option value=0.000 >Level 0/8</option>
     <option value=0.125>Level 1/8</option>
     <option value=0.250>Level 2/8</option>
     <option value=0.375>Level 3/8</option>
           <option value=0.500>Level 4/8</option>
               <option value=0.625>Level 5/8</option>
               <option value=0.750>Level 6/8</option>
                   <option value=0.875>Level 7/8</option>
                   <option value=1.000>Level 8/8</option>


</select></td></tr>

 <tr><td  align="right" ><label class="branch">Date</label></td><td align="left"><div id='jqxDeliveryOut' name='jqxDeliveryOut' value='<s:property value="jqxDeliveryOut"/>'></div>
                    <input type="hidden" id="hidjqxDeliveryOut" name="hidjqxDeliveryOut" value='<s:property value="hidjqxDeliveryOut"/>'/></td></tr>
  <tr><td  align="right"><label class="branch">Time</label></td><td align="left" ><div id='jqxDelTimeOut' name='jqxDelTimeOut' value='<s:property value="jqxDelTimeOut"/>'  ></div>
                   <input type="hidden" id="hidjqxDelTimeOut" name="hidjqxDelTimeOut" value='<s:property value="hidjqxDelTimeOut"/>'/></td></tr>
                    <tr><td colspan="2">&nbsp;</td></tr>
 <tr><td  align="center" colspan="2"><input type="Button" name="driverUpdate" id="driverUpdate" class="myButton" value="Update" onclick="funupdate()">
 <input type="Button" name="attachbtns" id="attachbtns" class="myButton" value="Attach" onclick="funAttachBtn()"></td> </tr>
	  <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>	
	 <tr><td colspan="2">&nbsp;</td></tr> 
	 <tr><td colspan="2">&nbsp;</td></tr>   
	  <tr><td colspan="2">&nbsp;</td></tr>          
  </table>
  <input type="hidden" name="rentaldoc" id="rentaldoc" style="height:20px;width:70%;" value='<s:property value="rentaldoc"/>' >
    <input type="hidden" name="chktype" id="chktype" style="height:20px;width:70%;" value='<s:property value="chktype"/>' >
<input type="hidden" name="rentaldate" id="rentaldate" style="height:20px;width:70%;" value='<s:property value="rentaldate"/>' >
<input type="hidden" name="fleetno" id="fleetno" style="height:20px;width:70%;" value='<s:property value="fleetno"/>' >
<input type="hidden" name="del_Driverid" id="del_Driverid" style="height:20px;width:70%;" value='<s:property value="del_Driverid"/>' >
<input type="hidden" name="out_km" id="out_km" style="height:20px;width:70%;" value='<s:property value="out_km"/>' >
<input type="hidden" name="out_fuel" id="out_fuel" style="height:20px;width:70%;" value='<s:property value="out_fuel"/>' >

<div hidden="true" id='jqxDateOut' name='jqxDateOut' value='<s:property value="jqxDateOut"/>'></div>
<div hidden="true" id='jqxTimeOut' name='jqxTimeOut' value='<s:property value="jqxTimeOut"/>'></div>


<input type="hidden" name="branchids" id="branchids" style="height:20px;width:70%;" value='<s:property value="branchids"/>' >
<input type="hidden" name="group" id="group" style="height:20px;width:70%;" value='<s:property value="group"/>' >
<input type="hidden" name="vehloca" id="vehloca" style="height:20px;width:70%;" value='<s:property value="vehloca"/>' >
	<input type="hidden" name="cldocno" id="cldocno" style="height:20px;width:70%;" value='<s:property value="cldocno"/>' > 
	 
   </fieldset>

</td>
<td width="80%">
	<table width="100%">
		<tr>
			  <td><div id="delupdiv"><jsp:include page="delupdateGrid.jsp"></jsp:include></div></td> 
			  </tr>
			  <%-- <tr>
			  <td><div hidden="true">	<jsp:include page="../../../../header.jsp"></jsp:include></div></td>
			  
		</tr> --%>
	</table>
</tr>
</table>

     
</div>
<div id="chauffeurinfowindow">
   <div ></div>
</div>
</div>
</body>
