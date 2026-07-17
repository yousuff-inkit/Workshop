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
        	/*  var url = "invoice.txt"; */
             var num = 1; 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
     						{name : 'voucherno', type: 'int'  },
     						{name : 'voc_no', type: 'int'    },
     						{name : 'date',type:'date'},
     						{name :'agmttype',type:'string'},
     						{name :'refname',type:'string'}
     						
     											
                 ],               
               localdata:maindata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            $("#printGrid").on("bindingcomplete", function (event) {
            	$("#overlay, #PleaseWait").hide();
            	});
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            }		
            );

            
            
            $("#printGrid").jqxGrid(
            {
                width: '100%',
                height: 250,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
               // editable: true,
                altRows: true,
                 showfilterrow: false, 
                 filterable: true,  
                sortable: true,
                selectionmode: 'checkbox',
               // pagermode: 'default',
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                    var cell = $('#printGrid').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'date' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#printGrid").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    }
                },
                
  
                
                columns: [
                           	{ text:'Doc No',filtertype:'number',datafield:'voucherno',width:'10%'},	
                           	{ text: 'Date', columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '20%',cellsformat:'dd.MM.yyyy' },
                           	{text:'Agreement Type', columntype: 'textbox', filtertype: 'input',datafield:'agmttype',width:'15.5%'},
                           	{ text: 'RA No',filtertype:'number', datafield: 'voc_no', width: '10%' },
							{text:'Client', columntype: 'textbox', filtertype: 'input',datafield:'refname',width:'40%'}
							
							
												
	              ]
            });
       $('#printGrid').on('rowdoubleclick', function (event) {
            	var row2=event.args.rowindex;
            	
            	/* document.getElementById("docno").value=$('#invoiceSearch').jqxGrid('getcellvalue', row2, "doc_no");
            	 $('#date').jqxDateTimeInput({ disabled: false});
            	$("#date").jqxDateTimeInput('val', $("#invoiceSearch").jqxGrid('getcellvalue', row2, "date")); 
            	document.getElementById("agmtno").value=$('#invoiceSearch').jqxGrid('getcellvalue', row2, "rano");
            	 $('#cmbagmttype').val($("#invoiceSearch").jqxGrid('getcellvalue', row2, "agmttype")) ;
            	$('#frmManualInvoice select').attr('disabled', false);
        		$("#fromdate").jqxDateTimeInput({ disabled: false});
                $("#todate").jqxDateTimeInput({ disabled: false}); 
            	document.getElementById("frmManualInvoice").submit();
                $('#window').jqxWindow('close');
 */
                });
            
        });
    </script>
    <div id="printGrid"></div>
 
