<%@page import="com.operations.agreement.rentalagreement.ClsRentalAgreementDAO"%>
<%
   	String docnovalsnot = request.getParameter("docnovals")==null?"0":request.getParameter("docnovals").trim();


ClsRentalAgreementDAO agmtdao=new ClsRentalAgreementDAO();


   	%>
 
<script type="text/javascript">
        
        $(document).ready(function () { 	
        	  var trafficinvodata = '<%=agmtdao.trafficNotinvoSearch(docnovalsnot)%>';
            
            
             var num = 0; 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                          	
     						{name : 'regno', type: 'string'  },
     						{name : 'fleetno', type: 'string'    },
     						{name : 'source', type: 'string'    },
     						{name : 'ticket_no', type: 'string'    },
     						{name : 'traffic_date', type: 'date'    },
     						{name : 'time', type: 'string'    },
     						{name : 'amount', type: 'string'    }
     						
                 ],
                 localdata: trafficinvodata,
                
                
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

            
            
            $("#jqxFinesNotInvoiced").jqxGrid(
            {
                width: '95%',
                height: 150,
                source: dataAdapter,
                columnsresize: true,
               
                altRows: true,

                sortable: true,
                selectionmode: 'singlerow',
            
                
                //Add row method
               /*  handlekeyboardnavigation: function (event) {
                    var cell = $('#jqxFinesNotInvoiced').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'NAME' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#jqxFinesNotInvoiced").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    }
                }, */
                
                //Filter
                /* ready: function () {
                    addfilter();
                }, */
                
                
                columns: [
							
							{ text: 'Reg No.', datafield: 'regno', width: '12%' },
							{ text: 'Fleet No.', datafield: 'fleetno', width: '12%' },
							{ text: 'Fine Source', datafield: 'source', width: '26%' },
							{ text: 'Ticket No.', datafield: 'ticket_no', width: '15%' },
							{ text: 'Date', datafield: 'traffic_date', width: '12%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Time', datafield: 'time', width: '8%' },
							{ text: 'Amount', datafield: 'amount', width: '15%',cellsformat:'d2' },
														
	              ]
            });
        });
    </script>
    <div id="jqxFinesNotInvoiced"></div>
