
   
 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%--   <jsp:include page="../../../../includes.jsp"></jsp:include>   --%> 
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
</style>
<% String fleetno=request.getParameter("fleetno"); %>

	<script type="text/javascript">
	$(document).ready(function () {


	}); 

	function  funuserupdates()
	
	{
	
		
		
		var fleetno='<%=fleetno%>';
	 
		var userids=document.getElementById("userdoc").value;
		var userdesc=document.getElementById("userdesc").value;
		
		if(userids=="")
		{
	
	
   	document.getElementById("errormsg").innerText="Select User Name";

	return 0;
		}
	else{
		 document.getElementById("errormsg").innerText="";
	   }
	
		if(userdesc=="")
		{
	
	
   	document.getElementById("errormsg").innerText="Enter Description";
	document.getElementById("userdesc").focus(); 
   	   
	return 0;
		}
	else{
		 document.getElementById("errormsg").innerText="";
	   }
 var nmaxs = userdesc.length;
    		
    		
          if(nmaxs>74)
       	   {
       	document.getElementById("errormsg").innerText="Description Cannot Contain More Than 75 Characters";
		document.getElementById("userdesc").focus(); 
       	   
		return 0;
			}
		else{
			 document.getElementById("errormsg").innerText="";
		   }
		

		funsavedatas(userids,userdesc,fleetno);
		
	}

	function funsavedatas(userids,userdesc,fleetno)
	{
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			
			
			 	var items= x.responseText.trim();
			 	document.getElementById("specialdiscountuser").value=items;
			 	
			 	
			 	
	 $.messager.alert('Message', 'Permitted By Special Approval');
	 $('#usersearchwindow').jqxWindow('close');



		}
		}
	     x.open("GET","saveuserdata.jsp?userids="+userids+"&userdesc="+userdesc+"&fleetno="+fleetno,true);
	    x.send();
	   
		
	}
	
	
	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr>
    <td colspan="8" align="right">
    
    <div>
      
   <jsp:include  page="userinfos.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
  <tr >
   <td>
   <table>
    <tr><td width="6%" align="right">Name</td><td width="20%" align="left"><input type="text" style="width:99%;" name="usernames" id="usernames" readonly="readonly"></td><td width="7%" align="right">Description</td><td width="60%" align="left"><input type="text" style="width:99%;" name="userdesc" id="userdesc"></td>
    
    <td width="7%"><input type="button" name="updateuser" id="updateuser" class="myButton"  value="Submit" onclick="funuserupdates()"></td></tr>
    
    </table> 

    </td>
  </tr>
  

</table>
<input type="hidden" style="width:99%;" name="userdoc" id="userdoc" readonly="readonly">
  </div>
</body>
</html>
  

   
    