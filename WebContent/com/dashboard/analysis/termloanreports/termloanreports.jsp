
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
<style>
.myButtons {
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
}


	
      

</style>

<script type="text/javascript">

$(document).ready(function () {
	 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	
	 
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

     $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
	 $('#accountSearchwindow').jqxWindow('close');  
	 
	 
	 $('#dealnowindow').jqxWindow({ width: '30%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Deal No Search' , position: { x: 200, y: 60 }, keyboardCloseKey: 27});
	 $('#dealnowindow').jqxWindow('close');
	     
	 
      
		 $('#dealno').dblclick(function(){
		  	    $('#dealnowindow').jqxWindow('open');
		   
		  	  dealnoSearchContent('dealnoseach.jsp?', $('#dealnowindow')); 
	    });
		 
		 
	     
		 $('#txtaccid').dblclick(function(){
		  	   
	  		  
			  $('#accountSearchwindow').jqxWindow('open');
			 commenSearchContent('finaccountSearch.jsp?');
				        
		  }); 
			  
		 
		 
		/*   $("#fleetdiv").hide();
		  $("#enqlistdiv").show(); */
});

 
 

function  getdealNo(event){
	 var x= event.keyCode;
	 if(x==114){
		
	  $('#dealnowindow').jqxWindow('open');
	
	  dealnoSearchContent('dealnoseach.jsp?');
	          }
		   
	 else{
		 }
	 
 
            }
 
 

function dealnoSearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 
			 $('#dealnowindow').jqxWindow('open');
		$('#dealnowindow').jqxWindow('setContent', data);

	}); 
	} 	
 
 
function  getAccTypeFrom(event){
	 var x= event.keyCode;
	 if(x==114){
		
	  $('#accountSearchwindow').jqxWindow('open');
	
	 commenSearchContent('finaccountSearch.jsp?');
	          }
		   
	 else{
		 }
	 }  



function commenSearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 
			 $('#accountSearchwindow').jqxWindow('open');
		$('#accountSearchwindow').jqxWindow('setContent', data);

	}); 
	} 	

function funExportBtn(){

	 
	 var type = document.getElementById("type").value;
	 
  
	 
		   if(type=="summary")
		   {
		
	 
 		 JSONToCSVConvertor(summdata, 'Term Loan Report', true);
 		 
		   }
		    
		  
	 
		   else   if(type=="detail" )
		   {
		
		
 		 JSONToCSVConvertor(detaildata, 'Term Loan Report', true);
 		 
		   }
	 }
 

 

function funreload(event)
{

	var uptodate = $('#uptodate').val();
	 var barchval = document.getElementById("cmbbranch").value;
			 
			 var type = document.getElementById("type").value;
			  
			 var findoc = document.getElementById("txtdocno").value;	
			 var dealnos = document.getElementById("dealno").value;
			 
		 		var dealno = dealnos.replace(/ /g, "%20");
			 
		   if(type=="summary")
			   {
			   
		  
               var aa="chk";

	 
	   $("#overlay, #PleaseWait").show();
	  $("#enqlistdiv").load("Gridfirst.jsp?barchval="+barchval+"&type="+type+"&val="+aa+"&findoc="+findoc+"&dealno="+dealno+'&uptodate='+uptodate);
			   }
	
		 
		 
		  if(type=="detail")
		  {
			 
		  $("#overlay, #PleaseWait").show();  
		  var aa="fleets";
		  $("#detdivs").load("detailgrid.jsp?barchval="+barchval+"&type="+type+"&val="+aa+"&findoc="+findoc+"&dealno="+dealno+'&uptodate='+uptodate);
		 
			
		  
		  
		  }
	  
		  
		  
	}



function changegrid()
{
	 var type = document.getElementById("type").value;
	if(type=="summary")
		{
		 
		  $("#enqlistdiv").show(); 
		  $("#detdivs").hide(); 
		  
		  $("#detailgeids").jqxGrid('clear');
	      $("#detailgeids").jqxGrid('addrow', null, {});
	      
		  
		  
	      $("#vehicleAssetGrid").jqxGrid('clear');
	      
	      $("#vehicleAssetGrid").jqxGrid('addrow', null, {});
	       
		
		}
	else
		{
	
	 
	  $("#enqlistdiv").hide(); 
	  $("#detdivs").show(); 
	  
	  $("#detailgeids").jqxGrid('clear');
      $("#detailgeids").jqxGrid('addrow', null, {});
      
	 
      
      $("#vehicleAssetGrid").jqxGrid('clear');
      $("#vehicleAssetGrid").jqxGrid('addrow', null, {});
 
		}
	
	}

 

