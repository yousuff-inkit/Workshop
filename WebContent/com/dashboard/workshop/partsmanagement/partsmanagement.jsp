<link href="../../../../css/css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%--  <script type="text/javascript" src="../../js/dashboard.js"></script>  --%>
<style type="text/css">
.myButtons {
	display: inline-block;
	margin-right:4px;
	margin-left:4px; 
  margin-bottom: 0;
  font-weight: normal;
  line-height: 1.3;
  text-align: center;
  white-space: nowrap;
  vertical-align: middle;
  -ms-touch-action: manipulation;
      touch-action: manipulation;
  cursor: pointer;
  -webkit-user-select: none;
     -moz-user-select: none;
      -ms-user-select: none;
          user-select: none;
  background-image: none;
  border: 1px solid transparent;
  border-radius: 4px;
  color: #fff;
  background-color: grey;
}
.myButtons:hover {
	  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons:active {
  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons:focus {
  color: #fff;
  background-color: grey;
}
 
select{
    height:18px;
}
.hidden-scrollbar {
  /* // overflow: auto; */
  height: 530px;
    overflow-x: hidden;
    
}
.headClass
        {
            background-color: #FFEBC2;
        }
        .redClass
        {
            background-color: #FFEBEB;
        }
        .violetClass
        {
            background-color: #EBD6FF;
        }
        .yellowClass
        {
            background-color: #FFFFD1;
        }
        .whiteClass
        {
           background-color: #FFF;
        }
        .greenClass
        {
           background-color: #CEFFCE;
        }	  
</style>

<script type="text/javascript">

$(document).ready(function () {
	
	
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	    
	 $("#Uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#Invdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});

	 $('#bayWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Bay Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#bayWindow').jqxWindow('close');
	 
	 $('#TechnicianWindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Technician Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	 $('#TechnicianWindow').jqxWindow('close');
	 
	 $('#sparePartWindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Spare Part Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	 $('#sparePartWindow').jqxWindow('close');
	 
	 $('#jobcard').dblclick(function(){
		 jobCardSearchContent("jobCardSearch.jsp");

		});
	 $('#vendorToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Vendor Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		$('#vendorToWindow').jqxWindow('close');
	 $('#jobCardToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Job Card Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#jobCardToWindow').jqxWindow('close');
	 
	 $("#vendor").dblclick(function(){
			vendorSearchContent("vendorSearch.jsp");
		});
	 
});
function funExportBtn(){
	//JSONToCSVCon(floordataexcel, 'Parts Accounting', true);
	$("#floorMgmtGrid").excelexportjs({
		containerid: "floorMgmtGrid",
		datatype: 'json',
		dataset: null,
		gridId: "floorMgmtGrid",
		columns: getColumns("floorMgmtGrid"),
		worksheetName: "Parts Accounting"
	});

}

	function vendorSearchContent(url) {
	 	$('#vendorToWindow').jqxWindow('open');
		$.get(url).done(function (data) {
			$('#vendorToWindow').jqxWindow('setContent', data);
		});
	}

	
	function funLoadData(){
		$("#nidescdetailsGrid").jqxGrid('clear');
		funsetnigrid();
		 
		
	}
	

	function funCreatePurch(){ 
	
   
	var rows = $("#jqxpartsgrid3").jqxGrid('getrows');
	
	var selectedrows=$("#jqxpartsgrid3").jqxGrid('selectedrowindexes');
	selectedrows = selectedrows.sort(function(a,b){return a - b});
	
	if(selectedrows.length==0){
	$("#overlay, #PleaseWait").hide();
	$.messager.alert('Warning','Select documents.');
	return false;
	}
	
	$.messager.confirm('Message', 'Do you want to save changes?', function(r){
	if(r==false)
	{
	return false; 
	}
	else
	{
	$("#overlay, #PleaseWait").show();
	var i=0;var temptrno=0;var temtbpur=0;var temaddval=0;
	var j=0;var k=0;var temptrno1=0;var temtbpur1=0;var temaddval1=0;
	for (i = 0; i < selectedrows.length; i++) {
	
			var srvdetmtrno= $('#jqxpartsgrid3').jqxGrid('getcellvalue', selectedrows[i], "rowno");
			temptrno=temptrno+","+srvdetmtrno;
			
			var chngntb= $('#jqxpartsgrid3').jqxGrid('getcellvalue', selectedrows[i], "toberequested");
			temtbpur=temtbpur+","+chngntb;
			
			var addval= $('#jqxpartsgrid3').jqxGrid('getcellvalue', selectedrows[i], "outqty");
			temaddval=temaddval+","+addval;
		
		
	temptrno1=temptrno;
	temtbpur1=temtbpur;
	temaddval1=temaddval;
	
    
	}
	$('#srvdetmtrno').val(temptrno1);
	$('#chngntb').val(temtbpur1);
	$('#addval').val(temaddval1);
	
	savegriddata($('#srvdetmtrno').val(),$('#chngntb').val(),$('#addval').val());
	
	}
	});
	}   
	function savegriddata(srvdetmtrno,chngntb,addval){
		
		var x=new XMLHttpRequest();
		var rval=$('#roundoff').val();
		var remarks=$('#txtremarks').val();
		var acno=$('#vendacno').val();
		var vtax=$('#vendtax').val();
		var idate=$('#Invdate').val();
		var ino=$('#invno').val();
		var jobno=$('#jobcarddocno').val();
		var ntotal=$('#nettotalval').val();
		var rows=$("#nidescdetailsGrid").jqxGrid('getrows');
		var gridarray=new Array();
		for(var i=0 ; i < rows.length ; i++){          
		 	    chks=rows[i].description;
		 	   $('#hiddesc').val(rows[i].description);               
				if (($(hiddesc).val()).includes('$')) { $(hiddesc).val($(hiddesc).val().replace('$', ''));};if (($(hiddesc).val()).includes('%')) { $(hiddesc).val($(hiddesc).val().replace('%', ''));};
		    	if (($(hiddesc).val()).includes('^')) { $(hiddesc).val($(hiddesc).val().replace('^', ''));};if (($(hiddesc).val()).includes('`')) { $(hiddesc).val($(hiddesc).val().replace('`', ''));};
		    	if (($(hiddesc).val()).includes('~')) { $(hiddesc).val($(hiddesc).val().replace('~', ''));};if ($(hiddesc).val().indexOf('\'')  >= 0 ) { $(hiddesc).val($(hiddesc).val().replace(/'/g, ''));};
		    	if ($(hiddesc).val().indexOf('"') >= 0) { $(hiddesc).val($(hiddesc).val().replace(/["']/g, ''));};if (($(hiddesc).val()).match(/\\/g)) { $(hiddesc).val($(hiddesc).val().replace(/\\/g, ''));};
		 	   if((typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != "") ){  
		 		  
		 		  gridarray.push((i+1)+" :: "+rows[i].qty+" :: "+$('#hiddesc').val()+" :: "+rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "+rows[i].nuprice+" :: 9 :: "+jobno+" :: "+0+" :: "+rows[i].headdoc+" :: "+rows[i].refrow+" :: "+rows[i].taxper+" :: "+rows[i].taxperamt+" :: "+rows[i].taxamount+"::");
			 }
		}
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
		{
		var items=x.responseText.trim();
		var nipurchasedocno=items.split("::")[0];
		var nipurchasevocno=items.split("::")[1];
		if(parseInt(nipurchasedocno)>0)
		{
			//'Document'+items+' Successfully Updated In Ni Purchase'
			$.messager.alert('Message', 'Successfully Created NI Purchase #'+nipurchasevocno);
			$("#overlay, #PleaseWait").hide();
		var reld=$('#jobcarddocno').val();
		$("#partsgrid3div").load("partsGrid.jsp?rowno="+reld+"&check="+1);
		$('#srvdetmtrno').val("");
		$('#chngntb').val("");
		$('#addval').val("");
		$("#nidescdetailsGrid").jqxGrid('clear');
		document.getElementById("invno").value="";
		document.getElementById("vendor").value="";
		document.getElementById("nettotalval").value="";
		document.getElementById("roundoff").value=0;
		 funcolctnipurchdet ();
		
		}
		else
		{
		$.messager.alert('Message', ' Not Updated ');
		}
		} 
		}  
		x.open("GET","savgdata.jsp?srvdetmtrno="+srvdetmtrno+"&chngsntb="+chngntb+"&addval="+addval+"&gridarray="+gridarray+"&acno="+acno+"&idate="+idate+"&ino="+ino+"&jobno="+jobno+"&ntotal="+ntotal+"&vtax="+vtax+"&roundval="+rval+"&remarks="+remarks,true);
		x.send();
		
		}  
	
	/* function funcolctnipurchdet() {
    
		$.messager.confirm('Message', 'Do you want to save changes?', function(r){
		if(r==false)
		{
		return false; 
		}
		else
		{
		//var accno=$('#raccno').val();
		var rval=$('#roundoff').val();
		var acno=$('#vendacno').val();
		var vtax=$('#vendtax').val();
		var idate=$('#Invdate').val();
		var ino=$('#invno').val();
		var jobno=$('#jobcarddocno').val();
		var ntotal=$('#nettotalval').val();
		var rows=$("#nidescdetailsGrid").jqxGrid('getrows');
		var gridarray=new Array();
		for(var i=0 ; i < rows.length ; i++){          
		 	    chks=rows[i].description;
		 	   if((typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != "") ){  
		 		  
		 		  gridarray.push((i+1)+" :: "+rows[i].qty+" :: "+rows[i].description+" :: "+rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "+rows[i].nuprice+" :: "+0+" :: "+0+" :: "+0+" :: "+rows[i].headdoc+" :: "+rows[i].refrow+" :: "+rows[i].taxper+" :: "+rows[i].taxperamt+" :: "+rows[i].taxamount+"::");
			 }    
		}
	savepurrchgridData(gridarray,acno,idate,ino,jobno,ntotal,vtax,rval);
    }
	});
	}
	function savepurrchgridData(gridarray,acno,idate,ino,jobno,ntotal,vtax,rval){
		
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
		{
		var items=x.responseText;
		if(parseInt(items)>0)
		{
		$.messager.alert('Message', 'Document'+items+' Successfully Updated In Ni Purchase');
		$("#overlay, #PleaseWait").hide();
		$("#nidescdetailsGrid").jqxGrid('clear');
		document.getElementById("invno").value="";
		document.getElementById("vendor").value="";
		document.getElementById("nettotalval").value="";
		document.getElementById("roundoff").value="";
		}
		else
		{
		$.messager.alert('Message', ' Not Updated ');
		}
		} 
		}  
		x.open("GET","savepurrchgridData.jsp?gridarray="+gridarray+"&acno="+acno+"&idate="+idate+"&ino="+ino+"&jobno="+jobno+"&ntotal="+ntotal+"&vtax="+vtax+"&roundval="+rval,true);
		x.send();
		
		
	} */
	function funcPrint(){
	  		
		var rows = $("#jqxpartsgrid3").jqxGrid('getrows');

		var selectedrows=$("#jqxpartsgrid3").jqxGrid('selectedrowindexes');
		selectedrows = selectedrows.sort(function(a,b){return a - b});

		if(selectedrows.length==0){
		$("#overlay, #PleaseWait").hide();
		$.messager.alert('Warning','Select documents.');
		return false;
		}


		 var i=0;var temptrno="";
		var j=0;
		for (i = 0; i < rows.length; i++) {
		if(selectedrows[j]==i){

		if(i==0){
		var srvdetmtrno= $('#jqxpartsgrid3').jqxGrid('getcellvalue', i, "rowno");
		temptrno=srvdetmtrno;
		}
		else{
		var srvdetmtrno= $('#jqxpartsgrid3').jqxGrid('getcellvalue', i, "rowno");
		temptrno=temptrno+","+srvdetmtrno;
		}
// 		temptrno1=temptrno+",";
        temptrno1=temptrno;
		j++; 
		}
		}
		$('#remtrno').val(temptrno1); 
		
	
	  		var jobno=$('#remtrno').val();
		    //alert(jobno);
	  	    var url=document.URL;
	  	    var reurl=url.split("com/");
	  	    //alert(reurl[0]+"printPartsCosting?jobno="+document.getElementById("hidjobno").value);
	  	  
	  	    var win= window.open(reurl[0]+"com/dashboard/workshop/partsmanagement/printParts?rowno="+$('#jobcarddocno').val()+"&jobdocno="+$('#remtrno').val(),"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	  	    win.focus();
	  		
	  	}
	
	function funsetnigrid(){
		//$("#nidescdetailsGrid").load("nipurchaseGrid.jsp");
		
		
	/* 	 if($('#invno').val()==""){
	  		   $.messager.alert('Message','Input a invoice number.');
	  		  }
 */		 if($('#vendor').val()=="" || $('#invno').val()=="" ){
	  		   $.messager.alert('Message','Select a vendor and invoice number.');
	  		  }
		 else{
		var taxcal=$('#vendtax').val();
	    if(taxcal==1){
	    	taxcal=5;
	    }else{
	    	taxcal=0;
	    }
	    
	   // if(taxcal==0)
		var rowcn = $("#jqxpartsgrid3").jqxGrid('getrows');
        var selectedrows=$("#jqxpartsgrid3").jqxGrid('selectedrowindexes');
        selectedrows = selectedrows.sort(function(a,b){return a-b;});
        
        var i=0;var j=0;
        for (i=0; i<rowcn.length; i++) {
	        
	        if(selectedrows[j]==i){
	        	$("#nidescdetailsGrid").jqxGrid('addrow', null, {});
	        	var rows = $("#nidescdetailsGrid").jqxGrid('getrows');
	 	        var rowlength= rows.length;
	        var bal=$('#jqxpartsgrid3').jqxGrid('getcellvalue', i, "toberequested");
	        if(bal==0){
	        	 $.messager.alert('Message','Sufficient balance not available.');
	        }else{
	        $('#nidescdetailsGrid').jqxGrid('setcellvalue',  rowlength-1, "description",$('#jqxpartsgrid3').jqxGrid('getcellvalue', i, "description"));
	        $('#nidescdetailsGrid').jqxGrid('setcellvalue',  rowlength-1, "qty",$('#jqxpartsgrid3').jqxGrid('getcellvalue', i, "toberequested"));
	        
	        $('#nidescdetailsGrid').jqxGrid('setcellvalue',  rowlength-1, "unitprice",$('#jqxpartsgrid3').jqxGrid('getcellvalue', i, "total"));
	        $('#nidescdetailsGrid').jqxGrid('setcellvalue',  rowlength-1, "taxper",taxcal);
	        $('#nidescdetailsGrid').jqxGrid('setcellvalue',  rowlength-1, "refrow",$('#jqxpartsgrid3').jqxGrid('getcellvalue', i, "rowno"));
	        $('#nidescdetailsGrid').jqxGrid('setcellvalue',  rowlength-1, "headdoc",$('#jqxpartsgrid3').jqxGrid('getcellvalue', i, "accno"));
	        $('#nidescdetailsGrid').jqxGrid('setcellvalue',  rowlength-1, "account",$('#jqxpartsgrid3').jqxGrid('getcellvalue', i, "raccno"));
	    	var raccno=$('#jqxpartsgrid3').jqxGrid('getcellvalue', i, "raccno");
	        }
	    	//alert(raccno);
			j++;
	        }
			
	     }
		 }
     
	}
	
	function funClearData(){
		/* $('input[type=text],[type=hidden]').val('');
		$('select').find('option').prop("selected", false);
		$('#Uptodate').jqxDateTimeInput('setDate',new Date());
	    $('input[type=radio]').prop("checked",false);
	    $('input[type=checkbox]').prop("checked",false);
	    $("#servicegrid2").jqxGrid('clear');
	    $("#partsgrid3").jqxGrid('clear');  
	    $("#jobgrid1").jqxGrid('clear'); */
	}
	
	 function funroundof() 
	   {
		   
		   var aa=document.getElementById("roundoff").value;
		   
		  if(aa=="" || aa==null)
			  {
			  aa=0;
			  }
		   
		   if(parseFloat(aa)>0 || parseFloat(aa)<0 || parseFloat(aa)==0)
			   {
			   
			   var summaryData1= $("#nidescdetailsGrid").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
            
             var cc=summaryData1.sum.replace(/,/g,'');
             var bb=parseFloat(cc)+parseFloat(aa);
             
             
             
          funRoundAmt(aa,"roundoff");
             funRoundAmt(bb,"nettotalval");
			   
			   }
		   
		     
	   }
	
	 function isNumber(evt) {
	        var iKeyCode = (evt.which) ? evt.which : evt.keyCode;
	        
	        		 if (iKeyCode == 45)
	        			       			 
	        			  {
	        			 
	        			 
	        			  return true;
	        		     } 
	        		
	        		
	        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
	        	{
	     	   document.getElementById("errormsg").innerText=" Enter Numbers Only";  
	           
	            return false;
	        	}
	        document.getElementById("errormsg").innerText="";  
	        return true;
	    }
	   
	   
	function funreload(event)
	
	{	
	    var brhid=$('#cmbbranch').val();
		 $("#floorMgmtGridDiv").load("partsmanagementGrid.jsp?&id=1&brhid="+brhid);
			
	   	
	}
	
	 function SearchContent(url,id) {
	    $.get(url).done(function (data) {
	  $('#'+id).jqxWindow('setContent', data);
	}); 
	}
	 
   
	 function funServiceUpdate(){  
		
		var jobno=$('#jobcarddocno').val();
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
		{
			var items=x.responseText;
			if(parseInt(items)>=1)
			{
				 $("#floorMgmtGridDiv").load("partsmanagementGrid.jsp?&id="+1);
				  $("#partflwupgrid").load("partsfllwup.jsp?docno="+jobno+"");
				$.messager.alert('Message', ' Successfully Updated ');
			}
			else
			{
				$.messager.alert('Message', ' Not Updated ');
			}
		}   
		}  
		x.open("GET","saveData.jsp?rowno="+$('#rowsno').val()+"&date="+$('#Uptodate').val()+"&remarks="+$('#txtremks').val()+"&statusid="+$('#txtstatus').val()+"&jobno="+$('#jobcarddocno').val(),true);    
		x.send();
	}	 



	   


	function disablepart(){
		
		
		 $("#amcfollowupGrid").jqxGrid('clear');
		 $("#amcfollowupGrid").jqxGrid({ disabled: true});
	}


	



	
	</script> 
	
</head>
<!-- setValues(); -->
<body onload="getBranch();disablepart();">
<!-- <form id="frmWorkQuotationApproval" method="post"> -->
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%" align="center">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>
	
	<tr>
	
   <td width="37%" align="right"><label class="branch">Status</label></td>            
         <td ><select id="txtstatus" name="txtstatus" style="width:75%;height:20px;" value='<s:property value="txtstatus"/>'>   
      <option value="">--select--</option><option value="Available">Available</option><option value="PartAvail">Partially Available</option><option value="Delayed">Delayed</option><option value="Ordered">Ordered</option></select>
  </tr>

 <tr>
   <td width="37%" align="right"><label class="branch">Parts exp.Dt</label></td><td width="63%"><div id="Uptodate"></div></td>
 </tr>
 <tr>
   <td width="37%" align="right"><label class="branch">Remarks</label></td>
   <td width="63%"><input type="text" name="txtremks" id="txtremks" style="height:20px;width:90%;" value='<s:property value="txtremks"/>' ></td>
 </tr>
 <!-- <tr>
   <td width="37%" align="right"><label class="branch">Job Card</label></td>
   <td width="63%"><input type="text" name="jobcard" id="jobcard" readonly placeholder="Press F3 to Search" onkeydown="getjobCardDetails(event)"></td>
 </tr> -->

 <%--  <tr>
   <td width="37%" align="right"><label class="branch">Remarks</label></td>
   <td width="63%"><input type="text" name="txtremarks" id="txtremarks" style="height:20px;width:90%;" value='<s:property value="txtremarks"/>' ></td>
 </tr> --%>
 <tr colspan="2"><td>&nbsp;</td></tr>
 <tr >
	<td colspan="2" style="border-top:2px solid #DCDDDE;">
	<div style="text-align:center;">
	<!-- <input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();"> &nbsp;
 -->	<input type="button" name="btnupdate" id="btnupdate" value="Update" class="myButtons" onclick="funServiceUpdate();"> &nbsp;
 <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
 
  <input type="button" name="btncreatepurch" id="btncreatepurch" value="Create Ni purchase" class="myButtons" onclick="funCreatePurch();"> &nbsp;
  <input type="button" class="myButton" name="btnPrint" id="btnPrint"  value="Print" onclick="funcPrint();">
  </tr>
	</div>
    </td>
	</tr>
<tr ><td colspan="2"><!-- <textarea id="agmtdetails" name="agmtdetails" readonly style="resize:none;" rows="10" cols="35"></textarea> -->
	
	<!-- <div style="text-align:center;">
		<input type="button" name="btncreatmr" id="btncreatmr" value="Creat MR" class="myButtons" onclick="funUpdateDetails();">
	</div> -->
	<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

</td></tr>

<tr colspan="2"><td>&nbsp;</td></tr>
	
		
	</table>
	</fieldset>
</td>
<td width="80%">
	<fieldset class="violetClass">
	<legend>Parts Management </legend>
	    <table width="100%" border="0">
		  <tr>
	   		<td><div id="floorMgmtGridDiv"><jsp:include page="partsmanagementGrid.jsp"></jsp:include></div></td>
	   	  </tr>
		</table>
	</fieldset>
	
	 <fieldset class="violetClass">
	<legend>Parts </legend>
	    <table width="100%" border="0">
		  <tr>
	   	<td><div id="partsgrid3div"><jsp:include page="partsGrid.jsp"></jsp:include></div></td>
	   	  </tr>  
		</table>
	</fieldset>
	<table width="100%" border="0">
	
     <tr>
     <td align="left" width="30%"><label class="branch">Vendor</label>
     <input type="text" name="vendor" id="vendor" style="height: 18px;" size=40% readonly="readonly" placeholder="Press F3 to search" onkeydown="vendorSearchContent(url)" value='<s:property value="vendor" />'></td>
	
     <td align="left" width="10%"><label class="branch">InvNo</label>
     <input type="text" name="invno" id="invno" style="height: 18px;" size=4%  placeholder="Enter Inv No"  value='<s:property value="invno" />'></td>
	
   <td  align="center"><label class="branch">InvDate</label></td>
   <td width="10%"><div id="Invdate" align="left" ></div></td> 
	
	<td align="left" width="50%"><label class="branch">Remarks</label>
    <input type="text" name="txtremarks" id="txtremarks" style="height: 18px;" size=80%   placeholder="Enter Remarks"  value='<s:property value="txtremarks" />'></td>
	
	</tr>
	<tr>
	 <td align="left"><input type="button" name="btnload" id="btnload" value="Load" class="myButtons" onclick="funLoadData();"> &nbsp;</td>	 
	 </tr>
   </table>
	<fieldset class="violetClass">
	<legend>Ni Purchase </legend>
	    <table width="100%" border="0">
		 <tr>
	   		<td><div id="nipurchasegrid"><jsp:include page="nipurchaseGrid.jsp"></jsp:include></div></td>
	   			   		
	   	  </tr> 
		</table>
	</fieldset>
   <fieldset> 
   <table width="100%" border="0"> 
   <td align="right"><label class="branch">Roundof</label></td>
    <td><div><input type="text" id="roundoff" name="roundoff" onblur="funroundof()"  style="text-align: right;"   onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);" value='<s:property value="roundoff"/>'/>&nbsp;&nbsp;</div></td>
    <td width="50%" align="right"><label class="branch">NetTotal</label></td>
    <td><div><input type="text" id="nettotalval" name="nettotalval"  style="text-align: right;"   value='<s:property value="nettotalval"/>'/></div></td>
   </table>
   </fieldset>
	<fieldset class="violetClass">
	<legend>Parts Followup</legend>
	    <table width="100%" border="0">
		 <tr>
	   		<td><div id="partflwupgrid"><jsp:include page="partsfllwup.jsp"></jsp:include></div></td>
	   	  </tr> 
		</table>
	</fieldset> 
	
</tr>
</table>
</div>

</div>
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="rowsno" id="rowsno" value='<s:property value="rowsno"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  <input type="hidden" name="jobcarddocno" id="jobcarddocno" value='<s:property value="jobcarddocno"/>'>
			  <input type="hidden" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>'>
			  <input type="hidden" name="jobno" id="jobno" value='<s:property value="jobno"/>'>
			  <input type="hidden" name="techno" id="techno" value='<s:property value="techno"/>'>
			  <input type="hidden" name="bayno" id="techno" value='<s:property value="techno"/>'>
			  <input type="hidden" name="part" id="part" value='<s:property value="part"/>'>
			  <input type="hidden" name="qnty" id="qnty" value='<s:property value="qnty"/>'>
			  <input type="hidden" name="rownum" id="rownum" value='<s:property value="rownum"/>'>
			  <input type="hidden" name="purqty" id="purqty" value='<s:property value="purqty"/>'>
			   <input type="hidden" name="tbpur" id="tbpur" value='<s:property value="tbpur"/>'>
			  <input type="hidden"  id="srvdetmtrno" name="srvdetmtrno" value='<s:property value="srvdetmtrno"/>' >
			  <input type="hidden"  id="chngntb" name="chngntb" value='<s:property value="chngntb"/>' >
			  <input type="hidden"  id="addval" name="addval" value='<s:property value="addval"/>' >
			  <input type="hidden" id="vendorname" name=vendorname value='<s:property value="vendorname"/>'>
			  <input type="hidden" id="vendorid" name=vendorid value='<s:property value="vendorid"/>'>
			  <input type="hidden" id="vendtax" name=vendtax value='<s:property value="vendtax"/>'>
			  <input type="hidden" id="vendacno" name=vendacno value='<s:property value="vendacno"/>'>
			   <input type="hidden" id="raccno" name=raccno value='<s:property value="raccno"/>'>
			     <input type="hidden" id="nettotal" name=nettotal value='<s:property value="nettotal"/>'>
			     <input type="hidden" id="remtrno" name=remtrno value='<s:property value="remtrno"/>'>
			     <input type="hidden" id="hiddesc" name=hiddesc value='<s:property value="hiddesc"/>'>
</form>
<div id="TechnicianWindow">
	<div></div>
	</div>
	<div id="bayWindow">
	<div></div>
	</div>
	<div id="sparePartWindow">
	<div></div>
	</div>
	<div id="jobCardToWindow">
	<div></div>
	</div>
	<div id="vendorToWindow">
	<div></div>
</div>
</body>
</html>