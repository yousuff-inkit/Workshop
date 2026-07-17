<%@page import="com.dashboard.client.clientvehiclemovementlist.*"%>
<%
ClsClientVehicleMovementListDAO listdao=new ClsClientVehicleMovementListDAO();
String fleetno = request.getParameter("fleetno")==null?"":request.getParameter("fleetno");
String id = request.getParameter("id")==null?"":request.getParameter("id");
String fromdate = request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate = request.getParameter("todate")==null?"":request.getParameter("todate");
String branch = request.getParameter("branch")==null?"":request.getParameter("branch");
String check = request.getParameter("check")==null?"":request.getParameter("check");
%>
<script type="text/javascript">
var detaildata;
var id='<%=id%>';
if(id=="1"){
	 detaildata='<%=listdao.getClientVehicleData(fleetno,fromdate,todate,branch,id,check)%>';
}
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 	{name : 'fleet_no', type: 'String'  },
					{name : 'reg_no', type: 'String'  },
					{name : 'agmtno', type: 'String'  },
					{name : 'driver', type: 'string' },
					{name : 'refname', type: 'String' },
					{name : 'opendate',type:'date'},
					{name : 'opentime',type:'date'},
					{name : 'openkm',type:'number'},
					{name : 'openfuel',type:'string'},
					{name : 'closedate',type:'date'},
					{name : 'closetime',type:'date'},
					{name : 'closekm',type:'number'},
					{name : 'closefuel',type:'string'},
					{name : 'daydiff',type:'number'},
					{name : 'kmdiff',type:'number'},
					{name : 'fueldiff',type:'string'}
						],
				    localdata: detaildata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    $("#clientVehicleGrid").on("bindingcomplete", function (event) {$('#overlay,#PleaseWait').hide();});  
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#clientVehicleGrid").jqxGrid(
    {
    	width: '99%',
        height: 520,
        source: dataAdapter,
       // rowsheight:20,
       // showaggregates:true,
       filtermode:'excel',
       // filterable: true,
       columnsresize:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [
					{ text: 'Sr. No.',datafield: '',columntype:'number', width: '5%', cellsrenderer: function (row, column, value) {
					    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					}   },	
					{text: 'Agmt No',datafield:'agmtno',width:'7%'},
					{text: 'Client',datafield:'refname',width:'16%'},
					{ text: 'Driver', datafield: 'driver', width: '10%' },
					{ text: 'Fleet', datafield: 'fleet_no', width: '5.5%'},
					{ text: 'Reg No', datafield: 'reg_no', width: '5.5%' },
					{ text: 'Open Date', datafield: 'opendate', width: '5.5%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Open Time', datafield: 'opentime', width: '5.5%',cellsformat:'HH:mm'  },
					{ text: 'Open Km', datafield: 'openkm', width: '5.5%' },
					{ text: 'Open Fuel', datafield: 'openfuel', width: '5.5%' },
					{ text: 'Close Date', datafield: 'closedate', width: '5.5%' ,cellsformat:'dd.MM.yyyy' },
					{ text: 'Close Time', datafield: 'closetime', width: '5.5%',cellsformat:'HH:mm'  },
					{ text: 'Close Km', datafield: 'closekm', width: '5.5%' },
					{ text: 'Close Fuel', datafield: 'closefuel', width: '5.5%' },
					{ text: 'Used Days', datafield: 'daydiff', width: '5.5%' ,cellsformat:'d1' },
					{ text: 'Used Km', datafield: 'kmdiff', width: '5.5%' ,cellsformat:'d0'},
					{ text: 'Used Fuel', datafield: 'fueldiff', width: '5.5%'}

					]
    
    });
    $('#clientVehicleGrid').on('rowdoubleclick', function (event) 
    		{ 
    			
    		});
});

</script>
<div id="clientVehicleGrid"></div>