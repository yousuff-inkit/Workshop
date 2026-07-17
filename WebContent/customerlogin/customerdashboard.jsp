<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Customer Dashboard</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css">
<jsp:include page="../floorMgmtIncludes.jsp"></jsp:include>
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />

<link href="css/util.css" rel="stylesheet" />
<style>
	@import url(https://fonts.googleapis.com/css?family=Source+Sans+Pro);
	@import url(https://fonts.googleapis.com/css?family=Teko:700);
	@font-face {
		font-family: Poppins-Regular;
	  	src: url('fonts/poppins/Poppins-Regular.ttf'); 
	}
	
	@font-face {
	  	font-family: Poppins-Medium;
	  	src: url('fonts/poppins/Poppins-Medium.ttf'); 
	}
	
	@font-face {
	  	font-family: Montserrat-Medium;
	  	src: url('fonts/montserrat/Montserrat-Medium.ttf'); 
	}
	
	@font-face {
	  	font-family: Montserrat-SemiBold;
	  	src: url('fonts/montserrat/Montserrat-SemiBold.ttf'); 
	}
	* {
		margin: 0px; 
		padding: 0px; 
		box-sizing: border-box;
	}
	html,body{
		width:100%;
		height:100%;
		background-color:#E9E9E9;
		font-family: Poppins-Regular, sans-serif;
	}
	.txt1 {
	  	font-family: Montserrat-SemiBold;
	  	font-size: 16px;
	  	color: #555555;
	  	line-height: 1.5;
	}
	
	.txt2 {
	  	font-family: Poppins-Regular;
	  	font-size: 14px;
	  	color: #999999;
	  	line-height: 1.5;
	}
	.rowgap{
    	margin-bottom:6px;
    }
	.page-loader{
		position:fixed;
		top:50%;
		left:50%;
		transform:translate(-50%,-50%);
		z-index:9999999;
	}
	.page-loader button,.page-loader button:hover,.page-loader button:active,.page-loader button:focus{
		background-color: #5867dd;
    	border-color: #5867dd;
		color:#fff;
	}
	.custom-tabs li a,.custom-tabs li{
		color:rgba(0,0,0,0.5);
	}
	.custom-tabs li.active a,.custom-tabs li.active,.custom-tabs li.focus a,.custom-tabs li.focus{
		color:rgba(88,103,221,1);
	}
	.card-container{
		width: 100%;
		background-color: #fff;
		box-shadow: 0 9px 16px 0 rgba(153,153,153,.25);
		padding-bottom: 5px;
	}
	.card-container .card-header{
		width: 100%;
		text-align: center;
		padding-top: 10px;
		padding-bottom: 5px;
	}
	.card-container .card-body{
		width: 100%;
		padding-left: 10px;
		padding-right: 10px;
	}
	.card-container .card-body .list-group .list-group-item{
		margin-bottom: 10px;
		border-radius: 25px;
	}
	.card-container .card-body .list-group .list-group-item .badge{
		background-color: rgba(0,0,0,.05);
		color: #000;
	}
	.txt1 {
	  	font-family: Montserrat-SemiBold;
	  	font-size: 16px;
	  	color: #555555;
	  	line-height: 1.5;
	}
	.card-body h1.txt1{
		font-size: 26px;
		margin-top: 5px;
	}
	.primary{
		color:#5867dd;
	}
	
	.custompanel{
      border:1px solid #ccc;
      float: left;
      display: inline-block;
      margin-top: 10px; 
      margin-right: 10px;
      padding-right: 10px;
      padding-left: 10px;
      padding-top: 10px;
      padding-bottom: 10px;
      border-radius: 8px;
    }
    .datepanel div{
    	display:inline-block;
    }
    .datepanel{
    	height:54px;
    	padding-top:20px;
    }
    .textpanel p.h4{
   		margin-top: 8px;
    	margin-bottom: 6px;
    }
	
.snip1563 {
  background-color: #fff;
  color: #ffffff;
  display: inline-block;
  font-family: 'Source Sans Pro', sans-serif;
  font-size: 16px;
  margin: 10px 5px;
  max-width: 100%;
  min-width: 230px;
  height:100px;
  overflow: hidden;
  position: relative;
  text-align: right;
  width: 100%;
}

.snip1563 *,
.snip1563 *:before,
.snip1563 *:after {
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
  -webkit-transition: all 0.45s ease;
  transition: all 0.45s ease;
}

.snip1563 img {
  backface-visibility: hidden;
  max-width: 100%;
  vertical-align: top;
}

.snip1563:before,
.snip1563:after {
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  content: '';
  background-color: #b81212;
  opacity: 0.5;
  -webkit-transition: all 0.45s ease;
  transition: all 0.45s ease;
}

.snip1563:before {
  -webkit-transform: skew(30deg) translateX(80%);
  transform: skew(30deg) translateX(80%);
}

.snip1563:after {
  -webkit-transform: skew(-30deg) translateX(70%);
  transform: skew(-30deg) translateX(70%);
}

.snip1563 figcaption {
  position: absolute;
  top: 0px;
  bottom: 0px;
  left: 0px;
  right: 0px;
  z-index: 1;
  bottom: 0;
  padding: 20px 20px 20px 40%;
}

.snip1563 figcaption:before,
.snip1563 figcaption:after {
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  background-color: #b81212;
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.7);
  content: '';
  opacity: 0.5;
  z-index: -1;
}

.snip1563 figcaption:before {
  -webkit-transform: skew(30deg) translateX(100%);
  transform: skew(30deg) translateX(100%);
}

.snip1563 figcaption:after {
  -webkit-transform: skew(-30deg) translateX(90%);
  transform: skew(-30deg) translateX(90%);
}

.snip1563 h3,
.snip1563 p {
  margin: 0;
  opacity: 0;
  letter-spacing: 1px;
}

.snip1563 h3 {
  font-family: 'Teko', sans-serif;
  font-size: 36px;
  font-weight: 700;
  line-height: 1em;
  text-transform: uppercase;
}

.snip1563 p {
  font-size: 0.9em;
}

.snip1563 a {
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  z-index: 1;
}

.snip1563:hover h3,
.snip1563.hover h3,
.snip1563:hover p,
.snip1563.hover p {
  -webkit-transform: translateY(0);
  transform: translateY(0);
  opacity: 0.9;
}

.snip1563:hover:before,
.snip1563.hover:before {
  -webkit-transform: skew(30deg) translateX(30%);
  transform: skew(30deg) translateX(30%);
  -webkit-transition-delay: 0.05s;
  transition-delay: 0.05s;
}

.snip1563:hover:after,
.snip1563.hover:after {
  -webkit-transform: skew(-30deg) translateX(20%);
  transform: skew(-30deg) translateX(20%);
}

.snip1563:hover figcaption:before,
.snip1563.hover figcaption:before {
  -webkit-transform: skew(30deg) translateX(50%);
  transform: skew(30deg) translateX(50%);
  -webkit-transition-delay: 0.15s;
  transition-delay: 0.15s;
}

.snip1563:hover figcaption:after,
.snip1563.hover figcaption:after {
  -webkit-transform: skew(-30deg) translateX(40%);
  transform: skew(-30deg) translateX(40%);
  -webkit-transition-delay: 0.1s;
  transition-delay: 0.1s;
}

.snip1563:hover h3,
.snip1563.hover h3,
.snip1563:hover p,
.snip1563.hover p {
  -webkit-transform: translateY(0);
  transform: translateY(0);
  opacity: 0.9;
}

.snip1563:hover:before,
.snip1563.hover:before {
  -webkit-transform: skew(30deg) translateX(30%);
  transform: skew(30deg) translateX(30%);
  -webkit-transition-delay: 0.05s;
  transition-delay: 0.05s;
}

.snip1563:hover:after,
.snip1563.hover:after {
  -webkit-transform: skew(-30deg) translateX(20%);
  transform: skew(-30deg) translateX(20%);
}

.snip1563:hover figcaption:before,
.snip1563.hover figcaption:before {
  -webkit-transform: skew(30deg) translateX(50%);
  transform: skew(30deg) translateX(50%);
  -webkit-transition-delay: 0.15s;
  transition-delay: 0.15s;
}

.snip1563:hover figcaption:after,
.snip1563.hover figcaption:after {
  -webkit-transform: skew(-30deg) translateX(40%);
  transform: skew(-30deg) translateX(40%);
  -webkit-transition-delay: 0.1s;
  transition-delay: 0.1s;
}
	
</style>
</head>
<body>
	<div class="page-loader">
		<button type="button" class="btn btn-brand"><i class="fa fa-circle-o-notch fa-spin fa-fw"></i> Loading</button>
	</div>
	<nav class="navbar navbar-default navbar-fixed-top">
  		<div class="container-fluid">
    		<div class="navbar-header">
      			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        			<span class="icon-bar"></span>
        			<span class="icon-bar"></span>
        			<span class="icon-bar"></span> 
      			</button>
      			<a class="navbar-brand" href="#">CRM Dashboard</a>
    		</div>
    		<div class="collapse navbar-collapse" id="myNavbar">
      			<!-- <ul class="nav navbar-nav">
        			<li class="active"><a href="#">Home</a></li>
        			<li><a href="#">Page 1</a></li>
        			<li><a href="#">Page 2</a></li> 
        			<li><a href="#">Page 3</a></li> 
      			</ul> -->
      			<ul class="nav navbar-nav navbar-right">
        			<li><a href="#"><span class="fa fa-bell-o"></span></a></li>
        			<li class="dropdown">
        				<a class="dropdown-toggle" data-toggle="dropdown" href="#"><span class="fa fa-user"></span> John Doe
        					<span class="caret"></span>
        				</a>
        				<ul class="dropdown-menu">
          					<li><a href="#">Sign Out</a></li>
          					<li><a href="#">Change Password</a></li>
        				</ul>
      				</li>
      			</ul>
    		</div>
  		</div>
	</nav> 
	
	<div class="container">
		<ul class="nav nav-tabs m-t-60 custom-tabs nav-justified">
    		<li class="active"><a data-toggle="tab" href="#menu-dashboard"><i class="fa fa-home p-r-5"></i>Dashboard</a></li>
    		<li><a data-toggle="tab" href="#menu1"><i class="fa fa-credit-card p-r-5"></i>Account Statement</a></li>
    		<li><a data-toggle="tab" href="#menu2"><i class="fa fa-money p-r-5"></i>Invoices</a></li>
    		<li><a data-toggle="tab" href="#menu3"><i class="fa fa-cogs p-r-5"></i>Settings</a></li>
  		</ul>

  		<div class="tab-content">
    		<div id="menu-dashboard" class="tab-pane fade in active">
      			<div class="container-fluid">
      				<div class="row">
      					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
      						<figure class="snip1563">
								<img src="images/bg-01.jpg" alt="sample110" />
		  						<figcaption>
		    						<h3>John Doe</h3>
		    						<p style="font-family: Poppins-Regular;"><span class="clientmobile p-r-20">+919895098950</span>|<span class="clientemail p-l-20">john_doe@gmail.com</span></p>
		  						</figcaption>
		  						<a href="#"></a>
							</figure>
						</div>
					</div>
      				<div class="row">
      					<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">
      						<div class="card-container img-rounded">
								<div class="card-header">
									<span>Balance</span>
								</div>
								<div class="card-body">
									<h1 class="text-center txt1">AED 15120.00</h1>
									<ul class="list-group">
  										<li class="list-group-item d-flex justify-content-between align-items-center">
    										PDC In Hand
    										<span class="badge badge-primary badge-pill">AED 15245.56</span>
  										</li>
  										<li class="list-group-item d-flex justify-content-between align-items-center">
    										Subsequent Reciept
    										<span class="badge badge-primary badge-pill">AED 125.56</span>
  										</li>
  										<li class="list-group-item d-flex justify-content-between align-items-center">
    										Advance
    										<span class="badge badge-primary badge-pill">AED 15120.00</span>
  										</li>
  										<li class="list-group-item d-flex justify-content-between align-items-center">
    										Balance
    										<span class="badge badge-primary badge-pill">AED 15120.00</span>
  										</li>
  										<li class="list-group-item d-flex justify-content-between align-items-center">
    										Un Applied
    										<span class="badge badge-primary badge-pill">AED 15120.00</span>
  										</li>
  										<li class="list-group-item d-flex justify-content-between align-items-center">
    										Total
    										<span class="badge badge-primary badge-pill">AED 15120.00</span>
  										</li>
									</ul>
								</div>
							</div>
      					</div>
      					<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
      						<div style="width:100%;">
      							<canvas id="myChart"></canvas>
      						</div>
      					</div>
      				</div>
      			</div>
    		</div>
    		<div id="menu1" class="tab-pane fade">
      			<div class="container-fluid">
				    <div class="row">
				    	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				        	<div class="primarypanel custompanel m-t-5 m-b-5">
				  				<button type="button" class="btn btn-default" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
				          		<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
				        		<button type="button" class="btn btn-default" id="btninfo" data-toggle="tooltip" title="Info" data-placement="bottom"><i class="fa fa-info-circle " aria-hidden="true"></i></button>
				        	</div>
				        	<div class="primarypanel custompanel datepanel">
				  				<div id="fromdate"></div>
				  				<div id="todate"></div>
				        	</div>
				        </div>
					</div>
					<div class="row rowgap">
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div id="accountsStatementDiv"><jsp:include page="accountsStatementTypeGrid.jsp"></jsp:include></div>
						</div>
					</div>
					<div class="row">
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<table width="100%">
								<tr>
									<td width="85%" align="right" style="font-size: 12px;font-weight: bold;">Net Amount :&nbsp;</td>
			        				<td width="15%" align="left"><input type="text" class="textbox form-control" id="txtnetamount" name="txtnetamount" style="width:90%;text-align: right;" value='<s:property value="txtnetamount"/>'/></td>
								</tr>
							</table>
						</div>
					</div>
				</div>
    		</div>
    		<div id="menu2" class="tab-pane fade">
      			<h3>Menu 2</h3>
      			<p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam.</p>
    		</div>
    		<div id="menu3" class="tab-pane fade">
      			<h3>Menu 3</h3>
      			<p>Eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.</p>
    		</div>
  		</div>
	</div>
	
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
    <script>
    	var ctx = document.getElementById('myChart').getContext('2d');
		var chart = new Chart(ctx, {
    		// The type of chart we want to create
    		type: 'line',
    		// The data for our dataset
    		data: {
        		labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
        		datasets: [{
            		label: 'My First dataset',
            		backgroundColor: 'rgb(255, 99, 132)',
            		borderColor: 'rgb(255, 99, 132)',
           			data: [0, 10, 5, 2, 20, 30, 45]
        		}]
    		},

    		// Configuration options go here
    		options: {}
		});
    	$(document).ready(function(){
    		$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    		$("#todate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    		/*$(".snip1563").addClass("hover");
    		$(".snip1563 .hover").mouseleave(
  				function () {
    				$(this).removeClass("hover");
  				}
			);*/
    	});
    	$(window).ready(function(){
    		$('.page-loader').hide();
  			setInterval(function(){ 
    			$('.snip1563').addClass("hover")
  			}, 1000);
		});
		
		
    	function funRoundAmt(value,id){
    		var res=parseFloat(value).toFixed(2);
    		var res1=(res=='NaN'?"0":res);
    		document.getElementById(id).value=res1;  
   		}
    </script>    
</body>
</html>