function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {

    var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
    
   // alert("arrData");
    var CSV = '';    
    //Set Report title in first row or line
    
    CSV += ReportTitle + '\r\n\n';

    //This condition will generate the Label/Header
    if (ShowLabel) {
        var row = "";
        
        //This loop will extract the label from 1st index of on array
        for (var index in arrData[0]) {
            
            //Now convert each value to string and comma-seprated
            row += index + ',';
        }

        row = row.slice(0, -1);
        
        //append Label row with line break
        CSV += row + '\r\n';
    }
    
    //1st loop is to extract each row
    for (var i = 0; i < arrData.length; i++) {
        var row = "";
        
        //2nd loop will extract each column and convert it in string comma-seprated
        for (var index in arrData[i]) {
            row += '"' + arrData[i][index] + '",';
        }

        row.slice(0, row.length - 1);
        
        //add a line break after each row
        CSV += row + '\r\n';
    }

    if (CSV == '') {        
        alert("Invalid data");
        return;
    }   
    
    //Generate a file name
    var fileName = "";
    //this will remove the blank-spaces from the title and replace it with an underscore
    fileName += ReportTitle.replace(/ /g,"_");   
    
    //Initialize file format you want csv or xls
    var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
    
    // Now the little tricky part.
    // you can use either>> window.open(uri);
    // but this will not work in some browsers
    // or you will not get the correct file extension    
    
    //this trick will generate a temp <a /> tag
    var link = document.createElement("a");    
    link.href = uri;
    
    //set the visibility hidden so it will not effect on your web-layout
    link.style = "visibility:hidden";
    link.download = fileName + ".csv";
    
    //this part will append the anchor tag and remove it after automatic click
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}




</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 
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
	  <tr><td align="right"><label class="branch">Up To</label></td>
     <td align="left"><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
 <tr><td align="right"> <label class="branch">Type</label></td> <td ><select id="type" onchange="changegrid()">
 <option value="summary">Summary</option>
 <option value="detail">Detail</option>
 
 </select> </td></tr>  
 
  
 <tr><td align="right"><label class="branch">Account</label></td>  
 <td align="left"><input type="text" id="txtaccid" name="txtaccid" style="width:60%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>'  onkeydown="getAccTypeFrom(event);"/></td></tr> 
 <tr><td>&nbsp;</td>
 <td><input type="text" id="txtaccname" name="txtaccname" style="width:100%;height:20px;" readonly="readonly" value='<s:property value="txtaccname"/>' tabindex="-1"/>
    <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/></td></tr>
  <tr>
	<td  align="right"><label class="branch">Deal No</label></td>	<td> <input type="text" id="dealno" readonly="readonly" style="height:20px;width:61%;" placeholder="Press F3 to Search" name="dealno" value='<s:property value="dealno"/>' onkeydown="getdealNo(event);" > </td>
           
	</tr> 
 
 
 
	 <tr><td colspan="2">&nbsp;</td></tr>
 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr>
	 <td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funcleardata()"></td></tr>
      
	<tr>
		 <tr><td colspan="2">&nbsp;</td></tr>
<!--  <tr><td colspan="2">&nbsp;</td></tr -->

	<tr>
	<td colspan="2"><div id='paychaaaaa' style="width: 100% ; align:right; height: 150px;"></div></td>
	</tr>	
	</table>
	</fieldset>
	<input type="hidden" id="cldocno" style="height:20px;width:70%;"  name="cldocno">
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="enqlistdiv" ><jsp:include page="Gridfirst.jsp"></jsp:include></div>
			 
			 
			  
			   <div id="detdivs" hidden="true"><jsp:include page="detailgrid.jsp"></jsp:include></div> 
			 </td>
		</tr>
	</table>
</tr>
</table>

</div>
 
<div id="accountSearchwindow">
   <div ></div>
</div>
<div id="dealnowindow">
   <div ></div>
</div>

 
</div>
</body>
</html>