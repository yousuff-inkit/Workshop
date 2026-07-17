<%@page import="com.dashboard.limousine.jobclose.*" %>
<%ClsLimoJobCloseDAO closedao=new ClsLimoJobCloseDAO();
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String status=request.getParameter("status")==null?"":request.getParameter("status");
String bookdocno=request.getParameter("bookdocno")==null?"":request.getParameter("bookdocno");

String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var id='<%=id%>';
var jobdata;
var Jobcloseexcel;
if(id=="1"){
	jobdata='<%=closedao.getJobData(fromdate, todate, bookdocno, branch, id)%>';
        Jobcloseexcel='<%=closedao.exceljobcloseData(fromdate, todate, bookdocno, branch, id)%>';
}
$(document).ready(function () { 
        var source =
           {
           datatype: "json",
           datafields: [

                       	{name : 'doc_no' , type: 'int' },
                       	{name : 'bookdocno',type:'int'},
                       	{name : 'detaildocno',type:'int'},
                       	{name : 'tarifdocno',type:'int'},
                       	{name : 'tarifdetaildocno',type:'int'},
                       	{name : 'docname',type:'string'},
                       	{name : 'refname' , type:'string'},
                       	{name : 'cldocno',type:'string'},
                       	{name : 'guestno',type:'string'},
                       	{name : 'guest',type:'string'},
                       	{name : 'type',type:'string'},
                       	{name : 'blockhrs',type:'number'},
                       	{name : 'pickupdate',type:'date'},
                       	{name : 'pickuptime',type:'date'},
                       	{name : 'pickuplocation',type:'string'},
                       	{name : 'dropofflocation',type:'string'},
                       	{name : 'brand',type:'string'},
                       	{name : 'model',type:'string'},
                       	{name : 'nos',type:'string'},
                       	{name : 'brandid',type:'string'},
                       	{name : 'modelid',type:'string'},
                       	{name : 'status',type:'string'},
                       	{name : 'greetrate',type:'number'},
                       	{name : 'viprate',type:'number'},
                       	{name : 'boquerate',type:'number'},
                       	{name : 'fleet_no',type:'number'},
                       	{name : 'reg_no',type:'number'},
                       	{name : 'flname',type:'string'}
     				   ],
					localdata:jobdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or pagse size is changed.
                }
          };

          var dataAdapter = new $.jqx.dataAdapter(source,
           		 {
               		loadError: function (xhr, status, error) {
	                 ///alert(error);    
	              }
			            
		        });

            $("#jobGrid").jqxGrid(
            {
               width: '99%',
               height: 150,
               source: dataAdapter,
               columnsresize: true,
               editable:false,
               selectionmode: 'checkbox',
               
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
                       
							{ text: 'Status',datafield:'status',width:'8%'},
							{ text: 'Doc No', datafield: 'doc_no',width:'4%',hidden:true},
							{ text: 'Detail Docno',datafield:'detaildocno',width:'4%',hidden:true},
							{ text: 'Booking Docno',datafield: 'bookdocno',width:'4%',hidden:true},
							{ text: 'Job Name',datafield:'docname',width:'6.2%',hidden:true},
							{ text: 'Job Name',datafield:'jobnametemp',width:'6.2%',cellsrenderer: function (row, columnfield, value, defaulthtml, columnproperties) {
								var bookdocno=$('#jobGrid').jqxGrid('getcellvalue',row,'bookdocno');
								var jobname=$('#jobGrid').jqxGrid('getcellvalue',row,'docname');
					        	return "<div style='overflow:hidden;text-overflow:ellipsis;padding-bottom:2px;text-align:left;margin-right:2px;margin-left:4px;margin-top:4px;'>" + (bookdocno+" - "+jobname) + "</div>";
					    	}},
							{ text: 'Client ID',datafield:'cldocno',width:'4%',hidden:true},
							{ text: 'Guest ID',datafield:'guestno',width:'4%',hidden:true},
							{ text: 'Client',  datafield: 'refname',width:'12%'},
							{ text: 'Guest',datafield:'guest',width:'10%'},
							{ text: 'Type',datafield:'type',width:'5%'},
							{ text: 'Block Hrs',datafield:'blockhrs',width:'4.5%'},
							{ text: 'Pickup date',datafield:'pickupdate',width:'6%',cellsformat:'dd.MM.yyyy'},
							{ text: 'Pickup time',datafield:'pickuptime',width:'5.5%',cellsformat:'HH:mm'},
							{ text: 'Pickup Location',datafield:'pickuplocation',width:'10%'},
							{ text: 'Dropoff Location',datafield:'dropofflocation',width:'10%'},
							{ text: 'Fleet No',datafield:'fleet_no',width:'8%'},
							{ text: 'Reg No',datafield:'reg_no',width:'8%'},
							{ text: 'Fleet Name',datafield:'flname',width:'12%'},
							{ text: 'Brand',datafield:'brand',width:'8%'},
							{ text: 'Model',datafield:'model',width:'8%'},
							{ text: 'Nos',datafield:'nos',width:'4%'},
							{ text: 'Brandid',datafield:'brandid',width:'4%',hidden:true},
							{ text: 'Modelid',datafield:'modelid',width:'4%',hidden:true},
							{ text: 'Tarifdocno',datafield:'tarifdocno',width:'4%',hidden:true},
							{ text: 'Tarifdetaildocno',datafield:'tarifdetaildocno',width:'4%',hidden:true},
							{ text: 'Greet & Meet Amt',datafield:'greetrate',hidden:true,cellsformat:'d2'},
							{ text: 'VIP Amt',datafield:'viprate',hidden:true,cellsformat:'d2'},
							{ text: 'Boque Amt',datafield:'boquerate',hidden:true,cellsformat:'d2'}
         	              ]
           
            });
            
            $('#jobGrid').on('rowselect', function (event) 
            		{
  		    // event arguments.
  		    var args = event.args;
  		    // row's bound index.
  		    var rowBoundIndex = event.args.rowindex;
  		    // row's data. The row's data object or null(when all rows are being selected or unselected with a single action). If you have a datafield called "firstName", to access the row's firstName, use var firstName = rowData.firstName;
  		    var rowData = event.args.row;
  		    
  		    var status=rowData.status;
  		    
  		    if(status=="Assigned"){
  		    	$('#calculationGrid').jqxGrid('addrow',null,{});
  		    	var calcindex=($('#calculationGrid').jqxGrid('getrows').length)-1;
  		    	$('#calculationGrid').jqxGrid('setcellvalue',calcindex,'jobname',rowData.docname);
  		    	$('#calculationGrid').jqxGrid('setcellvalue',calcindex,'bookdocno',rowData.bookdocno);
  		    	$('#calculationGrid').jqxGrid('setcellvalue',calcindex,'jobdocno',rowData.detaildocno);
  		    	$('#calculationGrid').jqxGrid('setcellvalue',calcindex,'tarifdocno',rowData.tarifdocno);
  		    	$('#calculationGrid').jqxGrid('setcellvalue',calcindex,'tarifdetaildocno',rowData.tarifdetaildocno);
  		    	$('#calculationGrid').jqxGrid('setcellvalue',calcindex,'startdate',rowData.pickupdate);
  		    	$('#calculationGrid').jqxGrid('setcellvalue',calcindex,'starttime',rowData.pickuptime);
  		    	var greetrate=rowData.greetrate;
  		    	var viprate=rowData.viprate;
  		    	var boquerate=rowData.boquerate;
  		    	if(greetrate!=null && greetrate!="undefined" && typeof(greetrate)!="undefined" && greetrate!=""){
  		    		$('#calculationGrid').jqxGrid('setcellvalue',calcindex,'greetchg',greetrate);
  		    	}
  		    	if(viprate!=null && viprate!="undefined" && typeof(viprate)!="undefined" && viprate!=""){
  		    		$('#calculationGrid').jqxGrid('setcellvalue',calcindex,'vipchg',viprate);
  		    	}
  		    	if(boquerate!=null && boquerate!="undefined" && typeof(boquerate)!="undefined" && boquerate!=""){
  		    		$('#calculationGrid').jqxGrid('setcellvalue',calcindex,'boquechg',boquerate);
  		    	}
  		    }
  		    else{
  		    	$.messager.alert('warning','Job not assigned');
  		    	return false;
  		    	//$('#jobGrid').jqxGrid('unselectrow', rowBoundIndex);
  		    }
            });
            $('#jobGrid').on('rowunselect', function (event) 
            		{
  		    // event arguments.
  		    var args = event.args;
  		    // row's bound index.
  		    var rowBoundIndex = event.args.rowindex;
  		    // row's data. The row's data object or null(when all rows are being selected or unselected with a single action). If you have a datafield called "firstName", to access the row's firstName, use var firstName = rowData.firstName;
  		    var rowData = event.args.row;
  		    var calcrows=$('#calculationGrid').jqxGrid('getrows');
  		    for(var i=0;i<calcrows.length;i++){
  		    	if($('#calculationGrid').jqxGrid('getcellvalue',i,'jobdocno')==rowData.detaildocno){
  			    	var id = $("#calculationGrid").jqxGrid('getrowid', i);
			        var commit = $("#calculationGrid").jqxGrid('deleterow', id);
  		    	}
  		    }
  		    
            });
            });

	
            </script>
            <div id="jobGrid"></div>
            
            
  
