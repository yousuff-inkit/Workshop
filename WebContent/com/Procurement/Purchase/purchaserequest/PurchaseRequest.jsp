<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<%
	String mod = request.getParameter("mod") == null ? "view" : request
			.getParameter("mod").toString();
 String purchasearray = request.getParameter("purchasearray") == null? "0": request.getParameter("purchasearray").toString() ;
 System.out.println("purchasearray==="+purchasearray);

%>
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
 
 <%
	String contextPath=request.getContextPath();
 %>
 
<style>
form label.error {
color:red;
  font-weight:bold;

}

.textbox {
    border: 0;
    height: 25px;
    width: 20%;
    border-radius: 5px;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -moz-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-background-clip: padding-box;
    outline: 0;
}
</style>
<script type="text/javascript">
<%-- var text1='<%=dtype%>'; --%>
var mod1='<%=mod%>';
var prcharray='<%=purchasearray%>';
 $(document).ready(function () {
	 
   	 $("#reqmasterdate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});   
   	 
  
  /*  	$('#brandsearchwndow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Brand Search',position: { x: 250, y: 60 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#brandsearchwndow').jqxWindow('close'); */
/*     
 	 $('#brandsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Brand Search' ,position: { x: 350, y: 60 }, keyboardCloseKey: 27});
     $('#brandsearchwndow').jqxWindow('close'); 

     $('#modelsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Model Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
     $('#modelsearchwndow').jqxWindow('close');
     $('#colorsearchwndow').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Color Search' ,position: {x: 600, y: 60  }, keyboardCloseKey: 27});
     $('#colorsearchwndow').jqxWindow('close');
 */
     
 
 

 
     $('#sidesearchwndow').jqxWindow({ width: '55%', height: '95%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Product Search ' , position: { x: 600, y: 0 }, keyboardCloseKey: 27});
     $('#sidesearchwndow').jqxWindow('close');   
     $('#searchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
     $('#searchwindow').jqxWindow('close');
	   $('#itemdocno').dblclick(function(){

			  if($("#mode").val() == "A" || $("#mode").val() == "E")
				  {
		 
			 
	  	    $('#searchwindow').jqxWindow('open');
	  	
			if(document.getElementById("itemtype").value=="1") 
				{
			 
				refsearchContent('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costCodeSearchGrid.jsp?docno='+document.getElementById("itemtype").value); 	
				}
			else if(document.getElementById("itemtype").value=="6")
			{
			 refsearchContent('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/fleetGrid.jsp?'); 	
			}
		
			else
				{
				 refsearchContent('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costunitsearch.jsp?docno='+document.getElementById("itemtype").value); 	
				}
			
			 
				  }
		  }); 
		
	});
 
 
 function getitem(event){
  	 var x= event.keyCode;
  	 if(x==114){

  		  $('#searchwindow').jqxWindow('open');
  			
  		if(document.getElementById("itemtype").value=="1") //com/search/costunit/costCodeSearchGrid.jsp
		{
		refsearchContent('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costCodeSearchGrid.jsp?docno='+document.getElementById("itemtype").value); 	
		}
  		
		else if(document.getElementById("itemtype").value=="6")
		{
		 refsearchContent('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/fleetGrid.jsp?'); 	
		}
	
  		
	else
		{
		 refsearchContent('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costunitsearch.jsp?docno='+document.getElementById("itemtype").value); 	
		}
	

  		 
  		  
  	 
  	 }
  	 else{
  		 }
  	 }  
  	  function refsearchContent(url) {
       //alert(url);
          $.get(url).done(function (data) {
  //alert(data);
        $('#searchwindow').jqxWindow('setContent', data);

  	}); 
    	}
 
 
       
          function productSearchContent(url) {
          	 //alert(url);
          		 $.get(url).done(function (data) {
          			 
          			 $('#sidesearchwndow').jqxWindow('open');
          		$('#sidesearchwndow').jqxWindow('setContent', data);
          
          	}); 
          	} 
    
         
          
    function funReset(){
		//$('#frmpurReq')[0].reset(); 
	}
	function funReadOnly(){
		$('#frmpurReq input').attr('readonly', true );
		$('#frmpurReq textarea').attr('readonly', true );
		$('#frmpurReq select').attr('disabled', true);

		$('#reqmasterdate').jqxDateTimeInput({ disabled: true});
		 
		$("#purchasedetails").jqxGrid({ disabled: true});
		
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
	
	}
	function funRemoveReadOnly(){
		 chkmultiqty();
		$('#frmpurReq input').attr('readonly', false );
		$('#frmpurReq textarea').attr('readonly', false );
		$('#frmpurReq select').attr('disabled', false);
	
		$('#reqmasterdate').jqxDateTimeInput({ disabled: false});
	 
		$("#purchasedetails").jqxGrid({ disabled: false});
		$('#docno').attr('readonly', true);
		if ($("#mode").val() == "A") {
			$('#reqmasterdate').val(new Date());
 
			 $("#purchasedetails").jqxGrid('clear');
			    $("#purchasedetails").jqxGrid('addrow', null, {});
		   }
		
		
		 if(mod1=="A")
			{
		    	
		    	$("#vehpurcgasereq").load("purreqDetails.jsp?prcharray="+'<%=purchasearray.replaceAll("\\s","a@b@c")%>'+"&modebprf=a1");
		     	}
		
		 chkcostcode();
		 
		 $('#itemdocno').attr('readonly', true);
		 $('#itemname').attr('readonly', true);
		 
		  
		 
		 
		 
		 
	}
	 
	
 
	
	
	
	function funNotify(){	
 
		
		
		
 		 var rows = $("#purchasedetails").jqxGrid('getrows');
		    $('#reqgridlenght').val(rows.length);
		   //alert($('#gridlength').val());
		   for(var i=0 ; i < rows.length ; i++){
		   // var myvar = rows[i].tarif; 
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "reqtest"+i)
		       .attr("name", "reqtest"+i)  
		    .attr("hidden", "true"); 
		    
		 
		    newTextBox.val(rows[i].psrno+"::"+rows[i].prodoc+" :: "+rows[i].unitdocno+" :: "+rows[i].qty+" :: "+rows[i].specid+" :: ");
		
		   newTextBox.appendTo('form');
		  
		    
		   }   
		
		return 1;
	} 

	function funChkButton() {
		
		frmpurReq.submit();
	}

	function funSearchLoad(){

		 changeContent('mainsearch.jsp?'); 
	}
   $(function(){
        $('#frmpurReq').validate({
                rules: { 
              
                
           
                	purdesc:{maxlength:100}
             
                 },
                 messages: {
                	 purdesc: {maxlength:" Max 100 chars"}
               
                
               
              
                 }
        });});
    
		 
	function funFocus(){
		 
	   	$('#reqmasterdate').jqxDateTimeInput('focus'); 	    		
	} 
	 
	function setValues() {
		if($('#hidreqmasterdate').val()){
			$("#reqmasterdate").jqxDateTimeInput('val', $('#hidreqmasterdate').val());
		}
		 
   	  var docVal1 = document.getElementById("masterdoc_no").value;
  	  
      	if(docVal1>0)
      		{
      	//	funchkforedit();
      	
      	
		 var indexVal2 = document.getElementById("masterdoc_no").value;
		 

     	  
         $("#vehpurcgasereq").load("purreqDetails.jsp?reqdoc="+indexVal2);
			funchkforedit(); 
      		}
      	if($('#msg').val()!=""){
 		   $.messager.alert('Message',$('#msg').val());
 		  }
	 
      	document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";   
      	//document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
			
		
	}
	
    function funPrintBtn(){
  	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
  	  
  	   var url=document.URL;

         var reurl=url.split("savepurreqdata");
         
        // $("#docno").prop("disabled", false);                
         
   
  var brhid=<%=session.getAttribute("BRANCHID").toString()%>
        	 var dtype=$('#formdetailcode').val();
  
   var win= window.open(reurl[0]+"printPurchaseReq?docno="+document.getElementById("masterdoc_no").value+"&dtype="+dtype+"&brhid="+brhid,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");    
 win.focus();
  	   } 
  	  
  	   else {
 	    	      $.messager.alert('Message','Select a Document....!','warning');
 	    	      return false;
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
					 
					}
			  
				
				
				
			} else {
			}
		}
		x.open("GET", "reqlinkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
		x.send();
	
	
	}
	
	 
	 function getitemtype(){ 
		 
			
		   var x=new XMLHttpRequest();
		   x.onreadystatechange=function(){
		   if (x.readyState==4 && x.status==200)
		    {
		      items= x.responseText;
		       
		      items=items.split('####');
		           var docno=items[0].split(",");
		           var type=items[1].split(",");
		        
		           var optionstype = '';

		
		           for ( var i = 0; i < type.length; i++) {
		        	   optionstype += '<option value="' + docno[i] + '">' + type[i] + '</option>';
			        }
		            
		            $("select#itemtype").html(optionstype); 	
		            
		        
		            if($('#hideitemtype').val()!="")
					  {
					  
					  
					  $('#itemtype').val($('#hideitemtype').val());   
					  
					  }
				 
		  
		    }
		       }
		   x.open("GET","getitem.jsp?",true);
			x.send();
		        
		      
		        }
	 
     
     function chkcostcode()
     {
      
        var x=new XMLHttpRequest();
        x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200)
         {
           var items= x.responseText.trim();
          
           if(parseInt(items)>0)
            {
        	   
        	   document.getElementById("costcheck").value=1;
        	   
        	   $('#hcostcodes').show();
        	    
        	   
         	  
             }
               else
           { 
            	   document.getElementById("costcheck").value=0;
            	   $('#hcostcodes').hide();
           }
           
            }}
        x.open("GET","<%=contextPath%>/com/Procurement/Purchase/costcodesearch/checkcostcode.jsp?",true);
     	x.send();
      
           
             
     	
     } 
     
	 function cleardata()
	 {
		 document.getElementById("itemdocno").value="";
		 document.getElementById("itemname").value="";
	/* 	 document.getElementById("clientname").value="";
	 
		 document.getElementById("cldocno").value="";
		 document.getElementById("siteid").value="";
		 document.getElementById("site").value=""; */
		 
	 
	 }
	 
	 
