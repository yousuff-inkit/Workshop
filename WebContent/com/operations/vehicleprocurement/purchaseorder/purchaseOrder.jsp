<%@ taglib prefix="s" uri="/struts-tags"%>
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

		
		 $("#vehpurorderDate").jqxDateTimeInput({ width: '120px', height: '15px', formatString:"dd.MM.yyyy"});

		 $("#vehpurorderdelDate").jqxDateTimeInput({ width: '120px', height: '15px', formatString:"dd.MM.yyyy"});
		 $('#brandsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Brand Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	     $('#brandsearchwndow').jqxWindow('close'); 

	     $('#modelsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Model Search' ,position: { x: 250, y:60 }, keyboardCloseKey: 27});
	     $('#modelsearchwndow').jqxWindow('close');
	     $('#colorsearchwndow').jqxWindow({ width: '25%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Color Search' ,position: { x: 800, y:60 }, keyboardCloseKey: 27});
	     $('#colorsearchwndow').jqxWindow('close');
	     $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
		 $('#accountSearchwindow').jqxWindow('close');
		     
		     $('#refnosearchwindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
			   $('#refnosearchwindow').jqxWindow('close'); 
			   
			   
			   
			   $('#vehrefno').dblclick(function(){
				   
				
				   
			  	    $('#refnosearchwindow').jqxWindow('open');
			  	
			  	  refsearchContent('vehreqRefnoSearch.jsp?'); 
			          
		  }); 
			   
			   
		 
	    $('#accid').dblclick(function(){
	    	   if($('#mode').val()=="A" || $('#mode').val()=="E" )
		          {
		          
		  	    $('#accountSearchwindow').jqxWindow('open');
		  	
		  	  accountSearchContent('accountsDetailsSearch.jsp');
		          }
	  }); 
	    
	    $('#vehpurorderDate').on('change', function (event) {
	        var maindate = $('#vehpurorderDate').jqxDateTimeInput('getDate');
	  	 	 if ($("#mode").val() == "A" || $('#mode').val()=="E" ) {   
	     funDateInPeriod(maindate);
	    	 }
	   });
	    
		
	});
	function getrefDetails(event){
	 	 var x= event.keyCode;
	 	 if(x==114){
	 	  $('#refnosearchwindow').jqxWindow('open');
	 	
	 	 refsearchContent('vehreqRefnoSearch.jsp?');  }
	 	 else{
	 		 }
	 	 }  
		  function refsearchContent(url) {
	       //alert(url);
	          $.get(url).done(function (data) {
	//alert(data);
	        $('#refnosearchwindow').jqxWindow('setContent', data);

		}); 
	    	}
	function getaccountdetails(event){
		
		  if($('#mode').val()=="A" || $('#mode').val()=="E" )
          {
	 	 var x= event.keyCode;
	 	 if(x==114){
	 	  $('#accountSearchwindow').jqxWindow('open');
	 	
	 	 accountSearchContent('accountsDetailsSearch.jsp');    }
	 	 else{
	 		 }
          }
	 	 }  
		  function accountSearchContent(url) {
	       //alert(url);
	          $.get(url).done(function (data) {
	//alert(data);
	        $('#accountSearchwindow').jqxWindow('setContent', data);

		}); 
	    	}
    function brandinfoSearchContent(url) {
     	 //alert(url);
     		 $.get(url).done(function (data) {
     			 
     			 $('#brandsearchwndow').jqxWindow('open');
     		$('#brandsearchwndow').jqxWindow('setContent', data);
     
     	}); 
     	} 
         function modelinfoSearchContent(url) {
          	 //alert(url);
          		 $.get(url).done(function (data) {
          			 
          			 $('#modelsearchwndow').jqxWindow('open');
          		$('#modelsearchwndow').jqxWindow('setContent', data);
          
          	}); 
          	} 
         function colorinfoSearchContent(url) {
           	 //alert(url);
           		 $.get(url).done(function (data) {
           			 
           			 $('#colorsearchwndow').jqxWindow('open');
           		$('#colorsearchwndow').jqxWindow('setContent', data);
           
           	}); 
           	} 
        
      

	
	 function funReadOnly(){
			$('#frmpurorder input').attr('readonly', true );
			$('#frmpurorder select').attr('disabled', true);
			
			$('#vehpurorderDate').jqxDateTimeInput({disabled: true});
			$('#vehpurorderdelDate').jqxDateTimeInput({disabled: true});
			$("#vehoredergrid").jqxGrid({ disabled: true});
			 $('#vehrefno').attr('disabled', true);
	 }
	 function funRemoveReadOnly(){
		 
			$('#frmpurorder input').attr('readonly', false );
			$('#frmpurorder select').attr('disabled', false);
			$("#vehoredergrid").jqxGrid({ disabled: false});
			$('#vehpurorderdelDate').jqxDateTimeInput({disabled: false});
			$('#vehpurorderDate').jqxDateTimeInput({disabled: false});
			 $('#vehrefno').attr('disabled', true);
			$('#docno').attr('readonly', true);
			  $('#vehpuraccname').attr('readonly', true);
			  $('#accid').attr('readonly', true);
			  $('#vehrefno').attr('readonly', true);
			  
			  
			if ($("#mode").val() == "A") {
				$('#vehpurorderdelDate').val(new Date());
				$('#vehpurorderDate').val(new Date());
				 $("#vehoredergrid").jqxGrid('clear');
				    $("#vehoredergrid").jqxGrid('addrow', null, {});
			   }
			
			if ($("#mode").val() == "E") {
			if($('#vehtype').val()=="VPR")
			  {
			
			  $('#vehrefno').attr('disabled', false);
		     $('#vehrefno').attr('readonly', true);
		
			  }
			}
			
	 }
	
	 
	 
		
		
		function funchkforedit()
	    {
		

		
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText.trim();	
					if(parseInt(items)>0)
						{
						
						 $("#btnEdit").attr('disabled', true );
						 $("#btnDelete").attr('disabled', true ); 
						 
						 
						 
						}
					else
						{
						 $("#btnEdit").attr('disabled', false);
						 $("#btnDelete").attr('disabled', false);
						}
				  
					
					
					
				} else {
				}
			}
			x.open("GET", "orderlinkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
			x.send();
		
		
		}
	 
	 
	   function funrefdisslno()
	   {
		   if($('#vehtype').val()=="VPR") 
			  {
			   $('#vehrefno').attr('disabled', false);
			 
			 
			 
			  } 
		   else
			   {
			   $('#vehrefno').val("");
			
			   $('#vehrefno').attr('disabled', true);
			  
			   
			   }
	   }
	 
	 function funSearchLoad(){
		 
		changeContent('vehOrederMastersearch.jsp'); 
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
			if( document.getElementById("vehtype").value=="VPR")
			{
	           var refno= document.getElementById('masterrefno').value;
			 
			 if(refno=="")
			 {
				 document.getElementById("errormsg").innerText=" Select Ref NO";	
				 document.getElementById('vehrefno').focus();
				 return 0;
			 }
			 
			 else
				 {
				 document.getElementById("errormsg").innerText="";
				 }
			 
		 
			}
			
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
		var refval= document.getElementById("nettotal").value;
		  if(refval=="")
			{
			 document.getElementById("errormsg").innerText="Total is Empty";
			 

			 return 0;
			   }
		else
			   {
			   document.getElementById("errormsg").innerText="";
			   }
		  var rows = $("#vehoredergrid").jqxGrid('getrows');
		    $('#vehoredergridlenght').val(rows.length);
		   //alert($('#gridlength').val());
		   for(var i=0 ; i < rows.length ; i++){
		   // var myvar = rows[i].tarif; 
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
               .attr("id", "vehodrtest"+i)
		       .attr("name", "vehodrtest"+i)
		       .attr("hidden", "true");   
		 
		   newTextBox.val(rows[i].sr_no+"::"+rows[i].brdid+" :: "+rows[i].modid+" :: " 
				   +rows[i].specification+" :: "+rows[i].clrid+" :: "+rows[i].qty+" :: "+rows[i].price+" :: "+rows[i].total+" :: "+rows[i].saveqty+" :: "+rows[i].rowno+" :: "+rows[i].qutval+" :: ");
		
		   newTextBox.appendTo('form');
		  
		    
		   }   
				 /* Applying Invoice Grid Updating Ends*/
				 
	    		return 1;
		} 
	 function  changeval()
	 {
		 
		 if($('#vehtypeval').val()!="")
		  {
		  
		  
		  $('#vehtype').val($('#vehtypeval').val());
		  }
		 
		 if($('#vehtypeval').val()=="VPR")
		  {
		
		  $('#vehrefno').attr('disabled', false);
		  
	  $('#vehrefno').attr('readonly', true);
	
		  }
	 }
	 function diserror()
	 {
		 
		 document.getElementById("errormsg").innerText=""; 
	 }
	  
	  function setValues(){
		 
		  if($('#hidvehpurorderDate').val()){
				 $("#vehpurorderDate").jqxDateTimeInput('val', $('#hidvehpurorderDate').val());
			  }
		 
		  
		  if($('#hidvehpurorderdelDate').val()){
				 $("#vehpurorderdelDate").jqxDateTimeInput('val', $('#hidvehpurorderdelDate').val());
			  }
		
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
			 
			
			var indexVa5 = document.getElementById("masterdoc_no").value;
		
	         if(indexVa5>0){
	        	 funchkforedit();
	         $("#vehorder").load("vehorderDetails.jsp?masterdoc="+indexVa5);  
	         } 
	         
	         changeval();
	         document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		}
	  
	  $(function(){
	        $('#frmpurorder').validate({
	        	 rules: { 
	        		 vehdesc:{maxlength:200}
	        		
	        	 },
		                 messages: {
		                	
		                	 vehdesc: {maxlength:"  Max 200 chars"}
		              
	                 }
	        });});
	
	    function funPrintBtn(){
	   	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	   	  
	   	   var url=document.URL;

	          var reurl=url.split("savePurchaseorder");
	          
	          $("#docno").prop("disabled", false);                
	          
	    
	  var win= window.open(reurl[0]+"printPurchorder?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	       
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


<div  class='hidden-scrollbar'>
<form id="frmpurorder" action="savePurchaseorder" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br><br>
<fieldset>
<table width="100%"><tr><td>
<table width="100%">
  <tr>
    <td width="4.2%"  align="right">&nbsp;&nbsp;Date</td> 
    <td width="5%"><div id="vehpurorderDate" name="vehpurorderDate" value='<s:property value="vehpurorderDate"/>'></div>
    <input type="hidden" id="hidvehpurorderDate" name="hidvehpurorderDate" value='<s:property value="hidvehpurorderDate"/>'/></td>
    
    <td width="60%" align="right">Doc No</td>
    <td width="21%"><input type="text" id="docno" name="docno" style="width:40%;" value='<s:property value="docno"/>' tabindex="-1"/>
    </td>
  </tr>
</table>
</td>
</tr>
<tr><td>                   
<table width="100%">
  <tr>
    <td width="2%" align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Vendor</td>
  <td width="29%">  <input type="text" id="accid" name="accid" style="width:20%;" placeholder="Press F3 to Search" value='<s:property value="accid"/>'  onkeydown="getaccountdetails(event)" onblur="diserror()"/>
   <input type="text" id="vehpuraccname" name="vehpuraccname" style="width:70%;" value='<s:property value="vehpuraccname"/>'/>
    <input type="hidden" id="headdoc" name="headdoc" value='<s:property value="headdoc"/>'/></td>
    <td align="right"  width="7%">Type</td>
    <td width="6%"><select id="vehtype" name="vehtype" style="width:92%;" value='<s:property value="vehtype"/>' onchange="funrefdisslno()">
      <option value="DIR">DIR </option>
       <option value="VPR">VPR</option></select>
     </td>
    
    <td width="8%"><input type="text" id="vehrefno" name="vehrefno" style="width:96%;" placeholder="Press F3 to Search" value='<s:property value="vehrefno"/>'  onkeydown="getrefDetails(event)"/></td>
     <td width="34%"></td>
  </tr>
  </table>
  </td></tr>
  <tr><td>
<table>

  <tr>
    <td align="right"  width="2%">Exp.Delivery</td>
    <td width="5%"><div id="vehpurorderdelDate" name="vehpurorderdelDate" value='<s:property value="vehpurorderdelDate"/>'></div>
    
     <input type="hidden" id="hidvehpurorderdelDate" name="hidvehpurorderdelDate" value='<s:property value="hidvehpurorderdelDate"/>'/></td>
    <td >Description<input type="text" id="vehdesc" name="vehdesc" style="width:70%;" value='<s:property value="vehdesc"/>'/></td>
  </tr>
</table>
</td></tr></table>
</fieldset>
<br>
<fieldset>

<div id="vehorder"><jsp:include page="vehorderDetails.jsp"></jsp:include></div> 
</fieldset>
<input type="hidden" id="masterrefno" name="masterrefno" value='<s:property value="masterrefno"/>'/>

<input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'/>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="brandval" name="brandval" value='<s:property value="brandval"/>'/>
<input type="hidden" id="nettotal" name="nettotal" value='<s:property value="nettotal"/>'/>
<input type="hidden" id="headacccode" name="headacccode" value='<s:property value="headacccode"/>'/>

<input type="hidden" id="vehoredergridlenght" name="vehoredergridlenght" value='<s:property value="vehoredergridlenght"/>'/>
<input type="hidden" id="vehtypeval" name="vehtypeval" value='<s:property value="vehtypeval"/>'/>




</form>
<div id="colorsearchwndow">
   <div ></div>
</div>
<div id="modelsearchwndow">
   <div ></div>
</div>
<div id="brandsearchwndow">
   <div ></div>
</div>
	<div id="accountSearchwindow">
   <div ></div>
</div>
<div id="refnosearchwindow">
   <div ></div>
</div>
</div>
</div>
</body>
</html>
