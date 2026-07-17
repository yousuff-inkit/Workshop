<%@page import="com.workshop.invoicev3.*" %>
 <%ClsInvoiceV3DAO invdao=new ClsInvoiceV3DAO();
String jobcarddocno=request.getParameter("jobcarddocno")==null?"0":request.getParameter("jobcarddocno");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String docno=request.getParameter("docno")==null?"0":request.getParameter("docno");

%>
 <script type="text/javascript">
var id='<%=id%>';
$(document).ready(function () {
	 
	let jobdocno='<%=jobcarddocno%>';
	let id='<%=id%>';
	let docno='<%=docno%>';
	let invoiceurl='getInvDetailData.jsp?jobdocno='+jobdocno+'&id='+id+'&invno='+docno;
	 var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
     	if(value=="undefined" || typeof(value)=="undefined"){
     		value="0.00";
     	}
     	$('#esttotal').val(value.replace(/\,/g,""));
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Total" + ': ' + value + '</div>';
     }
         // prepare the data
         var source =
         {
             datatype: "json",
             datafields: [
             			{name : 'rowno',type:'number'},
  						{name : 'serialno', type: 'string'},
  						{name : 'description',type:'string'},
  						{name : 'type',type:'string'},
  						{name : 'qty', type: 'number'},
  						{name : 'rate', type: 'number'},
  						{name : 'discount', type: 'number'},
  						{name : 'amount', type: 'number'},
  						{name : 'vatpercent', type: 'number'},
  						{name : 'vatamount', type: 'number'},
  						{name : 'netamount', type: 'number'},
  						{name : 'estdocno', type: 'number'},
  						{name : 'addition', type: 'number'},
  						{name : 'jobdocno', type: 'number'},
  						{name : 'invno', type: 'number'},
  						{name : 'chkcomplete',type:'number'}
  						     						
              ],
              url: invoiceurl,
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
         $("#invoiceDetailNewGrid").on("bindingcomplete", function (event) {
         	if($('#mode').val()=='E'){
         		var rows=$("#invoiceDetailNewGrid").jqxGrid('getrows');
         		for(var i=0;i<rows.length;i++){
         			if(rows[i].chkcomplete=="true" || rows[i].chkcomplete=="1"){
						$("#invoiceDetailNewGrid").jqxGrid('selectrow',i);
					}
					else{
						$("#invoiceDetailNewGrid").jqxGrid('unselectrow',i);
					}	
         		}
         	}
         }); 
         var dataAdapter = new $.jqx.dataAdapter(source,
         		 {
             		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            }		
         );
	 
	 $("#invoiceDetailNewGrid").jqxGrid(
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
                selectionmode: 'checkbox',
                handlekeyboardnavigation: function (event) {
                    /* var cell1 = $('#invoiceDetailNewGrid').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'amount') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if ((key == 9)) {
                        	$("#invoiceDetailNewGrid").jqxGrid('addrow',null,{});
							return true;						
						}
                    } */
				},
                
                columns: [
							{ text: 'Sr No', datafield: 'serialno', width: '6%',editable:false },
							{ text: 'Row No', datafield: 'rowno', width: '10%',editable:false,hidden:true},
							{ text: 'Estimation No', datafield: 'estdocno', width: '10%',editable:false,hidden:true},
							{ text: 'Addition No', datafield: 'addition', width: '10%',editable:false,hidden:true},
							{ text: 'Job No', datafield: 'jobdocno', width: '10%',editable:false,hidden:true},
							{ text: 'Inv No', datafield: 'invno', width: '10%',editable:false,hidden:true},
							{ text: 'Type', datafield: 'type', width: '8%',editable:false },
							{ text: 'Description', datafield: 'description', width: '27.5%',editable:false },
							{ text: 'Qty', datafield: 'qty', width: '8%',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring,align:'right',cellsalign:'right' },
							{ text: 'Rate', datafield: 'rate', width: '8%',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring,align:'right',cellsalign:'right' },
							{ text: 'Discount', datafield: 'discount', width: '8%',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring,align:'right',cellsalign:'right' },
							{ text: 'Amount', datafield: 'amount', width: '8%',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring,align:'right',cellsalign:'right' },
							{ text: 'VAT Percent', datafield: 'vatpercent', width: '8%',cellsformat:'d0',align:'right',cellsalign:'right' },
							{ text: 'VAT Amount', datafield: 'vatamount', width: '8%',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring,align:'right',cellsalign:'right' },
							{ text: 'Net Total', datafield: 'netamount', width: '8%',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring,align:'right',cellsalign:'right' },
																					
	              ]
            });
       
			$("#invoiceDetailNewGrid").on("cellvaluechanged", function (event) {
                var rowindex=event.args.rowindex;
                var dataField = event.args.datafield;
            	if(dataField=="discount" || dataField=="vatpercent" || dataField=="qty" || dataField=="rate"){
            		var jobqty=parseFloat($('#invoiceDetailNewGrid').jqxGrid('getcellvalue',rowindex,'jobqty'));
            		var rate=parseFloat($('#invoiceDetailNewGrid').jqxGrid('getcellvalue',rowindex,'rate'));
            		var hrs=parseFloat($('#invoiceDetailNewGrid').jqxGrid('getcellvalue',rowindex,'qty'));
            		var amount=(rate*hrs);
            		amount=parseFloat(amount);
            		amount=amount.toFixed(2);
            		
            		var jobdiscount=$('#invoiceDetailNewGrid').jqxGrid('getcellvalue',rowindex,'discount');
            		jobdiscount=(jobdiscount=="" || jobdiscount==null || jobdiscount=="undefined" || typeof(jobdiscount)=="undefined"?0.0:parseFloat(jobdiscount));
            		jobdiscount=parseFloat(jobdiscount);
            		var jobvatpercent=$('#invoiceDetailNewGrid').jqxGrid('getcellvalue',rowindex,'vatpercent');
            		jobvatpercent=(jobvatpercent=="" || jobvatpercent==null || jobvatpercent=="undefined" || typeof(jobvatpercent)=="undefined"?0.0:parseFloat(jobvatpercent));
            		jobvatpercent=parseFloat(jobvatpercent);
            		var subtotal=parseFloat(amount)-parseFloat(jobdiscount);
            		subtotal=parseFloat(subtotal);
            		subtotal=subtotal.toFixed(2);
            		var vatamount=parseFloat(subtotal)*(parseFloat(jobvatpercent)/100);
            		vatamount=parseFloat(vatamount);
            		vatamount=vatamount.toFixed(2);
            		var netamount=parseFloat(subtotal)+parseFloat(vatamount);
            		netamount=parseFloat(netamount);
            		netamount=netamount.toFixed(2);
            		console.log([amount,jobdiscount,jobvatpercent,subtotal,vatamount,netamount]);
            		$('#invoiceDetailNewGrid').jqxGrid('setcellvalue',rowindex,'amount',subtotal);
            		$('#invoiceDetailNewGrid').jqxGrid('setcellvalue',rowindex,'discount',jobdiscount);
            		$('#invoiceDetailNewGrid').jqxGrid('setcellvalue',rowindex,'vatpercent',jobvatpercent);
            		$('#invoiceDetailNewGrid').jqxGrid('setcellvalue',rowindex,'vatamount',vatamount);
            		$('#invoiceDetailNewGrid').jqxGrid('setcellvalue',rowindex,'netamount',netamount);
            		
            	}
            });
        });
    </script>
    <div id="invoiceDetailNewGrid"></div>
            