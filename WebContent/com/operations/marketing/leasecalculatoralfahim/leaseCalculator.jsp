<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
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
 </style>
 <script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/resample.js"></script>
<script type="text/javascript">
<% String masterdoc_no=request.getParameter("masterdoc_no");
String branchvals=request.getParameter("branchvals");
String currencyvals=request.getParameter("currencyvals");
String checkval=request.getParameter("checkval"); %>
var masterdoc_no='<%=masterdoc_no%>';
var checkval='<%=checkval%>';
var branchvals='<%=branchvals%>';
var currencyvals='<%=currencyvals%>';
        $(document).ready(function () {
		
			$("#btnEdit").click(function(){
        		validateEdit();
        		if($('#hidedit').val()!="1"){
        			return false;
        		}
        	});
    		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
   	     	$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
   	  		$("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	     	$('#reqsearchwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Lease Price Request Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   	$('#reqsearchwindow').jqxWindow('close');
		   
		   $("#btnExcel").click(function() {
		   		if(document.getElementById("docno").value==""){
					var topic=document.getElementById("lblvehicle").innerText;
		   			//$("#jqxleasecalculator").jqxGrid('exportdata', 'xls', 'Lease Calculation of '+topic);
		   		}
		       });
		   
		 
		   $('#leasereqdoc').dblclick(function(){
				 $('#reqsearchwindow').jqxWindow('open');
					$('#reqsearchwindow').jqxWindow('focus');
					 reqSearchContent('masterLeaseRequest.jsp?branch='+document.getElementById("brchName").value);
				});
	
        
     
        });
        
		function validateEdit(){
        	if($('#docno').val()!=""){
        		var x=new XMLHttpRequest();
		        x.onreadystatechange=function(){
		        	if (x.readyState==4 && x.status==200) 	 
		         	{
		        		var items= x.responseText.trim();
		        		if(parseInt(items)>0){
		        			$('#hidedit').val("1");
		        			$.messager.alert('warning','Cannot Edit,Transaction Exists');
		        			funCloseBtn();
		        		}
		         	}
		        }
		        x.open("GET","checkEditOption.jsp?docno="+$('#docno').val(),true);
		      	x.send();        			
    		}
        }
        function getLeaseReq(event){
        	var x= event.keyCode;
        	if(x==114){
        		 $('#reqsearchwindow').jqxWindow('open');
					$('#reqsearchwindow').jqxWindow('focus');
					 reqSearchContent('masterLeaseRequest.jsp?branch='+document.getElementById("brchName").value);	 
        	}
         	 

        }

        function reqSearchContent(url) {
            $.get(url).done(function (data) {
            $('#reqsearchwindow').jqxWindow('setContent', data);
        }); 
        }
        
    function funReadOnly(){
		$('#frmLeaseCalculator input').attr('readonly', true );
		$('#date').jqxDateTimeInput({disabled:true});

		if (document.getElementById("status").value=="0") {
			checkval="close";
		}  
		
		if(checkval=="open") {
			//alert(branchvals+'///'+currencyvals);
			$('#brchName').val(branchvals);
			$('#currency').val(currencyvals);
			funCreateBtn();
		}  
		
	}
        
	 function funRemoveReadOnly(){
		 if(checkval=="open") {	
			 $('#mode').val('A');
			 
		 }
			$('#frmLeaseCalculator input').attr('readonly', false );
			//$("#jqxleasecalculator").jqxGrid({ disabled: false});
			$('#date').jqxDateTimeInput({disabled:false});
			if(document.getElementById("mode").value=="A"){
			  	$('#leaseReqGrid').jqxGrid('clear');
				$('#date').jqxDateTimeInput('setDate',new Date());
				$('#leaseTypeoneGrid').jqxGrid('clear');
				$('#leaseTypetwoGrid').jqxGrid('clear');
				$('#leasetypeonediv').load('leaseTypeoneGrid.jsp');
				document.getElementById("lblvehicle").innerText="";
			}
			$('#docno').attr('readonly', true);
			$('#leasereqdoc').attr('readonly', true);
			$('#leasereqclient').attr('readonly', true);
			$('#clientmob').attr('readonly', true);
			//$('#txtinsurancecomp').attr('readonly', true);	
			if(checkval=="open"){
				var x=new XMLHttpRequest();
		        x.onreadystatechange=function(){
		        	if (x.readyState==4 && x.status==200) 	 
		         	{
		           		var items= x.responseText.trim();
		           		var item = items.split('####');
		           		document.getElementById("leasereqdoc").value=item[0];
		              	document.getElementById("hidleasereqdoc").value=item[1];
		                document.getElementById("leasereqclient").value=item[2];
		                document.getElementById("clientmob").value=item[3];
		     			$('#leasereqdiv').load('leaseReqGrid.jsp?reqdocno='+item[1]);
		     			$("#brchNames").val($("#brchName option:selected").text());
		     			$("#currencys").val($("#currency option:selected").text());
		         	}
		        }
		        x.open("GET","openLeaseReqAJAX.jsp?masterdoc_no="+masterdoc_no,true);
		      	x.send();
			}
	 }
	 
	 function funSearchLoad(){
		 changeContent('masterSearch.jsp?branch='+$('#brchName').val());  
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus()
	    {
	    	//document.getElementById("txtvehicle").focus(); 	    		
	    }
	 
	   
	  function funNotify(){	
	  				 
		  var rows = $("#leaseReqGrid").jqxGrid('getrows');
			if(rows[0].brand=="undefined" || rows[0].brand==""){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Please Select a valid document";
				return 0;	
			}
		
		  $('#reqgridlength').val(rows.length);
  			var  valid=0;
  			
		  for(var i=0 ; i < rows.length ; i++){
				var brand=rows[i].brand;
				var model=rows[i].model;
				var group=rows[i].gname;
  				if(group=="" || group=="undefined" || typeof(group)=="undefined" || group==null){
  					valid=-1;
  					$.messager.alert('warning','Cost Group of '+brand+' '+model+' not updated');
  					break;
  				}
  				newTextBox = $(document.createElement("input"))
			    .attr("type", "dil")
			    .attr("id", "testreq"+i)
			    .attr("name", "testreq"+i)
			    .attr("hidden", "true");
				var leasefromdate = $('#leaseReqGrid').jqxGrid('getcelltext', i, "leasefromdate");
				newTextBox.val(leasefromdate+"::"+rows[i].brdid+"::"+rows[i].modelid+"::"+rows[i].specification+"::"+rows[i].clrid+"::"+rows[i].leasemonths+"::"+rows[i].kmpermonth+"::"+rows[i].grpid+"::"+rows[i].reqsrno+"::"+rows[i].qty+"::"+rows[i].yomid+"::"+rows[i].vsb);
			
			newTextBox.appendTo('form');
			
				//alert("ddddd"+$("#test"+i).val());
			}
		 /*  var calcrows=$('#leaseTypeoneGrid').jqxGrid('getrows');
		  if(calcrows.length==0){
			  valid=-1;
		  }
		  for(var j=0;j<calcrows.length;j++){
			  newTextBox = $(document.createElement("input"))
			    .attr("type", "dil")
			    .attr("id", "calc"+j)
			    .attr("name", "calc"+j)
			    .attr("hidden", "true");
				newTextBox.val(calcrows[j].srno+"::"+calcrows[j].amount);
			newTextBox.appendTo('form');
		  }
		  document.getElementById("typeonelength").value=calcrows.length; */
		  if(valid==-1){
			  
			  return 0;
		  }
		/*   
		  var totalsum=$('#leaseTypetwoGrid').jqxGrid('getcolumnaggregateddata', 'amount', ['sum'], true);
          var total=totalsum.sum;
          document.getElementById("total").value=total;
           */
	    		return 1;
		} 
	  
	  function setValues(){
		  document.getElementById("formdetail").value="Lease Calculator";
	   		document.getElementById("formdetailcode").value="LEC";  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  	document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  	funSetlabel();
		
		  //	$("#leaseCalculator").load("leaseCalculatorGrid.jsp");
		  	if(document.getElementById("docno").value!="" && document.getElementById("leasereqdoc").value!=""){
			  	$('#leasereqdiv').load('leaseReqGrid.jsp?reqdocno='+document.getElementById("hidleasereqdoc").value+'&docno='+document.getElementById("docno").value+'&id=1');
			
			  	$('#leasetypeonediv').load('leaseTypeoneGrid.jsp?id=5&reqdocno='+$('#hidleasereqdoc').val());
			  	$('#leasetypetwodiv').load('leaseTypetwoGrid.jsp?id=5&reqdocno='+$('#hidleasereqdoc').val());
		  	}
		  	if(document.getElementById("docno").value==""){
				document.getElementById("processfield").disabled=true;	 
				$('#leaseTypeoneGrid').jqxGrid({disabled:true});
				$('#leaseTypetwoGrid').jqxGrid({disabled:true});
		  	}
		  	else{
		  		document.getElementById("processfield").disabled=false;
		  		$('#leaseTypeoneGrid').jqxGrid({disabled:false});
				$('#leaseTypetwoGrid').jqxGrid({disabled:false});
		  	}
	}
	  
	  
	  
	  
	  function funPrintBtn() {
		 	var url=document.URL;
			var reurl="";
			//reurl=url.split("leaseCalculator.jsp");
			 if(document.getElementById("msg").value!=""){
				reurl=url.split("saveLeaseCalculatorAlFahim");
			}
			else{
				reurl=url.split("leaseCalculator.jsp");
			} 
			
			var branch='<%=request.getParameter("branch")%>'; 
		    var win= window.open(reurl[0]+"printLeaseCalculator?docno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
		    win.focus();  
		    
		   
	  }
	  
	  function funProcess(){
		 
		  if(document.getElementById("lblvehicle").innerText==""){
			  $.messager.alert('warning','Please Select a vehicle');
			  return false;
		  }
		  var typeonerows=$('#leaseTypeoneGrid').jqxGrid('getrows');
		  var typeonearray=new Array();
		  var residualvalue=0.0;
		  for(var i=0;i<typeonerows.length;i++){
			if($('#leaseTypeoneGrid').jqxGrid('getcellvalue',i,'srno')=="20"){
				  residualvalue=$('#leaseTypeoneGrid').jqxGrid('getcellvalue',i,'amount');
			}
			  if((parseFloat(typeonerows[i].amount)!=0.0) && (typeonerows[i].amount=="" || typeonerows[i].amount=="undefined" || typeof(typeonerows[i].amount)=="undefined" || typeonerows[i].amount==null)){
				  $.messager.alert('warning','All Amounts are Mandatory');
				  return false;
			  }
			  else{
				  var srno=$('#leaseTypeoneGrid').jqxGrid('getcellvalue',i,'srno');
				  var amount=$('#leaseTypeoneGrid').jqxGrid('getcellvalue',i,'amount');
				  typeonearray.push(srno+"::"+amount);
			  }
		  }
		  if(residualvalue==0.0){
			  $.messager.alert('warning','Please configure Residual Value');
			  return false;
		  }
		  $('#leasetypetwodiv').load('leaseTypetwoGrid.jsp?typeonearray='+typeonearray+'&id=2&kmuse='+document.getElementById('kmuse').value+'&reqdocno='+document.getElementById('hidleasereqdoc').value+'&reqsrno='+document.getElementById('reqsrno').value+'&calcdocno='+$('#docno').val());
		  
	  }
	  
	  function funProcessSave(){
		  var typetworows=$('#leaseTypetwoGrid').jqxGrid('getrows');
		  if(typetworows.length==0){
			  $.messager.alert('warning','Please Process');
			  return false;
		  }
		  if(document.getElementById("lblvehicle").innerText==""){
			  $.messager.alert('warning','Please select a vehicle');
			  return false;
		  }
		  var rows=$('#leaseTypetwoGrid').jqxGrid('getrows');
		  var total=0.0,vehiclecost=0.0,excesskmrate=0.0,landedcost=0.0,margincost=0.0,daimler=0.0;
		  for(var i=0;i<rows.length;i++){
			  if($('#leaseTypetwoGrid').jqxGrid('getcellvalue',i,'srno')=="35"){
				  total=$('#leaseTypetwoGrid').jqxGrid('getcellvalue',i,'amount');
			  }
			  else if($('#leaseTypetwoGrid').jqxGrid('getcellvalue',i,'srno')=="29"){
				  vehiclecost=$('#leaseTypetwoGrid').jqxGrid('getcellvalue',i,'amount');
			  }
			  else if($('#leaseTypetwoGrid').jqxGrid('getcellvalue',i,'srno')=="9"){
				  landedcost=$('#leaseTypetwoGrid').jqxGrid('getcellvalue',i,'amount');
			  }
			  else if($('#leaseTypetwoGrid').jqxGrid('getcellvalue',i,'srno')=="30"){
				  margincost=$('#leaseTypetwoGrid').jqxGrid('getcellvalue',i,'amount');
			  }
			  else if($('#leaseTypetwoGrid').jqxGrid('getcellvalue',i,'srno')=="12"){
				  daimler=$('#leaseTypetwoGrid').jqxGrid('getcellvalue',i,'amount');
			  }
		  }
		  var rows2=$('#leaseTypeoneGrid').jqxGrid('getrows');
		  for(var i=0;i<rows2.length;i++){
			  if($('#leaseTypeoneGrid').jqxGrid('getcellvalue',i,'srno')=="33"){
				  excesskmrate=$('#leaseTypeoneGrid').jqxGrid('getcellvalue',i,'amount');
			  }
		  }
		  funProcessSaveAJAX(total,vehiclecost,excesskmrate,landedcost,margincost,daimler);
	  }
	  
	  function funProcessSaveAJAX(total,vehiclecost,excesskmrate,landedcost,margincost,daimler){
		  var reqsrno=$('#reqsrno').val();
		  var calcdocno=$('#docno').val();
		  var reqdocno=$('#hidleasereqdoc').val();
		 
          var residalvalue=$('#residalvalue').val();
		  var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText.trim();
					if(items=="1"){
						$.messager.alert('message','Successfully Saved');
					
						$('#leasereqdiv').load('leaseReqGrid.jsp?reqdocno='+document.getElementById('hidleasereqdoc').value+'&docno='+document.getElementById('docno').value+'&id=1');
						$('#processfield').attr('disabled',true);
					}
					else{
						$.messager.alert('message','Not Saved');
					}
				}
				else {
				}
			}
			x.open("GET", "processSaveAJAX.jsp?reqsrno="+reqsrno+"&calcdocno="+calcdocno+"&reqdocno="+reqdocno+"&total="+total+"&residalvalue="+residalvalue+"&vehiclecost="+vehiclecost+"&excesskmrate="+excesskmrate+"&landedcost="+landedcost+"&margincost="+margincost+"&daimler="+daimler, true);
			x.send();	
	  }
	  
	 /* function funSendmail()
	  {
		 alert(document.getElementById('hidemail').value);
		 var url=document.URL;
		 //alert(url);
		var reurl=url.split("com/");
		 // alert(reurl[0]);       
		         $("#docno").prop("disabled", false);
		         
		  var win= window.open(reurl[0]+"com/operations/marketing/leasecalculatoralfahim/JasperprintLeaseCalculator?docno="+document.getElementById("docno").value+"&print=0","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
		    win.focus();
	  } */
	 function funSendmail() {  
	     var email = document.getElementById("hidemail").value;
	     var res;var part1;var part2;var dotsplt;
	     if(email.indexOf("@")>=0) {
	      res = email.split('@');
	      part1=res[0];
	      part2=res[1];
	      dotsplt=part2.split('.');
	     }
	    /* if ($("#txtdocno").val().trim()=="" || typeof($("#txtdocno").val().trim())=="undefined" || typeof($("#txtdocno").val().trim())=="NaN") {
	      $('#txtaccid').val('');$('#txtaccname').val('');$('#txtdocno').val('');$('#txtaccemail').val('');
	   
	   if (document.getElementById("txtaccid").value == "") {
	          $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
	      }
	   $.messager.alert('Message','Account is Mandatory.','warning');
	   return;
	   } else  */
	   if(email.trim()=="" || typeof(email.trim())=="undefined" || typeof(email.trim())=="NaN") {
	      $.messager.alert('Message','Email is not Configured Properly.','warning');
	   return;
	   } else if(email.indexOf("@")<0) {
	      $.messager.alert('Message','Email is not Configured Properly.','warning');
	   return;
	   } else if(email.split('@').length!=2) {
	      $.messager.alert('Message','Email is not Configured Properly.','warning');
	   return;
	   } else if(part1.length==0) {
	      $.messager.alert('Message','Email is not Configured Properly.','warning');
	   return;
	   } else if(part1.split(" ").length>2) {
	      $.messager.alert('Message','Email is not Configured Properly.','warning');
	   return;
	    } else if(part2.split(".").length<2) {
	       $.messager.alert('Message','Email is not Configured Properly.','warning');
	   return;
	    } else if(dotsplt[0].length==0 ) {
	       $.messager.alert('Message','Email is not Configured Properly.','warning');
	   return;
	    } else if(dotsplt[1].length<2 ||dotsplt[1].length>4) {
	       $.messager.alert('Message','Email is not Configured Properly.','warning');
	   return;
	    } else {
	  
	      $("#overlay, #PleaseWait").show();
	     
	    $.ajaxFileUpload ({  
	           
	             url: 'JasperprintLeaseCalculator.action?docno='+document.getElementById("docno").value+'&email='+document.getElementById("hidemail").value+'&leasereqdoc='+document.getElementById("leasereqdoc").value+'&print=0',  
	                secureuri:false,//false  
	                fileElementId:'file', //id  <input type="file" id="file" name="file" />  
	                dataType: 'string',// json  
	                success: function (data, status) {  
	                 $('#btnSendingEmail').attr("disabled",true);
	                   if(status=='success'){
	       $("#overlay, #PleaseWait").hide();
	       $.messager.alert('Message','E-Mail Send Successfully');
	                    }
	                   if(status=='error'){
	                    $("#overlay, #PleaseWait").hide();
	                    $.messager.alert('Message','E-Mail Sending failed');
	                   }
	                   
	                    $("#testImg").attr("src",data.message);
	                    if(typeof(data.error) != 'undefined')  
	                    {  
	                        if(data.error != '')  
	                        {  
	                            alert(data.error);  
	                        }else  
	                        {  
	                            alert(data.message);  
	                        }  
	                    }  
	                },  
	                 error: function (data, status, e)
	                {  
	                    alert(e);  
	                }  
	            }) 
	           return false;
	  
	    } 
	    }
</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmLeaseCalculatorAlFahim" action="saveLeaseCalculatorAlFahim" >
<jsp:include page="../../../../header.jsp"></jsp:include><br/>
<!--<div class="hidden-scrollbar">-->
<fieldset>
<table width="100%">
  <tr>
    <td width="3%" align="right">Date</td>
    <td width="11%"><div id="date" name="date" value='<s:property value="date"/>'></div></td>
    <td width="10%" align="right">Lease Req Doc</td>
    <td width="12%"><input type="text" id="leasereqdoc" name="leasereqdoc" value='<s:property value="leasereqdoc"/>' placeholder="Press F3 to Search" onkeydown="getLeaseReq(event);"/></td>
    <td width="7%" align="right">Client</td>
    <td width="21%" align="left"><input type="text" name="leasereqclient" id="leasereqclient" style="width:99%;" readonly value='<s:property value="leasereqclient"/>'></td>
    <td width="17%" align="left"><input type="text" name="clientmob" id="clientmob" readonly value='<s:property value="clientmob"/>'></td>
    <td width="7%" align="right">Doc No</td>
    <td width="12%"><input type="text" id="vocno" name="vocno" value='<s:property value="vocno"/>'/></td>
  </tr>
</table>
 </fieldset><br/>
 <table width="100%"><tr><td><div id="leasereqdiv"><jsp:include page="leaseReqGrid.jsp"></jsp:include></div></td></tr></table>
 <fieldset id="processfield"><legend>Lease Calculus Info</legend>
 <table width="100%" border="0">
  <tr>
    <td colspan="2"  align="center"><label id="lblvehicle" name="lblvehicle" style="color:red;font-weight:bold;text-transform:uppercase;"><s:property value="lblvehicle"/></label></td>
    </tr>
  <tr>
    <td colspan="2"  align="center"><button type="button" class="myButton" id="btnprocess" onclick="funProcess();">Process</button>
    <button type="button" class="myButton" id="btnprocesssave" onclick="funProcessSave();">Save</button>
    </td>
    </tr>
  <tr>
    <td style="width:50%;"><div id="leasetypeonediv"><jsp:include page="leaseTypeoneGrid.jsp"></jsp:include></div></td>
    <td style="width:50%;"><div id="leasetypetwodiv"><jsp:include page="leaseTypetwoGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</fieldset>
 
 
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="hidleasereqdoc" name="hidleasereqdoc"  value='<s:property value="hidleasereqdoc"/>'/>
<input type="hidden" id="reqgridlength" name="reqgridlength" value='<s:property value="reqgridlength"/>'/>
<input type="hidden" id="typeonelength" name="typeonelength" value='<s:property value="typeonelength"/>'/>
<input type="hidden" id="kmuse" name="kmuse" value='<s:property value="kmuse"/>'/>
<input type="hidden" id="total" name="total" value='<s:property value="total"/>'/>
<input type="hidden" id="reqsrno" name="reqsrno" value='<s:property value="reqsrno"/>'/>
<input type="hidden" id="residalvalue" name="residalvalue" value='<s:property value="residalvalue"/>'/>
<input type="hidden" id="hidemail" name="hidemail" value='<s:property value="hidemail"/>'/>
<input type="hidden" id="docno" name="docno" value='<s:property value="docno"/>'/>
<input type="hidden" id="hidedit" name="hidedit" value="0"/>
<div id="reqsearchwindow">
<div></div>
</div>
</form>
</div>
</body>
</html>