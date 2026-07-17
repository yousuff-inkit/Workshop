<% String contextPath=request.getContextPath();%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Employee Status</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Raleway:200" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Droid+Serif:700i" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<script type="text/javascript" src="<%=contextPath%>/js/jquery-1.11.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$('.dropdown-menu li').hover(function(){
            var classname=$(this).attr('class');
            var text=$(this).find('a').text();
            $('.banner').removeClass('available-class');
            $('.banner').removeClass('busy-class');
            $('.banner').removeClass('absent-class');
            $('.banner').addClass(classname);
            if($('.btn-status').hasClass('available-class')){
                $('.btn-status').removeClass('available-class');
                $('.btn-status,.btn-status:focus,.btn-status:active').addClass(classname);
                $('.btn-status,.btn-status:focus,.btn-status:active').text(text);
            }
            else if($('.btn-status').hasClass('busy-class')){
                $('.btn-status').removeClass('busy-class');
                $('.btn-status,.btn-status:focus,.btn-status:active').addClass(classname);
                $('.btn-status,.btn-status:focus,.btn-status:active').text(text);
            }
            else if($('.btn-status').hasClass('absent-class')){
                $('.btn-status').removeClass('absent-class');
                $('.btn-status,.btn-status:focus,.btn-status:active').addClass(classname);
                $('.btn-status,.btn-status:focus,.btn-status:active').text(text);
            }
        });
		$('.dropdown-menu li').click(function(){
			var availability="";
			if($('.btn-status').hasClass('available-class')){
				availability="1";
            }
            else if($('.btn-status').hasClass('busy-class')){
            	availability="2";
            }
            else if($('.btn-status').hasClass('absent-class')){
            	availability="3";
            }
			
			saveStatus(availability);
		});
		getCurrentStatus();
	});
	
	function saveStatus(availability){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				items = items.split('####');
  				var valItems  = items[0];
  				var availabilityItems = items[1];
  				/* 
  				$("#overlay, #PleaseWait").hide();
  				
  				if(availabilityItems=='1'){
					$.messager.alert('Message', '  Your Current Status is Available ', function(r){
				    });
  				} else if(availabilityItems=='2'){
					$.messager.alert('Message', '  Your Current Status is Busy ', function(r){
				    });
  				} else if(availabilityItems=='3'){
					$.messager.alert('Message', '  Your Current Status is Absent ', function(r){
				    });
  				} else {
					$.messager.alert('Message', '  Your Status remains Same. ', function(r){
				    });
  				} */
		  }
		}
		
		
	function getCurrentStatus(){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText.trim();
  				var currentclassname="";
  				if(items=='1'){
  					currentclassname="available-class";
  				}
  				else if(items=='2'){
  					currentclassname="busy-class";
  				}
  				else if(items=='3'){
  					currentclassname="absent-class";
  				}
  				
  				var classname=currentclassname;
  	            var text=$(this).find('a').text();
  	            $('.banner').removeClass('available-class');
  	            $('.banner').removeClass('busy-class');
  	            $('.banner').removeClass('absent-class');
  	            $('.banner').addClass(classname);
  	            if($('.btn-status').hasClass('available-class')){
  	                $('.btn-status').removeClass('available-class');
  	                $('.btn-status,.btn-status:focus,.btn-status:active').addClass(classname);
  	                $('.btn-status,.btn-status:focus,.btn-status:active').text(text);
  	            }
  	            else if($('.btn-status').hasClass('busy-class')){
  	                $('.btn-status').removeClass('busy-class');
  	                $('.btn-status,.btn-status:focus,.btn-status:active').addClass(classname);
  	                $('.btn-status,.btn-status:focus,.btn-status:active').text(text);
  	            }
  	            else if($('.btn-status').hasClass('absent-class')){
  	                $('.btn-status').removeClass('absent-class');
  	                $('.btn-status,.btn-status:focus,.btn-status:active').addClass(classname);
  	                $('.btn-status,.btn-status:focus,.btn-status:active').text(text);
  	            }
  				
  				/* 
  				if(items=='1'){
  					document.getElementById("rdavailable").checked=true;
  				} else if(items=='2'){
  					document.getElementById("rdbusy").checked=true;
  				} else if(items=='3'){
  					document.getElementById("rdabsent").checked=true;
  				}  */
  		}
  		}
  		x.open("GET", "getCurrentStatus.jsp", true);
  		x.send();
 }
