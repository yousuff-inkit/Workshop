 <%@page import="com.dashboard.salik.ClsSalikDAO" %>
<% ClsSalikDAO csd=new ClsSalikDAO(); %>
 <%String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
 String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
 String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
 String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim();
 String rentalType = request.getParameter("rentaltype")==null?"0":request.getParameter("rentaltype").trim();
 String agmtNo = request.getParameter("agmtno")==null?"0":request.getParameter("agmtno").trim();%>
 <script type="text/javascript">
 
 var data1;
 var temp='<%=branchval%>';
 var exceldata;
 	if(temp!='NA'){ 
 		data1='<%=csd.invoicedGridLoading(branchval,fromDate, toDate, cldocno, rentalType, agmtNo)%>';
    	exceldata='<%=csd.invoicedExcelData(branchval,fromDate, toDate, cldocno, rentalType, agmtNo)%>';
 	}
    
        $(document).ready(function () { 	
              
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [


						{name : 'rano', type: 'string'    },
						{name : 'dtypedesc', type: 'string'    },
						{name : 'invno', type: 'string'    },
						{name : 'refname', type: 'string'    },

     						{name : 'regno', type: 'string'  },
     						{name : 'fleetno', type: 'string'    },
     						{name : 'location', type: 'string'    },
     						{name : 'direction', type: 'string'    },
     						{name : 'source', type: 'string'    },
     						{name : 'tagno', type: 'string'    },
     						{name : 'amount', type: 'string'    }
     						
                 ],
                 localdata: data1,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#jqxInvoiced").jqxGrid(
            {
                width: '98%',
                height: 480,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                showaggregates:true,
                selectionmode: 'singlerow',
                editable: false,
                localization: {thousandsSeparator: ""},
                
                columns: [
							

							{ text: 'RA No', datafield: 'rano', width: '8%' },
							{ text: 'Type', datafield: 'dtypedesc', width: '14%' },
							{ text: 'Inv No', datafield: 'invno', width: '8%' },
							{ text: 'Client/Employee', datafield: 'refname', width: '14%' },

							{ text: 'Reg No.', datafield: 'regno', width: '10%' },
							{ text: 'Fleet No.', datafield: 'fleetno', width: '10%' },
							{ text: 'Location', datafield: 'location', width: '15%' },
							{ text: 'Direction', datafield: 'direction', width: '15%' },
							{ text: 'Source', datafield: 'source', width: '20%' },
							{ text: 'Tag No.', datafield: 'tagno', width: '15%' },
							{ text: 'Amount', datafield: 'amount', width: '15%',cellsformat: 'd2',cellsalign: 'right', align:'right' },
														
	              ]
            });
            
            if(temp=='NA'){
                $("#jqxInvoiced").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
        });
    </script>
    <div id="jqxInvoiced"></div>
