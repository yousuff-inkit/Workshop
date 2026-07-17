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

<% String masterdoc_no=request.getParameter("masterdoc_no");
   String branchvals=request.getParameter("branchvals");
   String currencyvals=request.getParameter("currencyvals");
   String checkval=request.getParameter("checkval"); %>
   
<script type="text/javascript">
<%-- var text1='<%=dtype%>'; --%>

var masterdoc_no='<%=masterdoc_no%>';
var checkval='<%=checkval%>';

$(document).ready(function () {
	 $("#client").hide();	 
	 $("#r1").hide();
   	 $("#EnquiryDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});    
   	 $('#brandsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Brand Search' ,position: { x: 200, y: 120 }, keyboardCloseKey: 27});
     $('#brandsearchwndow').jqxWindow('close'); 
     $('#clientsearch1').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#clientsearch1').jqxWindow('close');
     $('#modelsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Model Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#modelsearchwndow').jqxWindow('close');
     $('#enqsrcwindow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Enquiry Source Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#enqsrcwindow').jqxWindow('close');
     $('#colorsearchwndow').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Color Search' ,position: { x: 500, y: 120 }, keyboardCloseKey: 27});
     $('#colorsearchwndow').jqxWindow('close');
     
    $('#cmbclient').dblclick(function(){
	  	    $('#clientsearch1').jqxWindow('open');
	       clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1')); 
       });
    $('#enqsrc').dblclick(function(){
  	   $('#enqsrcwindow').jqxWindow('open');
       enqsrcSearchContent('enqsrcSearchGrid.jsp?id=1', $('#enqsrcwindow')); 
   });
    if(document.getElementById("txtradio").value==1)
    	{
    	document.getElementById("r2").checked = true;
    
		$("#cmbclient").hide();
		$("#btnnewclient").hide();
    	}
  
   if(document.getElementById("txtradio").value=="")
	   {
	
	   $("#cmbclient").hide();
		$("#btnnewclient").hide();
	   }
   
   $('#EnquiryDate').on('change', function (event) {
       var maindate = $('#EnquiryDate').jqxDateTimeInput('getDate');
 	 	 if ($("#mode").val() == "A" || $('#mode').val()=="E" ) {   
    funDateInPeriod(maindate);
   	 }
  });
   
   
   
	  
   
 		$("#r1").click(function() {
 			
			document.getElementById("r2").checked = false;
			
			$('#cmbclient').attr('readonly', false );
			$('#txtclientname').attr('readonly', false );
			$('#txtaddress').attr('readonly', false );
			$('#txtmobile').attr('readonly', false );
			$('#txtemail').attr('readonly', false );
			$('#txtRemarks').attr('readonly', false );
		
			 document.getElementById("errormsg").innerText=""; 
			 document.getElementById("txtradio").value="1";
			 
			$("#btnnewclient").hide();
			$("#cmbclient").hide();
 			
 			
		});
		$("#r2").click(function() {
			
			document.getElementById("r1").checked = false;
			$('#cmbclient').attr('readonly', true );
			$('#txtclientname').attr('readonly', true );
			$('#txtaddress').attr('readonly', true );
			$('#txtmobile').attr('readonly', true );
			$('#txtemail').attr('readonly', true );
			$('#txtRemarks').attr('readonly', false );
			$("#cmbclient").show();
		
			$("#jqxEnquiry").jqxGrid({ disabled: false});
			 document.getElementById("txtradio").value="2";
			   document.getElementById("errormsg").innerText="";
			$("#btnnewclient").show();
			
		}); 
    
		
		  
		/* $('#txtdescription').keydown(function (evt) {
		     if (evt.keyCode==9) {
		             event.preventDefault();
		             $('#jqxJournalVoucher').jqxGrid('selectcell',0, 'type');
		             $('#jqxJournalVoucher').jqxGrid('focus',0, 'type');
		     }
		   });
		 */
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
    
	       function text()
	       {
	    	   var url=document.URL;
	      
			var reurl=url.split("com/");
	       top.addTab("Client",reurl[0]+"com/operations/clientrelations/client/clientMaster.jsp");
	     
	       }
    function funReset(){
		//$('#frmEnquiry')[0].reset(); 
	}
	function funReadOnly(){
	
		if (document.getElementById("status").value=="0") {
			checkval="close";
		}  
		
		if(checkval=="open") {
			 funCreateBtn();
		}
		
		$('#frmEnquiry input').prop('readonly', true );
		
		$('#frmEnquiry textarea').attr('readonly', true );
		$('#frmEnquiry select').attr('disabled', true);
		$('#btnnewclient').attr('disabled', true);
		$('#r1').attr('disabled', true);
		$('#r2').attr('disabled', true);
		$('#EnquiryDate').jqxDateTimeInput({ disabled: true});
	    $("#jqxEnquiry").jqxGrid({ disabled: true});
			
	}
	function funRemoveReadOnly(){
		
		$('#frmEnquiry input').attr('readonly', false );
		
		$('#frmEnquiry textarea').attr('readonly', false );
		$('#frmEnquiry select').attr('disabled', false);
		$('#btnnewclient').attr('disabled', false);
		$('#r1').attr('disabled', false);
		$('#r2').attr('disabled', false);
		$('#EnquiryDate').jqxDateTimeInput({ disabled: false});
	
		$("#jqxEnquiry").jqxGrid({ disabled: false});
		$('#docno').attr('readonly', true);
		$('#enqsrc').attr('readonly', true);
		
		if(checkval=="open") {	
		 	var x=new XMLHttpRequest();
	        x.onreadystatechange=function(){
	        if (x.readyState==4 && x.status==200) 	 
	         {
	           var items= x.responseText.trim();
	           var item = items.split('####');
	    
	  	 	   var branchvals='<%=branchvals%>';
	  	 	   var currencyvals='<%=currencyvals%>';
		 	   document.getElementById("brchName").value=branchvals;	 
		 	   document.getElementById("currency").value=currencyvals;	
		 	   $("#brchNames").val($("#brchName option:selected").text());
		 	   $("#currencys").val($("#currency option:selected").text());
			   document.getElementById("cmbclient").value=item[1];
			   document.getElementById("txtclientname").value=item[2];
			   document.getElementById("txtaddress").value=item[3];
			   document.getElementById("txtmobile").value=item[4];
			   document.getElementById("txtemail").value=item[5];
			   document.getElementById("r2").checked = true;
			   document.getElementById("r1").checked = false;
			   $('#cmbclient').attr('readonly', true );
			   $('#txtclientname').attr('readonly', true );
			   $('#txtaddress').attr('readonly', true );
			   $('#txtmobile').attr('readonly', true );
			   $('#txtemail').attr('readonly', true );
			   $('#txtRemarks').attr('readonly', false );
			   $("#cmbclient").show();
			   $("#jqxEnquiry").jqxGrid({ disabled: false});
			   $("#jqxEnquiry").jqxGrid('clear');
			   $("#jqxEnquiry").jqxGrid('addrow', null, {});
			   document.getElementById("txtradio").value="2";
			   document.getElementById("errormsg").innerText="";
			   $("#btnnewclient").show();
			   $('#EnquiryDate').val(new Date());
			   $('#r1').attr('disabled', false);
			   $('#r2').attr('disabled', false);
			   $('#EnquiryDate').jqxDateTimeInput({ disabled: false});
			   $('#btnnewclient').attr('disabled', false);
			   $("#mode").val("A");
				
	           }
	        }
	        x.open("GET","getClientDetails.jsp?masterdoc_no="+masterdoc_no,true);
	      	x.send();
      
	   } else {
			   if ($("#mode").val() == "A") {
				 $('#EnquiryDate').val(new Date());
			     $("#jqxEnquiry").jqxGrid('clear');
			     $("#jqxEnquiry").jqxGrid('addrow', null, {});
			   }
	    } 
		
		if ($("#mode").val() == "E") {
			if(document.getElementById("txtradio").value==1) {
					$('#r2').attr('disabled', true);	
			} else{
					$('#r1').attr('disabled', true);
			}
		}
	}
	
	function getEnqsrc(event){
   	 var x= event.keyCode;
   	 if(x==114){
   		$('#enqsrcwindow').jqxWindow('open');
        enqsrcSearchContent('enqsrcSearchGrid.jsp?id=1', $('#enqsrcwindow')); 
     }
   	 else{
   		 }
   	 }
	 function getclinfo(event){
    	 var x= event.keyCode;
    	 if(x==114){
    	  $('#clientsearch1').jqxWindow('open');
    
    
    	 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1'));    }
    	 else{
    		 }
    	 } 
	       function enqsrcSearchContent(url) {
	                 $.get(url).done(function (data) {
		           $('#enqsrcwindow').jqxWindow('setContent', data);
          	}); 
	           	} 
	       function clientSearchContent(url) {
               $.get(url).done(function (data) {
	          		 $('#clientsearch1').jqxWindow('setContent', data);
    			}); 
         	}
	       
	function funNotify(){	
		
		$('#EnquiryDate').jqxDateTimeInput({ disabled: false});
		
		
		  var maindate = $('#EnquiryDate').jqxDateTimeInput('getDate');
		   var validdate=funDateInPeriod(maindate);
		   if(validdate==0){
		   return 0; 
		   }
		
		if ($("#mode").val() == "A") {
		var valid=document.getElementById("gridval").value;
		
		if(valid=="")
			{
			 document.getElementById("errormsg").innerText=" Select Brand";
			return 0;
			}
		else
			{
			 document.getElementById("errormsg").innerText="";
			}
		}
		var valid2=document.getElementById("txtclientname").value;
		
		if(valid2=="")
			{
			document.getElementById("errormsg").innerText=" Select Client";
			return 0;
			}
		else{
			 document.getElementById("errormsg").innerText="";
		}
		
		
		var fromval=document.getElementById("fromdatesval").value;
		if(parseInt(fromval)==1)
			{
			
			document.getElementById("errormsg").innerText="From Date Less Than Current Date";
			return 0;
			
			}
		var toval=document.getElementById("todateval").value;
		if(parseInt(toval)==1)
			{
			document.getElementById("errormsg").innerText="To Date Less Than From Date "; 
			return 0;
			
			}
		
		 var rows = $("#jqxEnquiry").jqxGrid('getrows');
		 
		
		   for(var i=0 ; i < rows.length ; i++){
		    	
		 
			
		    if(parseInt(rows[i].brdid)>0)
    		{
		    
 	  
 	 	        if(rows[i].hidfromdate==""||rows[i].hidfromdate=="0.00"||typeof(rows[i].hidfromdate)=="undefined"||typeof(rows[i].hidfromdate)=="NaN")
    		
				{
				document.getElementById("errormsg").innerText="Enter From Date";  
		    	return 0;
				}
    		}
     	     
		   }
	
		 
		 
		 
		 
			 var rows = $("#jqxEnquiry").jqxGrid('getrows');
		    $('#enqgridlenght').val(rows.length);
		  
		   for(var i=0 ; i < rows.length ; i++){
		
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "enqtest"+i)
		       .attr("name", "enqtest"+i)
		       .attr("hidden", "true"); 
		 
		   newTextBox.val(rows[i].sr_no+"::"+rows[i].brdid+" :: "+rows[i].modid+" :: "
				   +rows[i].specification+" :: "+rows[i].clrid+" :: "+rows[i].ldur+" :: "+rows[i].hidfromdate+" :: "+rows[i].kmusage+" :: "+rows[i].qty+" :: ");
		
		   newTextBox.appendTo('form');
		  
		    
		   }   
		
		return 1;
	} 

	function funChkButton() {
		
		//frmEnquiry.submit();
	}

	function funSearchLoad(){
		 changeContent('lprMastersearch.jsp'); 
	}
    $(function(){
        $('#frmEnquiry').validate({
                rules: { 
                txtclientname:{"required":true},
                txtmobile:{"required":true,number:true,maxlength:12,minlength:12},
                txtemail:"required",
                txtaddress: {"required":true,maxlength:200},
                txtRemarks:{maxlength:200}
                 },
                 messages: {
                 txtRemarks: {maxlength:" Max 200 chars"},
                 txtclientname: {required:" *required"},
                 txtaddress: {required:"* required",maxlength:" Max 200 chars"},
                 txtmobile:{required:"* required",number:" Invalid MOB NO" ,maxlength:" Max 12 chars",minlength:" Minimum 12 chars" },
                 txtemail:" *Enter Valid Email",
              
                 }
        });});
    
		
	function funFocus(){
		 
	   /* 	$('#EnquiryDate').jqxDateTimeInput('focus');  */
	   
	   

		document.getElementById("r1").focus();
	   
	   
	}
	function reqdata()
	{
 		 if((document.getElementById("r1").checked=="")&&(document.getElementById("r2").checked==""))
 				 
         	
    		{ 
     	  
     	       document.getElementById("errormsg").innerText=" Select One Option";
     	      $('#frmEnquiry input').attr('readonly', true );
     			$('#frmEnquiry textarea').attr('readonly', true );
     			
     		
     	        return false;			            	              		          	  
   		}  
		 else 
	         	
 		{ 
			 document.getElementById("errormsg").innerText="";	
			 
			 $('#frmEnquiry input').attr('readonly', false );
				$('#frmEnquiry textarea').attr('readonly', false );
		}    
}
	
	
	function chkChange()
    {
		if($('#txtradio').val()!="")
			{
  	  if(document.getElementById("txtradio").value==2)
  		  {
  		  document.getElementById("r2").checked = true;
  		 document.getElementById("r1").checked = false; 
  	 	$("#cmbclient").show();
  		$("#btnnewclient").show(); 
  	     $('#frmEnquiry input').attr('readonly', true );
		$('#frmEnquiry textarea').attr('readonly', true );
              $('#docno').attr('readonly', true);
		
		
		
  		  }
  	  else 
  		  {
  	
  		  document.getElementById("r1").checked = true;
  		 document.getElementById("r2").checked = false;
  		  $('#frmEnquiry input').attr('readonly', true );
			$('#frmEnquiry textarea').attr('readonly', true );
			$('#docno').attr('readonly', true);
			
			
  		  }
			}
		else{}
 
    
	    
    } 
	
	
	 function disfields()
	 {
		 $('#docno').attr('readonly', true);
		 $('#cmbclient').attr('readonly', true );
		 if( document.getElementById("r2").checked == true)
			 {
				$('#txtclientname').attr('readonly', true );
		    	$('#txtaddress').attr('readonly', true );
		    	$('#txtmobile').attr('readonly', true );
		    	$('#txtemail').attr('readonly', true );
			 }
			if ($("#mode").val() == "view") {
	    	$('#txtclientname').attr('readonly', true );
	    	$('#txtaddress').attr('readonly', true );
	    	$('#txtmobile').attr('readonly', true );
	    	$('#txtemail').attr('readonly', true );
	    	$('#txtRemarks').attr('readonly', true ); 
			}
	 }
	 
	 
	function setValues() {
		  document.getElementById("formdetail").value="Lease Price Request";
	   		document.getElementById("formdetailcode").value="LPR";  
		if($('#hidEnquiryDate').val()){
			$("#EnquiryDate").jqxDateTimeInput('val', $('#hidEnquiryDate').val());
		}
	
		  
  	  var docVal1 = document.getElementById("masterdoc_no").value;
  	  
      	if(docVal1>0)
      		{
		 var indexVal2 = document.getElementById("masterdoc_no").value;
     	  
         $("#enqdiv").load("reqDetails.jsp?enqrdocno="+indexVal2);
      		}
      	if($('#msg').val()!=""){
 		   $.messager.alert('Message',$('#msg').val());
 		  }
	
      	
      	 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";	
      	 
     	chkChange();
	}
	 
    function funPrintBtn(){
 	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
 	  
 	   var url=document.URL;

        var reurl=url.split("saveLeasepricereq");
        
        $("#docno").prop("disabled", false);                
        
  
var win= window.open(reurl[0]+"printLeasepricereq?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
     
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
<form id="frmEnquiry" action="saveLeasepricereq" autocomplete="OFF" >

 <jsp:include page="../../../../header.jsp"></jsp:include><br/>
 <fieldset>
<legend>Lease Price Request</legend>          <!-- EnquiryDate, docno,cmbclientb,txtclientname,txtaddress -->
<table width="100%" >                        
  <tr>
    <td width="11%" align="right">Date</td>
    <td colspan="2"><div id='EnquiryDate' name='EnquiryDate' value='<s:property value="EnquiryDate"/>'></div>
                     <input type="hidden" id="hidEnquiryDate" name="hidEnquiryDate" value='<s:property value="hidEnquiryDate"/>'/></td>
   <%--  <td width="32%" align="right">User Name</td>
    <td width="33%"><input type="text" id="enquserName" name="enquserName" tabindex="-1" value="<%=session.getAttribute("USERNAME")%>"/></td> --%>
    <td width="32%" align="right">User Name : <label ><font size="2PX"><%=session.getAttribute("USERNAME")%></font></label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      Doc No</td>
    <td width="33%"><input type="text" id="docno" name="docno" tabindex="-1" value='<s:property value="docno"/>' onfoucs="disfields();"/></td>
  </tr>
   <tr>
    <td align="right">&nbsp;</td>

    <td colspan="2"><input type="radio" id="r2" name="client" value='<s:property value="1"/>' >Client</td>
    <td colspan="2"><input type="radio" id="r1" name="genaral" value='<s:property value="0"/>'  ><label id="client">General</label>&nbsp;
    
    </td>
  </tr>      
   <tr>
     <td align="right">Enquiry Source</td>
     <td colspan="3"><input type="text" name="enqsrc" id="enqsrc" value='<s:property value="enqsrc"/>' style="width:40%;" onkeydown="getEnqsrc(event);"></td>
<input type="hidden" name="hidenqsrc" id="hidenqsrc" value='<s:property value="hidenqsrc"/>'>     
     <td>&nbsp;</td>
   </tr>
   <tr>
    <td align="right">Client</td>     
    <td colspan="3"><input type="text" id="cmbclient" name="cmbclient" placeholder="Press F3 To Search" value='<s:property value="cmbclient"/>' onKeyDown="getclinfo(event);" onfocus="disfields();">
		
		<input type="text" id="txtclientname" name="txtclientname" style="width: 40%;" value='<s:property value="txtclientname"/>' onfocus="reqdata();disfields();"></td>
    <td><button type="button" id="btnnewclient"  class="myButton" onclick="text();">Create new Client</button></td>
  </tr>
 
 </table>
  <table width="100%" >
   <tr>
    <td width="10.8%" align="right">Address</td>
    <td><input type="text" id="txtaddress" name="txtaddress" style="width:70%;" value='<s:property value="txtaddress"/>' onfocus="reqdata();disfields();"></td>


  </tr>
  </table>
  <table  width="100%">
  <tr>
    <td align="right" width="10.8%">MOB</td>
    <td width="33.2%" ><input type="text" id="txtmobile" name="txtmobile" style="width:68.7%;" value='<s:property value="txtmobile"/>' onfocus="reqdata();disfields();"></td>
    <td align="right" width="3%" >Email</td>
    <td > <input type="email" id="txtemail" name="txtemail" style="width: 49.2%;" value='<s:property value="txtemail"/>' onfocus="reqdata();disfields();"></td>
  </tr>
  </table>
  <table  width="100%">
  <tr>
  <td align="right" width="10.8%">Remarks</td> 
    <td colspan="3">
    <input type="text" id="txtRemarks" name="txtRemarks" style="width:69.9%;" value='<s:property value="txtRemarks"/>'onfocus="reqdata();disfields();"></td>

  </tr>
</table>  
</fieldset>           
<br/>
<fieldset>
<div id="enqdiv">
<jsp:include page="reqDetails.jsp"></jsp:include></div>
</fieldset>

<input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>' />
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />

<input type="hidden" name="enqdtype" id="enqdtype" value='<s:property value="enqdtype"/>' />

<input type="hidden" id="enqgridlenght" name="enqgridlenght" />

<input type="hidden" name="gridval" id="gridval" value='<s:property value="gridval"/>' />  

<input type="hidden" name="forradiochk" id="forradiochk" value='<s:property value="forradiochk"/>' />  
<input type="hidden" name="brandval" id="brandval" value='<s:property value="brandval"/>' />  


<input type="hidden" name="fromdatesval" id="fromdatesval" value='<s:property value="fromdatesval"/>' />  
<input type="hidden" name="todateval" id="todateval" value='<s:property value="todateval"/>' />  



<input type="hidden" name="txtradio" id="txtradio" value='<s:property value="txtradio"/>' /> 

  <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>


</form>

<div id="enqsrcwindow">
   <div ></div>
</div>
<div id="colorsearchwndow">
   <div ></div>
</div>
<div id="modelsearchwndow">
   <div ></div>
</div>
<div id="brandsearchwndow">
   <div ></div>
</div>
<div id="clientsearch1">
   <div ></div>
</div>
</div>
</body>
</html>