</script>
<style type="text/css">
	body{
            overflow: hidden;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }
        @keyframes float {
            0% {
                box-shadow: 0 5px 15px 0px rgba(0,0,0,0.6);
                transform: translateY(0px);
            }
            50% {
                box-shadow: 0 25px 15px 0px rgba(0,0,0,0.2);
                transform: translateY(-20px);
            }
            100% {
                box-shadow: 0 5px 15px 0px rgba(0,0,0,0.6);
                transform: translateY(0px);
            }
        }
        @keyframes loadAnimation{
            from{
                opacity: 0;
            -webkit-transform: rotateY(90deg) scale(0.2); /* Chrome, Safari, Opera  */
            transform: rotateY(90deg) scale(0.2);   
            }
            to{
                opacity: 1;
                -webkit-transform: rotateY(0deg) scale(1); /* Chrome, Safari, Opera  */
            transform: rotateY(0deg) scale(1);
            }
        }
        .outer-container{
            /*width: 600px;
            height: 400px;*/
            width: 100%;
            height: 100%;
            box-shadow: 0 19px 38px rgba(0,0,0,0.30), 0 15px 12px rgba(0,0,0,0.22);
            
            background-color: #fff;
            animation-name:loadAnimation;
            animation-duration:1.5s;
            /*transform: translatey(0px);*/
            /*animation: float 6s ease-in-out infinite;*/
            /*-webkit-perspective: 500;
             -webkit-transform-style: preserve-3d;
    -webkit-transition-property: perspective;
     -webkit-transition-duration: 0.5s;*/

    /*-webkit-transform: rotateY(30deg);
    -webkit-transition-property: transform;
     -webkit-transition-duration: 0.5s;*/
        }
        .first,.second{
            float: left;
        }
        .first{
            width: 40%;
            height: 100%;
        }
        .first img{
            width: 100%;
            height: 100%;
        }
        .second{
            width: 60%;
            height: 100%;
            padding: 25px 25px 15px 25px;
            text-align: center;
        }
        .empname{
            text-transform: uppercase;
            font-family: 'Roboto', sans-serif;
            text-align: left;
        }
        .designation{
            text-transform: uppercase;
            font-family: 'Roboto', sans-serif;
            color: #C70039;
            font-weight: bold;   
            text-align: left;
        }
        .banner{
            width: 100%;
            height: 120px;
            background-color: #C70039;
            position: absolute;
            z-index: -5;
            transform: rotate(120deg);
            margin-left: -100px;
        }
        .social{
            list-style: none;
            margin-top: 5%;
            width: 100%;
            text-align: center;
            left: 0;
            padding-left: 0;
        }
        .social li{
            display: inline-block;
            font-size: 2.2em;
            padding-right:0.5em; 
            left: 0;
            transition: all 0.5s ease-in;

        }
        .social li:hover{
            transform: rotateY(360deg);
        }
        .social li a i{
            color: #C8C6C6;
        }
        .btn-status{
            width: 100%;
            margin-right: 0.5em;
            padding: 15px 25px 15px 25px;
        text-transform: uppercase;
        color: #fff;
        width: 100%;
        font-weight: bold;
        letter-spacing: 3px;
        text-align: center;
        margin-bottom: 10px;
        border-radius: 25px;
        }
        .open > .dropdown-menu {
          -webkit-transform: scale(1, 1);
          transform: scale(1, 1);  
          opacity:1;
        }
        .dropdown-menu{
            width: 100%;
            background-color: transparent !important;
            opacity:.3;
          -webkit-transform-origin: top;
          transform-origin: top;
          -webkit-animation-fill-mode: forwards;  
          animation-fill-mode: forwards; 
          -webkit-transform: scale(1, 0);
          display: block; 
          transition: all 0.2s linear;
          -webkit-transition: all 0.2s linear;
          border: none;
          outline: none;

        }
        .dropdown-menu li{
            width: 100%;
            color: #fff;
        }
        .dropdown-menu li a{
            color: #fff;
        }
        .btn-status:hover,.btn-status:active,.btn-status:focus{
            color: #fff;
        }
        .dropdown{
            width: 100%;
        }
        /*.btn-status.available-class,.banner.available-class{*/
        .available-class{
            background: #56ab2f;  /* fallback for old browsers */
            background: -webkit-linear-gradient(to left, #a8e063, #56ab2f);  /* Chrome 10-25, Safari 5.1-6 */
            background: linear-gradient(to left, #a8e063, #56ab2f); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
        }
        .busy-class{
            background: #EB3349;  /* fallback for old browsers */
            background: -webkit-linear-gradient(to left, #F45C43, #EB3349);  /* Chrome 10-25, Safari 5.1-6 */
            background: linear-gradient(to left, #F45C43, #EB3349); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
        }
        .absent-class{
            background: #000000;  /* fallback for old browsers */
            background: -webkit-linear-gradient(to left, #434343, #000000);  /* Chrome 10-25, Safari 5.1-6 */
            background: linear-gradient(to left, #434343, #000000); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */   
        }
        .dropdown-menu li.available-class{
            background-color: #C8C6C6;
            border-left: 5px solid #a8e063;
            color: #a8e063;
        }
        .dropdown-menu li.busy-class{
            background-color: #C8C6C6;
            border-left: 5px solid #F45C43;
            color: #F45C43;
        }
        .dropdown-menu li.absent-class{
            background-color: #C8C6C6;
            border-left: 5px solid #000000;
        }
        .btn-status:active,.btn-status:focus{
            background-color: transparent;
            border: none;
            outline: none !important;
        }
        
        .pull-right li{
            background-color: #F7F6F6 !important;
        }
        .custom-drop{
            padding: 0;
            margin: 0;
        }
        .open>.dropdown-toggle.btn-default.available-class{
             background: #56ab2f;  /* fallback for old browsers */
            background: -webkit-linear-gradient(to left, #a8e063, #56ab2f);  /* Chrome 10-25, Safari 5.1-6 */
            background: linear-gradient(to left, #a8e063, #56ab2f); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
            color: #fff;
        }
        .open>.dropdown-toggle.btn-default.busy-class{
            background: #EB3349;  /* fallback for old browsers */
            background: -webkit-linear-gradient(to left, #F45C43, #EB3349);  /* Chrome 10-25, Safari 5.1-6 */
            background: linear-gradient(to left, #F45C43, #EB3349); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
            color: #fff;
        }
        .open>.dropdown-toggle.btn-default.absent-class{
            background: #000000;  /* fallback for old browsers */
            background: -webkit-linear-gradient(to left, #434343, #000000);  /* Chrome 10-25, Safari 5.1-6 */
            background: linear-gradient(to left, #434343, #000000); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */   
            color: #fff;
        }
        .custom-drop li:nth-child(1){
            border-top-left-radius: 5px;
            border-top-right-radius: 5px;
        }
        .custom-drop li:nth-child(3){
            border-bottom-left-radius: 5px;
            border-bottom-right-radius: 5px;
        }
        .custom-drop li a{
            text-transform: uppercase;
            text-align: center;
            padding: 15px 25px 15px 25px;
            font-weight: bold;
            letter-spacing: 3px;
        }
        .details{
            list-style: none;
            text-align: left;
            margin-left: 0;
            padding-left: 0; 

        }
        .details li{
            margin-top: 10px;
            margin-bottom: 10px; 
            font-family: 'Roboto', sans-serif;
            padding-left: 0px;
        }
        .details li i{
            padding-right:20px; 
            font-size: 1.1em;
        }
        .dept{
            text-align: left;
            font-family: 'Droid Serif', serif;
            color: #464746;
        }
</style>
</head>
<body>
<div class="banner available-class"></div>

        <div style="-webkit-perspective: 600px;perspective: 600px;width: 600px;height: 400px;margin-left: 25%;margin-top: 6%;">
        <div class="outer-container img-rounded">
            <div class="first">
                <img src="images/usrnew.jpeg" class="img-rounded">
            </div>
            <div class="second">
                <h1 class="empname">vishakh vp</h1>
                <p class="designation">software engineer</p>
                <p class="dept">Development</p>
                <ul class="details">
                    <li><i class="fa fa-id-badge"  aria-hidden="true"></i>GW-001</li>
                    <li><i class="fa fa-envelope"  aria-hidden="true"></i>vishakhvp@gmail.com</li>
                    <li><i class="fa fa-phone"  aria-hidden="true"></i>9895098950</li>
                </ul>
                <ul class="social">
                    <li><a href="#"><i class="fa fa-dribbble" aria-hidden="true"></i></a></li>
                    <li><a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a></li>
                    <li><a href="#"><i class="fa fa-behance" aria-hidden="true"></i></a></li>
                    <li><a href="#"><i class="fa fa-linkedin" aria-hidden="true"></i></a></li>
                    <li><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
                </ul>
                <div class="dropdown">
                    <button class="btn btn-default btn-status available-class dropdown-toggle" type="button" id="menu1" data-toggle="dropdown">Available
                    <span class="caret"></span></button>
                    <ul class="dropdown-menu custom-drop pull-right" role="menu" aria-labelledby="menu1">
                        <li role="presentation" class="available-class"><a role="menuitem" tabindex="-1" href="#">Available</a></li>
                        <li role="presentation" class="busy-class"><a role="menuitem" tabindex="-1" href="#">Busy</a></li>
                        <li role="presentation" class="absent-class"><a role="menuitem" tabindex="-1" href="#">Absent</a></li>
                    </ul>
                </div>   
            </div>
        </div>
        </div>
</body>
</html>