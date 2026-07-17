<%@ taglib prefix="s" uri="/struts-tags" %>

<% String contextPath=request.getContextPath();
String outdate=request.getParameter("printdate");
String outtime=request.getParameter("printtime");

%>

<!DOCTYPE html>
<html><head>
 
<style type="text/css">
body {
    font-size: 0.75em;
}

</style>
</head>
<body >

<form >
</br></br></br></br></br></br></br>

<table width="97%"  align="left" >

<%-- <tr><td width=8%>sub</td><td width="55%"><s:property value="barnchval"/></td><td align="right" width="25%"><s:property value="rentaldoc"/></td><td width=10%>sub</td></tr>
 --%>
 <tr><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<s:property value="barnchval"/></td><td align="right"><s:property value="rentaldoc"/></td> 
  </tr>
  <tr><td height="5"></td></tr>
 <!--  <tr><td width="9%">sub</td>
  <td width="55%">branch</td>
  <td align="right" width="25%">doc no</td>
  <td align="right" width="9%">sub</td>
</tr> -->
  
  
  <tr><td width="63%" height="770"   >
  <table  width="100%" >
  <tr><td height="30" colspan="4" align="center"><s:property value="clname"/></td></tr>
    <tr><td height="35" colspan="4" align="center"><s:property value="radrname"/></td></tr>
      <tr><td height="35" colspan="4" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<s:property value="claddress"/></td></tr>
        <tr><td height="17" colspan="2" align="right"><s:property value="clmobno"/></td>
        <td height="17"colspan="2" align="right">&nbsp;</td></tr>
        <tr><td height="17" colspan="2" align="right">&nbsp;</td>
        <td height="17"colspan="2" align="right">&nbsp;</td></tr>
        
        <tr>
          <td width=5% height="48" align="center"><s:property value="radlno"/></td>
          <td width=5% height="48" align="right"><s:property value="lblissby"/></td>
          <td width=5% height="48" align="right" ><s:property value="lblissfromdate"/></td>
          <td width=5% height="48" align="right"><s:property value="licexpdate"/></td>
        </tr>
<tr>
  <td height="5" align="center"><s:property value="passno"/></td>
  <td height="5" align="right">&nbsp;</td>
  <td height="5" align="right"><s:property value="passexpdate"/></td>
  <td height="5" align="right"><s:property value="dobdate"/></td>
</tr>            
<tr><td  height="16" colspan="2" align="center"><s:property value="lblnation"/></td>
        <td  height="16" colspan="2" align="center">&nbsp;</td></tr>
        <tr><td  height="25" colspan="4" align="center"><s:property value="adddrname1"/></td></tr>
         <tr>
           <td width=25% height="23" align="center"><s:property value="addlicno1"/></td>
           <td width=15% height="23" align="right">&nbsp;</td>
           <td width=20% height="23" align="right">&nbsp;</td>
           <td width=15% height="23" align="center"><s:property value="expdate1"/></td>
         </tr>
        <tr><td height="590" colspan="4">&nbsp;</td></tr>
  </table>
  </td>
  <td width="35%"   >
<table width=100%  >
  
  <tr>
    <td height="20" align="center" ><font size="1.5"><s:property value="ravehname"/></font></td>
    <td height="20" align="center"><s:property value="ravehregno"/></td>
  </tr>
  <tr>
  <td height="32" align="center"><font size="1.5"><s:property value="racolor"/></font></td>
  <td height="32" align="center"><s:property value="rayom"/></td>
  </tr>
  <tr>
  <td height="32" rowspan="2" align="center"><s:property value="raklmout"/></td>
  <td height="10"></td>
  </tr>
  <tr>
    <td height="19" align="center"><%=outdate%>&nbsp;<%=outtime%></td>
  </tr>
  <tr>
  <td height="32" rowspan="2" align="center">&nbsp;</td>
  <td height="10"></td>
  </tr>
  <tr>
    <td height="19" align="center">&nbsp;</td>
  </tr>
  <tr>
  <td height="25"></td>
  <td height="25" align="left">&nbsp;</td>
  </tr>
 <!--  <tr>
  <td  height="20">Driven</td>
  <td  height="20">sub</td>
  </tr> -->
 </table>


<table width=100% >

  <tr>
  <td width="68%" height="24"></td>
  <td width="32%" align="right">
  <% if(request.getAttribute("rarenttypes").toString().equalsIgnoreCase("daily")){ %>
<s:property value="tariff"/>
 <%} %>
  </td>
  </tr>
  
  <tr>
    <td height="20"></td>
    <td align="right">
    <% if(request.getAttribute("rarenttypes").toString().equalsIgnoreCase("weekly")){ %>
    
  <s:property value="tariff"/>
 <%} %>
    </td>
  </tr>
  <tr>
  <td height="26"></td>
  <td align="right"><% if(request.getAttribute("rarenttypes").toString().equalsIgnoreCase("monthly")){ %>
    
  <s:property value="tariff"/>
 <%} %>
 </td>
  </tr><tr>
  <td height="24"></td>
  <td height="24" align="right"><s:property value="racdwscdw"/></td>
  </tr><tr>
  <td></td>
  <td height="24" align="right"><s:property value="laldelcharge"/></td>
  </tr><tr>
  <td></td>
  <td height="22" align="right">&nbsp;</td>
  </tr><tr>
  <td></td>
  <td height="24" align="right">&nbsp;</td>
  </tr><tr>
  <td></td>
  <td height="24" align="right">&nbsp;</td>
  </tr><tr>
  <td></td>
  <td height="23" align="right"><s:property value="raexxtakmchg"/></td>
  </tr><tr>
  <td ></td>
  <td height="16" align="right">&nbsp;</td>
  </tr><tr>
  <td></td>
  <td height="18" align="right">&nbsp;</td>
  </tr><tr>
  <td></td>
  <td height="23" align="right">&nbsp;</td>
  </tr><tr>
  <td ></td>
  <td height="26" align="right">&nbsp;</td>
  </tr>
  <td></td>
  <td height="30" align="right">&nbsp;</td>
  </tr><tr>
  <td></td>
  <td height="30" align="right">&nbsp;</td>
  </tr><tr>
  <td></td>
  <td height="30" align="right">&nbsp;</td>
  </tr><tr>
  <td></td>
  <td height="30" align="right">&nbsp;</td>
  </tr>
 </table>


  <table width=100%  > 
  <tr>
  		<td width="60%"></td>
  		<td height="" align="left">&nbsp;</td>
        
   </tr>
  <tr><td width="60%"></td>
  <td height="11" align="left">&nbsp;</td>
  </tr>
  </table>
 
 <table width=100%  > 
    <tr>
  <td height="80" align="center" >&nbsp;</td>
  </tr>
  </table>

<table width=100%  > 
  
        <tr>
  		<td width="55%" height=70 align="center">&nbsp;</td>
        <td width="15%" height=70 align="right">&nbsp;</td>
       <td width="30%" height=70 align="right">&nbsp;</td>
       </tr>
  </table>



 
  
</td>
</tr>
</table>
</form>
</body>

</html>
