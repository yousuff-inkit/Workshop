<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
 
 
 
<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
.icons {
	width: 3em;
	height: 3em;
	border: none;
	background-color: #E0ECF8;
}
.iconss {
	width: 4em;
	height: 3em;
	border: none;
	background-color: #E0ECF8;
}
</style>

<script type="text/javascript">   
 
   $(document).ready(function () { 
		
	   /* Date */ 	
       $("#masterdate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
      
       
      
       $('#brandsearchwndows').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Brand Search' ,position: { x: 250, y: 100 }, keyboardCloseKey: 27});
       $('#brandsearchwndows').jqxWindow('close'); 
       $('#modelsearchwndows').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Model Search' ,position: { x: 500, y: 100 }, keyboardCloseKey: 27});
       $('#modelsearchwndows').jqxWindow('close');
       $('#groupsearchwndows').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Group Search' ,position: { x: 500, y: 100 }, keyboardCloseKey: 27});
       $('#groupsearchwndows').jqxWindow('close');
 
       $("#btnDelete").attr('disabled', true );
    
          
           
          $('#groupname').dblclick(function(){
        	  if ($("#mode").val() == "A" || $("#mode").val() == "E") {   
       		 
	  	    $('#groupsearchwndows').jqxWindow('open');
	   
	  	  groupContent('groupsearch.jsp?', $('#groupsearchwndows')); 
       			  
        	  }
     });
    
    
        $('#brandname').dblclick(function(){
        	  if ($("#mode").val() == "A" || $("#mode").val() == "E") {   
       		 
	  	    $('#brandsearchwndows').jqxWindow('open');
	   
	  	  brandnameContent('brandSearch.jsp?', $('#brandsearchwndows')); 
       			  
        	  }
     });
      
    	$('#modelname').dblclick(function(){
	 		if (($("#mode").val() == "A" || $("#mode").val() == "E") && document.getElementById("brandid").value!="") {   
	    	 
	  	    $('#modelsearchwndows').jqxWindow('open');
	   
	  	  modelContent('modelsearch.jsp?brandid='+document.getElementById("brandid").value, $('#modelsearchwndows')); 
	    			   
	 		}
	           });
       
        
 
       
      
    
    
 
       
});
   
 
   function getbranddetails(event){
	  	 var x= event.keyCode;
	  	 if(x==114){
	  		if ($("#mode").val() == "A" ||$("#mode").val() == "E") {   
	    		   
	  	  $('#brandsearchwndows').jqxWindow('open');
	  
	  	brandnameContent('brandSearch.jsp?', $('#brandsearchwndows'));  
	    			    
	  		}
	  		}
	  	 
	  	 }  
   function getgroup(event){
	  	 var x= event.keyCode;
	  	 if(x==114){
	  		if ($("#mode").val() == "A" ) {   
	    		   
	  	  $('#groupsearchwndows').jqxWindow('open');
	  
	  	groupContent('groupsearch.jsp?', $('#groupsearchwndows'));  
	    			    
	  		}
	  		}
	  	 
	  	 }  
   function groupContent(url) {
       //alert(url);
          $.get(url).done(function (data) {
//alert(data);
        $('#groupsearchwndows').jqxWindow('setContent', data);

	}); 
    	} 

   
   //groupname getgroup groupsearch.jsp groupsearchwndows
   
   
		  function brandnameContent(url) {
	        //alert(url);
	           $.get(url).done(function (data) {
	 //alert(data);
	         $('#brandsearchwndows').jqxWindow('setContent', data);

		}); 
	     	} 
   
   
		 	function getmodeldetails(event){
		        var x= event.keyCode;
		            if(x==114){
		            	if ($("#mode").val() == "A" ||$("#mode").val() == "E") {   
		         		   
		        $('#modelsearchwndows').jqxWindow('open');

		           modelContent('modelsearch.jsp?brandid='+document.getElementById("brandid").value, $('#modelsearchwndows')); 
		         			  
		            	}
		            	}
		         
		                   }  
		 	function modelContent(url) {
			    //alert(url);
			       $.get(url).done(function (data) {
			//alert(data);
			     $('#modelsearchwndows').jqxWindow('setContent', data);
			
			            }); 
			 	} 	  
 
	  
   function funReset(){
		//$('#frmcostgroup')[0].reset(); 
	}
   
	function funReadOnly(){
		$('#frmcostgroup input').attr('readonly', true );
		$('#frmcostgroup textarea').attr('readonly', true );
		 
		$('#frmcostgroup select').attr('disabled', true);
		$('#masterdate').jqxDateTimeInput({ disabled: true}); 
		   
		
	}
	
	function funRemoveReadOnly(){
		$('#frmcostgroup input').attr('readonly', true );
		 
		$('#frmcostgroup select').attr('disabled', false);
		 
	  
		$('#masterdate').jqxDateTimeInput({ disabled: false}); 
		$('#desc').attr('readonly', false );  
		if($("#mode").val()=="A")
			{
			 
			$('#masterdate').val(new Date());
			}
		 
		} 

	
	function funNotify(){	
		
		if(document.getElementById("groupname").value=="")
			{
			document.getElementById("groupname").focus();
			document.getElementById("errormsg").innerText=" Search Group";
			return 0;
			}
		
		if(document.getElementById("brandname").value=="")
		{
			document.getElementById("brandname").focus();
			document.getElementById("errormsg").innerText=" Search Brand";
			return 0;
		
		}
		if(document.getElementById("modelname").value=="")
		{
			document.getElementById("modelname").focus();
			document.getElementById("errormsg").innerText=" Search Model";
			return 0;
		
		}
	 
		// groupname brandname modelname
     
 
 
		return 1;
	} 

	function funChkButton() {
		/* funReset(); */
	}

	function funSearchLoad(){
		changeContent('mastersearch.jsp'); 
	}
		
	function funFocus(){
	   	$('#masterdate').jqxDateTimeInput('focus'); 	    		
	}
 
 

 	
 
 
	function setValues() {
	
		// main
		if($('#hidmasterdate').val()){
			$("#masterdate").jqxDateTimeInput('val', $('#hidmasterdate').val());
		}
	 
 
		 if($('#msg').val()!=""){
			
			   $.messager.alert('Message',$('#msg').val());
			  }
		 
		 
 
		
		 
		 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	 
		 
	}
	  
	  
 
     
 	</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmcostgroup" action="saveLCG" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div class='hidden-scrollbar'>
<fieldset>
<legend>Lease Cost Group</legend>           
  <br> 
<fieldset>
<table width="90%"  >   
       
  <tr>
    <td width="105"   align="right">Date</td> 
    <td width="270"  ><div id='masterdate' name='masterdate' value='<s:property value="masterdate"/>'></div>
     </td>
 
                      
    <td width="65"  align="right">Group</td>
    <td width="360" > <%-- <select id="groupname" style="resize:none;width:98.3%;"  value='<s:property value="groupname"/>'>
      <option></option>
  
</select> 
     --%>
      <input type="text" id="groupname" name="groupname" style="resize:none;width:98.3%;"  value='<s:property value="groupname"/>' placeholder="Press F3 to Search" onkeydown="getgroup(event);"   /></td> 
    <td width="115" align="right"  >Doc No</td>
    <td width="395"><input type="text" id="docno" name="docno"  value='<s:property value="docno"/>' /></td>

  </tr>
  <tr>
  <td  align="right">Brand</td>
    <td >
      <input type="text" id="brandname" name="brandname"  style="resize:none;width:98.3%;" value='<s:property value="brandname"/>' placeholder="Press F3 to Search"  onkeydown="getbranddetails(event);"/></td> 
    <td  align="right">Model</td>
    <td  >
      <input type="text" id="modelname" name="modelname"   style="resize:none;width:98.3%;"value='<s:property value="modelname"/>' placeholder="Press F3 to Search"  onkeydown="getmodeldetails(event);"   /></td>  
      <td  >&nbsp;</td>
         <td  >&nbsp;</td> 
  </tr>
  
    <tr>  
     <td align="right">Description</td><td colspan="3" ><input type="text" id="desc" name="desc"  placeholder="Enter Description"  style="resize:none;width:99%;"  value='<s:property value="desc"/>' /></td>
      <td  >&nbsp;</td>
         <td  >&nbsp;</td> 
 </tr>
</table>
 </fieldset>
 <br>
  <table width="100%">
      <tr>
       
        <td >	 <div id=loaddatas></div>  
</td>
        
      </tr>
    </table>
 
 
</fieldset>
 
 <div id="ids">
<jsp:include page="downgrid.jsp"></jsp:include></div>
 
    
 
 
 <input type="hidden" id="hidmasterdate" name="hidmasterdate" value='<s:property value="hidmasterdate"/>'/>
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' /> 
 <input type="hidden" id="brandid" name="brandid" value='<s:property value="brandid"/>'/> 
 <input type="hidden" id="modelid" name="modelid" value='<s:property value="modelid"/>'/>
  <input type="hidden" id="groupid" name="groupid" value='<s:property value="groupid"/>'/>
 <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>  
      
             
  
  
    <br> 
</div>
</form>

<div id="brandsearchwndows">
   <div ></div>
</div>
<div id="modelsearchwndows">
   <div ></div>
</div>
 <div id="groupsearchwndows">
   <div ></div>
</div>
 
 
</div>
</body>
</html>