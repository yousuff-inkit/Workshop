<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<% String contextPath=request.getContextPath();
//System.out.println("contextPath==333333333333333=="+contextPath);%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">


function funUpdate(){
	
	//alert("funUpdate=====");
	var txtcaptcha=document.getElementById('txtcaptcha').value;
	document.getElementById('captcha').value=txtcaptcha;
	//alert("txtcaptcha====="+txtcaptcha);
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
	        items= x.responseText;
	        //alert("===vitems====="+items);
			}
		else
			{
			}
	}
	x.open("GET","getCaptchatxt.jsp?txtcaptcha="+txtcaptcha,true);
	x.send();
}


</script>
</head>
 <body bgcolor="#E0ECF8">
<div id=btnok>
<!-- border="" -->
<table width="100%" >
  <tr >
  <td width="4%" align="left">Captcha &nbsp;<input type="text" id="txtcaptcha" placeholder="Enter the code here" name="txtcaptcha" style="width:70%;" value='<s:property value="txtcaptcha"/>'/></td>
    <td width="20%">&nbsp;</td>
    </tr>
    <tr>
   <td align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="btnOk" id="btnOk" style="width:60%;" class="myButton" value="Continue" onclick="funUpdate();"></td>
   <td>
   <tr><div id="Captcha">
   <img src="<%=contextPath%>/captcha.png" width="300" height="120" alt="img"/>
		</div></tr>
   </td>
   </tr>
   </table>
   </div>
   </body>
   </html>