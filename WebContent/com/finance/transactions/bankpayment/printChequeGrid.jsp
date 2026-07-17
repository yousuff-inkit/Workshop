<%@page import="com.operations.commtransactions.invoice.*"%>
<%
	ClsManualInvoiceDAO1 manualdao=new ClsManualInvoiceDAO1();
%>
<%String mode=request.getParameter("mode")==null?"0":request.getParameter("mode");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String agmtno=request.getParameter("agmtno")==null?"":request.getParameter("agmtno");
String agmttype=request.getParameter("agmttype")==null?"":request.getParameter("agmttype");
String client=request.getParameter("client")==null?"":request.getParameter("client");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromno=request.getParameter("fromno")==null?"":request.getParameter("fromno");
String tono=request.getParameter("tono")==null?"":request.getParameter("tono");
%>
 <script type="text/javascript">
		 var mode='<%=mode%>';
		 var maindata;
		 
		 if(mode=="1"){
			maindata= '<%=manualdao.printInvoiceSearch(mode,fromdate,todate,agmtno,agmttype,client,branch,fromno,tono)%>';  
		 }
		 else{
			 
		 }
		 
        $(document).ready(function () { 	

            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
								{ name: 'chqno', type: 'String' },
								{ name: 'chqdt', type: 'date' },
								{ name: 'opsacno', type: 'int' },
								{ name: 'account', type: 'int' },
								{ name: 'description', type: 'String' },
								{ name: 'tr_no', type: 'int' },					
                 			],               
               localdata:maindata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            $("#printChequeGrid").on("bindingcomplete", function (event) {
            	$("#overlay, #PleaseWait").hide();
            	});

            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#printChequeGrid").jqxGrid(
            {
                width: '100%',
                height: 250,
                source: dataAdapter,
                columnsresize: true,
                showfilterrow: false, 
                filterable: true,  
                sortable: true,
                selectionmode: 'checkbox',
                
                columns: [
							{ text: 'Cheque No', datafield: 'chqno', width: '20%' },
							{ text: 'Cheque Date', datafield: 'chqdt', cellsformat: 'dd.MM.yyyy' ,width: '10%' },
							{ text: 'A/C No.', datafield: 'opsacno', hidden: true, width: '10%' },
							{ text: 'A/C No.', datafield: 'account', width: '10%' },
							{ text: 'Account Name', datafield: 'description', width: '60%' },
							{ text: 'Tr No', datafield: 'tr_no', hidden: true, width: '10%' },
	              ]
            });
            
});

</script>
<div id="printChequeGrid"></div>
 
