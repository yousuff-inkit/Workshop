<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Technician Utlization</title>
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
	<div class="load-wrapp page-loader">
    	<div class="load-9">
        	<div class="spinner">
            	<div class="bubble-1"></div>
                <div class="bubble-2"></div>
            </div>
        </div>
    </div>
    <div class="container-fluid">
    	<div style="display:flex;flex-direction:row;">
    		<div class="primarypanel custompanel">
  				<button type="button" class="btn btn-default" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
          		<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
        		<button type="button" class="btn btn-default hidden" id="btninfo" data-toggle="tooltip" title="Info" data-placement="bottom"><i class="fa fa-info-circle " aria-hidden="true"></i></button>
        		<select name="cmbbranch" id="cmbbranch" style="min-width:125px;display:inline-block;" class="hidden"><option value="">--Select--</option></select>
        	</div>
        	<div class="actionpanel custompanel">
        		<div id="basedate" style="margin-top:8px;"></div>
        	</div>
    	</div>
    	<div class="row">
    		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
    			<div id="techutilgriddiv" style="margin-top:5px;"><jsp:include page="techUtilGrid.jsp"></jsp:include></div>
    		</div>
    	</div>
    </div>
    <script src="../../../../js/sweetalert2.all.min.js"></script>
	<script src="../../../../vendors/select2/js/select2.min.js"></script>
    <script type="text/javascript">

    	$(document).ready(function(){
    		
    		$("#basedate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"MMM-yyyy"});
    		$('.page-loader').hide();
    		
    		
    		//$('#cmbbranch').select2();
    		
    		$('#basedate').on('change', function (event){
				var jsDate = event.args.date; 
    			var type = event.args.type; // keyboard, mouse or null depending on how the date was selected.
    		});
    		
    		$('#btnsubmit').click(function(){
    			var basedate=$('#basedate').jqxDateTimeInput('getDate');
    			var month=new Date(basedate).getMonth()+1;
    			var year=new Date(basedate).getFullYear();
    			$('#techutilgriddiv').load('techUtilGrid.jsp?mode=1&month='+month+'&year='+year);
    		});
    	});
    	
		$('#btnexcel').click(function(){
			$("#techUtilGrid").excelexportjs({
				containerid: "techUtilGrid",
				datatype: 'json',
				dataset: null,
				gridId: "techUtilGrid",
				columns: getColumns("techUtilGrid"),
				worksheetName: "Man Power Utlisation"
			});
		});
    </script>
</body>
</html>