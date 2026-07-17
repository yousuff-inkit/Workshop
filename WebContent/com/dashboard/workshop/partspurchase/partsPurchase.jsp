<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="com.dashboard.workshop.floormgmt.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<title></title>
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
          <button type="button" class="btn btn-default" id="btngoodsissuenote"><i class="fa fa-outdent" aria-hidden="true" data-toggle="tooltip" title="Goods Issue Note" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btncashdisbursement" data-target="#modalcashdisbursement" ><i class="fa fa-money" aria-hidden="true" data-toggle="tooltip" title="Cash Disbursement" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnnipurchaseorder" data-target="#modalnipurchaseorder" ><i class="fa fa-shopping-cart " aria-hidden="true" data-toggle="tooltip" title="NI Purchase Order" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnnipurchase"  data-target="#modalnipurchase" ><i class="fa fa-external-link" aria-hidden="true" data-toggle="tooltip" title="NI Purchase" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnconfirm"><i class="fa fa-check-circle-o" aria-hidden="true" data-toggle="tooltip" title="Confirm" data-placement="bottom"></i></button>
        </div>
        
        <div class="warningpanel custompanel">
		 <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btnpendingcount" data-toggle="tooltip" title="Pending" data-placement="bottom"><i class="fa fa-sticky-note-o" aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-pendingcount">0</span>
          </div>
          
          <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btnnipendingoncdcount" data-toggle="tooltip" title="NI Pending on CD" data-placement="bottom"><i class="fa fa-cc" aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-nipendingoncdcount">0</span>
          </div>
          	
          <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btnnipendingonpocount" data-toggle="tooltip" title="NI Pending on PO" data-placement="bottom"><i class="fa fa-list" aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-nipendingonpocount">0</span>
          </div>
        </div>
        
        <div class="otherpanel custompanel">
          <button type="button" class="btn btn-default" id="btndetails"><i class="fa fa-asterisk" aria-hidden="true" data-toggle="tooltip" title="Estimation Details" data-placement="bottom"></i></button>
		  
		   <button type="button" class="btn btn-default" id="btnnipending"><i class="fa fa-list-alt" aria-hidden="true" data-toggle="tooltip" title="NI Pending" data-placement="bottom"></i></button>
         
          <button type="button" class="btn btn-default" id="btncomment"  data-target="#modalcomments" ><i class="fa fa-comments" aria-hidden="true" data-toggle="tooltip" title="Comments" data-placement="bottom"></i></button>
        </div>
        
        <div class="textpanel custompanel">
			<p class="h4">&nbsp;</p>
        </div>
      </div>
    </div>
   
    <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div id="partsplangriddiv"><jsp:include page="partsPurchaseGrid.jsp"></jsp:include></div>
      </div>
    </div>
	
	<div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div id="partsgriddiv"><jsp:include page="partsGrid.jsp"></jsp:include></div>
      </div>
    </div>
	
	<!-- Cash Disbursement Modal-->
	<div id="modalcashdisbursement" class="modal fade" role="dialog">
    	<div class="modal-dialog" style="width:50%;">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Cash Disbursement for Job Card #<span></span></h4>
          		</div>
          		<div class="modal-body">
            		<div class="form-horizontal">
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="datecd">Date:</label>
    						<div class="col-sm-9 input-container">
      							<div id="datecd" name="datecd"></div>
    						</div>
  						</div>
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="fromaccount">From Account:</label>
    						<div class="col-sm-3 input-container">
      							<input type="text" class="form-control" id="fromaccountid" placeholder="Press F3 To search" onKeyDown="getAccountDetails(event,'FROM');" readonly style="background-color: transparent;"/>
    							<input type="hidden" id="hidfromaccount"/>
    						</div>
    						<div class="col-sm-6 input-container">
      							<input type="text" class="form-control" id="fromaccount" readonly style="background-color: transparent;"/>
    						</div>
  						</div>
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="toaccount">To Account:</label>
    						<div class="col-sm-3 input-container">
      							<input type="text" class="form-control" id="toaccountid" placeholder="Press F3 To search" onKeyDown="getAccountDetails(event,'TO');" readonly style="background-color: transparent;"/>
    							<input type="hidden" id="hidtoaccount"/>
    						</div>
    						<div class="col-sm-6 input-container">
      							<input type="text" class="form-control" id="toaccount" readonly style="background-color: transparent;"/>
    						</div>
  						</div>
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="remarkscd">Remarks:</label>
    						<div class="col-sm-9 input-container">
      							<input type="text" class="form-control" id="remarkscd" placeholder="Enter Remarks"/>
    						</div>
  						</div>
						<div class="form-group">
    						<label class="control-label col-sm-3" for="totalcdamount">Total CD Amount:</label>
    						<div class="col-sm-3 input-container">
      							<input type="text" class="form-control" id="totalcdamount" readonly style="background-color: transparent;text-align:right;"/>
    						</div>
  						</div>
  						
            		</div>
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btncashdisbursementcreate">Save Changes</button>
          		</div>
        </div>
      </div>
    </div>
    
	<!-- NI Purchase Order Modal-->
    <div id="modalnipurchaseorder" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Create NI Purchase Order for Job Card #<span></span></h4>
          		</div>
          		<div class="modal-body">
            		<div class="form-horizontal">
            			<div class="form-group">
    						<label class="control-label col-sm-3" for="cmbvendornpo">Vendor:</label>
    						<div class="col-sm-9 input-container">
      							<select class="form-control" name="cmbvendornpo" id="cmbvendornpo" style="width:100%;">
      								<option value="">--Select--</option>
      							</select>
    						</div>
  						</div>
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="npopurchasedetails">Purchase Details:</label>
    						<div class="col-sm-9 input-container">
      							<input type="text" class="form-control" id="npopurchasedetails" name="npopurchasedetails" placeholder="Enter Purchase Details">
    						</div>
  						</div>
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="nporemarks">Remarks:</label>
    						<div class="col-sm-9 input-container">
      							<input type="text" class="form-control" id="nporemarks" name="nporemarks" placeholder="Enter Remarks">
    						</div>
  						</div>
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="npoamount">Total Amount:</label>
    						<div class="col-sm-4 input-container">
      							<input type="text" class="form-control" id="npoamount" readonly style="background-color: transparent;text-align:right;"/>
    						</div>
  						</div>
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="npovatperc">VAT %:</label>
    						<div class="col-sm-4 input-container">
      							<input type="text" class="form-control" id="npovatperc" readonly style="background-color: transparent;text-align:right;"/>
    						</div>
  						</div>
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="npovatamount">VAT Amount:</label>
    						<div class="col-sm-4 input-container">
      							<input type="text" class="form-control" id="npovatamount" readonly style="background-color: transparent;text-align:right;"/>
    						</div>
  						</div>
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="nponetamount">Net Total:</label>
    						<div class="col-sm-4 input-container">
      							<input type="text" class="form-control" id="nponetamount" readonly style="background-color: transparent;text-align:right;"/>
    						</div>
  						</div>
            		</div>
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btnnipurchaseordercreate">Save Changes</button>
            		
          		</div>
        </div>
      </div>
    </div>
	
	<!-- NI Purchase Ref Type Modal-->
    <div id="modalnireftype" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Create NI Purchase for Job Card #<span></span></h4>
          		</div>
          		<div class="modal-body">
            		<div class="form-horizontal">
            			<div class="form-group">
    						<label class="control-label col-sm-3" for="cmbnireftype">Ref Type:</label>
    						<div class="col-sm-4 input-container">
      							<select class="form-control" name="cmbnireftype" id="cmbnireftype" style="width:100%;">
									<option value="DIR">DIR</option>
      								<option value="NPO">NPO</option>
      							</select>
    						</div>
							<div class="col-sm-5 input-container">
      							<input type="text" class="form-control" id="nirefno" name="nirefno" placeholder="Press F3 To Search" readonly style="background-color: transparent;" disabled="disabled" onKeyDown="getrefnosearch(event);"/>
								<input type="hidden" id="npodoc_no"/>
								<input type="hidden" id="sparerownos"/>
    						</div>
  						</div>
            		</div>
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btnnipurchaseproceed">Proceed</button>
          		</div>
        </div>
      </div>
    </div>
   
   <!-- NI Purchase Modal-->
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
    						<label class="control-label col-sm-3" for="purchasedetails">Purchase Details:</label>
    						<div class="col-sm-9 input-container">
      							<input type="text" class="form-control" id="purchasedetails" name="purchasedetails" placeholder="Enter Purchase Details">
    						</div>
  						</div>
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="remarks">Remarks:</label>
    						<div class="col-sm-9 input-container">
      							<input type="text" class="form-control" id="remarks" name="remarks" placeholder="Enter Remarks">
    						</div>
  						</div>
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="niamount">Total Amount:</label>
    						<div class="col-sm-4 input-container">
      							<input type="text" class="form-control" id="niamount" readonly style="background-color: transparent;text-align:right;"/>
    						</div>
  						</div>
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="nivatperc">VAT %:</label>
    						<div class="col-sm-4 input-container">
      							<input type="text" class="form-control" id="nivatperc" readonly style="background-color: transparent;text-align:right;"/>
    						</div>
  						</div>
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="nivatamount">VAT Amount:</label>
    						<div class="col-sm-4 input-container">
      							<input type="text" class="form-control" id="nivatamount" readonly style="background-color: transparent;text-align:right;"/>
    						</div>
  						</div>
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="ninetamount">Net Total:</label>
    						<div class="col-sm-4 input-container">
      							<input type="text" class="form-control" id="ninetamount" readonly style="background-color: transparent;text-align:right;"/>
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
  <input type="hidden" name="hidremarks" id="hidremarks"/>
  <div id="partssearchwindow">
   		<div><img id="loadingImage" src="../../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
	</div>
	
	 <div id="accountSearchwindow">
	   <div></div>
	</div>
	
	 <div id="estDetailswindow">
	   <div></div>
	</div> 
	
	<div id="nipendingwindow">
	   <div></div>
	</div>
	
	</div> 
		 <div id="refnosearchwindow">
	   <div></div>
	</div> 
	
	<div id="printWindow">
		<div></div>
	</div> 
	
	
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->

