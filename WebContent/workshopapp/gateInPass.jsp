<!-- <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%> -->
    <% String contextPath=request.getContextPath();%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.47/css/bootstrap-datetimepicker.css"/>

<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"> -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
<link rel="stylesheet" href="css/wizard.css">
<link rel="stylesheet" type="text/css" href="css/util.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
<link rel="stylesheet" href="css/signature-pad.css">

<title>Gateway ERP</title>
<style>
	.main{
		padding:0;
	}
	.main > .container{
		width:100%;
	}
	.steps{
		display:none;
	}
	.content .current{
		padding-top:0;
	}
	.signup-form{
		padding:0;
	}
	.logo-container{
		text-align:center;
		display:block;
		margin-right:auto;
		margin-left:auto;
		padding-top:20px;
	}
	.signup-form{
		background-color: #8EC5FC;
    background-image: linear-gradient(62deg, #8EC5FC 0%, #E0C3FC 100%);
    padding-left: 15px;
    padding-top: 15px;
    padding-right: 15px;
    border-top-left-radius: 15px;
    border-top-right-radius: 15px;
	}
	.select2-search { background-color:#E0C3FC; }
	.select2-search input { background-color:#E0C3FC; }
	.select2-results { background-color:#E0C3FC; }
	.select2-selection--single{background-color:transparent !important;}
	.main .container h2{
		padding-top: 10px;
    	padding-bottom: 15px;
	}
	.switch {
  position: relative;
  display: inline-block;
  width: 60px;
  height: 34px;
}

.switch input { 
  opacity: 0;
  width: 0;
  height: 0;
}

.slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #ccc;
  border: 1px solid #ebebeb;
  -webkit-transition: .4s;
  transition: .4s;
}

.slider:before {
  position: absolute;
  content: "";
  height: 26px;
  width: 26px;
  left: 4px;
  bottom: 4px;
  background-color: white;
  -webkit-transition: .4s;
  transition: .4s;
}

input:checked + .slider {
  background-color: #2196F3;
  border-color:#2196F3;
}

input:focus + .slider {
  box-shadow: 0 0 1px #2196F3;
}

input:checked + .slider:before {
  -webkit-transform: translateX(26px);
  -ms-transform: translateX(26px);
  transform: translateX(26px);
}

/* Rounded sliders */
.slider.round {
  border-radius: 34px;
}

.slider.round:before {
  border-radius: 50%;
}
.file-container button{
	color: #000;
    border-color: #ebebeb;
}
.form-group span.help-block{
    color: #dc3545;
    font-weight: 400;
    display: flex;
    align-self: self-start;
}
.select2-container--default .select2-selection--single.error{
	border-color:red;
}
.input-group-append{
	border: 1px solid #fff;
    border-radius: 4px;
}
input#clientdetails{
	width: 92%;
	margin-right:0;
}
input#recievedfrommobile{
	width: 85%;
	margin-right:0;
	
}
.lnr{
	font-weight:bold;
}
.select2-search{
	background-color:transparent;
}
.select2-container--default .select2-selection--multiple{
	background-color:transparent;
}

</style>
</head>
<body onselectstart="return false">
	<div class="page-loader">
		<button type="button" class="btn btn-brand"><i class="fa lnr lnr-sync fa-spin fa-fw"></i> Loading</button>
	</div>
	<div class="main">
	    <div class="container">
	    	<div class="logo-container">
	    		<img src="images/pal-logo.png" class="img-comp">
	    	</div>
	    	
	        <h2>GATE IN PASS</h2>
	        <form method="POST" id="frmappgateinpass" class="signup-form" autocomplete="off">
	            <button class="btn btn-primary d-none" onclick="funGIPPrint();">Print</button>
	            <h3>
	                <span class="title_text">Master Info</span>
	            </h3>
	            <fieldset>
	                <div class="fieldset-content">
	                    <div class="row">
	                    	<input type="hidden" name="docno" id="docno" placeholder="Doc No"/>
	                    	<div class="col-12 col-sm-6 col-md-4 col-lg-4">
	                			<div class="form-select form-group-w">
	                        		<label for="cmbbranch" class="form-label">Branch</label>
	                        		<select name="cmbbranch" id="cmbbranch">
	                            		<option value="">--Select--</option>
	                        		</select>
	                    		</div>
	                		</div>
	                		<div class="col-12 col-sm-6 col-md-4 col-lg-4">
		                		<div class="form-group form-group-w">
		                        	<label for="regno" class="form-label">Reg No / Stock No</label>
		                        	<input type="text" name="regno" id="regno" placeholder="Reg No" onkeyup="funFilterList(this);"/>
		                        	<div class="searchlist-container">
		                        		<ul id="regnosearchlist" class="searchlist list-group d-none">
	  										
										</ul>
		                        	</div>
		                    	</div>	
		                	</div>
		                    <div class="col-12 col-sm-6 col-md-4 col-lg-4">
		                    	<div class="form-group form-group-w">
			                        <label for="platecode" class="form-label">Plate Code</label>
			                        <input type="text" name="platecode" id="platecode" placeholder="Plate Code"  onkeyup="funFilterList(this);"/>
			                        <div class="searchlist-container">
		                        		<ul id="platecodesearchlist" class="searchlist list-group d-none">
	  										
										</ul>
		                        	</div>
			                    </div>	
		                    </div>
	                	</div>
	                	<div class="row">
	                		<div class="col-12 col-sm-6 col-md-4 col-lg-4">
	                			<div class="form-group form-group-w">
			                        <label for="brand" class="form-label">Brand</label>
			                        <input type="text" name="brand" id="brand" placeholder="Brand"  onkeyup="funFilterList(this);"/>
			                        <div class="searchlist-container">
		                        		<ul id="brandsearchlist" class="searchlist list-group d-none">
	  										
										</ul>
		                        	</div>
			                    </div>		
	                		</div>
	                		<div class="col-12 col-sm-6 col-md-4 col-lg-4">
	                			<div class="form-group form-group-w">
			                        <label for="model" class="form-label">Model</label>
			                        <input type="text" name="model" id="model" placeholder="Model"  onkeyup="funFilterList(this);"/>
			                        <div class="searchlist-container">
		                        		<ul id="modelsearchlist" class="searchlist list-group d-none">
	  										
										</ul>
		                        	</div>
			                    </div>		
	                		</div>
	                		<div class="col-12 col-sm-6 col-md-4 col-lg-4">
	                			<div class="form-group form-group-w">
			                        <label for="color" class="form-label">Color</label>
			                        <input type="text" name="color" id="color" placeholder="Color"  onkeyup="funFilterList(this);"/>
			                        <div class="searchlist-container">
		                        		<ul id="colorsearchlist" class="searchlist list-group d-none">
	  										
										</ul>
		                        	</div>
			                    </div>		
	                		</div>
	                		<div class="col-12 col-sm-6 col-md-4 col-lg-4">
	                			<div class="form-group form-group-w">
			                        <label for="cmbyom" class="form-label">YoM</label>
			                        <select name="cmbyom" id="cmbyom">
	                            		<option value="">--Select--</option>
	                        		</select>
			                    </div>		
	                		</div>
	                		<div class="col-12 col-sm-6 col-md-4 col-lg-4">
	                			<div class="form-group form-group-w">
			                        <label for="chassisno" class="form-label">Chassis No</label>
			                        <input type="text" name="chassisno" id="chassisno" placeholder="Chassis No" />
			                    </div>
	                		</div>
	                	</div>
	                    <div class="row">
	                    	<div class="col-12 col-sm-12 col-md-12 col-lg-12">
	                    		<div class="form-group form-group-w">
			                        <label for="clientdetails" class="form-label">Client Details</label>
			                        <div class="input-group">
			                        	<input type="text" name="clientdetails" id="clientdetails" placeholder="Client Details" onkeyup="funFilterList(this);"/>
			                        	<div class="input-group-append">
      										<button class="btn btn-default" type="button">
        										<i class="lnr lnr-users"></i>
      										</button>
    									</div>
			                        </div>
			                        <div class="searchlist-container">
		                        		<ul id="clientsearchlist" class="searchlist list-group d-none">
	  										
										</ul>
		                        	</div>
			                    	
			                    </div>		
	                    	</div>
	                    </div>
	                    <div class="row">
	                    	<div class="col-12 col-sm-6 col-md-6 col-lg-6">
	                    		<div class="form-group">
			                        <label for="recievedfromname" class="form-label">Recieved From Name</label>
			                        <input type="text" name="recievedfromname" id="recievedfromname" placeholder="Customer Name" />
			                    </div>
	                    	</div>
	                    	<div class="col-12 col-sm-6 col-md-6 col-lg-6">
	                    		<div class="form-group form-group-w">
			                        <label for="recievedfrommobile" class="form-label">Mobile</label>
			                        <div class="input-group">
			                        	<input type="text" name="recievedfrommobile" id="recievedfrommobile" placeholder="Customer Mobile" onkeyup="funFilterList(this);"/>
			                        	<div class="input-group-append">
      										<button class="btn btn-default" type="button">
        										<i class="lnr lnr-phone-handset"></i>
      										</button>
    									</div>
			                        </div>
			                        <div class="searchlist-container">
		                        		<ul id="mobilesearchlist" class="searchlist list-group d-none">
	  										
										</ul>
		                        	</div>
			                        <!-- <input type="text" name="recievedfrommobile" id="recievedfrommobile" placeholder="Customer Mobile" />-->
			                    </div>
	                    	</div>
	                    	<div class="col-12 col-sm-6 col-md-6 col-lg-6">
	                    		<div class="form-group">
			                        <label for="recievedfromemail" class="form-label">Email</label>
			                        <input type="text" name="recievedfromemail" id="recievedfromemail" placeholder="Customer Email" />
			                    </div>
	                    	</div>
	                    </div>
	                    
	                    
	                    
	                    
	                    <!-- 
	                    <div class="form-group form-password">
	                        <label for="password" class="form-label">Password</label>
	                        <input type="password" name="password" id="password" data-indicator="pwindicator" />
	                        <div id="pwindicator">
	                            <div class="bar-strength">
	                                <div class="bar-process">
	                                    <div class="bar"></div>
	                                </div>
	                            </div>
	                            <div class="label"></div>
	                        </div>
	                    </div>
	                     -->
	                </div>
	                <div class="fieldset-footer">
	                    <span>Step 1 of 3</span>
	                </div>
	            </fieldset>
	            <h3>
	                <span class="title_text">Vehicle Info</span>
	            </h3>
	            <fieldset>
	                <div class="fieldset-content">
	                	<div class="row">
	                		<div class="col-12 col-sm-6 col-md-4 col-lg-4">
	                			<div class="form-group form-group-w">
			                        <label for="cmbrepairtype" class="form-label">Repair Type</label>
			                        <select multiple="multiple" name="cmbrepairtype" id="cmbrepairtype" class="form-control" style="width:100%;">
	                            		<option value="">--Select--</option>
	                        		</select>
			                    </div>		
	                		</div>
	                		<div class="col-3 col-sm-6 col-md-4 col-lg-4">
	                			<div class="form-group text-left">
	                				<label class="control-label">Back Job</label>
	                				<label class="switch">
  										<input type="checkbox" id="chkbackjob">
  										<span class="slider round"></span>
									</label>
	                			</div>
	                		</div>
	                		<div class="col-12 col-sm-6 col-md-4 col-lg-4">
	                			<div class="form-group form-group-w">
			                        <label for="cmbserviceadvisor" class="form-label">Service Advisor</label>
			                        <select name="cmbserviceadvisor" id="cmbserviceadvisor" class="form-control" style="width:100%;">
	                            		<option value="">--Select--</option>
	                        		</select>
			                    </div>		
	                		</div>
	                	</div>
	                	<div class="row">
	                		<div class="col-6 col-sm-6 col-md-4 col-lg-2">
	                			<div class="form-group">
			                        <label for="km" class="form-label">Km</label>
			                        <input type="text" name="km" id="km" placeholder="Kms" />
			                    </div>
	                		</div>
	                		<div class="col-6 col-sm-6 col-md-4 col-lg-2">
	                			<div class="form-select">
	                        		<label for="cmbfuel" class="form-label">Fuel</label>
	                        		<select name="cmbfuel" id="cmbfuel">
	                            		<option value="0.000">Level 0/8</option>
	                            		<option value="0.125">Level 1/8</option>
	                            		<option value="0.250">Level 2/8</option>
	                            		<option value="0.375">Level 3/8</option>
	                            		<option value="0.500">Level 4/8</option>
	                            		<option value="0.625">Level 5/8</option>
	                            		<option value="0.750">Level 6/8</option>
	                            		<option value="0.875">Level 7/8</option>
	                            		<option value="1.000">Level 8/8</option>
	                        		</select>
	                    		</div>
	                		</div>
	                		<div class="col-6 col-sm-6 col-md-4 col-lg-3">
	                			<div class="form-select">
			                        <label for="reftype" class="form-label">Ref Type</label>
			                        <select name="cmbattachtype" id="cmbattachtype"></select>  
			                    </div> 
	                		</div>
	                		<div class="col-12 col-sm-6 col-md-4 col-lg-4">
	                			<div class="form-group">
			                        <!-- <label for="file" class="form-label">Select Photos</label> -->
			                        <div class="input-group">
			                        	<input type="file" id="file" name="file" class="form-control" style="opacity: 1;margin-right: 0;background-color: transparent;border-color: rgba(255,255,255,0.5);">
			                        	<div class="input-group-append">
      										<button type="button" class="btn btn-outline-primary" id="btnupload" style="border-color:transparent;color:#000;font-weight:bold;">
        										<i class="lnr lnr-upload"></i>
      										</button>
    									</div>
			                        </div>
			                    </div>
	                		</div>
	                	</div>
	                    <div class="row">
	                    	<div class="col-12 col-sm-12 col-md-12 col-lg-12">
	                    		<div class="inventory-container">
	                    			
	                    		</div>
	                    	</div>
	                    </div>
	                </div>
	                <div class="fieldset-footer">
	                    <span>Step 2 of 3</span>
	                </div>
	            </fieldset>
	            <h3>
	                <span class="title_text">Estimate Info</span>
	            </h3>
	            <fieldset>
	                <div class="fieldset-content">
	                	<div class="row">
	                		<div class="col-6 col-sm-6 col-md-6 col-lg-6">
	                			<div class="form-group">
			                        <label for="gipestdate" class="form-label">Date</label>
			                        <div class="input-group date" id="gipestdate">
		                    			<input type="text" class="form-control" />
		                    			<span class="input-group-addon">
		                        			<span class="glyphicon glyphicon-calendar"></span>
		                    			</span>
		                			</div>
									<span class="help-block"></span>
			                    </div>
	                		</div>
	                		<div class="col-6 col-sm-6 col-md-6 col-lg-6">
	                			<div class="form-group">
			                        <label for="gipesttime" class="form-label">Time</label>
			                        <div class="input-group date" id="gipesttime">
		                    			<input type="text" class="form-control" />
		                    			<span class="input-group-addon">
		                        			<span class="glyphicon glyphicon-calendar"></span>
		                    			</span>
		                			</div>
									<span class="help-block"></span>
			                    </div>
	                		</div>
	                	</div>
	                	<div class="row">
	                		<div class="col-12 col-sm-12 col-md-12 col-lg-12">
	                			<div class="form-group">
			                        <label for="remarks" class="form-label">Concern</label>
			                        <div class="input-group">
			                        	<input type="text" name="remarks" id="remarks" placeholder="Concern" class="form-control concern-text" style="margin-right:0;"/>
										<div class="input-group-append">
      										<button type="button" class="btn btn-outline-primary btnaddconcern" style="border-color:transparent;color:#000;font-weight:bold;">
        										<i class="lnr lnr-chevron-down"></i>
      										</button>
    									</div>
			                        </div>
			                    </div>
	                		</div>
	                	</div>
	                	<div class="row">
	                		<div class="col-12 col-sm-12 col-md-12 col-lg-12">
	                			<div class="form-group">
			                        <label for="vehimagediv" class="form-label">Vehicle Inspection</label>
			                        <div id="vehimagediv"><jsp:include page="vehImage.jsp"></jsp:include></div>
			                    </div>
	                		</div>
	                	</div>
	                	<div class="row">
	                		<div class="col-12 col-sm-12 col-md-12 col-lg-12">
	                			<div class="form-group">
			                        <label for="signaturediv" class="form-label">Customer Signature</label>
			                        <div id="signaturediv"><jsp:include page="signature.jsp"></jsp:include></div>
			                    </div>
	                		</div>
	                	</div>
	                </div>
	                <div class="fieldset-footer">
	                    <span>Step 3 of 3</span>
	                </div>
	            </fieldset>
	            <input type="hidden" name="mode" id="mode" value="A">
	            <input type="hidden" name="duplicateconfig" id="duplicateconfig" value="0">
	        </form>
	    </div>
	</div>
	<!-- <script src="js/jquery-1.11.1.min.js"></script> -->
	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="vendor/steps/jquery.steps.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.47/js/bootstrap-datetimepicker.min.js" ></script>
	<script src="js/main.js"></script>
	<script type="text/javascript" src="js/ajaxfileupload.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
	
	<script>
		var fieldsizedata={};
		$(document).keypress(function(event){
	    	if (event.which == '13') {
	      		event.preventDefault();
	    	}
		});
		var gipform=$('#frmappgateinpass');
		
		var stepstatus=false;
		function funFilterList(el){
			var input=$(el).val();
			input = input.toUpperCase();
			var li=$(el).closest('.form-group').find('.searchlist li');
			for (i = 0; i < li.length; i++) {
    			var a = li[i].getElementsByTagName("a")[0];
    			var txtValue = a.textContent || a.innerText;
    			if (txtValue.toUpperCase().indexOf(input) > -1) {
      				li[i].style.display = "";
    			} else {
      				li[i].style.display = "none";
    			}
  			}
			
		}
		function funAddConcern(elm){
			var concerntext=$(elm).closest('.concern-text').val();
			if(concerntext!=''){
				var htmldata='';
				htmldata+='<div class="form-group">';
		        htmldata+='<label for="remarks" class="form-label" style="opacity:0;">Concern</label>';
		        htmldata+='<div class="input-group">';
		        htmldata+='<input type="text" placeholder="Concern" class="form-control concern-text" style="margin-right:0;">';
				htmldata+='<div class="input-group-append">';
     				htmldata+='<button type="button" class="btn btn-outline-primary btnaddconcern" style="border-color:transparent;color:#000;font-weight:bold;">';
       			htmldata+='<i class="lnr lnr-chevron-down"></i>';
     				htmldata+='</button>';
   				htmldata+='</div>';
		        htmldata+='</div>';
		        htmldata+='</div>';
				$(elm).closest('.form-group').parent().append($.parseHTML(htmldata));
				$(elm).closest('.form-group').next().find('.btnaddconcern').on('click',function(){
					funAddConcern(this);	
				});
			}
		}
		$(document).ready(function(){
			getRefType();
			$('.btnaddconcern').on('click',function(){
				var concerntext=$(this).closest('.concern-text').val();
				if(concerntext!=''){
					var htmldata='';
					htmldata+='<div class="form-group">';
			        htmldata+='<label for="remarks" class="form-label" style="opacity:0;">Concern</label>';
			        htmldata+='<div class="input-group">';
			        htmldata+='<input type="text" placeholder="Concern" class="form-control concern-text" style="margin-right:0;">';
					htmldata+='<div class="input-group-append">';
      				htmldata+='<button type="button" class="btn btn-outline-primary btnaddconcern" style="border-color:transparent;color:#000;font-weight:bold;">';
        			htmldata+='<i class="lnr lnr-chevron-down"></i>';
      				htmldata+='</button>';
    				htmldata+='</div>';
			        htmldata+='</div>';
			        htmldata+='</div>';
					$(this).closest('.form-group').parent().append($.parseHTML(htmldata));
					$(this).closest('.form-group').next().find('.btnaddconcern').on('click',function(){
						funAddConcern(this);	
					});
				}
			});
			$('#docno').change(function(){
				if($(this).val()!=''){
					$('h2').append(' #'+$(this).val());
				}
				else{
					$('h2').text('GATE IN PASS');
				}
			});
			$("#clientdetails,#recievedfrommobile").keyup(function (e) {
				if($(this).val()==''){
					$('#clientdetails').val('');
		    		$('#recievedfromname').val('');
		    		$('#recievedfromname').attr('data-cldocno','');
		    		$('#recievedfrommobile').val('');
		    		$('#recievedfromemail').val('');
				}
				var cldocno=$('#recievedfromname').attr('data-cldocno');
				if(cldocno=='' || cldocno=='undefined' || typeof(cldocno)=='undefined' || cldocno==null){
					$('#recievedfromname').attr('data-cldocno','');
				}
		    	if($('#recievedfromname').attr('data-cldocno')==''){
		    		if($(this).attr('id')=='clientdetails'){
		    			$('#recievedfromname').val($(this).val());	
		    		}
		    		
		    	}
			});
			$("#regno,#recievedfrommobile,#km").keypress(function (e) {
            	var keyCode = e.keyCode || e.which;
            	//Regex for Valid Characters i.e.Numbers only.
            	var regex = /^[0-9]+$/;
	            //Validate TextBox value against the Regex.
    	        var isValid = regex.test(String.fromCharCode(keyCode));
        	    var targetid='#'+$(this).attr('id');
        	    $(targetid).parent().find('span.help-block').remove();
        	    if (!isValid) {
            	    $(targetid).parent().find('span.help-block').remove();
            	    $(targetid).parent().append($.parseHTML('<span class="help-block">Only Numbers Allowed</span>'));
            	}
            	else{
            		$(targetid).parent().find('span.help-block').remove();
            	}
            return isValid;
        });
			$('#cmbbranch').change(function(){
				getRegNoData($(this).val());
			});
				/*$('#regno').blur(function(){
					if($(this).val()!=''){
						if($(this).closest('.form-group').find('.searchlist').hasClass('d-none')){
							
						}
						else{
							$(this).closest('.form-group').find('.searchlist').addClass('d-none')
						}	
						return false;
					}
					
					
				});*/
				$('#gipestdate').datetimepicker({
		    		format:"DD.MM.YYYY",
		    		date: new Date(),
		    		allowInputToggle:true
		    	});
		    	$('#gipesttime').datetimepicker({
		    		format:"HH:mm",
		    		date: new Date(),
		    		allowInputToggle:true
		    	});
				getInitData();
		    	//$('#date').data("DateTimePicker").date(moment());
			
				$('.form-group-w').each(function(key,value){
		    		var searchstatus=$(this).find('.searchlist-container').length;
		    		if(searchstatus==1){
		    			$(this).find('input:not(#clientdetails,#recievedfrommobile)').click(function(e){
		    				
		    			}).focus(function(e){
		    				$('.searchlist').addClass('d-none');
		    				$(this).closest('.form-group-w').find('.searchlist').toggleClass('d-none');
		    				$(this).closest('.form-group-w').find('.searchlist').show();
		    				return false;
		    			});
		    		}
		    	});
		    
		    	$('.form-group-w').each(function(key,value){
		    		var searchstatus=$(this).find('.searchlist-container').length;
		    		if(searchstatus==1){
		    			$(this).find('.input-group').find('.btn').click(function(e){
		    				$('.searchlist').addClass('d-none');
		    				if($(this).closest('.form-group-w').find('.searchlist').hasClass('d-none')){
		    					$(this).closest('.form-group-w').find('.searchlist').removeClass('d-none');
		    				}
		    				$(this).closest('.form-group-w').find('.searchlist').show();
		    				return false;
		    			});
		    		}
		    	});
		    $('#btnupload').click(function(){
		    	
		        if(document.getElementById("file").files.length > 0 ){
		        	//console.log(document.getElementById("file").files);
		        	$('.page-loader').show();
		        	var docno=$('#docno').val();
		        	var attachdesc='App attachment of GIP# '+docno;
		        	attachdesc=encodeURIComponent(attachdesc);
		        	console.log('appAttachAction.action?formCode=GIP&doc_no='+docno+'&descpt='+attachdesc+'&reftypid=2');  
					$.ajaxFileUpload({
              			url:'appAttachAction.action?formCode=GIP&doc_no='+docno+'&descpt='+attachdesc+'&reftypid='+$("#cmbattachtype").val(),
            			secureuri:false,//false  
            			fileElementId:'file',//id  <input type="file" id="file" name="file" />  
            			dataType: 'json',// json  
            			success: function (data, status){  
               				if(status=='success'){
               					$('.page-loader').hide();
			            		Swal.fire({
									icon: 'success',
						  			title: 'Success',
						  			text: 'Upload successfull'
								});
                  			}
                  			else if(typeof(data.error) != 'undefined'){
                  				$('.page-loader').hide();  
                      			if(data.error != ''){
                      				Swal.fire({
										icon: 'error',
							  			title: 'Error',
							  			text: data.error
									});
                      			}
                      			else{
                      				$('.page-loader').hide();
                      				Swal.fire({
										icon: 'warning',
							  			title: 'Warning',
							  			text: data.message
									});  
                      			}  
                  			}  
              			},  
              			error: function (data, status, e){
              				$('.page-loader').hide(); 
              				Swal.fire({
								icon: 'warning',
					  			title: 'Warning',
					  			text: e
							});
              			}  
          			});  
      			}
		    });
		    
		});
		function getRegNoData(brhid){
			var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();
	  				items=JSON.parse(items);
	  				var htmldata='';
	  				$.each(items.regnodata,function(index,value){
	  					htmldata+='<li class="list-group-item"><a href="#" data-username="'+value.username+'" data-regno="'+value.regno+'" data-pltid="'+value.pltid+'" data-brandid="'+value.brandid+'" data-brandname="'+value.brandname+'" data-modelid="'+value.modelid+'" data-modelname="'+value.modelname+'" data-chassisno="'+value.chassisno+'" data-refname="'+value.refname+'" data-cldocno="'+value.cldocno+'" data-mobile="'+value.mobile+'" data-email="'+value.email+'" data-yom="'+value.yom+'" data-colorname="'+value.colorname+'" data-colorid="'+value.colorid+'">'+value.regno+' '+value.pltid+'</li>';
	  				});
	  				$('#regnosearchlist').html($.parseHTML(htmldata));
	  				
	  				$('.searchlist li a').on('click',function(){
				    	var value=$(this).text();
				    	if($(this).closest('.form-group-w').find('input').attr('id')=='regno'){
				    	
				    		$('#regno').val($(this).attr('data-regno'));
				    		$('#platecode').val($(this).attr('data-pltid'));
				    		$('#platecode').attr('data-docno',$(this).attr('data-pltid'));
				    		$('#brand').val($(this).attr('data-brandname'));
				    		$('#brand').attr('data-docno',$(this).attr('data-brandid'));
				    		$('#model').val($(this).attr('data-modelname'));
				    		$('#model').attr('data-docno',$(this).attr('data-modelid'));
				    		$('#color').val($(this).attr('data-colorname'));
				    		$('#color').attr('data-docno',$(this).attr('data-colorid'));
				    		
				    		$('#chassisno').val($(this).attr('data-chassisno'));
				    		$('#clientdetails').val($(this).attr('data-refname'));
				    		$('#recievedfromname').val($(this).attr('data-username'));
				    		$('#recievedfromname').attr('data-cldocno',$(this).attr('data-cldocno'));
				    		$('#recievedfrommobile').val($(this).attr('data-mobile'));
				    		$('#recievedfromemail').val($(this).attr('data-email'));
				    		$('#cmbyom').val($(this).attr('data-yom'));
				    	    $('#cmbyom').select2().trigger('change');
				    	    validatechassisno();
				    	}
				    	$(this).closest('.searchlist').toggleClass('d-none');
				    	return false;
				    });
	  				}
	  		}
	  		x.open("GET", "getRegNoData.jsp?brhid="+brhid, true);
	  		x.send();
		}
		function getInitData(){
			var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();
	  				items=JSON.parse(items);
	  				fieldsizedata=items.fieldsizedata;
	  				var htmldata='',mobilehtmldata='';
	  				console.log(items);
	  				$('#duplicateconfig').val(items.duplicateconfig);
	  				$.each(items.clientdata,function(index,value){
	  					htmldata+='<li class="list-group-item"><a href="#" data-docno="'+value.docno+'" data-mobile="'+value.mobile+'" data-email="'+value.email+'" data-name="'+value.refname+'">'+value.refname+' '+value.mobile+'</li>';
	  					mobilehtmldata+='<li class="list-group-item"><a href="#" data-docno="'+value.docno+'" data-mobile="'+value.mobile+'" data-email="'+value.email+'" data-name="'+value.refname+'">'+value.mobile+'</li>';
	  				});
	  				$('#clientsearchlist').html($.parseHTML(htmldata));
	  				$('#mobilesearchlist').html($.parseHTML(mobilehtmldata));
	  				htmldata='';
	  				$.each(items.branddata,function(index,value){
	  					htmldata+='<li class="list-group-item"><a href="#" data-docno="'+value.docno+'">'+value.refname+'</li>';
	  				});
	  				$('#brandsearchlist').html($.parseHTML(htmldata));
	  				htmldata='';
	  				$.each(items.colordata,function(index,value){
	  					htmldata+='<li class="list-group-item"><a href="#" data-docno="'+value.docno+'">'+value.refname+'</li>';
	  				});
	  				$('#colorsearchlist').html($.parseHTML(htmldata));
	  				htmldata='';
	  				$.each(items.regnodata,function(index,value){
	  					htmldata+='<li class="list-group-item"><a href="#" data-username="'+value.username+'" data-regno="'+value.regno+'" data-pltid="'+value.pltid+'" data-brandid="'+value.brandid+'" data-brandname="'+value.brandname+'" data-modelid="'+value.modelid+'" data-modelname="'+value.modelname+'" data-chassisno="'+value.chassisno+'" data-refname="'+value.refname+'" data-cldocno="'+value.cldocno+'" data-mobile="'+value.mobile+'" data-email="'+value.email+'" data-yom="'+value.yom+'">'+value.regno+' '+value.pltid+'</li>';
	  				});
	  				$('#regnosearchlist').html($.parseHTML(htmldata));
	  				htmldata='';
	  				$.each(items.platedata,function(index,value){
	  					htmldata+='<li class="list-group-item"><a href="#" data-docno="'+value.docno+'">'+value.refname+'</li>';
	  				});
	  				$('#platecodesearchlist').html($.parseHTML(htmldata));
	  				htmldata='<option value="">--Select--</option>';
	  				$.each(items.repairtypedata,function(index,value){
	  					htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
	  				});
	  				$('#cmbrepairtype').html($.parseHTML(htmldata));
	  				$('#cmbrepairtype').select2({
						placeholder: "Select Repair Type",
		  				allowClear: true
					});
	  				htmldata='';
	  				$.each(items.branchdata,function(index,value){
	  					htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
	  				});
	  				$('#cmbbranch').html($.parseHTML(htmldata));
	  				$('#cmbbranch').select2({
						placeholder: "Select a status",
		  				allowClear: true
					});
					htmldata='<option value="">--Select--</option>';
	  				$.each(items.serviceadvisordata,function(index,value){
	  					htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
	  				});
	  				$('#cmbserviceadvisor').html($.parseHTML(htmldata));
	  				$('#cmbserviceadvisor').select2({
						placeholder: "Select Service Advisor",
		  				allowClear: true
					});
					htmldata='';
	  				$.each(items.yomdata,function(index,value){
	  					htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
	  				});
	  				$('#cmbyom').html($.parseHTML(htmldata));
	  				$('#cmbyom').select2({
						placeholder: "Select a year",
		  				allowClear: true
					});
	  				htmldata='<fieldset><legend>Inventory List</legend><ul class="list-group">';
	  				$.each(items.inventorydata,function(index,value){
						htmldata+='<li class="list-group-item inventory-item" data-docno="'+value.docno+'">';
                        htmldata+='<div class="custom-control custom-checkbox">';
                        htmldata+='<input class="custom-control-input" id="inventoryitemchk'+index+'" type="checkbox">';
                        htmldata+='<label class="cursor-pointer font-italic d-block custom-control-label" for="inventoryitemchk'+index+'">'+value.refname+'</label>';
                        htmldata+='</div>';
                        htmldata+='</li>';
	  					/*htmldata+='<div class="inventory-item" data-docno="'+value.docno+'">';
						htmldata+='<div class="col-9"><label>'+value.refname+'</label></div>';
		                htmldata+='<div class="col-3"><input type="checkbox" style="display:inline-block;" class="form-control"></div>';
		                htmldata+='</div>';*/
	  				});
	  				htmldata+='</ul></fieldset>';
	  				$('.inventory-container').html($.parseHTML(htmldata));
	  				
	  				$('.searchlist li a').on('click',function(){
				    	var value=$(this).text();
				    	
				    	if($(this).closest('.form-group-w').find('input').attr('id')=='brand'){
				    		var docno=$(this).attr('data-docno');
				    		$(this).closest('.form-group-w').find('input').val(value);
				    		$(this).closest('.form-group-w').find('input').attr('data-docno',docno);
				    		getModel(docno);
				    	}
				    	else if($(this).closest('.form-group-w').find('input').attr('id')=='regno'){
				    	
				    		$('#regno').val($(this).attr('data-regno'));
				    		$('#platecode').val($(this).attr('data-pltid'));
				    		$('#brand').val($(this).attr('data-brandname'));
				    		$('#brand').attr('data-docno',$(this).attr('data-brandid'));
				    		$('#model').val($(this).attr('data-modelname'));
				    		$('#model').attr('data-docno',$(this).attr('data-modelid'));
				    		$('#chassisno').val($(this).attr('data-chassisno'));
				    		$('#clientdetails').val($(this).attr('data-refname'));
				    		$('#recievedfromname').val($(this).attr('data-username'));
				    		$('#recievedfromname').attr('data-cldocno',$(this).attr('data-cldocno'));
				    		$('#recievedfrommobile').val($(this).attr('data-mobile'));
				    		$('#recievedfromemail').val($(this).attr('data-email'));
				    		$('#cmbyom').val($(this).attr('data-yom'));
				    	    $('#cmbyom').select2().trigger('change');
				    	}
				    	else if($(this).closest('.form-group-w').find('input').attr('id')=='clientdetails'){
				    		$('#clientdetails').val($(this).attr('data-name'));
				    		$('#recievedfromname').val($(this).attr('data-name'));
				    		$('#recievedfromname').attr('data-cldocno',$(this).attr('data-docno'));
				    		$('#recievedfrommobile').val($(this).attr('data-mobile'));
				    		$('#recievedfromemail').val($(this).attr('data-email'));
				    		//console.log($(this).html());
				    	}
				    	else if($(this).closest('.form-group-w').find('input').attr('id')=='recievedfrommobile'){
				    		$('#clientdetails').val($(this).attr('data-name'));
				    		$('#recievedfromname').val($(this).attr('data-name'));
				    		$('#recievedfromname').attr('data-cldocno',$(this).attr('data-docno'));
				    		$('#recievedfrommobile').val($(this).attr('data-mobile'));
				    		$('#recievedfromemail').val($(this).attr('data-email'));
				    		//console.log($(this).html());
				    	}
				    	else{
				    		var docno=$(this).attr('data-docno');
				    		$(this).closest('.form-group-w').find('input').val(value);
				    		$(this).closest('.form-group-w').find('input').attr('data-docno',docno);
				    	}
				    	$(this).closest('.searchlist').hide();
				    	
				    	return false;
				    });
				    getRegNoData($('#cmbbranch').val());
				    $('.page-loader').hide();
	  			}
	  		}
	  		x.open("GET", "getInitData.jsp", true);
	  		x.send();
		}
		
		function getModel(brandid){
			var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();
	  				items=JSON.parse(items);
	  				var htmldata='';
	  				$.each(items.modeldata,function(index,value){
	  					htmldata+='<li class="list-group-item"><a href="#" data-docno="'+value.docno+'">'+value.refname+'</li>';
	  				});
	  				$('#modelsearchlist').html($.parseHTML(htmldata));
	  				$('#modelsearchlist li a').on('click',function(){
				    	var value=$(this).text();
				    	var docno=$(this).attr('data-docno');
				    	$(this).closest('.form-group-w').find('input').val(value);
				    	$(this).closest('.form-group-w').find('input').attr('data-docno',docno);
				    	$(this).closest('.searchlist').toggleClass('d-none');
				    	return false;
				    });
	  			}
	  		}
	  		x.open("GET", "getModel.jsp?brandid="+brandid, true);
	  		x.send();
		}
		
		async function checkDuplicateGIP(regno,platecode){
			return await $.ajax({
				url: "checkDuplicateGIP.jsp",
				type: "GET",
				async: false,
				data:{'regno':regno,'platecode':platecode}
			});
		}
		gipform.steps({
					//startIndex: 2,
			        headerTag: "h3",
			        bodyTag: "fieldset",
			        transitionEffect: "slideLeft",
			        labels: {
			            previous: 'Previous',
			            next: 'Next',
			            finish: 'Submit',
			            current: ''
			        },
			        titleTemplate: '<div class="title"><span class="number">#index#</span>#title#</div>',
			        onStepChanging: function(event, currentIndex, newIndex) {
			        	console.log(event);
			        	if(newIndex<currentIndex){
			        		return true;
			        	}
			        	if(stepstatus){
			        		stepstatus=false;
			        		return true;
			        	}
			        	if(currentIndex==0){
			        		var regno=$('#regno').val();
							var platecode=$('#platecode').val();
							var brandid=$('#brand').attr('data-docno');
							var plateid=$('#platecode').attr('data-docno');
							var colorid=$('#color').attr('data-docno');
							//return true;
			        		
							if(regno.trim()=="" || regno.trim()=="undefined"){
								$('#regno').addClass('error');
								$('#regno').parent().find('span.help-block').remove();
								$('#regno').parent().append($.parseHTML('<span class="help-block">Regno is mandatory</span>'));
								return false;
							}
							else{
								$('#regno').removeClass('error');
								$('#regno').parent().find('span.help-block').remove();
							}
							if(platecode.trim()=="" || platecode.trim()=="undefined"){
								$('#platecode').addClass('error');
								$('#platecode').parent().find('span.help-block').remove();
								$('#platecode').parent().append($.parseHTML('<span class="help-block">Plate Code is mandatory</span>'));
								return false;
							}
							else{
								$('#platecode').removeClass('error');
								$('#platecode').parent().find('span.help-block').remove();
							}
							if(typeof(plateid)=="undefined" || plateid.trim()=="" || plateid.trim()=="undefined"){
								$('#platecode').addClass('error');
								$('#platecode').parent().find('span.help-block').remove();
								$('#platecode').parent().append($.parseHTML('<span class="help-block">Please Select Plate Code</span>'));
								return false;
							}
							else{
								$('#platecode').removeClass('error');
								$('#platecode').parent().find('span.help-block').remove();
							}
							if(typeof(colorid)=="undefined" || colorid.trim()=="" || colorid.trim()=="undefined"){
								$('#color').addClass('error');
								$('#color').parent().find('span.help-block').remove();
								$('#color').parent().append($.parseHTML('<span class="help-block">Please Select Color</span>'));
								return false;
							}
							else{
								$('#color').removeClass('error');
								$('#color').parent().find('span.help-block').remove();
							}
							if(typeof(brandid)=="undefined" || brandid.trim()=="" || brandid.trim()=="undefined"){
								$('#brand').addClass('error');
								$('#brand').parent().find('span.help-block').remove();
								$('#brand').parent().append($.parseHTML('<span class="help-block">Brand is mandatory</span>'));
								return false;
							}
							else{
								$('#brand').removeClass('error');
								$('#brand').parent().find('span.help-block').remove();
							}
							var modelid=$('#model').attr('data-docno');
							if(typeof(modelid)=="undefined" || modelid=="" || modelid=="undefined"){
								$('#model').addClass('error');
								$('#model').parent().find('span.help-block').remove();
								$('#model').parent().append($.parseHTML('<span class="help-block">Model is mandatory</span>'));
								return false;
							}
							else{
								$('#model').removeClass('error');
								$('#model').parent().find('span.help-block').remove();
							}
							var branchid=$('#cmbbranch').val();
							var chassisno=$('#chassisno').val();
							var recievedfromname=$('#recievedfromname').val();
							if(recievedfromname.trim()==''){
								$('#recievedfromname').parent().find('span.help-block').remove();
								$('#recievedfromname').parent().append($.parseHTML('<span class="help-block">Name is mandatory</span>'));
								$('#recievedfromname').addClass('error');
								return false;
							}
							else{
								$('#recievedfromname').parent().find('span.help-block').remove();
								$('#recievedfromname').removeClass('error');
							}
							
							var clientdetails=$('#clientdetails').val();
							if(clientdetails.trim()==''){
								$('#clientdetails').parent().find('span.help-block').remove();
								$('#clientdetails').parent().append($.parseHTML('<span class="help-block">Client Name is mandatory</span>'));
								$('#clientdetails').addClass('error');
								return false;
							}
							else{
								$('#clientdetails').parent().find('span.help-block').remove();
								$('#clientdetails').removeClass('error');
							}
							
							var recievedfrommobile=$('#recievedfrommobile').val();							
							if(recievedfrommobile.length!=12){
								$('#recievedfrommobile').parent().find('span.help-block').remove();
								$('#recievedfrommobile').parent().append($.parseHTML('<span class="help-block">Mobile No must be 12 digits</span>'));
								$('#recievedfrommobile').addClass('error');
								return false;
							}
							else{
								$('#recievedfrommobile').parent().find('span.help-block').remove();
								$('#recievedfrommobile').removeClass('error');
							}
							var sizeinvalid=0;							
							$('#recievedfrommobile,#clientdetails,#recievedfromname,#recievedfromemail').each(function(){
								var targetsize=0;
								var targetid=$(this).attr('id');
								var targetvalue=$(this).val();
								if(targetid=='recievedfrommobile'){
									targetsize=fieldsizedata.mobile;
								}
								else if(targetid=='clientdetails'){
									targetsize=fieldsizedata.clientname;
								}
								else if(targetid=='recievedfromname'){
									targetsize=fieldsizedata.username;
								}
								else if(targetid=='recievedfromemail'){
									targetsize=fieldsizedata.email;
								}
								else{
								}
								if(targetvalue.length>targetsize){
									$(this).parent().find('span.help-block').remove();
									$(this).parent().append($.parseHTML('<span class="help-block">Max '+targetsize+' Chars only</span>'));
									$(this).addClass('error');
									sizeinvalid=1;
									return false;
								}
								else{
									$(this).parent().find('span.help-block').remove();
									$(this).removeClass('error');
								}
							});  
							if(sizeinvalid==1){
								return false;
							}
							
							$('#chassisno').each(function(){
								var targetsize=0;
								var targetid=$(this).attr('id');
								var targetvalue=$(this).val();
								if(targetid=='chassisno'){
									targetsize=fieldsizedata.chassis;
								}else{
								}
								if(targetsize==17){        
									if(targetvalue.length!=targetsize){   
										$(this).parent().find('span.help-block').remove(); 
										$(this).parent().append($.parseHTML('<span class="help-block">Chassis No must be '+targetsize+' Chars only</span>'));  
										$(this).addClass('error');
										sizeinvalid=1;
										return false;
									}
									else{
										$(this).parent().find('span.help-block').remove();
										$(this).removeClass('error');
									}
								}else{
									if(targetvalue.length>targetsize){
										$(this).parent().find('span.help-block').remove();
										$(this).parent().append($.parseHTML('<span class="help-block">Max '+targetsize+' Chars only</span>'));
										$(this).addClass('error');
										sizeinvalid=1;
										return false;
									}
									else{
										$(this).parent().find('span.help-block').remove();
										$(this).removeClass('error');
									}
								}
							});
							if(sizeinvalid==1){
								return false;
							}
							var cldocno=$('#recievedfromname').attr('data-cldocno');
							
							var cmbyom=$('#cmbyom').val();
							clientdetails=encodeURIComponent(clientdetails);
							brandid=encodeURIComponent(brandid);
							modelid=encodeURIComponent(modelid);
							colorid=encodeURIComponent(colorid);
							chassisno=encodeURIComponent(chassisno);
							recievedfromname=encodeURIComponent(recievedfromname);
							recievedfrommobile=encodeURIComponent(recievedfrommobile);
							branchid=encodeURIComponent(branchid);
							var recievedfromemail=$('#recievedfromemail').val();
							
							/*if (/^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/.test(recievedfromemail))
							{
  								$('#recievedfromemail').removeClass('error');
  								$('#recievedfromemail').parent().find('span.help-block').remove();
							}
							else{
								$('#recievedfromemail').parent().find('span.help-block').remove();
								$('#recievedfromemail').addClass('error');
								$('#recievedfromemail').parent().append($.parseHTML('<span class="help-block">Please enter valid email</span>'));
								return false;
							}*/
						
							
							$('.page-loader').show();
							if(recievedfromemail!=''){
								recievedfromemail=encodeURIComponent(recievedfromemail);
							}
							
							var docno=$('#docno').val();
							if($('#duplicateconfig').val()=='1'){
								$.get('checkDuplicateGIP.jsp',{'regno':regno,'platecode':platecode},function(data){
									data=JSON.parse(data);									
									if(data.gipexist=="1"){
										$('.page-loader').hide();
										$('#regno').addClass('error');
										$('#regno').parent().find('span.help-block').remove();
										$('#regno').parent().append($.parseHTML('<span class="help-block">GIP Already Exists #'+data.gipvocno+'</span>'));
										$('#regno').focus();
										return false;
									}
									else{
										regno=encodeURIComponent(regno);
										platecode=encodeURIComponent(platecode);
										
										var x = new XMLHttpRequest();
								  		x.onreadystatechange = function() {
								  			if (x.readyState == 4 && x.status == 200) {
								  				var items = x.responseText.trim();
								  				if(items.split("::")[0]=="0"){
								  					$('#docno').val(items.split("::")[1]);
								  					stepstatus = true;
			                        				//This will move to next step.
			                        				$('.page-loader').hide();
			                        				$(gipform).steps("next");
								  					return true;
								  				}
								  				else{
								  					alert("Ajax Error");
								  					return false;
								  				}
								  			}
								  		}
								  		x.open("GET", "saveData.jsp?colorid="+colorid+"&docno="+docno+"&regno="+regno+"&platecode="+platecode+"&brandid="+brandid+"&modelid="+modelid+"&chassisno="+chassisno+"&recievedfromname="+recievedfromname+"&recievedfrommobile="+recievedfrommobile+"&cldocno="+cldocno+"&mode="+currentIndex+"&branchid="+branchid+"&clientdetails="+clientdetails+"&recievedfromemail="+recievedfromemail+"&cmbyom="+cmbyom, true);
								  		x.send();				
									}
								});
							}
							else{
								regno=encodeURIComponent(regno);
								platecode=encodeURIComponent(platecode);
								
								var x = new XMLHttpRequest();
						  		x.onreadystatechange = function() {
						  			if (x.readyState == 4 && x.status == 200) {
						  				var items = x.responseText.trim();
						  				if(items.split("::")[0]=="0"){
						  					$('#docno').val(items.split("::")[1]);
						  					stepstatus = true;
	                        				//This will move to next step.
	                        				$('.page-loader').hide();
	                        				$(gipform).steps("next");
						  					return true;
						  				}
						  				else{
						  					alert("Ajax Error");
						  					return false;
						  				}
						  			}
						  		}
						  		x.open("GET", "saveData.jsp?colorid="+colorid+"&docno="+docno+"&regno="+regno+"&platecode="+platecode+"&brandid="+brandid+"&modelid="+modelid+"&chassisno="+chassisno+"&recievedfromname="+recievedfromname+"&recievedfrommobile="+recievedfrommobile+"&cldocno="+cldocno+"&mode="+currentIndex+"&branchid="+branchid+"&clientdetails="+clientdetails+"&recievedfromemail="+recievedfromemail+"&cmbyom="+cmbyom, true);
						  		x.send();	
							}
							        		
						}
						else if(currentIndex==1){
							//return true;
							var docno=$('#docno').val();
							var repairtypearray=new Array();
							var cmbrepairtype=$('#cmbrepairtype').val();
							//alert(cmbrepairtype);
							var km=$('#km').val();
							var cmbfuel=$('#cmbfuel').val();
							var cmbserviceadvisor=$('#cmbserviceadvisor').val();
							var chkbackjob=0;
							if(document.getElementById("chkbackjob").checked==true){
								chkbackjob=1;
							}
							if(km=='' || km=='undefined'){
								$('#km').addClass('error');
								return false;
							}
							else{
								$('#km').removeClass('error');
							}
							if(cmbserviceadvisor=='' || cmbserviceadvisor=='undefined' || typeof(cmbserviceadvisor)=='undefined'){
								$('#cmbserviceadvisor').parent().find('span.help-block').remove();
								$('#cmbserviceadvisor').parent().append($.parseHTML('<span class="help-block">Service Advisor is Mandatory</span>'));
            					$('#cmbserviceadvisor').parent().find('.select2-container--default .select2-selection--single').addClass('error');
            					return false;
            				}
            				else{
            					$('#cmbserviceadvisor').removeClass('error').parent().find('span.help-block').remove();
            					$('#cmbserviceadvisor').parent().find('.select2-container--default .select2-selection--single').removeClass('error');
            				}
							var inventoryarray=new Array();
							$('.inventory-container input[type=checkbox]:checked').each(function () {
								var inventorydocno= $(this).closest('.inventory-item').attr('data-docno'); 
								inventoryarray.push(inventorydocno+"::"+1);
							});
							var x = new XMLHttpRequest();
							x.onreadystatechange = function() {
								if (x.readyState == 4 && x.status == 200) {
									var items = x.responseText.trim();
									if(items.split("::")[0]=="0"){
					  					stepstatus = true;
                        				//This will move to next step.
                        				$(gipform).steps("next");
					  					return true;
					  				}
					  				else{
					  					alert("Ajax Error");
					  					return false;
					  				}
								}
							}
							x.open("GET", "saveData.jsp?chkbackjob="+chkbackjob+"&inventoryarray="+inventoryarray+"&cmbserviceadvisor="+cmbserviceadvisor+"&docno="+docno+"&cmbrepairtype="+cmbrepairtype+"&km="+km+"&fuel="+cmbfuel+"&mode="+currentIndex, true);
							x.send();	
						}
									
			        },
			        onStepChanged: function(event, currentIndex, priorIndex) {
			        	$("html, body").animate({ scrollTop: 0 }, "slow");
			        	if(currentIndex!=0){
			        		$('#btnclear').parent().hide();
			        	}
			        	else{
			        		$('#btnclear').parent().show();
			        	}
			        	if(currentIndex==2){
			        		$('#vehimagediv').load('vehImage.jsp');
			        		$('#signaturediv').load('signature.jsp');
			        	}
			        },
			        onFinishing: function(event, currentIndex) {
			            if(stepstatus){
			        		stepstatus=false;
			        		return true;
			        	}
			            if(currentIndex==2){
							var gipestdate=$('#gipestdate').find('input').val();
							var gipesttime=$('#gipesttime').find('input').val();
							var remarkarray=new Array();
							$('.concern-text').each(function(index,value){
								remarkarray.push($(value).val());
							});
							var remarks=$('#remarks').val();
							remarks=encodeURIComponent(remarks);
							var docno=$('#docno').val();
							if(gipestdate==''){
								$('#gipestdate').closest('.form-group').addClass('has-error');
								$('#gipestdate').closest('.form-group').find('.help-block').text('');
								$('#gipestdate').closest('.form-group').find('.help-block').text('Date is mandatory');
								$('#gipestdate').closest('.form-group').find('.help-block').css('display','block');
								return false;
							}
							else{
								$('#gipestdate').closest('.form-group').removeClass('has-error');
								$('#gipestdate').closest('.form-group').find('.help-block').text('');
								$('#gipestdate').closest('.form-group').find('.help-block').css('display','none');
							}
							if(gipesttime==''){
								$('#gipesttime').closest('.form-group').addClass('has-error');
								$('#gipesttime').closest('.form-group').find('.help-block').text('');
								$('#gipesttime').closest('.form-group').find('.help-block').text('Time is mandatory');
								$('#gipesttime').closest('.form-group').find('.help-block').css('display','block');
								return false;
							}
							else{
								$('#gipesttime').closest('.form-group').removeClass('has-error');
								$('#gipesttime').closest('.form-group').find('.help-block').text('');
								$('#gipesttime').closest('.form-group').find('.help-block').css('display','none');
							}
							if($('#remarks').val().length>fieldsizedata.mainremarks){
								$('#remarks').parent().find('span.help-block').remove();
								$('#remarks').parent().append($.parseHTML('<span class="help-block">Max '+fieldsizedata.mainremarks+' Chars only</span>'));
								$('#remarks').addClass('error');
								sizeinvalid=1;
								return false;
							}
							else{
								$('#remarks').parent().find('span.help-block').remove();
								$('#remarks').removeClass('error');
							}
							if(vehImagePad.isEmpty()){
								Swal.fire({
									icon: 'warning',
									title: 'Warning',
									text: 'Please mark Inspection'
								});
								return false;
							}
							if(signaturePad.isEmpty()) {
			    				Swal.fire({
									icon: 'warning',
									title: 'Warning',
									text: 'Please enter signature'
								});
								return false;
			  				}
			  				else{
			  					$('.page-loader').show();
								var x = new XMLHttpRequest();
								x.onreadystatechange = function() {
									if (x.readyState == 4 && x.status == 200) {
										var items = x.responseText.trim();
										if(items.split("::")[0]=="0"){
											var attachdesc="Signature of GIP "+docno;
											attachdesc=encodeURIComponent(attachdesc);
											var dataURL=signaturePad.toDataURL();
											//console.log(dataURL);
											var postData = "canvasData="+dataURL;
											$.ajax({ 
                            					type: "POST", 
                            					url: "saveSignature.jsp?formname=GIP&docno="+docno+"&descpt="+attachdesc+"&reftypid=1&imgtype=1", 
                            					data: { 
           											imgBase64: dataURL
        										}
                        					}).done(function(o) { 
                        						attachdesc="Vehicle Inspection of GIP "+docno;
												attachdesc=encodeURIComponent(attachdesc);
												dataURL=vehImagePad.toDataURL();
												postData = "canvasData="+dataURL;
												$.ajax({ 
                            						type: "POST", 
                            						url: "saveSignature.jsp?formname=GIP&docno="+docno+"&descpt="+attachdesc+"&reftypid=1&imgtype=2", 
                            						data: { 
           												imgBase64: dataURL
        											}
                        						}).done(function(o) { 
                        							stepstatus=true;
                            						$('.page-loader').hide();
                            						$(gipform).steps("finish");
                            						return true;
                        						});
                        					}); 
										}
										else{
											alert("Ajax Error");
											return false;
										}
									}
								}
								x.open("GET", "saveData.jsp?remarkarray="+remarkarray+"&docno="+docno+"&gipestdate="+gipestdate+"&gipesttime="+gipesttime+"&remarks="+remarks+"&mode="+currentIndex, true);
								x.send();
			  				}
							
						}
			        },
			        onFinished: function(event, currentIndex) {
			            //location.reload();
			            var url=document.URL;
	     				var reurl=url.split("saveAppLogin");
	     				var docno=$('#docno').val();
	                	//var win= window.open(reurl[0]+"workshopAppGIPPrint.action?docno="+docno+"&formdetailcode=GIP","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	                	//var win= window.open(reurl[0]+"Gateinpassprint?docno="+docno+"&formdetailcode=GIP&printsource=APP","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
						var win= window.open(reurl[0]+"../com/workshop/gateinpassmaster/Gateinpassprint?docno="+docno+"&formdetailcode=GIP&printsource=APP","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
						//win.focus();
	                	//window.location.reload(true);
	                	if(!url.includes("appredirect")){
	                		window.location.href=url+"?appredirect=1";	
	                	}
	                	else{
	                		window.location.href=url;
	                	}
	                	return true;
			        }
			    });
			    var clearhtml='<li aria-hidden="false" aria-disabled="false"><a id="btnclear" role="menuitem">Clear</a></li>';
				$('ul[aria-label=Pagination]').prepend($.parseHTML(clearhtml));
			    $("#btnclear").click(function() { 
			    	$('.current').find('input:text,input:hidden,input:file').val('');
					$('.current').find('input:text,input:hidden,input:file').each(function(){
			    		var data=$(this).data();
			    		var target=$(this);
			    		$.each(data,function(key,value){
			    			$(target).attr('data-'+key,'');
			    		});
			    	});
			    	$('.current').find('select').each(function(){
			    		var target=$(this).attr('id');
			    		$('#'+target).val($('#'+target+' option:first').val()).trigger('change');
			    	});
			    	$('.current').find('input:checkbox').each(function(){
			    		var target=$(this).attr('id');
			    		if($('#'+target).is(':checked')){
			    			$('#'+target).trigger('click');
			    		}
			    	});
			    	signaturePad.clear();
			    	vehImagePad.clear();
			    	
			    	$('#gipestdate').data("DateTimePicker").date(moment());
			    	$('#gipesttime').data("DateTimePicker").date(moment());
			    });
			    function clearData(){
			    	
			    }
			    function funGIPPrint(){
			    	$('#docno').val(1374);
			    	var url=document.URL;
     				var reurl=url.split("saveAppLogin");
     				var docno=$('#docno').val();
                	var win= window.open(reurl[0]+"../com/workshop/gateinpassmaster/Gateinpassprint?docno="+docno+"&formdetailcode=GIP&printsource=APP","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
                	win.focus();
                	
			    }
			    function validatechassisno(){
			    	var sizeinvalid=0;	
			    	$('#chassisno').each(function(){
						var targetsize=0;
						var targetid=$(this).attr('id');
						var targetvalue=$(this).val();
						if(targetid=='chassisno'){
							targetsize=fieldsizedata.chassis;
						}else{
						}
						if(targetsize==17){        
							if(targetvalue.length!=targetsize){   
								$(this).parent().find('span.help-block').remove(); 
								$(this).parent().append($.parseHTML('<span class="help-block">Chassis No must be '+targetsize+' Chars only</span>'));  
								$(this).addClass('error');
								sizeinvalid=1;
								return false;
							}
							else{
								$(this).parent().find('span.help-block').remove();
								$(this).removeClass('error');
							}
						}else{
							if(targetvalue.length>targetsize){
								$(this).parent().find('span.help-block').remove();
								$(this).parent().append($.parseHTML('<span class="help-block">Max '+targetsize+' Chars only</span>'));
								$(this).addClass('error');
								sizeinvalid=1;
								return false;
							}
							else{
								$(this).parent().find('span.help-block').remove();
								$(this).removeClass('error');
							}
						}
					});
					if(sizeinvalid==1){
						return false;
					}
			    }
			    function getRefType(){	
				    var x=new XMLHttpRequest();
				    var items,refname,refcode,refdocno;
				    x.onreadystatechange=function(){
					    if (x.readyState==4 && x.status==200)
					    {  
						    items= x.responseText;
						    items=items.split('####');
						    refname=items[0].split(",");
						    refcode=items[1].split(",");
						    refdocno=items[2].split(",");
						    var optionref = '';
						    var optionscurr = '';
						    console.log(refname)
						    for ( var i = 0; i < refname.length; i++) { 
							    optionref += '<option value="' + refdocno[i] + '">' + refname[i] + '</option>';
						    }
						    $("select#cmbattachtype").html(optionref);
					    }
					    else
					    {
					    }  
				    }
				    x.open("GET","getRefType.jsp",true);
				    x.send(); 
			    }
	</script>
</body>
</html>