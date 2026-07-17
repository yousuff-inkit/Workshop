
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html >
<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="css/mystyle.css">
<link rel="shortcut icon" href="<%=contextPath+"/"%>gatelogo.ico" > 
<title>Gateway ERP(Integrated) Copyright &#169; 2017 GW INNOVATIONS PVT. LTD.</title>
<script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jquery.easyui.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/css/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/css/icon.css">

<style type="text/css">
	/* The snackbar - position it at the bottom and in the middle of the screen */
@font-face {
 	font-family: Poppins-Regular;
 	src: url('icons/fonts/poppins/Poppins-Regular.ttf'); 
}
#snackbar {
    visibility: hidden; /* Hidden by default. Visible on click */
    min-width: 250px; /* Set a default minimum width */
    margin-left: -125px; /* Divide value of min-width by 2 */
    background-color: #333; /* Black background color */
    color: #fff; /* White text color */
    text-align: center; /* Centered text */
    border-radius: 2px; /* Rounded borders */
    padding: 16px; /* Padding */
    position: fixed; /* Sit on top of the screen */
    z-index: 1; /* Add a z-index if needed */
    left: 50%; /* Center the snackbar */
    bottom: 30px; /* 30px from the bottom */
    font-family: Poppins-Regular;
}

/* Show the snackbar when clicking on a button (class added with JavaScript) */
#snackbar.show {
    visibility: visible; /* Show the snackbar */

/* Add animation: Take 0.5 seconds to fade in and out the snackbar. 
However, delay the fade out process for 2.5 seconds */
    -webkit-animation: fadein 0.5s, fadeout 0.5s 2.5s;
    animation: fadein 0.5s, fadeout 0.5s 2.5s;
}

/* Animations to fade the snackbar in and out */
@-webkit-keyframes fadein {
    from {bottom: 0; opacity: 0;} 
    to {bottom: 30px; opacity: 1;}
}

@keyframes fadein {
    from {bottom: 0; opacity: 0;}
    to {bottom: 30px; opacity: 1;}
}

@-webkit-keyframes fadeout {
    from {bottom: 30px; opacity: 1;} 
    to {bottom: 30px; opacity: 1;}
}

@keyframes fadeout {
    from {bottom: 30px; opacity: 1;}
    to {bottom: 30px; opacity: 1;}
}
a{
	color:red;
	font-weight:bold;
}
#msgexpiry {
	text-align:center;
	height:10px;
	background-color: transparent;
	border: none;
	color: red;
	font-weight: bold;
	width: 100%;
}

#msgexpiry {
  -moz-animation-duration: 1s;
  -moz-animation-name: blink;
  -moz-animation-iteration-count: infinite;
  -moz-animation-direction: alternate;
  
  -webkit-animation-duration: 2s;
  -webkit-animation-name: blink;
  -webkit-animation-iteration-count: infinite;
  -webkit-animation-direction: alternate;
  
  animation-duration: 1s;
  animation-name: blink;
  animation-iteration-count: infinite;
  animation-direction: alternate;
}

@-moz-keyframes blink {
  from {
    opacity: 1;
  }
  
  to {
    opacity: 0;
  }
}

@-webkit-keyframes blink {
  from {
    opacity: 1;
  }
  
  to {
    opacity: 0;
  }
}

@keyframes blink {
  from {
    opacity: 1;
  }
  
  to {
    opacity: 0;
  }
}
</style>

