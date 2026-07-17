<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../includes.jsp"></jsp:include>

<script type="text/javascript">   
     
	$(document).ready(function () {    
	 	 $("#date").jqxDateTimeInput({ width: '109px', height: '20px', formatString:"dd.MM.yyyy"});
	 	 $('#clientsearchwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	     $('#clientsearchwindow').jqxWindow('close');    
	     $('#txtevaluatedfor').dblclick(function(){
	     	 $('#clientsearchwindow').jqxWindow('open');
	 		 clientSearchContent('clientINgridsearch.jsp');     
	    });                                           
	});                
	 function clientSearchContent(url) {
			$('#clientsearchwindow').jqxWindow('open');
	        $.get(url).done(function (data) {
	        $('#clientsearchwindow').jqxWindow('setContent', data);
		}); 
	}
	 function getclientinfo(event){         
		 var x= event.keyCode;                                 
		if(x==114){
			$('#clientsearchwindow').jqxWindow('open');
			clientSearchContent('clientINgridsearch.jsp');            
			}
		else{}
	}
	 function funReadOnly(){
			$('#frmEvaluation input').attr('readonly', true );
		    $('#frmEvaluation select').attr('disabled', true); 
			$('#date').jqxDateTimeInput({disabled: true});
	 }
	 
	 function funRemoveReadOnly(){
			$('#frmEvaluation input').attr('readonly', false );
			$('#frmEvaluation select').attr('disabled', false); 
			$('#date').jqxDateTimeInput({disabled: false});
			$('#txtevaluatedfor').attr('readonly', true);   
			$('#docno').attr('readonly', true);
			
			if ($("#mode").val() == "A") {
				$('#date').val(new Date());
			}
	 }
	 function funNotify(){	
			 var cldocno=document.getElementById("cldocno").value;
			 var marketprice=document.getElementById("txtmarketprice").value;
			 var billingamt=document.getElementById("txtbillingamt").value;
			 if(cldocno==""){   
				 document.getElementById("errormsg").innerText="Evaluated For is Mandatory.";   
				 return 0;
			 }
			 if(marketprice==""){   
				 document.getElementById("errormsg").innerText="Market Price For is Mandatory.";   
				 return 0;
			 }
			 if(billingamt==""){   
				 document.getElementById("errormsg").innerText="Billing Amount For is Mandatory.";   
				 return 0;
			 }
		 return 1;          
		} 
	 
	 function funSearchLoad(){
			changeContent('evlMainSearch.jsp');      
		 }
	 
	 function funFocus()
	    {
	    	$('#date').jqxDateTimeInput('focus'); 	    		
	    }
	 
	 function setValues(){
		 if($('#hiddate').val()!=""){    
			 $("#date").jqxDateTimeInput('val', $('#hiddate').val());
		  }
		 
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		 
		 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		 funSetlabel();
		 
		}
	 
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 /* Validations */
	 $(function(){
	        $('#frmEvaluation').validate({
	                rules: {
	                	txtevaluatedfor:"required",
	                	txtmarketprice:"required",
	                	txtbillingamt:"required",
	                 },
	                 messages: {
	                	 txtbillingamt:" *",
	                	 txtevaluatedfor:" *",
	                	 txtmarketprice:" *",   
	                 }
	        });});
	 function funRoundAmt(value,id){   
		  var res=parseFloat(value).toFixed(window.parent.amtdec.value);
		  var res1=(res=='NaN'?"0":res);
		  document.getElementById(id).value=res1;  
		 }  
	 function funPrintBtn() {
			if (($("#mode").val() == "view") && $("#docno").val()!="") {                 
				 var url=document.URL;  
		         var reurl=url.split("saveEvaluation");          
		         var win= window.open(reurl[0]+"printEvaluation?docno="+$('#masterdocno').val()+"&branch="+document.getElementById("brchName").value,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
		         win.focus();
			}else{
					$.messager.alert('Message','Select a Document....!','warning');     
					return;   
				}  
		 }
		function editstatus(){
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText.trim();	
					if(parseInt(items)>0)
						{
				         
						 $("#btnEdit").attr('disabled', true );
						 $('#btnDelete').attr('disabled', true );   
						
						}
					else 
						{
						
						 $("#btnEdit").attr('disabled', false );
						 $('#btnDelete').attr('disabled', false );    
						
						}
					   
				} else {  
				}  
			}
			x.open("GET", "getEditStat.jsp?masterdoc="+$('#masterdocno').val(), true); 
			x.send();
		}
</script>

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>

</head>
<body onload="setValues();"  onmouseover="editstatus();">      
<div id="mainBG" class="homeContent" data-type="background">   
<form id="frmEvaluation" action="saveEvaluation" method="post" autocomplete="off">
<jsp:include page="../../../header.jsp"></jsp:include><br/>
   
