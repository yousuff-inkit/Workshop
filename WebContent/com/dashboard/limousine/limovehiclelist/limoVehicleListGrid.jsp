<%@page import="com.dashboard.limousine.limovehiclelist.*" %>
<%ClsLimoVehicleListDAO listdao=new ClsLimoVehicleListDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String regno=request.getParameter("regno")==null?"":request.getParameter("regno");
String brandid=request.getParameter("brandid")==null?"":request.getParameter("brandid");
String modelid=request.getParameter("modelid")==null?"":request.getParameter("modelid");
String groupid=request.getParameter("groupid")==null?"":request.getParameter("groupid");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
%>
<script type="text/javascript">
var id='<%=id%>';
var	vehdata;
var Vehiclelistexcel;
if(id=="1"){
	vehdata='<%=listdao.getVehicleData(regno,brandid,modelid,groupid,branch,id)%>';
        Vehiclelistexcel='<%=listdao.excelVehicleData(regno,brandid,modelid,groupid,branch,id)%>'; 
}
$(document).ready(function () {

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
						{name : 'doc_no', type: 'String'  },
 						{name : 'authority', type: 'string'  },
 						{name : 'platecode',type:'string'},
 						{name : 'gname',type:'string'},
 						{name : 'reg_no', type: 'String'  }, 
 						{name : 'fleet_no', type: 'String'  },
 						{name : 'flname', type: 'String'  },
 						{name : 'brand',type:'string'},
 						{name : 'model',type:'string'},
 						{name : 'color',type:'string'},
 						{name : 'yom',type:'string'},
						{name : 'engine', type: 'String'},
						{name : 'chassis', type: 'String'  },
						{name : 'saliktag',type:'string'},
						{name : 'tcno',type:'string'}
											
						],
				    localdata: vehdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
         
          $('#limoVehicleListGrid').on('bindingcomplete', function (event) {
        	  $('#overlay,#PleaseWait,#loadingImage').hide();
          });
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#limoVehicleListGrid").jqxGrid(
    {
        width: '100%',
        height: 500,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        columns: [
                  
					 { text: 'SL#', sortable: false, filterable: false, editable: false,
					    groupable: false, draggable: false, resizable: false,
					    datafield: 'sl', columntype: 'number', width: '5%',
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					    }
					  },
					  { text: 'Fleet No', datafield:'fleet_no',width:'7%'},
					  { text: 'Reg No', datafield:'reg_no',width:'6%'},
					  { text: 'Authority', datafield:'authority',width:'10%'},
					  { text: 'Plate Code', datafield:'platecode',width:'6%'},
					  { text: 'Fleet Name', datafield:'flname',width:'15%'},
					  { text: 'Tarif Group', datafield:'gname',width:'7%'},
					  { text: 'Brand', datafield:'brand',width:'10%'},
					  { text: 'Model', datafield:'model',width:'10%'},
					  { text: 'Color', datafield:'color',width:'10%'},
					  { text: 'YOM', datafield:'yom',width:'4%'},
					  { text: 'Engine No', datafield:'engine',width:'10%'},
					  { text: 'Chassis No', datafield:'chassis',width:'10%'},
					  { text: 'Salik Tag', datafield:'saliktag',width:'7%'},
					  { text: 'Traffic Tcno', datafield:'tcno',width:'7%'},
                      { text: 'Doc No', datafield: 'doc_no', width: '10%',hidden:true}

					]

    });

});

	
	
</script>
<div id="limoVehicleListGrid"></div>