</script>
</head>
<body onload="setValues();chkcostcode();getitemtype();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmpurReq" action="savepurreqdata" autocomplete="OFF" >     

<jsp:include page="../../../../header.jsp"></jsp:include>
<jsp:include page="multiqty.jsp"></jsp:include><br/>
<br>
<fieldset>

<table width="100%" >                        
  <tr>
    <td width="4.5%" align="right">Date</td> 
    <td colspan="2"  width="6%"><div id='reqmasterdate' name='reqmasterdate' value='<s:property value="reqmasterdate"/>'></div> 
                     <input type="hidden" id="hidreqmasterdate" name="hidreqmasterdate" value='<s:property value="hidreqmasterdate"/>'/></td>
                     
                 <td width="20%" align="right">Ref No</td><td><input type="text" id="refno" name="refno" value='<s:property value="refno"/>'  /></td>
                 
                <td width="50%" align="right">&nbsp;<div id="hcostcodes" hidden="true"> Group&nbsp; <select  id="itemtype"  name="itemtype" style="width:15%;" onchange="cleardata()"> 
    <option>
     </option>   
                             
    </select> &nbsp;  &nbsp;
    Job No&nbsp;<input type="text" id="itemdocno" placeholder="Press F3 to Search"    name="itemdocno"  onkeydown="getitem(event);" value='<s:property value="itemdocno"/>' >
    
    <input type="text" id="itemname" name="itemname" style="width:43%;"   value='<s:property value="itemname"/>' > </div></td>
                 
                 
    <td width="5%" align="right">Doc No</td>
    <td width="33%"><input type="text" id="docno" name="docno" tabindex="-1" value='<s:property value="docno"/>'/></td>
  </tr>
  
   
