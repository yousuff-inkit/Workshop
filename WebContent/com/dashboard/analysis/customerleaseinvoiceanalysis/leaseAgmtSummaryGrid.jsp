<%@page import="com.dashboard.analysis.customerleaseinvoiceanalysis.*" %>
<%ClsLeaseAgmtDetailDAO agmtdao=new ClsLeaseAgmtDetailDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String status=request.getParameter("status")==null?"":request.getParameter("status");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
%>
<script type="text/javascript">
var summarydata;
var id='<%=id%>';
if(id=="1"){
	summarydata='<%=agmtdao.getSummaryData(id,fromdate,todate,status,branch)%>';
	summarydataExcel='<%=agmtdao.getExportSummaryData(id,fromdate,todate,status,branch)%>';
}
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'rano' , type: 'number' },
                  		{name : 'branchname',type:'string'},
                  		{name : 'refno',type:'string'},
						{name : 'reg_no',type:'number'},
                  		{name : 'contractdate',type:'date'},
                  		{name : 'refname',type:'string'},
                  		{name : 'chassis',type:'string'},
                  		{name : 'clstatus',type:'string'},
                  		{name : 'flname',type:'string'},
                  		{name : 'plate',type:'string'},
                  		{name : 'total',type:'number'},
                        {name : 'totalreceived',type:'number'},
                  		                		
                  		{name : 'balance',type:'number'},
                  	
                  		{name : 'totalinvoiced',type:'number'}
						],
				    localdata: summarydata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    $("#leaseAgmtSummaryGrid").on("bindingcomplete", function (event) {
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
    
    
    $("#leaseAgmtSummaryGrid").jqxGrid(
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
                  		{ text: 'Branch',datafield:'branchname',width:'10%'},
						{ text: 'RA No', datafield: 'rano', width: '7%'},
						{ text: 'Ref No',datafield:'refno',width:'6%'},
						{ text: 'Contract Date', datafield: 'contractdate', width: '6%',cellsformat:'dd.MM.yyyy'},
						{ text: 'Client', datafield: 'refname', width: '20%'},
						{ text: 'Status', datafield: 'clstatus', width: '5%'},
						{ text: 'Fleet',datafield:'flname',width:'12%'},
						{ text: 'Reg No',datafield:'reg_no',width:'6%'},
						{ text: 'Plate',datafield:'plate',width:'6%'},
						{ text: 'Chassis',datafield:'chassis',width:'10%'},
						{ text: 'Total', datafield: 'total', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right'},
						
                        { text: 'TotalInvoice',datafield:'totalinvoiced',width:'8%'},
						{ text: 'Total Recieved',datafield:'totalreceived',width:'8%'},
						{ text: 'Balance', datafield: 'balance', width: '8%',cellsformat:'d2',cellsalign:'right',align:'right'}
					]

    });

});

	
	
</script>
<div id="leaseAgmtSummaryGrid"></div>