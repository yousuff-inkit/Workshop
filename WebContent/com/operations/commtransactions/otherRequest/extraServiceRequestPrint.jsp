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
    border: 1px solid rgb(139,136,120);
    border-collapse: collapse;
}
 fieldSet {
  -webkit-border-radius: 8px;
  -moz-border-radius: 8px;
  border-radius: 8px;
  border: 1px solid rgb(139,136,120);

 }
 legend {
        border-style:none;
        background-color:#FFF;
        padding-left:1px;
    }
 hr { 
   border-top: 1px solid #e1e2df  ;
    } 

</style>

<script type="text/javascript">

	function hidedata(){
		
		var first=document.getElementById("firstarray").value;
		
		if(parseInt(first)==1){
			   $("#firstdiv").prop("hidden", false);
			}
		else{
			$("#firstdiv").prop("hidden", true);
			}
	}

</script>

</head>
<body bgcolor="white" style="font-size:10px;" onload="hidedata();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmextraServiceRequestPrint" action="extraServiceRequestPrint" method="post" autocomplete="off" target="_blank">

<div style="background-color:white;">

<jsp:include page="../../../common/printHeader.jsp"></jsp:include>

<fieldset>
<table width="100%">
  <tr>
    <td width="4%">Date</td>
    <td width="16%">: <label id="lbldate" name="lbldate"><s:property value="lbldate"/></label></td>
    <td width="8%">RA Type</td>
    <td width="20%">: <label id="lblratype" name="lblratype"><s:property value="lblratype"/></label></td>
    <td width="7%">RA No.</td>
    <td width="28%">: <label id="lblrano" name="lblrano"><s:property value="lblrano"/></label></td>
    <td width="6%">Doc No.</td>
    <td width="11%">: <label id="lbldocno" name="lbldocno"><s:property value="lbldocno"/></label></td>
  </tr>
  <tr>
    <td>Client</td>
    <td colspan="3">: <label id="lblclient" name="lblclient"><s:property value="lblclient"/></label></td>
    <td>Description</td>
    <td colspan="3">: <label id="lbldescription" name="lbldescription"><s:property value="lbldescription"/></label></td>
  </tr>
</table><br/>
</fieldset><br/>
  
<div id="firstdiv" hidden="true" >

<table style="border-collapse: collapse;" width="100%" >
  <tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
    <td align="left" style="border-collapse: collapse;" ><b>Sl No</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Extra Service Request Description</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Remarks</b></td> 
    <td align="right" style="border-collapse: collapse;"><b>Amount</b></td>
  </tr>
  <tr>
      <td colspan="4"><hr noshade size=1 color="#e1e2df"   width="100%"></td>
  </tr>
    <%int j=0,k=0; %>
    <s:iterator var="stat" value='#request.printingarray'>
   <%k=k+1;j=0;%>
	<tr>   
		<td width="6%" align="left"><%=k%></td>
    	<s:iterator status="arr" value="#stat.split('::')" var="des">   
    	<% if(j==1){%>
    	<td width="48%" align="left">
		    <s:property value="#des"/>
    	</td>
     	<%} else if(j==2){%>
  		<td align="right">
		    <s:property value="#des"/>
  			</td>
   		<%} else{ %>
  		<td align="left">
		  <s:property value="#des"/>
  		</td>
  		<% } j++;  %>
 		</s:iterator>
	</tr>
	</s:iterator> 
</table><br/>
</div>
<jsp:include page="../../../common/printFooter.jsp"></jsp:include>
<br/><br/><br/><br/>
<input type="hidden" id="firstarray" name="firstarray" value='<s:property value="firstarray"/>'>  
</div>

</form>
</div>
</body>
</html>
