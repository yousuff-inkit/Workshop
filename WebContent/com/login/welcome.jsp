<!DOCTYPE html >
<html>
<head>
<% String contextPath=request.getContextPath();%>
<%
    response.sendRedirect("login.jsp");
    return;
%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="shortcut icon" href="<%=contextPath+"/"%>icons/ink_new_logo_2025.png" >
<title>INK IT Business Solutions</title>
<style type="text/css">

html, body {
  margin: 0;
  height: 100%
  
}

.sky {
  height: 80vh;
  background: transparent;
  position: relative;
  overflow: hidden;
  -webkit-animation: sky_background 50s ease-out infinite;
  -moz-animation: sky_background 50s ease-out infinite;
  -o-animation: sky_background 50s ease-out infinite;
  -webkit-transform: translate3d(0, 0, 0);
  -moz-transform: translate3d(0, 0, 0);
  -o-transform: translate3d(0, 0, 0)
}

.moon {
  
  /* background: url("http://i.imgur.com/wFXd68N.png"); */
  position: absolute;
  left: 0;
  height: 300%;
  width: 300%;
  -webkit-animation: moon 50s linear infinite;
  -moz-animation: moon 50s linear infinite;
  -o-animation: moon 50s linear infinite;
  -webkit-transform: translate3d(0, 0, 0);
  -moz-transform: translate3d(0, 0, 0);
  -o-transform: translate3d(0, 0, 0)
}

.clouds_one {
  position: absolute;
  left: 1010px;
  top: 0;
  /* height: 100%; */
  height: 43vh;
  width: 300%;
  -webkit-animation: cloud_one 500s linear infinite;
  -moz-animation: cloud_one 500s linear infinite;
  -o-animation: cloud_one 500s linear infinite;
  -webkit-transform: translate3d(0, 0, 0);
  -moz-transform: translate3d(0, 0, 0);
  -o-transform: translate3d(0, 0, 0) 
}

.clouds_two {
  background: url("com/login/clouds.png");
  position: absolute;
  left: 0;
  top: 0;
  /* height: 100%; */
  height: 80vh;
  width: 300%;
  -webkit-animation: cloud_two 75s linear infinite;
  -moz-animation: cloud_two 75s linear infinite;
  -o-animation: cloud_two 75s linear infinite;
  -webkit-transform: translate3d(0, 0, 0);
  -moz-transform: translate3d(0, 0, 0);
  -o-transform: translate3d(0, 0, 0)
}

.clouds_three {
  position: absolute;
  left: 0;
  top: 0;
  /* height: 100%; */
  height: 80vh;
  width: 300%;
  -webkit-animation: cloud_three 100s linear infinite;
  -moz-animation: cloud_three 100s linear infinite;
  -o-animation: cloud_three 100s linear infinite;
  -webkit-transform: translate3d(0, 0, 0);
  -moz-transform: translate3d(0, 0, 0);
  -o-transform: translate3d(0, 0, 0)
}

@-webkit-keyframes sky_background {
  0% {
    background: transparent;
    /* color: #007fd5 */
  }
  50% {
    background: transparent;
   /*  color: #a3d9ff */
  }
  100% {
    background: transparent;
    /* color: #007fd5 */
  }
}

@-webkit-keyframes moon {
  0% {
    opacity: 0;
    left: -200% -moz-transform: scale(0.5);
    -webkit-transform: scale(0.5);
  }
  50% {
    opacity: 0;
    -moz-transform: scale(1);
    left: 0% bottom: 250px;
    -webkit-transform: scale(1);
  }
  100% {
    opacity: 0;
    bottom: 500px;
    -moz-transform: scale(0.5);
    -webkit-transform: scale(0.5);
  }
}

@-webkit-keyframes cloud_one {
  0% {
    left: 1010px
  }
  100% {
    left: -200%
  }
}

@-webkit-keyframes cloud_two {
  0% {
    left: 0
  }
  100% {
    left: -200%
  }
}

@-webkit-keyframes cloud_three {
  0% {
    left: 0
  }
  100% {
    left: -200%
  }
}

@-moz-keyframes sky_background {
  0% {
    background: transparent;
    /* color: #007fd5 */
  }
  50% {
    background: transparent;
    /* color: #a3d9ff */
  }
  100% {
    background: transparent;
    /* color: #007fd5 */
  }
}

