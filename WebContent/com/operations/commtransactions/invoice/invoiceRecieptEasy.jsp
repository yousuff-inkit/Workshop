<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <link rel="stylesheet" type="text/css" href="../../../../css/body.css">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
 .hidden-scrollbar {
  overflow: auto;
  height: 800px;
} 

body { counter-reset: page 0;}
 fieldSet {
  -webkit-border-radius: 8px;
  -moz-border-radius: 8px;
  border-radius: 8px;
  border: 1px solid rgb(139,136,120);
 }                      
 /* 
    @media screen {
        .footer1 {
            display: none;
        }
    }
    @page { counter-increment: page }
#content{
display:table;
counter-reset: page 0;

}
#pageFooter {
    display: table-footer-group;
}
 */
/* 
#pageFooter:before {
     counter-increment: page 1;
	content: counter(page, decimal);
}  
     */

#content {
    display: table;
}

#pageFooter {
    display: table-footer-group;
}

#pageFooter:after {
    counter-increment: page;
    content: counter(page);
}

#pageFooter:after {
    counter-increment: page;
    content:"Page " counter(page);
    left: 0; 
    top: 100%;
    white-space: nowrap; 
    z-index: 20px;
    -moz-border-radius: 5px; 
    -moz-box-shadow: 0px 0px 4px #222;  
    background-image: -moz-linear-gradient(top, #eeeeee, #cccccc);  
    background-image: -moz-linear-gradient(top, #eeeeee, #cccccc);  
  }
</style> 
<script>
$(document).ready(function(){
	/* var head = $('#pagebreak');
	$("tbody tr:nth-child(10n)").after(head.clone());
	$("tbody tr:nth-child(10n)").css("background-color", "yellow"); */
	//$("tbody tr:nth-child(10n+10)").css("page-break-before", "always");
	//$('tbody tr:nth-child(10n)').nextAll().remove();
	/* $('tbody tr:nth-child(10n)').after($('tbody tr:nth-child(10n)').css('page-break-before','always'));  */
/* 	if($('tbody tr').find('nth-child(42)')){   
		$('tbody tr:nth-child(40n)').after('<br>');
		var head = $('table thead tr');
		$('tbody tr:nth-child(42n)').after(head.clone());
	}
	else{
		$('tbody tr:nth-child(50n)').after('<br>');	
	}
	 */
/* 	 
	if($( "#detailtable tbody tr:eq(40)")){
		alert("hi");
	    var head = $('<tr><td><br/></td></tr>');
	   // var check=$('#check');
	    $( "tbody tr:eq(39)").after(head.clone());
	  //  $( "tbody tr:nth-child(15)").after(check.clone());
	   } 
	   
	else if($( "#detailtable tbody tr:gt(40)")){
	    alert("hinjnj");
		var head = $('<tr><td><br/></td></tr>');
	  //  $( "tbody tr:nth-child(55n)").after(head.clone());
	//    var check=$('#check');
//	    $( "tbody tr:nth-child(60n)").after(check.clone());
	   }
	  */ var height=$(document).height();
	  var total=Math.round(height/842);
	  if(total%1!=0){
		  total=parseInt(total)+1;
	  }
	//document.getElementById("pageFooter").innerText="Pages "+total;
	/*   var head = $('#detailtable thead tr');
	$( "#detailtable tbody tr:nth-child(41)").before(head.clone()); */
});
</script>
</head>
<body onload="" style="background-color:white;">
<!-- <div id="mainBG" class="homeContent" data-type="background"> -->
<s:set name="counter" value="0"></s:set>
<s:set name="salik" value="#lblsalikcount"></s:set>
<s:set name="printcounter" value="0"></s:set>
<s:iterator value='#request.TRIAL' status="arr" var="#aa">
<s:if test="#printcounter>0">
	<DIV style="page-break-after:always"></DIV>
</s:if>
<form id="frmGroupedInvoicePrint" action="printGroupedInvoice" autocomplete="off" target="_blank">
<table width="100%" class="normaltable" >
  <tr>
    <td width="27%" rowspan="6"><img src="<%=contextPath%>/icons/epic.jpg" width="100%" height="auto"  alt=""/></td>
    <td width="41%" rowspan="2">&nbsp;</td>
    <td width="32%"><font size="3"><label id="lblcompname" name="lblcompname" ><s:property value="lblcompname"/></label></font></td>
  </tr>
  <tr>
    <td><b><label id="lblcompaddress" name="lblcompaddress"><s:property value="lblcompaddress"/></label></b></td>
  </tr>
  <tr>
    <td rowspan="2"  align="center"><b><font size="5"><label id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label></font></b></td>
    <td align="left"><b>Tel :</b>&nbsp;<label id="lblcomptel" name="lblcomptel"><s:property value="lblcomptel"/></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Fax :</b>&nbsp;<label name="lblcompfax" id="lblcompfax" ><s:property value="lblcompfax"/></label></td>
  </tr>
  <tr>
    <td align="left"><b>Email :</b>&nbsp;<label id="lblcompemail" name="lblcompemail"><s:property value="lblcompemail"/></label><br><b>Website :</b>&nbsp;<label name="lblcompwebsite" id="lblcompwebsite" ><s:property value="lblcompwebsite"/></label></td>
  </tr>
  <tr>
    <td rowspan="2">&nbsp;</td>
    <%-- <label id="lblbranch" name="lblbranch" ><s:property value="lblbranch"/></label> --%>
    <td align="left">&nbsp;</td>
  </tr>
  <tr>
  <%-- <label id="lbllocation" name="lbllocation" ><s:property value="lbllocation"/></label> --%>
    <td align="left"><b></b>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="3"><hr noshade size=1 width="100%"></td>
  </tr>
   <tr>
    <td colspan="3"></td></tr></table>
<fieldset>
<table width="100%">
  <tr>
    <td width="16%" align="left">Customer Name </td>
    <td colspan="3">: <label id="lblclient" name="lblclient"><s:property value="lblclient"/></label></td>
    <!-- <td width="22%">&nbsp;</td> -->
    <td width="12%" align="left">Invoice No </td>
    <td width="20%">: <label name="lblinvno" id="lblinvno" ><s:property value="lblinvno"/></label></td>
  <%-- <label name="lblbranchcode" id="lblbranchcode" ><s:property value="lblbranchcode"/>/</label><label name="lbldateyear" id="lbldateyear" ><s:property value="lbldateyear"/>/</label><label name="lblinvno" id="lblinvno" ><s:property value="lblinvno"/></label> --%>
  </tr>
  <tr>
    <td align="left">Customer Code </td>
    <td width="18%">: <label id="lblaccount" name="lblaccount" ><s:property value="lblaccount"/></label></td>
    <td width="12%" align="left">&nbsp;</td>
    <td></td>
    <td align="left">Date </td>
    <td>: <%-- <label name="lbldate" id="lbldate" ><s:property value="lbldate"/></label> --%><label name="lblinvto" id="lblinvto" ><s:property value="lblinvto"/></label></td>
  </tr>
  <tr>
    <td align="left">Address </td>
    <td colspan="3" align="left">: <label name="lbladdress1" id="lbladdress1" ><s:property value="lbladdress1"/></label></td>
    <td align="left">Payment Due Date</td>
    <td>: <label name="duedate" id="duedate" ><s:property value="duedate"/></label></td>
  </tr>
  <tr>
    <td align="left">&nbsp;</td>
    <td colspan="3" align="left">: <label name="lbladdress2" id="lbladdress2" ><s:property value="lbladdress2"/></label></td>
    <td align="left">From Period</td>
    <td>: <label name="lblinvfrom" id="lblinvfrom" ><s:property value="lblinvfrom"/></label></td>
  </tr>
  <tr>
    <td align="left">Phone</td>
    <td colspan="3" align="left">: <label name="lbltelphone" id="lbltelphone" ><s:property value="lbltelphone"/></label></td>
    <td align="left">To Period</td>
    <td>: <label name="lblinvto" id="lblinvto" ><s:property value="lblinvto"/></label></td>
  </tr>
  <tr>
    <td align="left">Mobile</td>
    <td colspan="3" align="left">: <label name="lblmobile" id="lblmobile" ><s:property value="lblmobile"/></label></td>
    <%-- <td align="left">Credit Period</td>
    <td>: <label name="lblcreditdiff" id="lblcreditdiff" ><s:property value="lblcreditdiff"/></label></td> --%>
  </tr>
  <tr>
    <td align="left">Damage Details</td>
    <td colspan="3" align="left">:&nbsp;Inspection No <label name="lblinspno" id="lblinspno" ><s:property value="lblinspno"/></label>, Reg No <label name="lblinspregno" id="lblinspregno" ><s:property value="lblinspregno"/></label></td>
    <td align="left">Currency</td>
    <td>: <label id="lblcurrency" name="lblcurrencycode" ><s:property value="lblcurrencycode"/></label></td>
  </tr>
  
</table>
</fieldset>
<br>

<hr>

<%-- <table width="100%" id="detailtable">
 <thead>
 <tr class="head">
    <th align="left"><b>SI No</b></th>
    <th align="left"><b>Ref Date</b></th>
    <th align="left"><b>Ref Type</b></th>
    <th align="left"><b>Ref No</b></th>
    <th align="left"><b>Agmt No</b></th>
    <th align="left"><b>MRA No</b></th>
    <th align="left"><b>Org.Reg No</b></th>
    <th align="left"><b>Cur.Reg No</b></th>
    <th align="left"><b>From Date</b></th>
    <th align="left"><b>To Date</b></th>
    <th align="right"><b>Total</b></th>
  </tr>
  </thead>
  <tbody>
 <s:set name="i" value="0"></s:set>
 <s:iterator var="stat1" status="arr" value="%{#request.INVPRINT}" >

		 <s:set name="i" value="#i+1"></s:set>
		 <s:if test="#arr5.index>30"> 
		 	<s:set name="i" value="0"></s:set>
		 </s:if>
		 <s:if test="#arr.index==#counter">
		
		    <s:iterator status="arr" value="#stat1" var="stat">  
		    <s:if test="#arr.index==40">
	<div style="page-break-before:always"></div>
</s:if>  
<tr>   
<%int i=0; %>
    <s:iterator status="arr" value="#stat.split('::')" var="des">   
    <%
    if(i>1){%>
    <s:if test="#arr.index<=9">
  		<td  align="left">  
    </s:if>
    <s:else>
  <td  align="right">  
    </s:else>
  
  <s:property value="#des"/>
  </td>
   <%} else{ %>
    
  <td  align="left">
  <s:property value="#des"/>
  </td>
  <% } i++;  %>
 </s:iterator>
</tr>
</s:iterator>
</s:if>

</s:iterator>
</tbody>
</table> --%>

<table width="100%">
 <tr>
    <td align="left">SI No</td>
    <td align="left">Charge Description</td>
    <td align="right">No of Bikes</td>
    <td align="right">Total</td>
  </tr>
  <s:set var="temp" value="1"></s:set>
  
  </tr>
  

 
 <s:iterator var="stat1" status="arr" value="%{#request.INVPRINT}" >
		 <s:if test="#arr.index==#counter">
		
		    <s:iterator status="arr" value="#stat1" var="stat">    
		   
<tr>   
<%int i=0; %>
 
     <s:iterator status="arr" value="#stat.split('::')" var="des">
    <%
    if(i>1 && i<4){%>
    
  <td  align="right">
  
<s:property value="#des"/>

  </td>
   <%} else if(i<=1) { %>
    
  <td  align="left">
  <s:property value="#des"/>
  </td>
  <% } i++;  %>
 </s:iterator>
</tr>
</s:iterator>
</s:if>
</s:iterator>

</table>
<hr>
<table width="100%">
	<tr>
		<td width="15%">Description</td>
		<td width="85%">:&nbsp;<label id="lblledgernote" name="lblledgernote"><s:property value="lblledgernote"/></label></td>
</table>
<hr>
<table width="100%" >
  <tr>
    <td width="166" align="left">Total :</td>
    <td width="783">&nbsp;</td>
    <td width="163">&nbsp;</td>
    <td width="146" align="right"><b><label id="lbltotal" name="lbltotal"><s:property value="lbltotal"/></label></b></td>
  </tr>
  <tr>
    <td align="left"><b>Net Amount :</b></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td align="right"><b><label id="lblnetamount" name="lblnetamount"><s:property value="lblnetamount"/></label><b></td>
  </tr>
  <tr>
    <td align="left"><b>Amount In Words : </b></td>
    <td colspan="3" align="right"><b><label id="lblamountwords" name="lblamountwords"><s:property value="lblamountwords"/></label></b></td>
    </tr>
</table>
<hr>
<h4 style="text-align:center;text-transform:uppercase"><b>bank details</b></h4>
<h4>Please Transfer to our Bank Account Below</h4>
<table width="40%" border="0">
  
  <tr>
    <td colspan="2">EASY LEASE MOTOR CYCLE RENTAL LLC</td>
    </tr>
  <tr>
    <td>BANK</td>
    <td>:&nbsp;EMIRATES ISLAMIC BANK</td>
  </tr>
  <tr>
    <td>A/C NO</td>
    <td>:&nbsp;3707413595301</td>
  </tr>
  <tr>
    <td>IBAN No</td>
    <td>:&nbsp;AE890340003707413595301</td>
  </tr>
  <tr>
    <td>SWIFT CODE</td>
    <td>:&nbsp;MEBLAEAD</td>
  </tr>
  <tr>
    <td>BRANCH</td>
    <td>:&nbsp;AL TWAR BRANCH</td>
  </tr>
  <tr>
    <td>DUBAI, UAE.</td>
    <td>&nbsp;</td>
  </tr>
</table>

<div id="bottompage">
<table width="100%" >
  <tr>
    <td width="13%">Checked By</td>
    <td width="20%"><label id="lblcheckedby" name="lblcheckedby"><s:property value="lblcheckedby"/></label></td>
    <td width="13%">Recieved By</td>
    <td width="29%"><label id="lblrecievedby" name="lblrecievedby"><s:property value="lblrecievedby"/></label></td>
    <td width="4%">Date</td>
    <td width="21%"><label id="lblfinaldate" name="lblfinaldate"><s:property value="lblfinaldate"/></label></td>
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
</table>
<h4>For Easy Lease Motorcycle Rental LLC</h4>
<table width="40%">
	<tr>
		<td>
			<img src="../../../../icons/easyleasesignature.png" alt=""  width="50%" height="50%">
			
		</td>
	</tr>
	<tr>
		<td>
			<img src="../../../../icons/easyleasestamp.png" alt="" width="90%" height="50%">
		</td>			
	</tr>
</table>

</div>

 <div class="divFooter">
 

</div> 
<!-- </div> -->
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
<%-- </form>

</s:iterator> --%>
<%-- <div width="135%" style="border:1px solid black;"><jsp:include page="../../../common/printFooter.jsp"></jsp:include></div> --%>
<!-- </div> -->
<table style="width:100%;" class="footer1">
 <tr>
     <td colspan="3" align="center"><fieldset><font style="color: #D8D8D8;font-size: 11px;"><b>System Generated Document Original Signature & Stamp Not Required.</b></font></fieldset></td>
  </tr>
  <tr>
  <td width="47%" style="color: #D8D8D8;" align="left"><i>Printed by <%=session.getAttribute("USERNAME")%> 
  <label id="lblfooter"></label></i></td>
  
  <td width="43%" style="color: #FAFAFA;" align="left">Powered by GATEWAY ERP</td>
  
 <td width="10%" style="color: #D8D8D8;">
    <div id="content"> 
  <label id="pageFooter"></label>
   </div>  
  </td>
  </tr>
</table>
<input type="hidden" name="lblagmtcounteasy" id="lblagmtcounteasy" value='<s:property value="lblagmtcounteasy"/>'/>
<s:set name="agmtcounteasy" value="lblagmtcounteasy" />
<input type="hidden" name="lblsalikcount" id="lblsalikcount" value='<s:property value="lblsalikcount"/>'/>
<input type="hidden" name="lbltrafficcount" id="lbltrafficcount" value='<s:property value="lbltrafficcountdubai"/>'/>
<input type="hidden" name="lbltrafficcountelse" id="lbltrafficcountelse" value='<s:property value="lbltrafficcountelse"/>'/>
<s:set name="saliktemp" value="lblsalikcount" />
<s:set name="trafficdubai" value="lbltrafficcountdubai" />
<s:set name="trafficelse" value="lbltrafficcountelse" />
<input type="hidden" name="lblshowfees" id="lblshowfees" value='<s:property value="lblshowfees"/>'/>
<s:set name="showfees" value="lblshowfees" />
<s:if test="#saliktemp > 0">

<!-- <DIV style="page-break-after:auto"></DIV> -->
	<div class="salikdiv" id="salikdiv">
	<DIV style="page-break-after:always"></DIV>
		<table width="100%">
  			<tr>
			    <td width="18%"><img alt="Dubai Gov Logo" src="<%=contextPath%>/icons/dubaigovlogo.jpg"/></td>
			    <td width="25%">&nbsp;</td>
			    <td width="34%">&nbsp;</td>
			    <td width="23%"><img alt="RTA Logo" src="<%=contextPath%>/icons/rtalogo.jpg"/></td>
  			</tr>
  			<tr><td colspan="4"><hr noshade size=1 width="100%"></td></tr> 
  			<tr>
  				<td colspan="4"><table width="100%" class="saliktable">
  					<thead>
  						<tr class="saliktable">
  							<th width="10%" class="saliktable"><b>Sr No</b></th>
							  <th width="10%" class="saliktable"><b>Transaction ID</b></th>
							  <th width="20%" class="saliktable"><b>Trip Date/Time</b></th>
							  <th width="15%" class="saliktable"><b>Transaction Post Date</b></th>
							  <th width="30%" class="saliktable"><b>Plate Info</b></th>
							  <th width="10%" class="saliktable"><b>Toll Gate Location</b></th>
							  <th width="10%" class="saliktable"><b>Toll Gate Direction</b></th>
							  <th width="10%" class="saliktable"><b>Amount<br>(AED)</b></th>
  						</tr>
  					</thead>
  					<tbody>
  					 					
     					<s:iterator var="statsalik" status="arr" value='#request.SALIKPRINT' >
      						<s:if test="#arr.index==#counter">
								<s:iterator status="arr" value="#statsalik" var="statsalik2"> 
									<tr class="saliktable">
									
 										<s:iterator status="arr" value="#statsalik2.split('::')" var="dessalik"> 
											
  											<td class="saliktable"><s:property value="#dessalik"/></td>
  										</s:iterator>
  									</tr>	
  								</s:iterator>
  							
  							</s:if>
  						</s:iterator>
  					</tbody>
  			</table>
  			</td></tr>
</table>

</div>
<br/><br/><br/><br/><br/><br/>
<div class="divFooter">
 
<table width="100%">
 <tr>
     <td colspan="3" align="center"><fieldset><font style="color: #D8D8D8;font-size: 11px;">System Generated Document Original Signature & Stamp Not Required.</font></fieldset></td>
  </tr>
  <tr>
  <td width="47%" style="color: #D8D8D8;" align="left"><i>Printed by <%=session.getAttribute("USERNAME")%> 
  <label id="lblfooter"></label></i></td>
  
  <td width="43%" style="color: #FAFAFA;" align="left">Powered by GATEWAY ERP</td>
  
 <td width="10%" style="color: #D8D8D8;">
    <!-- <div id="content"> 
  <div id="pageFooter"></div>
   </div>   -->
  </td>
  </tr>
</table>

</div>
</s:if>


<s:if test="#trafficdubai > 0"> 

<div class="trafficdiv" id="trafficdiv">
<DIV style="page-break-after:always"></DIV>
	<table width="100%">
  			<tr>
  			 	
  				<td width="18%"><img alt="Dubai Gov Logo" src="<%=contextPath%>/icons/dubaigovlogo.jpg"/></td>
			    <td width="25%">&nbsp;</td>
			    <td width="34%">&nbsp;</td>
			    <td width="23%"><img alt="RTA Logo" src="<%=contextPath%>/icons/rtalogo.jpg"/></td>
  				
			    <%-- <td><s:property value="#trafficbanner"/><img alt="Traffic Logo" src="<%=contextPath%>/icons/traffic_banner.jpg"/></td> --%>
			     
			    <%-- <td><s:property value="#trafficbanner"/><img alt="Traffic Logo" src="<%=contextPath%>/icons/traffic_banner.jpg"/></td> --%>
		    </tr>
  			<tr><td colspan="4"><hr noshade size=1 width="100%"></td></tr> 
  			<tr>
  				<td colspan="4"><table width="100%" class="saliktable">
  					<thead>
  						<tr class="saliktable">
  						<th width="10%" class="saliktable"><b>Sr No</b></th>
							  <th width="10%" class="saliktable" align="left"><b>Reg No</b></th>
							  <th width="15%" class="saliktable" align="left"><b>Ticket No</b></th>
							  <th width="10%" class="saliktable" align="left"><b>Traffic Date</b></th>
							  <th width="10%" class="saliktable" align="left"><b>Time</b></th>
							  <th width="10%" class="saliktable" align="left"><b>Amount</b></th>
							  <th width="30%" class="saliktable" align="left"><b>Fine Source</b></th>
							  <th width="20%" class="saliktable" align="left"><b>Description</b></th>
  						</tr>
  					</thead>
  					<tbody>
  					 					
     					<s:iterator var="stattraffic" status="arr" value='#request.TRAFFICPRINTDUBAI' >
      						<s:if test="#arr.index==#counter">
								<s:iterator status="arr" value="#stattraffic" var="stattraffic2"> 
									<tr class="saliktable">
									
 										<s:iterator status="arr" value="#stattraffic2.split('::')" var="destraffic"> 
											
  											<td class="saliktable"><s:property value="#destraffic"/></td>
  										</s:iterator>
  									</tr>	
  								</s:iterator>
  							
  							</s:if>
  						</s:iterator>
  					</tbody>
  			</table>
  			</td></tr>
			<s:if test="#showfees > 0">
  				<tr><td>
  				<br>
  				**Govt. Knowledge Fees for Dubai Traffic fine AED 20/-</td></tr>
  			</s:if>
</table>
</div>

<br/><br/><br/><br/><br/><br/>
<div class="divFooter">
 
<table width="100%">
 <tr>
     <td colspan="3" align="center"><fieldset><font style="color: #D8D8D8;font-size: 11px;">System Generated Document Original Signature & Stamp Not Required.</font></fieldset></td>
  </tr>
  <tr>
  <td width="47%" style="color: #D8D8D8;" align="left"><i>Printed by <%=session.getAttribute("USERNAME")%> 
  <label id="lblfooter"></label></i></td>
  
  <td width="43%" style="color: #FAFAFA;" align="left">Powered by GATEWAY ERP</td>
  
 <td width="10%" style="color: #D8D8D8;">
    <!-- <div id="content"> 
  <div id="pageFooter"></div>
   </div>  --> 
  </td>
  </tr>
</table>

</div>
</s:if>


<s:if test="#trafficelse > 0"> 

<div class="trafficdiv" id="trafficdiv">
<DIV style="page-break-after:always"></DIV>
	<table width="100%">
  			<tr>
  			 	
  			<%-- 	<td width="18%"><img alt="Dubai Gov Logo" src="<%=contextPath%>/icons/dubaigovlogo.jpg"/></td>
			    <td width="25%">&nbsp;</td>
			    <td width="34%">&nbsp;</td>
			    <td width="23%"><img alt="RTA Logo" src="<%=contextPath%>/icons/rtalogo.jpg"/></td>
  				
			    <td><s:property value="#trafficbanner"/><img alt="Traffic Logo" src="<%=contextPath%>/icons/traffic_banner.jpg"/></td> --%>
			     
			    <td><s:property value="#trafficbanner"/><img alt="Traffic Logo" src="<%=contextPath%>/icons/traffic_banner.jpg"/></td> 
		    </tr>
  			<tr><td><hr noshade size=1 width="100%"></td></tr> 
  			<tr>
  				<td><table width="100%" class="saliktable">
  					<thead>
  						<tr class="saliktable">
  						<th width="10%" class="saliktable"><b>Sr No</b></th>
							  <th width="10%" class="saliktable" align="left"><b>Reg No</b></th>
							  <th width="15%" class="saliktable" align="left"><b>Ticket No</b></th>
							  <th width="10%" class="saliktable" align="left"><b>Traffic Date</b></th>
							  <th width="10%" class="saliktable" align="left"><b>Time</b></th>
							  <th width="10%" class="saliktable" align="left"><b>Amount</b></th>
							  <th width="30%" class="saliktable" align="left"><b>Fine Source</b></th>
							  <th width="20%" class="saliktable" align="left"><b>Description</b></th>
  						</tr>
  					</thead>
  					<tbody>
  					 					
     					<s:iterator var="stattraffic" status="arr" value='#request.TRAFFICPRINTELSE' >
      						<s:if test="#arr.index==#counter">
								<s:iterator status="arr" value="#stattraffic" var="stattraffic2"> 
									<tr class="saliktable">
									
 										<s:iterator status="arr" value="#stattraffic2.split('::')" var="destraffic"> 
											
  											<td class="saliktable"><s:property value="#destraffic"/></td>
  										</s:iterator>
  									</tr>	
  								</s:iterator>
  							
  							</s:if>
  						</s:iterator>
  					</tbody>
  			</table>
  			</td></tr>
</table>
</div>

<br/><br/><br/><br/><br/><br/>
 <div class="divFooter">
 
<table width="100%">
 <tr>
     <td colspan="3" align="center"><fieldset><font style="color: #D8D8D8;font-size: 11px;">System Generated Document Original Signature & Stamp Not Required.</font></fieldset></td>
  </tr>
  <tr>
  <td width="47%" style="color: #D8D8D8;" align="left"><i>Printed by <%=session.getAttribute("USERNAME")%> 
  <label id="lblfooter"></label></i></td>
  
  <td width="43%" style="color: #FAFAFA;" align="left">Powered by GATEWAY ERP</td>
  
 <td width="10%" style="color: #D8D8D8;">
    <!-- <div id="content"> 
  <div id="pageFooter"></div>
   </div>  --> 
  </td>
  </tr>
</table>

</div>
</s:if>
<s:if test="#agmtcounteasy > 0">
<div style="page-break-after:always;"></div>
<table width="100%" class="normaltable">
  <tr>
    <td width="27%" rowspan="6"><img src="<%=contextPath%>/icons/epic.jpg" width="100%" height="auto"  alt=""/></td>
    <td width="41%" rowspan="2"><h3 style="text-transform:uppercase;text-align:center;">List of Agreements</h3></td>
    <td width="32%">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="3">&nbsp;</td>
  </tr>
 </table>

<table style="width:100%;">
	<tr>
		<td align="left"><b>Sr No</b></td>
		<td align="left"><b>Agmt No</b></td>
		<td align="left"><b>Inv No</b></td>
		<td align="left"><b>Ref No</b></td>
		<td align="left"><b>From Date</b></td>
		<td align="left"><b>To Date</b></td>
		<td align="left"><b>No of Days</b></td>
		<td align="left"><b>Reg No</b></td>
		<td align="right"><b>Rental Chg</b></td>
		<td align="right"><b>Acc Chg</b></td>
		<td align="right"><b>Insur Chg</b></td>
		<td align="right"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Total</b></td>
	</tr>
	<s:iterator var="easyagmt" status="arr" value='#request.EASYAGMTPRINT' >
      	<s:if test="#arr.index==#counter">
			<s:iterator status="arr" value="#easyagmt" var="easyagmtrow"> 
				<tr class="saliktable">
 					<s:iterator status="arr" value="#easyagmtrow.split('::')" var="easyagmtcolumn"> 
 						<s:if test="#arr.index>7">
 							<td align="right"><s:property value="#easyagmtcolumn"/></td>
 						</s:if>
  						<s:else>
  							<td align="left"><s:property value="#easyagmtcolumn"/></td>
  						</s:else>
  					</s:iterator>
  				</tr>	
  			</s:iterator>
  		 </s:if>
  	</s:iterator>
</table>
<hr>
<table width="100%">
	<tr>
		<td align="right"><b>Total&nbsp;&nbsp;&nbsp;:&nbsp;<label id="lblnetamount" name="lblnetamount" style="text-align:right;"><s:property value="lblnetamount"/></label><b></td>
</table>
</s:if>
</form>
<s:set name="printcounter" value="%{#printcounter+1}" />
<s:set name="counter" value="%{#counter+1}" />
</s:iterator>
</body>
</html>


<%-- 
  <jsp:include page="../../../../css/printtable.css"></jsp:include> 
 <jsp:include page="../../../../js/printTable.js"></jsp:include>  --%>



<%-- 
<fieldset>
  <table width="100%" >
    <tr>
      <td width="15%" align="right"> Contract Vehicle  </td>
      <td width="85%">: <label name="lblcontractvehicle" id="lblcontractvehicle" >
        <s:property value="lblcontractvehicle"/>
      </label></td>
    </tr>
  
  </table>
</fieldset> --%>



<%-- 
<table width="100%">

   <s:iterator var="stat2" status="arr" value='#request.FLEETPRINT' >
   <s:if test="#arr.index==#counter">
<tr>
 <s:iterator status="arr" value="#stat2" var="des2"> 
<td  align="left"><b>Other Fleets</b></td>
  <td><s:property value="#des2"/> </td>

  </tr>
  </s:iterator>
  </s:if>
  </s:iterator>
  
</table> --%>
