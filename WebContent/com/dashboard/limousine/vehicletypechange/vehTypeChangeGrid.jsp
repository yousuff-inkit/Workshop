<%@page import="com.dashboard.limousine.vehtypechange.*" %>
<%ClsVehTypeChangeDAO typedao=new ClsVehTypeChangeDAO();
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String uptodate=request.getParameter("uptodate")==null?"":request.getParameter("uptodate");
String regno=request.getParameter("regno")==null?"":request.getParameter("regno");
String brandid=request.getParameter("brandid")==null?"":request.getParameter("brandid");
String modelid=request.getParameter("modelid")==null?"":request.getParameter("modelid");
String groupid=request.getParameter("groupid")==null?"":request.getParameter("groupid");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
%>
<script type="text/javascript">
var id='<%=id%>';
var	typechangedata;
var VehicleTypeChangeexcel;
if(id=="1"){
	typechangedata='<%=typedao.getTypeChangeData(branch,uptodate,regno,brandid,modelid,groupid,id)%>';
        VehicleTypeChangeexcel='<%=typedao.excelTypeChangeData(branch,uptodate,regno,brandid,modelid,groupid,id)%>';
}
$(document).ready(function () {

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                      	{name : 'doc_no' , type: 'string' },
                  		{name : 'date' , type: 'date' },
						{name : 'fleet_no', type: 'String'  },
						{name : 'flname', type: 'String'  },
						{name : 'reg_no', type: 'string'  },
						{name : 'brand', type: 'string'  },
						{name : 'model', type: 'string'  },
						{name : 'gname', type: 'string'  },
						{name : 'engineno',type:'string'},
						{name : 'chaseno',type:'string'},
						{name : 'availbranch',type:'string'},
						{name : 'availlocation',type:'string'}
						
						],
				    localdata: typechangedata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
         
          $('#vehTypeChangeGrid').on('bindingcomplete', function (event) {
        	  $('#overlay,#PleaseWait').hide();
          });
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#vehTypeChangeGrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 25,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       sortable:true,
        columns: [
                  
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
					    groupable: false, draggable: false, resizable: false,
					    datafield: 'sl', columntype: 'number', width: '3%',
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					    }
					  },
                        { text: 'Doc No', datafield: 'doc_no', width: '5%'},  
      					{ text: 'Date', datafield: 'date', width: '7%',cellsformat:'dd.MM.yyyy'},
      					{ text: 'Fleet No',datafield:'fleet_no',width:'7%'},
      					{ text: 'Fleet Name',datafield:'flname',width:'14%'},
      					{ text: 'Reg No',datafield:'reg_no',width:'8%'},
      					{ text: 'Brand',datafield:'brand',width:'8%'},
      					{ text: 'Model',datafield:'model',width:'8%'},
      					{ text: 'Group',datafield:'gname',width:'8%'},
      					{ text: 'Engine No',datafield:'engineno',width:'8%'},
      					{ text: 'Chassis No',datafield:'chaseno',width:'8%'},
      					{ text: 'Avail Branch',datafield:'availbranch',width:'8%'},
      					{ text: 'Avail Location',datafield:'availlocation',width:'8%'}

					]

    });

    $('#vehTypeChangeGrid').on('rowdoubleclick', function (event) 
    		{ 
    		    var args = event.args;
    		    // row's bound index.
    		    var boundIndex = event.args.rowindex;
    		    // row's visible index.
    		    var visibleIndex = event.args.visibleindex;
    		    // right click.
    		    var rightclick = event.args.rightclick; 
    		    // original event.
    		    var ev = event.args.originalEvent;
    		    
    		    document.getElementById("fleetno").value=$('#vehTypeChangeGrid').jqxGrid('getcellvalue',boundIndex,'fleet_no');
    		    
    		});
});

	
	
</script>
<div id="vehTypeChangeGrid"></div>