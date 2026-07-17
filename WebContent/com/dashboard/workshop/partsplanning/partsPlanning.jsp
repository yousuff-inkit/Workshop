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
<script src="../../../../vendors/bootstrap-v3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../../../../vendors/bootstrap-v3/css/bootstrap.min.css">
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
        	<button type="button" class="btn btn-default" id="btninfo" data-toggle="tooltip" title="Info" data-placement="bottom"><i class="fa fa-info-circle " aria-hidden="true"></i></button>
        	<select name="cmbbranch" id="cmbbranch" style="min-width:125px;"><option value="">--Select--</option></select>
        </div>
        <div class="actionpanel custompanel">
          <button type="button" class="btn btn-default" id="btnproductupdate" data-target="#modalproductupdate"><i class="fa fa-pencil" aria-hidden="true" data-toggle="tooltip" title="Product Update" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnpurchaserequest" data-target="#modalpurchaserequest" ><i class="fa fa-shopping-cart " aria-hidden="true" data-toggle="tooltip" title="Purchase Request" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnnipurchase"  data-target="#modalnipurchase" ><i class="fa fa-external-link" aria-hidden="true" data-toggle="tooltip" title="NI Purchase" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btngoodsissuenote"  ><i class="fa fa-outdent" aria-hidden="true" data-toggle="tooltip" title="Goods Issue Note" data-placement="bottom"></i></button>
        </div>
        
        <div class="otherpanel custompanel">
          <button type="button" class="btn btn-default" id="btncomment"  data-target="#modalcomments" ><i class="fa fa-comments " aria-hidden="true" data-toggle="tooltip" title="Comments" data-placement="bottom"></i></button>
        </div>
        <div class="textpanel custompanel">
			<p class="h4">&nbsp;</p>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div id="partsplangriddiv"><jsp:include page="partsPlanningGrid.jsp"></jsp:include></div>
      </div>
    </div>
	<div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div id="partsgriddiv"><jsp:include page="partsGrid.jsp"></jsp:include></div>
      </div>
    </div>
	
	<div id="modalnipurchase" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Create NI Purchase for Job Card #<span></span></h4>
          		</div>
          		<div class="modal-body">
            		<div class="form-horizontal">
            			<div class="form-group">
    						<label class="control-label col-sm-3" for="cmbvendor">Vendor:</label>
    						<div class="col-sm-9 input-container">
      							<select class="form-control" name="cmbvendor" id="cmbvendor" style="width:100%;">
      								<option value="">--Select--</option>
      							</select>
    						</div>
  						</div>
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="invno">Invoice No:</label>
    						<div class="col-sm-9 input-container">
      							<input type="text" class="form-control" id="invno" name="invno" placeholder="Enter Invoice No">
    						</div>
  						</div>
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="invdate">Invoice Date:</label>
    						<div class="col-sm-9 input-container">
      							<div id="invdate" name="invdate"></div>
    						</div>
  						</div>
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="remarks">Remarks:</label>
    						<div class="col-sm-9 input-container">
      							<input type="text" class="form-control" id="remarks" name="remarks" placeholder="Enter Remarks">
    						</div>
  						</div>
  						
            		</div>
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btnnipurchasecreate">Save Changes</button>
            		
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
                <!-- <div class="container-fluid"> -->
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
                <!-- </div> -->
              </div>
            </div>
          </div>
          <!-- <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          </div> -->
        </div>
      </div>
    </div>
  </div>
  <input type="hidden" name="jobcarddocno" id="jobcarddocno">
  <input type="hidden" name="jobcardvocno" id="jobcardvocno">
  <div id="partssearchwindow">
   		<div><img id="loadingImage" src="../../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
	</div>
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->

<script src="../../../../js/sweetalert2.all.min.js"></script>
<script src="../../../../vendors/select2/js/select2.min.js"></script>

