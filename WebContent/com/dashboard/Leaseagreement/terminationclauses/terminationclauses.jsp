
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
	
 
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	  $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");



	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	    
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	 $('#todate').on('change', function (event) {
			
		   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  }   
	 });
	  
});

  function funExportBtn(){
	  
	   
	   
		 if(parseInt(window.parent.chkexportdata.value)=="1")
		 {
		 JSONToCSVCon(dat1, 'Termination Clauses', true);
		 }
	 else
		 {
		 $("#leasetermination").jqxGrid('exportdata', 'xls', 'Termination Clauses');
		 }
		
	   
	   
	   
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
function funreload(event)
{

	  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
	  // out date
	 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	 	 
	   if(fromdates>todates){
		   
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		 
	   return false;
	  } 
	   else
		   {
	 var barchval = document.getElementById("cmbbranch").value;
     var fromdate= $("#fromdate").val();
	 var todate= $("#todate").val();
	
	   $("#overlay, #PleaseWait").show();
	  $("#listdiv").load("terminationlistGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate);
	
		   }
	}
	 function isNumber(evt) {
		    var iKeyCode = (evt.which) ? evt.which : evt.keyCode;
		    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
		     {
		    	  
				   $.messager.alert('Message','Enter Numbers Only ','warning');     	
		   

		        return false;
		     }
		 

		    return true;
		}
	 
	 
	 
 
	 
	 
	 
	 
	 
	 function funupdate()
	 {
	 	
			if(document.getElementById("amt1").value=="")
				{
				 $.messager.alert('Message','Minimum Data Requirement','warning');     	
				   

			        return false;
			
				}
  
	 		
	 	var m1=document.getElementById("m1").value;	
	 	var m2=document.getElementById("m2").value;
		var amt1=document.getElementById("amt1").value;
	 	
	 	
	 	var m3=document.getElementById("m3").value;	
	 	var m4=document.getElementById("m4").value;
	 	var amt2=document.getElementById("amt2").value;
	 	
	 	var m5=document.getElementById("m5").value;	
	 	var m6=document.getElementById("m6").value;
	 	var amt3=document.getElementById("amt3").value;
	 	
	 	var m7=document.getElementById("m7").value;	
	 	var m8=document.getElementById("m8").value;
	 	var amt4=document.getElementById("amt4").value;
	 	
	 	var m9=document.getElementById("m9").value;	
	 	var m10=document.getElementById("m10").value;
	 	var amt5=document.getElementById("amt5").value;
	 	
 
	     $.messager.confirm('Message', 'Do you want to save changes?', function(r){
	    	  
	 	       
	      	if(r==false)
	      	  {
	      		return false; 
	      	  }
	      	else{
	      		
	      //	list.push(m1+"::"+m2+"::"+amt1+"::"+","+m3+"::"+m4+"::"+amt2+"::"+","+m5+"::"+m6+"::"+amt3+"::"+","+m7+"::"+m8+"::"+amt4+"::"+","+m9+"::"+m10+"::"+amt5);
	      		
	      		delsave(m1,m2,amt1,m3,m4,amt2,m5,m6,amt3,m7,m8,amt4,m9,m10,amt5);
	      	}
	 	     });
	 	
	 	
	 }
	 	function delsave(m1,m2,amt1,m3,m4,amt2,m5,m6,amt3,m7,m8,amt4,m9,m10,amt5)
	          {
	 		
	 		var x=new XMLHttpRequest();
	 		x.onreadystatechange=function(){
	 		if (x.readyState==4 && x.status==200)
	 			{
	 		
	 			 	var items= x.responseText;
	 			
	 			 	 document.getElementById("m1").value="";	
	 			 	 document.getElementById("m2").value="";
	 			 	 document.getElementById("amt1").value="";
	 			 	
	 			 	
	 			 	document.getElementById("m3").value="";	
	 			 	document.getElementById("m4").value="";
	 			 	document.getElementById("amt2").value="";
	 			 	
	 			 	document.getElementById("m5").value="";	
	 			 	document.getElementById("m6").value="";
	 			 	document.getElementById("amt3").value="";
	 			 	
	 			 	document.getElementById("m7").value="";	
	 			 	document.getElementById("m8").value="";
	 			 	document.getElementById("amt4").value="";
	 			 	
	 			 	document.getElementById("m9").value="";	
	 			 	document.getElementById("m10").value="";
	 			 	document.getElementById("amt5").value="";
	 			 	
	 			 	
	 			 	document.getElementById("ladocno").value="";
	 			 	document.getElementById("lano").value="";
	 			 	
	 			 	// lano
	 			 	
	 				disitems();
	 			 	funreload(event);
	 			 	$.messager.alert('Message', '  Record Successfully Updated ', function(r){
	 					     
	 				     });
	 	    }
	 		}
	 		  x.open("GET","saveterminationdate.jsp?m1="+m1+"&m2="+m2+"&amt1="+amt1+"&m3="+m3+"&m4="+m4+"&amt2="+amt2+"&m5="+m5+"&m6="+m6+
	 				 "&amt3="+amt3+"&m7="+m7+"&m8="+m8+"&amt4="+amt4+"&m9="+m9+"&m10="+m10+"&amt5="+amt5+"&doc="+document.getElementById("ladocno").value,true);
	 	     x.send();
	 		
	 		}
	 
	 
	 function disitems()
	 {
		 
		 // ladocno lano
		  $('#lano').attr("readonly",true);
		 	
			 $('#m1').attr("readonly",true);
			 $('#m2').attr("readonly",true);
			 $('#amt1').attr("readonly",true);	
		 	
			 $('#m3').attr("readonly",true);
			 $('#m4').attr("readonly",true);
			 $('#amt2').attr("readonly",true);	
			 
			 $('#m5').attr("readonly",true);
			 $('#m6').attr("readonly",true);
			 $('#amt3').attr("readonly",true);	
			 
			 $('#m7').attr("readonly",true);
			 $('#m8').attr("readonly",true);
			 $('#amt4').attr("readonly",true);	
			 
			 $('#m9').attr("readonly",true);
			 $('#m10').attr("readonly",true);
			 $('#amt5').attr("readonly",true);	
			 
			 
			 
			 
			 $('#terUpdate').attr("disabled",true);	
		 	
		 	
		 	
		 	
		 	
		 	
		 
	 }
	 
</script>
</head>
<body onload="getBranch();disitems()">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	  <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                    
                    
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>
<%-- 	 <table width="100%">
	 <tr>
	<td  align="right"><label class="branch" >From Date</label></td><td><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div></td>
           
	</tr> 
	
	 <tr>
	<td align="right"><label class="branch">To Date</label></td><td><div id='todate' name='todate' value='<s:property value="todate"/>'></div></td>
    </tr>
     </table>
	</td> --%>      
	
	 <tr><td colspan="2">&nbsp;</td></tr>
 <tr><td align="right"> <label class="branch">LA NO</label></td> <td ><input type="text"  id="lano" name="lano" style="height:20px;width:70%;" value='<s:property value="lano"/>' > </td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">
         
          <table width="100%"  > 
          <tr>
            <td  width="50%" ><input type="text" name="m1" id="m1"   value='<s:property value="m1"/>'  onkeypress="javascript:return isNumber (event)" style="width:38%;height:20px;text-align: center;">
              <label class="branch">to</label>
              <input type="text" name="m2"  id="m2" value='<s:property value="m2"/>' style="width:38%;height:20px;text-align: center;" onkeypress="javascript:return isNumber (event)" onblur="change1();"></td>
            <td  width="50%"  align="left"><input type="text" id="amt1" name="amt1"  style="width:100%;height:21px;text-align: right;" value='<s:property value="amt1"/>' onblur="funRoundAmt(this.value,this.id);"  onkeypress="javascript:return isNumber (event)"/></td>
          </tr>
          <tr>
            <td  ><input type="text" name="m3" id="m3"   value='<s:property value="m3"/>' onkeypress="javascript:return isNumber (event)" readonly="readonly" style="width:38%;height:20px;text-align: center;">
                       <label class="branch">to</label>
              <input type="text" name="m4" id="m4" value='<s:property value="m4"/>' onkeypress="javascript:return isNumber (event)"  style="width:38%;height:20px;text-align: center;" onblur="change2();"></td>
            <td align="left"><input type="text" id="amt2" name="amt2"   style="width:100%;height:21px;text-align: right;"   value='<s:property value="amt2"/>' onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event)" /></td>
          </tr>
          <tr>
            <td  ><input type="text" name="m5" id="m5"  value='<s:property value="m5"/>' onkeypress="javascript:return isNumber (event)"  readonly="readonly" style="width:38%;height:20px;text-align: center;">
                     <label class="branch">to</label>
              <input type="text" name="m6" id="m6" value='<s:property value="m6"/>' onkeypress="javascript:return isNumber (event)" style="width:38%;height:20px;text-align: center;" onblur="change3();"></td>
            <td align="left"><input type="text" id="amt3" name="amt3"   style="width:100%;height:21px;text-align: right;"   value='<s:property value="amt3"/>' onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event)" /></td>
          </tr>
          <tr>
            <td  ><input type="text" name="m7" id="m7" value='<s:property value="m7"/>' onkeypress="javascript:return isNumber (event)"  readonly="readonly" style="width:38%;height:20px;text-align: center;">
                <label class="branch">to</label>
              <input type="text"  value='<s:property value="m8"/>' name="m8" id="m8" onkeypress="javascript:return isNumber (event)"  style="width:38%;height:20px;text-align: center;" onblur="change4();"></td>
            <td align="left"><input type="text" id="amt4" name="amt4"   style="width:100%;height:21px;text-align: right;"   onblur="funRoundAmt(this.value,this.id);" value='<s:property value="amt4"/>' onkeypress="javascript:return isNumber (event)" /></td>
          </tr>
          <tr>
            <td ><input type="text" name="m9" id="m9" value='<s:property value="m9"/>' onkeypress="javascript:return isNumber (event)" readonly="readonly" style="width:38%;height:20px;text-align: center;">
              <label class="branch">to</label>
              <input type="text" name="m10"  id="m10" value='<s:property value="m10"/>' onkeypress="javascript:return isNumber (event)"  style="width:38%;height:20px;text-align: center;" ></td>
            <td align="left"><input type="text" id="amt5" name="amt5"   style="width:100%;height:21px;text-align: right;"  onblur="funRoundAmt(this.value,this.id);" value='<s:property value="amt5"/>' onkeypress="javascript:return isNumber (event)" /></td>
          </tr>
          
        </table>
 

 

	
</td></tr> 
 	 <tr><td colspan="2">&nbsp;</td></tr> 
	 	 <tr><td colspan="2" align="center"><input type="Button" name="terUpdate" id="terUpdate" class="myButton" value="Update" onclick="funupdate()"></td></tr> 
	 	 	 <tr><td colspan="2">&nbsp;</td></tr> 
	 	 	 	 	 <tr><td colspan="2">&nbsp;</td></tr> 
	 	 	 <tr><td colspan="2">&nbsp;</td></tr> 
	</table>
	</fieldset>
	<input type="hidden" id="ladocno" style="height:20px;width:70%;"  name="ladocno">
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="listdiv"><jsp:include page="terminationlistGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>

</div>
<div id="clinfowindow">
   <div ></div>
</div> 
</div>
</body>
</html>