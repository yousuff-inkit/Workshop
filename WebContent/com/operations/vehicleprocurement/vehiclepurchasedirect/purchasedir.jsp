<%@ taglib prefix="s" uri="/struts-tags"%>
 <%@page import="java.util.*" %>
 <%@page import="java.text.SimpleDateFormat" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<%-- <% String contextPath=request.getContextPath();%> --%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
form label.error {
color:red;
  font-weight:bold;

}


  

   


   
</style>
<script type="text/javascript">
	$(document).ready(function() {
		 // $("#imagedivv").hide(); 
		 $("#vehpurorderDate").jqxDateTimeInput({ width: '120px', height: '15px', formatString:"dd.MM.yyyy"});
		
		 $("#vehpurinvDate").jqxDateTimeInput({ width: '120px', height: '15px', formatString:"dd.MM.yyyy"});
		 
		
	     $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
		 $('#accountSearchwindow').jqxWindow('close');
		     
		     $('#fleetwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' ,title: 'Fleet Search' , position: { x: 150, y: 60 }, keyboardCloseKey: 27});
			 $('#fleetwindow').jqxWindow('close');
				     
			  
			
			    $('#accid').dblclick(function(){
			    	
			    	   if($('#mode').val()!="view")
				          {
				  	    $('#accountSearchwindow').jqxWindow('open');
				  	
				  	  accountSearchContent('accountsDetailsSearch.jsp?');
				          }
			  }); 	   
	 
	 
				 
				 $("#btnEdit").attr('disabled', true );
		  
		    
	    $('#vehpurorderDate').on('change', function (event) {
	        var maindate = $('#vehpurorderDate').jqxDateTimeInput('getDate');
	  	 	 if ($("#mode").val() != "view"  ) {   
	     funDateInPeriod(maindate);
	    	 }
	   });  
		    
		    
		 
	   
	    
	 //   $("#imagedivv").hide(); 

		
	});
			   
			   function commenSearchContent(url) {
				 	 //alert(url);
				 		 $.get(url).done(function (data) {
				 			 
				 			 $('#accountSearchwindow').jqxWindow('open');
				 		$('#accountSearchwindow').jqxWindow('setContent', data);
				 
				 	}); 
				 	} 	
			   
			  
			 //   getfinacc(event)
			function  getfinacc(event){
	 	 var x= event.keyCode;
	 	 if(x==114){
	 		
	 	  $('#accountSearchwindow').jqxWindow('open');
	 	
	 	 commenSearchContent('finaccountSearch.jsp?');
		          }
	 		   
	 	 else{
	 		 }
	 	 }     
			   
 
	function fleetSearchContent(url) {
	 	 //alert(url);
	 		 $.get(url).done(function (data) {
	 			 
	 			 $('#fleetwindow').jqxWindow('open');
	 		$('#fleetwindow').jqxWindow('setContent', data);
	 
	 	}); 
	 	} 
	
	
	function getaccountdetails(event){
	 	 var x= event.keyCode;
	 	 if(x==114){
	 		   if($('#mode').val()!="view")
		          {
	 	  $('#accountSearchwindow').jqxWindow('open');
	 	
	 	 accountSearchContent('accountsDetailsSearch.jsp?'); 
		          }
	 		   }
	 	 else{
	 		 }
	 	 }  
		  function accountSearchContent(url) {
	       //alert(url);
	          $.get(url).done(function (data) {
	//alert(data);
	        $('#accountSearchwindow').jqxWindow('setContent', data);

		}); 
	    	}
   
        
      

	
	 function funReadOnly(){
			$('#frmpurchasedir input').attr('readonly', true );
			$('#frmpurchasedir select').attr('disabled', true);
			
			$('#vehpurorderDate').jqxDateTimeInput({disabled: true});
			$('#vehpurinvDate').jqxDateTimeInput({disabled: true});
			   
	 }
	 function funRemoveReadOnly(){
		 
			$('#frmpurchasedir input').attr('readonly', false );
			$('#frmpurchasedir select').attr('disabled', false);
			$('#vehpurorderDate').jqxDateTimeInput({disabled: false});
			$('#vehpurinvDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$('#accid').attr('readonly', true);
			if ($("#mode").val() == "A") {
			 
				$('#vehpurorderDate').val(new Date());
				$('#vehpurinvDate').val(new Date());
			    $("#vehpurchasedirgrid").jqxGrid('clear');
			    $("#vehpurchasedirgrid").jqxGrid('addrow', null, {});
			  
				    
				     
			   }
			
		/* 	if ($("#mode").val() == "E") {
			if($('#vehtype').val()=="VPO")
			  {
			
			  $('#vehrefno').attr('disabled', false);
			  
		  $('#vehrefno').attr('readonly', true);
		
			  }
			} */
			
			
			
			
			if($('#mode').val()=='D')
			{
			
			$('#frmpurchasedir input').attr('readonly',false);  
			$('#frmpurchasedir select').attr('disabled',false); 
			$('#vehpurorderDate').jqxDateTimeInput({disabled: false});
			$('#vehpurinvDate').jqxDateTimeInput({disabled: false});
 
			
			funchkfordel(document.getElementById("masterdoc_no").value);	
			funReadOnly();
			exit();
		
	
		
	       }
	
			
			
	 }
	 
	 
	 
	 function funchkfordel(masterdoc_no)
	 {


	 	var x = new XMLHttpRequest();
	 	x.onreadystatechange = function() {
	 		if (x.readyState == 4 && x.status == 200) {
	 			var items = x.responseText.trim();	
	 		//	alert(items);
	 			if(parseInt(items)>0)
	 				{
	 				$.messager.alert('Message',' Transaction Already Exists','warning');  
	             return 0;
	 	
	 				
	 				}
	 			else
	 				{
	 			
	 				
	 				$('#frmpurchasedir input').attr('readonly',false);  
	 				$('#frmpurchasedir select').attr('disabled',false); 
	 				$('#vehpurorderDate').jqxDateTimeInput({disabled: false});
	 				$('#vehpurinvDate').jqxDateTimeInput({disabled: false});
	 				$('#frmpurchasedir').submit(); 
	 				}
	 		  
	 			
	 			
	 			
	 		} else {
	 			
	 		}
	 	}
	 	x.open("GET", "deletechk.jsp?srno="+document.getElementById("masterdoc_no").value, true);
	 	x.send();
	 	
	 	}
	 	

 
	 
	 
	 
	 function funSearchLoad(){
		changeContent('mastersearch.jsp'); 
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus()
	    {
	    	$('#vehpurorderDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	 
	
	   
	  function funNotify(){
		  
		  var maindate = $('#vehpurorderDate').jqxDateTimeInput('getDate');
		   var validdate=funDateInPeriod(maindate);
		   if(validdate==0){
		   return 0; 
		   }
		  
	 
		//   fleet_no chaseno enginno prch_cost addicost price  brdid modid clrid
	 		
		var purid= document.getElementById("accid").value;

		if(purid=="")
			{
			 document.getElementById("errormsg").innerText=" Select An Account";
			 
			 document.getElementById("accid").focus();
			 return 0;
			   }
		else
			   {
			   document.getElementById("errormsg").innerText="";
			   } 
		
		
		var invno= document.getElementById("invno").value;

		if(invno=="")
			{
			 document.getElementById("errormsg").innerText=" Enter Invoice No";
			 
			 document.getElementById("invno").focus();
			 return 0;
			   }
		else
			   {
			   document.getElementById("errormsg").innerText="";
			   } 
		
		
 
		  var rows = $("#vehpurchasedirgrid").jqxGrid('getrows');
		    $('#vehpurchasegridlenght').val(rows.length);
		   //alert($('#gridlength').val());
		   for(var i=0 ; i < rows.length ; i++){
		   // var myvar = rows[i].tarif; 
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
           .attr("id", "vehpurchasetest"+i)
		       .attr("name", "vehpurchasetest"+i) 
		           .attr("hidden", "true"); 
		    
		 
		   newTextBox.val(rows[i].fleet_no+"::"+rows[i].brdid+" :: "+rows[i].modid+" :: "
				   +rows[i].clrid+" :: "+rows[i].chaseno+" :: "+rows[i].enginno+" :: "+rows[i].prch_cost+" :: "+rows[i].addicost+" :: "
				   +rows[i].price+" :: ");
	//s	alert(newTextBox.val());
		   newTextBox.appendTo('form');
		  
		    
		   }   
				 /* Applying Invoice Grid Updating Ends*/
				 
	    		return 1;
		} 
	  
    
	  
	  $(function(){
	        $('#frmpurchasedir').validate({
	        	 rules: { 
	        		 vehdesc:{maxlength:200},
	        		 
	        	 },
		                 messages: {
		                	 
		                	 vehdesc: {maxlength:"  Max 250 chars"}
		              
	                 }
	        });});
 
	  
 
	  
	function isNumber(evt) {
	    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
	    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
	    	{
	 	   document.getElementById("errormsg").innerText=" Enter Numbers Only";  
	       
	        return false;
	    	}
	    document.getElementById("errormsg").innerText="";  
	    return true;
	}  
	
	
  function setValues()
  {
	  
	   if($('#hidvehpurorderDate').val()){
			 $("#vehpurorderDate").jqxDateTimeInput('val', $('#hidvehpurorderDate').val());
		  }
	 


	  if($('#hidvehpurinvDate').val()){
			 $("#vehpurinvDate").jqxDateTimeInput('val', $('#hidvehpurinvDate').val());
		  }
	  
		var indexVa5 = document.getElementById("masterdoc_no").value;
		
        if(parseInt(indexVa5)>0){
       	
  	 
        $("#vehpuchase").load("vehpurchaseDetails.jsp?masterdoc="+indexVa5);  
        }
        if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
      	 funSetlabel();	 
  }
	
 
	 function funPrintBtn(){
	  	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	  	  
	  	   var url=document.URL;
	  	 
	         var reurl=url.split("savePurchase");
	         
	         $("#docno").prop("disabled", false);                
	         
	   
	 var win= window.open(reurl[0]+"printPurchaseDir?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	      
	 win.focus(); 
	  	   } 
	  	  
	  	   else {
	 	    	      $.messager.alert('Message','Select a Document....!','warning');
	 	    	      return false;
	 	    	     }
	 	    	
	  	}  
</script>

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background" >
<jsp:include page="../../../../header.jsp"></jsp:include><br><br>

<div  class='hidden-scrollbar'>

<form id="frmpurchasedir" action="savePurchaseDir" method="post" autocomplete="off">

<fieldset>
<table width="100%"><tr><td>
<table width="100%"   >
  <tr>
    <td width="4.2%"  align="right">&nbsp;&nbsp;Date</td>  
    <td width="1%"><div id="vehpurorderDate" name="vehpurorderDate" value='<s:property value="vehpurorderDate"/>'></div>
    <input type="hidden" id="hidvehpurorderDate" name="hidvehpurorderDate" value='<s:property value="hidvehpurorderDate"/>'/></td>
    
    <td width="75%" align="right">Doc No</td>
    <td width="10%"><input type="text" id="docno" name="docno" style="width:97%;" readonly="readonly" value='<s:property value="docno"/>' tabindex="-1"/>
    </td>
  </tr>
</table>
</td>
</tr>
<tr><td>                   
<table width="100%"   >
  <tr>
    <td width="2%" align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Vendor</td>
  <td width="34%">  <input type="text" id="accid" name="accid" style="width:20%;" placeholder="Press F3 to Search" value='<s:property value="accid"/>'  onkeydown="getaccountdetails(event)"/>
   <input type="text" id="vehpuraccname" name="vehpuraccname" style="width:75%;" value='<s:property value="vehpuraccname"/>'/>
   
    <td align="right"  width="3%">Inv No</td> 
    <td width="10%">  <input type="text" id="invno" name="invno" style="width:50%;"  onkeypress="javascript:return isNumber (event)" value='<s:property value="invno"/>'/></td>
    <td align="right"  width="6%">Purchase Date</td>
    <td width="5%"><div id="vehpurinvDate" name="vehpurinvDate" value='<s:property value="vehpurinvDate"/>'></div>
    <input type="hidden" id="hidvehpurinvDate" name="hidvehpurinvDate" value='<s:property value="hidvehpurinvDate"/>'/>
    </td>
<td width="30%">&nbsp;&nbsp;&nbsp;</td>

  </tr>
  </table>
  </td></tr>
  <tr><td>
<table width="100%">

  <tr>
    
    <td >Description&nbsp;&nbsp;<input type="text" id="vehdesc" name="vehdesc" style="width:64%;" value='<s:property value="vehdesc"/>'/>
    
    </td>
  </tr>
</table>
</td></tr></table>
</fieldset>
<br>
<fieldset>

<div id="vehpuchase"><jsp:include page="vehpurchaseDetails.jsp"></jsp:include></div> 
</fieldset>

 
<br><br>
<input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'/>  


 

<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
    
<input type="hidden" id="headacccode" name="headacccode"  value='<s:property value="headacccode"/>'/>
<input type="hidden" id="vehpurchasegridlenght" name="vehpurchasegridlenght"  value='<s:property value="vehpurchasegridlenght"/>'/>

 
 </form>
	<div id="accountSearchwindow">
   <div ></div>
</div>
   
<div id="fleetwindow"><div></div>
</div>
 
</div>
</div>
 
</body>
</html>
