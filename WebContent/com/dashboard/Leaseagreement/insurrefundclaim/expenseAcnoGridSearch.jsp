<%@page import="com.dashboard.leaseagreement.insurrefundclaim.*" %>
<%ClsInsurRefundDAO refunddao=new ClsInsurRefundDAO();
%>
<script type="text/javascript">
var expensedata='<%=refunddao.getExpenseAccount()%>'; 
$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
           
						{name : 'doc_no', type: 'number'},
						{name : 'description',type:'string'},
						{name : 'account',type:'number'}

						],
				    localdata: expensedata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };

    $("#expenseAcnoGridSearch").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );

    $("#expenseAcnoGridSearch").jqxGrid(
    {
        width: '98%',
        height: 330,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       sortable:true,
        columns: [  
					 { text: 'SL#', sortable: false, filterable: false, editable: false,
					    groupable: false, draggable: false, resizable: false,
					    datafield: 'sl', columntype: 'number', width: '10%',
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					    }  
					 },
                  	 { text: 'Doc No', datafield: 'doc_no', width: '8%',hidden:true},
                  	 { text: 'Description',datafield:'description',width:'60%'},
				     { text: 'Account', datafield:'account', width: '30%'}
					
					]
   
    });

    $('#expenseAcnoGridSearch').on('rowdoubleclick', function (event){
    	var rowindex=event.args.rowindex;
    	document.getElementById("expenseaccount").value=$('#expenseAcnoGridSearch').jqxGrid('getcellvalue',rowindex,'description');
    	document.getElementById("hidexpenseaccount").value=$('#expenseAcnoGridSearch').jqxGrid('getcellvalue',rowindex,'doc_no');
    	$('#expenseacnowindow').jqxWindow('close');
    }); 
});
                     
</script>
<div id="expenseAcnoGridSearch"></div>