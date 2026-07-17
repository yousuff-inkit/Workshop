
   
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
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />.branch {
	
}
</style>


<style>
.branchss {
	color: black;
	background-color: E0#ECF8;
	width: 100%;
	font-family: Tahoma;
	font-size: 10px;
}
</style>
	<script type="text/javascript">
	$(document).ready(function () {


	}); 

	function  funuserupdates()
	
	{
	
		
		
		
		var userids=document.getElementById("userdoc").value;
		var userdesc=document.getElementById("userdesc").value;
		
		if(userids=="")
		{
	
	
			 $.messager.show({title:'Message',msg:'Select User Name',showType:'show',
                 style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
             }); 
   /*  $.messager.alert('Message', 'Select User Name'); */
	return 0;
		}
	else{
		// document.getElementById("errormsg").innerText="";
	   }
	
		if(userdesc=="")
		{
			 $.messager.show({title:'Message',msg:'Enter Description',showType:'show',
                 style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
             }); 
			/*  $.messager.alert('Message', 'Enter Description'); */
   //	document.getElementById("errormsg").innerText="Enter Description";
	document.getElementById("userdesc").focus(); 
   	   
	return 0;
		}
	else{
		
	   }
 var nmaxs = userdesc.length;
    		
    		
          if(nmaxs>74)
       	   {
        	  $.messager.show({title:'Message',msg:'Description Cannot Contain More Than 75 Characters',showType:'show',
                  style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
              }); 
        	   // $.messager.alert('Message', 'Description Cannot Contain More Than 75 Characters');
      // 	document.getElementById("errormsg").innerText="Description Cannot Contain More Than 75 Characters";
		document.getElementById("userdesc").focus(); 
       	   
		return 0;
			}
		else{
			// document.getElementById("errormsg").innerText="";
		   }
		

		funsavedatas(userids,userdesc);
		
	}

	function funsavedatas(userids,userdesc)
	{
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			
			
			 	var items= x.responseText.trim();
 		
	 $.messager.alert('Message', 'Permitted By Special Approval');
	 $('#usersearchwindow').jqxWindow('close');



		}
		}
	     x.open("GET","saveuserdata.jsp?userids="+userids+"&userdesc="+userdesc,true);
	    x.send();
	   
		
	}
	
	
	</script>
<body bgcolor="#ECF8E0">
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
    <tr><td width="6%" align="right"><label class="branchss" >Name</label></td><td width="20%" align="left"><input type="text" style="height:20px;width:99%;" name="usernames" id="usernames" readonly="readonly"></td>
    <td width="7%" align="right"><label class="branchss">Description</label></td><td width="60%" align="left"><input type="text" style="height:20px;width:99%;" name="userdesc" id="userdesc"></td>
    
    <td width="7%"><input type="button" name="updateuser" id="updateuser" class="myButton"  value="Submit" onclick="funuserupdates()"></td></tr>
    
    </table> 

    </td>
  </tr>
  

</table>
   <br>
<input type="hidden" style="width:99%;" name="userdoc" id="userdoc" readonly="readonly">
  </div>
</body>
</html>
  

   
    