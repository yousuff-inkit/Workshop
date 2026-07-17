<%-- <!DOCTYPE html>
<html lang="en">
<head>
    <title>html2canvas example</title>
 <jsp:include page="../../../../includes.jsp"></jsp:include>
    <script type="text/javascript" src="../../../../js/tableExport.js"></script>
        <script type="text/javascript" src="../../../../js/jspdf.min.js"></script>
            <script type="text/javascript" src="../../../../js/jquery.base64.js"></script>
                <script type="text/javascript" src="../../../../js/html2canvas.js"></script>
 <% String contextPath=request.getContextPath();%>
 
  <script type="text/javascript">
  $(document).ready(function(){ 
	/*     var specialElementHandlers = {
	        '#editor': function (element,renderer) {
	            return true;
	        }
	    };
 
		
	        var doc = new jsPDF();
	        doc.fromHTML($('body').get(0), 15, 15, {
				'width': 1080, 
				'elementHandlers': specialElementHandlers
			});
	        doc.save('sample-file.pdf');  */
	        
	        var specialElementHandlers = {
	    	        '#editor': function (element,renderer) {
	    	            return true;
	    	        }
	    	    };
	     
	    		
	    	        var doc = new jsPDF();
	    	        doc.fromHTML($('body').get(0), 15, 50, {
		                'width': 1080,'elementHandlers': specialElementHandlers
		            });
	    	        doc.save('sample-file.pdf'); 
	        
	        
	  /*       
	        var specialElementHandlers = {
	                '#editor': function (element,renderer) {
	                    return true;
	                }
	            };

	        $('#downloadFile').click(function () {
	            var doc = new jsPDF();
	            var source = $('#target').html();
	            var specialElementHandlers = {
	                '#bypassme': function (element, renderer) {
	                    return true;
	                 }
	            };
	            doc.fromHTML(source, 0.5, 0.5, {
	                'width': 75,'elementHandlers': specialElementHandlers
	            });
	            //doc.output("dataurlnewwindow");
	            doc.save('C:/Test.pdf');
	        }); */
	        
	   
	});


  </script>
</head>
<body id="target">
<div id="content">
     <h3>Hello, this is a H3 tag</h3>
      <a class="upload"  >Upload to Imgur</a>    
   <div id="mainBG" class="homeContent" data-type="background">
<form id="frmqotPrint" action="prqotInvoice" autocomplete="off" target="_blank">
<jsp:include page="../../../../../header.jsp"></jsp:include> <br/> 

 <div style="background-color:white;">
<div style="background-color:white;">
<table width="100%" class="normaltable" border="1">
  <tr>
    <td width="18%" rowspan="6"><img src="<%=contextPath%>/icons/epic.jpg" width="100" height="91"  alt=""/></td> 
    <td width="57%" rowspan="2">&nbsp;</td>
    <td width="25%"><font size="3"><label id="lblcompname" name="lblcompname" ><s:property value="lblcompname"/></label></font></td>
  </tr>
  <tr>
    <td><b><label id="lblcompaddress" name="lblcompaddress"><s:property value="lblcompaddress"/></label></b></td>
  </tr>
  <tr>
    <td rowspan="2"  align="center"><b><font size="5"><label id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label></font></b></td>
    <td align="left"><b>Tel :</b>&nbsp;<label id="lblcomptel" name="lblcomptel"><s:property value="lblcomptel"/></label></td>
  </tr>
  <tr>
    <td align="left"><b>Fax :</b>&nbsp;<label name="lblcompfax" id="lblcompfax" ><s:property value="lblcompfax"/></label></td>
  </tr>
  <tr>
    <td rowspan="2">&nbsp;</td>
    <td align="left"><b>Branch :</b>&nbsp;<label id="lblbranch" name="lblbranch" ><s:property value="lblbranch"/></label></td>
  </tr>
  <tr>
    <td align="left"><b>Location :</b>&nbsp;<label id="lbllocation" name="lbllocation" ><s:property value="lbllocation"/></label></td>
  </tr>
  <tr>
    <td colspan="3"><hr noshade size=1 width="100%"></td>
  </tr>
   <tr>
    <td colspan="3"></td></tr></table></div>

</div>
<fieldset>

