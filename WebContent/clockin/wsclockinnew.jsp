<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>Job Clock In/Out</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../vendors/bootstrap-v3/css/bootstrap.min.css">
<link rel="stylesheet" href="../vendors/animate/animate.css">
<jsp:include page="../floorMgmtIncludes.jsp"></jsp:include>
<link href="../vendors/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="../vendors/select2/css/select2.min.css" rel="stylesheet" />
<style type="text/css">
	.rowgap{
		margin-bottom:8px;
	}
	
	.multitab {
		display: none;
	}
	.load-wrapp {
	    float: left;
	    width: 100px;
	    height: 100px;
	    margin: 0 10px 10px 0;
	    padding: 20px 20px 20px;
	    border-radius: 5px;
	    text-align: center;
	    background-color: #fff;
	    position:absolute;
	    z-index:9999;
	    top:50%;
	    left:50%;
	    transform:translate(-50%,-50%);
	    border:1px solid #000;
	}
	.spinner {
	    position: relative;
	    width: 45px;
	    height: 45px;
	    margin: 0 auto;
	}
	
	.bubble-1,
	.bubble-2 {
	    position: absolute;
	    top: 0;
	    width: 25px;
	    height: 25px;
	    border-radius: 100%;
	    
	    background-color: #000;
	}
	
	.bubble-2 {
	    top: auto;
	    bottom: 0;
	}
	.load-9 .spinner {border:none;animation: loadingI 2s linear infinite;}
	.load-9 .bubble-1, .load-9 .bubble-2 {animation: bounce 2s ease-in-out infinite;}
	.load-9 .bubble-2 {animation-delay: -1.0s;}
	@keyframes loadingI {
	    100% {transform: rotate(360deg);}
	}
	
	@keyframes bounce  {
	  0%, 100% {transform: scale(0.0);}
	  50% {transform: scale(1.0);}
	}
			
</style>

