<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
<title>GIP Material Request</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<jsp:include page="../../../../floorMgmtIncludes.jsp"></jsp:include>
<script src="../../../../vendors/bootstrap-v3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../../../../vendors/bootstrap-v3/css/bootstrap.min.css">
<link rel="stylesheet" href="../../../../vendors/animate/animate.css">

<link href="../../../../vendors/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="../../../../vendors/select2/css/select2.min.css" rel="stylesheet" />


  <style type="text/css">
  	:root {
	    --theme-deafult: #7366ff;
	    --theme-secondary: #f73164;
	}
	@font-face {
  		font-family: Poppins;
  		src: url('../../../../vendors/fonts/Poppins/Poppins-Regular.ttf')  format('truetype');
	}
	body{
		font-family:Poppins;
		font-size:12px;
	}
	input.form-control{
		height:34px !important;
		font-size:12px !important;
	}
	p{
		margin-bottom:0;
		
	}
	.panel-body{
		border:0;
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
	   position:absolute;right:-5px;top:-8px;z-index:2;
	   background-color:red;
	background-image: linear-gradient(135deg, #667eea 0%, #764ba2 100%);	
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
    .textpanel p.h8{
   		margin-top: 4px;
    	margin-bottom: 3px;
    	text-size:10;
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
	
	button[data-dismiss="modal"] {
		background-color:#fff;
	}
	.modal .well{
		padding:15px;
		margin-bottom:10px;
	}
	.modal .well fieldset legend{
		margin-bottom:10px;
	}
  </style>
</head>
<body>
	<div class="hidden">
		<label class="detail" name="lbldetail" id="lbldetail"></label>
		<label class="details" name="lbldetailname" id="lbldetailname"></label>
		<input type="text" name="detail" id="detail" value="<s:property value="detail"/>" />
		<input type="text" name="detailname" id="detailname" value="<s:property value="detailname"/>" />
		<input type="text" name="txtdetailpermissiondocno" id="txtdetailpermissiondocno" value="<s:property value="txtdetailpermissiondocno"/>" />
	</div>
	<div class="load-wrapp page-loader">
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
        			<select name="cmbbranch" id="cmbbranch" style="min-width:125px;"><option value="">--Select--</option></select>
    			</div>
    			<div class="actionpanel custompanel" style="min-height:5.5rem;">
    				<button type="button" class="btn btn-default hidden" id="btnmatrequest" ><i class="fa fa-cart-plus " aria-hidden="true" data-toggle="tooltip" title="Material Request" data-placement="bottom"></i></button>
    				<button type="button" class="btn btn-default hidden" id="btnpriceupdate" ><i class="fa fa-money " aria-hidden="true" data-toggle="tooltip" title="Price Update" data-placement="bottom"></i></button>
    				<button type="button" class="btn btn-default hidden" id="btntechapproval" ><i class="fa fa-user " aria-hidden="true" data-toggle="tooltip" title="Technical Approve" data-placement="bottom"></i></button>
    				<button type="button" class="btn btn-default hidden" id="btnfinapproval" ><i class="fa fa-check " aria-hidden="true" data-toggle="tooltip" title="Financial Approve" data-placement="bottom"></i></button>
    			</div>
    			<div class="warningpanel custompanel">
    				<div class="btn-group" role="group">
          				<button type="button" class="btn btn-default" data-toggle="tooltip" title="Material Request Pending" data-placement="bottom" data-filtervalue="Material Request" data-datafield="reqstatus" data-filtertype="stringfilter" data-filtercondition="equal"><i class="fa fa-cart-plus" aria-hidden="true"></i></button>
          				<span class="badge badge-notify badge-matreq">0</span>
          			</div>
          			<div class="btn-group" role="group">
          				<button type="button" class="btn btn-default" data-toggle="tooltip" title="Technical Approval Pending" data-placement="bottom" data-filtervalue="Technical Approval" data-datafield="reqstatus" data-filtertype="stringfilter" data-filtercondition="equal"><i class="fa fa-user " aria-hidden="true"></i></button>
          				<span class="badge badge-notify badge-tech">0</span>
          			</div>
          			<div class="btn-group" role="group">
          				<button type="button" class="btn btn-default" data-toggle="tooltip" title="Financial Approval Pending" data-placement="bottom" data-filtervalue="Financial Approval" data-datafield="reqstatus" data-filtertype="stringfilter" data-filtercondition="equal"><i class="fa fa-check " aria-hidden="true"></i></button>
          				<span class="badge badge-notify badge-fin">0</span>
          			</div>
    			</div>
    			<div class="otherpanel custompanel" style="min-height:5.5rem;">
    				<label class="checkbox-inline" for="chkallmatreq"><input type="checkbox" value="" id="chkallmatreq" onchange="funAllMatReq();">All Material Request</label>
    			</div>
    			<div class="printpanel custompanel">
    				<button type="button" class="btn btn-default" id="btnprint" ><i class="fa fa-print " aria-hidden="true" data-toggle="tooltip" title="Print Material Request" data-placement="bottom"></i></button>
    			</div>
    			<div class="textpanel custompanel hidden" style="min-height:5.5rem;">
					<p style="word-wrap: break-word;font-size:1.1rem;">&nbsp;</p>
        		</div>
    		</div>
    	</div>
    	<div class="row rowgap">
    		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
    			<div id="gipgriddiv"><jsp:include page="GIPGrid.jsp"></jsp:include></div>
    		</div>
    	</div>
    	<div class="row rowgap">
    		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
    			<div id="materialdiv"><jsp:include page="materialGrid.jsp"></jsp:include></div>
    		</div>
    	</div>
    	
    	<div class="modal fade" id="modalmatreq" role="dialog">
    		<div class="modal-dialog">
    			<div class="modal-content">
    				<div class="modal-header">
    					<button type="button" class="close" data-dismiss="modal">&times;</button>
    					<h4>Material Request for GIP #<span class="gipvocno"></span></h4>
    				</div>
    				<div class="modal-body">
    					<form class="form">
    						<div class="form-group">
    							<label for="matreqdesc">Description:</label>
    							<input type="text" class="form-control" id="matreqdesc" name="matreqdesc" data-maxlength="255">
    						</div>
    					</form>
    				</div>
    				<div class="modal-footer">
    					<button class="btn btn-default">Cancel</button>
    					<button class="btn btn-default btn-primary" id="btnmatreqsave">Save Changes</button>
    				</div>
    			</div>
    		</div>
    	</div>
    	
    	
    	<div class="modal fade" id="modalpriceupdate" role="dialog">
    		<div class="modal-dialog">
    			<div class="modal-content">
    				<div class="modal-header">
    					<button type="button" class="close" data-dismiss="modal">&times;</button>
    					<h4>Price Update for GIP #<span class="gipvocno"></span></h4>
    				</div>
    				<div class="modal-body">
    					<form class="form">
    						<div class="form-group">
    							<label for="matreqdesc">Description:</label>
    							<input type="text" class="form-control" id="priceupdatedesc" name="priceupdatedesc" data-maxlength="255">
    						</div>
    					</form>
    				</div>
    				<div class="modal-footer">
    					<button class="btn btn-default">Cancel</button>
    					<button class="btn btn-default btn-primary" id="btnpriceupdatesave">Save Changes</button>
    				</div>
    			</div>
    		</div>
    	</div>
    	
    	<div class="modal fade" id="modaltechapproval" role="dialog">
    		<div class="modal-dialog">
    			<div class="modal-content">
    				<div class="modal-header">
    					<button type="button" class="close" data-dismiss="modal">&times;</button>
    					<h4>Technical Approval for GIP #<span class="gipvocno"></span></h4>
    				</div>
    				<div class="modal-body">
    					<form class="form">
    						<div class="form-group">
    							<label for="matreqdesc">Description:</label>
    							<input type="text" class="form-control" id="techdesc" name="techdesc" data-maxlength="255">
    						</div>
    					</form>
    				</div>
    				<div class="modal-footer">
    					<button class="btn btn-default">Cancel</button>
    					<button class="btn btn-default btn-primary" id="btntechsave">Save Changes</button>
    				</div>
    			</div>
    		</div>
    	</div>
    	
    	
    	<div class="modal fade" id="modalfinapproval" role="dialog">
    		<div class="modal-dialog">
    			<div class="modal-content">
    				<div class="modal-header">
    					<button type="button" class="close" data-dismiss="modal">&times;</button>
    					<h4>Financial Approval for GIP #<span class="gipvocno"></span></h4>
    				</div>
    				<div class="modal-body">
    					<form class="form">
    						<div class="form-group">
    							<label for="matreqdesc">Description:</label>
    							<input type="text" class="form-control" id="findesc" name="findesc" data-maxlength="255">
    						</div>
    					</form>
    				</div>
    				<div class="modal-footer">
    					<button class="btn btn-default">Cancel</button>
    					<button class="btn btn-default btn-primary" id="btnfinsave">Save Changes</button>
    				</div>
    			</div>
    		</div>
    	</div>
    </div>
    
    <input type="hidden" name="gatedocno" id="gatedocno"/>
    <input type="hidden" name="gatevocno" id="gatevocno"/>
      <input type="hidden" name="brhid" id="brhid"/>
    <script src="../../../../js/sweetalert2.all.min.js"></script>
	<script src="../../../../vendors/select2/js/select2.min.js"></script>
    
    <script type="text/javascript">
    	
    
    	function funAllMatReq(){
    		if(document.getElementById("chkallmatreq").checked==true){
    			$('.actionpanel button').attr('disabled',true);
    			$('.actionpanel button').addClass('disabled');
    			$('#materialGrid').jqxGrid('clear');
    			$('#gipgriddiv').load('GIPGrid.jsp?id=1&mode=2');
    		}
    		else{
    			$('.actionpanel button').attr('disabled',false);
    			$('.actionpanel button').removeClass('disabled');
    			$('#materialGrid').jqxGrid('clear');
    			$('#gipgriddiv').load('GIPGrid.jsp?id=1');
    		}
    	}
    	
    	function funGetCountData(brhid){
    		$.get('getCountData.jsp',{'brhid':brhid},function(data){
    			data=JSON.parse(data);
				$('.badge-matreq').text(data.matreqpending);
				$('.badge-tech').text(data.techpending);
				$('.badge-fin').text(data.finpending);    			
    		});
    	}
    	
    	function funCheckSession(){
    		var session='<%=session.getAttribute("BRANCHID")%>';
			if(session==null || session=="null" || session=="" || session=="undefined" || typeof(session)=="undefined"){
				Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Session Expired'
				});
				return false;
			}
    	}
    	$(document).ready(function(){
    		$('[data-toggle="tooltip"]').tooltip();
    		
    		<%String main2=request.getParameter("main")==null?"":request.getParameter("main");%>
    		<%String name2=request.getParameter("name")==null?"":request.getParameter("name");%>
    		<%String docno=request.getParameter("docno")==null?"":request.getParameter("docno");%>
    		
    		if($('#detailname').val()=="" || $('#detailname').val()=="undefined" || typeof($('#detailname').val())=="undefined"){
    			document.getElementById("lbldetailname").innerText='<%=name2%>';
    			document.getElementById("lbldetail").innerText='<%=main2.equalsIgnoreCase("0")?"Workshop":main2%>';
    			$('#detailname').val(document.getElementById("lbldetail").innerText);
    			document.getElementById("txtdetailpermissiondocno").value='<%=docno%>';
    		}
    		else{
    			document.getElementById("lbldetailname").innerText=$('#detailname').val();
    			document.getElementById("lbldetail").innerText=$('#detail').val();
    			document.getElementById("txtdetailpermissiondocno").value='<%=docno%>';
    		}
    		var formname=$('#lbldetailname').text();
    		var formdocno=$('#txtdetailpermissiondocno').val();
    		$.get('getInitData.jsp',{'formname':formname,'formdocno':formdocno},function(data){
    			data=JSON.parse(data);
    			console.log(data);
    			var htmldata='';
				$.each(data.branchdata,function(index,value){
	  				htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
	  			});
				$('.badge-matreq').text(data.matreqpending);
				$('.badge-tech').text(data.techpending);
				$('.badge-fin').text(data.finpending);
				$('#cmbbranch').html($.parseHTML(htmldata));
				$('#cmbbranch').select2({
	  				placeholder:"Select Branch",
	  				allowClear:true
	  			});
				if(data.dtype=="BGMRE"){
					$('#btnmatrequest,#btnpriceupdate').removeClass('hidden');
				}
				else if(data.dtype=="BGMRT"){
					$('#btntechapproval').removeClass('hidden');
				}
				else if(data.dtype=="BGMRF"){
					$('#btnfinapproval').removeClass('hidden');
				}
				$('.page-loader').hide();
    		});
    		
    		$('#btnexcel').click(function(){
    			$("#GIPGrid").excelexportjs({
    				containerid: "GIPGrid",
    				datatype: 'json',
    				dataset: null,
    				gridId: "GIPGrid",
    				columns: getColumns("GIPGrid") ,
    				worksheetName:"GIP Material Request List"
    			});
    		});
    		$('#btnsubmit').click(function(){
    			var sessionstatus=funCheckSession();
    			if(sessionstatus==false){
    				return false;
    			}
            	//funGetFilterData();
            	$('.textpanel p').text('');
            	$('.textpanel').addClass('hidden');
            	$('.page-loader').show();
            	
            	var brhid=$('#cmbbranch').val();
            	funGetCountData(brhid);
            	$('#gipgriddiv').load('GIPGrid.jsp?id=1&brhid='+brhid);
            });
    		$('#btnprint').click(function(){
    			var gatedocno=$('#gatedocno').val();
    			if(gatedocno==''){
    				Swal.fire({
    					icon:'warning',
    					type: 'error',
    					title: 'Warning',
    					text: 'Please select a document'
    				});
    				return false;
    			}
    			funPrint()
            });
    		
    		$('.printpanel button').click(function(){
    			var sessionstatus=funCheckSession();
    			if(sessionstatus==false){
    				return false;
    			}
    			var gatedocno=$('#gatedocno').val();
    			if(gatedocno==''){
    				Swal.fire({
    					icon:'warning',
    					type: 'error',
    					title: 'Warning',
    					text: 'Please select a document'
    				});
    				return false;
    			}
    		});
    		$('.actionpanel button').click(function(){
    			var sessionstatus=funCheckSession();
    			if(sessionstatus==false){
    				return false;
    			}
    			var gatedocno=$('#gatedocno').val();
    			if(gatedocno==''){
    				Swal.fire({
    					icon:'warning',
    					type: 'error',
    					title: 'Warning',
    					text: 'Please select a document'
    				});
    				return false;
    			}
    			else{
    				var targetid=$(this).attr('id');
    				var gipindex=$('#gipindex').val();
					if(gipindex=='' || gipindex=='undefined' || typeof(gipindex)=='undefined'){
						Swal.fire({
	    					icon:'warning',
	    					type: 'error',
	    					title: 'Warning',
	    					text: 'Please select a document'
	    				});
	    				return false;
					}
    				var matreqdocno=$('#GIPGrid').jqxGrid('getcellvalue',gipindex,'matreqdocno');
					var finapproval=$('#GIPGrid').jqxGrid('getcellvalue',gipindex,'finapproval');
					var techapproval=$('#GIPGrid').jqxGrid('getcellvalue',gipindex,'techapproval');
					
    				if(targetid=='btnmatrequest'){
    					if(matreqdocno!='0'){
    						Swal.fire({
    	    					icon:'warning',
    	    					type: 'error',
    	    					title: 'Warning',
    	    					text: 'Material Request already issued'
    	    				});
    	    				return false;
    					}
    					else{
    						funMaterialRequest(gatedocno);	
    					}
    					
    				}
    				else if(targetid=='btnpriceupdate'){
    					if(matreqdocno=='0'){
    						Swal.fire({
    	    					icon:'warning',
    	    					type: 'error',
    	    					title: 'Warning',
    	    					text: 'Material Request not issued'
    	    				});
    	    				return false;
    					}
    					else if(finapproval=='1'){
    						Swal.fire({
    	    					icon:'warning',
    	    					type: 'error',
    	    					title: 'Warning',
    	    					text: 'Document Financial Approved'
    	    				});
    	    				return false;
    					}
    					else if(techapproval=='1'){
    						Swal.fire({
    	    					icon:'warning',
    	    					type: 'error',
    	    					title: 'Warning',
    	    					text: 'Document Technical Approved'
    	    				});
    	    				return false;
    					}
    					funPriceUpdate(gatedocno);
    				}
    				else if(targetid=='btntechapproval'){
    					if(matreqdocno=='0'){
    						Swal.fire({
    	    					icon:'warning',
    	    					type: 'error',
    	    					title: 'Warning',
    	    					text: 'Material Request not issued'
    	    				});
    	    				return false;
    					}
    					if(techapproval=='1'){
    						Swal.fire({
    	    					icon:'warning',
    	    					type: 'error',
    	    					title: 'Warning',
    	    					text: 'Already Technical Approved'
    	    				});
    	    				return false;
    					}
    					if(finapproval=='1'){
    						Swal.fire({
    	    					icon:'warning',
    	    					type: 'error',
    	    					title: 'Warning',
    	    					text: 'Already Financial Approved'
    	    				});
    	    				return false;
    					}
    					funApprovalUpdate(matreqdocno,'T');
    				}
    				else if(targetid=='btnfinapproval'){
    					if(matreqdocno=='0'){
    						Swal.fire({
    	    					icon:'warning',
    	    					type: 'error',
    	    					title: 'Warning',
    	    					text: 'Material Request not issued'
    	    				});
    	    				return false;
    					}
    					if(techapproval=='0'){
    						Swal.fire({
    	    					icon:'warning',
    	    					type: 'error',
    	    					title: 'Warning',
    	    					text: 'Technical Approval Pending'
    	    				});
    	    				return false;
    					}
    					if(finapproval=='1'){
    						Swal.fire({
    	    					icon:'warning',
    	    					type: 'error',
    	    					title: 'Warning',
    	    					text: 'Financial Approval Issued'
    	    				});
    	    				return false;
    					}
    					funApprovalUpdate(matreqdocno,'F');
    				}
    			}
    		});
    		
    		$('#btntechsave').click(function(){
    			var gatedocno=$('#gatedocno').val();
    			var gatevocno=$('#gatevocno').val();
    			$('.page-loader').show();
				var reqarray="";
				var gipindex=$('#gipindex').val();
				var matreqdocno=$('#GIPGrid').jqxGrid('getcellvalue',gipindex,'matreqdocno');
				var maindesc=$('#techdesc').val();
				var maxdesclength=$('#techdesc').attr('data-maxlength');
				if(maindesc.length>0 && maindesc.length>parseInt(maxdesclength)){
					Swal.fire({
						icon:'warning',
						type: 'error',
						title: 'Warning',
						text: 'Description Max Length Reached:'+maxdesclength
					});
					return false;
				}
				
				$.post('updateApproval.jsp',{'matreqdocno':matreqdocno,'apprmode':'T','desc':maindesc},function(data){
						data=JSON.parse(data);
						console.log(data);
						if(data.errorstatus=="1"){
							Swal.fire({
								icon:'warning',
								type: 'error',
								title: 'Warning',
								text: 'Not Approved'
							});
							return false;
						}
						else{
							Swal.fire({
								icon:'success',
								type: 'success',
								title: 'Success',
								text: data.errormsg
							});
							$('.modal.in').modal('hide');
							$('#btnsubmit').trigger('click');
						}
					});
    		});
    		
    		
    		$('#btnfinsave').click(function(){
    			var gatedocno=$('#gatedocno').val();
    			var gatevocno=$('#gatevocno').val();
    			$('.page-loader').show();
				var reqarray="";
				var gipindex=$('#gipindex').val();
				var matreqdocno=$('#GIPGrid').jqxGrid('getcellvalue',gipindex,'matreqdocno');
				var maindesc=$('#findesc').val();
				var maxdesclength=$('#findesc').attr('data-maxlength');
				if(maindesc.length>0 && maindesc.length>parseInt(maxdesclength)){
					Swal.fire({
						icon:'warning',
						type: 'error',
						title: 'Warning',
						text: 'Description Max Length Reached:'+maxdesclength
					});
					return false;
				}
				
				$.post('updateApproval.jsp',{'matreqdocno':matreqdocno,'apprmode':'F','desc':maindesc},function(data){
						data=JSON.parse(data);
						console.log(data);
						if(data.errorstatus=="1"){
							Swal.fire({
								icon:'warning',
								type: 'error',
								title: 'Warning',
								text: 'Not Approved'
							});
							return false;
						}
						else{
							Swal.fire({
								icon:'success',
								type: 'success',
								title: 'Success',
								text: data.errormsg
							});
							$('.modal.in').modal('hide');
							$('#btnsubmit').trigger('click');
						}
					});
    		});
    		
    		$('#btnpriceupdatesave').click(function(){
    			var gatedocno=$('#gatedocno').val();
    			var gatevocno=$('#gatevocno').val();
    			$('.page-loader').show();
				var reqarray="";
				var priceupdatedesc=$('#priceupdatedesc').val();
				var maxdesclength=$('#priceupdatedesc').attr('data-maxlength');
				if(priceupdatedesc.length>0 && priceupdatedesc.length>parseInt(maxdesclength)){
					Swal.fire({
						icon:'warning',
						type: 'error',
						title: 'Warning',
						text: 'Description Max Length Reached:'+maxdesclength
					});
					return false;
				}
				var reqrows=$('#materialGrid').jqxGrid('getrows');
				for(var i=0;i<reqrows.length;i++){
					var desc=$('#materialGrid').jqxGrid('getcellvalue',i,'reqdesc');
					var qty=$('#materialGrid').jqxGrid('getcellvalue',i,'qty');
					var price=$('#materialGrid').jqxGrid('getcellvalue',i,'price');
					if(desc!="" && desc!="undefined" && desc!=null && typeof(desc)!="undefined"){
						if(desc.includes(",")){
							desc=desc.replaceAll(","," ");	
						}
						if(reqarray==""){
							reqarray+=desc+" :: "+qty+" :: "+price;
						}
						else{
							reqarray+=","+desc+" :: "+qty+" :: "+price;
						}
					}
				}
				$.post('priceUpdate.jsp',{'gatedocno':gatedocno,'reqarray':reqarray,'desc':priceupdatedesc},function(data){
					data=JSON.parse(data);
					if(data.errorstatus=="1"){
						Swal.fire({
							icon:'warning',
							type: 'error',
							title: 'Warning',
							text: 'Please enter valid documents'
						});
						return false;
					}
					else{
						Swal.fire({
							icon:'success',
							type: 'success',
							title: 'Success',
							text: 'Price Updated of GIP #'+gatevocno
						});
						$('.modal.in').modal('hide');
						$('#btnsubmit').trigger('click');
					}
				});
    		})
    		$('#btnmatreqsave').click(function(){
    			var gatedocno=$('#gatedocno').val();
    			$('.page-loader').show();
				var reqarray="";
				var matreqdesc=$('#matreqdesc').val();
				var maxdesclength=$('#matreqdesc').attr('data-maxlength');
				if(matreqdesc.length>0 && matreqdesc.length>parseInt(maxdesclength)){
					Swal.fire({
						icon:'warning',
						type: 'error',
						title: 'Warning',
						text: 'Description Max Length Reached:'+maxdesclength
					});
					return false;
				}
				var reqrows=$('#materialGrid').jqxGrid('getrows');
				for(var i=0;i<reqrows.length;i++){
					var desc=$('#materialGrid').jqxGrid('getcellvalue',i,'reqdesc');
					var qty=$('#materialGrid').jqxGrid('getcellvalue',i,'qty');
					var price=$('#materialGrid').jqxGrid('getcellvalue',i,'price');
					if(desc!="" && desc!="undefined" && desc!=null && typeof(desc)!="undefined"){
						if(desc.includes(",")){
							desc=desc.replaceAll(","," ");	
						}
						if(reqarray==""){
							reqarray+=desc+" :: "+qty+" :: "+price;
						}
						else{
							reqarray+=","+desc+" :: "+qty+" :: "+price;
						}
					}
				}
				$.post('createMaterialReq.jsp',{'gatedocno':gatedocno,'reqarray':reqarray,'desc':matreqdesc},function(data){
					data=JSON.parse(data);
					if(data.errorstatus=="1"){
						Swal.fire({
							icon:'warning',
							type: 'error',
							title: 'Warning',
							text: 'Please enter valid documents'
						});
						return false;
					}
					else{
						Swal.fire({
							icon:'success',
							type: 'success',
							title: 'Success',
							text: 'Material Request #'+data.docno+' Created'
						});
						$('.modal.in').modal('hide');
						$('#btnsubmit').trigger('click');
					}
				});
    		});
    	});
    	
    	function funApprovalUpdate(matreqdocno,apprmode){
    		
    		var confirmmsg='';
    		var gatevocno=$('#gatevocno').val();
    		$('.gipvocno').text(gatevocno);
    		if(apprmode=='T'){
    			$('#modaltechapproval').modal();
    		}
    		else if(apprmode=='F'){
    			$('#modalfinapproval').modal();
    		}
    		
    	}
    	function funMaterialRequest(gatedocno){
    		var gatevocno=$('#gatevocno').val();
    		$('.gipvocno').text(gatevocno);
    		var reqrows=$('#materialGrid').jqxGrid('getrows');
			var reqvalidsize=0;
			for(var i=0;i<reqrows.length;i++){
				var desc=$('#materialGrid').jqxGrid('getcellvalue',i,'reqdesc');
				if(desc!="" && desc!="undefined" && desc!=null && typeof(desc)!="undefined"){
					reqvalidsize++;
				}
			}
    		if(reqvalidsize<=0){
    			Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please enter valid documents'
				});
				return false;
    		}
    		
    		$('#modalmatreq').modal();
    		
    	}
    	
    	function funPriceUpdate(gatedocno){
    		var gatevocno=$('#gatevocno').val();
    		$('.gipvocno').text(gatevocno);
    		var reqrows=$('#materialGrid').jqxGrid('getrows');
			var reqvalidsize=0;
			for(var i=0;i<reqrows.length;i++){
				var desc=$('#materialGrid').jqxGrid('getcellvalue',i,'reqdesc');
				if(desc!="" && desc!="undefined" && desc!=null && typeof(desc)!="undefined"){
					reqvalidsize++;
				}
			}
    		if(reqvalidsize<=0){
    			Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please enter valid documents'
				});
				return false;
    		}
    		
    		$('#modalpriceupdate').modal();
    	}
    	function  funPrint()
		  {
		  
			 var doccno=$('#gatedocno').val();
			 var brhid=$('#brhid').val();
			 
		   			
				        var url=document.URL;
				        var reurl=url.split("GIPMatRequest.jsp");
			
				        var win= window.open(reurl[0]+"printgipmatrequest.action?docno="+doccno+"&brhid="+brhid,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
				        
				        win.focus();				   
				        }
    	
    </script>
</body>
</html>