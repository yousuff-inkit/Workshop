<%@page import="com.dashboard.workshop.nipurchasecreate.ClsNiPurchaseCreateDAO"%>
<%
ClsNiPurchaseCreateDAO DAO=new ClsNiPurchaseCreateDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
%>

<script type="text/javascript">
 
var id='<%=id%>';
var detaildata;
var poexportdata;


if(id=='1'){
	detaildata='<%=DAO.getDetailData(docno,id)%>';

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
						{name : 'description', type: 'string'},
						{name : 'qty', type: 'number'},
						{name : 'unitprice', type: 'number'},
						{name : 'total', type: 'number'},
						{name : 'discount', type: 'number'},
						{name : 'netamt', type: 'number'},
						{name : 'nettotal', type: 'number' },
						{name : 'nuprice', type: 'number'},
						{name : 'srno', type: 'int'},
						{name : 'taxper', type: 'number'  },  
					 	{name : 'taxamount', type: 'number'  },
						{name : 'taxperamt', type: 'number'  },
                  		],
				    localdata: detaildata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#detailGridID").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#detailGridID").jqxGrid(
    {
        width: '98%',
        height: 260,
        columnsheight:23,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
       sortable:false,
        columns: [
               
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },
				
							{ text: 'Description', datafield: 'description', width: '36%', },
							{ text: 'Quantity', datafield: 'qty', width: '5%' ,cellsalign: 'left', align:'left'},
							{ text: 'Unit Price', datafield: 'unitprice', width: '8%' ,cellsalign: 'right', align:'right', align:'right',cellsformat:'d2'},
							{ text: 'Total', datafield: 'total', width: '8%' ,editable: false,cellsalign: 'right', align:'right',cellsformat:'d2'},
		    				{ text: 'Discount', datafield: 'discount', width: '8%',cellsalign: 'right', align:'right',cellsformat:'d2' },
							{ text: 'Net Amount', datafield: 'nettotal', width: '10%',cellsformat:'d2',cellsalign: 'right', align:'right'},
							{ text: 'Tax %', datafield: 'taxper', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Tax Amount', datafield: 'taxperamt', width: '8%', cellsformat: 'd2'  , cellsalign: 'right', align: 'right'},
							{ text: 'Net Total', datafield: 'taxamount', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right'},
							{ text: 'nuprice', datafield: 'nuprice', width: '9%',cellsformat:'d2',hidden:true},
							{ text: 'srno', datafield: 'srno', width: '9%',hidden:true}
					]
    });
    $('#detailGridID').on('rowdoubleclick', function (event) 
      		{ 
  	 	 var rowindex1=event.args.rowindex;
      		});	 
     
  
    });

	
	
</script>
<div id="detailGridID"></div>