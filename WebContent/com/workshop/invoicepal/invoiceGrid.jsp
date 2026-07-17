<%@page import="com.workshop.wsinvoicepal.*" %>
<%ClsWSInvoiceDAO invoicedao=new ClsWSInvoiceDAO();
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String id=request.getParameter("id")==null?"":request.getParameter("id");

%>
 <script type="text/javascript">
var id='<%=id%>';
 $(document).ready(function () {
	 
	 var invoicedata=[];
	 if(id=="1"){
		 invoicedata='<%=invoicedao.getGridData(docno,id)%>';
	 }
	 var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
     	if(value=="undefined" || typeof(value)=="undefined"){
     		value="0.00";
     	}
     	 if(value!="" && value!=null && value!="undefined"){
     		$('#total').val(value.replace(/\,/g,""));
     		$('#total').trigger('blur');
     		var total=parseFloat($('#total').val());
  		  var excess=parseFloat($('#excessamount').val());
  		  var discount=parseFloat($('#discount').val());
  		  var nettotal=(total)-discount;
  		//  $('#nettotal').val(nettotal);
  		var taxpercent=parseFloat($('#taxpercent').val());
		  var taxvalue=taxpercent/100;
		  var taxamount=nettotal*taxvalue;
		  taxamount=funCustomRound(taxamount);
		//  $('#taxamount').val(taxamount);
		  var taxtotal=parseFloat(taxamount)+parseFloat(nettotal);
		  taxtotal=funCustomRound(taxtotal);
		  taxtotal=taxtotal-parseFloat($('#roundamt').val());
		  // $('#taxtotal').val(taxtotal);
		  if($('#total').val()!="0.00"){
			  if(parseFloat($('#total').val())<parseFloat($('#esttotal').val()) && $('#esttotal').val()!=""){
	     			$.messager.alert('Warning','Cannot be less than estimated total');
	     		}  
		  }
     		
     	}
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + ': ' + value + '</div>';
     }
         // prepare the data
         var source =
         {
             datatype: "json",
             datafields: [
  						{name : 'desc1', type: 'string'},
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
	 
	 $("#invoiceGrid").jqxGrid(
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
                    var cell1 = $('#invoiceGrid').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'amount') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if ((key == 9)) {
                        	$("#invoiceGrid").jqxGrid('addrow',null,{});
							return true;						
						}
                    }
				},
                
                columns: [
							{ text: 'Sr No', sortable: false, filterable: true, editable: false,
                              groupable: false, draggable: true, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }    
							},
							{ text: 'Description', datafield: 'desc1', width: '65%' },
							{ text: 'Amount', datafield: 'amount', width: '30%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring }
																					
	              ]
            });
       

        });
 function funCustomRound(value){
		var res=parseFloat(value).toFixed(window.parent.amtdec.value);
		var res1=(res=='NaN'?"0":res);
		return res1;  
	}
 </script>
    <div id="invoiceGrid"></div>
            