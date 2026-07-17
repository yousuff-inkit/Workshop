<%@page import="com.workshop.wsinvoicepal.*" %>
<%ClsWSInvoiceDAO invoicedao=new ClsWSInvoiceDAO();
String jobcarddocno=request.getParameter("jobcarddocno")==null?"":request.getParameter("jobcarddocno");
String id=request.getParameter("id")==null?"":request.getParameter("id");
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");

%>
 <script type="text/javascript">
var id='<%=id%>';
 $(document).ready(function () {
	 
	 var invoicedata=[];
	 if(id=="1"){
		 invoicedata='<%=invoicedao.getDetailGridData(jobcarddocno,id,docno)%>';
	 }
	 var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
     	if(value=="undefined" || typeof(value)=="undefined"){
     		value="0.00";
     	}
     	$('#esttotal').val(value.replace(/\,/g,""));
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + ': ' + value + '</div>';
     }
         // prepare the data
         var source =
         {
             datatype: "json",
             datafields: [
  						{name : 'serialno', type: 'string'},
  						{name : 'description',type:'string'},
  						{name : 'amount', type: 'number'}
  						     						
              ],
              localdata: invoicedata,
              deleterow: function (rowid, commit) {
                  // synchronize with the server - send delete command
                  // call commit with parameter true if the synchronization with the server is successful 
                  // and with parameter false if the synchronization failed.
                  commit(true);
              },
             
             pager: function (pagenum, pagesize, oldpagenum) {
                 // callback called when a page or page size is changed.
             }
                                     
         };
         
         var dataAdapter = new $.jqx.dataAdapter(source,
         		 {
             		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            }		
         );
	 
	 $("#invoiceDetailGrid").jqxGrid(
            {
            	width: '100%',
                height: 200,
                pageable: false,
                source: dataAdapter,
                editable: true, 
                autoheight: false,
                showaggregates:true,
                showstatusbar:true,
                sortable: 'true',
                selectionmode: 'singlecell',
                handlekeyboardnavigation: function (event) {
                    /* var cell1 = $('#invoiceDetailGrid').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'amount') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if ((key == 9)) {
                        	$("#invoiceDetailGrid").jqxGrid('addrow',null,{});
							return true;						
						}
                    } */
				},
                
                columns: [
							{ text: 'Sr No', datafield: 'serialno', width: '10%',editable:false },
							{ text: 'Description', datafield: 'description', width: '60%' },
							{ text: 'Amount', datafield: 'amount', width: '30%',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring,align:'right',cellsalign:'right' }
																					
	              ]
            });
       

        });
    </script>
    <div id="invoiceDetailGrid"></div>
            