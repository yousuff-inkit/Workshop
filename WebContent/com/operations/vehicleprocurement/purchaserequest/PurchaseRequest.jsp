<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>
<%--   <% 
  
String dtype=  session.getAttribute("Code").toString();
  System.out.println("sss    "+dtype);
  %>  --%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>GatewayERP(i)</title>
 <jsp:include page="../../../../includes.jsp"></jsp:include> 
<style>
form label.error {
color:red;
  font-weight:bold;

}
</style>
<script type="text/javascript">
<%-- var text1='<%=dtype%>'; --%>
 $(document).ready(function () {
	 
   	 $("#vehpurreqDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});   
   	 
   	 $("#vehexpDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});   
  /*  	$('#brandsearchwndow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Brand Search',position: { x: 250, y: 60 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#brandsearchwndow').jqxWindow('close'); */
    
 	 $('#brandsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Brand Search' ,position: { x: 350, y: 60 }, keyboardCloseKey: 27});
     $('#brandsearchwndow').jqxWindow('close'); 

     $('#modelsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Model Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
     $('#modelsearchwndow').jqxWindow('close');
     $('#colorsearchwndow').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Color Search' ,position: {x: 600, y: 60  }, keyboardCloseKey: 27});
     $('#colorsearchwndow').jqxWindow('close');

     
     


	
		
	});
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
         
       
          
          
          
    function funReset(){
		//$('#frmvehpurReq')[0].reset(); 
	}
	function funReadOnly(){
		$('#frmvehpurReq input').attr('readonly', true );
		$('#frmvehpurReq textarea').attr('readonly', true );
		$('#frmvehpurReq select').attr('disabled', true);

		$('#vehpurreqDate').jqxDateTimeInput({ disabled: true});
		$('#vehexpDate').jqxDateTimeInput({ disabled: true});
		$("#purchasedetails").jqxGrid({ disabled: true});
		
	   
	
	}
	function funRemoveReadOnly(){
		

		
		
		$('#frmvehpurReq input').attr('readonly', false );
		$('#frmvehpurReq textarea').attr('readonly', false );
		$('#frmvehpurReq select').attr('disabled', false);
	
		$('#vehpurreqDate').jqxDateTimeInput({ disabled: false});
		$('#vehexpDate').jqxDateTimeInput({ disabled: false});
		$("#purchasedetails").jqxGrid({ disabled: false});
		$('#docno').attr('readonly', true);
		if ($("#mode").val() == "A") {
			$('#vehpurreqDate').val(new Date());
			$('#vehexpDate').val(new Date());
			 $("#purchasedetails").jqxGrid('clear');
			    $("#purchasedetails").jqxGrid('addrow', null, {});
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
		x.open("GET", "reqlinkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
		x.send();
	
	
	}
	
	
	
	function funNotify(){	
		
		
/* if ($("#brchName").val() == ""||$("#brchName").val() == "null" || typeof($("#brchName").val()) == "undefined" ) { 
			
			document.getElementById("errormsg").innerText="Your Secure Session Has Expired";
			return 0;
		} */
		if ($("#mode").val() == "A") {
			var gridval= document.getElementById("gridvalidate").value;	
			if(gridval==""){
				
				document.getElementById("errormsg").innerText="Brand is empty";
				
				return 0;
			}
			else
				{
				document.getElementById("errormsg").innerText="";
				}
		}
		
		
		
		
		
 		 var rows = $("#purchasedetails").jqxGrid('getrows');
		    $('#vehreqgridlenght').val(rows.length);
		   //alert($('#gridlength').val());
		   for(var i=0 ; i < rows.length ; i++){
		   // var myvar = rows[i].tarif; 
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "vehreqtest"+i)
		       .attr("name", "vehreqtest"+i)
		    .attr("hidden", "true"); 
		    
		 
		   newTextBox.val(rows[i].sr_no+"::"+rows[i].brdid+" :: "+rows[i].modid+" :: "
				   +rows[i].specification+" :: "+rows[i].clrid+" :: "+rows[i].qty+" :: "+rows[i].remarks+" :: ");
		
		   newTextBox.appendTo('form');
		  
		    
		   }   
		
		return 1;
	} 

	function funChkButton() {
		
		frmvehpurReq.submit();
	}

	function funSearchLoad(){

		 changeContent('vehreqMastersearch.jsp?'); 
	}
   $(function(){
        $('#frmvehpurReq').validate({
                rules: { 
              
                
           
                	purdesc:{maxlength:200}
             
                 },
                 messages: {
                	 purdesc: {maxlength:" Max 200 chars"}
               
                
               
              
                 }
        });});
    
		 
	function funFocus(){
		 
	   	$('#vehpurreqDate').jqxDateTimeInput('focus'); 	    		
	}
		   function combochange()
		   {
			   if($('#cmbreftypeval').val()!="")
				  {
				  
				  
				  $('#cmbreftype').val($('#cmbreftypeval').val());
				  }
			  
		   }
	 
	function setValues() {
		if($('#hidvehpurreqDate').val()){
			$("#vehpurreqDate").jqxDateTimeInput('val', $('#hidvehpurreqDate').val());
		}
		if($('#hidvehexpDate').val()){
			$("#vehexpDate").jqxDateTimeInput('val', $('#hidvehexpDate').val());
		}
		  
   	  var docVal1 = document.getElementById("masterdoc_no").value;
  	  
      	if(docVal1>0)
      		{
      		funchkforedit();
		 var indexVal2 = document.getElementById("masterdoc_no").value;
     	  
         $("#vehpurcgasereq").load("purreqDetails.jsp?vehreqdoc="+indexVal2);
      		}
      	if($('#msg').val()!=""){
 		   $.messager.alert('Message',$('#msg').val());
 		  }
	
      	combochange();  
      	document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";   
		
		
	}
	
    function funPrintBtn(){
  	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
  	  
  	   var url=document.URL;

         var reurl=url.split("savepurreq");
         
         $("#docno").prop("disabled", false);                
         
   
 var win= window.open(reurl[0]+"printPurreq?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
      
 win.focus();
  	   } 
  	  
  	   else {
 	    	      $.messager.alert('Message','Select a Document....!','warning');
 	    	      return false;
 	    	     }
 	    	
  	}
	
</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmvehpurReq" action="savepurreq" autocomplete="OFF" >

<jsp:include page="../../../../header.jsp"></jsp:include><br/>
<br>
<fieldset>
        <!-- vehpurreqDate, docno,cmbclientb,txtclientname,txtaddress -->
<table width="100%" >                        
  <tr>
    <td width="4.5%" align="right">Date</td>  
    <td colspan="2"  width="6%"><div id='vehpurreqDate' name='vehpurreqDate' value='<s:property value="vehpurreqDate"/>'></div>
                     <input type="hidden" id="hidvehpurreqDate" name="hidvehpurreqDate" value='<s:property value="hidvehpurreqDate"/>'/></td>
                     
                        <td align="right" width="35.5%">Type</td>
        <td width="10%"><select id="cmbreftype" name="cmbreftype" style=width:62%  value='<s:property value="cmbreftype"/>' onchange="fundisrefno();">
            <option value="Fleet">Fleet</option>
            <option value="Lease">Lease</option>
                        </select></td> 
    <td width="32%" align="right">Doc No</td>
    <td width="33%"><input type="text" id="docno" name="docno" tabindex="-1" value='<s:property value="docno"/>'/></td>
  </tr>
  
   
</table>    
<table width="100%" >                                                                   
<tr>
 <td width="2.5%" align="right">Exp.Delivery</td>
    <td colspan="2" width="1%"><div id='vehexpDate' name='vehexpDate' value='<s:property value="vehexpDate"/>'></div>
                     <input type="hidden" id="hidvehexpDate" name="hidvehexpDate" value='<s:property value="hidvehexpDate"/>'/></td>

 <td width="3%" align="right">Description</td>
    <td colspan="2"  width="70%">       <input type="text" id="purdesc" name="purdesc"  style="width:70%;" value='<s:property value="purdesc"/>'/></td>
     <td></td> <td></td>          
</tr>

</table>    
</fieldset>    
  
<br/>
<fieldset>
<div id="vehpurcgasereq">  <jsp:include page="purreqDetails.jsp"></jsp:include></div>
 </fieldset>
 
 <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>' />
 
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />

  <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
 <input type="hidden" id="cmbreftypeval" name="cmbreftypeval"  value='<s:property value="cmbreftypeval"/>'/>

 <input type="hidden" name="brandval" id="brandval" value='<s:property value="brandval"/>' />  
 <input type="hidden" name="vehreqgridlenght" id="vehreqgridlenght" value='<s:property value="vehreqgridlenght"/>' />  
 
 <input type="hidden" name="gridvalidate" id="gridvalidate" value='<s:property value="gridvalidate"/>' />  
 


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

</div>
</body>
</html>