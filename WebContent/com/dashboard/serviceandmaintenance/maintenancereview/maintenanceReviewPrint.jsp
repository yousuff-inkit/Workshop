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

<style type="text/css">
.tablereceipt {
    border: 1px solid black;
    border-collapse: collapse;
}

fieldSet {
  		-webkit-border-radius: 8px;
  		-moz-border-radius: 8px;
  		border-radius: 8px;
  		border: 1px solid rgb(139,136,120);
  }

legend{
        border-style:none;
        background-color:#FFF;
        padding-left:1px;
    }
    
hr { 
   		border-top: 1px solid #e1e2df  ;
    }

.verticalLine {
    border-left: 1px solid black;
}

</style>

<script type="text/javascript">

	function hidedata(){
		
		var first=document.getElementById("firstarray").value;
		var sec=document.getElementById("secarray").value;
		
		if(parseInt(first)==1){
			   $("#firstdiv").prop("hidden", false);
			} else{
				$("#firstdiv").prop("hidden", true);
			}
		
		if(parseInt(sec)==2){
			  $("#secdiv").prop("hidden", false);
		}
		else{
			 $("#secdiv").prop("hidden", true);
			}
		
		}

</script>

</head>
<body bgcolor="white" style="font-size:10px;" onload="hidedata();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmMaintanenceReview" action="printMaintanenceReview" method="post" autocomplete="off" target="_blank">

<div style="background-color:white;">

<jsp:include page="../../../common/printHeader.jsp"></jsp:include>

<fieldset>
<table width="95%">
  <tr>
    <td width="12%"><b>Fleet</b></td>
    <td width="18%"><b><font size="1">: 
<label id="lblfleetno" name="lblfleetno"><s:property value="lblfleetno"/></label></font></b></td>
    <td colspan="4"><b><font size="1">
<label id="lblfleetname" name="lblfleetname"><s:property value="lblfleetname"/></label></font></b></td>
  </tr>
  <tr>
    <td><b>Reg. No.</b></td>
    <td>: <label id="lblfleetregno" name="lblfleetregno"><s:property value="lblfleetregno"/></label></td>
    <td width="15%"><b>Authority</b></td>
    <td width="29%">: <label id="lblfleetauthority" name="lblfleetauthority"><s:property value="lblfleetauthority"/></label></td>
    <td width="10%"><b>YOM</b></td>
    <td width="16%">: <label id="lblfleetyom" name="lblfleetyom"><s:property value="lblfleetyom"/></label></td>
  </tr>
  <tr>
    <td><b>Color</b></td>
    <td>: <label id="lblfleetcolor" name="lblfleetcolor"><s:property value="lblfleetcolor"/></label></td>
    <td><b>Engine No.</b></td>
    <td>: <label id="lblfleetengineno" name="lblfleetengineno"><s:property value="lblfleetengineno"/></label></td>
    <td><b>Chassis No.</b></td>
    <td>: <label id="lblfleetchassisno" name="lblfleetchassisno"><s:property value="lblfleetchassisno"/></label></td>
  </tr>
</table>
</fieldset><br/>

<div id="firstdiv" hidden="true">
<table id="accident" width="95%" class="tablereceipt" align="center">
<thead>
  <tr><th colspan="11" height="28" style="background-color: #F6CECE;"><b>Accident History</b></th></tr>
  
  <tr height="28" style="background-color: #D8D8D8;" class="tablereceipt" align="center">
    <th class="tablereceipt" width="4%" align="center">Sr.No</th>
    <th class="tablereceipt" width="10%" align="center">Date</th>
    <th class="tablereceipt" width="10%" align="center">Police Report</th>
    <th class="tablereceipt" width="10%" align="center">Collection Date</th>
    <th class="tablereceipt" width="12%" align="left">Place</th>
    <th class="tablereceipt" width="12%" align="right">Fines</th>
    <th class="tablereceipt" width="10%" align="left">Claim</th>
    <th class="tablereceipt" width="32%" align="left">Remarks</th>
  </tr>
</thead>
<tbody>
  <%int i=0,l=0; %>
  <s:iterator var="stat" value='#request.printaccidentsarray' >
  <%l=l+1;i=0;%>
	<tr height="25" class=tablereceipt> 
	    <td class="tablereceipt" width="4%" align="center"><%=l%></td>
    	<s:iterator status="arr" value="#stat.split('::')" var="des">
    	
    	<%i=i+1;%>
    	<% if(i==1){%>
    	<td class=tablereceipt width="10%" align="center">
		    <s:property value="#des"/>
    	</td>
    	<%} else if(i==2){%>
    	<td class=tablereceipt width="10%" align="center">
		    <s:property value="#des"/>
    	</td>
    	
    	<%} else if(i==3){%>
    	<td class=tablereceipt width="10%" align="center">
		    <s:property value="#des"/>
    	</td>
    	
    	<%}else if(i==4){%>
    	<td class=tablereceipt width="12%" align="left">
		    <s:property value="#des"/>
    	</td> 
    	<%}else if(i==5){%>
    	<td class=tablereceipt width="12%" align="right">
		    <s:property value="#des"/>
    	</td>
  	    <%}else if(i==6){%>
    	<td class=tablereceipt width="10%" align="left">
		    <s:property value="#des"/>
    	</td>
    	<%}else if(i==7){%>
    	<td class=tablereceipt width="32%" align="left">
		    <s:property value="#des"/>
    	</td>
   		<%} else{ %>
  		<td class=tablereceipt width="2%" align="center">
		  <s:property value="#des"/>
  		</td>
  		<% } %>
 		</s:iterator>
	</tr>
	</s:iterator>
	</tbody>
