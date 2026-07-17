<%@page import="com.dashboard.workshop.technicianproductivity.ClsTechProductivityDAO"%>
<%
ClsTechProductivityDAO DAO=new ClsTechProductivityDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String techid=request.getParameter("techid")==null?"":request.getParameter("techid");
String jcno=request.getParameter("jcno")==null?"":request.getParameter("jcno");
String clientid=request.getParameter("clientid")==null?"":request.getParameter("clientid");
String clcatid=request.getParameter("clcatid")==null?"":request.getParameter("clcatid");

%>

<script type="text/javascript">
 
var id='<%=id%>';
var data1;


if(id=='1'){
	data1='<%=DAO.getDetailData(fromdate,todate,techid,jcno,clientid,clcatid,id)%>';

}
else{
	data1=[];
}
 
$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
						{name : 'docno',type:'number'},
                  		{name : 'technician',type:'string'},
                  		{name : 'jobcard',type:'string'},
                  		{name : 'service_type',type:'string'},
                  		{name : 'description',type:'string'},
                  		{name : 'hours',type:'string'},
                  		{name : 'totalhours',type:'number'},
                  		{name : 'total',type:'number'},
                  		{name : 'invoiced_value',type:'number'},
                  		
                  		],
				    localdata: data1,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#detailGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#detailGrid").jqxGrid(
    {
        width: '98%',
        height: 520,
        columnsheight:23,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        showaggregates:true,
        showstatusbar:true,
       sortable:false,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Technician',datafield:'technician',width:'18%'},
       				{ text: 'Job Card',datafield:'jobcard',width:'6%'},
       				{ text: 'Service Type',datafield:'service_type',width:'18%'},
       				{ text: 'Description',datafield:'description',width:'25%'}, 
       				{ text: 'Hours',datafield:'hours',width:'8%',cellsformat:'d2',aggregates: ['sum']},
       				{ text: 'Total',datafield:'total',width:'10%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
       				{ text: 'Invoiced Value',datafield:'invoiced_value',width:'10%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum']},
					]
    });
    $('#detailGrid').on('rowdoubleclick', function (event) 
      		{ 
      		});	 
    });

	
	
</script>
<div id="detailGrid"></div>