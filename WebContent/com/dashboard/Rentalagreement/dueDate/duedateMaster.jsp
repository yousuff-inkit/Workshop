
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
	
	 $("#dateDue").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#timeDue").jqxDateTimeInput({  width: '20%', height: '17px', formatString: 'HH:mm', showCalendarButton: false });
	 
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");


	 
	 $("#duegridDate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	 $('#dateDue').on('change', function (event) {
			
		   var indate1=new Date($('#duegridDate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var agmtdate1=new Date($('#dateDue').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(indate1>agmtdate1){
			   
			   $.messager.alert('Message','Date Cannot Be Less Than Due Date  ','warning');   
			 
		   return false;
		  }   
	 });
});

function funExportBtn(){
    

	   JSONToCSVConvertor(duedateexcel, 'Due Date List', true);
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
	   $("#overlay, #PleaseWait").show();
	  $("#duedatediv").load("duedateGrid.jsp?barchval="+barchval);
	
	
	}
	


function funchangeinfo()
{
  if($('#cmbinfo').val()==1)
	  {
	 
	 $('#dateDue').jqxDateTimeInput({ disabled: false});
	 $('#timeDue').jqxDateTimeInput({ disabled: true});
		$('#dateDue').jqxDateTimeInput('focus'); 
	 
	  }
  else if($('#cmbinfo').val()==2)
  {
 
 $('#dateDue').jqxDateTimeInput({ disabled: false});
 $('#timeDue').jqxDateTimeInput({ disabled: true});
	$('#dateDue').jqxDateTimeInput('focus'); 
  }
  else if($('#cmbinfo').val()==3)
  {
 
 $('#dateDue').jqxDateTimeInput({ disabled: true});
 $('#timeDue').jqxDateTimeInput({ disabled: true});
 document.getElementById("remarks").focus();
 
  }
	 
	
	}
function disitems()
{
	
	 $('#dateDue').jqxDateTimeInput({ disabled: true});
	 $('#timeDue').jqxDateTimeInput({ disabled: true});
	 
	 
	 $('#cmbinfo').attr("disabled",true);
	 $('#remarks').attr("readonly",true);
	 $('#driverUpdate').attr("disabled",true);
	

	
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
		 
		 
		
		 var rentaldocno = document.getElementById("rentaldoc").value;
		 var branchids = document.getElementById("branchids").value;
		 var remarks = document.getElementById("remarks").value;
		 var cmbinfo = document.getElementById("cmbinfo").value;
		 var exdate =  $('#dateDue').val();
		 var extime =  $('#timeDue').val();
		 var duedategd =  $('#duegridDate').val();
		 if($('#cmbinfo').val()!=3)
		  {
		 var indate1=new Date($('#duegridDate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var agmtdate1=new Date($('#dateDue').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(indate1>agmtdate1){
			   
			   $.messager.alert('Message',' Date Cannot Be Less Than Due Date ','warning');      
			  
		   return false;
		  }   
		  }

		    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
		     	  
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		 savegriddata(rentaldocno,branchids,remarks,cmbinfo,exdate,extime,duedategd);	
		     	}
			     });
		
		
		
	}
	function savegriddata(rentaldocno,branchids,remarks,cmbinfo,exdate,extime,duedategd)
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
				  $('#dateDue').val(new Date());
				  $('#timeDue').val(new Date());
				  $('#duegridDate').val("");
				
				 $.messager.alert('Message', '  Record Successfully Updated ', function(r){
			 		 
			 		 
				     
			     });
				 funreload(event); 
				 $("#duedetailsgrid").jqxGrid('clear');
				 disitems();
				 
				
				}
			
		}
			
	x.open("GET","saveduedate.jsp?rentaldocno="+rentaldocno+"&branchids="+branchids+"&remarks="+remarks+"&cmbinfo="+cmbinfo+"&exdate="+exdate+"&extime="+extime+"&duedategd="+duedategd,true);

	x.send();
			
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

	<tr><td  align="right" ><label class="branch">Date</label></td><td align="left"><div id='dateDue' name='dateDue' value='<s:property value="dateDue"/>'></div>
                   </td></tr>
  <tr><td  align="right"><label class="branch">Time</label></td><td align="left" ><div id='timeDue' name='timeDue' value='<s:property value="timeDue"/>'  ></div>
                </td></tr>
	 <tr><td align="right"><label class="branch">Remarks </label></td><td align="left"><input type="text" id="remarks" style="height:20px;width:88%;" name="remarks"  value='<s:property value="remarks"/>'> </td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	<tr><td  align="center" colspan="2"><input type="Button" name="driverUpdate" id="driverUpdate" class="myButton" value="UPDATE" onclick="funupdate()"></td> </tr>
	
	 <tr><td colspan="2">&nbsp;</td></tr>  
 
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>	
	 <tr><td colspan="2">&nbsp;</td></tr>
	 	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>	
	 <tr><td colspan="2">&nbsp;</td></tr>

	 	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>	
	 <tr><td colspan="2">&nbsp;</td></tr>




  </table>
   <input type="hidden" name="branchids" id="branchids" style="height:20px;width:70%;" value='<s:property value="branchids"/>' >
 <input type="hidden" name="rentaldoc" id="rentaldoc" style="height:20px;width:70%;" value='<s:property value="rentaldoc"/>' >
<div hidden="true" id='duegridDate' name='duegridDate' value='<s:property value="duegridDate"/>'></div>	 
	 
   </fieldset>

</td>
<td width="80%">
	<table width="100%">
		<tr>
			  <td><div id="duedatediv"><jsp:include page="duedateGrid.jsp"></jsp:include></div><br>
			  </td> 
		</tr>
		
		<tr>
		<td colspan="2" align="left" ><div id="detaildiv"><jsp:include page="detailgrid.jsp"></jsp:include></div></td></tr>
	</table>
</tr>
</table>
</div>
</div>
</body>
