<%@ taglib uri="/struts-tags" prefix="s"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Gateway ERP</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="shortcut icon" href="<%=contextPath+"/"%>gatelogo.ico" >
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="../workshopapp/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="../workshopapp/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="../workshopapp/fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="../workshopapp/vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="../workshopapp/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="../workshopapp/vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="../workshopapp/vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="../workshopapp/vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="../workshopapp/css/util.css">
	<link rel="stylesheet" type="text/css" href="../workshopapp/css/main.css">
<!--===============================================================================================-->
	<style>
		.custom-form{
			position:absolute;
			top:50%;
			left:50%;
			transform:translate(-50%,-50%);
		}
		.comp-logo{
			margin-left:auto;
			margin-right:auto;
			margin-bottom:15px;
		}
		.footer{
			margin-top:15px;
			/* position:absolute; */
			bottom:0;
		}
	</style>
</head>
<body autocomplete="off">
	<!-- style="background-image: url(images/bg-01.jpg);" -->
	<form class="custom-form validate-form" id="frmFloorLogin" action="saveFloorLogin" method="post" autocomplete="off">
	<div class="container-fluid">
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 text-center ">
				<img src="../workshopapp/images/pal-logo.png" class="img-responsive comp-logo">
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div class="form-group">
					<label class="control-label">Username</label>
					<div class="input-group">
						<span class="input-group-addon"><i class="fa fa-user"></i></span>
					<input class="form-control" type="text" name="username" id="username" placeholder="Enter username">
					</div>
					
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div class="form-group">
					<label class="control-label">Password</label>
					<div class="input-group">
						<span class="input-group-addon"><i class="fa fa-lock"></i></span>
					<input class="form-control" type="password" name="password" id="password" placeholder="Enter password">
					</div>
					
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 text-center">
				<button class="btn btn-default btn-primary btn-block" id="btnlogin" type="button">
							Login
						</button>
			</div>
		</div>
		
	</div>
		<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
		<input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
		<div class="footer">
			<div class="row">
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 text-center">
					<img src="../icons/gateway_logo.gif" class="img-responsive m-b-20" style="width:40%;height:auto;">
				</div>
			</div>
		</div>
	</form>
	
<!--===============================================================================================-->
	<script src="../workshopapp/vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="../workshopapp/vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="../workshopapp/vendor/bootstrap/js/popper.js"></script>
	<script src="../workshopapp/vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="../workshopapp/vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="../workshopapp/vendor/daterangepicker/moment.min.js"></script>
	<script src="../workshopapp/vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="../workshopapp/vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="js/main.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.24.4/dist/sweetalert2.all.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			
    	});
	</script>	
</body>
</html>