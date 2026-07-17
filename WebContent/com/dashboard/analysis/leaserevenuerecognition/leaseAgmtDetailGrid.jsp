<%@page import="com.dashboard.analysis.leaserevenuerecognition.*"%>
<%
ClsLeaseRevenueRecognitionDAO agmtdao=new ClsLeaseRevenueRecognitionDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String agmtno=request.getParameter("agmtno")==null?"":request.getParameter("agmtno");
%>
<script type="text/javascript">
var detaildata;
var id='<%=id%>';
if(id=="1"){
	detaildata='<%=agmtdao.getDetailData(id,agmtno)%>';
	exceldata='<%=agmtdao.getDetailExcelData(id,agmtno)%>';
}
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'fromdate',type:'date'},
                  		{name : 'todate',type:'date'},
                  		{name : 'amount',type:'number'},
                  		{name : 'rentalamt',type:'number'},
                  		{name : 'accamt',type:'number'},
                  		{name : 'insuramt',type:'number'},
                  		{name : 'chaufamt',type:'number'}
						],
				    localdata: detaildata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    $("#leaseAgmtDetailGrid").on("bindingcomplete", function (event) {
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
    
    
    $("#leaseAgmtDetailGrid").jqxGrid(
    {
        width: '98%',
        height: 510,
        source: dataAdapter,
        showaggregates:true,
        columnsresize:true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       sortable:false,
        columns: [
              	
						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '10%', cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },
						{ text: 'From Date', datafield: 'fromdate', width: '20%',cellsformat:'dd.MM.yyyy'},
						{ text: 'To Date', datafield: 'todate', width: '20%',cellsformat:'dd.MM.yyyy'},
						{ text: 'Amount',datafield:'amount',width:'10%',cellsalign:'right',align:'right',cellsformat:'d2'},
						{ text: 'Rental Amount',datafield:'rentalamt',width:'10%',cellsalign:'right',align:'right',cellsformat:'d2'},
						{ text: 'Acc Amount',datafield:'accamt',width:'10%',cellsalign:'right',align:'right',cellsformat:'d2'},
						{ text: 'Insur Amount',datafield:'insuramt',width:'10%',cellsalign:'right',align:'right',cellsformat:'d2'},
						{ text: 'Chauffer Amount',datafield:'chaufamt',width:'10%',cellsalign:'right',align:'right',cellsformat:'d2'}
					]

    });

});

	
	
</script>
<div id="leaseAgmtDetailGrid"></div>