<div class='hidden-scrollbar'>
<table width="100%">
  <tr>
    <td width="5%" align="right">Date</td>     
    <td width="15%"><div id="date" name="date" value='<s:property value="date"/>'></div>
    <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddate"/>'/></td>    
    <td width="6%" align="right">Doc No</td>
    <td width="6%"><input type="text" id="docno" name="docno" style="width:50%;" tabindex="-1" value='<s:property value="docno"/>'/></td>
  </tr>
</table>
<br/>   

<fieldset>
<table width="100%">   
  <tr>  
    <td width="9%" align="right">Evaluated For</td>           
    <td width="14%"  colspan="4"><input type="text" id="txtevaluatedfor" name="txtevaluatedfor" placeholder="press F3 to search" style="width:99.5%;" onKeyDown="getclientinfo(event);"  value='<s:property value="txtevaluatedfor"/>'/>
                                 <input type="hidden" id="cldocno" name="cldocno"  value='<s:property value="cldocno"/>'/></td>   
    <td width="6%" align="right">Car Maker</td> 
    <td width="14%" colspan="2"><input type="text" id="txtcarmaker" name="txtcarmaker" style="width:97%;" value='<s:property value="txtcarmaker"/>'/></td>      
 </tr>
  <tr> 
    <td width="5%" align="right">Model</td>
    <td width="14%" colspan="2"><input type="text" id="txtmodel" name="txtmodel" style="width:97%;" value='<s:property value="txtmodel"/>'></td>
    <td width="10%" align="right">Year of Make</td>
    <td width="10%"><input type="text" id="txtyearofmake" name="txtyearofmake" style="width:97%;" value='<s:property value="txtyearofmake"/>'/></td>
    <td width="7%" align="right">Chassis No.</td>
    <td width="14%" colspan="2"><input type="text" id="txtchassisno" name="txtchassisno" style="width:97%;" value='<s:property value="txtchassisno"/>'/></td>
  </tr>      
  <tr>
    <td width="6%" align="right">Interior Color and Condition</td>       
    <td width="14%"><input type="text" id="txtinterior" name="txtinterior" style="width:97%;" value='<s:property value="txtinterior"/>'/></td>
    <td width="14%" align="right">Exterior Color and Condition</td>
    <td width="14%"><input type="text" id="txtexterior" name="txtexterior" style="width:97%;" value='<s:property value="txtexterior"/>'/></td>
    <td width="7%" align="right">Remaining dealer Warranty</td>   
    <td width="8%"><input type="text" id="txtwarranty" name="txtwarranty" style="width:97%;" value='<s:property value="txtwarranty"/>'/></td>
    </tr> 
   <tr>  
    <td width="6%" align="right">No of Cylinders</td>
    <td width="10%"><input type="text" id="txtnoofcylinders" name="txtnoofcylinders" style="width:97%;" value='<s:property value="txtnoofcylinders"/>'/></td>
    <td width="6%" align="right">Engine No. and Capacity</td>       
    <td width="14%"><input type="text" id="txtengineno" name="txtengineno" style="width:97%;" value='<s:property value="txtengineno"/>'/></td>
    <td width="5%" align="right">Transmission</td>
    <td width="14%"><input type="text" id="txttransmission" name="txttransmission" style="width:97%;" value='<s:property value="txttransmission"/>'/></td>
    <td width="6%" align="right">Mileage</td>
    <td width="10%"><input type="text" id="txtmileage" name="txtmileage" style="width:95%;" value='<s:property value="txtmileage"/>'/></td>
  </tr> 
    <tr>
    <td width="10%" align="right">Specification</td>
    <td width="14%" colspan="3"><input type="text" id="txtspecification" name="txtspecification" style="width:99%;" value='<s:property value="txtspecification"/>'/></td>
    <td width="10%" align="right">Evaluated Market Price</td>
    <td width="10%"><input type="text" id="txtmarketprice" name="txtmarketprice" onblur="funRoundAmt(this.value,this.id);" style="width:97%;text-align: right;" value='<s:property value="txtmarketprice"/>'/></td>
    <td width="6%" align="right">Billing Amount</td>
    <td width="10%"><input type="text" id="txtbillingamt" name="txtbillingamt" onkeypress="return isNumberKey(event)" onblur="funRoundAmt(this.value,this.id);" style="width:97%;text-align: right;" value='<s:property value="txtbillingamt"/>'/></td>
 </tr>   
  <tr>   
    <td width="7%" align="right">Other Remarks</td>   
    <td width="14%"  colspan="8"><input type="text" id="txtremakrs" name="txtremakrs" style="width:99.4%;" value='<s:property value="txtremakrs"/>'/></td>
    </tr>    
</table>
</fieldset><br/>           
<input type="hidden" id="mode" name="mode"/>   
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>    
<input type="hidden" id="masterdocno" name="masterdocno"  value='<s:property value="masterdocno"/>'/>
</div>
</form>
<div id="clientsearchwindow">
   <div ></div>     
</div>
</div>
</body>
</html>