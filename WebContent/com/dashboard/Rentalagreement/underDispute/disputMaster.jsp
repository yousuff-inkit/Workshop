
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
	
	 $("#disputeDate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#duegridDate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	 
	 
	 $('#disputeDate').on('change', function (event) {
			
		   var indate1=new Date($('#duegridDate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var agmtdate1=new Date($('#disputeDate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(indate1>agmtdate1){
			   
			   $.messager.alert('Message','Date Cannot Be Less Than Due Date  ','warning');   
			 
		   return false;
		  }   
	 });
});


function getinfo() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
		//alert(items);
			items = items.split('####');
			
			var srno  = items[0].split(",");
			var process = items[1].split(",");
			var optionsbranch = '<option value="" selected>-- Select -- </option>';
			for (var i = 0; i < process.length; i++) {
				optionsbranch += '<option value="' + srno[i].trim() + '">'
						+ process[i] + '</option>';
			}
			$("select#cmbinfo").html(optionsbranch);
			
		} else {
			//alert("Error");
		}
	}
	x.open("GET","getinfo.jsp", true);
	x.send();
}


function funreload(event)
{
	 var barchval = document.getElementById("cmbbranch").value;
	
	 $("#duedetailsgrid").jqxGrid('clear');
	  $("#disputdiv").load("disputeGrid.jsp?barchval="+barchval);
	
	
	}
	

function funchangeinfo()
{
  if($('#cmbinfo').val()==4)
	  {
	 
	 document.getElementById("remarks").focus();
	 $('#disputeDate').jqxDateTimeInput({ disabled: false});
	 $('#caseno').attr("disabled",true);
	 $('#station').attr("disabled",true);
	 $('#value').attr("disabled",true);
	 $('#casenote').attr("disabled",true);
	 
	  }
  else if($('#cmbinfo').val()==5)
  {
	  document.getElementById("remarks").focus();
	  $('#disputeDate').jqxDateTimeInput({ disabled: false});
		 $('#caseno').attr("disabled",false);
		 $('#station').attr("disabled",false);
		 $('#value').attr("disabled",false);
		 $('#casenote').attr("disabled",false);
	
  }
  else if($('#cmbinfo').val()==6)
  {
	  document.getElementById("remarks").focus();
	  $('#disputeDate').jqxDateTimeInput({ disabled: true});
		 $('#caseno').attr("disabled",true);
		 $('#station').attr("disabled",true);
		 $('#value').attr("disabled",true);
		 $('#casenote').attr("disabled",true);

 
  }
	 
	
	}
	
function funExportBtn(){
	  // $("#disputgrid").jqxGrid('exportdata', 'xls', 'RAG-Under Dispute');
	   
	   
	   
	   if(parseInt(window.parent.chkexportdata.value)=="1")
	    {
	    JSONToCSVCon(datasssss, 'RAG-Under Dispute', true);
	    }
	   else
	    {
	    $("#disputgrid").jqxGrid('exportdata', 'xls', 'RAG-Under Dispute');
	    }
	   
	   
	 }
	
	