</head>
<body>
	<div class="load-wrapp">
    	<div class="load-9">
        	<div class="spinner">
            	<div class="bubble-1"></div>
                <div class="bubble-2"></div>
            </div>
        </div>
    </div>
	    <div id="modalclockin" class="modal fade in" role="dialog">
      		<div class="modal-dialog">
        		<div class="modal-content">
          			<div class="modal-header">
            			<button type="button" class="close" data-dismiss="modal">&times;</button>
            			<h4 class="modal-title">Clock In/Out</h4>
          			</div>
          			<div class="modal-body">
            			<div class="container-fluid">
            				<div class="row rowgap">
            					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            						<div class="multitab">
            							<div class="input-group">
    										<input id="jobcard" type="text" class="form-control" name="jobcard" placeholder="Enter Your Job Card" autofocus>
											<div class="input-group-btn">
      											<button class="btn btn-default" type="button" id="btnjobcardnext">
        											<i class="fa fa-arrow-right"></i>
      											</button>
    										</div>
  										</div>
            						</div>
            						<div class="multitab">
            							<div class="input-group">
    										<div class="input-group-btn">
      											<button class="btn btn-default" type="button" id="btnemployeeprev">
        											<i class="fa fa-arrow-left"></i>
      											</button>
    										</div>
    										<input id="employee" type="text" class="form-control" name="employee" placeholder="Enter Your Employee Id">
											<div class="input-group-btn">
      											<button class="btn btn-default" type="button" id="btnemployeesearch">
        											<i class="fa fa-search"></i>
      											</button>
    										</div>
  										</div>
            						</div>
            					</div>
            				</div>
            				<div class="row rowgap">
								<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
									Job Card Details
								</div>
								<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
									<input type="text" name="vehicledetails" id="vehicledetails" class="form-control" readonly>
								</div>
							</div>
							<div class="row rowgap">
								<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
									Employee Name
								</div>
								<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
									<input type="text" name="employeename" id="employeename" class="form-control" readonly>
								</div>
							</div>
							<div class="row rowgap">
								<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
									Active Job Details
								</div>
								<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
									<input type="text" name="activejobdetails" id="activejobdetails" class="form-control" readonly>
								</div>
							</div>
							<div class="row rowgap hidden">
								<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
									Bay
								</div>
								<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
									<select name="cmbbay" id="cmbbay" class="form-control" style="width:100%;">
										<option value="">--Select--</option>
									</select>
								</div>
							</div>
            				<div class="row rowgap">
								<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">
									<button type="button" id="btnok" class="btn btn-default">OK</button>
									<button type="button" id="btnclear" class="btn btn-default">CLEAR</button>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
									<h4 class="validatemsgs" style="text-align:center;"><span></span></h4>
								</div>
							</div>
          				</div>
          				<div class="modal-footer">
            				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          				</div>
        			</div>
      			</div>
    		</div>
		</div>
	<input type="hidden" name="actionstatus" id="actionstatus">
	<input type="hidden" name="autosubmitconfig" id="autosubmitconfig">
	
	<script src="../vendors/bootstrap-v3/js/bootstrap.min.js"></script>
	<script src="../vendors/select2/js/select2.min.js"></script>
	<script src="../vendors/sweetalert2/7.0/sweetalert2.all.min.js"></script>
	
	<script type="text/javascript">
	$(document).ready(function(){
		$('#cmbbay').select2({
			placeholder:'Select Bay',
			allowClear:true
		});
		getInitData();
		$('.load-wrapp').hide();
		$('#modalclockin').modal('show');
		$('#btnjobcardnext').click(function(){
			var jobcard=$('#jobcard').val();
			if(jobcard=="" || jobcard=="0"){
				$('.validatemsgs span').removeClass().addClass('label label-danger').text('Please enter valid Jobcard');
				return false;
			}
			getVehicleData();
		});
		$('#jobcard').on("keypress", function(e) {
	        if (e.keyCode == 13) {
	        	var jobcard=$('#jobcard').val();
	        	if(jobcard=="" || jobcard=="0"){
					$('.validatemsgs span').removeClass().addClass('label label-danger').text('Please enter valid Jobcard');
					return false;
				}
	        	getVehicleData();
	            return false; // prevent the button click from happening
	        }
		});
		$('#employee').on("keypress", function(e) {
	        if (e.keyCode == 13) {
	            getEmployeeData();
	            return false; // prevent the button click from happening
	        }
		});
		$('#btnemployeeprev').click(function(){
			currentTab=0;
			showTab(currentTab);
		});
		$('#btnemployeesearch').click(function(){
			getEmployeeData();
		});
		$('#btnok').click(function(){
        	//validateData();
        	var jobcard=$('#jobcard').val();
        	var employee=$('#employee').val();
        	var actionstatus=$('#actionstatus').val();
        	if(jobcard=="" || jobcard=="0"){
				$('.validatemsgs span').removeClass().addClass('label label-danger').text('Please enter valid Jobcard');
				return false;
			}
			if(employee=="" || employee=="0"){
				$('.validatemsgs span').removeClass().addClass('label label-danger').text('Please enter valid Employee');
				return false;
			}
        	insertClockIn(jobcard,employee,actionstatus);
        });
        $('#btnclear').click(function(){
        	funClearData(1);
        });
        
	});
	
	function funClearData(mode){
		if(mode=="1"){
			$('#jobcard,#employee,#vehicledetails,#employeename,#activejobdetails').val('');
	        showTab(0,'next');
	        $('.validatemsgs span').removeClass().text('');	
		}
		else{
			$('#jobcard,#employee,#vehicledetails,#employeename,#activejobdetails').val('');
	        showTab(0,'next');
			setTimeout(funClearMsg, 5000);
		}
	}
	
	function funClearMsg(){
		$('.validatemsgs span').removeClass().text('');	
	}
	function getInitData(){
		$.get('getInitData.jsp',function(data){
			data=JSON.parse(data);
			$('#autosubmitconfig').val(data.autosubmitconfig);
			if(data.bayconfig=="0"){
				if($('#cmbbay').closest('.row').hasClass('hidden')){
				}
				else{
					$('#cmbbay').closest('.row').addClass('hidden');
				}
			}
			else{
				$('#cmbbay').closest('.row').removeClass('hidden');
			}
			
			var htmldata='<option value="">--Select--</option>';
			$.each(data.baydata,function(index,value){
				htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
			});
			$('#cmbbay').attr('data-config',data.bayconfig);
			$('#cmbbay').html($.parseHTML(htmldata));
			$('#cmbbay').select2({
				placeholder:'Select Bay',
				allowClear:true
			});	
		});
	}
	function validateData(){
		var jobcard=$('#jobcard').val();
		if(jobcard==""){
			/*swal({
				type: 'error',
				title: 'Warning',
				text: 'Please enter valid Jobcard'
			});*/
			$('.validatemsgs span').removeClass().addClass('label label-danger').text('Please enter valid Jobcard');
			return false;
		}
		var employee=$('#employee').val();
		if(employee==""){
			/*swal({
				type: 'error',
				title: 'Warning',
				text: 'Please enter valid Employee'
			});*/
			$('.validatemsgs span').removeClass().addClass('label label-danger').text('Please enter valid Employee');
			return false;
		}
		
		validateDataAjax(jobcard,employee);
	}
	function validateDataAjax(jobcard,employee){
		if(jobcard=="" || jobcard=="0" || employee=="" || employee=="0"){
			$('.validatemsgs span').removeClass().addClass('label label-danger').text("Please enter valid details");
			return false;	
		}
		else{
			$('.validatemsgs span').removeClass().addClass('label label-danger').text("");
		}
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split("::");
				var actionstatus=items[2];
				document.getElementById("actionstatus").value=items[2];
				if(items[0]=="0"){
					/*Swal({
  						title: 'Message',
  						text: items[1],
  						type: 'success',
						showCancelButton: true,
  						confirmButtonColor: '#3085d6',
  						cancelButtonColor: '#d33',
  						confirmButtonText: 'Confirm'
					}).then((result) => {
  						if (result.value) {
						    insertClockIn(jobcard,employee,actionstatus);
  						}
					})*/
					$('.validatemsgs span').removeClass().addClass('label label-primary').text(items[1]);	
					if($('#autosubmitconfig').val()=="1"){
						$('#btnok').trigger('click');
					}
				}
				else{
					/*swal({
						type: 'error',
						title: 'Warning',
						text: items[1]
					});*/
					$('.validatemsgs span').removeClass().addClass('label label-danger').text(items[1]);	
				}
				
			}
			else
			{
			}
		}
		x.open("GET","validateDataAjax.jsp?jobcard="+jobcard+"&employee="+employee,true);
		x.send();
	}
	function insertClockIn(jobcard,employee,actionstatus){
		var baydocno=$('#cmbbay').val();
		var bayconfig=$('#cmbbay').attr('data-config');
    	$('.load-wrapp').show();
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split("::");
				$('.load-wrapp').hide();
				if(items[0]=="0"){
					/*swal({
						type: 'success',
						title: 'Message',
						text: items[1]
					});*/
					$('.validatemsgs span').removeClass().addClass('label label-success').text(items[1]);
					//$('#btnclear').trigger('click');
					funClearData(2);
					$('#cmbbay').val(null).trigger('change');
					$('#jobcard').focus();
				}
				else{
					/*swal({
						type: 'error',
						title: 'Warning',
						text: items[1]
					});*/
					$('.validatemsgs span').removeClass().addClass('label label-danger').text(items[1]);
				}
			}
			else
			{
			}
		}
		x.open("GET","insertClockIn.jsp?baydocno="+baydocno+"&bayconfig="+bayconfig+"&jobcard="+jobcard+"&employee="+employee+"&actionstatus="+actionstatus,true);
		x.send();
    }
	var currentTab=0;
	showTab(currentTab,'next');
	function showTab(index,direction){
		$('.multitab').css('display','none');
		var multitabs = document.getElementsByClassName("multitab");
  		multitabs[index].style.display = "block";
	}
	function getVehicleData(){
		var jobcard=$('#jobcard').val();
	  	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				if(items.split("::")[2]==""){
					$('#vehicledetails').val(items.split("::")[1]);
					currentTab=1;
					showTab(currentTab,'next');
					$( "#employee" ).focus();
					$('.validatemsgs span').removeClass().text('');
				}
				else{
					/*swal({
						type: 'error',
						title: 'Warning',
						text: items.split("::")[2]
					});*/
					$('.validatemsgs span').removeClass().addClass('label label-danger').text(items.split("::")[2]);
					$( "#jobcard" ).focus();
				}
				
			}
			else
			{
			}
		}
	x.open("GET","getVehicleDetails.jsp?jobcard="+jobcard,true);
	x.send();
	}
	
	function getEmployeeData(){
		var employee=$('#employee').val();
	  	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				if(items==""){
					$('.validatemsgs span').removeClass().addClass('label label-danger').text("No Employee Found");
					return false;
				}
				$('#employeename').val(items);
				if($('#employeename').val()!=''){
					getActiveJobCardDetails();
				}
				validateData();
			}
			else
			{
			}
		}
	x.open("GET","getEmployeeName.jsp?employee="+employee,true);
	x.send();
	}
	function getActiveJobCardDetails(){
		var employee=$('#employee').val();
		var jobcard=$('#jobcard').val();
	  	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				$('#activejobdetails').val(items);
			}
			else
			{
			}
		}
	x.open("GET","getActiveJobCardDetails.jsp?employee="+employee+"&jobcard="+jobcard,true);
	x.send();
	}
</script>
</body>
</html>