<table width="100%" border="1"> 
  <tr>
    <td width="15%" align="left">Customer Name </td>
    <td width="61%">: <label id="lblclient" name="lblclient"><s:property value="lblclient"/></label></td>
    <td width="8%" align="left">Doc No</td>
    <td  width="16%">: <label id="docvals" name="docvals"><s:property value="docvals"/></label></td>
    </tr>
    <tr>
    <td align="left">Address </td>
    <td >: <label name="lblclientaddress" id="lblclientaddress" ><s:property value="lblclientaddress"/></label></td>
    <td align="left">Date </td>
    <td >: <label name="lbldate" id="lbldate" ><s:property value="lbldate"/></label></td>
  </tr>
  <tr>
   
    <td align="left">MOB </td>
    <td>: <label name="lblmob" id="lblmob" ><s:property value="lblmob"/></label></td>
        <td align="left">Type</td>
    <td>: <label name="lbltypep" id="lbltypep" ><s:property value="lbltypep"/></label></td>
  </tr>
  <tr>

    <td align="left">Email</td>
    <td>: <label name="lblemail" id="lblemail" ><s:property value="lblemail"/></label></td>
      <td align="left">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
 
   </table>
</fieldset>
<br>

  <div id="firstdiv" hidden="true" >
<!-- <fieldset> -->
<table style="border-collapse: collapse;" width="100%"  border=""> 

 <tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
    <td align="left" style="border-collapse: collapse;" ><b>Sl No</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Brand</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Model</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Specification</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Color</b></td>
    <td align="left"  style="border-collapse: collapse;"><b>Rent Type</b></td>
    <td align="left" style="border-collapse: collapse;"><b>From Date</b></td>
    <td align="left"  style="border-collapse: collapse;"><b>To Date</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Unit</b></td>
        <td align="left" style="border-collapse: collapse;"><b>Group</b></td>
 
  </tr>
 
<s:iterator var="stat" value='#request.details' >
<tr>   
<%int i=0; %>
    <s:iterator status="arr" value="#stat.split('::')" var="des">   
    <%
    if(i>1){%>
    
  <td  align="left" >
  <s:property value="#des"/>
  </td>
   <%} else{ %>
    
  <td  align="left"  >
  <s:property value="#des"/>
  </td>
  <% } i++;  %>
 </s:iterator>
</tr>
</s:iterator>
</table>
<!-- </fieldset> -->
</div>
<br>
  <div id="secdiv" hidden="true" > 
<!-- <fieldset> -->
<table style="border-collapse: collapse;" width="100%" border="" >
<!-- group1, rentaltype, rate, cdw, pai, cdw1, pai1, gps, babyseater, cooler, kmrest, exkmrte, oinschg, exhrchg -->
 <tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
    <td align="left" style="border-collapse: collapse;" ><b>Sl No</b></td>
    <td align="left"style="border-collapse: collapse;" ><b>Group</b></td>
    <td align="left"  style="border-collapse: collapse;"><b>Rental Type</b></td>
    <td align="right" style="border-collapse: collapse;"><b>Taiff</b></td>
    <td align="right" style="border-collapse: collapse;"><b>CDW</b></td>
    <td align="right" style="border-collapse: collapse;"><b>SCDW</b></td>
    <td align="right" style="border-collapse: collapse;"><b>Gps</b></td>
    <td align="right" style="border-collapse: collapse;"><b>Child Seat</b></td>
    <td align="right"  style="border-collapse: collapse;"><b>Booster</b></td>
    <td align="right" style="border-collapse: collapse;"><b>KM Rest</b></td>
        <td align="right" style="border-collapse: collapse;"><b>Exc KM Rate</b></td>
           <td align="right"  style="border-collapse: collapse;"><b>Ins Charge</b></td>
  <td align="right"  style="border-collapse: collapse;"><b>Ex. Hr Charge</b></td>
     
   
  </tr>

<s:iterator var="stat" value='#request.tariffdetails' >
<tr>   
<%int j=0; %>
    <s:iterator status="arr" value="#stat.split('::')" var="des">   
    <%
    if(j>2){%>
    
  <td  align="right" >
  <s:property value="#des"/>
  </td>
   <%} else{ %>
    
  <td  align="left" >
  <s:property value="#des"/>
  </td>
  <% } j++;  %>
 </s:iterator>
</tr>
</s:iterator>

</table>
<!-- </fieldset> -->
</div>
<br>



</div>
</form>
</div>

  </div>  

</body>
</html> --%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@ page import="java.net.URL"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>JSP Response setHeader</title>
</head>
<body>
<form>
<table>
<tr>
<td>Enter your Name :</td>
<td><input type="text" name="name" />
</td>
</tr>
<tr>
<tr>
<td></td>
<td><input type="submit" value="submit" />
</td>
</tr>
</table>
</form>
<%
String nm = request.getParameter("name");

if (nm != null) {
out.println("The Header <b>" + nm + "</b> has been already set : "
+ response.containsHeader("Author")+"<br>");
response.setHeader("Author", nm);
out.println("Author : " + nm+"<br>");
out.println("The Header <b>" + nm + "</b> has been already set : "
+ response.containsHeader("Author"));
}
%>
</body>
</html>