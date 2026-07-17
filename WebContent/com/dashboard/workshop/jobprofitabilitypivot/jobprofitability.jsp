<jsp:include page="../../../../reportincludes.jsp"></jsp:include>                  
<%@ taglib prefix="s" uri="/struts-tags" %>
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
</style>


<script type="text/javascript">

	$(document).ready(function () {  
		     $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	         $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		     $("#fromdate").jqxDateTimeInput({ width: '125px', height: '20px',formatString:"dd.MM.yyyy"});
		     $("#todate").jqxDateTimeInput({ width: '125px', height: '20px',formatString:"dd.MM.yyyy"});
		     var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
		     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
		     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
		     $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate)); 
		 	});
	
	 $(function() {
	      $("#btnSubmit").click(function(evt) {
	    	  var fromdate = $('#fromdate').val();
	 		  var todate = $('#todate').val(); 
	 		  $("#overlay, #PleaseWait").show();
	    	  $("#leadDiv").load("jobprofitabilityGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1");
	          evt.preventDefault();                 
	      })
	    })  
	     
	function funExportBtn(){        
			 JSONToCSVCon(data,'Job profitability',true);   
	}
	 function JSONToCSVCon(JSONData, ReportTitle, ShowLabel) {


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
		    
			 // newly added 
		    var temp = CSV;
		    blob = new Blob([temp],{type: 'text/csv'});
		    var bigcsv= window.webkitURL.createObjectURL(blob);
		   
			
		    //Initialize file format you want csv or xls
		  //  var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
		    
		    // Now the little tricky part.
		    // you can use either>> window.open(uri);
		    // but this will not work in some browsers
		    // or you will not get the correct file extension    
		    
		    //this trick will generate a temp <a /> tag
		    var link = document.createElement("a");    
		     //  link.href = uri;
		      link.href = bigcsv;
		    
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
<body >
<div id="mainBG" class="homeContent" data-type="background">   
 <table>
        <tr>
            <td width="20%">
            <table width="100%" >
	 <tr>
	 <td>Inv From</td>   
     <td><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>' ></div></td></tr> 
	<tr>
	<td >Inv To</td>        
    <td><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr>
   <tr><td align="center"><button type="button" class="myButtons" id="btnExcel" title="Export current Document to Excel" onclick="funExportBtn();">Excel</button></td><td align="center"><button type="button" class="myButtons" id="btnSubmit" title="Submit" >Submit</button></td></tr> 
  <tr>  
	 <td align="right" colspan="2"> <div id="divPivotGridDesigner" style="height: 490px; width: 250px;"></div></td></tr>
                 </table>
            </td>   
            <td width="80%">    
                <div id="leadDiv" style="height:540px; width: 1090px;"><jsp:include page="jobprofitabilityGrid.jsp"></jsp:include>   
                </div>  
            </td>
        </tr>
    </table>
</div>
</body>
</html>