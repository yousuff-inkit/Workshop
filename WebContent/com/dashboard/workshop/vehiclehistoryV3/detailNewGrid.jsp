<%@page import="com.dashboard.workshop.vehiclehistoryv3.*" %>
 <%ClsVehicleHistoryV3DAO dao=new ClsVehicleHistoryV3DAO();
 String regno=request.getParameter("regno")==null?"":request.getParameter("regno");
 String pltid=request.getParameter("pltid")==null?"":request.getParameter("pltid");
 String id=request.getParameter("id")==null?"":request.getParameter("id");
 String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
 String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
%>
 <script type="text/javascript">
var id='<%=id%>';
$(document).ready(function () {
	 
	var invoicedata=[];
	if(id=="1"){
		invoicedata='<%=dao.getDetailNewGridData(regno,pltid,fromdate,todate,id)%>';
	}
	
	 var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
     	if(value=="undefined" || typeof(value)=="undefined"){
     		value="0.00";
     	}
     	//$('#esttotal').val(value.replace(/\,/g,""));
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
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
	 
	 $("#invoiceDetailNewGrid").jqxGrid(
            {
            	width: '100%',
                height: 500,
                pageable: false,
                source: dataAdapter,
                editable: false, 
                autoheight: false,
                showaggregates:true,
                showstatusbar:true,
                sortable: 'true',
                selectionmode: 'singlerow',
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
							{ text: 'Type', datafield: 'type', width: '10%',editable:false },
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
       		$("#overlay, #PleaseWait").hide();
        });
    </script>
    <div id="invoiceDetailNewGrid"></div>
            