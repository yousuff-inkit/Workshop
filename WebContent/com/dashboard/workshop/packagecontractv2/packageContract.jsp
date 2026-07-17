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
<jsp:include page="../../../../floorMgmtIncludes.jsp"></jsp:include>
<link rel="stylesheet" href="../../../../vendors/bootstrap-v3/css/bootstrap.min.css">
<script src="../../../../vendors/bootstrap-v3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../../../../vendors/animate/animate.css">

<link href="../../../../vendors/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="../../../../vendors/select2/css/select2.min.css" rel="stylesheet" />

  <style type="text/css">
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
    /*.custompanel .buttoncontainer{
    	clear:both;
    	float:left;
    	display:inline-block;
    }
     .custompanel div{
    	float: left;
      	display: inline-block;
      	margin:0;
      	padding:0;
      	width:auto;
    }
    .custompanel button{
       border:none;
    }*/
    .badge-notify{
	   position:absolute;right:-5px;top:-8px;z-index:2;background-color:red;
	} 
	.comment{
      background-image: linear-gradient(120deg, #a1c4fd 0%, #c2e9fb 100%);
      color: #000;
      clear:both;
      float: right;
      display: block;
      padding-top: 8px;
      padding-bottom: 2px;
      padding-left: 10px;
      padding-right: 5px;
      border-radius: 12px;
      border-top-right-radius: 0;
      margin-bottom: 8px;
      transition:all 0.5s ease-in;
    }
    .msg-details{
      text-align: right;
    }
    .comments-container{
      height: 400px;
      overflow-y: auto;
      margin-bottom: 8px;
      padding-right: 5px;
    }
    .comments-outer-container{
      width: 100%;
      height: 100%;
    }
    .msg{
    	word-break:break-all;
    }
    .rowgap{
    	margin-bottom:6px;
    }
    .textpanel p.h4{
   		margin-top: 8px;
    	margin-bottom: 6px;
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
	.form-group.has-error div.col-sm-9 .select2-container--default .select2-selection--single{
		border: 1px solid #a94442;
	}	
	.form-group.has-error div.col-sm-9 span.help-class{
		color:#a94442;
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
  	<div class="container-fluid">
  		<div class="row rowgap">
      		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        		<div class="primarypanel custompanel">
  					<button type="button" class="btn btn-default" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
          			<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
        			<button type="button" class="btn btn-default hidden" id="btninfo" data-toggle="tooltip" title="Info" data-placement="bottom"><i class="fa fa-info-circle " aria-hidden="true"></i></button>
        			<select name="cmbbranch" id="cmbbranch" style="min-width:125px;"><option value="">--Select--</option></select>
        		</div>
        		<div class="actionpanel custompanel">
          			<button type="button" class="btn btn-default" id="btncreatecontract" data-target="#modalcreatecontract"><i class="fa fa-file" aria-hidden="true" data-toggle="tooltip" title="Create Contract" data-placement="bottom"></i></button>
          			<button type="button" class="btn btn-default" id="btncreatesrs"><i class="fa fa-credit-card" aria-hidden="true" data-toggle="tooltip" title="Create Invoice" data-placement="bottom"></i></button>
          			<button type="button" class="btn btn-default" id="btnutil" data-target="#modalutil"><i class="fa fa-tasks" aria-hidden="true" data-toggle="tooltip" title="Utilization Log" data-placement="bottom"></i></button>
        		</div>
        		<div class="warningpanel custompanel">
          			<div class="btn-group" role="group">
          				<button type="button" class="btn btn-default" id="btnpendingsrs" data-toggle="tooltip" title="Pending Invoices" data-placement="bottom" data-filtervalue="0" data-datafield="srsdocno" data-filtertype="numericfilter" data-filtercondition="EQUAL"><i class="fa fa-credit-card-alt" aria-hidden="true"></i></button>
          				<span class="badge badge-notify badge-partsdelay">0</span>
          			</div>
          			<div class="btn-group" role="group">
          				<button type="button" class="btn btn-default" id="btnnotrecieved" data-toggle="tooltip" title="Not Recieved" data-placement="bottom" data-filtervalue="1" data-datafield="outstatus" data-filtertype="numericfilter" data-filtercondition="EQUAL"><i class="fa fa-clock-o" aria-hidden="true"></i></button>
          				<span class="badge badge-notify badge-partsdelay">0</span>
          			</div>	
        		</div>
        		<div class="detailpanel custompanel">
        			<div class="btn-group" role="group">
          				<button type="button" class="btn btn-default" id="btncontractprint" data-toggle="tooltip" title="Contract Print" data-placement="bottom"><i class="fa fa-print " aria-hidden="true"></i></button>
          				<span class="badge badge-notify badge-jobcard">C</span>
          			</div>
        		</div>
        		<div class="otherpanel custompanel">
          			<button type="button" class="btn btn-default" id="btncomment"  data-target="#modalcomments" ><i class="fa fa-comments " aria-hidden="true" data-toggle="tooltip" title="Comments" data-placement="bottom"></i></button>
        		</div>
        		<div class="textpanel custompanel" style="max-width:400px;height:55px;">
					<p style="word-wrap: break-word;font-size:1.2em;">&nbsp;</p>
        		</div>
      		</div>
    	</div>
    	<div class="row">
      		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        		<div id="packagegriddiv"><jsp:include page="packageGrid.jsp"></jsp:include></div>
      		</div>
    	</div>
	</div>
		<!-- Package Contract Create modal -->
		<div id="modalcreatecontract" class="modal fade" role="dialog">
	    	<div class="modal-dialog">
	        	<div class="modal-content">
	          		<div class="modal-header">
	            		<button type="button" class="close" data-dismiss="modal">&times;</button>
	            		<h4 class="modal-title">Create Package Contract</h4>
	          		</div>
	          		<div class="modal-body">
	            		<div class="container-fluid">
	            			<div class="form-horizontal">
	            				<div class="form-group">
    								<label class="control-label col-sm-3" for="cmbclient">Client:</label>
    								<div class="col-sm-9">
      									<select class="form-control" name="cmbclient" id="cmbclient" style="width:100%;"><option value="">--Select--</option></select>
    								</div>
  								</div>
  								<div class="form-group">
    								<label class="control-label col-sm-3" for="cmbmodel">Model:</label>
    								<div class="col-sm-9">
      									<select style="width:100%;" name="cmbmodel" id="cmbmodel" class="form-control" onchange="funGetModalPackage(this.value);"><option value="">--Select--</option></select>
    								</div>
  								</div>
  								<div class="form-group">
    								<label class="control-label col-sm-3" for="regno">Reg No:</label>
    								<div class="col-sm-9">
      									<input type="text" name="regno" id="regno" placeholder="Vehicle No" class="form-control">
    								</div>
  								</div>
  								<div class="form-group">
    								<label class="control-label col-sm-3" for="chassisno">Chassis No:</label>
    								<div class="col-sm-9">
      									<input type="text" name="chassisno" id="chassisno" placeholder="Chassis No" class="form-control">
    								</div>
  								</div>
								<div class="form-group">
    								<label class="control-label col-sm-3" for="cmbpackage">Package:</label>
    								<div class="col-sm-9">
      									<select style="width:100%;" class="form-control" name="cmbpackage" id="cmbpackage"><option value="">--Select--</option></select>
    								</div>
  								</div>
								<div class="form-group">
    								<label class="control-label col-sm-3" for="fromdate">From Date:</label>
    								<div class="col-sm-3" style="padding-top:8px;">
      									<div id="fromdate"></div>
    								</div>
    								<label class="control-label col-sm-2" for="todate">To Date:</label>
    								<div class="col-sm-3" style="padding-top:8px;">
      									<div id="todate"></div>
    								</div>
  								</div>
  								
  								<div class="form-group">
    								<label class="control-label col-sm-3" for="todate">Remarks:</label>
    								<div class="col-sm-9">
      									<input type="text" name="remarks" id="remarks" class="form-control" placeholder="Enter Remarks">
    								</div>
  								</div>
	            			</div>
	            		</div>
	            	</div>
	            	<div class="modal-footer text-right">
	            		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	            		<button type="button" class="btn btn-default btn-primary" id="btncreatecontractsave">Update</button>
	          		</div>
	          	</div>
	        </div>
		</div>
	    
	    <div id="modalutil" class="modal fade" role="dialog">
	    	<div class="modal-dialog">
	        	<div class="modal-content">
	          		<div class="modal-header">
	            		<button type="button" class="close" data-dismiss="modal">&times;</button>
	            		<h4 class="modal-title">Utilization Log</h4>
	          		</div>
	          		<div class="modal-body">
	          			<div id="utilgriddiv"><jsp:include page="utilGrid.jsp"></jsp:include></div>
	 				</div>
	 			</div>
	 		</div>
	 	</div>
	     
    	<!-- Comments Modal-->
    	<div id="modalcomments" class="modal fade" role="dialog">
      		<div class="modal-dialog">
        		<div class="modal-content">
          			<div class="modal-header">
            			<button type="button" class="close" data-dismiss="modal">&times;</button>
            			<h4 class="modal-title">Comments</h4>
          			</div>
          			<div class="modal-body">
            			<div class="comments-outer-container container-fluid">
              				<div class="comments-container">
              				</div>
              				<div class="create-msg-container">
                  				<div class="row">
                    				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                      					<div class="input-group">
                        					<input type="text" class="form-control" placeholder="Please Type In" id="txtcomment">
                        					<div class="input-group-btn">
                          						<button type="button" id="btncommentsend" class="btn btn-default">
                            						<i class="fa fa-paper-plane"></i>
                          						</button>
                        					</div>
                      					</div>
                    				</div>
                  				</div>
              				</div>
            			</div>
          			</div>
        		</div>
      		</div>
    	</div>
<input type="hidden" name="contractdocno" id="contractdocno">
<input type="hidden" name="contractvocno" id="contractvocno">
<input type="hidden" name="estaction" id="estaction">
<input type="hidden" name="contractprintaction" id="contractprintaction">

  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->

<script src="../../../../js/sweetalert2.all.min.js"></script>
<script src="../../../../vendors/select2/js/select2.min.js"></script>
<script type="text/javascript">
	let customfields=[];
	let customcolumns=[];
    $(document).ready(function(){
        $('[data-toggle="tooltip"]').tooltip(); 
        $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 	$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 	var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
		var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	 	$('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	 	getInitData(1);
	 	funGetCountData();
        $('.load-wrapp').hide();        
        
        
        $('#btnsubmit').click(function(){
			$('.modal.fade.in').find('input:text').val('');
			$('.modal.fade.in').find('select').val('').trigger('change');
			$('.modal.fade.in').find('input:checkbox').each(function(){
				if($(this).is(':checked')){
					$(this).trigger('click');
				}
			});
			$('.modal.fade.in').find('.jqx-datetimeinput').each(function(){
				$(this).jqxDateTimeInput('setDate',new Date());
			});
			$('.modal.fade.in').modal('hide');
			getInitData(1);
        	funGetCountData();
        	var brhid=$('#cmbbranch').val();
        	$('#packagegriddiv').load('packageGrid.jsp?id=1&brhid='+brhid);
        });
        $('#btnexcel').click(function(){
        	$("#packageGrid").excelexportjs({
        		containerid: "packageGrid",
        		datatype: 'json',
        		dataset: null,
        		gridId: "packageGrid",
        		columns: getColumns("packageGrid"),
        		worksheetName: "Package Contract List"
        	});
        });
        
        $('.actionpanel button,.detailpanel button,.otherpanel button').click(function(){
        	var contractdocno=$('#contractdocno').val();
			var targetid=$(this).attr('id');        	
        	if(contractdocno=="" && targetid!="btncreatecontract"){
        		Swal.fire({
					type: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
        	var modaltarget=$(this).attr('data-target');
        	if(modaltarget!=null && modaltarget!="undefined"){
        		$(modaltarget).modal('show');	
        	}
        });
        $('#btncontractprint').click(function(){
        	var url=document.URL;
 			var reurl=url.split("com/");
 			var rowindex=$('#gridindex').val();
 			var printaction=$('#contractprintaction').val();
 			var docno=$('#packageGrid').jqxGrid('getcellvalue',rowindex,'doc_no');
 			var brhid=$('#packageGrid').jqxGrid('getcellvalue',rowindex,'brhid');
 			var path= printaction+"?docno="+docno+"&brhid="+brhid;  
 			var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");		
 			win.focus();
        });
        $('#btncommentsend').click(function(){
        	var txtcomment=$('#txtcomment').val();
        	var jobcarddocno=$('#jobcarddocno').val();
        	if(txtcomment==""){
        		Swal.fire({
					type: 'error',
					title: 'Warning',
					text: 'Please type in comment'
				});
        		return false;
        	}
        	if(jobcarddocno==""){
        		Swal.fire({
					type: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
        	
        	saveComment();
        });
        
        $('.warningpanel div button').click(function(){
        	var gridrows=$('#packageGrid').jqxGrid('getrows');
        	if(gridrows.length==0){
        		Swal.fire({
					type: 'error',
					title: 'Warning',
					text: 'Please submit'
				});
				return false;
        	}
        	$(this).toggleClass('active');
        	if($(this).hasClass('active')){
        		addGridFilters($(this).attr('id'),$(this).attr('data-filtervalue'),$(this).attr('data-datafield'),$(this).attr('data-filtertype'),$(this).attr('data-filtercondition'));
        	}
        	else{
        		$('#packageGrid').jqxGrid('removefilter',$(this).attr('data-datafield'), true);
        	}
        });
        
        $('#btncreatesrs').click(function(){
        	var contractdocno=$('#contractdocno').val();
        	var contractvocno=$('#contractvocno').val();
        	var gridindex=$('#gridindex').val();
        	if(contractdocno==''){
        		Swal.fire({
					icon:'error',
					type: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
				return false;
        	}
        	var srsdocno=$('#packageGrid').jqxGrid('getcellvalue',gridindex,'srsdocno');
        	if(parseInt(srsdocno)>0){
        		Swal.fire({
					icon:'error',
					type: 'error',
					title: 'Warning',
					text: 'Already Invoiced'
				});
				return false;
        	}
        	if(contractdocno==''){
        		Swal.fire({
					icon:'error',
					type: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
				return false;
        	}
        	Swal.fire({
				title: 'Are you sure?',
				text: "Do you want to create Invoice against contract "+contractvocno,
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {
				if (result.isConfirmed) {
					$.post('createSRS.jsp',{'contractdocno':contractdocno},function(data,status){
						data=JSON.parse(data);
						if(data.errorstatus=="0"){
							Swal.fire({
								icon:'success',
								type: 'success',
								title: 'Success',
								text: 'Successfully generated SRS '+data.srsvocno
							});
							$('#btnsubmit').trigger('click');
						}
						else{
							Swal.fire({
								icon:'error',
								type: 'error',
								title: 'Warning',
								text: 'Not generated'
							});
							return false;
						}
					});
				}
			});
        });
        $('#cmbmodel').on('select2:select', function (e) {
    		var data = e.params.data;
    		funGetModalPackage(data.id);
		});
		
		$('#btncreatecontractsave').click(function(){
			var cldocno=$('#cmbclient').val();
			var package=$('#cmbpackage').val();
			if(cldocno==''){
				//$.messager.alert('Warning','Please select client');
				$('#cmbclient').closest('.form-group').addClass('has-error');
				$('#cmbclient').closest('div.col-sm-9').append($.parseHTML('<span class="help-class">Please select Client</span>'));
				return false;
			}
			else{
				$('#cmbclient').closest('.form-group').removeClass('has-error');
				$('#cmbclient').closest('div.col-sm-9').find('span.help-class').remove();
			}
			var cmbmodel=$('#cmbmodel').val();
			if(cmbmodel==''){
				$('#cmbmodel').closest('.form-group').addClass('has-error');
				$('#cmbmodel').closest('div.col-sm-9').append($.parseHTML('<span class="help-class">Please select Model</span>'));
				return false;
			}
			else{
				$('#cmbmodel').closest('.form-group').removeClass('has-error');
				$('#cmbmodel').closest('div.col-sm-9').find('span.help-class').remove();
			}
			if(package==''){
				$('#cmbpackage').closest('.form-group').addClass('has-error');
				$('#cmbpackage').closest('div.col-sm-9').append($.parseHTML('<span class="help-class">Please select package</span>'));
				return false;
			}
			else{
				$('#cmbpackage').closest('.form-group').removeClass('has-error');
				$('#cmbpackage').closest('div.col-sm-9').find('span.help-class').remove();
			}
			var regno=$('#regno').val();
			var chassisno=$('#chassisno').val();
			if(regno=='' && chassisno==''){
				$('#regno,#chassisno').closest('.form-group').addClass('has-error');
				$('#regno,#chassisno').closest('div.col-sm-9').append($.parseHTML('<span class="help-class">Reg No or Chassis No is mandatory</span>'));
				return false;
			}
			else{
				$('#regno,#chassisno').closest('.form-group').removeClass('has-error');
				$('#regno,#chassisno').closest('div.col-sm-9').find('span.help-class').remove();
			}
			var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			var todate=new Date($('#todate').jqxDateTimeInput('getDate'));
			if(fromdate==null){
				$.messager.alert('Warning','Please select From Date');
				return false;
			}
			if(todate==null){
				$.messager.alert('Warning','Please select To Date');
				return false;
			}
			fromdate.setHours(0,0,0,0);
			todate.setHours(0,0,0,0);
			if(fromdate>todate){
				$.messager.alert('Warning','From Date must be less than To Date');
				return false;
			}
			fromdate=$('#fromdate').jqxDateTimeInput('val');
			todate=$('#todate').jqxDateTimeInput('val');
			
			var remarks=$('#remarks').val();
			if(remarks!=''){
				if(remarks.length>200){
					//$.messager.alert('Warning','Max 200 Chars only for Remarks');
					$('#remarks').closest('.form-group').addClass('has-error');
					$('#remarks').closest('div.col-sm-9').append($.parseHTML('<span class="help-class">Max 200 Chars only</span>'));
				
					return false;
				}
			}
			
			Swal.fire({
				title: 'Are you sure?',
				text: "Do you want to create contract",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {
				if (result.isConfirmed) {
					var brhid=$('#cmbbranch').val();
					$.post('saveData.jsp',{'cmbmodel':cmbmodel,'regno':regno,'chassisno':chassisno,'cldocno':cldocno,'package':package,'fromdate':fromdate,'todate':todate,'remarks':remarks,'brhid':brhid,'mode':1},function(data,status){
						data=JSON.parse(data);
						if(data.errorstatus=="0"){
							//$.messager.alert('Message','Successfully Saved');
							Swal.fire({
								icon:'success',
								type: 'success',
								title: 'Success',
								text: 'Successfully Saved'
							});
							/*$('#cmbclient,#cmbpackage,#cmbmodel').val('').trigger('change');
							$('#fromdate,#todate').jqxDateTimeInput('setDate',new Date());
							$('#remarks,#regno,#chassisno').val('');
							$('#packagegriddiv').load('packageGrid.jsp');*/
							$('#btnsubmit').trigger('click');
						}
						else{
							//$.messager.alert('Message','Not Saved');
							Swal.fire({
								icon:'warning',
								type: 'error',
								title: 'Warning',
								text: 'Not Saved'
							});
							return false;
						}
					});
				}
			});
		});
    });
    
    function funGetModalPackage(modelvalue){
    	$.get('getInitData.jsp',{'mode':3,'modelid':modelvalue},function(data){
    		data=JSON.parse(data);
    		var htmldata='<option value="">--Select--</option>';
	        $.each(data.packagedata,function(index,value){
				htmldata+='<option value="'+value.docno+'" data-fromdate="'+value.pkgfromdate+'" data-todate="'+value.pkgtodate+'">'+value.name+'</option>';
			});
			$('#cmbpackage').html($.parseHTML(htmldata));
			$('#cmbpackage').select2({
	        	placeholder:"Select Package",
	        	allowClear:true
	        });
	        
	        $('#cmbpackage').on("select2:select", function (e) {
	        	$('#fromdate').jqxDateTimeInput('val',$("#cmbpackage").select2().find(":selected").attr('data-fromdate'));
	        	$('#todate').jqxDateTimeInput('val',$("#cmbpackage").select2().find(":selected").attr('data-todate')); 
	        });
    	});
    }
    function funGetCountData(){
    	var brhid=$('#cmbbranch').val();
    	$.get('getInitData.jsp',{'mode':4,'brhid':brhid},function(data){
    		data=JSON.parse(data.trim());
    		$('.warningpanel .btn-group').eq(0).find('span.badge-notify').text(data.pendingcount);
    		$('.warningpanel .btn-group').eq(1).find('span.badge-notify').text(data.notrcvcount);
    	});
    }
    function getInitData(mode){
    	$.get('getInitData.jsp',{'mode':mode},function(data){
			data=JSON.parse(data);
			var htmldata='<option value="">--Select--</option>';
			$.each(data.clientdata,function(index,value){
				htmldata+='<option value="'+value.cldocno+'">'+value.refname+'</option>';
			});
			$('#cmbclient').html($.parseHTML(htmldata));
			$('#cmbclient').select2({
	        	placeholder:"Select Client",
	        	allowClear:true
	        });
	        htmldata='<option value="">--Select--</option>';
	        /*$.each(data.packagedata,function(index,value){
				htmldata+='<option value="'+value.docno+'">'+value.name+'</option>';
			});*/
			$('#cmbpackage').html($.parseHTML(htmldata));
			$('#cmbpackage').select2({
	        	placeholder:"Select Package",
	        	allowClear:true
	        });
	        
	        htmldata='<option value="">--Select--</option>';
	        $.each(data.modeldata,function(index,value){
				htmldata+='<option value="'+value.docno+'">'+value.name+'</option>';
			});
			$('#cmbmodel').html($.parseHTML(htmldata));
			$('#cmbmodel').select2({
	        	placeholder:"Select Model",
	        	allowClear:true
	        });
			htmldata='';
			$.each(data.branchdata,function(index,value){
	  			htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
	  		});
	  		$('#cmbbranch').html($.parseHTML(htmldata));
	  		$('#cmbbranch').select2();    
	  		
	  		$('#estaction').val(data.estimationaction);
	  		$('#contractprintaction').val(data.contractprintaction);
		});
    	
    }
    function addGridFilters(id,filtervalue,datafield,filtertype,filtercondition){
    	var filtergroup = new $.jqx.filter();
    	var filter_or_operator = 1;
    	if(id=="btnoverdue" || id=="btnextendeddate"){
			var d=new Date();
			var day=d.getDate();
			var month=d.getMonth();
			var year=d.getFullYear();    		
    		filtervalue=new Date(year,month,day);
    		filter_or_operator=0;
    	} 
    	//var filtercondition = 'contains';
    	var filter1 = filtergroup.createfilter(filtertype, filtervalue, filtercondition);

    	filtergroup.addfilter(filter_or_operator, filter1);
    	//filtergroup.addfilter(filter_or_operator, filter2);
    	// add the filters.
    	$("#packageGrid").jqxGrid('addfilter', datafield, filtergroup);
    	// apply the filters.
    	$("#packageGrid").jqxGrid('applyfilters');
 	}
    function saveComment(){
    	var comment=$('#txtcomment').val();
    	var jobcarddocno=$('#jobcarddocno').val();
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split(",");
				getComments();		
			}
			else
			{
			}
		}
		x.open("GET","saveComment.jsp?comment="+comment.replace(/ /g, "%20")+"&jobcarddocno="+jobcarddocno,true);
		x.send();
    }
    function getComments(){
    	var jobcarddocno=$('#jobcarddocno').val();
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				$('.comments-container').html('');
				if(x.responseText.trim()!=""){
					var items=x.responseText.trim().split(",");
					var str='';
					for(var i=0;i<items.length;i++){
						str+='<div class="comment"><div class="msg"><p>'+items[i].split("::")[0]+'</p></div><div class="msg-details"><p>'+items[i].split("::")[1]+' - '+items[i].split("::")[2]+'</p></div></div>';
					}
					$('.comments-container').html($.parseHTML(str));		
				}
			
			}
			else
			{
			}
		}
		x.open("GET","getComments.jsp?jobcarddocno="+jobcarddocno,true);
		x.send();
    }
</script>
</body>
</html>
