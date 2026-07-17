<%@page import="com.dashboard.limousine.assignlist.*" %>
<%ClsLimoAssignListDAO assigndao=new ClsLimoAssignListDAO();
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String type=request.getParameter("type")==null?"":request.getParameter("type");
String driver=request.getParameter("driver")==null?"":request.getParameter("driver");
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var id='<%=id%>';
var assigndata;
if(id=="1"){
	assigndata='<%=assigndao.getAssignListData(fromdate, todate, type, driver, branch, id)%>';
}
$(document).ready(function () { 
        var source =
           {
           datatype: "json",
           datafields: [

                       	{name : 'bookdocno',type:'string'},
                       	{name : 'docname',type:'string'},
                       	{name : 'refname' , type:'string'},
                       	{name : 'guest',type:'string'},
                       	{name : 'type',type:'string'},
                       	{name : 'blockhrs',type:'number'},
                       	{name : 'pickupdate',type:'date'},
                       	{name : 'pickuptime',type:'date'},
                       	{name : 'pickuplocation',type:'string'},
                       	{name : 'pickupaddress',type:'string'},
                       	{name : 'dropofflocation',type:'string'},
                       	{name : 'dropoffaddress',type:'string'},
                       	{name : 'fleet',type:'string'},
                       	{name : 'reg_no',type:'number'},
                       	{name : 'driver',type:'string'}
     				   ],
					localdata:assigndata,
                
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

            $("#assignListGrid").jqxGrid(
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
							{ text: 'Job Name',datafield:'docname',width:'4.5%',
								cellsrenderer: function (row, columnfield, value, defaulthtml, columnproperties) {
									var bookdocno=$('#assignListGrid').jqxGrid('getcellvalue',row,'bookdocno');
						        	return "<div style='overflow:hidden;text-overflow:ellipsis;padding-bottom:2px;text-align:left;margin-right:2px;margin-left:4px;margin-top:4px;'>" + (bookdocno+" - "+value) + "</div>";
						    	}
							},
							{ text: 'Driver',datafield:'driver',width:'10%'},
							{ text: 'Fleet',datafield:'fleet',width:'16%'},
							{ text: 'Reg No',datafield:'reg_no',width:'6%'},
							{ text: 'Book Docno',datafield: 'bookdocno',width:'5%',hidden:true},
							{ text: 'Client',  datafield: 'refname',width:'12%'},
							{ text: 'Guest',datafield:'guest',width:'10%'},
							{ text: 'Type',datafield:'type',width:'5%'},
							{ text: 'Block Hrs',datafield:'blockhrs',width:'4.5%'},
							{ text: 'Pickup date',datafield:'pickupdate',width:'6%',cellsformat:'dd.MM.yyyy'},
							{ text: 'Pickup time',datafield:'pickuptime',width:'5.5%',cellsformat:'HH:mm'},
							{ text: 'Pickup Location',datafield:'pickuplocation',width:'10%'},
							{ text: 'Pickup Address',datafield: 'pickupaddress',width:'10%'},
							{ text: 'Dropoff Location',datafield:'dropofflocation',width:'10%'},
							{ text: 'Dropoff Address',datafield:'dropoffaddress',width:'10%'},

							
         	              ]
           
            });
            
            $("#assignListGrid").on("celldoubleclick", function (event)
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

function funExportBtn(){
	var assignexceldata;
	if(parseInt(window.parent.chkexportdata.value)=="1")
 	{
		assignexceldata='<%=assigndao.getAssignListExcelData(fromdate, todate, type, driver, branch, "1")%>';
 		JSONToCSVCon(assignexceldata, 'Assignment List', true);
 	}
	else
 	{
		$("#assignListGrid").jqxGrid('exportdata', 'xls', 'Assignment List');
 	}
}
            </script>
            <div id="assignListGrid"></div>
