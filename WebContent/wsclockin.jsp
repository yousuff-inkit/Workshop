<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>Job Clock In/Out</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css">
<jsp:include page="floorMgmtIncludes.jsp"></jsp:include>
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
<style type="text/css">
	.rowgap{
		margin-bottom:8px;
	}
</style>

</head>
<body>
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
								<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
									Job Card #
								</div>
								<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
									<select class="cmbjobcard" name="cmbjobcard" style="width: 100%" id="cmbjobcard" onchange="getVehicleData();">
  										<option value="">--Select--</option>
									</select>
								</div>
							</div>
							<div class="row rowgap">
								<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
								</div>
								<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
									<input type="text" name="vehicledetails" id="vehicledetails" class="form-control" readonly>
								</div>
							</div>
							<div class="row rowgap">
								<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
									Employee #
								</div>
								<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
									<select class="cmbemployee" name="cmbemployee" style="width: 100%" id="cmbemployee" >
  										<option value="">--Select--</option>
									</select>
								</div>
							</div>
							<div class="row rowgap">
								<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
								</div>
								<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
									<label class="radio-inline"><input type="radio" name="optclocktype" checked id="rdoclockin">In</label>
									<label class="radio-inline"><input type="radio" name="optclocktype" id="rdoclockout">Out</label>
								</div>
							</div>
							<div class="row rowgap">
								<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
									Date &amp; Time
								</div>
								<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
									<div class="row">
										<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
											<div id="date"></div>
										</div>
										<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
											<div id="time"></div>
										</div>
									</div>
								</div>
							</div>
							<div class="row rowgap">
								<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">
									<button type="button" id="btnok" class="btn btn-default">OK</button>
									<button type="button" id="btnclear" class="btn btn-default">CLEAR</button>
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

	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.24.4/dist/sweetalert2.all.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){
		$("#date").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
        $("#time").jqxDateTimeInput({ width: '80px', height: '15px', formatString:"HH:mm",showCalendarButton:false,value:new Date()});
        $('.cmbjobcard,.cmbemployee').select2();
        getJobCard();
        getEmployee();
        $('#modalclockin').modal('show');
        $('#btnclear').click(function(){
        	$('.cmbjobcard,.cmbemployee').val(null).trigger('change');
        	$('#rdoclockin').attr('checked',true);
			$('#date,#time').jqxDateTimeInput('setDate',new Date());
        });
        $('#btnok').click(function(){
        	validateData();
        });
	});
	
	function validateData(){
		var cmbjobcard=$('#cmbjobcard').val();
		if(cmbjobcard==""){
			swal({
				type: 'error',
				title: 'Warning',
				text: 'Please select Jobcard'
			});
			return false;
		}
		var cmbemployee=$('#cmbemployee').val();
		if(cmbjobcard==""){
			swal({
				type: 'error',
				title: 'Warning',
				text: 'Please select Employee'
			});
			return false;
		}
		var date=$('#date').jqxDateTimeInput('getDate');
		if(date==null){
			swal({
				type: 'error',
				title: 'Warning',
				text: 'Please select Date'
			});
			return false;
		}
		var time=$('#time').jqxDateTimeInput('getDate');
		if(time==null){
			swal({
				type: 'error',
				title: 'Warning',
				text: 'Please select Time'
			});
			return false;
		}
		date=$('#date').jqxDateTimeInput('val');
		time=$('#time').jqxDateTimeInput('val');
		var clocktype="";
		if($('#rdoclockin').is(":checked")){
			clocktype="1";
		}
		else{
			clocktype="2";
		}
		validateDataAjax(cmbjobcard,cmbemployee,clocktype,date,time);
	}
	function validateDataAjax(cmbjobcard,cmbemployee,clocktype,date,time){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split("::");
				if(items[0]=="0"){
					Swal({
  						title: 'Message',
  						text: items[1],
  						type: 'success',
						showCancelButton: true,
  						confirmButtonColor: '#3085d6',
  						cancelButtonColor: '#d33',
  						confirmButtonText: 'Confirm'
					}).then((result) => {
  						if (result.value) {
						    insertClockIn(cmbjobcard,cmbemployee,clocktype,date,time);
  						}
					})	
				}
				else{
					swal({
						type: 'error',
						title: 'Warning',
						text: items[1]
					});
				}
				
			}
			else
			{
			}
		}
		x.open("GET","validateClockData.jsp?cmbjobcard="+cmbjobcard+"&cmbemployee="+cmbemployee+"&clocktype="+clocktype+"&date="+date+"&time="+time,true);
		x.send();
	}
	function insertClockIn(cmbjobcard,cmbemployee,clocktype,date,time){
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split("::");
				if(items[0]=="0"){
					swal({
						type: 'success',
						title: 'Message',
						text: items[1]
					});
					$('#btnclear').trigger('click');
				}
				else{
					swal({
						type: 'error',
						title: 'Warning',
						text: items[1]
					});
				}
			}
			else
			{
			}
		}
		x.open("GET","insertClockIn.jsp?cmbjobcard="+cmbjobcard+"&cmbemployee="+cmbemployee+"&clocktype="+clocktype+"&date="+date+"&time="+time,true);
		x.send();
    }
	function getJobCard(){
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split(",");
				var str='<option value="">--Select--</option>';
				for(var i=0;i<items.length;i++){
					str+='<option value="'+items[i].split("::")[0]+'">'+items[i].split("::")[1]+'</option>';
				}
				$('.cmbjobcard').html(str);	
			}
			else
			{
			}
		}
		x.open("GET","getJobCard.jsp",true);
		x.send();
    }
    function getEmployee(){
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split(",");
				var str='<option value="">--Select--</option>';
				for(var i=0;i<items.length;i++){
					str+='<option value="'+items[i].split("::")[0]+'">'+items[i].split("::")[1]+'</option>';
				}
				$('.cmbemployee').html(str);	
			}
			else
			{
			}
		}
		x.open("GET","getTechnician.jsp",true);
		x.send();
    }
    function getVehicleData(){
    	var jobcard=$('#cmbjobcard').val();
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				$('#vehicledetails').val(items);
			}
			else
			{
			}
		}
		x.open("GET","getVehicleDetails.jsp?jobcard="+jobcard,true);
		x.send();
    }
</script>
</body>
</html>