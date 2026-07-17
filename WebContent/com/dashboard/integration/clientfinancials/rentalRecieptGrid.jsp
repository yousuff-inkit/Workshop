<%@page import="com.dashboard.integration.clientfinancials.*" %>
<% ClsClientFinancialsDAO clientfinancedao=new ClsClientFinancialsDAO(); 
String id=request.getParameter("id")==null?"":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
%>
<script type="text/javascript">
var id='<%=id%>';
var rentalrecieptdata;
var rentalrecieptexceldata;
if(id=="1"){
	rentalrecieptdata='<%=clientfinancedao.getRentalRecieptData(id,fromdate,todate,branch)%>'; 
	rentalrecieptexceldata='<%=clientfinancedao.getRentalRecieptExcelData(id,fromdate,todate,branch)%>';
}
$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
           
						{name : 'recieptno', type: 'string'},
						{name : 'recieptdate',type:'date'},
						{name : 'acrefno', type: 'string'},
						{name : 'refname',type:'string'},
						{name : 'reg_no', type: 'number'},
						{name : 'chassisno',type:'string'},
						{name : 'amount',type:'number'},
						{name : 'paymenttype',type:'number'}

						],
				    localdata: rentalrecieptdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };

    $("#rentalRecieptGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
//    	$('#rentalrentalRecieptGrid').jqxGrid({ sortable: true});
   });
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );

    $("#rentalRecieptGrid").jqxGrid(
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
                  	 { text: 'Reciept No', datafield: 'recieptno', width: '8%'},
				     { text: 'Reciept Date', datafield:'recieptdate', width: '8%',cellsformat:'dd.MM.yyyy'},
				     { text: 'MK No',datafield:'acrefno',width:'12%'},
				     { text: 'Customer Name',datafield:'refname',width:'29%'},
				     { text: 'Vehicle Reg No',datafield:'reg_no',width:'8%'},
				     { text: 'Chassis No',datafield:'chassisno',width:'10%'},
				     { text: 'Amount Collected',datafield:'amount',width:'8%',cellsformat:'d2',cellsalign:'right',align:'right'},
				     { text: 'Payment Type',datafield:'paymenttype',width:'8%'}
					]
   
    });

    $('#rentalRecieptGrid').on('rowdoubleclick', function (event){
    	var rowindex=event.args.rowindex;
    	
    }); 
});
    
</script>
<div id="rentalRecieptGrid"></div>
