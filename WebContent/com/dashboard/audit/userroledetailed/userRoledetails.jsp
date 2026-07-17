<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

<script type="text/javascript">

$(document).ready(function () {
	$("#branchlabel").css("opacity","0");$("#branchdiv").css("opacity","0");
	
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
     
   
    $('#userRoleDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'User-Role Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#userRoleDetailsWindow').jqxWindow('close');
});

function getRole(event){
	document.getElementById("txtusername").value="";
	 if (document.getElementById("txtusername").value == "") {
			
		 
	        $('#txtusername').attr('placeholder', 'Press F3 TO Search'); 
	    }
    var x= event.keyCode;
    if(x==114){
  	  userRoleSearchContent('userRoleSearchGrid.jsp');
    }
    else{}
    }
function funSearchdblclick(){
	document.getElementById("txtusername").value="";
	 if (document.getElementById("txtusername").value == "") {
			
		 
	        $('#txtusername').attr('placeholder', 'Press F3 TO Search'); 
	    }
	  $('#txtrolename').dblclick(function(){
		  userRoleSearchContent('userRoleSearchGrid.jsp');
	  });
}

function userRoleSearchContent(url) {
	    $('#userRoleDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#userRoleDetailsWindow').jqxWindow('setContent', data);
		$('#userRoleDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
function getName(event){
    var x= event.keyCode;
    if(x==114){
  	  userNameSearchContent('userNameSearchGrid.jsp');
    }
    else{}
    }
    
function funExportBtn(){

	 		
		  	JSONToCSVCon(data11, 'Menu Role', true);
			JSONToCSVCon(data13, 'BI Role', true);
		  
		
		
	}
function funNamedblclick(){
	  $('#txtusername').dblclick(function(){
		  userNameSearchContent('userNameSearchGrid.jsp');
	  });
}

function userNameSearchContent(url) {
	    $('#userRoleDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#userRoleDetailsWindow').jqxWindow('setContent', data);
		$('#userRoleDetailsWindow').jqxWindow('bringToFront');
	}); 
	}

function funreload(event){
	
	// $("#jqxUserRole").jqxGrid({ disabled: true});
	// $("#jqxUserRoledetails").jqxGrid({ disabled: true});
	
	/*  var userrole=$('#txtrolename').val();
	var username=$('#txtusername').val();  */
	var roleid=$('#txtroleid').val();
	var rolleid=$('#txtrolleid').val();
	//if(roleid>=0){
	//$("#overlay, #PleaseWait").show();
	$('#userrolGriddiv').load('userRoleGrid.jsp?roleid='+roleid+'&rolleid='+rolleid+'&id=1');	
	$('#userroldetailsGriddiv').load('userRoledetailsGrid.jsp?roleid='+roleid+'&rolleid='+rolleid+'&id=1');
	//}
	//else{
	
	//}
}
function funReadOnly(){
	$('#frmUserRoleMaster input').attr('readonly', true );
	// $("#jqxUserRole").jqxGrid({ disabled: true});
	//	$("#jqxUserRoledetails").jqxGrid({ disabled: true});
	/* $("#fromdate").jqxDateTimeInput({ disabled: true}); */
	/* $("#todate").jqxDateTimeInput({ disabled: true}); */
}
	
</script>

</head>
<body onload="funReadOnly();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	
		
	<tr><td colspan="2"><jsp:include page="../../heading.jsp"></jsp:include></td></tr>
	
	<tr><td colspan="2">&nbsp;</td></tr>
    <tr><td  align="right" width="25%" ><label class="branch">User Role</label></td>
    <td align="left">
   <input type="text" id="txtrolename" name="txtrolename" placeholder="Press F3 to Search" style="width:90%;height:20px;" ondblclick="funSearchdblclick();" onkeydown="getRole(event);" value='<s:property value="txtrolename"/>'/>
	<input type="hidden" id="txtroleid" name="txtroleid" value='<s:property value="txtroleid"/>'/>
                    </td></tr>
                    
                     <tr><td  align="right" ><label class="branch">User Name</label></td><td align="left">
                     <input type="text" id="txtusername" name="txtusername" placeholder="Press F3 to Search" style="width:90%;height:20px;" ondblclick="funNamedblclick();" onkeydown="getName(event);" value='<s:property value="txtusername"/>'/>
  <input type="hidden" id="txtrolleid" name="txtrolleid" value='<s:property value="txtrolleid"/>'/>
                    </td></tr>
    
    <tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr> 
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="userrolGriddiv"><jsp:include page="userRoleGrid.jsp"></jsp:include></div></td> 
		</tr>
		<tr>
		<td><div id="userroldetailsGriddiv"><jsp:include page="userRoledetailsGrid.jsp"></jsp:include></div></td> 
		</tr>
	</table>
</tr>
</table>
</div>

<div id="userRoleDetailsWindow">
	<div></div>
	
</div>
</div> 
</body>
</html>