<script>
$(document).ready(function () {
	
	if($('#msg').val()!="" ) {
		$.messager.alert('Login Failed',$('#msg').val());
	}
	$('#snackbar').addClass('show');
	 $('body').keydown(function (evt) {
		  if (evt.keyCode == 8) {
			  var d = event.srcElement || event.target;
		        if ((d.tagName.toUpperCase() === 'INPUT' && 
		             (
		                 d.type.toUpperCase() === 'TEXT' ||
		                 d.type.toUpperCase() === 'PASSWORD' || 
		                 d.type.toUpperCase() === 'FILE' || 
		                 d.type.toUpperCase() === 'EMAIL' || 
		                 d.type.toUpperCase() === 'SEARCH' || 
		                 d.type.toUpperCase() === 'DATE' )
		             ) || 
		             d.tagName.toUpperCase() === 'TEXTAREA') {
		            doPrevent = d.readOnly || d.disabled;
		        }
		        else {
		            doPrevent = true;
		        }
		    }
		    if (doPrevent) {
		        event.preventDefault();
			}
	}); 

	
    $("input").not($(":button")).keypress(function (evt) {
        if (evt.keyCode == 13) {
            iname = $(this).val();
            if (iname !== 'Submit') {
                var fields = $(this).parents('form:eq(0),body').find('button, input, textarea, select');
                var index = fields.index(this);
                if (index > -1 && (index + 1) < fields.length) {
                    fields.eq(index + 1).focus();
                }
                return false;
            }
        }
    });
});


function getComp()
{
	var x=new XMLHttpRequest();
	var items,cmpItems;
	x.onreadystatechange=function(){

            if (x.status == 500) {
                chkcompany();
	        }

		if (x.readyState==4 && x.status==200)
			{
		        items= x.responseText;
		  
		        if(items.trim()=="NOTGET")
		        	{
		        	
		        	//alert("1");
		        	chkcompany();
		        	return 0;
		        	}
		        
		        else
		        	{
		         items=items.split('####');
		         var cmpItems = items[0].split(",");
		        var cmpIdItems = items[1].split(",");
	        	var optionscmp = '';
		       for ( var i = 0; i < cmpItems.length; i++) {
		    	   optionscmp += '<option value="' + cmpIdItems[i] + '">' + cmpItems[i] + '</option>';
		        }
		        	$("select#company").html(optionscmp);
		        	 
		        	if(items[2].trim()==''){
			        	$('#msgexpiry').hide();
					} else {
						$('#msgexpiry').val(items[2]);
					}
		        	
		        	}
			}
		else
			{
			}
	}
	x.open("GET","getCompany.jsp",true);
	x.send();
}

  function chkcompany()
{
	
	 var company=$("#company").val();
	 
		  if(!(parseInt(company)>0))
		{  
 
       setInterval(function(){ 
	 
	window.location.reload(true);
 
	             }, 3000);
	
			}
		  else
			  {
			 
			  }
}
 
  
</script> 

</head>
<body background="icons/car.jpg" style="overflow:hidden;background-repeat: no-repeat;" autocomplete="off" onload="getComp();"> 
	<div class="content">
	   <form method="post" action="login" autocomplete="off">
		<table class="loginTable" border="0" align="center" cellpadding="10" cellspacing="0">
		<tr>
		    <td colspan="3" align="center"><input type="text" id="msgexpiry" name="msgexpiry" value='<s:property value="msgexpiry"/>'/></td>
		</tr>
		<tr>
		    <td colspan="3"><select name="company" id="company" required="required" ></select></td>
		</tr>
		<tr>
		    <td width="150"><p style="margin-left:20px;">USERNAME</p></td>
			<td style="width:10px;">:</td>
			<td width="110"><input type="text" name="userid" value="" placeholder="Username" autofocus></td>
		</tr>
		<tr>
		    <td><p style="margin-left:20px;">PASSWORD</p></td>
			<td>:</td>
			<td><input type="password" name="password" value="" placeholder="Password"></td>
		</tr>
		<tr>
			<td colspan="3" style="text-align:center;"><input class="buttonStyle" type="submit" id="btnlogin" name="commit" value="Login"  onclick=""/></td>
		</tr>
	</table>
	<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
 <div id="snackbar">Check out the newer version <a href="loginnew.jsp">here</a></div>
		</form>
	</div>
</body>
</html>