@-moz-keyframes moon {
  0% {
    opacity: 0;
    left: -200% -moz-transform: scale(0.5);
    -webkit-transform: scale(0.5);
  }
  50% {
    opacity: 1;
    -moz-transform: scale(1);
    left: 0% bottom: 250px;
    -webkit-transform: scale(1);
  }
  100% {
    opacity: 0;
    bottom: 500px;
    -moz-transform: scale(0.5);
    -webkit-transform: scale(0.5);
  }
}

@-moz-keyframes cloud_one {
  0% {
    left: 1010px;
    margin-right: 20px;
  }
  100% {
    left: -200%
  }
}

@-moz-keyframes cloud_two {
  0% {
    left: 0;
    margin-right: 20px;
  }
  100% {
    left: -200%
  }
}

@-moz-keyframes cloud_three {
  0% {
    left: 0;
    margin-right: 20px;
  }
  100% {
    left: -200%
  }
}

 body {
    /* padding-left: 11em; */
    font-family: Tahoma,Georgia, "Times New Roman",Times, serif;
    color: black;
    }
 h1 {
    color: red;
    font-family: Raleway;/* Helvetica, Geneva, Arial,
          SunSans-Regular, sans-serif */ }
  ul.navbar {
    list-style-type: none;
    padding: 0;
    margin: 0;
    position: absolute;
    top: 2em;
    left: 1em;
    width: 9em }
 ul.navbar li {
    background: white;
    color: red;
    margin: 0.5em 0;
    padding: 0.3em;
    border-right: 1em solid black;
    cursor:pointer }
  ul.navbar a {
    text-decoration: none }
  a:link {
    color: red }
  a:visited {
    color: red }
 address {
    color: blue;
    margin-top: 1em;
    padding-top: 1em;
    /* border-top: thin dotted */
	text-shadow: #ccc 0 1px 0, #c9c9c9 0 2px 0, #bbb 0 3px 0, #b9b9b9 0 4px 0, #aaa 0 5px 0,rgba(0,0,0,.1) 0 6px 1px, rgba(0,0,0,.1) 0 0 5px, rgba(0,0,0,.3) 0 1px 3px, rgba(0,0,0,.15) 0 3px 5px, rgba(0,0,0,.2) 0 5px 10px, rgba(0,0,0,.2) 0 10px 10px, rgba(0,0,0,.1) 0 20px 20px;
    }
 
 .buttonWelcome{
    font-family: "Myriad Pro";
	font-weight: bold;
	font-size: 11px;
	color: white;
	background: #149BCC;
	border:none;
	padding:8px 4px;
	height:30px;
	width:100px;
	cursor:pointer;
	float: right;
}   
          
  
</style>
<script type="text/javascript">
	
	function openNewWindow()
	 {
	     var url=document.URL;
	     var reurl=url.split("login");
	     
	      var newWindow = window.open(reurl[0]+"login.jsp", "GatewayERP(i)",'resizable=0,scrollbars=0,'+
	       'menubar=0,location=no,directories=0,fullscreen=0,channelmode=1,titlebar=0,statusbar=0,addressbar=0,width=1366,height=768'); 
	       
	     if (window.focus) {newWindow.focus()}
	     return false;
	 }
	
	function openNewRegisterWindow()
	 {
	 	 var url=document.URL;
	     var reurl=url.split("login");
	     
	      var newWindow = window.open(reurl[0]+"register.jsp", "GatewayERP(i)",'resizable=0,scrollbars=0,'+
	       'menubar=0,location=no,directories=0,fullscreen=0,channelmode=1,titlebar=0,statusbar=0,addressbar=0,width=1366,height=768'); 
	       
	     if (window.focus) {newWindow.focus()}
	     return false;
	 }
	
</script>
</head>
<body background="<%=contextPath%>/icons/gatewaywelcome.png" style="overflow:hidden;background-repeat: no-repeat;">

 <div class="sky"> 
    <div class="clouds_two"></div>
    <div class="clouds_one"></div>
    <div class="clouds_three"></div>
  </div> 
 <div style="position: fixed;z-index:15;bottom:10px;margin-right:10px;float:right;width:100vw;"> 
 <input class="buttonWelcome" type="button" name="gateway" value="To Know More"  onclick="window.open('http://gatewayerp.com')"/>&nbsp;&nbsp;
 <input hidden="true" class="buttonWelcome" type="submit" name="commit" value="Register"  onclick="openNewRegisterWindow();"/>&nbsp;&nbsp;
 <input class="buttonWelcome" type="submit" name="commit" value="Login"  onclick="openNewWindow();"/>

 
<!-- Sign and date the page, it's only polite! -->
 <address><marquee>Business Process Management is essential to CONTROL & GROW</marquee></address>
 </div>
</body>
</html>