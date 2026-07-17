<%@page import="com.dashboard.analysis.leaseagmtdetail.*" %>
<%ClsLeaseAgmtDetailDAO agmtdao=new ClsLeaseAgmtDetailDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
%>
<script type="text/javascript">
var summarydata;
var summaryexceldata;
var id='<%=id%>';
if(id=="1"){
	summarydata='<%=agmtdao.getSummaryData(id,fromdate,todate,branch)%>';
	summaryexceldata='<%=agmtdao.getSummaryExcelData(id,fromdate,todate,branch)%>';
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
						{name : 'fleet_no',type:'string'},
                  		{name : 'flname',type:'string'},
                  		{name : 'plate',type:'string'},
                  		{name : 'total',type:'number'},
                  		{name : 'totalinvoiced',type:'number'},
                        {name : 'totalreceived',type:'number'},
                  		{name : 'totaltobereceived',type:'number'},
                  		{name : 'advance',type:'number'},
                  		{name : 'balance',type:'number'},
                  		{name : 'chequecount',type:'int'},
                  		{name : 'postamount',type:'number'},
                  		{name : 'postbalance',type:'number'},
                  		{name : 'fleet_no',type:'number'}
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
						{ text: 'LA No', datafield: 'rano', width: '7%'},
						{ text: 'Ref No',datafield:'refno',width:'6%'},
						{ text: 'Contract Date', datafield: 'contractdate', width: '6%',cellsformat:'dd.MM.yyyy'},
						{ text: 'Client', datafield: 'refname', width: '20%'},
						{ text: 'Fleet No.',datafield:'fleet_no',width:'8%'},
						{ text: 'Fleet',datafield:'flname',width:'12%'},
						{ text: 'Reg No',datafield:'reg_no',width:'6%'},
						{ text: 'Plate',datafield:'plate',width:'6%'},
						{ text: 'Total', datafield: 'total', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right'},
						{ text: 'Advance', datafield: 'advance', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right'},
						{ text: 'Balance', datafield: 'balance', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right'},
						{ text: 'No of Cheques', datafield: 'chequecount', width: '7%',cellsformat:'d',cellsalign:'right',align:'right'},
						{ text: 'BPV Posted', datafield: 'postamount', width: '10%',cellsformat:'d2',cellsalign:'right',align:'right'},
						{ text: 'BPV To Be Posted', datafield: 'postbalance', width: '10%',cellsformat:'d2',cellsalign:'right',align:'right'},
						{ text: 'Total Invoiced',datafield:'totalinvoiced',width:'10%',cellsformat:'d2',cellsalign:'right',align:'right'},
						{ text: 'Total Recieved',datafield:'totalreceived',width:'10%',cellsformat:'d2',cellsalign:'right',align:'right'},
						{ text: 'Total Amt To Be Collected',datafield:'totaltobereceived',width:'12%',cellsformat:'d2',cellsalign:'right',align:'right'}
						
					]

    });

});

	
	
</script>
<div id="leaseAgmtSummaryGrid"></div>