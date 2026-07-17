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
          <button type="button" class="btn btn-default" id="btnjobplan" data-target="#modaljobplan"><i class="fa fa-calendar-check-o" aria-hidden="true" data-toggle="tooltip" title="Job Planning" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnvehmovupdate" data-target="#modalvehmovupdate" ><i class="fa fa-car " aria-hidden="true" data-toggle="tooltip" title="Vehicle Movement Update" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnjobstatus"  data-target="#modaljobstatus" ><i class="fa fa-filter " aria-hidden="true" data-toggle="tooltip" title="Job Status" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnteamselection" data-target="#modalteamselection"><i class="fa fa-users " aria-hidden="true" data-toggle="tooltip" title="Team Selection" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btntotalloss"><i class="fa fa-times" aria-hidden="true" data-toggle="tooltip" title="Total Loss" data-placement="bottom"></i></button>
        </div>
        <div class="warningpanel custompanel">
          <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btnpartsdelay" data-toggle="tooltip" title="Parts Delay" data-placement="bottom" data-filtervalue="Delayed" data-datafield="partsstatus" data-filtertype="stringfilter" data-filtercondition="contains"><i class="fa fa-cogs " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-partsdelay">3</span>
          </div>	
          <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btnhrsexceeded" data-toggle="tooltip" title="Hours Exceeded" data-placement="bottom"  data-filtervalue="0" data-datafield="hrsdiff" data-filtertype="numericfilter"  data-filtercondition="GREATER_THAN"><i class="fa fa-hourglass-2 " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-hrsexceeded">3</span>
          </div>
          <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btnoverdue" data-toggle="tooltip" title="Overdue" data-placement="bottom"   data-filtervalue="0" data-datafield="promiseddate" data-filtertype="datefilter"  data-filtercondition="LESS_THAN"><i class="fa fa-toggle-up " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-overdue">3</span>
          </div>
          <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btnextendeddate" data-toggle="tooltip" title="Extended Date" data-placement="bottom"  data-filtervalue="0" data-datafield="extdate" data-filtertype="datefilter"  data-filtercondition="NOT_NULL"><i class="fa fa-level-up " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-extendeddate">3</span>
          </div>
          <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btnhighpriority" data-toggle="tooltip" title="High Priority" data-placement="bottom" data-filtervalue="High" data-datafield="priority" data-filtertype="stringfilter"  data-filtercondition="contains"><i class="fa fa-exclamation-triangle " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-highpriority">3</span>
          </div>
          <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btnunattended" data-toggle="tooltip" title="Un Attended" data-placement="bottom" data-filtervalue="0" data-datafield="unattendedstatus" data-filtertype="numericfilter"  data-filtercondition="GREATER_THAN"><i class="fa fa-low-vision " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-unattended">3</span>
          </div>
        <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btnbadgetotalloss" data-toggle="tooltip" title="Total Loss" data-placement="bottom" data-filtervalue="0" data-datafield="totalloss" data-filtertype="numericfilter" data-filtercondition="GREATER_THAN"><i class="fa fa-times " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-totalloss">3</span>
          </div>
        </div>
        <div class="detailpanel custompanel">
          <button type="button" class="btn btn-default" id="btnpartsdetails"  data-target="#modalpartsdetails" ><i class="fa fa-cogs " aria-hidden="true" data-toggle="tooltip" title="Parts Details" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnworks" data-target="#modalworksdetails" ><i class="fa fa-list-alt " aria-hidden="true" data-toggle="tooltip" title="Works" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnvehmovement" data-target="#modalvehmovement"><i class="fa fa-exchange " aria-hidden="true" data-toggle="tooltip" title="Vehicle Movement Status" data-placement="bottom"></i></button>  
        <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btnjobcardprint" data-toggle="tooltip" title="Job Card Print" data-placement="bottom"><i class="fa fa-briefcase " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-jobcard">J</span>
          </div>
        </div>
        <div class="otherpanel custompanel">
          <button type="button" class="btn btn-default" id="btncomment"  data-target="#modalcomments" ><i class="fa fa-comments " aria-hidden="true" data-toggle="tooltip" title="Comments" data-placement="bottom"></i></button>
        </div>
        <div class="textpanel custompanel" style="max-width:180px;height:55px;">
			<p style="word-wrap: break-word;font-size:1.1rem;">&nbsp;</p>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div id="floormgmtgriddiv"><jsp:include page="floorMgmtGrid.jsp"></jsp:include></div>
      </div>
    </div>
	
	<!-- Job card Print modal -->
		<div id="modaljobcardprint" class="modal fade" role="dialog">
	    	<div class="modal-dialog">
	        	<div class="modal-content">
	          		<div class="modal-header">
	            		<button type="button" class="close" data-dismiss="modal">&times;</button>
	            		<h4 class="modal-title">Job Card Print</h4>
	          		</div>
	          		<div class="modal-body">
	            		<div class="container-fluid">
	            			<div class="row rowgap">
	            				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
	            					<div id="jobcardprintdiv"><jsp:include page="jobcardPrintVoucherWindow.jsp"></jsp:include></div>
	            				</div>
	            			</div>            	
	            		</div>
	            	</div>
	          	</div>
	        </div>
	      </div>
	<!-- Job Planning Modal -->
	
	<div id="modaljobplan" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Job Planning</h4>
          		</div>
          		<div class="modal-body">
            		<div class="container-fluid">
            			<div class="row rowgap">
            				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            					<div id="baygriddiv"><jsp:include page="bayGrid.jsp"></jsp:include></div>
            				</div>
            			</div>            	
            		</div>
            	</div>
          		<div class="modal-footer text-right">
	            	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	            	<button type="button" class="btn btn-default btn-primary" id="btnjobplansave">Update</button>
	          	</div>
          	</div>
          	
        </div>
      </div>
    <!-- Vehicle Movement Modal-->
    <div id="modalvehmovupdate" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Vehicle Movement Update</h4>
          </div>
          <div class="modal-body">
            <p><!-- Some text in the modal. --></p>
            <div class="container-fluid">
            	<div class="row rowgap">
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            			<div class="row">
            				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            					Move To
            				</div>
            				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            					<div class="checkbox">
  									<label><input type="checkbox" value="" class="chkallbays">All Zones</label>
								</div>
            				</div>
            			</div>
            		</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            			<select class="cmbbaymovupdate" name="cmbbay" style="width: 100%">
  							<option value="">--Select--</option>
						</select>
					</div>
            	</div>
            	<div class="row rowgap">
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">In Date &amp; Time</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            			<div class="row">
            				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6"><div id="baymovupdateindate"></div></div>
            				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6"><div id="baymovupdateintime"></div></div>
            			</div>
            		</div>
				</div>
				<div class="row rowgap">
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Out Date &amp; Time</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            			<div class="row">
            				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6"><div id="baymovupdateoutdate"></div></div>
            				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6"><div id="baymovupdateouttime"></div></div>
            			</div>
            		</div>
				</div>
				<div class="row rowgap">
            		<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3">Remarks</div>
            		<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
            			<input type="text" name="baymovupdateremarks" id="baymovupdateremarks" class="form-control">
					</div>
            	</div>
				<div class="row rowgap">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">
						<button type="button" name="btnbaymovupdate" id="btnbaymovupdate" class="btn btn-default">UPDATE</button>
					</div>
				</div>
            	</div>
            </div>
          </div>
          <!-- <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          </div> -->
        </div>
      </div>
    </div>

    <!-- Job Status Modal-->
    <div id="modaljobstatus" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Zone Status Update</h4>
          </div>
          <div class="modal-body">
          	<div class="container-fluid">
            	<div class="row rowgap">
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            			<div class="row">
            				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            					Zone
            				</div>
            				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            					<div class="checkbox">
  									<label><input type="checkbox" value="" class="chkallbays">All Zones</label>
								</div>
            				</div>
            			</div>
            		</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            			<select class="cmbbaystatusupdate" name="cmbbaystatusupdate" style="width: 100%" id="cmbbaystatusupdate">
  							<option value="">--Select--</option>
						</select>
					</div>
            	</div>
            	<div class="row rowgap">
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Zone Status</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            			<select class="cmbbaystatus" name="cmbbaystatus" style="width: 100%" id="cmbbaystatus">
  							<option value="">--Select--</option>
  							<!-- <option value="P">Parked</option> -->
  							<option value="C">Completed</option>
  							<option value="S">Started</option>
  							<option value="N">Not Attended</option>
						</select>
					</div>
            	</div>
            	<div class="row rowgap">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">
						<button type="button" name="btnbaystatusupdate" id="btnbaystatusupdate" class="btn btn-default">UPDATE</button>
					</div>
				</div>
            </div>
          </div>
