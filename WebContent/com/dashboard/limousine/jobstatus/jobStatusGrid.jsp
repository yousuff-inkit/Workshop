<%@page import="com.dashboard.limousine.jobstatus.*" %>
<%ClsLimoJobStatusDAO statusdao=new ClsLimoJobStatusDAO();
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String status=request.getParameter("status")==null?"":request.getParameter("status");
String id=request.getParameter("id")==null?"":request.getParameter("id");
String booktype=request.getParameter("booktype")==null?"":request.getParameter("booktype");
%>
<script type="text/javascript">
var id='<%=id%>';
var statusdata;
var Jobstatusexcel;
var booktype='<%=booktype%>';
if(id=="1"){
	statusdata='<%=statusdao.getStatusData(fromdate,todate,branch,status,id,booktype)%>';
        Jobstatusexcel='<%=statusdao.exceljobststusData(fromdate,todate,branch,status,id,booktype)%>';
}
$(document).ready(function () { 
        var source =
           {
           datatype: "json",
           datafields: [

                       	{name : 'doc_no' , type: 'int' },
                       	{name : 'bookdocno',type:'int'},
                       	{name : 'detaildocno',type:'int'},
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
                       	{name : 'pickupaddress',type:'string'},
                       	{name : 'dropofflocation',type:'string'},
                       	{name : 'dropoffaddress',type:'string'},
                       	{name : 'brand',type:'string'},
                       	{name : 'model',type:'string'},
                       	{name : 'nos',type:'string'},
                       	{name : 'brandid',type:'string'},
                       	{name : 'modelid',type:'string'},
                       	{name : 'status',type:'string'}
     				   ],
					localdata:statusdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or pagse size is changed.
                }
          };

        $("#jobStatusGrid").on("bindingcomplete", function (event) {
        	// your code here.
        if(booktype=="1"){
        	$('#jobStatusGrid').jqxGrid('setcolumnproperty', 'dropofflocation', 'hidden', false);
        	$('#jobStatusGrid').jqxGrid('setcolumnproperty', 'dropoffaddress', 'hidden', false);
        	$('#jobStatusGrid').jqxGrid('setcolumnproperty', 'blockhrs', 'hidden', true);
        	$('#jobStatusGrid').jqxGrid('setcolumnproperty', 'pickupaddress', 'width', '10%');
        }
        else if(booktype="2"){
        	$('#jobStatusGrid').jqxGrid('setcolumnproperty', 'dropofflocation', 'hidden', true);
        	$('#jobStatusGrid').jqxGrid('setcolumnproperty', 'dropoffaddress', 'hidden', true);
        	$('#jobStatusGrid').jqxGrid('setcolumnproperty', 'blockhrs', 'hidden', false);
        	$('#jobStatusGrid').jqxGrid('setcolumnproperty', 'pickupaddress', 'width', '14.5%');
        }
        });
          var dataAdapter = new $.jqx.dataAdapter(source,
           		 {
               		loadError: function (xhr, status, error) {
	                 ///alert(error);    
	              }
			            
		        });

            $("#jobStatusGrid").jqxGrid(
            {
               width: '99%',
               height: 520,
               source: dataAdapter,
               columnsresize: true,
               editable:false,
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
							{ text: 'SL#', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '3%',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							},
							{ text: 'Status',datafield:'status',width:'10%'},
							{ text: 'Doc No', datafield: 'doc_no',width:'4%',hidden:true},
							{ text: 'Detail Docno',datafield:'detaildocno',width:'4%',hidden:true},
							{ text: 'Book Docno',datafield: 'bookdocno',width:'5%',hidden:true},
							{ text: 'Job Name',datafield:'docname',width:'4.5%',
								cellsrenderer: function (row, columnfield, value, defaulthtml, columnproperties) {
									var bookdocno=$('#jobStatusGrid').jqxGrid('getcellvalue',row,'bookdocno');
						        	return "<div style='overflow:hidden;text-overflow:ellipsis;padding-bottom:2px;text-align:left;margin-right:2px;margin-left:4px;margin-top:4px;'>" + (bookdocno+" - "+value) + "</div>";
						    	}
							},
							{ text: 'Client ID',datafield:'cldocno',width:'4%',hidden:true},
							{ text: 'Guest ID',datafield:'guestno',width:'4%',hidden:true},
							{ text: 'Client',  datafield: 'refname',width:'12%'},
							{ text: 'Guest',datafield:'guest',width:'10%'},
							{ text: 'Type',datafield:'type',width:'5%',hidden:true},
							{ text: 'Block Hrs',datafield:'blockhrs',width:'4.5%'},
							{ text: 'Pickup date',datafield:'pickupdate',width:'6%',cellsformat:'dd.MM.yyyy'},
							{ text: 'Pickup time',datafield:'pickuptime',width:'5.5%',cellsformat:'HH:mm'},
							{ text: 'Pickup Location',datafield:'pickuplocation',width:'10%'},
							{ text: 'Pickup Address',datafield: 'pickupaddress',width:'10%'},
							{ text: 'Dropoff Location',datafield:'dropofflocation',width:'10%',hidden:true},
							{ text: 'Dropoff Address',datafield:'dropoffaddress',width:'10%',hidden:true},
							{ text: 'Brand',datafield:'brand',width:'8%'},
							{ text: 'Model',datafield:'model',width:'8%'},
							{ text: 'Nos',datafield:'nos',width:'4%'},
							{ text: 'Brandid',datafield:'brandid',width:'4%',hidden:true},
							{ text: 'Modelid',datafield:'modelid',width:'4%',hidden:true}
							
         	              ]
           
            });
            
            $("#jobStatusGrid").on("celldoubleclick", function (event)
            		{
            		    // event arguments.
            		    var args = event.args;
            		    // row's bound index.
            		    var rowBoundIndex = event.args.rowindex;
            		    // row's visible index.
            		    var rowVisibleIndex = event.args.visibleindex;
            		    // right click.
            		    var rightClick = event.args.rightclick; 
            		    // original event.
            		    var ev = event.args.originalEvent;
            		    // column index.
            		    var columnIndex = event.args.columnindex;
            		    // column data field.
            		    var dataField = event.args.datafield;
            		    // cell value
            		    var value = event.args.value;
            		});
            });

	
            </script>
            <div id="jobStatusGrid"></div>
