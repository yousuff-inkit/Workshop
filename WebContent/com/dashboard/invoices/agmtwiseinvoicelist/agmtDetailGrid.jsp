
<%@page import="com.dashboard.invoices.agmtwiseinvoicelist.*"%>
<%ClsAgmtWiseInvoiceListDAO leasedao=new ClsAgmtWiseInvoiceListDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String invtrno=request.getParameter("invtrno")==null?"":request.getParameter("invtrno");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
String type=request.getParameter("type")==null?"":request.getParameter("type");%>

 <style>
 .greenClass
        {
            background-color: #ACF6CB;
        }
   .greyClass
        {
           background-color: #D8D8D8;
        }
 </style>
<script type="text/javascript">

var agmtdata;
var agmtdataexcel;
var id='<%=id%>';
if(id=="1"){
	agmtdata='<%=leasedao.getDetailData(cldocno, invtrno, fromdate, todate,branch, id)%>';
	agmtdataexcel='<%=leasedao.getDetailDataExcel(cldocno, invtrno, fromdate, todate,branch, id)%>';
}
else
{		
	agmtdata=[];
} 
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'outregno',type:'number'},
                  		{name : 'repdate',type:'date'},
                  		{name : 'invvocno',type:'string'},
                  		{name : 'invtrno',type:'string'},
                  		{name : 'repdocno',type:'number'},
                  		{name : 'reg_no',type:'number'},
                  		{name : 'po',type:'string'},
                  		{name : 'datediff',type:'number'},
                  		{name : 'voc_no',type:'string'},
                  		{name : 'fromdate',type:'date'},
                  		{name : 'todate',type:'date'},
                  		{name : 'rentalamt',type:'number'},
                  		{name : 'accamt',type:'number'},
                  		{name : 'insuramt',type:'number'},
                  		{name : 'amount',type:'number'}
						],
				    localdata: agmtdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
	
	$("#agmtDetailGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	$('#invvocno').val($('#agmtDetailGrid').jqxGrid('getcellvalue',0,'invvocno'));
    	$('#invtrno').val($('#agmtDetailGrid').jqxGrid('getcellvalue',0,'invtrno'));
    	});
	
    var cellclassname = function (row, column, value, data) {
        if(typeof(data.amount)=="undefined" || data.amount=="" ){
        	return ""; 
        }
        else{
        	//alert(data.amount);
        	return "greenClass";
        };
          };
 
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#agmtDetailGrid").jqxGrid(
    {
        width: '98%',
        height: 200,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: false,
        selectionmode: 'checkbox',
        pagermode: 'default',
        columnsresize: true,
       	sortable:false,
		columns: [
				{ text: 'Sr. No.',datafield: '',columntype:'number', width: '5%',cellclassname: cellclassname, 
					cellsrenderer: function (row, column, value) {
				    	return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					}
				},	
				{ text: 'Agmt No', datafield: 'voc_no', width: '8%' ,cellclassname: cellclassname},
				{ text: 'Inv No', datafield: 'invvocno', width: '8%' ,cellclassname: cellclassname},
				{ text: 'Ref No', datafield: 'po', width: '16%' ,cellclassname: cellclassname},
				{ text: 'From Date', datafield: 'fromdate', width: '8%' ,cellclassname: cellclassname,cellsformat:'dd.MM.yyyy'},
				{ text: 'To Date', datafield: 'todate', width: '8%' ,cellclassname: cellclassname,cellsformat:'dd.MM.yyyy'},
				{ text: 'No of Days', datafield: 'datediff', width: '6%' ,cellclassname: cellclassname},
				{ text: 'Reg No', datafield: 'reg_no', width: '6%' ,cellclassname: cellclassname},
				{ text: 'Rental Charges', datafield: 'rentalamt', width: '8%' ,cellclassname: cellclassname,cellsformat:'d2',align:'right',cellsalign:'right'},
				{ text: 'Acc Charges', datafield: 'accamt', width: '8%' ,cellclassname: cellclassname,cellsformat:'d2',align:'right',cellsalign:'right'},
				{ text: 'Insur Charges', datafield: 'insuramt', width: '8%' ,cellclassname: cellclassname,cellsformat:'d2',align:'right',cellsalign:'right'},
				{ text: 'Total', datafield: 'amount', width: '8%' ,cellclassname: cellclassname,cellsformat:'d2',align:'right',cellsalign:'right'}
				
				
					]

    });
	
$('#agmtDetailGrid').on('rowselect', function (event) 
    		{
    		 
    		});
    
});

</script>
<div id="agmtDetailGrid"></div>