<!--           <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          </div> -->
        </div>
      </div>
    </div>

    <!-- Team Selection Modal-->
    <div id="modalteamselection" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Team Selection</h4>
          </div>
          <div class="modal-body">
            <div class="container-fluid">
            	<ul class="nav nav-tabs">
					<li class="active"><a data-toggle="tab" href="#tabteamstoselect">To Be Selected</a></li>
				    <li><a data-toggle="tab" href="#tabselectedteams">Selected Teams</a></li>
				</ul>
				<div class="tab-content">
    				<div id="tabteamstoselect" class="tab-pane fade in active">
      					<div class="row rowgap">
            				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            					<div class="row">
            						<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            							<h4>Select Zone</h4>  
            						</div>
            						<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            							<div class="checkbox">
		  									<label><input type="checkbox" value="" class="chkallbays">All Zones</label>
										</div>
            						</div>
            					</div>
            					<div class="row">
            						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
	            						<select class="cmbteamupdatebay form-control" id="cmbteamupdatebay" name="cmbteamupdatebay" style="width: 100%">
		  									<option value="">--Select--</option>
										</select>
									</div>
            					</div>
            				</div>
            				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            					<h4>Select Team</h4>
            					<select class="cmbteamupdate form-control" id="cmbteamupdate" name="cmbteamupdate[]" multiple="multiple" style="width: 100%">
									<option value="">--Select--</option>
								</select>
            				</div>
            			</div>
            			<div class="row">
            				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">
            					<button type="button" class="btn btn-default" name="btnteamupdate" id="btnteamupdate">UPDATE</button>
            				</div>
            			</div>
    				</div>
    				<div id="tabselectedteams" class="tab-pane fade">
      					<div id="selectedteamsgriddiv"><jsp:include page="selectedTeamsGrid.jsp"></jsp:include></div>
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
    <!-- Parts Details Modal-->
    <div id="modalpartsdetails" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Parts Details</h4>
          </div>
          <div class="modal-body">
            <div id="partsdetailsgriddiv"><jsp:include page="partsDetailsGrid.jsp"></jsp:include></div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          </div>
        </div>
      </div>
    </div>

    <!-- Work Details Modal-->
    <div id="modalworksdetails" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Work Details</h4>
          </div>
          <div class="modal-body">
            <div id="jobworkersgriddiv"><jsp:include page="jobWorkersGrid.jsp"></jsp:include></div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          </div>
        </div>
      </div>
    </div>

    <!-- Vehicle Movement List Modal-->
    <div id="modalvehmovement" class="modal fade" role="dialog">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Vehicle Movement List</h4>
          </div>
          <div class="modal-body">
            <div id="baymovgriddiv"><jsp:include page="bayMovGrid.jsp"></jsp:include></div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
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
  <input type="hidden" name="z1count" id="z1count">
  <input type="hidden" name="z2count" id="z2count">
  <input type="hidden" name="z3count" id="z3count">
  <input type="hidden" name="z4count" id="z4count">
  <input type="hidden" name="z5count" id="z5count">
  <input type="hidden" name="z6count" id="z6count">
  <input type="hidden" name="z7count" id="z7count">
  <input type="hidden" name="z8count" id="z8count">
  <input type="hidden" name="z9count" id="z9count">
  <input type="hidden" name="z10count" id="z10count">
  <input type="hidden" name="z11count" id="z11count">
  <input type="hidden" name="z12count" id="z12count">
  <input type="hidden" name="z13count" id="z13count">
  <input type="hidden" name="z14count" id="z14count">
  
  
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->

