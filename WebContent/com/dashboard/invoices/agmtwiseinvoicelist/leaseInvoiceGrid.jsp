
<%@page import="com.dashboard.invoices.agmtwiseinvoicelist.*"%>
<%ClsAgmtWiseInvoiceListDAO listdao=new ClsAgmtWiseInvoiceListDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String client=request.getParameter("client")==null?"":request.getParameter("client");
String type=request.getParameter("type")==null?"":request.getParameter("type");
%>
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

var invoicedata;
var id='<%=id%>';
var branch='<%=branch%>';
var type='<%=type%>';
var client='<%=client%>';
var fromdate='<%=fromdate%>';
var todate='<%=todate%>';
if(id=="1"){
	invoicedata='<%=listdao.getMasterData(branch, fromdate, todate, client, type, id)%>';
}
else
{
	invoicedata;
} 
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'account' , type: 'number' },
                  		{name : 'description' , type: 'string' },
						{name : 'agmtnocount', type: 'number'  },
						{name : 'amount', type: 'number'  },
						{name : 'rentalamt', type: 'number'  },
						{name : 'accamt', type: 'number'  },
						{name : 'insuramt', type: 'number'  },
						{name : 'cldocno',type:'number'},
						{name : 'invtrno',type:'number'},
						],
				    localdata: invoicedata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
	
	$("#leaseInvoiceGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	
    	});
	
    var cellclassname = function (row, column, value, data) {
   
          };
 
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#leaseInvoiceGrid").jqxGrid(
    {
        width: '98%',
        height: 300,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: false,
        selectionmode: 'singlerow',
        pagermode: 'default',
        columnsresize: true,
       sortable:false,
				        columns: [
				{ text: 'Sr. No.',datafield: '',columntype:'number', width: '5%',cellclassname: cellclassname, cellsrenderer: function (row, column, value) {
				    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
				}   },	
				{ text: 'Ac No', datafield: 'account', width: '10%'   ,cellclassname: cellclassname},
				{ text: 'Ac Name', datafield: 'description', width: '35%' ,cellclassname: cellclassname},
				{ text: 'No of Agmt', datafield: 'agmtnocount', width: '10%' ,cellclassname: cellclassname},
				{ text: 'Amount', datafield: 'amount', width: '10%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname},
				{ text: 'Rental Sum', datafield: 'rentalamt', width: '10%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname},
				{ text: 'Acc Sum', datafield: 'accamt', width: '10%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname},
				{ text: 'Insur Sum',datafield: 'insuramt', width: '10%',cellsalign:'right',align:'right',cellclassname: cellclassname,cellsformat:'d2'},
				{ text: 'Client docno',datafield: 'cldocno', width: '10%',cellsalign:'right',align:'right',cellclassname: cellclassname,hidden:true},
				{ text: 'Inv trno',datafield: 'invtrno', width: '10%',cellsalign:'right',align:'right',cellclassname: cellclassname,hidden:true}
					]

    });
	
$('#leaseInvoiceGrid').on('rowdoubleclick', function (event) 
    		{
				$("#overlay, #PleaseWait").show();
    		    // event arguments.
    		    var args = event.args;
    		    // row's bound index.
    		    var rowBoundIndex = event.args.rowindex;
    		    // row's data. The row's data object or null(when all rows are being selected or unselected with a single action). If you have a datafield called "firstName", to access the row's firstName, use var firstName = rowData.firstName;
    		    var rowData = event.args.row;
    		    
    		    var cldocno=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',rowBoundIndex,'cldocno');
    		    var invtrno=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',rowBoundIndex,'invtrno');
    		    $('#tempclientname').val($('#leaseInvoiceGrid').jqxGrid('getcellvalue',rowBoundIndex,'description'));
    		    $('#leaseagmtdiv').load('agmtDetailGrid.jsp?cldocno='+cldocno+'&id=1&fromdate='+fromdate+'&todate='+todate+'&branch='+branch+'&type='+type+'&invtrno='+invtrno);
    		    
    		});
   
});

</script>
<div id="leaseInvoiceGrid"></div>