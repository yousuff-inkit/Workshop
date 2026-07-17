<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="com.dashboard.workshop.floormgmt.*" %>
<%ClsFloorMgmtDAO floordao=new ClsFloorMgmtDAO();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Floor Management</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<jsp:include page="../reportincludes.jsp"></jsp:include>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="../vendors/clockpicker/jquery-clockpicker.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css">
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
<link rel="stylesheet" href="../workshopapp/css/util.css">
<link rel="stylesheet" href="../vendors/clockpicker/jquery-clockpicker.min.css">


<style type="text/css">
	:root {
  		--main-bg-color:#0c447f;
  		--main-sec-color:#fff;
	}
	@font-face {
		font-family: Poppins-Regular;
	  	src: url('../workshopapp/fonts/poppins/Poppins-Regular.ttf'); 
	}
	
	@font-face {
	  	font-family: Poppins-Medium;
	  	src: url('../workshopapp/fonts/poppins/Poppins-Medium.ttf'); 
	}
	
	@font-face {
	  	font-family: Montserrat-Medium;
	  	src: url('../workshopapp/fonts/montserrat/Montserrat-Medium.ttf'); 
	}
	
	@font-face {
	  	font-family: Montserrat-SemiBold;
	  	src: url('../workshopapp/fonts/montserrat/Montserrat-SemiBold.ttf'); 
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
	.page-loader{
		position:fixed;
		top:50%;
		left:50%;
		transform:translate(-50%,-50%);
	}
	.nav-pills>li.active>a, .nav-pills>li.active>a:focus, .nav-pills>li.active>a:hover {
		background-color:var(--main-bg-color);
		color:var(--main-sec-color);
	}
	ul.list-group li.list-group-item{
		cursor:pointer;
	}
</style>
<script type="text/javascript">
	function preventBack() { window.history.forward(); }
    setTimeout("preventBack()", 0);
    window.onunload = function () { null };
</script>
</head>
<body>
	<div class="page-loader hidden">
		<button type="button" class="btn btn-default btn-primary">Loading <i class="fa fa-circle-o-notch fa-spin fa-fw"></i></button>
	</div>
	<nav class="navbar navbar-default navbar-fixed-top">
  		<div class="container-fluid">
    		<div class="navbar-header">
      			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        			<span class="icon-bar"></span>
        			<span class="icon-bar"></span>
        			<span class="icon-bar"></span>
      			</button>
      			<a class="navbar-brand" href="#">Floor App</a>
    		</div>
    		<div class="collapse navbar-collapse" id="myNavbar">
     			<ul class="nav navbar-nav navbar-right">
        			<li class="dropdown">
          				<a class="dropdown-toggle user-dropdown" data-toggle="dropdown" href="#"><i class="fa fa-user"></i> <span class="user-dropdown-text">User</span><span class="caret"></span></a>
        				<ul class="dropdown-menu">
          					<li><a href="#" onclick="location.replace('index.jsp');"><i class="fa fa-lock"></i> Sign Out</a></li>
        				</ul>
      				</li>
      			</ul>
    		</div>
  		</div>
	</nav>
	<div class="container-fluid m-t-60">
		<form autocomplete="off">
		<div class="form-horizontal">
			<div class="form-group">
    			<label class="control-label col-sm-2" for="cmbbranch">Branch:</label>
    			<div class="col-sm-10">
      				<select class="form-control" name="cmbbranch" id="cmbbranch"><option value="">--Select--</option></select>
    			</div>
  			</div>
  			<div class="form-group">
    			<label class="control-label col-sm-2" for="">Reg No:</label>
    			<div class="col-sm-4">
      				<input type="text" name="regno" id="regno" placeholder="Reg No" class="form-control" autocomplete="off">
    				<ul class="list-group" id="regnolist" style="max-height:250px;overflow-y:auto;"></ul>
    			</div>
    			<label class="control-label col-sm-2" for="">Job No:</label>
    			<div class="col-sm-4">
      				<input type="text" name="jobno" id="jobno" placeholder="Job No" class="form-control">
    				<ul class="list-group" id="jobnolist" style="max-height:250px;overflow-y:auto;"></ul>
    			</div>
  			</div>
		</div>
		<ul class="nav nav-pills nav-justified">
  			<li class="active"><a data-toggle="pill" href="#menujobplan">Job Plan</a></li>
  			<li><a data-toggle="pill" href="#menuvehmove">Vehicle Movement</a></li>
		</ul>
		<div class="tab-content">
			<div class="tab-pane fade in active" id="menujobplan">
				<div class="panel panel-default">
					<div class="panel-body">
						<div class="form-horizontal">
							<div class="form-group">
								<div class="col-sm-12">
									<div id="jobplandiv"><jsp:include page="bayGrid.jsp"></jsp:include></div>
								</div>
							</div>
							<div class="form-group">
				    			<div class="col-sm-12">
				    				<div id="serviceteamdiv"><jsp:include page="serviceTeamGrid.jsp"></jsp:include></div>
				    			</div>
				  			</div>
						</div>			
						
					</div>
					<div class="panel-footer text-right">
						<button type="button" class="btn btn-default btn-primary" name="btnjobplan" id="btnjobplan">Save Changes</button>
					</div>
				</div>
				
			</div>
			<div class="tab-pane fade" id="menuvehmove">
				<div class="panel panel-default">
					<div class="panel-body">
						<div class="form-horizontal">
							<div class="form-group">
				    			<label class="control-label col-sm-2" for="bay">Bay:</label>
				    			<div class="col-sm-10">
				      				<input type="text" name="bay" id="bay" placeholder="Bay" class="form-control">
    								<ul class="list-group" id="baylist" style="max-height:250px;overflow-y:auto;"></ul>
				    			</div>
				  			</div>
				  			<div class="form-group">
				    			<label class="control-label col-sm-2" for="baymovupdateindate">In Date &amp; Time:</label>
				    			<div class="col-sm-10">
				      				<div class="row">
			            				<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6"><div id="baymovupdateindate"></div></div>
			            				<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
			            					<!-- <div id="baymovupdateintime"></div> -->
			            					<div id="baymovupdateintime" class="input-group" data-placement="bottom" data-align="bottom" data-autoclose="true">
    											<input type="text" class="form-control">
    											<span class="input-group-addon">
        											<span class="glyphicon glyphicon-time"></span>
    											</span>
											</div>
			            				</div>
			            			</div>
				    			</div>
				  			</div>
				  			<div class="form-group">
				    			<label class="control-label col-sm-2" for="baymovupdateoutdate">Out Date &amp; Time:</label>
				    			<div class="col-sm-10">
				      				<div class="row">
			            				<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6"><div id="baymovupdateoutdate"></div></div>
			            				<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
			            					<!-- <div id="baymovupdateouttime"></div> -->
			            					<div id="baymovupdateouttime" class="input-group" data-placement="bottom" data-align="bottom" data-autoclose="true">
    											<input type="text" class="form-control">
    											<span class="input-group-addon">
        											<span class="glyphicon glyphicon-time"></span>
    											</span>
											</div>
			            				</div>
			            			</div>
				    			</div>
				  			</div>
				  			<div class="form-group">
				    			<label class="control-label col-sm-2" for="cmbbaystatus">Status:</label>
				    			<div class="col-sm-10">
		            				<select name="cmbbaystatus" id="cmbbaystatus" class="form-control">
		            					<option value="S">Started</option>
		            					<option value="C" selected>Completed</option>
		            					<option value="N">Not Attended</option>
		            				</select>
				    			</div>
				  			</div>
				  			<div class="form-group">
				    			<label class="control-label col-sm-2" for="baymovupdateoutdate">Remarks:</label>
				    			<div class="col-sm-10">
			            			<input type="text" name="vehmovremarks" id="vehmovremarks" placeholder="Remarks" class="form-control">
				    			</div>
				  			</div>
						</div>
					</div>
					<div class="panel-footer text-right">
						<button type="button" class="btn btn-default btn-primary" name="btnvehmove" id="btnvehmove">Save Changes</button>
					</div>
				</div>
				<div class="panel panel-default">
					<div class="panel-header"></div>
					<div class="panel-body">
						<div class="table-responsive">
							<table class="table table-stripped table-hover" id="tblbaystatus">
								<thead>
									<tr>
										<th>Bay</th>
										<th>In Details</th>
										<th>Out Details</th>
										<th>Status</th>
									</tr>
								</thead>
								<tbody>
									
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
		</form>
	</div>
	<input type="hidden" id="jobdocno">
	<input type="hidden" id="jobvocno" class="form-control"> 
	<script src="../js/sweetalert2.all.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
	<script type="text/javascript">
	
			function getBranchData(){
				$.ajax({
					async:false,
					url: "getBranchData.jsp",success: function(data){
						data=JSON.parse(data);
						var htmldata='<option value="">Select Branch</option>';
						$.each(data.branchdata,function(index,value){
							htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
						});
						$('#cmbbranch').html($.parseHTML(htmldata));
						$('#cmbbranch option').eq(1).attr('selected','selected');
						getInitData();
					}
				});
			}
		function clickJobHandler(jobdocno,listname){
			var jobtext=$(listname).find("[data-docno='" + jobdocno + "']").html();
			var brhid=$('#cmbbranch').val();
			$(listname).closest('div').find('input').val(jobtext);
			$('#jobplandiv').load('bayGrid.jsp?id=1&jobno='+jobdocno+'&brhid='+brhid);
			$('#serviceteamdiv').load('serviceTeamGrid.jsp?id=1&brhid='+brhid);
			getCommonData();
			
			$.get('getBayData.jsp',{'jobdocno':jobdocno},function(data){
				data=JSON.parse(data);
				var bayhtml='';
				$.each(data.baydata,function(index,value){
					bayhtml+='<li class="list-group-item" data-docno="'+value.docno+'">'+value.name+'</li>';
				});
				$('#baylist').html($.parseHTML(bayhtml));
				$('#baylist li').click(function(){
					$('#bay').val($(this).html());
					$('#bay').attr('data-docno',$(this).attr('data-docno'));
					$('#baylist').hide();
					return false;
				});
				if(data.invaliddata=="0"){
					$('#baymovupdateindate').jqxDateTimeInput('val',data.indate);
					$('#baymovupdateintime input').prop('value',data.intime);
					$('#baymovupdateoutdate').jqxDateTimeInput('val',data.outdate);
					$('#baymovupdateouttime input').prop('value',data.outtime);
				}
			});
		}
		
		
		function getInitData(){
			$.get('getInitData.jsp',{'brhid':$('#cmbbranch').val()},function(data){
				data=JSON.parse(data);
				$('.user-dropdown .user-dropdown-text').text(data.username);
				
				var htmldata='';
				$.each(data.regnodata,function(index,value){
					htmldata+='<li class="list-group-item" data-docno="'+value.jobdocno+'" data-vocno="'+value.jobvocno+'">'+value.refname+'</li>';
				});
				
				$('#regnolist').html($.parseHTML(htmldata));
				$('#regnolist li').click(function(){
					$('input').val('');
					var elm=this;
					$('#jobdocno').val($(elm).attr('data-docno'));
					$('#jobvocno').val($(elm).attr('data-vocno'));
					$('#regno').val($(elm).text());
					$('#regnolist').hide();
					var jobdocno=$('#jobdocno').val();
					clickJobHandler(jobdocno,'#jobnolist');					
					return false;
				});
				
				htmldata='';
				$.each(data.jobnodata,function(index,value){
					htmldata+='<li class="list-group-item" data-docno="'+value.jobdocno+'" data-vocno="'+value.jobvocno+'">'+value.jobvocno+'</li>';
				});
				
				$('#jobnolist').html($.parseHTML(htmldata));
				$('#jobnolist li').click(function(){
					$('input').val('');
					var elm=this;
					$('#jobdocno').val($(elm).attr('data-docno'));
					$('#jobvocno').val($(elm).attr('data-vocno'));
					$('#jobno').val($(elm).text());
					var jobdocno=$('#jobdocno').val();
					$('#jobnolist').hide();
					clickJobHandler(jobdocno,'#regnolist');
					return false;
				});
				
			});
		}
		function getCommonData(){
			//gets called after every action
			var htmldata='';
			$.get('getCommonData.jsp',{'jobdocno':$('#jobdocno').val()},function(data){
				data=JSON.parse(data);
				$.each(data.baydetails,function(index,value){
					htmldata+='<tr>';
					htmldata+='<td>'+value.bayname+'</td>';
					htmldata+='<td>'+value.indetails+'</td>';
					if(value.outdetails=='undefined' || typeof(value.outdetails)=='undefined'){
						htmldata+='<td>&nbsp;</td>';
					}
					else{
						htmldata+='<td>'+value.outdetails+'</td>';
					}
					
					htmldata+='<td>'+value.baystatus+'</td>';
					htmldata+='</tr>';
				});
				$('#tblbaystatus tbody').html($.parseHTML(htmldata));
			});
		}
		$(document).ready(function(){
			$("#baymovupdateindate").jqxDateTimeInput({ width: '125px', height: '24px', formatString:"dd.MM.yyyy"});
        	//$("#baymovupdateintime").jqxDateTimeInput({ width: '80px', height: '24px', formatString:"HH:mm",showTimeButton:true,showCalendarButton:false,value:new Date()});
        	$('#baymovupdateintime').clockpicker({
			    placement: 'bottom',
			    align: 'bottom',
			    donetext: 'Done',
			    'default':'now',
			    afterDone: function() {
                	var outdate=new Date($('#baymovupdateindate').jqxDateTimeInput('getDate'));
                	var outtime=$('#baymovupdateintime input.form-control').val();
                	var curdate=new Date();
                	outdate.setHours(0,0,0,0);
                	curdate.setHours(0,0,0,0);
                	if(outdate-curdate==0){
                		var curtime=new Date();
                		if(parseInt(outtime.split(':')[0])>curtime.getHours()){
                			Swal.fire({
								type: 'error',
								title: 'Warning',
								text: 'Future Date, Transaction Restricted.'
							});
							$('#baymovupdateintime input.form-control').val(getTimeString(new Date()));
							return false;
                		}
                		else if(parseInt(outtime.split(':')[0])==curtime.getHours()){
                			if(parseInt(outtime.split(':')[1])>curtime.getMinutes()){
	                			Swal.fire({
									type: 'error',
									title: 'Warning',
									text: 'Future Date, Transaction Restricted.'
								});
								$('#baymovupdateintime input.form-control').val(getTimeString(new Date()));
								return false;
	                		}	
                		}
                	}
                }
			});
			$('#baymovupdateintime input.form-control').val(getTimeString(new Date()));
        	$("#baymovupdateoutdate").jqxDateTimeInput({ width: '125px', height: '24px', formatString:"dd.MM.yyyy"});
        	//$("#baymovupdateouttime").jqxDateTimeInput({ width: '80px', height: '24px', formatString:"HH:mm",showTimeButton:true,showCalendarButton:false,value:new Date()});
			$('#baymovupdateouttime').clockpicker({
			    placement: 'bottom',
			    align: 'bottom',
			    donetext: 'Done',
			    'default':'now',
			    afterDone: function() {
                	var outdate=new Date($('#baymovupdateoutdate').jqxDateTimeInput('getDate'));
                	var outtime=$('#baymovupdateouttime input.form-control').val();
                	var curdate=new Date();
                	outdate.setHours(0,0,0,0);
                	curdate.setHours(0,0,0,0);
                	if(outdate-curdate==0){
                		var curtime=new Date();
                		if(parseInt(outtime.split(':')[0])>curtime.getHours()){
                			Swal.fire({
								type: 'error',
								title: 'Warning',
								text: 'Future Date, Transaction Restricted.'
							});
							$('#baymovupdateouttime input.form-control').val(getTimeString(new Date()));
							return false;
                		}
                		else if(parseInt(outtime.split(':')[0])==curtime.getHours()){
                			if(parseInt(outtime.split(':')[1])>curtime.getMinutes()){
	                			Swal.fire({
									type: 'error',
									title: 'Warning',
									text: 'Future Date, Transaction Restricted.'
								});
								$('#baymovupdateouttime input.form-control').val(getTimeString(new Date()));
								return false;
	                		}	
                		}
                	}
                }
			});
			$('#baymovupdateouttime input.form-control').val(getTimeString(new Date()));
			$('#baymovupdateindate').on('change', function (event) 
			{  
			    var jsDate = event.args.date; 
			    var type = event.args.type; // keyboard, mouse or null depending on how the date was selected.
				var datevalid=funDateInPeriod(new Date($('#baymovupdateindate').jqxDateTimeInput('getDate')));
				if(datevalid==0){
					$('#baymovupdateindate').jqxDateTimeInput('setDate',new Date());
					return false;
				}
			});
			$('#baymovupdateoutdate').on('change', function (event) 
			{  
			    var jsDate = event.args.date; 
			    var type = event.args.type; // keyboard, mouse or null depending on how the date was selected.
				var datevalid=funDateInPeriod(new Date($('#baymovupdateoutdate').jqxDateTimeInput('getDate')));
				if(datevalid==0){
					$('#baymovupdateoutdate').jqxDateTimeInput('setDate',new Date());
					return false;
				}
			}); 
			$('ul.list-group').hide();
			getBranchData();
			$('#cmbbranch').change(function(){
				$('input').val('');
				$('#tblbaystatus tbody').html('');
				$('#bayGrid').jqxGrid('clear');
				$('#serviceTeamGrid').jqxGrid('clear');
				$('#baymovupdateindate,#baymovupdateoutdate').jqxDateTimeInput('setDate',new Date());
				$('a[href="#menujobplan"]').trigger('click');
				getInitData();
			});
			
			$('#regno,#jobno,#technician,#bay').click(function(){
				$('ul.list-group').hide();
				$(this).closest('div').find('ul.list-group').show();
			});
			$('#regno,#jobno,#technician,#bay').on("keyup", function() {
    			var value = $(this).val().toLowerCase();
    			var li=$(this).closest('div').find('ul.list-group li');
				for (i = 0; i < li.length; i++) {
    				var a = li[i];
    				//.getElementsByTagName("a")[0];
    				var txtValue = a.textContent || a.innerText;
    				if (txtValue.toUpperCase().indexOf(value) > -1) {
      					li[i].style.display = "";
    				} else {
      					li[i].style.display = "none";
    				}
  				}
  			});
			
			$('#btnjobplan').click(function(){
				var jobdocno=$('#jobdocno').val();
				var jobvocno=$('#jobvocno').val();
				
				if($('#jobdocno').val()==''){
					Swal.fire({
						type: 'error',
						title: 'Warning',
						text: 'Please select a document'
					});
	        		return false;
				}
				var teamrows=$('#serviceTeamGrid').jqxGrid('getselectedrowindexes');
				if(teamrows.length==0){
					Swal.fire({
						type: 'error',
						title: 'Warning',
						text: 'Please select a technician'
					});
	        		return false;
				}
				Swal.fire({
		  			title: 'Are you sure?',
		  			text: "Do you want to update jobplan of "+jobvocno+"?",
		  			icon: 'warning',
		  			showCancelButton: true,
		  			confirmButtonColor: '#3085d6',
		  			cancelButtonColor: '#d33',
		  			confirmButtonText: 'Yes'
				}).then((result) => {
		  			if (result.isConfirmed) {
		  				//Updating Job Planning
						var bayarray=new Array();
						var teamarray=new Array();
						var bayrows=$('#bayGrid').jqxGrid('getselectedrowindexes');
						for(var i=0;i<bayrows.length;i++){
							bayarray.push($('#bayGrid').jqxGrid('getcellvalue',bayrows[i],'doc_no')+"::"+$('#bayGrid').jqxGrid('getcellvalue',bayrows[i],'seqno'));
						}
						for(var i=0;i<teamrows.length;i++){
							teamarray.push($('#serviceTeamGrid').jqxGrid('getcellvalue',teamrows[i],'docno'));
						}
						var x=new XMLHttpRequest();
						x.onreadystatechange=function(){
							if (x.readyState==4 && x.status==200){
								var items=x.responseText.trim();
								var data=JSON.parse(items);
								if(data.errorstatus=="0"){
			    					Swal.fire({
										type: 'success',
										title: 'Success',
										text: 'Updated Successfully'
									});
									$.get('getBayData.jsp',{'jobdocno':jobdocno},function(data){
										data=JSON.parse(data);
										var bayhtml='';
										$.each(data.baydata,function(index,value){
											bayhtml+='<li class="list-group-item" data-docno="'+value.docno+'">'+value.name+'</li>';
										});
										$('#baylist').html($.parseHTML(bayhtml));
										$('#baylist li').click(function(){
											$('#bay').val($(this).html());
											$('#bay').attr('data-docno',$(this).attr('data-docno'));
											$('#baylist').hide();
											return false;
										});
									});
								}
								else{
			    					Swal.fire({
										type: 'error',
										title: 'Warning',
										text: 'Not Updated'
									});
									return false;
			    				}
							}
						}
						x.open("GET","updateData.jsp?jobdocno="+jobdocno+"&bayarray="+bayarray+"&teamarray="+teamarray+"&baylength="+bayarray.length+"&teamlength="+teamarray.length,true);	 		
						x.send();
		  			}
				});
			});
			
			$('#btnvehmove').click(function(){
				var jobdocno=$('#jobdocno').val();
				var jobvocno=$('#jobvocno').val();
				
				if($('#jobdocno').val()==''){
					Swal.fire({
						type: 'error',
						title: 'Warning',
						text: 'Please select a document'
					});
	        		return false;
				}
				if($('#bay').val()=='' || $('#bay').attr('data-docno')=='undefined'){
					Swal.fire({
						type: 'error',
						title: 'Warning',
						text: 'Please select a bay'
					});
	        		return false;
				}
				if($('#baymovupdateindate').jqxDateTimeInput('getDate')!=null && $('#baymovupdateindate').jqxDateTimeInput('getDate')!=''){
					var indatevalid=funDateInPeriod(new Date($('#baymovupdateindate').jqxDateTimeInput('getDate')));
					if(indatevalid==0){
						return false;
					}
					var outdate=new Date($('#baymovupdateindate').jqxDateTimeInput('getDate'));
                	var outtime=$('#baymovupdateintime input.form-control').val();
                	var curdate=new Date();
                	outdate.setHours(0,0,0,0);
                	curdate.setHours(0,0,0,0);
                	if(outdate-curdate==0){
                		var curtime=new Date();
                		if(parseInt(outtime.split(':')[0])>curtime.getHours()){
                			Swal.fire({
								type: 'error',
								title: 'Warning',
								text: 'Future Date, Transaction Restricted.'
							});
							$('#baymovupdateintime input.form-control').val(getTimeString(new Date()));
							return false;
                		}
                		else if(parseInt(outtime.split(':')[0])==curtime.getHours()){
                			if(parseInt(outtime.split(':')[1])>curtime.getMinutes()){
	                			Swal.fire({
									type: 'error',
									title: 'Warning',
									text: 'Future Date, Transaction Restricted.'
								});
								$('#baymovupdateintime input.form-control').val(getTimeString(new Date()));
								return false;
	                		}	
                		}
                	}
				}
				
				if($('#baymovupdateoutdate').jqxDateTimeInput('getDate')!=null && $('#baymovupdateoutdate').jqxDateTimeInput('getDate')!=''){
					var indatevalid=funDateInPeriod(new Date($('#baymovupdateoutdate').jqxDateTimeInput('getDate')));
					if(indatevalid==0){
						return false;
					}
					var outdate=new Date($('#baymovupdateoutdate').jqxDateTimeInput('getDate'));
                	var outtime=$('#baymovupdateouttime input.form-control').val();
                	var curdate=new Date();
                	outdate.setHours(0,0,0,0);
                	curdate.setHours(0,0,0,0);
                	if(outdate-curdate==0){
                		var curtime=new Date();
                		if(parseInt(outtime.split(':')[0])>curtime.getHours()){
                			Swal.fire({
								type: 'error',
								title: 'Warning',
								text: 'Future Date, Transaction Restricted.'
							});
							$('#baymovupdateouttime input.form-control').val(getTimeString(new Date()));
							return false;
                		}
                		else if(parseInt(outtime.split(':')[0])==curtime.getHours()){
                			if(parseInt(outtime.split(':')[1])>curtime.getMinutes()){
	                			Swal.fire({
									type: 'error',
									title: 'Warning',
									text: 'Future Date, Transaction Restricted.'
								});
								$('#baymovupdateouttime input.form-control').val(getTimeString(new Date()));
								return false;
	                		}	
                		}
                	}
				}
			//	alert($('#vehmovremarks').val());
				Swal.fire({
		  			title: 'Are you sure?',
		  			text: "Do you want to update movement of "+jobvocno+"?",
		  			icon: 'warning',
		  			showCancelButton: true,
		  			confirmButtonColor: '#3085d6',
		  			cancelButtonColor: '#d33',
		  			confirmButtonText: 'Yes'
				}).then((result) => {
		  			if (result.isConfirmed) {
										
						var cmbbaymovupdate=$('#bay').attr('data-docno');
		    			var baymovupdateindate=$('#baymovupdateindate').jqxDateTimeInput('val');
		    			var baymovupdateintime=$('#baymovupdateintime input').prop('value');
		    			var baymovupdateoutdate=$('#baymovupdateoutdate').jqxDateTimeInput('val');
		    			var baymovupdateouttime=$('#baymovupdateouttime input').prop('value');
		    			var baymovupdateremarks=$('#vehmovremarks').val();
		    			$.post('bayMovUpdate.jsp',
		    				{	
		    					'simpler':1,
		    					'baystatus':$('#cmbbaystatus').val(),
		    					'jobcarddocno':jobdocno,
		    					'cmbbaymovupdate':cmbbaymovupdate,
		    					'baymovupdateindate':baymovupdateindate,
		    					'baymovupdateintime':baymovupdateintime,
		    					'baymovupdateoutdate':baymovupdateoutdate,
		    					'baymovupdateouttime':baymovupdateouttime,
		    					'baymovupdateremarks':baymovupdateremarks
		    				},
		    				function(items,status){
		    					console.log(items);
		    					if(items.split("::")[0]=="0"){
									Swal.fire({
										type: 'success',
										title: 'Message',
										text: 'Zone Movement Updated'
									});
									if(cmbbaymovupdate=='12'){
										$('input').val('');
										$('#tblbaystatus tbody').html('');
										$('#bayGrid').jqxGrid('clear');
										$('#serviceTeamGrid').jqxGrid('clear');
										$('#baymovupdateindate,#baymovupdateoutdate').jqxDateTimeInput('setDate',new Date());
										$('a[href="#menujobplan"]').trigger('click');
										getInitData();
									}
									getCommonData();
									//$('#btnsubmit').trigger('click');
									
								}
								else{
									Swal.fire({
										type: 'error',
										title: 'Warning',
										text: items.split("::")[1]
									});
								}
		    				}
		    			);
		    		}
		    	});
			});
		});
		
		function funDateInPeriod(value){
	       var currentDate = new Date(new Date());
	       if(value>currentDate){
	        	Swal.fire({
					type: 'error',
					title: 'Warning',
					text: 'Future Date, Transaction Restricted.'
				});
		        return 0;
	       } 
	       return 1;
	    }
	    function getTimeString(datetime){
  			var hours = datetime.getHours();
  			var minutes = datetime.getMinutes();
  			if(parseInt(hours) < 10){
    			hours = "0" + hours;
  			}
  			if(parseInt(minutes) < 10){
    			minutes = "0" + minutes;
  			}
  			return hours + ":"  + minutes;
		};
	</script>
</body>
</html>
