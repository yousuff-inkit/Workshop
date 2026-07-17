 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"> 
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<script type="text/javascript">
$(document).ready(function() {
    var otherdetailconfig = $('#otherdetailsconfig').val(); 
	if(parseInt(otherdetailconfig)==1){
		 $('#prntdiv').show();
	}else{
		 $('#prntdiv').hide();
	}  
});

 function funWithJobDetailsPrint(){
 			var url=document.URL;
 			var reurl=url.split("com/");
 			var gatedocno=$('#lblgipno').val();
 			var estdocno=$('#estdocno').val();
 			var printchk=$('#printchk').val();
            var jobdet=1; 
 			var path= "com/workshop/wsjobcardpal/WSJobCardPrintPalAction1?docno="+$('#docno').val()+"&gatedocno="+gatedocno+"&estdocno="+estdocno+"&branch="+$('#brchName').val()+"&refno="+$('#hidrefno').val()+"&jobdet="+jobdet+"&printchk="+printchk;  
 			var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");		
 			win.focus();	
 	}    

 	function funWithoutJobDetailsPrint(){ 
 		    var gridarray=new Array();
 		    var otherdetailconfig = $('#otherdetailsconfig').val(); 
 			if(parseInt(otherdetailconfig)==1){
			    var rows=$("#printdataGrid").jqxGrid('getrows');
			    for(var i=0;i<rows.length;i++){
			    	var chk=$("#printdataGrid").jqxGrid('getcellvalue',i,'pdata');    
			    	if(typeof(chk)!="undefined" && typeof(chk)!="NaN" && chk!=""){
			    		gridarray.push(rows[i].pdata);     
			    	}
			    }
		    }     
			var url=document.URL;
			var reurl=url.split("com/");
			var gatedocno=$('#lblgipno').val();
			var estdocno=$('#estdocno').val(); 
			var jobdet=0;
			var path= "com/workshop/wsjobcardpal/WSJobCardPrintPalAction1?docno="+$('#docno').val()+"&gatedocno="+gatedocno+"&estdocno="+estdocno+"&branch="+$('#brchName').val()+"&refno="+$('#hidrefno').val()+"&jobdet="+jobdet+"&detailarray="+encodeURIComponent(gridarray)+"&otherdetailconfig="+otherdetailconfig;  
			var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");		
			win.focus();	
	}
</script>

<body>
<div id=search>
<br/>
<table width="100%">  
 <tr>
	  <td colspan="2"><div id="prntdiv"><jsp:include page="printdetailsGrid.jsp"></jsp:include></div></td>
 </tr>
<tr>
<td align="center" colspan="2">Additional Estimation<select name="printchk" id="printchk" value='<s:property value="printchk"/>'>
           
            <option value=a>All</option>
            <option value=0>0</option>
            <option value=1>1</option>
            <option value=2>2</option>
            <option value=3>3</option>
            <option value=4>4</option>
            <option value=5>5</option>
           
        </select></td>
</tr>
  <tr>
    <td align="center"><input type="button" name="btnjobdetails" id="btnjobdetails" class="myButton" value="With Job Details"  onclick="funWithJobDetailsPrint();"></td>
    <td align="center"><input type="button" name="btnwithoutjobdetails" id="btnwithoutjobdetails" class="myButton" value="Without Job Details"  onclick="funWithoutJobDetailsPrint()"></td>
  </tr>
</table>
<br/><br/><br/><br/><br/><br/>
  </div>
</body>
</html>