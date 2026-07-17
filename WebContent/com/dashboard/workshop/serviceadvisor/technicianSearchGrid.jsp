<%@page import="com.dashboard.workshop.serviceadvisor.*" %>
<%ClsServiceAdvisorDAO servicedao=new ClsServiceAdvisorDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
 
var id='<%=id%>';
var techniciandata;
if(id=='1'){
	techniciandata='<%=servicedao.getTechnicianData(id)%>';
 <%-- gateexceldata='<%=gatedao.getGateInPassExcelData(fromdate,todate,id)%>'; --%>
}
else{
	techniciandata=[];
/* gateexceldata=[]; */
}
 
$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'techniciandocno',type:'number'},
                  		{name : 'technicianname',type:'string'},
                  		{name : 'techniciancode',type:'string'}
				
                  		],
				    localdata: techniciandata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#technicianSearchGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#technicianSearchGrid").jqxGrid(
    {
        width: '99%',
        height: 300,
        columnsheight:23,
        source: dataAdapter,
        filtermode:'excel',
        showfilterrow:true,
        filterable: true,
        selectionmode: 'singlerow',
       sortable:false,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '10%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Code',datafield:'techniciancode',width:'20%'},
       				{ text: 'Technician Docno',datafield:'techniciandocno',width:'40%',hidden:true},
       				{ text: 'Technician',datafield:'technicianname',width:'70%'}

					]
    });
    $('#technicianSearchGrid').on('rowdoubleclick', function (event) 
      		{ 
  	  			var rowindex1=event.args.rowindex;
      			$('#technician').val($('#technicianSearchGrid').jqxGrid('getcellvalue',rowindex1,'technicianname'));
      			$('#hidtechnician').val($('#technicianSearchGrid').jqxGrid('getcellvalue',rowindex1,'techniciandocno'));
      			$('#technicianwindow').jqxWindow('close');
      		});	 
     
    });

	
	
</script>
<div id="technicianSearchGrid"></div>