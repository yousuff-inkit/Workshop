 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/body.css" media="screen" rel="stylesheet" type="text/css" />
<style>
.formfont {
	font: 10px Tahoma;
	color: #404040;
	background: #E0ECF8;
	overflow:hidden;
}
</style>


	<script type="text/javascript">
	$(document).ready(function () {
		 $( "#btnok_agmt" ).click(function() {
	  	   
	        	var rows = $("#agmtsearch").jqxGrid('selectedrowindexes');
	        if(rows!=""){
	     	 	if(document.getElementById("searchdetails").value==""){
		           		document.getElementById("searchdetails").value="Agreement";	
		           		document.getElementById("agmtno").value="Agreement";
		           	}
		           	else{
		           		document.getElementById("searchdetails").value+="\n\nAgreement";
		           		document.getElementById("agmtno").value+="\nAgreement";
		           	}
	        }
	       
	        	
	        	document.getElementById("hidagmtno").value="";
	        	
	        	for(var i=0;i<rows.length;i++){
	        		var dummy=$('#agmtsearch').jqxGrid('getcellvalue',rows[i],'voc_no');
	        		var docno=$('#agmtsearch').jqxGrid('getcellvalue',rows[i],'doc_no');
	        		document.getElementById("searchdetails").value+="\n"+dummy;
	        		document.getElementById("agmtno").value+="\n"+dummy;
	        		if(i==0){
	        			document.getElementById("hidagmtno").value=docno;
	        		}
	        		else{
	        			document.getElementById("hidagmtno").value+=","+docno;
	        		}
	        	}
	        	$('#agmtnowindow').jqxWindow('close');
		});


	$( "#btncancel_agmt" ).click(function() {
			$('#agmtnowindow').jqxWindow('close');
		});
		

	}); 

 	function mainloadSearch() {
 		
 		var sclnames="";
 		var smob=document.getElementById("Sl_mob").value;
 		var rno=document.getElementById("rno").value;
 		var flno=document.getElementById("flno").value;
 		var sregno=document.getElementById("sregno").value;
 		var smra=document.getElementById("smra").value;
	
 		var sclname = sclnames.replace(/ /g, "%20");
 		
 		var branch_chk=document.getElementById("branch_chk").value;
 		
		getdata(sclname,smob,rno,flno,sregno,smra,branch_chk);
		
		

	}
	 function getdata(sclname,smob,rno,flno,sregno,smra,branch_chk){
		 var branch='<%=request.getParameter("branch")==null?"":request.getParameter("branch")%>';
		 var agmttype='<%=request.getParameter("agmttype")==null?"":request.getParameter("agmttype")%>';
		 var agmtstatus='<%=request.getParameter("agmtstatus")==null?"":request.getParameter("agmtstatus")%>';
		 var agmtfromdate='<%=request.getParameter("agmtfromdate")==null?"":request.getParameter("agmtfromdate")%>';
		 var agmttodate='<%=request.getParameter("agmttodate")==null?"":request.getParameter("agmttodate")%>';
		 $("#overlay, #PleaseWait").show();
		 $("#srefreshdiv").load('agmtSearch.jsp?sclname='+sclname+'&smob='+smob+'&rno='+rno+'&flno='+flno+'&sregno='+sregno+'&smra='+smra+'&branch_chk='+branch_chk+'&branch='+branch+'&agmttype='+agmttype+'&agmtstatus='+agmtstatus+'&agmtfromdate='+agmtfromdate+'&agmttodate='+agmttodate+'&id=1');
		 
		}
 
	</script>
<body bgcolor="#E0ECF8">
<div id="search">
     <table  width="100%"  >
    <tr>
         <td align="right" width="188"><span class="formfont">Doc NO</span></td>
    <td width="216" align="left"><input type="text" name="rno" id="rno" value='<s:property value="rno"/>' style="height:18px;"></td>
    <td width="120" align="right"><span class="formfont">Fleet NO</span></td>
    <td width="233" align="left"><input type="text" name="flno" id="flno" value='<s:property value="flno"/>' style="height:18px;"></td>
    <td width="116" align="right"><span class="formfont">MOB</span></td>
    <td width="126" align="left"><input type="text" name="Sl_mob" id="Sl_mob" value='<s:property value="Sl_mob"/>' style="height:18px;"></td>
      <td width="131" align="right"><input style="vertical-align:middle;" type="checkbox" id="branch_chk"  name="branch_chk" value="0" onClick="$(this).attr('value', this.checked ? 1 : 0)" >
<span class="formfont">All Branch</span> &nbsp;</td>
      <td width="131" align="right">&nbsp;</td>


    </tr>
    <tr>
      <td align="right"><span class="formfont">MRA</span></td>
      <td align="left"><input type="text" id="smra" name="smra" value='<s:property value="smra"/>' style="height:18px;"></td>
      <td align="right"><span class="formfont">Reg NO</span></td>
      <td align="left"><input type="text" id="sregno" name="sregno" value='<s:property value="sregno"/>' style="height:18px;"></td>
      <td colspan="3" align="center"><input type="button" name="mbtnrasearch" id="mbtnrasearch" class="myButton" value="Search"  onClick="mainloadSearch();">
      &nbsp;&nbsp;<input type="button" name="btnok_agmt" id="btnok_agmt" class="myButton" value="Ok" >&nbsp;&nbsp;
      <input type="button" name="btncancel_agmt" id="btncancel_agmt" class="myButton" value="Cancel"></td>
      <td align="right">&nbsp;</td>
    
    </tr>
    <tr>
      <td colspan="13" align="right"><div id="srefreshdiv">
      
   <jsp:include  page="agmtSearch.jsp"></jsp:include> 
   
   </div></td>
      </tr>
  </table>
</div>
</body>
</html>