<script src="../../../../js/sweetalert2.all.min.js"></script>
<script src="../../../../vendors/select2/js/select2.min.js"></script>
<script type="text/javascript">
	var baynames={};
	$.ajax({
	    async: false,
	    type: "GET",
	    url: "getGridBays.jsp",
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function (response) {
	    	response=JSON.parse(JSON.stringify(response));
	        $.each(response.baydata,function(index,value){
	        	baynames['z'+value.docno]=value.code;
	        	baynames['z'+value.docno+'hidden']=false;
	        	if(value.status!="3"){
	        		baynames['z'+value.docno+'hidden']=true;
	        	}
	        });
	    }
	});
    $(document).ready(function(){
        
        $('[data-toggle="tooltip"]').tooltip(); 
        $('.cmbbaymovupdate,.cmbbaystatus,.cmbbaystatusupdate,.cmbteamupdatebay').select2();
        $('.cmbteamupdate').select2();
        funGetCountData();
        getAllBays();
        getTeam();
        getInitData();
        $("#baymovupdateindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
        $("#baymovupdateintime").jqxDateTimeInput({ width: '80px', height: '15px', formatString:"HH:mm",showCalendarButton:false});
        $("#baymovupdateoutdate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
        $("#baymovupdateouttime").jqxDateTimeInput({ width: '80px', height: '15px', formatString:"HH:mm",showCalendarButton:false});
        $('.load-wrapp').hide();
        
        $('#btnjobcardprint').click(function(){
        	var jobcarddocno=$('#jobcarddocno').val();
        	
        	if(jobcarddocno==''){
				Swal.fire({
					type: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
			}
			$('#modaljobcardprint').modal('show');
			
        });
        $('#btntotalloss').click(function(){
        	var jobcarddocno=$('#jobcarddocno').val();
        	var jobcardvocno=$('#jobcardvocno').val();
        	
        	if(jobcarddocno==''){
				Swal.fire({
					type: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
			}
			
			Swal.fire({
	  			title: 'Are you sure?',
	  			text: "Do you want to update jobcard "+jobcardvocno+" as Total Loss?",
	  			icon: 'warning',
	  			showCancelButton: true,
	  			confirmButtonColor: '#3085d6',
	  			cancelButtonColor: '#d33',
	  			confirmButtonText: 'Yes'
			}).then((result) => {
	  			if (result.isConfirmed) {
	    			$.post('updateTotalLoss.jsp',{'jobcarddocno':jobcarddocno},function(data,status){
	    				data=JSON.parse(data);
	    				if(data.errorstatus=="0"){
	    					Swal.fire({
								type: 'success',
								title: 'Success',
								text: 'Updated Successfully'
							});
							funGetCountData();
				        	var brhid=$('#cmbbranch').val();
				        	$('#floormgmtgriddiv').load('floorMgmtGrid.jsp?id=1&brhid='+brhid);
	    				}
	    				else{
	    					Swal.fire({
								type: 'error',
								title: 'Warning',
								text: 'Not Updated'
							});
							return false;
	    				}
	    				
	    			});
	  			}
			});
        });
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
        	funGetCountData();
        	var brhid=$('#cmbbranch').val();
        	$('#floormgmtgriddiv').load('floorMgmtGrid.jsp?id=1&brhid='+brhid);
        });
        $('#btnexcel').click(function(){
        	<%-- var exceldata='<%=floordao.getFloorMgmtDataExcel("1")%>';
        	JSONToCSVCon(exceldata, 'Floor Management List', true); --%>
        	$("#floorMgmtGrid").excelexportjs({
        		containerid: "floorMgmtGrid",
        		datatype: 'json',
        		dataset: null,
        		gridId: "floorMgmtGrid",
        		columns: getColumns("floorMgmtGrid"),
        		worksheetName: "Floor Management List"
        	});
        });
        
        $('#btnjobplansave').click(function(){
        	var jobcarddocno=$('#jobcarddocno').val();
        	if(jobcarddocno==''){
				Swal.fire({
					type: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
			}
			var bayrows=$('#bayGrid').jqxGrid('getselectedrowindexes');
			if(bayrows.length==0){
				Swal.fire({
					type: 'error',
					title: 'Warning',
					text: 'Please select atleast 1 bay'
				});
				return false;
			}
			for(var i=0;i<bayrows.length;i++){
				var seqno=$('#bayGrid').jqxGrid('getcellvalue',bayrows[i],'seqno');
				if(seqno=="" || seqno==null || seqno=="undefined" || typeof(seqno)=="undefined"){
					//$.messager.alert('Warning','Please fill Seq No of selected bays');
					Swal.fire({
						type: 'error',
						title: 'Warning',
						text: 'Please fill Seq No of selected bays'
					});
					return false;
				}
				for(var j=0;j<bayrows.length;j++){
					var dupseqno=$('#bayGrid').jqxGrid('getcellvalue',bayrows[j],'seqno');
					if(i!=j && seqno==dupseqno){
						//$.messager.alert('Warning','Duplicate Sequence number not allowed');
						Swal.fire({
							type: 'error',
							title: 'Warning',
							text: 'Duplicate Sequence number not allowed'
						});
						return false;
					}
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
	    				bayUpdate();		
	  				}
				});
        		
        });
        function bayUpdate(){
        	$('.load-wrapp').show();
        	var jobcarddocno=$('#jobcarddocno').val();
			var bayarray=new Array();
			var teamarray=new Array();
			var bayrows=$('#bayGrid').jqxGrid('getselectedrowindexes');
			for(var i=0;i<bayrows.length;i++){
				bayarray.push($('#bayGrid').jqxGrid('getcellvalue',bayrows[i],'doc_no')+"::"+$('#bayGrid').jqxGrid('getcellvalue',bayrows[i],'seqno'));
			}
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200){
					var items=x.responseText.trim();
					$('.load-wrapp').hide();
					if(parseInt(items)=="0")  
					{	
						//$.messager.alert('Message', '  Record Successfully Updated ');
						Swal.fire({
							type: 'success',
							title: 'success',
							text: 'Record Successfully Updated'
						});
						$('#btnsubmit').trigger('click');
						
					}
					else
					{
						Swal.fire({
							type: 'error',
							title: 'Warning',
							text: 'Not Updated'
						});
						//$.messager.alert('Message', '  Not Updated  ');
					}
				}
			}
			x.open("POST","updateData.jsp?jobdocno="+jobcarddocno+"&bayarray="+bayarray+"&baylength="+bayrows.length,true);	 		
			x.send();	
        }
       	$('.chkallbays').change(function() {
        	if($(this).is(":checked")) {
	            getAllBays();
       	 	}
       	 	else{
       	 		getBays($('#jobcarddocno').val());
       	 	}
    	});
        
        $('.actionpanel button,.detailpanel button,.otherpanel button').click(function(){
        	var jobcarddocno=$('#jobcarddocno').val();
        	if(jobcarddocno==""){
        		Swal.fire({
					type: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
        	var modaltarget=$(this).attr('data-target');
        	$(modaltarget).modal('show');
        });
        $('#btnteamupdate').click(function(){
        	var jobcarddocno=$('#jobcarddocno').val();
        	var cmbteamupdatebay=$('#cmbteamupdatebay').val();
        	var cmbteamupdate=$('#cmbteamupdate').val();
        	if(jobcarddocno==""){
        		Swal.fire({
					type: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
			if(cmbteamupdate==""){
        		Swal.fire({
					type: 'error',
					title: 'Warning',
					text: 'Please select atleast 1 team'
				});
        		return false;
        	}
        	if(cmbteamupdatebay==""){
        		Swal.fire({
					type: 'error',
					title: 'Warning',
					text: 'Please select a zone'
				});
        		return false;
        	}
        	funTeamUpdate();
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
        
        $('#btnbaymovupdate').click(function(){
        	if($('#jobcarddocno').val()==''){
        		Swal.fire({
					type: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
        	if($('.cmbbaymovupdate').val()==''){
        		Swal.fire({
					type: 'error',
					title: 'Warning',
					text: 'Please select a zone'
				});
        		return false;
        	}
        	funUpdateBayMov();
        });
        
        $('#btnbaystatusupdate').click(function(){
        	if($('#jobcarddocno').val()==''){
        		Swal.fire({
					type: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
        	if($('.cmbbaystatusupdate').val()==''){
        		Swal.fire({
					type: 'error',
					title: 'Warning',
					text: 'Please select a zone'
				});
        		return false;
        	}
        	if($('.cmbbaystatus').val()==''){
        		Swal.fire({
					type: 'error',
					title: 'Warning',
					text: 'Please select a status'
				});
        		return false;
        	}
        	funUpdateBayStatus();
        });
        $('.warningpanel div button').click(function(){
        	var gridrows=$('#floorMgmtGrid').jqxGrid('getrows');
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
        		$('#floorMgmtGrid').jqxGrid('removefilter',$(this).attr('data-datafield'), true);
        	}
        });
    });
    function getInitData(){
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				items=JSON.parse(items);
				var htmldata='';
				$.each(items.branchdata,function(index,value){
	  				htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
	  			});
	  			$('#cmbbranch').html($.parseHTML(htmldata));
	  			$('#cmbbranch').select2();
			}
			else
			{
			}
		}
		x.open("GET","getInitData.jsp",true);
		x.send();
    }
    function funTeamUpdate(){
    	var jobcarddocno=$('#jobcarddocno').val();
        var cmbteamupdatebay=$('#cmbteamupdatebay').val();
        var cmbteamupdate=$('#cmbteamupdate').val();
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				if(items=="0"){
					Swal.fire({
						type: 'success',
						title: 'Message',
						text: 'Successfully Updated'
					});
					$('#selectedteamsgriddiv').load('selectedTeamsGrid.jsp?id=1&jobcarddocno='+$('#jobcarddocno').val());
				}
				else{
					Swal.fire({
						type: 'error',
						title: 'warning',
						text: 'Not Updated'
					});
				}
			}
			else
			{
			}
		}
		x.open("GET","updateTeam.jsp?cmbteamupdatebay="+cmbteamupdatebay+"&jobcarddocno="+jobcarddocno+"&cmbteamupdate="+cmbteamupdate,true);
		x.send();
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
    	$("#floorMgmtGrid").jqxGrid('addfilter', datafield, filtergroup);
    	// apply the filters.
    	$("#floorMgmtGrid").jqxGrid('applyfilters');
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
    
   function getAllBays(){
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split(",");
				var str='<option value="">--Select--</option>';
				for(var i=0;i<items.length;i++){
					str+='<option value="'+items[i].split("::")[0]+'">'+items[i].split("::")[1]+'</option>';
				}
				$('.cmbbaymovupdate').html(str);	
				$('.cmbbaystatusupdate').html(str);	
				$('.cmbteamupdatebay').html(str);
			}
			else
			{
			}
		}
		x.open("GET","getAllBayData.jsp",true);
		x.send();
    }
    
    function getBays(jobdocno){
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				if(x.responseText.trim()==""){
					Swal.fire({
						type: 'error',
						title: 'Warning',
						text: 'Please Complete Job Planning'
					});
					return false;
				}
				var items=x.responseText.trim().split(",");
				var str='<option value="">--Select--</option>';
				for(var i=0;i<items.length;i++){
					str+='<option value="'+items[i].split("::")[0]+'">'+items[i].split("::")[1]+'</option>';
				}
				$('.cmbbaymovupdate').html(str);	
				$('.cmbbaystatusupdate').html(str);	
				$('.cmbteamupdatebay').html(str);
			}
			else
			{
			}
		}
		x.open("GET","getBayData.jsp?jobdocno="+jobdocno,true);
		x.send();
    }
    function getTeam(){
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split(",");
				var str='<option value="">--Select--</option>';
				for(var i=0;i<items.length;i++){
					str+='<option value="'+items[i].split("::")[0]+'">'+items[i].split("::")[1]+'</option>';
				}
				$('.cmbteamupdate').html(str);
			}
			else
			{
			}
		}
		x.open("GET","getTeamData.jsp",true);
		x.send();
    }
    
    
    
    
    function funUpdateBayMov(){
    	var jobcarddocno=$('#jobcarddocno').val();
    	var cmbbaymovupdate=$('.cmbbaymovupdate').val();
    	var baymovupdateindate=$('#baymovupdateindate').jqxDateTimeInput('val');
    	var baymovupdateintime=$('#baymovupdateintime').jqxDateTimeInput('val');
    	var baymovupdateoutdate=$('#baymovupdateoutdate').jqxDateTimeInput('val');
    	var baymovupdateouttime=$('#baymovupdateouttime').jqxDateTimeInput('val');
    	var baymovupdateremarks=$('#baymovupdateremarks').val();
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				if(items.split("::")[0]=="0"){
					Swal.fire({
						type: 'success',
						title: 'Message',
						text: 'Zone Movement Updated'
					});
					$('#btnsubmit').trigger('click');
					
				}
				else{
					Swal.fire({
						type: 'error',
						title: 'Warning',
						text: items.split("::")[1]
					});
				}
				
			}
			else
			{
			}
		}
		x.open("GET","bayMovUpdate.jsp?jobcarddocno="+jobcarddocno+"&cmbbaymovupdate="+cmbbaymovupdate+"&baymovupdateindate="+baymovupdateindate+"&baymovupdateintime="+baymovupdateintime+"&baymovupdateoutdate="+baymovupdateoutdate+"&baymovupdateouttime="+baymovupdateouttime+"&baymovupdateremarks="+baymovupdateremarks,true);
		x.send();
    }
    
    function funUpdateBayStatus(){
    	var jobcarddocno=$('#jobcarddocno').val();
    	var cmbbaystatusupdate=$('.cmbbaystatusupdate').val();
    	var cmbbaystatus=$('#cmbbaystatus').val();
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				if(items=="0"){
					Swal.fire({
						type: 'success',
						title: 'Message',
						text: 'Zone Status Updated'
					});
					$('#btnsubmit').trigger('click');
				}
				else{
					Swal.fire({
						type: 'error',
						title: 'Warning',
						text: 'Not Updated'
					});
				}
				
			}
			else
			{
			}
		}
		x.open("GET","bayStatusUpdate.jsp?jobcarddocno="+jobcarddocno+"&cmbbaystatusupdate="+cmbbaystatusupdate+"&cmbbaystatus="+cmbbaystatus,true);
		x.send();
    }
    
    function funGetCountData(){
    	var brhid=$('#cmbbranch').val();
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split("::");
				$('.badge-partsdelay').text(items[0]);
				$('.badge-hrsexceeded').text(items[1]);
				$('.badge-overdue').text(items[2]);
				$('.badge-extendeddate').text(items[3]);
				$('.badge-highpriority').text(items[4]);
				$('.badge-unattended').text(items[5]);
				$('.badge-totalloss').text(items[20]);
				for(var i=1,j=6;i<=14;i++,j++){
					$('#z'+i+'count').val(items[j]);
				}
			}
			else
			{
			}
		}
		x.open("GET","getCountData.jsp?brhid="+brhid,true);
		x.send();
    }
    
     
function JSONToCSVCon(JSONData, ReportTitle, ShowLabel) {

    var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
    
   // alert("arrData");
    var CSV = '';    
    //Set Report title in first row or line
    
    CSV += ReportTitle + '\r\n\n';

    //This condition will generate the Label/Header
    if (ShowLabel) {
        var row = "";
        
        //This loop will extract the label from 1st index of on array
        for (var index in arrData[0]) {
            
            //Now convert each value to string and comma-seprated
            row += index + ',';
        }

        row = row.slice(0, -1);
        
        //append Label row with line break
        CSV += row + '\r\n';
    }
    
    //1st loop is to extract each row
    for (var i = 0; i < arrData.length; i++) {
        var row = "";
        
        //2nd loop will extract each column and convert it in string comma-seprated
        for (var index in arrData[i]) {
            row += '"' + arrData[i][index] + '",';
        }

        row.slice(0, row.length - 1);
        
        //add a line break after each row
        CSV += row + '\r\n';
    }

    if (CSV == '') {        
        alert("Invalid data");
        return;
    }   
    
    //Generate a file name
    var fileName = "";
    //this will remove the blank-spaces from the title and replace it with an underscore
    fileName += ReportTitle.replace(/ /g,"_");   
    
    //Initialize file format you want csv or xls
    var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
    
    // Now the little tricky part.
    // you can use either>> window.open(uri);
    // but this will not work in some browsers
    // or you will not get the correct file extension    
    
    //this trick will generate a temp <a /> tag
    var link = document.createElement("a");    
    link.href = uri;
    
    //set the visibility hidden so it will not effect on your web-layout
    link.style = "visibility:hidden";
    link.download = fileName + ".csv";
    
    //this part will append the anchor tag and remove it after automatic click
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}
  </script>
</body>
</html>
