<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@page import="com.dashboard.analysis.collectionanalysis.ClsCollectionAnalysis"%>
<%ClsCollectionAnalysis DAO= new ClsCollectionAnalysis(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
 	 String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String group=request.getParameter("group")==null?"":request.getParameter("group");
     String distribution=request.getParameter("distribution")==null?"":request.getParameter("distribution");
     String hidclientcat=request.getParameter("hidclientcat")==null?"":request.getParameter("hidclientcat");
     String hidclient=request.getParameter("hidclient")==null?"":request.getParameter("hidclient");
     String hidsalesman=request.getParameter("hidsalesman")==null?"":request.getParameter("hidsalesman");
     String hidbrand=request.getParameter("hidbrand")==null?"":request.getParameter("hidbrand");
     String hidmodel=request.getParameter("hidmodel")==null?"":request.getParameter("hidmodel");
     String hidgroup=request.getParameter("hidgroup")==null?"":request.getParameter("hidgroup");
     String hidyom=request.getParameter("hidyom")==null?"":request.getParameter("hidyom"); 
	 String check = request.getParameter("check")==null?"0":request.getParameter("check");%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<style type="text/css">
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

.myButtons1 {
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
.myButtons1:hover {
	  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons1:active {
  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons1:focus {
  color: #fff;
  background-color: grey;
}
</style>

<script type="text/javascript">

	$(document).ready(function () {
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		   
		 $('#clientSearchWindow').jqxWindow({ width: '62%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' , title: 'Client Search' ,position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
		 $('#clientSearchWindow').jqxWindow('close');
		 
		 $('#clientCategorySearchWindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Client Category Search' ,position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
		 $('#clientCategorySearchWindow').jqxWindow('close');
		
		 $('#salesmanSearchWindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Salesman Search' ,position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
		 $('#salesmanSearchWindow').jqxWindow('close');
		 
		 $('#brandSearchWindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Brand Search' ,position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
		 $('#brandSearchWindow').jqxWindow('close');
		   
		 $('#modelSearchWindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Model Search' ,position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
		 $('#modelSearchWindow').jqxWindow('close');
		   
		 $('#groupSearchWindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Group Search' ,position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
		 $('#groupSearchWindow').jqxWindow('close');
		  
		 $('#yomSearchWindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'YOM Search' ,position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
		 $('#yomSearchWindow').jqxWindow('close');
		
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	 		
	});
	
	function clientSearchContent(url) {
	    $('#clientSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientSearchWindow').jqxWindow('setContent', data);
		$('#clientSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function clientCategorySearchContent(url) {
	    $('#clientCategorySearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientCategorySearchWindow').jqxWindow('setContent', data);
		$('#clientCategorySearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function salesmanSearchContent(url) {
	    $('#salesmanSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#salesmanSearchWindow').jqxWindow('setContent', data);
		$('#salesmanSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function brandSearchContent(url) {
	    $('#brandSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#brandSearchWindow').jqxWindow('setContent', data);
		$('#brandSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function modelSearchContent(url) {
	    $('#modelSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#modelSearchWindow').jqxWindow('setContent', data);
		$('#modelSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function groupSearchContent(url) {
	    $('#groupSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#groupSearchWindow').jqxWindow('setContent', data);
		$('#groupSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function yomSearchContent(url) {
	    $('#yomSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#yomSearchWindow').jqxWindow('setContent', data);
		$('#yomSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function funExportBtn(){
		$("#collectionDiv").load("collectionGrid.jsp?branchval="+$('#cmbbranch').val()+"&fromdate="+$('#fromdate').val()+"&todate="+$('#todate').val()+"&hidclientcat="+$('#hidclientcat').val()+"&hidclient="+$('#hidclient').val()+"&hidsalesman="+$('#hidsalesman').val()+"&hidbrand="+$('#hidbrand').val()+"&hidmodel="+$('#hidmodel').val()+"&hidgroup="+$('#hidgroup').val()+"&hidyom="+$('#hidyom').val()+"&excelexport=EXCEL");
	} 
	
	function getGridColumnCalculation(fromdate,todate){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				 items = items.split('***');
		          var difference=items[0];
		          var columns=items[1];
		          
		          if(parseInt(columns)==1) {
						$.messager.alert('Message','Period is too Long,Limit Reached.','warning');
						return;
		          }else {
		        	  
		        	  var branch = $('#cmbbranch').val();
		     		  var fromdate = $('#fromdate').val();
		     		  var todate = $('#todate').val();
		     		  var group = $('#cmbgroup').val();
		     		  var distribution = $('#cmbdistribution').val();
		     		  var hidclientcat = $('#hidclientcat').val();
		     	      var hidclient = $('#hidclient').val();
		     	      var hidsalesman = $('#hidsalesman').val();
		     	      var hidbrand = $('#hidbrand').val();
		     	      var hidmodel = $('#hidmodel').val();
		     	      var hidgroup = $('#hidgroup').val();
		     	      var hidyom = $('#hidyom').val();
		        	  
		        	  $("#overlay, #PleaseWait").show();
		     		 
		        	  $("#analysisDiv").load("collectionAnalysisGrid.jsp?branchval="+branch+"&fromdate="+fromdate+"&todate="+todate+"&group="+group+"&distribution="+distribution+"&hidclientcat="+hidclientcat+"&hidclient="+hidclient+"&hidsalesman="+hidsalesman+"&hidbrand="+hidbrand+"&hidmodel="+hidmodel+"&hidgroup="+hidgroup+"&hidyom="+hidyom+"&check=2");
		          }
    		}
		}
		x.open("GET", "getGridColumnCalculation.jsp?fromdate="+fromdate+"&todate="+todate, true);
		x.send();
   }
	
	function funreload(event){
		 var branch = $('#cmbbranch').val();
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var group = $('#cmbgroup').val();
		 var hidclientcat = $('#hidclientcat').val();
	     var hidclient = $('#hidclient').val();
	     var hidsalesman = $('#hidsalesman').val();
	     var hidbrand = $('#hidbrand').val();
	     var hidmodel = $('#hidmodel').val();
	     var hidgroup = $('#hidgroup').val();
	     var hidyom = $('#hidyom').val();

	     if(fromdate==todate) {
				$.messager.alert('Message','Not a Valid Period,From Date & To Date are Same.','warning');
				return;
         }

	     if($('#cmbgroup').val()!='' && $('#cmbdistribution').val()==''){
	    		
	    		$("#overlay, #PleaseWait").show();$('#collectionDiv').hide();$('#analysisDiv').show();
	    		
	    		$("#analysisDiv").load("collectionAnalysisGrid.jsp?branchval="+branch+"&fromdate="+fromdate+"&todate="+todate+"&group="+group+"&hidclientcat="+hidclientcat+"&hidclient="+hidclient+"&hidsalesman="+hidsalesman+"&hidbrand="+hidbrand+"&hidmodel="+hidmodel+"&hidgroup="+hidgroup+"&hidyom="+hidyom+"&check=1");
	    		
	    } 
	     
	     else if($('#cmbdistribution').val()!=''){
	    		if($('#cmbdistribution').val()=='quarterwise'){
	    			var d1=$('#fromdate').jqxDateTimeInput('getDate');
	       		 	var d2=$('#todate').jqxDateTimeInput('getDate');
	       		 	months = (d2.getFullYear() - d1.getFullYear()) * 12;
	       		    months -= d1.getMonth() + 1;
	       		    months += d2.getMonth();
	       		    months=months <= 0 ? 0 : months;
	       		    
	       		    if(months<3){
	       		    	$.messager.alert('Message','Quarterwise Must Contain Minimum 3 Months.','warning');
	       		    	return false;
	       		    }
	    		}
	    		
	    		$("#overlay, #PleaseWait").show();$('#collectionDiv').hide();$('#analysisDiv').show();
	    		
	    		getGridColumnCalculation(fromdate,todate);
	    		
	    		//$("#analysisDiv").load("collectionAnalysisGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&grpby1="+grpby1+"&distribution="+cmbfrequency+"&check=1&hidbrand="+hidbrand+"&hidmodel="+hidmodel+"&hidgroup="+hidgroup+"&hidyom="+hidyom+"&hidclientcat="+hidclientcat+"&hidclient="+hidclient+"&hidsalesman="+hidsalesman+"&hidrentalagent="+hidrentalagent);
	    	 }
	    	 else{
	    		 $("#overlay, #PleaseWait").show();$('#collectionDiv').show();$('#analysisDiv').hide();
	    		 
	    		 $("#collectionDiv").load("collectionGrid.jsp?branchval="+branch+"&fromdate="+fromdate+"&todate="+todate+"&hidclientcat="+hidclientcat+"&hidclient="+hidclient+"&hidsalesman="+hidsalesman+"&hidbrand="+hidbrand+"&hidmodel="+hidmodel+"&hidgroup="+hidgroup+"&hidyom="+hidyom);	 
	    	 }
	}
	
	function getClient(){
	 	 clientSearchContent('clientSearch.jsp');
	}

	function getClientCategory(){
		 clientCategorySearchContent('clientCategorySearch.jsp?id=1');
	}
	
	function getClientSalesman(){
		salesmanSearchContent('clientSalesManSearch.jsp?id=2');
	}

	function getBrand(){
		brandSearchContent('brandSearch.jsp?id=1');
	}

	function getModel(){
		modelSearchContent('modelSearch.jsp?id=1');
	}

	function getGroup(event){
		 groupSearchContent('groupSearch.jsp?id=1');
	}
	
	function getYom(event){
		 yomSearchContent('yomSearch.jsp?id=1');
	}
	
	function setSearch(){
		var value=$('#searchby').val().trim();
		
		if(value=="clientcat"){
			getClientCategory();
		}
		else if(value=="client"){
			getClient();
		}
		else if(value=="salesman"){
			getClientSalesman();
		}
		else if(value=="brand"){
			getBrand();
		}
		else if(value=="model"){
			getModel();
		}
		else if(value=="group"){
			getGroup();
		}
		else if(value=="yom"){
			getYom();
		}
		else{}
	}
	
	function setRemove(){
		var value=$('#searchby').val().trim();
		
		if(value=="clientcat"){
			document.getElementById("searchdetails").value="";document.getElementById("clientcat").value="";document.getElementById("hidclientcat").value="";
			
			document.getElementById("searchdetails").value=document.getElementById("client").value;
			
			if(document.getElementById("salesman").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("salesman").value;	
			}
			/* if(document.getElementById("brand").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("brand").value;	
			}
			if(document.getElementById("model").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("model").value;	
			}
			if(document.getElementById("group").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
			}
			if(document.getElementById("yom").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
			} */
			
		}
		else if(value=="client"){
			document.getElementById("searchdetails").value="";document.getElementById("client").value="";document.getElementById("hidclient").value="";
			
			document.getElementById("searchdetails").value=document.getElementById("clientcat").value;
			
			if(document.getElementById("salesman").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("salesman").value;	
			}
			/* if(document.getElementById("brand").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("brand").value;	
			}
			if(document.getElementById("model").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("model").value;	
			}
			if(document.getElementById("group").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
			}
			if(document.getElementById("yom").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
			} */		
		}
		else if(value=="salesman"){
			document.getElementById("searchdetails").value="";document.getElementById("salesman").value="";document.getElementById("hidsalesman").value="";

			document.getElementById("searchdetails").value=document.getElementById("clientcat").value;
			
			if(document.getElementById("client").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("client").value;	
			}
			/* if(document.getElementById("brand").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("brand").value;	
			}
			if(document.getElementById("model").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("model").value;	
			}
			if(document.getElementById("group").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
			}
			if(document.getElementById("yom").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
			}*/	
		}
		/* else if(value=="brand"){
			document.getElementById("searchdetails").value="";document.getElementById("brand").value="";document.getElementById("hidbrand").value="";
			
			document.getElementById("searchdetails").value=document.getElementById("clientcat").value;
			
			if(document.getElementById("client").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("client").value;	
			}
			if(document.getElementById("salesman").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("salesman").value;	
			}
			if(document.getElementById("model").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("model").value;	
			}
			if(document.getElementById("group").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
			}
			if(document.getElementById("yom").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
			}
		}
		else if(value=="model"){
			document.getElementById("searchdetails").value="";document.getElementById("model").value="";document.getElementById("hidmodel").value="";
			
			document.getElementById("searchdetails").value=document.getElementById("clientcat").value;
			
			if(document.getElementById("client").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("client").value;	
			}
			if(document.getElementById("salesman").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("salesman").value;	
			}
			if(document.getElementById("brand").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("brand").value;	
			}
			if(document.getElementById("group").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
			}
			if(document.getElementById("yom").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
			}
		}
		else if(value=="group"){
			document.getElementById("searchdetails").value="";document.getElementById("group").value="";document.getElementById("hidgroup").value="";
			
			document.getElementById("searchdetails").value=document.getElementById("clientcat").value;
			
			if(document.getElementById("client").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("client").value;	
			}
			if(document.getElementById("salesman").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("salesman").value;	
			}
			if(document.getElementById("brand").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("brand").value;	
			}
			if(document.getElementById("model").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("model").value;	
			}
			if(document.getElementById("yom").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
			}
		}
		else if(value=="yom"){
			document.getElementById("searchdetails").value="";document.getElementById("yom").value="";document.getElementById("hidyom").value="";
			
			document.getElementById("searchdetails").value=document.getElementById("clientcat").value;
			
			if(document.getElementById("client").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("client").value;	
			}
			if(document.getElementById("salesman").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("salesman").value;	
			}
			if(document.getElementById("brand").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("brand").value;	
			}
			if(document.getElementById("model").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("model").value;	
			}
			if(document.getElementById("group").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
			}
		} */
	}
	
	function funClearData(){
		$('#cmbbranch').val('a');
   	    $('#fromdate').val(new Date());
   	    var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	    var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	    var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	    $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		$('#todate').val(new Date());
		  
		document.getElementById("searchdetails").value="";document.getElementById("searchby").value="";document.getElementById("clientcat").value="";
		document.getElementById("hidclientcat").value="";document.getElementById("client").value="";document.getElementById("hidclient").value="";
		document.getElementById("group").value="";document.getElementById("hidgroup").value="";document.getElementById("model").value="";
		document.getElementById("hidmodel").value="";document.getElementById("salesman").value="";document.getElementById("hidsalesman").value="";
		document.getElementById("yom").value="";document.getElementById("hidyom").value="";document.getElementById("brand").value="";
		document.getElementById("hidbrand").value="";
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
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr>
	 <td align="right"><label class="branch">From</label></td>
     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr>
	<td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr>  
	<tr><td align="right"><label class="branch">Grouping</label></td>
	<td><select name="cmbgroup" id="cmbgroup"><option value="">--Select--</option><option value="clientcat">Client Category</option>
    <option value="client">Client</option><option value="salesman">Salesman</option><!-- <option value="brand">Brand</option>
    <option value="model">Model</option><option value="group">Group</option><option value="yom">YOM</option> -->
    </select></td></tr>  
    <tr><td align="right"><label class="branch">Distribution</label></td>
    <td><select name="cmbdistribution" id="cmbdistribution">
    <option value="">--Select--</option><option value="1">Branchwise</option><option value="2">Monthwise</option>
    <option value="3">Quarterwise</option><option value="4">Yearwise</option><option value="5">Client Category</option>
    <option value="6">Salesman</option><!-- <option value="7">Brand</option><option value="8">Model</option>
    <option value="9">Group</option><option value="10">YOM</option> -->
    </select></td></tr>
	<tr><td colspan="2">
	<table width="100%">
	  <tr>
	    <td align="right"><label class="branch">Search by</label></td>
	    <td align="left"><select name="searchby" id="searchby"><option value="">--Select--</option>
		<option value="client">Client</option><option value="clientcat">Client Category</option>
		<option value="salesman">Salesman</option><!-- <option value="brand">Brand</option><option value="model">Model</option>
		<option value="group">Group</option><option value="yom">YOM</option> --></select></td>
	    <td><button type="button" name="btnadditem" id="additem" class="myButtons1" onClick="setSearch();">+</button></td>
	    <td><button type="button" name="btnremoveitem" id="btnremoveitem" class="myButtons1" onclick="setRemove();">-</button></td>
	  </tr>
	  <tr>
	    <td colspan="4" align="center"><textarea id="searchdetails" style="height:140px;width:230px;font: 10px Tahoma;resize:none" name="searchdetails" readonly="readonly"><s:property value="searchdetails"></s:property></textarea>
	    </td>
	  </tr>
	</table></td></tr>
	<tr><td colspan="2"><center><input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();"></center></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2"><input type="hidden" name="clientcat" id="clientcat"><input type="hidden" name="hidclientcat" id="hidclientcat">
			  <input type="hidden" name="client" id="client"><input type="hidden" name="hidclient" id="hidclient">
			  <input type="hidden" name="group" id="group"><input type="hidden" name="hidgroup" id="hidgroup">
			  <input type="hidden" name="model" id="model"><input type="hidden" name="hidmodel" id="hidmodel">
			  <input type="hidden" name="salesman" id="salesman"><input type="hidden" name="hidsalesman" id="hidsalesman">
			  <input type="hidden" name="yom" id="yom"><input type="hidden" name="hidyom" id="hidyom">
			  <input type="hidden" name="brand" id="brand"><input type="hidden" name="hidbrand" id="hidbrand"></td></tr>  
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="collectionDiv"><jsp:include page="collectionGrid.jsp"></jsp:include></div>
			    <div id="analysisDiv" hidden="true"><jsp:include page="collectionAnalysisGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>

<div id="clientSearchWindow">
	<div></div><div></div>
</div>
<div id="clientCategorySearchWindow">
	<div></div><div></div>
</div>
<div id="salesmanSearchWindow">
	<div></div><div></div>
</div>
<div id="brandSearchWindow">
	<div></div><div></div>
</div>
<div id="modelSearchWindow">
	<div></div><div></div>
</div>
<div id="groupSearchWindow">
	<div></div><div></div>
</div>
<div id="yomSearchWindow">
	<div></div><div></div>
</div>
</div>
</body>
</html>