<script type="text/javascript">
    $(document).ready(function(){
        $('[data-toggle="tooltip"]').tooltip();
        $('#partssearchwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Product Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#partssearchwindow').jqxWindow('close'); 
		$("#invdate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		getInitData();
		$('#btnsubmit').click(function(){
			var brhid=$('#cmbbranch').val();
			$('.load-wrapp').show();
			$('#partsplangriddiv').load('partsPlanningGrid.jsp?id=1&brhid='+brhid);
		});
		$('#btnexcel').click(function(){
			$("#partsPlanningGrid").excelexportjs({
				containerid: "partsPlanningGrid",
				datatype: 'json',
				dataset: null,
				gridId: "partsPlanningGrid",
				columns: getColumns("partsPlanningGrid"),
				worksheetName: "Parts Planning Data"
			});
		});
		$('#btnproductupdate').click(function(){
			var selectedrows=$('#partsGrid').jqxGrid('selectedrowindexes');
			var estdocno=$('#partsPlanningGrid').jqxGrid('getcellvalue',$('#gridrowindex').val(),'estdocno');
			if(selectedrows.length==0){
				Swal.fire({
					type: 'Warning',
					title: 'Warning',
					text: 'Cannot update empty rows'
				});
				return false;
			}
			else{
				var partsarray=new Array();
				for(var i=0;i<selectedrows.length;i++){
					var rowno=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'rowno');
					var desc=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'description');
					var qty=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'qty');
					var rate=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'rate');
					var psrno=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'psrno');
					if(desc!="undefined" && typeof(desc)!="undefined" && desc!=null && desc!=""){
						partsarray.push(rowno+" :: "+desc+" :: "+qty+" :: "+rate+" :: "+psrno);
					}
					
				}
				Swal.fire({
	  				title: 'Are you sure?',
	  				text: "Do you want to update changes?",
	  				icon: 'warning',
	  				showCancelButton: true,
	  				confirmButtonColor: '#3085d6',
	  				cancelButtonColor: '#d33',
	  				confirmButtonText: 'Yes'
				}).then((result) => {
	  				if (result.isConfirmed) {
	    				$.post('saveData.jsp',
    					{
    						'partsarray[]':partsarray,
    						'estdocno':estdocno,
    						'mode':1
    					},
    					function(data,status){
    						data=JSON.parse(data);
    						if(data.errorstatus=="0"){
    							Swal.fire({
									type: 'Success',
									title: 'Message',
									text: 'Updated Successfully'
								});
								$('#partsGrid').jqxGrid('clear');
								$('#btnsubmit').trigger('click');
    						}
    						else{
    							Swal.fire({
									type: 'Warning',
									title: 'Warning',
									text: 'Not Updated'
								});
								return false;
    						}
	    				});		
	  				}
				});
			}
		});
		
		
		$('#btngoodsissuenote').click(function(){
			var selectedrows=$('#partsGrid').jqxGrid('selectedrowindexes');
			var estdocno=$('#partsPlanningGrid').jqxGrid('getcellvalue',$('#gridrowindex').val(),'estdocno');
			if(selectedrows.length==0){
				Swal.fire({
					type: 'Warning',
					title: 'Warning',
					text: 'Cannot update empty rows'
				});
				return false;
			}
			else{
				var partsarray=new Array();
				var partsrowarray=new Array();
				for(var i=0;i<selectedrows.length;i++){
					var rowno=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'rowno');
					var desc=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'description');
					var qty=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'issqty');
					
					var rate=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'rate');
					var psrno=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'psrno');
					var prdid=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'prdid');
					var unitdocno=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'unitdocno');
					var specid=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'specid');
					var purchasereqdocno=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'purchasereqdocno');
					
					
					var requiredqty=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'qty');
					var gisqty=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'goodsissueqty');
					
					var prdname=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'description');
					 var stkval=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'stock');
				//	alert(parseFloat(qty)+"===="+parseFloat(requiredqty)+"===="+parseFloat(gisqty));
				//	alert(parseFloat(qty)-parseFloat(requiredqty)-parseFloat(gisqty) <0);
					if(parseFloat(qty)==0){
						Swal.fire({
							type: 'Warning',
							title: 'Warning',
							text: 'Enter Issue Qty.'
						});
						return false;
		      		  }
					if(parseFloat(requiredqty)-parseFloat(qty)-parseFloat(gisqty) <0){
						Swal.fire({
							type: 'Warning',
							title: 'Warning',
							text: 'Already Created Goods Issue Note'
						});
						return false;		
					}
					
					 if((parseFloat(stkval)<parseFloat(qty)) ){
				        	
				        	  $.messager.alert('Message','Product - '+prdname+' - Not in Stock.');     	
				        	  $('#partsGrid').jqxGrid('setcellvalue',rowBoundIndex,'issqty',stkval);
				        	
				        	  }
					if(qty!="undefined" && typeof(qty)!="undefined" && qty!=null && qty!=""){
						//partsarray.push(rowno+" :: "+desc+" :: "+qty+" :: "+rate+" :: "+psrno+" :: "+prdid+" :: "+unitdocno+" :: "+specid);
					    partsrowarray.push(rowno);
						partsarray.push(psrno+"::"+psrno+" :: "+unitdocno+" :: "+qty+" :: "+qty+" :: "+"0"+" :: "+specid+" :: "+"0"+" ::"+"0"+" ::"+"0");
					}
					
				}
				
			//	alert(partsarray);
				var jobcardvocno=$('#jobcardvocno').val();
				Swal.fire({
	  				title: 'Are you sure?',
	  				text: "Do you want to create Goods Issue for Job Card #"+jobcardvocno+"?",
	  				icon: 'warning',
	  				showCancelButton: true,
	  				confirmButtonColor: '#3085d6',
	  				cancelButtonColor: '#d33',
	  				confirmButtonText: 'Yes'
				}).then((result) => {
	  				if (result.isConfirmed) {
	    				$.post('saveGoodsIssue.jsp',
    					{
	    					'partsrowarray[]':partsrowarray,
    						'partsarray[]':partsarray,
    						'estdocno':estdocno,
    						'mode':2
    					},
    					function(data,status){
    						data=JSON.parse(data);
    						if(data.errorstatus=="0"){
    							Swal.fire({
									type: 'Success',
									title: 'Message',
									text: 'Successfuly Created Goods Issue Note #'+data.refdocno
								});
								$('#partsGrid').jqxGrid('clear');
								$('#btnsubmit').trigger('click');
    						}
    						else{
    							Swal.fire({
									type: 'Warning',
									title: 'Warning',
									text: 'Not Updated'
								});
								return false;
    						}
	    				});		
	  				}
				});
			}
		});
		
		$('#btnpurchaserequest').click(function(){
			var selectedrows=$('#partsGrid').jqxGrid('selectedrowindexes');
			var estdocno=$('#partsPlanningGrid').jqxGrid('getcellvalue',$('#gridrowindex').val(),'estdocno');
			if(selectedrows.length==0){
				Swal.fire({
					type: 'Warning',
					title: 'Warning',
					text: 'Cannot update empty rows'
				});
				return false;
			}
			else{
				var partsarray=new Array();
				for(var i=0;i<selectedrows.length;i++){
					var rowno=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'rowno');
					var desc=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'description');
					var qty=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'issqty');
					var rate=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'rate');
					var psrno=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'psrno');
					var prdid=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'prdid');
					var unitdocno=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'unitdocno');
					var specid=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'specid');
					var purchasereqdocno=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'purchasereqdocno');
					if(parseFloat(qty)==0){
						Swal.fire({
							type: 'Warning',
							title: 'Warning',
							text: 'Enter Issue Qty.'
						});
						return false;
		      		  }
					if(parseInt(purchasereqdocno)>0){
						Swal.fire({
							type: 'Warning',
							title: 'Warning',
							text: 'Already Created Purchase Request'
						});
						return false;		
					}
					
					
					if(parseInt(purchasereqdocno)>0){
						Swal.fire({
							type: 'Warning',
							title: 'Warning',
							text: 'Already Created Purchase Request'
						});
						return false;		
					}
					psrno=psrno=='' || psrno==null || psrno=='undefined' || typeof(psrno)=='undefined'?'0':psrno;
					if(psrno=='0'){
						Swal.fire({
							type: 'Warning',
							title: 'Warning',
							text: 'Product Not Selected'
						});
						return false;		
					}
					if(desc!="undefined" && typeof(desc)!="undefined" && desc!=null && desc!=""){
						partsarray.push(rowno+" :: "+desc+" :: "+qty+" :: "+rate+" :: "+psrno+" :: "+prdid+" :: "+unitdocno+" :: "+specid);
					}
					
				}
				var jobcardvocno=$('#jobcardvocno').val();
				Swal.fire({
	  				title: 'Are you sure?',
	  				text: "Do you want to create Purchase Request for Job Card #"+jobcardvocno+"?",
	  				icon: 'warning',
	  				showCancelButton: true,
	  				confirmButtonColor: '#3085d6',
	  				cancelButtonColor: '#d33',
	  				confirmButtonText: 'Yes'
				}).then((result) => {
	  				if (result.isConfirmed) {
	    				$.post('saveData.jsp',
    					{
    						'partsarray[]':partsarray,
    						'estdocno':estdocno,
    						'mode':2
    					},
    					function(data,status){
    						data=JSON.parse(data);
    						if(data.errorstatus=="0"){
    							Swal.fire({
									type: 'Success',
									title: 'Message',
									text: 'Successfuly Created Purchase Request #'+data.refdocno
								});
								$('#partsGrid').jqxGrid('clear');
								$('#btnsubmit').trigger('click');
    						}
    						else{
    							Swal.fire({
									type: 'Warning',
									title: 'Warning',
									text: 'Not Updated'
								});
								return false;
    						}
	    				});		
	  				}
				});
			}
		});
		
		
		$('#btnnipurchase').click(function(){
			var jobcarddocno=$('#jobcarddocno').val();
			var selectedrows=$('#partsGrid').jqxGrid('selectedrowindexes');
			
			if(jobcarddocno==""){
				Swal.fire({
					type: 'Warning',
					title: 'Warning',
					text: 'Please select a document'
				});
				return false;
			}
			else if(selectedrows.length==0){
				Swal.fire({
					type: 'Warning',
					title: 'Warning',
					text: 'Please select rows'
				});
				return false;
			}
			var selectedrows=$('#partsGrid').jqxGrid('getselectedrowindexes');
			for(var i=0;i<selectedrows.length;i++){
				var purchaseprice=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'purchaseprice');
				if(purchaseprice==null || purchaseprice=="" || purchaseprice=="undefined" || typeof(purchaseprice)=="undefined"){
					Swal.fire({
						type: 'Warning',
						title: 'Warning',
						text: 'Please type in purchase price'
					});
					return false;	
				}
				var nipurchasedocno=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'nipurchasedocno');
				if(parseInt(nipurchasedocno)>0){
					Swal.fire({
						type: 'Warning',
						title: 'Warning',
						text: 'Already Created NI Purchase'
					});
					return false;	
				}
				var nipurchaseqty=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'issqty');
				if(parseFloat(nipurchaseqty)==0){
					Swal.fire({
						type: 'Warning',
						title: 'Warning',
						text:  'Enter Issue Qty.'
					});
					return false;
	      		  }
			}
			$('#modalnipurchase').find('.modal-header').find('span').text($('#jobcardvocno').val());
			$('#modalnipurchase').modal('show');
		});
		
		$('#btnnipurchasecreate').click(function(){
			var jobcarddocno=$('#jobcarddocno').val();
			var estdocno=$('#partsPlanningGrid').jqxGrid('getcellvalue',$('#gridrowindex').val(),'estdocno');
			if(jobcarddocno==""){
				Swal.fire({
					type: 'Warning',
					title: 'Warning',
					text: 'Please select a document'
				});
				return false;
			}
			var selectedrows=$('#partsGrid').jqxGrid('getselectedrowindexes');
			for(var i=0;i<selectedrows.length;i++){
				var purchaseprice=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'purchaseprice');
				if(purchaseprice==null || purchaseprice=="" || purchaseprice=="undefined" || typeof(purchaseprice)=="undefined"){
					Swal.fire({
						type: 'Warning',
						title: 'Warning',
						text: 'Please type in purchase price'
					});
					return false;	
				}
			}
			var invalid=0;
			$('#cmbvendor,#invno,#remarks,#invdate').each(function(){
				var targetid=$(this).attr('id');
				
				if(targetid=='invdate'){
					if($('#invdate').jqxDateTimeInput('getDate')==null){
						$('#invdate').closest('.form-group').addClass('has-error');
						$('#invdate').closest('.form-group').find('.input-container').find('span.help-block').remove();
						$('#invdate').closest('.form-group').find('.input-container').append($.parseHTML('<span class="help-block">Mandatory</span>'));
						invalid=1;
						return false;
					}
					else{
						$('#invdate').closest('.form-group').removeClass('has-error');
						$('#invdate').closest('.form-group').find('.input-container').find('span.help-block').remove();
					}
				}
				else{
					if($(this).val()==''){
						$(this).closest('.form-group').addClass('has-error');
						$(this).closest('.form-group').find('.input-container').find('span.help-block').remove();
						$(this).closest('.form-group').find('.input-container').append($.parseHTML('<span class="help-block">Mandatory</span>'));
						invalid=1;
						return false;
					}
					else{
						$(this).closest('.form-group').removeClass('has-error');
						$(this).closest('.form-group').find('.input-container').find('span.help-block').remove();
					}
				}
				if(invalid==1){
					return false;
				}
			});
			
			if(invalid==0){
				var vendortax=$('#cmbvendor').find(':selected').attr('data-tax');
   				var taxpercent=0.0;
   				if(vendortax=="1"){
   					taxpercent=parseFloat($('#cmbvendor').find(':selected').attr('data-taxpercent'));
   				}
   				else{
   					taxpercent=0.0;
   				}
   				var partsarray=new Array();
   				var normalpartsarray=new Array();
				for(var i=0;i<selectedrows.length;i++){
					var rowno=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'rowno');
					var desc=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'description');
					var qty=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'issqty');
					var rate=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'rate');
					var psrno=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'psrno');
					var prdid=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'prdid');
					var unitdocno=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'unitdocno');
					var specid=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'specid');
					var purchaseprice=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'purchaseprice');
					var total=parseFloat(purchaseprice)*parseFloat(qty);
					var gridacno=$('#cmbvendor').find(':selected').attr('data-gridacno');
					var taxvalue=((parseFloat(taxpercent)/100)*parseFloat(total)).toFixed(2);
					var nettaxamount=parseFloat(taxvalue)+parseFloat(total);
					
					
				
					
					if(desc!="undefined" && typeof(desc)!="undefined" && desc!=null && desc!=""){
						//console.log((i+1)+"::"+qty+" :: "+desc+" :: "+purchaseprice+" :: "+total+"::"+0.0+"::"+total+"::"+total+"::"+9+"::"+jobcarddocno+"::"+desc+"::"+gridacno+"::"+(i+1)+"::"+taxpercent+"::"+taxvalue+"::"+nettaxamount);
						partsarray.push((i+1)+"::"+qty+" :: "+desc+" :: "+purchaseprice+" :: "+total+"::"+0.0+"::"+total+"::"+total+"::"+9+"::"+jobcarddocno+"::"+desc+"::"+gridacno+"::"+(i+1)+"::"+taxpercent+"::"+taxvalue+"::"+nettaxamount);
						normalpartsarray.push(rowno+" :: "+desc+" :: "+qty+" :: "+rate+" :: "+psrno+" :: "+purchaseprice);
					}
					
					
				}
				var jobcardvocno=$('#jobcardvocno').val();
				Swal.fire({
	  				title: 'Are you sure?',
	  				text: "Do you want to create NI Pucrhase for Job #"+jobcardvocno+"?",
	  				icon: 'warning',
	  				showCancelButton: true,
	  				confirmButtonColor: '#3085d6',
	  				cancelButtonColor: '#d33',
	  				confirmButtonText: 'Yes'
				}).then((result) => {
	  				if (result.isConfirmed) {
	    				
	    				$.post('saveData.jsp',
    					{
    						'partsarray[]':partsarray,
    						'normalpartsarray[]':normalpartsarray,
    						'estdocno':estdocno,
    						'vendor':$('#cmbvendor').val(),
    						'invno':$('#invno').val(),
    						'invdate':$('#invdate').jqxDateTimeInput('val'),
    						'remarks':$('#remarks').val(),
    						'mode':3
    					},
    					function(data,status){
    						data=JSON.parse(data);
    						if(data.errorstatus=="0"){
    							Swal.fire({
									type: 'Success',
									title: 'Message',
									text: 'Successfully Created NI Purchase #'+data.refdocno
								});
								$('#partsGrid').jqxGrid('clear');
								$('#cmbvendor').val(null).trigger('change');
								$('#invdate').jqxDateTimeInput('setDate',new Date());
								$('#invno,#remarks').val('');
								$('#modalnipurchase').modal('hide');
								$('#btnsubmit').trigger('click');
    						}
    						else{
    							Swal.fire({
									type: 'Warning',
									title: 'Warning',
									text: 'Not Updated'
								});
								return false;
    						}
	    				});		
	  				}
				});	
			}		
			
		});
		
		$('#btncommentsend').click(function(){
        	var txtcomment=$('#txtcomment').val();
        	var jobcarddocno=$('#jobcarddocno').val();
        	if(txtcomment==""){
        		swal({
					type: 'error',
					title: 'Warning',
					text: 'Please type in comment'
				});
        		return false;
        	}
        	if(jobcarddocno==""){
        		swal({
					type: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
        	
        	saveComment();
        });
        
        $('.otherpanel button').click(function(){
        	var jobcarddocno=$('#jobcarddocno').val();
        	if(jobcarddocno==""){
        		swal({
					type: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
        	var modaltarget=$(this).attr('data-target');
        	$(modaltarget).modal('show');
        });
	});  
	function SearchContent(url,id) {
    	$.get(url).done(function (data) {
  			$('#'+id).jqxWindow('setContent', data);
		}); 
	}
	function getInitData(){
		$.get('getInitData.jsp',function(data){
			data=JSON.parse(data.trim());
			var htmldata='';
			$.each(data.branchdata,function(index,value){
  				htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
  			});
  			$('#cmbbranch').html($.parseHTML(htmldata));
  			$('#cmbbranch').select2({
  				placeholder:"Select Branch",
  				allowClear:true
  			});
  			htmldata='<option value="">--Select--</option>';
  			$.each(data.vendordata,function(index,value){
  				htmldata+='<option value="'+value.docno+'" data-taxpercent="'+value.taxpercent+'" data-gridacno="'+value.gridacno+'" data-tax="'+value.tax+'">'+value.refname+'</option>';
  			});
  			$('#cmbvendor').html($.parseHTML(htmldata));
  			$('#cmbvendor').select2({
  				placeholder:"Select Vendor",
  				allowClear:true
  			});
		});
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
</script>
</body>
</html>
