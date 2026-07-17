<%@page import="com.dashboard.client.clientvehiclemovement.*"%>
<%
ClsClientVehicleMovementDAO movdao=new ClsClientVehicleMovementDAO();
String client = request.getParameter("client")==null?"":request.getParameter("client");
String desc = request.getParameter("desc")==null?"":request.getParameter("desc");
String id = request.getParameter("id")==null?"":request.getParameter("id");
String fromdate = request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate = request.getParameter("todate")==null?"":request.getParameter("todate");
%>
<script type="text/javascript">
var detaildata;
var id='<%=id%>';
if(id=="1"){
	 detaildata='<%=movdao.getDetailData(client,desc,id,fromdate,todate)%>';
}
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 	{name : 'agmtno', type: 'String'  },
					{name : 'client', type: 'String'  },
					{name : 'cldocno', type: 'String'  },
					{name : 'driver', type: 'string' },
					{name : 'fleet_no', type: 'String' },
					{name : 'vehicle',type:'string'},
					{name : 'reg_no',type:'string'},
					{name : 'opendate',type:'date'},
					{name : 'opentime',type:'date'},
					{name : 'openkm',type:'number'},
					{name : 'openfuel',type:'string'},
					{name : 'closedate',type:'date'},
					{name : 'closetime',type:'date'},
					{name : 'closekm',type:'number'},
					{name : 'closefuel',type:'string'},
					{name : 'movdate',type:'date'},
					{name : 'movtime',type:'date'},
					{name : 'movkm',type:'number'},
					{name : 'movfuel',type:'string'},
					{name : 'mobile',type:'string'},
					{name : 'licenseno',type:'string'},
					{name : 'licenseexp',type:'date'},
					{name : 'idno',type:'string'},
					{name : 'clientmovdocno',type:'string'}
						
						],
				    localdata: detaildata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#detailGrid").jqxGrid(
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
					{text: 'Agmt No',datafield:'agmtno',width:'10%',hidden:true},
					{text: 'Client',datafield:'client',width:'16%'},
					{ text: 'Client Id', datafield: 'cldocno', width: '10%',hidden:true},
					{ text: 'Driver', datafield: 'driver', width: '10%' },
					{ text: 'Fleet', datafield: 'fleet_no', width: '7%'},
					{ text : 'Vehicle',datafield:'vehicle',width:'10%'},
					{ text: 'Reg No', datafield: 'reg_no', width: '7%' },
					{ text: 'Open Date', datafield: 'opendate', width: '10%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Open Time', datafield: 'opentime', width: '10%',cellsformat:'HH:mm'  },
					{ text: 'Open Km', datafield: 'openkm', width: '10%' },
					{ text: 'Open Fuel', datafield: 'openfuel', width: '10%' },
					{ text: 'Close Date', datafield: 'closedate', width: '10%' ,cellsformat:'dd.MM.yyyy' },
					{ text: 'Close Time', datafield: 'closetime', width: '10%',cellsformat:'HH:mm'  },
					{ text: 'Close Km', datafield: 'closekm', width: '10%' },
					{ text: 'Close Fuel', datafield: 'closefuel', width: '10%' },
					{ text: 'Mov Date', datafield: 'movdate', width: '10%' ,cellsformat:'dd.MM.yyyy',hidden:true },//Corresponding to gl_vmove
					{ text: 'Mov Time', datafield: 'movtime', width: '10%' ,cellsformat:'HH:mm',hidden:true },
					{ text: 'Mov Km', datafield: 'movkm', width: '10%' ,hidden:true},
					{ text: 'Mov Fuel', datafield: 'movfuel', width: '10%' ,hidden:true},
					{ text: 'Mobile', datafield: 'mobile', width: '10%',hidden:true  },//Corresponding to Client Vehicle Movement
					{ text: 'License No', datafield: 'licenseno', width: '10%',hidden:true},
					{ text: 'License Exp', datafield: 'licenseexp', width: '10%' ,hidden:true,cellsformat:'dd.MM.yyyy'},
					{ text: 'ID No', datafield: 'idno', width: '10%' ,hidden:true},
					{ text: 'Client Mov Docno',datafield:'clientmovdocno',width:'10%',hidden:true}
						
					
					]
    
    });
    $('#detailGrid').on('rowdoubleclick', function (event) 
    		{ 
    			$('#fleetno').val($('#detailGrid').jqxGrid('getcellvalue',event.args.rowindex,'fleet_no'));
    			$('#agmtno').val($('#detailGrid').jqxGrid('getcellvalue',event.args.rowindex,'agmtno'));
    			$('#detailrowindex').val(event.args.rowindex);
    			var desc=$('#desc').val();
    			if(desc=='OUT'){
	    			$('#driver').val($('#detailGrid').jqxGrid('getcellvalue',event.args.rowindex,'driver'));
	    			$('#mobile').val($('#detailGrid').jqxGrid('getcellvalue',event.args.rowindex,'mobile'));
	    			$('#licenseno').val($('#detailGrid').jqxGrid('getcellvalue',event.args.rowindex,'licenseno'));
	    			$('#licenseexpiry').jqxDateTimeInput('val',$('#detailGrid').jqxGrid('getcellvalue',event.args.rowindex,'licenseexp'));
	    			$('#idno').val($('#detailGrid').jqxGrid('getcellvalue',event.args.rowindex,'idno'));
	    			$('#clientmovdocno').val($('#detailGrid').jqxGrid('getcellvalue',event.args.rowindex,'clientmovdocno'));
    			}
    			});
});

</script>
<div id="detailGrid"></div>
<input type="hidden" name="detailrowindex" id="detailrowindex">
<input type="hidden" name="clientmovdocno" id="clientmovdocno">