</table>    
<table width="100%" >                                                                 
<tr>
  

 <td width="3%" align="right">Description</td>
    <td colspan="2"  width="70%">  <input type="text" id="purdesc" name="purdesc"  style="width:70%;" value='<s:property value="purdesc"/>'/></td>
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
 
 <input type="hidden" name="reqgridlenght" id="reqgridlenght" value='<s:property value="reqgridlenght"/>' />   
 
 
  <input type="text" name="gridtext" id="gridtext"  style="width:0%;height:0%;"  class="textbox" value='<s:property value="gridtext"/>'  />   
  
    <input type="text" name="gridtext1" id="gridtext1"  style="width:0%;height:0%;"  class="textbox" value='<s:property value="gridtext1"/>' />   
    
 
 
 <input type="hidden" id="costtr_no" name="costtr_no"  value='<s:property value="costtr_no"/>'/> 
 <input type="hidden" id="costcheck" name="costcheck"  value='<s:property value="costcheck"/>'/> 
 <input type="hidden" id="hideitemtype" name="hideitemtype"  value='<s:property value="hideitemtype"/>'/> 
 <input type="hidden" id="hidetype" name="hidetype"  value='<s:property value="hidetype"/>'/>


</form>

	 <div id="sidesearchwndow">
	   <div ></div>
	</div>
 <div id="searchwindow">
   <div ></div>
</div>
<!-- <div id="colorsearchwndow">
   <div ></div>
</div>
<div id="modelsearchwndow">
   <div ></div>
</div>
<div id="brandsearchwndow">
   <div ></div>
</div> -->

</div>
</body>
</html>