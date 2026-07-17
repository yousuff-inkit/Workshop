<%@page import="com.dashboard.integration.gps.*" %>
<% ClsGPSDAO gpsdao=new ClsGPSDAO(); 
String id=request.getParameter("id")==null?"":request.getParameter("id");
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
%>
<script type="text/javascript">
var id='<%=id%>';
var gpsdata;
if(id=="1"){
	gpsdata='<%=gpsdao.getDownloadData(docno,id,fromdate,todate)%>'; 
	//alert(gpsdata);
	<%-- gpsexceldata='<%=defleetdao.getDeFleetExcelData(id,fromdate,todate,branch)%>'; --%>
}
$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
           
						{name : 'gpsdatetime', type: 'date'},
						{name : 'fleet_no',type:'number'},
						{name : 'reg_no', type: 'number'},
						{name : 'flname',type:'string'},
						{name : 'calibrationkm', type: 'number'},
						{name : 'gpskm',type:'number'},
						{name : 'totalkm',type:'number'},
						{name : 'plateinfo',type:'string'}

						],
				    localdata: gpsdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };

    $("#gpsGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
//    	$('#rentalInvoiceGrid').jqxGrid({ sortable: true});
   });
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );

    $("#gpsGrid").jqxGrid(
    {
        width: '99%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       sortable:true,
        columns: [  
					 { text: 'Sr. No.',datafield: '',columntype:'number', width: '6%', cellsrenderer: function (row, column, value) {
					    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					 }   },	
                  	 { text: 'Fleet No', datafield: 'fleet_no', width: '8%'},
				     { text: 'Reg No', datafield:'reg_no', width: '8%'},
				     { text: 'Fleet Name',datafield:'flname',width:'32%'},
				     { text: 'Date Time',datafield:'gpsdatetime',width:'12%',cellsformat:'dd.MM.yyyy HH:mm'},
				     { text: 'Plate Info',datafield:'plateinfo',width:'10%'},
				     { text: 'Calibration Km',datafield:'calibrationkm',width:'8%',cellsformat:'d2',cellsalign:'right',align:'right'},
				     { text: 'Tracker Km',datafield:'gpskm',width:'8%',cellsformat:'d2',cellsalign:'right',align:'right'},
				     { text: 'Total Km',datafield:'totalkm',width:'8%',cellsformat:'d2',cellsalign:'right',align:'right'}
					]
   
    });

    $('#gpsGrid').on('rowdoubleclick', function (event){
    	var rowindex=event.args.rowindex;
    	
    }); 
});
    
</script>
<div id="gpsGrid"></div>
