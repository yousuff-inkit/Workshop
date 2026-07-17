<%@page import="com.dashboard.workshop.serviceadvisor.*" %>
<%ClsServiceAdvisorDAO servicedao=new ClsServiceAdvisorDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String processstatus=request.getParameter("processstatus")==null?"":request.getParameter("processstatus");
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
%>
<script type="text/javascript">
 
var id='<%=id%>';
<%-- ='<%=id%>'; --%>
var maintenancedata;
var processstatus='<%=processstatus%>';
if(id=='1'){
  maintenancedata='<%=servicedao.getMaintenanceData(id,processstatus,docno)%>';
 <%-- gateexceldata='<%=gatedao.getGateInPassExcelData(fromdate,todate,id)%>'; --%>
}
else{
	maintenancedata=[];
/* gateexceldata=[]; */
}
 
$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'maintenancedocno',type:'number'},
                  		{name : 'maintenance',type:'string'},
                  		{name : 'description',type:'string'}
				
                  		],
				    localdata: maintenancedata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#maintenanceGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	if(processstatus=="2"){
    		var rows=$('#maintenanceGrid').jqxGrid('getrows');
    		for(var i=0;i<rows.length;i++){
    			$('#maintenanceGrid').jqxGrid('selectrow', i);
    		}
    	}
    });        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#maintenanceGrid").jqxGrid(
    {
        width: '98%',
        height: 220,
        columnsheight:23,
        source: dataAdapter,
        showfilterrow:true,
        filterable: true,
        selectionmode: 'checkbox',
       sortable:false,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '9%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Maintenance',datafield:'maintenance',width:'40%'},
       				{ text: 'Maintenance Docno',datafield:'maintenancedocno',width:'40%',hidden:true},
       				{ text: 'Description',datafield:'description',width:'45%'}

					]
    });
    $('#maintenanceGrid').on('rowdoubleclick', function (event) 
      		{ 
  	  var rowindex1=event.args.rowindex;
      
      		});	 
     
    });

	
	
</script>
<div id="maintenanceGrid"></div>