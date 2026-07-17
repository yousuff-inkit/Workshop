<%@page import="com.dashboard.vehicle.vehiclestatussummary.*" %>
<% ClsVehStatusSummaryDAO summarydao=new ClsVehStatusSummaryDAO();%>
<%
	String id = request.getParameter("id")==null?"":request.getParameter("id").trim();
	String branch = request.getParameter("branch")==null?"":request.getParameter("branch").trim();
	String description = request.getParameter("description")==null?"":request.getParameter("description").trim();
	String fromdate = request.getParameter("fromdate")==null?"":request.getParameter("fromdate").trim();
	String todate = request.getParameter("todate")==null?"":request.getParameter("todate").trim();
%> 

<script type="text/javascript">
var id='<%=id%>';
var detaildata;
if(id=="1"){
	detaildata='<%=summarydao.getDetailData(description,branch,fromdate,todate,id)%>'; 
}
else{
	detaildata=[];
}
$(document).ready(function () {
	
        
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 	{name : 'doc_no', type: 'number'  },
					{name : 'voc_no', type: 'number'  },
					{name : 'name', type: 'string'  },
					{name : 'fleet_no',type:'number'},
					{name : 'flname',type:'string'},
					{name : 'branchout',type:'string'},
					{name : 'dateout',type:'date'},
					{name : 'timeout',type:'string'},
					{name : 'kmout',type:'number'},
					{name : 'fuelout',type:'string'},
					{name : 'branchin',type:'string'},
					{name : 'datein',type:'date'},
					{name : 'timein',type:'string'},
					{name : 'kmin',type:'number'},
					{name : 'fuelin',type:'string'}
						
						],
				    localdata: detaildata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    $("#detailsGrid").on("bindingcomplete", function (event) {
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
    
    
    $("#detailsGrid").jqxGrid(
    {
        width: '100%',
        height: 205,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [
						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '4%', cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },	
						{ text: 'Doc No Original', datafield: 'doc_no', width: '10%',hidden:true},
						{ text: 'Doc No', datafield: 'voc_no', width: '6%'},
						{ text: 'Name',datafield:'name',width:'15%'},
						{ text: 'Fleet No',datafield:'fleet_no',width:'6%'},
						{ text: 'Fleet Name',datafield:'flname',width:'12%',hidden:true},
						{ text: 'Branch Out',datafield:'branchout',width:'10%'},
						{ text: 'Date Out',datafield:'dateout',width:'7%',cellsformat:'dd.MM.yyyy'},
						{ text: 'Time Out',datafield:'timeout',width:'6%',cellsformat:'HH:mm'},
						{ text: 'Km Out',datafield:'kmout',width:'6%',cellsformat:'d',cellsalign:'right',align:'right'},
						{ text: 'Fuel Out',datafield: 'fuelout',width:'7%'},
						{ text: 'Branch In',datafield:'branchin',width:'10%'},
						{ text: 'Date In',datafield:'datein',width:'7%',cellsformat:'dd.MM.yyyy'},
						{ text: 'Time In',datafield:'timein',width:'6%',cellsformat:'HH:mm'},
						{ text: 'Km In',datafield:'kmin',width:'7%',cellsformat:'d',cellsalign:'right',align:'right'},
						{ text: 'Fuel Out',datafield: 'fuelin',width:'7%'},
						{ text: 'Tran Code', datafield: 'tran_code', width: '10%',hidden:true },
					
					]
    
    });
   
});

	
	
</script>
<div id="detailsGrid"></div>