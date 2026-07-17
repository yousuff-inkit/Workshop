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

.verticalLine {
    border-left: 1px solid black;
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
    
P.breakhere {page-break-before: always}

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
<form id="frmLeaseQuotation" action="printLeaseQuotation" method="post" autocomplete="off" target="_blank">

<div style="background-color:white;">

<jsp:include page="../../../common/printHeader.jsp"></jsp:include>

<fieldset>
<table width="100%">
  <tr>
    <td width="18%">Customer Name</td>
    <td width="82%">:&nbsp;<label id="lblcustomername" name="lblcustomername"><s:property value="lblcustomername"/></label></td>
  </tr>
  <tr>
    <td>Address</td>
    <td>:&nbsp;<label id="lblcustomeraddress" name="lblcustomeraddress"><s:property value="lblcustomeraddress"/></label></td>
  </tr>
  <tr>
    <td>Phone Number</td>
    <td>:&nbsp;<label id="lblcustomermobile" name="lblcustomermobile"><s:property value="lblcustomermobile"/></label></td>
  </tr>
  <tr>
    <td>Email Address</td>
    <td>:&nbsp;<label id="lblcustomeremail" name="lblcustomeremail"><s:property value="lblcustomeremail"/></label></td>
  </tr>
  <tr>
    <td>Employer Name</td>
    <td>:&nbsp;<label id="lblemployeename" name="lblemployeename"><s:property value="lblemployeename"/></label></td>
  </tr>
  <tr>
    <td>Employer Address</td>
    <td>:&nbsp;<label id="lblemployeeaddress" name="lblemployeeaddress"><s:property value="lblemployeeaddress"/></label></td>
  </tr>
  <tr>
    <td>Job Title</td>
    <td>:&nbsp;<label id="lbljobtitle" name="lbljobtitle"><s:property value="lbljobtitle"/></label></td>
  </tr>
  <tr>
    <td>Date of Joining</td>
    <td>:&nbsp;<label id="lbldateofjoining" name="lbldateofjoining"><s:property value="lbldateofjoining"/></label></td>
  </tr>
  <tr>
    <td>Bank Name</td>
    <td>:&nbsp;<label id="lblbankname" name="lblbankname"><s:property value="lblbankname"/></label></td>
  </tr>
  <tr>
    <td>Scheme of Lease</td>
    <td>:&nbsp;<label id="lblschemeoflease" name="lblschemeoflease"><s:property value="lblschemeoflease"/></label></td>
  </tr>
</table>
</fieldset><br/>

<div id="firstdiv" hidden="true">
<table id="leaseapp" width="100%" class="tablereceipt" align="center">
<thead>
  <tr height="28" style="background-color: #FFEBCD;" class="tablereceipt" align="center">
    <th class="tablereceipt" width="5%" align="center">Sr.No</th>
    <th class="tablereceipt" width="36%" align="left">&nbsp;Type of Vehicle</th>
    <th class="tablereceipt" width="15%" align="right">Total Lease Cost&nbsp;</th>
    <th class="tablereceipt" width="12%" align="right">Advance&nbsp;</th>
    <th class="tablereceipt" width="10%" align="center">Lease Duration (Months)</th>
    <th class="tablereceipt" width="10%" align="center">Installments (Number of Months)</th>
    <th class="tablereceipt" width="12%" align="right">Installment (Month)&nbsp;</th>
  </tr>
</thead>
<tbody>
  <%int i=0,l=0; %>
  <s:iterator var="stat" value='#request.printleaseapplications' >
  <%l=l+1;i=0;%>
	<tr height="25" class=tablereceipt> 
	    <td class="tablereceipt" width="5%" align="center"><%=l%></td>
    	<s:iterator status="arr" value="#stat.split('::')" var="des">
    	
    	<%i=i+1;%>
    	<% if(i==1){%>
    	<td class=tablereceipt width="36%" align="left">&nbsp;
		    <s:property value="#des"/>
    	</td>
    	<%} else if(i==2){%>
    	<td class=tablereceipt width="15%" align="right">
		    <s:property value="#des"/>&nbsp;
    	</td>
    	
    	<%} else if(i==3){%>
    	<td class=tablereceipt width="12%" align="right">
		    <s:property value="#des"/>&nbsp;
    	</td>
    	
    	<%}else if(i==4){%>
    	<td class=tablereceipt width="10%" align="center">
		    <s:property value="#des"/>
    	</td> 
    	<%}else if(i==5){%>
    	<td class=tablereceipt width="10%" align="center">
		    <s:property value="#des"/>
    	</td>
  	    <%}else if(i==6){%>
    	<td class=tablereceipt width="12%" align="right">
		    <s:property value="#des"/>&nbsp;
    	</td>
   		<%} else{ %>
  		<td class=tablereceipt width="5%" align="center">
		  <s:property value="#des"/>
  		</td>
  		<% } %>
 		</s:iterator>
	</tr>
	</s:iterator>
	</tbody>
</table><br/>
</div>

<fieldset>
<!-- <table width="100%">
  <tr>
    <td width="44%">&nbsp;</td>
    <td width="28%" align="center">Original</td>
    <td width="28%" align="center">Copy</td>
  </tr> 
</table>-->
<table width="100%">
  <s:set var="temp" value="1"></s:set>
   <%int m=0; %>
  <s:iterator var="stat1" status="arr" value='#request.TERMLIST' >
  <s:iterator status="arr" value="#stat1" var="stat">    
  <tr>   
     <s:iterator status="arr" value="#stat.split('::')" var="des">
   		<s:if test="#arr.index==0">
   		<td width="50%" align="left"><Strong><s:property value="#des"/></Strong></td>
   		 <%if(m==0) { %>
   		 <td style="font-weight: bold;">Original</td>
   		 <td style="font-weight: bold;">Copy</td>
   		  <%} %>
   		</s:if>
   		<s:elseif test="#arr.index==1">
   		<tr>
   		<td><s:property value="#des"/>
   		</s:elseif>
   		<s:else>
  <td colspan="3" align="left"> <s:property value="#des"/></td>		
   		</s:else>
 </s:iterator>
 <%m++; %>
</tr>
</s:iterator>
</s:iterator>
 
</table>
</fieldset>

<table width="100%">
  <tr>
    <td><b>Important Note:</b> Original document is required for 1 & 2 if printed through online original stamp is a must.</td>
  </tr>
  <tr>
    <td><b>Remarks :</b></td>
  </tr>
  <tr>
    <td height="20">I acknowledge that all information are correct and accurate.</td>
  </tr>
</table>     
<table width="100%">
  <tr>
  <td height="10">&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  </tr>
  <tr>
    <td width="7%" align="left">Signed</td>
    <td width="30%">:&nbsp;<hr noshade size=1 width="100%"></td>
    <td width="63%" align="left">&nbsp;&nbsp;Approved for Finance Credit Review : </td>
  </tr>
  <tr>
    <td align="left">Date</td>
    <td>:&nbsp;<hr noshade size=1 width="100%"></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2" rowspan="2">&nbsp;</td>
    <td align="center">Malcolm Crawford Cooper</td>
  </tr>
  <tr>
    <td align="center">General Manager</td>
  </tr>
</table><br/><br/>

<table id="preparedby" width="100%" class="tablereceipt">
<tr>
<td width="60%">
<table width="100%">
  <tr>
    <td width="39%" align="left" height="25"><b>Prepared</b></td>
    <td width="35%" align="center"><b>Verified</b></td>
    <td width="26%" align="center"><b>Approved</b></td>
  </tr>
  <tr>
    <td><b>by</b>&nbsp;<label name="lblpreparedby" id="lblpreparedby" ><s:property value="lblpreparedby"/></label></td>
    <td rowspan="3" align="center"><label name="lblverifiedby" id="lblverifiedby" ><s:property value="lblverifiedby"/></label></td>
    <td rowspan="3" align="center"><label name="lblapprovedby" id="lblapprovedby" ><s:property value="lblapprovedby"/></label></td>
  </tr>
  <tr>
    <td><b>on</b>&nbsp;<label name="lblpreparedon" id="lblpreparedon" ><s:property value="lblpreparedon"/></label></td>
    </tr>
  <tr>
    <td><b>at</b>&nbsp;<label name="lblpreparedat" id="lblpreparedat" ><s:property value="lblpreparedat"/></label></td>
    </tr>
</table>
</td>

<td width="40%" class="tablereceipt">
<table width="100%">
  <tr>
    <td height="25" colspan="4"><b>Received By</b></td>
  </tr>
  <tr>
    <td width="5%"><b>Name</b></td>
    <td colspan="3">:<hr style="border:0;border-bottom: 1px dashed #ccc;" size=1 width="100%"></td>
  </tr>
  <tr>
    <td><b>Date</b></td>
    <td width="48%">:&nbsp;</td>
    <td width="5%"><b>Time</b></td>
    <td width="42%">:&nbsp;</td>
  </tr>
</table>
</td></tr>
</table>

<table width="100%">
  <tr>
  <td width="47%" style="color: #D8D8D8;" align="left"><i>Printed by <%=session.getAttribute("USERNAME")%> 
  <label id="lblfooter"></label></i></td>
  <td width="43%" style="color: #FAFAFA;" align="left">Powered by GATEWAY ERP</td>
  <td width="10%" style="color: #D8D8D8;"></td>
  </tr>
</table>
<br/><br/>

<P CLASS="breakhere">

 											<!-- Page 2 -->
 											
<jsp:include page="../leasecalculatoralfahim/AlFahimPrint.jsp"></jsp:include> 		
									
<input type="hidden" id="firstarray" name="firstarray" value='<s:property value="firstarray"/>'>  
<input type="hidden" id="secarray" name="secarray" value='<s:property value="secarray"/>'>
</div>
</form>
</div>
</body>
</html>