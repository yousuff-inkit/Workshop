<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<script type="text/javascript">
	$(document).ready(function() {
		 $("#btnstockcheck").hide();
		
		 $("#jqxStockCheckDate").jqxDateTimeInput({ width: '120px', height: '15px', formatString:"dd.MM.yyyy"});
	});

	
	function funReadOnly(){
		$('#frmVehStockCheck input').attr('readonly', true );
		$('#jqxStockCheckDate').jqxDateTimeInput({disabled: true});
		$("#jqxVehStockGrid").jqxGrid({ disabled: true});
		$("#btnstockcheck").hide();
    }
 	
	function funRemoveReadOnly(){
		$('#frmVehStockCheck input').attr('readonly', true );
		$('#txtremarks').attr('readonly', false );
		$('#jqxStockCheckDate').jqxDateTimeInput({disabled: true});
		$("#jqxVehStockGrid").jqxGrid({ disabled: true});
	    $("#btnstockcheck").show();
	    
	    if ($("#mode").val() == "A") {
			 $("#jqxVehStockGrid").jqxGrid('clear'); 
			 $("#jqxVehStockGrid").jqxGrid('addrow', null, {}); 
		} 
	    
	    if ($("#mode").val() == "E") {
	    	 $("#btnstockcheck").hide(); 
	    	 $("#jqxVehStockGrid").jqxGrid('disabled', false); 
		} 
    }
	
	function funSearchLoad(){
		 changeContent('vstcMainSearch.jsp'); 
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#btnstockcheck').focus();
	    }
	   
	  function funNotify(){	
		  
		  /* Stock Check Grid  Saving*/
			 var rows = $("#jqxVehStockGrid").jqxGrid('getrows');
			 var length=0;
				 for(var i=0 ; i < rows.length ; i++){
					var chk=rows[i].fleet_no;
					if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
						newTextBox = $(document.createElement("input"))
					    .attr("type", "dil")
					    .attr("id", "test"+length)
					    .attr("name", "test"+length)
						.attr("hidden", "true");
						length=length+1;
						
			    newTextBox.val(rows[i].fleet_no+"::"+rows[i].tran_code+"::"+rows[i].remarks+"::"+rows[i].brhid);
				newTextBox.appendTo('form');
				 }
				}
	 		 $('#gridlength').val(length);
		   /* Stock Check Grid  Saving Ends*/
		  
		     $('#jqxStockCheckDate').jqxDateTimeInput({disabled: false});
	    	 return 1;
		} 
	  
	  
	  function setValues(){
		  
		  if($('#hidjqxStockCheckDate').val()){
				 $("#jqxStockCheckDate").jqxDateTimeInput('val', $('#hidjqxStockCheckDate').val());
			  }
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
		  
		  var indexVal = document.getElementById("docno").value;
		  var brch=window.parent.branchid.value;
		 
		  if(indexVal>0 && brch!="") {
			 $('#brchName').attr('disabled', false);   
			 $("#vehicleStockCheckDiv").load("vehicleStockCheckGrid.jsp?txtvehstockcheckdocno2="+indexVal+'&branch='+brch);
		  }
		}
	
	function funStockGridLoad(){
		var brch=document.getElementById("brchName").value;
		$("#jqxVehStockGrid").jqxGrid({ disabled: false});
		var chk=1;
		$("#vehicleStockCheckDiv").load("vehicleStockCheckGrid.jsp?check="+chk+'&branch='+brch);
		
	}
	
	
	function funExcelBtn(){
	    

		JSONToCSVCon(vehstchkexcel, 'Vehicle Stock Check List', true);
		   }
		  
		
	
</script>
	
<style>
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

.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmVehStockCheck" action="saveVehStockCheck" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div  class='hidden-scrollbar'>

<table width="100%">
  <tr>
    <td width="6%" align="right">Date</td>
    <td width="8%"><div id="jqxStockCheckDate" name="jqxStockCheckDate" value='<s:property value="jqxStockCheckDate"/>'></div>
    <input type="hidden" id="hidjqxStockCheckDate" name="hidjqxStockCheckDate" value='<s:property value="hidjqxStockCheckDate"/>'/></td>
    <td width="9%" align="right" style="font-family: Myriad Pro;font-size: 12px;font-weight: bold;color: #32CD32;">Ready To Rent : </td>
    <td width="10%"><input type="text" class="textbox" id="txtreadytorent" name="txtreadytorent" style="width:60%;text-align: center;" value='<s:property value="txtreadytorent"/>'/></td>
    <td width="6%" align="right" style="font-family: Myriad Pro;font-size: 12px;font-weight: bold;color: #FA5858;">UnRentable : </td>
    <td width="14%"><input type="text" class="textbox" id="txtunrentable" name="txtunrentable" style="width:40%;text-align: center;" value='<s:property value="txtunrentable"/>'/></td>
    <td width="3%" align="right" style="font-family: Myriad Pro;font-size: 12px;font-weight: bold;">Total : </td>
    <td width="14%"><input type="text" class="textbox" id="txttotal" name="txttotal" style="width:40%;text-align: center;" value='<s:property value="txttotal"/>'/></td>
    <td width="5%" align="center"><button class="myButton" type="button" id="btnstockcheck" name="btnstockcheck" onclick="funStockGridLoad();">View</button></td>
    <td width="6%" align="right">Doc No</td>
    <td width="19%"><input type="text" id="docno" name="txtvehstockcheckdocno" style="width:50%;" value='<s:property value="txtvehstockcheckdocno"/>' tabindex="-1"/></td>
  </tr>
  <tr>
    <td align="right">Remarks</td>
    <td colspan="10"><input type="text" id="txtremarks" name="txtremarks" style="width:60%;"  value='<s:property value="txtremarks"/>'/></td>
  </tr>
</table><br/>

<div id="vehicleStockCheckDiv"><jsp:include page="vehicleStockCheckGrid.jsp"></jsp:include></div><br/>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
</div>
</form>
	
</div>
</body>
</html>