</table><br/>
</div>
<div id="secdiv" hidden="true" > 
<table id="service" width="95%" class="tablereceipt" align="center">
<thead>
  <tr><th colspan="11" height="28" style="background-color: #F6CECE;"><b>Service History</b></th></tr>
  
  <tr height="28" style="background-color: #D8D8D8;" class="tablereceipt" align="center">
    <th class="tablereceipt" width="4%" align="center">Sr.No</th>
    <th class="tablereceipt" width="7%" align="center">Date</th>
    <th class="tablereceipt" width="10%" align="center">Type</th>
    <th class="tablereceipt" width="7%" align="center">Service KM</th>
    <!-- <th class="tablereceipt" width="8%" align="center">Next KM</th> -->
    <th class="tablereceipt" width="9%" align="center">Garage</th>
    <th class="tablereceipt" width="10%" align="center">Type</th>
    <th class="tablereceipt" width="15%" align="left">Description</th>
    <th class="tablereceipt" width="19%" align="left">Remarks</th>
    <th class="tablereceipt" width="7%" align="right">Labor Cost</th>
    <th class="tablereceipt" width="7%" align="right">Parts Cost</th>
    <th class="tablereceipt" width="7%" align="right">Total</th>
  </tr>
  </thead>
  <tbody>
  <%int j=0,k=0; %>
  <s:iterator var="stat" value='#request.printservicesarray' >
  <%j=0;k=k+1;%>
	<tr height="25" class=tablereceipt>   
	    <td class="tablereceipt" width="4%" align="center"><%=k%></td>
    	<s:iterator status="arr" value="#stat.split('::')" var="des">
    	<%j=j+1;%>
    	<% if(j==1){%>
    	<td class=tablereceipt width="7%" align="center">
		    <s:property value="#des"/>
    	</td>
        <%} else if(j==2){%>
    	<td class=tablereceipt width="10%" align="center">
		    <s:property value="#des"/>
    	</td>
    	
    	<%} else if(j==3){%>
    	<td class=tablereceipt width="7%" align="center">
		    <s:property value="#des"/>
    	</td> 
       	<%}else if(j==4){%>
    	<td class=tablereceipt width="9%" align="center">
		    <s:property value="#des"/>
    	</td>
     	<%}else if(j==5){%>
    	<td class=tablereceipt width="10%" align="center">
		    <s:property value="#des"/>
    	</td>
    	<%}else if(j==6){%>
    	<td class=tablereceipt width="15%" align="left">
		    <s:property value="#des"/>
    	</td>
    	<%}else if(j==7){%>
    	<td class=tablereceipt width="19%" align="left">
		    <s:property value="#des"/>
    	</td>
    	<%}else if(j==8){%>
    	<td class=tablereceipt width="7%" align="right">
		    <s:property value="#des"/>
    	</td>
    	<%}else if(j==9){%>
    	<td class=tablereceipt width="7%" align="right">
		    <s:property value="#des"/>
    	</td>
    	<%}else if(j==10){%>
    	<td class=tablereceipt width="7%" align="right">
		    <s:property value="#des"/>
    	</td>
   		<%} else{ %>
  		<td class=tablereceipt  width="2%" align="center">
		  <s:property value="#des"/>
  		</td>
  		<% } %>
 		</s:iterator>
 		
	</tr>
	</s:iterator>
	</tbody>
</table><br/>
</div>

<br/>

<table width="100%">
 <tr>
     <td colspan="3" align="center"><fieldset><font style="color: #D8D8D8;font-size: 11px;">System Generated Document Signature & Stamp Not Required.</font></fieldset></td>
  </tr>
  <tr>
  <td width="47%" style="color: #D8D8D8;" align="left"><i>Printed by <%=session.getAttribute("USERNAME")%> 
  <label id="lblfooter"></label></i></td>
  
  <td width="43%" style="color: #FAFAFA;" align="left">Powered by GATEWAY ERP</td>
  
 <td width="10%" style="color: #D8D8D8;">
    <div id="content"> 
  <div id="pageFooter"></div>
   </div>  
  </td>
  </tr>
</table>

<input type="hidden" id="firstarray" name="firstarray" value='<s:property value="firstarray"/>'>  
<input type="hidden" id="secarray" name="secarray" value='<s:property value="secarray"/>'>
</div>
</form>
</div>
</body>
</html>