function disitems()
{
	
	 $('#disputeDate').jqxDateTimeInput({ disabled: true});
	 
	 $('#cmbinfo').attr("disabled",true);
	 $('#remarks').attr("readonly",true);
	 $('#driverUpdate').attr("disabled",true);
	 $('#caseno').attr("readonly",true);
	 $('#station').attr("readonly",true);
	 $('#value').attr("readonly",true);
	 $('#casenote').attr("readonly",true);
	 
	 

	
}
	function funupdate()
	{	
		
		 if(document.getElementById("cmbinfo").value=="")
		 {
			 $.messager.alert('Message','Select Process ','warning'); 
			 return 0;
		 }
		
		 if($('#remarks').val()=="")
		 {
			 $.messager.alert('Message','Enter Remarks ','warning');  
			 return 0;
		 }
		
		 
		 var remarkss = document.getElementById("remarks").value;
		 var nmax = remarkss.length;
			
			
	      if(nmax>99)
	   	   {
	   	  $.messager.alert('Message',' Remarks cannot contain more than 100 characters ','warning');   
	   	
				return false; 
	   	   
	   	 
	   	 
	   	   } 
		 
		 if($('#cmbinfo').val()==5)
		  {
			 if(document.getElementById("caseno").value=="")
			 {
				 $.messager.alert('Message','Enter Case NO ','warning');  
				 
				 
				 
				 return 0;
			 }
			 if(document.getElementById("station").value=="")
			 {
				 $.messager.alert('Message','Enter Station ','warning');  
				 
				 
				 
				 return 0;
			 }
			 if(document.getElementById("value").value=="")
			 {
				 $.messager.alert('Message','Enter Value ','warning');  
				 
				 
				 return 0;
			 }
			 if(document.getElementById("casenote").value=="")
			 {
				 $.messager.alert('Message','Enter Note ','warning');  
				
				 return 0;
			 }
			 
			 
			 var casenoteval = document.getElementById("casenote").value;
			 var nmax = casenoteval.length;
				
				
		      if(nmax>199)
		   	   {
		   	  $.messager.alert('Message','Note cannot contain more than 200 characters ','warning');   
		   	
					return false; 
		   	   
		   	 
		   	 
		   	   } 
			 
			 
		  }
		 
		 
		 if($('#cmbinfo').val()!=6)
		  {
			   var indate1=new Date($('#duegridDate').jqxDateTimeInput('getDate'));
				 
				  // out date
				 	 var agmtdate1=new Date($('#disputeDate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(indate1>agmtdate1){
			   
			   $.messager.alert('Message',' Date Cannot Be Less Than Due Date ','warning');      
			  
		   return false;
		  }   
		  }

		 
		 var rentaldocno = document.getElementById("rentaldoc").value;
		 var branchids = document.getElementById("branchids").value;
		 var remarks = document.getElementById("remarks").value;
		 var cmbinfo = document.getElementById("cmbinfo").value;
		 var disputedate =  $('#disputeDate').val();

		 var caseno = document.getElementById("caseno").value;
		 var station = document.getElementById("station").value;
		 var value = document.getElementById("value").value;
		 var casenote = document.getElementById("casenote").value;
		var cldocno=document.getElementById("cldocno").value;

		    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
		     	  
			       
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		 savegriddata(rentaldocno,branchids,remarks,cmbinfo,disputedate,caseno,station,value,casenote,cldocno);	
		     	}
			     });
		
		

	}
	function savegriddata(rentaldocno,branchids,remarks,cmbinfo,disputedate,caseno,station,value,casenote,cldocno)
	{
	
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			
			
				var items=x.responseText;
				 document.getElementById("fleetno").value="";
				 document.getElementById("rentaldoc").value="";
				 document.getElementById("branchids").value="";
				 document.getElementById("remarks").value="";
				 document.getElementById("cmbinfo").value="";
				 
				 document.getElementById("caseno").value="";
				 document.getElementById("station").value="";
				 document.getElementById("value").value="";
				 document.getElementById("casenote").value="";
				 document.getElementById("cldocno").value="";
				  $('#disputeDate').val(new Date());
	
				 $.messager.alert('Message', '  Record Successfully Updated ', function(r){
			 		 
			 		 
				     
			     });
				 funreload(event);
				
				 $("#duedetailsgrid").jqxGrid('clear');
				 disitems();
				 
				
				}
			
		}
	
	x.open("GET","savedispute.jsp?rentaldocno="+rentaldocno+"&branchids="+branchids+"&remarks="+remarks+"&cmbinfo="+cmbinfo+"&disputedate="+disputedate+"&caseno="+caseno+"&station="+station+"&value="+value+"&casenote="+casenote+"&cldocno="+cldocno,true);

	x.send();
			
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
</script>
</head>
<body onload="getBranch();getinfo();disitems();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	                                            
	 
	 <tr><td align="right"><label class="branch">Fleet NO</label></td>
	 <td align="left"><input type="text" id="fleetno" style="height:20px;width:70%;" name="fleetno"  value='<s:property value="fleetno"/>' readonly="readonly"> </td></tr>
	<tr> <td  align="right"><label class="branch">Process</label></td><td align="left">
 <select name="cmbinfo" id="cmbinfo" style="width:70%;" name="cmbinfo"  value='<s:property value="cmbinfo"/>' onchange="funchangeinfo()">
       

</select></td></tr>
 <tr><td align="right"><label class="branch">Remarks </label></td><td align="left"><input type="text" id="remarks" style="height:20px;width:88%;" name="remarks"  value='<s:property value="remarks"/>'> </td></tr>
		<tr><td  align="right" ><label class="branch">Date</label></td><td align="left"><div id='disputeDate' name='disputeDate' value='<s:property value="disputeDate"/>'></div>
                   </td></tr>
	 <tr><td align="right"><label class="branch">Case NO </label></td><td align="left"><input type="text" id="caseno" style="height:20px;width:70%;" name="caseno"  value='<s:property value="caseno"/>'> </td></tr>
	 <tr><td align="right"><label class="branch">Station </label></td><td align="left"><input type="text" id="station" style="height:20px;width:70%;" name="station"  value='<s:property value="station"/>'> </td></tr>
	  <tr><td align="right"><label class="branch">Value </label></td><td align="left"><input type="text" id="value" style="height:20px;width:70%;" name="value"  value='<s:property value="value"/>' onkeypress="javascript:return isNumber (event)" > </td></tr>
	 <tr><td align="right" ><label class="branch">Note</label></td><td align="left"><input type="text" id="casenote" style="height:20px;width:88%;" name="casenote"  value='<s:property value="casenote"/>'> </td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	<tr><td  align="center" colspan="2"><input type="Button" name="driverUpdate" id="driverUpdate" class="myButton" value="UPDATE" onclick="funupdate()"></td> </tr>
	
	 <tr><td colspan="2">&nbsp;</td></tr>  
 
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>	
	 <tr><td colspan="2">&nbsp;</td></tr>
	 	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>	





  </table>
  
  
  
   <input type="hidden" name="cldocno" id="cldocno" style="height:20px;width:70%;" value='<s:property value="cldocno"/>' >
 <input type="hidden" name="rentaldoc" id="rentaldoc" style="height:20px;width:70%;" value='<s:property value="rentaldoc"/>' >
 
  <input type="hidden" name="branchids" id="branchids" style="height:20px;width:70%;" value='<s:property value="branchids"/>' >
 
<div hidden="true" id='duegridDate' name='duegridDate' value='<s:property value="duegridDate"/>'></div>	 
	 
   </fieldset>

</td>
<td width="80%">
	<table width="100%">
		<tr>
			  <td><div id="disputdiv"><jsp:include page="disputeGrid.jsp"></jsp:include></div> <br></td> 
		</tr>
			<tr>
		<td colspan="2" align="left" ><div id="disdetaildiv"><jsp:include page="dispudetailgrid.jsp"></jsp:include></div></td></tr>
	</table>
</tr>
</table>
</div>
</div>
</body>
