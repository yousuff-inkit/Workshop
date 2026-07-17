<%@page import="com.dashboard.integration.clientfinancials.*" %>
<% ClsClientFinancialsDAO clientfinancedao=new ClsClientFinancialsDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
%>
<script type="text/javascript">
var id='<%=id%>';
var invoicedata;
var invoiceexceldata;
if(id=="1"){
	invoicedata='<%=clientfinancedao.getInvoiceData(id,fromdate,todate,branch)%>'; 
	invoiceexceldata='<%=clientfinancedao.getInvoiceExcelData(id,fromdate,todate,branch)%>';
}
$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
           
						{name : 'invvocno', type: 'string'},
						{name : 'invdate',type:'date'},
						{name : 'acrefno', type: 'string'},
						{name : 'refname',type:'string'},
						{name : 'reg_no', type: 'number'},
						{name : 'chassisno',type:'string'},
						{name : 'amount',type:'number'},
						{name : 'invdocno',type:'number'}

						],
				    localdata: invoicedata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };

    $("#invoiceGrid").on("bindingcomplete", function (event) {
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

    $("#invoiceGrid").jqxGrid(
    {
        width: '99%',
        height: 220,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'checkbox',
        pagermode: 'default',
       sortable:true,
        columns: [  
					 { text: 'Sr. No.',datafield: '',columntype:'number', width: '6%', cellsrenderer: function (row, column, value) {
					    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					 }   },	
                  	 { text: 'Invoice No', datafield: 'invvocno', width: '8%'},
                  	{ text: 'Invoice No', datafield: 'invdocno', width: '8%',hidden:true},
				     { text: 'Invoice Date', datafield:'invdate', width: '8%',cellsformat:'dd.MM.yyyy'},
				     { text: 'MK No',datafield:'acrefno',width:'12%'},
				     { text: 'Customer Name',datafield:'refname',width:'32%'},
				     { text: 'Vehicle Reg No',datafield:'reg_no',width:'10%'},
				     { text: 'Chassis No',datafield:'chassisno',width:'13%'},
				     { text: 'Amount Invoiced',datafield:'amount',width:'8%',cellsformat:'d2',cellsalign:'right',align:'right'}
					]
   
    });

    $('#invoiceGrid').on('rowdoubleclick', function (event){
    	var rowindex=event.args.rowindex;
    	
    }); 
});
    
</script>
<div id="invoiceGrid"></div>
