<%@page import="com.dashboard.leaseagreement.insurrefundclaim.*" %>
<%ClsInsurRefundDAO refunddao=new ClsInsurRefundDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
%>
<script type="text/javascript">
var refunddata;
var id='<%=id%>';
if(id=="1"){
	refunddata='<%=refunddao.getInsurRefundData(fromdate,todate,id)%>';
}
$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
           
						{name : 'doc_no', type: 'number'},
						{name : 'dtype',type:'number'},
						{name : 'tranid',type:'number'},
						{name : 'tr_no', type: 'string'},
						{name : 'description', type: 'string'},
						{name : 'refno',type:'string'},
						{name : 'insurrefundaccount', type: 'string'},
						{name : 'insurrefundacno',type:'number'},
						{name : 'amount',type:'number'}
						],
				    localdata: refunddata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };

    $("#insurRefundGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    });
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );

    $("#insurRefundGrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       	sortable:false,
        columns: [  
					 { text: 'SL#', sortable: false, filterable: false, editable: false,
					    groupable: false, draggable: false, resizable: false,
					    datafield: 'sl', columntype: 'number', width: '5%',
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					    }  
					 },
                  	 { text: 'Doc No', datafield: 'doc_no', width: '10%'},
                  	 { text: 'Dtype',datafield:'dtype',width:'10%'},
				     { text: 'Tranid', datafield:'tranid', width: '10%',hidden:true},
				     { text: 'Trno', datafield:'tr_no', width: '10%',hidden:true},
				     { text: 'Description',datafield: 'description', width: '25%'},
				     { text: 'Account',datafield:'insurrefundaccount',width:'30%'},
				     { text: 'Acno',datafield: 'insurrefundacno', width: '10%'},
				     { text: 'Amount',datafield: 'amount', width: '10%',cellsalign:'right',align:'right',cellsformat:'d2'}
					 
					
					]
   
    });

    $('#insurRefundGrid').on('rowdoubleclick', function (event){
    	var rowindex=event.args.rowindex;
    	document.getElementById("amount").value=$('#insurRefundGrid').jqxGrid('getcellvalue',rowindex,'amount');
    	document.getElementById("tempamount").value=$('#insurRefundGrid').jqxGrid('getcellvalue',rowindex,'amount');
    	document.getElementById("tranid").value=$('#insurRefundGrid').jqxGrid('getcellvalue',rowindex,'tranid');
    	setExpenseAmount();
    }); 
});
                     
  
</script>
<div id="insurRefundGrid"></div>