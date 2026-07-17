<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<% String contextPath=request.getContextPath();%>
	<title>Gateway ERP | Workshop</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="<%=contextPath+"/"%>gatelogo.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="js/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="icons/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================
	<link rel="stylesheet" type="text/css" href="fonts/Linearicons-Free-v1.0.0/icon-font.min.css">-->
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="js/animate/animate.css">
<!--===============================================================================================	
	<link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================
	<link rel="stylesheet" type="text/css" href="vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="js/select2/select2.min.css">
<!--===============================================================================================
	<link rel="stylesheet" type="text/css" href="vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	
	<link rel="stylesheet" type="text/css" href="<%=contextPath%>/css/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=contextPath%>/css/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=contextPath%>/css/loginutil.css">
	<link rel="stylesheet" type="text/css" href="<%=contextPath%>/css/loginmain.css">
<!--===============================================================================================-->
</head>
<body style="background-color: #666666;" onload="getComp();">
	
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100">
				<form class="login100-form validate-form" method="post" action="login" autocomplete="off">
					<span class="login100-form-title p-b-43">
						Login to continue
					</span>
					
					<div class="wrap-input100 validate-input" data-validate="Company is required" style="height:auto;">
						<select class="js-example-basic-single input100" name="company" id="company">
							<option value="">--Select--</option>
							
						</select>
						<span class="focus-input100"></span>
					</div>
					<div class="wrap-input100 validate-input" data-validate = "Valid username is required: michael">
						<input class="input100" type="text" name="userid">
						<span class="focus-input100"></span>
						<span class="label-input100">Username</span>
					</div>
					
					
					<div class="wrap-input100 validate-input" data-validate="Password is required">
						<input class="input100" type="password" name="password">
						<span class="focus-input100"></span>
						<span class="label-input100">Password</span>
					</div>
					
					<div class="flex-sb-m w-full p-t-3 p-b-32">
						<div class="contact100-form-checkbox">
							<input class="input-checkbox100" id="ckb1" type="checkbox" name="remember-me">
							<label class="label-checkbox100" for="ckb1">
								Remember me
							</label>
						</div>

						<div>
							<a href="#" class="txt1">
								Forgot Password?
							</a>
						</div>
					</div>
			

					<div class="container-login100-form-btn">
						<button class="login100-form-btn" type="submit" id="btnlogin" name="commit">
							Login
						</button>
					</div>
					
					<!--<div class="text-center p-t-46 p-b-20">
						<span class="txt2">
							or sign up using
						</span>
					</div>

					<div class="login100-form-social flex-c-m">
						<a href="#" class="login100-form-social-item flex-c-m bg1 m-r-5">
							<i class="fa fa-facebook-f" aria-hidden="true"></i>
						</a>

						<a href="#" class="login100-form-social-item flex-c-m bg2 m-r-5">
							<i class="fa fa-twitter" aria-hidden="true"></i>
						</a>
					</div>-->
					<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
				</form>

				<div class="login100-more" style="background-image: url('icons/gtr.jpg');">
				</div>
			</div>
		</div>
	</div>
	
	

	
	
<!--===============================================================================================-->
	<script src="js/jquery/jquery-3.2.1.min.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jquery.easyui.min.js"></script>
<!--===============================================================================================
	<script src="vendor/animsition/js/animsition.min.js"></script>-->
<!--===============================================================================================-->
	<script src="js/bootstrap/js/popper.js"></script>
	<script src="js/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="js/select2/select2.min.js"></script>
<!--===============================================================================================
	<script src="vendor/daterangepicker/moment.min.js"></script>
	<script src="vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================
	<script src="vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="js/loginmain.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.24.4/dist/sweetalert2.all.min.js"></script>
	<script>
		$(document).ready(function() {
			$('.js-example-basic-single').select2({
				placeholder: 'Choose Company'
			});
			if($('#msg').val()!="" ) {
				/* $.messager.alert('Login Failed',$('#msg').val()); */
				swal({
					  type: 'error',
					  title: 'Login Failed',
					  html: $('#msg').val()
					});
			}
			
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

</body>
</html>