<script src="../../../../js/sweetalert2.all.min.js"></script>
<script src="../../../../vendors/select2/js/select2.min.js"></script>

<script type="text/javascript">
   
	$(document).ready(function(){
        $('[data-toggle="tooltip"]').tooltip();
        $('#partssearchwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Product Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#partssearchwindow').jqxWindow('close'); 
		
		$('#accountSearchwindow').jqxWindow({ width: '60%', height: '62%',  maxHeight: '75%' ,maxWidth: '70%' , title: 'Account Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
	    $('#accountSearchwindow').jqxWindow('close');
		
	    $('#estDetailswindow').jqxWindow({ width: '35%', height: '62%',  maxHeight: '75%' ,maxWidth: '70%' , title: 'Estimation Details' ,position: { x: 400, y: 60 }, keyboardCloseKey: 27});
	    $('#estDetailswindow').jqxWindow('close');
	 
	 	$('#nipendingwindow').jqxWindow({ width: '90%', height: '70%',  maxHeight: '80%' ,maxWidth: '90%' , title: 'NI Pending List' ,position: { x: 100, y: 30 }, keyboardCloseKey: 27});
	    $('#nipendingwindow').jqxWindow('close');
	    
	    $('#refnosearchwindow').jqxWindow({ width: '50%', height: '59%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Ref No Search' ,position: { x: 450, y: 40 }, keyboardCloseKey: 27});
	    $('#refnosearchwindow').jqxWindow('close');  
	    
	    $('#printWindow').jqxWindow({width: '25%', height: '25%',  maxHeight: '30%' ,maxWidth: '30%' , title: 'Print',position: { x: 500, y: 170 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		$('#printWindow').jqxWindow('close');
	    
		$("#datecd").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		$("#invdate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		
		getInitData();
		
		funGetCountData();
		
		$('#fromaccountid').dblclick(function() {
		    $('#accountSearchwindow').jqxWindow('open');
		    SearchContent('accountGridSearch.jsp?dtype=GL&type=FROM','accountSearchwindow');
		});
		
		$('#toaccountid').dblclick(function() {
		    $('#accountSearchwindow').jqxWindow('open');
		    SearchContent('accountGridSearch.jsp?dtype=GL&type=TO','accountSearchwindow');
		});
		
		$('#btndetails').click(function(){
			var estdocno=$('#partsPurchaseGrid').jqxGrid('getcellvalue',$('#gridrowindex').val(),'estdocno');
			if(!$.isNumeric(estdocno)){
				Swal.fire({
					type: 'Warning',
					title: 'Warning',
					text: 'Please select a document'
				});
				return false;
			}
			$('#estDetailswindow').jqxWindow('open');
			SearchContent('estimationDetails.jsp?docno='+estdocno,'estDetailswindow');
		});
		
		$('#btnnipending').click(function(){
			var brhid=$('#cmbbranch').val();
			$('#nipendingwindow').jqxWindow('open');
			SearchContent('niPendingJobs.jsp?id=1&brhid='+brhid,'nipendingwindow');
		});
		
		$('#nirefno').dblclick(function(){
			$('#refnosearchwindow').jqxWindow('open');
			SearchContent('ordermainsearch.jsp?sparerownos='+$("#sparerownos").val(),'refnosearchwindow');
		}); 
		
		$('#btnsubmit').click(function(){
			var brhid=$('#cmbbranch').val();
			$('.load-wrapp').show();
			$('#partsplangriddiv').load('partsPurchaseGrid.jsp?id=1&brhid='+brhid);
			funGetCountData();
		});
		
		$('#btnpendingcount').click(function(){
			var brhid=$('#cmbbranch').val();
			$('.load-wrapp').show();
			$('#partsplangriddiv').load('partsPurchaseGrid.jsp?id=1&brhid='+brhid+'&filter=PNDG');
			funGetCountData();
		});
		
		$('#btnnipendingoncdcount').click(function(){
			var brhid=$('#cmbbranch').val();
			$('.load-wrapp').show();
			$('#partsplangriddiv').load('partsPurchaseGrid.jsp?id=1&brhid='+brhid+'&filter=NICDPNDG');
			funGetCountData();
		});
			
		$('#btnnipendingonpocount').click(function(){
			var brhid=$('#cmbbranch').val();
			$('.load-wrapp').show();
			$('#partsplangriddiv').load('partsPurchaseGrid.jsp?id=1&brhid='+brhid+'&filter=NIPOPNDG');
			funGetCountData();
		});
		
		$('#btnexcel').click(function(){
			$("#partsPurchaseGrid").excelexportjs({
				containerid: "partsPurchaseGrid",
				datatype: 'json',
				dataset: null,
				gridId: "partsPurchaseGrid",
				columns: getColumns("partsPurchaseGrid"),
				worksheetName: "Parts Purchase"
			});
		});
		
		$('#btnproductupdate').click(function(){
			var selectedrows=$('#partsGrid').jqxGrid('selectedrowindexes');
			var estdocno=$('#partsPurchaseGrid').jqxGrid('getcellvalue',$('#gridrowindex').val(),'estdocno');
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
			var estdocno=$('#partsPurchaseGrid').jqxGrid('getcellvalue',$('#gridrowindex').val(),'estdocno');
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
					
					var issuebalqty=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'issuebalqty');
					
					var prdname=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'description');
					var stkval=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'stock');
					if(parseFloat(qty)==0){
						Swal.fire({
							type: 'Warning',
							title: 'Warning',
							text: 'Enter Issue Qty.'
						});
						return false;
		      		}
					
					if(parseFloat(qty)>parseFloat(issuebalqty)){
						Swal.fire({
							type: 'Warning',
							title: 'Warning',
							text: 'Quantity exceeds balance quantity'
						});
						return false;		
					}
					
					if((parseFloat(stkval)<parseFloat(qty)) ){
						Swal.fire({
							type: 'Warning',
							title: 'Warning',
							text: 'Product - '+prdname+' - Not in Stock.'
						});	
				        $('#partsGrid').jqxGrid('setcellvalue',rowBoundIndex,'issqty',stkval);
				 	}
					 
					if(qty!="undefined" && typeof(qty)!="undefined" && qty!=null && qty!=""){
					    partsrowarray.push(rowno);
						partsarray.push(psrno+"::"+psrno+" :: "+unitdocno+" :: "+qty+" :: "+qty+" :: "+"0"+" :: "+specid+" :: "+"0"+" ::"+"0"+" ::"+"0");
					}
					
				}
				
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
		
		$('#btncashdisbursement').click(function(){ 
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

			var totalcdamount=0;
			for(var i=0;i<selectedrows.length;i++){
				var cdqty=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'cdqty');
				var balqty=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'balqty');
				var rate=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'rate');

				if(!$.isNumeric(cdqty) || parseFloat(cdqty)==0){
					Swal.fire({
						type: 'Warning',
						title: 'Warning',
						text:  'Enter CD Qty.'
					});
					return false;
	      		}
				
				if(parseFloat(cdqty)>parseFloat(balqty)){
					Swal.fire({
						type: 'Warning',
						title: 'Warning',
						text: 'Quantity exceeds balance quantity'
					});
					return false;		
				}
				
				var cdamt=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'purchaseprice');
				if(cdamt==null || cdamt=="" || cdamt=="undefined" || typeof(cdamt)=="undefined"){
					Swal.fire({
						type: 'Warning',
						title: 'Warning',
						text: 'Please type in CD Amount'
					});
					return false;	
				}			
				
			/*	if(parseFloat(cdamt)>parseFloat(rate)){
					Swal.fire({
						type: 'Warning',
						title: 'Warning',
						text: 'CD Amount should not be greater than rate'
					});
					return false;	
				} */
				
				totalcdamount+=parseFloat($('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'purchaseprice'));
			}
			$("#totalcdamount").val(totalcdamount);
			$('#modalcashdisbursement').find('.modal-header').find('span').text($('#jobcardvocno').val());
			$('#modalcashdisbursement').modal('show');
		});
		
		$('#btncashdisbursementcreate').click(function(){
			var jobcarddocno=$('#jobcarddocno').val();
			var estdocno=$('#partsPurchaseGrid').jqxGrid('getcellvalue',$('#gridrowindex').val(),'estdocno');
			if(jobcarddocno==""){
				Swal.fire({
					type: 'Warning',
					title: 'Warning',
					text: 'Please select a document'
				});
				return false;
			}
			var selectedrows=$('#partsGrid').jqxGrid('getselectedrowindexes');
			
			var invalid=0;
			$('#datecd,#fromaccountid,#toaccountid,#remarkscd').each(function(){
				var targetid=$(this).attr('id');
				
				if(targetid=='datecd'){
					if($('#datecd').jqxDateTimeInput('getDate')==null){
						$('#datecd').closest('.form-group').addClass('has-error');
						$('#datecd').closest('.form-group').find('.input-container').find('span.help-block').remove();
						$('#datecd').closest('.form-group').find('.input-container').append($.parseHTML('<span class="help-block">Mandatory</span>'));
						invalid=1;
						return false;
					}
					else{
						$('#datecd').closest('.form-group').removeClass('has-error');
						$('#datecd').closest('.form-group').find('.input-container').find('span.help-block').remove();
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
				
   				var strpartsarray=new Array();
				for(var i=0;i<selectedrows.length;i++){
					var rowno=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'rowno');
					var desc=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'description');
					var cdqty=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'cdqty');
					var cdamt=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'purchaseprice');
					
					if(desc!="undefined" && typeof(desc)!="undefined" && desc!=null && desc!=""){
						strpartsarray.push(rowno+" :: "+cdqty+" :: "+cdamt);
					}
				}

				var jobcardvocno=$('#jobcardvocno').val();
				Swal.fire({
	  				title: 'Are you sure?',
	  				text: "Do you want to create Contra Trans for Job #"+jobcardvocno+"?",
	  				icon: 'warning',
	  				showCancelButton: true,
	  				confirmButtonColor: '#3085d6',
	  				cancelButtonColor: '#d33',
	  				confirmButtonText: 'Yes'
				}).then((result) => {
	  				if (result.isConfirmed) {
	    				
	    				$.post('saveContraTrans.jsp',
    					{
    						'strpartsarray[]':strpartsarray,
    						'estdocno':estdocno,
							'date':$('#datecd').jqxDateTimeInput('val'),
    						'fromaccount':$('#hidfromaccount').val(),
    						'toaccount':$('#hidtoaccount').val(),
    						'remarks':$('#hidremarks').val()+" "+$('#remarkscd').val(),
							'totalcdamount':$('#totalcdamount').val()
    					},
    					function(data,status){
    						data=JSON.parse(data);
    						if(data.errorstatus=="0"){
    							Swal.fire({
									type: 'Success',
									title: 'Message',
									text: 'Successfully Created Contra Trans #'+data.refdocno
								});
								$('#partsGrid').jqxGrid('clear');
								$('#datecd').jqxDateTimeInput('setDate',new Date());
								$('#fromaccountid,#fromaccount,#toaccountid,#toaccount,#remarkscd').val('');
								$('#modalcashdisbursement').modal('hide');
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
		
		$('#btnnipurchaseorder').click(function(){ 
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
			
			var npoamount=0;
			
			var selectedrows=$('#partsGrid').jqxGrid('getselectedrowindexes');
			for(var i=0;i<selectedrows.length;i++){
				var nipoqty=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'nipoqty');
				var balqty=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'balqty');
				var purchaseprice=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'purchaseprice');
				var rate=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'rate');
				
				if(!$.isNumeric(nipoqty) || parseFloat(nipoqty)==0){
					Swal.fire({
						type: 'Warning',
						title: 'Warning',
						text:  'Enter PO Qty.'
					});
					return false;
	      		}
				
				if(parseFloat(nipoqty)>parseFloat(balqty)){
					Swal.fire({
						type: 'Warning',
						title: 'Warning',
						text: 'Quantity exceeds balance quantity'
					});
					return false;		
				}
				  
				if(purchaseprice==null || purchaseprice=="" || purchaseprice=="undefined" || typeof(purchaseprice)=="undefined"){
					Swal.fire({
						type: 'Warning',
						title: 'Warning',
						text: 'Please type in purchase order price'
					});
					return false;	
				}
				  
				var total=parseFloat(purchaseprice)*parseFloat(nipoqty);
				  
				npoamount+=parseFloat(total);
			}
			
			$("#npoamount").val(npoamount);
			calNiPurchaseOrder();
			
			$('#modalnipurchaseorder').find('.modal-header').find('span').text($('#jobcardvocno').val());
			$('#modalnipurchaseorder').modal('show');
		});
		
		$('#btnnipurchaseordercreate').click(function(){
			var jobcarddocno=$('#jobcarddocno').val();
			var estdocno=$('#partsPurchaseGrid').jqxGrid('getcellvalue',$('#gridrowindex').val(),'estdocno');
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
						text: 'Please type in purchase order price'
					});
					return false;	
				}
			}
			var invalid=0;
			$('#cmbvendornpo,#nporemarks').each(function(){
				var targetid=$(this).attr('id');
				
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
				
				if(invalid==1){
					return false;
				}
			});
			
			if(invalid==0){
				var vendortax=$('#cmbvendornpo').find(':selected').attr('data-tax');
   				var taxpercent=0.0;
   				if(vendortax=="1"){
   					taxpercent=parseFloat($('#cmbvendornpo').find(':selected').attr('data-taxpercent'));
   				}
   				else{
   					taxpercent=0.0;
   				}
   				var partsarray=new Array();
   				var normalpartsarray=new Array();
				for(var i=0;i<selectedrows.length;i++){
					var rowno=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'rowno');
					var desc=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'description');
					var qty=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'nipoqty');
					var rate=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'rate');
					var psrno=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'psrno');
					var prdid=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'prdid');
					var unitdocno=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'unitdocno');
					var specid=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'specid');
					var purchaseprice=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'purchaseprice');
					var total=parseFloat(purchaseprice)*parseFloat(qty);
					var gridacno=$('#cmbvendornpo').find(':selected').attr('data-gridacno');
					var taxvalue=((parseFloat(taxpercent)/100)*parseFloat(total)).toFixed(2);
					var nettaxamount=parseFloat(taxvalue)+parseFloat(total);
					
					if(desc!="undefined" && typeof(desc)!="undefined" && desc!=null && desc!=""){
						partsarray.push((i+1)+"::"+qty+" :: "+desc+" :: "+purchaseprice+" :: "+total+"::"+0.0+"::"+total+"::"+purchaseprice+"::"+taxpercent+"::"+taxvalue+"::"+nettaxamount);
						normalpartsarray.push(rowno+" :: "+desc+" :: "+qty+" :: "+rate+" :: "+psrno+" :: "+purchaseprice);
					}
				}
				
				var jobcardvocno=$('#jobcardvocno').val();
				Swal.fire({
	  				title: 'Are you sure?',
	  				text: "Do you want to create NI Pucrhase Order for Job #"+jobcardvocno+"?",
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
    						'vendor':$('#cmbvendornpo').val(),
    						'purchasedetails':$('#npopurchasedetails').val(),
    						'remarks':$('#hidremarks').val()+" "+$('#nporemarks').val(),
    						'mode':2
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
								$('#cmbvendornpo').val(null).trigger('change');
								$('#npopurchasedetails,#nporemarks').val('');
								$('#modalnipurchaseorder').modal('hide');
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
			
			var niamount=0;
			
			var poCreated=false;
			
			var rownos="";
			
			var selectedrows=$('#partsGrid').jqxGrid('getselectedrowindexes');
			for(var i=0;i<selectedrows.length;i++){
				var nipurchaseqty=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'niqty');
				var nibalqty=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'nibalqty');
				var purchaseprice=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'purchaseprice');
				var rate=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'rate');
				var nipoqty=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'hidnipoqty');
				var rowno=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'rowno');
				
				rownos+=rowno+",";
				
				if(!$.isNumeric(nipurchaseqty) || parseFloat(nipurchaseqty)==0){
					Swal.fire({
						type: 'Warning',
						title: 'Warning',
						text:  'Enter NI Qty.'
					});
					return false;
	      		}
				
				if(parseFloat(nipurchaseqty)>parseFloat(nibalqty)){
					Swal.fire({
						type: 'Warning',
						title: 'Warning',
						text: 'Quantity exceeds balance quantity'
					});
					return false;		
				}
				  
				if(purchaseprice==null || purchaseprice=="" || purchaseprice=="undefined" || typeof(purchaseprice)=="undefined"){
					Swal.fire({
						type: 'Warning',
						title: 'Warning',
						text: 'Please type in purchase price'
					});
					return false;	
				}
				
				if(parseFloat(nipoqty)>0){
					poCreated=true;
				}
				
				var total=parseFloat(purchaseprice)*parseFloat(nipurchaseqty);
				  
				niamount+=parseFloat(total);
			}
			
			$("#niamount").val(niamount);
			calNiPurchase();
			
			rownos=rownos.slice(0,-1)
			
			$('#cmbnireftype').val('DIR').trigger('change');
			
			if(poCreated){
				$("#sparerownos").val(rownos);
				$('#modalnireftype').find('.modal-header').find('span').text($('#jobcardvocno').val());
				$('#modalnireftype').modal('show');
			}else{
				$('#modalnipurchase').find('.modal-header').find('span').text($('#jobcardvocno').val());
				$('#modalnipurchase').modal('show');
			}
		});
		
		$('#btnnipurchaseproceed').click(function(){
			if($("#cmbnireftype").val()=="NPO" && $("#npodoc_no").val()==""){
				Swal.fire({
					type: 'Warning',
					title: 'Warning',
					text: 'Please select a document'
				});
				return false;
			}
			
			var selectedrows=$('#partsGrid').jqxGrid('getselectedrowindexes');
			for(var i=0;i<selectedrows.length;i++){
				var nipurchaseqty=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'niqty');
				var nipoqty=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'hidnipoqty');
				
				if($("#cmbnireftype").val()=="NPO" && (parseFloat(nipurchaseqty)>parseFloat(nipoqty))){
					Swal.fire({
						type: 'Warning',
						title: 'Warning',
						text: 'Quantity exceeds PO quantity'
					});
					return false;		
				}
			}
			
			$('#modalnireftype').modal('hide');
			$('#modalnipurchase').find('.modal-header').find('span').text($('#jobcardvocno').val());
			$('#modalnipurchase').modal('show');
		});
		
		$('#btnnipurchasecreate').click(function(){
			var jobcarddocno=$('#jobcarddocno').val();
			var estdocno=$('#partsPurchaseGrid').jqxGrid('getcellvalue',$('#gridrowindex').val(),'estdocno');
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
					var qty=$('#partsGrid').jqxGrid('getcellvalue',selectedrows[i],'niqty');
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
    						'purchasedetails':$('#purchasedetails').val(),
    						'remarks':$('#hidremarks').val()+" "+$('#remarks').val(),
    						'reftype':$('#cmbnireftype').val(),
    						'refno':$('#npodoc_no').val(),
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
								$('#cmbnireftype').val('DIR').trigger('change');
								$('#invdate').jqxDateTimeInput('setDate',new Date());
								$('#invno,#purchasedetails,#remarks').val('');
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
	
	$("#btnconfirm").click(function(){
		var jobcarddocno=$('#partsPurchaseGrid').jqxGrid('getcellvalue',$('#gridrowindex').val(),'jobdocno');
		var processstatus=$('#partsPurchaseGrid').jqxGrid('getcellvalue',$('#gridrowindex').val(),'processstatus');
		
		if(!$.isNumeric(jobcarddocno)){
			Swal.fire({
				type: 'Warning',
				title: 'Warning',
				text: 'Please select a document'
			});
			return false;
		}
		
		if(parseFloat(processstatus)<=6){
			Swal.fire({
				type: 'Warning',
				title: 'Warning',
				text: 'Gate Out Pass not generated'
			});
			return false;
		}
		
		Swal.fire({
				title: 'Are you sure?',
				text: "Do you want to confirm Job Card#"+$('#jobcardvocno').val()+" ?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
		}).then((result) => {
				if (result.isConfirmed) {
				$.post('confirmDocument.jsp',{'jobcarddocno':jobcarddocno},
				function(data,status){
					data=JSON.parse(data);
					if(data=="0"){
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
	});
	
	$("#cmbvendor").change(function(){
		calNiPurchase();
	});
	
	$("#cmbvendornpo").change(function(){
		calNiPurchaseOrder();
	});
	
	$("#cmbnireftype").change(function(){
		if($(this).val()=="DIR"){
			$("#nirefno").val('');
			$("#npodoc_no").val('');
			$('#nirefno').attr('disabled', true );
		}else{
			$('#nirefno').attr('disabled', false );
		}
	});
	
	function calNiPurchase(){
		var niamount=parseFloat($("#niamount").val());
		var taxpercent=0.0;
		
		var vendortax=$('#cmbvendor').find(':selected').attr('data-tax');
		
   		if(vendortax=="1"){
   			taxpercent=parseFloat($('#cmbvendor').find(':selected').attr('data-taxpercent'));
   		}else{
   			taxpercent=0.0;
   		}
		var taxvalue=((parseFloat(taxpercent)/100)*parseFloat(niamount)).toFixed(2);
		var nettaxamount=parseFloat(taxvalue)+parseFloat(niamount);
		
		$("#nivatperc").val(taxpercent);
		$("#nivatamount").val(taxvalue);
		$("#ninetamount").val(nettaxamount);	
	}
	
	function calNiPurchaseOrder(){
		var npoamount=parseFloat($("#npoamount").val());
		var taxpercent=0.0;
		
		var vendortax=$('#cmbvendornpo').find(':selected').attr('data-tax');
		
   		if(vendortax=="1"){
   			taxpercent=parseFloat($('#cmbvendornpo').find(':selected').attr('data-taxpercent'));
   		}else{
   			taxpercent=0.0;
   		}
		var taxvalue=((parseFloat(taxpercent)/100)*parseFloat(npoamount)).toFixed(2);
		var nettaxamount=parseFloat(taxvalue)+parseFloat(npoamount);
		
		$("#npovatperc").val(taxpercent);
		$("#npovatamount").val(taxvalue);
		$("#nponetamount").val(nettaxamount);	
	}
	
	function getAccountDetails(event,type) {
	    var x = event.keyCode;
	    if (x == 114) {
	    	$('#accountSearchwindow').jqxWindow('open');
	    	SearchContent('accountGridSearch.jsp?dtype=GL&type='+type,'accountSearchwindow');
	    } 
	}
	
	function getrefnosearch(event){
		var x= event.keyCode;
		if(x==114){
			$('#refnosearchwindow').jqxWindow('open');
	    	SearchContent('ordermainsearch.jsp?sparerownos='+$("#sparerownos").val(),'refnosearchwindow');
		}
	}  

    function SearchContent(url,id) {
    	$.get(url).done(function (data) {
  			$('#'+id).jqxWindow('setContent', data);
  			$('#'+id).jqxWindow('bringToFront');
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
			
			$('#cmbvendornpo').html($.parseHTML(htmldata));
  			$('#cmbvendornpo').select2({
  				placeholder:"Select Vendor",
  				allowClear:true
  			});
		});
	}
	
	function funGetCountData(){
	    	var brhid=$('#cmbbranch').val();
	    	var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
				{
					var items=x.responseText.trim().split("::");
					$('.badge-pendingcount').text(items[0]);
					$('.badge-nipendingoncdcount').text(items[1]);
					$('.badge-nipendingonpocount').text(items[2]);
				}
			}
			x.open("GET","getCountData.jsp?brhid="+brhid,true);
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
		}
		x.open("GET","saveComment.jsp?comment="+comment.replace(/ /g, "%20")+"&jobcarddocno="+jobcarddocno,true);
		x.send();
    }
	
</script>
</body>
</html>
