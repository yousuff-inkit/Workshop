<%@page import="com.dashboard.limousine.jobdetaillist.*" %>
<%
ClsJobDetailListDAO jobdao=new ClsJobDetailListDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
%>
<script type="text/javascript">
var id='<%=id%>';
var jobdata;
if(id=="1"){
	jobdata='<%=jobdao.getJobDetails(id,branch,fromdate,todate)%>';
}
$(document).ready(function () { 
	
       
        var source =
           {
           datatype: "json",
           datafields: [
						{name : 'bookdocno',type:'string'},
                       	{name : 'jobdocno' , type: 'string' },
                       	{name : 'jobname',type:'string'},
                       	{name : 'jobnametemp',type:'string'},
                       	{name : 'refname',type:'string'},
                       	{name : 'guest',type:'string'},
                       	{name : 'driver',type:'string'},
                       	{name : 'type',type:'string'},
                       	{name : 'blockhours',type:'string'},
                       	{name : 'startdate',type:'date'},
                       	{name : 'starttime',type:'string'},
                       	{name : 'startkm',type:'number'},
                       	{name : 'enddate',type:'date'},
                       	{name : 'endtime',type:'string'},
                       	{name : 'endkm',type:'number'},
                       	{name : 'pickuplocation',type:'string'},
                       	{name : 'pickupaddress',type:'string'},
                       	{name : 'dropofflocation',type:'string'},
                       	{name : 'dropoffaddress',type:'string'},
                       	{name : 'brand',type:'string'},
                       	{name : 'model',type:'string'},
                       	{name : 'nos',type:'string'}     		
                       	
                       	],
					localdata:jobdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or pagse size is changed.
                }
          };
        $('#jobDetailListGrid').on('bindingcomplete', function (event) {
      	  $('#overlay,#PleaseWait,#loadingImage').hide();
        });
          var dataAdapter = new $.jqx.dataAdapter(source,
           		 {
               		loadError: function (xhr, status, error) {
	                 ///alert(error);    
	              }
			            
		        });

            $("#jobDetailListGrid").jqxGrid(
            {
               width: '100%',
               height: 500,
               source: dataAdapter,
               columnsresize: true,
               editable:false,
               filterable:true,
               filtermode:'excel',
               selectionmode: 'singlerow',
               
                //Add row method
                 handlekeyboardnavigation: function (event) {
            // var rows = $('#jqxgridtarif').jqxGrid('getrows');
       /*      alert("here");
                  var rowlength= event.args.rowindex;
                  alert(rowlength);
                    var cell = $('#jqxgridtarif').jqxGrid('getselectedcell');
				if (cell != undefined && cell.datafield == 'disclevel3') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {
                            $('#jqxgridtarif').jqxGrid('selectcell',rowlength+1, 'rentaltype');
                   					$('#jqxgridtarif').jqxGrid('focus',rowlength+1, 'rentaltype');
                                       
                        }
				} */
                 },
            
               
                columns: [
            				{ text: 'Book Docno',datafield:'bookdocno',width:'10%',hidden:true},
							{ text: 'Job Docno',datafield:'jobdocno',width:'10%',hidden:true},
							{ text: 'Job Name',datafield:'jobname',width:'10%',hidden:true},
							{ text: 'Job',datafield:'jobnametemp',width:'7%'},
							{ text: 'Client',datafield:'refname',width:'12%'},
							{ text: 'Guest',datafield:'guest',width:'10%'},
							{ text: 'Driver',datafield:'driver',width:'10%'},
							{ text: 'Type',datafield:'type',width:'7%'},
							{ text: 'Block Hrs',datafield:'blockhrs',width:'5%'},
							{ text: 'Start Date',datafield:'startdate',cellsformat:'dd.MM.yyyy',width:'7%'},
							{ text: 'Start Time',datafield: 'starttime',cellsformat:'HH:mm',width:'7%'},
							{ text: 'Start Km',datafield:'startkm',cellsformat:'d',width:'7%'},
							{ text: 'End Date',datafield:'enddate',cellsformat:'dd.MM.yyyy',width:'7%'},
							{ text: 'End Time',datafield: 'endtime',cellsformat:'HH:mm',width:'7%'},
							{ text: 'End Km',datafield:'endkm',cellsformat:'d',width:'7%'},
							{ text: 'Pickup Location',datafield:'pickuplocation',width:'10%'},
							{ text: 'Pickup Address',datafield: 'pickupaddress',width:'10%'},
							{ text: 'Dropoff Location',datafield:'dropofflocation',width:'10%'},
							{ text: 'Dropoff Address',datafield:'dropoffaddress',width:'10%'},
							{ text: 'Brand',datafield:'brand',width:'8%'},
							{ text: 'Model',datafield:'model',width:'8%'},
							{ text: 'Nos',datafield:'nos',width:'4%'}
							
         	              ]
           
            });
            
            });

	
            </script>
            <div id="jobDetailListGrid"></div>