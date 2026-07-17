<%@page import="com.limousine.limobooking.*" %>
<%ClsLimoBookingDAO bookdao=new ClsLimoBookingDAO();
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String id=request.getParameter("id")==null?"0":request.getParameter("id");

%>
<script type="text/javascript">
var id='<%=id%>';
var billdata;
if(id=="1"){
	billdata='<%=bookdao.getBillingData(docno,id)%>';
}
$(document).ready(function () { 
	
 var columnsrenderer = function (value) {
        		return '<div style="text-align: right;margin-top: 5px;">' + value + '</div>';
         };

       
        var source =
           {
           datatype: "json",
           datafields: [

                       	{name : 'billto' , type: 'string' },
                       	{name : 'billmode' , type:'string'},
                       	{name : 'billper' , type:'number'}
     				   ],
					localdata:billdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or pagse size is changed.
                }
          };

   	 var rendererstring=function (aggregates){
          	var value=aggregates['sum'];
          	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' +  value + '</div>';
          }
          var dataAdapter = new $.jqx.dataAdapter(source,
           		 {
               		loadError: function (xhr, status, error) {
	                 ///alert(error);    
	              }
			            
		        });
          var list = ['Client', 'Guest'];
          var billmodelist = new Array();
            $("#billingGrid").jqxGrid(
            {
               width: '100%',
               height: 150,
               source: dataAdapter,
               columnsresize: true,
               disabled:true,
               editable:true,
               selectionmode: 'singlecell',
               localization: {thousandsSeparator: ""},
               statusbarheight:25,
               showaggregates:true,
               showstatusbar:true,
               
                //Add row method
                 handlekeyboardnavigation: function (event) {
            // var rows = $('#jqxgridtarif').jqxGrid('getrows');
       /*      alert("here");
                  var rowlength= event.args.rowindex;
                  alert(rowlength);
                    var cell = $('#jqxgridtarif').jqxGrid('getselectedcell');
				if (cell != undefined && cell.datafield == 'disclevel3') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {
                            $('#jqxgridtarif').jqxGrid('selectcell',rowlength+1, 'rentaltype');
                   					$('#jqxgridtarif').jqxGrid('focus',rowlength+1, 'rentaltype');
                                       
                        }
				} */
                 },
            
               
                columns: [
							{ text: 'Billing To', datafield: 'billto',width:'33.33%',columntype:'dropdownlist',
								
 								createeditor: function (row, column, editor) {
 		                            editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
 								}
							},
							{ text: 'Billing Mode',  datafield: 'billmode',width:'33.33%',columntype:'dropdownlist',
								
 								createeditor: function (row, column, editor) {
 									 var billingto = $('#billingGrid').jqxGrid('getcellvalue', row, "billto");
 									
 		                            if(billingto=="Client"){
 		                            	billmodelist = ["On Account", "Cash", "Credit"];
 		                            }
 		                            else if(billingto=="Guest"){
 		                            	billmodelist = ["Cash", "Credit"];
 		                            }
 		                            
 									editor.jqxDropDownList({ autoDropDownHeight: true, source: billmodelist });
 								
 								},
 								initeditor: function (row, cellvalue, editor) {
 		                            
									var billingto = $('#billingGrid').jqxGrid('getcellvalue', row, "billto");
 									
 		                            if(billingto=="Client"){
 		                            	billmodelist = ["On Account", "Cash", "Credit"];
 		                            }
 		                            else if(billingto=="Guest"){
 		                            	billmodelist = ["Cash", "Credit"];
 		                            }
 		                            
 									editor.jqxDropDownList({ autoDropDownHeight: true, source: billmodelist });
 								
 		                        }
 								
							},
 							
							{ text: 'Billing Percentage',  datafield: 'billper',editable:true ,width:'33.33%',aggregates: ['sum'],aggregatesrenderer:rendererstring}
         	              ]
           
            });
            
            $("#billingGrid").on("celldoubleclick", function (event)
            		{
            		    // event arguments.
            		    var args = event.args;
            		    // row's bound index.
            		    var rowBoundIndex = event.args.rowindex;
            		    // row's visible index.
            		    var rowVisibleIndex = event.args.visibleindex;
            		    // right click.
            		    var rightClick = event.args.rightclick; 
            		    // original event.
            		    var ev = event.args.originalEvent;
            		    // column index.
            		    var columnIndex = event.args.columnindex;
            		    // column data field.
            		    var dataField = event.args.datafield;
            		    // cell value
            		    var value = vargs.value;
            		});
            });

	
            </script>
            <div id="billingGrid"></div>
