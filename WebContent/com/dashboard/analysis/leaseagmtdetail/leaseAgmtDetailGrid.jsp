<%@page import="com.dashboard.analysis.leaseagmtdetail.*" %>
<%ClsLeaseAgmtDetailDAO agmtdao=new ClsLeaseAgmtDetailDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String agmtno=request.getParameter("agmtno")==null?"":request.getParameter("agmtno");
%>
<script type="text/javascript">
var detaildata;
var detailexceldata;
var id='<%=id%>';
if(id=="1"){
	detaildata='<%=agmtdao.getDetailData(id,agmtno)%>';
	detailexceldata='<%=agmtdao.getDetailExcelData(id,agmtno)%>';
}
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'chequedate',type:'date'},
                  		{name : 'chequeno',type:'string'},
                  		{name : 'amount',type:'number'},
                  		{name : 'bpvno',type:'number'},
                  		{name : 'postamount',type:'number'},
                  		{name : 'postbalance',type:'number'}
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
						{ text: 'Cheque Date', datafield: 'chequedate', width: '15%',cellsformat:'dd.MM.yyyy'},
						{ text: 'Cheque No', datafield: 'chequeno', width: '15%'},
						{ text: 'Amount',datafield:'amount',width:'15%',cellsalign:'right',align:'right',cellsformat:'d2'},
						{ text: 'Reciept No',datafield:'bpvno',width:'15%'},
						{ text: 'Posted Amount',datafield:'postamount',width:'15%',cellsalign:'right',align:'right',cellsformat:'d2'},
						{ text: 'Balance',datafield:'postbalance',width:'15%',cellsalign:'right',align:'right',cellsformat:'d2'}
					]

    });

});

	
	
</script>
<div id="leaseAgmtDetailGrid"></div>