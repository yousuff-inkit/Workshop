<%@page import="com.limousine.jobassignment.*" %>
<%ClsJobAssignDAO jobdao=new ClsJobAssignDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String fleetno=request.getParameter("fleetno")==null?"":request.getParameter("fleetno");
String fleetname=request.getParameter("fleetname")==null?"":request.getParameter("fleetname");
String brand=request.getParameter("brand")==null?"":request.getParameter("brand");
String model=request.getParameter("model")==null?"":request.getParameter("model");
String group=request.getParameter("group")==null?"":request.getParameter("group");
String allfleets=request.getParameter("allfleets")==null?"0":request.getParameter("allfleets");
String gridbrandid=request.getParameter("gridbrandid")==null?"":request.getParameter("gridbrandid");
String gridmodelid=request.getParameter("gridmodelid")==null?"":request.getParameter("gridmodelid");
String regno=request.getParameter("regno")==null?"":request.getParameter("regno");
%>
<script type="text/javascript">
var id='<%=id%>';
var fleetdata;
if(id=="1"){
	fleetdata='<%=jobdao.getFleetData(fleetno,fleetname,brand,model,group,allfleets,gridbrandid,gridmodelid,id,regno)%>';
}
$(document).ready(function () { 
	
       
        var source =
           {
           datatype: "json",
           datafields: [

                       	{name : 'fleet_no' , type: 'number' },
                       	{name : 'flname' , type:'string'},
                       	{name : 'brand',type:'string'},
                       	{name : 'model',type:'string'},
                       	{name : 'gname',type:'string'},
			{name:   'reg_no',type:'reg_no'}
     				   ],
					localdata:fleetdata,
                
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

            $("#fleetSearchGrid").jqxGrid(
            {
               width: '100%',
               height: 300,
               source: dataAdapter,
               columnsresize: true,
               //disabled:true,
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
							{ text: 'Fleet No', datafield: 'fleet_no',width:'8%'},
							{text:'Reg No',datafield:'reg_no',width:'8%'},
							{ text: 'Fleet Name',datafield:'flname',width:'34%'},
							{ text: 'Brand',  datafield: 'brand',width:'20%'},
							{ text: 'Model',datafield:'model',width:'20%'},
							{ text: 'Group',datafield:'gname',width:'10%'}
							
         	              ]
           
            });
            
            $("#fleetSearchGrid").on("rowdoubleclick", function (event)
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
            		    
            		    document.getElementById("fleetno").value=$('#fleetSearchGrid').jqxGrid('getcellvalue',rowBoundIndex,'fleet_no');
            		    $('#fleetwindow').jqxWindow('close');
            		});
            });

	
            </script>
            <div id="fleetSearchGrid"></div>
