<%@page import="com.dashboard.accounts.finance.ClsFinance"%>
<%ClsFinance DAO= new ClsFinance(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String accDocno = request.getParameter("accdocno")==null?"0":request.getParameter("accdocno").trim();
     String dType = request.getParameter("dtype")==null?"0":request.getParameter("dtype").trim();
     String docRangeFrom = request.getParameter("docrangefrom")==null?"0":request.getParameter("docrangefrom").trim();
     String docRangeTo = request.getParameter("docrangeto")==null?"0":request.getParameter("docrangeto").trim();
     String amtRangeFrom = request.getParameter("amtrangefrom")==null?"0":request.getParameter("amtrangefrom").trim();
     String amtRangeTo = request.getParameter("amtrangeto")==null?"0":request.getParameter("amtrangeto").trim();
     String chk = request.getParameter("chk")==null?"0":request.getParameter("chk");%>

<script type="text/javascript">
        
		var data2;
		var temp='<%=branchval%>';
		var temp1='<%=dType%>';
		
		if(temp1=='UCP' || temp1=='UCR'){
			if(temp!='NA'){
				  data2='<%=DAO.finance(branchval, fromDate, toDate, accDocno, dType, docRangeFrom, docRangeTo, amtRangeFrom, amtRangeTo,chk)%>';
				  var dataExcelExport6='<%=DAO.financeExcelExport(branchval, fromDate, toDate, accDocno, dType, docRangeFrom, docRangeTo, amtRangeFrom, amtRangeTo,chk)%>';
			}
		}
	
        $(document).ready(function () { 
        	
        	var rendererstring=function (aggregates){
               	var value=aggregates['sum'];
               	if(typeof(value) == "undefined"){
               		value=0.00;
               	}
               	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + "Total : " + '' + value + '</div>';
               }
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'int'   },
     						{name : 'date', type: 'date'   },
     						{name : 'remarks', type: 'string'  },
     						{name : 'amount', type: 'number' },
     						{name : 'currency', type: 'string'   },
     						{name : 'localamount', type: 'number' },
     						{name : 'chqno', type: 'String' },
     						{name : 'dates', type: 'date'   },
                        ],
                		 localdata: data2,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxUnclearedChequeVoucher").jqxGrid(
            {
                width: '100%',
                height: 470,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
             	showaggregates: true,
             	showstatusbar:true,
             	rowsheight:25,
             	statusbarheight:25,
                editable: false,
                localization: {thousandsSeparator: ""},
                
                columns: [
							{ text: 'Doc No',  datafield: 'doc_no', width: '5%' },
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '10%' },
							{ text: 'Remarks', datafield: 'remarks', width: '40%' },
							{ text: 'Amount', datafield: 'amount', cellsformat: 'd2', width: '10%', cellsalign: 'right', align: 'right' },
							{ text: 'Currency', datafield: 'currency',  width: '5%' },
							{ text: 'Local Amount', datafield: 'localamount', cellsformat: 'd2', width: '10%', cellsalign: 'right', align: 'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: 'Cheque No', datafield: 'chqno', width: '10%' },
							{ text: 'Cheque Date', datafield: 'dates', cellsformat: 'dd-MMM-yyyy' , width: '10%' },
						]
            });
           
            if(temp=='NA'){
                $("#jqxUnclearedChequeVoucher").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
});
</script>
<div id="jqxUnclearedChequeVoucher"></div>
 